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
    /// A two's-complement signed immediate: `shift` = low bit, `width` = bit
    /// count. Fed by the operand at `op` -- either a plain immediate (`smax`
    /// imm8) or a memory reference's offset (`ldur`/`ldtr` unscaled imm9).
    SImm { op: u8, shift: u8, width: u8 },
    /// The 13-bit logical-immediate bitmask field (`N:immr:imms` at bit 10),
    /// computed from the operand value. `is64` selects the 64/32-bit element.
    LogicalImm { op: u8, is64: bool },
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
}

/// One catalogue entry: a base word and the fields spliced into it.
#[derive(Debug, Clone, Copy)]
pub(crate) struct Form {
    pub mnemonic: &'static str,
    /// Operand shapes this form accepts, in written order.
    pub ops: &'static [A64Op],
    pub base: u32,
    pub fields: &'static [Field],
}

/// Operand-shape a form slot accepts.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum A64Op {
    /// A 64-bit `X` register.
    X,
    /// A 32-bit `W` register.
    W,
    /// An immediate.
    Imm,
    /// An optional `lsl #s` shift (move-wide / add-sub-imm); absent = 0.
    OptLsl,
    /// A condition code.
    Cond,
    /// A base-register memory reference `[Xn|SP]`.
    Mem,
}

/// A resolved operand handed to [`encode`].
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Opnd {
    /// Register: `num` 0..31, `is64` selects X vs W.
    Reg {
        num: u8,
        is64: bool,
    },
    Imm(i64),
    /// An `lsl #shift` modifier operand.
    Lsl(u32),
    /// A system register, as its 15-bit `mrs`/`msr` field
    /// (`(op0-2)<<14 | op1<<11 | CRn<<7 | CRm<<3 | op2`).
    SysReg(u16),
    /// A memory reference `[base, #off]` (`off` in bytes). `off` is signed for
    /// the unscaled/unprivileged imm9 forms; the scaled `ldr`/`str` path treats
    /// it as an unsigned scaled offset.
    Mem {
        base: u8,
        off: i64,
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
        Opnd::Mem { base, .. } => Ok(base),
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
        (A64Op::Imm, Opnd::Imm(_)) => true,
        (A64Op::OptLsl, Opnd::Lsl(_)) => true,
        (A64Op::Cond, Opnd::Cond(_)) => true,
        (A64Op::Mem, Opnd::Mem { .. }) => true,
        _ => false,
    }
}

/// Encode one A64 instruction to its 32-bit word. Operand order is the written
/// (assembly) order. `OptLsl` slots may be omitted by the caller (a missing
/// trailing shift defaults to 0).
pub(crate) fn encode(mnemonic: &str, ops: &[Opnd]) -> Result<u32, String> {
    // System-register move: `mrs Xt, <sysreg>` / `msr <sysreg>, Xt`. The
    // register is always 64-bit; the 15-bit system-register field sits at bit 5.
    if mnemonic == "mrs" || mnemonic == "msr" {
        let (base, rt, field) = match (mnemonic, ops) {
            ("mrs", [Opnd::Reg { num, .. }, Opnd::SysReg(f)]) => (0xD530_0000u32, *num, *f),
            ("msr", [Opnd::SysReg(f), Opnd::Reg { num, .. }]) => (0xD510_0000u32, *num, *f),
            _ => return Err(String::from("inline asm: bad mrs/msr operands")),
        };
        return Ok(base | ((field as u32) << 5) | (rt as u32 & 31));
    }
    // Load / store with an immediate offset: `ldr Xt, [Xn, #off]` etc. The
    // access width comes from the register operand (X vs W).
    if mnemonic == "ldr" || mnemonic == "str" {
        if let [Opnd::Reg { num, is64 }, Opnd::Mem { base, off }] = *ops {
            use super::encode::{Reg, enc_ldr_imm, enc_ldr32_imm, enc_str_imm, enc_str32_imm};
            let rt = Reg(num);
            let rn = Reg(base);
            let off = off as u32; // scaled unsigned offset (imm12)
            return Ok(match (mnemonic, is64) {
                ("ldr", true) => enc_ldr_imm(rt, rn, off),
                ("ldr", false) => enc_ldr32_imm(rt, rn, off),
                ("str", true) => enc_str_imm(rt, rn, off),
                _ => enc_str32_imm(rt, rn, off),
            });
        }
        return Err(String::from("inline asm: bad ldr/str operands"));
    }
    // Load / store pair with a signed, size-scaled offset: `stp Xt1, Xt2,
    // [Xn, #off]`. Both data registers share a width; the offset is a multiple
    // of the access size in the range of a signed 7-bit field.
    if mnemonic == "stp" || mnemonic == "ldp" {
        if let [
            Opnd::Reg { num: t1, is64 },
            Opnd::Reg { num: t2, is64: w2 },
            Opnd::Mem { base, off },
        ] = *ops
        {
            if is64 != w2 {
                return Err(String::from(
                    "inline asm: stp/ldp registers differ in width",
                ));
            }
            let (base_op, scale): (u32, i64) = if is64 {
                (0xA900_0000, 8)
            } else {
                (0x2900_0000, 4)
            };
            if off % scale != 0 {
                return Err(String::from(
                    "inline asm: stp/ldp offset not a multiple of the access size",
                ));
            }
            let imm = off / scale;
            if !(-64..=63).contains(&imm) {
                return Err(String::from("inline asm: stp/ldp offset out of range"));
            }
            let l = if mnemonic == "ldp" { 1u32 << 22 } else { 0 };
            return Ok(base_op
                | l
                | ((imm as u32 & 0x7F) << 15)
                | ((t2 as u32) << 10)
                | ((base as u32) << 5)
                | (t1 as u32));
        }
        return Err(String::from("inline asm: bad stp/ldp operands"));
    }
    // `mov` is an alias whose expansion is value-dependent, so the generator
    // omits it. A register move is `orr Rd, xzr, Rm`; a small immediate is
    // `movz Rd, #imm`. The width comes from the resolved destination register.
    // The `mov Rd, sp` / `mov sp, Rd` stack-pointer forms are rewritten to
    // `add ..., #0` earlier (the parser, which can tell `sp` from `xzr`).
    if mnemonic == "mov" {
        match *ops {
            [Opnd::Reg { num: rd, is64 }, Opnd::Reg { num: rm, .. }] => {
                let base = if is64 { 0xAA00_03E0u32 } else { 0x2A00_03E0 };
                return Ok(base | ((rm as u32) << 16) | (rd as u32));
            }
            [Opnd::Reg { num: rd, is64 }, Opnd::Imm(v)] => {
                if !(0..=0xFFFF).contains(&v) {
                    return Err(String::from(
                        "inline asm: mov immediate out of movz range; use movz/movk/movn",
                    ));
                }
                let base = if is64 { 0xD280_0000u32 } else { 0x5280_0000 };
                return Ok(base | ((v as u32) << 5) | (rd as u32));
            }
            _ => return Err(String::from("inline asm: bad mov operands")),
        }
    }
    // The catalogue is sorted by mnemonic (enforced by the generator and the
    // `catalogue_is_sorted` test): binary-search to the mnemonic's run of forms.
    let forms = super::isa_a64_table::FORMS;
    let start = forms.partition_point(|f| f.mnemonic < mnemonic);
    for f in &forms[start..] {
        if f.mnemonic != mnemonic {
            break;
        }
        // Match, allowing a trailing OptLsl slot to be absent.
        let required = f.ops.iter().filter(|o| **o != A64Op::OptLsl).count();
        if ops.len() < required || ops.len() > f.ops.len() {
            continue;
        }
        if f.ops
            .iter()
            .zip(ops.iter())
            .all(|(&p, &o)| op_matches(p, o))
        {
            return pack(f, ops);
        }
    }
    Err(format!(
        "inline asm: no A64 encoding for `{mnemonic}` with these operands"
    ))
}

fn pack(f: &Form, ops: &[Opnd]) -> Result<u32, String> {
    let mut word = f.base;
    for field in f.fields {
        match *field {
            Field::Reg { op, shift } => {
                word |= (reg(ops[op as usize])? as u32 & 31) << shift;
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
            Field::LogicalImm { op, is64 } => {
                let v = imm(ops[op as usize])? as u64;
                let enc = encode_logical_imm(v, is64)
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
        }
    }
    Ok(word)
}

#[cfg(test)]
mod tests;
