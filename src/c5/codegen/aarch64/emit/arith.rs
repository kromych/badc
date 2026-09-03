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
    let src_place = place_of(alloc, value);
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
    store_spilled_int(code, frame, dst, rd);
    true
}

/// `Inst::Copy`: move `value` into this instruction's place, bit-exact
/// in both banks.
pub(super) fn emit_copy(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    is_fp: bool,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    let src_place = place_of(alloc, value);
    // A reload lands in the destination itself.
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
        store_spilled_fp(code, frame, dst, dd);
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
    store_spilled_int(code, frame, dst, rd);
    true
}

/// `Inst::Bswap`: reverse the low `width` bytes, zero-extended: `rev Xd`,
/// `rev Wd` (zero-extending), or `rev Wd` then `lsr Wd, #16`, which
/// drops the reversed upper halfword.
pub(super) fn emit_bswap(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    width: u8,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    let src_place = place_of(alloc, value);
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
    store_spilled_int(code, frame, dst, rd);
    true
}

/// `Inst::MulAdd`: one `madd` / `msub`, which reads all three sources
/// before writing, so `rd` may alias any of them. A spilled operand
/// reloads into the two scratches or, when all three spilled, `rd`; a
/// spilled result has no third register, so that combination takes the
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
    let place = |val: u32| place_of(alloc, val);
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
    store_spilled_int(code, frame, dst, rd);
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
    let lhs_place = place_of(alloc, lhs);
    let rhs_place = place_of(alloc, rhs);
    // FP arithmetic and comparison: operands in d-registers, spills
    // reloaded into the FP scratches; no integer materialisation runs here.
    if fp_arith_enc(op).is_some() {
        // C99 6.3.1.8: the encoder follows the result's precision.
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
            // The arithmetic reads dn / dm before writing dd, so a spilled result
            // may reuse the first FP scratch.
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
        store_spilled_fp(code, frame, dst, dd);
        return true;
    }
    if let Some(cond) = fp_compare_cond(op) {
        // The compare width follows the operands' precision.
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
        // A fused branch consumes the flags; the value is dead.
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        emit(code, enc_cset(rd, cond));
        store_spilled_int(code, frame, dst, rd);
        return true;
    }
    // `add rd, rn, rm` reads rn before writing rd, so a result in
    // scratch.primary may alias the lhs reload.
    let Some(rd) = int_or_spill_scratch(dst, scratch) else {
        return false;
    };
    // The allocator marked this Shr as the sign-narrow pair `Shl K; Shr K`
    // with K in 32 / 48 / 56: one sign-extend.
    let sxtw_source = alloc
        .sxtw_source
        .get(v as usize)
        .copied()
        .unwrap_or(super::super::ir::NO_VALUE);
    if sxtw_source != super::super::ir::NO_VALUE {
        let src_place = place_of(alloc, sxtw_source);
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
        store_spilled_int(code, frame, dst, rd);
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
        store_spilled_int(code, frame, dst, rd);
        return true;
    }
    if matches!(op, BinOp::Mod | BinOp::Modu) {
        // rem = rn - (rn / rm) * rm: the quotient must alias neither operand,
        // and a spilled divisor sits in scratch.secondary. x19 is reserved by
        // the prologue for a spilling function with a modulo.
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
        store_spilled_int(code, frame, dst, rd);
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
    store_spilled_int(code, frame, dst, rd);
    true
}

/// The d-register encoder of an FP arithmetic op, `None` otherwise.
fn fp_arith_enc(op: BinOp) -> Option<fn(u8, u8, u8) -> u32> {
    Some(match op {
        BinOp::Fadd => enc_fadd_d,
        BinOp::Fsub => enc_fsub_d,
        BinOp::Fmul => enc_fmul_d,
        BinOp::Fdiv => enc_fdiv_d,
        _ => return None,
    })
}

/// The condition of an FP comparison's `fcmp` + `cset`, `None`
/// otherwise.
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

/// The condition of an integer comparison's `cmp` + `cset`.
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

/// The single-instruction encoding of `rd = rn op imm` when one exists:
/// shifts by 0..63, a multiply by a power of two as a shift, add / sub
/// of a 12-bit magnitude (a small negative immediate swaps to the other
/// form), `x ^ -1` as `mvn`, `x & 0xffffffff` as a 32-bit move. Whether
/// a form exists depends on `(op, imm)` alone, which
/// `binop_imm_materializes` reads off this function.
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
/// immediate into a register at the site, which the loop-invariant
/// hoist can lift into a preheader. Mod / Modu never take the immediate
/// path.
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
    let Some(rd) = int_or_spill_scratch(dst, scratch) else {
        return false;
    };
    let lhs_place = place_of(alloc, lhs);
    // The allocator flagged this `BinopI(Shr, _, K)` as the upper half of
    // a sign-narrow pair whose Shl was DCE'd: one sign-extend of the Shl's
    // lhs.
    let sxtw_source = alloc
        .sxtw_source
        .get(v as usize)
        .copied()
        .unwrap_or(super::super::ir::NO_VALUE);
    if sxtw_source != super::super::ir::NO_VALUE {
        let src_place = place_of(alloc, sxtw_source);
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
        store_spilled_int(code, frame, dst, rd);
        return true;
    }
    let rn = match materialize_int(code, lhs_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    if let Some(word) = binop_imm_peephole(op, rhs_imm, rd, rn) {
        emit(code, word);
        store_spilled_int(code, frame, dst, rd);
        return true;
    }
    // `cmp Xn, #imm12` covers 0..4095.
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
        store_spilled_int(code, frame, dst, rd);
        return true;
    }
    load_imm64(code, scratch.secondary, rhs_imm as u64);
    let rm = scratch.secondary;
    if compare_cond(op).is_some() {
        emit(code, cmp_reg_word(alloc, v, rn, rm));
        // A fused branch consumes the flags; the value is dead.
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        let cond = compare_cond(op).unwrap();
        emit(code, enc_cset(rd, cond));
        store_spilled_int(code, frame, dst, rd);
        return true;
    }
    if matches!(op, BinOp::Mod | BinOp::Modu) {
        // Mod / Modu need a third scratch; the walker does not emit them under
        // BinopI.
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
    store_spilled_int(code, frame, dst, rd);
    true
}
