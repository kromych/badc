use super::*;

/// `Inst::Extend { value, kind }` -- sign-extend the low bytes of a
/// GPR value to 64 bits via the `SXTB` / `SXTH` / `SXTW` aliases.
pub(super) fn emit_extend(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    kind: LoadKind,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    let src_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match materialize_int(code, src_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rd = match int_or_spill_scratch(dst, scratch) {
        Some(r) => r,
        None => {
            bail_msg("Extend: dst not int reg / spill");
            return false;
        }
    };
    let enc = match kind {
        LoadKind::I8 => super::encode::enc_sxtb(rd, rn),
        LoadKind::I16 => super::encode::enc_sxth(rd, rn),
        LoadKind::I32 => super::encode::enc_sxtw(rd, rn),
        _ => {
            bail_msg("Extend: unsupported kind");
            return false;
        }
    };
    emit(code, enc);
    spill_local_addr_to_dst(code, dst, rd, frame);
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
    scratch: &ScratchPool,
) -> bool {
    let src_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    // The destination doubles as the staging register, so a reload
    // lands where the value belongs and needs no follow-up move.
    if is_fp {
        let dd = match dst {
            Place::FpReg(r) => r,
            Place::Spill(_) => frame.fp_scratch[0],
            _ => {
                bail_msg("Copy: dst not fp reg / spill");
                return false;
            }
        };
        let dn = match materialize_fp(code, src_place, dd, frame) {
            Some(r) => r,
            None => {
                bail_msg("Copy: value not fp reg / spill");
                return false;
            }
        };
        if dd != dn {
            emit(code, super::encode::enc_fmov_d_d(dd, dn));
        }
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dd, sp_off);
        }
        return true;
    }
    let rd = match int_or_spill_scratch(dst, scratch) {
        Some(r) => r,
        None => {
            bail_msg("Copy: dst not int reg / spill");
            return false;
        }
    };
    let rn = match materialize_int(code, src_place, rd, frame) {
        Some(r) => r,
        None => {
            bail_msg("Copy: value not int reg / spill");
            return false;
        }
    };
    if rd != rn {
        emit(code, super::encode::enc_mov_reg(rd, rn));
    }
    spill_local_addr_to_dst(code, dst, rd, frame);
    true
}

/// `Inst::Bswap { value, width }` -- reverse the low `width` bytes,
/// zero-extended. 64-bit: `rev Xd`. 32-bit: `rev Wd` (the 32-bit write
/// zero-extends). 16-bit: `rev Wd` then `lsr Wd, #16`, which drops the
/// reversed upper halfword so operand bits above the width cannot
/// reach the result.
pub(super) fn emit_bswap(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    width: u8,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    let src_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match materialize_int(code, src_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rd = match int_or_spill_scratch(dst, scratch) {
        Some(r) => r,
        None => {
            bail_msg("Bswap: dst not int reg / spill");
            return false;
        }
    };
    match width {
        2 => {
            emit(code, super::encode::enc_rev32(rd, rn));
            emit(code, super::encode::enc_lsr32_imm(rd, rd, 16));
        }
        4 => emit(code, super::encode::enc_rev32(rd, rn)),
        _ => emit(code, super::encode::enc_rev64(rd, rn)),
    }
    spill_local_addr_to_dst(code, dst, rd, frame);
    true
}

/// `Inst::MulAdd { a, b, c, neg_product }` -- one `madd` / `msub`.
/// The instruction reads all three sources before writing the
/// destination, so `rd` may alias any of them. A spilled operand
/// reloads into a register of its own: the two scratch registers,
/// plus `rd` when the allocator gave the result one -- a third
/// landing spot the reload only reaches when all three operands
/// spilled, which leaves `rd` holding nothing. A spilled result has
/// no third register to offer, so that combination falls back to the
/// `mul` / `sub` pair the contraction replaced.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_mul_add(
    code: &mut Vec<u8>,
    dst: Place,
    a: u32,
    b: u32,
    c: u32,
    neg_product: bool,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    let (rd, spill_to) = match dst {
        Place::IntReg(r) => (Reg(r), None),
        Place::Spill(slot) => (scratch.primary, Some(slot)),
        _ => return false,
    };
    let place = |val: u32| {
        alloc
            .places
            .get(val as usize)
            .copied()
            .unwrap_or(Place::None)
    };
    let (pa, pb, pc) = (place(a), place(b), place(c));
    let spilled = [pa, pb, pc]
        .iter()
        .filter(|p| matches!(p, Place::Spill(_)))
        .count();
    if spilled == 3 && spill_to.is_some() {
        let (Some(rn), Some(rm)) = (
            materialize_int(code, pa, scratch.primary, frame),
            materialize_int(code, pb, scratch.secondary, frame),
        ) else {
            return false;
        };
        emit(code, enc_mul(scratch.primary, rn, rm));
        let Some(ra) = materialize_int(code, pc, scratch.secondary, frame) else {
            return false;
        };
        let word = if neg_product {
            enc_sub_reg(rd, ra, scratch.primary)
        } else {
            enc_add_reg(rd, ra, scratch.primary)
        };
        emit(code, word);
    } else {
        let mut reloads = [scratch.primary, scratch.secondary, rd].into_iter();
        let mut operand = |code: &mut Vec<u8>, p: Place| -> Option<Reg> {
            match p {
                Place::IntReg(r) => Some(Reg(r)),
                Place::Spill(_) => materialize_int(code, p, reloads.next()?, frame),
                _ => None,
            }
        };
        let Some(rn) = operand(code, pa) else {
            return false;
        };
        let Some(rm) = operand(code, pb) else {
            return false;
        };
        let Some(ra) = operand(code, pc) else {
            return false;
        };
        let word = if neg_product {
            enc_msub(rd, rn, rm, ra)
        } else {
            super::encode::enc_madd(rd, rn, rm, ra)
        };
        emit(code, word);
    }
    if let Some(slot) = spill_to {
        let sp_off = spill_off(frame, slot);
        emit_spill_str_x_auto(code, frame, rd, sp_off);
    }
    true
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
    scratch: &ScratchPool,
) -> bool {
    let lhs_place = alloc
        .places
        .get(lhs as usize)
        .copied()
        .unwrap_or(Place::None);
    let rhs_place = alloc
        .places
        .get(rhs as usize)
        .copied()
        .unwrap_or(Place::None);
    // FP arithmetic + comparison branch. Both operands live in
    // d-regs; arithmetic produces a d-reg; comparisons produce a
    // GPR (cset). The scratch d-regs (d0 / d1) reload spilled
    // operands; the matching int scratch slots aren't disturbed
    // because no int materialisation runs in this branch.
    if fp_arith_enc(op).is_some() {
        // C99 6.3.1.8: pick the single- vs double-precision encoder by
        // the result's width. A `float op float` result is f32 and the
        // operands are themselves f32; a `double` result is f64.
        let is_f32 = alloc.is_f32(v);
        let dn = match materialize_fp_for(code, lhs, lhs_place, frame.fp_scratch[0], frame, alloc) {
            Some(r) => r,
            None => return false,
        };
        let dm = match materialize_fp_for(code, rhs, rhs_place, frame.fp_scratch[1], frame, alloc) {
            Some(r) => r,
            None => return false,
        };
        let dd = match dst {
            Place::FpReg(r) => r,
            // Stage a spilled result through a reserved scratch d-reg
            // outside the allocator's banks; d0 may hold a live
            // value the caller still needs. `arith` reads dn / dm
            // before writing dd, so reusing the first FP scratch (a possible
            // operand source) is safe.
            Place::Spill(_) => frame.fp_scratch[0],
            _ => return false,
        };
        let word = if is_f32 {
            match op {
                BinOp::Fadd => super::encode::enc_fadd_s(dd, dn, dm),
                BinOp::Fsub => super::encode::enc_fsub_s(dd, dn, dm),
                BinOp::Fmul => super::encode::enc_fmul_s(dd, dn, dm),
                BinOp::Fdiv => super::encode::enc_fdiv_s(dd, dn, dm),
                _ => return false,
            }
        } else {
            match op {
                BinOp::Fadd => enc_fadd_d(dd, dn, dm),
                BinOp::Fsub => enc_fsub_d(dd, dn, dm),
                BinOp::Fmul => enc_fmul_d(dd, dn, dm),
                BinOp::Fdiv => enc_fdiv_d(dd, dn, dm),
                _ => return false,
            }
        };
        emit(code, word);
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dd, sp_off);
        }
        return true;
    }
    if let Some(cond) = fp_compare_cond(op) {
        // The compare width follows the operands' precision: two f32
        // operands use `fcmp Sn, Sm`, else `fcmp Dn, Dm`.
        let is_f32 = alloc.is_f32(lhs) || alloc.is_f32(rhs);
        let dn = match materialize_fp_for(code, lhs, lhs_place, frame.fp_scratch[0], frame, alloc) {
            Some(r) => r,
            None => return false,
        };
        let dm = match materialize_fp_for(code, rhs, rhs_place, frame.fp_scratch[1], frame, alloc) {
            Some(r) => r,
            None => return false,
        };
        let rd = match dst {
            Place::IntReg(r) => Reg(r),
            Place::Spill(_) => scratch.primary,
            _ => return false,
        };
        if is_f32 {
            emit(code, enc_fcmp_s(dn, dm));
        } else {
            emit(code, enc_fcmp_d(dn, dm));
        }
        // When the terminator's b.cond consumes the flags directly,
        // drop the cset materialisation -- the comparison value is
        // dead.
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        emit(code, enc_cset(rd, cond));
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rd, sp_off);
        }
        return true;
    }
    // Integer binop path. The result lands in a GPR; if the
    // allocator picked a spill slot, route through
    // `scratch.primary` and store afterwards. Using
    // scratch.primary as the rd is safe even when the lhs
    // materialise wrote it there: `add rd, rn, rm` reads rn
    // before writing rd, so a self-aliasing destination doesn't
    // corrupt the operand.
    let (rd, spill_to) = match dst {
        Place::IntReg(r) => (Reg(r), None),
        Place::Spill(slot) => (scratch.primary, Some(slot)),
        _ => return false,
    };
    // sxtw / sxth / sxtb fold for the walker-shape sign-narrow
    // pair `Binop(Shl, X, Imm(K)); Binop(Shr, _, Imm(K))`. The
    // allocator marked this Shr and stashed the K (32 / 48 / 56);
    // emit one sign-extend instead of two shifts.
    let sxtw_source = alloc
        .sxtw_source
        .get(v as usize)
        .copied()
        .unwrap_or(super::super::ir::NO_VALUE);
    if sxtw_source != super::super::ir::NO_VALUE {
        let src_place = alloc
            .places
            .get(sxtw_source as usize)
            .copied()
            .unwrap_or(Place::None);
        let rn = match materialize_int(code, src_place, scratch.primary, frame) {
            Some(r) => r,
            None => return false,
        };
        let k = alloc.sxtw_k.get(v as usize).copied().unwrap_or(0);
        let word = match k {
            32 => super::encode::enc_sxtw(rd, rn),
            48 => super::encode::enc_sxth(rd, rn),
            56 => super::encode::enc_sxtb(rd, rn),
            _ => return false,
        };
        emit(code, word);
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rd, sp_off);
        }
        return true;
    }
    let rn = match materialize_int(code, lhs_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rm = match materialize_int(code, rhs_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return false,
    };
    if let Some(cond) = compare_cond(op) {
        emit(code, cmp_reg_word(alloc, v, rn, rm));
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        emit(code, enc_cset(rd, cond));
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rd, sp_off);
        }
        return true;
    }
    if matches!(op, BinOp::Mod | BinOp::Modu) {
        // rem = rn - (rn / rm) * rm. The msub reads the dividend (rn)
        // and divisor (rm), so the quotient must occupy a register
        // distinct from both. A spilled operand was materialised into
        // a scratch register, so the quotient cannot blindly reuse
        // `scratch.secondary` -- when the divisor is spilled it sits
        // there, and the divide would overwrite it before the msub
        // reads it. Pick a free scratch or the result register that
        // aliases neither operand.
        // x19 is reserved by the prologue for a spilling function that
        // contains a modulo, so it is a safe third scratch when the
        // dividend, divisor and result all occupy the other registers.
        let quot = [scratch.secondary, scratch.primary, rd, Reg(19)]
            .into_iter()
            .find(|r| r.0 != rn.0 && r.0 != rm.0)
            .unwrap_or(Reg(19));
        let divider = if matches!(op, BinOp::Mod) {
            enc_sdiv(quot, rn, rm)
        } else {
            enc_udiv(quot, rn, rm)
        };
        emit(code, divider);
        emit(code, enc_msub(rd, quot, rm, rn));
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rd, sp_off);
        }
        return true;
    }
    let word = match op {
        BinOp::Add => enc_add_reg(rd, rn, rm),
        BinOp::Sub => enc_sub_reg(rd, rn, rm),
        BinOp::Mul => enc_mul(rd, rn, rm),
        BinOp::Mulh => super::encode::enc_smulh(rd, rn, rm),
        BinOp::Mulhu => super::encode::enc_umulh(rd, rn, rm),
        BinOp::Div => enc_sdiv(rd, rn, rm),
        BinOp::Divu => enc_udiv(rd, rn, rm),
        BinOp::And => enc_and_reg(rd, rn, rm),
        BinOp::Or => enc_orr_reg(rd, rn, rm),
        BinOp::Xor => enc_eor_reg(rd, rn, rm),
        BinOp::Shl => enc_lslv(rd, rn, rm),
        BinOp::Shr => enc_asrv(rd, rn, rm),
        BinOp::Shru => enc_lsrv(rd, rn, rm),
        BinOp::Ror => super::encode::enc_rorv(rd, rn, rm),
        _ => return false,
    };
    emit(code, word);
    if let Some(slot) = spill_to {
        let sp_off = spill_off(frame, slot);
        emit_spill_str_x_auto(code, frame, rd, sp_off);
    }
    true
}

/// Map an FP arithmetic binop to its d-reg encoder. Returns
/// `None` for non-arithmetic ops so the caller can try the
/// comparison or integer paths.
fn fp_arith_enc(op: BinOp) -> Option<fn(u8, u8, u8) -> u32> {
    Some(match op {
        BinOp::Fadd => enc_fadd_d,
        BinOp::Fsub => enc_fsub_d,
        BinOp::Fmul => enc_fmul_d,
        BinOp::Fdiv => enc_fdiv_d,
        _ => return None,
    })
}

/// Map an FP comparison binop to the AArch64 condition code the
/// matching fcmp + cset pair should use. Returns `None` for any
/// non-FP-compare op.
pub(super) fn fp_compare_cond(op: BinOp) -> Option<Cond> {
    Some(match op {
        BinOp::Feq => Cond::Eq,
        BinOp::Fne => Cond::Ne,
        BinOp::Flt => Cond::Mi,
        BinOp::Fgt => Cond::Gt,
        BinOp::Fle => Cond::Ls,
        BinOp::Fge => Cond::Ge,
        _ => return None,
    })
}

/// Map a comparison binop to the matching `Cond` for the
/// cmp / cset pair.
pub(super) fn compare_cond(op: BinOp) -> Option<Cond> {
    Some(match op {
        BinOp::Eq => Cond::Eq,
        BinOp::Ne => Cond::Ne,
        BinOp::Lt => Cond::Lt,
        BinOp::Gt => Cond::Gt,
        BinOp::Le => Cond::Le,
        BinOp::Ge => Cond::Ge,
        BinOp::Ult => Cond::Lo,
        BinOp::Ugt => Cond::Hi,
        BinOp::Ule => Cond::Ls,
        BinOp::Uge => Cond::Hs,
        _ => return None,
    })
}

/// Unsigned 12-bit immediate field of `cmp Xn, #imm`, when `imm` fits.
fn cmp_imm12(imm: i64) -> Option<u32> {
    u32::try_from(imm).ok().filter(|v| *v < (1u32 << 12))
}

/// Single-instruction encoding of `rd = rn op imm`, when one exists.
/// Avoids the `load_imm64 -> reg-form op` pair the caller falls back to.
///   * Shl / Shr / Shru / Ror by 0..63 -> LSL / ASR / LSR / ROR by
///     immediate (UBFM / SBFM aliases).
///   * Mul by a power of two -> LSL by log2.
///   * Add / Sub with a 12-bit magnitude -> enc_add_imm / enc_sub_imm;
///     `x + (-k) == x - k` in two's complement, so a small negative
///     immediate swaps to the other form instead of materializing the
///     sign-extended constant.
///   * `x ^ -1` -> mvn, `x & 0xffffffff` -> a 32-bit move (the mask has
///     no logical-immediate AND short form here).
///
/// Whether a form exists depends on `(op, imm)` alone, so
/// [`binop_imm_materializes`] reads the answer off this function.
fn binop_imm_peephole(op: BinOp, imm: i64, rd: Reg, rn: Reg) -> Option<u32> {
    let imm_u64 = imm as u64;
    let pow2_shift = if imm > 0 && imm_u64.is_power_of_two() {
        let s = imm_u64.trailing_zeros();
        if s < 64 { Some(s as u8) } else { None }
    } else {
        None
    };
    let shift_amount = if (0..64).contains(&imm) {
        Some(imm as u8)
    } else {
        None
    };
    let imm12 = cmp_imm12(imm);
    let imm12_neg = if imm < 0 {
        let m = imm.unsigned_abs();
        if m < (1u64 << 12) {
            u32::try_from(m).ok()
        } else {
            None
        }
    } else {
        None
    };
    match op {
        BinOp::Shl => shift_amount.map(|s| super::encode::enc_lsl_imm(rd, rn, s)),
        BinOp::Shr => shift_amount.map(|s| super::encode::enc_asr_imm(rd, rn, s)),
        BinOp::Shru => shift_amount.map(|s| super::encode::enc_lsr_imm(rd, rn, s)),
        BinOp::Ror => shift_amount.map(|s| super::encode::enc_ror_imm(rd, rn, s)),
        BinOp::Mul => pow2_shift.map(|s| super::encode::enc_lsl_imm(rd, rn, s)),
        BinOp::Add => imm12
            .map(|v| enc_add_imm(rd, rn, v))
            .or_else(|| imm12_neg.map(|v| enc_sub_imm(rd, rn, v))),
        BinOp::Sub => imm12
            .map(|v| enc_sub_imm(rd, rn, v))
            .or_else(|| imm12_neg.map(|v| enc_add_imm(rd, rn, v))),
        BinOp::Xor if imm == -1 => Some(super::encode::enc_mvn(rd, rn)),
        BinOp::And if imm as u64 == 0xffff_ffff => Some(super::encode::enc_mov_w_w(rd, rn)),
        _ => None,
    }
}

/// Whether lowering `Inst::BinopI { op, rhs_imm: imm }` builds the
/// immediate into a register at the site. True means the site pays a
/// `load_imm64` the loop-invariant hoist can lift into a preheader by
/// rewriting the site to the register form; false means the immediate
/// rides the instruction's own encoding and the rewrite would add work.
/// Mod / Modu never reach the immediate path (the walker does not emit
/// them under `BinopI`, and the lowering below declines them).
pub(crate) fn binop_imm_materializes(op: BinOp, imm: i64) -> bool {
    if matches!(op, BinOp::Mod | BinOp::Modu) {
        return false;
    }
    if binop_imm_peephole(op, imm, Reg(0), Reg(0)).is_some() {
        return false;
    }
    !(compare_cond(op).is_some() && cmp_imm12(imm).is_some())
}

/// Whether comparison `v` reads its operands at 32 bits
/// (`passes::narrow`).
fn narrow_cmp(alloc: &Allocation, v: super::super::ir::ValueId) -> bool {
    crate::c5::codegen::passes::narrow::is_cmp32(&alloc.cmp32, v)
}

/// Encoding for the `cmp` of comparison `v`, in the operand width the
/// narrowing analysis settled.
fn cmp_reg_word(alloc: &Allocation, v: super::super::ir::ValueId, rn: Reg, rm: Reg) -> u32 {
    if narrow_cmp(alloc, v) {
        super::encode::enc_cmp_reg_w(rn, rm)
    } else {
        enc_cmp_reg(rn, rm)
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
    scratch: &ScratchPool,
) -> bool {
    let (rd, spill_to) = match dst {
        Place::IntReg(r) => (Reg(r), None),
        Place::Spill(slot) => (scratch.primary, Some(slot)),
        _ => return false,
    };
    let lhs_place = alloc
        .places
        .get(lhs as usize)
        .copied()
        .unwrap_or(Place::None);
    // sxtw / sxth / sxtb fold: the allocator pre-flagged this
    // `BinopI(Shr, _, K)` as the upper half of a sign-narrow pair
    // (`Shl K; Shr K`). The matching Shl was decremented to zero
    // uses and DCE'd; we emit a single sign-extend whose source is
    // the Shl's lhs (the original pre-narrow value).
    let sxtw_source = alloc
        .sxtw_source
        .get(v as usize)
        .copied()
        .unwrap_or(super::super::ir::NO_VALUE);
    if sxtw_source != super::super::ir::NO_VALUE {
        let src_place = alloc
            .places
            .get(sxtw_source as usize)
            .copied()
            .unwrap_or(Place::None);
        let rn = match materialize_int(code, src_place, scratch.primary, frame) {
            Some(r) => r,
            None => return false,
        };
        let word = match rhs_imm {
            32 => super::encode::enc_sxtw(rd, rn),
            48 => super::encode::enc_sxth(rd, rn),
            56 => super::encode::enc_sxtb(rd, rn),
            _ => unreachable!(),
        };
        emit(code, word);
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rd, sp_off);
        }
        return true;
    }
    let rn = match materialize_int(code, lhs_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    if let Some(word) = binop_imm_peephole(op, rhs_imm, rd, rn) {
        emit(code, word);
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rd, sp_off);
        }
        return true;
    }
    // Compare-with-12-bit-immediate: emit `cmp Xn, #imm12`
    // (subs xzr, Xn, #imm12) and skip the imm-into-scratch load.
    // The 12-bit unsigned-immediate form covers 0..4095; outside
    // that range we fall through to the load-imm64 + cmp-reg path.
    if compare_cond(op).is_some()
        && let Some(imm) = cmp_imm12(rhs_imm)
    {
        emit(
            code,
            if narrow_cmp(alloc, v) {
                super::encode::enc_subs_imm_w(Reg::SP, rn, imm)
            } else {
                enc_subs_imm(Reg::SP, rn, imm)
            },
        );
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        let cond = compare_cond(op).unwrap();
        emit(code, enc_cset(rd, cond));
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rd, sp_off);
        }
        return true;
    }
    load_imm64(code, scratch.secondary, rhs_imm as u64);
    let rm = scratch.secondary;
    if compare_cond(op).is_some() {
        emit(code, cmp_reg_word(alloc, v, rn, rm));
        // When the terminator's b.cond will consume the flags
        // directly, drop the cset materialisation -- the
        // comparison value is dead.
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        let cond = compare_cond(op).unwrap();
        emit(code, enc_cset(rd, cond));
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rd, sp_off);
        }
        return true;
    }
    if matches!(op, BinOp::Mod | BinOp::Modu) {
        // Need a third scratch reg distinct from rn / rm; the
        // walker doesn't emit Mod / Modu under BinopI, so falling
        // back to the non-immediate path is safe.
        return false;
    }
    let word = match op {
        BinOp::Add => enc_add_reg(rd, rn, rm),
        BinOp::Sub => enc_sub_reg(rd, rn, rm),
        BinOp::Mul => enc_mul(rd, rn, rm),
        BinOp::Mulh => super::encode::enc_smulh(rd, rn, rm),
        BinOp::Mulhu => super::encode::enc_umulh(rd, rn, rm),
        BinOp::Div => enc_sdiv(rd, rn, rm),
        BinOp::Divu => enc_udiv(rd, rn, rm),
        BinOp::And => enc_and_reg(rd, rn, rm),
        BinOp::Or => enc_orr_reg(rd, rn, rm),
        BinOp::Xor => enc_eor_reg(rd, rn, rm),
        BinOp::Shl => enc_lslv(rd, rn, rm),
        BinOp::Shr => enc_asrv(rd, rn, rm),
        BinOp::Shru => enc_lsrv(rd, rn, rm),
        BinOp::Ror => super::encode::enc_rorv(rd, rn, rm),
        _ => return false,
    };
    emit(code, word);
    if let Some(slot) = spill_to {
        let sp_off = spill_off(frame, slot);
        emit_spill_str_x_auto(code, frame, rd, sp_off);
    }
    true
}
