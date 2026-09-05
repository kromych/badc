//! Table-driven x86-64 encoder.
//!
//! The instruction catalogue in [`super::isa_x86_table`] is a compact set of
//! [`Form`]s generated from an external instruction-set database (see
//! `tools/gen_isa.py`); this module interprets a form against concrete
//! operands to produce machine bytes. It is the single encoder shared by the
//! GP / system surface: the general-instruction lowering and the extended
//! inline-asm path resolve their operands to [`Opnd`]s and call [`encode`].
//!
//! Operand order is Intel (`dst, src`), matching the database signatures. The
//! caller passes operands already resolved to architectural register numbers.

#![allow(dead_code)] // Catalogue breadth runs ahead of lowering coverage.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

pub(crate) use super::isa_x86_table::Mnem;

/// Encoding mode, selected by `.code16` / `.code32` / `.code64`. It fixes the
/// default operand and address sizes the `66` and `67` prefixes select away
/// from, and whether REX (so 64-bit operands, `r8`..`r15`, and RIP-relative
/// addressing) exists at all.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub(crate) enum Mode {
    Bits16,
    Bits32,
    #[default]
    Bits64,
}

impl Mode {
    /// Default operand size in bytes of the `v` width class.
    pub(crate) fn opsize(self) -> u8 {
        match self {
            Mode::Bits16 => 2,
            _ => 4,
        }
    }

    /// Default operand size of the stack and near-branch group, which long
    /// mode promotes to 64-bit.
    pub(crate) fn stack_opsize(self) -> u8 {
        match self {
            Mode::Bits16 => 2,
            Mode::Bits32 => 4,
            Mode::Bits64 => 8,
        }
    }

    /// Default address size in bytes.
    pub(crate) fn addrsize(self) -> u8 {
        match self {
            Mode::Bits16 => 2,
            Mode::Bits32 => 4,
            Mode::Bits64 => 8,
        }
    }
}

/// Operand-size width class of a form's operand slot.
///
/// `V` is 16/32/64 (word/dword/qword) selected by the operation width; `Y` is
/// 32/64; the fixed classes bind one width.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum W {
    B,
    Wd,
    L,
    Q,
    V,
    Y,
}

/// Immediate width/signedness class of an immediate operand slot.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum ImmC {
    /// 8-bit immediate.
    Ib,
    /// 8-bit immediate sign-extended to the operand width (the `83 /r` group);
    /// only matches a value that fits in a signed byte.
    Imms8,
    /// 16-bit immediate.
    Iw,
    /// 32-bit immediate.
    Id,
    /// 64-bit immediate.
    Iq,
    /// Operand-width immediate (16/32/32-sx by width; the `iv` group).
    Iv,
    /// The implicit constant `1` (shift-by-one forms).
    One,
}

/// One operand slot of a form, in Intel order.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum OpPat {
    /// Register supplied through `ModRM.reg`.
    Reg(W),
    /// Register-or-memory (`ModRM.rm`).
    Rm(W),
    /// Memory only (`ModRM.rm` with a memory form).
    Mem(W),
    /// Memory of unspecified size (`clflush`, `prefetch`, the descriptor-table
    /// and save/restore ops): matches a memory operand of any width. Only the
    /// descriptor-table ops read an operand-size-dependent pair
    /// (`m16&16` / `m16&32` / `m16&64`); the rest ignore the width entirely.
    MemAny,
    /// Immediate.
    Imm(ImmC),
    /// A fixed architectural register (`al`/`ax`/`eax`/`rax`, `cl`, `dx`, ...).
    Fixed(u8, W),
    /// A relative code offset immediate of the given byte size.
    Rel(u8),
}

/// Legacy opcode map the primary opcode lives in.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Map {
    Legacy,
    Op0F,
    Op0F38,
    Op0F3A,
}

/// REX.W policy for a form.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum RexW {
    /// Never set (operation is 8/16/32-bit or W is irrelevant).
    W0,
    /// Always set (`REX.W` baked into the opcode string).
    W1,
    /// Set when the operation width is 64-bit.
    ByWidth,
    /// 64-bit is the default operand size in long mode; never set REX.W
    /// (push/pop/call/jmp/leave/ret group).
    Default64,
}

/// Source of the `ModRM.reg` field.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum RegField {
    /// Taken from the operand at this index (a register operand).
    FromOp(u8),
    /// An opcode extension digit (`/0`..`/7`).
    Ext(u8),
    /// No `ModRM.reg` source (a `+r` or nullary form). Named to avoid
    /// colliding with `Option::None` in the glob-imported generated table.
    NoReg,
}

/// One catalogue entry: an operand pattern plus its encoding.
#[derive(Debug, Clone, Copy)]
pub(crate) struct Form {
    /// The mnemonic as an enum, for the native emitter's type-safe, integer
    /// dispatch. `mnemonic` is the same value as a string, for the inline-asm
    /// parser's token lookup and for diagnostics.
    pub mnem: Mnem,
    pub mnemonic: &'static str,
    pub ops: &'static [OpPat],
    /// Mandatory prefix bytes (`F2`/`F3`/mandatory-`66`), in order, emitted
    /// before REX. The operand-size `66` for 16-bit operations is separate and
    /// added by the encoder from the operation width.
    pub pp: &'static [u8],
    pub map: Map,
    /// Fixed opcode bytes after the map. For a `+r` form the register is added
    /// into the last byte. System forms with a fixed ModRM tail (e.g.
    /// `0F 01 F9`) list every byte here and set `reg` to [`RegField::NoReg`].
    pub opcode: &'static [u8],
    pub plus_r: bool,
    pub rexw: RexW,
    pub reg: RegField,
    /// Index of the operand supplying `ModRM.rm` (a register or memory
    /// operand), or `255` when the form has no ModRM r/m.
    pub rm: u8,
    pub imm: Option<ImmC>,
    /// Index of the immediate operand, or `255` when the immediate is implicit
    /// (the `1` of a shift-by-one form).
    pub imm_op: u8,
}

/// A resolved operand handed to [`encode`]. Register numbers are architectural
/// (0..16). Memory is a `disp(%base, %index, scale)` form: `base` holds the
/// address, `disp` is a byte displacement (0 for the bare form), and an optional
/// scaled `index` selects a SIB encoding (`scale` in {1,2,4,8}).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Opnd {
    Reg {
        num: u8,
        width: u8,
    },
    /// A legacy high-byte register `%ah` / `%ch` / `%dh` / `%bh`, held as its
    /// ModRM field value 4..8. The same field values name `spl` / `bpl` /
    /// `sil` / `dil` when a REX prefix is present, so an encoding that needs
    /// one cannot name a high-byte register and is rejected below.
    HighByteReg(u8),
    Mem {
        base: u8,
        index: Option<u8>,
        scale: u8,
        disp: i32,
        width: u8,
    },
    /// RIP-relative memory `disp32(%rip)`: ModRM mod=00 rm=101 in 64-bit mode.
    /// The displacement is the (relocation-patched) offset from the next
    /// instruction.
    RipRel {
        disp: i32,
        width: u8,
    },
    /// Absolute memory `disp32` with no base or index: ModRM mod=00 rm=100,
    /// SIB base=101 index=100 (none). Meaningful under a segment override,
    /// where the displacement is segment-relative.
    AbsMem {
        disp: i32,
        width: u8,
    },
    /// Scaled-index memory with no base register (`disp(,%index,scale)`):
    /// ModRM mod=00 rm=100, SIB base=101 + disp32. The small/kernel code-model
    /// per-CPU form; `disp` is a literal or a relocation-patched symbol offset.
    IndexMem {
        index: u8,
        scale: u8,
        disp: i32,
        width: u8,
    },
    Imm(i64),
}

impl Opnd {
    fn width(self) -> Option<u8> {
        match self {
            Opnd::Reg { width, .. }
            | Opnd::Mem { width, .. }
            | Opnd::RipRel { width, .. }
            | Opnd::AbsMem { width, .. }
            | Opnd::IndexMem { width, .. } => Some(width),
            Opnd::HighByteReg(_) => Some(1),
            Opnd::Imm(_) => None,
        }
    }
}

fn wbytes(w: W, opw: u8) -> Option<u8> {
    match w {
        W::B => Some(1),
        W::Wd => Some(2),
        W::L => Some(4),
        W::Q => Some(8),
        // `v` is word/dword/qword, `y` is dword/qword; neither is a byte.
        W::V => (opw != 1).then_some(opw),
        W::Y => (opw >= 4).then_some(opw),
    }
}

/// Encoded width of an immediate field in bytes, or `None` for the implicit
/// `1` operand, which encodes nothing.
fn imm_field_bytes(c: ImmC, opw: u8) -> Option<u8> {
    Some(match c {
        ImmC::Ib | ImmC::Imms8 => 1,
        ImmC::Iw => 2,
        ImmC::Id => 4,
        ImmC::Iv if opw == 2 => 2,
        ImmC::Iv => 4,
        ImmC::Iq => 8,
        ImmC::One => return None,
    })
}

/// The width class of a form's operand slot as `mode` reads it. The catalogue
/// is generated for long mode, where the stack and near-branch group takes a
/// promoted 64-bit operand size; in every other mode the group follows the
/// mode default, which is the `v` class.
fn eff_w(w: W, rexw: RexW, mode: Mode) -> W {
    if mode != Mode::Bits64 && rexw == RexW::Default64 && w == W::Q {
        W::V
    } else {
        w
    }
}

/// A leading `66` on a legacy-map form is the operand-size prefix selecting
/// the 16-bit member, not a mandatory prefix: the mode decides whether it is
/// emitted. Mandatory `66` only occurs on the escape maps.
fn legacy66(f: &Form) -> bool {
    f.map == Map::Legacy && f.pp.first() == Some(&0x66)
}

/// Whether the operand-size prefix selects the form's operand width even
/// though no slot carries the `v` class. The catalogue pins a width the
/// architecture leaves to that class in three places: an extending move's
/// destination (`movzx r32, r/m16`), a fixed accumulator wider than a byte
/// (`in eax, dx`), and a register-in-opcode group whose members differ only
/// by operand size (`B8+rd mov`, whose immediate width follows it, so the
/// catalogue splits the group into `iw` / `id` / `iq` members). All three
/// name the operation width.
fn pinned_width(f: &Form) -> bool {
    let slot = |p: Option<&OpPat>| match p {
        Some(&(OpPat::Reg(w) | OpPat::Rm(w) | OpPat::Mem(w))) => wbytes(w, 0),
        _ => None,
    };
    let extends = matches!(f.reg, RegField::FromOp(0))
        && f.rm == 1
        && matches!((slot(f.ops.first()), slot(f.ops.get(1))), (Some(a), Some(b)) if a > b);
    extends
        || f.ops
            .iter()
            .any(|p| matches!(p, OpPat::Fixed(0, W::Wd | W::L | W::Q)))
        || (f.plus_r
            && f.ops
                .iter()
                .any(|p| matches!(p, OpPat::Reg(W::Wd | W::L | W::Q))))
}

/// The single width every sized register/memory slot of a form binds, or
/// `None` when it has no such slot, mixes widths (`movsxd r64, r/m32`), or
/// leaves the width to the `v` / `y` class. A `mem` slot of unstated size
/// carries no width and does not take part.
fn uniform_width(f: &Form) -> Option<u8> {
    let mut seen = None;
    for p in f.ops {
        let w = match *p {
            OpPat::Reg(w) | OpPat::Rm(w) | OpPat::Mem(w) => w,
            _ => continue,
        };
        let bytes = match w {
            W::B => 1,
            W::Wd => 2,
            W::L => 4,
            W::Q => 8,
            W::V | W::Y => return None,
        };
        if *seen.get_or_insert(bytes) != bytes {
            return None;
        }
    }
    seen
}

/// Whether two forms share an opcode: same map, opcode bytes, `+r` shape,
/// `ModRM.reg` source and mandatory prefixes. A leading legacy `66` is the
/// operand-size prefix, not a mandatory one, so it is left out of the
/// identity: it is what distinguishes the members being compared.
fn same_opcode(a: &Form, b: &Form) -> bool {
    let mandatory = |f: &Form| if legacy66(f) { &f.pp[1..] } else { f.pp };
    a.map == b.map
        && a.opcode == b.opcode
        && a.plus_r == b.plus_r
        && a.reg == b.reg
        && mandatory(a) == mandatory(b)
}

/// Whether the catalogue spells a `v` width class out member by member under
/// this form's opcode, instead of naming the class (`and r/m16, imm16` /
/// `r/m32, imm32` / `r/m64, imms32`, all `81 /4`). The operand-size prefix
/// still selects between such members, so the form is operand-sized. The
/// 16-bit member marks the class, and carries the prefix in its encoding: a
/// group whose widths are only 32 and 64 is the `y` class, which REX.W alone
/// selects (`ptwrite`), and a 16-bit operand that really is fixed stands
/// under its opcode without the prefix, whatever wider register spellings
/// the catalogue admits beside it (`lldt`, `verr r32`).
fn width_class_spelled_out(f: &Form) -> bool {
    // The prefix selects between the 16- and 32-bit operand sizes; a byte or
    // 64-bit width is not a member of that pair, and rejecting it here keeps
    // the scan off every byte instruction.
    let Some(w @ (2 | 4)) = uniform_width(f) else {
        return false;
    };
    let forms = super::isa_x86_table::FORMS;
    let start = forms.partition_point(|g| g.mnem < f.mnem);
    let group = forms[start..]
        .iter()
        .take_while(|g| g.mnem == f.mnem)
        .chain(FORMS_SUPPLEMENT.iter().filter(|g| g.mnem == f.mnem))
        .filter(|g| same_opcode(f, g));
    let mut widths = 0u32;
    let mut marked = false;
    for g in group {
        if let Some(gw) = uniform_width(g) {
            widths |= 1 << gw;
            marked |= gw == 2 && g.pp.first() == Some(&0x66);
        }
    }
    marked && widths != (1 << w)
}

/// Byte size of a form's relative-offset slot. The near-branch group's
/// displacement follows the operand size, so it is 16-bit outside long mode
/// unless the operand-size prefix selects 32.
fn rel_bytes(sz: u8, f: &Form, opw: u8) -> u8 {
    if sz > 1 && f.rexw == RexW::Default64 {
        opw.min(4)
    } else {
        sz
    }
}

fn pat_matches(p: OpPat, o: Opnd, opw: u8, opw_known: bool) -> bool {
    match (p, o) {
        (OpPat::Reg(w), Opnd::Reg { width, .. }) => wbytes(w, opw) == Some(width),
        (OpPat::Rm(w), Opnd::Reg { width, .. }) => wbytes(w, opw) == Some(width),
        (OpPat::Reg(w) | OpPat::Rm(w), Opnd::HighByteReg(_)) => wbytes(w, opw) == Some(1),
        (OpPat::Rm(w), Opnd::Mem { width, .. }) => wbytes(w, opw) == Some(width),
        (
            OpPat::Rm(w),
            Opnd::RipRel { width, .. } | Opnd::AbsMem { width, .. } | Opnd::IndexMem { width, .. },
        ) => wbytes(w, opw) == Some(width),
        (OpPat::Mem(w), Opnd::Mem { width, .. }) => wbytes(w, opw) == Some(width),
        (
            OpPat::Mem(w),
            Opnd::RipRel { width, .. } | Opnd::AbsMem { width, .. } | Opnd::IndexMem { width, .. },
        ) => wbytes(w, opw) == Some(width),
        (
            OpPat::MemAny,
            Opnd::Mem { .. } | Opnd::RipRel { .. } | Opnd::AbsMem { .. } | Opnd::IndexMem { .. },
        ) => true,
        (OpPat::Fixed(num, w), Opnd::Reg { num: n, width }) => {
            n == num && wbytes(w, opw) == Some(width)
        }
        // An immediate must fit its field as the instruction will read it
        // (byte fields take either signedness; a 32-bit field under a 64-bit
        // operation sign-extends), or a narrow form would win on length and
        // silently truncate the value. A field at least as wide as the
        // operation takes any value: the assembler reduces the expression to
        // the operation width there (`movl $~0xfa1e0ff3, %eax`), so only a
        // field narrower than the operation constrains the choice of form.
        (OpPat::Imm(c), Opnd::Imm(v)) => {
            let fits = match c {
                ImmC::Ib => (-0x80..=0xff).contains(&v),
                ImmC::Imms8 => (-0x80..=0x7f).contains(&v),
                ImmC::Iw => (-0x8000..=0xffff).contains(&v),
                ImmC::Id if opw == 8 => (-0x8000_0000..=0x7fff_ffff).contains(&v),
                ImmC::Id => (-0x8000_0000..=0xffff_ffff).contains(&v),
                ImmC::Iv => match opw {
                    2 => (-0x8000..=0xffff).contains(&v),
                    8 => (-0x8000_0000..=0x7fff_ffff).contains(&v),
                    _ => (-0x8000_0000..=0xffff_ffff).contains(&v),
                },
                ImmC::Iq => true,
                ImmC::One => v == 1,
            };
            fits || (opw_known && imm_field_bytes(c, opw).is_some_and(|f| f >= opw))
        }
        // A relative offset must fit its field, or the short branch form
        // would win with a truncated displacement.
        (OpPat::Rel(sz), Opnd::Imm(v)) => match sz {
            1 => (-0x80..=0x7f).contains(&v),
            2 => (-0x8000..=0x7fff).contains(&v),
            _ => (-0x8000_0000..=0x7fff_ffff).contains(&v),
        },
        _ => false,
    }
}

/// The operation width a form reads from its operands, in bytes, and whether
/// it is established rather than defaulted: an explicit size suffix, else the
/// widest register / memory operand, else the mode default. An operand a
/// `mem` slot of unstated size consumes carries no width, as the slot carries
/// none. An immediate-only instruction (`push $imm`) has neither, and the
/// assembler's default-64 operation width for that group is not modelled, so
/// an out-of-range immediate there stays a diagnostic instead of being
/// reduced.
fn form_width(f: &Form, ops: &[Opnd], override_w: Option<u8>, mode: Mode) -> (u8, bool) {
    if let Some(w) = override_w {
        return (w, true);
    }
    let widest = f
        .ops
        .iter()
        .zip(ops)
        .filter(|(p, _)| !matches!(p, OpPat::MemAny))
        .filter_map(|(_, o)| o.width())
        .max();
    (widest.unwrap_or_else(|| mode.opsize()), widest.is_some())
}

fn rex(w: bool, r: bool, x: bool, b: bool) -> u8 {
    0x40 | ((w as u8) << 3) | ((r as u8) << 2) | ((x as u8) << 1) | (b as u8)
}

fn modrm_reg(reg: u8, rm: u8) -> u8 {
    0xC0 | ((reg & 7) << 3) | (rm & 7)
}

fn emit_modrm_mem(code: &mut InsnBuf, reg: u8, base: u8, index: Option<u8>, scale: u8, disp: i32) {
    let rm = base & 7;
    // A SIB byte is required for a scaled index, and for an rsp/r12 base
    // (rm==100 otherwise means "SIB follows").
    let use_sib = index.is_some() || rm == 4;
    // The mod field selects the displacement size. rbp / r13 (rm==5, including
    // as a SIB base) has no no-displacement form (mod=00 there means RIP or a
    // base-less SIB), so a zero displacement is still encoded as disp8=0.
    let mod_ = if disp == 0 && rm != 5 {
        0
    } else if (-128..=127).contains(&disp) {
        1
    } else {
        2
    };
    if use_sib {
        let scale_bits = match scale {
            2 => 1,
            4 => 2,
            8 => 3,
            _ => 0,
        };
        // index 100 = no index.
        let idx = index.map(|i| i & 7).unwrap_or(4);
        code.push((mod_ << 6) | ((reg & 7) << 3) | 4);
        code.push((scale_bits << 6) | (idx << 3) | rm);
    } else {
        code.push((mod_ << 6) | ((reg & 7) << 3) | rm);
    }
    match mod_ {
        1 => code.push(disp as u8),
        2 => code.extend_from_slice(&disp.to_le_bytes()),
        _ => {}
    }
}

/// ModRM + displacement bytes of a 16-bit address, as `(bytes, length)`.
/// There is no SIB byte: the r/m field names one of the fixed base / index
/// pairs over bx, bp, si and di, and the displacement is 8- or 16-bit.
pub(super) fn modrm_mem16(
    reg: u8,
    base: Option<u8>,
    index: Option<(u8, u8)>,
    disp: i32,
) -> Result<([u8; 3], usize), String> {
    const BX: u8 = 3;
    const BP: u8 = 5;
    const SI: u8 = 6;
    const DI: u8 = 7;
    if index.is_some_and(|(_, scale)| scale != 1) {
        return Err(String::from("inline asm: 16-bit addressing has no scale"));
    }
    let index = index.map(|(i, _)| i);
    let mut out = [0u8; 3];
    // The pair is unordered: `(%bx,%si)` and `(%si,%bx)` name one address.
    let pair = match (base, index) {
        (Some(b), Some(i)) if i == BX || i == BP => (i, b),
        (b, i) => (b.unwrap_or(0), i.unwrap_or(0)),
    };
    let rm = match (base, index, pair) {
        (_, Some(_), (BX, SI)) => 0,
        (_, Some(_), (BX, DI)) => 1,
        (_, Some(_), (BP, SI)) => 2,
        (_, Some(_), (BP, DI)) => 3,
        (Some(SI), None, _) => 4,
        (Some(DI), None, _) => 5,
        (Some(BP), None, _) => 6,
        (Some(BX), None, _) => 7,
        (None, None, _) => {
            // mod=00 rm=110 is the base-less disp16 form.
            out[0] = ((reg & 7) << 3) | 6;
            out[1..3].copy_from_slice(&(disp as u16).to_le_bytes());
            return Ok((out, 3));
        }
        _ => {
            return Err(String::from(
                "inline asm: 16-bit addressing takes only bx / bp with si / di",
            ));
        }
    };
    // rm=110 with mod=00 is the base-less form, so `(%bp)` encodes a disp8 of 0.
    let mod_ = if disp == 0 && rm != 6 {
        0
    } else if (-128..=127).contains(&disp) {
        1
    } else {
        2
    };
    out[0] = (mod_ << 6) | ((reg & 7) << 3) | rm;
    match mod_ {
        1 => {
            out[1] = disp as u8;
            Ok((out, 2))
        }
        2 => {
            out[1..3].copy_from_slice(&(disp as u16).to_le_bytes());
            Ok((out, 3))
        }
        _ => Ok((out, 1)),
    }
}

fn reg_num(o: Opnd) -> u8 {
    match o {
        Opnd::Reg { num, .. } => num,
        Opnd::HighByteReg(num) => num,
        Opnd::Mem { base, .. } => base,
        // RIP-relative / absolute / no-base scaled index have no base
        // register: no REX.B (REX.X for the index is computed separately).
        Opnd::RipRel { .. } | Opnd::AbsMem { .. } | Opnd::IndexMem { .. } | Opnd::Imm(_) => 0,
    }
}

/// A fixed-capacity buffer for one encoded instruction. An x86-64 instruction
/// is at most 15 bytes, so encoding never touches the heap -- the native
/// emitter appends the finished bytes to its output, and shortest-wins compares
/// candidates on the stack.
#[derive(Clone, Copy)]
struct InsnBuf {
    data: [u8; 15],
    len: u8,
}

impl InsnBuf {
    fn new() -> Self {
        InsnBuf {
            data: [0; 15],
            len: 0,
        }
    }
    fn push(&mut self, b: u8) {
        self.data[self.len as usize] = b;
        self.len += 1;
    }
    fn extend_from_slice(&mut self, bs: &[u8]) {
        let n = self.len as usize;
        self.data[n..n + bs.len()].copy_from_slice(bs);
        self.len += bs.len() as u8;
    }
    fn as_slice(&self) -> &[u8] {
        &self.data[..self.len as usize]
    }
}

/// One operand slot of a form as `mode` reads it.
fn mode_pat(p: OpPat, f: &Form, opw: u8, mode: Mode) -> OpPat {
    match p {
        OpPat::Reg(w) => OpPat::Reg(eff_w(w, f.rexw, mode)),
        OpPat::Rm(w) => OpPat::Rm(eff_w(w, f.rexw, mode)),
        OpPat::Mem(w) => OpPat::Mem(eff_w(w, f.rexw, mode)),
        OpPat::Fixed(n, w) => OpPat::Fixed(n, eff_w(w, f.rexw, mode)),
        OpPat::Rel(sz) => OpPat::Rel(rel_bytes(sz, f, opw)),
        // The stack group's imm32 is generated for long mode; its field
        // follows the operand size (`iv`), 16-bit under the 16-bit one.
        OpPat::Imm(ImmC::Id) if f.rexw == RexW::Default64 => OpPat::Imm(ImmC::Iv),
        other => other,
    }
}

fn form_matches(f: &Form, ops: &[Opnd], opw: u8, opw_known: bool, mode: Mode) -> bool {
    f.ops.len() == ops.len()
        && f.ops
            .iter()
            .zip(ops.iter())
            .all(|(&p, &o)| pat_matches(mode_pat(p, f, opw, mode), o, opw, opw_known))
}

impl Mnem {
    /// The mnemonic for a token, or `None`. Used only by the inline-asm parser
    /// (the one place a mnemonic arrives as text); the catalogue is sorted by
    /// name, so this binary-searches.
    pub(crate) fn from_name(name: &str) -> Option<Mnem> {
        let forms = super::isa_x86_table::FORMS;
        let i = forms.partition_point(|f| f.mnemonic < name);
        forms.get(i).filter(|f| f.mnemonic == name).map(|f| f.mnem)
    }
}

/// Operand shapes in AT&T order, for a diagnostic naming what was rejected.
fn describe_operands(ops: &[Opnd]) -> String {
    let mut out = String::new();
    for (i, o) in ops.iter().enumerate() {
        if i > 0 {
            out.push_str(", ");
        }
        match *o {
            Opnd::Reg { num, width } => out.push_str(&format!("r{num}:{width}")),
            Opnd::HighByteReg(num) => out.push_str(&format!("rh{num}:1")),
            Opnd::Mem { width, .. } => out.push_str(&format!("mem:{width}")),
            Opnd::RipRel { width, .. } => out.push_str(&format!("riprel:{width}")),
            Opnd::AbsMem { width, .. } => out.push_str(&format!("absmem:{width}")),
            Opnd::IndexMem { width, .. } => out.push_str(&format!("indexmem:{width}")),
            Opnd::Imm(v) => out.push_str(&format!("imm({v})")),
        }
    }
    out
}

/// Encode one instruction. `width_override` forces the operation width (an
/// AT&T size suffix); otherwise it comes from the operands. Among the forms
/// that match, the shortest encoding is chosen (ties broken by catalogue
/// order), which deterministically reproduces the assembler's preference for
/// the `83 /r` imm8 short form, the accumulator immediate forms, and the like.
pub(crate) fn encode(
    mnem: Mnem,
    width_override: Option<u8>,
    ops: &[Opnd],
) -> Result<Vec<u8>, String> {
    encode_in(
        Mode::Bits64,
        Mode::Bits64.addrsize(),
        mnem,
        width_override,
        ops,
    )
}

/// Encode one instruction in `mode`. `addr` is the address size in bytes the
/// instruction's memory operand is written at; it differs from the mode
/// default exactly when the `67` prefix is required.
pub(crate) fn encode_in(
    mode: Mode,
    addr: u8,
    mnem: Mnem,
    width_override: Option<u8>,
    ops: &[Opnd],
) -> Result<Vec<u8>, String> {
    // Long mode addresses at 64 or 32 bits; the other modes at 32 or 16.
    let ok_addr: [u8; 2] = if mode == Mode::Bits64 { [8, 4] } else { [4, 2] };
    if !ok_addr.contains(&addr) {
        return Err(format!(
            "inline asm: address size {addr} is not encodable in this mode"
        ));
    }
    let (best, matched) = encode_best(mnem, width_override, ops, mode, addr);
    match best {
        Some(b) => Ok(b.as_slice().to_vec()),
        None if matched => Err(format!(
            "inline asm: `{mnem:?}` operand form not encodable ({})",
            describe_operands(ops)
        )),
        None => Err(format!(
            "inline asm: no encoding for `{mnem:?}` with these operands ({})",
            describe_operands(ops)
        )),
    }
}

/// Encode one instruction directly into `code`, no heap allocation. The native
/// emitter's migrated families use this: the operands are always a form the
/// catalogue covers, so a failure is a codegen invariant violation and panics.
pub(crate) fn encode_into(
    code: &mut Vec<u8>,
    mnem: Mnem,
    width_override: Option<u8>,
    ops: &[Opnd],
) {
    let mode = Mode::Bits64;
    match encode_best(mnem, width_override, ops, mode, mode.addrsize()).0 {
        Some(b) => code.extend_from_slice(b.as_slice()),
        None => panic!("native emit: no encoding for `{mnem:?}` with these operands"),
    }
}

/// The shortest encoding of `mnem` for `ops`, plus whether any form matched (to
/// distinguish "no such form" from "form matched but not encodable"). The
/// catalogue is sorted by mnemonic and `Mnem`'s Ord matches that order, so this
/// binary-searches on the integer discriminant to the mnemonic's run of forms.
///
/// Forms of equal length are ranked by immediate field width, which is how
/// GNU as orders its own templates: a 16-bit operand against the accumulator
/// encodes `add $1, %ax` as either `05 iw` or `83 /0 ib`, both three bytes,
/// and the sign-extended byte form is the one it picks.
fn encode_best(
    mnem: Mnem,
    width_override: Option<u8>,
    ops: &[Opnd],
    mode: Mode,
    addr: u8,
) -> (Option<InsnBuf>, bool) {
    let forms = super::isa_x86_table::FORMS;
    let start = forms.partition_point(|f| f.mnem < mnem);
    let mut best: Option<(InsnBuf, u8)> = None;
    let mut matched = false;
    let generated = forms[start..].iter().take_while(|f| f.mnem == mnem);
    let supplemental = FORMS_SUPPLEMENT.iter().filter(|f| f.mnem == mnem);
    for f in generated.chain(supplemental) {
        let (opw, opw_known) = form_width(f, ops, width_override, mode);
        if !form_matches(f, ops, opw, opw_known, mode) {
            continue;
        }
        matched = true;
        let imm = f.imm.and_then(|c| imm_field_bytes(c, opw)).unwrap_or(0);
        if let Ok(buf) = encode_form(f, ops, opw, opw_known, mode, addr)
            && best.is_none_or(|(b, bi)| (buf.len, imm) < (b.len, bi))
        {
            best = Some((buf, imm));
        }
    }
    (best.map(|(b, _)| b), matched)
}

/// Forms the external instruction database omits, encoded by the same
/// interpreter as the generated catalogue. `inc` / `dec` on a 16- or 32-bit
/// register have a one-byte `+r` encoding outside 64-bit mode, where those
/// opcodes are the REX prefix instead; the database carries only the
/// mode-independent `FF /0` and `FF /1`. The segment-descriptor loads
/// `lsl` / `lar` take a 16-bit source but the destination may be 32-bit; the
/// generator's uniform-width `r/m` model drops those mixed-width forms. The
/// source is `r/m16` regardless of whether the assembler wrote a 16- or
/// 32-bit register (both `lar %di,%eax` and `lar %edi,%eax` encode `0F 02 C7`);
/// the `r32,r/m32` and `r32,r/m16` forms are both supplemented so a
/// 16- or 32-bit source register or `m16` memory operand matches. A 64-bit
/// destination does not occur. The AMD SVM ops `vmload` / `vmsave` / `vmrun`
/// address the VMCB through an implicit `rax`; the database lists only the
/// operandless spelling, so the explicit-`%rax` form the compilers emit
/// (`vmsave %rax`) is supplemented, encoding identically since `rax` is not
/// named in the opcode. `invlpga` is the two-operand member of the same class:
/// the address rides an implicit `rax` and the ASID an implicit `ecx`, so the
/// compilers emit `invlpga %rax, %ecx` (Intel-ordered `ecx, rax` here); like
/// `vmsave` the registers are not named in the opcode. The descriptor-table
/// and machine-status ops `verr` / `verw` / `lldt` / `ltr` / `sldt` / `str` /
/// `smsw` / `lmsw` address a 16-bit field in memory whatever width the operand
/// was written with, and the memory forms take no operand-size prefix, so each
/// takes a prefixless `MemAny` form beside the register ones. The three that
/// store into a register (`sldt`, `str`, `smsw`) also write a 32-bit
/// destination, which is the same encoding without the 0x66 the generated
/// 16-bit form carries. `lea` computes an address at every operand size, but
/// the generator reads its unsized `mem` operand as carrying no width and
/// drops the 16-bit destination row, leaving the group without the member
/// that marks it a width class; the supplement spells it with the `66` a
/// 16-bit-only legacy row carries. The stack-adjusting returns `ret imm16` (C2) and
/// `retf imm16` (CA) are absent from the generated catalogue; the immediate
/// is 16-bit at every operand size, so each is one form.
static FORMS_SUPPLEMENT: &[Form] = &[
    Form {
        mnem: Mnem::Ret,
        mnemonic: "ret",
        ops: &[OpPat::Imm(ImmC::Iw)],
        pp: &[],
        map: Map::Legacy,
        opcode: &[0xC2],
        plus_r: false,
        rexw: RexW::Default64,
        reg: RegField::NoReg,
        rm: 255,
        imm: Some(ImmC::Iw),
        imm_op: 0,
    },
    Form {
        mnem: Mnem::Retf,
        mnemonic: "retf",
        ops: &[OpPat::Imm(ImmC::Iw)],
        pp: &[],
        map: Map::Legacy,
        opcode: &[0xCA],
        plus_r: false,
        rexw: RexW::Default64,
        reg: RegField::NoReg,
        rm: 255,
        imm: Some(ImmC::Iw),
        imm_op: 0,
    },
    Form {
        mnem: Mnem::Inc,
        mnemonic: "inc",
        ops: &[OpPat::Reg(W::V)],
        pp: &[],
        map: Map::Legacy,
        opcode: &[0x40],
        plus_r: true,
        rexw: RexW::W0,
        reg: RegField::NoReg,
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Lea,
        mnemonic: "lea",
        ops: &[OpPat::Reg(W::Wd), OpPat::MemAny],
        pp: &[0x66],
        map: Map::Legacy,
        opcode: &[0x8D],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::FromOp(0),
        rm: 1,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Dec,
        mnemonic: "dec",
        ops: &[OpPat::Reg(W::V)],
        pp: &[],
        map: Map::Legacy,
        opcode: &[0x48],
        plus_r: true,
        rexw: RexW::W0,
        reg: RegField::NoReg,
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Lsl,
        mnemonic: "lsl",
        ops: &[OpPat::Reg(W::Q), OpPat::Rm(W::Q)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x03],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::FromOp(0),
        rm: 1,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Lsl,
        mnemonic: "lsl",
        ops: &[OpPat::Reg(W::Q), OpPat::Rm(W::Wd)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x03],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::FromOp(0),
        rm: 1,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Lar,
        mnemonic: "lar",
        ops: &[OpPat::Reg(W::Q), OpPat::Rm(W::Q)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x02],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::FromOp(0),
        rm: 1,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Lar,
        mnemonic: "lar",
        ops: &[OpPat::Reg(W::Q), OpPat::Rm(W::Wd)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x02],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::FromOp(0),
        rm: 1,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Verr,
        mnemonic: "verr",
        ops: &[OpPat::MemAny],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x00],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(4),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Verr,
        mnemonic: "verr",
        ops: &[OpPat::Rm(W::L)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x00],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(4),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Verr,
        mnemonic: "verr",
        ops: &[OpPat::Rm(W::Q)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x00],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(4),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Verw,
        mnemonic: "verw",
        ops: &[OpPat::MemAny],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x00],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(5),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Verw,
        mnemonic: "verw",
        ops: &[OpPat::Rm(W::L)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x00],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(5),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Verw,
        mnemonic: "verw",
        ops: &[OpPat::Rm(W::Q)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x00],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(5),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Lldt,
        mnemonic: "lldt",
        ops: &[OpPat::MemAny],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x00],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(2),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Ltr,
        mnemonic: "ltr",
        ops: &[OpPat::MemAny],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x00],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(3),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Sldt,
        mnemonic: "sldt",
        ops: &[OpPat::MemAny],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x00],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(0),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Sldt,
        mnemonic: "sldt",
        ops: &[OpPat::Rm(W::L)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x00],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(0),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Str,
        mnemonic: "str",
        ops: &[OpPat::MemAny],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x00],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(1),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Str,
        mnemonic: "str",
        ops: &[OpPat::Rm(W::L)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x00],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(1),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Smsw,
        mnemonic: "smsw",
        ops: &[OpPat::MemAny],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x01],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(4),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Smsw,
        mnemonic: "smsw",
        ops: &[OpPat::Rm(W::L)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x01],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(4),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Lmsw,
        mnemonic: "lmsw",
        ops: &[OpPat::MemAny],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x01],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::Ext(6),
        rm: 0,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Ud0,
        mnemonic: "ud0",
        ops: &[],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0xFF],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::NoReg,
        rm: 255,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Ud0,
        mnemonic: "ud0",
        ops: &[OpPat::Reg(W::V), OpPat::Rm(W::V)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0xFF],
        plus_r: false,
        rexw: RexW::ByWidth,
        reg: RegField::FromOp(0),
        rm: 1,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Ud1,
        mnemonic: "ud1",
        ops: &[],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0xB9],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::NoReg,
        rm: 255,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Ud1,
        mnemonic: "ud1",
        ops: &[OpPat::Reg(W::V), OpPat::Rm(W::V)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0xB9],
        plus_r: false,
        rexw: RexW::ByWidth,
        reg: RegField::FromOp(0),
        rm: 1,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Lsl,
        mnemonic: "lsl",
        ops: &[OpPat::Reg(W::L), OpPat::Rm(W::L)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x03],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::FromOp(0),
        rm: 1,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Lsl,
        mnemonic: "lsl",
        ops: &[OpPat::Reg(W::L), OpPat::Rm(W::Wd)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x03],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::FromOp(0),
        rm: 1,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Lar,
        mnemonic: "lar",
        ops: &[OpPat::Reg(W::L), OpPat::Rm(W::L)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x02],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::FromOp(0),
        rm: 1,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Lar,
        mnemonic: "lar",
        ops: &[OpPat::Reg(W::L), OpPat::Rm(W::Wd)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x02],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::FromOp(0),
        rm: 1,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Vmload,
        mnemonic: "vmload",
        ops: &[OpPat::Fixed(0, W::Q)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x01, 0xDA],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::NoReg,
        rm: 255,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Vmsave,
        mnemonic: "vmsave",
        ops: &[OpPat::Fixed(0, W::Q)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x01, 0xDB],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::NoReg,
        rm: 255,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Vmrun,
        mnemonic: "vmrun",
        ops: &[OpPat::Fixed(0, W::Q)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x01, 0xD8],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::NoReg,
        rm: 255,
        imm: None,
        imm_op: 255,
    },
    Form {
        mnem: Mnem::Invlpga,
        mnemonic: "invlpga",
        ops: &[OpPat::Fixed(1, W::L), OpPat::Fixed(0, W::Q)],
        pp: &[],
        map: Map::Op0F,
        opcode: &[0x01, 0xDF],
        plus_r: false,
        rexw: RexW::W0,
        reg: RegField::NoReg,
        rm: 255,
        imm: None,
        imm_op: 255,
    },
];

fn encode_form(
    f: &Form,
    ops: &[Opnd],
    opw: u8,
    opw_known: bool,
    mode: Mode,
    addr: u8,
) -> Result<InsnBuf, String> {
    let mut code = InsnBuf::new();
    // Opcodes 0x40..0x4F are the REX prefix in long mode, so a legacy `+r`
    // form based there encodes only in 16- and 32-bit modes.
    if mode == Mode::Bits64
        && f.map == Map::Legacy
        && f.plus_r
        && matches!(f.opcode, [op] if (0x40..0x50).contains(op))
    {
        return Err(String::from(
            "inline asm: the one-byte `inc`/`dec` form is a REX prefix in 64-bit mode",
        ));
    }
    // Address-size prefix: `67` selects the non-default address size. A form
    // with no memory r/m operand addresses nothing and takes none.
    let rm_op = (f.rm != 255).then(|| ops[f.rm as usize]);
    let mem_rm = matches!(
        rm_op,
        Some(Opnd::Mem { .. } | Opnd::AbsMem { .. } | Opnd::IndexMem { .. })
    );
    if mem_rm && addr != mode.addrsize() {
        code.push(0x67);
    }
    // Operand-size prefix: `66` selects the width class member that is not the
    // mode default. A form whose widths are all fixed (lldt r16/m16, in al/dx)
    // has its operand size baked into the opcode and takes no prefix, unless
    // the catalogue spells the same opcode at another width; a legacy-map form
    // carrying `66` in `pp` is the 16-bit member of such a class, so the
    // prefix comes from this rule instead of from `pp`.
    let pp66 = legacy66(f);
    let has_v = f.ops.iter().any(|&p| {
        matches!(
            mode_pat(p, f, opw, mode),
            OpPat::Reg(W::V) | OpPat::Rm(W::V) | OpPat::Mem(W::V) | OpPat::Fixed(_, W::V)
        )
    });
    let fopw = if pp66 { 2 } else { opw };
    let dflt = if f.rexw == RexW::Default64 {
        mode.stack_opsize()
    } else {
        mode.opsize()
    };
    // The stack / near-branch group encodes 16- and 64-bit operands in long
    // mode and 16- and 32-bit ones elsewhere.
    if f.rexw == RexW::Default64 && opw_known && opw == (if mode == Mode::Bits64 { 4 } else { 8 }) {
        return Err(format!(
            "inline asm: operand size {opw} is not encodable for this group in this mode"
        ));
    }
    // An operandless form, and a descriptor-table op, take their width from
    // the mnemonic's size suffix (`retl` and `lgdtl` in a `.code16` stub);
    // with no suffix it is the mode default, which the 64-bit exclusion below
    // leaves unprefixed.
    let desc_table = matches!(f.mnem, Mnem::Lgdt | Mnem::Lidt | Mnem::Sgdt | Mnem::Sidt);
    // The prefix applies only when the operation width differs from the mode
    // default and is not 64-bit, which REX.W selects; the catalogue scan sits
    // behind that so it stays off the path every other instruction takes.
    let selects = fopw != dflt && fopw != 8;
    // A stack-group form with an established width is operand-sized even when
    // no slot carries the `v` class (`push imm8`).
    let sized = has_v
        || pp66
        || desc_table
        || pinned_width(f)
        || (opw_known && (f.ops.is_empty() || f.rexw == RexW::Default64))
        || (selects && width_class_spelled_out(f));
    if sized && selects {
        code.push(0x66);
    }
    code.extend_from_slice(if pp66 { &f.pp[1..] } else { f.pp });

    // Resolve the reg-field operand.
    let reg_op = match f.reg {
        RegField::FromOp(i) => Some(ops[i as usize]),
        _ => None,
    };

    // `xchg eax, eax` must not take the 90+r accumulator short form: 0x90
    // decodes as NOP and skips the 32-bit zero-extension a real exchange
    // performs. The 16/64-bit self-exchanges are architectural no-ops
    // either way and keep the short form; the 64-bit one is the bare `90`,
    // since REX.W selects nothing there and both assemblers omit it.
    let self_xchg =
        f.plus_r && *f.opcode == [0x90] && matches!(rm_op, Some(Opnd::Reg { num: 0, .. }));
    if self_xchg && opw == 4 {
        return Err(String::from(
            "inline asm: xchg eax, eax is not the 90+r form",
        ));
    }

    // REX computation.
    let w = match f.rexw {
        RexW::W0 | RexW::Default64 => false,
        RexW::W1 => !self_xchg,
        RexW::ByWidth => opw == 8,
    };
    let reg_hi = reg_op.map(|o| reg_num(o) >= 8).unwrap_or(false);
    let rm_hi = rm_op.map(|o| reg_num(o) >= 8).unwrap_or(false);
    // REX.X extends a SIB index register.
    let index_hi = matches!(rm_op, Some(Opnd::Mem { index: Some(i), .. }) if i >= 8)
        || matches!(rm_op, Some(Opnd::IndexMem { index, .. }) if index >= 8);
    // A byte register spl/bpl/sil/dil (4..8) needs a REX to be named at all,
    // otherwise those encodings mean ah/ch/dh/bh. The requirement is a
    // property of the operand, not of the operation width: movsx/movzx mix a
    // byte source with a wider destination, so `opw` is not 1 there.
    let byte_reg =
        |o: Option<Opnd>| matches!(o, Some(Opnd::Reg { num, width: 1 }) if (4..8).contains(&num));
    let byte_rex = byte_reg(reg_op) || byte_reg(rm_op);
    let high_byte = |o: Option<Opnd>| matches!(o, Some(Opnd::HighByteReg(_)));
    if w || reg_hi || rm_hi || index_hi || byte_rex {
        if high_byte(reg_op) || high_byte(rm_op) {
            return Err(String::from(
                "inline asm: `%ah`/`%ch`/`%dh`/`%bh` has no encoding under a REX prefix",
            ));
        }
        // REX exists only in long mode, so a 64-bit operand, an `r8`..`r15`
        // register, and the uniform byte registers have no encoding elsewhere.
        if mode != Mode::Bits64 {
            return Err(String::from(
                "inline asm: form needs a REX prefix, which 16- and 32-bit modes have not",
            ));
        }
        code.push(rex(w, reg_hi, index_hi, rm_hi));
    }

    // Opcode map + opcode bytes.
    match f.map {
        Map::Legacy => {}
        Map::Op0F => code.push(0x0F),
        Map::Op0F38 => code.extend_from_slice(&[0x0F, 0x38]),
        Map::Op0F3A => code.extend_from_slice(&[0x0F, 0x3A]),
    }
    let (last, head) = f.opcode.split_last().expect("form opcode non-empty");
    code.extend_from_slice(head);
    if f.plus_r {
        let r = rm_op.map(reg_num).unwrap_or(0);
        code.push(last + (r & 7));
    } else {
        code.push(*last);
    }

    // ModRM (+ SIB / disp).
    let regfield = match f.reg {
        RegField::FromOp(i) => reg_num(ops[i as usize]) & 7,
        RegField::Ext(d) => d,
        RegField::NoReg => 0,
    };
    // A `+r` form embeds its register in the opcode and has no ModRM byte.
    if !f.plus_r && (f.reg != RegField::NoReg || f.rm != 255) {
        match rm_op {
            Some(Opnd::Reg { num, .. }) | Some(Opnd::HighByteReg(num)) => {
                code.push(modrm_reg(regfield, num))
            }
            Some(Opnd::Mem {
                base,
                index,
                scale,
                disp,
                ..
            }) if addr == 2 => {
                let (bytes, n) =
                    modrm_mem16(regfield, Some(base), index.map(|i| (i, scale)), disp)?;
                code.extend_from_slice(&bytes[..n]);
            }
            Some(Opnd::Mem {
                base,
                index,
                scale,
                disp,
                ..
            }) => emit_modrm_mem(&mut code, regfield, base, index, scale, disp),
            Some(Opnd::RipRel { disp, .. }) => {
                if mode != Mode::Bits64 {
                    return Err(String::from(
                        "inline asm: RIP-relative addressing exists only in 64-bit mode",
                    ));
                }
                // mod=00 rm=101: RIP-relative, disp32 follows.
                code.push(((regfield & 7) << 3) | 5);
                code.extend_from_slice(&disp.to_le_bytes());
            }
            Some(Opnd::AbsMem { disp, .. }) if addr == 2 => {
                let (bytes, n) = modrm_mem16(regfield, None, None, disp)?;
                code.extend_from_slice(&bytes[..n]);
            }
            Some(Opnd::AbsMem { disp, .. }) if mode != Mode::Bits64 => {
                // mod=00 rm=101 is the plain disp32 form; only long mode reads
                // it as RIP-relative and needs the base-less SIB instead.
                code.push(((regfield & 7) << 3) | 5);
                code.extend_from_slice(&disp.to_le_bytes());
            }
            Some(Opnd::AbsMem { disp, .. }) => {
                // mod=00 rm=100, SIB base=101 index=100: absolute disp32.
                code.push(((regfield & 7) << 3) | 4);
                code.push(0x25);
                code.extend_from_slice(&disp.to_le_bytes());
            }
            Some(Opnd::IndexMem {
                index, scale, disp, ..
            }) => {
                // mod=00 rm=100, SIB base=101 (no base) + disp32, scaled index.
                let scale_bits = match scale {
                    2 => 1,
                    4 => 2,
                    8 => 3,
                    _ => 0,
                };
                code.push(((regfield & 7) << 3) | 4);
                code.push((scale_bits << 6) | ((index & 7) << 3) | 5);
                code.extend_from_slice(&disp.to_le_bytes());
            }
            _ => return Err(String::from("inline asm: form needs an r/m operand")),
        }
    }

    // Immediate. The stack group's imm32 field follows the operand size, as
    // in `mode_pat`.
    if let Some(c) = f.imm {
        let c = if f.rexw == RexW::Default64 && c == ImmC::Id {
            ImmC::Iv
        } else {
            c
        };
        let val = if f.imm_op == 255 {
            1
        } else {
            match ops[f.imm_op as usize] {
                Opnd::Imm(v) => v,
                _ => return Err(String::from("inline asm: immediate operand expected")),
            }
        };
        // A relative offset's field is as wide as the branch displacement, not
        // as the immediate class the catalogue names for long mode.
        match f.ops.first() {
            Some(&OpPat::Rel(sz)) if f.ops.len() == 1 => {
                let n = rel_bytes(sz, f, fopw);
                code.extend_from_slice(&val.to_le_bytes()[..n as usize]);
            }
            _ => emit_imm(&mut code, c, val, opw),
        }
    }
    Ok(code)
}

fn emit_imm(code: &mut InsnBuf, c: ImmC, v: i64, opw: u8) {
    match c {
        ImmC::Ib | ImmC::Imms8 => code.push(v as u8),
        ImmC::Iw => code.extend_from_slice(&(v as u16).to_le_bytes()),
        ImmC::Id => code.extend_from_slice(&(v as u32).to_le_bytes()),
        ImmC::Iq => code.extend_from_slice(&(v as u64).to_le_bytes()),
        ImmC::Iv => {
            if opw == 2 {
                code.extend_from_slice(&(v as u16).to_le_bytes());
            } else {
                code.extend_from_slice(&(v as u32).to_le_bytes());
            }
        }
        ImmC::One => {}
    }
}

#[cfg(test)]
mod tests;
