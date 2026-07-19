//! GCC extended inline-asm (AArch64): ARM-syntax template parsing and operand
//! assignment.
//!
//! [`parse_template`] turns a template into a sequence of [`AsmInsnA64`]s with
//! symbolic operand references (`%N` / `%wN` / `%xN`), explicit registers
//! (`x5`, `w5`, `sp`, `xzr`), and immediates (`#imm`). The emitter
//! ([`super::emit`]) assigns a machine register to each register operand per
//! [`assign_operand_regs`], resolves each reference, and encodes the
//! register-concrete instruction through the table encoder
//! ([`super::table`]). Raw-byte pieces (a `.byte` directive or a hex-byte run)
//! ride the same stream so a template may mix them with mnemonics.
//!
//! The VM does not interpret this path (its inline-asm evaluator is x86-only),
//! so AArch64 mnemonic inline asm is native-only.

#![allow(dead_code)]

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::ssa::emit_common;

/// One symbolic operand of a template instruction.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmOpndA64 {
    /// `%N` / `%wN` / `%xN`: operand N of the statement, at the register width
    /// named by the modifier (or the operand's own width when unmodified).
    Ref { idx: u8, is64: Option<bool> },
    /// An explicit register: `x5` / `w5` / `sp` / `xzr` (`num == 31` is the
    /// zero register or SP, per the instruction).
    Reg { num: u8, is64: bool },
    /// A literal immediate `#imm`.
    Imm(i64),
    /// A `lsl #n` shift modifier (move-wide).
    Lsl(u32),
    /// A system register named in a `mrs` / `msr`, resolved to its 15-bit field.
    SysReg(u16),
    /// A memory reference `[base, #off]` (the `off` defaults to 0). The base is
    /// an operand reference or an explicit register. `pre` marks the
    /// pre-index writeback form `[base, #off]!`; post-index (`[base], #off`)
    /// is the separate trailing-immediate operand shape the encoder folds in.
    Mem { base: MemBase, off: i64, pre: bool },
    /// A condition code (`eq`, `ne`, ...) as its 4-bit encoding, for the
    /// conditional-select forms.
    Cond(u8),
    /// A local-label reference `Nb` / `Nf`: label number plus direction
    /// (`forward` selects the next definition after the branch, otherwise the
    /// most recent one at or before it).
    Label { num: u32, forward: bool },
}

/// The base register of a memory operand.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum MemBase {
    Ref(u8),
    Reg(u8),
}

/// The 15-bit `mrs`/`msr` system-register field for a name, or the generic
/// `s<op0>_<op1>_c<CRn>_c<CRm>_<op2>` spelling that names any register.
/// `field = (op0-2)<<14 | op1<<11 | CRn<<7 | CRm<<3 | op2`.
fn sysreg_field(name: &str) -> Option<u16> {
    fn pack(op0: u16, op1: u16, crn: u16, crm: u16, op2: u16) -> u16 {
        ((op0 - 2) << 14) | (op1 << 11) | (crn << 7) | (crm << 3) | op2
    }
    // Register names are case-insensitive in the architecture; normalize before
    // matching either the named table or the generic spelling.
    let name = name.to_ascii_lowercase();
    let name = name.as_str();
    // Common registers by name; extend as needed.
    let named = |n: &str| -> Option<(u16, u16, u16, u16, u16)> {
        Some(match n {
            "midr_el1" => (3, 0, 0, 0, 0),
            "mpidr_el1" => (3, 0, 0, 0, 5),
            "ctr_el0" => (3, 3, 0, 0, 1),
            "tpidr_el0" => (3, 3, 13, 0, 2),
            "tpidr_el1" => (3, 0, 13, 0, 4),
            "sctlr_el1" => (3, 0, 1, 0, 0),
            "vbar_el1" => (3, 0, 12, 0, 0),
            "daif" => (3, 3, 4, 2, 1),
            "nzcv" => (3, 3, 4, 2, 0),
            "cntfrq_el0" => (3, 3, 14, 0, 0),
            "cntpct_el0" => (3, 3, 14, 0, 1),
            "cntvct_el0" => (3, 3, 14, 0, 2),
            // Physical / virtual generic-timer control, timer-value, and
            // compare-value registers.
            "cntp_ctl_el0" => (3, 3, 14, 2, 1),
            "cntp_tval_el0" => (3, 3, 14, 2, 0),
            "cntp_cval_el0" => (3, 3, 14, 2, 2),
            "cntv_ctl_el0" => (3, 3, 14, 3, 1),
            "cntv_tval_el0" => (3, 3, 14, 3, 0),
            "cntv_cval_el0" => (3, 3, 14, 3, 2),
            "cntkctl_el1" => (3, 0, 14, 1, 0),
            "esr_el1" => (3, 0, 5, 2, 0),
            "far_el1" => (3, 0, 6, 0, 0),
            "elr_el1" => (3, 0, 4, 0, 1),
            "spsr_el1" => (3, 0, 4, 0, 0),
            "currentel" => (3, 0, 4, 2, 2),
            _ => return None,
        })
    };
    if let Some((op0, op1, crn, crm, op2)) = named(name) {
        return Some(pack(op0, op1, crn, crm, op2));
    }
    // Generic `sN_N_cN_cN_N` spelling.
    let p: Vec<&str> = name.split('_').collect();
    if p.len() == 5
        && let Some(op0) = p[0].strip_prefix('s').and_then(|s| s.parse::<u16>().ok())
        && let Ok(op1) = p[1].parse::<u16>()
        && let Some(crn) = p[2].strip_prefix('c').and_then(|s| s.parse::<u16>().ok())
        && let Some(crm) = p[3].strip_prefix('c').and_then(|s| s.parse::<u16>().ok())
        && let Ok(op2) = p[4].parse::<u16>()
        && (2..=3).contains(&op0)
        && op1 <= 7
        && crn <= 15
        && crm <= 15
        && op2 <= 7
    {
        return Some(pack(op0, op1, crn, crm, op2));
    }
    None
}

/// One instruction of a parsed template.
#[derive(Debug, Clone)]
pub(crate) struct AsmInsnA64 {
    /// Empty for a raw-byte piece (`bytes` carries the payload) and for a
    /// local-label definition (`label_def` carries the number).
    pub mnemonic: String,
    pub operands: Vec<AsmOpndA64>,
    /// Literal bytes for a raw-byte piece; empty for a mnemonic.
    pub bytes: Vec<u8>,
    /// A local-label definition `N:`; the emitter records the code offset it
    /// stands at.
    pub label_def: Option<u32>,
}

/// A condition-code mnemonic to its 4-bit encoding.
pub(crate) fn cond_code(name: &str) -> Option<u8> {
    Some(match name {
        "eq" => 0,
        "ne" => 1,
        "cs" | "hs" => 2,
        "cc" | "lo" => 3,
        "mi" => 4,
        "pl" => 5,
        "vs" => 6,
        "vc" => 7,
        "hi" => 8,
        "ls" => 9,
        "ge" => 10,
        "lt" => 11,
        "gt" => 12,
        "le" => 13,
        "al" => 14,
        "nv" => 15,
        _ => return None,
    })
}

fn parse_reg(tok: &str) -> Option<(u8, bool)> {
    match tok {
        "sp" | "xzr" => return Some((31, true)),
        "wsp" | "wzr" => return Some((31, false)),
        _ => {}
    }
    let (is64, rest) = match tok.as_bytes().first()? {
        b'x' => (true, &tok[1..]),
        b'w' => (false, &tok[1..]),
        _ => return None,
    };
    let n: u8 = rest.parse().ok()?;
    (n <= 30).then_some((n, is64))
}

fn parse_int(s: &str) -> Option<i64> {
    let s = s.trim();
    let (neg, s) = match s.strip_prefix('-') {
        Some(r) => (true, r),
        None => (false, s),
    };
    let v = if let Some(h) = s.strip_prefix("0x").or_else(|| s.strip_prefix("0X")) {
        i64::from_str_radix(h, 16).ok()?
    } else {
        s.parse::<i64>().ok()?
    };
    Some(if neg { -v } else { v })
}

/// Split an operand list on commas, but not commas inside `[...]` (a memory
/// operand carries its own comma, as in `[x1, #8]`).
fn split_operands(rest: &str) -> Vec<&str> {
    let mut out = Vec::new();
    let (mut depth, mut start) = (0i32, 0usize);
    for (i, c) in rest.char_indices() {
        match c {
            '[' => depth += 1,
            ']' => depth -= 1,
            ',' if depth == 0 => {
                out.push(rest[start..i].trim());
                start = i + 1;
            }
            _ => {}
        }
    }
    let last = rest[start..].trim();
    if !last.is_empty() {
        out.push(last);
    }
    out
}

/// Parse a `[base]` / `[base, #off]` memory reference; `pre` is the pre-index
/// writeback (`[base, #off]!`).
fn parse_mem(inner: &str, pre: bool) -> Result<AsmOpndA64, String> {
    let parts = split_operands(inner);
    if parts.is_empty() || parts.len() > 2 {
        return Err(format!("inline asm: bad memory operand `[{inner}]`"));
    }
    let base = match parse_operand(parts[0])? {
        AsmOpndA64::Ref { idx, .. } => MemBase::Ref(idx),
        AsmOpndA64::Reg { num, .. } => MemBase::Reg(num),
        _ => {
            return Err(format!(
                "inline asm: memory base must be a register `[{inner}]`"
            ));
        }
    };
    let off = if parts.len() == 2 {
        parts[1]
            .strip_prefix('#')
            .and_then(parse_int)
            .ok_or_else(|| format!("inline asm: bad memory offset `{}`", parts[1]))?
    } else {
        0
    };
    Ok(AsmOpndA64::Mem { base, off, pre })
}

/// Parse one operand token (already trimmed).
fn parse_operand(tok: &str) -> Result<AsmOpndA64, String> {
    // `[...]` is an offset reference; `[...]!` a pre-index writeback.
    if let Some(inner) = tok.strip_prefix('[').and_then(|t| t.strip_suffix(']')) {
        return parse_mem(inner, false);
    }
    if let Some(inner) = tok
        .strip_prefix('[')
        .and_then(|t| t.strip_suffix('!'))
        .and_then(|t| t.strip_suffix(']'))
    {
        return parse_mem(inner, true);
    }
    if let Some(rest) = tok.strip_prefix('#') {
        let v = parse_int(rest).ok_or_else(|| format!("inline asm: bad immediate `{tok}`"))?;
        return Ok(AsmOpndA64::Imm(v));
    }
    if let Some(rest) = tok.strip_prefix('%') {
        // `%N`, `%wN`, `%xN`.
        let (is64, digits) = match rest.as_bytes().first() {
            Some(b'w') => (Some(false), &rest[1..]),
            Some(b'x') => (Some(true), &rest[1..]),
            _ => (None, rest),
        };
        let idx: u8 = digits
            .parse()
            .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
        return Ok(AsmOpndA64::Ref { idx, is64 });
    }
    // `lsl #n` shift modifier (the only shift kind the move-wide forms take).
    if let Some(rest) = tok.strip_prefix("lsl") {
        let amt = rest
            .trim()
            .strip_prefix('#')
            .and_then(parse_int)
            .ok_or_else(|| format!("inline asm: bad shift `{tok}`"))?;
        return Ok(AsmOpndA64::Lsl(amt as u32));
    }
    if let Some((num, is64)) = parse_reg(tok) {
        return Ok(AsmOpndA64::Reg { num, is64 });
    }
    // A system-register name (for mrs / msr).
    if let Some(field) = sysreg_field(tok) {
        return Ok(AsmOpndA64::SysReg(field));
    }
    // A condition code (for csel and other conditional forms).
    if let Some(c) = cond_code(tok) {
        return Ok(AsmOpndA64::Cond(c));
    }
    // A local-label reference `Nb` / `Nf` (mnemonics never start with a digit).
    if let Some((digits, dir)) = tok
        .strip_suffix('b')
        .map(|d| (d, false))
        .or_else(|| tok.strip_suffix('f').map(|d| (d, true)))
        && !digits.is_empty()
        && digits.bytes().all(|c| c.is_ascii_digit())
        && let Ok(num) = digits.parse::<u32>()
    {
        return Ok(AsmOpndA64::Label { num, forward: dir });
    }
    Err(format!("inline asm: unsupported operand `{tok}`"))
}

/// Parse an AArch64 inline-asm template into its instruction sequence.
/// Instructions are separated by `;` or newlines; operands by commas. A piece
/// that is all raw bytes (a `.byte`-family directive or a hex-byte run) becomes
/// a raw-byte instruction.
pub(crate) fn parse_template(tmpl: &[u8]) -> Result<Vec<AsmInsnA64>, String> {
    let text =
        core::str::from_utf8(tmpl).map_err(|_| String::from("inline asm: non-UTF8 template"))?;
    let mut insns = Vec::new();
    for piece in text.split([';', '\n']) {
        let mut piece = piece.trim();
        if piece.is_empty() {
            continue;
        }
        // A leading `N:` defines a local label at this point; the rest of the
        // statement (possibly empty) follows on the same line.
        if let Some(colon) = piece.find(':')
            && colon > 0
            && piece.as_bytes()[..colon].iter().all(u8::is_ascii_digit)
        {
            let num: u32 = piece[..colon]
                .parse()
                .map_err(|_| format!("inline asm: bad label `{piece}`"))?;
            insns.push(AsmInsnA64 {
                mnemonic: String::new(),
                operands: Vec::new(),
                bytes: Vec::new(),
                label_def: Some(num),
            });
            piece = piece[colon + 1..].trim();
            if piece.is_empty() {
                continue;
            }
        }
        // Reuse the shared raw-byte recognizer for a single piece.
        if let Some(bytes) = emit_common::parse_raw_template(piece.as_bytes()) {
            insns.push(AsmInsnA64 {
                mnemonic: String::new(),
                operands: Vec::new(),
                bytes,
                label_def: None,
            });
            continue;
        }
        let (mnem, rest) = match piece.find(char::is_whitespace) {
            Some(p) => (&piece[..p], piece[p..].trim()),
            None => (piece, ""),
        };
        // `mov Rd, sp` / `mov sp, Rn` is `add Rd, Rn, #0` -- distinct from the
        // register move `mov Rd, Rm` (`orr Rd, xzr, Rm`), and only the raw
        // token tells `sp` from `xzr` (both parse to register 31). Rewrite the
        // stack-pointer forms here; a plain register / immediate `mov` stays and
        // is encoded by the alias arm in `super::table::encode`.
        if mnem == "mov" {
            let toks: Vec<&str> = split_operands(rest);
            if toks.len() == 2
                && (toks[0] == "sp" || toks[0] == "wsp" || toks[1] == "sp" || toks[1] == "wsp")
            {
                let dst = parse_operand(toks[0])?;
                let src = parse_operand(toks[1])?;
                insns.push(AsmInsnA64 {
                    mnemonic: String::from("add"),
                    operands: alloc::vec![dst, src, AsmOpndA64::Imm(0)],
                    bytes: Vec::new(),
                    label_def: None,
                });
                continue;
            }
        }
        let mut operands = Vec::new();
        if !rest.is_empty() {
            for op in split_operands(rest) {
                operands.push(parse_operand(op)?);
            }
        }
        insns.push(AsmInsnA64 {
            mnemonic: String::from(mnem),
            operands,
            bytes: Vec::new(),
            label_def: None,
        });
    }
    Ok(insns)
}

/// Assign an AArch64 register number to each register operand of the statement,
/// per its constraint. Returns a vector parallel to `operands`: `Some(reg)` for
/// a register operand, `None` for an immediate-only operand. `r` operands take
/// free registers from a pool of x0..x15 (the emitter saves and restores them,
/// and reserves x16 / x17 as bridge scratch); matching constraints alias the
/// register of the operand they name.
pub(crate) fn assign_operand_regs(
    operands: &[crate::c5::ir::AsmOperand],
) -> Result<Vec<Option<u8>>, String> {
    use crate::c5::ir::AsmConstraint as C;
    let mut assigned: Vec<Option<u8>> = alloc::vec![None; operands.len()];
    let mut used = [false; 32];
    // x0..x15 are the allocatable pool; x16/x17 are the emitter's scratch.
    let pool: [u8; 16] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
    for (i, op) in operands.iter().enumerate() {
        if matches!(op.constraint, C::Reg | C::Mem) {
            let r = pool
                .iter()
                .copied()
                .find(|&r| !used[r as usize])
                .ok_or_else(|| String::from("inline asm: out of registers for operands"))?;
            used[r as usize] = true;
            assigned[i] = Some(r);
        }
    }
    for i in 0..operands.len() {
        if let C::Match(n) = operands[i].constraint {
            let r = assigned.get(n as usize).copied().flatten().ok_or_else(|| {
                String::from("inline asm: matching constraint on a non-register operand")
            })?;
            assigned[i] = Some(r);
        }
    }
    // Fixed / register-or-immediate constraints are x86-specific and do not
    // occur in AArch64 templates; reject them rather than mis-assign.
    for op in operands {
        if matches!(op.constraint, C::Fixed(_) | C::RegOrImm(_)) {
            return Err(String::from(
                "inline asm: fixed-register constraint not supported on AArch64",
            ));
        }
    }
    Ok(assigned)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parse_data_processing() {
        let insns = parse_template(b"add %0, %1, %2").unwrap();
        assert_eq!(insns.len(), 1);
        assert_eq!(insns[0].mnemonic, "add");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Ref { idx: 0, is64: None },
                AsmOpndA64::Ref { idx: 1, is64: None },
                AsmOpndA64::Ref { idx: 2, is64: None },
            ]
        );
    }

    #[test]
    fn parse_regs_imms_shifts() {
        let insns = parse_template(b"movz x3, #0x1234, lsl #16; mov %w0, wzr").unwrap();
        assert_eq!(insns.len(), 2);
        assert_eq!(insns[0].mnemonic, "movz");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Reg { num: 3, is64: true },
                AsmOpndA64::Imm(0x1234),
                AsmOpndA64::Lsl(16),
            ]
        );
        assert_eq!(
            insns[1].operands,
            [
                AsmOpndA64::Ref {
                    idx: 0,
                    is64: Some(false)
                },
                AsmOpndA64::Reg {
                    num: 31,
                    is64: false
                },
            ]
        );
    }

    #[test]
    fn parse_raw_piece_in_stream() {
        let insns = parse_template(b".byte 0x1f, 0x20, 0x03, 0xd5; add %0, %0, %1").unwrap();
        assert_eq!(insns.len(), 2);
        assert_eq!(insns[0].bytes, [0x1f, 0x20, 0x03, 0xd5]);
        assert!(insns[0].mnemonic.is_empty());
        assert_eq!(insns[1].mnemonic, "add");
    }

    #[test]
    fn parse_mov_stack_pointer_rewrite() {
        // `mov Rd, sp` / `mov sp, Rn` become `add ..., #0` (only the raw token
        // separates `sp` from `xzr`); a register move stays `mov`.
        let insns = parse_template(b"mov x0, sp; mov sp, x1; mov x2, x3").unwrap();
        assert_eq!(insns[0].mnemonic, "add");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Reg { num: 0, is64: true },
                AsmOpndA64::Reg {
                    num: 31,
                    is64: true
                },
                AsmOpndA64::Imm(0),
            ]
        );
        assert_eq!(insns[1].mnemonic, "add");
        assert_eq!(
            insns[1].operands[0],
            AsmOpndA64::Reg {
                num: 31,
                is64: true
            }
        );
        assert_eq!(insns[2].mnemonic, "mov"); // register move kept for the encoder
    }

    #[test]
    fn parse_memory_operands() {
        // A memory operand keeps its internal comma out of the operand split.
        let insns = parse_template(b"ldr %0, [%1, #8]; str x3, [x4]").unwrap();
        assert_eq!(insns[0].mnemonic, "ldr");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Ref { idx: 0, is64: None },
                AsmOpndA64::Mem {
                    base: MemBase::Ref(1),
                    off: 8,
                    pre: false,
                },
            ]
        );
        assert_eq!(
            insns[1].operands,
            [
                AsmOpndA64::Reg { num: 3, is64: true },
                AsmOpndA64::Mem {
                    base: MemBase::Reg(4),
                    off: 0,
                    pre: false,
                },
            ]
        );
        // A negative offset feeds the signed imm9 forms (ldur/ldtr/sttr).
        let insns = parse_template(b"ldtr w0, [x1, #-4]").unwrap();
        assert_eq!(
            insns[0].operands[1],
            AsmOpndA64::Mem {
                base: MemBase::Reg(1),
                off: -4,
                pre: false,
            }
        );
        // A pre-index writeback `[base, #off]!`.
        let insns = parse_template(b"stp x0, x1, [sp, #-16]!").unwrap();
        assert_eq!(
            insns[0].operands[2],
            AsmOpndA64::Mem {
                base: MemBase::Reg(31),
                off: -16,
                pre: true,
            }
        );
    }

    #[test]
    fn parse_sysreg_operands() {
        // CTR_EL0 field 0x5801, cross-checked against the pattern-matched
        // encoding elsewhere; the generic `s3_3_c14_c0_2` names CNTVCT_EL0.
        assert_eq!(sysreg_field("ctr_el0"), Some(0x5801));
        assert_eq!(sysreg_field("s3_3_c0_c0_1"), Some(0x5801)); // == ctr_el0
        assert_eq!(sysreg_field("s3_3_c14_c0_2"), Some(0x5F02)); // cntvct_el0
        // Generic-timer registers (verified byte-identical to the assembler).
        assert_eq!(sysreg_field("cntv_ctl_el0"), Some(0x5F19));
        assert_eq!(sysreg_field("cntv_tval_el0"), Some(0x5F18));
        assert_eq!(sysreg_field("cntvct_el0"), Some(0x5F02));
        assert_eq!(sysreg_field("cntp_ctl_el0"), Some(0x5F11));
        assert_eq!(sysreg_field("tpidr_el1"), Some(0x4684)); // per-CPU pointer
        // Register names are case-insensitive.
        assert_eq!(sysreg_field("CurrentEL"), sysreg_field("currentel"));
        assert_eq!(sysreg_field("CNTV_CTL_EL0"), Some(0x5F19));
        assert_eq!(sysreg_field("not_a_reg"), None);
        let insns = parse_template(b"mrs %0, ctr_el0; msr nzcv, %1").unwrap();
        assert_eq!(insns[0].mnemonic, "mrs");
        assert_eq!(
            insns[0].operands,
            [
                AsmOpndA64::Ref { idx: 0, is64: None },
                AsmOpndA64::SysReg(0x5801)
            ]
        );
        assert_eq!(insns[1].mnemonic, "msr");
        assert!(matches!(insns[1].operands[0], AsmOpndA64::SysReg(_)));
    }

    #[test]
    fn parse_condition_operand() {
        assert_eq!(cond_code("lt"), Some(11));
        assert_eq!(cond_code("hs"), Some(2)); // alias of cs
        assert_eq!(cond_code("xyz"), None);
        let insns = parse_template(b"csel %0, %1, %2, ne").unwrap();
        assert_eq!(insns[0].mnemonic, "csel");
        assert_eq!(insns[0].operands[3], AsmOpndA64::Cond(1));
    }

    #[test]
    fn parse_local_labels() {
        // A definition alone, one prefixing an instruction, and both reference
        // directions.
        let insns = parse_template(b"1:\n\tsub %0, %0, #1\n2: cbnz %0, 1b\n\tb 2f").unwrap();
        assert_eq!(insns[0].label_def, Some(1));
        assert_eq!(insns[1].mnemonic, "sub");
        assert_eq!(insns[2].label_def, Some(2));
        assert_eq!(insns[3].mnemonic, "cbnz");
        assert_eq!(
            insns[3].operands[1],
            AsmOpndA64::Label {
                num: 1,
                forward: false
            }
        );
        assert_eq!(insns[4].mnemonic, "b");
        assert_eq!(
            insns[4].operands[0],
            AsmOpndA64::Label {
                num: 2,
                forward: true
            }
        );
    }
}
