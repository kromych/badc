//! Scalar promotion of an address-taken automatic aggregate (SROA).
//!
//! Runs under `-O` after the inliner and the post-inline mem2reg. An
//! automatic aggregate stays memory-resident whenever its base address
//! is taken (`Inst::LocalAddr`), which mem2reg treats as an unanalysable
//! pin. This pass replaces every access through that address with an
//! access to a per-field frame slot and re-runs mem2reg, which promotes
//! the now address-free field slots to SSA values and inserts phis
//! across any surrounding loop. A field carried in a value is visible to
//! the constant folder, the branch folder, and the dominator-scoped
//! range analysis; the memory form is not, because a store anywhere in
//! between may alias it.
//!
//! Admission. An object is split only when every value that resolves to
//! an address inside it -- a `LocalAddr` of its base plus a chain of
//! constant `Add` / `Sub` -- is used exclusively as either
//!
//!   * the address of a non-volatile `Load` / `Store` whose byte range
//!     lies inside the object, or
//!   * the destination of an `Mcpy` starting at the object's first byte
//!     (a template initializer or a whole-object assignment).
//!
//! Any other use -- a call argument, a stored pointer, a comparison, a
//! runtime index, a terminator operand, an `Mcpy` source, an atomic or
//! segment-relative access -- lets the object be reached through a
//! pointer this pass does not track, so the object is declined. The
//! accessed byte ranges must also partition the object: two accesses are
//! either the same `(offset, width)` field or disjoint, so no field's
//! storage is ever observed at a second width. Storage written outside
//! the instruction tape (a by-value aggregate parameter's prologue copy,
//! the indirect-result address) and over-aligned objects are never
//! candidates.
//!
//! Each field gets its own frame slot. The object's own cells are reused
//! when every field starts on a distinct 8-byte boundary -- the shape a
//! fully unrolled constant-index array produces -- and fresh single-cell
//! slots are allocated otherwise, since a struct member's byte offset
//! need not be a multiple of the slot pitch. Either way the object's
//! base address becomes dead and the frame compaction reclaims whatever
//! is left unreferenced.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use crate::c5::codegen::ssa::reg_alloc::for_each_operand;
use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId};

/// Split local aggregates into per-field scalar slots and re-run mem2reg
/// to promote them. Returns the base slots of objects that were fully
/// promoted (every field lifted to a register), for the debug-info
/// emitter to drop their now-stale frame location.
pub(crate) fn run(func: &mut FunctionSsa, usable_gpr: usize) -> Vec<i64> {
    // mem2reg leaves computed-goto functions unpromoted; keep this pass
    // consistent so its split can never strand a slot the re-run refuses
    // to lift.
    if !func.computed_goto_targets.is_empty() {
        return Vec::new();
    }
    let split = split_objects(func, usable_gpr);
    if split.is_empty() {
        return Vec::new();
    }
    // The split produced address-free field slots; the mem2reg re-run
    // promotes them (a full pruned-SSA rebuild, confined to this
    // function by the gate at the call site).
    let promoted: BTreeSet<i64> = crate::c5::codegen::ssa::mem2reg::run(func)
        .into_iter()
        .collect();
    // Report an object as promoted only when every field slot was
    // lifted; a partially promoted object keeps a live frame location
    // the debug info must still point at.
    let mut fully: Vec<i64> = Vec::new();
    for (base, slots) in split {
        if slots.iter().all(|s| promoted.contains(s)) {
            fully.push(base);
        }
    }
    fully
}

/// A constant-offset scalar access to an object, resolved to the byte
/// range it reads or writes.
struct Access {
    id: u32,
    base: i64,
    off: i64,
    width: i64,
    store: bool,
}

/// A whole-object block copy into an object's first byte. The copy's
/// source is read off the tape at expansion time.
struct BlockInit {
    id: u32,
    base: i64,
    size: i64,
    align: i64,
}

/// One field of the copy a `BlockInit` is decomposed into: read `width`
/// bytes at `off` from the copy's source and write them to `slot`.
struct CopyField {
    off: i64,
    slot: i64,
    load: LoadKind,
    store: StoreKind,
}

/// Rewrite every splittable object's accesses to per-field slots,
/// decompose its block initializer, and neutralise the dead
/// base-address instructions. Returns `(base_slot, field_slots)` for
/// each object actually split. Splits nothing when the total field
/// count would exceed `budget` (the target's usable GPR file), since the
/// mem2reg re-run would then spill the loop-carried phis back to the
/// frame at a net loss.
fn split_objects(func: &mut FunctionSsa, budget: usize) -> Vec<(i64, Vec<i64>)> {
    let Some(cells_of) = candidate_objects(func) else {
        return Vec::new();
    };

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
    let mut declined: BTreeSet<i64> = BTreeSet::new();
    let mut accesses: Vec<Access> = Vec::new();
    let mut inits: Vec<BlockInit> = Vec::new();

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
                    && let Some(&cells) = cells_of.get(&base)
                {
                    let off = off + *disp as i64;
                    let width = load_width(*kind);
                    if *volatile || off < 0 || off + width > cells * 8 {
                        declined.insert(base);
                    } else {
                        accesses.push(Access {
                            id: i as u32,
                            base,
                            off,
                            width,
                            store: false,
                        });
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
                    && let Some(&cells) = cells_of.get(&base)
                {
                    let off = off + *disp as i64;
                    let width = store_width(*kind);
                    if *volatile || off < 0 || off + width > cells * 8 {
                        declined.insert(base);
                    } else {
                        accesses.push(Access {
                            id: i as u32,
                            base,
                            off,
                            width,
                            store: true,
                        });
                    }
                }
                // The stored value being an address escapes that base.
                if let Some(base) = base_of(*value) {
                    declined.insert(base);
                }
            }
            Inst::Mcpy {
                dst,
                src,
                size,
                align,
            } => {
                // Reading the object through a block copy is not
                // modelled; only a copy that fills it from its first
                // byte is.
                if let Some(base) = base_of(*src) {
                    declined.insert(base);
                }
                if let Some((base, off)) = resolved.get(*dst as usize).copied().flatten()
                    && cells_of.contains_key(&base)
                {
                    if off == 0 && *size > 0 {
                        inits.push(BlockInit {
                            id: i as u32,
                            base,
                            size: *size,
                            align: *align as i64,
                        });
                    } else {
                        declined.insert(base);
                    }
                }
            }
            other => {
                for_each_operand(other, |v| {
                    if let Some(base) = base_of(v) {
                        declined.insert(base);
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
            declined.insert(base);
        }
        if let Some(base) = base_of(block.exit_acc) {
            declined.insert(base);
        }
    }
    // A block copy's own value id must have no operand consumer: the
    // decomposition below replaces it with per-field stores, which do
    // not produce the copied object's address. `Block::exit_acc` is not
    // a consumer -- it pins the block's last accumulator write for
    // liveness, and the expansion's final store takes that role, as it
    // already does for a plain `Store`.
    if !inits.is_empty() {
        let mut used: BTreeSet<ValueId> = BTreeSet::new();
        for inst in &func.insts {
            for_each_operand(inst, |v| {
                used.insert(v);
            });
        }
        for block in &func.blocks {
            let mut term = block.terminator;
            term.for_each_operand_mut(|v| {
                used.insert(*v);
            });
        }
        for init in &inits {
            if used.contains(&init.id) {
                declined.insert(init.base);
            }
        }
    }

    // Group the surviving accesses into fields (the flag records whether
    // the field is carried in an FP register) and check that the byte
    // ranges partition: two accesses are the same field or disjoint.
    let mut fields_of: BTreeMap<i64, BTreeMap<(i64, i64), bool>> = BTreeMap::new();
    for a in &accesses {
        if declined.contains(&a.base) {
            continue;
        }
        let fp = match &func.insts[a.id as usize] {
            Inst::Load { kind, .. } => matches!(kind, LoadKind::F32 | LoadKind::F64),
            Inst::Store { kind, .. } => matches!(kind, StoreKind::F32 | StoreKind::F64),
            _ => false,
        };
        *fields_of
            .entry(a.base)
            .or_default()
            .entry((a.off, a.width))
            .or_default() |= fp;
    }
    for (base, fields) in &fields_of {
        let mut end = 0i64;
        for &(off, width) in fields.keys() {
            if off < end {
                declined.insert(*base);
                break;
            }
            end = off + width;
        }
    }
    // A block initializer must decompose exactly: every field it covers
    // has to sit wholly inside the copy, at its natural alignment within
    // the guarantee the copy carries, and move through an integer
    // register. A field outside the copy keeps its own slot's value.
    for init in &inits {
        let Some(fields) = fields_of.get(&init.base) else {
            continue;
        };
        let ok = fields.iter().all(|(&(off, width), &fp)| {
            off >= init.size
                || (off + width <= init.size
                    && !fp
                    && width <= init.align
                    && off % width == 0
                    && off <= i32::MAX as i64)
        });
        if !ok {
            declined.insert(init.base);
        }
    }

    // Assign a slot to every field of every surviving object.
    let order: Vec<i64> = fields_of
        .keys()
        .copied()
        .filter(|b| !declined.contains(b))
        .collect();
    let total: usize = order.iter().map(|b| fields_of[b].len()).sum();
    if order.is_empty() || total > budget {
        return Vec::new();
    }
    let mut slots_of: BTreeMap<i64, BTreeMap<(i64, i64), i64>> = BTreeMap::new();
    for &base in &order {
        let fields = &fields_of[&base];
        // Reuse the object's own cells when every field starts on a
        // distinct 8-byte boundary; the frame already reserved them.
        let cellwise = fields.keys().all(|&(off, _)| off % 8 == 0)
            && fields
                .keys()
                .map(|&(off, _)| off / 8)
                .collect::<BTreeSet<i64>>()
                .len()
                == fields.len();
        let mut assigned: BTreeMap<(i64, i64), i64> = BTreeMap::new();
        for &(off, width) in fields.keys() {
            let slot = if cellwise {
                base + off / 8
            } else {
                func.locals += 1;
                -func.locals
            };
            assigned.insert((off, width), slot);
        }
        slots_of.insert(base, assigned);
    }

    let mut splits: BTreeMap<u32, Vec<CopyField>> = BTreeMap::new();
    for init in &inits {
        let Some(assigned) = slots_of.get(&init.base) else {
            continue;
        };
        let copies = assigned
            .iter()
            .filter(|((off, _), _)| *off < init.size)
            .map(|(&(off, width), &slot)| {
                let (load, store) = copy_kinds(width);
                CopyField {
                    off,
                    slot,
                    load,
                    store,
                }
            })
            .collect();
        splits.insert(init.id, copies);
    }

    // Commit: rewrite each surviving access to its field slot.
    for a in &accesses {
        let Some(assigned) = slots_of.get(&a.base) else {
            continue;
        };
        let slot = assigned[&(a.off, a.width)];
        let inst = &mut func.insts[a.id as usize];
        if a.store {
            if let Inst::Store { value, kind, .. } = *inst {
                *inst = Inst::StoreLocal {
                    off: slot,
                    value,
                    kind,
                    volatile: false,
                };
            }
        } else if let Inst::Load { kind, .. } = *inst {
            *inst = Inst::LoadLocal {
                off: slot,
                kind,
                volatile: false,
            };
        }
    }
    // Neutralise the now-dead base-address expressions of every split
    // object: every consumer was a rewritten access or another address
    // expression, so the value has no live use. Before the expansion
    // below, which renumbers the tape `resolved` is indexed by.
    for (v, r) in resolved.iter().enumerate() {
        if let Some((base, _)) = r
            && slots_of.contains_key(base)
        {
            func.insts[v] = Inst::Imm(0);
        }
    }
    if !splits.is_empty() {
        expand_block_inits(func, &splits);
    }
    slots_of
        .into_iter()
        .map(|(base, assigned)| (base, assigned.into_values().collect()))
        .collect()
}

/// Local aggregates this pass may consider, as `base -> cells`. A base
/// repeated across disjoint scopes takes the smallest cell count so an
/// access is bounds-checked against every occupant. `None` when there is
/// nothing to do.
fn candidate_objects(func: &FunctionSsa) -> Option<BTreeMap<i64, i64>> {
    let mut cells_of: BTreeMap<i64, i64> = BTreeMap::new();
    for &(base, cells) in &func.multi_cell_slots {
        if base >= 0 || cells < 1 {
            continue;
        }
        // An over-aligned automatic object (C11 6.7.5) lives sp-relative in the
        // realigned region keyed by its base slot; splitting it would strand
        // the fields at fp-relative slots off their boundary.
        if func.over_aligned.iter().any(|&(s, _)| s == base) {
            continue;
        }
        // Storage the prologue fills outside the instruction tape: a
        // by-value aggregate parameter's body copy and the caller's
        // indirect-result address. The incoming bytes have no store in
        // the tape, so a promoted field slot would read undefined.
        let occupied = |s: i64| s != 0 && s >= base && s < base + cells;
        if func.param_local_slots.iter().copied().any(occupied)
            || occupied(func.indirect_result_slot)
        {
            continue;
        }
        cells_of
            .entry(base)
            .and_modify(|c| *c = (*c).min(cells))
            .or_insert(cells);
    }
    if cells_of.is_empty() {
        None
    } else {
        Some(cells_of)
    }
}

/// Replace each `Mcpy` named in `splits` with the per-field load / store
/// pairs it decomposes into, renumbering the tape around the insertions.
fn expand_block_inits(func: &mut FunctionSsa, splits: &BTreeMap<u32, Vec<CopyField>>) {
    let n = func.insts.len();
    let old_ranges: Vec<core::ops::Range<u32>> =
        func.blocks.iter().map(|b| b.inst_range.clone()).collect();
    // Layout first: an instruction's new id is the last id of its
    // replacement group, so the operand rewrite below reads a complete
    // map.
    let mut value_remap: Vec<ValueId> = alloc::vec![NO_VALUE; n];
    let mut next: u32 = 0;
    for range in &old_ranges {
        for old in range.start..range.end {
            next += group_len(splits, old);
            value_remap[old as usize] = next - 1;
        }
    }
    let total = next as usize;
    let remap = |v: ValueId| -> ValueId {
        match value_remap.get(v as usize) {
            Some(&new) if v != NO_VALUE => new,
            _ => v,
        }
    };

    let mut new_insts: Vec<Inst> = Vec::with_capacity(total);
    let mut new_src: Vec<(u32, u32)> = Vec::with_capacity(total);
    let mut new_f32: Vec<bool> = Vec::with_capacity(total);
    for (bi, range) in old_ranges.iter().enumerate() {
        let start = new_insts.len() as u32;
        for old in range.start..range.end {
            let loc = func.inst_src.get(old as usize).copied().unwrap_or((0, 0));
            match splits.get(&old) {
                Some(copies) if !copies.is_empty() => {
                    let src = match func.insts[old as usize] {
                        Inst::Mcpy { src, .. } => remap(src),
                        _ => NO_VALUE,
                    };
                    for c in copies {
                        let loaded = new_insts.len() as ValueId;
                        new_insts.push(Inst::Load {
                            addr: src,
                            disp: c.off as i32,
                            kind: c.load,
                            volatile: false,
                        });
                        new_insts.push(Inst::StoreLocal {
                            off: c.slot,
                            value: loaded,
                            kind: c.store,
                            volatile: false,
                        });
                        new_src.push(loc);
                        new_src.push(loc);
                        new_f32.push(false);
                        new_f32.push(false);
                    }
                }
                Some(_) => {
                    new_insts.push(Inst::Imm(0));
                    new_src.push(loc);
                    new_f32.push(false);
                }
                None => {
                    let mut inst = func.insts[old as usize].clone();
                    inst.for_each_operand_mut(|v| *v = remap(*v));
                    new_insts.push(inst);
                    new_src.push(loc);
                    new_f32.push(func.f32_values.get(old as usize).copied().unwrap_or(false));
                }
            }
        }
        func.blocks[bi].inst_range = start..new_insts.len() as u32;
    }
    for block in func.blocks.iter_mut() {
        block.exit_acc = remap(block.exit_acc);
        block.terminator.for_each_operand_mut(|v| *v = remap(*v));
    }
    // The per-site cross-TU relocation tables key on the value id of the
    // instruction naming the symbol, so they move with the operands.
    for table in [
        &mut func.extern_call_refs,
        &mut func.extern_imm_code_refs,
        &mut func.extern_imm_data_refs,
        &mut func.extern_tls_refs,
    ] {
        for (v, _) in table.iter_mut() {
            *v = remap(*v);
        }
    }
    func.insts = new_insts;
    func.inst_src = new_src;
    func.f32_values = new_f32;
}

/// Instruction count an old tape position expands to.
fn group_len(splits: &BTreeMap<u32, Vec<CopyField>>, old: u32) -> u32 {
    match splits.get(&old) {
        Some(copies) => (2 * copies.len() as u32).max(1),
        None => 1,
    }
}

/// Load / store kinds moving `width` bytes through an integer register.
fn copy_kinds(width: i64) -> (LoadKind, StoreKind) {
    match width {
        1 => (LoadKind::U8, StoreKind::I8),
        2 => (LoadKind::U16, StoreKind::I16),
        4 => (LoadKind::U32, StoreKind::I32),
        _ => (LoadKind::I64, StoreKind::I64),
    }
}

fn load_width(kind: LoadKind) -> i64 {
    match kind {
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I32 | LoadKind::U32 | LoadKind::F32 => 4,
        LoadKind::I64 | LoadKind::F64 => 8,
    }
}

fn store_width(kind: StoreKind) -> i64 {
    match kind {
        StoreKind::I8 => 1,
        StoreKind::I16 => 2,
        StoreKind::I32 | StoreKind::F32 => 4,
        StoreKind::I64 | StoreKind::F64 => 8,
    }
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
            locals: 4,
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
        let split = split_objects(&mut f, 64);
        assert_eq!(split, alloc::vec![(-2, alloc::vec![-2, -1])]);
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
    fn over_budget_object_not_split() {
        // The two-element array needs 2 register slots; a budget of 1
        // leaves it memory-resident (the re-run would spill it back).
        let mut f = two_elem_array();
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 1);
        assert!(split.is_empty(), "over-budget object must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    #[test]
    fn runtime_index_object_not_split() {
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
        let split = split_objects(&mut f, 64);
        assert!(split.is_empty(), "runtime-index object must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    #[test]
    fn escaped_address_object_not_split() {
        // Const-index stores plus the base address escaping through the
        // terminator: the whole object must stay memory-resident.
        let insts = alloc::vec![
            Inst::Imm(5),        // v0
            Inst::LocalAddr(-2), // v1
            store(1, 0),         // v2 a[0]=5
            Inst::LocalAddr(-2), // v3 escapes below
        ];
        let mut f = func(insts, Terminator::Return(3), alloc::vec![(-2, 2)]);
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 64);
        assert!(split.is_empty(), "escaped-address object must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    #[test]
    fn function_without_candidate_objects_untouched() {
        // No multi-cell locals: nothing to scalarize, and the mem2reg
        // re-run never fires.
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

    /// A struct with a 4-byte member at offset 0 and an 8-byte member at
    /// offset 8: the fields are not slot-pitch aligned as a group, so
    /// each takes a fresh slot.
    #[test]
    fn sub_word_fields_take_fresh_slots() {
        let insts = alloc::vec![
            Inst::Imm(3),        // v0
            Inst::LocalAddr(-4), // v1
            Inst::Store {
                addr: 1,
                disp: 0,
                value: 0,
                kind: StoreKind::I32,
                volatile: false
            }, // v2 s.state = 3
            Inst::LocalAddr(-4), // v3
            Inst::Load {
                addr: 3,
                disp: 0,
                kind: LoadKind::U32,
                volatile: false
            }, // v4 s.state
        ];
        let mut f = func(insts, Terminator::Return(4), alloc::vec![(-4, 4)]);
        let split = split_objects(&mut f, 64);
        assert_eq!(split.len(), 1, "the struct splits");
        // Offset 0 is a lone 8-aligned field, so it reuses cell 0.
        assert!(matches!(
            f.insts[2],
            Inst::StoreLocal {
                off: -4,
                kind: StoreKind::I32,
                ..
            }
        ));
        assert!(matches!(
            f.insts[4],
            Inst::LoadLocal {
                off: -4,
                kind: LoadKind::U32,
                ..
            }
        ));
    }

    /// Two fields inside one 8-byte cell cannot reuse the object's
    /// storage; both take fresh slots below the existing frame.
    #[test]
    fn fields_sharing_a_cell_take_fresh_slots() {
        let insts = alloc::vec![
            Inst::Imm(1),        // v0
            Inst::LocalAddr(-2), // v1
            Inst::Store {
                addr: 1,
                disp: 0,
                value: 0,
                kind: StoreKind::I32,
                volatile: false
            }, // v2
            Inst::LocalAddr(-2), // v3
            Inst::Store {
                addr: 3,
                disp: 4,
                value: 0,
                kind: StoreKind::I32,
                volatile: false
            }, // v4
            Inst::LocalAddr(-2), // v5
            Inst::Load {
                addr: 5,
                disp: 4,
                kind: LoadKind::I32,
                volatile: false
            }, // v6
        ];
        let mut f = func(insts, Terminator::Return(6), alloc::vec![(-2, 1)]);
        let split = split_objects(&mut f, 64);
        assert_eq!(split.len(), 1);
        let slots = &split[0].1;
        assert!(
            slots.iter().all(|&s| s < -4),
            "fields sharing a cell take fresh slots, got {slots:?}"
        );
    }

    /// An access that overlaps another at a second width leaves the
    /// object in memory: the field decomposition is not a partition.
    #[test]
    fn overlapping_widths_not_split() {
        let insts = alloc::vec![
            Inst::Imm(1),        // v0
            Inst::LocalAddr(-2), // v1
            store(1, 0),         // v2 8-byte store at 0
            Inst::LocalAddr(-2), // v3
            Inst::Load {
                addr: 3,
                disp: 0,
                kind: LoadKind::I32,
                volatile: false
            }, // v4 4-byte load at 0
        ];
        let mut f = func(insts, Terminator::Return(4), alloc::vec![(-2, 1)]);
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 64);
        assert!(split.is_empty(), "overlapping widths must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    /// A template `Mcpy` filling the object decomposes into a per-field
    /// load from the template plus a store to the field slot.
    #[test]
    fn block_initializer_splits_into_field_copies() {
        let insts = alloc::vec![
            Inst::LocalAddr(-2), // v0
            Inst::ImmData(64),   // v1
            Inst::Mcpy {
                dst: 0,
                src: 1,
                size: 16,
                align: 8
            }, // v2
            Inst::LocalAddr(-2), // v3
            Inst::Load {
                addr: 3,
                disp: 8,
                kind: LoadKind::I64,
                volatile: false
            }, // v4
        ];
        let mut f = func(insts, Terminator::Return(4), alloc::vec![(-2, 2)]);
        let split = split_objects(&mut f, 64);
        assert_eq!(split.len(), 1, "the initialized object splits");
        // The Mcpy became one load/store pair for the single live field.
        let pairs: Vec<_> = f
            .insts
            .iter()
            .enumerate()
            .filter(|(_, i)| matches!(i, Inst::StoreLocal { .. }))
            .collect();
        assert_eq!(pairs.len(), 1, "one field copy, got {:?}", f.insts);
        let (si, _) = pairs[0];
        assert!(
            matches!(
                f.insts[si - 1],
                Inst::Load {
                    addr: 1,
                    disp: 8,
                    kind: LoadKind::I64,
                    ..
                }
            ),
            "field copy reads the template at the field offset, got {:?}",
            f.insts[si - 1]
        );
        // The block range covers the grown tape.
        assert_eq!(f.blocks[0].inst_range, 0..f.insts.len() as u32);
    }

    /// An `Mcpy` reading the object escapes it: the pass models filling
    /// an object from elsewhere, not copying it out.
    #[test]
    fn block_copy_out_of_object_not_split() {
        let insts = alloc::vec![
            Inst::LocalAddr(-2), // v0
            Inst::ImmData(64),   // v1
            Inst::Mcpy {
                dst: 1,
                src: 0,
                size: 16,
                align: 8
            }, // v2
            Inst::LocalAddr(-2), // v3
            load(3),             // v4
        ];
        let mut f = func(insts, Terminator::Return(4), alloc::vec![(-2, 2)]);
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 64);
        assert!(split.is_empty(), "object read by a block copy must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    /// A by-value aggregate parameter's body slot is filled by the
    /// prologue, not by the tape, so it is never a candidate.
    #[test]
    fn aggregate_parameter_slot_not_split() {
        let insts = alloc::vec![
            Inst::LocalAddr(-2), // v0
            load(0),             // v1
        ];
        let mut f = func(insts, Terminator::Return(1), alloc::vec![(-2, 2)]);
        f.param_local_slots = alloc::vec![-2];
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 64);
        assert!(split.is_empty(), "parameter storage must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }

    /// A volatile access keeps the object memory-resident (C99 6.7.3p6).
    #[test]
    fn volatile_access_not_split() {
        let insts = alloc::vec![
            Inst::Imm(1),        // v0
            Inst::LocalAddr(-2), // v1
            Inst::Store {
                addr: 1,
                disp: 0,
                value: 0,
                kind: StoreKind::I64,
                volatile: true
            }, // v2
        ];
        let mut f = func(insts, Terminator::Return(2), alloc::vec![(-2, 1)]);
        let before = alloc::format!("{:?}", f.insts);
        let split = split_objects(&mut f, 64);
        assert!(split.is_empty(), "volatile access must not split");
        assert_eq!(before, alloc::format!("{:?}", f.insts), "tape unchanged");
    }
}
