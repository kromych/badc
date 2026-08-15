//! Call-frame information from assembler `.cfi_*` directives, built into
//! CIE/FDE records that reach the object writer as ordinary [`AsmSection`]s.
//!
//! `.eh_frame` is the runtime table: `SHF_ALLOC`, `zR` augmentation with a
//! PC-relative FDE pointer, read through `PT_GNU_EH_FRAME`. `.debug_frame`
//! is the offline one: not allocated, absolute FDE addresses, `cie_id`
//! all-ones. `.cfi_sections` selects; the default is `.eh_frame`.

use alloc::string::String;
use alloc::vec::Vec;

use super::emit_common::{AsmRelocKind, AsmSection, AsmSectionReloc, AsmSectionTarget};
use crate::c5::codegen::map_syms::MapMarks;

// Call-frame instruction opcodes. The low-opcode forms pack an operand into
// the top two bits; `DW_CFA_ADVANCE_LOC_HI`, `DW_CFA_OFFSET_HI` and
// `DW_CFA_RESTORE_HI` are those prefixes.
pub(crate) const DW_CFA_NOP: u8 = 0x00;
pub(crate) const DW_CFA_ADVANCE_LOC_HI: u8 = 0x40;
pub(crate) const DW_CFA_OFFSET_HI: u8 = 0x80;
pub(crate) const DW_CFA_RESTORE_HI: u8 = 0xc0;
pub(crate) const DW_CFA_ADVANCE_LOC1: u8 = 0x02;
pub(crate) const DW_CFA_ADVANCE_LOC2: u8 = 0x03;
pub(crate) const DW_CFA_ADVANCE_LOC4: u8 = 0x04;
pub(crate) const DW_CFA_OFFSET_EXTENDED: u8 = 0x05;
pub(crate) const DW_CFA_RESTORE_EXTENDED: u8 = 0x06;
pub(crate) const DW_CFA_UNDEFINED: u8 = 0x07;
pub(crate) const DW_CFA_SAME_VALUE: u8 = 0x08;
pub(crate) const DW_CFA_REGISTER: u8 = 0x09;
pub(crate) const DW_CFA_REMEMBER_STATE: u8 = 0x0a;
pub(crate) const DW_CFA_RESTORE_STATE: u8 = 0x0b;
pub(crate) const DW_CFA_DEF_CFA: u8 = 0x0c;
pub(crate) const DW_CFA_DEF_CFA_REGISTER: u8 = 0x0d;
pub(crate) const DW_CFA_DEF_CFA_OFFSET: u8 = 0x0e;
pub(crate) const DW_CFA_OFFSET_EXTENDED_SF: u8 = 0x11;
pub(crate) const DW_CFA_DEF_CFA_OFFSET_SF: u8 = 0x13;
pub(crate) const DW_CFA_VAL_OFFSET: u8 = 0x14;
pub(crate) const DW_CFA_VAL_OFFSET_SF: u8 = 0x15;
/// `DW_CFA_GNU_window_save`, and on AArch64 `DW_CFA_AARCH64_negate_ra_state`.
pub(crate) const DW_CFA_NEGATE_RA_STATE: u8 = 0x2d;

/// `DW_EH_PE_pcrel | DW_EH_PE_sdata4`: the FDE pointer encoding the `zR`
/// augmentation advertises. A 4-byte PC-relative displacement keeps the
/// section free of load-time relocations in a shared object.
const DW_EH_PE_PCREL_SDATA4: u8 = 0x1b;

/// Which of the two tables a unit's CFI lands in. `.cfi_sections` sets it;
/// with no directive the unit emits `.eh_frame` alone, as GNU as does.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct CfiSections {
    pub eh_frame: bool,
    pub debug_frame: bool,
}

impl Default for CfiSections {
    fn default() -> Self {
        CfiSections {
            eh_frame: true,
            debug_frame: false,
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum CfiArch {
    X86,
    X86_64,
    Aarch64,
}

/// Address width and architecture of the unit the frames describe.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct CfiTarget {
    pub arch: CfiArch,
    pub addr_bytes: u8,
}

impl CfiTarget {
    /// Factor every code offset by this before encoding an advance.
    fn code_align(self) -> u64 {
        match self.arch {
            CfiArch::Aarch64 => 4,
            _ => 1,
        }
    }

    /// Factor every saved-register offset by this. Negative, so a register
    /// stored below the CFA takes a positive factored operand.
    fn data_align(self) -> i64 {
        match self.arch {
            CfiArch::X86 => -4,
            _ => -8,
        }
    }

    fn return_column(self) -> u64 {
        match self.arch {
            CfiArch::X86 => 8,
            CfiArch::X86_64 => 16,
            CfiArch::Aarch64 => 30,
        }
    }

    /// Initial rules `.cfi_startproc` installs without `simple`: the ABI's
    /// state at a function's entry instruction.
    fn default_rules(self) -> Vec<CfiOp> {
        match self.arch {
            CfiArch::X86 => alloc::vec![
                CfiOp::DefCfa {
                    reg: CfiReg::Num(4),
                    off: 4,
                },
                CfiOp::Offset {
                    reg: CfiReg::Num(8),
                    off: -4,
                },
            ],
            CfiArch::X86_64 => alloc::vec![
                CfiOp::DefCfa {
                    reg: CfiReg::Num(7),
                    off: 8,
                },
                CfiOp::Offset {
                    reg: CfiReg::Num(16),
                    off: -8,
                },
            ],
            // The AArch64 PCS puts the incoming CFA at `sp`, with the return
            // address live in x30 rather than memory.
            CfiArch::Aarch64 => alloc::vec![CfiOp::DefCfa {
                reg: CfiReg::Num(31),
                off: 0,
            }],
        }
    }
}

/// A register operand. Names resolve against the arch's table at encode
/// time, where the address width that picks between the 32- and 64-bit x86
/// numbering is known.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum CfiReg {
    Num(u64),
    Name(String),
}

impl CfiReg {
    fn resolve(&self, t: CfiTarget) -> Result<u64, String> {
        match self {
            CfiReg::Num(n) => Ok(*n),
            CfiReg::Name(n) => reg_number(n, t).ok_or_else(|| {
                alloc::format!("`.cfi_*` names register `{n}`, unknown to the target")
            }),
        }
    }
}

/// x86-64 psABI DWARF register numbers, in numbering order.
const X86_64_REGS: &[&str] = &[
    "rax", "rdx", "rcx", "rbx", "rsi", "rdi", "rbp", "rsp", "r8", "r9", "r10", "r11", "r12", "r13",
    "r14", "r15", "rip",
];

const X86_REGS: &[&str] = &[
    "eax", "ecx", "edx", "ebx", "esp", "ebp", "esi", "edi", "eip", "eflags",
];

/// i386 segment registers, numbered from 40.
const X86_SEG_REGS: &[&str] = &["es", "cs", "ss", "ds", "fs", "gs"];

fn reg_number(name: &str, t: CfiTarget) -> Option<u64> {
    let n = name.strip_prefix('%').unwrap_or(name);
    if let Some(rest) = n.strip_prefix('r').filter(|_| t.arch == CfiArch::Aarch64) {
        return rest.parse::<u64>().ok().filter(|&v| v < 32);
    }
    match t.arch {
        CfiArch::Aarch64 => match n {
            "sp" => Some(31),
            "lr" => Some(30),
            _ => n
                .strip_prefix('x')
                .and_then(|d| d.parse::<u64>().ok())
                .filter(|&v| v < 31)
                .or_else(|| {
                    n.strip_prefix('v')
                        .and_then(|d| d.parse::<u64>().ok())
                        .filter(|&v| v < 32)
                        .map(|v| v + 64)
                }),
        },
        CfiArch::X86_64 => X86_64_REGS.iter().position(|r| *r == n).map(|i| i as u64),
        CfiArch::X86 => X86_REGS
            .iter()
            .position(|r| *r == n)
            .map(|i| i as u64)
            .or_else(|| {
                X86_SEG_REGS
                    .iter()
                    .position(|r| *r == n)
                    .map(|i| i as u64 + 40)
            }),
    }
}

/// One `.cfi_*` directive, with operands parsed but registers unresolved.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum CfiOp {
    StartProc { simple: bool },
    EndProc,
    Sections(CfiSections),
    SignalFrame,
    ReturnColumn(CfiReg),
    DefCfa { reg: CfiReg, off: i64 },
    DefCfaRegister(CfiReg),
    DefCfaOffset(i64),
    AdjustCfaOffset(i64),
    Offset { reg: CfiReg, off: i64 },
    RelOffset { reg: CfiReg, off: i64 },
    ValOffset { reg: CfiReg, off: i64 },
    NegateRaState,
    Register { reg: CfiReg, from: CfiReg },
    Restore(CfiReg),
    Undefined(CfiReg),
    SameValue(CfiReg),
    RememberState,
    RestoreState,
    Escape(Vec<u8>),
}

/// A directive at the point the assembler reached it: the section it was
/// written in and the byte offset the location counter held there.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct CfiRecord {
    /// Section identity key, as [`super::emit_common::section_key_of`] spells it.
    pub key: String,
    pub offset: u32,
    pub op: CfiOp,
}

/// Parse a `.cfi_*` directive's operands. Numeric operands are absolute
/// expressions (`\sc - 4` after macro expansion), so `eval` supplies the
/// assembler's own constant folding. Returns `None` for a directive that
/// carries no frame state, which deposits nothing.
pub(crate) fn parse_cfi_directive(
    tok: &str,
    rest: &str,
    eval: &dyn Fn(&str) -> Option<i64>,
) -> Result<Option<CfiOp>, String> {
    let rest = rest.trim();
    let args: Vec<&str> = if rest.is_empty() {
        Vec::new()
    } else {
        rest.split(',').map(|a| a.trim()).collect()
    };
    let reg = |i: usize| -> Result<CfiReg, String> {
        let a = args
            .get(i)
            .ok_or_else(|| alloc::format!("`{tok}` needs a register operand"))?;
        Ok(parse_reg(a))
    };
    let num = |i: usize| -> Result<i64, String> {
        let a = args
            .get(i)
            .ok_or_else(|| alloc::format!("`{tok}` needs a numeric operand"))?;
        eval(a).ok_or_else(|| alloc::format!("`{tok}` operand `{a}` is not a constant"))
    };
    let op = match tok {
        ".cfi_startproc" => CfiOp::StartProc {
            simple: rest == "simple",
        },
        ".cfi_endproc" => CfiOp::EndProc,
        ".cfi_sections" => {
            let mut s = CfiSections {
                eh_frame: false,
                debug_frame: false,
            };
            for a in &args {
                match *a {
                    ".eh_frame" => s.eh_frame = true,
                    ".debug_frame" => s.debug_frame = true,
                    other => {
                        return Err(alloc::format!(
                            "`.cfi_sections` names `{other}`, which is no frame section"
                        ));
                    }
                }
            }
            CfiOp::Sections(s)
        }
        ".cfi_signal_frame" => CfiOp::SignalFrame,
        ".cfi_return_column" => CfiOp::ReturnColumn(reg(0)?),
        ".cfi_def_cfa" => CfiOp::DefCfa {
            reg: reg(0)?,
            off: num(1)?,
        },
        ".cfi_def_cfa_register" => CfiOp::DefCfaRegister(reg(0)?),
        ".cfi_def_cfa_offset" => CfiOp::DefCfaOffset(num(0)?),
        ".cfi_adjust_cfa_offset" => CfiOp::AdjustCfaOffset(num(0)?),
        ".cfi_offset" => CfiOp::Offset {
            reg: reg(0)?,
            off: num(1)?,
        },
        ".cfi_rel_offset" => CfiOp::RelOffset {
            reg: reg(0)?,
            off: num(1)?,
        },
        ".cfi_val_offset" => CfiOp::ValOffset {
            reg: reg(0)?,
            off: num(1)?,
        },
        ".cfi_negate_ra_state" | ".cfi_window_save" => CfiOp::NegateRaState,
        ".cfi_register" => CfiOp::Register {
            reg: reg(0)?,
            from: reg(1)?,
        },
        ".cfi_restore" => CfiOp::Restore(reg(0)?),
        ".cfi_undefined" => CfiOp::Undefined(reg(0)?),
        ".cfi_same_value" => CfiOp::SameValue(reg(0)?),
        ".cfi_remember_state" => CfiOp::RememberState,
        ".cfi_restore_state" => CfiOp::RestoreState,
        ".cfi_escape" => {
            let mut bytes = Vec::with_capacity(args.len());
            for a in &args {
                let v = eval(a).ok_or_else(|| {
                    alloc::format!("`.cfi_escape` operand `{a}` is not a constant")
                })?;
                bytes.push(v as u8);
            }
            CfiOp::Escape(bytes)
        }
        // A directive with no bearing on the tables' contents.
        ".cfi_label" | ".cfi_personality" | ".cfi_lsda" => return Ok(None),
        _ => return Err(alloc::format!("unsupported directive `{tok}`")),
    };
    Ok(Some(op))
}

fn parse_reg(a: &str) -> CfiReg {
    match parse_int(a) {
        Some(n) if n >= 0 && !a.starts_with('%') => CfiReg::Num(n as u64),
        _ => CfiReg::Name(String::from(a)),
    }
}

fn parse_int(s: &str) -> Option<i64> {
    let s = s.trim();
    let (neg, s) = match s.strip_prefix('-') {
        Some(r) => (true, r.trim()),
        None => (false, s.strip_prefix('+').map(str::trim).unwrap_or(s)),
    };
    let v = if let Some(h) = s.strip_prefix("0x").or_else(|| s.strip_prefix("0X")) {
        i64::from_str_radix(h, 16).ok()?
    } else {
        s.parse::<i64>().ok()?
    };
    Some(if neg { -v } else { v })
}

/// A frame description under construction: the code range it covers and the
/// call-frame instructions describing it.
struct Fde {
    key: String,
    start: u32,
    end: u32,
    signal: bool,
    /// `.cfi_return_column`'s override; the target's own column otherwise.
    return_column: Option<CfiReg>,
    /// Instructions and the section offset each applies from.
    ops: Vec<(u32, CfiOp)>,
}

/// Running CFA state, which lowers the offset-relative directives.
#[derive(Default, Clone, Copy)]
struct CfaState {
    offset: i64,
}

pub(crate) fn build_cfi_sections(
    records: &[CfiRecord],
    t: CfiTarget,
) -> Result<Vec<AsmSection>, String> {
    let (fdes, sections) = collect_fdes(records)?;
    if fdes.is_empty() {
        return Ok(Vec::new());
    }
    let mut out = Vec::new();
    if sections.eh_frame {
        out.push(encode_table(&fdes, t, true)?);
    }
    if sections.debug_frame {
        out.push(encode_table(&fdes, t, false)?);
    }
    Ok(out)
}

/// Group the stream into frame descriptions and settle the tables asked for.
fn collect_fdes(records: &[CfiRecord]) -> Result<(Vec<Fde>, CfiSections), String> {
    let mut fdes: Vec<Fde> = Vec::new();
    let mut open: Option<Fde> = None;
    let mut sections = CfiSections::default();
    let mut saw_proc = false;
    for r in records {
        match &r.op {
            CfiOp::Sections(s) => {
                // GNU as honours the directive only before the first frame
                // opens; one inside a description leaves the choice alone.
                if !saw_proc {
                    sections = *s;
                }
            }
            CfiOp::StartProc { simple } => {
                if open.is_some() {
                    return Err(String::from(
                        "`.cfi_startproc` inside a frame description already open",
                    ));
                }
                saw_proc = true;
                let mut fde = Fde {
                    key: r.key.clone(),
                    start: r.offset,
                    end: r.offset,
                    signal: false,
                    return_column: None,
                    ops: Vec::new(),
                };
                if !simple {
                    fde.ops.push((r.offset, CfiOp::StartProc { simple: false }));
                }
                open = Some(fde);
            }
            CfiOp::EndProc => {
                let mut fde = open
                    .take()
                    .ok_or_else(|| String::from("`.cfi_endproc` with no `.cfi_startproc` open"))?;
                if fde.key != r.key {
                    return Err(String::from(
                        "a frame description must open and close in one section",
                    ));
                }
                fde.end = r.offset;
                fdes.push(fde);
            }
            CfiOp::SignalFrame => match open.as_mut() {
                Some(f) => f.signal = true,
                None => {
                    return Err(String::from(
                        "`.cfi_signal_frame` outside a frame description",
                    ));
                }
            },
            CfiOp::ReturnColumn(reg) => match open.as_mut() {
                Some(f) => f.return_column = Some(reg.clone()),
                None => {
                    return Err(String::from(
                        "`.cfi_return_column` outside a frame description",
                    ));
                }
            },
            op => {
                let f = open.as_mut().ok_or_else(|| {
                    String::from("a `.cfi_*` state directive outside a frame description")
                })?;
                if f.key != r.key {
                    return Err(String::from(
                        "a frame description must open and close in one section",
                    ));
                }
                f.ops.push((r.offset, op.clone()));
            }
        }
    }
    if open.is_some() {
        return Err(String::from("`.cfi_startproc` with no `.cfi_endproc`"));
    }
    Ok((fdes, sections))
}

/// A CIE's identity: two frames share one when every field matches.
#[derive(PartialEq, Eq)]
struct CieKey {
    signal: bool,
    return_column: u64,
    initial: Vec<u8>,
}

/// Lower one frame's directives, splitting off the leading run that applies
/// at the frame's first byte. That run is the frame's initial state and
/// belongs in the CIE, which is what `DW_CFA_restore` names.
fn lower_fde(fde: &Fde, t: CfiTarget) -> Result<(Vec<u8>, Vec<u8>), String> {
    let mut initial = Vec::new();
    let mut body = Vec::new();
    let mut cfa = CfaState::default();
    let mut at = fde.start;
    let mut hoisting = true;
    for (off, op) in &fde.ops {
        if let CfiOp::StartProc { .. } = op {
            for d in t.default_rules() {
                encode_op(&mut initial, &d, &mut cfa, t)?;
            }
            continue;
        }
        // The initial run ends at the first instruction that describes a
        // later point in the frame.
        if hoisting && *off == fde.start && hoistable(op) {
            encode_op(&mut initial, op, &mut cfa, t)?;
            continue;
        }
        hoisting = false;
        if *off > at {
            write_advance(&mut body, (*off - at) as u64, t)?;
            at = *off;
        }
        encode_op(&mut body, op, &mut cfa, t)?;
    }
    Ok((initial, body))
}

/// Whether an instruction may join a CIE's initial run. The state-stack and
/// escape forms are excluded: their meaning depends on stream position.
fn hoistable(op: &CfiOp) -> bool {
    matches!(
        op,
        CfiOp::DefCfa { .. }
            | CfiOp::DefCfaRegister(_)
            | CfiOp::DefCfaOffset(_)
            | CfiOp::AdjustCfaOffset(_)
            | CfiOp::Offset { .. }
            | CfiOp::RelOffset { .. }
            | CfiOp::ValOffset { .. }
            | CfiOp::Register { .. }
            | CfiOp::Undefined(_)
            | CfiOp::SameValue(_)
    )
}

fn encode_op(
    out: &mut Vec<u8>,
    op: &CfiOp,
    cfa: &mut CfaState,
    t: CfiTarget,
) -> Result<(), String> {
    let daf = t.data_align();
    match op {
        CfiOp::DefCfa { reg, off } => {
            cfa.offset = *off;
            out.push(DW_CFA_DEF_CFA);
            write_uleb(out, reg.resolve(t)?);
            write_uleb(out, *off as u64);
        }
        CfiOp::DefCfaRegister(reg) => {
            out.push(DW_CFA_DEF_CFA_REGISTER);
            write_uleb(out, reg.resolve(t)?);
        }
        CfiOp::DefCfaOffset(off) => {
            cfa.offset = *off;
            write_def_cfa_offset(out, *off, daf);
        }
        CfiOp::AdjustCfaOffset(delta) => {
            cfa.offset += *delta;
            write_def_cfa_offset(out, cfa.offset, daf);
        }
        CfiOp::Offset { reg, off } => write_offset(out, reg.resolve(t)?, *off, daf)?,
        // The register sits at `cfa_reg + off`; the CFA is `cfa_reg +
        // cfa_offset`, so the CFA-relative distance is the difference.
        CfiOp::RelOffset { reg, off } => {
            write_offset(out, reg.resolve(t)?, *off - cfa.offset, daf)?
        }
        // The register's value, rather than the address it was saved at.
        CfiOp::ValOffset { reg, off } => {
            let r = reg.resolve(t)?;
            let factored = factor(*off, daf)?;
            if factored >= 0 {
                out.push(DW_CFA_VAL_OFFSET);
                write_uleb(out, r);
                write_uleb(out, factored as u64);
            } else {
                out.push(DW_CFA_VAL_OFFSET_SF);
                write_uleb(out, r);
                write_sleb(out, factored);
            }
        }
        CfiOp::NegateRaState => out.push(DW_CFA_NEGATE_RA_STATE),
        CfiOp::Register { reg, from } => {
            out.push(DW_CFA_REGISTER);
            write_uleb(out, reg.resolve(t)?);
            write_uleb(out, from.resolve(t)?);
        }
        CfiOp::Restore(reg) => {
            let r = reg.resolve(t)?;
            if r < 0x40 {
                out.push(DW_CFA_RESTORE_HI | r as u8);
            } else {
                out.push(DW_CFA_RESTORE_EXTENDED);
                write_uleb(out, r);
            }
        }
        CfiOp::Undefined(reg) => {
            out.push(DW_CFA_UNDEFINED);
            write_uleb(out, reg.resolve(t)?);
        }
        CfiOp::SameValue(reg) => {
            out.push(DW_CFA_SAME_VALUE);
            write_uleb(out, reg.resolve(t)?);
        }
        CfiOp::RememberState => out.push(DW_CFA_REMEMBER_STATE),
        CfiOp::RestoreState => out.push(DW_CFA_RESTORE_STATE),
        CfiOp::Escape(b) => out.extend_from_slice(b),
        CfiOp::StartProc { .. }
        | CfiOp::EndProc
        | CfiOp::Sections(_)
        | CfiOp::SignalFrame
        | CfiOp::ReturnColumn(_) => {}
    }
    Ok(())
}

fn write_def_cfa_offset(out: &mut Vec<u8>, off: i64, daf: i64) {
    if off >= 0 {
        out.push(DW_CFA_DEF_CFA_OFFSET);
        write_uleb(out, off as u64);
    } else {
        out.push(DW_CFA_DEF_CFA_OFFSET_SF);
        write_sleb(out, off / daf);
    }
}

/// Divide a CFA-relative byte offset by the data alignment factor.
fn factor(off: i64, daf: i64) -> Result<i64, String> {
    if off % daf != 0 {
        return Err(alloc::format!(
            "a saved-register offset of {off} is not a multiple of the data alignment factor {daf}"
        ));
    }
    Ok(off / daf)
}

fn write_offset(out: &mut Vec<u8>, reg: u64, off: i64, daf: i64) -> Result<(), String> {
    let factored = factor(off, daf)?;
    if factored >= 0 && reg < 0x40 {
        out.push(DW_CFA_OFFSET_HI | reg as u8);
        write_uleb(out, factored as u64);
    } else if factored >= 0 {
        out.push(DW_CFA_OFFSET_EXTENDED);
        write_uleb(out, reg);
        write_uleb(out, factored as u64);
    } else {
        out.push(DW_CFA_OFFSET_EXTENDED_SF);
        write_uleb(out, reg);
        write_sleb(out, factored);
    }
    Ok(())
}

fn write_advance(out: &mut Vec<u8>, bytes: u64, t: CfiTarget) -> Result<(), String> {
    let caf = t.code_align();
    if !bytes.is_multiple_of(caf) {
        return Err(alloc::format!(
            "a frame advance of {bytes} bytes is not a multiple of the code alignment factor {caf}"
        ));
    }
    let n = bytes / caf;
    if n < 0x40 {
        out.push(DW_CFA_ADVANCE_LOC_HI | n as u8);
    } else if n <= 0xff {
        out.push(DW_CFA_ADVANCE_LOC1);
        out.push(n as u8);
    } else if n <= 0xffff {
        out.push(DW_CFA_ADVANCE_LOC2);
        out.extend_from_slice(&(n as u16).to_le_bytes());
    } else {
        out.push(DW_CFA_ADVANCE_LOC4);
        out.extend_from_slice(&(n as u32).to_le_bytes());
    }
    Ok(())
}

/// Build one frame table. `eh` picks the runtime form over the offline one.
fn encode_table(fdes: &[Fde], t: CfiTarget, eh: bool) -> Result<AsmSection, String> {
    let mut bytes: Vec<u8> = Vec::new();
    let mut relocs: Vec<AsmSectionReloc> = Vec::new();
    let mut cies: Vec<(CieKey, u32)> = Vec::new();
    for fde in fdes {
        let (initial, body) = lower_fde(fde, t)?;
        let column = match &fde.return_column {
            Some(r) => r.resolve(t)?,
            None => t.return_column(),
        };
        let key = CieKey {
            signal: fde.signal,
            return_column: column,
            initial,
        };
        let cie_off = match cies.iter().find(|(k, _)| *k == key) {
            Some((_, off)) => *off,
            None => {
                let off = bytes.len() as u32;
                write_cie(&mut bytes, &key, t, eh);
                cies.push((key, off));
                off
            }
        };
        write_fde(&mut bytes, &mut relocs, fde, cie_off, &body, t, eh);
    }
    // The last record absorbs the padding that keeps the section's length a
    // whole number of addresses, so concatenated unit tables stay aligned.
    let addr = t.addr_bytes as usize;
    if !bytes.len().is_multiple_of(addr) {
        let pad = addr - bytes.len() % addr;
        extend_last_record(&mut bytes, pad);
    }
    Ok(AsmSection {
        name: String::from(if eh { ".eh_frame" } else { ".debug_frame" }),
        flags: String::from(if eh { "a" } else { "" }),
        sh_type: None,
        bytes,
        relocs,
        labels: Vec::new(),
        align: t.addr_bytes as u32,
        after_insn: false,
        map: MapMarks::default(),
    })
}

/// Offset of the final record's length field, found by walking the chain.
fn last_record_start(bytes: &[u8]) -> usize {
    let mut at = 0usize;
    let mut last = 0usize;
    while at + 4 <= bytes.len() {
        let len = u32::from_le_bytes([bytes[at], bytes[at + 1], bytes[at + 2], bytes[at + 3]]);
        last = at;
        at += 4 + len as usize;
    }
    last
}

/// Grow the table.s final record by `pad` `DW_CFA_nop`s.
fn extend_last_record(bytes: &mut Vec<u8>, pad: usize) {
    let at = last_record_start(bytes);
    let len = u32::from_le_bytes([bytes[at], bytes[at + 1], bytes[at + 2], bytes[at + 3]]);
    bytes[at..at + 4].copy_from_slice(&(len + pad as u32).to_le_bytes());
    bytes.extend(core::iter::repeat_n(DW_CFA_NOP, pad));
}

fn write_cie(out: &mut Vec<u8>, key: &CieKey, t: CfiTarget, eh: bool) {
    let start = out.len();
    out.extend_from_slice(&[0u8; 4]);
    if eh {
        out.extend_from_slice(&0u32.to_le_bytes());
    } else {
        out.extend_from_slice(&u32::MAX.to_le_bytes());
    }
    out.push(1);
    // `z` announces the augmentation-data block `R` fills with the FDE
    // pointer encoding; `.debug_frame` carries only the signal-frame mark.
    if eh {
        out.extend_from_slice(b"zR");
    }
    if key.signal {
        out.push(b'S');
    }
    out.push(0);
    write_uleb(out, t.code_align());
    write_sleb(out, t.data_align());
    // Version 1 carries the return column in a single byte.
    out.push(key.return_column as u8);
    if eh {
        write_uleb(out, 1);
        out.push(DW_EH_PE_PCREL_SDATA4);
    }
    out.extend_from_slice(&key.initial);
    finish_record(out, start, record_align(t, eh));
}

#[allow(clippy::too_many_arguments)]
fn write_fde(
    out: &mut Vec<u8>,
    relocs: &mut Vec<AsmSectionReloc>,
    fde: &Fde,
    cie_off: u32,
    body: &[u8],
    t: CfiTarget,
    eh: bool,
) {
    let start = out.len();
    out.extend_from_slice(&[0u8; 4]);
    if eh {
        // Distance back to the CIE, which is how `.eh_frame` names it.
        out.extend_from_slice(&((out.len() as u32) - cie_off).to_le_bytes());
    } else {
        // An offset into this section, which the link must rebase.
        relocs.push(AsmSectionReloc {
            offset: out.len() as u32,
            width: 4,
            kind: AsmRelocKind::Data,
            pcrel: false,
            branch: false,
            signed: false,
            target: AsmSectionTarget::OwnSection(cie_off),
            addend: 0,
        });
        out.extend_from_slice(&[0u8; 4]);
    }
    // The frame's first byte. `.eh_frame` states it PC-relative, so a
    // shared object needs no load-time relocation to read the table.
    let width = if eh { 4 } else { t.addr_bytes };
    relocs.push(AsmSectionReloc {
        offset: out.len() as u32,
        width,
        kind: AsmRelocKind::Data,
        pcrel: eh,
        branch: false,
        signed: false,
        target: AsmSectionTarget::SectionStart(fde.key.clone()),
        addend: fde.start as i64,
    });
    out.extend_from_slice(&[0u8; 8][..width as usize]);
    let range = (fde.end - fde.start) as u64;
    out.extend_from_slice(&range.to_le_bytes()[..width as usize]);
    if eh {
        write_uleb(out, 0);
    }
    out.extend_from_slice(body);
    finish_record(out, start, record_align(t, eh));
}

/// Pad a record to `align` and back-patch the length field, which counts
/// everything after itself.
fn finish_record(out: &mut Vec<u8>, start: usize, align: usize) {
    while !(out.len() - start).is_multiple_of(align) {
        out.push(DW_CFA_NOP);
    }
    let len = (out.len() - start - 4) as u32;
    out[start..start + 4].copy_from_slice(&len.to_le_bytes());
}

/// `.debug_frame` aligns a record to the address size, `.eh_frame` to the
/// 32-bit DWARF length unit.
fn record_align(t: CfiTarget, eh: bool) -> usize {
    if eh { 4 } else { t.addr_bytes as usize }
}

fn write_uleb(out: &mut Vec<u8>, mut value: u64) {
    loop {
        let mut b = (value & 0x7f) as u8;
        value >>= 7;
        if value != 0 {
            b |= 0x80;
        }
        out.push(b);
        if value == 0 {
            break;
        }
    }
}

fn write_sleb(out: &mut Vec<u8>, mut value: i64) {
    loop {
        let mut b = (value & 0x7f) as u8;
        value >>= 7;
        let done = (value == 0 && b & 0x40 == 0) || (value == -1 && b & 0x40 != 0);
        if !done {
            b |= 0x80;
        }
        out.push(b);
        if done {
            break;
        }
    }
}
