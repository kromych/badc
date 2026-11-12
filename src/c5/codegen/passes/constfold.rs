//! Post-inline constant folding. The inliner substitutes call-site
//! immediates into callee bodies and materializes callee-narrows
//! extends on them (`splice_param_ref`), leaving `Extend(Imm)` /
//! `Binop(Imm, Imm)` / `BinopI(Imm, k)` chains no earlier stage
//! re-folds. Folding them lets the downstream matchers (`rotate`'s
//! constant-count arm, `constfold_branch`, the immediate-form
//! encoders) see plain `Inst::Imm` / `Inst::BinopI` shapes.
//!
//! Rewrites, in-place to a bounded fixed point:
//!   * `Extend { Imm }` -> `Imm` (sign-extended per kind);
//!   * `BinopI { int op, Imm lhs, k }` -> `Imm`;
//!   * `Binop { int op, Imm, Imm }` -> `Imm`;
//!   * `Binop { rhs = Imm }` -> `BinopI` for [`binopi_safe`] ops when
//!     the immediate encodes without a per-use scratch
//!     materialization or the `Imm` def has no other use;
//!   * `Binop { lhs = Imm }` -> the rhs-imm form via commutation or
//!     compare mirroring, then the rule above;
//!   * `Fneg { Imm }` -> `Imm` with the sign bit flipped;
//!   * `Neg { Imm }` -> the negated `Imm`, and `x * -1` / `0 - x` ->
//!     `Neg { x }`, which takes one instruction where the multiply
//!     takes three and needs no constant register;
//!   * a `VecExtract` of a lane a `VecInsert` wrote -> the inserted value
//!     read back as the extract's kind, past the inserts of other lanes,
//!     and of a zero vector -> `Imm(0)` ([`fold_lane_reads`]).
//!
//! Save for that sign flip, only a plain integer `Inst::Imm` whose
//! `f32_values` flag is clear participates: `ImmData` / `ImmCode` /
//! `ImmExtCode` / `BlockAddr` / `TlsAddr` / `LocalAddr` resolve to
//! addresses at emit time, and an f32 `Imm` carries the low-32 bit
//! pattern in the IR while the evaluator's register convention is
//! f64-widened. Division the evaluator computes but native code traps
//! on (`/ 0`, `i64::MIN / -1`) is refused by `eval::fold_binop`, so
//! folding never changes runtime behavior.
//!
//! Blocks and terminators are untouched and every rewrite is
//! in-place, so `inst_src` / `f32_values` stay parallel. Operand
//! `Imm`s made dead are reaped by the emit's use-count DCE.

use crate::c5::codegen::ssa::reg_alloc::{for_each_operand, produces_fp_result};
use crate::c5::ir::{
    BinOp, FpCastKind, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId,
    is_comparison_op,
};
use crate::c5::vm::eval;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec;
use alloc::vec::Vec;

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs {
        run_one(func);
    }
}

/// Bound on fold rounds. A round resolves every chain whose defs
/// precede their uses on the inst tape; further rounds only pick up
/// cross-block back-references, which converge in practice within
/// two.
const MAX_ROUNDS: usize = 4;

pub(crate) fn run_one(func: &mut FunctionSsa) {
    for _ in 0..MAX_ROUNDS {
        let folded = fold_round(func) | fold_constant_lanes(func);
        let lanes = fold_lane_reads(func);
        let forwarded = forward_identities(func);
        if !folded && !lanes && !forwarded {
            break;
        }
    }
    // After the rounds, which fold a round trip of a constant whole and
    // the lane reads of a constant vector's inserts.
    fold_constant_halves(func);
    compared_truncations(func);
}

/// `(float)(int)x` that only comparisons read is `trunc(x)`: the two are
/// equal wherever the conversion to an integer is defined (C17 6.3.1.4p1)
/// but in the sign of a zero, which a comparison does not see, and the
/// truncation takes no integer round trip.
fn compared_truncations(func: &mut FunctionSsa) {
    let n = func.insts.len();
    let (mut read, mut compared) = (vec![false; n], vec![true; n]);
    for inst in &func.insts {
        let compare =
            matches!(inst, Inst::Binop { op, .. } if crate::c5::ir::is_fp_comparison_op(*op));
        inst.for_each_operand(|v| {
            if let Some(r) = read.get_mut(v as usize) {
                *r = true;
                compared[v as usize] &= compare;
            }
        });
    }
    for b in &func.blocks {
        b.terminator.for_each_operand(|v| {
            if let Some(c) = compared.get_mut(v as usize) {
                *c = false;
            }
        });
    }
    let f32 =
        |func: &FunctionSsa, v: ValueId| func.f32_values.get(v as usize).copied().unwrap_or(false);
    for i in 0..n {
        let Inst::FpCast {
            kind: FpCastKind::IntToFp,
            value,
        } = func.insts[i]
        else {
            continue;
        };
        let int = match func.insts[value as usize] {
            Inst::Extend {
                value,
                kind: LoadKind::I32,
                ..
            } => value,
            _ => value,
        };
        if let Inst::FpCast {
            kind: FpCastKind::FpToInt,
            value: x,
        } = func.insts[int as usize]
            && read[i]
            && compared[i]
            && f32(func, x) == f32(func, i as ValueId)
        {
            let kind = match f32(func, x) {
                true => crate::c5::op::Intrinsic::Truncf,
                false => crate::c5::op::Intrinsic::Trunc,
            };
            func.insts[i] = Inst::Intrinsic {
                kind: kind as i64,
                args: alloc::vec![x],
            };
        }
    }
}

/// A constant written into a lane of an 8-byte vector that is itself a
/// constant -- zero, undefined, or a `VecConst` -- is the constant with that
/// lane replaced: the vector's one 64-bit lane, which the targets build
/// in a general register and move over whole.
fn fold_constant_lanes(func: &mut FunctionSsa) -> bool {
    let mut changed = false;
    for i in 0..func.insts.len() {
        let Inst::VecInsert {
            vec,
            value,
            off,
            kind,
            bytes: 8,
        } = func.insts[i]
        else {
            continue;
        };
        let w = u32::from(store_width(kind));
        if !matches!(
            kind,
            StoreKind::I8 | StoreKind::I16 | StoreKind::I32 | StoreKind::I64
        ) || u32::from(off) + w > 8
        {
            continue;
        }
        let Some(&Inst::Imm(x)) = func.insts.get(value as usize) else {
            continue;
        };
        let base = match func.insts.get(vec as usize) {
            Some(Inst::Imm(0) | Inst::Undef) => 0u64,
            Some(&Inst::VecConst {
                imm,
                kind: k,
                bytes: 8,
            }) => {
                let bits = 8 * u32::from(store_width(k));
                let lane = imm as u64 & (u64::MAX >> (64 - bits));
                (0..64 / bits).fold(0, |p, j| p | lane << (j * bits))
            }
            _ => continue,
        };
        let mask = (u64::MAX >> (64 - 8 * w)) << (8 * u32::from(off));
        let merged = (base & !mask) | ((x as u64) << (8 * u32::from(off)) & mask);
        func.insts[i] = Inst::VecConst {
            imm: merged as i64,
            kind: StoreKind::I64,
            bytes: 8,
        };
        changed = true;
    }
    changed
}

/// A chain of three or more integer constants inserted into a 16-byte
/// constant vector, each insert read by the next alone, is its two 64-bit
/// halves: the second insert from the end becomes the low half in both
/// lanes, the one after it the high half as an 8-byte constant, and the
/// last inserts that over the low one. Equal halves are one splat.
fn fold_constant_halves(func: &mut FunctionSsa) -> bool {
    let mut uses = vec![0u32; func.insts.len()];
    for inst in &func.insts {
        inst.for_each_operand(|v| {
            if let Some(u) = uses.get_mut(v as usize) {
                *u += 1;
            }
        });
    }
    for b in &func.blocks {
        b.terminator.for_each_operand(|v| {
            if let Some(u) = uses.get_mut(v as usize) {
                *u += 1;
            }
        });
    }
    // The insert at `i` of an integer constant into a 16-byte vector: its
    // vector and the lane written, as a mask and the bits.
    let lane = |func: &FunctionSsa, i: ValueId| -> Option<(ValueId, u128, u128)> {
        let Inst::VecInsert {
            vec,
            value,
            off,
            kind,
            bytes: 16,
        } = func.insts[i as usize]
        else {
            return None;
        };
        if !matches!(
            kind,
            StoreKind::I8 | StoreKind::I16 | StoreKind::I32 | StoreKind::I64
        ) {
            return None;
        }
        let w = u32::from(store_width(kind));
        let Some(&Inst::Imm(x)) = func.insts.get(value as usize) else {
            return None;
        };
        let at = 8 * u32::from(off);
        let mask = (u128::MAX >> (128 - 8 * w)) << at;
        Some((vec, mask, (u128::from(x as u64) << at) & mask))
    };
    // A chain is folded from its end: an insert another one writes over is
    // inside a chain.
    let mut inner = vec![false; func.insts.len()];
    for i in 0..func.insts.len() {
        if let Some((vec, ..)) = lane(func, i as ValueId)
            && let Some(x) = inner.get_mut(vec as usize)
        {
            *x = true;
        }
    }
    let mut changed = false;
    for last in 0..func.insts.len() {
        if uses[last] == 0 || inner[last] {
            continue;
        }
        let mut chain = Vec::new();
        let (mut at, mut known, mut bits) = (last as ValueId, 0u128, 0u128);
        let base = loop {
            let Some((vec, mask, x)) = lane(func, at) else {
                break None;
            };
            if !chain.is_empty() && uses[at as usize] != 1 {
                break None;
            }
            chain.push(at);
            // A lane written later wins over one written before it.
            bits |= x & !known;
            known |= mask;
            match func.insts[vec as usize] {
                Inst::Imm(0) | Inst::Undef => break Some(0u128),
                Inst::VecConst {
                    imm,
                    kind,
                    bytes: 16,
                } => {
                    let w = 8 * u32::from(store_width(kind));
                    let l = u128::from(imm as u64) & (u128::MAX >> (128 - w));
                    break Some((0..128 / w).fold(0, |p, j| p | l << (j * w)));
                }
                _ => at = vec,
            }
        };
        let Some(base) = base else { continue };
        if chain.len() < 3 {
            continue;
        }
        let v = (base & !known) | bits;
        let (lo, hi) = (v as u64 as i64, (v >> 64) as u64 as i64);
        let (pair_lo, pair_hi) = (chain[2], chain[1]);
        if lo == hi {
            func.insts[last] = Inst::VecConst {
                imm: lo,
                kind: StoreKind::I64,
                bytes: 16,
            };
        } else {
            func.insts[pair_lo as usize] = Inst::VecConst {
                imm: lo,
                kind: StoreKind::I64,
                bytes: 16,
            };
            func.insts[pair_hi as usize] = Inst::VecConst {
                imm: hi,
                kind: StoreKind::I64,
                bytes: 8,
            };
            func.insts[last] = Inst::VecInsert {
                vec: pair_lo,
                value: pair_hi,
                off: 8,
                kind: StoreKind::F64,
                bytes: 16,
            };
        }
        changed = true;
    }
    changed
}

/// Bytes a lane insert of `kind` writes.
fn store_width(kind: StoreKind) -> u8 {
    match kind {
        StoreKind::I8 => 1,
        StoreKind::I16 => 2,
        StoreKind::I32 | StoreKind::F32 => 4,
        StoreKind::V128 => 16,
        StoreKind::V256 => 32,
        StoreKind::V512 => 64,
        _ => 8,
    }
}

/// Inserts `fold_lane_reads` looks through for the lane it reads.
const LANE_DEPTH: u32 = 64;

/// A 16-byte vector built as its low 8 bytes inserted into zero and its
/// high 8 bytes inserted over that, when the zero and the low insert have
/// no other reader: every byte is written, so the zero is undefined and the
/// low insert needs no clearing of the bytes above its lane.
fn blank_under_pairs(func: &mut FunctionSsa) -> bool {
    let mut uses = vec![0u32; func.insts.len()];
    let mut count = |v: ValueId| {
        if let Some(u) = uses.get_mut(v as usize) {
            *u += 1;
        }
    };
    func.insts
        .iter()
        .for_each(|inst| inst.for_each_operand(&mut count));
    func.blocks
        .iter()
        .for_each(|b| b.terminator.for_each_operand(&mut count));
    let mut changed = false;
    for i in 0..func.insts.len() {
        let low = crate::c5::codegen::ssa::vector_slots::pair_low(func, &uses, &func.insts[i]);
        if let Some(low) = low
            && let Inst::VecInsert { vec: zero, .. } = func.insts[low as usize]
            && uses[zero as usize] == 1
            && matches!(func.insts[zero as usize], Inst::Imm(0))
        {
            func.insts[zero as usize] = Inst::Undef;
            changed = true;
        }
    }
    changed
}

/// Rewrite each `VecExtract` whose lane the vector's inserts determine:
/// the value an insert of the same lane and width wrote, read back as the
/// extract's kind reads it from memory (a sign or zero extension of its low
/// bytes, or the value itself), looking past inserts of disjoint lanes; a
/// lane inside a 128-bit part written whole, that lane of the part; a lane
/// of a zero vector, zero, and of an undefined one, undefined. A lane
/// insert over an insert of the same
/// lane takes that insert's vector. Returns whether anything was rewritten.
fn fold_lane_reads(func: &mut FunctionSsa) -> bool {
    let mut changed = blank_under_pairs(func);
    // A lane written over the same lane of an insert writes over that
    // insert's vector.
    for i in 0..func.insts.len() {
        let Inst::VecInsert { vec, off, kind, .. } = func.insts[i] else {
            continue;
        };
        if let Inst::VecInsert {
            vec: base,
            off: at,
            kind: under,
            ..
        } = func.insts[vec as usize]
            && at == off
            && store_width(under) == store_width(kind)
            && let Inst::VecInsert { vec, .. } = &mut func.insts[i]
        {
            *vec = base;
            changed = true;
        }
    }
    for i in 0..func.insts.len() {
        let Inst::VecExtract {
            mut vec, off, kind, ..
        } = func.insts[i]
        else {
            continue;
        };
        let read = vec;
        let width = match kind {
            LoadKind::F32 => 4,
            LoadKind::F64 => 8,
            LoadKind::V128 => 16,
            k => match k.int_bytes() {
                Some(n) => n,
                None => continue,
            },
        };
        let mut found = None;
        for _ in 0..LANE_DEPTH {
            match func.insts[vec as usize] {
                Inst::VecInsert {
                    vec: base,
                    value,
                    off: at,
                    kind: stored,
                    ..
                } => {
                    let n = store_width(stored);
                    if at == off && n == width {
                        found = Some((value, stored));
                        break;
                    }
                    if at + n <= off || off + width <= at {
                        vec = base;
                        continue;
                    }
                    // A lane of a part written whole is that lane of the part.
                    if stored == StoreKind::V128 && at <= off && off + width <= at + 16 {
                        func.insts[i] = Inst::VecExtract {
                            vec: value,
                            off: off - at,
                            kind,
                            bytes: 16,
                        };
                        changed = true;
                    }
                    break;
                }
                // Every lane of a splat is its value.
                Inst::VecSplat {
                    value,
                    kind: stored,
                    ..
                } => {
                    if store_width(stored) == width {
                        found = Some((value, stored));
                    }
                    break;
                }
                // And of a constant splat, its lane's bytes at the offset
                // the read takes within the lane.
                Inst::VecConst {
                    imm, kind: stored, ..
                } => {
                    let size = store_width(stored);
                    let at = off % size;
                    if at + width > size {
                        break;
                    }
                    let lane = (imm as u64) >> (8 * u32::from(at));
                    let read = match kind {
                        LoadKind::I8 => Some(lane as i8 as i64),
                        LoadKind::U8 => Some(lane as u8 as i64),
                        LoadKind::I16 => Some(lane as i16 as i64),
                        LoadKind::U16 => Some(lane as u16 as i64),
                        LoadKind::I32 => Some(lane as i32 as i64),
                        LoadKind::U32 => Some(lane as u32 as i64),
                        LoadKind::I64 => Some(imm),
                        _ => None,
                    };
                    if let Some(k) = read {
                        func.insts[i] = Inst::Imm(k);
                        changed = true;
                    }
                    break;
                }
                Inst::Imm(0) if !matches!(kind, LoadKind::F32 | LoadKind::F64) => {
                    func.insts[i] = Inst::Imm(0);
                    changed = true;
                    break;
                }
                // A lane of an undefined vector is undefined.
                Inst::Undef => {
                    func.insts[i] = Inst::Undef;
                    changed = true;
                    break;
                }
                Inst::Copy { value, .. } => vec = value,
                _ => break,
            }
        }
        // Past inserts of other lanes the read takes the vector it reached,
        // which a fold of that vector's lanes then sees.
        let Some((value, stored)) = found else {
            if vec != read
                && let Inst::VecExtract { vec: v, .. } = &mut func.insts[i]
            {
                *v = vec;
                changed = true;
            }
            continue;
        };
        let float = matches!(stored, StoreKind::F32 | StoreKind::F64);
        func.insts[i] = match kind {
            LoadKind::F32 | LoadKind::F64 if float => Inst::Copy { value, is_fp: true },
            LoadKind::V128 if stored == StoreKind::V128 => Inst::Copy { value, is_fp: true },
            LoadKind::I64 if !float => Inst::Copy {
                value,
                is_fp: false,
            },
            LoadKind::I32 | LoadKind::I16 | LoadKind::I8 if !float => Inst::Extend {
                value,
                kind,
                nsw: false,
            },
            LoadKind::U32 | LoadKind::U16 | LoadKind::U8 if !float => Inst::BinopI {
                op: BinOp::And,
                lhs: value,
                rhs_imm: (1i64 << (8 * width)) - 1,
            },
            _ => continue,
        };
        changed = true;
    }
    changed
}

/// Producer depth `is_bool_value` chases through phis and extends.
const BOOL_DEPTH: u32 = 8;

/// Whether `v` is provably 0 or 1: a comparison result, a 0/1
/// constant, or a phi / integer-extend chain of such. Phi cycles
/// terminate on the depth bound.
fn is_bool_value(func: &FunctionSsa, v: ValueId, depth: u32) -> bool {
    if depth == 0 || v == NO_VALUE {
        return false;
    }
    if matches!(func.f32_values.get(v as usize), Some(true)) {
        return false;
    }
    match func.insts.get(v as usize) {
        Some(Inst::Imm(k)) => *k == 0 || *k == 1,
        Some(Inst::Binop { op, .. }) | Some(Inst::BinopI { op, .. }) => is_comparison_op(*op),
        Some(Inst::Extend { value, kind, .. }) => {
            !matches!(kind, LoadKind::F32 | LoadKind::F64) && is_bool_value(func, *value, depth - 1)
        }
        Some(Inst::Phi { incoming, kind }) => {
            !matches!(kind, LoadKind::F32 | LoadKind::F64)
                && !incoming.is_empty()
                && incoming
                    .iter()
                    .all(|&(_, s)| is_bool_value(func, s, depth - 1))
        }
        _ => false,
    }
}

/// The operand an instruction reproduces bit for bit, if any: `x != 0`
/// over a provably 0/1 `x` (`is_bool_value`) -- the short-circuit lowering
/// re-normalizes an `&&` / `||` operand a comparison or `!` already
/// normalized -- an integer operation by its identity constant, `x & x` /
/// `x | x`, and a copy between general registers.
fn forwarded_operand(func: &FunctionSsa, idx: usize) -> Option<ValueId> {
    if matches!(func.f32_values.get(idx), Some(true)) {
        return None;
    }
    if let Inst::Copy {
        value,
        is_fp: false,
    } = func.insts[idx]
        && !matches!(func.f32_values.get(value as usize), Some(true))
        && func
            .insts
            .get(value as usize)
            .is_some_and(|i| !produces_fp_result(i))
    {
        return Some(value);
    }
    if let Inst::Binop {
        op: BinOp::And | BinOp::Or,
        lhs,
        rhs,
    } = func.insts[idx]
        && lhs == rhs
    {
        return Some(lhs);
    }
    let (op, lhs, imm) = match &func.insts[idx] {
        Inst::BinopI { op, lhs, rhs_imm } => (*op, *lhs, *rhs_imm),
        Inst::Binop { op, lhs, rhs } => (*op, *lhs, imm_of(func, *rhs)?),
        _ => return None,
    };
    let identity = match op {
        BinOp::Ne => imm == 0 && is_bool_value(func, lhs, BOOL_DEPTH),
        BinOp::Add | BinOp::Sub | BinOp::Or | BinOp::Xor => imm == 0,
        BinOp::Shl | BinOp::Shr | BinOp::Shru => imm == 0,
        BinOp::Mul | BinOp::Div | BinOp::Divu => imm == 1,
        BinOp::And => imm == -1,
        _ => false,
    };
    identity.then_some(lhs)
}

/// The operand of `v`'s definition when that definition is a negate.
fn negated_value(func: &FunctionSsa, v: ValueId) -> Option<ValueId> {
    match func.insts.get(v as usize) {
        Some(Inst::Neg(x)) => Some(*x),
        _ => None,
    }
}

/// The operand of a doubly-applied negation: `-(-x)` is `x` for every
/// two's-complement value, the type minimum included.
fn double_negate_operand(func: &FunctionSsa, idx: usize) -> Option<ValueId> {
    let Inst::Neg(v) = func.insts[idx] else {
        return None;
    };
    match func.insts.get(v as usize) {
        Some(Inst::Neg(inner)) => Some(*inner),
        _ => None,
    }
}

/// The arm a select yields when that does not depend on its condition's
/// value at run time: the condition is a constant, or both arms are one
/// value.
fn select_arm(func: &FunctionSsa, idx: usize) -> Option<ValueId> {
    let Inst::Select { cond, a, b, .. } = func.insts[idx] else {
        return None;
    };
    if a == b {
        return Some(a);
    }
    match func.insts.get(cond as usize) {
        Some(Inst::Imm(k)) => Some(if *k != 0 { a } else { b }),
        _ => None,
    }
}

/// Redirect every consumer of an instruction [`forwarded_operand`],
/// [`double_negate_operand`] or [`select_arm`] answers to that operand,
/// leaving the instruction dead. The operand dominates each redirected
/// use, since it dominates the instruction.
/// Returns whether any operand actually changed.
/// The operand a whole-vector operation with a zero or all-ones operand
/// equals: `a + 0`, `a - 0`, `a | 0`, `a ^ 0` and `a & ~0` are `a`; `a & 0`
/// is the zero and `a | ~0` the all-ones constant. A zero is the zero fill
/// a promoted vector takes (`Imm(0)`) or a constant splat of zero.
fn vector_identity(func: &FunctionSsa, i: usize) -> Option<ValueId> {
    let Inst::VecBinop { op, lhs, rhs, .. } = func.insts[i] else {
        return None;
    };
    let splat = |v: ValueId| match func.insts.get(v as usize) {
        Some(Inst::Imm(0)) => Some(0u64),
        Some(&Inst::VecConst { imm, kind, .. }) => {
            let bits = 8 * u32::from(store_width(kind));
            let mask = u64::MAX >> (64 - bits);
            match imm as u64 & mask {
                0 => Some(0),
                m if m == mask => Some(u64::MAX),
                _ => None,
            }
        }
        _ => None,
    };
    let constant = |v: ValueId| matches!(func.insts.get(v as usize), Some(Inst::VecConst { .. }));
    match (op, splat(lhs), splat(rhs)) {
        (BinOp::Add | BinOp::Or | BinOp::Xor, _, Some(0)) | (BinOp::Sub, _, Some(0)) => Some(lhs),
        (BinOp::Add | BinOp::Or | BinOp::Xor, Some(0), _) => Some(rhs),
        (BinOp::And, _, Some(u64::MAX)) => Some(lhs),
        (BinOp::And, Some(u64::MAX), _) => Some(rhs),
        (BinOp::And, _, Some(0)) if constant(rhs) => Some(rhs),
        (BinOp::And, Some(0), _) if constant(lhs) => Some(lhs),
        (BinOp::Or, _, Some(u64::MAX)) => Some(rhs),
        (BinOp::Or, Some(u64::MAX), _) => Some(lhs),
        _ => None,
    }
}

fn forward_identities(func: &mut FunctionSsa) -> bool {
    let n = func.insts.len();
    let redirect: Vec<Option<ValueId>> = (0..n)
        .map(|i| {
            forwarded_operand(func, i)
                .or_else(|| double_negate_operand(func, i))
                .or_else(|| select_arm(func, i))
                .or_else(|| vector_identity(func, i))
        })
        .collect();
    let any = redirect.iter().any(Option::is_some);
    if !any {
        return false;
    }
    let resolve = |mut v: ValueId| -> ValueId {
        let mut guard = 0usize;
        while v != NO_VALUE && (v as usize) < n {
            match redirect[v as usize] {
                Some(t) if t != v => {
                    v = t;
                    guard += 1;
                    if guard > n {
                        break;
                    }
                }
                _ => break,
            }
        }
        v
    };
    let mut changed = false;
    for inst in func.insts.iter_mut() {
        inst.for_each_operand_mut(|op| {
            let t = resolve(*op);
            if t != *op {
                *op = t;
                changed = true;
            }
        });
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE {
            let t = resolve(block.exit_acc);
            if t != block.exit_acc {
                block.exit_acc = t;
                changed = true;
            }
        }
        block.terminator.for_each_operand_mut(|v| {
            let t = resolve(*v);
            if t != *v {
                *v = t;
                changed = true;
            }
        });
    }
    changed
}

/// The constant the operation `v` computes from `l` and `r`: a comparison
/// or a division marked for its 32-bit form reads the low words, as the
/// emitted compare or division does, since its operands may have lost the
/// extensions the mark made redundant.
fn fold_binop_of(func: &FunctionSsa, v: ValueId, op: BinOp, l: i64, r: i64) -> Option<i64> {
    if crate::c5::ir::is_fp_comparison_op(op) {
        return fold_fp_compare(func, v, op, l, r);
    }
    if super::narrow::is_narrow_div(func, v) {
        return super::narrow::fold_div32(op, l, r);
    }
    super::narrow::fold_at_width(op, l, r, super::narrow::is_cmp32(&func.cmp32, v))
}

/// A floating comparison `v` of the constants `l` and `r`, at the
/// operands' precision: with neither a NaN it raises no exception (IEEE
/// 754 5.11), so its result is fixed.
fn fold_fp_compare(func: &FunctionSsa, v: ValueId, op: BinOp, l: i64, r: i64) -> Option<i64> {
    let Inst::Binop { lhs, .. } = *func.insts.get(v as usize)? else {
        return None;
    };
    let single = func.f32_values.get(lhs as usize).copied().unwrap_or(false);
    let value = |bits: i64| {
        if single {
            f64::from(f32::from_bits(bits as u32))
        } else {
            f64::from_bits(bits as u64)
        }
    };
    let (a, b) = (value(l), value(r));
    if a.is_nan() || b.is_nan() {
        return None;
    }
    let holds = match crate::c5::ir::fp_relation(op) {
        BinOp::Feq => a == b,
        BinOp::Fne | BinOp::Fone => a != b,
        BinOp::Flt => a < b,
        BinOp::Fgt => a > b,
        BinOp::Fle => a <= b,
        BinOp::Fge => a >= b,
        BinOp::Funo => false,
        _ => return None,
    };
    Some(i64::from(holds))
}

/// Node budget for one per-incoming evaluation. A shared operand is
/// re-evaluated per use, so the budget caps a wide expression tree
/// rather than its depth alone; it also terminates the recursion.
const SELECT_EVAL_BUDGET: u32 = 96;

/// Evaluate `v` with `pivot` bound to `bind`, over the same integer
/// `Extend` / `Bswap` / `BitCount` / `BinopI` / `Binop` set [`fold_round`]
/// folds. Any other def, and any operand the shared resolver cannot pin to
/// an integer immediate, makes the value unknown.
fn eval_with(
    func: &FunctionSsa,
    v: ValueId,
    pivot: ValueId,
    bind: i64,
    budget: &mut u32,
) -> Option<i64> {
    *budget = budget.checked_sub(1)?;
    if v == pivot {
        return Some(bind);
    }
    if let Some(k) = imm_of(func, v) {
        return Some(k);
    }
    if matches!(func.f32_values.get(v as usize), Some(true)) {
        return None;
    }
    match *func.insts.get(v as usize)? {
        Inst::Extend { value, kind, .. } => Some(eval::eval_extend(
            eval_with(func, value, pivot, bind, budget)?,
            kind,
        )),
        Inst::Bswap { value, width } => Some(eval::eval_bswap(
            eval_with(func, value, pivot, bind, budget)?,
            width,
        )),
        Inst::BitCount { op, value, width } => Some(eval::eval_bit_count(
            op,
            eval_with(func, value, pivot, bind, budget)?,
            width,
        )),
        Inst::BinopI { op, lhs, rhs_imm } => fold_binop_of(
            func,
            v,
            op,
            eval_with(func, lhs, pivot, bind, budget)?,
            rhs_imm,
        ),
        Inst::Binop { op, lhs, rhs } => {
            let l = eval_with(func, lhs, pivot, bind, budget)?;
            let r = eval_with(func, rhs, pivot, bind, budget)?;
            fold_binop_of(func, v, op, l, r)
        }
        _ => None,
    }
}

/// Nesting budget and value-set cap for [`select_values`]. Nested `?:`
/// merges a phi into a phi, so the walk crosses a few levels; the cap
/// bounds the per-consumer evaluation count. The budget also terminates
/// the walk over a loop phi, which reaches itself.
const SELECT_SET_DEPTH: u32 = 4;
const SELECT_SET_MAX: usize = 8;

/// Accumulate the distinct integer constants `v` can produce: an
/// immediate, or the union over a phi's incomings. False when any
/// incoming is not one of those, when the set exceeds the cap, or on an
/// FP-kind phi, whose incomings are bit patterns the integer evaluator
/// must not compute on.
fn collect_select_values(func: &FunctionSsa, v: ValueId, depth: u32, out: &mut Vec<i64>) -> bool {
    if let Some(k) = imm_of(func, v) {
        if !out.contains(&k) {
            out.push(k);
        }
        return out.len() <= SELECT_SET_MAX;
    }
    let Some(Inst::Phi { incoming, kind }) = func.insts.get(v as usize) else {
        return false;
    };
    if matches!(kind, LoadKind::F32 | LoadKind::F64) || depth == 0 {
        return false;
    }
    incoming
        .iter()
        .all(|&(_, iv)| collect_select_values(func, iv, depth - 1, out))
}

/// The set of integer constants a phi can produce, when it can produce
/// more than one. An all-agreeing phi resolves through [`imm_of`]
/// already, so it is left to [`fold_round`].
fn select_values(func: &FunctionSsa, v: ValueId) -> Option<Vec<i64>> {
    if !matches!(func.insts.get(v as usize), Some(Inst::Phi { .. })) {
        return None;
    }
    let mut values = Vec::new();
    if !collect_select_values(func, v, SELECT_SET_DEPTH, &mut values) {
        return None;
    }
    (values.len() > 1).then_some(values)
}

/// Per-value list of the instruction indices that read it. Terminator
/// and `exit_acc` references are left out: neither is a foldable
/// consumer.
fn user_lists(func: &FunctionSsa) -> Vec<Vec<ValueId>> {
    let mut users: Vec<Vec<ValueId>> = vec![Vec::new(); func.insts.len()];
    for (i, inst) in func.insts.iter().enumerate() {
        for_each_operand(inst, |op| {
            if let Some(slot) = users.get_mut(op as usize) {
                slot.push(i as ValueId);
            }
        });
    }
    users
}

/// Fold a consumer of a select whose result is the same for every value
/// the select can produce: `> 3ul` on a `c ? 1 : 0` is 0 either way, and
/// so is a mask selecting none of the bits the incomings set. The
/// condition stays unknown; the consumer does not depend on it. Walks
/// forward from each select, so the cost tracks its use chain and a
/// consumer folds at any distance down it -- an intermediate whose own
/// value differs per incoming is walked through, not folded.
///
/// -O only: such a value is not a constant expression (C99 6.6), so this
/// is the optimizer proving the consumer invariant, never the front end
/// widening what it accepts.
pub(crate) fn fold_selects(func: &mut FunctionSsa) -> bool {
    let selects: Vec<(ValueId, Vec<i64>)> = (0..func.insts.len() as ValueId)
        .filter_map(|v| select_values(func, v).map(|values| (v, values)))
        .collect();
    if selects.is_empty() {
        return false;
    }
    let users = user_lists(func);
    // Per-walk visited marks, stamped with the walk's index so the reset
    // between selects is free rather than a scan of the whole tape.
    let mut seen = vec![0u32; func.insts.len()];
    let mut queue: Vec<ValueId> = Vec::new();
    let mut changed = false;
    for (walk, (pivot, values)) in selects.iter().enumerate() {
        let stamp = walk as u32 + 1;
        queue.clear();
        queue.extend_from_slice(&users[*pivot as usize]);
        while let Some(u) = queue.pop() {
            if core::mem::replace(&mut seen[u as usize], stamp) == stamp {
                continue;
            }
            if !matches!(
                func.insts[u as usize],
                Inst::Extend { .. }
                    | Inst::Bswap { .. }
                    | Inst::BitCount { .. }
                    | Inst::BinopI { .. }
                    | Inst::Binop { .. }
            ) {
                continue;
            }
            if !matches!(func.f32_values.get(u as usize), Some(true)) {
                let mut uniform = None;
                for &bind in values {
                    let mut budget = SELECT_EVAL_BUDGET;
                    match eval_with(func, u, *pivot, bind, &mut budget) {
                        Some(k) if uniform.is_none_or(|prev| prev == k) => uniform = Some(k),
                        _ => {
                            uniform = None;
                            break;
                        }
                    }
                }
                if let Some(k) = uniform {
                    func.insts[u as usize] = Inst::Imm(k);
                    changed = true;
                }
            }
            queue.extend_from_slice(&users[u as usize]);
        }
    }
    changed
}

/// Program-level facts for deciding that a symbol address is non-null:
/// the referent must be defined in this unit and not weak. An undefined
/// symbol may bind to address zero (a weak reference by ELF rule, any
/// extern under a model that places objects at absolute addresses), and
/// a weak definition is preemptible, so both stay out.
pub(crate) struct AddrFacts {
    /// Parser-symbol indices with a non-weak definition in this unit.
    nonnull_syms: BTreeSet<u32>,
    /// Entry PCs of non-weak functions defined in this unit. An extern
    /// function referenced by address carries a placeholder ent_pc with
    /// no body, so membership -- not the extern-ref table -- is what
    /// separates the two.
    nonnull_code_pcs: BTreeSet<usize>,
    /// Data-segment `[lo, hi)` ranges of weak definitions; an `ImmData`
    /// offset inside one is preemptible storage.
    weak_data: Vec<(i64, i64)>,
    /// As `weak_data`, for the TLS block.
    weak_tls: Vec<(i64, i64)>,
}

pub(crate) fn addr_facts(program: &crate::c5::program::Program) -> AddrFacts {
    use crate::c5::token::Token;
    let mut facts = AddrFacts {
        nonnull_syms: BTreeSet::new(),
        nonnull_code_pcs: BTreeSet::new(),
        weak_data: Vec::new(),
        weak_tls: Vec::new(),
    };
    for (i, s) in program.symbols.iter().enumerate() {
        if !s.defined_here {
            continue;
        }
        if !s.is_weak {
            facts.nonnull_syms.insert(i as u32);
            if s.class == Token::Fun as i64 {
                facts.nonnull_code_pcs.insert(s.val as usize);
            }
        } else if s.class == Token::Glo as i64 && s.reserved_data_bytes > 0 {
            let range = (s.val, s.val + s.reserved_data_bytes);
            if s.is_thread_local {
                facts.weak_tls.push(range);
            } else {
                facts.weak_data.push(range);
            }
        }
    }
    facts
}

/// Whether `v` produces an address that cannot compare equal to a null
/// pointer constant (C99 6.3.2.3p3, 6.5.9p6): a local slot, a block
/// address, an import stub, or a code / data / TLS address whose
/// referent has a non-weak definition in this unit per [`AddrFacts`]. A
/// displacement chain on such a base is not walked through: the IR does
/// not distinguish pointer arithmetic (in-bounds by C99 6.5.6p8) from
/// integer arithmetic on a converted address, and the latter may wrap
/// to zero.
fn is_nonnull_addr(
    func: &FunctionSsa,
    extern_syms: &BTreeMap<u32, u32>,
    facts: &AddrFacts,
    v: ValueId,
) -> bool {
    // An extern-resolved instruction is judged by its symbol; its
    // payload is a placeholder.
    if let Some(sym) = extern_syms.get(&v) {
        return facts.nonnull_syms.contains(sym);
    }
    let outside =
        |ranges: &[(i64, i64)], off: i64| !ranges.iter().any(|&(lo, hi)| off >= lo && off < hi);
    match func.insts.get(v as usize) {
        Some(Inst::ImmCode(pc)) => facts.nonnull_code_pcs.contains(pc),
        Some(Inst::ImmData(off)) => outside(&facts.weak_data, *off),
        Some(Inst::TlsAddr(off)) => outside(&facts.weak_tls, *off),
        Some(Inst::ImmExtCode(_) | Inst::LocalAddr(_) | Inst::BlockAddr(_)) => true,
        _ => false,
    }
}

/// The identity of an address-constant producer, for deciding that two
/// SSA values denote the same link-time address. Extern-resolved
/// instructions are keyed by their parser symbol: their payload is a
/// placeholder, and the first function's entry PC is also 0, so the
/// payload alone cannot distinguish them.
#[derive(PartialEq, Eq)]
enum AddrIdent {
    Code(usize),
    Data(i64),
    Tls(i64),
    ExtCode(i64),
    Local(i64),
    ExternSym(u32),
}

fn addr_ident(
    func: &FunctionSsa,
    extern_syms: &BTreeMap<u32, u32>,
    v: ValueId,
) -> Option<AddrIdent> {
    if let Some(&sym) = extern_syms.get(&v) {
        return Some(AddrIdent::ExternSym(sym));
    }
    Some(match func.insts.get(v as usize)? {
        Inst::ImmCode(pc) => AddrIdent::Code(*pc),
        Inst::ImmData(off) => AddrIdent::Data(*off),
        Inst::TlsAddr(off) => AddrIdent::Tls(*off),
        Inst::ImmExtCode(idx) => AddrIdent::ExtCode(*idx),
        Inst::LocalAddr(slot) => AddrIdent::Local(*slot),
        _ => return None,
    })
}

/// Fold the comparisons a compile-time assertion on a symbol address
/// reduces to, so the branch fold can drop the arm that calls the
/// assertion's never-defined helper:
///
///   * `addr == 0` / `addr != 0` where `addr` is non-null per
///     [`is_nonnull_addr`];
///   * `a OP b` where both operands resolve to the same value or to
///     the same address constant (C99 6.5.9p6: pointers to the same
///     object or function compare equal) -- the shape inlining leaves
///     when a call site passes the same function the callee compares
///     its parameter against, one operand spliced from the caller and
///     one from the callee.
///
/// -O only: an address is not a constant expression (C99 6.6), so this
/// is the optimizer proving the comparison invariant.
pub(crate) fn fold_addr_compares(func: &mut FunctionSsa, facts: &AddrFacts) -> bool {
    let extern_syms: BTreeMap<u32, u32> = func
        .extern_imm_code_refs
        .iter()
        .chain(&func.extern_imm_data_refs)
        .chain(&func.extern_tls_refs)
        .copied()
        .collect();
    let mut changed = false;
    for idx in 0..func.insts.len() {
        let folded = match &func.insts[idx] {
            Inst::BinopI {
                op: op @ (BinOp::Eq | BinOp::Ne),
                lhs,
                rhs_imm: 0,
            } if is_nonnull_addr(func, &extern_syms, facts, *lhs) => {
                Some(i64::from(*op == BinOp::Ne))
            }
            Inst::Binop { op, lhs, rhs } => same_operand_compare(*op).filter(|_| {
                let (l, r) = (*lhs, *rhs);
                l == r
                    || matches!(
                        (
                            addr_ident(func, &extern_syms, l),
                            addr_ident(func, &extern_syms, r),
                        ),
                        (Some(a), Some(b)) if a == b
                    )
            }),
            _ => None,
        };
        if let Some(k) = folded {
            func.insts[idx] = Inst::Imm(k);
            changed = true;
        }
    }
    changed
}

/// Resolve every remaining deferred `__builtin_constant_p` to 0 and
/// `__builtin_object_size` to its type's fallback. Called once the
/// branch-fold fixed point stalls: no later pass discovers new constants or
/// objects, so an operand not resolved by now never is.
pub(crate) fn resolve_constant_p(func: &mut FunctionSsa) -> bool {
    use crate::c5::op::Intrinsic;
    let mut changed = false;
    for i in 0..func.insts.len() {
        let answer = match &func.insts[i] {
            Inst::Intrinsic { kind, .. } if *kind == Intrinsic::ConstantP as i64 => Inst::Imm(0),
            Inst::Intrinsic { kind, args } if *kind == Intrinsic::ObjectSize as i64 => {
                let ty = args.get(1).and_then(|&t| imm_of(func, t)).unwrap_or(0);
                Inst::Imm(crate::c5::compiler::object_size_fallback(ty))
            }
            // A subobject bound no query is left to read is its pointer, and
            // a builtin's argument no fold took is the argument.
            Inst::Intrinsic { kind, args }
                if *kind == Intrinsic::SubobjectBound as i64
                    || *kind == Intrinsic::BuiltinArg as i64 =>
            {
                Inst::Copy {
                    value: args[0],
                    is_fp: false,
                }
            }
            _ => continue,
        };
        func.insts[i] = answer;
        changed = true;
    }
    changed
}

/// Ops both per-arch emitters lower in `BinopI` form. The x86_64
/// `emit_binop_imm` panics on Div / Divu / Mod / Modu; the aarch64
/// one bails on Mod / Modu (no third scratch register). FP ops keep
/// register operands. Everything else has an immediate-form arm in
/// both emitters.
fn binopi_safe(op: BinOp) -> bool {
    matches!(
        op,
        BinOp::Add
            | BinOp::Sub
            | BinOp::Mul
            | BinOp::And
            | BinOp::Or
            | BinOp::Xor
            | BinOp::Shl
            | BinOp::Shr
            | BinOp::Shru
            | BinOp::Ror
            | BinOp::Ror32
            | BinOp::Eq
            | BinOp::Ne
            | BinOp::Lt
            | BinOp::Gt
            | BinOp::Le
            | BinOp::Ge
            | BinOp::Ult
            | BinOp::Ugt
            | BinOp::Ule
            | BinOp::Uge
    )
}

/// Whether `op` with immediate `imm` encodes in both per-arch
/// emitters without a per-use scratch materialization of the
/// immediate. Derived from the two `emit_binop_imm` peephole sets:
/// shifts embed a 6-bit count, add/sub take imm12 (aarch64) / imm32
/// (x86_64), compares cmp-imm12 / cmp-imm32, mul lowers to a
/// shift-by-log2; `And 0xffffffff` and `Xor -1` have dedicated
/// single-instruction forms. Anything else loads the immediate into
/// a scratch register at every use, so rewriting a shared immediate
/// operand would duplicate its materialization.
fn imm_encodes_free(op: BinOp, imm: i64) -> bool {
    match op {
        BinOp::Shl | BinOp::Shr | BinOp::Shru | BinOp::Ror => (0..64).contains(&imm),
        BinOp::Ror32 => (0..32).contains(&imm),
        BinOp::Add | BinOp::Sub => imm.unsigned_abs() < 4096,
        BinOp::Mul => imm > 0 && (imm as u64).is_power_of_two(),
        BinOp::And => imm == 0xffff_ffff,
        BinOp::Xor => imm == -1,
        BinOp::Eq
        | BinOp::Ne
        | BinOp::Lt
        | BinOp::Gt
        | BinOp::Le
        | BinOp::Ge
        | BinOp::Ult
        | BinOp::Ugt
        | BinOp::Ule
        | BinOp::Uge => (0..4096).contains(&imm),
        _ => false,
    }
}

/// `x OP x` for the integer comparisons: reflexive ops yield 1, the
/// strict ones 0 (C99 6.5.8p6, 6.5.9). These opcodes never carry
/// floating operands -- the FP comparisons are the separate `Feq` /
/// `Flt` / ... family -- so the NaN caveat does not arise.
fn same_operand_compare(op: BinOp) -> Option<i64> {
    Some(match op {
        BinOp::Eq | BinOp::Le | BinOp::Ge | BinOp::Ule | BinOp::Uge => 1,
        BinOp::Ne | BinOp::Lt | BinOp::Gt | BinOp::Ult | BinOp::Ugt => 0,
        _ => return None,
    })
}

/// `imm OP x` recast as `x OP' imm`: the op itself for commutative
/// ops, the mirrored comparison for ordered compares. `None` for the
/// non-commutative rest (Sub, shifts, division, FP).
pub(crate) fn mirror(op: BinOp) -> Option<BinOp> {
    Some(match op {
        BinOp::Add | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor | BinOp::Eq | BinOp::Ne => op,
        BinOp::Lt => BinOp::Gt,
        BinOp::Gt => BinOp::Lt,
        BinOp::Le => BinOp::Ge,
        BinOp::Ge => BinOp::Le,
        BinOp::Ult => BinOp::Ugt,
        BinOp::Ugt => BinOp::Ult,
        BinOp::Ule => BinOp::Uge,
        BinOp::Uge => BinOp::Ule,
        _ => return None,
    })
}

/// Resolve `v` to its integer constant when its def is a plain
/// `Inst::Imm` not flagged f32. Out-of-range ids (`NO_VALUE`) and
/// address-bearing immediates resolve to `None`.
fn imm_of(func: &FunctionSsa, v: ValueId) -> Option<i64> {
    imm_through_phis(&func.insts, &func.f32_values, v)
}

/// The constant operand `v` of `op`: a floating comparison reads one of
/// either precision, which [`fold_fp_compare`] tells apart.
fn operand_imm(func: &FunctionSsa, op: BinOp, v: ValueId) -> Option<i64> {
    if crate::c5::ir::is_fp_comparison_op(op) {
        imm_through_phis(&func.insts, &[], v)
    } else {
        imm_of(func, v)
    }
}

/// Recursion budget for the multi-incoming phi merge. Each level
/// multiplies by the operand count, so the bound keeps the walk cheap
/// while still crossing the few merges a folded control-flow chain
/// stacks up.
const PHI_MERGE_DEPTH: u32 = 4;

/// Shared constant resolver: names an `Inst::Imm`, or reaches one
/// through phis. An empty `f32_values` accepts every `Imm`, for callers
/// with no float-immediate distinction to make.
pub(super) fn imm_through_phis(insts: &[Inst], f32_values: &[bool], v: ValueId) -> Option<i64> {
    imm_through_phis_depth(insts, f32_values, v, PHI_MERGE_DEPTH)
}

fn imm_through_phis_depth(
    insts: &[Inst],
    f32_values: &[bool],
    v: ValueId,
    depth: u32,
) -> Option<i64> {
    match insts.get(v as usize)? {
        Inst::Imm(k) if !matches!(f32_values.get(v as usize), Some(true)) => Some(*k),
        // An instruction reads an indeterminate value as the zero the
        // allocation places for it.
        Inst::Undef if !matches!(f32_values.get(v as usize), Some(true)) => Some(0),
        // Every predecessor supplying the same constant makes the merge
        // that constant, whichever edge is taken. A `&&` / `||` whose
        // arms decide the same way reaches the fold in this shape, as
        // does any merge of equal constants an inline exposed, and a
        // merge a pruned branch left with one predecessor. An
        // indeterminate income may be any value, so it takes the one the
        // others agree on. The depth bound also terminates a loop phi,
        // whose back edge reaches itself.
        Inst::Phi { incoming, .. } => {
            if depth == 0 {
                return None;
            }
            let mut agreed = None;
            for &(_, v) in incoming {
                if matches!(insts.get(v as usize), Some(Inst::Undef)) {
                    continue;
                }
                let k = imm_through_phis_depth(insts, f32_values, v, depth - 1)?;
                if agreed.is_some_and(|a| a != k) {
                    return None;
                }
                agreed = Some(k);
            }
            agreed
        }
        _ => None,
    }
}

/// Operand-reference counts, including terminator conditions and the
/// per-block `exit_acc`. Counts taken at round start over-approximate
/// after in-round rewrites drop references, which only defers a
/// single-use rewrite to the next round.
fn count_uses(func: &FunctionSsa) -> Vec<u32> {
    let n = func.insts.len();
    let mut counts = vec![0u32; n];
    let bump = |counts: &mut Vec<u32>, v: ValueId| {
        if v != NO_VALUE && (v as usize) < n {
            counts[v as usize] += 1;
        }
    };
    for inst in &func.insts {
        for_each_operand(inst, |op| bump(&mut counts, op));
        if let Inst::CallIndirect { target, .. } = inst {
            bump(&mut counts, *target);
        }
    }
    for block in &func.blocks {
        match block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => bump(&mut counts, cond),
            Terminator::Return(v) => bump(&mut counts, v),
            Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. } => {
                bump(&mut counts, target)
            }
            _ => {}
        }
        bump(&mut counts, block.exit_acc);
    }
    counts
}

/// Whether an `And` by `mask` leaves every bit a `width`-byte reversal or
/// count reads (the low `width * 8`) unchanged.
fn low_mask_transparent(mask: i64, width: u8) -> bool {
    match width {
        2 => mask & 0xffff == 0xffff,
        4 => mask & 0xffff_ffff == 0xffff_ffff,
        _ => mask == -1,
    }
}

/// The constant an `Or` sets its bits with, when `v` is that `Or`.
fn or_imm(func: &FunctionSsa, v: ValueId) -> Option<i64> {
    match func.insts.get(v as usize)? {
        Inst::BinopI {
            op: BinOp::Or,
            rhs_imm,
            ..
        } => Some(*rhs_imm),
        _ => None,
    }
}

/// The value an `And` masks, when `v` is that `And` and its mask keeps
/// every bit a left shift by `k` keeps (bits `0..=63 - k`).
fn masked_before_shl(func: &FunctionSsa, v: ValueId, k: i64) -> Option<ValueId> {
    let Some(&Inst::BinopI {
        op: BinOp::And,
        lhs,
        rhs_imm,
    }) = func.insts.get(v as usize)
    else {
        return None;
    };
    let kept = u64::MAX.checked_shr(u32::try_from(k).ok()?)?;
    ((1..64).contains(&k) && rhs_imm as u64 & kept == kept).then_some(lhs)
}

/// The bits a conversion of the constant `k` gives (C99 6.3.1.4, 6.3.1.5),
/// rounded once to nearest as the default floating environment does.
/// `src_f32` / `dst_f32` say the operand / result is a `float`, held in the
/// low word. A NaN keeps its runtime conversion, which quiets a signaling
/// one, and so does a value out of the integer range, whose conversion is
/// undefined.
fn eval_fp_cast(kind: FpCastKind, k: i64, src_f32: bool, dst_f32: bool) -> Option<i64> {
    const TWO_63: f64 = 9_223_372_036_854_775_808.0;
    let real = || {
        let x = if src_f32 {
            f64::from(f32::from_bits(k as u32))
        } else {
            f64::from_bits(k as u64)
        };
        (!x.is_nan()).then_some(x)
    };
    let float = |x: f32| i64::from(x.to_bits());
    let double = |x: f64| x.to_bits() as i64;
    Some(match kind {
        FpCastKind::F32ToF64 if src_f32 && !dst_f32 => double(real()?),
        FpCastKind::F64ToF32 if !src_f32 && dst_f32 => float(real()? as f32),
        FpCastKind::FpBits | FpCastKind::BitsFp if !src_f32 && !dst_f32 => k,
        FpCastKind::IntToFp if !src_f32 && dst_f32 => float(k as f32),
        FpCastKind::IntToFp if !src_f32 => double(k as f64),
        FpCastKind::UIntToFp if !src_f32 && dst_f32 => float(k as u64 as f32),
        FpCastKind::UIntToFp if !src_f32 => double(k as u64 as f64),
        // `as` truncates toward zero, which in range is the C conversion.
        FpCastKind::FpToInt if !dst_f32 => real().filter(|x| (-TWO_63..TWO_63).contains(x))? as i64,
        FpCastKind::UFpToInt if !dst_f32 => {
            real().filter(|&x| x > -1.0 && x < 2.0 * TWO_63)? as u64 as i64
        }
        _ => return None,
    })
}

/// The bits an arithmetic operation on the constants `l` and `r` gives
/// (C99 6.5.5, 6.5.6), rounded once to nearest as the default floating
/// environment does; `f32` says the operands and the result are `float`s.
/// A NaN operand or result keeps its runtime operation, whose NaN the
/// target's unit chooses.
fn eval_fp_binop(op: BinOp, l: i64, r: i64, f32: bool) -> Option<i64> {
    fn arith<T>(op: BinOp, a: T, b: T) -> Option<T>
    where
        T: core::ops::Add<Output = T>
            + core::ops::Sub<Output = T>
            + core::ops::Mul<Output = T>
            + core::ops::Div<Output = T>,
    {
        Some(match op {
            BinOp::Fadd => a + b,
            BinOp::Fsub => a - b,
            BinOp::Fmul | BinOp::FmulContractible => a * b,
            BinOp::Fdiv => a / b,
            _ => return None,
        })
    }
    if f32 {
        let (a, b) = (f32::from_bits(l as u32), f32::from_bits(r as u32));
        let x = arith(op, a, b)?;
        (!a.is_nan() && !b.is_nan() && !x.is_nan()).then(|| i64::from(x.to_bits()))
    } else {
        let (a, b) = (f64::from_bits(l as u64), f64::from_bits(r as u64));
        let x = arith(op, a, b)?;
        (!a.is_nan() && !b.is_nan() && !x.is_nan()).then(|| x.to_bits() as i64)
    }
}

fn fold_round(func: &mut FunctionSsa) -> bool {
    let uses = count_uses(func);
    // A shared immediate operand only moves into the instruction when
    // the encoding is materialization-free; a sole use may always
    // move (the per-use materialization replaces the def's).
    let to_imm_form = |op: BinOp, value_id: ValueId, imm: i64| -> bool {
        binopi_safe(op)
            && (imm_encodes_free(op, imm) || uses.get(value_id as usize).copied().unwrap_or(0) == 1)
    };
    let mut changed = false;
    for idx in 0..func.insts.len() {
        let f32 = |v: usize| matches!(func.f32_values.get(v), Some(true));
        // IEEE 754 negation flips the sign bit, exactly for every value;
        // an f32 `Imm` holds its pattern in the low word.
        if let Inst::Fneg(src) = func.insts[idx]
            && let Some(&Inst::Imm(k)) = func.insts.get(src as usize)
            && f32(idx) == f32(src as usize)
        {
            func.insts[idx] = Inst::Imm(k ^ if f32(idx) { 0x8000_0000 } else { i64::MIN });
            changed = true;
            continue;
        }
        if let Inst::FpCast { kind, value } = func.insts[idx]
            && let Some(&Inst::Imm(k)) = func.insts.get(value as usize)
            && let Some(folded) = eval_fp_cast(kind, k, f32(value as usize), f32(idx))
        {
            func.insts[idx] = Inst::Imm(folded);
            changed = true;
            continue;
        }
        if let Inst::Binop { op, lhs, rhs } = func.insts[idx]
            && let Some(&Inst::Imm(l)) = func.insts.get(lhs as usize)
            && let Some(&Inst::Imm(r)) = func.insts.get(rhs as usize)
            && f32(lhs as usize) == f32(idx)
            && f32(rhs as usize) == f32(idx)
            && let Some(folded) = eval_fp_binop(op, l, r, f32(idx))
        {
            func.insts[idx] = Inst::Imm(folded);
            changed = true;
            continue;
        }
        if f32(idx) {
            continue;
        }
        let new_inst = match &func.insts[idx] {
            // An extend reads the low bits of its operand, which an `Or`
            // with all of them set fixes.
            Inst::Extend { value, kind, .. } => imm_of(func, *value)
                .or_else(|| {
                    or_imm(func, *value)
                        .filter(|&k| eval::eval_extend(k, *kind) == eval::eval_extend(-1, *kind))
                })
                .map(|k| Inst::Imm(eval::eval_extend(k, *kind))),
            Inst::Udiv128 { hi, lo, divisor } => {
                match (imm_of(func, *hi), imm_of(func, *lo), imm_of(func, *divisor)) {
                    (Some(h), Some(l), Some(d)) => eval::udiv128(h, l, d).map(Inst::Imm),
                    _ => None,
                }
            }
            Inst::Bswap { value, width } => match imm_of(func, *value) {
                Some(k) => Some(Inst::Imm(eval::eval_bswap(k, *width))),
                // The reversal reads only the low `width` bytes, so a
                // mask that keeps those bytes intact (the walker's
                // conversion to the operation's unsigned width) is
                // transparent to it.
                None => match func.insts.get(*value as usize) {
                    Some(Inst::BinopI {
                        op: BinOp::And,
                        lhs,
                        rhs_imm,
                    }) if low_mask_transparent(*rhs_imm, *width) => Some(Inst::Bswap {
                        value: *lhs,
                        width: *width,
                    }),
                    _ => None,
                },
            },
            Inst::BitCount { op, value, width } => match imm_of(func, *value) {
                Some(k) => Some(Inst::Imm(eval::eval_bit_count(*op, k, *width))),
                None => match func.insts.get(*value as usize) {
                    Some(Inst::BinopI {
                        op: BinOp::And,
                        lhs,
                        rhs_imm,
                    }) if low_mask_transparent(*rhs_imm, *width) => Some(Inst::BitCount {
                        op: *op,
                        value: *lhs,
                        width: *width,
                    }),
                    _ => None,
                },
            },
            Inst::Neg(value) => imm_of(func, *value).map(|k| Inst::Imm(k.wrapping_neg())),
            // `a + -b` is `a - b` and `a - -b` is `a + b`, exact modulo
            // 2^64 either way; the negate goes dead when this was its
            // only use.
            Inst::Binop {
                op: op @ (BinOp::Add | BinOp::Sub),
                lhs,
                rhs,
            } if negated_value(func, *rhs).is_some() => {
                negated_value(func, *rhs).map(|x| Inst::Binop {
                    op: if *op == BinOp::Add {
                        BinOp::Sub
                    } else {
                        BinOp::Add
                    },
                    lhs: *lhs,
                    rhs: x,
                })
            }
            Inst::Binop {
                op: BinOp::Add,
                lhs,
                rhs,
            } if negated_value(func, *lhs).is_some() => {
                negated_value(func, *lhs).map(|x| Inst::Binop {
                    op: BinOp::Sub,
                    lhs: *rhs,
                    rhs: x,
                })
            }
            // `-x - 1` is `~x` for every two's-complement value.
            Inst::BinopI {
                op: BinOp::Add,
                lhs,
                rhs_imm: -1,
            }
            | Inst::BinopI {
                op: BinOp::Sub,
                lhs,
                rhs_imm: 1,
            } if negated_value(func, *lhs).is_some() => {
                negated_value(func, *lhs).map(|x| Inst::BinopI {
                    op: BinOp::Xor,
                    lhs: x,
                    rhs_imm: -1,
                })
            }
            // `x * -1` is `-x` and `0 - x` is `-x`, for every value:
            // two's-complement multiply and subtract are exact modulo
            // 2^64, and so is the negate they become.
            Inst::BinopI {
                op: BinOp::Mul,
                lhs,
                rhs_imm: -1,
            } => Some(Inst::Neg(*lhs)),
            Inst::Binop {
                op: BinOp::Mul,
                lhs,
                rhs,
            } if imm_of(func, *rhs) == Some(-1) && imm_of(func, *lhs).is_none() => {
                Some(Inst::Neg(*lhs))
            }
            Inst::Binop {
                op: BinOp::Mul,
                lhs,
                rhs,
            } if imm_of(func, *lhs) == Some(-1) && imm_of(func, *rhs).is_none() => {
                Some(Inst::Neg(*rhs))
            }
            Inst::Binop {
                op: BinOp::Sub,
                lhs,
                rhs,
            } if imm_of(func, *lhs) == Some(0) && imm_of(func, *rhs).is_none() => {
                Some(Inst::Neg(*rhs))
            }
            // All ones absorb an `Or`, and an `Or` that sets every bit of
            // a mask fixes the masked value.
            Inst::BinopI {
                op: BinOp::Or,
                rhs_imm: -1,
                ..
            } => Some(Inst::Imm(-1)),
            Inst::Binop {
                op: BinOp::Or,
                lhs,
                rhs,
            } if imm_of(func, *lhs) == Some(-1) || imm_of(func, *rhs) == Some(-1) => {
                Some(Inst::Imm(-1))
            }
            Inst::BinopI {
                op: BinOp::And,
                lhs,
                rhs_imm,
            } if or_imm(func, *lhs).is_some_and(|k| rhs_imm & !k == 0) => Some(Inst::Imm(*rhs_imm)),
            // A value less itself, or exclusive-ored with itself, is zero.
            Inst::Binop {
                op: BinOp::Sub | BinOp::Xor,
                lhs,
                rhs,
            } if lhs == rhs => Some(Inst::Imm(0)),
            // No value is below zero unsigned.
            Inst::BinopI {
                op: op @ (BinOp::Ult | BinOp::Uge),
                rhs_imm: 0,
                ..
            } => Some(Inst::Imm(i64::from(*op == BinOp::Uge))),
            // The shift discards every bit the mask clears.
            Inst::BinopI {
                op: BinOp::Shl,
                lhs,
                rhs_imm,
            } if masked_before_shl(func, *lhs, *rhs_imm).is_some() => {
                masked_before_shl(func, *lhs, *rhs_imm).map(|x| Inst::BinopI {
                    op: BinOp::Shl,
                    lhs: x,
                    rhs_imm: *rhs_imm,
                })
            }
            Inst::BinopI { op, lhs, rhs_imm } => imm_of(func, *lhs)
                .and_then(|l| fold_binop_of(func, idx as ValueId, *op, l, *rhs_imm))
                .map(Inst::Imm),
            Inst::Binop { op, lhs, rhs } if lhs == rhs && same_operand_compare(*op).is_some() => {
                same_operand_compare(*op).map(Inst::Imm)
            }
            Inst::Binop { op, lhs, rhs } => {
                match (operand_imm(func, *op, *lhs), operand_imm(func, *op, *rhs)) {
                    (Some(l), Some(r)) => {
                        fold_binop_of(func, idx as ValueId, *op, l, r).map(Inst::Imm)
                    }
                    (None, Some(r)) if to_imm_form(*op, *rhs, r) => Some(Inst::BinopI {
                        op: *op,
                        lhs: *lhs,
                        rhs_imm: r,
                    }),
                    (Some(l), None) => {
                        mirror(*op)
                            .filter(|m| to_imm_form(*m, *lhs, l))
                            .map(|m| Inst::BinopI {
                                op: m,
                                lhs: *rhs,
                                rhs_imm: l,
                            })
                    }
                    _ => None,
                }
            }
            // Deferred `__builtin_constant_p`: the operand folded to an
            // integer immediate, so the answer is 1. `imm_of` refuses
            // address-bearing immediates, which are not constants here.
            // The address-and-width form of a load folds on const data.
            Inst::Intrinsic { kind, args }
                if *kind == crate::c5::op::Intrinsic::ConstantP as i64 && args.len() == 1 =>
            {
                args.first()
                    .and_then(|&a| imm_of(func, a))
                    .map(|_| Inst::Imm(1))
            }
            _ => None,
        };
        if let Some(inst) = new_inst {
            func.insts[idx] = inst;
            changed = true;
        }
    }
    changed
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{Block, LoadKind, Terminator};
    use alloc::vec;
    use alloc::vec::Vec;

    fn fresh(insts: Vec<Inst>) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            seh_scopes: Vec::new(),
            block_seh: Vec::new(),
            funclet_slots: Vec::new(),
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            ssp: crate::c5::ir::SspFacts::default(),
            has_returns_twice_call: false,
            did_unroll: false,
            did_inline: false,
            n_params: 0,
            is_variadic: false,
            is_inline: false,
            is_always_inline: false,
            is_noinline: false,
            is_naked: false,
            is_noreturn: false,
            conv: crate::c5::codegen::CallConv::Target,
            general_regs_only: false,
            tls_dynamic: false,
            section: None,
            patchable_entry: None,
            no_instrument: false,
            no_stack_protector: false,
            is_weak: false,
            is_internal: false,
            const_params: 0,
            inst_src: vec![crate::c5::ir::InstSrc::default(); n],
            f32_values: vec![false; n],
            cmp32: Vec::new(),
            div32: Vec::new(),
            low_word_tests: Vec::new(),
            param_fp_mask: crate::c5::ir::FpMask::EMPTY,
            param_widths: crate::c5::ir::ArgWidths::default(),
            agg_descs: Vec::new(),
            param_aggs: Vec::new(),
            param_local_slots: Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            ret_type_tag: None,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            label_data_relocs: Vec::new(),
            jump_tables: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
            array_slots: Vec::new(),
            vector_objects: Vec::new(),
            owned_params: Vec::new(),
            over_aligned: Default::default(),
            frame_align: 0,
            realign_region_bytes: 0,
            insts,
            blocks: vec![Block {
                start_pc: 0,
                inst_range: 0..n as u32,
                terminator: Terminator::Return(crate::c5::ir::NO_VALUE),
                exit_acc: 0,
            }],
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        }
    }

    #[test]
    fn binop_of_two_imms_folds() {
        let mut f = fresh(vec![
            Inst::Imm(2),
            Inst::Imm(3),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(f.insts[2], Inst::Imm(5)));
    }

    #[test]
    fn chain_through_extend_folds_in_one_run() {
        // Post-inline shape: Imm -> callee-narrows Extend -> shift.
        let mut f = fresh(vec![
            Inst::Imm(0xff),
            Inst::Extend {
                value: 0,
                kind: LoadKind::I8,
                nsw: false,
            },
            Inst::BinopI {
                op: BinOp::Mul,
                lhs: 1,
                rhs_imm: 2,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(f.insts[1], Inst::Imm(-1)));
        assert!(matches!(f.insts[2], Inst::Imm(-2)));
    }

    #[test]
    fn div_mod_by_zero_is_refused() {
        for op in [BinOp::Div, BinOp::Mod, BinOp::Divu, BinOp::Modu] {
            let mut f = fresh(vec![
                Inst::Imm(7),
                Inst::Imm(0),
                Inst::Binop { op, lhs: 0, rhs: 1 },
            ]);
            run_one(&mut f);
            assert!(matches!(f.insts[2], Inst::Binop { .. }), "{op:?}");
        }
    }

    #[test]
    fn min_over_minus_one_is_refused() {
        for op in [BinOp::Div, BinOp::Mod] {
            let mut f = fresh(vec![
                Inst::Imm(i64::MIN),
                Inst::Imm(-1),
                Inst::Binop { op, lhs: 0, rhs: 1 },
            ]);
            run_one(&mut f);
            assert!(matches!(f.insts[2], Inst::Binop { .. }), "{op:?}");
        }
    }

    /// A 128-by-64 division of constants folds where it would not fault.
    #[test]
    fn a_fitting_128_by_64_division_of_constants_folds() {
        for (hi, lo, divisor, want) in [
            (1, 0, 3, Some(0x5555_5555_5555_5555)),
            (0, -1, -1, Some(1)),
            (2, 5, 2, None),
            (0, 7, 0, None),
        ] {
            let mut f = fresh(vec![
                Inst::Imm(hi),
                Inst::Imm(lo),
                Inst::Imm(divisor),
                Inst::Udiv128 {
                    hi: 0,
                    lo: 1,
                    divisor: 2,
                },
            ]);
            run_one(&mut f);
            match want {
                Some(q) => assert!(
                    matches!(f.insts[3], Inst::Imm(k) if k == q),
                    "{:?}",
                    f.insts[3]
                ),
                None => assert!(
                    matches!(f.insts[3], Inst::Udiv128 { .. }),
                    "{:?}",
                    f.insts[3]
                ),
            }
        }
    }

    /// Unsigned, `x < 0` and `x >= 0` are constants, `x <= 0` and `x > 0` not.
    #[test]
    fn an_unsigned_comparison_with_zero_that_cannot_vary_folds() {
        for (op, want) in [
            (BinOp::Ult, Some(0)),
            (BinOp::Uge, Some(1)),
            (BinOp::Ule, None),
            (BinOp::Ugt, None),
        ] {
            let mut f = fresh(vec![
                Inst::LocalAddr(0),
                Inst::BinopI {
                    op,
                    lhs: 0,
                    rhs_imm: 0,
                },
            ]);
            run_one(&mut f);
            match want {
                Some(k) => assert!(
                    matches!(f.insts[1], Inst::Imm(v) if v == k),
                    "{op:?}: {:?}",
                    f.insts[1]
                ),
                None => assert!(
                    matches!(f.insts[1], Inst::BinopI { .. }),
                    "{op:?}: {:?}",
                    f.insts[1]
                ),
            }
        }
    }

    #[test]
    fn an_identity_operation_forwards_its_operand() {
        let forwards = [
            (BinOp::Add, 0),
            (BinOp::Sub, 0),
            (BinOp::Or, 0),
            (BinOp::Xor, 0),
            (BinOp::Shl, 0),
            (BinOp::Shr, 0),
            (BinOp::Shru, 0),
            (BinOp::Mul, 1),
            (BinOp::Div, 1),
            (BinOp::Divu, 1),
            (BinOp::And, -1),
        ];
        let keeps = [
            (BinOp::Add, 1),
            (BinOp::And, 0xffff_ffff),
            (BinOp::Mod, 1),
            (BinOp::Modu, 1),
            (BinOp::Ne, 0),
        ];
        for (op, k, forwarded) in forwards
            .iter()
            .map(|&(op, k)| (op, k, true))
            .chain(keeps.iter().map(|&(op, k)| (op, k, false)))
        {
            let mut f = fresh(vec![
                Inst::LocalAddr(0),
                Inst::BinopI {
                    op,
                    lhs: 0,
                    rhs_imm: k,
                },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 1,
                    rhs_imm: 8,
                },
            ]);
            run_one(&mut f);
            let reads = match f.insts[2] {
                Inst::BinopI { lhs, .. } => lhs,
                ref other => panic!("{other:?}"),
            };
            assert_eq!(reads == 0, forwarded, "{op:?} {k}");
        }
    }

    /// A left shift by `k` reads its operand's low `64 - k` bits, so a mask
    /// that keeps them all is skipped and one that clears one stays.
    #[test]
    fn a_mask_a_left_shift_discards_is_skipped() {
        let run = |mask: i64, k: i64| {
            let mut f = fresh(vec![
                Inst::LocalAddr(0),
                Inst::BinopI {
                    op: BinOp::And,
                    lhs: 0,
                    rhs_imm: mask,
                },
                Inst::BinopI {
                    op: BinOp::Shl,
                    lhs: 1,
                    rhs_imm: k,
                },
            ]);
            run_one(&mut f);
            match f.insts[2] {
                Inst::BinopI {
                    op: BinOp::Shl,
                    lhs,
                    rhs_imm,
                } if rhs_imm == k => lhs,
                ref other => panic!("{other:?}"),
            }
        };
        assert_eq!(run(0x3f_ffff, 42), 0, "22 bits kept by a shift by 42");
        assert_eq!(run(0xff_ffff_ffff, 24), 0, "40 bits kept by a shift by 24");
        // `(unsigned long long)hi << 32`: the zero extension of a 32-bit value.
        assert_eq!(run(0xffff_ffff, 32), 0, "32 bits kept by a shift by 32");
        assert_eq!(run(-2, 63), 1, "bit 0 cleared");
        assert_eq!(run(0x1f_ffff, 42), 1, "bit 21 cleared");
        assert_eq!(run(0x7fff_ffff, 32), 1, "bit 31 cleared");
    }

    /// A negated constant is the constant with its sign bit flipped: bit
    /// 63 of a double, bit 31 of a float's low-word pattern, zero
    /// included. A negation whose width differs from its operand's stays.
    #[test]
    fn negated_constant_flips_its_sign_bit() {
        let run = |bits: i64, f32_src: bool, f32_neg: bool| {
            let mut f = fresh(vec![Inst::Imm(bits), Inst::Fneg(0)]);
            f.f32_values = vec![f32_src, f32_neg];
            run_one(&mut f);
            f.insts[1].clone()
        };
        let neg = |x: f64| (-x).to_bits() as i64;
        assert!(
            matches!(run(2.5f64.to_bits() as i64, false, false), Inst::Imm(k) if k == neg(2.5))
        );
        assert!(matches!(run(0, false, false), Inst::Imm(i64::MIN)));
        let f32_bits = 2.5f32.to_bits() as i64;
        assert!(
            matches!(run(f32_bits, true, true), Inst::Imm(k) if k == (-2.5f32).to_bits() as i64)
        );
        assert!(matches!(run(f32_bits, true, false), Inst::Fneg(0)));
    }

    #[test]
    fn rhs_imm_rewrites_to_binopi_for_safe_ops() {
        let mut f = fresh(vec![
            Inst::LocalAddr(0),
            Inst::Imm(9),
            Inst::Binop {
                op: BinOp::Shru,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(
            f.insts[2],
            Inst::BinopI {
                op: BinOp::Shru,
                lhs: 0,
                rhs_imm: 9,
            }
        ));
    }

    #[test]
    fn div_mod_never_rewrite_to_binopi() {
        // Pins BINOPI_SAFE to the emitters' coverage: the x86_64
        // BinopI arm panics on Div / Divu / Mod / Modu and the
        // aarch64 arm bails on Mod / Modu.
        for op in [BinOp::Div, BinOp::Divu, BinOp::Mod, BinOp::Modu] {
            assert!(!binopi_safe(op), "{op:?}");
            let mut f = fresh(vec![
                Inst::LocalAddr(0),
                Inst::Imm(2),
                Inst::Binop { op, lhs: 0, rhs: 1 },
            ]);
            run_one(&mut f);
            assert!(matches!(f.insts[2], Inst::Binop { .. }), "{op:?}");
        }
        for op in [
            BinOp::Fadd,
            BinOp::Fsub,
            BinOp::Fmul,
            BinOp::Fdiv,
            BinOp::Feq,
            BinOp::Fne,
            BinOp::Flt,
            BinOp::Fgt,
            BinOp::Fle,
            BinOp::Fge,
            BinOp::FltQuiet,
            BinOp::FgtQuiet,
            BinOp::FleQuiet,
            BinOp::FgeQuiet,
            BinOp::Fone,
            BinOp::Funo,
        ] {
            assert!(!binopi_safe(op), "{op:?}");
        }
        for op in [
            BinOp::Add,
            BinOp::Sub,
            BinOp::Mul,
            BinOp::And,
            BinOp::Or,
            BinOp::Xor,
            BinOp::Shl,
            BinOp::Shr,
            BinOp::Shru,
            BinOp::Ror,
            BinOp::Eq,
            BinOp::Ne,
            BinOp::Lt,
            BinOp::Gt,
            BinOp::Le,
            BinOp::Ge,
            BinOp::Ult,
            BinOp::Ugt,
            BinOp::Ule,
            BinOp::Uge,
        ] {
            assert!(binopi_safe(op), "{op:?}");
        }
    }

    #[test]
    fn lhs_imm_commutes_and_mirrors() {
        // 5 + x -> x + 5.
        let mut f = fresh(vec![
            Inst::Imm(5),
            Inst::LocalAddr(0),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(
            f.insts[2],
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 1,
                rhs_imm: 5,
            }
        ));
        // 5 < x -> x > 5.
        let mut f = fresh(vec![
            Inst::Imm(5),
            Inst::LocalAddr(0),
            Inst::Binop {
                op: BinOp::Lt,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(
            f.insts[2],
            Inst::BinopI {
                op: BinOp::Gt,
                lhs: 1,
                rhs_imm: 5,
            }
        ));
        // 5 - x has no rhs-imm form; it must stay put.
        let mut f = fresh(vec![
            Inst::Imm(5),
            Inst::LocalAddr(0),
            Inst::Binop {
                op: BinOp::Sub,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(f.insts[2], Inst::Binop { op: BinOp::Sub, .. }));
    }

    #[test]
    fn f32_flagged_imm_does_not_fold() {
        // An f32 Imm carries the low-32 bit pattern; folding it with
        // the f64-widened evaluator convention would corrupt it.
        let mut f = fresh(vec![
            Inst::Imm(0x3f80_0000),
            Inst::Extend {
                value: 0,
                kind: LoadKind::I32,
                nsw: false,
            },
        ]);
        f.f32_values[0] = true;
        run_one(&mut f);
        assert!(matches!(f.insts[1], Inst::Extend { .. }));
    }

    #[test]
    fn address_imms_do_not_fold() {
        // ImmData is a data-segment offset patched at write time, not
        // an integer constant; it must survive as the BinopI operand.
        let mut f = fresh(vec![
            Inst::ImmData(64),
            Inst::Imm(8),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(f.insts[0], Inst::ImmData(64)));
        assert!(matches!(
            f.insts[2],
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 0,
                rhs_imm: 8,
            }
        ));
    }

    #[test]
    fn shared_wide_imm_keeps_register_form() {
        // A scratch-materialized immediate (Xor with a wide constant)
        // shared by two ops must stay a register operand: rewriting
        // both would duplicate the constant materialization per use.
        let mut f = fresh(vec![
            Inst::LocalAddr(0),
            Inst::Imm(0x0123_4567_89ab_cdef),
            Inst::Binop {
                op: BinOp::Xor,
                lhs: 0,
                rhs: 1,
            },
            Inst::Binop {
                op: BinOp::Xor,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(f.insts[2], Inst::Binop { .. }));
        assert!(matches!(f.insts[3], Inst::Binop { .. }));
    }

    #[test]
    fn single_use_wide_imm_rewrites() {
        let mut f = fresh(vec![
            Inst::LocalAddr(0),
            Inst::Imm(0x0123_4567_89ab_cdef),
            Inst::Binop {
                op: BinOp::Xor,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(
            f.insts[2],
            Inst::BinopI {
                op: BinOp::Xor,
                lhs: 0,
                rhs_imm: 0x0123_4567_89ab_cdef,
            }
        ));
    }

    #[test]
    fn extend_of_imm_folds_per_kind() {
        let mut f = fresh(vec![
            Inst::Imm(0x1_8000),
            Inst::Extend {
                value: 0,
                kind: LoadKind::I16,
                nsw: false,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(f.insts[1], Inst::Imm(-32768)));
    }

    #[test]
    fn an_undefined_phi_income_takes_the_constant_the_others_agree_on() {
        // `int x; if (c) x = 7; return x + 1;`: the edge with no store may
        // carry any value, so the merge is 7. Two disagreeing constants
        // still leave it unknown.
        let merge = |second: Inst| {
            fresh(vec![
                Inst::Undef,
                Inst::Imm(7),
                second,
                Inst::Phi {
                    incoming: vec![(0, 0), (1, 1), (2, 2)],
                    kind: LoadKind::I64,
                },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 3,
                    rhs_imm: 1,
                },
            ])
        };
        let mut f = merge(Inst::Imm(7));
        run_one(&mut f);
        assert!(matches!(f.insts[4], Inst::Imm(8)), "{:?}", f.insts[4]);
        let mut f = merge(Inst::Imm(9));
        run_one(&mut f);
        assert!(matches!(f.insts[4], Inst::BinopI { .. }));
        // A phi none of whose incomes is defined has no value to agree on.
        let all_undef = [
            Inst::Undef,
            Inst::Phi {
                incoming: vec![(0, 0)],
                kind: LoadKind::I64,
            },
        ];
        assert_eq!(imm_through_phis(&all_undef, &[], 1), None);
    }

    #[test]
    fn an_undefined_value_an_instruction_reads_folds_as_zero() {
        // A bit-field store into a fresh object reads its storage unit:
        // `(u & ~3) | 1` over the unread unit is 1.
        let mut f = fresh(vec![
            Inst::Undef,
            Inst::BinopI {
                op: BinOp::And,
                lhs: 0,
                rhs_imm: !3,
            },
            Inst::BinopI {
                op: BinOp::Or,
                lhs: 1,
                rhs_imm: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(f.insts[2], Inst::Imm(1)), "{:?}", f.insts);
    }

    /// `phi(1, 0)` at index 2, with `insts[3..]` as the consumers under test.
    fn with_select(mut consumers: Vec<Inst>) -> FunctionSsa {
        let mut insts = vec![
            Inst::Imm(1),
            Inst::Imm(0),
            Inst::Phi {
                incoming: vec![(0, 0), (1, 1)],
                kind: LoadKind::I64,
            },
        ];
        insts.append(&mut consumers);
        fresh(insts)
    }

    #[test]
    fn select_invariant_comparison_folds() {
        // Both incomings are <= 3, so `ugt 3` is 0 either way. The select
        // itself is left alone: its value does depend on the condition.
        let mut f = with_select(vec![Inst::BinopI {
            op: BinOp::Ugt,
            lhs: 2,
            rhs_imm: 3,
        }]);
        assert!(fold_selects(&mut f));
        assert!(matches!(f.insts[3], Inst::Imm(0)));
        assert!(matches!(f.insts[2], Inst::Phi { .. }));
    }

    #[test]
    fn select_variant_consumer_is_left_alone() {
        // `+ 1` is 2 or 1: the consumer does depend on the condition.
        let mut f = with_select(vec![Inst::BinopI {
            op: BinOp::Add,
            lhs: 2,
            rhs_imm: 1,
        }]);
        assert!(!fold_selects(&mut f));
        assert!(matches!(f.insts[3], Inst::BinopI { .. }));
    }

    #[test]
    fn select_invariant_mask_folds_through_a_variant_chain() {
        // The `or` intermediates differ per incoming (5 / 4), so they are
        // walked through rather than folded; the mask over them selects
        // no bit either can set, so it folds.
        let mut f = with_select(vec![
            Inst::BinopI {
                op: BinOp::Or,
                lhs: 2,
                rhs_imm: 4,
            },
            Inst::BinopI {
                op: BinOp::And,
                lhs: 3,
                rhs_imm: 0x1_8000,
            },
        ]);
        assert!(fold_selects(&mut f));
        assert!(matches!(f.insts[3], Inst::BinopI { op: BinOp::Or, .. }));
        assert!(matches!(f.insts[4], Inst::Imm(0)));
    }

    #[test]
    fn nested_select_contributes_its_values_to_the_outer_set() {
        // A nested `?:` merges a phi into a phi: the outer phi can produce
        // 1, 2 or 3, so `ugt 3` is 0 for every one of them.
        let mut f = fresh(vec![
            Inst::Imm(1),
            Inst::Imm(2),
            Inst::Phi {
                incoming: vec![(0, 0), (1, 1)],
                kind: LoadKind::I64,
            },
            Inst::Imm(3),
            Inst::Phi {
                incoming: vec![(0, 2), (1, 3)],
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: BinOp::Ugt,
                lhs: 4,
                rhs_imm: 3,
            },
        ]);
        assert_eq!(select_values(&f, 4), Some(vec![1, 2, 3]));
        assert!(fold_selects(&mut f));
        assert!(matches!(f.insts[5], Inst::Imm(0)));
    }

    #[test]
    fn loop_counter_phi_is_not_a_select() {
        // `phi(0, phi + 1)`: the back edge is not an immediate, so the set
        // of values is unknown and a comparison on it must survive.
        let mut f = fresh(vec![
            Inst::Imm(0),
            Inst::Phi {
                incoming: vec![(0, 0), (1, 2)],
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 1,
                rhs_imm: 1,
            },
            Inst::BinopI {
                op: BinOp::Ugt,
                lhs: 1,
                rhs_imm: 3,
            },
        ]);
        assert_eq!(select_values(&f, 1), None);
        assert!(!fold_selects(&mut f));
    }

    #[test]
    fn select_with_a_non_constant_incoming_is_refused() {
        // A loop-carried phi has an incoming that is not an immediate, so
        // the set of values it can take is unknown.
        let mut f = fresh(vec![
            Inst::Imm(1),
            Inst::Load {
                addr: 0,
                disp: 0,
                kind: LoadKind::I64,
                volatile: false,
                align: 0,
                pc_rel: false,
            },
            Inst::Phi {
                incoming: vec![(0, 0), (1, 1)],
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: BinOp::Ugt,
                lhs: 2,
                rhs_imm: 3,
            },
        ]);
        assert!(!fold_selects(&mut f));
        assert!(matches!(f.insts[3], Inst::BinopI { .. }));
    }

    #[test]
    fn fp_kind_select_is_refused() {
        // An F64 phi merges bit patterns; the integer evaluator must not
        // compute on them.
        let mut f = fresh(vec![
            Inst::Imm(1),
            Inst::Imm(0),
            Inst::Phi {
                incoming: vec![(0, 0), (1, 1)],
                kind: LoadKind::F64,
            },
            Inst::BinopI {
                op: BinOp::Ugt,
                lhs: 2,
                rhs_imm: 3,
            },
        ]);
        assert!(!fold_selects(&mut f));
    }

    #[test]
    fn same_operand_integer_compares_fold() {
        for (op, want) in [
            (BinOp::Eq, 1),
            (BinOp::Le, 1),
            (BinOp::Ge, 1),
            (BinOp::Ule, 1),
            (BinOp::Uge, 1),
            (BinOp::Ne, 0),
            (BinOp::Lt, 0),
            (BinOp::Gt, 0),
            (BinOp::Ult, 0),
            (BinOp::Ugt, 0),
        ] {
            let mut f = fresh(vec![Inst::LocalAddr(0), Inst::Binop { op, lhs: 0, rhs: 0 }]);
            run_one(&mut f);
            assert!(
                matches!(f.insts[1], Inst::Imm(k) if k == want),
                "{op:?} -> {want}"
            );
        }
        // A shift or a product on a shared operand stays put.
        for op in [BinOp::Shl, BinOp::Mul] {
            let mut f = fresh(vec![Inst::LocalAddr(0), Inst::Binop { op, lhs: 0, rhs: 0 }]);
            run_one(&mut f);
            assert!(matches!(f.insts[1], Inst::Binop { .. }), "{op:?}");
        }
    }

    #[test]
    fn a_conversion_of_a_constant_folds_in_range() {
        let f64b = |x: f64| x.to_bits() as i64;
        let f32b = |x: f32| i64::from(x.to_bits());
        let folds = [
            (
                FpCastKind::F32ToF64,
                f32b(1.5),
                (true, false),
                Some(f64b(1.5)),
            ),
            (
                FpCastKind::F64ToF32,
                f64b(0.1),
                (false, true),
                Some(f32b(0.1)),
            ),
            (FpCastKind::IntToFp, -7, (false, false), Some(f64b(-7.0))),
            // One rounding to `float`, not two through `double`.
            (
                FpCastKind::IntToFp,
                0x20_0000_2000_0001,
                (false, true),
                Some(0x5a00_0001),
            ),
            (
                FpCastKind::UIntToFp,
                -1,
                (false, false),
                Some(f64b(18_446_744_073_709_551_616.0)),
            ),
            (
                FpCastKind::UIntToFp,
                -1,
                (false, true),
                Some(f32b(18_446_744_073_709_551_616.0)),
            ),
            (FpCastKind::FpToInt, f64b(-2.75), (false, false), Some(-2)),
            (FpCastKind::FpToInt, f32b(-2.75), (true, false), Some(-2)),
            (
                FpCastKind::FpToInt,
                f64b(-9_223_372_036_854_775_808.0),
                (false, false),
                Some(i64::MIN),
            ),
            (
                FpCastKind::UFpToInt,
                f64b(3e9),
                (false, false),
                Some(3_000_000_000),
            ),
            (FpCastKind::UFpToInt, f64b(-0.5), (false, false), Some(0)),
            // Out of range, a NaN, or an operand of the other width.
            (
                FpCastKind::FpToInt,
                f64b(9_223_372_036_854_775_808.0),
                (false, false),
                None,
            ),
            (FpCastKind::UFpToInt, f64b(-1.0), (false, false), None),
            (FpCastKind::F32ToF64, f32b(f32::NAN), (true, false), None),
            (FpCastKind::F64ToF32, f64b(f64::NAN), (false, true), None),
            (FpCastKind::F32ToF64, f64b(1.5), (false, false), None),
            (FpCastKind::IntToFp, f32b(1.5), (true, false), None),
        ];
        for (kind, k, (src_f32, dst_f32), want) in folds {
            assert_eq!(
                eval_fp_cast(kind, k, src_f32, dst_f32),
                want,
                "{kind:?} {k:#x}"
            );
        }
    }

    #[test]
    fn a_compare_marked_for_32_bits_folds_on_the_low_words() {
        // The sign extension of 0xFEFE_FEFE against its zero extension:
        // unequal as 64-bit values, equal in the low word a 32-bit compare
        // reads.
        for (marked, want) in [(true, 0), (false, 1)] {
            let mut f = fresh(vec![
                Inst::Imm(0xFEFE_FEFE_u32 as i32 as i64),
                Inst::BinopI {
                    op: BinOp::Ne,
                    lhs: 0,
                    rhs_imm: 0xFEFE_FEFE,
                },
            ]);
            f.cmp32 = vec![false, marked];
            run_one(&mut f);
            assert!(
                matches!(f.insts[1], Inst::Imm(k) if k == want),
                "marked {marked}"
            );
        }
    }

    #[test]
    fn same_operand_arithmetic_folds() {
        for (op, zero) in [
            (BinOp::Sub, true),
            (BinOp::Xor, true),
            (BinOp::And, false),
            (BinOp::Or, false),
        ] {
            let mut f = fresh(vec![
                Inst::LocalAddr(0),
                Inst::Binop { op, lhs: 0, rhs: 0 },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 1,
                    rhs_imm: 8,
                },
            ]);
            run_one(&mut f);
            if zero {
                assert!(
                    matches!(f.insts[1], Inst::Imm(0)),
                    "{op:?}: {:?}",
                    f.insts[1]
                );
            } else {
                assert!(
                    matches!(f.insts[2], Inst::BinopI { lhs: 0, .. }),
                    "{op:?} forwards its operand: {:?}",
                    f.insts[2]
                );
            }
        }
    }

    #[test]
    fn set_bits_absorb_what_reads_only_them() {
        let or_then = |k: i64, reader: Inst| {
            let mut f = fresh(vec![
                Inst::LocalAddr(0),
                Inst::BinopI {
                    op: BinOp::Or,
                    lhs: 0,
                    rhs_imm: k,
                },
                reader,
            ]);
            run_one(&mut f);
            f.insts[if k == -1 { 1 } else { 2 }].clone()
        };
        let and = |m: i64| Inst::BinopI {
            op: BinOp::And,
            lhs: 1,
            rhs_imm: m,
        };
        let extend = |kind: LoadKind| Inst::Extend {
            value: 1,
            kind,
            nsw: false,
        };
        assert!(matches!(or_then(-1, and(7)), Inst::Imm(-1)));
        assert!(matches!(or_then(0xff, and(0x0f)), Inst::Imm(0x0f)));
        assert!(matches!(or_then(0xff, and(0x1ff)), Inst::BinopI { .. }));
        assert!(matches!(
            or_then(0xffff_ffff, and(0xffff_ffff)),
            Inst::Imm(0xffff_ffff)
        ));
        assert!(matches!(
            or_then(0xffff_ffff, extend(LoadKind::I32)),
            Inst::Imm(-1)
        ));
        assert!(matches!(or_then(0xff, extend(LoadKind::I8)), Inst::Imm(-1)));
        assert!(matches!(
            or_then(0x7fff_ffff, extend(LoadKind::I32)),
            Inst::Extend { .. }
        ));
    }

    fn facts(nonnull_pcs: &[usize]) -> AddrFacts {
        AddrFacts {
            nonnull_syms: BTreeSet::new(),
            nonnull_code_pcs: nonnull_pcs.iter().copied().collect(),
            weak_data: Vec::new(),
            weak_tls: Vec::new(),
        }
    }

    #[test]
    fn null_compare_of_defined_function_address_folds() {
        // `addr == 0` on a defined function's address is 0; `!= 0` is 1.
        let mut f = fresh(vec![
            Inst::ImmCode(7),
            Inst::BinopI {
                op: BinOp::Eq,
                lhs: 0,
                rhs_imm: 0,
            },
            Inst::BinopI {
                op: BinOp::Ne,
                lhs: 0,
                rhs_imm: 0,
            },
        ]);
        assert!(fold_addr_compares(&mut f, &facts(&[7])));
        assert!(matches!(f.insts[1], Inst::Imm(0)));
        assert!(matches!(f.insts[2], Inst::Imm(1)));
    }

    #[test]
    fn null_compare_of_extern_placeholder_pc_is_refused() {
        // An extern function's placeholder ent_pc is not a defined pc,
        // so its address may bind to zero.
        let mut f = fresh(vec![
            Inst::ImmCode(7),
            Inst::BinopI {
                op: BinOp::Eq,
                lhs: 0,
                rhs_imm: 0,
            },
        ]);
        assert!(!fold_addr_compares(&mut f, &facts(&[])));
        assert!(matches!(f.insts[1], Inst::BinopI { .. }));
    }

    #[test]
    fn null_compare_of_weak_or_extern_sym_ref_is_refused() {
        // An extern-resolved instruction is judged by its symbol: sym 5
        // has no non-weak definition here, so no fold.
        let mut f = fresh(vec![
            Inst::ImmCode(0),
            Inst::BinopI {
                op: BinOp::Eq,
                lhs: 0,
                rhs_imm: 0,
            },
        ]);
        f.extern_imm_code_refs.push((0, 5));
        assert!(!fold_addr_compares(&mut f, &facts(&[0])));
        assert!(matches!(f.insts[1], Inst::BinopI { .. }));
        // The same sym with a non-weak definition folds.
        let mut g = fresh(vec![
            Inst::ImmCode(0),
            Inst::BinopI {
                op: BinOp::Eq,
                lhs: 0,
                rhs_imm: 0,
            },
        ]);
        g.extern_imm_code_refs.push((0, 5));
        let mut fx = facts(&[]);
        fx.nonnull_syms.insert(5);
        assert!(fold_addr_compares(&mut g, &fx));
        assert!(matches!(g.insts[1], Inst::Imm(0)));
    }

    #[test]
    fn null_compare_of_weak_data_range_is_refused() {
        let mut fx = facts(&[]);
        fx.weak_data.push((64, 72));
        // Inside the weak definition's range: refused.
        let mut f = fresh(vec![
            Inst::ImmData(64),
            Inst::BinopI {
                op: BinOp::Ne,
                lhs: 0,
                rhs_imm: 0,
            },
        ]);
        assert!(!fold_addr_compares(&mut f, &fx));
        // Outside it: this unit's non-weak storage, never null.
        let mut g = fresh(vec![
            Inst::ImmData(128),
            Inst::BinopI {
                op: BinOp::Ne,
                lhs: 0,
                rhs_imm: 0,
            },
        ]);
        assert!(fold_addr_compares(&mut g, &fx));
        assert!(matches!(g.insts[1], Inst::Imm(1)));
    }

    #[test]
    fn identical_address_constant_operands_fold() {
        // Two distinct defs of the same function address -- the shape
        // inlining leaves -- compare as the same pointer.
        let mut f = fresh(vec![
            Inst::ImmCode(7),
            Inst::ImmCode(7),
            Inst::Binop {
                op: BinOp::Ne,
                lhs: 0,
                rhs: 1,
            },
        ]);
        assert!(fold_addr_compares(&mut f, &facts(&[])));
        assert!(matches!(f.insts[2], Inst::Imm(0)));
        // Two extern placeholders with the same payload but different
        // symbols are different addresses: refused.
        let mut g = fresh(vec![
            Inst::ImmCode(0),
            Inst::ImmCode(0),
            Inst::Binop {
                op: BinOp::Ne,
                lhs: 0,
                rhs: 1,
            },
        ]);
        g.extern_imm_code_refs.push((0, 3));
        g.extern_imm_code_refs.push((1, 4));
        assert!(!fold_addr_compares(&mut g, &facts(&[])));
        // The same extern symbol on both sides is one address.
        let mut h = fresh(vec![
            Inst::ImmCode(0),
            Inst::ImmCode(0),
            Inst::Binop {
                op: BinOp::Eq,
                lhs: 0,
                rhs: 1,
            },
        ]);
        h.extern_imm_code_refs.push((0, 3));
        h.extern_imm_code_refs.push((1, 3));
        assert!(fold_addr_compares(&mut h, &facts(&[])));
        assert!(matches!(h.insts[2], Inst::Imm(1)));
    }

    /// `x != 0` over a comparison result redirects its consumers to
    /// the comparison; the renormalize goes dead.
    #[test]
    fn bool_renormalize_redirects_to_the_source() {
        let mut f = fresh(vec![
            Inst::LoadLocal {
                disp: 0,
                off: 2,
                kind: LoadKind::I64,
                volatile: false,
            },
            Inst::BinopI {
                op: BinOp::Lt,
                lhs: 0,
                rhs_imm: 3,
            },
            Inst::BinopI {
                op: BinOp::Ne,
                lhs: 1,
                rhs_imm: 0,
            },
            Inst::StoreLocal {
                disp: 0,
                off: -1,
                value: 2,
                kind: crate::c5::ir::StoreKind::I64,
                volatile: false,
                nsw: false,
            },
        ]);
        run_one(&mut f);
        assert!(
            matches!(
                f.insts[3],
                Inst::StoreLocal {
                    disp: 0,
                    value: 1,
                    ..
                }
            ),
            "store must read the comparison, got {:?}",
            f.insts[3]
        );
    }

    /// `x != 0` over a value that is not provably 0/1 keeps its
    /// consumers.
    #[test]
    fn renormalize_of_a_non_bool_value_stays() {
        let mut f = fresh(vec![
            Inst::LoadLocal {
                disp: 0,
                off: 2,
                kind: LoadKind::I64,
                volatile: false,
            },
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 0,
                rhs_imm: 3,
            },
            Inst::BinopI {
                op: BinOp::Ne,
                lhs: 1,
                rhs_imm: 0,
            },
            Inst::StoreLocal {
                disp: 0,
                off: -1,
                value: 2,
                kind: crate::c5::ir::StoreKind::I64,
                volatile: false,
                nsw: false,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(
            f.insts[3],
            Inst::StoreLocal {
                disp: 0,
                value: 2,
                ..
            }
        ));
    }

    /// A phi merging a comparison with a 0/1 constant is 0/1, so a
    /// renormalize over it also redirects (the short-circuit merge
    /// shape).
    #[test]
    fn bool_renormalize_sees_through_a_bool_phi() {
        let mut f = fresh(vec![
            Inst::LoadLocal {
                disp: 0,
                off: 2,
                kind: LoadKind::I64,
                volatile: false,
            },
            Inst::BinopI {
                op: BinOp::Ugt,
                lhs: 0,
                rhs_imm: 9,
            },
            Inst::Imm(0),
            Inst::Phi {
                incoming: vec![(0, 1), (1, 2)],
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: BinOp::Ne,
                lhs: 3,
                rhs_imm: 0,
            },
            Inst::StoreLocal {
                disp: 0,
                off: -1,
                value: 4,
                kind: crate::c5::ir::StoreKind::I64,
                volatile: false,
                nsw: false,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(
            f.insts[5],
            Inst::StoreLocal {
                disp: 0,
                value: 3,
                ..
            }
        ));
    }
}
