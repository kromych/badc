//! Rebuild the single modulo the SSA builder split when nothing else
//! consumes its quotient.
//!
//! `ssa::build` lowers `n % d` over a register divisor to
//! `q = n / d; t = q * d; n - t`, so a division over the same operands
//! reaches `q` instead of issuing a second one -- through the builder's
//! block cache in either source order, and through `passes::cse` across
//! dominating blocks. Where no such division exists the split is pure
//! cost: both targets take the remainder from one divide instruction
//! (aarch64 `sdiv` + `msub`, x86_64 `idiv`'s remainder half).
//!
//! Running after the value numbering makes the use counts final: a `q`
//! whose only consumer is the multiply found no partner, so the
//! subtract goes back to `Mod` / `Modu` and the divide and the multiply
//! are left unreferenced for the allocator's dead-pure skip.
//!
//! The three values must share a block. A divide in a dominating block
//! also runs on paths that never reach the subtract, so folding it in
//! would move where a divide by zero traps.

use crate::c5::codegen::ssa::reg_alloc::compute_use_counts;
use crate::c5::ir::{BinOp, FunctionSsa, Inst, ValueId, remainder_op};

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs {
        run_one(func);
    }
}

/// `(lhs, rhs)` when `idx` names `Binop(op, lhs, rhs)`.
fn as_binop(func: &FunctionSsa, idx: ValueId, op: BinOp) -> Option<(ValueId, ValueId)> {
    match func.insts.get(idx as usize)? {
        Inst::Binop { op: got, lhs, rhs } if *got == op => Some((*lhs, *rhs)),
        _ => None,
    }
}

/// The divisor as the multiply carries it. Inlining can turn a
/// parameter divisor into a constant, which `passes::constfold` then
/// moves into the multiply's opcode; the divide keeps its operand.
enum Divisor {
    Val(ValueId),
    Imm(i64),
}

/// `(quotient, divisor)` when `idx` names `q * d`.
fn as_product(func: &FunctionSsa, idx: ValueId) -> Option<(ValueId, Divisor)> {
    match func.insts.get(idx as usize)? {
        Inst::Binop {
            op: BinOp::Mul,
            lhs,
            rhs,
        } => Some((*lhs, Divisor::Val(*rhs))),
        Inst::BinopI {
            op: BinOp::Mul,
            lhs,
            rhs_imm,
        } => Some((*lhs, Divisor::Imm(*rhs_imm))),
        _ => None,
    }
}

fn same_divisor(func: &FunctionSsa, want: &Divisor, d: ValueId) -> bool {
    match want {
        Divisor::Val(v) => *v == d,
        Divisor::Imm(k) => matches!(func.insts.get(d as usize), Some(Inst::Imm(got)) if got == k),
    }
}

fn run_one(func: &mut FunctionSsa) {
    let counts = compute_use_counts(func);
    let single_use = |v: ValueId| counts.get(v as usize).copied() == Some(1);
    let ranges: alloc::vec::Vec<core::ops::Range<u32>> =
        func.blocks.iter().map(|b| b.inst_range.clone()).collect();
    for range in ranges {
        for v in range.clone() {
            let Some((n, t)) = as_binop(func, v, BinOp::Sub) else {
                continue;
            };
            if !range.contains(&t) || !single_use(t) {
                continue;
            }
            let Some((q, want)) = as_product(func, t) else {
                continue;
            };
            if !range.contains(&q) || !single_use(q) {
                continue;
            }
            let Some(&Inst::Binop {
                op: div,
                lhs: dividend,
                rhs: d,
            }) = func.insts.get(q as usize)
            else {
                continue;
            };
            if dividend != n || !same_divisor(func, &want, d) {
                continue;
            }
            if let Some(op) = remainder_op(div) {
                func.insts[v as usize] = Inst::Binop { op, lhs: n, rhs: d };
            }
        }
    }
}

#[cfg(test)]
mod tests;
