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
//!
//! `run_one` takes an entry range per parameter, which
//! [`super::ipa_const_param`] derives from the call sites of a function
//! only this translation unit can reach. `Inst::ParamRef` is the
//! parameter's entry value, so that range bounds every read of it.

use alloc::collections::BTreeMap;
use alloc::vec::Vec;

use crate::c5::ir::{BinOp, BlockId, FunctionSsa, Inst, LoadKind, Terminator, ValueId};

/// Inclusive bounds on a value's 64-bit register contents, read as a
/// signed integer. `i128` so intersection and the +-1 steps below cannot
/// overflow at the extremes.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(crate) struct Range {
    lo: i128,
    hi: i128,
}

pub(crate) const UNIVERSE: Range = Range {
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

    /// Smallest range containing both. Used to join what the separate
    /// call sites of one function pass for a parameter.
    pub(crate) fn hull(self, other: Range) -> Range {
        Range {
            lo: self.lo.min(other.lo),
            hi: self.hi.max(other.hi),
        }
    }

    pub(crate) fn is_universe(self) -> bool {
        self == UNIVERSE
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
/// their operands are SSA values. Pure integer arithmetic and
/// non-volatile loads get a structural key over canonical operand ids;
/// everything else keys on its own canonical id. A load key names the
/// value memory held at the read, so facts under one are only sound
/// until something writes memory; the walk in [`run_one`] wipes them at
/// every potential write and at every join.
type Key = (u8, u32, u32, i64);

fn opaque_key(v: ValueId) -> Key {
    (0, v, 0, 0)
}

fn is_load_key(k: Key) -> bool {
    (5..=7).contains(&k.0)
}

/// Canonical id per value: the first instruction computing the same
/// pure expression. Address chains re-materialised per block
/// (`LocalAddr` + constant offset, the same field read twice) collapse
/// onto one identity, which is what lets a branch fact recorded for one
/// read reach the other.
fn value_numbers(insts: &[Inst]) -> Vec<ValueId> {
    let mut canon: Vec<ValueId> = (0..insts.len() as ValueId).collect();
    let mut table: BTreeMap<Key, ValueId> = BTreeMap::new();
    for i in 0..insts.len() {
        let c = |v: ValueId| canon.get(v as usize).copied().unwrap_or(v);
        // Address-materialisation immediates (`ImmData`, `ImmCode`,
        // `ImmExtCode`, `TlsAddr`) stay on their own ids: their operand
        // is a placeholder a per-instruction fixup resolves, so equal
        // operands can name different symbols.
        let key: Key = match &insts[i] {
            Inst::Imm(k) => (1, 0, 0, *k),
            Inst::LocalAddr(off) => (5, 0, 0, *off),
            Inst::ParamRef { idx, kind } => (7, *idx as u32, load_kind_code(*kind), 0),
            Inst::Extend { value, kind } if !matches!(kind, LoadKind::F32 | LoadKind::F64) => {
                (8, c(*value), load_kind_code(*kind), 0)
            }
            Inst::BinopI { op, lhs, rhs_imm } if is_pure_int(*op) => {
                (9, c(*lhs), binop_code(*op), *rhs_imm)
            }
            Inst::Binop { op, lhs, rhs } if is_pure_int(*op) => {
                (10, c(*lhs), c(*rhs), binop_code(*op).into())
            }
            _ => continue,
        };
        match table.get(&key) {
            Some(&first) => canon[i] = first,
            None => {
                table.insert(key, i as ValueId);
            }
        }
    }
    canon
}

/// Key for a value read as an operand. A load keys on its own id: the
/// value is whatever memory held when the load ran, which no expression
/// over the current memory state describes once something has written
/// in between.
fn key_of(insts: &[Inst], canon: &[ValueId], v: ValueId) -> Key {
    let c = |x: ValueId| canon.get(x as usize).copied().unwrap_or(x);
    match insts.get(v as usize) {
        Some(Inst::Imm(k)) => (1, 0, 0, *k),
        Some(Inst::Extend { value, kind }) => (2, c(*value), load_kind_code(*kind), 0),
        Some(Inst::BinopI { op, lhs, rhs_imm }) if is_pure_int(*op) => {
            (3, c(*lhs), binop_code(*op), *rhs_imm)
        }
        Some(Inst::Binop { op, lhs, rhs }) if is_pure_int(*op) => {
            (4, c(*lhs), c(*rhs), binop_code(*op).into())
        }
        _ => opaque_key(c(v)),
    }
}

/// Positional key for what a load of this shape produces from the
/// current memory state. Sound to read or write only at a walk point
/// where the described load's execution is not separated from the
/// point by a potential memory write; [`run_one`] wipes these keys at
/// every such write and every join.
fn load_expr_key(insts: &[Inst], canon: &[ValueId], v: ValueId) -> Option<Key> {
    let c = |x: ValueId| canon.get(x as usize).copied().unwrap_or(x);
    match insts.get(v as usize) {
        Some(Inst::Load {
            addr,
            disp,
            kind,
            volatile: false,
        }) => Some((5, c(*addr), load_kind_code(*kind), *disp as i64)),
        Some(Inst::LoadLocal {
            off,
            kind,
            volatile: false,
        }) => Some((6, 0, load_kind_code(*kind), *off)),
        Some(Inst::LoadIndexed {
            base,
            index,
            scale,
            kind,
        }) => Some((
            7,
            c(*base),
            c(*index),
            ((*scale as i64) << 8) | load_kind_code(*kind) as i64,
        )),
        _ => None,
    }
}

/// Whether an instruction may write memory (or transfer control to code
/// that can), ending the validity of every load-keyed fact. Volatile
/// loads read strictly per the abstract machine but write nothing.
fn writes_memory(inst: &Inst) -> bool {
    matches!(
        inst,
        Inst::Store { .. }
            | Inst::StoreLocal { .. }
            | Inst::StoreIndexed { .. }
            | Inst::SegStore { .. }
            | Inst::Call { .. }
            | Inst::CallIndirect { .. }
            | Inst::CallExt { .. }
            | Inst::TailExt(_)
            | Inst::Mcpy { .. }
            | Inst::AtomicRmw { .. }
            | Inst::AtomicCas { .. }
            | Inst::Intrinsic { .. }
            | Inst::InlineAsm { .. }
            | Inst::AllocaInit(_)
    )
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
        LoadKind::I8 => Range {
            lo: -0x80,
            hi: 0x7f,
        },
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

    /// Drop every load-keyed fact (undo-logged): memory may have
    /// changed, so what a read produced no longer bounds what the same
    /// read produces next.
    fn wipe_loads(&mut self) {
        let stale: Vec<Key> = self
            .live
            .iter()
            .filter(|(k, r)| is_load_key(**k) && !r.is_universe())
            .map(|(k, _)| *k)
            .collect();
        for key in stale {
            self.set(key, UNIVERSE);
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
        // An unsigned bound below a non-negative k still pins the sign
        // bit clear, so it is the signed interval [0, k) whatever the
        // current range says.
        if k >= 0 {
            return match (op, holds) {
                (BinOp::Ult, true) | (BinOp::Uge, false) => Some(Range { lo: 0, hi: k - 1 }),
                (BinOp::Ule, true) | (BinOp::Ugt, false) => Some(Range { lo: 0, hi: k }),
                _ => None,
            };
        }
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

/// Interval addition / subtraction on the 64-bit register reading.
/// A bound that leaves the representable range means the operation can
/// wrap, and a wrapped interval says nothing.
fn arith(a: Range, b: Range, sub: bool) -> Range {
    let (lo, hi) = if sub {
        (a.lo - b.hi, a.hi - b.lo)
    } else {
        (a.lo + b.lo, a.hi + b.hi)
    };
    if lo < i64::MIN as i128 || hi > i64::MAX as i128 {
        return UNIVERSE;
    }
    Range { lo, hi }
}

/// Forward bounds for an instruction, given its operands' ranges and
/// the entry range of each parameter.
fn eval(insts: &[Inst], canon: &[ValueId], facts: &Facts, inst: &Inst, params: &[Range]) -> Range {
    let range_of = |v: ValueId| facts.get(key_of(insts, canon, v));
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
            BinOp::Add => arith(range_of(*lhs), Range::exact(*rhs_imm), false),
            BinOp::Sub => arith(range_of(*lhs), Range::exact(*rhs_imm), true),
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
            BinOp::Add => arith(range_of(*lhs), range_of(*rhs), false),
            BinOp::Sub => arith(range_of(*lhs), range_of(*rhs), true),
            _ => UNIVERSE,
        },
        // A width-limited read cannot produce a value outside the width
        // it extends from.
        Inst::Load { kind, .. } | Inst::LoadLocal { kind, .. } => {
            extend_range(*kind).unwrap_or(UNIVERSE)
        }
        // A floating parameter's value is not an integer, so an
        // interprocedural bound does not describe it.
        Inst::ParamRef {
            kind: LoadKind::F32 | LoadKind::F64,
            ..
        } => UNIVERSE,
        // Plus, for an integer parameter, whatever every call site
        // agrees the argument is bounded by. A narrow parameter reads
        // its own width out of the incoming register, so the caller's
        // range describes the parameter only when that read cannot
        // change a value inside it -- an argument range wider than the
        // parameter says nothing about what the parameter becomes.
        Inst::ParamRef { idx, kind } => {
            let w = extend_range(*kind).unwrap_or(UNIVERSE);
            match params.get(*idx as usize) {
                Some(r) if w.contains(*r) => *r,
                _ => w,
            }
        }
        _ => UNIVERSE,
    }
}

/// Bounds an argument expression carries with no dominating facts in
/// scope: the instruction's own shape only. Operand ranges read as
/// [`UNIVERSE`], so nothing here depends on another function's
/// parameter ranges and the interprocedural join needs no fixed point.
pub(crate) fn arg_range(insts: &[Inst], v: ValueId) -> Range {
    match insts.get(v as usize) {
        // No facts are in scope, so operand keys are never looked up
        // and the canonical map is irrelevant; the empty slice keys
        // every operand on its own id.
        Some(inst) => eval(insts, &[], &Facts::default(), inst, &[]),
        None => UNIVERSE,
    }
}

/// Facts the edge from `pred` into its single successor carries: the
/// branch condition's own value, and the range its comparison implies
/// for the compared expression.
fn apply_edge(
    func: &FunctionSsa,
    canon: &[ValueId],
    facts: &mut Facts,
    load_epoch: &[u64],
    epoch: u64,
    pred: BlockId,
    holds: bool,
) {
    let cond = match func.blocks[pred as usize].terminator {
        Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => cond,
        _ => return,
    };
    let insts = func.insts.as_slice();
    // The branch tests the condition against zero, so the taken edge
    // says only that it is not zero -- `if (x & 4)` reaches its body
    // with the value 4, not 1.
    let key = key_of(insts, canon, cond);
    let current = facts.get(key);
    let cond_range = if holds {
        implied(BinOp::Ne, 0, true, current)
    } else {
        Some(Range { lo: 0, hi: 0 })
    };
    if let Some(r) = cond_range {
        facts.narrow(key, r);
    }
    // A condition that is itself a comparison narrows what it compares.
    let (op, lhs, rhs_range) = match insts.get(cond as usize) {
        Some(Inst::BinopI { op, lhs, rhs_imm }) => (*op, *lhs, Range::exact(*rhs_imm)),
        Some(Inst::Binop { op, lhs, rhs }) => {
            let r = facts.get(key_of(insts, canon, *rhs));
            if r.lo != r.hi {
                return;
            }
            (*op, *lhs, r)
        }
        _ => return,
    };
    let key = key_of(insts, canon, lhs);
    let current = facts.get(key);
    if let Some(r) = implied(op, rhs_range.lo, holds, current) {
        facts.narrow(key, r);
        // The compared value is what memory held when the load ran, so
        // the bound describes a later load of the same expression only
        // while nothing can have written in between.
        if load_epoch.get(lhs as usize) == Some(&epoch)
            && let Some(ek) = load_expr_key(insts, canon, lhs)
        {
            facts.narrow(ek, r);
        }
    }
}

/// Rewrite every comparison the dominating conditions settle. `params`
/// is the entry range of each declared parameter, empty when none is
/// known. Returns whether the function changed, so the caller's fixed
/// point can re-run the branch fold and the prune on the result.
pub(crate) fn run_one(func: &mut FunctionSsa, params: &[Range]) -> bool {
    let n = func.blocks.len();
    if n == 0 {
        return false;
    }
    let idom = crate::c5::codegen::ssa::mem2reg::dominators(func);
    let preds = crate::c5::codegen::ssa::mem2reg::predecessors(func);
    let canon = value_numbers(func.insts.as_slice());
    // Dominator-tree children, so the walk visits each block once with
    // its dominators' facts in scope.
    let mut children: Vec<Vec<BlockId>> = alloc::vec![Vec::new(); n];
    for (b, &d) in idom.iter().enumerate().take(n).skip(1) {
        if d != BlockId::MAX && (d as usize) != b {
            children[d as usize].push(b as BlockId);
        }
    }
    let mut facts = Facts::default();
    let mut folded: Vec<(u32, i64)> = Vec::new();
    // Walk-position memory epoch: bumped at every potential write. A
    // load's recorded epoch says whether its value still equals what a
    // load of the same expression would produce here.
    let mut epoch: u64 = 1;
    let mut load_epoch: Vec<u64> = alloc::vec![0; func.insts.len()];
    // Explicit stack: `Enter(b)` walks the block, `Leave(mark, epoch)`
    // drops the facts its subtree contributed and restores the walk
    // position's epoch. The epoch is path state like the facts: a
    // sibling subtree's writes are not on this path, and SSA dominance
    // keeps its values out of this path's operands, so the numeric
    // reuse after a rewind is unobservable.
    enum Step {
        Enter(BlockId),
        Leave(usize, u64),
    }
    let mut stack = alloc::vec![Step::Enter(0)];
    while let Some(step) = stack.pop() {
        let b = match step {
            Step::Leave(mark, at) => {
                facts.rewind(mark);
                epoch = at;
                continue;
            }
            Step::Enter(b) => b,
        };
        let mark = facts.mark();
        stack.push(Step::Leave(mark, epoch));
        // A block reached from one predecessor carries that edge's
        // condition; with more than one predecessor the paths disagree,
        // and a joined-over path may have written the memory a load
        // fact describes.
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
                apply_edge(func, &canon, &mut facts, &load_epoch, epoch, p, holds);
            }
        } else {
            facts.wipe_loads();
            epoch += 1;
        }
        let range = func.blocks[b as usize].inst_range.clone();
        for pc in range.start..range.end {
            let inst = &func.insts[pc as usize];
            if writes_memory(inst) {
                facts.wipe_loads();
                epoch += 1;
            }
            let key = key_of(func.insts.as_slice(), &canon, pc);
            let ekey = load_expr_key(func.insts.as_slice(), &canon, pc);
            let mut r =
                eval(func.insts.as_slice(), &canon, &facts, inst, params).meet(facts.get(key));
            // At the load itself the positional fact is current, so the
            // value it produces meets it, and the value read here is
            // what the expression produces until the next write.
            if let Some(ek) = ekey {
                r = r.meet(facts.get(ek));
                load_epoch[pc as usize] = epoch;
            }
            let decided = match inst {
                Inst::BinopI { op, lhs, rhs_imm } => decide(
                    *op,
                    facts.get(key_of(func.insts.as_slice(), &canon, *lhs)),
                    Range::exact(*rhs_imm),
                ),
                Inst::Binop { op, lhs, rhs } => decide(
                    *op,
                    facts.get(key_of(func.insts.as_slice(), &canon, *lhs)),
                    facts.get(key_of(func.insts.as_slice(), &canon, *rhs)),
                ),
                _ => None,
            };
            let r = match decided {
                Some(v) => {
                    folded.push((pc, v as i64));
                    Range::exact(v as i64)
                }
                None => r,
            };
            facts.set(key, r);
            if let Some(ek) = ekey {
                facts.set(ek, r);
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

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{Block, Terminator};
    use alloc::vec;

    fn fresh(insts: Vec<Inst>, n_params: usize) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            n_params,
            inst_src: vec![(0, 0); n],
            f32_values: vec![false; n],
            insts,
            blocks: vec![Block {
                start_pc: 0,
                inst_range: 0..n as u32,
                terminator: Terminator::Return(crate::c5::ir::NO_VALUE),
                exit_acc: 0,
            }],
            ..FunctionSsa::default()
        }
    }

    /// `p >= 0` for a parameter read at a narrower width than the
    /// register the caller filled. The read is what produces the
    /// parameter's value, so a caller range reaching outside the read
    /// width says nothing: the entry value of an `I32` parameter whose
    /// argument was `0x80000000` is `INT_MIN`, not `0x80000000`.
    #[test]
    fn narrow_parameter_declines_a_range_wider_than_its_read() {
        let insts = |kind| {
            alloc::vec![
                Inst::ParamRef { idx: 0, kind },
                Inst::BinopI {
                    op: BinOp::Ge,
                    lhs: 0,
                    rhs_imm: 0,
                },
            ]
        };
        let wide = Range {
            lo: 0,
            hi: 0xffff_ffff,
        };
        let mut f = fresh(insts(LoadKind::I32), 1);
        assert!(
            !run_one(&mut f, &[wide]),
            "a range wider than the parameter's read width must not decide the comparison"
        );
        // The same range on a parameter read at full width does decide
        // it, and so does a range the narrow read leaves untouched.
        let mut f = fresh(insts(LoadKind::I64), 1);
        assert!(run_one(&mut f, &[wide]));
        assert!(matches!(f.insts[1], Inst::Imm(1)));
        let mut f = fresh(insts(LoadKind::I32), 1);
        assert!(run_one(&mut f, &[Range { lo: 0, hi: 1000 }]));
        assert!(matches!(f.insts[1], Inst::Imm(1)));
    }

    /// A dominating unsigned guard on a loaded field bounds what a
    /// re-materialised load of the same field produces (the kernel's
    /// min() type check reads the field once for the guard and once for
    /// the value), and a store in between ends the fact.
    #[test]
    fn guarded_field_reload_carries_the_bound_until_a_store() {
        use crate::c5::ir::StoreKind;
        // b0: a = LocalAddr(-1); x = Load[a+8]; c = x >=u 100; Bz c -> b2 else b1
        // b1: return
        // b2: a' = LocalAddr(-1); [store a'+8 when poisoned]
        //     y = Load[a'+8]; y >= 0; return
        let build = |poison: bool| {
            let mut insts = alloc::vec![
                Inst::LocalAddr(-1),
                Inst::Load {
                    addr: 0,
                    disp: 8,
                    kind: LoadKind::I64,
                    volatile: false,
                },
                Inst::BinopI {
                    op: BinOp::Uge,
                    lhs: 1,
                    rhs_imm: 100,
                },
                Inst::LocalAddr(-1),
            ];
            if poison {
                insts.push(Inst::Store {
                    addr: 3,
                    disp: 8,
                    value: 2,
                    kind: StoreKind::I64,
                    volatile: false,
                });
            }
            let load = insts.len() as u32;
            insts.push(Inst::Load {
                addr: 3,
                disp: 8,
                kind: LoadKind::I64,
                volatile: false,
            });
            insts.push(Inst::BinopI {
                op: BinOp::Ge,
                lhs: load,
                rhs_imm: 0,
            });
            let n = insts.len() as u32;
            let block = |range: core::ops::Range<u32>, t: Terminator| Block {
                start_pc: 0,
                inst_range: range,
                terminator: t,
                exit_acc: 0,
            };
            FunctionSsa {
                inst_src: vec![(0, 0); n as usize],
                f32_values: vec![false; n as usize],
                insts,
                blocks: vec![
                    block(
                        0..3,
                        Terminator::Bz {
                            cond: 2,
                            target: 2,
                            fall_through: 1,
                        },
                    ),
                    block(3..3, Terminator::Return(crate::c5::ir::NO_VALUE)),
                    block(3..n, Terminator::Return(n - 1)),
                ],
                ..FunctionSsa::default()
            }
        };
        let mut clean = build(false);
        assert!(run_one(&mut clean, &[]), "the guarded reload must fold");
        assert!(
            matches!(clean.insts[5], Inst::Imm(1)),
            "x <u 100 pins the reload to [0, 99], so y >= 0 is 1"
        );
        let mut poisoned = build(true);
        run_one(&mut poisoned, &[]);
        assert!(
            matches!(poisoned.insts[6], Inst::BinopI { .. }),
            "a store between the guard and the reload must end the fact"
        );
    }

    /// A branch fact about a load taken before an intervening write
    /// describes that value, not the expression: a fresh load of the
    /// same slot after the write must not inherit the bound (inlined
    /// asm helpers reuse one output slot, so the shape is common).
    #[test]
    fn stale_load_fact_does_not_reach_a_fresh_load() {
        use crate::c5::ir::StoreKind;
        let insts = alloc::vec![
            Inst::LocalAddr(-1),
            Inst::Load {
                addr: 0,
                disp: 8,
                kind: LoadKind::I64,
                volatile: false,
            },
            // The write separating the load from the branch that
            // tests it.
            Inst::Store {
                addr: 0,
                disp: 8,
                value: 1,
                kind: StoreKind::I64,
                volatile: false,
            },
            Inst::BinopI {
                op: BinOp::Uge,
                lhs: 1,
                rhs_imm: 100,
            },
            Inst::LocalAddr(-1),
            Inst::Load {
                addr: 4,
                disp: 8,
                kind: LoadKind::I64,
                volatile: false,
            },
            Inst::BinopI {
                op: BinOp::Ge,
                lhs: 5,
                rhs_imm: 0,
            },
        ];
        let n = insts.len() as u32;
        let block = |range: core::ops::Range<u32>, t: Terminator| Block {
            start_pc: 0,
            inst_range: range,
            terminator: t,
            exit_acc: 0,
        };
        let mut f = FunctionSsa {
            inst_src: vec![(0, 0); n as usize],
            f32_values: vec![false; n as usize],
            insts,
            blocks: vec![
                block(
                    0..4,
                    Terminator::Bz {
                        cond: 3,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(4..4, Terminator::Return(crate::c5::ir::NO_VALUE)),
                block(4..n, Terminator::Return(n - 1)),
            ],
            ..FunctionSsa::default()
        };
        run_one(&mut f, &[]);
        assert!(
            matches!(f.insts[6], Inst::BinopI { .. }),
            "the bound belongs to the pre-store value, not the reload"
        );
    }

    /// A floating parameter's entry value is not an integer, so an
    /// integer bound must not reach it.
    #[test]
    fn floating_parameter_takes_no_interprocedural_range() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::F64,
                },
                Inst::BinopI {
                    op: BinOp::Ge,
                    lhs: 0,
                    rhs_imm: 0,
                },
            ],
            1,
        );
        assert!(!run_one(&mut f, &[Range { lo: 0, hi: 1000 }]));
    }
}
