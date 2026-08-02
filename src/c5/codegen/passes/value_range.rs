//! Integer comparisons decided by a dominating branch condition.
//!
//! Every other `-O` fold reads an operand that is already an immediate.
//! A comparison whose answer follows from the condition guarding the
//! block it sits in has no immediate anywhere, so it stayed a runtime
//! test and the arm it selects stayed live -- including an arm holding a
//! build-time-assert call the source expects to be unreachable.
//!
//! The analysis is a range per expression, carried down the dominator
//! tree. Entering a block whose only predecessor ends in a conditional
//! branch, the condition's comparison holds (or its negation does) on
//! every path in, so the compared expression's range narrows for that
//! subtree. Instructions contribute their own bounds on the way through:
//! a mask bounds its result, an extension bounds it to the accessed
//! width. A comparison the ranges settle is rewritten to its answer,
//! which is what the branch folder and the unreachable-block prune in
//! [`super::simplify_branches`] consume.
//!
//! Ranges are keyed by expression rather than by value id, so a
//! re-materialised operand -- the same extension of the same value
//! emitted in two blocks -- reads the fact recorded for the other. The
//! key covers only pure arithmetic; a load or a call is opaque, so
//! nothing is carried across a write to memory.

use alloc::collections::BTreeMap;
use alloc::vec::Vec;

use crate::c5::ir::{BinOp, BlockId, FunctionSsa, Inst, LoadKind, Terminator, ValueId};

/// Inclusive bounds on a value's 64-bit register contents, read as a
/// signed integer. `i128` so intersection and the +-1 steps below cannot
/// overflow at the extremes.
#[derive(Clone, Copy, PartialEq, Eq)]
struct Range {
    lo: i128,
    hi: i128,
}

const UNIVERSE: Range = Range {
    lo: i64::MIN as i128,
    hi: i64::MAX as i128,
};

impl Range {
    fn exact(v: i64) -> Self {
        Range {
            lo: v as i128,
            hi: v as i128,
        }
    }

    fn meet(self, other: Range) -> Range {
        Range {
            lo: self.lo.max(other.lo),
            hi: self.hi.min(other.hi),
        }
    }

    fn contains(self, other: Range) -> bool {
        self.lo <= other.lo && other.hi <= self.hi
    }

    /// True when every value in the range is non-negative, so the
    /// unsigned reading of the register equals the signed one.
    fn non_negative(self) -> bool {
        self.lo >= 0
    }
}

/// Expression identity: `(tag, a, b, imm)`. Two instructions with the
/// same key compute the same value wherever both are in scope, because
/// their operands are SSA values. Only pure integer arithmetic gets a
/// structural key; everything else keys on its own value id.
type Key = (u8, u32, u32, i64);

fn opaque_key(v: ValueId) -> Key {
    (0, v, 0, 0)
}

fn key_of(insts: &[Inst], v: ValueId) -> Key {
    match insts.get(v as usize) {
        Some(Inst::Imm(k)) => (1, 0, 0, *k),
        Some(Inst::Extend { value, kind }) => (2, *value, load_kind_code(*kind), 0),
        Some(Inst::BinopI { op, lhs, rhs_imm }) if is_pure_int(*op) => {
            (3, *lhs, binop_code(*op), *rhs_imm)
        }
        Some(Inst::Binop { op, lhs, rhs }) if is_pure_int(*op) => {
            (4, *lhs, *rhs, binop_code(*op).into())
        }
        _ => opaque_key(v),
    }
}

fn load_kind_code(k: LoadKind) -> u32 {
    match k {
        LoadKind::I64 => 0,
        LoadKind::U8 => 1,
        LoadKind::I8 => 2,
        LoadKind::I32 => 3,
        LoadKind::U32 => 4,
        LoadKind::I16 => 5,
        LoadKind::U16 => 6,
        LoadKind::F32 => 7,
        LoadKind::F64 => 8,
    }
}

fn binop_code(op: BinOp) -> u32 {
    op as u32
}

/// Integer operators whose result is a function of the operand values
/// alone. The floating-point opcodes are excluded: their results are
/// not integers and the ranges here would not describe them.
fn is_pure_int(op: BinOp) -> bool {
    !matches!(
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
    )
}

/// Integer comparison operators, with whether they read their operands
/// as unsigned.
fn comparison(op: BinOp) -> Option<bool> {
    Some(match op {
        BinOp::Eq | BinOp::Ne | BinOp::Lt | BinOp::Gt | BinOp::Le | BinOp::Ge => false,
        BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge => true,
        _ => return None,
    })
}

/// Bounds an extension's result takes from the width it reads.
fn extend_range(kind: LoadKind) -> Option<Range> {
    Some(match kind {
        LoadKind::I64 => return None,
        LoadKind::U8 => Range { lo: 0, hi: 0xff },
        LoadKind::I8 => Range { lo: -0x80, hi: 0x7f },
        LoadKind::U16 => Range { lo: 0, hi: 0xffff },
        LoadKind::I16 => Range {
            lo: -0x8000,
            hi: 0x7fff,
        },
        LoadKind::U32 => Range {
            lo: 0,
            hi: 0xffff_ffff,
        },
        LoadKind::I32 => Range {
            lo: i32::MIN as i128,
            hi: i32::MAX as i128,
        },
        LoadKind::F32 | LoadKind::F64 => return None,
    })
}

/// Scoped fact map: a range per expression key, with an undo log so the
/// dominator-tree walk can drop a subtree's facts on the way back up.
#[derive(Default)]
struct Facts {
    live: BTreeMap<Key, Range>,
    undo: Vec<(Key, Option<Range>)>,
}

impl Facts {
    fn get(&self, key: Key) -> Range {
        self.live.get(&key).copied().unwrap_or(UNIVERSE)
    }

    fn set(&mut self, key: Key, r: Range) {
        let prev = self.live.insert(key, r);
        self.undo.push((key, prev));
    }

    /// Narrow `key` and report whether the result is empty, which means
    /// the block cannot be entered under this fact.
    fn narrow(&mut self, key: Key, r: Range) {
        let merged = self.get(key).meet(r);
        self.set(key, merged);
    }

    fn mark(&self) -> usize {
        self.undo.len()
    }

    fn rewind(&mut self, mark: usize) {
        while self.undo.len() > mark {
            let (key, prev) = self.undo.pop().expect("mark is a prior length");
            match prev {
                Some(r) => self.live.insert(key, r),
                None => self.live.remove(&key),
            };
        }
    }
}

/// Answer a comparison from its operand ranges, or `None` when the
/// ranges overlap enough to leave it open.
fn decide(op: BinOp, a: Range, b: Range) -> Option<bool> {
    let unsigned = comparison(op)?;
    if unsigned && !(a.non_negative() && b.non_negative()) {
        return None;
    }
    let lt = a.hi < b.lo;
    let gt = a.lo > b.hi;
    let eq = a.lo == a.hi && b.lo == b.hi && a.lo == b.lo;
    Some(match op {
        BinOp::Eq => {
            if eq {
                true
            } else if lt || gt {
                false
            } else {
                return None;
            }
        }
        BinOp::Ne => {
            if eq {
                false
            } else if lt || gt {
                true
            } else {
                return None;
            }
        }
        BinOp::Lt | BinOp::Ult => {
            if lt {
                true
            } else if a.lo >= b.hi {
                false
            } else {
                return None;
            }
        }
        BinOp::Le | BinOp::Ule => {
            if a.hi <= b.lo {
                true
            } else if gt {
                false
            } else {
                return None;
            }
        }
        BinOp::Gt | BinOp::Ugt => {
            if gt {
                true
            } else if a.hi <= b.lo {
                false
            } else {
                return None;
            }
        }
        _ => {
            if a.lo >= b.hi {
                true
            } else if lt {
                false
            } else {
                return None;
            }
        }
    })
}

/// The range `x` takes when `op(x, k)` has the given truth value.
/// Narrowing an inequality is exact; a disequality only moves an
/// endpoint, which is what an enumerated state excluded by a loop
/// condition needs.
fn implied(op: BinOp, k: i128, holds: bool, current: Range) -> Option<Range> {
    let unsigned = comparison(op)?;
    if unsigned && !(current.non_negative() && k >= 0) {
        return None;
    }
    let (lo, hi) = (current.lo, current.hi);
    Some(match (op, holds) {
        (BinOp::Eq, true) | (BinOp::Ne, false) => Range { lo: k, hi: k },
        (BinOp::Eq, false) | (BinOp::Ne, true) => Range {
            lo: if lo == k { lo + 1 } else { lo },
            hi: if hi == k { hi - 1 } else { hi },
        },
        (BinOp::Lt | BinOp::Ult, true) | (BinOp::Ge | BinOp::Uge, false) => Range { lo, hi: k - 1 },
        (BinOp::Lt | BinOp::Ult, false) | (BinOp::Ge | BinOp::Uge, true) => Range { lo: k, hi },
        (BinOp::Le | BinOp::Ule, true) | (BinOp::Gt | BinOp::Ugt, false) => Range { lo, hi: k },
        _ => Range { lo: k + 1, hi },
    })
}

/// Forward bounds for an instruction, given its operands' ranges.
fn eval(insts: &[Inst], facts: &Facts, inst: &Inst) -> Range {
    let range_of = |v: ValueId| facts.get(key_of(insts, v));
    match inst {
        Inst::Imm(k) => Range::exact(*k),
        // A floating-point widening produces no integer, so it carries
        // no bounds; `I64` is the identity.
        Inst::Extend {
            kind: LoadKind::F32 | LoadKind::F64,
            ..
        } => UNIVERSE,
        Inst::Extend { value, kind } => {
            let src = range_of(*value);
            match extend_range(*kind) {
                // The extension is the identity on a value that already
                // fits the accessed width.
                Some(w) if w.contains(src) => src,
                Some(w) => w,
                None => src,
            }
        }
        Inst::BinopI { op, lhs, rhs_imm } => match op {
            _ if comparison(*op).is_some() => Range { lo: 0, hi: 1 },
            // A mask by a non-negative immediate bounds the result by
            // the mask, and never makes it negative. The masked operand
            // bounds it too only when it is itself non-negative: masking
            // a negative value yields a large positive one.
            BinOp::And if *rhs_imm >= 0 => {
                let l = range_of(*lhs);
                Range {
                    lo: 0,
                    hi: if l.non_negative() {
                        (*rhs_imm as i128).min(l.hi)
                    } else {
                        *rhs_imm as i128
                    },
                }
            }
            _ => UNIVERSE,
        },
        Inst::Binop { op, lhs, rhs } => match op {
            _ if comparison(*op).is_some() => Range { lo: 0, hi: 1 },
            BinOp::And => {
                let (a, b) = (range_of(*lhs), range_of(*rhs));
                match (a.non_negative(), b.non_negative()) {
                    (true, true) => Range {
                        lo: 0,
                        hi: a.hi.min(b.hi),
                    },
                    (true, false) => Range { lo: 0, hi: a.hi },
                    (false, true) => Range { lo: 0, hi: b.hi },
                    _ => UNIVERSE,
                }
            }
            _ => UNIVERSE,
        },
        // A width-limited read cannot produce a value outside the width
        // it extends from.
        Inst::Load { kind, .. } | Inst::LoadLocal { kind, .. } | Inst::ParamRef { kind, .. } => {
            extend_range(*kind).unwrap_or(UNIVERSE)
        }
        _ => UNIVERSE,
    }
}

/// Facts the edge from `pred` into its single successor carries: the
/// branch condition's own value, and the range its comparison implies
/// for the compared expression.
fn apply_edge(func: &FunctionSsa, facts: &mut Facts, pred: BlockId, holds: bool) {
    let cond = match func.blocks[pred as usize].terminator {
        Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => cond,
        _ => return,
    };
    let insts = func.insts.as_slice();
    facts.narrow(
        key_of(insts, cond),
        if holds {
            Range { lo: 1, hi: 1 }
        } else {
            Range { lo: 0, hi: 0 }
        },
    );
    // A condition that is itself a comparison narrows what it compares.
    let (op, lhs, rhs_range) = match insts.get(cond as usize) {
        Some(Inst::BinopI { op, lhs, rhs_imm }) => (*op, *lhs, Range::exact(*rhs_imm)),
        Some(Inst::Binop { op, lhs, rhs }) => {
            let r = facts.get(key_of(insts, *rhs));
            if r.lo != r.hi {
                return;
            }
            (*op, *lhs, r)
        }
        _ => return,
    };
    let key = key_of(insts, lhs);
    let current = facts.get(key);
    if let Some(r) = implied(op, rhs_range.lo, holds, current) {
        facts.narrow(key, r);
    }
}

/// Rewrite every comparison the dominating conditions settle. Returns
/// whether the function changed, so the caller's fixed point can
/// re-run the branch fold and the prune on the result.
pub(crate) fn run_one(func: &mut FunctionSsa) -> bool {
    let n = func.blocks.len();
    if n == 0 {
        return false;
    }
    let idom = crate::c5::codegen::ssa::mem2reg::dominators(func);
    let preds = crate::c5::codegen::ssa::mem2reg::predecessors(func);
    // Dominator-tree children, so the walk visits each block once with
    // its dominators' facts in scope.
    let mut children: Vec<Vec<BlockId>> = alloc::vec![Vec::new(); n];
    for b in 1..n {
        let d = idom[b];
        if d != BlockId::MAX && (d as usize) != b {
            children[d as usize].push(b as BlockId);
        }
    }
    let mut facts = Facts::default();
    let mut folded: Vec<(u32, i64)> = Vec::new();
    // Explicit stack: `Enter(b)` walks the block, `Leave(mark)` drops
    // the facts its subtree contributed.
    enum Step {
        Enter(BlockId),
        Leave(usize),
    }
    let mut stack = alloc::vec![Step::Enter(0)];
    while let Some(step) = stack.pop() {
        let b = match step {
            Step::Leave(mark) => {
                facts.rewind(mark);
                continue;
            }
            Step::Enter(b) => b,
        };
        let mark = facts.mark();
        stack.push(Step::Leave(mark));
        // A block reached from one predecessor carries that edge's
        // condition; with more than one predecessor the paths disagree.
        if let [p] = preds[b as usize][..] {
            let holds = match func.blocks[p as usize].terminator {
                Terminator::Bz {
                    target,
                    fall_through,
                    ..
                } if target != fall_through => Some(target != b),
                Terminator::Bnz {
                    target,
                    fall_through,
                    ..
                } if target != fall_through => Some(target == b),
                _ => None,
            };
            if let Some(holds) = holds {
                apply_edge(func, &mut facts, p, holds);
            }
        }
        let range = func.blocks[b as usize].inst_range.clone();
        for pc in range.start..range.end {
            let inst = &func.insts[pc as usize];
            let key = key_of(func.insts.as_slice(), pc);
            let r = eval(func.insts.as_slice(), &facts, inst).meet(facts.get(key));
            let decided = match inst {
                Inst::BinopI { op, lhs, rhs_imm } => decide(
                    *op,
                    facts.get(key_of(func.insts.as_slice(), *lhs)),
                    Range::exact(*rhs_imm),
                ),
                Inst::Binop { op, lhs, rhs } => decide(
                    *op,
                    facts.get(key_of(func.insts.as_slice(), *lhs)),
                    facts.get(key_of(func.insts.as_slice(), *rhs)),
                ),
                _ => None,
            };
            match decided {
                Some(v) => {
                    folded.push((pc, v as i64));
                    facts.set(key, Range::exact(v as i64));
                }
                None => facts.set(key, r),
            }
        }
        for &c in &children[b as usize] {
            stack.push(Step::Enter(c));
        }
    }
    for &(pc, v) in &folded {
        func.insts[pc as usize] = Inst::Imm(v);
    }
    !folded.is_empty()
}
