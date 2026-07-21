//! Scalar promotion of constant-index local arrays (SROA-lite).
//!
//! Runs under `-O` after the constant folder, on functions the unroll
//! pass expanded (`FunctionSsa::did_unroll`). Full unrolling of a
//! constant-trip loop turns each array subscript `a[j]` into a constant
//! byte offset from the array's base slot, so the frame round-trip that
//! kept the array memory-resident is removable. mem2reg leaves such an
//! array in memory because its base address is taken (`LocalAddr`), so
//! this pass rewrites every constant-offset, full-width access into a
//! per-element `LoadLocal` / `StoreLocal` against the element's own
//! frame slot and re-runs mem2reg, which promotes the now address-free
//! element slots to SSA values (and inserts phis across any surrounding
//! loop).
//!
//! A local aggregate is split only when every access through its base
//! address is a non-volatile, full-width (8-byte), 8-byte-aligned,
//! in-bounds constant offset and the address never otherwise escapes (to
//! a call, a stored pointer, an `Mcpy`, a comparison, or a runtime-index
//! computation). An 8-byte element at byte offset `k*8` from base slot
//! `S` occupies frame slot `S + k` (locals sit at `off * 8` bytes from
//! the frame pointer, `emit_common::c5_slot_to_fp_offset`), so the
//! rewrite reuses storage the frame already reserved -- no new slot is
//! allocated. The now-dead base-address instructions are neutralised to
//! `Imm(0)` so mem2reg's address-taken scan no longer pins the base slot.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use crate::c5::codegen::ssa::reg_alloc::for_each_operand;
use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId};

/// Split constant-index local arrays into per-element scalar slots and
/// re-run mem2reg to promote them. Returns the base slots of arrays that
/// were fully promoted (every element lifted to a register), for the
/// debug-info emitter to drop their now-stale frame location.
pub(crate) fn run(func: &mut FunctionSsa, usable_gpr: usize) -> Vec<i64> {
    // mem2reg leaves computed-goto functions unpromoted; keep this pass
    // consistent so its split can never strand a slot the re-run refuses
    // to lift.
    if !func.computed_goto_targets.is_empty() {
        return Vec::new();
    }
    let split = split_arrays(func, usable_gpr);
    if split.is_empty() {
        return Vec::new();
    }
    // The split produced address-free element slots; the mem2reg re-run
    // promotes them (a full pruned-SSA rebuild, confined to this function
    // by the did_unroll gate at the call site).
    let promoted: BTreeSet<i64> = crate::c5::codegen::ssa::mem2reg::run(func)
        .into_iter()
        .collect();
    // Report an array base as promoted only when every element slot was
    // lifted; a partially promoted array keeps a live frame location the
    // debug info must still point at.
    let mut fully: Vec<i64> = Vec::new();
    for (base, cells) in split {
        if (0..cells).all(|k| promoted.contains(&(base + k))) {
            fully.push(base);
        }
    }
    fully
}

/// A constant-offset, full-width access to split, resolved to its
/// per-element frame slot.
struct Access {
    id: u32,
    base: i64,
    slot: i64,
    store: bool,
}

/// Rewrite every splittable array's accesses to per-element LoadLocal /
/// StoreLocal and neutralise the dead base-address instructions. Returns
/// `(base_slot, cells)` for each array actually split. Splits nothing
/// when the total element count would exceed `budget` (the target's
/// usable GPR file), since the mem2reg re-run would then spill the
/// loop-carried phis back to the frame at a net loss.
fn split_arrays(func: &mut FunctionSsa, budget: usize) -> Vec<(i64, i64)> {
    // Candidate array bases: declared / synthetic multi-cell locals. The
    // parser records each as `(base, cells)` with `base` the lowest cell.
    // A base repeated across disjoint scopes takes the smallest cell count
    // so an access is bounds-checked against every occupant.
    let mut cells_of: BTreeMap<i64, i64> = BTreeMap::new();
    for &(base, cells) in &func.multi_cell_slots {
        // An over-aligned automatic object (C11 6.7.5) lives sp-relative in the
        // realigned region keyed by its base slot; splitting it would strand
        // the elements at fp-relative slots off their boundary.
        if func.over_aligned.iter().any(|&(s, _)| s == base) {
            continue;
        }
        if base < 0 && cells >= 1 {
            cells_of
                .entry(base)
                .and_modify(|c| *c = (*c).min(cells))
                .or_insert(cells);
        }
    }
    if cells_of.is_empty() {
        return Vec::new();
    }

    // Resolve every value to its (base_slot, byte_offset) when it is an
    // address expression rooted at a `LocalAddr` through constant Add /
    // Sub chains; None otherwise. Memoised with an in-progress guard
    // against the cyclic references the unordered SSA tape may carry.
    let n = func.insts.len();
    let mut state: Vec<u8> = alloc::vec![0u8; n];
    let mut resolved: Vec<Option<(i64, i64)>> = alloc::vec![None; n];
    for v in 0..n {
        resolve_addr(&func.insts, v as ValueId, &mut state, &mut resolved);
    }
    let base_of = |v: ValueId| -> Option<i64> {
        resolved
            .get(v as usize)
            .copied()
            .flatten()
            .map(|(b, _)| b)
            .filter(|b| cells_of.contains_key(b))
    };

    // A base drops out the moment any access or use fails a condition.
    let mut unsafe_base: BTreeSet<i64> = BTreeSet::new();
    let mut accesses: Vec<Access> = Vec::new();

    for (i, inst) in func.insts.iter().enumerate() {
        match inst {
            // An address expression built by a constant Add / Sub is a
            // safe intermediate: its address operand is skipped here and
            // its result is validated through the uses of `i`.
            Inst::BinopI {
                op: BinOp::Add | BinOp::Sub,
                ..
            }
            | Inst::Binop {
                op: BinOp::Add | BinOp::Sub,
                ..
            } if resolved[i].is_some() => {}
            Inst::Load {
                addr,
                disp,
                kind,
                volatile,
            } => {
                if let Some((base, off)) = resolved.get(*addr as usize).copied().flatten()
                    && cells_of.contains_key(&base)
                {
                    match check_access(base, off + *disp as i64, load_is_word(*kind), &cells_of) {
                        Some(slot) if !*volatile => accesses.push(Access {
                            id: i as u32,
                            base,
                            slot,
                            store: false,
                        }),
                        _ => {
                            unsafe_base.insert(base);
                        }
                    }
                }
            }
            Inst::Store {
                addr,
                disp,
                value,
                kind,
                volatile,
            } => {
                if let Some((base, off)) = resolved.get(*addr as usize).copied().flatten()
                    && cells_of.contains_key(&base)
                {
                    match check_access(base, off + *disp as i64, store_is_word(*kind), &cells_of) {
                        Some(slot) if !*volatile => accesses.push(Access {
                            id: i as u32,
                            base,
                            slot,
                            store: true,
                        }),
                        _ => {
                            unsafe_base.insert(base);
                        }
                    }
                }
                // The stored value being an address escapes that base.
                if let Some(base) = base_of(*value) {
                    unsafe_base.insert(base);
                }
            }
            other => {
                for_each_operand(other, |v| {
                    if let Some(base) = base_of(v) {
                        unsafe_base.insert(base);
                    }
                });
            }
        }
    }
    // A base address reaching a terminator or block accumulator escapes.
    for block in &func.blocks {
        let v = match &block.terminator {
            Terminator::Return(v)
            | Terminator::Bz { cond: v, .. }
            | Terminator::Bnz { cond: v, .. }
            | Terminator::GotoIndirect { target: v }
            | Terminator::JumpTable { idx: v, .. } => *v,
            _ => NO_VALUE,
        };
        if let Some(base) = base_of(v) {
            unsafe_base.insert(base);
        }
        if let Some(base) = base_of(block.exit_acc) {
            unsafe_base.insert(base);
        }
    }

    // Bases that survived every check and carry at least one access.
    let mut split: BTreeMap<i64, i64> = BTreeMap::new();
    for a in &accesses {
        if !unsafe_base.contains(&a.base) {
            split.insert(a.base, cells_of[&a.base]);
        }
    }
    if split.is_empty() {
        return Vec::new();
    }
    // Register-budget gate: promoting more element slots than the target's
    // GPR file holds spills the loop-carried phis back to the frame at a
    // net loss, so leave the arrays memory-resident when the split would
    // overflow the budget. Nothing is mutated on this path.
    let total: i64 = split.values().copied().sum();
    if total > budget as i64 {
        return Vec::new();
    }
    // Commit: rewrite each surviving access to its per-element slot.
    for a in &accesses {
        if !split.contains_key(&a.base) {
            continue;
        }
        let inst = &mut func.insts[a.id as usize];
        if a.store {
            if let Inst::Store { value, kind, .. } = *inst {
                *inst = Inst::StoreLocal {
                    off: a.slot,
                    value,
                    kind,
                    volatile: false,
                };
            }
        } else if let Inst::Load { kind, .. } = *inst {
            *inst = Inst::LoadLocal {
                off: a.slot,
                kind,
                volatile: false,
            };
        }
    }
    // Neutralise the now-dead base-address expressions of every split
    // base: every consumer was a rewritten access or another address
    // expression, so the value has no live use.
    for (v, r) in resolved.iter().enumerate() {
        if let Some((base, _)) = r
            && split.contains_key(base)
        {
            func.insts[v] = Inst::Imm(0);
        }
    }
    split.into_iter().collect()
}

/// The frame slot an 8-byte access at `total_off` bytes from base slot
/// `base` maps to, when the access is full-width, 8-byte-aligned, and in
/// bounds. `None` otherwise.
fn check_access(
    base: i64,
    total_off: i64,
    is_word: bool,
    cells_of: &BTreeMap<i64, i64>,
) -> Option<i64> {
    if !is_word || total_off < 0 || total_off % 8 != 0 {
        return None;
    }
    let k = total_off / 8;
    let cells = *cells_of.get(&base)?;
    if k >= cells {
        return None;
    }
    Some(base + k)
}

fn load_is_word(k: LoadKind) -> bool {
    matches!(k, LoadKind::I64 | LoadKind::F64)
}

fn store_is_word(k: StoreKind) -> bool {
    matches!(k, StoreKind::I64 | StoreKind::F64)
}

/// Resolve `v` to `(base_slot, byte_offset)` when it is a `LocalAddr`
/// plus a chain of constant Add / Sub, else `None`. Memoised; `state`
/// holds 0 (unvisited), 1 (in progress -- a cycle, treated as None), or
/// 2 (done).
fn resolve_addr(
    insts: &[Inst],
    v: ValueId,
    state: &mut [u8],
    resolved: &mut [Option<(i64, i64)>],
) -> Option<(i64, i64)> {
    let vi = v as usize;
    if vi >= insts.len() {
        return None;
    }
    match state[vi] {
        1 => return None,
        2 => return resolved[vi],
        _ => {}
    }
    state[vi] = 1;
    let imm = |id: ValueId| -> Option<i64> {
        match insts.get(id as usize) {
            Some(Inst::Imm(k)) => Some(*k),
            _ => None,
        }
    };
    let r = match &insts[vi] {
        Inst::LocalAddr(s) => Some((*s, 0)),
        Inst::BinopI {
            op: BinOp::Add,
            lhs,
            rhs_imm,
        } => resolve_addr(insts, *lhs, state, resolved).map(|(s, o)| (s, o + *rhs_imm)),
        Inst::BinopI {
            op: BinOp::Sub,
            lhs,
            rhs_imm,
        } => resolve_addr(insts, *lhs, state, resolved).map(|(s, o)| (s, o - *rhs_imm)),
        Inst::Binop {
            op: BinOp::Add,
            lhs,
            rhs,
        } => {
            if let Some(c) = imm(*rhs) {
                resolve_addr(insts, *lhs, state, resolved).map(|(s, o)| (s, o + c))
            } else if let Some(c) = imm(*lhs) {
                resolve_addr(insts, *rhs, state, resolved).map(|(s, o)| (s, o + c))
            } else {
                None
            }
        }
        Inst::Binop {
            op: BinOp::Sub,
            lhs,
            rhs,
        } => {
            if let Some(c) = imm(*rhs) {
                resolve_addr(insts, *lhs, state, resolved).map(|(s, o)| (s, o - c))
            } else {
                None
            }
        }
        _ => None,
    };
    state[vi] = 2;
    resolved[vi] = r;
    r
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{Block, Terminator};

    fn func(insts: Vec<Inst>, term: Terminator, multi_cell: Vec<(i64, i64)>) -> FunctionSsa {
        let n = insts.len() as u32;
        FunctionSsa {
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            insts,
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..n,
                terminator: term,
                exit_acc: NO_VALUE,
            }],
            multi_cell_slots: multi_cell,
            ..FunctionSsa::default()
        }
    }

    fn store(addr: ValueId, value: ValueId) -> Inst {
        Inst::Store {
            addr,
            disp: 0,
            value,
            kind: StoreKind::I64,
            volatile: false,
        }
    }
    fn load(addr: ValueId) -> Inst {
        Inst::Load {
            addr,
            disp: 0,
            kind: LoadKind::I64,
            volatile: false,
        }
    }
    fn add_imm(lhs: ValueId, k: i64) -> Inst {
        Inst::BinopI {
            op: BinOp::Add,
            lhs,
            rhs_imm: k,
        }
    }

    /// Two-element local array `a` at base slot -2: a[0]=v0 via
    /// LocalAddr(-2), a[1]=v3 via LocalAddr(-2)+8, then read back.
    fn two_elem_array() -> FunctionSsa {
        let insts = alloc::vec![
            Inst::Imm(5),        // v0
            Inst::LocalAddr(-2), // v1
            store(1, 0),         // v2  a[0] = 5
            Inst::Imm(7),        // v3
            Inst::LocalAddr(-2), // v4
            add_imm(4, 8),       // v5  &a[1]
            store(5, 3),         // v6  a[1] = 7
            Inst::LocalAddr(-2), // v7
            load(7),             // v8  a[0]
            Inst::LocalAddr(-2), // v9
            add_imm(9, 8),       // v10 &a[1]
            load(10),            // v11 a[1]
            Inst::Binop {
                op: BinOp::Add,
                lhs: 8,
                rhs: 11,
            }, // v12 a[0] + a[1]
        ];
        func(insts, Terminator::Return(12), alloc::vec![(-2, 2)])
    }

    #[test]
    fn const_index_array_splits_and_promotes() {
        let mut f = two_elem_array();
        let promoted = run(&mut f, 64);
        assert_eq!(promoted, alloc::vec![-2], "the array's base slot promotes");
        // No frame access to the array survives after promotion.
        for inst in &f.insts {
            assert!(
                !matches!(
                    inst,
                    Inst::LoadLocal { off: -2 | -1, .. } | Inst::StoreLocal { off: -2 | -1, .. }
                ) || matches!(inst, Inst::LoadLocal { .. }),
                "no live StoreLocal to the array may remain"
            );
        }
        assert!(
            !f.insts
                .iter()
                .any(|i| matches!(i, Inst::StoreLocal { off: -2 | -1, .. })),
            "promoted stores are neutralised"
        );
    }

    #[test]
    fn dead_local_addr_neutralised() {
        let mut f = two_elem_array();
        let split = split_arrays(&mut f, 64);
        assert_eq!(split, alloc::vec![(-2, 2)]);
        // Store/Load rewritten to per-element slots (-2 for a[0], -1 for a[1]).
        assert!(matches!(f.insts[2], Inst::StoreLocal { off: -2, .. }));
        assert!(matches!(f.insts[6], Inst::StoreLocal { off: -1, .. }));
        assert!(matches!(f.insts[8], Inst::LoadLocal { off: -2, .. }));
        assert!(matches!(f.insts[11], Inst::LoadLocal { off: -1, .. }));
        // Base-address instructions (LocalAddr + Add) neutralised.
        for id in [1usize, 4, 5, 7, 9, 10] {
            assert!(
                matches!(f.insts[id], Inst::Imm(0)),
                "address expr v{id} must be neutralised, got {:?}",
                f.insts[id]
            );
        }
    }

    #[test]
    fn over_budget_array_not_split() {
        // The two-element array needs 2 register slots; a budget of 1
        // leaves it memory-resident (the re-run would spill it back).
        let mut f = two_elem_array();
        let before = alloc::format!("{:?}", f.insts);
        let split = split_arrays(&mut f, 1);
        assert!(split.is_empty(), "over-budget array must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    #[test]
    fn runtime_index_array_not_split() {
        // a[0]=v0 (constant), then a load at a runtime offset.
        let insts = alloc::vec![
            Inst::Imm(5),        // v0
            Inst::LocalAddr(-2), // v1
            store(1, 0),         // v2 a[0]=5
            Inst::ParamRef {
                idx: 0,
                kind: LoadKind::I64,
            }, // v3 runtime k
            Inst::LocalAddr(-2), // v4
            Inst::Binop {
                op: BinOp::Add,
                lhs: 4,
                rhs: 3,
            }, // v5 &a[k] (runtime)
            load(5),             // v6
        ];
        let mut f = func(insts, Terminator::Return(6), alloc::vec![(-2, 2)]);
        let before = alloc::format!("{:?}", f.insts);
        let split = split_arrays(&mut f, 64);
        assert!(split.is_empty(), "runtime-index array must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    #[test]
    fn escaped_address_array_not_split() {
        // Const-index stores plus the base address escaping through the
        // terminator: the whole array must stay memory-resident.
        let insts = alloc::vec![
            Inst::Imm(5),        // v0
            Inst::LocalAddr(-2), // v1
            store(1, 0),         // v2 a[0]=5
            Inst::LocalAddr(-2), // v3 escapes below
        ];
        let mut f = func(insts, Terminator::Return(3), alloc::vec![(-2, 2)]);
        let before = alloc::format!("{:?}", f.insts);
        let split = split_arrays(&mut f, 64);
        assert!(split.is_empty(), "escaped-address array must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    #[test]
    fn function_without_candidate_arrays_untouched() {
        // No multi-cell locals: nothing to scalarize, and the mem2reg
        // re-run never fires (mirrors a function the unroll pass left with
        // no constant-index array).
        let insts = alloc::vec![
            Inst::Imm(1),
            Inst::LoadLocal {
                off: 2,
                kind: LoadKind::I64,
                volatile: false,
            },
        ];
        let mut f = func(insts, Terminator::Return(1), alloc::vec![]);
        let before = alloc::format!("{:?}", f.insts);
        let promoted = run(&mut f, 64);
        assert!(promoted.is_empty());
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }
}
