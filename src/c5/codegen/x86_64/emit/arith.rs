use super::*;

/// Map an FP arithmetic [`BinOp`] to its scalar SSE encoder. `is_f32`
/// selects the single-precision (`addss` / ...) vs double-precision
/// (`addsd` / ...) form per C99 6.3.1.8. Returns `None` for any
/// non-FP-arith op.
fn fp_arith_enc_for(op: BinOp, is_f32: bool) -> Option<fn(&mut Vec<u8>, Reg, Reg)> {
    Some(if is_f32 {
        match op {
            BinOp::Fadd => emit_addss,
            BinOp::Fsub => emit_subss,
            BinOp::Fmul => emit_mulss,
            BinOp::Fdiv => emit_divss,
            _ => return None,
        }
    } else {
        match op {
            BinOp::Fadd => emit_addsd,
            BinOp::Fsub => emit_subsd,
            BinOp::Fmul => emit_mulsd,
            BinOp::Fdiv => emit_divsd,
            _ => return None,
        }
    })
}

/// How a `setcc` result needs to be combined with the parity flag
/// for the IEEE-754 NaN semantics required by C99 6.5.9 / 6.5.8.
/// `ucomisd` sets ZF=PF=CF=1 on an unordered (NaN) comparison;
/// a bare `setcc` on Cc::B / Cc::E / Cc::Be / Cc::Ne would then
/// disagree with `!(NaN < x)` / `(NaN != x)`.
#[derive(Clone, Copy)]
enum FpCmpNanFix {
    /// CC already evaluates to 0 on an unordered compare (Cc::A
    /// and Cc::Ae both require CF=0, which NaN never satisfies).
    None,
    /// AND with `setnp` (PF=0) to clear the result when NaN.
    /// Used by `==`, `<`, `<=` per C99 6.5.9p3 / 6.5.8p6.
    AndNotP,
    /// OR with `setp` (PF=1) so the result is 1 on NaN. Used by
    /// `!=` per C99 6.5.9p3.
    OrP,
}

/// Map an FP comparison [`BinOp`] to the x86_64 condition code the
/// matching `ucomisd` + `setcc` pair should use plus the NaN-fix
/// needed after the `setcc`. Returns `None` for any non-FP-compare
/// op.
fn fp_compare_cc(op: BinOp) -> Option<(Cc, FpCmpNanFix)> {
    Some(match op {
        BinOp::Feq => (Cc::E, FpCmpNanFix::AndNotP),
        BinOp::Fne => (Cc::Ne, FpCmpNanFix::OrP),
        BinOp::Flt => (Cc::B, FpCmpNanFix::AndNotP),
        BinOp::Fgt => (Cc::A, FpCmpNanFix::None),
        BinOp::Fle => (Cc::Be, FpCmpNanFix::AndNotP),
        BinOp::Fge => (Cc::Ae, FpCmpNanFix::None),
        _ => return None,
    })
}

/// Operand size in bytes for comparison `v`: 4 when the narrowing
/// analysis proved the answer is decided by the low words
/// (`passes::narrow`), 8 otherwise.
fn cmp_width(alloc: &Allocation, v: super::super::ir::ValueId) -> u8 {
    if crate::c5::codegen::passes::narrow::is_cmp32(&alloc.cmp32, v) {
        4
    } else {
        8
    }
}

/// Map an integer comparison [`BinOp`] to its x86_64 condition code
/// (signed L / G / LE / GE, unsigned B / A / BE / AE per C99 6.5.8).
/// `None` for any non-comparison op.
pub(super) fn int_cmp_cc(op: BinOp) -> Option<Cc> {
    Some(match op {
        BinOp::Eq => Cc::E,
        BinOp::Ne => Cc::Ne,
        BinOp::Lt => Cc::L,
        BinOp::Gt => Cc::G,
        BinOp::Le => Cc::Le,
        BinOp::Ge => Cc::Ge,
        BinOp::Ult => Cc::B,
        BinOp::Ugt => Cc::A,
        BinOp::Ule => Cc::Be,
        BinOp::Uge => Cc::Ae,
        _ => return None,
    })
}

/// After a flags-setting compare: `true` when a fused branch consumes
/// the flags directly and the boolean materialisation is elided, else
/// `setcc` + `movzx` the result into `rd`.
fn finish_int_cmp(
    code: &mut Vec<u8>,
    v: super::super::ir::ValueId,
    cc: Cc,
    rd: Reg,
    alloc: &Allocation,
) -> bool {
    if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
        return true;
    }
    emit_setcc_r8(code, cc, rd);
    emit_movzx_r_r8(code, rd, rd);
    false
}

/// `Inst::Extend { value, kind }` -- sign-extend the low bytes of a
/// GPR value to 64 bits via `MOVSX` / `MOVSXD`.
pub(super) fn emit_extend(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    kind: LoadKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = place_of(alloc, value);
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("Extend: dst not int reg / spill");
    };
    let Some(rn) = materialize_int(code, src_place, rd, frame) else {
        return fail("Extend: value not int reg / spill");
    };
    match kind {
        LoadKind::I8 => super::encode::emit_movsx_r_r8(code, rd, rn),
        LoadKind::I16 => super::encode::emit_movsx_r_r16(code, rd, rn),
        LoadKind::I32 => super::encode::emit_movsxd_r_r(code, rd, rn),
        _ => return fail("Extend: unsupported kind"),
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// `Inst::Copy { value, is_fp }` -- move `value` into this
/// instruction's own place. Bit-exact in both banks, so a
/// single-precision operand keeps its pattern.
pub(super) fn emit_copy(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    is_fp: bool,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = place_of(alloc, value);
    if is_fp {
        let Some(dd) = fp_or_spill_dst(dst, frame) else {
            return fail("Copy: dst not fp reg / spill");
        };
        let Some(dn) = materialize_fp(code, src_place, dd, frame) else {
            return fail("Copy: value not fp reg / spill / int reg");
        };
        if dn.0 != dd.0 {
            emit_movapd_xmm_xmm(code, dd, dn);
        }
        fp_spill_dst_to_slot(code, dst, dd, frame);
    } else {
        let Some(rd) = int_or_spill_dst(dst) else {
            return fail("Copy: dst not int reg / spill");
        };
        let Some(rn) = materialize_int(code, src_place, rd, frame) else {
            return fail("Copy: value not int reg / spill");
        };
        if rd != rn {
            emit_mov_rr(code, rd, rn);
        }
        spill_dst_to_slot(code, dst, rd, frame);
    }
    true
}

/// `Inst::Bswap { value, width }` -- reverse the low `width` bytes,
/// zero-extended. 64-bit: `bswap r64`. 32-bit: `bswap r32` (reads the
/// low dword, zero-extends). 16-bit: `movzx` clears the upper bits the
/// rotate would keep, then `rol dst16, 8` swaps the two low bytes.
pub(super) fn emit_bswap(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    width: u8,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = place_of(alloc, value);
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("Bswap: dst not int reg / spill");
    };
    let Some(rn) = materialize_int(code, src_place, rd, frame) else {
        return fail("Bswap: value not int reg / spill");
    };
    match width {
        2 => {
            super::encode::emit_movzx_r_r16(code, rd, rn);
            emit_shift_ri(code, Mnem::Rol, 2, rd, 8);
        }
        4 => {
            if rd != rn {
                super::encode::emit_mov_r32_r32(code, rd, rn);
            }
            super::encode::emit_bswap_r(code, rd, 4);
        }
        _ => {
            emit_mov_rr(code, rd, rn);
            super::encode::emit_bswap_r(code, rd, 8);
        }
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// `Inst::Fma { a, b, c, neg_product, neg_addend }` -- fused multiply
/// add `dst = (neg_product ? -(a*b) : a*b) + (neg_addend ? -c : c)`
/// with a single rounding (C99 6.5p8 / FP_CONTRACT). FMA3 (Haswell+)
/// is the assumed x86_64 baseline. The `231` form computes
/// `dst = a*b OP dst`, so the addend `c` is staged into `dst` first;
/// the two multiplicands are forced into the scratch xmms outside the
/// allocator pool so that staging `c` cannot clobber them.
pub(super) fn emit_fma(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    a: u32,
    b: u32,
    c: u32,
    neg_product: bool,
    neg_addend: bool,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let is_f32 = alloc.is_f32(v);
    let a_place = place_of(alloc, a);
    let b_place = place_of(alloc, b);
    let c_place = place_of(alloc, c);
    let Some(ra) = materialize_fp(code, a_place, Reg(frame.fp_scratch[0]), frame) else {
        return fail("Fma: a not fp reg / spill / int reg");
    };
    if ra.0 != frame.fp_scratch[0] {
        emit_movapd_xmm_xmm(code, Reg(frame.fp_scratch[0]), ra);
    }
    let Some(rb) = materialize_fp(code, b_place, Reg(frame.fp_scratch[1]), frame) else {
        return fail("Fma: b not fp reg / spill / int reg");
    };
    if rb.0 != frame.fp_scratch[1] {
        emit_movapd_xmm_xmm(code, Reg(frame.fp_scratch[1]), rb);
    }
    // The destination also supplies the accumulator. A spilled result
    // routes through a third scratch outside the pool.
    let dd = match dst {
        Place::FpReg(r) => Reg(r),
        Place::Spill(_) => Reg(frame.fp_scratch[2]),
        _ => return fail("Fma: dst not fp reg / spill"),
    };
    let Some(rc) = materialize_fp(code, c_place, dd, frame) else {
        return fail("Fma: c not fp reg / spill / int reg");
    };
    if rc.0 != dd.0 {
        emit_movapd_xmm_xmm(code, dd, rc);
    }
    let (a14, b15) = (Reg(frame.fp_scratch[0]), Reg(frame.fp_scratch[1]));
    match (neg_product, neg_addend, is_f32) {
        (false, false, false) => emit_vfmadd231sd(code, dd, a14, b15),
        (false, true, false) => emit_vfmsub231sd(code, dd, a14, b15),
        (true, false, false) => emit_vfnmadd231sd(code, dd, a14, b15),
        (true, true, false) => emit_vfnmsub231sd(code, dd, a14, b15),
        (false, false, true) => emit_vfmadd231ss(code, dd, a14, b15),
        (false, true, true) => emit_vfmsub231ss(code, dd, a14, b15),
        (true, false, true) => emit_vfnmadd231ss(code, dd, a14, b15),
        (true, true, true) => emit_vfnmsub231ss(code, dd, a14, b15),
    }
    fp_spill_dst_to_slot(code, dst, dd, frame);
    true
}

/// `Inst::MulAdd { a, b, c, neg_product }` -- x86-64 has no
/// three-operand integer multiply-accumulate, so the node lowers back
/// to the `imul` plus `add` / `sub` pair. The two-operand `imul`
/// overwrites its destination, which cannot be `rd` (still to receive
/// `c`), so the product forms in a multiplicand's own register when
/// this instruction is that value's last reader -- the register the
/// allocator would have given the separate product -- and in
/// `SCRATCH_R11` otherwise. Both multiplicands are consumed before `c`
/// is staged, so `rd` may hold either of them.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_mul_add(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    a: u32,
    b: u32,
    c: u32,
    neg_product: bool,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("MulAdd: dst not int reg / spill");
    };
    let (pa, pb, pc) = (place_of(alloc, a), place_of(alloc, b), place_of(alloc, c));
    let dies_here = |val: u32| alloc.last_use.get(val as usize).copied() == Some(v);
    // `c + a*b` with the addend elsewhere can multiply into the
    // destination and add in place; `c - a*b` needs the destination
    // for the addend, so its product goes to a multiplicand's own
    // register when this instruction is that value's last reader, and
    // to the fixed scratch otherwise.
    let into_dst = !neg_product && pc != Place::IntReg(rd.0);
    let (rp, other) = if into_dst && pb == Place::IntReg(rd.0) {
        (rd, pa)
    } else if into_dst {
        let Some(ra) = materialize_int(code, pa, rd, frame) else {
            return fail("MulAdd: a not int reg / spill");
        };
        if ra.0 != rd.0 {
            emit_mov_rr(code, rd, ra);
        }
        (rd, pb)
    } else if let Some(pair) =
        [(a, pa, pb), (b, pb, pa)]
            .into_iter()
            .find_map(|(val, place, other)| match place {
                Place::IntReg(r) if dies_here(val) && r != rd.0 && pc != Place::IntReg(r) => {
                    Some((Reg(r), other))
                }
                _ => None,
            })
    {
        pair
    } else {
        let Some(ra) = materialize_int(code, pa, SCRATCH_R11, frame) else {
            return fail("MulAdd: a not int reg / spill");
        };
        if ra.0 != SCRATCH_R11.0 {
            emit_mov_rr(code, SCRATCH_R11, ra);
        }
        (SCRATCH_R11, pb)
    };
    let Some(rm) = materialize_int(code, other, SCRATCH_R10, frame) else {
        return fail("MulAdd: multiplicand not int reg / spill");
    };
    emit_rr(code, Mnem::Imul, 8, rp, rm);
    // With the product in the destination the addend joins it there,
    // and a spilled addend reloads into the scratch that path left
    // free; otherwise the destination takes the addend first. Either
    // way the multiplicands are already consumed.
    let landing = if rp.0 == rd.0 { SCRATCH_R11 } else { rd };
    let Some(rc) = materialize_int(code, pc, landing, frame) else {
        return fail("MulAdd: c not int reg / spill");
    };
    if rp.0 == rd.0 {
        emit_rr(code, Mnem::Add, 8, rd, rc);
    } else {
        if rc.0 != rd.0 {
            emit_mov_rr(code, rd, rc);
        }
        emit_rr(
            code,
            if neg_product { Mnem::Sub } else { Mnem::Add },
            8,
            rd,
            rp,
        );
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// `Inst::Fneg(v)` -- flip the IEEE 754 sign bit. For a `double`
/// the mask is `1 << 63`; for a single-precision value (C99 6.3.1.8)
/// the mask is `1 << 31`, flipping the sign bit of the f32 held in
/// the low dword. Builds the mask on the fly into the second FP scratch
/// (movq xmm, r10 after loading the immediate into r10) and xors in
/// place.
pub(super) fn emit_fneg(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = place_of(alloc, value);
    let Some(dd) = fp_or_spill_dst(dst, frame) else {
        return fail("Fneg: dst not fp reg / spill");
    };
    let Some(dn) = materialize_fp(code, src_place, dd, frame) else {
        return fail("Fneg: value not fp reg / spill / int reg");
    };
    if dn.0 != dd.0 {
        emit_movapd_xmm_xmm(code, dd, dn);
    }
    // Build the sign-bit mask in an integer scratch and transfer to
    // the second FP scratch, then xorpd in place. r10 is reserved outside both
    // allocator banks and holds nothing live on this path (Fneg reads
    // only its FP `value`), so the mask load clobbers no allocator
    // value.
    let scratch_int = SCRATCH_R10;
    let mask: i64 = if alloc.is_f32(v) {
        0x8000_0000
    } else {
        i64::MIN
    };
    emit_mov_r_imm64(code, scratch_int, mask);
    emit_movq_xmm_r(code, Reg(frame.fp_scratch[1]), scratch_int);
    emit_xorpd(code, dd, Reg(frame.fp_scratch[1]));
    fp_spill_dst_to_slot(code, dst, dd, frame);
    true
}

/// `sqrt` / `fabs` intrinsic -- a unary FP operation lowering to a
/// single hardware instruction. `sqrt` uses `SQRTSD` / `SQRTSS`; `fabs`
/// clears the IEEE 754 sign bit by AND-ing with the inverted-sign mask
/// (C99 7.12.7), built in an integer scratch and transferred to
/// the second FP scratch, mirroring `emit_fneg`.
pub(super) fn emit_fp_unary(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    value: u32,
    kind: super::super::op::Intrinsic,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    use super::super::op::Intrinsic as I;
    use super::encode::{emit_andpd, emit_roundsd, emit_roundss, emit_sqrtsd, emit_sqrtss};
    let src_place = place_of(alloc, value);
    let Some(dd) = fp_or_spill_dst(dst, frame) else {
        return fail("fp_unary: dst not fp reg / spill");
    };
    let Some(dn) = materialize_fp(code, src_place, dd, frame) else {
        return fail("fp_unary: value not fp reg / spill / int reg");
    };
    let is_f32 = alloc.is_f32(v);
    match kind {
        I::Sqrt | I::Sqrtf => {
            if is_f32 {
                emit_sqrtss(code, dd, dn);
            } else {
                emit_sqrtsd(code, dd, dn);
            }
        }
        I::Fabs | I::Fabsf => {
            if dn.0 != dd.0 {
                emit_movapd_xmm_xmm(code, dd, dn);
            }
            let mask: i64 = if is_f32 { 0x7fff_ffff } else { i64::MAX };
            emit_mov_r_imm64(code, SCRATCH_R10, mask);
            emit_movq_xmm_r(code, Reg(frame.fp_scratch[1]), SCRATCH_R10);
            emit_andpd(code, dd, Reg(frame.fp_scratch[1]));
        }
        I::Floor | I::Floorf | I::Ceil | I::Ceilf | I::Trunc | I::Truncf => {
            // ROUNDSD/ROUNDSS rounding-mode immediate, with bit 3 set to
            // suppress the precision (inexact) exception: 0x09 floor
            // (toward -inf), 0x0A ceil (toward +inf), 0x0B trunc (toward
            // zero).
            let imm: u8 = match kind {
                I::Floor | I::Floorf => 0x09,
                I::Ceil | I::Ceilf => 0x0A,
                _ => 0x0B,
            };
            if is_f32 {
                emit_roundss(code, dd, dn, imm);
            } else {
                emit_roundsd(code, dd, dn, imm);
            }
        }
        _ => return fail("fp_unary: not a unary FP intrinsic"),
    }
    fp_spill_dst_to_slot(code, dst, dd, frame);
    true
}

/// `Inst::FpCast { kind, value }` -- int <-> f64 conversion. For
/// `IntToFp`, `CVTSI2SD` widens a signed 64-bit GPR into an xmm.
/// For `FpToInt`, `CVTTSD2SI` rounds-to-zero an xmm into a 64-bit
/// signed int.
pub(super) fn emit_fp_cast(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    kind: FpCastKind,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = place_of(alloc, value);
    match kind {
        FpCastKind::IntToFp => {
            let Some(rn) = materialize_int(code, src_place, SCRATCH_R10, frame) else {
                return fail("FpCast IntToFp: value not int reg / spill");
            };
            let Some(dd) = fp_or_spill_dst(dst, frame) else {
                return fail("FpCast IntToFp: dst not fp reg / spill");
            };
            // Break the false dependency `cvtsi2*` carries on the
            // destination's prior contents (it merges into the low
            // element, leaving a read-after-write chain otherwise).
            emit_xorps(code, dd, dd);
            // C99 6.3.1.4: a `float` result converts directly to single
            // precision (one rounding) rather than to double + narrow.
            if alloc.is_f32(v) {
                emit_cvtsi2ss(code, dd, rn);
            } else {
                emit_cvtsi2sd(code, dd, rn);
            }
            fp_spill_dst_to_slot(code, dst, dd, frame);
            true
        }
        FpCastKind::UIntToFp => {
            // Unsigned 64-bit to double. SSE2 has no unsigned convert
            // before AVX512: when bit 63 is clear the signed convert is
            // exact; otherwise halve the value -- OR-ing the discarded
            // low bit back in as the sticky bit so the narrowing rounds
            // correctly -- convert, and double.
            let Some(src) = materialize_int(code, src_place, SCRATCH_R10, frame) else {
                return fail("FpCast UIntToFp: value not int reg / spill");
            };
            let Some(dd) = fp_or_spill_dst(dst, frame) else {
                return fail("FpCast UIntToFp: dst not fp reg / spill");
            };
            // Modifiable scratch copies so a live source register is not
            // clobbered by the shift/and below.
            let rn = SCRATCH_R10;
            let t = SCRATCH_R11;
            // C99 6.3.1.4: a `float` result converts in single precision.
            let res_f32 = alloc.is_f32(v);
            // Break the false dependency the converts carry on `dd`;
            // covers both branch targets since it precedes the test.
            emit_xorps(code, dd, dd);
            emit_mov_rr(code, rn, src);
            emit_rr(code, Mnem::Test, 8, rn, rn);
            emit_jcc_rel8(code, Cc::S, 0);
            let js_fixup = code.len() - 1;
            if res_f32 {
                emit_cvtsi2ss(code, dd, rn);
            } else {
                emit_cvtsi2sd(code, dd, rn);
            }
            emit_jmp_rel8(code, 0);
            let jmp_fixup = code.len() - 1;
            let big = code.len();
            code[js_fixup] = (big - js_fixup - 1) as i8 as u8;
            emit_mov_rr(code, t, rn);
            emit_shift_ri(code, Mnem::Shr, 8, t, 1);
            emit_ri(code, Mnem::And, 8, rn, 1);
            emit_rr(code, Mnem::Or, 8, t, rn);
            if res_f32 {
                emit_cvtsi2ss(code, dd, t);
                emit_addss(code, dd, dd);
            } else {
                emit_cvtsi2sd(code, dd, t);
                emit_addsd(code, dd, dd);
            }
            let done = code.len();
            code[jmp_fixup] = (done - jmp_fixup - 1) as i8 as u8;
            fp_spill_dst_to_slot(code, dst, dd, frame);
            true
        }
        FpCastKind::FpToInt => {
            let Some(dn) = materialize_fp(code, src_place, Reg(frame.fp_scratch[0]), frame) else {
                return fail("FpCast FpToInt: value not fp reg / spill / int reg");
            };
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("FpCast FpToInt: dst not int reg / spill");
            };
            // C99 6.3.1.4: a `float` source truncates directly to the
            // integer (`cvttss2si` reads the single in the low dword)
            // rather than widening to double first.
            if alloc.is_f32(value) {
                emit_cvttss2si(code, rd, dn);
            } else {
                emit_cvttsd2si(code, rd, dn);
            }
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        FpCastKind::UFpToInt => {
            // Double to unsigned 64-bit. SSE2 `cvttsd2si` is signed: a
            // value in [2^63, 2^64) saturates to the integer
            // indefinite. Compare with 2^63: below it the signed
            // truncate is exact; at or above, subtract 2^63, truncate
            // the in-range remainder, and set bit 63.
            let Some(src_xmm) = materialize_fp(code, src_place, Reg(frame.fp_scratch[0]), frame)
            else {
                return fail("FpCast UFpToInt: value not fp reg / spill / int reg");
            };
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("FpCast UFpToInt: dst not int reg / spill");
            };
            // Modifiable copy so the `subsd` below cannot clobber a
            // live source xmm.
            let dn = Reg(frame.fp_scratch[0]);
            emit_movapd_xmm_xmm(code, dn, src_xmm);
            let two63 = Reg(frame.fp_scratch[1]);
            emit_mov_r_imm64(code, SCRATCH_R11, 0x43E0000000000000u64 as i64);
            emit_movq_xmm_r(code, two63, SCRATCH_R11);
            emit_ucomisd(code, dn, two63);
            emit_jcc_rel8(code, Cc::Ae, 0);
            let jae_fixup = code.len() - 1;
            emit_cvttsd2si(code, rd, dn);
            emit_jmp_rel8(code, 0);
            let jmp_fixup = code.len() - 1;
            let big = code.len();
            code[jae_fixup] = (big - jae_fixup - 1) as i8 as u8;
            emit_subsd(code, dn, two63);
            emit_cvttsd2si(code, rd, dn);
            emit_mov_r_imm64(code, SCRATCH_R11, 0x8000000000000000u64 as i64);
            emit_rr(code, Mnem::Or, 8, rd, SCRATCH_R11);
            let done = code.len();
            code[jmp_fixup] = (done - jmp_fixup - 1) as i8 as u8;
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        // C99 6.3.1.5: widen single to double (`cvtss2sd`) or narrow
        // double to single (`cvtsd2ss`). The single value lives in the
        // low dword of the xmm; `cvtss2sd` reads it, `cvtsd2ss` writes
        // it, so both are register-to-register with no separate move.
        FpCastKind::F32ToF64 => {
            let Some(dn) = materialize_fp(code, src_place, Reg(frame.fp_scratch[0]), frame) else {
                return fail("FpCast F32ToF64: value not fp reg / spill / int reg");
            };
            let Some(dd) = fp_or_spill_dst(dst, frame) else {
                return fail("FpCast F32ToF64: dst not fp reg / spill");
            };
            emit_cvtss2sd(code, dd, dn);
            fp_spill_dst_to_slot(code, dst, dd, frame);
            true
        }
        FpCastKind::F64ToF32 => {
            let Some(dn) = materialize_fp(code, src_place, Reg(frame.fp_scratch[0]), frame) else {
                return fail("FpCast F64ToF32: value not fp reg / spill / int reg");
            };
            let Some(dd) = fp_or_spill_dst(dst, frame) else {
                return fail("FpCast F64ToF32: dst not fp reg / spill");
            };
            emit_cvtsd2ss(code, dd, dn);
            fp_spill_dst_to_slot(code, dst, dd, frame);
            true
        }
    }
}

/// The two-operand ALU mnemonic of `op`; `None` for a compare, a shift or
/// an rdx:rax op.
fn alu_mnem(op: BinOp) -> Option<Mnem> {
    Some(match op {
        BinOp::Add => Mnem::Add,
        BinOp::Sub => Mnem::Sub,
        BinOp::Mul => Mnem::Imul,
        BinOp::And => Mnem::And,
        BinOp::Or => Mnem::Or,
        BinOp::Xor => Mnem::Xor,
        _ => return None,
    })
}

fn shift_mnem(op: BinOp) -> Mnem {
    match op {
        BinOp::Shl => Mnem::Shl,
        BinOp::Shr => Mnem::Sar,
        BinOp::Shru => Mnem::Shr,
        BinOp::Ror => Mnem::Ror,
        _ => unreachable!("shift_mnem: non-shift op {op:?}"),
    }
}

/// Stage the lhs into the destination of a two-operand op.
fn stage_lhs(code: &mut Vec<u8>, rd: Reg, rn: Reg) {
    if rd.0 != rn.0 {
        emit_mov_rr(code, rd, rn);
    }
}

#[allow(clippy::too_many_arguments)]
pub(super) fn emit_binop(
    code: &mut Vec<u8>,
    op: BinOp,
    v: super::super::ir::ValueId,
    dst: Place,
    lhs: u32,
    rhs: u32,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let lhs_place = place_of(alloc, lhs);
    let rhs_place = place_of(alloc, rhs);
    if let Some(arith) = fp_arith_enc_for(op, alloc.is_f32(v)) {
        return emit_fp_binop(code, arith, dst, lhs_place, rhs_place, frame);
    }
    if let Some((cc, nan_fix)) = fp_compare_cc(op) {
        return emit_fp_compare(code, op, v, dst, lhs, rhs, cc, nan_fix, alloc, frame);
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("Binop: dst not int reg / spill");
    };
    // The walker's sign-narrow pair `Binop(Shl, X, Imm(K)); Binop(Shr, _,
    // Imm(K))`: the allocator marked this Shr and stashed K (32 / 48 / 56),
    // so one movsxd / movsx replaces the two shifts.
    let sxtw_source = alloc
        .sxtw_source
        .get(v as usize)
        .copied()
        .unwrap_or(super::super::ir::NO_VALUE);
    if sxtw_source != super::super::ir::NO_VALUE {
        let src_place = place_of(alloc, sxtw_source);
        let Some(src_reg) = int_operand_into_rd(code, src_place, rd, frame) else {
            return fail("Binop sxtw: src not int reg / spill");
        };
        let k = alloc.sxtw_k.get(v as usize).copied().unwrap_or(0);
        match k {
            32 => super::encode::emit_movsxd_r_r(code, rd, src_reg),
            48 => super::encode::emit_movsx_r_r16(code, rd, src_reg),
            56 => super::encode::emit_movsx_r_r8(code, rd, src_reg),
            _ => return fail("Binop sxtw: unexpected K"),
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    if let Place::Spill(rhs_slot) = rhs_place
        && let Some(done) =
            emit_binop_spilled_rhs(code, op, v, dst, rd, lhs_place, rhs_slot, alloc, frame)
    {
        return done;
    }
    emit_int_binop(code, op, v, dst, rd, lhs_place, rhs_place, alloc, frame)
}

/// Scalar FP arithmetic in xmm. `op dst, rhs` overwrites dst, so rhs is
/// captured into a register distinct from dst before lhs is staged into
/// dst: the allocator can color rhs to dst's xmm, and `materialize_fp`
/// returns an `FpReg` source in place, so rhs is copied into the second FP
/// scratch when it aliases dst.
fn emit_fp_binop(
    code: &mut Vec<u8>,
    arith: fn(&mut Vec<u8>, Reg, Reg),
    dst: Place,
    lhs_place: Place,
    rhs_place: Place,
    frame: Frame,
) -> bool {
    let Some(dd) = fp_or_spill_dst(dst, frame) else {
        return fail("Fbinop: dst not fp reg / spill");
    };
    let dm = match rhs_place {
        Place::FpReg(r) if r == dd.0 => {
            emit_movapd_xmm_xmm(code, Reg(frame.fp_scratch[1]), dd);
            Reg(frame.fp_scratch[1])
        }
        _ => match materialize_fp(code, rhs_place, Reg(frame.fp_scratch[1]), frame) {
            Some(r) => r,
            None => return fail("Fbinop: rhs not fp reg / spill / int reg"),
        },
    };
    let Some(dn) = materialize_fp(code, lhs_place, dd, frame) else {
        return fail("Fbinop: lhs not fp reg / spill / int reg");
    };
    if dn.0 != dd.0 {
        emit_movapd_xmm_xmm(code, dd, dn);
    }
    arith(code, dd, dm);
    fp_spill_dst_to_slot(code, dst, dd, frame);
    true
}

/// FP comparison: `ucomisd` / `ucomiss` sets ZF / CF / PF, PF=1 signalling
/// an unordered (NaN) compare. C99 6.5.9p3 / 6.5.8p6 require `==`, `<`,
/// `<=` to yield 0 on NaN and `!=` to yield 1, so the cc-only `setcc`
/// takes an explicit AND-with-`setnp` / OR-with-`setp` fixup. A fused
/// branch reads the flags instead.
#[allow(clippy::too_many_arguments)]
fn emit_fp_compare(
    code: &mut Vec<u8>,
    op: BinOp,
    v: super::super::ir::ValueId,
    dst: Place,
    lhs: u32,
    rhs: u32,
    cc: Cc,
    nan_fix: FpCmpNanFix,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let Some(dn) = materialize_fp(code, place_of(alloc, lhs), Reg(frame.fp_scratch[0]), frame)
    else {
        return fail("Fcmp: lhs not fp reg / spill / int reg");
    };
    let Some(dm) = materialize_fp(code, place_of(alloc, rhs), Reg(frame.fp_scratch[1]), frame)
    else {
        return fail("Fcmp: rhs not fp reg / spill / int reg");
    };
    // A fused `Flt` / `Fle` compares with the operands swapped so the
    // branch takes the parity-clean `A` / `Ae` shapes.
    let fused = alloc.branch_fused.get(v as usize).copied().unwrap_or(false);
    let (dn, dm) = if fused && fused_fp_swaps_operands(op) {
        (dm, dn)
    } else {
        (dn, dm)
    };
    // The compare width follows the operands' precision (C99 6.3.1.8).
    if alloc.is_f32(lhs) || alloc.is_f32(rhs) {
        emit_ucomiss(code, dn, dm);
    } else {
        emit_ucomisd(code, dn, dm);
    }
    if fused {
        return true;
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("Fcmp: dst not int reg / spill");
    };
    emit_setcc_r8(code, cc, rd);
    emit_movzx_r_r8(code, rd, rd);
    match nan_fix {
        FpCmpNanFix::None => {}
        FpCmpNanFix::AndNotP | FpCmpNanFix::OrP => {
            // r10 / r11 hold nothing live on this path (both operands are
            // in xmm), so one of them is disjoint from `rd`.
            let scratch = if rd.0 == SCRATCH_R10.0 {
                SCRATCH_R11
            } else {
                SCRATCH_R10
            };
            let and_not_p = matches!(nan_fix, FpCmpNanFix::AndNotP);
            let fix_cc = if and_not_p { Cc::Np } else { Cc::P };
            emit_setcc_r8(code, fix_cc, scratch);
            emit_movzx_r_r8(code, scratch, scratch);
            let mnem = if and_not_p { Mnem::And } else { Mnem::Or };
            emit_rr(code, mnem, 8, rd, scratch);
        }
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// A spilled second operand of an arithmetic or compare op is read in
/// place through the op's memory-source form, so it needs no scratch
/// register (a scratch could hold a live lhs under high pressure). Shifts
/// are excluded: x86 reads the shift count from cl. `None` when the op
/// takes the register path.
#[allow(clippy::too_many_arguments)]
fn emit_binop_spilled_rhs(
    code: &mut Vec<u8>,
    op: BinOp,
    v: super::super::ir::ValueId,
    dst: Place,
    rd: Reg,
    lhs_place: Place,
    rhs_slot: u32,
    alloc: &Allocation,
    frame: Frame,
) -> Option<bool> {
    let (rhs_base, rhs_off) = spill_slot_addr(frame, rhs_slot);
    let cmp_cc = int_cmp_cc(op);
    let arith = matches!(
        op,
        BinOp::Add | BinOp::Sub | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor
    );
    if !arith && cmp_cc.is_none() {
        return None;
    }
    let Some(rn) = int_operand_into_rd(code, lhs_place, rd, frame) else {
        return Some(fail("Binop: lhs not int reg / spill"));
    };
    if let Some(cc) = cmp_cc {
        emit_rm(code, Mnem::Cmp, cmp_width(alloc, v), rn, rhs_base, rhs_off);
        if finish_int_cmp(code, v, cc, rd, alloc) {
            return Some(true);
        }
    } else {
        if rd.0 != rn.0 {
            emit_mov_rr(code, rd, rn);
        }
        match op {
            BinOp::Add => emit_rm(code, Mnem::Add, 8, rd, rhs_base, rhs_off),
            BinOp::Sub => emit_rm(code, Mnem::Sub, 8, rd, rhs_base, rhs_off),
            BinOp::Mul => emit_imul_r_mem(code, rd, rhs_base, rhs_off),
            BinOp::And => emit_rm(code, Mnem::And, 8, rd, rhs_base, rhs_off),
            BinOp::Or => emit_rm(code, Mnem::Or, 8, rd, rhs_base, rhs_off),
            BinOp::Xor => emit_rm(code, Mnem::Xor, 8, rd, rhs_base, rhs_off),
            _ => unreachable!(),
        }
    }
    spill_dst_to_slot(code, dst, rd, frame);
    Some(true)
}

/// The two-operand integer path: stage lhs into rd, then `OP rd, rm`.
#[allow(clippy::too_many_arguments)]
fn emit_int_binop(
    code: &mut Vec<u8>,
    op: BinOp,
    v: super::super::ir::ValueId,
    dst: Place,
    rd: Reg,
    lhs_place: Place,
    rhs_place: Place,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    // Stage lhs into rd first, so the two-operand ops below can
    // `op rd, rm` and land the result in rd. A spilled rhs for an
    // arithmetic or compare op was already handled in place above; the
    // remaining spilled-rhs case is a shift, whose count this scratch
    // carries. A register rhs needs the scratch only to preserve itself
    // when it aliases rd.
    //
    // The scratch must not be rcx for a shift: the shift count is moved
    // into rcx (cl) by the shift arm below, which preserves any live SSA
    // value the allocator parked in rcx with a push / pop around that
    // move. Materialising a spilled count straight into rcx here would
    // overwrite that live value before the push could save it. r11 is
    // reserved outside both allocator banks (see the `SCRATCH_R10`
    // note), so it is always a safe count scratch; the non-shift path
    // keeps the cheaper r10 / rcx choice.
    let is_shift = matches!(op, BinOp::Shl | BinOp::Shr | BinOp::Shru | BinOp::Ror);
    let rhs_scratch = if is_shift {
        if rd.0 == SCRATCH_R10.0 {
            SCRATCH_R11
        } else {
            SCRATCH_R10
        }
    } else if rd.0 == SCRATCH_R10.0 {
        Reg::RCX
    } else {
        SCRATCH_R10
    };
    let rhs_aliases_rd = matches!(rhs_place, Place::IntReg(r) if r == rd.0);
    // When the allocator places both rhs and dst in the same register
    // and lhs is spilled, the lhs spill-load below writes rd before
    // any rhs-staging mov runs, destroying the rhs value. Preserve
    // rhs into the scratch first so the downstream
    // rhs_aliases_rd / stage_rhs_to_scratch paths read the right
    // operand.
    let rhs_preserved_in_scratch = rhs_aliases_rd && matches!(lhs_place, Place::Spill(_));
    if rhs_preserved_in_scratch {
        emit_mov_rr(code, rhs_scratch, rd);
    }
    let Some(rn) = int_operand_into_rd(code, lhs_place, rd, frame) else {
        return fail("Binop: lhs not int reg / spill");
    };
    // Div / Mod / Mulh / Mulhu hijack rax + rdx (SDM: IDIV's implicit
    // operand is rdx:rax and the result is rax (quot), rdx (rem);
    // one-operand IMUL / MUL multiply rax and write rdx:rax). They
    // need their own marshalling separate from the two-operand
    // path below.
    if matches!(
        op,
        BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu | BinOp::Mulh | BinOp::Mulhu
    ) {
        // When the rhs aliased rd and was saved into the scratch
        // above (because the spilled lhs load just overwrote rd), it
        // now lives in that scratch register, not its original
        // place; reading the original place would take the lhs as the
        // second operand.
        let rhs_place = if rhs_preserved_in_scratch {
            Place::IntReg(rhs_scratch.0)
        } else {
            rhs_place
        };
        return emit_binop_rdx_rax(code, op, dst, rd, rn, rhs_place, frame);
    }
    // x86_64's two-operand op `OP rd, rm` mutates rd. The standard
    // sequence below stages LHS into rd then emits `OP rd, rm`.
    // When rhs is an IntReg whose register is rd, materialize_int
    // would return rd as `rm`; the subsequent `mov rd, rn` would
    // then overwrite the rhs value, and the op would compute
    // `lhs OP lhs` instead of `lhs OP rhs`.
    //
    // For commutative ops (Add, Mul, And, Or, Xor) the work to fix
    // this is zero: rd already holds the value we want, so emit
    // `OP rd, rn` directly -- rd <- rhs OP lhs == lhs OP rhs.
    //
    // For non-commutative ops (Sub, Lt, Gt, ...) we must stage
    // rhs into the scratch before the `mov rd, rn` clobbers it.
    let commutative = matches!(
        op,
        BinOp::Add | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor
    );
    let is_cmp = matches!(
        op,
        BinOp::Eq
            | BinOp::Ne
            | BinOp::Lt
            | BinOp::Gt
            | BinOp::Le
            | BinOp::Ge
            | BinOp::Ult
            | BinOp::Ugt
            | BinOp::Ule
            | BinOp::Uge
    );
    if rhs_aliases_rd && commutative {
        // When rhs was preserved into rhs_scratch above (lhs Spill case),
        // rd now holds lhs from the spill load and the second operand
        // is rhs_scratch; otherwise rd still holds rhs and rn holds lhs.
        let other = if rhs_preserved_in_scratch {
            rhs_scratch
        } else {
            rn
        };
        emit_rr(code, alu_mnem(op).unwrap(), 8, rd, other);
        return true;
    }
    // Comparison ops read both operands, set flags, then setcc+
    // movzx writes the dst. The dst is not used as an input, so
    // the staging `mov rd, rn` below is unnecessary; the rhs may
    // even live in `rd` itself (rhs_aliases_rd), and `cmp rn, rm`
    // still reads it before any write touches rd. Skip the stage
    // and the scratch-mov for cmp ops.
    let stage_rhs_to_scratch = rhs_aliases_rd && !is_cmp;
    let Some(rm) = (if rhs_preserved_in_scratch {
        Some(rhs_scratch)
    } else if stage_rhs_to_scratch {
        emit_mov_rr(code, rhs_scratch, rd);
        Some(rhs_scratch)
    } else if let Place::IntReg(r) = rhs_place {
        Some(Reg(r))
    } else {
        materialize_int(code, rhs_place, rhs_scratch, frame)
    }) else {
        return fail("Binop: rhs not int reg / spill");
    };
    // `lea rd, [rn + rm]` folds the staging mov and the add into one
    // address-unit op when the result lands in a different register
    // than the lhs. It reads both operands before writing rd (so it is
    // correct even were rd to alias rm) and sets no flags, which an
    // add-result consumer never reads. The rd == rn case is already a
    // single `add rd, rm`, so it stays on the path below.
    if matches!(op, BinOp::Add) && rd.0 != rn.0 {
        super::encode::emit_lea_r_sib(code, rd, rn, rm, 1);
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // x86_64's two-operand ops mutate the destination, so stage
    // the LHS into rd first (preserves SSA semantics where the
    // result is `lhs OP rhs`). Cmp ops skip this -- they read
    // rn / rm directly and write dst via setcc+movzx.
    if !is_cmp && rd.0 != rn.0 {
        emit_mov_rr(code, rd, rn);
    }
    if let Some(m) = alu_mnem(op) {
        emit_rr(code, m, 8, rd, rm);
    } else if let Some(cc) = int_cmp_cc(op) {
        // Write setcc into rd's own low byte rather than cl, so a live SSA
        // value parked in rcx survives.
        emit_rr(code, Mnem::Cmp, cmp_width(alloc, v), rn, rm);
        if finish_int_cmp(code, v, cc, rd, alloc) {
            return true;
        }
    } else if is_shift {
        // The count is a register here; `mov rd, rn` above left the lhs
        // in rd.
        return emit_shift_by_count_reg(code, op, v, dst, rd, ShiftCount::Reg(rm), alloc, frame);
    } else {
        // A new op variant reaching here is an IR producer / consumer
        // mismatch, not a register-pressure shape.
        panic!("Binop: unhandled integer op variant {op:?}");
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Lower `BinOp::{Div,Mod,Divu,Modu,Mulh,Mulhu}` on x86_64. All six
/// use the implicit rdx:rax pair: IDIV / DIV take the dividend there
/// (low half in rax) and write the quotient to rax and the remainder
/// to rdx; one-operand IMUL / MUL multiply rax by the operand and
/// write the 128-bit product to rdx:rax. The surrounding
/// allocator-chosen values in rax / rdx must be preserved across the
/// sequence. The 8-byte preserve uses `push %rax` / `pop %rax`; the
/// temporary 8-byte misalignment is fine -- none of these read or
/// write the stack, and SysV / Win64 only require 16-byte alignment
/// at `call` sites.
///
/// `rn` is the already-materialised lhs; `rhs_place` is the second
/// operand's place so we can route it directly into r10 (which the
/// one-operand reg/mem field can name, and which is never in any
/// allocator pool).
fn emit_binop_rdx_rax(
    code: &mut Vec<u8>,
    op: BinOp,
    dst: Place,
    rd: Reg,
    rn: Reg,
    rhs_place: Place,
    frame: Frame,
) -> bool {
    let is_mulh = matches!(op, BinOp::Mulh | BinOp::Mulhu);
    // The high half of the product lands in rdx, as the remainder does.
    let want_rdx = is_mulh || matches!(op, BinOp::Mod | BinOp::Modu);
    let is_unsigned = matches!(op, BinOp::Divu | BinOp::Modu | BinOp::Mulhu);

    // Preserve rax / rdx: the allocator can park a live value in
    // either register and the sequence must not destroy it. rax
    // receives the lhs and the quotient / low product half; rdx
    // receives the dividend high half (cqo / xor edx,edx) and the
    // remainder / high product half. Skip the save when rd will
    // overwrite the register anyway, since the value living there is
    // dead the moment rd commits its result.
    let preserve_rax = rd.0 != Reg::RAX.0;
    let preserve_rdx = rd.0 != Reg::RDX.0;
    let pushed_bytes = (preserve_rax as i32 + preserve_rdx as i32) * 8;

    // Resolve the second operand. All four one-operand forms accept
    // r/m64, so a spilled operand is named directly through its stack
    // slot (its rsp offset shifted by the rax/rdx preservation pushes
    // below) and a register operand outside the implicit rdx:rax pair
    // is used in place -- neither needs a scratch register, which the
    // surrounding high-pressure allocation may not have free. An
    // operand that aliases rax or rdx is copied into the dedicated
    // scratch before the rax setup overwrites those registers; the
    // scratch is free unless it already holds the lhs (a spilled lhs).
    enum RmOperand {
        Reg(Reg),
        Mem(Reg, i32),
    }
    let rm_operand = match rhs_place {
        Place::IntReg(r) if r != Reg::RAX.0 && r != Reg::RDX.0 => RmOperand::Reg(Reg(r)),
        Place::Spill(slot) => {
            let (sb, off) = spill_slot_addr_shifted(frame, slot, pushed_bytes as u32);
            RmOperand::Mem(sb, off)
        }
        Place::IntReg(r) => {
            // An operand in rax / rdx must be copied out before the
            // rax setup overwrites those registers. The copy target
            // must not collide with the staged lhs: a spilled lhs is
            // materialised into rd, which for a spilled dst is
            // SCRATCH_R10, so SCRATCH_R10 is not always free here.
            // SCRATCH_R11 is reserved outside both allocator pools
            // and never holds the lhs, so it is always available.
            let rhs_scratch = if rn.0 == SCRATCH_R10.0 {
                SCRATCH_R11
            } else {
                SCRATCH_R10
            };
            emit_mov_rr(code, rhs_scratch, Reg(r));
            RmOperand::Reg(rhs_scratch)
        }
        _ => return fail("Binop rdx:rax: rhs not int reg / spill"),
    };

    if preserve_rax {
        emit_push_r(code, Reg::RAX);
    }
    if preserve_rdx {
        emit_push_r(code, Reg::RDX);
    }
    // rax := lhs (dividend low half, or multiplicand).
    if rn.0 != Reg::RAX.0 {
        emit_mov_rr(code, Reg::RAX, rn);
    }
    // A divide needs rdx seeded with the dividend's high half: signed
    // uses CQO to sign-extend rax, unsigned zero-extends with
    // `xor edx, edx`. A multiply reads only rax and overwrites rdx.
    if !is_mulh {
        if is_unsigned {
            emit_rr(code, Mnem::Xor, 8, Reg::RDX, Reg::RDX);
        } else {
            super::encode::emit_cqo(code);
        }
    }
    let mnem = match (is_mulh, is_unsigned) {
        (true, true) => Mnem::Mul,
        (true, false) => Mnem::Imul,
        (false, true) => Mnem::Div,
        (false, false) => Mnem::Idiv,
    };
    match rm_operand {
        RmOperand::Reg(r) => super::encode::emit_unary_r(code, mnem, 8, r),
        RmOperand::Mem(sb, off) => super::encode::emit_unary_m(code, mnem, 8, sb, off),
    }
    // Capture result into rd before restoring rdx / rax.
    let result_src = if want_rdx { Reg::RDX } else { Reg::RAX };
    if rd.0 != result_src.0 {
        emit_mov_rr(code, rd, result_src);
    }
    if preserve_rdx {
        emit_pop_r(code, Reg::RDX);
    }
    if preserve_rax {
        emit_pop_r(code, Reg::RAX);
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Source of a variable shift count for `emit_shift_by_count_reg`.
enum ShiftCount {
    /// Count already resident in a register; moved into cl.
    Reg(Reg),
    /// Count is a compile-time immediate; loaded into cl. Reached
    /// only for an out-of-range `BinopI` shift (C99 6.5.7p3 makes
    /// such a count undefined), kept well-formed rather than bailed.
    Imm(i64),
}

/// Lower `rd = rd OP count` for a variable-count shift / rotate, with
/// the value to shift already staged in `rd`. x86 reads the count
/// from cl, so the count is moved into rcx and the shift issued
/// against rd. When the allocator parked a live SSA value in rcx
/// (rcx is in the caller-saved pool), it is preserved with push /
/// pop around the move; the body is register-to-register only, so
/// the transient 8-byte misalignment is irrelevant (no call site
/// intervenes). When `rd` itself is rcx the value to shift and the
/// count would both need rcx at once, so the shift is staged in a
/// reserved scratch and copied back.
#[allow(clippy::too_many_arguments)]
fn emit_shift_by_count_reg(
    code: &mut Vec<u8>,
    op: BinOp,
    v: super::super::ir::ValueId,
    dst: Place,
    rd: Reg,
    count: ShiftCount,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let count_reg = match count {
        ShiftCount::Reg(r) => Some(r),
        ShiftCount::Imm(_) => None,
    };
    let do_shift = |code: &mut Vec<u8>, target: Reg| emit_shift_cl(code, shift_mnem(op), 8, target);
    if rd.0 == Reg::RCX.0 {
        // Stage the value in a scratch disjoint from rcx and the count
        // register; r11 is reserved outside both allocator banks and
        // never aliases rd, the count, or any live value.
        let scratch = SCRATCH_R11;
        emit_mov_rr(code, scratch, rd);
        match count {
            ShiftCount::Reg(r) if r.0 != Reg::RCX.0 => emit_mov_rr(code, Reg::RCX, r),
            ShiftCount::Reg(_) => {}
            ShiftCount::Imm(imm) => super::encode::emit_mov_r_imm64(code, Reg::RCX, imm),
        }
        do_shift(code, scratch);
        emit_mov_rr(code, rd, scratch);
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // Save rcx whenever any value is allocated there (unless the count
    // already sits in rcx, in which case nothing below writes it). A
    // `def < v < last_use` pc-interval test is not a liveness test: a
    // value carried around a loop back edge is live at the shift while
    // the shift's pc lies outside the interval.
    // A `-ffixed-rcx` holds a value of the program's, preserved the same way.
    let _ = v;
    let rcx_holds_live = count_reg.map(|r| r.0).unwrap_or(u8::MAX) != Reg::RCX.0
        && (frame.fixed_regs.has_gpr(Reg::RCX.0)
            || alloc
                .places
                .iter()
                .any(|p| matches!(p, Place::IntReg(r) if *r == Reg::RCX.0)));
    if rcx_holds_live {
        emit_push_r(code, Reg::RCX);
    }
    match count {
        ShiftCount::Reg(r) if r.0 != Reg::RCX.0 => emit_mov_rr(code, Reg::RCX, r),
        ShiftCount::Reg(_) => {}
        ShiftCount::Imm(imm) => super::encode::emit_mov_r_imm64(code, Reg::RCX, imm),
    }
    do_shift(code, rd);
    if rcx_holds_live {
        emit_pop_r(code, Reg::RCX);
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Whether lowering `Inst::BinopI { op, rhs_imm: imm }` builds the
/// immediate into a register at the site -- the `mov r, imm64` the
/// peepholes in [`emit_binop_imm`] exist to avoid. True means the
/// loop-invariant hoist can lift that materialization into a preheader
/// by rewriting the site to the register form; false means the
/// immediate rides the instruction's own imm8 / imm32 field and the
/// rewrite would add work. Mirrors the arm order below.
pub(crate) fn binop_imm_materializes(op: BinOp, imm: i64) -> bool {
    let fits_i32 = i32::try_from(imm).is_ok();
    match op {
        // imm8 form in range, and the cl path for a count C99 6.5.7p3
        // leaves undefined; neither materializes the immediate.
        BinOp::Shl | BinOp::Shr | BinOp::Shru | BinOp::Ror => false,
        BinOp::Mod | BinOp::Modu => false,
        BinOp::Mul => !(fits_i32 || (imm > 0 && (imm as u64).is_power_of_two())),
        BinOp::Add | BinOp::Sub | BinOp::Or | BinOp::Xor => !fits_i32,
        BinOp::And => !(fits_i32 || imm as u64 == 0xffff_ffff),
        _ if int_cmp_cc(op).is_some() => !fits_i32,
        // Mulh / Mulhu / Div / Divu reach the r11-scratch path below.
        _ => true,
    }
}

#[allow(clippy::too_many_arguments)]
pub(super) fn emit_binop_imm(
    code: &mut Vec<u8>,
    op: BinOp,
    v: super::super::ir::ValueId,
    dst: Place,
    lhs: u32,
    rhs_imm: i64,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("BinopI: dst not int reg / spill");
    };
    let lhs_place = place_of(alloc, lhs);
    let Some(rn) = int_operand_into_rd(code, lhs_place, rd, frame) else {
        return fail("BinopI: lhs not int reg / spill");
    };
    // The sign-narrow pair folds to one movsxd / movsx, as in `emit_binop`.
    let sxtw_source = alloc
        .sxtw_source
        .get(v as usize)
        .copied()
        .unwrap_or(super::super::ir::NO_VALUE);
    if sxtw_source != super::super::ir::NO_VALUE {
        let src_place = place_of(alloc, sxtw_source);
        let Some(src_reg) = int_operand_into_rd(code, src_place, rd, frame) else {
            return fail("BinopI sxtw: src not int reg / spill");
        };
        match rhs_imm {
            32 => super::encode::emit_movsxd_r_r(code, rd, src_reg),
            48 => super::encode::emit_movsx_r_r16(code, rd, src_reg),
            56 => super::encode::emit_movsx_r_r8(code, rd, src_reg),
            _ => unreachable!(),
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // Forms that avoid the 10-byte `mov r11, imm64` of the scratch path
    // below: a multiply by a power of two is a shift, by 3 / 5 / 9 one
    // `lea`, by any other i32 `imul rd, rn, imm32`; a shift by 0..63 takes
    // the imm8 form; an add / sub of an i32 into another register is one
    // `lea`, a step of one `inc` / `dec` (the flags differ only in the
    // carry, which no consumer of a `BinopI` reads); `x & 0xffffffff` is a
    // 32-bit `mov`, since `and r64, imm32` sign-extends the immediate; the
    // other ALU ops take their imm32 form.
    let imm_fits_i32 = i32::try_from(rhs_imm).is_ok();
    let imm_is_pow2 = rhs_imm > 0 && (rhs_imm as u64).is_power_of_two();
    let shift_amount = if (0..64).contains(&rhs_imm) {
        Some(rhs_imm as u8)
    } else {
        None
    };
    let used_peephole = match op {
        BinOp::Mul if imm_is_pow2 => {
            stage_lhs(code, rd, rn);
            emit_shift_ri(
                code,
                Mnem::Shl,
                8,
                rd,
                (rhs_imm as u64).trailing_zeros() as u8,
            );
            true
        }
        // The base and index are both `rn`, so the result may reuse `rn`.
        BinOp::Mul if matches!(rhs_imm, 3 | 5 | 9) => {
            super::encode::emit_lea_r_sib(code, rd, rn, rn, (rhs_imm - 1) as u8);
            true
        }
        BinOp::Mul if imm_fits_i32 => {
            super::encode::emit_imul_r_r_imm32(code, rd, rn, rhs_imm as i32);
            true
        }
        BinOp::Shl | BinOp::Shr | BinOp::Shru | BinOp::Ror if shift_amount.is_some() => {
            stage_lhs(code, rd, rn);
            emit_shift_ri(code, shift_mnem(op), 8, rd, shift_amount.unwrap());
            true
        }
        BinOp::Add if rd.0 != rn.0 && imm_fits_i32 => {
            super::encode::emit_lea_r_mem(code, rd, rn, rhs_imm as i32);
            true
        }
        BinOp::Sub if rd.0 != rn.0 && imm_fits_i32 && rhs_imm != i64::from(i32::MIN) => {
            super::encode::emit_lea_r_mem(code, rd, rn, -(rhs_imm as i32));
            true
        }
        BinOp::Add | BinOp::Sub if rhs_imm == 1 || rhs_imm == -1 => {
            stage_lhs(code, rd, rn);
            let up = (rhs_imm == 1) == matches!(op, BinOp::Add);
            let mnem = if up { Mnem::Inc } else { Mnem::Dec };
            super::encode::emit_unary_r(code, mnem, 8, rd);
            true
        }
        BinOp::And if rhs_imm == 0xffff_ffff => {
            super::encode::emit_mov_r32_r32(code, rd, rn);
            true
        }
        BinOp::Add | BinOp::Sub | BinOp::And | BinOp::Or | BinOp::Xor if imm_fits_i32 => {
            stage_lhs(code, rd, rn);
            super::encode::emit_ri(code, alu_mnem(op).unwrap(), 8, rd, rhs_imm as i32);
            true
        }
        _ => false,
    };
    if used_peephole {
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // A compare against an i32: `cmp rn, imm32`, or against 0 the shorter
    // `test rn, rn`, whose ZF / SF / CF / OF match.
    if let Some(cc) = int_cmp_cc(op)
        && imm_fits_i32
    {
        let w = cmp_width(alloc, v);
        if rhs_imm == 0 {
            super::encode::emit_rr(code, Mnem::Test, w, rn, rn);
        } else {
            super::encode::emit_ri(code, Mnem::Cmp, w, rn, rhs_imm as i32);
        }
        if finish_int_cmp(code, v, cc, rd, alloc) {
            return true;
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // A commutative op with `rd != rn` folds the staging mov into the
    // materialisation: `mov rd, imm; OP rd, rn`.
    let commutative = matches!(
        op,
        BinOp::Add | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor
    );
    if commutative && rd.0 != rn.0 {
        super::encode::emit_mov_r_imm64(code, rd, rhs_imm);
        emit_rr(code, alu_mnem(op).unwrap(), 8, rd, rn);
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // A shift by a count outside 0..63 (C99 6.5.7p3 leaves it undefined)
    // routes through cl like the register-shift path, so the emit stays
    // well-formed.
    if matches!(op, BinOp::Shl | BinOp::Shr | BinOp::Shru | BinOp::Ror) {
        stage_lhs(code, rd, rn);
        return emit_shift_by_count_reg(
            code,
            op,
            v,
            dst,
            rd,
            ShiftCount::Imm(rhs_imm),
            alloc,
            frame,
        );
    }
    // The immediate materialises into r11, which sits outside both
    // allocator banks (`RegBanks::for_target`) and so never aliases `rd` or
    // `rn` and is free under any register pressure.
    let scratch = SCRATCH_R11;
    super::encode::emit_mov_r_imm64(code, scratch, rhs_imm);
    stage_lhs(code, rd, rn);
    if let Some(m) = alu_mnem(op) {
        emit_rr(code, m, 8, rd, scratch);
    } else if let Some(cc) = int_cmp_cc(op) {
        emit_rr(code, Mnem::Cmp, cmp_width(alloc, v), rn, scratch);
        if finish_int_cmp(code, v, cc, rd, alloc) {
            return true;
        }
    } else {
        // A new op variant reaching here is an IR producer / consumer
        // mismatch, not a register-pressure shape.
        panic!("BinopI: unhandled integer op variant {op:?}");
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}
