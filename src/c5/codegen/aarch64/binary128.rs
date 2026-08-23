//! AAPCS64 `long double` storage: IEEE binary128 in a 16-byte object.
//! AArch64 has no quad-precision unit, so a declared object converts
//! to and from the binary64 the compute path carries through the
//! open-coded sequences here. Both mirror `crate::c5::softfp`'s
//! `f128_to_f64` / `f64_to_f128` step for step -- widening is exact,
//! narrowing rounds to nearest with ties to even.
//!
//! Each sequence borrows integer registers from the allocator's pool
//! and restores them before it ends; `addr` must name a register
//! outside that pool, and nothing between the save and the restore
//! addresses `sp`.

use alloc::vec::Vec;

use super::emit::{NARROW_BORROW, emit_agg_load_int, enc_store_unit};
use super::encode::{
    Cond, Reg, emit, enc_add_imm, enc_add_imm_lsl12, enc_add_reg, enc_and_reg, enc_asr_imm, enc_b,
    enc_b_cond, enc_bic_reg, enc_cbnz, enc_cbz, enc_clz, enc_cmp_reg, enc_cset, enc_fmov_d_to_x,
    enc_fmov_x_to_d, enc_ldp_off, enc_ldr_imm, enc_lsl_imm, enc_lslv, enc_lsr_imm, enc_lsrv,
    enc_mov_reg, enc_movz, enc_orr_reg, enc_stp_off, enc_str_imm, enc_sub_imm, enc_sub_imm_lsl12,
    enc_sub_reg, enc_subs_imm,
};

/// The exponent bias difference between binary128 and binary64, less
/// the 1023 the rounding step adds back.
const BIAS_DELTA: u32 = 15360;

/// Registers each sequence borrows, in the order they are assigned.
fn borrow<const N: usize>(addr: Reg) -> [Reg; N] {
    let mut out = [Reg(0); N];
    let mut n = 0;
    for cand in NARROW_BORROW {
        if n == N {
            break;
        }
        if cand != addr.0 {
            out[n] = Reg(cand);
            n += 1;
        }
    }
    debug_assert_eq!(n, N, "binary128: no free borrow register");
    out
}

/// Save `regs` in a fresh 16-aligned area below `sp`; returns its size.
fn save(code: &mut Vec<u8>, regs: &[Reg]) -> u32 {
    let bytes = (regs.len().div_ceil(2) * 16) as u32;
    emit(code, enc_sub_imm(Reg::SP, Reg::SP, bytes));
    let mut i = 0;
    while i + 1 < regs.len() {
        emit(
            code,
            enc_stp_off(regs[i], regs[i + 1], Reg::SP, (i * 8) as i32),
        );
        i += 2;
    }
    if i < regs.len() {
        emit(code, enc_str_imm(regs[i], Reg::SP, (i * 8) as u32));
    }
    bytes
}

/// Mirror of [`save`].
fn restore(code: &mut Vec<u8>, regs: &[Reg], bytes: u32) {
    let mut i = 0;
    while i + 1 < regs.len() {
        emit(
            code,
            enc_ldp_off(regs[i], regs[i + 1], Reg::SP, (i * 8) as i32),
        );
        i += 2;
    }
    if i < regs.len() {
        emit(code, enc_ldr_imm(regs[i], Reg::SP, (i * 8) as u32));
    }
    emit(code, enc_add_imm(Reg::SP, Reg::SP, bytes));
}

/// Retarget the placeholder branch at `at` to the end of `code`.
fn patch(code: &mut [u8], at: usize) {
    let delta = ((code.len() - at) / 4) as i32;
    let w = u32::from_le_bytes(code[at..at + 4].try_into().unwrap());
    let patched = if w & 0xFC00_0000 == 0x1400_0000 {
        (w & !0x03FF_FFFF) | (delta as u32 & 0x03FF_FFFF)
    } else {
        (w & !(0x7_FFFF << 5)) | ((delta as u32 & 0x7_FFFF) << 5)
    };
    code[at..at + 4].copy_from_slice(&patched.to_le_bytes());
}

/// Emit a placeholder branch and return its offset for [`patch`].
fn branch(code: &mut Vec<u8>, word: u32) -> usize {
    let at = code.len();
    emit(code, word);
    at
}

/// `rd = rn & ((1 << bits) - 1)`, for a mask no logical immediate
/// carries cheaply here.
fn mask_low(code: &mut Vec<u8>, rd: Reg, rn: Reg, bits: u8) {
    emit(code, enc_lsl_imm(rd, rn, 64 - bits));
    emit(code, enc_lsr_imm(rd, rd, 64 - bits));
}

/// `cmp rn, #imm` through a scratch, for immediates past the 12-bit
/// field.
fn cmp_imm16(code: &mut Vec<u8>, rn: Reg, tmp: Reg, imm: u16) {
    emit(code, enc_movz(tmp, imm, 0));
    emit(code, enc_cmp_reg(rn, tmp));
}

/// Add (or subtract, when `sub`) `BIAS_DELTA` to `rd`.
fn bias(code: &mut Vec<u8>, rd: Reg, sub: bool) {
    let (hi, lo) = (BIAS_DELTA / 4096, BIAS_DELTA % 4096);
    if sub {
        emit(code, enc_sub_imm_lsl12(rd, rd, hi));
        emit(code, enc_sub_imm(rd, rd, lo));
    } else {
        emit(code, enc_add_imm_lsl12(rd, rd, hi));
        emit(code, enc_add_imm(rd, rd, lo));
    }
}

/// Load the binary128 object at `[addr + disp]` and narrow it into the
/// d-register `dd`. `bound` caps the access width when the storage is
/// under-aligned.
pub(super) fn emit_narrow_load(
    code: &mut Vec<u8>,
    dd: u8,
    addr: Reg,
    disp: u32,
    bound: Option<u32>,
) {
    let r = borrow::<7>(addr);
    let (lo, hi, sgn, exp, tmp, acc, aux) = (r[0], r[1], r[2], r[3], r[4], r[5], r[6]);
    let bytes = save(code, &r);
    match bound {
        Some(a) => {
            emit_agg_load_int(code, lo, addr, disp, 8, a, true, tmp);
            emit_agg_load_int(code, hi, addr, disp + 8, 8, a, true, tmp);
        }
        None => {
            emit(code, enc_ldr_imm(lo, addr, disp));
            emit(code, enc_ldr_imm(hi, addr, disp + 8));
        }
    }
    emit(code, enc_lsr_imm(sgn, hi, 63));
    emit(code, enc_lsl_imm(sgn, sgn, 63));
    emit(code, enc_lsl_imm(exp, hi, 1));
    emit(code, enc_lsr_imm(exp, exp, 49));
    mask_low(code, hi, hi, 48);
    cmp_imm16(code, exp, tmp, 0x7fff);
    let to_finite = branch(code, enc_b_cond(Cond::Ne, 0));
    // Infinity keeps a zero significand; a NaN keeps its top payload
    // bits and stays quiet.
    emit(code, enc_orr_reg(tmp, hi, lo));
    let to_inf = branch(code, enc_cbz(tmp, 0));
    emit(code, enc_lsl_imm(tmp, hi, 4));
    emit(code, enc_lsr_imm(aux, lo, 60));
    emit(code, enc_orr_reg(tmp, tmp, aux));
    emit(code, enc_movz(aux, 0x7ff8, 3));
    emit(code, enc_orr_reg(tmp, tmp, aux));
    emit(code, enc_orr_reg(acc, sgn, tmp));
    let nan_done = branch(code, enc_b(0));
    patch(code, to_finite);
    // Top 64 significand bits as 1.63 fixed point; the rest is sticky.
    emit(code, enc_lsl_imm(hi, hi, 15));
    emit(code, enc_lsr_imm(tmp, lo, 49));
    emit(code, enc_orr_reg(hi, hi, tmp));
    emit(code, enc_subs_imm(Reg::SP, exp, 0));
    emit(code, enc_cset(tmp, Cond::Ne));
    emit(code, enc_lsl_imm(tmp, tmp, 63));
    emit(code, enc_orr_reg(hi, hi, tmp));
    mask_low(code, lo, lo, 49);
    emit(code, enc_subs_imm(Reg::SP, lo, 0));
    emit(code, enc_cset(lo, Cond::Ne));
    emit(code, enc_subs_imm(Reg::SP, exp, 0));
    emit(code, enc_cset(tmp, Cond::Eq));
    emit(code, enc_add_reg(exp, exp, tmp));
    let to_zero = branch(code, enc_cbz(hi, 0));
    emit(code, enc_clz(tmp, hi));
    emit(code, enc_lslv(hi, hi, tmp));
    emit(code, enc_sub_reg(exp, exp, tmp));
    bias(code, exp, true);
    cmp_imm16(code, exp, tmp, 0x7ff);
    let to_inf2 = branch(code, enc_b_cond(Cond::Ge, 0));
    // Bits dropped from the fraction, less one: 10 for a normal
    // result, one more per binade below the normal range.
    emit(code, enc_movz(tmp, 1, 0));
    emit(code, enc_sub_reg(tmp, tmp, exp));
    emit(code, enc_asr_imm(aux, tmp, 63));
    emit(code, enc_bic_reg(tmp, tmp, aux));
    emit(code, enc_add_imm(tmp, tmp, 10));
    cmp_imm16(code, tmp, aux, 63);
    let to_zero2 = branch(code, enc_b_cond(Cond::Gt, 0));
    emit(code, enc_lsr_imm(acc, hi, 1));
    emit(code, enc_lsrv(acc, acc, tmp));
    emit(code, enc_lsrv(aux, hi, tmp));
    emit(code, enc_sub_reg(tmp, Reg::SP, tmp));
    emit(code, enc_lslv(hi, hi, tmp));
    emit(code, enc_subs_imm(Reg::SP, hi, 0));
    emit(code, enc_cset(hi, Cond::Ne));
    emit(code, enc_orr_reg(lo, lo, hi));
    mask_low(code, hi, acc, 1);
    emit(code, enc_orr_reg(lo, lo, hi));
    mask_low(code, aux, aux, 1);
    emit(code, enc_and_reg(lo, lo, aux));
    emit(code, enc_sub_imm(hi, exp, 1));
    emit(code, enc_asr_imm(aux, hi, 63));
    emit(code, enc_bic_reg(exp, hi, aux));
    emit(code, enc_lsl_imm(exp, exp, 52));
    emit(code, enc_add_reg(acc, acc, exp));
    emit(code, enc_add_reg(acc, acc, lo));
    emit(code, enc_add_reg(acc, acc, sgn));
    let round_done = branch(code, enc_b(0));
    patch(code, to_inf);
    patch(code, to_inf2);
    emit(code, enc_movz(acc, 0x7ff0, 3));
    emit(code, enc_orr_reg(acc, sgn, acc));
    let inf_done = branch(code, enc_b(0));
    patch(code, to_zero);
    patch(code, to_zero2);
    emit(code, enc_mov_reg(acc, sgn));
    patch(code, nan_done);
    patch(code, round_done);
    patch(code, inf_done);
    emit(code, enc_fmov_x_to_d(dd, acc));
    restore(code, &r, bytes);
}

/// Widen the f64 in `dn` into the binary128 object at `[addr + disp]`.
/// `dn` is left untouched -- the c5 store rule keeps the stored value
/// in the accumulator.
pub(super) fn emit_widen_store(
    code: &mut Vec<u8>,
    dn: u8,
    addr: Reg,
    disp: u32,
    bound: Option<u32>,
) {
    let r = borrow::<5>(addr);
    let (lo, hi, exp, man, tmp) = (r[0], r[1], r[2], r[3], r[4]);
    let bytes = save(code, &r);
    emit(code, enc_fmov_d_to_x(lo, dn));
    emit(code, enc_lsr_imm(hi, lo, 63));
    emit(code, enc_lsl_imm(hi, hi, 63));
    emit(code, enc_lsl_imm(exp, lo, 1));
    emit(code, enc_lsr_imm(exp, exp, 53));
    mask_low(code, man, lo, 52);
    cmp_imm16(code, exp, tmp, 0x7ff);
    let to_spec = branch(code, enc_b_cond(Cond::Eq, 0));
    let to_small = branch(code, enc_cbz(exp, 0));
    bias(code, exp, false);
    // Pack: the significand's low 4 bits fall in the low half.
    let pack = code.len();
    emit(code, enc_lsl_imm(lo, man, 60));
    emit(code, enc_lsr_imm(tmp, man, 4));
    emit(code, enc_orr_reg(hi, hi, tmp));
    emit(code, enc_lsl_imm(tmp, exp, 48));
    emit(code, enc_orr_reg(hi, hi, tmp));
    let to_store = branch(code, enc_b(0));
    patch(code, to_spec);
    emit(code, enc_lsl_imm(lo, man, 60));
    emit(code, enc_lsr_imm(tmp, man, 4));
    emit(code, enc_orr_reg(hi, hi, tmp));
    emit(code, enc_movz(tmp, 0x7fff, 3));
    emit(code, enc_orr_reg(hi, hi, tmp));
    let to_store2 = branch(code, enc_cbz(man, 0));
    emit(code, enc_movz(tmp, 0x8000, 2));
    emit(code, enc_orr_reg(hi, hi, tmp));
    let to_store3 = branch(code, enc_b(0));
    patch(code, to_small);
    let to_sub = branch(code, enc_cbnz(man, 0));
    emit(code, enc_mov_reg(lo, Reg::SP));
    let to_store4 = branch(code, enc_b(0));
    patch(code, to_sub);
    // Subnormal: normalize so the leading bit becomes implicit.
    emit(code, enc_clz(tmp, man));
    emit(code, enc_sub_imm(tmp, tmp, 11));
    emit(code, enc_lslv(man, man, tmp));
    mask_low(code, man, man, 52);
    emit(code, enc_movz(exp, 15361, 0));
    emit(code, enc_sub_reg(exp, exp, tmp));
    let back = code.len();
    let w = enc_b(((pack as i64 - back as i64) / 4) as i32);
    emit(code, w);
    patch(code, to_store);
    patch(code, to_store2);
    patch(code, to_store3);
    patch(code, to_store4);
    match bound {
        Some(a) => {
            store_bounded(code, lo, addr, disp, a, tmp);
            store_bounded(code, hi, addr, disp + 8, a, tmp);
        }
        None => {
            emit(code, enc_str_imm(lo, addr, disp));
            emit(code, enc_str_imm(hi, addr, disp + 8));
        }
    }
    restore(code, &r, bytes);
}

/// Write the 8 bytes of `rs` to `[addr + off]` in `align`-wide pieces.
fn store_bounded(code: &mut Vec<u8>, rs: Reg, addr: Reg, off: u32, align: u32, tmp: Reg) {
    for (i, (o, w)) in crate::c5::codegen::access_pieces(off, 8, align, true).enumerate() {
        let src = if i == 0 {
            rs
        } else {
            emit(code, enc_lsr_imm(tmp, rs, ((o - off) * 8) as u8));
            tmp
        };
        emit(code, enc_store_unit(w, src, addr, o));
    }
}
