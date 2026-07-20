//! Stack-slot coalescing.
//!
//! The SSA builder reserves a fresh frame slot per synthetic temporary
//! (`alloc_synthetic_local`, the phi substitute at every control-flow merge)
//! and never reuses one, and the parser assigns each declared local a slot by
//! lexical scope rather than by live range. A function with many merges, or
//! many lexically-coexisting but live-disjoint locals -- a large `switch`,
//! say -- thus accumulates a frame far larger than its peak live slot count.
//! A frame whose per-call growth exceeds a caller's stack-overflow margin
//! defeats any recursion guard built on that margin.
//!
//! This pass reuses scalar slots whose live ranges do not overlap and
//! compacts the frame. A slot is a candidate only when every reference to it
//! is a scalar `LoadLocal` / `StoreLocal`; any slot whose address is taken
//! (`LocalAddr`), that backs an aggregate call result (`ret_slot_local`),
//! that carries a non-zero `AllocaInit`, that is an interior cell of a
//! multi-cell object (`multi_cell_slots`), or that the emit reaches through a
//! `FunctionSsa` field rather than an instruction (`indirect_result_slot`,
//! `param_local_slots`) is reserved, so a reused scalar never lands on storage
//! an instruction reaches another way. Multi-cell groups move as contiguous
//! blocks; overlapping declared groups (one slot reused across disjoint
//! scopes) merge into a single block.
//!
//! The pass always coalesces the whole movable frame (declared locals
//! included) so the emitted machine code is independent of whether debug
//! info is requested. `run` returns, per function, a map from each original
//! movable slot offset to its post-coalesce classification, which the DWARF
//! emitter consumes: an EXCLUSIVE slot (the new offset backs exactly one
//! original slot) carries `Some(new_off)` and its location is rewritten to
//! the new offset; a SHARED slot (the new offset backs disjoint-lifetime
//! scalars) carries `None` and its location is dropped, since no single
//! frame address holds it for the whole scope.

use super::super::ir::{FunctionSsa, Inst, ValueId};
use super::mem2reg::successors;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

/// Per-function map from an original movable slot offset to its
/// post-coalesce DWARF classification (`Some(new_off)` = exclusive,
/// `None` = shared), keyed by the function's `ent_pc`.
pub(crate) type CoalesceDwarf = BTreeMap<usize, BTreeMap<i64, Option<i64>>>;

pub(crate) fn run(funcs: &mut [FunctionSsa]) -> CoalesceDwarf {
    let mut out = CoalesceDwarf::new();
    for f in funcs.iter_mut() {
        let ent_pc = f.ent_pc;
        let m = coalesce(f);
        if !m.is_empty() {
            out.insert(ent_pc, m);
        }
    }
    out
}

fn coalesce(f: &mut FunctionSsa) -> BTreeMap<i64, Option<i64>> {
    // A returns-twice call (setjmp family / vfork) re-enters the frame
    // after the first-return path ran: live ranges from ordinary
    // liveness do not bound slot lifetime (C99 7.13.2.1p3), so every
    // slot stays dedicated -- the same rule the register allocator
    // applies to spill slots.
    if f.has_returns_twice_call {
        return BTreeMap::new();
    }
    // `synthetic_base > 0` marks a walker-built function with declared
    // locals; hand-built SSA (sys-trampolines, CRT entry) carries 0 and is
    // left alone -- its slot model is not the walker's.
    let synth_base = f.synthetic_base;
    let total = f.locals;
    if synth_base <= 0 || total <= 0 {
        return BTreeMap::new();
    }
    // The whole movable frame is coalesced; a slot at offset 0 is not movable.
    let floor = 0;
    if total <= floor {
        return BTreeMap::new();
    }
    let movable = |off: i64| off < 0 && -off > floor && -off <= total;

    // Leave a dynamic-sp function (alloca / VLA) uncoalesced. Its runtime
    // allocations are reached through computed pointers this pass does not
    // model, so compacting the named slots around them is not proven safe.
    // TODO: model the computed pointers so alloca functions compact too.
    if f.insts
        .iter()
        .any(|i| matches!(i, Inst::AllocaInit(slot) if *slot > 0))
    {
        return BTreeMap::new();
    }

    // Interior cells of every movable multi-cell object: declared aggregates
    // and struct-by-value parameter copies (seeded from the parser) plus
    // synthetic aggregates (`alloc_synthetic_struct`). The cells of one group
    // are contiguous with the base (lowest address) most negative.
    let mut agg_cells: BTreeSet<i64> = BTreeSet::new();
    for &(base, cells) in &f.multi_cell_slots {
        for k in 0..cells {
            let off = base + k;
            if movable(off) {
                agg_cells.insert(off);
            }
        }
    }

    // Supplement the recorded extents with extents derived from how each
    // `LocalAddr` result is used: a whole-struct `Mcpy` carries the byte
    // size, a field load / store the displacement. A parser-allocated struct
    // temporary -- a struct call result, a compound literal -- reaches memory
    // through a base address but carries no `VariableInfo`, so it is absent
    // from `multi_cell_slots`; without this a coalesced slot could land on
    // such a temporary's interior cell, which no instruction names directly.
    let mut la_base: BTreeMap<ValueId, i64> = BTreeMap::new();
    for (i, inst) in f.insts.iter().enumerate() {
        if let Inst::LocalAddr(base) = inst
            && movable(*base)
        {
            la_base.insert(i as ValueId, *base);
        }
    }
    let mut extent: BTreeMap<i64, i64> = BTreeMap::new();
    for inst in &f.insts {
        match inst {
            Inst::Load { addr, disp, .. } | Inst::Store { addr, disp, .. } => {
                if let Some(&base) = la_base.get(addr) {
                    let e = extent.entry(base).or_insert(0);
                    *e = (*e).max(*disp as i64 + 8);
                }
            }
            Inst::Mcpy { dst, src, size } => {
                if let Some(&base) = la_base.get(dst) {
                    let e = extent.entry(base).or_insert(0);
                    *e = (*e).max(*size);
                }
                if let Some(&base) = la_base.get(src) {
                    let e = extent.entry(base).or_insert(0);
                    *e = (*e).max(*size);
                }
            }
            // A struct-returning call writes its whole result through the
            // out-pointer into `ret_slot_local`, contiguously. The body may
            // then read the result cell by cell (`LoadLocal { off: base + k }`),
            // which alone would make the interior cells coalescing candidates
            // and scatter them away from the contiguous write. Reserve the
            // full return extent so the group moves as one block.
            Inst::Call {
                ret_slot_local,
                ret_agg,
                ..
            }
            | Inst::CallIndirect {
                ret_slot_local,
                ret_agg,
                ..
            }
            | Inst::CallExt {
                ret_slot_local,
                ret_agg,
                ..
            } => {
                if let Some(ai) = ret_agg
                    && movable(*ret_slot_local)
                    && let Some(d) = f.agg_descs.get(*ai as usize)
                {
                    let e = extent.entry(*ret_slot_local).or_insert(0);
                    *e = (*e).max(d.size as i64);
                }
            }
            _ => {}
        }
    }
    for (&base, &bytes) in &extent {
        let cells = (bytes + 7) / 8;
        if cells > 1 {
            for k in 0..cells {
                let off = base + k;
                if movable(off) {
                    agg_cells.insert(off);
                }
            }
        }
    }

    // Slots the emit reaches only through a `FunctionSsa` field, never an
    // instruction: they must be reserved and remapped in lockstep with any
    // body load / store of the same slot. The prologue store of the
    // indirect-result pointer and of a narrow float parameter both land here.
    let mut field_slots: BTreeSet<i64> = BTreeSet::new();
    if movable(f.indirect_result_slot) {
        field_slots.insert(f.indirect_result_slot);
    }
    for &s in &f.param_local_slots {
        if movable(s) {
            field_slots.insert(s);
        }
    }

    // Reserved single slots: a movable slot reached by means other than a
    // direct scalar load / store that is not an aggregate interior.
    let mut reserved_single: BTreeSet<i64> = BTreeSet::new();
    for &off in &field_slots {
        if !agg_cells.contains(&off) {
            reserved_single.insert(off);
        }
    }
    for inst in &f.insts {
        let off = match inst {
            Inst::LocalAddr(off) | Inst::AllocaInit(off) => *off,
            Inst::Call { ret_slot_local, .. }
            | Inst::CallIndirect { ret_slot_local, .. }
            | Inst::CallExt { ret_slot_local, .. } => *ret_slot_local,
            // A volatile-accessed slot keeps its own storage: the
            // object must hold its last store across control
            // transfers the CFG does not model (C99 7.13.2.1
            // longjmp), so the liveness below cannot justify
            // sharing or moving it.
            Inst::LoadLocal { off, volatile, .. } | Inst::StoreLocal { off, volatile, .. }
                if *volatile =>
            {
                *off
            }
            _ => continue,
        };
        if movable(off) && !agg_cells.contains(&off) {
            reserved_single.insert(off);
        }
    }

    // Candidate scalar slots: movable, only ever a scalar LoadLocal /
    // StoreLocal, not an aggregate interior, not reserved.
    let mut candidates: BTreeSet<i64> = BTreeSet::new();
    for inst in &f.insts {
        if let Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } = inst
            && movable(*off)
            && !agg_cells.contains(off)
            && !reserved_single.contains(off)
        {
            candidates.insert(*off);
        }
    }
    if candidates.len() < 2 {
        return BTreeMap::new();
    }
    let slots: Vec<i64> = candidates.iter().copied().collect();
    let slot_bit: BTreeMap<i64, usize> = slots.iter().enumerate().map(|(i, &o)| (o, i)).collect();
    let n = slots.len();
    let words = n.div_ceil(64);
    let nb = f.blocks.len();

    // Per-block gen / kill over the candidate slots. gen = a slot loaded
    // before it is stored in the block (upward-exposed use); kill = a slot
    // stored in the block.
    let mut gen_bits = alloc::vec![0u64; nb * words];
    let mut kill = alloc::vec![0u64; nb * words];
    for (b, blk) in f.blocks.iter().enumerate() {
        let mut stored: BTreeSet<usize> = BTreeSet::new();
        for inst in &f.insts[blk.inst_range.start as usize..blk.inst_range.end as usize] {
            match inst {
                Inst::LoadLocal { off, .. } => {
                    if let Some(&bit) = slot_bit.get(off)
                        && !stored.contains(&bit)
                    {
                        gen_bits[b * words + bit / 64] |= 1u64 << (bit % 64);
                    }
                }
                Inst::StoreLocal { off, .. } => {
                    if let Some(&bit) = slot_bit.get(off) {
                        kill[b * words + bit / 64] |= 1u64 << (bit % 64);
                        stored.insert(bit);
                    }
                }
                _ => {}
            }
        }
    }

    // Backward liveness to a fixed point.
    let succ: Vec<Vec<usize>> = f
        .blocks
        .iter()
        .map(|blk| {
            successors(&blk.terminator, &f.computed_goto_targets, &f.jump_tables)
                .iter()
                .map(|&b| b as usize)
                .collect()
        })
        .collect();
    let mut live_in = alloc::vec![0u64; nb * words];
    let mut live_out = alloc::vec![0u64; nb * words];
    let mut changed = true;
    while changed {
        changed = false;
        for b in (0..nb).rev() {
            for w in 0..words {
                let mut out = 0u64;
                for &s in &succ[b] {
                    out |= live_in[s * words + w];
                }
                if out != live_out[b * words + w] {
                    live_out[b * words + w] = out;
                    changed = true;
                }
                let v = gen_bits[b * words + w] | (out & !kill[b * words + w]);
                if v != live_in[b * words + w] {
                    live_in[b * words + w] = v;
                    changed = true;
                }
            }
        }
    }

    // Interference. Walk each block backward; `live` starts at live_out[b].
    // At a StoreLocal def of slot s, s interferes with every other live slot,
    // then leaves the live set; a LoadLocal use adds its slot.
    let mut interfere = alloc::vec![0u64; n * words];
    for (b, blk) in f.blocks.iter().enumerate() {
        let mut live = live_out[b * words..(b + 1) * words].to_vec();
        let r = blk.inst_range.start as usize..blk.inst_range.end as usize;
        for inst in f.insts[r].iter().rev() {
            match inst {
                Inst::StoreLocal { off, .. } => {
                    if let Some(&bit) = slot_bit.get(off) {
                        for w in 0..words {
                            let mut m = live[w];
                            if w == bit / 64 {
                                m &= !(1u64 << (bit % 64));
                            }
                            interfere[bit * words + w] |= m;
                            let mut mm = m;
                            while mm != 0 {
                                let t = w * 64 + mm.trailing_zeros() as usize;
                                interfere[t * words + bit / 64] |= 1u64 << (bit % 64);
                                mm &= mm - 1;
                            }
                        }
                        live[bit / 64] &= !(1u64 << (bit % 64));
                    }
                }
                Inst::LoadLocal { off, .. } => {
                    if let Some(&bit) = slot_bit.get(off) {
                        live[bit / 64] |= 1u64 << (bit % 64);
                    }
                }
                _ => {}
            }
        }
    }

    // Greedy colouring: interfering slots get distinct colours.
    let mut color = alloc::vec![usize::MAX; n];
    let mut ncolors = 0usize;
    for i in 0..n {
        let mut used: BTreeSet<usize> = BTreeSet::new();
        for j in 0..n {
            if color[j] != usize::MAX && interfere[i * words + j / 64] & (1u64 << (j % 64)) != 0 {
                used.insert(color[j]);
            }
        }
        let mut c = 0;
        while used.contains(&c) {
            c += 1;
        }
        color[i] = c;
        ncolors = ncolors.max(c + 1);
    }

    // Compact the movable region. Magnitudes are assigned just past the
    // floor: aggregate runs first (each a contiguous block, order preserved
    // so the base stays the lowest address and interior pointer arithmetic
    // still lands), then reserved singles, then one slot per colour. Slots at
    // or below the floor and the parameter slots (positive offsets) are not
    // in the map and keep their offset.
    let mut new_off: BTreeMap<i64, i64> = BTreeMap::new();
    let mut next_mag = floor;
    let cells_sorted: Vec<i64> = agg_cells.iter().copied().collect();
    let mut i = 0;
    while i < cells_sorted.len() {
        let lo_off = cells_sorted[i];
        let mut j = i;
        while j + 1 < cells_sorted.len() && cells_sorted[j + 1] == cells_sorted[j] + 1 {
            j += 1;
        }
        let hi_off = cells_sorted[j];
        let width = hi_off - lo_off + 1;
        for off in lo_off..=hi_off {
            new_off.insert(off, -(next_mag + 1 + (hi_off - off)));
        }
        next_mag += width;
        i = j + 1;
    }
    for &off in &reserved_single {
        next_mag += 1;
        new_off.insert(off, -next_mag);
    }
    let mut color_off: Vec<i64> = alloc::vec![0; ncolors];
    let mut color_set: Vec<bool> = alloc::vec![false; ncolors];
    for (i, &off) in slots.iter().enumerate() {
        let c = color[i];
        if !color_set[c] {
            next_mag += 1;
            color_off[c] = -next_mag;
            color_set[c] = true;
        }
        new_off.insert(off, color_off[c]);
    }
    let new_locals = next_mag;
    if new_locals >= total {
        return BTreeMap::new();
    }
    for inst in &mut f.insts {
        match inst {
            Inst::LocalAddr(off)
            | Inst::AllocaInit(off)
            | Inst::LoadLocal { off, .. }
            | Inst::StoreLocal { off, .. } => {
                if let Some(&nn) = new_off.get(off) {
                    *off = nn;
                }
            }
            Inst::Call { ret_slot_local, .. }
            | Inst::CallIndirect { ret_slot_local, .. }
            | Inst::CallExt { ret_slot_local, .. } => {
                if let Some(&nn) = new_off.get(ret_slot_local) {
                    *ret_slot_local = nn;
                }
            }
            _ => {}
        }
    }
    if let Some(&nn) = new_off.get(&f.indirect_result_slot) {
        f.indirect_result_slot = nn;
    }
    for s in &mut f.param_local_slots {
        if let Some(&nn) = new_off.get(s) {
            *s = nn;
        }
    }
    f.multi_cell_slots.clear();
    f.locals = new_locals;

    // Classify each original movable slot for the DWARF emitter. A new
    // offset that backs exactly one original slot (an aggregate, a reserved
    // single, or a single-use colour) holds that slot's value for its whole
    // scope, so the location is rewritten to the new offset (exclusive). A
    // new offset shared by more than one original slot (disjoint-lifetime
    // scalars sharing storage) has no single stable location, so the slot's
    // location is dropped (shared).
    let mut reverse_count: BTreeMap<i64, usize> = BTreeMap::new();
    for &new in new_off.values() {
        *reverse_count.entry(new).or_insert(0) += 1;
    }
    new_off
        .into_iter()
        .map(|(orig, new)| {
            if reverse_count.get(&new).copied().unwrap_or(0) == 1 {
                (orig, Some(new))
            } else {
                (orig, None)
            }
        })
        .collect()
}
