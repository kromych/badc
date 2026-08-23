//! Contract an integer multiply feeding an add or a subtract into a
//! single multiply-accumulate (`Inst::MulAdd`).
//!
//! Recognised shapes, where `m = Binop(Mul, a, b)` is read by exactly
//! the add / sub being rewritten:
//!
//! ```text
//!   r = Binop(Add, m, c)   ->  MulAdd { a, b, c, neg_product: false }
//!   r = Binop(Add, c, m)   ->  MulAdd { a, b, c, neg_product: false }
//!   r = Binop(Sub, c, m)   ->  MulAdd { a, b, c, neg_product: true }
//! ```
//!
//! `Binop(Sub, m, c)` -- `a*b - c` -- has no fused form: AArch64's
//! `msub` subtracts the product from the addend, not the reverse.
//!
//! Two's-complement multiply and add agree modulo 2^64 whether or not
//! the product passes through a register of its own, so unlike the
//! floating-point contraction in `fma` this one changes no value.
//!
//! A product with a second reader stays where it is; the rewrite is in
//! place at the add / sub's value id and leaves the `Mul` for the
//! per-arch emit's `use_counts` zero-skip path.
//!
//! Only a target with a three-operand multiply-accumulate runs this.
//! x86-64 lowers the node back to the `imul` pair it replaced (see the
//! emit), and holding both multiplicands live to the accumulate rather
//! than the product costs it: +17 instructions over `tests/snapshots`
//! and +14 over `demos/sqlite3/sqlite3.c`, against -45 and -17 on
//! aarch64.
//!
//! TODO: a constant multiplier stays in `BinopI` and does not
//! contract, which leaves the constant-divisor remainder
//! (`magic.rs`) at `mov`, `mul`, `sub` where `mov`, `msub` would do.

use alloc::vec::Vec;

use crate::c5::codegen::ssa::reg_alloc::compute_use_counts;
use crate::c5::ir::{BinOp, FunctionSsa, Inst, ValueId};

/// `(a, b)` when `idx` names a `Mul` whose only reader is the
/// instruction being rewritten.
fn single_use_mul(func: &FunctionSsa, counts: &[u32], idx: ValueId) -> Option<(ValueId, ValueId)> {
    if counts.get(idx as usize).copied().unwrap_or(0) != 1 {
        return None;
    }
    match func.insts.get(idx as usize)? {
        Inst::Binop {
            op: BinOp::Mul,
            lhs,
            rhs,
        } => Some((*lhs, *rhs)),
        _ => None,
    }
}

/// The replacement node for a contractible add / sub at `idx`.
fn match_mul_add(func: &FunctionSsa, counts: &[u32], idx: usize) -> Option<Inst> {
    let (op, lhs, rhs) = match &func.insts[idx] {
        Inst::Binop {
            op: op @ (BinOp::Add | BinOp::Sub),
            lhs,
            rhs,
        } => (*op, *lhs, *rhs),
        _ => return None,
    };
    if op == BinOp::Add
        && let Some((a, b)) = single_use_mul(func, counts, lhs)
    {
        return Some(Inst::MulAdd {
            a,
            b,
            c: rhs,
            neg_product: false,
        });
    }
    let (a, b) = single_use_mul(func, counts, rhs)?;
    Some(Inst::MulAdd {
        a,
        b,
        c: lhs,
        neg_product: op == BinOp::Sub,
    })
}

/// Walk every function, contracting recognised multiply-accumulates.
pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        let counts = compute_use_counts(func);
        let mut rewrites: Vec<(usize, Inst)> = Vec::new();
        for idx in 0..func.insts.len() {
            if let Some(fused) = match_mul_add(func, &counts, idx) {
                rewrites.push((idx, fused));
            }
        }
        for (idx, fused) in rewrites {
            func.insts[idx] = fused;
        }
    }
}

#[cfg(test)]
mod tests;
