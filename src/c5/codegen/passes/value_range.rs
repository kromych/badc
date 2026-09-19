//! Integer comparisons decided by a dominating branch condition.
//!
//! Every other `-O` fold reads an operand that is already an immediate.
//! A comparison whose answer follows from the condition guarding the
//! block it sits in has no immediate anywhere, so it stayed a runtime
//! test and the arm it selects stayed live -- including an arm holding a
//! build-time-assert call the source expects to be unreachable.
//!
//! Two ranges bound each value. [`def_ranges`] is what the definition
//! alone says, iterated to a settled table so a phi is
//! bounded by the hull of what reaches it -- which is how a loop-carried
//! state variable is bounded by the states it can hold. On top of that a
//! range per expression is carried down the dominator tree: entering a
//! block whose only predecessor ends in a conditional branch, the
//! condition's comparison holds (or its negation does) on every path in,
//! so the compared expression's range narrows for that subtree. Where
//! the condition reaches the compared value through a step that
//! preserves the comparison -- a mask that clears no bit the operand can
//! hold, an exclusive-or or constant offset under an equality -- the
//! comparison is rewritten onto that value and the bound recorded there
//! too, along with the comparison's own answer and its negation. A
//! comparison the ranges settle, or one a dominating branch already
//! answered, is rewritten to that answer, which is what the branch
//! folder and the unreachable-block prune in
//! [`super::simplify_branches`] consume.
//!
//! Ranges are keyed by expression rather than by value id, so a
//! re-materialised operand -- the same extension of the same value
//! emitted in two blocks -- reads the fact recorded for the other. The
//! key covers only pure arithmetic; a load or a call is opaque, so
//! nothing is carried across a write to memory. A store is the one
//! write that also establishes something: a later read of the location
//! it wrote produces the value it stored, so the stored value's bounds
//! become the reading's, which is how a local whose address escaped --
//! and which therefore keeps its frame slot -- is still bounded by what
//! the body last assigned to it.
//!
//! `run_one` takes an entry range per parameter, which
//! [`super::ipa_const_param`] derives from the call sites of a function
//! only this translation unit can reach. `Inst::ParamRef` is the
//! parameter's entry value, so that range bounds every read of it.

use alloc::collections::BTreeMap;
use alloc::vec::Vec;

use crate::c5::ir::{BinOp, BlockId, FunctionSsa, Inst, LoadKind, StoreKind, Terminator, ValueId};

/// Inclusive bounds on a value's 64-bit register contents, read as a
/// signed integer. `i128` so intersection and the +-1 steps below cannot
/// overflow at the extremes.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
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

    pub(crate) fn bounds(self) -> (i128, i128) {
        (self.lo, self.hi)
    }

    /// Widening: an endpoint that moved outward goes to the first bound
    /// beyond it of the 8-, 16- and 32-bit ranges and the register's, so
    /// the result fits every width the hull fits, and an endpoint takes
    /// each bound at most once.
    fn widen(self, other: Range) -> Range {
        const LO: [i128; 5] = [0, -0x80, -0x8000, -0x8000_0000, i64::MIN as i128];
        const HI: [i128; 8] = [
            -1,
            0x7f,
            0xff,
            0x7fff,
            0xffff,
            0x7fff_ffff,
            0xffff_ffff,
            i64::MAX as i128,
        ];
        let hull = self.hull(other);
        Range {
            lo: match hull.lo < self.lo {
                true => LO.into_iter().find(|&b| b <= hull.lo).unwrap_or(hull.lo),
                false => self.lo,
            },
            hi: match hull.hi > self.hi {
                true => HI.into_iter().find(|&b| b >= hull.hi).unwrap_or(hull.hi),
                false => self.hi,
            },
        }
    }

    /// Whether an extension from `kind` is the identity on the range.
    pub(crate) fn fits(self, kind: LoadKind) -> bool {
        extend_range(kind).is_some_and(|w| w.contains(self))
    }

    pub(crate) fn high_word_clear(self) -> bool {
        self.lo >= 0 && self.hi <= 0xffff_ffff
    }

    /// Whether `x & k == x` for every `x` in the range.
    pub(crate) fn kept_by_mask(self, k: i64) -> bool {
        self.non_negative() && (k as i128) & low_mask_above(self.hi) == low_mask_above(self.hi)
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
            Inst::ParamRef { idx, kind } => (7, (*idx), load_kind_code(*kind), 0),
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

/// The part of an indexed load's key past its base and index.
fn indexed_key(ext: crate::c5::ir::IndexExt, scale: u8, kind: LoadKind) -> i64 {
    ((ext as i64) << 16) | ((scale as i64) << 8) | load_kind_code(kind) as i64
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
            ..
        }) => Some((5, c(*addr), load_kind_code(*kind), *disp as i64)),
        Some(Inst::LoadLocal {
            off,
            kind,
            volatile: false,
        }) => Some((6, 0, load_kind_code(*kind), *off)),
        Some(Inst::LoadIndexed {
            base,
            index,
            index_ext,
            scale,
            kind,
        }) => Some((
            7,
            c(*base),
            c(*index),
            indexed_key(*index_ext, *scale, *kind),
        )),
        _ => None,
    }
}

/// The integer load kinds that read back exactly the bytes a store of
/// `kind` wrote. A float store leaves no integer reading.
fn load_kinds_of_store(kind: StoreKind) -> &'static [LoadKind] {
    match kind {
        StoreKind::I8 => &[LoadKind::I8, LoadKind::U8],
        StoreKind::I16 => &[LoadKind::I16, LoadKind::U16],
        StoreKind::I32 => &[LoadKind::I32, LoadKind::U32],
        StoreKind::I64 => &[LoadKind::I64],
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 | StoreKind::V128 => &[],
    }
}

/// What a store establishes about a later load of the location it
/// wrote: `(load key, range)` per load kind that reads the store back
/// unchanged.
///
/// The store writes the low bytes of its value and the load extends
/// them again, so the round trip is the identity exactly when the
/// value's range already lies inside the window the load's own kind
/// produces (C99 6.3.1.3 -- a value representable in the accessed type
/// converts to itself). Outside that window the bytes still round trip,
/// but the extension changes the value, and the load's own width range
/// already says everything then.
///
/// A volatile store is excluded: the object may change between the
/// write and the read by means outside the abstract machine (C99
/// 6.7.3p6), so what was written does not bound what is read.
fn stored_facts(
    canon: &[ValueId],
    inst: &Inst,
    mut range_of: impl FnMut(ValueId) -> Range,
) -> Vec<(Key, Range)> {
    let c = |x: ValueId| canon.get(x as usize).copied().unwrap_or(x);
    let (kinds, value, key_for): (_, _, &dyn Fn(LoadKind) -> Key) = match inst {
        Inst::Store {
            addr,
            disp,
            value,
            kind,
            volatile: false,
            ..
        } => (load_kinds_of_store(*kind), *value, &|k| {
            (5, c(*addr), load_kind_code(k), *disp as i64)
        }),
        Inst::StoreLocal {
            off,
            value,
            kind,
            volatile: false,
        } => (load_kinds_of_store(*kind), *value, &|k| {
            (6, 0, load_kind_code(k), *off)
        }),
        Inst::StoreIndexed {
            base,
            index,
            index_ext,
            scale,
            value,
            kind,
        } => (load_kinds_of_store(*kind), *value, &|k| {
            (7, c(*base), c(*index), indexed_key(*index_ext, *scale, k))
        }),
        _ => return Vec::new(),
    };
    if kinds.is_empty() {
        return Vec::new();
    }
    let r = range_of(value);
    if r.is_universe() {
        return Vec::new();
    }
    kinds
        .iter()
        .filter(|&&k| extend_range(k).is_none_or(|w| w.contains(r)))
        .map(|&k| (key_for(k), r))
        .collect()
}

/// Whether an instruction may write memory (or transfer control to code
/// that can), ending the validity of every load-keyed fact. Volatile
/// loads read strictly per the abstract machine but write nothing; an
/// atomic load is an ordering point after which another thread's
/// writes may be visible (C11 5.1.2.4), so it ends the facts too.
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
            | Inst::Mzero { .. }
            | Inst::AtomicRmw { .. }
            | Inst::AtomicCas { .. }
            | Inst::AtomicLoad { .. }
            | Inst::AtomicStore { .. }
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
        LoadKind::F80 => 9,
        LoadKind::F128 => 10,
        LoadKind::V128 => 11,
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

/// The comparison that is false exactly where `op` is true. Both read
/// a total order, so the negation is the complementary operator.
fn negate(op: BinOp) -> Option<BinOp> {
    Some(match op {
        BinOp::Eq => BinOp::Ne,
        BinOp::Ne => BinOp::Eq,
        BinOp::Lt => BinOp::Ge,
        BinOp::Ge => BinOp::Lt,
        BinOp::Gt => BinOp::Le,
        BinOp::Le => BinOp::Gt,
        BinOp::Ult => BinOp::Uge,
        BinOp::Uge => BinOp::Ult,
        BinOp::Ugt => BinOp::Ule,
        BinOp::Ule => BinOp::Ugt,
        _ => return None,
    })
}

/// Key of the expression `lhs op imm`, as [`key_of`] gives it for an
/// instruction computing that comparison.
fn cmp_key(canon: &[ValueId], lhs: ValueId, op: BinOp, imm: i64) -> Key {
    let c = canon.get(lhs as usize).copied().unwrap_or(lhs);
    (3, c, binop_code(op), imm)
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
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 | LoadKind::V128 => {
            return None;
        }
    })
}

/// Scoped fact map: a range per expression key, with an undo log so the
/// dominator-tree walk can drop a subtree's facts on the way back up.
#[derive(Default)]
struct Facts {
    live: BTreeMap<Key, Range>,
    undo: Vec<(Key, Option<Range>)>,
    /// Every load key holding a bound, possibly repeated and possibly
    /// stale, so a wipe visits the bounded load facts rather than the map.
    bounded_loads: Vec<Key>,
    /// Keys the wipes have visited. The scaling test reads it.
    wipe_visits: usize,
}

impl Facts {
    fn get(&self, key: Key) -> Range {
        self.live.get(&key).copied().unwrap_or(UNIVERSE)
    }

    fn set(&mut self, key: Key, r: Range) {
        let prev = self.live.insert(key, r);
        self.undo.push((key, prev));
        self.note_bound(key, r);
    }

    fn note_bound(&mut self, key: Key, r: Range) {
        if is_load_key(key) && !r.is_universe() {
            self.bounded_loads.push(key);
        }
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
                Some(r) => {
                    self.live.insert(key, r);
                    self.note_bound(key, r);
                }
                None => {
                    self.live.remove(&key);
                }
            }
        }
    }

    /// Drop every load-keyed fact (undo-logged): memory may have
    /// changed, so what a read produced no longer bounds what the same
    /// read produces next.
    fn wipe_loads(&mut self) {
        let stale = core::mem::take(&mut self.bounded_loads);
        self.wipe_visits += stale.len();
        for key in stale {
            if !self.get(key).is_universe() {
                self.set(key, UNIVERSE);
            }
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

/// Smallest `2^k - 1` that is at least `x`, for `x` in `0 ..= i64::MAX`:
/// the bound a bitwise combination of values below it cannot exceed,
/// since no operand has a bit set above the mask.
fn low_mask_above(x: i128) -> i128 {
    let mut m: i128 = 0;
    while m < x {
        m = m * 2 + 1;
    }
    m
}

/// Whether `k` is `2^n - 1`, so `x & k` clears exactly the bits above
/// bit `n - 1`.
fn is_low_mask(k: i64) -> bool {
    k > 0 && k & k.wrapping_add(1) == 0
}

/// Bounds a bitwise `or` / `xor` of two non-negative ranges: the result
/// has no bit set above the highest either operand can hold, and `or` is
/// at least each operand.
fn bitwise(a: Range, b: Range, or: bool) -> Range {
    if !(a.non_negative() && b.non_negative()) {
        return UNIVERSE;
    }
    Range {
        lo: if or { a.lo.max(b.lo) } else { 0 },
        hi: low_mask_above(a.hi.max(b.hi)),
    }
}

/// Bounds a shift by a constant. A shift count outside `0 ..= 63` is not
/// defined by C99 6.5.7p3, so it carries no bounds.
fn shift(a: Range, by: i64, op: BinOp) -> Range {
    if !(0..64).contains(&by) {
        return UNIVERSE;
    }
    let by = by as u32;
    let r = match op {
        BinOp::Shl => Range {
            lo: a.lo << by,
            hi: a.hi << by,
        },
        // Arithmetic right shift is monotone over the whole range.
        BinOp::Shr => Range {
            lo: a.lo >> by,
            hi: a.hi >> by,
        },
        // The logical shift of a negative value is a large positive one,
        // so only the width bound holds unless the operand is known
        // non-negative.
        _ if !a.non_negative() => Range {
            lo: 0,
            hi: (u64::MAX >> by) as i128,
        },
        _ => Range {
            lo: a.lo >> by,
            hi: a.hi >> by,
        },
    };
    if r.lo < i64::MIN as i128 || r.hi > i64::MAX as i128 {
        return UNIVERSE;
    }
    r
}

/// Largest magnitude in the range.
fn magnitude(r: Range) -> i128 {
    r.lo.abs().max(r.hi.abs())
}

/// `r` when it lies in the register's signed range. A bound outside it
/// means the operation can wrap, and a wrapped interval says nothing.
fn representable(r: Range) -> Range {
    if UNIVERSE.contains(r) { r } else { UNIVERSE }
}

/// Bounds `a / d`, C99 6.5.5p6. The truncating quotient is monotone in
/// each operand while the divisor keeps its sign, so the corners bound it;
/// across zero only `|a / d| <= |a|` holds, which the quotient 0 of an
/// aarch64 divide by zero satisfies too. `i64::MIN / -1` leaves the range.
/// The unsigned form reads a negative register as a value of 2^63 and up.
fn quotient(a: Range, d: Range, unsigned: bool) -> Range {
    if unsigned {
        return match (a.non_negative(), d.lo > 0) {
            (true, true) => Range {
                lo: a.lo / d.hi,
                hi: a.hi / d.lo,
            },
            (true, false) => Range { lo: 0, hi: a.hi },
            (false, true) if d.lo > 1 => Range {
                lo: 0,
                hi: u64::MAX as i128 / d.lo,
            },
            _ => UNIVERSE,
        };
    }
    if d.lo <= 0 && d.hi >= 0 {
        let m = magnitude(a);
        return representable(Range { lo: -m, hi: m });
    }
    let corners = [a.lo / d.lo, a.lo / d.hi, a.hi / d.lo, a.hi / d.hi];
    representable(Range {
        lo: corners.into_iter().min().unwrap_or(UNIVERSE.lo),
        hi: corners.into_iter().max().unwrap_or(UNIVERSE.hi),
    })
}

/// Bounds `a % d`, C99 6.5.5p6: the result has the dividend's sign and at
/// most its magnitude -- an aarch64 remainder by zero is the dividend --
/// and stays below a divisor that cannot be zero. The unsigned form reads
/// a negative register as a value of 2^63 and up, which neither bound
/// describes.
fn remainder(a: Range, d: Range, unsigned: bool) -> Range {
    if unsigned {
        let below = (d.lo > 0).then_some(d.hi - 1);
        return match (a.non_negative(), below) {
            (true, Some(m)) => Range {
                lo: 0,
                hi: a.hi.min(m),
            },
            (true, None) => Range { lo: 0, hi: a.hi },
            (false, Some(m)) => Range { lo: 0, hi: m },
            (false, None) => UNIVERSE,
        };
    }
    let by_dividend = Range {
        lo: a.lo.min(0),
        hi: a.hi.max(0),
    };
    if d.lo <= 0 && d.hi >= 0 {
        return by_dividend;
    }
    let m = magnitude(d) - 1;
    by_dividend.meet(Range { lo: -m, hi: m })
}

/// The unsigned operator computing what the signed division `op` does
/// over a non-negative dividend and a positive divisor (C99 6.5.5p6).
/// [`run_one`] rewrites a division by a power of two that way where the
/// facts in scope bound the dividend, a guard included: the unsigned
/// form is a shift or a mask at any operand width, and the signed one
/// biases the dividend first. The rewrite holds wherever the result is
/// read, every reader being dominated by the instruction and so by the
/// guard, whatever the dividend holds elsewhere.
fn unsigned_form(op: BinOp) -> Option<BinOp> {
    match op {
        BinOp::Div => Some(BinOp::Divu),
        BinOp::Mod => Some(BinOp::Modu),
        _ => None,
    }
}

/// Bounds of a division or remainder `op` over operand ranges.
fn divmod(op: BinOp, a: Range, d: Range) -> Range {
    // An empty operand range marks code no path reaches; its bounds are
    // not ordered, and a divisor bound can be zero on the side that
    // excludes it.
    if a.lo > a.hi || d.lo > d.hi {
        return UNIVERSE;
    }
    match op {
        BinOp::Div => quotient(a, d, false),
        BinOp::Divu => quotient(a, d, true),
        BinOp::Mod => remainder(a, d, false),
        _ => remainder(a, d, true),
    }
}

/// Forward bounds for an instruction, given its operands' ranges and
/// the entry range of each parameter.
fn eval(inst: &Inst, params: &[Range], mut range_of: impl FnMut(ValueId) -> Range) -> Range {
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
        // The reversed bytes are zero-extended from the operation width.
        Inst::Bswap { width, .. } => match width {
            2 => Range { lo: 0, hi: 0xffff },
            4 => Range {
                lo: 0,
                hi: 0xffff_ffff,
            },
            _ => UNIVERSE,
        },
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
            BinOp::Or | BinOp::Xor => bitwise(
                range_of(*lhs),
                Range::exact(*rhs_imm),
                matches!(op, BinOp::Or),
            ),
            BinOp::Shl | BinOp::Shr | BinOp::Shru => shift(range_of(*lhs), *rhs_imm, *op),
            BinOp::Div | BinOp::Divu | BinOp::Mod | BinOp::Modu => {
                divmod(*op, range_of(*lhs), Range::exact(*rhs_imm))
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
            BinOp::Add => arith(range_of(*lhs), range_of(*rhs), false),
            BinOp::Sub => arith(range_of(*lhs), range_of(*rhs), true),
            BinOp::Or | BinOp::Xor => {
                bitwise(range_of(*lhs), range_of(*rhs), matches!(op, BinOp::Or))
            }
            BinOp::Div | BinOp::Divu | BinOp::Mod | BinOp::Modu => {
                divmod(*op, range_of(*lhs), range_of(*rhs))
            }
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
/// scope: the instruction's own shape only, over unbounded operands.
pub(crate) fn arg_range(insts: &[Inst], v: ValueId) -> Range {
    match insts.get(v as usize) {
        Some(inst) => eval(inst, &[], |_| UNIVERSE),
        None => UNIVERSE,
    }
}

/// Changes a value takes at their exact size before it is widened.
const EXACT_STEPS: u8 = 2;

/// Bounds a value's definition carries wherever it is live, a phi taking
/// the hull of what reaches it: the table grows from empty until every
/// entry contains what its rule produces from the table. A sweep in reverse
/// postorder visits each value, then each change queues its readers; the
/// widening bounds the changes per value, so the work is linear in edges.
pub(crate) fn def_ranges(func: &FunctionSsa, params: &[Range]) -> Vec<Range> {
    use alloc::collections::BinaryHeap;
    use core::cmp::Reverse;
    let n = func.insts.len();
    let order = visit_order(func);
    let mut pos = alloc::vec![0u32; n];
    for (i, &v) in order.iter().enumerate() {
        pos[v as usize] = i as u32;
    }
    let (starts, readers) = reader_table(func);
    let mut cur: Vec<Option<Range>> = alloc::vec![None; n];
    let mut steps = alloc::vec![0u8; n];
    let mut queued = alloc::vec![false; n];
    let mut queue: BinaryHeap<Reverse<u32>> = BinaryHeap::new();
    let mut sweep = 0..order.len() as u32;
    while let Some(p) = sweep.next().or_else(|| queue.pop().map(|Reverse(p)| p)) {
        let v = order[p as usize] as usize;
        queued[v] = false;
        let Some(next) = def_rule(func, params, &cur, v) else {
            continue;
        };
        let grown = match cur[v] {
            None => next,
            Some(old) if old.contains(next) => continue,
            Some(old) => {
                steps[v] = steps[v].saturating_add(1);
                match steps[v] > EXACT_STEPS {
                    true => old.widen(next),
                    false => old.hull(next),
                }
            }
        };
        cur[v] = Some(grown);
        // A reader the sweep has not reached yet is visited by it.
        for &r in &readers[starts[v] as usize..starts[v + 1] as usize] {
            let r = r as usize;
            if pos[r] < sweep.start && !core::mem::replace(&mut queued[r], true) {
                queue.push(Reverse(pos[r]));
            }
        }
    }
    // A value no definition reached stays unbounded rather than empty:
    // the iteration's own reach is not a statement about the program.
    cur.into_iter().map(|r| r.unwrap_or(UNIVERSE)).collect()
}

/// What `v`'s definition produces from `cur`; `None` until it reads an entry.
fn def_rule(
    func: &FunctionSsa,
    params: &[Range],
    cur: &[Option<Range>],
    v: usize,
) -> Option<Range> {
    let bounds = |o: ValueId| cur.get(o as usize).copied().flatten();
    match &func.insts[v] {
        // A floating phi merges no integers.
        Inst::Phi {
            kind: LoadKind::F32 | LoadKind::F64,
            ..
        } => Some(UNIVERSE),
        Inst::Phi { incoming, .. } => incoming
            .iter()
            .filter_map(|&(_, s)| bounds(s))
            .reduce(Range::hull),
        inst => {
            let mut unreached = false;
            let r = eval(inst, params, |o| {
                bounds(o).unwrap_or_else(|| {
                    unreached = true;
                    UNIVERSE
                })
            });
            (!unreached).then_some(r)
        }
    }
}

/// Every value once: reachable blocks in reverse postorder, then the rest.
fn visit_order(func: &FunctionSsa) -> Vec<ValueId> {
    let n = func.insts.len();
    let mut blocks = crate::c5::codegen::ssa::mem2reg::postorder(func);
    blocks.reverse();
    let mut reached = alloc::vec![false; func.blocks.len()];
    for &b in &blocks {
        reached[b as usize] = true;
    }
    blocks.extend((0..func.blocks.len() as BlockId).filter(|&b| !reached[b as usize]));
    let mut seen = alloc::vec![false; n];
    let mut order: Vec<ValueId> = Vec::with_capacity(n);
    for b in blocks {
        for v in func.blocks[b as usize].inst_range.clone() {
            if (v as usize) < n && !core::mem::replace(&mut seen[v as usize], true) {
                order.push(v);
            }
        }
    }
    order.extend((0..n as ValueId).filter(|&v| !seen[v as usize]));
    order
}

/// The instructions reading `v` as an operand: `readers[starts[v]..starts[v + 1]]`.
fn reader_table(func: &FunctionSsa) -> (Vec<u32>, Vec<ValueId>) {
    let n = func.insts.len();
    let mut starts = alloc::vec![0u32; n + 1];
    for inst in &func.insts {
        inst.for_each_operand(|o| {
            if (o as usize) < n {
                starts[o as usize + 1] += 1;
            }
        });
    }
    for i in 0..n {
        starts[i + 1] += starts[i];
    }
    let mut fill = starts.clone();
    let mut readers = alloc::vec![0; starts[n] as usize];
    for (i, inst) in func.insts.iter().enumerate() {
        inst.for_each_operand(|o| {
            if (o as usize) < n {
                readers[fill[o as usize] as usize] = i as ValueId;
                fill[o as usize] += 1;
            }
        });
    }
    (starts, readers)
}

/// Rewrite `lhs op k` into an equivalent comparison on the value `lhs`
/// was built from, so a branch on a masked or offset expression also
/// bounds that value. Each step preserves the comparison's truth for
/// every operand value; `None` where it would not.
fn peel(insts: &[Inst], def: &[Range], op: BinOp, lhs: ValueId, k: i64) -> Option<(ValueId, i64)> {
    let (inner, step, c) = match insts.get(lhs as usize)? {
        Inst::BinopI { op, lhs, rhs_imm } => (*lhs, *op, *rhs_imm),
        _ => return None,
    };
    let equality = matches!(op, BinOp::Eq | BinOp::Ne);
    match step {
        // A mask that clears no bit the operand can hold is the
        // identity, so every comparison on the mask is one on the
        // operand.
        BinOp::And
            if is_low_mask(c)
                && Range {
                    lo: 0,
                    hi: c as i128,
                }
                .contains(*def.get(inner as usize).unwrap_or(&UNIVERSE)) =>
        {
            Some((inner, k))
        }
        // Exclusive-or and a constant offset are bijections on the
        // register, so an equality against the result is an equality
        // against the unique operand producing it. Neither preserves
        // order, so only equalities peel; both wrap, and so does the
        // preimage.
        BinOp::Xor if equality => Some((inner, k ^ c)),
        BinOp::Add if equality => Some((inner, k.wrapping_sub(c))),
        BinOp::Sub if equality => Some((inner, k.wrapping_add(c))),
        _ => None,
    }
}

/// Tables the walk consults but does not change while an edge's facts
/// are applied.
#[derive(Clone, Copy)]
struct Tables<'a> {
    canon: &'a [ValueId],
    def: &'a [Range],
    load_epoch: &'a [u64],
}

/// Facts the edge from `pred` into its single successor carries: the
/// branch condition's own value, and the range its comparison implies
/// for the compared expression and for what that expression was built
/// from.
fn apply_edge(
    func: &FunctionSsa,
    tables: &Tables<'_>,
    facts: &mut Facts,
    epoch: u64,
    pred: BlockId,
    holds: bool,
) {
    let Tables {
        canon,
        def,
        load_epoch,
    } = *tables;
    let cond = match func.blocks[pred as usize].terminator {
        Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => cond,
        _ => return,
    };
    let insts = func.insts.as_slice();
    // The branch tests the condition against zero, so the taken edge
    // says only that it is not zero -- `if (x & 4)` reaches its body
    // with the value 4, not 1.
    let key = key_of(insts, canon, cond);
    let current = held(facts, def, key, cond);
    let cond_range = if holds {
        implied(BinOp::Ne, 0, true, current)
    } else {
        Some(Range { lo: 0, hi: 0 })
    };
    if let Some(r) = cond_range {
        facts.narrow(key, r);
    }
    // A condition that is itself a comparison narrows what it
    // compares. Any other condition is the zero test the branch
    // performs, so it narrows as `cond != 0` and peels from there --
    // the shape a branch-cond fold leaves after rewriting
    // `Bz(x != 0)` to `Bz(x)`.
    let (op, lhs, rhs_range) = match insts.get(cond as usize) {
        Some(Inst::BinopI { op, lhs, rhs_imm }) if comparison(*op).is_some() => {
            (*op, *lhs, Range::exact(*rhs_imm))
        }
        Some(Inst::Binop { op, lhs, rhs }) if comparison(*op).is_some() => {
            let r = held(facts, def, key_of(insts, canon, *rhs), *rhs);
            if r.lo != r.hi {
                return;
            }
            (*op, *lhs, r)
        }
        Some(_) => (BinOp::Ne, cond, Range::exact(0)),
        None => return,
    };
    let Ok(mut k) = i64::try_from(rhs_range.lo) else {
        return;
    };
    let mut lhs = lhs;
    // Walk down the expression the comparison was built from, recording
    // the bound each rewriting implies. The chain is finite (each step
    // moves to an operand) and bounded here against a cyclic tape.
    for _ in 0..insts.len().min(8) {
        // The comparison itself is settled on this edge, and so is its
        // negation. An expression recomputing either in the dominated
        // subtree reads the answer, which is what decides a test the
        // operands' bounds leave open -- a disequality against a value
        // with no bound on either side of it.
        for (op, v) in [(Some(op), holds), (negate(op), !holds)] {
            if let Some(op) = op.filter(|op| comparison(*op).is_some()) {
                facts.narrow(cmp_key(canon, lhs, op, k), Range::exact(v as i64));
            }
        }
        let key = key_of(insts, canon, lhs);
        if let Some(r) = implied(op, k as i128, holds, held(facts, def, key, lhs)) {
            facts.narrow(key, r);
            // The compared value is what memory held when the load ran,
            // so the bound describes a later load of the same expression
            // only while nothing can have written in between.
            if load_epoch.get(lhs as usize) == Some(&epoch)
                && let Some(ek) = load_expr_key(insts, canon, lhs)
            {
                facts.narrow(ek, r);
            }
        }
        match peel(insts, def, op, lhs, k) {
            Some((inner, next)) => (lhs, k) = (inner, next),
            None => break,
        }
    }
}

/// What is known about `v` at this walk position: the dominating facts
/// recorded for its expression, met with what its definition alone says.
fn held(facts: &Facts, def: &[Range], key: Key, v: ValueId) -> Range {
    facts
        .get(key)
        .meet(*def.get(v as usize).unwrap_or(&UNIVERSE))
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
    let def = def_ranges(func, params);
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
    // Divisions [`unsigned_form`] applies to.
    let mut unsigned: Vec<ValueId> = Vec::new();
    // Zero-test terminators the walk's facts settle: (block, cond is
    // non-zero). Applied after the walk so the CFG the tables describe
    // stays fixed while facts flow.
    let mut branch_folds: Vec<(BlockId, bool)> = Vec::new();
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
                let tables = Tables {
                    canon: &canon,
                    def: &def,
                    load_epoch: &load_epoch,
                };
                apply_edge(func, &tables, &mut facts, epoch, p, holds);
            }
        } else {
            facts.wipe_loads();
            epoch += 1;
        }
        let range = func.blocks[b as usize].inst_range.clone();
        for pc in range.start..range.end {
            let inst = &func.insts[pc as usize];
            if writes_memory(inst) {
                // What a store puts in memory bounds a later read of
                // the same location. Read the value's range before the
                // wipe -- it may itself rest on a load fact -- and
                // record the reading afterwards, so the store's own
                // invalidation does not drop what it just established.
                let established = {
                    let insts = func.insts.as_slice();
                    stored_facts(&canon, inst, |v| {
                        held(&facts, &def, key_of(insts, &canon, v), v)
                    })
                };
                facts.wipe_loads();
                epoch += 1;
                for (k, r) in established {
                    facts.set(k, r);
                }
            }
            let insts = func.insts.as_slice();
            let at = |v: ValueId| held(&facts, &def, key_of(insts, &canon, v), v);
            let key = key_of(insts, &canon, pc);
            let ekey = load_expr_key(insts, &canon, pc);
            let mut r = eval(inst, params, at).meet(held(&facts, &def, key, pc));
            // At the load itself the positional fact is current, so the
            // value it produces meets it, and the value read here is
            // what the expression produces until the next write.
            if let Some(ek) = ekey {
                r = r.meet(facts.get(ek));
                load_epoch[pc as usize] = epoch;
            }
            let decided = match inst {
                Inst::BinopI { op, lhs, rhs_imm } => decide(*op, at(*lhs), Range::exact(*rhs_imm)),
                Inst::Binop { op, lhs, rhs } => decide(*op, at(*lhs), at(*rhs)),
                _ => None,
            };
            if let Inst::BinopI { op, lhs, .. } | Inst::Binop { op, lhs, .. } = inst
                && let Some(d) = match inst {
                    Inst::BinopI { rhs_imm, .. } => Some(Range::exact(*rhs_imm)),
                    Inst::Binop { rhs, .. } => Some(at(*rhs)),
                    _ => None,
                }
                && unsigned_form(*op).is_some()
                && d.lo == d.hi
                && d.lo > 0
                && (d.lo as u128).is_power_of_two()
                && at(*lhs).non_negative()
            {
                unsigned.push(pc);
            }
            // Either the operands' bounds answer the comparison, or the
            // bounds on the expression itself have closed to one value
            // -- which is how a dominating branch's own answer reaches a
            // repetition of it. Only a pure integer operation is
            // rewritten: its result is a function of its operands, so
            // replacing it with that value drops nothing else.
            let point = || match r.lo == r.hi
                && matches!(
                    inst,
                    Inst::BinopI { op, .. } | Inst::Binop { op, .. } if is_pure_int(*op)
                ) {
                true => i64::try_from(r.lo).ok(),
                false => None,
            };
            let r = match decided.map(|v| v as i64).or_else(point) {
                Some(v) => {
                    folded.push((pc, v));
                    Range::exact(v)
                }
                None => r,
            };
            facts.set(key, r);
            if let Some(ek) = ekey {
                facts.set(ek, r);
            }
        }
        // The facts at the block's end also settle its own zero-test
        // terminator when they pin the condition's value. The pin is
        // path-local, so no instruction rewrite can carry it; folding
        // the branch here is the terminator's form of the comparison
        // rewrite above.
        if let Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } =
            func.blocks[b as usize].terminator
            && cond != crate::c5::ir::NO_VALUE
        {
            let insts = func.insts.as_slice();
            let r = held(&facts, &def, key_of(insts, &canon, cond), cond);
            if let Some(nz) = decide(BinOp::Ne, r, Range::exact(0)) {
                branch_folds.push((b as BlockId, nz));
            }
        }
        for &c in &children[b as usize] {
            stack.push(Step::Enter(c));
        }
    }
    for &(pc, v) in &folded {
        func.insts[pc as usize] = Inst::Imm(v);
    }
    for &pc in &unsigned {
        if let Inst::BinopI { op, .. } | Inst::Binop { op, .. } = &mut func.insts[pc as usize]
            && let Some(u) = unsigned_form(*op)
        {
            *op = u;
        }
    }
    // Apply the deferred terminator folds and drop each removed edge's
    // phi incomings so the successor reflects its real predecessors.
    let mut removed: Vec<(BlockId, BlockId)> = Vec::new();
    for &(b, nonzero) in &branch_folds {
        let (taken, not_taken) = match func.blocks[b as usize].terminator {
            Terminator::Bz {
                target,
                fall_through,
                ..
            } => {
                if nonzero {
                    (fall_through, target)
                } else {
                    (target, fall_through)
                }
            }
            Terminator::Bnz {
                target,
                fall_through,
                ..
            } => {
                if nonzero {
                    (target, fall_through)
                } else {
                    (fall_through, target)
                }
            }
            _ => continue,
        };
        func.blocks[b as usize].terminator = Terminator::Jmp(taken);
        if not_taken != taken {
            removed.push((b, not_taken));
        }
    }
    for (from, to) in removed {
        let Some(block) = func.blocks.get(to as usize) else {
            continue;
        };
        for i in block.inst_range.clone() {
            if let Inst::Phi { incoming, .. } = &mut func.insts[i as usize] {
                incoming.retain(|&(pred, _)| pred != from);
            }
        }
    }
    !folded.is_empty() || !branch_folds.is_empty()
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
                    align: 0,
                },
                Inst::BinopI {
                    op: BinOp::Uge,
                    lhs: 1,
                    rhs_imm: 100,
                },
                Inst::LocalAddr(-1),
            ];
            if poison {
                // The stored value is the address itself, which carries
                // no bounds: the reload is then decided by the store's
                // invalidation alone, which is what this pins. A store
                // of a bounded value establishes its own fact and is
                // covered by `stored_value_bounds_a_later_reload`.
                insts.push(Inst::Store {
                    addr: 3,
                    disp: 8,
                    value: 3,
                    kind: StoreKind::I64,
                    volatile: false,
                    align: 0,
                });
            }
            let load = insts.len() as u32;
            insts.push(Inst::Load {
                addr: 3,
                disp: 8,
                kind: LoadKind::I64,
                volatile: false,
                align: 0,
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

    /// What a store writes bounds a later read of the location, at the
    /// load kinds that give the value back unchanged. A narrower read
    /// converts the value (C99 6.3.1.3), so it takes no bound from a
    /// source range that does not fit the width it reads.
    #[test]
    fn stored_value_bounds_a_later_reload() {
        use crate::c5::ir::StoreKind;
        // a = LocalAddr(-1); p = ParamRef(0); v = p & 0x1ff;
        // store[a+8] = v (I64 or I8); y = load[a+8] (matching kind);
        // y >= 0
        let build = |kind: StoreKind, load_kind: LoadKind| {
            let insts = alloc::vec![
                Inst::LocalAddr(-1),
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::BinopI {
                    op: BinOp::And,
                    lhs: 1,
                    rhs_imm: 0x1ff,
                },
                Inst::Store {
                    addr: 0,
                    disp: 8,
                    value: 2,
                    kind,
                    volatile: false,
                    align: 0,
                },
                Inst::Load {
                    addr: 0,
                    disp: 8,
                    kind: load_kind,
                    volatile: false,
                    align: 0,
                },
                Inst::BinopI {
                    op: BinOp::Ge,
                    lhs: 4,
                    rhs_imm: 0,
                },
            ];
            fresh(insts, 1)
        };
        // Full width: the read gives the value back, so [0, 511] holds.
        let mut wide = build(StoreKind::I64, LoadKind::I64);
        run_one(&mut wide, &[]);
        assert!(
            matches!(wide.insts[5], Inst::Imm(1)),
            "an I64 reload of an I64 store takes the stored bound"
        );
        // A byte store of a value that does not fit a byte: the read
        // sign-extends different bits, so the stored bound says nothing.
        let mut narrow = build(StoreKind::I8, LoadKind::I8);
        run_one(&mut narrow, &[]);
        assert!(
            matches!(narrow.insts[5], Inst::BinopI { .. }),
            "a signed byte reload of a [0, 511] store takes no bound"
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
                align: 0,
            },
            // The write separating the load from the branch that
            // tests it.
            Inst::Store {
                addr: 0,
                disp: 8,
                value: 1,
                kind: StoreKind::I64,
                volatile: false,
                align: 0,
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
                align: 0,
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

    /// A loop-carried state variable takes the hull of what reaches its
    /// phi, so the loop's own exit test excludes the state the body's
    /// dispatch has an arm for. Without the merged bounds the exit test
    /// is a disequality against an unbounded value and settles nothing.
    ///
    /// b0: v0 = 2                                  -> b1
    /// b1: v1 = phi(b0: v0, b3: v4); v2 = v1 != 0  Bnz v2 -> b2 else b4
    /// b2: v3 = (v1 == 0)   -- the arm to decide   -> b3
    /// b3: v4 = 1                                  -> b1
    #[test]
    fn loop_state_phi_bounds_the_dispatch() {
        let insts = alloc::vec![
            Inst::Imm(2), // v0
            Inst::Phi {
                incoming: alloc::vec![(0, 0), (3, 4)],
                kind: LoadKind::I64,
            }, // v1
            Inst::BinopI {
                op: BinOp::Ne,
                lhs: 1,
                rhs_imm: 0,
            }, // v2
            Inst::BinopI {
                op: BinOp::Eq,
                lhs: 1,
                rhs_imm: 0,
            }, // v3
            Inst::Imm(1), // v4
        ];
        let block = |range: core::ops::Range<u32>, t: Terminator| Block {
            start_pc: 0,
            inst_range: range,
            terminator: t,
            exit_acc: 0,
        };
        let mut f = FunctionSsa {
            inst_src: vec![(0, 0); 5],
            f32_values: vec![false; 5],
            insts,
            blocks: vec![
                block(0..1, Terminator::Jmp(1)),
                block(
                    1..3,
                    Terminator::Bnz {
                        cond: 2,
                        target: 2,
                        fall_through: 4,
                    },
                ),
                block(3..4, Terminator::Jmp(3)),
                block(4..5, Terminator::Jmp(1)),
                block(5..5, Terminator::Return(crate::c5::ir::NO_VALUE)),
            ],
            ..FunctionSsa::default()
        };
        assert!(run_one(&mut f, &[]), "the state's bounds must decide it");
        assert!(
            matches!(f.insts[3], Inst::Imm(0)),
            "the state is in [1, 2] on the body edge, so `== 0` is 0: {:?}",
            f.insts[3]
        );
    }

    /// A loop-carried value whose rule moves its bound one step per pass
    /// settles: `v = phi(0, (v + 1) & 0xff)` widens to the byte the mask
    /// keeps it in, so it is known non-negative and inside the byte.
    ///
    /// b0: v0 = 0                -> b1
    /// b1: v1 = phi(v0, v3)
    ///     v2 = v1 + 1
    ///     v3 = v2 & 0xff
    ///     v4 = (v1 >= 0)        -> b1
    #[test]
    fn a_widened_loop_value_settles_inside_its_mask() {
        let insts = alloc::vec![
            Inst::Imm(0),
            Inst::Phi {
                incoming: alloc::vec![(0, 0), (1, 3)],
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 1,
                rhs_imm: 1,
            },
            Inst::BinopI {
                op: BinOp::And,
                lhs: 2,
                rhs_imm: 0xff,
            },
            Inst::BinopI {
                op: BinOp::Ge,
                lhs: 1,
                rhs_imm: 0,
            },
        ];
        let block = |range: core::ops::Range<u32>, t: Terminator| Block {
            start_pc: 0,
            inst_range: range,
            terminator: t,
            exit_acc: 0,
        };
        let mut f = FunctionSsa {
            inst_src: vec![(0, 0); 5],
            f32_values: vec![false; 5],
            insts,
            blocks: vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..5, Terminator::Jmp(1)),
            ],
            ..FunctionSsa::default()
        };
        assert!(def_ranges(&f, &[])[1] == Range { lo: 0, hi: 0xff });
        assert!(
            run_one(&mut f, &[]),
            "the iteration must settle with bounds"
        );
        assert!(
            matches!(f.insts[4], Inst::Imm(1)),
            "the widened lower endpoint still proves it non-negative: {:?}",
            f.insts[4]
        );
    }

    /// An unbounded counter settles; its extension keeps its own bound.
    /// b0: v0 = 0                                          -> b1
    /// b1: v1 = phi(v0, v3); v2 = sext32(v1); v3 = v2 + 1  -> b1
    #[test]
    fn a_widened_counter_settles_and_its_extension_keeps_its_bound() {
        let insts = alloc::vec![
            Inst::Imm(0),
            Inst::Phi {
                incoming: alloc::vec![(0, 0), (1, 3)],
                kind: LoadKind::I64,
            },
            Inst::Extend {
                value: 1,
                kind: LoadKind::I32,
            },
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 2,
                rhs_imm: 1,
            },
        ];
        let block = |range: core::ops::Range<u32>| Block {
            start_pc: 0,
            inst_range: range,
            terminator: Terminator::Jmp(1),
            exit_acc: 0,
        };
        let f = FunctionSsa {
            inst_src: vec![(0, 0); 4],
            f32_values: vec![false; 4],
            insts,
            blocks: vec![block(0..1), block(1..4)],
            ..FunctionSsa::default()
        };
        let def = def_ranges(&f, &[]);
        let int = Range {
            lo: i32::MIN as i128,
            hi: i32::MAX as i128,
        };
        assert!(def[2] == int);
        assert!(
            def[1]
                == Range {
                    lo: int.lo,
                    hi: u32::MAX as i128
                }
        );
    }

    /// The digit loop `while (n > 0) { digit = n % 10; ...; n = n / 10; }`:
    /// b0: v0 = param(I32)                                    -> b1
    /// b1: v1 = phi(v0, v4); v2 = sext32(v1); v3 = v2 % 10;
    ///     v4 = v2 / 10                                       -> b1
    /// The remainder lies in (-10, 10), so an `int` extension of it is
    /// the identity, and the quotient of an `int` by 10 is an `int`.
    #[test]
    fn remainder_and_quotient_by_a_constant_bound_the_digit_loop() {
        let insts = alloc::vec![
            Inst::ParamRef {
                idx: 0,
                kind: LoadKind::I32,
            },
            Inst::Phi {
                incoming: alloc::vec![(0, 0), (1, 4)],
                kind: LoadKind::I64,
            },
            Inst::Extend {
                value: 1,
                kind: LoadKind::I32,
            },
            Inst::BinopI {
                op: BinOp::Mod,
                lhs: 2,
                rhs_imm: 10,
            },
            Inst::BinopI {
                op: BinOp::Div,
                lhs: 2,
                rhs_imm: 10,
            },
        ];
        let block = |range: core::ops::Range<u32>| Block {
            start_pc: 0,
            inst_range: range,
            terminator: Terminator::Jmp(1),
            exit_acc: 0,
        };
        let f = FunctionSsa {
            n_params: 1,
            inst_src: vec![(0, 0); 5],
            f32_values: vec![false; 5],
            insts,
            blocks: vec![block(0..1), block(1..5)],
            ..FunctionSsa::default()
        };
        let def = def_ranges(&f, &[]);
        assert!(def[3] == Range { lo: -9, hi: 9 });
        assert!(def[3].fits(LoadKind::I32) && def[3].fits(LoadKind::I8));
        let tenth = Range {
            lo: i32::MIN as i128 / 10,
            hi: i32::MAX as i128 / 10,
        };
        assert!(def[4] == tenth);
        // The phi is the hull of the parameter and the quotient.
        assert!(def[1].fits(LoadKind::I32));
    }

    /// A signed division by a power of two whose dividend the guard keeps
    /// non-negative becomes the unsigned one, in the guarded arm only and
    /// for that divisor shape only.
    /// b0: v0 = param(I32); v1 = v0 >= 0; bz v1 -> b2
    /// b1: v2 = v0 / 8; v3 = v0 % 8; v4 = v0 / 10; v5 = v0 / -8
    /// b2: v6 = v0 / 8
    #[test]
    fn guarded_division_by_a_power_of_two_becomes_unsigned() {
        let div = |op, rhs_imm| Inst::BinopI {
            op,
            lhs: 0,
            rhs_imm,
        };
        let insts = alloc::vec![
            Inst::ParamRef {
                idx: 0,
                kind: LoadKind::I32,
            },
            Inst::BinopI {
                op: BinOp::Ge,
                lhs: 0,
                rhs_imm: 0,
            },
            div(BinOp::Div, 8),
            div(BinOp::Mod, 8),
            div(BinOp::Div, 10),
            div(BinOp::Div, -8),
            div(BinOp::Div, 8),
        ];
        let block = |range: core::ops::Range<u32>, t: Terminator| Block {
            start_pc: 0,
            inst_range: range,
            terminator: t,
            exit_acc: 0,
        };
        let mut f = FunctionSsa {
            n_params: 1,
            inst_src: vec![(0, 0); 7],
            f32_values: vec![false; 7],
            insts,
            blocks: vec![
                block(
                    0..2,
                    Terminator::Bz {
                        cond: 1,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(2..6, Terminator::Return(2)),
                block(6..7, Terminator::Return(6)),
            ],
            ..FunctionSsa::default()
        };
        run_one(&mut f, &[]);
        let op = |v: usize| match f.insts[v] {
            Inst::BinopI { op, .. } => op,
            ref other => panic!("{other:?}"),
        };
        assert_eq!(
            [op(2), op(3), op(4), op(5), op(6)],
            [BinOp::Divu, BinOp::Modu, BinOp::Div, BinOp::Div, BinOp::Div]
        );
    }

    /// `quotient` and `remainder` over the operand ranges that decide
    /// their rules, each beside the case it must not cover.
    #[test]
    fn division_bounds_hold_at_the_edges_of_their_rules() {
        let r = |lo: i128, hi: i128| Range { lo, hi };
        let exact = |k: i64| Range::exact(k);
        let (min, max) = (i64::MIN as i128, i64::MAX as i128);
        // Signed quotient: the corners, with either divisor sign.
        assert!(quotient(r(-7, 100), exact(10), false) == r(0, 10));
        assert!(quotient(r(-70, 100), exact(-10), false) == r(-10, 7));
        assert!(quotient(r(10, 20), r(2, 5), false) == r(2, 10));
        assert!(quotient(r(-20, -10), r(-5, -2), false) == r(2, 10));
        // `i64::MIN / -1` leaves the register; next to it, it does not.
        assert!(quotient(r(min, 0), exact(-1), false) == UNIVERSE);
        assert!(quotient(r(min + 1, 0), exact(-1), false) == r(0, max));
        assert!(quotient(r(min, 0), r(-2, -1), false) == UNIVERSE);
        // A divisor range holding zero bounds by the dividend only.
        assert!(quotient(r(-5, 9), r(-3, 3), false) == r(-9, 9));
        assert!(quotient(r(-5, 9), exact(0), false) == r(-9, 9));
        assert!(quotient(UNIVERSE, r(-3, 3), false) == UNIVERSE);
        // Unsigned quotient. A register that can be negative reads as
        // 2^63 and up: only a divisor above 1 brings it back in range.
        assert!(quotient(r(10, 100), r(2, 5), true) == r(2, 50));
        assert!(quotient(r(10, 100), r(-1, 5), true) == r(0, 100));
        assert!(quotient(r(-1, 100), exact(2), true) == r(0, max));
        assert!(quotient(r(-1, 100), exact(1), true) == UNIVERSE);
        assert!(quotient(r(-1, 100), r(-4, 4), true) == UNIVERSE);
        // Signed remainder: the dividend's sign and magnitude, and below
        // the divisor's magnitude when the divisor cannot be zero.
        assert!(remainder(r(-100, 100), exact(10), false) == r(-9, 9));
        assert!(remainder(r(0, 100), exact(-10), false) == r(0, 9));
        assert!(remainder(r(-100, -1), exact(10), false) == r(-9, 0));
        assert!(remainder(r(-3, 4), exact(10), false) == r(-3, 4));
        assert!(remainder(UNIVERSE, exact(i64::MIN), false) == r(-max, max));
        assert!(remainder(r(-100, 100), r(-10, 10), false) == r(-100, 100));
        assert!(remainder(r(-100, 100), exact(0), false) == r(-100, 100));
        assert!(remainder(r(5, 100), r(3, 7), false) == r(0, 6));
        // Unsigned remainder.
        assert!(remainder(r(0, 100), exact(10), true) == r(0, 9));
        assert!(remainder(r(0, 5), exact(10), true) == r(0, 5));
        assert!(remainder(r(-100, 100), exact(10), true) == r(0, 9));
        assert!(remainder(r(0, 100), exact(-10), true) == r(0, 100));
        assert!(remainder(r(0, 100), exact(0), true) == r(0, 100));
        assert!(remainder(r(-1, 100), exact(-10), true) == UNIVERSE);
        assert!(remainder(r(-1, 100), r(0, 10), true) == UNIVERSE);
    }

    /// Each bound against the operation itself, over every pair of a small
    /// operand grid: the evaluator's result lies inside the range computed
    /// from the exact operand ranges and from intervals around them.
    #[test]
    fn division_bounds_contain_every_evaluated_result() {
        use crate::c5::vm::eval::apply_binop;
        let grid: [i64; 15] = [
            i64::MIN,
            i64::MIN + 1,
            -(1 << 32),
            i32::MIN as i64,
            -11,
            -2,
            -1,
            0,
            1,
            2,
            11,
            i32::MAX as i64,
            1 << 32,
            i64::MAX - 1,
            i64::MAX,
        ];
        let holds = |got: Range, v: i64| got.lo <= v as i128 && v as i128 <= got.hi;
        for op in [BinOp::Div, BinOp::Divu, BinOp::Mod, BinOp::Modu] {
            for (i, &a) in grid.iter().enumerate() {
                for (j, &d) in grid.iter().enumerate() {
                    // A trapping pair has no result to bound.
                    let Ok(v) = apply_binop(op, a, d) else {
                        continue;
                    };
                    let exact = divmod(op, Range::exact(a), Range::exact(d));
                    assert!(holds(exact, v), "{op:?} {a} {d}: {v}");
                    let wide = |k: usize| Range {
                        lo: grid[k.saturating_sub(1)] as i128,
                        hi: grid[(k + 1).min(grid.len() - 1)] as i128,
                    };
                    assert!(holds(divmod(op, wide(i), wide(j)), v), "{op:?} {a} {d}");
                }
            }
        }
    }

    /// The bounds a definition carries must not depend on the order the
    /// iteration reached it: a phi whose incoming values are all
    /// unbounded stays unbounded, and its consumers decide nothing.
    #[test]
    fn phi_of_unbounded_values_decides_nothing() {
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64,
                },
                Inst::Phi {
                    incoming: alloc::vec![(0, 0), (0, 1)],
                    kind: LoadKind::I64,
                },
                Inst::BinopI {
                    op: BinOp::Ge,
                    lhs: 2,
                    rhs_imm: 0,
                },
            ],
            2,
        );
        assert!(!run_one(&mut f, &[]));
    }

    /// Bitwise and shift bounds. Each is checked through a comparison
    /// the bounds settle and one they must leave open.
    #[test]
    fn bitwise_and_shift_bounds() {
        let decides = |inst: Inst, cmp: BinOp, k: i64| {
            let mut f = fresh(
                alloc::vec![
                    Inst::ParamRef {
                        idx: 0,
                        kind: LoadKind::U8,
                    },
                    inst,
                    Inst::BinopI {
                        op: cmp,
                        lhs: 1,
                        rhs_imm: k,
                    },
                ],
                1,
            );
            run_one(&mut f, &[]).then(|| match f.insts[2] {
                Inst::Imm(v) => v,
                _ => -1,
            })
        };
        // A U8 parameter is in [0, 255]; xor by 3 stays under the next
        // mask up, and or by 3 is at least 3.
        let xor = |k| Inst::BinopI {
            op: BinOp::Xor,
            lhs: 0,
            rhs_imm: k,
        };
        assert_eq!(decides(xor(3), BinOp::Le, 255), Some(1));
        assert_eq!(decides(xor(3), BinOp::Le, 100), None);
        assert_eq!(
            decides(
                Inst::BinopI {
                    op: BinOp::Or,
                    lhs: 0,
                    rhs_imm: 3,
                },
                BinOp::Ge,
                3
            ),
            Some(1)
        );
        // Shifts move both endpoints; a shift left out of the register
        // is not modelled and settles nothing.
        let shl = |k| Inst::BinopI {
            op: BinOp::Shl,
            lhs: 0,
            rhs_imm: k,
        };
        assert_eq!(decides(shl(4), BinOp::Le, 255 * 16), Some(1));
        assert_eq!(decides(shl(62), BinOp::Ge, 0), None);
        assert_eq!(
            decides(
                Inst::BinopI {
                    op: BinOp::Shru,
                    lhs: 0,
                    rhs_imm: 4,
                },
                BinOp::Le,
                15
            ),
            Some(1)
        );
        // A remainder by a constant is bounded by it, with the dividend's
        // sign; an I8 parameter reaches below zero, so the signed form
        // does not prove the result non-negative.
        assert_eq!(
            decides(
                Inst::BinopI {
                    op: BinOp::Mod,
                    lhs: 0,
                    rhs_imm: 10,
                },
                BinOp::Le,
                9
            ),
            Some(1)
        );
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I8,
                },
                Inst::BinopI {
                    op: BinOp::Mod,
                    lhs: 0,
                    rhs_imm: 10,
                },
                Inst::BinopI {
                    op: BinOp::Ge,
                    lhs: 1,
                    rhs_imm: 0,
                },
            ],
            1,
        );
        assert!(!run_one(&mut f, &[]), "a negative dividend is not excluded");
        // An unsigned remainder reads a negative immediate as a divisor
        // above 2^63, which `|k|` does not describe: `x %u 2^63` on a
        // dividend up to 2^63 - 1 is the dividend itself, above the
        // `|k| - 1` the signed reading would give.
        let mut f = fresh(
            alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::BinopI {
                    op: BinOp::Ge,
                    lhs: 0,
                    rhs_imm: 0,
                },
                Inst::BinopI {
                    op: BinOp::Modu,
                    lhs: 0,
                    rhs_imm: i64::MIN,
                },
                Inst::BinopI {
                    op: BinOp::Le,
                    lhs: 2,
                    rhs_imm: i64::MAX - 1,
                },
            ],
            1,
        );
        run_one(&mut f, &[]);
        assert!(
            matches!(f.insts[3], Inst::BinopI { .. }),
            "a divisor above 2^63 bounds nothing: {:?}",
            f.insts[3]
        );
    }

    /// A branch on a masked or offset expression bounds the value it was
    /// built from, and only where the rewriting preserves the
    /// comparison: a mask that can clear a bit the operand holds, and an
    /// ordering through a non-monotone step, do not peel.
    #[test]
    fn branch_facts_reach_through_invertible_steps() {
        // b0: x = param & 0xff; y = x ^ 2; c = (y != 0); Bnz c -> b1
        // b1: eq = (x == 2)   -- decided false by the dominating branch
        let build = |mask: i64, cmp: BinOp| {
            let insts = alloc::vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::U8,
                },
                Inst::BinopI {
                    op: BinOp::And,
                    lhs: 0,
                    rhs_imm: mask,
                },
                Inst::BinopI {
                    op: BinOp::Xor,
                    lhs: 1,
                    rhs_imm: 2,
                },
                Inst::BinopI {
                    op: BinOp::Ne,
                    lhs: 2,
                    rhs_imm: 0,
                },
                Inst::BinopI {
                    op: cmp,
                    lhs: 1,
                    rhs_imm: 2,
                },
            ];
            let block = |range: core::ops::Range<u32>, t: Terminator| Block {
                start_pc: 0,
                inst_range: range,
                terminator: t,
                exit_acc: 0,
            };
            FunctionSsa {
                n_params: 1,
                inst_src: vec![(0, 0); 5],
                f32_values: vec![false; 5],
                insts,
                blocks: vec![
                    block(
                        0..4,
                        Terminator::Bnz {
                            cond: 3,
                            target: 1,
                            fall_through: 2,
                        },
                    ),
                    block(4..5, Terminator::Return(4)),
                    block(4..4, Terminator::Return(crate::c5::ir::NO_VALUE)),
                ],
                ..FunctionSsa::default()
            }
        };
        let mut f = build(0xff, BinOp::Eq);
        assert!(run_one(&mut f, &[]));
        assert!(
            matches!(f.insts[4], Inst::Imm(0)),
            "(x ^ 2) != 0 is x != 2: {:?}",
            f.insts[4]
        );
        // The same chain compared for order: the exclusive-or does not
        // preserve it, so nothing peels through and x <= 2 stays open.
        let mut f = build(0xff, BinOp::Le);
        run_one(&mut f, &[]);
        assert!(
            matches!(f.insts[4], Inst::BinopI { .. }),
            "an ordering must not peel through a non-monotone step"
        );
    }

    /// A mask peels only where it clears no bit its operand can hold.
    /// The operand here is unbounded, so `x & 0xff` is not `x`: the
    /// masked value being zero says nothing about `x`.
    ///
    /// b0: y = x & 0xff; Bnz y -> b1 else b2
    /// b2: eq = (x == 0)   -- must stay a runtime test
    #[test]
    fn a_mask_that_is_not_the_identity_does_not_peel() {
        let insts = alloc::vec![
            Inst::ParamRef {
                idx: 0,
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: BinOp::And,
                lhs: 0,
                rhs_imm: 0xff,
            },
            Inst::BinopI {
                op: BinOp::Eq,
                lhs: 0,
                rhs_imm: 0,
            },
        ];
        let block = |range: core::ops::Range<u32>, t: Terminator| Block {
            start_pc: 0,
            inst_range: range,
            terminator: t,
            exit_acc: 0,
        };
        let mut f = FunctionSsa {
            n_params: 1,
            inst_src: vec![(0, 0); 3],
            f32_values: vec![false; 3],
            insts,
            blocks: vec![
                block(
                    0..2,
                    Terminator::Bnz {
                        cond: 1,
                        target: 1,
                        fall_through: 2,
                    },
                ),
                block(2..2, Terminator::Return(crate::c5::ir::NO_VALUE)),
                block(2..3, Terminator::Return(2)),
            ],
            ..FunctionSsa::default()
        };
        run_one(&mut f, &[]);
        assert!(
            matches!(f.insts[2], Inst::BinopI { .. }),
            "x & 0xff == 0 does not decide x == 0: {:?}",
            f.insts[2]
        );
    }

    /// A wipe visits the load facts holding a bound, not the map: over N
    /// bounded loads each followed by a write the visits stay linear, and
    /// a rewind past a wipe makes the restored bounds wipeable again.
    #[test]
    fn a_wipe_visits_only_the_bounded_load_facts() {
        const N: u32 = 4096;
        let bound = Range { lo: 0, hi: 255 };
        let load = |i: u32| -> Key { (5, i, 0, 0) };
        let mut facts = Facts::default();
        for i in 0..N {
            facts.set(opaque_key(i), bound);
            facts.set(load(i), bound);
            facts.wipe_loads();
            assert!(facts.get(load(i)).is_universe());
            assert!(
                facts.get(opaque_key(i)) == bound,
                "only load facts are wiped"
            );
        }
        assert!(
            facts.wipe_visits <= 2 * N as usize,
            "{} visits for {N} loads",
            facts.wipe_visits
        );

        let mark = facts.mark();
        facts.set(load(0), bound);
        let inner = facts.mark();
        facts.wipe_loads();
        facts.rewind(inner);
        assert!(facts.get(load(0)) == bound, "the rewind restores the bound");
        facts.wipe_loads();
        assert!(
            facts.get(load(0)).is_universe(),
            "and the bound is wiped again"
        );
        facts.rewind(mark);
    }

    /// Contradictory guards leave a divisor with an empty range, whose
    /// upper bound can be zero while the lower one is positive.
    #[test]
    fn a_division_under_contradictory_guards_bounds_nothing() {
        let empty = Range { lo: 6, hi: 0 };
        let a = Range { lo: 0, hi: 100 };
        for op in [BinOp::Div, BinOp::Divu, BinOp::Mod, BinOp::Modu] {
            assert!(divmod(op, a, empty).is_universe(), "{op:?}");
            assert!(divmod(op, empty, Range::exact(3)).is_universe(), "{op:?}");
        }
    }
}
