//! Recognise `(x >> c) | (x << (W - c))` shapes and fold them to a
//! single `Ror`. Runs after `ssa_inline` so post-inline rotates
//! exposed by parameter substitution become recognisable. Only the
//! 64-bit form (`W == 64`) is matched; the per-arch emit rotates the
//! full register.
//!
//! Three patterns are matched:
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
//!    sub = Binop(Sub, Imm(64), vc)  # possibly i32 sign-narrowed
//!    b   = Binop(Shl, x, sub)
//!    or  = Binop(Or, a, b)          -> BinopI(Ror, x, C)
//!    ```
//!
//! 3. **Runtime rotate amount**: the shru count is a value `c` and the
//!    shl count is `64 - c` (the same value, direct or i32
//!    sign-narrowed):
//!    ```text
//!    a   = Binop(Shru, x, c)
//!    b   = Binop(Shl, x, Sub(Imm(64), c))
//!    or  = Binop(Or, a, b)          -> Binop(Ror, x, c)
//!    ```
//!    The hardware rotate masks the count to the operand width, so the
//!    fold holds for every `c`.
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

enum ShiftAmount {
    Imm(i64),
    Value(ValueId),
}

/// Rotate-right count: a compile-time constant or a runtime value.
enum RotateBy {
    Imm(i64),
    Val(ValueId),
}

/// The shl leg's count resolved against the `64 - c` rotate form: a
/// literal count, or the value `c` in `64 - c` (direct or i32
/// sign-narrowed).
enum ShlCount {
    Const(i64),
    Complement(ValueId),
}

/// If `v` -- directly or through the i32 sign-narrow pair -- is
/// `Sub(Imm(64), w)`, return `w`.
fn sub64_rhs(func: &FunctionSsa, v: ValueId) -> Option<ValueId> {
    let sub_id = match func.insts.get(v as usize)? {
        Inst::Binop { op: BinOp::Sub, .. } => v,
        _ => strip_sign_narrow_32(func, v)?,
    };
    let Inst::Binop {
        op: BinOp::Sub,
        lhs,
        rhs,
    } = func.insts.get(sub_id as usize)?
    else {
        return None;
    };
    (const_imm(func, *lhs) == Some(64)).then_some(*rhs)
}

fn resolve_shl_count(func: &FunctionSsa, count: &ShiftAmount) -> Option<ShlCount> {
    match count {
        ShiftAmount::Imm(c) => Some(ShlCount::Const(*c)),
        ShiftAmount::Value(v) => {
            if let Some(c) = const_imm(func, *v) {
                return Some(ShlCount::Const(c));
            }
            let w = sub64_rhs(func, *v)?;
            match const_imm(func, w) {
                Some(c) => Some(ShlCount::Const(64 - c)),
                None => Some(ShlCount::Complement(w)),
            }
        }
    }
}

/// Attempt to recognise the rotate pattern at the OR named by
/// `or_idx`. Returns `Some((x, by))` on a match. A constant count
/// lands in `1..=63`.
fn match_rotate(func: &FunctionSsa, or_idx: usize) -> Option<(ValueId, RotateBy)> {
    let Inst::Binop {
        op: BinOp::Or,
        lhs,
        rhs,
    } = &func.insts[or_idx]
    else {
        return None;
    };
    let try_one = |a: ValueId, b: ValueId| -> Option<(ValueId, RotateBy)> {
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
        match resolve_shl_count(func, &count_b)? {
            // Both counts constant and complementary -> rotate by C.
            ShlCount::Const(cb) => {
                let ca = match count_a {
                    ShiftAmount::Imm(c) => c,
                    ShiftAmount::Value(v) => const_imm(func, v)?,
                };
                if (1..=63).contains(&ca) && (1..=63).contains(&cb) && ca + cb == 64 {
                    Some((x_a, RotateBy::Imm(ca)))
                } else {
                    None
                }
            }
            // The shl count is `64 - vc`; the shru count must be that
            // same `vc`. The hardware rotate masks the count to the
            // operand width, so the 64-bit rotate is correct for every
            // vc.
            ShlCount::Complement(w) => match count_a {
                ShiftAmount::Value(vc) if vc == w => Some((x_a, RotateBy::Val(vc))),
                _ => None,
            },
        }
    };
    try_one(*lhs, *rhs).or_else(|| try_one(*rhs, *lhs))
}

/// Walk every function, rewrite recognised rotates to `Ror`.
pub(super) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        let n = func.insts.len();
        let mut rewrites: Vec<(usize, ValueId, RotateBy)> = Vec::new();
        for idx in 0..n {
            if let Some((x, by)) = match_rotate(func, idx) {
                rewrites.push((idx, x, by));
            }
        }
        for (idx, x, by) in rewrites {
            func.insts[idx] = match by {
                RotateBy::Imm(c) => Inst::BinopI {
                    op: BinOp::Ror,
                    lhs: x,
                    rhs_imm: c,
                },
                RotateBy::Val(vc) => Inst::Binop {
                    op: BinOp::Ror,
                    lhs: x,
                    rhs: vc,
                },
            };
        }
    }
}
