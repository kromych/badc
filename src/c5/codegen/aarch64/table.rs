//! Table-driven AArch64 (A64) encoder.
//!
//! Every A64 instruction is one 32-bit little-endian word: a fixed base with
//! named bit-fields spliced in. The catalogue in [`super::isa_a64_table`] is
//! generated from an external instruction-set database (see
//! `tools/gen_isa_a64.py`) as a base word plus a field list; this module packs
//! concrete operand values into those fields. Some fields need a computed
//! encoding rather than a raw value -- the logical-immediate bitmask, the
//! move-wide `hw` shift -- which the field kind selects.
//!
//! Register numbers are architectural (0..31, 31 = xzr/sp per context). The
//! `sf` bit (W vs X) is baked into the two separate catalogue rows.

#![allow(dead_code)] // Catalogue breadth runs ahead of lowering coverage.

use alloc::format;
use alloc::string::String;

/// A field of a form: where a value lands in the 32-bit word and how the
/// operand that feeds it is encoded.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Field {
    /// A register spliced at bit `shift`, fed by the operand at index `op`.
    /// The value is a plain register's number or a memory operand's base
    /// register; the operand widths (`sf`) are baked into the base word.
    Reg { op: u8, shift: u8 },
    /// A raw unsigned immediate: `shift` = low bit, `width` = bit count. Fed by
    /// the operand at `op` (index into the instruction's operand list).
    UImm { op: u8, shift: u8, width: u8 },
    /// The add/sub-immediate value group: the 12-bit field at bit 10 plus the
    /// `sh` bit at 22 selecting a left shift of 12. An optional `lsl #0|#12` at
    /// `shift_op` fixes the shift; without one it comes from the value.
    AddSubImm { op: u8, shift_op: u8 },
    /// A two's-complement signed immediate: `shift` = low bit, `width` = bit
    /// count. Fed by the operand at `op` -- either a plain immediate (`smax`
    /// imm8) or a memory reference's offset (`ldur`/`ldtr` unscaled imm9).
    SImm { op: u8, shift: u8, width: u8 },
    /// A scaled unsigned immediate offset: the written byte offset must be a
    /// non-negative multiple of `scale`, and the `width`-bit field at `shift`
    /// holds offset/scale (the `ldrh` #imm*2, `ldrsw` #imm*4 loads/stores).
    ScaledUImm {
        op: u8,
        shift: u8,
        width: u8,
        scale: u16,
    },
    /// A scaled two's-complement immediate offset: the written byte offset
    /// must be a multiple of `scale`, and the signed `width`-bit field at
    /// `shift` holds offset/scale (the `ldp`/`stp` imm7 pair offsets).
    ScaledSImm {
        op: u8,
        shift: u8,
        width: u8,
        scale: u16,
    },
    /// The index-register group of a register-offset memory operand: Rm at
    /// bit 16, the extend option at 13, and the S bit at 12. A written shift
    /// must be the access-size log2 `sl2` (S = 1) or 0 (S = 0; for a byte
    /// access `lsl #0` written out is the S = 1 form, as the assembler
    /// encodes it). The base register is a separate `Reg` field.
    MemRegIdx { op: u8, sl2: u8 },
    /// The 13-bit logical-immediate bitmask field (`N:immr:imms` at bit 10),
    /// computed from the operand value. `is64` selects the 64/32-bit element.
    LogicalImm { op: u8, is64: bool },
    /// Like [`Field::LogicalImm`] but encoding the bitwise complement of the
    /// operand value at the `is64` element width. The `bic`/`bics` immediate
    /// aliases assemble as `and`/`ands` with the inverted bitmask.
    LogicalImmNot { op: u8, is64: bool },
    /// Move-wide 16-bit immediate at bit 5.
    MovImm { op: u8 },
    /// Move-wide `hw` shift-amount/16 at bit 21, from an optional `lsl #s`
    /// operand (absent = 0).
    MovHw { op: u8 },
    /// Left-shift amount for a `lsl #n` alias encoded through `ubfm`/`ubfm`:
    /// `immr = (-n) mod width` at bit 16, `imms = width-1-n` at bit 10.
    LslAlias { op: u8, is64: bool },
    /// Logical/arithmetic right-shift `#n` for the `lsr`/`asr` aliases: `immr`
    /// at bit 16 (imms is baked in the base word).
    ShrAlias { op: u8 },
    /// 4-bit condition code at bit 12, fed by the operand at `op`. `inv` stores
    /// the inverted condition for the aliases whose written condition flips
    /// (`cset`/`csetm`); al/nv have no inversion and are rejected there.
    Cond { op: u8, inv: bool },
    /// The shifted-register group: the 2-bit shift kind at bit 22 and the
    /// 6-bit amount at bit 10, fed by an optional trailing operand (absent =
    /// LSL #0). `is64` bounds the amount (0..63 vs 0..31); `ror` admits the
    /// fourth kind, which the arithmetic forms reserve.
    Shift { op: u8, is64: bool, ror: bool },
    /// The extended-register group: the 3-bit extend option at bit 13 and the
    /// 3-bit amount at bit 10, fed by an optional trailing operand (absent =
    /// UXTX #0 at 64 bits, UXTW #0 at 32). The option also fixes the width of
    /// the extended register at slot `rm`.
    Extend { op: u8, rm: u8, is64: bool },
}

/// One catalogue entry: a base word and the fields spliced into it.
#[derive(Debug, Clone, Copy)]
pub(crate) struct Form {
    pub mnemonic: &'static str,
    /// Operand shapes this form accepts, in written order.
    pub ops: &'static [A64Op],
    pub base: u32,
    /// Bitmask of operand slots whose register field reads 31 as the stack
    /// pointer. Register 31 is the zero register in every other slot, so a
    /// written `sp` there does not name this form.
    pub sp: u8,
    pub fields: &'static [Field],
}

/// Operand-shape a form slot accepts.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum A64Op {
    /// A 64-bit `X` register.
    X,
    /// A 32-bit `W` register.
    W,
    /// A register of either width: the extended-register second source, whose
    /// width the written extend selects.
    RegAny,
    /// An immediate.
    Imm,
    /// An optional `lsl #s` shift (move-wide / add-sub-imm); absent = 0.
    OptLsl,
    /// An optional shifted-register `<lsl|lsr|asr|ror> #n` group; absent = 0.
    OptShift,
    /// An optional extended-register `<extend> {#n}` group; absent = the
    /// width's identity extend.
    OptExt,
    /// A condition code.
    Cond,
    /// A base-register memory reference `[Xn|SP]`, with or without an
    /// immediate offset.
    Mem,
    /// A pre-index writeback memory reference `[Xn|SP, #off]!`.
    MemPre,
    /// A register-offset memory reference `[Xn|SP, Rm{, <ext> #s}]`.
    MemReg,
}

/// A resolved operand handed to [`encode`].
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Opnd {
    /// Register: `num` 0..31, `is64` selects X vs W. `sp` records that
    /// register 31 was written as `sp`/`wsp` rather than `xzr`/`wzr`; the two
    /// spellings share the field value and differ only by form.
    Reg {
        num: u8,
        is64: bool,
        sp: bool,
    },
    /// `Xn!`: a 64-bit register the instruction writes back, as the memory
    /// copy/set family spells its size and pointer operands.
    RegWb(u8),
    /// SIMD/FP register: `num` 0..31, `is_d` selects the D (64) vs S (32) view.
    VReg {
        num: u8,
        is_d: bool,
    },
    /// The 128-bit `qN` view of a SIMD register, used by the vector load/store
    /// forms (`ldr`/`str qN`).
    QReg(u8),
    /// A byte/half scalar-SIMD view `bN`/`hN` (`size` 0 or 1). The word/dword
    /// views `sN`/`dN` are `VReg`; together they name the scalar destination of
    /// the across-lane reductions.
    VScalar {
        num: u8,
        size: u8,
    },
    /// SIMD vector-arrangement register view `vN.T`: `size` is the element-size
    /// log2 (byte 0 .. dword 3), `q` selects the 128- vs 64-bit register.
    VecReg {
        num: u8,
        size: u8,
        q: bool,
    },
    /// A single SIMD element `vN.T[index]`: `size` is the element-size log2,
    /// `index` the lane. Used by the lane-transfer forms (umov/smov/ins).
    VecElem {
        num: u8,
        size: u8,
        index: u8,
    },
    /// A SIMD register list `{v0.T, ..}` of `count` consecutive registers (1..4)
    /// starting at `first`, all of one arrangement. Used by ld1..ld4/st1..st4.
    VecList {
        first: u8,
        count: u8,
        size: u8,
        q: bool,
    },
    Imm(i64),
    /// A floating-point immediate as its 8-bit VFP encoding (`fmov Vd, #imm`).
    FpImm(u8),
    /// An `lsl #shift` modifier operand. In a shifted-register group it is the
    /// LSL kind; in an extended-register one, the width's identity extend.
    Lsl(u32),
    /// A shifted-register `<lsr|asr|ror> #amount` modifier (`kind` 1..3; LSL
    /// arrives as [`Opnd::Lsl`], which the extended forms also accept).
    Shift {
        kind: u8,
        amount: u8,
    },
    /// An extended-register `<extend> {#amount}` modifier; `option` is the
    /// 3-bit extend selector (UXTB 0 .. UXTX 3, SXTB 4 .. SXTX 7).
    Extend {
        option: u8,
        amount: u8,
    },
    /// A system register, as its 16-bit `mrs`/`msr` field
    /// (`op0<<14 | op1<<11 | CRn<<7 | CRm<<3 | op2`).
    SysReg(u16),
    /// A `dc`/`ic`/`tlbi`/`at`/`sys` system-operation base word (Rt field left
    /// zero); the encoder ORs in the register operand or xzr.
    SysOp(u32),
    /// A memory reference `[base, #off]` (`off` in bytes, signed); the form's
    /// offset field decides the scaling and range.
    Mem {
        base: u8,
        off: i64,
        /// Pre-index writeback (`[base, #off]!`); the offset forms leave it
        /// false.
        pre: bool,
    },
    /// A register-offset memory reference `[base, Rm, <option> {#shift}]`. The
    /// `option` is the 3-bit extend selector (UXTW 2, LSL/UXTX 3, SXTW 6,
    /// SXTX 7); `shift` is the written scale amount, `None` when absent.
    MemReg {
        base: u8,
        index: u8,
        option: u8,
        shift: Option<u8>,
    },
    /// A 4-bit condition code for the conditional-select forms.
    Cond(u8),
}

/// AArch64 logical-immediate (bitmask) encoder. Returns the 13-bit field
/// `N<<12 | immr<<6 | imms` (instruction bits [22:10]), or `None` if the value
/// is not a representable bitmask. A bitmask immediate is a rotated run of ones
/// inside an element of `esize` in {2,4,8,16,32,64} replicated across the
/// register; the all-zero and all-ones patterns are not encodable.
pub(crate) fn encode_logical_imm(value: u64, is64: bool) -> Option<u32> {
    let size: u32 = if is64 { 64 } else { 32 };
    let value = if is64 { value } else { value & 0xFFFF_FFFF };
    if !is64 && (value >> 32) != 0 {
        return None;
    }
    let size_mask = if size == 64 {
        u64::MAX
    } else {
        (1u64 << size) - 1
    };
    if value == 0 || value == size_mask {
        return None;
    }
    // Element size: halve while both halves are equal.
    let mut esize = size;
    while esize > 2 {
        let h = esize >> 1;
        let m = (1u64 << h) - 1;
        if (value & m) != ((value >> h) & m) {
            break;
        }
        esize = h;
    }
    let emask = if esize == 64 {
        u64::MAX
    } else {
        (1u64 << esize) - 1
    };
    let elem = value & emask;

    let ctz = |x: u64| x.trailing_zeros();
    let cto = |x: u64| x.trailing_ones();
    let is_shifted_mask = |x: u64| -> bool {
        if x == 0 {
            return false;
        }
        let y = x >> ctz(x);
        (y & y.wrapping_add(1)) == 0
    };

    let (i, run): (u32, u32);
    if is_shifted_mask(elem) {
        i = ctz(elem);
        run = cto(elem >> i);
    } else {
        // The ones-run wraps the element boundary: the complement, widened to
        // 64 bits with ones above the element, must be a single run.
        let widened = elem | (!emask);
        if !is_shifted_mask(!widened) {
            return None;
        }
        let lead = widened.leading_ones();
        i = 64 - lead;
        run = lead + cto(widened) - (64 - esize);
    }
    let immr = (esize.wrapping_sub(i)) & (esize - 1);
    let nimms = ((!(esize - 1) << 1) | (run - 1)) & 0x7F;
    let n = ((nimms >> 6) & 1) ^ 1;
    Some((n << 12) | (immr << 6) | (nimms & 0x3F))
}

fn reg(o: Opnd) -> Result<u8, String> {
    match o {
        Opnd::Reg { num, .. } => Ok(num),
        // A memory reference contributes its base register (the Rn field).
        Opnd::Mem { base, .. } | Opnd::MemReg { base, .. } => Ok(base),
        _ => Err(String::from("inline asm: register operand expected")),
    }
}

fn imm(o: Opnd) -> Result<i64, String> {
    match o {
        Opnd::Imm(v) => Ok(v),
        _ => Err(String::from("inline asm: immediate operand expected")),
    }
}

/// An immediate field's value: a plain immediate, or a memory reference's
/// offset (the imm9/imm12 offset of the load-store forms). Used by the raw
/// unsigned and signed immediate fields, which a memory operand may feed.
fn imm_or_off(o: Opnd) -> Result<i64, String> {
    match o {
        Opnd::Imm(v) => Ok(v),
        Opnd::Mem { off, .. } => Ok(off),
        _ => Err(String::from("inline asm: immediate operand expected")),
    }
}

fn cond(o: Opnd) -> Result<u8, String> {
    match o {
        Opnd::Cond(c) => Ok(c),
        _ => Err(String::from("inline asm: condition operand expected")),
    }
}

fn op_matches(p: A64Op, o: Opnd) -> bool {
    match (p, o) {
        (A64Op::X, Opnd::Reg { is64, .. }) => is64,
        (A64Op::W, Opnd::Reg { is64, .. }) => !is64,
        (A64Op::RegAny, Opnd::Reg { .. }) => true,
        (A64Op::Imm, Opnd::Imm(_)) => true,
        (A64Op::OptLsl, Opnd::Lsl(_)) => true,
        (A64Op::OptShift, Opnd::Lsl(_) | Opnd::Shift { .. }) => true,
        (A64Op::OptExt, Opnd::Lsl(_) | Opnd::Extend { .. }) => true,
        (A64Op::Cond, Opnd::Cond(_)) => true,
        // The offset and writeback addressing modes are distinct catalogue
        // shapes, so a pre-index operand never takes an offset-only encoding.
        (A64Op::Mem, Opnd::Mem { pre, .. }) => !pre,
        (A64Op::MemPre, Opnd::Mem { pre, .. }) => pre,
        (A64Op::MemReg, Opnd::MemReg { .. }) => true,
        _ => false,
    }
}

/// A memory operand with a nonzero offset must feed an immediate field of the
/// form; otherwise a base-only shape would silently drop the written offset.
fn mem_offsets_consumed(f: &Form, ops: &[Opnd]) -> bool {
    ops.iter().enumerate().all(|(i, o)| {
        let Opnd::Mem { off, .. } = o else {
            return true;
        };
        *off == 0
            || f.fields.iter().any(|fl| match *fl {
                Field::UImm { op, .. }
                | Field::SImm { op, .. }
                | Field::ScaledUImm { op, .. }
                | Field::ScaledSImm { op, .. } => op as usize == i,
                _ => false,
            })
    })
}

/// The unscaled-offset (simm9) sibling of a scaled-offset load/store. The
/// assembler encodes a written offset the scaled uimm12 form cannot represent
/// through the sibling when simm9 can; the encoder does the same after the
/// scaled form's fields reject.
fn unscaled_sibling(mnem: &str) -> Option<&'static str> {
    Some(match mnem {
        "ldr" => "ldur",
        "ldrb" => "ldurb",
        "ldrh" => "ldurh",
        "ldrsb" => "ldursb",
        "ldrsh" => "ldursh",
        "ldrsw" => "ldursw",
        "str" => "stur",
        "strb" => "sturb",
        "strh" => "sturh",
        _ => return None,
    })
}

/// Split the trailing `2` off a widening/narrowing mnemonic (`saddl2` yields
/// `("saddl", true)`); a plain mnemonic yields `is_upper = false`. Always
/// returns a value; the caller's own opcode table decides which names are real.
fn strip_widen2(mnem: &str) -> Option<(&str, bool)> {
    Some(match mnem.strip_suffix('2') {
        Some(base) => (base, true),
        None => (mnem, false),
    })
}

/// For an FP/SIMD `ldr`/`str` whose transfer register is `rt`, resolve the
/// register number, the access-size log2 (2 for s, 3 for d, 4 for q), and the
/// immediate- and register-offset base words. Returns None for a non-FP operand.
fn fp_ldst_reg(mnem: &str, rt: &Opnd) -> Option<(u8, u32, u32, u32)> {
    let is_ld = mnem == "ldr";
    Some(match *rt {
        Opnd::VReg { num, is_d: false } => (
            num,
            2,
            if is_ld { 0xBD40_0000 } else { 0xBD00_0000 },
            if is_ld { 0xBC60_0800 } else { 0xBC20_0800 },
        ),
        Opnd::VReg { num, is_d: true } => (
            num,
            3,
            if is_ld { 0xFD40_0000 } else { 0xFD00_0000 },
            if is_ld { 0xFC60_0800 } else { 0xFC20_0800 },
        ),
        Opnd::QReg(num) => (
            num,
            4,
            if is_ld { 0x3DC0_0000 } else { 0x3D80_0000 },
            if is_ld { 0x3CE0_0800 } else { 0x3CA0_0800 },
        ),
        _ => return None,
    })
}

/// Register number and `opc` selector (s 0, d 1, q 2) of a SIMD register-pair
/// transfer operand; `None` for a non-FP operand.
fn fp_pair_reg(o: &Opnd) -> Option<(u8, u8)> {
    Some(match *o {
        Opnd::VReg { num, is_d: false } => (num, 0),
        Opnd::VReg { num, is_d: true } => (num, 1),
        Opnd::QReg(num) => (num, 2),
        _ => return None,
    })
}

/// Encode one A64 instruction to its 32-bit word. Operand order is the written
/// (assembly) order. `OptLsl` slots may be omitted by the caller (a missing
/// trailing shift defaults to 0).
pub(crate) fn encode(mnemonic: &str, ops: &[Opnd]) -> Result<u32, String> {
    // A written `sp` is only ever a catalogue form's business: the bespoke
    // arms below all encode register 31 as the zero register, so routing an sp
    // operand past them would silently drop the stack pointer.
    if ops.iter().any(|o| matches!(o, Opnd::Reg { sp: true, .. })) {
        return encode_catalogue(mnemonic, ops);
    }
    // System-register move: `mrs Xt, <sysreg>` / `msr <sysreg>, Xt`. The
    // register is always 64-bit; the 16-bit `op0:op1:CRn:CRm:op2` field sits at
    // bit 5, with the L bit (read/write) fixed by the base word.
    if mnemonic == "mrs" || mnemonic == "msr" {
        let (base, rt, field) = match (mnemonic, ops) {
            ("mrs", [Opnd::Reg { num, .. }, Opnd::SysReg(f)]) => (0xD520_0000u32, *num, *f),
            ("msr", [Opnd::SysReg(f), Opnd::Reg { num, .. }]) => (0xD500_0000u32, *num, *f),
            _ => return Err(String::from("inline asm: bad mrs/msr operands")),
        };
        return Ok(base | ((field as u32) << 5) | (rt as u32 & 31));
    }
    // `casp{,a,l,al} <Rs>, <R(s+1)>, <Rt>, <R(t+1)>, [<Xn|SP>]` -- the LSE
    // compare-and-swap-pair. Only Rs (bit 16), Rt (bit 0) and Rn (bit 5) are
    // encoded; the second and fourth operands are the implied Rs+1 / Rt+1 and
    // are validated, not stored. Rs and Rt must be even. Byte-identical to GNU
    // as: `casp x0,x1,x2,x3,[x4]` is 0x4820_7C82.
    if let "casp" | "caspa" | "caspl" | "caspal" = mnemonic {
        let [
            Opnd::Reg { num: rs, is64, .. },
            Opnd::Reg {
                num: rs2, is64: w1, ..
            },
            Opnd::Reg {
                num: rt, is64: w2, ..
            },
            Opnd::Reg {
                num: rt2, is64: w3, ..
            },
            Opnd::Mem {
                base: rn,
                off: 0,
                pre: false,
            },
        ] = *ops
        else {
            return Err(String::from(
                "inline asm: casp needs <Rs>, <Rs+1>, <Rt>, <Rt+1>, [Xn]",
            ));
        };
        if is64 != w1 || is64 != w2 || is64 != w3 {
            return Err(String::from("inline asm: casp register widths differ"));
        }
        if rs % 2 != 0 || rt % 2 != 0 {
            return Err(String::from("inline asm: casp Rs and Rt must be even"));
        }
        if rs2 != rs + 1 || rt2 != rt + 1 {
            return Err(String::from(
                "inline asm: casp second/fourth register must be Rs+1 / Rt+1",
            ));
        }
        let acquire = matches!(mnemonic, "caspa" | "caspal");
        let release = matches!(mnemonic, "caspl" | "caspal");
        let base = 0x0820_7C00u32
            | if is64 { 1 << 30 } else { 0 }
            | if acquire { 1 << 22 } else { 0 }
            | if release { 1 << 15 } else { 0 };
        return Ok(base | ((rs as u32) << 16) | ((rn as u32) << 5) | (rt as u32));
    }
    // Memory copy / set (FEAT_MOPS). Every mnemonic shares one field layout --
    // destination pointer at bit 0, size at bit 5, source pointer or set value
    // at bit 16 -- so the option and stage suffixes only pick the base word.
    // `cpy` takes `[Xd]!, [Xs]!, Xn!` and `set` takes `[Xd]!, Xn!, Xs`.
    if let Some(base) = mops_base(mnemonic) {
        let (rd, rn, rs, set) = match ops {
            [
                Opnd::Mem {
                    base: rd,
                    off: 0,
                    pre: true,
                },
                Opnd::Mem {
                    base: rs,
                    off: 0,
                    pre: true,
                },
                Opnd::RegWb(rn),
            ] => (*rd, *rn, *rs, false),
            [
                Opnd::Mem {
                    base: rd,
                    off: 0,
                    pre: true,
                },
                Opnd::RegWb(rn),
                Opnd::Reg {
                    num: rs,
                    is64: true,
                    sp: false,
                },
            ] => (*rd, *rn, *rs, true),
            _ => {
                return Err(format!(
                    "inline asm: `{mnemonic}` needs `[Xd]!, [Xs]!, Xn!` or `[Xd]!, Xn!, Xs`"
                ));
            }
        };
        // GNU as rejects register 31 wherever the operand is a pointer or the
        // size; only the set value reads it, as xzr.
        if rd == 31 || rn == 31 || (!set && rs == 31) {
            return Err(format!(
                "inline asm: `{mnemonic}` needs a 64-bit integer register here"
            ));
        }
        if rd == rn || rd == rs || rn == rs {
            return Err(format!(
                "inline asm: `{mnemonic}` operands must be distinct registers"
            ));
        }
        return Ok(base | ((rs as u32) << 16) | ((rn as u32) << 5) | (rd as u32));
    }
    // fmov between a SIMD/FP register and a GP register (bridging the two
    // register files), or an FP-to-FP move. The GP<->FP forms require matching
    // widths (Xd<->Dn, Wd<->Sn); Rn/Rd sit at their usual positions.
    if mnemonic == "fmov" {
        return match ops {
            [
                Opnd::Reg { num: rd, is64, .. },
                Opnd::VReg { num: vn, is_d },
            ] if is64 == is_d => {
                let base = if *is64 { 0x9E66_0000u32 } else { 0x1E26_0000 };
                Ok(base | ((*vn as u32) << 5) | (*rd as u32))
            }
            [
                Opnd::VReg { num: vd, is_d },
                Opnd::Reg { num: rn, is64, .. },
            ] if is64 == is_d => {
                let base = if *is_d { 0x9E67_0000u32 } else { 0x1E27_0000 };
                Ok(base | ((*rn as u32) << 5) | (*vd as u32))
            }
            [
                Opnd::VReg { num: vd, is_d: d1 },
                Opnd::VReg { num: vn, is_d: d2 },
            ] if d1 == d2 => {
                let base = if *d1 { 0x1E60_4000u32 } else { 0x1E20_4000 };
                Ok(base | ((*vn as u32) << 5) | (*vd as u32))
            }
            // Scalar FP immediate `fmov Dd|Sd, #imm`: type bit selects double,
            // the 8-bit VFP value sits at bit 13.
            [Opnd::VReg { num: rd, is_d }, Opnd::FpImm(imm8)] => {
                let base = if *is_d { 0x1E60_1000u32 } else { 0x1E20_1000 };
                Ok(base | ((*imm8 as u32) << 13) | (*rd as u32))
            }
            // Vector FP immediate `fmov Vd.T, #imm` (T = 2s/4s/2d): the modified-
            // immediate cmode 1111; op (bit 29) selects the .2d double form and
            // the 8-bit value splits abc:defgh.
            [Opnd::VecReg { num: rd, size, q }, Opnd::FpImm(imm8)] => {
                if *size < 2 {
                    return Err(String::from(
                        "inline asm: vector fmov immediate needs 2s/4s/2d",
                    ));
                }
                if *size == 3 && !*q {
                    return Err(String::from("inline asm: .1d is reserved (use .2d)"));
                }
                let v = *imm8 as u32;
                Ok(0x0F00_F400
                    | (if *size == 3 { 1u32 << 29 } else { 0 })
                    | (if *q { 1u32 << 30 } else { 0 })
                    | ((v >> 5) << 16)
                    | ((v & 0x1F) << 5)
                    | (*rd as u32))
            }
            _ => Err(String::from(
                "inline asm: bad fmov operands (D<->X, S<->W, D<->D, S<->S, or #imm)",
            )),
        };
    }
    // Scalar FP two-source: `<fadd|fsub|fmul|fdiv|fmax|fmin|fnmul> Dd|Sd, ...`,
    // one width. `type` bit 22 selects double; the opcode sits at bit 12. The
    // same mnemonics on vector (VecReg) operands fall through to the SIMD arm.
    if let Some(opc) = match mnemonic {
        "fmul" => Some(0u32),
        "fdiv" => Some(1),
        "fadd" => Some(2),
        "fsub" => Some(3),
        "fmax" => Some(4),
        "fmin" => Some(5),
        "fnmul" => Some(8),
        _ => None,
    } && let [
        Opnd::VReg { num: rd, is_d: d0 },
        Opnd::VReg { num: rn, is_d: d1 },
        Opnd::VReg { num: rm, is_d: d2 },
    ] = *ops
    {
        if d0 != d1 || d1 != d2 {
            return Err(String::from(
                "inline asm: FP arithmetic operand widths differ",
            ));
        }
        let base = 0x1E20_0800u32 | if d0 { 0x40_0000 } else { 0 };
        return Ok(base | (opc << 12) | ((rm as u32) << 16) | ((rn as u32) << 5) | (rd as u32));
    }
    // Scalar FP one-source: `<fneg|fabs|fsqrt> Dd|Sd, ...`, one width (single =
    // double base less the type bit). The same mnemonics on vector (VecReg)
    // operands fall through to the SIMD two-register-misc arm.
    if let Some(base_d) = match mnemonic {
        "fabs" => Some(0x1E60_C000u32),
        "fneg" => Some(0x1E61_4000),
        "fsqrt" => Some(0x1E61_C000),
        _ => None,
    } && let [
        Opnd::VReg { num: rd, is_d: d0 },
        Opnd::VReg { num: rn, is_d: d1 },
    ] = *ops
    {
        if d0 != d1 {
            return Err(String::from("inline asm: FP unary operand widths differ"));
        }
        let base = if d0 { base_d } else { base_d - 0x40_0000 };
        return Ok(base | ((rn as u32) << 5) | (rd as u32));
    }
    // FP compare `fcmp`/`fcmpe Vn, {Vm | #0.0}` sets the flags. The result field
    // is the compare opcode: the register form is zero, the `#0.0` form sets
    // bit 3, and the exception-signalling `fcmpe` adds bit 4.
    if let "fcmp" | "fcmpe" = mnemonic {
        let e = if mnemonic == "fcmpe" { 0x10u32 } else { 0 };
        return match *ops {
            [
                Opnd::VReg { num: rn, is_d },
                Opnd::VReg { num: rm, is_d: d2 },
            ] if is_d == d2 => {
                let base = if is_d { 0x1E60_2000u32 } else { 0x1E20_2000 };
                Ok(base | ((rm as u32) << 16) | ((rn as u32) << 5) | e)
            }
            [Opnd::VReg { num: rn, is_d }, Opnd::Imm(0)] => {
                let base = if is_d { 0x1E60_2000u32 } else { 0x1E20_2000 };
                Ok(base | ((rn as u32) << 5) | 8 | e)
            }
            _ => Err(String::from("inline asm: bad fcmp/fcmpe operands")),
        };
    }
    // Integer -> FP: `scvtf|ucvtf Vd, Rn`. sf (bit 31) is the integer width,
    // the type bit (22) the FP width, bit 16 selects unsigned.
    if let Some(uns) = match mnemonic {
        "scvtf" => Some(0u32),
        "ucvtf" => Some(0x1_0000),
        _ => None,
    } {
        let [
            Opnd::VReg { num: rd, is_d },
            Opnd::Reg { num: rn, is64, .. },
        ] = *ops
        else {
            return Err(String::from("inline asm: bad scvtf/ucvtf operands"));
        };
        let base = if is64 { 0x8000_0000u32 } else { 0 }
            | 0x1E22_0000
            | if is_d { 0x40_0000 } else { 0 }
            | uns;
        return Ok(base | ((rn as u32) << 5) | (rd as u32));
    }
    // FP -> integer, rounding toward zero: `fcvtzs|fcvtzu Rd, Vn`.
    if let Some(uns) = match mnemonic {
        "fcvtzs" => Some(0u32),
        "fcvtzu" => Some(0x1_0000),
        _ => None,
    } {
        let [
            Opnd::Reg { num: rd, is64, .. },
            Opnd::VReg { num: rn, is_d },
        ] = *ops
        else {
            return Err(String::from("inline asm: bad fcvtzs/fcvtzu operands"));
        };
        let base = if is64 { 0x8000_0000u32 } else { 0 }
            | 0x1E38_0000
            | if is_d { 0x40_0000 } else { 0 }
            | uns;
        return Ok(base | ((rn as u32) << 5) | (rd as u32));
    }
    // FP size conversion between single and double: `fcvt Vd, Vn`.
    if mnemonic == "fcvt" {
        let [
            Opnd::VReg {
                num: rd,
                is_d: dst_d,
            },
            Opnd::VReg {
                num: rn,
                is_d: src_d,
            },
        ] = *ops
        else {
            return Err(String::from("inline asm: bad fcvt operands"));
        };
        let base = match (dst_d, src_d) {
            (false, true) => 0x1E62_4000u32, // Sd, Dn (double -> single)
            (true, false) => 0x1E22_C000,    // Dd, Sn (single -> double)
            _ => {
                return Err(String::from(
                    "inline asm: fcvt needs different source and destination widths",
                ));
            }
        };
        return Ok(base | ((rn as u32) << 5) | (rd as u32));
    }
    // SIMD `dup Vd.T, Rn`: broadcast a GP register into every lane. The imm5
    // field carries the element size as a one-hot bit. Valid targets are
    // 8b/16b/4h/8h/2s/4s/2d; the single-lane .1d is not a broadcast target.
    // The element form `dup Bd|Hd|Sd|Dd, Vn.T[i]` is handled with its `mov`
    // spelling below, so a non-GP source falls through rather than erroring.
    if mnemonic == "dup"
        && let [Opnd::VecReg { num: rd, size, q }, Opnd::Reg { num: rn, .. }] = *ops
    {
        if size > 3 || (size == 3 && !q) {
            return Err(String::from(
                "inline asm: bad dup arrangement (8b/16b/4h/8h/2s/4s/2d)",
            ));
        }
        let imm5 = 1u32 << size;
        return Ok((if q { 1u32 << 30 } else { 0 })
            | 0x0E00_0C00
            | (imm5 << 16)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // SIMD three-same integer ops `Vd.T, Vn.T, Vm.T`, one arrangement. size at
    // bit 22, Q at 30, U at 29, the opcode in the base word; `lo..=hi` bounds
    // the element size (mul/min/max/mla/abd have no 64-bit form). GP add/sub/mul
    // (Reg operands) fall through to the catalogue below.
    if let Some((op_base, u, lo, hi)) = match mnemonic {
        "add" => Some((0x0E20_8400u32, 0u32, 0u8, 3u8)),
        "sub" => Some((0x0E20_8400, 1, 0, 3)),
        "mul" => Some((0x0E20_9C00, 0, 0, 2)),
        "pmul" => Some((0x0E20_9C00, 1, 0, 0)),
        "cmeq" => Some((0x0E20_8C00, 1, 0, 3)),
        "cmgt" => Some((0x0E20_3400, 0, 0, 3)),
        "cmge" => Some((0x0E20_3C00, 0, 0, 3)),
        "cmhi" => Some((0x0E20_3400, 1, 0, 3)),
        "cmhs" => Some((0x0E20_3C00, 1, 0, 3)),
        "smax" => Some((0x0E20_6400, 0, 0, 2)),
        "smin" => Some((0x0E20_6C00, 0, 0, 2)),
        "umax" => Some((0x0E20_6400, 1, 0, 2)),
        "umin" => Some((0x0E20_6C00, 1, 0, 2)),
        "sqadd" => Some((0x0E20_0C00, 0, 0, 3)),
        "uqadd" => Some((0x0E20_0C00, 1, 0, 3)),
        "sqsub" => Some((0x0E20_2C00, 0, 0, 3)),
        "uqsub" => Some((0x0E20_2C00, 1, 0, 3)),
        "mla" => Some((0x0E20_9400, 0, 0, 2)),
        "mls" => Some((0x0E20_9400, 1, 0, 2)),
        "sabd" => Some((0x0E20_7400, 0, 0, 2)),
        "uabd" => Some((0x0E20_7400, 1, 0, 2)),
        "addp" => Some((0x0E20_BC00, 0, 0, 3)),
        _ => None,
    } && let [
        Opnd::VecReg { num: rd, size, q },
        Opnd::VecReg {
            num: rn,
            size: s1,
            q: q1,
        },
        Opnd::VecReg {
            num: rm,
            size: s2,
            q: q2,
        },
    ] = *ops
    {
        if size != s1 || size != s2 || q != q1 || q != q2 {
            return Err(String::from(
                "inline asm: vector arithmetic arrangements differ",
            ));
        }
        if size < lo || size > hi {
            return Err(String::from(
                "inline asm: element size invalid for this vector op",
            ));
        }
        if size == 3 && !q {
            return Err(String::from(
                "inline asm: .1d arrangement is reserved (use .2d)",
            ));
        }
        return Ok((if q { 1u32 << 30 } else { 0 })
            | op_base
            | (u << 29)
            | ((size as u32) << 22)
            | ((rm as u32) << 16)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // SIMD logical `<and|bic|orr|orn|eor|bsl|bit|bif> Vd.T, Vn.T, Vm.T`, byte
    // arrangement only; the (U, size) fields select the operation. GP forms
    // (Reg operands) fall through to the catalogue.
    if let Some(variant) = match mnemonic {
        "and" => Some(0u32),
        "bic" => Some(0x0040_0000),
        "orr" => Some(0x0080_0000),
        "orn" => Some(0x00C0_0000),
        "eor" => Some(0x2000_0000),
        "bsl" => Some(0x2040_0000),
        "bit" => Some(0x2080_0000),
        "bif" => Some(0x20C0_0000),
        _ => None,
    } && let [
        Opnd::VecReg { num: rd, size, q },
        Opnd::VecReg {
            num: rn,
            size: s1,
            q: q1,
        },
        Opnd::VecReg {
            num: rm,
            size: s2,
            q: q2,
        },
    ] = *ops
    {
        if size != 0 || s1 != 0 || s2 != 0 || q != q1 || q != q2 {
            return Err(String::from(
                "inline asm: vector logical ops are 8b/16b only",
            ));
        }
        return Ok((if q { 1u32 << 30 } else { 0 })
            | 0x0E20_1C00
            | variant
            | ((rm as u32) << 16)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // SIMD register-pair load/store `<ldp|stp> <St1|Dt1|Qt1>, <t2>, [Xn|SP..]`.
    // `opc` selects the register view and the scale (4 << opc); the addressing
    // mode sits at bit 23 (post-index 1, signed offset 2, pre-index 3) and the
    // load bit at 22. Byte-identical to GNU as: `ldp q0, q1, [x2, #16]` is
    // 0xAD408440 and `stp d2, d3, [x2, #-16]!` is 0x6DBF0C42.
    if let ("ldp" | "stp", [t1, t2, mem, rest @ ..]) = (mnemonic, ops)
        && let Some((rt, opc)) = fp_pair_reg(t1)
        && let Some((rt2, opc2)) = fp_pair_reg(t2)
    {
        if opc != opc2 {
            return Err(String::from("inline asm: register-pair widths differ"));
        }
        let (rn, off, mode) = match (mem, rest) {
            (
                Opnd::Mem {
                    base,
                    off,
                    pre: true,
                },
                [],
            ) => (*base, *off, 3u32),
            (
                Opnd::Mem {
                    base,
                    off: 0,
                    pre: false,
                },
                [Opnd::Imm(n)],
            ) => (*base, *n, 1),
            (
                Opnd::Mem {
                    base,
                    off,
                    pre: false,
                },
                [],
            ) => (*base, *off, 2),
            _ => {
                return Err(format!(
                    "inline asm: no A64 encoding for `{mnemonic}` with these operands"
                ));
            }
        };
        let scale = 4i64 << opc;
        if off % scale != 0 || !(-64..=63).contains(&(off / scale)) {
            return Err(format!(
                "inline asm: `{mnemonic}` offset {off} is not a signed 7-bit multiple of {scale}"
            ));
        }
        let imm7 = ((off / scale) as u32) & 0x7F;
        let load = u32::from(mnemonic == "ldp");
        return Ok(0x2C00_0000
            | ((opc as u32) << 30)
            | (mode << 23)
            | (load << 22)
            | (imm7 << 15)
            | ((rt2 as u32) << 10)
            | ((rn as u32) << 5)
            | (rt as u32));
    }
    // SIMD shift-and-insert by immediate. `sri` counts from the right, so the
    // immh:immb field holds `2 * esize - shift` for a shift of 1..=esize;
    // `sli` counts from the left, holding `esize + shift` for 0..=esize-1.
    // Byte-identical to GNU as: `sri v1.4s, v17.4s, #20` is 0x6F2C4621 and
    // `sli v1.4s, v17.4s, #20` is 0x6F345621.
    if let Some((base, right)) = match mnemonic {
        "sri" => Some((0x2F00_4400u32, true)),
        "sli" => Some((0x2F00_5400u32, false)),
        _ => None,
    } && let [
        Opnd::VecReg { num: rd, size, q },
        Opnd::VecReg {
            num: rn,
            size: s1,
            q: q1,
        },
        Opnd::Imm(shift),
    ] = *ops
    {
        if size != s1 || q != q1 {
            return Err(String::from("inline asm: vector shift arrangements differ"));
        }
        if size == 3 && !q {
            return Err(String::from(
                "inline asm: .1d arrangement is reserved (use .2d)",
            ));
        }
        let esize = 8i64 << size;
        let range = if right { 1..=esize } else { 0..=esize - 1 };
        if !range.contains(&shift) {
            return Err(format!(
                "inline asm: `{mnemonic}` shift {shift} out of range for this arrangement"
            ));
        }
        let field = if right {
            2 * esize - shift
        } else {
            esize + shift
        } as u32;
        return Ok((if q { 1u32 << 30 } else { 0 })
            | base
            | (field << 16)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // SHA1 / SHA512 schedule and hash updates: the arrangement is fixed by the
    // instruction, so only the register fields vary. `sha512h` / `sha512h2`
    // take their two sources as q registers. Byte-identical to GNU as:
    // `sha1su0 v0.4s, v1.4s, v2.4s` is 0x5E023020 and `sha512h q3, q6, v7.2d`
    // is 0xCE6780C3.
    if let Some((base, esize)) = match mnemonic {
        "sha1su0" => Some((0x5E00_3000u32, 2u8)),
        "sha1su1" => Some((0x5E28_1800, 2)),
        "sha512su0" => Some((0xCEC0_8000, 3)),
        "sha512su1" => Some((0xCE60_8800, 3)),
        "sha512h" => Some((0xCE60_8000, 3)),
        "sha512h2" => Some((0xCE60_8400, 3)),
        _ => None,
    } {
        let vec_of = |o: &Opnd| match *o {
            Opnd::VecReg { num, size, q } if size == esize && q => Some(num),
            _ => None,
        };
        let fields = match *ops {
            [ref d, ref n] => vec_of(d).zip(vec_of(n)).map(|(d, n)| (d, n, 0)),
            [Opnd::QReg(d), Opnd::QReg(n), ref m] => vec_of(m).map(|m| (d, n, m)),
            [ref d, ref n, ref m] => vec_of(d)
                .zip(vec_of(n))
                .zip(vec_of(m))
                .map(|((d, n), m)| (d, n, m)),
            _ => None,
        };
        let (rd, rn, rm) = fields.ok_or_else(|| {
            format!("inline asm: no A64 encoding for `{mnemonic}` with these operands")
        })?;
        return Ok(base | ((rm as u32) << 16) | ((rn as u32) << 5) | (rd as u32));
    }
    // SIMD permute `<zip1|zip2|uzp1|uzp2|trn1|trn2> Vd.T, Vn.T, Vm.T`, one
    // arrangement. size at bit 22, Q at 30; each op's base word carries its
    // opcode. The .1d arrangement (size 3 without Q) is reserved.
    if let Some(base) = match mnemonic {
        "uzp1" => Some(0x0E00_1800u32),
        "trn1" => Some(0x0E00_2800),
        "zip1" => Some(0x0E00_3800),
        "uzp2" => Some(0x0E00_5800),
        "trn2" => Some(0x0E00_6800),
        "zip2" => Some(0x0E00_7800),
        _ => None,
    } && let [
        Opnd::VecReg { num: rd, size, q },
        Opnd::VecReg {
            num: rn,
            size: s1,
            q: q1,
        },
        Opnd::VecReg {
            num: rm,
            size: s2,
            q: q2,
        },
    ] = *ops
    {
        if size != s1 || size != s2 || q != q1 || q != q2 {
            return Err(String::from(
                "inline asm: vector permute arrangements differ",
            ));
        }
        if size == 3 && !q {
            return Err(String::from(
                "inline asm: vector permute .1d is reserved (use .2d)",
            ));
        }
        return Ok(base
            | (if q { 1u32 << 30 } else { 0 })
            | ((size as u32) << 22)
            | ((rm as u32) << 16)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // SIMD extract `ext Vd.16b, Vn.16b, Vm.16b, #imm`: a byte-granular window
    // starting at byte `imm` of the concatenation Vm:Vn. Byte arrangement only;
    // the imm4 index is 0..15 (Q=1) or 0..7 (Q=0).
    if mnemonic == "ext"
        && let [
            Opnd::VecReg { num: rd, size, q },
            Opnd::VecReg {
                num: rn,
                size: s1,
                q: q1,
            },
            Opnd::VecReg {
                num: rm,
                size: s2,
                q: q2,
            },
            Opnd::Imm(index),
        ] = *ops
    {
        if size != 0 || s1 != 0 || s2 != 0 || q != q1 || q != q2 {
            return Err(String::from("inline asm: ext operands must be 8b/16b"));
        }
        let lanes = if q { 16 } else { 8 };
        if index < 0 || index >= lanes {
            return Err(String::from("inline asm: ext index out of range"));
        }
        return Ok(0x2E00_0000
            | (if q { 1u32 << 30 } else { 0 })
            | ((rm as u32) << 16)
            | ((index as u32) << 11)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // SIMD FP three-same `Vd.T, Vn.T, Vm.T` (T = 2s/4s/2d): fadd/fsub/fmul/fdiv,
    // fmax/fmin, the compares fcmeq/fcmgt/fcmge, the multiply-accumulates fmla/
    // fmls, absolute difference fabd, and pairwise faddp. The sz bit (22) selects
    // double; each op's base word carries its opcode plus the U and sub/min
    // flags. Scalar f-arith (VReg operands) is handled elsewhere; VReg here
    // falls through.
    if let Some(base) = match mnemonic {
        "fadd" => Some(0x0E20_D400u32),
        "fsub" => Some(0x0EA0_D400),
        "fmul" => Some(0x2E20_DC00),
        "fdiv" => Some(0x2E20_FC00),
        "fmax" => Some(0x0E20_F400),
        "fmin" => Some(0x0EA0_F400),
        "fcmeq" => Some(0x0E20_E400),
        "fcmgt" => Some(0x2EA0_E400),
        "fcmge" => Some(0x2E20_E400),
        "fmla" => Some(0x0E20_CC00),
        "fmls" => Some(0x0EA0_CC00),
        "fabd" => Some(0x2EA0_D400),
        "faddp" => Some(0x2E20_D400),
        _ => None,
    } && let [
        Opnd::VecReg { num: rd, size, q },
        Opnd::VecReg {
            num: rn,
            size: s1,
            q: q1,
        },
        Opnd::VecReg {
            num: rm,
            size: s2,
            q: q2,
        },
    ] = *ops
    {
        if size != s1 || size != s2 || q != q1 || q != q2 {
            return Err(String::from("inline asm: FP vector arrangements differ"));
        }
        if size < 2 {
            return Err(String::from("inline asm: FP vector ops are 2s/4s/2d only"));
        }
        let sz = if size == 3 { 0x40_0000u32 } else { 0 };
        return Ok(base
            | (if q { 1u32 << 30 } else { 0 })
            | sz
            | ((rm as u32) << 16)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // SIMD shift by immediate `<shl|sshr|ushr> Vd.T, Vn.T, #shift`. The immh:immb
    // field (bits 22..16) encodes both element size and amount: left shifts use
    // esize+shift, right shifts use 2*esize-shift. U at bit 29 selects ushr; the
    // .1d arrangement is reserved (only .2d exists for vectors).
    if let Some((base, u, left)) = match mnemonic {
        "shl" => Some((0x0F00_5400u32, 0u32, true)),
        "sshr" => Some((0x0F00_0400, 0, false)),
        "ushr" => Some((0x0F00_0400, 1, false)),
        _ => None,
    } && let [
        Opnd::VecReg { num: rd, size, q },
        Opnd::VecReg {
            num: rn,
            size: s1,
            q: q1,
        },
        Opnd::Imm(shift),
    ] = *ops
    {
        if size != s1 || q != q1 {
            return Err(String::from("inline asm: vector shift arrangements differ"));
        }
        if size > 3 || (size == 3 && !q) {
            return Err(String::from(
                "inline asm: vector shift .1d is reserved (use .2d)",
            ));
        }
        let esize = 8i64 << size;
        let immhb = if left {
            if shift < 0 || shift >= esize {
                return Err(String::from(
                    "inline asm: vector left-shift amount out of range",
                ));
            }
            esize + shift
        } else {
            if shift < 1 || shift > esize {
                return Err(String::from(
                    "inline asm: vector right-shift amount out of range",
                ));
            }
            2 * esize - shift
        };
        return Ok(base
            | (u << 29)
            | (if q { 1u32 << 30 } else { 0 })
            | ((immhb as u32) << 16)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // SIMD modified immediate `movi|mvni Vd.T, #imm{, lsl #s}`. The 8-bit value
    // splits abc:defgh across bits 18..16 and 9..5; cmode selects the element
    // size and shift. Byte and .2d use cmode 1110 (the .2d form, op=1,
    // replicates each immediate bit to a byte); half/word use the shifted-
    // immediate cmodes. mvni sets op and is not defined for byte or .2d.
    if let "movi" | "mvni" = mnemonic
        && let Some((rd, size, q, imm, shift)) = match *ops {
            [Opnd::VecReg { num, size, q }, Opnd::Imm(v)] => Some((num, size, q, v, 0i64)),
            [Opnd::VecReg { num, size, q }, Opnd::Imm(v), Opnd::Lsl(s)] => {
                Some((num, size, q, v, s as i64))
            }
            _ => None,
        }
    {
        let is_mvni = mnemonic == "mvni";
        let qbit = if q { 1u32 << 30 } else { 0 };
        if size == 3 {
            if is_mvni || shift != 0 {
                return Err(String::from(
                    "inline asm: movi .2d takes no shift; mvni .2d is not defined",
                ));
            }
            // Each of the 8 immediate bits fills a byte of the 64-bit element.
            let mut bits = 0u32;
            for (i, b) in (imm as u64).to_le_bytes().iter().enumerate() {
                match b {
                    0x00 => {}
                    0xFF => bits |= 1 << i,
                    _ => {
                        return Err(String::from(
                            "inline asm: movi .2d immediate bytes must be 0x00 or 0xFF",
                        ));
                    }
                }
            }
            return Ok(0x2F00_E400
                | qbit
                | ((bits >> 5) << 16)
                | ((bits & 0x1F) << 5)
                | (rd as u32));
        }
        if !(0..=0xFF).contains(&imm) {
            return Err(String::from(
                "inline asm: movi/mvni immediate must be 0..255",
            ));
        }
        let cmode = match (size, shift) {
            (0, 0) => 0b1110u32,
            (1, 0) => 0b1000,
            (1, 8) => 0b1010,
            (2, 0) => 0b0000,
            (2, 8) => 0b0010,
            (2, 16) => 0b0100,
            (2, 24) => 0b0110,
            _ => {
                return Err(String::from(
                    "inline asm: invalid movi/mvni shift for this arrangement",
                ));
            }
        };
        if is_mvni && size == 0 {
            return Err(String::from(
                "inline asm: mvni is not defined for a byte arrangement",
            ));
        }
        let v = imm as u32;
        return Ok(0x0F00_0400
            | qbit
            | (if is_mvni { 1u32 << 29 } else { 0 })
            | ((v >> 5) << 16)
            | (cmode << 12)
            | ((v & 0x1F) << 5)
            | (rd as u32));
    }
    // SIMD two-register misc (one source): the sign ops abs/neg, bitwise
    // not/mvn, popcount cnt, the reverses rev16/rev32/rev64, and the FP unary
    // fabs/fneg/fsqrt. Each base word bakes U and the opcode; `lo..=hi` bounds
    // the element size (byte-only for not/cnt/rev16, up to word for rev64, all
    // sizes for abs/neg, 2s/4s/2d for the FP ops). GP neg/mvn and scalar
    // fabs/fneg/fsqrt (Reg/VReg operands) fall through.
    if let Some((base, lo, hi)) = match mnemonic {
        "rev64" => Some((0x0E20_0800u32, 0u8, 2u8)),
        "rev32" => Some((0x2E20_0800, 0, 1)),
        "rev16" => Some((0x0E20_1800, 0, 0)),
        "cnt" => Some((0x0E20_5800, 0, 0)),
        "not" | "mvn" => Some((0x2E20_5800, 0, 0)),
        "abs" => Some((0x0E20_B800, 0, 3)),
        "neg" => Some((0x2E20_B800, 0, 3)),
        "fabs" => Some((0x0E20_F800, 2, 3)),
        "fneg" => Some((0x2E20_F800, 2, 3)),
        "fsqrt" => Some((0x2E21_F800, 2, 3)),
        _ => None,
    } && let [
        Opnd::VecReg { num: rd, size, q },
        Opnd::VecReg {
            num: rn,
            size: s1,
            q: q1,
        },
    ] = *ops
    {
        if size != s1 || q != q1 {
            return Err(String::from(
                "inline asm: vector 1-source arrangements differ",
            ));
        }
        if size < lo || size > hi {
            return Err(String::from(
                "inline asm: element size invalid for this vector op",
            ));
        }
        if size == 3 && !q {
            return Err(String::from(
                "inline asm: .1d arrangement is reserved (use .2d)",
            ));
        }
        return Ok(base
            | (if q { 1u32 << 30 } else { 0 })
            | ((size as u32) << 22)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // SIMD across-lane reduction `<addv|smaxv|sminv|umaxv|uminv> Vd, Vn.T`
    // reduces a vector to a scalar at the source element size; the long
    // reductions saddlv/uaddlv widen the scalar one size. size (bit 22) is the
    // source element (8b/16b/4h/8h/4s only), U at 29 selects unsigned, and the
    // destination is a scalar-SIMD register whose width must match (b/h are
    // VScalar, s/d are VReg).
    if let Some((base, u, widen)) = match mnemonic {
        "addv" => Some((0x0E31_B800u32, 0u32, false)),
        "smaxv" => Some((0x0E30_A800, 0, false)),
        "sminv" => Some((0x0E31_A800, 0, false)),
        "umaxv" => Some((0x0E30_A800, 1, false)),
        "uminv" => Some((0x0E31_A800, 1, false)),
        "saddlv" => Some((0x0E30_3800, 0, true)),
        "uaddlv" => Some((0x0E30_3800, 1, true)),
        _ => None,
    } && let [
        dst,
        Opnd::VecReg {
            num: rn,
            size: ss,
            q,
        },
    ] = ops
    {
        let (rd, dsize) = match dst {
            Opnd::VScalar { num, size } => (*num, *size),
            Opnd::VReg { num, is_d } => (*num, if *is_d { 3u8 } else { 2 }),
            _ => {
                return Err(String::from(
                    "inline asm: reduction destination must be a scalar-SIMD register (b/h/s/d)",
                ));
            }
        };
        if *ss > 2 {
            return Err(String::from(
                "inline asm: reduction source must be 8b/16b/4h/8h/4s",
            ));
        }
        if dsize != ss + if widen { 1 } else { 0 } {
            return Err(String::from(
                "inline asm: reduction destination width must match the source element",
            ));
        }
        return Ok(base
            | (u << 29)
            | (if *q { 1u32 << 30 } else { 0 })
            | ((*ss as u32) << 22)
            | ((*rn as u32) << 5)
            | (rd as u32));
    }
    // Crypto two-register, fixed arrangement `<op> Vd.T, Vn.T`: the AES round
    // steps aese/aesd/aesmc/aesimc (.16b) and the SHA update steps sha256su0/
    // sha1su1 (.4s). The whole encoding but Rn/Rd is fixed per op.
    if let Some((base, req)) = match mnemonic {
        "aese" => Some((0x4E28_4800u32, 0u8)),
        "aesd" => Some((0x4E28_5800, 0)),
        "aesmc" => Some((0x4E28_6800, 0)),
        "aesimc" => Some((0x4E28_7800, 0)),
        "sha256su0" => Some((0x5E28_2800, 2)),
        "sha1su1" => Some((0x5E28_1800, 2)),
        _ => None,
    } && let [
        Opnd::VecReg { num: rd, size, q },
        Opnd::VecReg {
            num: rn,
            size: s1,
            q: q1,
        },
    ] = *ops
    {
        if size != req || s1 != req || !q || !q1 {
            return Err(String::from(
                "inline asm: crypto operands need the op's fixed arrangement (.16b for AES, .4s for SHA)",
            ));
        }
        return Ok(base | ((rn as u32) << 5) | (rd as u32));
    }
    // SHA256 hash update `<sha256h|sha256h2> Qd, Qn, Vm.4s`: the accumulator is a
    // 128-bit Q register, the schedule a word vector.
    if let Some(base) = match mnemonic {
        "sha256h" => Some(0x5E00_4000u32),
        "sha256h2" => Some(0x5E00_5000),
        _ => None,
    } && let [
        Opnd::QReg(rd),
        Opnd::QReg(rn),
        Opnd::VecReg {
            num: rm,
            size: 2,
            q: true,
        },
    ] = *ops
    {
        return Ok(base | ((rm as u32) << 16) | ((rn as u32) << 5) | (rd as u32));
    }
    // SHA256 schedule update `sha256su1 Vd.4s, Vn.4s, Vm.4s`.
    if mnemonic == "sha256su1"
        && let [
            Opnd::VecReg { num: rd, size, q },
            Opnd::VecReg {
                num: rn,
                size: s1,
                q: q1,
            },
            Opnd::VecReg {
                num: rm,
                size: s2,
                q: q2,
            },
        ] = *ops
    {
        if size != 2 || s1 != 2 || s2 != 2 || !q || !q1 || !q2 {
            return Err(String::from("inline asm: sha256su1 operands must be .4s"));
        }
        return Ok(0x5E00_6000 | ((rm as u32) << 16) | ((rn as u32) << 5) | (rd as u32));
    }
    // SIMD widening three-register (long) `Vd.<2T>, Vn.<T>, Vm.<T>`: the sum,
    // difference, product, or multiply-accumulate of two narrow vectors into a
    // vector whose element is twice as wide. size (bit 22) is the SOURCE width;
    // the `2` mnemonic reads the top half of 128-bit sources (Q at 30). U at 29
    // selects the unsigned op.
    if let Some((wmnem, upper)) = strip_widen2(mnemonic)
        && let Some((base, u)) = match wmnem {
            "saddl" => Some((0x0E20_0000u32, 0u32)),
            "uaddl" => Some((0x0E20_0000, 1)),
            "ssubl" => Some((0x0E20_2000, 0)),
            "usubl" => Some((0x0E20_2000, 1)),
            "smull" => Some((0x0E20_C000, 0)),
            "umull" => Some((0x0E20_C000, 1)),
            "smlal" => Some((0x0E20_8000, 0)),
            "umlal" => Some((0x0E20_8000, 1)),
            "smlsl" => Some((0x0E20_A000, 0)),
            "umlsl" => Some((0x0E20_A000, 1)),
            _ => None,
        }
        && let [
            Opnd::VecReg {
                num: rd,
                size: ds,
                q: dq,
            },
            Opnd::VecReg {
                num: rn,
                size: ss,
                q: sq,
            },
            Opnd::VecReg {
                num: rm,
                size: ms,
                q: mq,
            },
        ] = *ops
    {
        if ss != ms || sq != mq {
            return Err(String::from(
                "inline asm: widening source arrangements differ",
            ));
        }
        if !dq || ds != ss + 1 || ss > 2 {
            return Err(String::from(
                "inline asm: widening destination must be one element size wider (8h/4s/2d)",
            ));
        }
        if sq != upper {
            return Err(String::from(
                "inline asm: the `2` form reads 128-bit sources; the base form reads 64-bit",
            ));
        }
        return Ok(base
            | (u << 29)
            | (if upper { 1u32 << 30 } else { 0 })
            | ((ss as u32) << 22)
            | ((rm as u32) << 16)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // SIMD narrowing two-register `Vd.<T>, Vn.<2T>`: extract narrow elements
    // from a wide vector. size (bit 22) is the DESTINATION width; the `2`
    // mnemonic writes the top half of a 128-bit destination (Q at 30). U at 29
    // selects the unsigned-saturating (uqxtn) or signed-to-unsigned (sqxtun) op.
    if let Some((nmnem, upper)) = strip_widen2(mnemonic)
        && let Some((base, u)) = match nmnem {
            "xtn" => Some((0x0E21_2800u32, 0u32)),
            "sqxtun" => Some((0x0E21_2800, 1)),
            "sqxtn" => Some((0x0E21_4800, 0)),
            "uqxtn" => Some((0x0E21_4800, 1)),
            _ => None,
        }
        && let [
            Opnd::VecReg {
                num: rd,
                size: ds,
                q: dq,
            },
            Opnd::VecReg {
                num: rn,
                size: ss,
                q: sq,
            },
        ] = *ops
    {
        if !sq || ss == 0 || ds + 1 != ss {
            return Err(String::from(
                "inline asm: narrowing source must be one element size wider (8h/4s/2d)",
            ));
        }
        if dq != upper {
            return Err(String::from(
                "inline asm: the `2` form writes the top half; the base form writes the low half",
            ));
        }
        return Ok(base
            | (u << 29)
            | (if upper { 1u32 << 30 } else { 0 })
            | ((ds as u32) << 22)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // Polynomial (carryless) multiply long `pmull|pmull2 Vd, Vn, Vm`: the byte
    // form widens .8b/.16b to .8h, the dword form widens .1d/.2d to .1q (used
    // for GHASH). pmull2 (Q=1) reads the upper-half source lanes. The size field
    // is the source width; the destination is one element class wider.
    if let "pmull" | "pmull2" = mnemonic
        && let [
            Opnd::VecReg {
                num: rd,
                size: ds,
                q: dq,
            },
            Opnd::VecReg {
                num: rn,
                size: ss,
                q: sq,
            },
            Opnd::VecReg {
                num: rm,
                size: ms,
                q: mq,
            },
        ] = *ops
    {
        let upper = mnemonic == "pmull2";
        if ss != ms || sq != mq {
            return Err(String::from("inline asm: pmull source arrangements differ"));
        }
        if sq != upper {
            return Err(String::from(
                "inline asm: the `2` form reads 128-bit sources; the base form reads 64-bit",
            ));
        }
        let want_dst = match ss {
            0 => (1u8, true),
            3 => (4, true),
            _ => {
                return Err(String::from(
                    "inline asm: pmull source must be .8b/.16b or .1d/.2d",
                ));
            }
        };
        if (ds, dq) != want_dst {
            return Err(String::from(
                "inline asm: pmull destination must be .8h (byte source) or .1q (dword source)",
            ));
        }
        return Ok(0x0E20_E000
            | (if upper { 1u32 << 30 } else { 0 })
            | ((ss as u32) << 22)
            | ((rm as u32) << 16)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // SIMD element to GP register: `umov Rd, Vn.T[i]` (zero-extended) or
    // `smov Rd, Vn.T[i]` (sign-extended). imm5 = (index << (size+1)) | (1<<size)
    // carries element size and lane. umov's destination width is fixed by the
    // element (X for d, W otherwise), Q following; smov's Q follows the chosen
    // destination, which must be wider than the element.
    if let Some((base, signed)) = match mnemonic {
        "umov" | "mov" => Some((0x0E00_3C00u32, false)),
        "smov" => Some((0x0E00_2C00, true)),
        _ => None,
    } && let [
        Opnd::Reg { num: rd, is64, .. },
        Opnd::VecElem {
            num: rn,
            size,
            index,
        },
    ] = *ops
    {
        if signed {
            if size as u32 >= if is64 { 3 } else { 2 } {
                return Err(String::from(
                    "inline asm: smov element must be narrower than the destination",
                ));
            }
        } else if is64 != (size == 3) {
            return Err(String::from(
                "inline asm: umov destination width must match the element (X for d, W otherwise)",
            ));
        }
        let imm5 = ((index as u32) << (size + 1)) | (1u32 << size);
        let q = if is64 { 1u32 << 30 } else { 0 };
        return Ok(base | q | (imm5 << 16) | ((rn as u32) << 5) | (rd as u32));
    }
    // SIMD element to SIMD element: `ins Vd.T[i], Vn.T[j]` (also spelled
    // `mov`). imm5 carries the destination element size and lane, imm4 the
    // source lane scaled by the element size. Byte-identical to GNU as:
    // `mov v2.s[1], v5.s[3]` is 0x6E0C64A2.
    if let "ins" | "mov" = mnemonic
        && let [
            Opnd::VecElem {
                num: rd,
                size,
                index,
            },
            Opnd::VecElem {
                num: rn,
                size: s1,
                index: index2,
            },
        ] = *ops
    {
        if size != s1 {
            return Err(String::from("inline asm: ins element sizes differ"));
        }
        let imm5 = ((index as u32) << (size + 1)) | (1u32 << size);
        let imm4 = (index2 as u32) << size;
        return Ok(0x6E00_0400 | (imm5 << 16) | (imm4 << 11) | ((rn as u32) << 5) | (rd as u32));
    }
    // SIMD element to scalar: `mov Bd|Hd|Sd|Dd, Vn.T[i]`, the `dup` element
    // alias. imm5 carries the element size and lane; the destination view must
    // name the same element size. Byte-identical to GNU as: `mov d19, v0.d[1]`
    // is 0x5E180413.
    if let "mov" | "dup" = mnemonic
        && let [dst, src] = ops
        && let Opnd::VecElem {
            num: rn,
            size,
            index,
        } = *src
        && let Some(dsize) = match *dst {
            Opnd::VScalar { size: s, .. } => Some(s),
            Opnd::VReg { is_d, .. } => Some(if is_d { 3 } else { 2 }),
            _ => None,
        }
    {
        let rd = match *dst {
            Opnd::VScalar { num, .. } | Opnd::VReg { num, .. } => num,
            _ => unreachable!("guarded by the size match"),
        };
        if dsize != size {
            return Err(String::from(
                "inline asm: scalar destination must name the source element size",
            ));
        }
        let imm5 = ((index as u32) << (size + 1)) | (1u32 << size);
        return Ok(0x5E00_0400 | (imm5 << 16) | ((rn as u32) << 5) | (rd as u32));
    }
    // GP register to SIMD element: `ins Vd.T[i], Rn` (also spelled `mov`). The
    // vector register is 128-bit so Q is fixed; imm5 carries element size and
    // lane. The source width follows the element (X for d, W otherwise).
    if let "ins" | "mov" = mnemonic
        && let [
            Opnd::VecElem {
                num: rd,
                size,
                index,
            },
            Opnd::Reg { num: rn, is64, .. },
        ] = *ops
    {
        if is64 != (size == 3) {
            return Err(String::from(
                "inline asm: ins source width must match the element (X for d, W otherwise)",
            ));
        }
        let imm5 = ((index as u32) << (size + 1)) | (1u32 << size);
        return Ok(0x4E00_1C00 | (imm5 << 16) | ((rn as u32) << 5) | (rd as u32));
    }
    // System operation: `dc`/`ic`/`tlbi`/`at`/`sys <op>{, Xt}`. The op is a base
    // word; the Rt field takes the register operand or xzr (31) when absent.
    if let "dc" | "ic" | "tlbi" | "at" | "sys" = mnemonic {
        let (base, rt) = match ops {
            [Opnd::SysOp(b)] => (*b, 31u32),
            [Opnd::SysOp(b), Opnd::Reg { num, .. }] => (*b, *num as u32),
            _ => return Err(String::from("inline asm: bad sys-op operands")),
        };
        return Ok(base | (rt & 31));
    }
    // Bitfield extract / insert aliases of sbfm/bfm/ubfm: the written
    // `Xd, Xn, #lsb, #width` becomes immr/imms. Extract (ubfx/sbfx/bfxil) keeps
    // immr=lsb, imms=lsb+width-1; insert (ubfiz/sbfiz/bfi) sets immr=-lsb mod
    // regsize, imms=width-1. The register width picks the field-mask bit N.
    if let "ubfx" | "sbfx" | "bfxil" | "ubfiz" | "sbfiz" | "bfi" = mnemonic {
        let [
            Opnd::Reg { num: rd, is64, .. },
            Opnd::Reg {
                num: rn, is64: n2, ..
            },
            Opnd::Imm(lsb),
            Opnd::Imm(width),
        ] = *ops
        else {
            return Err(String::from("inline asm: bad bitfield operands"));
        };
        if is64 != n2 {
            return Err(String::from("inline asm: bitfield operand widths differ"));
        }
        let regsize = if is64 { 64i64 } else { 32 };
        if lsb < 0 || width < 1 || lsb >= regsize || lsb + width > regsize {
            return Err(String::from("inline asm: bitfield lsb/width out of range"));
        }
        let (opc, insert): (u32, bool) = match mnemonic {
            "sbfx" => (0, false),
            "sbfiz" => (0, true),
            "bfxil" => (1, false),
            "bfi" => (1, true),
            "ubfx" => (2, false),
            _ => (2, true), // ubfiz
        };
        let (immr, imms) = if insert {
            (((regsize - lsb) % regsize) as u32, (width - 1) as u32)
        } else {
            (lsb as u32, (lsb + width - 1) as u32)
        };
        let base = 0x1300_0000u32 | (opc << 29) | if is64 { 0x8040_0000 } else { 0 };
        return Ok(base | (immr << 16) | (imms << 10) | ((rn as u32) << 5) | (rd as u32));
    }
    // FP/SIMD load/store: `ldr|str St|Dt|Qt, [Xn{, #off | , Rm}]`. These use the
    // FP register file; the immediate offset scales by the access size (4 for s,
    // 8 for d, 16 for q), a register offset feeds Rm with the size-scaled shift.
    if let ("ldr" | "str", [rt_opnd, mem]) = (mnemonic, ops)
        && let Some((rt, log2, imm_base, reg_base)) = fp_ldst_reg(mnemonic, rt_opnd)
    {
        return match mem {
            Opnd::Mem {
                base,
                off,
                pre: false,
            } => {
                let scale = 1i64 << log2;
                if *off < 0 || off % scale != 0 {
                    return Err(String::from(
                        "inline asm: FP load/store offset must be a non-negative multiple of the access size",
                    ));
                }
                let imm = (off / scale) as u32;
                if imm > 0xFFF {
                    return Err(String::from(
                        "inline asm: FP load/store offset out of range",
                    ));
                }
                Ok(imm_base | (imm << 10) | ((*base as u32) << 5) | (rt as u32))
            }
            Opnd::MemReg {
                base,
                index,
                option,
                shift,
            } => {
                let s = match shift {
                    None | Some(0) => 0u32,
                    Some(a) if *a as u32 == log2 => 1,
                    Some(_) => {
                        return Err(String::from(
                            "inline asm: FP load/store register-offset shift must match the access size",
                        ));
                    }
                };
                Ok(reg_base
                    | ((*index as u32) << 16)
                    | ((*option as u32) << 13)
                    | (s << 12)
                    | ((*base as u32) << 5)
                    | (rt as u32))
            }
            _ => Err(String::from("inline asm: bad FP load/store operands")),
        };
    }
    // SIMD multiple-structures load/store `<ld1..ld4|st1..st4> {Vt.T, ..}, [Xn]`
    // with an optional post-index. The structure (1..4, from the mnemonic) and
    // register count select the opcode; L (bit 22) is load vs store, Q and size
    // come from the arrangement, and Rt is the first register of the list. A
    // trailing `, #imm` (increment = list byte size, Rm = 31) or `, Xm` (Rm =
    // Xm) is the writeback form (bit 23), leaving the base register incremented.
    if let "ld1" | "st1" | "ld2" | "st2" | "ld3" | "st3" | "ld4" | "st4" = mnemonic
        && let [
            Opnd::VecList {
                first,
                count,
                size,
                q,
            },
            mem,
            post @ ..,
        ] = ops
    {
        let is_ld = mnemonic.as_bytes()[0] == b'l';
        let structure = mnemonic.as_bytes()[2] - b'0';
        let opcode = match (structure, *count) {
            (1, 1) => 0x7u32,
            (1, 2) => 0xA,
            (1, 3) => 0x6,
            (1, 4) => 0x2,
            (2, 2) => 0x8,
            (3, 3) => 0x4,
            (4, 4) => 0x0,
            _ => {
                return Err(String::from(
                    "inline asm: register count does not match the ld/st structure",
                ));
            }
        };
        let base = match mem {
            Opnd::Mem {
                base,
                off: 0,
                pre: false,
            } => *base,
            _ => {
                return Err(String::from(
                    "inline asm: ld1/st1 need a plain [Xn] address",
                ));
            }
        };
        let (rm, wb) = match post {
            [] => (0u32, 0u32),
            [Opnd::Imm(inc)] => {
                if *inc != (*count as i64) * if *q { 16 } else { 8 } {
                    return Err(String::from(
                        "inline asm: ld1/st1 immediate post-index must equal the list byte size",
                    ));
                }
                (31, 1u32 << 23)
            }
            [
                Opnd::Reg {
                    num, is64: true, ..
                },
            ] => (*num as u32, 1u32 << 23),
            _ => {
                return Err(String::from(
                    "inline asm: bad ld1/st1 post-index (want `, #imm` or `, Xm`)",
                ));
            }
        };
        return Ok(0x0C00_0000
            | wb
            | (if is_ld { 1u32 << 22 } else { 0 })
            | (if *q { 1u32 << 30 } else { 0 })
            | (rm << 16)
            | (opcode << 12)
            | ((*size as u32) << 10)
            | ((base as u32) << 5)
            | (*first as u32));
    }
    // SIMD load-replicate `ld1r..ld4r {Vt.T, ..}, [Xn]{, #inc | , Xm}`: load one
    // element per register and broadcast it to every lane. The count must match
    // the structure; opcode (15..12) is 0xC for 1/2 registers and 0xE for 3/4,
    // with R (bit 21) set for the even counts. An immediate post-index equals the
    // replicated byte size (count << size, Rm = 31), a register post-index gives
    // Rm, and either sets the writeback bit (23).
    if let "ld1r" | "ld2r" | "ld3r" | "ld4r" = mnemonic
        && let [
            Opnd::VecList {
                first,
                count,
                size,
                q,
            },
            mem,
            post @ ..,
        ] = ops
    {
        if *count != mnemonic.as_bytes()[2] - b'0' {
            return Err(String::from(
                "inline asm: ldNr register count must match the structure",
            ));
        }
        let base = match mem {
            Opnd::Mem {
                base,
                off: 0,
                pre: false,
            } => *base,
            _ => return Err(String::from("inline asm: ldNr needs a plain [Xn] address")),
        };
        let (rm, wb) = match post {
            [] => (0u32, 0u32),
            [Opnd::Imm(inc)] => {
                if *inc != (*count as i64) << size {
                    return Err(String::from(
                        "inline asm: ldNr immediate post-index must equal the replicated byte size",
                    ));
                }
                (31, 1u32 << 23)
            }
            [
                Opnd::Reg {
                    num, is64: true, ..
                },
            ] => (*num as u32, 1u32 << 23),
            _ => {
                return Err(String::from(
                    "inline asm: bad ldNr post-index (want `, #imm` or `, Xm`)",
                ));
            }
        };
        let opcode = if *count <= 2 { 0xCu32 } else { 0xE };
        let r_bit = if count % 2 == 0 { 1u32 << 21 } else { 0 };
        return Ok(0x0D40_0000
            | wb
            | r_bit
            | (opcode << 12)
            | (if *q { 1u32 << 30 } else { 0 })
            | (rm << 16)
            | ((*size as u32) << 10)
            | ((base as u32) << 5)
            | (*first as u32));
    }
    // SIMD single-structure lane load/store `<ld1|st1> {Vt.T}[i], [Xn]{, #inc |
    // , Xm}`: transfer one lane. The lane index is bit-sliced across Q (30), S
    // (12), and the size field (11..10): field4 = (index << size) | (size==3 ? 1
    // : 0); the opcode (15..13) is the element class. L (bit 22) marks the load.
    // The immediate post-index increment is the element size (1<<size bytes).
    if let "ld1" | "st1" = mnemonic
        && let [
            Opnd::VecElem {
                num: rt,
                size,
                index,
            },
            mem,
            post @ ..,
        ] = ops
    {
        let base = match mem {
            Opnd::Mem {
                base,
                off: 0,
                pre: false,
            } => *base,
            _ => {
                return Err(String::from(
                    "inline asm: single-lane ld1/st1 need a plain [Xn] address",
                ));
            }
        };
        let (rm, wb) = match post {
            [] => (0u32, 0u32),
            [Opnd::Imm(inc)] => {
                if *inc != 1i64 << size {
                    return Err(String::from(
                        "inline asm: single-lane post-index must equal the element size",
                    ));
                }
                (31, 1u32 << 23)
            }
            [
                Opnd::Reg {
                    num, is64: true, ..
                },
            ] => (*num as u32, 1u32 << 23),
            _ => {
                return Err(String::from(
                    "inline asm: bad single-lane post-index (want `, #imm` or `, Xm`)",
                ));
            }
        };
        let field4 = ((*index as u32) << size) | if *size == 3 { 1 } else { 0 };
        let opcode = if *size == 3 {
            0b100u32
        } else {
            (*size as u32) << 1
        };
        return Ok(0x0D00_0000
            | wb
            | (if mnemonic == "ld1" { 1u32 << 22 } else { 0 })
            | (((field4 >> 3) & 1) << 30)
            | (opcode << 13)
            | (rm << 16)
            | (((field4 >> 2) & 1) << 12)
            | ((field4 & 0b11) << 10)
            | ((base as u32) << 5)
            | (*rt as u32));
    }
    // SHA3 three-source xor `eor3 Vd.16b, Vn.16b, Vm.16b, Va.16b`
    // (FEAT_SHA3): Vd = Vn ^ Vm ^ Va, .16b only.
    if let (
        "eor3",
        [
            Opnd::VecReg {
                num: rd,
                size: 0,
                q: true,
            },
            Opnd::VecReg {
                num: rn,
                size: 0,
                q: true,
            },
            Opnd::VecReg {
                num: rm,
                size: 0,
                q: true,
            },
            Opnd::VecReg {
                num: ra,
                size: 0,
                q: true,
            },
        ],
    ) = (mnemonic, ops)
    {
        return Ok(0xCE00_0000
            | ((*rm as u32) << 16)
            | ((*ra as u32) << 10)
            | ((*rn as u32) << 5)
            | (*rd as u32));
    }
    if mnemonic == "eor3" {
        return Err(String::from("inline asm: eor3 operands must be .16b"));
    }
    // SIMD table lookup `<tbl|tbx> Vd.T, {Vn.16b, ..}, Vm.T` (T = 8b/16b): each
    // byte of the index Vm selects a byte from the table register list. `len`
    // (bits 14..13) is the table count minus one; bit 12 selects tbx (which
    // keeps the destination byte for an out-of-range index) over tbl (zero).
    if let (
        "tbl" | "tbx",
        [
            Opnd::VecReg {
                num: rd,
                size: 0,
                q,
            },
            Opnd::VecList {
                first,
                count,
                size: tsize,
                q: tq,
            },
            Opnd::VecReg {
                num: rm,
                size: 0,
                q: mq,
            },
        ],
    ) = (mnemonic, ops)
    {
        if q != mq {
            return Err(String::from(
                "inline asm: table lookup destination and index must share the arrangement",
            ));
        }
        if *tsize != 0 || !*tq {
            return Err(String::from(
                "inline asm: table lookup registers must be .16b",
            ));
        }
        let op = if mnemonic == "tbx" { 1u32 << 12 } else { 0 };
        return Ok(0x0E00_0000
            | (if *q { 1u32 << 30 } else { 0 })
            | op
            | ((*rm as u32) << 16)
            | (((*count - 1) as u32) << 13)
            | ((*first as u32) << 5)
            | (*rd as u32));
    }
    // `mov` is an alias whose expansion is value-dependent, so the generator
    // omits it. A register move is `orr Rd, xzr, Rm`; a small immediate is
    // `movz Rd, #imm`. The width comes from the resolved destination register.
    // The `mov Rd, sp` / `mov sp, Rd` stack-pointer forms are rewritten to
    // `add ..., #0` earlier (the parser, which can tell `sp` from `xzr`).
    if mnemonic == "mov" {
        // `mov Vd.T, Vn.T` is the vector ORR alias (byte arrangements).
        if let [
            Opnd::VecReg { num: rd, size, q },
            Opnd::VecReg {
                num: rn,
                size: s1,
                q: q1,
            },
        ] = *ops
        {
            if size != 0 || s1 != 0 || q != q1 {
                return Err(String::from("inline asm: vector mov must be 8b/16b"));
            }
            return Ok((if q { 1u32 << 30 } else { 0 })
                | 0x0EA0_1C00
                | ((rn as u32) << 16)
                | ((rn as u32) << 5)
                | (rd as u32));
        }
        match *ops {
            [Opnd::Reg { num: rd, is64, .. }, Opnd::Reg { num: rm, .. }] => {
                let base = if is64 { 0xAA00_03E0u32 } else { 0x2A00_03E0 };
                return Ok(base | ((rm as u32) << 16) | (rd as u32));
            }
            [dst @ Opnd::Reg { is64, .. }, Opnd::Imm(v)] => return encode_mov_imm(dst, is64, v),
            _ => return Err(String::from("inline asm: bad mov operands")),
        }
    }
    // `ror Rd, Rn, #n` is the immediate alias of `extr Rd, Rn, Rn, #n`; the
    // register form (`rorv`) is in the catalogue under the same mnemonic.
    if mnemonic == "ror"
        && let [dst, src @ Opnd::Reg { .. }, imm @ Opnd::Imm(_)] = *ops
    {
        return encode_catalogue("extr", &[dst, src, src, imm]);
    }
    encode_catalogue(mnemonic, ops)
}

/// `mov Rd, #imm`: the move alias the value admits, in the order the
/// architecture prefers -- a 16-bit chunk (`movz`), the complement of one
/// (`movn`), then a bitmask immediate (`orr Rd, ZR, #imm`).
fn encode_mov_imm(dst: Opnd, is64: bool, v: i64) -> Result<u32, String> {
    let width = if is64 { 64u32 } else { 32 };
    let value = if is64 { v as u64 } else { v as u32 as u64 };
    let chunk =
        |x: u64| -> Option<u32> { (0..width / 16).find(|hw| x & !(0xFFFFu64 << (hw * 16)) == 0) };
    for (mnem, x) in [
        ("movz", value),
        ("movn", !value & (u64::MAX >> (64 - width))),
    ] {
        if let Some(hw) = chunk(x) {
            let imm = Opnd::Imm(((x >> (hw * 16)) & 0xFFFF) as i64);
            return encode_catalogue(mnem, &[dst, imm, Opnd::Lsl(hw * 16)]);
        }
    }
    if encode_logical_imm(value, is64).is_some() {
        let zr = Opnd::Reg {
            num: 31,
            is64,
            sp: false,
        };
        return encode_catalogue("orr", &[dst, zr, Opnd::Imm(v)]);
    }
    Err(String::from(
        "inline asm: mov immediate is not a move-wide or bitmask immediate",
    ))
}

/// Look the operand shape up in the generated catalogue and pack it. A form
/// only matches when every written `sp` lands in a slot its `sp` mask marks,
/// which is what selects the extended-register add/sub over the shifted one.
/// The extended-register forms are tried second: an operand list that both
/// can express (no `sp`, no written extend) takes the shifted encoding, as the
/// assembler does.
fn encode_catalogue(mnemonic: &str, ops: &[Opnd]) -> Result<u32, String> {
    // The catalogue is sorted by mnemonic (enforced by the generator and the
    // `catalogue_is_sorted` test): binary-search to the mnemonic's run of forms.
    let forms = super::isa_a64_table::FORMS;
    let start = forms.partition_point(|f| f.mnemonic < mnemonic);
    let mut sp_rejected = false;
    for extended in [false, true] {
        for f in &forms[start..] {
            if f.mnemonic != mnemonic {
                break;
            }
            if f.ops.contains(&A64Op::OptExt) != extended {
                continue;
            }
            // Match, allowing a trailing optional shift/extend slot to be absent.
            let required = f
                .ops
                .iter()
                .filter(|o| !matches!(o, A64Op::OptLsl | A64Op::OptShift | A64Op::OptExt))
                .count();
            if ops.len() < required || ops.len() > f.ops.len() {
                continue;
            }
            if !f
                .ops
                .iter()
                .zip(ops.iter())
                .all(|(&p, &o)| op_matches(p, o))
                || !mem_offsets_consumed(f, ops)
            {
                continue;
            }
            if !sp_slots_allowed(f, ops) {
                sp_rejected = true;
                continue;
            }
            return match pack(f, ops) {
                // An offset the scaled uimm12 field rejects may still have the
                // sibling's unscaled simm9 encoding; keep the scaled form's
                // error when the sibling rejects too.
                Err(e) => match unscaled_sibling(mnemonic) {
                    Some(sib) => encode(sib, ops).map_err(|_| e),
                    None => Err(e),
                },
                ok => ok,
            };
        }
    }
    if sp_rejected {
        return Err(format!(
            "inline asm: `{mnemonic}` reads register 31 as the zero register here, not sp"
        ));
    }
    Err(format!(
        "inline asm: no A64 encoding for `{mnemonic}` with these operands"
    ))
}

/// Base word of a FEAT_MOPS memory copy / set mnemonic, with the destination,
/// size and source fields clear. Measured from GNU as; the suffixes select the
/// stage (`p`/`m`/`e`) and the read/write temporal-hint options.
#[rustfmt::skip]
static MOPS_FORMS: &[(&str, u32)] = &[
    ("cpye", 0x1D800400), ("cpyen", 0x1D80C400), ("cpyern", 0x1D808400),
    ("cpyert", 0x1D802400), ("cpyertwn", 0x1D806400), ("cpyet", 0x1D803400),
    ("cpyetn", 0x1D80F400), ("cpyewn", 0x1D804400), ("cpyewt", 0x1D801400),
    ("cpyfe", 0x19800400), ("cpyfen", 0x1980C400), ("cpyfern", 0x19808400),
    ("cpyfert", 0x19802400), ("cpyfertwn", 0x19806400), ("cpyfet", 0x19803400),
    ("cpyfetn", 0x1980F400), ("cpyfewn", 0x19804400), ("cpyfewt", 0x19801400),
    ("cpyfm", 0x19400400), ("cpyfmn", 0x1940C400), ("cpyfmrn", 0x19408400),
    ("cpyfmrt", 0x19402400), ("cpyfmrtwn", 0x19406400), ("cpyfmt", 0x19403400),
    ("cpyfmtn", 0x1940F400), ("cpyfmwn", 0x19404400), ("cpyfmwt", 0x19401400),
    ("cpyfp", 0x19000400), ("cpyfpn", 0x1900C400), ("cpyfprn", 0x19008400),
    ("cpyfprt", 0x19002400), ("cpyfprtwn", 0x19006400), ("cpyfpt", 0x19003400),
    ("cpyfptn", 0x1900F400), ("cpyfpwn", 0x19004400), ("cpyfpwt", 0x19001400),
    ("cpym", 0x1D400400), ("cpymn", 0x1D40C400), ("cpymrn", 0x1D408400),
    ("cpymrt", 0x1D402400), ("cpymrtwn", 0x1D406400), ("cpymt", 0x1D403400),
    ("cpymtn", 0x1D40F400), ("cpymwn", 0x1D404400), ("cpymwt", 0x1D401400),
    ("cpyp", 0x1D000400), ("cpypn", 0x1D00C400), ("cpyprn", 0x1D008400),
    ("cpyprt", 0x1D002400), ("cpyprtwn", 0x1D006400), ("cpypt", 0x1D003400),
    ("cpyptn", 0x1D00F400), ("cpypwn", 0x1D004400), ("cpypwt", 0x1D001400),
    ("sete", 0x19C08400), ("seten", 0x19C0A400), ("setet", 0x19C09400),
    ("setetn", 0x19C0B400), ("setm", 0x19C04400), ("setmn", 0x19C06400),
    ("setmt", 0x19C05400), ("setmtn", 0x19C07400), ("setp", 0x19C00400),
    ("setpn", 0x19C02400), ("setpt", 0x19C01400), ("setptn", 0x19C03400),
];

/// Look up a memory copy / set base word by mnemonic.
fn mops_base(mnemonic: &str) -> Option<u32> {
    MOPS_FORMS
        .binary_search_by(|(m, _)| (*m).cmp(mnemonic))
        .ok()
        .map(|i| MOPS_FORMS[i].1)
}

/// Every operand written as `sp`/`wsp` must land in a slot the form encodes as
/// the stack pointer.
fn sp_slots_allowed(f: &Form, ops: &[Opnd]) -> bool {
    ops.iter().enumerate().all(|(i, o)| match *o {
        Opnd::Reg { sp: true, .. } => f.sp & (1 << i) != 0,
        _ => true,
    })
}

fn pack(f: &Form, ops: &[Opnd]) -> Result<u32, String> {
    let mut word = f.base;
    for field in f.fields {
        match *field {
            Field::Reg { op, shift } => {
                word |= (reg(ops[op as usize])? as u32 & 31) << shift;
            }
            Field::AddSubImm { op, shift_op } => {
                let v = imm_or_off(ops[op as usize])?;
                let written = match ops.get(shift_op as usize) {
                    None => None,
                    Some(Opnd::Lsl(n @ (0 | 12))) => Some(*n == 12),
                    Some(_) => {
                        return Err(String::from(
                            "inline asm: add/sub immediate shift must be lsl #0 or #12",
                        ));
                    }
                };
                let (v, sh) = match written {
                    Some(sh) => (v, sh),
                    None if (0..=0xFFF).contains(&v) => (v, false),
                    None if v > 0 && v & 0xFFF == 0 && v >> 12 <= 0xFFF => (v >> 12, true),
                    None => {
                        return Err(String::from("inline asm: immediate out of 12-bit range"));
                    }
                };
                if !(0..=0xFFF).contains(&v) {
                    return Err(String::from("inline asm: immediate out of 12-bit range"));
                }
                word |= ((v as u32) << 10) | (u32::from(sh) << 22);
            }
            Field::UImm { op, shift, width } => {
                let v = imm_or_off(ops[op as usize])?;
                let mask = (1u64 << width) - 1;
                if (v as u64) & !mask != 0 {
                    return Err(format!("inline asm: immediate out of {width}-bit range"));
                }
                word |= ((v as u32) & mask as u32) << shift;
            }
            Field::SImm { op, shift, width } => {
                let v = imm_or_off(ops[op as usize])?;
                let lo = -(1i64 << (width - 1));
                let hi = (1i64 << (width - 1)) - 1;
                if v < lo || v > hi {
                    return Err(format!(
                        "inline asm: signed immediate out of {width}-bit range"
                    ));
                }
                let mask = (1u64 << width) - 1;
                word |= (((v as u64) & mask) as u32) << shift;
            }
            Field::ScaledUImm {
                op,
                shift,
                width,
                scale,
            } => {
                let v = imm_or_off(ops[op as usize])?;
                let scale = scale as i64;
                if v < 0 || v % scale != 0 {
                    return Err(format!(
                        "inline asm: offset must be a non-negative multiple of {scale}"
                    ));
                }
                let f = v / scale;
                let mask = (1u64 << width) - 1;
                if (f as u64) & !mask != 0 {
                    return Err(format!(
                        "inline asm: scaled immediate out of {width}-bit range"
                    ));
                }
                word |= ((f as u32) & mask as u32) << shift;
            }
            Field::ScaledSImm {
                op,
                shift,
                width,
                scale,
            } => {
                let v = imm_or_off(ops[op as usize])?;
                let scale = scale as i64;
                if v % scale != 0 {
                    return Err(format!("inline asm: offset must be a multiple of {scale}"));
                }
                let q = v / scale;
                let bound = 1i64 << (width - 1);
                if q < -bound || q >= bound {
                    return Err(format!(
                        "inline asm: scaled offset out of the signed {width}-bit range"
                    ));
                }
                let mask = (1u64 << width) - 1;
                word |= (((q as u64) & mask) as u32) << shift;
            }
            Field::MemRegIdx { op, sl2 } => {
                let Opnd::MemReg {
                    index,
                    option,
                    shift,
                    ..
                } = ops[op as usize]
                else {
                    return Err(String::from(
                        "inline asm: register-offset memory operand expected",
                    ));
                };
                let s = match shift {
                    None => 0u32,
                    Some(0) if sl2 > 0 => 0,
                    Some(a) if a == sl2 => 1,
                    Some(_) => {
                        return Err(String::from(
                            "inline asm: register-offset shift must match the access size",
                        ));
                    }
                };
                word |= ((index as u32) << 16) | ((option as u32) << 13) | (s << 12);
            }
            Field::LogicalImm { op, is64 } => {
                let v = imm(ops[op as usize])? as u64;
                let enc = encode_logical_imm(v, is64)
                    .ok_or_else(|| String::from("inline asm: not a logical immediate"))?;
                word |= enc << 10;
            }
            Field::LogicalImmNot { op, is64 } => {
                let v = imm(ops[op as usize])? as u64;
                let mask = if is64 { u64::MAX } else { 0xFFFF_FFFF };
                let enc = encode_logical_imm(!v & mask, is64)
                    .ok_or_else(|| String::from("inline asm: not a logical immediate"))?;
                word |= enc << 10;
            }
            Field::MovImm { op } => {
                let v = imm(ops[op as usize])?;
                if !(0..=0xFFFF).contains(&v) {
                    return Err(String::from("inline asm: move-wide immediate out of range"));
                }
                word |= (v as u32) << 5;
            }
            Field::MovHw { op } => {
                let s = match ops.get(op as usize) {
                    Some(Opnd::Lsl(s)) => *s,
                    None => 0,
                    _ => return Err(String::from("inline asm: expected lsl shift")),
                };
                if s % 16 != 0 {
                    return Err(String::from(
                        "inline asm: move-wide shift not a multiple of 16",
                    ));
                }
                word |= (s / 16) << 21;
            }
            Field::LslAlias { op, is64 } => {
                let n = imm(ops[op as usize])? as u32;
                let width = if is64 { 64 } else { 32 };
                if n >= width {
                    return Err(String::from("inline asm: shift amount out of range"));
                }
                let immr = (width - n) % width;
                let imms = width - 1 - n;
                word |= (immr << 16) | (imms << 10);
            }
            Field::ShrAlias { op } => {
                let n = imm(ops[op as usize])? as u32;
                word |= (n & 63) << 16;
            }
            Field::Cond { op, inv } => {
                let c = cond(ops[op as usize])?;
                let c = if inv {
                    if c >= 14 {
                        return Err(String::from(
                            "inline asm: al/nv condition is invalid for this alias",
                        ));
                    }
                    c ^ 1
                } else {
                    c
                };
                word |= ((c as u32) & 15) << 12;
            }
            Field::Shift { op, is64, ror } => {
                let (kind, amount) = match ops.get(op as usize) {
                    None => (0u8, 0u32),
                    Some(Opnd::Lsl(n)) => (0, *n),
                    Some(Opnd::Shift { kind, amount }) => (*kind, *amount as u32),
                    Some(_) => return Err(String::from("inline asm: shift operand expected")),
                };
                if kind == 3 && !ror {
                    return Err(String::from(
                        "inline asm: ror is not a valid shift for this instruction",
                    ));
                }
                if amount >= if is64 { 64 } else { 32 } {
                    return Err(String::from("inline asm: shift amount out of range"));
                }
                word |= ((kind as u32) << 22) | (amount << 10);
            }
            Field::Extend { op, rm, is64 } => {
                let ident = if is64 { 3u8 } else { 2 };
                let (option, amount) = match ops.get(op as usize) {
                    None => (ident, 0u8),
                    Some(Opnd::Lsl(n)) => (ident, u8::try_from(*n).unwrap_or(u8::MAX)),
                    Some(Opnd::Extend { option, amount }) => (*option, *amount),
                    Some(_) => return Err(String::from("inline asm: extend operand expected")),
                };
                if amount > 4 {
                    return Err(String::from("inline asm: extend amount out of range"));
                }
                // The option fixes the extended register's width: the
                // doubleword extends (uxtx/sxtx) take an X register, the
                // narrowing ones a W. A 32-bit instruction extends from W
                // whatever the option.
                let want64 = is64 && (option & 3) == 3;
                match ops.get(rm as usize) {
                    Some(Opnd::Reg { is64: w, .. }) if *w == want64 => {}
                    Some(Opnd::Reg { .. }) => {
                        return Err(String::from(
                            "inline asm: extended register width does not match the extend",
                        ));
                    }
                    _ => return Err(String::from("inline asm: extended register expected")),
                }
                word |= ((option as u32) << 13) | ((amount as u32) << 10);
            }
        }
    }
    Ok(word)
}

#[cfg(test)]
mod tests;
