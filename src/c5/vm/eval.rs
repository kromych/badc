//! Shared SSA constant evaluator: the arithmetic arms of the VM
//! interpreter, factored out so the interpreter and the compile-time
//! constant folder (`codegen::passes::constfold`) share one
//! implementation of the operator semantics.

use super::super::ir::{BinOp, FpCastKind, LoadKind, eval_int_binop};

/// The interpreter's diagnosis of a zero divisor, named for the trapping
/// op: it reports the division rather than invoking host-level UB. The VM
/// re-wraps `message()` into its runtime error; the fold gate refuses the
/// operands instead.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum EvalTrap {
    Div,
    Mod,
    Divu,
    Modu,
}

impl EvalTrap {
    /// The trap for a zero divisor under `op`; `eval_int_binop` rejects
    /// no other opcode.
    fn zero_divisor(op: BinOp) -> Self {
        match op {
            BinOp::Div => EvalTrap::Div,
            BinOp::Mod => EvalTrap::Mod,
            BinOp::Divu => EvalTrap::Divu,
            BinOp::Modu => EvalTrap::Modu,
            _ => unreachable!("zero divisor reported for {op:?}"),
        }
    }

    pub(crate) fn message(self) -> &'static str {
        match self {
            EvalTrap::Div => "vm_ssa: signed integer division by zero",
            EvalTrap::Mod => "vm_ssa: signed integer modulo by zero",
            EvalTrap::Divu => "vm_ssa: unsigned integer division by zero",
            EvalTrap::Modu => "vm_ssa: unsigned integer modulo by zero",
        }
    }
}

/// Round a result to single precision when `f32_flag` marks the
/// defining value f32 (C99 6.3.1.8). The register convention keeps an
/// f32 value as the f64 bit pattern of its single-precision value, so
/// the round-trip through `f32` reproduces hardware single-precision
/// arithmetic. A non-f32 (double) value passes through unchanged. The
/// flag is `None` for SSA built outside the walker (no f32 tracking),
/// which also passes through as double.
pub(crate) fn round_if_f32(bits: i64, f32_flag: Option<&bool>) -> i64 {
    if matches!(f32_flag, Some(true)) {
        (f64::from_bits(bits as u64) as f32 as f64).to_bits() as i64
    } else {
        bits
    }
}

/// Binop dispatch. The integer arms are [`eval_int_binop`], shared with
/// the constant folders, and a zero divisor there surfaces as
/// [`EvalTrap`]. The FP arms treat each operand as the bit pattern of an
/// `f64` and return a fresh bit pattern (arithmetic) or 0 / 1 (compares).
/// Mulh / Mulhu / Ror have no C operator, so they are evaluated here.
pub(crate) fn apply_binop(op: BinOp, lhs: i64, rhs: i64) -> Result<i64, EvalTrap> {
    let r = match op {
        BinOp::Mulh => (((lhs as i128) * (rhs as i128)) >> 64) as i64,
        BinOp::Mulhu => (((lhs as u64 as u128) * (rhs as u64 as u128)) >> 64) as i64,
        BinOp::Ror => (lhs as u64).rotate_right(rhs as u32 & 63) as i64,
        BinOp::Fadd => (f64::from_bits(lhs as u64) + f64::from_bits(rhs as u64)).to_bits() as i64,
        BinOp::Fsub => (f64::from_bits(lhs as u64) - f64::from_bits(rhs as u64)).to_bits() as i64,
        BinOp::Fmul => (f64::from_bits(lhs as u64) * f64::from_bits(rhs as u64)).to_bits() as i64,
        BinOp::Fdiv => (f64::from_bits(lhs as u64) / f64::from_bits(rhs as u64)).to_bits() as i64,
        BinOp::Feq => (f64::from_bits(lhs as u64) == f64::from_bits(rhs as u64)) as i64,
        BinOp::Fne => (f64::from_bits(lhs as u64) != f64::from_bits(rhs as u64)) as i64,
        BinOp::Flt => (f64::from_bits(lhs as u64) < f64::from_bits(rhs as u64)) as i64,
        BinOp::Fgt => (f64::from_bits(lhs as u64) > f64::from_bits(rhs as u64)) as i64,
        BinOp::Fle => (f64::from_bits(lhs as u64) <= f64::from_bits(rhs as u64)) as i64,
        BinOp::Fge => (f64::from_bits(lhs as u64) >= f64::from_bits(rhs as u64)) as i64,
        op => return eval_int_binop(op, lhs, rhs).map_err(|_| EvalTrap::zero_divisor(op)),
    };
    Ok(r)
}

/// Compile-time fold gate over [`apply_binop`]. Refuses:
///   * FP ops -- the folder handles integer values only (the IR keeps
///     an f32 `Imm` as the low-32 bit pattern while the VM register
///     convention widens to f64, so the bit-level semantics differ);
///   * division / modulo by zero;
///   * `i64::MIN / -1` and `i64::MIN % -1` -- `wrapping_div` folds a
///     value the native `idiv` traps on (#DE), so folding would change
///     the program's runtime behavior;
///   * a shift whose count is negative or at least the register width --
///     C99 6.5.7p3 leaves the result undefined, so there is no value to
///     fold to. [`apply_binop`]'s mask to the low six bits is what the
///     hardware does at run time, not a translation-time answer, and
///     baking it in makes a `__builtin_constant_p` over the result true
///     and can decide a branch the source never meant to reach. Matches
///     the range analysis, which gives such a shift no bounds.
pub(crate) fn fold_binop(op: BinOp, lhs: i64, rhs: i64) -> Option<i64> {
    if matches!(op, BinOp::Shl | BinOp::Shr | BinOp::Shru) && !(0..64).contains(&rhs) {
        return None;
    }
    if matches!(
        op,
        BinOp::Fadd
            | BinOp::Fsub
            | BinOp::Fmul
            | BinOp::Fdiv
            | BinOp::Feq
            | BinOp::Fne
            | BinOp::Flt
            | BinOp::Fgt
            | BinOp::Fle
            | BinOp::Fge
    ) {
        return None;
    }
    if matches!(op, BinOp::Div | BinOp::Mod) && lhs == i64::MIN && rhs == -1 {
        return None;
    }
    apply_binop(op, lhs, rhs).ok()
}

/// `Inst::Extend`: discard the bits above `kind`'s width and
/// replicate the sign bit (C99 6.3.1.3). Kinds outside the signed
/// narrow set pass through unchanged.
pub(crate) fn eval_extend(raw: i64, kind: LoadKind) -> i64 {
    match kind {
        LoadKind::I8 => raw as i8 as i64,
        LoadKind::I16 => raw as i16 as i64,
        LoadKind::I32 => raw as i32 as i64,
        _ => raw,
    }
}

/// `Inst::Bswap`: reverse the low `width` bytes (2, 4, or 8) and
/// zero-extend. Operand bits above the width are ignored.
pub(crate) fn eval_bswap(raw: i64, width: u8) -> i64 {
    match width {
        2 => (raw as u16).swap_bytes() as i64,
        4 => (raw as u32).swap_bytes() as i64,
        _ => (raw as u64).swap_bytes() as i64,
    }
}

/// `Inst::FpCast`. A register carrying a single-precision value
/// already holds the f64 bit pattern of that f32 (the F32 load widens
/// on read). Widening to double is therefore a no-op; narrowing
/// rounds the f64 to f32 then re-stores the f32-as-f64 bit pattern
/// (C99 6.3.1.5). `result_f32` marks an `int -> float` result: the
/// integer converts directly to single precision (one rounding, C99
/// 6.3.1.4), matching the native `cvtsi2ss` / `scvtf s` rather than the
/// double-rounding a convert-to-double-then-narrow would produce.
pub(crate) fn eval_fpcast(kind: FpCastKind, raw: i64, result_f32: bool) -> i64 {
    match kind {
        FpCastKind::FpToInt => f64::from_bits(raw as u64) as i64,
        FpCastKind::UFpToInt => f64::from_bits(raw as u64) as u64 as i64,
        FpCastKind::IntToFp if result_f32 => (raw as f32 as f64).to_bits() as i64,
        FpCastKind::IntToFp => (raw as f64).to_bits() as i64,
        FpCastKind::UIntToFp if result_f32 => (raw as u64 as f32 as f64).to_bits() as i64,
        FpCastKind::UIntToFp => (raw as u64 as f64).to_bits() as i64,
        FpCastKind::F32ToF64 => raw,
        FpCastKind::F64ToF32 => (f64::from_bits(raw as u64) as f32 as f64).to_bits() as i64,
    }
}

/// `Inst::Fneg` on an f64 bit pattern.
pub(crate) fn eval_fneg(raw: i64) -> i64 {
    (-f64::from_bits(raw as u64)).to_bits() as i64
}

/// `Inst::Fma`: single-rounding fused multiply-add (C99 6.5p8). Match
/// the host fmadd / vfmadd: round once, at the result's width.
/// `libm::fma` / `fmaf` give the same single rounding as the native
/// instruction (and, unlike `f64::mul_add`, are available in the
/// no_std build) so the VM reference agrees with native codegen on
/// every target.
pub(crate) fn eval_fma(
    a_bits: i64,
    b_bits: i64,
    c_bits: i64,
    neg_product: bool,
    neg_addend: bool,
    is_f32: bool,
) -> i64 {
    let mut av = f64::from_bits(a_bits as u64);
    let bv = f64::from_bits(b_bits as u64);
    let mut cv = f64::from_bits(c_bits as u64);
    if neg_product {
        av = -av;
    }
    if neg_addend {
        cv = -cv;
    }
    let res = if is_f32 {
        libm::fmaf(av as f32, bv as f32, cv as f32) as f64
    } else {
        libm::fma(av, bv, cv)
    };
    res.to_bits() as i64
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::codegen::ssa::build::fold_int_binop_imm;
    use crate::c5::irgen::fold_int_binop;

    #[test]
    fn fold_refuses_div_mod_by_zero() {
        for op in [BinOp::Div, BinOp::Mod, BinOp::Divu, BinOp::Modu] {
            assert_eq!(fold_binop(op, 7, 0), None);
        }
    }

    #[test]
    fn fold_refuses_min_over_minus_one() {
        // Native `idiv` raises #DE on this operand pair; `wrapping_div`
        // would fold it to i64::MIN and hide the trap.
        assert_eq!(fold_binop(BinOp::Div, i64::MIN, -1), None);
        assert_eq!(fold_binop(BinOp::Mod, i64::MIN, -1), None);
        // The unsigned forms treat i64::MIN / -1 as ordinary operands.
        assert_eq!(fold_binop(BinOp::Divu, i64::MIN, -1), Some(0));
        assert_eq!(fold_binop(BinOp::Modu, i64::MIN, -1), Some(i64::MIN));
    }

    #[test]
    fn fold_refuses_fp_ops() {
        assert_eq!(fold_binop(BinOp::Fadd, 1, 2), None);
        assert_eq!(fold_binop(BinOp::Feq, 1, 1), None);
    }

    #[test]
    fn fold_refuses_out_of_range_shift_counts() {
        // C99 6.5.7p3: no defined result, so nothing to fold to. The
        // interpreter still answers, masking to the register width.
        for op in [BinOp::Shl, BinOp::Shr, BinOp::Shru] {
            assert_eq!(fold_binop(op, 1, 64), None);
            assert_eq!(fold_binop(op, 1, 65), None);
            assert_eq!(fold_binop(op, 1, -1), None);
            assert_eq!(fold_binop(op, 1, i64::MIN), None);
            assert!(fold_binop(op, 1, 0).is_some());
            assert!(fold_binop(op, 1, 63).is_some());
        }
        assert_eq!(apply_binop(BinOp::Shl, 1, 65), Ok(2));
        // A rotate is not a C operator; every count is defined for it.
        assert_eq!(fold_binop(BinOp::Ror, 1, 65), Some(i64::MIN));
    }

    #[test]
    fn fold_matches_interpreter_semantics() {
        assert_eq!(fold_binop(BinOp::Add, i64::MAX, 1), Some(i64::MIN));
        assert_eq!(fold_binop(BinOp::Shl, 1, 3), Some(8));
        assert_eq!(fold_binop(BinOp::Shr, -8, 1), Some(-4));
        assert_eq!(
            fold_binop(BinOp::Shru, -8, 1),
            Some(((-8i64) as u64 >> 1) as i64)
        );
        assert_eq!(fold_binop(BinOp::Div, -7, 2), Some(-3));
        assert_eq!(fold_binop(BinOp::Mod, -7, 2), Some(-1));
        assert_eq!(fold_binop(BinOp::Ror, 1, 1), Some(i64::MIN));
        assert_eq!(fold_binop(BinOp::Ult, -1, 1), Some(0));
        assert_eq!(fold_binop(BinOp::Lt, -1, 1), Some(1));
    }

    #[test]
    fn extend_sign_replicates_per_kind() {
        assert_eq!(eval_extend(0xff, LoadKind::I8), -1);
        assert_eq!(eval_extend(0x8000, LoadKind::I16), -32768);
        assert_eq!(eval_extend(0xffff_ffff, LoadKind::I32), -1);
        assert_eq!(eval_extend(0x7f, LoadKind::I8), 0x7f);
        assert_eq!(eval_extend(-1, LoadKind::I64), -1);
    }

    /// The two constant folders and the interpreter answer for the same C
    /// operators; a divergence would give a folded expression a different
    /// value than the interpreter computes for it. Operands cover zero,
    /// one, minus one, both signs, the signed extremes, and shift counts
    /// 0, 1, 63, 64, 65 and negative. A new opcode is not reached here,
    /// but the exhaustive matches in `eval_int_binop` and `apply_binop`
    /// force a decision for it.
    #[test]
    fn the_constant_folders_match_apply_binop() {
        const OPS: [BinOp; 23] = [
            BinOp::Add,
            BinOp::Sub,
            BinOp::Mul,
            BinOp::And,
            BinOp::Or,
            BinOp::Xor,
            BinOp::Shl,
            BinOp::Shr,
            BinOp::Shru,
            BinOp::Eq,
            BinOp::Ne,
            BinOp::Lt,
            BinOp::Gt,
            BinOp::Le,
            BinOp::Ge,
            BinOp::Ult,
            BinOp::Ugt,
            BinOp::Ule,
            BinOp::Uge,
            BinOp::Div,
            BinOp::Mod,
            BinOp::Divu,
            BinOp::Modu,
        ];
        const VALS: [i64; 18] = [
            0,
            1,
            -1,
            2,
            -2,
            3,
            -3,
            7,
            -7,
            63,
            64,
            65,
            -64,
            -65,
            i64::MIN,
            i64::MIN + 1,
            i64::MAX - 1,
            i64::MAX,
        ];
        for op in OPS {
            let divmod = matches!(op, BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu);
            for lhs in VALS {
                for rhs in VALS {
                    // Over the C operators the SSA builder's gate refuses
                    // exactly what `fold_binop` refuses, and folds to the
                    // same value.
                    assert_eq!(
                        fold_int_binop_imm(op, lhs, rhs),
                        fold_binop(op, lhs, rhs),
                        "{op:?} {lhs} {rhs}"
                    );
                    if divmod && rhs == 0 {
                        // A zero divisor is the folder's caller's
                        // responsibility, so only the interpreter answers.
                        assert!(apply_binop(op, lhs, rhs).is_err(), "{op:?} {lhs} 0");
                        continue;
                    }
                    assert_eq!(
                        apply_binop(op, lhs, rhs),
                        Ok(fold_int_binop(op, lhs, rhs)),
                        "{op:?} {lhs} {rhs}"
                    );
                    if let Some(folded) = fold_int_binop_imm(op, lhs, rhs) {
                        assert_eq!(Ok(folded), apply_binop(op, lhs, rhs), "{op:?} {lhs} {rhs}");
                    }
                }
            }
        }
    }

    /// The two gates part company on the opcodes no C operator produces:
    /// the SSA builder folds a rotate only for counts its own guard
    /// admits and leaves the wide multiplies to run time, while
    /// `fold_binop` answers for all of them.
    #[test]
    fn the_gates_differ_on_the_non_c_opcodes() {
        assert_eq!(fold_int_binop_imm(BinOp::Ror, 1, 1), Some(i64::MIN));
        assert_eq!(fold_binop(BinOp::Ror, 1, 1), Some(i64::MIN));
        assert_eq!(fold_int_binop_imm(BinOp::Ror, 1, 65), None);
        assert_eq!(fold_binop(BinOp::Ror, 1, 65), Some(i64::MIN));
        for op in [BinOp::Mulh, BinOp::Mulhu] {
            assert_eq!(fold_int_binop_imm(op, i64::MAX, 4), None);
            assert!(fold_binop(op, i64::MAX, 4).is_some());
        }
    }
}
