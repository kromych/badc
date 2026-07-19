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
    /// A scaled unsigned immediate offset: the written byte offset must be a
    /// non-negative multiple of `scale`, and the `width`-bit field at `shift`
    /// holds offset/scale (the `ldrh` #imm*2, `ldrsw` #imm*4 loads/stores).
    ScaledUImm {
        op: u8,
        shift: u8,
        width: u8,
        scale: u16,
    },
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
    /// SIMD/FP register: `num` 0..31, `is_d` selects the D (64) vs S (32) view.
    VReg {
        num: u8,
        is_d: bool,
    },
    /// SIMD vector-arrangement register view `vN.T`: `size` is the element-size
    /// log2 (byte 0 .. dword 3), `q` selects the 128- vs 64-bit register.
    VecReg {
        num: u8,
        size: u8,
        q: bool,
    },
    Imm(i64),
    /// An `lsl #shift` modifier operand.
    Lsl(u32),
    /// A system register, as its 15-bit `mrs`/`msr` field
    /// (`(op0-2)<<14 | op1<<11 | CRn<<7 | CRm<<3 | op2`).
    SysReg(u16),
    /// A `dc`/`ic`/`tlbi` system-operation base word (Rt field left zero); the
    /// encoder ORs in the register operand or xzr.
    SysOp(u32),
    /// A memory reference `[base, #off]` (`off` in bytes). `off` is signed for
    /// the unscaled/unprivileged imm9 forms; the scaled `ldr`/`str` path treats
    /// it as an unsigned scaled offset.
    Mem {
        base: u8,
        off: i64,
        /// Pre-index writeback (`[base, #off]!`); the offset-only and scaled
        /// forms leave it false.
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
        // Only the offset form matches: a pre-index `[Xn, #off]!` operand must
        // not silently take an offset-only encoding and drop its writeback. The
        // catalogue carries no writeback forms, so pre-index falls through to a
        // clear "no encoding" error. A register-offset `MemReg` never matches.
        (A64Op::Mem, Opnd::Mem { pre, .. }) => !pre,
        _ => false,
    }
}

/// The `size` (bits 31:30), `opc` (23:22), and access-size log2 of a scalar
/// load/store, or None if the mnemonic is not one. `rt_is64` selects the opc of
/// the sign-extending loads (X target 10, W target 11) and the size of the
/// plain word/dword `ldr`/`str`.
fn ld_st_size_opc(mnem: &str, rt_is64: bool) -> Option<(u32, u32, u8)> {
    let w = if rt_is64 { 3u32 } else { 2 };
    Some(match mnem {
        "strb" => (0, 0, 0),
        "ldrb" => (0, 1, 0),
        "ldrsb" => (0, if rt_is64 { 2 } else { 3 }, 0),
        "strh" => (1, 0, 1),
        "ldrh" => (1, 1, 1),
        "ldrsh" => (1, if rt_is64 { 2 } else { 3 }, 1),
        "str" => (w, 0, w as u8),
        "ldr" => (w, 1, w as u8),
        "ldrsw" => (2, 2, 2),
        _ => return None,
    })
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
    // fmov between a SIMD/FP register and a GP register (bridging the two
    // register files), or an FP-to-FP move. The GP<->FP forms require matching
    // widths (Xd<->Dn, Wd<->Sn); Rn/Rd sit at their usual positions.
    if mnemonic == "fmov" {
        return match ops {
            [Opnd::Reg { num: rd, is64 }, Opnd::VReg { num: vn, is_d }] if is64 == is_d => {
                let base = if *is64 { 0x9E66_0000u32 } else { 0x1E26_0000 };
                Ok(base | ((*vn as u32) << 5) | (*rd as u32))
            }
            [Opnd::VReg { num: vd, is_d }, Opnd::Reg { num: rn, is64 }] if is64 == is_d => {
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
            _ => Err(String::from(
                "inline asm: bad fmov operands (D<->X, S<->W, D<->D, or S<->S)",
            )),
        };
    }
    // FP two-source: `<fadd|fsub|fmul|fdiv|fmax|fmin|fnmul> Vd, Vn, Vm`, all one
    // width. `type` bit 22 selects double; the opcode sits at bit 12.
    if let Some(opc) = match mnemonic {
        "fmul" => Some(0u32),
        "fdiv" => Some(1),
        "fadd" => Some(2),
        "fsub" => Some(3),
        "fmax" => Some(4),
        "fmin" => Some(5),
        "fnmul" => Some(8),
        _ => None,
    } {
        let [
            Opnd::VReg { num: rd, is_d: d0 },
            Opnd::VReg { num: rn, is_d: d1 },
            Opnd::VReg { num: rm, is_d: d2 },
        ] = *ops
        else {
            return Err(String::from("inline asm: bad FP arithmetic operands"));
        };
        if d0 != d1 || d1 != d2 {
            return Err(String::from(
                "inline asm: FP arithmetic operand widths differ",
            ));
        }
        let base = 0x1E20_0800u32 | if d0 { 0x40_0000 } else { 0 };
        return Ok(base | (opc << 12) | ((rm as u32) << 16) | ((rn as u32) << 5) | (rd as u32));
    }
    // FP one-source: `<fneg|fabs|fsqrt> Vd, Vn`, one width (single = double base
    // less the type bit).
    if let Some(base_d) = match mnemonic {
        "fabs" => Some(0x1E60_C000u32),
        "fneg" => Some(0x1E61_4000),
        "fsqrt" => Some(0x1E61_C000),
        _ => None,
    } {
        let [
            Opnd::VReg { num: rd, is_d: d0 },
            Opnd::VReg { num: rn, is_d: d1 },
        ] = *ops
        else {
            return Err(String::from("inline asm: bad FP unary operands"));
        };
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
        let [Opnd::VReg { num: rd, is_d }, Opnd::Reg { num: rn, is64 }] = *ops else {
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
        let [Opnd::Reg { num: rd, is64 }, Opnd::VReg { num: rn, is_d }] = *ops else {
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
    // field carries the element size as a one-hot bit.
    if mnemonic == "dup" {
        let [Opnd::VecReg { num: rd, size, q }, Opnd::Reg { num: rn, .. }] = *ops else {
            return Err(String::from("inline asm: bad dup operands"));
        };
        let imm5 = 1u32 << size;
        return Ok((if q { 1u32 << 30 } else { 0 })
            | 0x0E00_0C00
            | (imm5 << 16)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // SIMD three-same integer ops `Vd.T, Vn.T, Vm.T`, one arrangement:
    // add/sub/mul, the compares cmeq/cmgt/cmge/cmhi/cmhs, and smax/smin/umax/
    // umin. size at bit 22, Q at 30, U at 29, the opcode in the base word. GP
    // add/sub/mul (Reg operands) fall through to the catalogue below.
    if let Some((op_base, u)) = match mnemonic {
        "add" => Some((0x0E20_8400u32, 0u32)),
        "sub" => Some((0x0E20_8400, 1)),
        "mul" => Some((0x0E20_9C00, 0)),
        "cmeq" => Some((0x0E20_8C00, 1)),
        "cmgt" => Some((0x0E20_3400, 0)),
        "cmge" => Some((0x0E20_3C00, 0)),
        "cmhi" => Some((0x0E20_3400, 1)),
        "cmhs" => Some((0x0E20_3C00, 1)),
        "smax" => Some((0x0E20_6400, 0)),
        "smin" => Some((0x0E20_6C00, 0)),
        "umax" => Some((0x0E20_6400, 1)),
        "umin" => Some((0x0E20_6C00, 1)),
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
        return Ok((if q { 1u32 << 30 } else { 0 })
            | op_base
            | (u << 29)
            | ((size as u32) << 22)
            | ((rm as u32) << 16)
            | ((rn as u32) << 5)
            | (rd as u32));
    }
    // SIMD logical `<and|bic|orr|orn|eor> Vd.T, Vn.T, Vm.T`, byte arrangement
    // only; the (U, size) fields select the operation. GP forms (Reg operands)
    // fall through to the catalogue.
    if let Some(variant) = match mnemonic {
        "and" => Some(0u32),
        "bic" => Some(0x0040_0000),
        "orr" => Some(0x0080_0000),
        "orn" => Some(0x00C0_0000),
        "eor" => Some(0x2000_0000),
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
    // System operation: `dc`/`ic`/`tlbi <op>{, Xt}`. The op is a base word; the
    // Rt field takes the register operand or xzr (31) when there is none.
    if let "dc" | "ic" | "tlbi" = mnemonic {
        let (base, rt) = match ops {
            [Opnd::SysOp(b)] => (*b, 31u32),
            [Opnd::SysOp(b), Opnd::Reg { num, .. }] => (*b, *num as u32),
            _ => return Err(String::from("inline asm: bad dc/ic/tlbi operands")),
        };
        return Ok(base | (rt & 31));
    }
    // Bitfield extract / insert aliases of sbfm/bfm/ubfm: the written
    // `Xd, Xn, #lsb, #width` becomes immr/imms. Extract (ubfx/sbfx/bfxil) keeps
    // immr=lsb, imms=lsb+width-1; insert (ubfiz/sbfiz/bfi) sets immr=-lsb mod
    // regsize, imms=width-1. The register width picks the field-mask bit N.
    if let "ubfx" | "sbfx" | "bfxil" | "ubfiz" | "sbfiz" | "bfi" = mnemonic {
        let [
            Opnd::Reg { num: rd, is64 },
            Opnd::Reg { num: rn, is64: n2 },
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
    // Prefetch: `prfm <prfop>, [Xn{, #off | , Rm}]`. The prfop code fills the Rt
    // slot; the immediate offset is scaled by 8, a register offset feeds Rm.
    if mnemonic == "prfm" {
        return match ops {
            [
                Opnd::Imm(code),
                Opnd::Mem {
                    base,
                    off,
                    pre: false,
                },
            ] => {
                if *off < 0 || off % 8 != 0 {
                    return Err(String::from(
                        "inline asm: prfm offset must be a non-negative multiple of 8",
                    ));
                }
                let imm = (off / 8) as u32;
                if imm > 0xFFF {
                    return Err(String::from("inline asm: prfm offset out of range"));
                }
                Ok(0xF980_0000 | (imm << 10) | ((*base as u32) << 5) | (*code as u32 & 31))
            }
            [
                Opnd::Imm(code),
                Opnd::MemReg {
                    base,
                    index,
                    option,
                    shift,
                },
            ] => {
                let s = match shift {
                    None | Some(0) => 0u32,
                    Some(3) => 1,
                    Some(_) => {
                        return Err(String::from(
                            "inline asm: prfm register-offset shift must be 3",
                        ));
                    }
                };
                Ok(0xF8A0_0800
                    | ((*index as u32) << 16)
                    | ((*option as u32) << 13)
                    | (s << 12)
                    | ((*base as u32) << 5)
                    | (*code as u32 & 31))
            }
            _ => Err(String::from("inline asm: bad prfm operands")),
        };
    }
    // FP/SIMD scalar load/store: `ldr|str Dt|St, [Xn{, #off | , Rm}]`. These use
    // the FP register file; the immediate offset scales by the access size (8
    // for d, 4 for s), a register offset feeds Rm with the size-scaled shift.
    if let ("ldr" | "str", [Opnd::VReg { num: rt, is_d }, mem]) = (mnemonic, ops) {
        let is_ld = mnemonic == "ldr";
        let (imm_base, reg_base, log2) = if *is_d {
            (
                if is_ld { 0xFD40_0000u32 } else { 0xFD00_0000 },
                if is_ld { 0xFC60_0800u32 } else { 0xFC20_0800 },
                3u32,
            )
        } else {
            (
                if is_ld { 0xBD40_0000u32 } else { 0xBD00_0000 },
                if is_ld { 0xBC60_0800u32 } else { 0xBC20_0800 },
                2,
            )
        };
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
                Ok(imm_base | (imm << 10) | ((*base as u32) << 5) | (*rt as u32))
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
                    | (*rt as u32))
            }
            _ => Err(String::from("inline asm: bad FP load/store operands")),
        };
    }
    // Load / store with a register offset: `<ldr|ldrb|ldrh|ldrsb|ldrsh|ldrsw|
    // str|strb|strh> Xt, [Xn, Rm{, <ext> #s}]` across the access sizes. The base
    // word is `0x38200800 | size<<30 | opc<<22`; a written shift must be zero or
    // the access-size log2 (the S bit selects the latter).
    if let [
        Opnd::Reg { num: rt, is64 },
        Opnd::MemReg {
            base,
            index,
            option,
            shift,
        },
    ] = ops
        && let Some((size, opc, access_log2)) = ld_st_size_opc(mnemonic, *is64)
    {
        let s = match shift {
            None | Some(0) => 0u32,
            Some(a) if *a == access_log2 => 1,
            Some(_) => {
                return Err(String::from(
                    "inline asm: load/store register-offset shift must match the access size",
                ));
            }
        };
        let base_word = 0x3820_0800u32 | (size << 30) | (opc << 22);
        return Ok(base_word
            | ((*index as u32) << 16)
            | ((*option as u32) << 13)
            | (s << 12)
            | ((*base as u32) << 5)
            | (*rt as u32));
    }
    // Load / store with an immediate offset: `ldr Xt, [Xn, #off]` etc. The
    // access width comes from the register operand (X vs W).
    if mnemonic == "ldr" || mnemonic == "str" {
        // The offset form `[Xn, #off]` scales the unsigned offset by the access
        // size (imm12); the pre-index `[Xn, #off]!` and post-index `[Xn], #off`
        // writeback forms take an unscaled signed byte offset (imm9).
        if let [
            Opnd::Reg { num, is64 },
            Opnd::Mem {
                base,
                off,
                pre: false,
            },
        ] = *ops
        {
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
        let (rt, is64, base, off, pre) = match *ops {
            [
                Opnd::Reg { num, is64 },
                Opnd::Mem {
                    base,
                    off,
                    pre: true,
                },
            ] => (num, is64, base, off, true),
            [
                Opnd::Reg { num, is64 },
                Opnd::Mem {
                    base,
                    off: 0,
                    pre: false,
                },
                Opnd::Imm(o),
            ] => (num, is64, base, o, false),
            _ => return Err(String::from("inline asm: bad ldr/str operands")),
        };
        if !(-256..=255).contains(&off) {
            return Err(String::from(
                "inline asm: ldr/str writeback offset out of range",
            ));
        }
        let size = if is64 { 0xF800_0000u32 } else { 0xB800_0000 };
        let opc = if mnemonic == "ldr" { 0x0040_0000 } else { 0 };
        let idx = if pre { 0xC00u32 } else { 0x400 };
        return Ok(size
            | opc
            | idx
            | ((off as u32 & 0x1FF) << 12)
            | ((base as u32) << 5)
            | (rt as u32));
    }
    // Load / store pair with a signed, size-scaled offset. The index mode is
    // the offset form `[Xn, #off]`, the pre-index `[Xn, #off]!`, or the
    // post-index `[Xn], #off` (the offset a trailing operand). Both data
    // registers share a width; the offset is a multiple of the access size in
    // the range of a signed 7-bit field.
    if mnemonic == "stp" || mnemonic == "ldp" {
        enum Idx {
            Off,
            Pre,
            Post,
        }
        let (t1, t2, is64, base, off, mode) = match *ops {
            [
                Opnd::Reg { num: t1, is64 },
                Opnd::Reg { num: t2, is64: w2 },
                Opnd::Mem { base, off, pre },
            ] if is64 == w2 => (
                t1,
                t2,
                is64,
                base,
                off,
                if pre { Idx::Pre } else { Idx::Off },
            ),
            [
                Opnd::Reg { num: t1, is64 },
                Opnd::Reg { num: t2, is64: w2 },
                Opnd::Mem {
                    base,
                    off: 0,
                    pre: false,
                },
                Opnd::Imm(o),
            ] if is64 == w2 => (t1, t2, is64, base, o, Idx::Post),
            _ => return Err(String::from("inline asm: bad stp/ldp operands")),
        };
        let scale: i64 = if is64 { 8 } else { 4 };
        if off % scale != 0 {
            return Err(String::from(
                "inline asm: stp/ldp offset not a multiple of the access size",
            ));
        }
        let imm = off / scale;
        if !(-64..=63).contains(&imm) {
            return Err(String::from("inline asm: stp/ldp offset out of range"));
        }
        let base_op: u32 = match (is64, mode) {
            (true, Idx::Off) => 0xA900_0000,
            (false, Idx::Off) => 0x2900_0000,
            (true, Idx::Pre) => 0xA980_0000,
            (false, Idx::Pre) => 0x2980_0000,
            (true, Idx::Post) => 0xA880_0000,
            (false, Idx::Post) => 0x2880_0000,
        };
        let l = if mnemonic == "ldp" { 1u32 << 22 } else { 0 };
        return Ok(base_op
            | l
            | ((imm as u32 & 0x7F) << 15)
            | ((t2 as u32) << 10)
            | ((base as u32) << 5)
            | (t1 as u32));
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
