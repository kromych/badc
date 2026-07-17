//! Contract a floating-point multiply feeding an add or subtract into
//! a single fused multiply-add (`Inst::Fma`), which rounds once instead
//! of twice. C99 6.5p8 permits this when `FP_CONTRACT` is in effect;
//! it is taken to be ON at `-O` (this pass only runs there).
//!
//! Recognised shapes, where `m = Binop(Fmul, a, b)` is used by exactly
//! the add/sub being rewritten (so the separately-rounded product is
//! not observable elsewhere):
//!
//! ```text
//!   r = Binop(Fadd, m, c)   ->  Fma { a, b, c, -product=false, -addend=false }   (a*b + c)
//!   r = Binop(Fadd, c, m)   ->  Fma { a, b, c, false, false }                    (a*b + c)
//!   r = Binop(Fsub, m, c)   ->  Fma { a, b, c, false, true  }                    (a*b - c)
//!   r = Binop(Fsub, c, m)   ->  Fma { a, b, c, true,  false }                    (c - a*b)
//! ```
//!
//! The product, addend, and result must share precision (all f64 or
//! all f32) so the fused form keeps the same operand width. The rewrite
//! is in place at the add/sub's value id, preserving its f32 marker;
//! the now-unreferenced `Fmul` is dropped by the per-arch emit's
//! `use_counts` zero-skip path.

use alloc::vec::Vec;

use crate::c5::ir::{BinOp, FunctionSsa, Inst, Terminator, ValueId};

/// f32 marker for a value, defaulting to f64 when unrecorded.
fn is_f32(func: &FunctionSsa, idx: ValueId) -> bool {
    func.f32_values.get(idx as usize).copied().unwrap_or(false)
}

/// Return `(a, b)` when `idx` is `Binop(Fmul, a, b)` of the requested
/// precision; `None` otherwise.
fn as_fmul(func: &FunctionSsa, idx: ValueId, want_f32: bool) -> Option<(ValueId, ValueId)> {
    match func.insts.get(idx as usize)? {
        Inst::Binop {
            op: BinOp::Fmul,
            lhs,
            rhs,
        } if is_f32(func, idx) == want_f32 => Some((*lhs, *rhs)),
        _ => None,
    }
}

/// Count uses of every value across the function so contraction only
/// fires on a product that feeds nothing but the add/sub.
fn use_counts(func: &FunctionSsa) -> Vec<u32> {
    let mut counts = alloc::vec![0u32; func.insts.len()];
    for inst in &func.insts {
        crate::c5::codegen::ssa::reg_alloc::for_each_operand(inst, |v| {
            if let Some(slot) = counts.get_mut(v as usize) {
                *slot += 1;
            }
        });
    }
    let mut bump = |v: ValueId| {
        if let Some(slot) = counts.get_mut(v as usize) {
            *slot += 1;
        }
    };
    for block in &func.blocks {
        match block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => bump(cond),
            Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. } => {
                bump(target)
            }
            Terminator::Return(v) => bump(v),
            Terminator::Jmp(_)
            | Terminator::TailExt(_)
            | Terminator::FallThrough(_)
            | Terminator::Unreachable => {}
        }
        if block.exit_acc != crate::c5::ir::NO_VALUE {
            bump(block.exit_acc);
        }
    }
    counts
}

/// Recognise a contractible add/sub at `idx`. Returns the replacement
/// `Inst::Fma` on a match.
fn match_fma(func: &FunctionSsa, counts: &[u32], idx: usize) -> Option<Inst> {
    let want_f32 = is_f32(func, idx as ValueId);
    let (op, lhs, rhs) = match &func.insts[idx] {
        Inst::Binop {
            op: op @ (BinOp::Fadd | BinOp::Fsub),
            lhs,
            rhs,
        } => (*op, *lhs, *rhs),
        _ => return None,
    };
    // A product is contractible only when its sole consumer is this
    // add/sub and it shares the result's precision.
    let single_use_fmul = |m: ValueId| -> Option<(ValueId, ValueId)> {
        if counts.get(m as usize).copied().unwrap_or(0) != 1 {
            return None;
        }
        as_fmul(func, m, want_f32)
    };
    // The addend must match precision too.
    let addend_ok = |c: ValueId| is_f32(func, c) == want_f32;
    match op {
        BinOp::Fadd => {
            if let Some((a, b)) = single_use_fmul(lhs)
                && addend_ok(rhs)
            {
                return Some(Inst::Fma {
                    a,
                    b,
                    c: rhs,
                    neg_product: false,
                    neg_addend: false,
                });
            }
            if let Some((a, b)) = single_use_fmul(rhs)
                && addend_ok(lhs)
            {
                return Some(Inst::Fma {
                    a,
                    b,
                    c: lhs,
                    neg_product: false,
                    neg_addend: false,
                });
            }
            None
        }
        BinOp::Fsub => {
            // m - c  ->  a*b - c
            if let Some((a, b)) = single_use_fmul(lhs)
                && addend_ok(rhs)
            {
                return Some(Inst::Fma {
                    a,
                    b,
                    c: rhs,
                    neg_product: false,
                    neg_addend: true,
                });
            }
            // c - m  ->  c - a*b
            if let Some((a, b)) = single_use_fmul(rhs)
                && addend_ok(lhs)
            {
                return Some(Inst::Fma {
                    a,
                    b,
                    c: lhs,
                    neg_product: true,
                    neg_addend: false,
                });
            }
            None
        }
        _ => None,
    }
}

/// Walk every function, contracting recognised multiply-add chains.
pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        let counts = use_counts(func);
        let n = func.insts.len();
        let mut rewrites: Vec<(usize, Inst)> = Vec::new();
        for idx in 0..n {
            if let Some(fma) = match_fma(func, &counts, idx) {
                rewrites.push((idx, fma));
            }
        }
        for (idx, fma) in rewrites {
            func.insts[idx] = fma;
        }
    }
}
