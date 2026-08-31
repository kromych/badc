//! Integer comparisons decided by a dominating branch condition.
//!
//! Every other `-O` fold reads an operand that is already an immediate.
//! A comparison whose answer follows from the condition guarding the
//! block it sits in has no immediate anywhere, so it stayed a runtime
//! test and the arm it selects stayed live -- including an arm holding a
//! build-time-assert call the source expects to be unreachable.
//!
//! Two ranges bound each value. [`def_ranges`] is what the definition
//! alone says, iterated over the tape to a settled table so a phi is
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

    /// Widening: an endpoint that moved outward goes to the end of the
    /// register's range rather than to its new value. Contains both
    /// operands, and sends each endpoint to its limit at most once, so
    /// an iteration applying it cannot ascend forever.
    fn widen(self, other: Range) -> Range {
        Range {
            lo: if other.lo < self.lo {
                UNIVERSE.lo
            } else {
                self.lo
            },
            hi: if other.hi > self.hi {
                UNIVERSE.hi
            } else {
                self.hi
            },
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

/// The integer load kinds that read back exactly the bytes a store of
/// `kind` wrote. A float store leaves no integer reading.
fn load_kinds_of_store(kind: StoreKind) -> &'static [LoadKind] {
    match kind {
        StoreKind::I8 => &[LoadKind::I8, LoadKind::U8],
        StoreKind::I16 => &[LoadKind::I16, LoadKind::U16],
        StoreKind::I32 => &[LoadKind::I32, LoadKind::U32],
        StoreKind::I64 => &[LoadKind::I64],
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => &[],
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
            scale,
            value,
            kind,
        } => (load_kinds_of_store(*kind), *value, &|k| {
            (
                7,
                c(*base),
                c(*index),
                ((*scale as i64) << 8) | load_kind_code(k) as i64,
            )
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
        LoadKind::F80 => 9,
        LoadKind::F128 => 10,
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
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => return None,
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

/// Bounds a remainder by a constant divisor. The C99 6.5.5p6 result has
/// the sign of the dividend, so a dividend that may be negative reaches
/// down to `-(|k| - 1)`. The unsigned form reads both operands as
/// unsigned, where a negative immediate is a divisor above `2^63` and a
/// negative dividend a huge numerator, neither of which `|k|` describes.
fn remainder(a: Range, k: i64, unsigned: bool) -> Range {
    if unsigned && !(a.non_negative() && k > 0) {
        return UNIVERSE;
    }
    let m = match (k as i128).checked_abs() {
        Some(m) if m > 0 => m - 1,
        _ => return UNIVERSE,
    };
    Range {
        lo: if a.non_negative() { 0 } else { -m },
        hi: m,
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
            BinOp::Mod => remainder(range_of(*lhs), *rhs_imm, false),
            BinOp::Modu => remainder(range_of(*lhs), *rhs_imm, true),
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

/// Rounds of the definition-range iteration, and the round from which a
/// value that is still moving is widened so the ascending chain
/// terminates.
const WIDEN_ROUND: u32 = 3;
const MAX_ROUNDS: u32 = 16;

/// Bounds a value's definition carries wherever it is live: the
/// instruction's own rule over its operands' bounds, with a phi taking
/// the hull of what reaches it. Iterating from the empty range makes
/// each round's table an under-approximation, so only a settled table
/// is returned; a run still moving after [`MAX_ROUNDS`] yields no
/// bounds at all. Settled means every value already contains what its
/// rule produces from the table, and a table with that property
/// over-approximates every value a definition can produce, whatever
/// order the iteration reached it in.
fn def_ranges(func: &FunctionSsa, params: &[Range]) -> Vec<Range> {
    let n = func.insts.len();
    let mut cur: Vec<Option<Range>> = alloc::vec![None; n];
    let mut settled = false;
    for round in 0..MAX_ROUNDS {
        let mut changed = false;
        for v in 0..n {
            let next = match &func.insts[v] {
                // A floating phi merges no integers.
                Inst::Phi {
                    kind: LoadKind::F32 | LoadKind::F64,
                    ..
                } => Some(UNIVERSE),
                Inst::Phi { incoming, .. } => incoming
                    .iter()
                    .filter_map(|&(_, s)| cur.get(s as usize).copied().flatten())
                    .reduce(Range::hull),
                inst => {
                    let mut unreached = false;
                    let r = eval(inst, params, |o| {
                        match cur.get(o as usize).copied().flatten() {
                            Some(r) => r,
                            None => {
                                unreached = true;
                                UNIVERSE
                            }
                        }
                    });
                    if unreached { None } else { Some(r) }
                }
            };
            let next = match (round >= WIDEN_ROUND, cur[v], next) {
                (true, Some(old), Some(new)) => Some(old.widen(new)),
                (_, _, next) => next,
            };
            if next != cur[v] {
                changed = true;
                cur[v] = next;
            }
        }
        if !changed {
            settled = true;
            break;
        }
    }
    // A value no definition reached stays unbounded rather than empty:
    // the iteration's own reach is not a statement about the program.
    match settled {
        true => cur.into_iter().map(|r| r.unwrap_or(UNIVERSE)).collect(),
        false => alloc::vec![UNIVERSE; n],
    }
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

    /// A loop-carried value whose rule does not reproduce the widened
    /// bounds must still settle. `v = phi(0, (v + 1) & 0xff)` is that
    /// shape: sending a moved endpoint to the end of the register keeps
    /// the other, and the mask's own bound is inside the result, so the
    /// next round changes nothing. Sending it to the whole register
    /// instead would alternate with what the mask recomputes and the
    /// iteration would never settle, discarding every bound in the
    /// function. The lower endpoint survives, so the value is still
    /// known non-negative.
    ///
    /// b0: v0 = 0                -> b1
    /// b1: v1 = phi(v0, v3)
    ///     v2 = v1 + 1
    ///     v3 = v2 & 0xff
    ///     v4 = (v1 >= 0)        -> b1
    #[test]
    fn a_widened_loop_value_settles_and_keeps_its_lower_bound() {
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
}
