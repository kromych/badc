//! Recognise `(x >> c) | (x << (W - c))` shapes and fold them to a
//! single `BinopI(Ror, x, c)`. Runs after `ssa_inline` so post-inline
//! rotates exposed by parameter substitution become recognisable.
//!
//! Two patterns are matched today:
//!
//! 1. **Constant immediates on both shifts**:
//!    ```text
//!    a = BinopI(Shru, x, C1)
//!    b = BinopI(Shl, x, C2)        with C1 + C2 == 64
//!    or = Binop(Or, a, b)          -> BinopI(Ror, x, C1)
//!    ```
//!
//! 2. **Constant rotate amount, value-form shift counts** (the shape
//!    SHA-512's `R(x,c)` lowers to after inlining):
//!    ```text
//!    vc  = Imm(C)
//!    a   = Binop(Shru, x, vc)
//!    v64 = Imm(64)
//!    sub = Binop(Sub, v64, vc)
//!    lo  = BinopI(Shl, sub, 32)     # sign-narrow (64-c) i32 -> i64
//!    hi  = BinopI(Shr, lo, 32)
//!    b   = Binop(Shl, x, hi)
//!    or  = Binop(Or, a, b)          -> BinopI(Ror, x, C)
//!    ```
//!
//! The OR's variant is rewritten in place; its operands' use-counts
//! drop to zero and the per-arch emit DCEs them via the existing
//! `use_counts` zero-skip path.

use alloc::vec::Vec;

use super::super::ir::{BinOp, FunctionSsa, Inst, ValueId};

/// Look at `idx`'s def in `func`; return `Some(C)` when it is
/// `Inst::Imm(C)`. Conservatively returns `None` otherwise.
fn const_imm(func: &FunctionSsa, idx: ValueId) -> Option<i64> {
    if let Some(Inst::Imm(c)) = func.insts.get(idx as usize) {
        Some(*c)
    } else {
        None
    }
}

/// Trace a 32-bit sign-narrow pair `BinopI(Shr, BinopI(Shl, v, 32),
/// 32)` and return the inner `v`. Returns `None` when the chain
/// doesn't match exactly. The pair is what the walker emits when
/// promoting an int (i32) value to an i64 shift count.
fn strip_sign_narrow_32(func: &FunctionSsa, idx: ValueId) -> Option<ValueId> {
    let hi = func.insts.get(idx as usize)?;
    let Inst::BinopI {
        op: BinOp::Shr,
        lhs: lo_id,
        rhs_imm: 32,
    } = hi
    else {
        return None;
    };
    let lo = func.insts.get(*lo_id as usize)?;
    let Inst::BinopI {
        op: BinOp::Shl,
        lhs: v,
        rhs_imm: 32,
    } = lo
    else {
        return None;
    };
    Some(*v)
}

/// Attempt to recognise the rotate pattern at the OR named by
/// `or_idx`. Returns `Some((x, C))` on a match. `C` is the
/// rotate-right count and lands in `1..=63`.
fn match_rotate(func: &FunctionSsa, or_idx: usize) -> Option<(ValueId, i64)> {
    let Inst::Binop {
        op: BinOp::Or,
        lhs,
        rhs,
    } = &func.insts[or_idx]
    else {
        return None;
    };
    let try_one = |a: ValueId, b: ValueId| -> Option<(ValueId, i64)> {
        // a should be the shru leg; b should be the shl leg.
        let shru = func.insts.get(a as usize)?;
        let (x_a, count_a) = match shru {
            Inst::BinopI {
                op: BinOp::Shru,
                lhs,
                rhs_imm,
            } => (*lhs, ShiftAmount::Imm(*rhs_imm)),
            Inst::Binop {
                op: BinOp::Shru,
                lhs,
                rhs,
            } => (*lhs, ShiftAmount::Value(*rhs)),
            _ => return None,
        };
        let shl = func.insts.get(b as usize)?;
        let (x_b, count_b) = match shl {
            Inst::BinopI {
                op: BinOp::Shl,
                lhs,
                rhs_imm,
            } => (*lhs, ShiftAmount::Imm(*rhs_imm)),
            Inst::Binop {
                op: BinOp::Shl,
                lhs,
                rhs,
            } => (*lhs, ShiftAmount::Value(*rhs)),
            _ => return None,
        };
        if x_a != x_b {
            return None;
        }
        // Determine the rotate count by resolving both shift amounts
        // to constants where possible.
        let c_a = match count_a {
            ShiftAmount::Imm(c) => Some(c),
            ShiftAmount::Value(v) => const_imm(func, v),
        }?;
        let c_b = match count_b {
            ShiftAmount::Imm(c) => c,
            ShiftAmount::Value(v) => {
                if let Some(c) = const_imm(func, v) {
                    c
                } else {
                    // Try the sign-narrowed `64 - C` form: v's def is
                    // BinopI(Shr, BinopI(Shl, sub, 32), 32) where
                    // sub = Binop(Sub, Imm(64), Imm(C)).
                    let inner = strip_sign_narrow_32(func, v)?;
                    let sub_inst = func.insts.get(inner as usize)?;
                    let Inst::Binop {
                        op: BinOp::Sub,
                        lhs: sub_lhs,
                        rhs: sub_rhs,
                    } = sub_inst
                    else {
                        return None;
                    };
                    let lhs_c = const_imm(func, *sub_lhs)?;
                    let rhs_c = const_imm(func, *sub_rhs)?;
                    if lhs_c != 64 {
                        return None;
                    }
                    lhs_c - rhs_c
                }
            }
        };
        if !(1..=63).contains(&c_a) || !(1..=63).contains(&c_b) {
            return None;
        }
        if c_a + c_b != 64 {
            return None;
        }
        Some((x_a, c_a))
    };
    if let Some(res) = try_one(*lhs, *rhs) {
        return Some(res);
    }
    // Commutative -- try swapped operands.
    try_one(*rhs, *lhs)
}

enum ShiftAmount {
    Imm(i64),
    Value(ValueId),
}

/// Walk every function, rewrite recognised rotates to
/// `BinopI(Ror, x, C)`.
pub(super) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        let n = func.insts.len();
        let mut rewrites: Vec<(usize, ValueId, i64)> = Vec::new();
        for idx in 0..n {
            if let Some((x, c)) = match_rotate(func, idx) {
                rewrites.push((idx, x, c));
            }
        }
        for (idx, x, c) in rewrites {
            func.insts[idx] = Inst::BinopI {
                op: BinOp::Ror,
                lhs: x,
                rhs_imm: c,
            };
        }
    }
}
