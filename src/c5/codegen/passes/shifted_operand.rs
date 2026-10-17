//! Fold a constant shift into the add, sub, and, or or xor that alone
//! reads it, as the AArch64 shifted-register operand (`Inst::ShiftOp`):
//! `Binop(op, a, s)` with `s = BinopI(sh, x, k)`, `sh` a shift by 1..=63
//! or a multiply by `2^k`, becomes `ShiftOp { op, lhs: a, rhs: x, sh, k }`,
//! and a commutative `op` takes `s` on either side. Both forms compute in
//! 64 bits, so no value changes. The rewrite is in place at the reader and
//! leaves the shift to the emit's skip of unread values, except that a
//! materialized immediate of a commutative `BinopI` takes over its slot.

use alloc::vec::Vec;

use crate::c5::codegen::ssa::reg_alloc::compute_use_counts;
use crate::c5::ir::{BinOp, FunctionSsa, Inst, ValueId};

/// `(x, shift, k)` when `idx` names a constant shift whose only reader is
/// the instruction being rewritten.
fn single_use_shift(
    func: &FunctionSsa,
    counts: &[u32],
    idx: ValueId,
) -> Option<(ValueId, BinOp, u8)> {
    if counts.get(idx as usize).copied().unwrap_or(0) != 1 {
        return None;
    }
    let Inst::BinopI { op, lhs, rhs_imm } = *func.insts.get(idx as usize)? else {
        return None;
    };
    let (shift, k) = match op {
        BinOp::Shl | BinOp::Shr | BinOp::Shru => (op, rhs_imm),
        BinOp::Mul if rhs_imm > 0 && (rhs_imm as u64).is_power_of_two() => {
            (BinOp::Shl, i64::from(rhs_imm.trailing_zeros()))
        }
        _ => return None,
    };
    (1..64).contains(&k).then_some((lhs, shift, k as u8))
}

/// The replacement node for a foldable reader at `idx`.
fn match_shift_op(func: &FunctionSsa, counts: &[u32], idx: usize) -> Option<Inst> {
    let Inst::Binop { op, lhs, rhs } = func.insts[idx] else {
        return None;
    };
    if !matches!(
        op,
        BinOp::Add | BinOp::Sub | BinOp::And | BinOp::Or | BinOp::Xor
    ) {
        return None;
    }
    let fused = |lhs, (rhs, shift, amount)| Inst::ShiftOp {
        op,
        lhs,
        rhs,
        shift,
        amount,
    };
    if let Some(s) = single_use_shift(func, counts, rhs) {
        return Some(fused(lhs, s));
    }
    if op == BinOp::Sub {
        return None;
    }
    single_use_shift(func, counts, lhs).map(|s| fused(rhs, s))
}

/// The rewrites, shift slot first, of a commutative `BinopI` over a single-use shift.
fn match_shift_imm(func: &FunctionSsa, counts: &[u32], idx: usize) -> Option<[(usize, Inst); 2]> {
    let Inst::BinopI { op, lhs, rhs_imm } = func.insts[idx] else {
        return None;
    };
    if !matches!(op, BinOp::Add | BinOp::And | BinOp::Or | BinOp::Xor)
        || !crate::c5::codegen::aarch64::emit::binop_imm_materializes(op, rhs_imm, false)
    {
        return None;
    }
    let (rhs, shift, amount) = single_use_shift(func, counts, lhs)?;
    Some([
        (lhs as usize, Inst::Imm(rhs_imm)),
        (
            idx,
            Inst::ShiftOp {
                op,
                lhs,
                rhs,
                shift,
                amount,
            },
        ),
    ])
}

/// Walk every function, folding recognised shifts into their readers.
pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        let counts = compute_use_counts(func);
        let mut rewrites: Vec<(usize, Inst)> = Vec::new();
        for idx in 0..func.insts.len() {
            if counts[idx] == 0 {
                continue;
            }
            if let Some(fused) = match_shift_op(func, &counts, idx) {
                rewrites.push((idx, fused));
            } else if let Some(pair) = match_shift_imm(func, &counts, idx) {
                rewrites.extend(pair);
            }
        }
        for (idx, fused) in rewrites {
            func.insts[idx] = fused;
        }
    }
}

#[cfg(test)]
mod tests;
