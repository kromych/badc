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

use super::super::ir::{BinOp, FunctionSsa, Inst, ValueId};
use super::mem2reg::successors;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

/// Per-function map from an original movable slot offset to its
/// post-coalesce DWARF classification (`Some(new_off)` = exclusive,
/// `None` = shared), keyed by the function's `ent_pc`.
pub(crate) type CoalesceDwarf = BTreeMap<usize, BTreeMap<i64, Option<i64>>>;

/// `compact` (the -O post-inline mode) repacks the frame even when fewer
/// than two scalar slots can share: slots whose every access mem2reg
/// promoted or the branch folds pruned are dropped and the survivors are
/// renumbered densely, so a spliced-then-promoted callee region stops
/// occupying the frame. Without it (the -O0 mode) a function that has
/// nothing to share is left untouched.
pub(crate) fn run(funcs: &mut [FunctionSsa], compact: bool) -> CoalesceDwarf {
    let mut out = CoalesceDwarf::new();
    for f in funcs.iter_mut() {
        let ent_pc = f.ent_pc;
        let m = coalesce(f, compact);
        if !m.is_empty() {
            out.insert(ent_pc, m);
        }
    }
    out
}

fn coalesce(f: &mut FunctionSsa, compact: bool) -> BTreeMap<i64, Option<i64>> {
    // A returns-twice call (setjmp family / vfork) re-enters the frame after
    // the first-return path ran, and stack-pointer asm (longjmp / stack-switch
    // idioms) parks an activation the CFG does not model. Live ranges from
    // ordinary liveness do not bound slot lifetime in either case (C99
    // 7.13.2.1p3), so no two slots may share storage -- the same rule the
    // register allocator applies to spill slots. Sharing is what liveness
    // justifies; keeping a slot no instruction and no `FunctionSsa` field
    // names is not, so such a function still drops its unreferenced slots and
    // renumbers the survivors one-to-one below.
    let dedicated = f.has_returns_twice_call || f.has_sp_asm();
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

    // Leave a realigning function (an automatic object aligned above 16,
    // C11 6.7.5) uncoalesced: its dynamic-sp frame is the expensive shape
    // already and stays as emitted. A 16-aligned region keeps the static
    // frame; its member slots are held out of sharing below and
    // `FunctionSsa::over_aligned` is renumbered in lockstep.
    if f.frame_align > 16 {
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

    // Instructions covered by a block: the emitted tape. Branch folding
    // deletes blocks but leaves their instructions in `insts`; an access
    // reachable through no block never executes and must not reserve or
    // keep a slot.
    let mut in_block = alloc::vec![false; f.insts.len()];
    for blk in &f.blocks {
        for pc in blk.inst_range.clone() {
            if let Some(b) = in_block.get_mut(pc as usize) {
                *b = true;
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
    // A field address may be a constant `Add` / `Sub` over the base rather
    // than a bare displacement, so chains resolve to `(base, byte_offset)`;
    // the tape is not ordered definitions-before-uses, hence the fixpoint.
    let mut la_base: BTreeMap<ValueId, (i64, i64)> = BTreeMap::new();
    loop {
        let mut grew = false;
        for (i, inst) in f.insts.iter().enumerate().filter(|(i, _)| in_block[*i]) {
            let v = i as ValueId;
            if la_base.contains_key(&v) {
                continue;
            }
            let resolved = match inst {
                Inst::LocalAddr(base) if movable(*base) => Some((*base, 0)),
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs,
                    rhs_imm,
                } => la_base.get(lhs).map(|&(b, o)| (b, o + *rhs_imm)),
                Inst::BinopI {
                    op: BinOp::Sub,
                    lhs,
                    rhs_imm,
                } => la_base.get(lhs).map(|&(b, o)| (b, o - *rhs_imm)),
                _ => None,
            };
            if let Some(r) = resolved {
                la_base.insert(v, r);
                grew = true;
            }
        }
        if !grew {
            break;
        }
    }
    let mut extent: BTreeMap<i64, i64> = BTreeMap::new();
    for (_, inst) in f.insts.iter().enumerate().filter(|(i, _)| in_block[*i]) {
        match inst {
            Inst::Load { addr, disp, .. } | Inst::Store { addr, disp, .. } => {
                if let Some(&(base, off)) = la_base.get(addr) {
                    let e = extent.entry(base).or_insert(0);
                    *e = (*e).max(off + *disp as i64 + 8);
                }
            }
            Inst::Mcpy { dst, src, size, .. } => {
                if let Some(&(base, off)) = la_base.get(dst) {
                    let e = extent.entry(base).or_insert(0);
                    *e = (*e).max(off + *size);
                }
                if let Some(&(base, off)) = la_base.get(src) {
                    let e = extent.entry(base).or_insert(0);
                    *e = (*e).max(off + *size);
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
    // An accessed over-aligned region member keeps dedicated storage: sharing
    // its slot with a scalar would put the scalar in the region too, and the
    // entry's renumbering below is 1:1 only for reserved slots and aggregate
    // runs. An unaccessed member stays out of every set, so the repack drops
    // its slot and the entry follows.
    let region_slots: BTreeSet<i64> = f.over_aligned.iter().map(|&(s, _)| s).collect();
    for (_, inst) in f.insts.iter().enumerate().filter(|(i, _)| in_block[*i]) {
        if let Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } = inst
            && region_slots.contains(off)
            && movable(*off)
            && !agg_cells.contains(off)
        {
            reserved_single.insert(*off);
        }
    }
    for (_, inst) in f.insts.iter().enumerate().filter(|(i, _)| in_block[*i]) {
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
    for (_, inst) in f.insts.iter().enumerate().filter(|(i, _)| in_block[*i]) {
        if let Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } = inst
            && movable(*off)
            && !agg_cells.contains(off)
            && !reserved_single.contains(off)
        {
            candidates.insert(*off);
        }
    }
    // Under `dedicated` no slot may share storage; every candidate keeps its
    // own offset through the reserved path, which drops the unreferenced.
    if dedicated {
        reserved_single.append(&mut candidates);
    }
    // Nothing to share leaves the -O0 frame untouched; the compact mode
    // still repacks so unreferenced slots are dropped.
    if !compact && candidates.len() < 2 {
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
    // Off a worklist: a block is recomputed only when a successor's
    // live-in grew, so the sweep count tracks loop depth rather than the
    // block count. The dataflow is monotone from the empty set, so its
    // least fixed point -- and hence the result -- does not depend on
    // the visit order.
    let mut preds: Vec<Vec<usize>> = alloc::vec![Vec::new(); nb];
    for (b, ss) in succ.iter().enumerate() {
        for &s in ss {
            preds[s].push(b);
        }
    }
    let mut live_in = alloc::vec![0u64; nb * words];
    let mut live_out = alloc::vec![0u64; nb * words];
    let mut work: Vec<usize> = (0..nb).collect();
    let mut queued = alloc::vec![true; nb];
    while let Some(b) = work.pop() {
        queued[b] = false;
        let mut grew = false;
        for w in 0..words {
            let mut out = 0u64;
            for &s in &succ[b] {
                out |= live_in[s * words + w];
            }
            live_out[b * words + w] = out;
            let v = gen_bits[b * words + w] | (out & !kill[b * words + w]);
            if v != live_in[b * words + w] {
                live_in[b * words + w] = v;
                grew = true;
            }
        }
        if grew {
            for &p in &preds[b] {
                if !queued[p] {
                    queued[p] = true;
                    work.push(p);
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

    // Greedy colouring: interfering slots get distinct colours. Each
    // row is walked over its set bits, and the colours its already-
    // coloured neighbours hold are marked in a stamp array refreshed by
    // bumping the stamp, so the search costs the row's degree rather
    // than the candidate count times a set insertion.
    let mut color = alloc::vec![usize::MAX; n];
    let mut color_used = alloc::vec![0u32; n + 1];
    let mut ncolors = 0usize;
    for i in 0..n {
        let stamp = i as u32 + 1;
        for w in 0..words {
            let mut bits = interfere[i * words + w];
            while bits != 0 {
                let j = w * 64 + bits.trailing_zeros() as usize;
                bits &= bits - 1;
                if color[j] != usize::MAX {
                    color_used[color[j]] = stamp;
                }
            }
        }
        let mut c = 0;
        while color_used[c] == stamp {
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
    // In compact mode an aggregate run no live instruction or `FunctionSsa`
    // field reaches -- every access was promoted or sits in a deleted block
    // -- is dropped rather than repacked.
    let mut referenced: BTreeSet<i64> = field_slots.clone();
    if compact {
        for (_, inst) in f.insts.iter().enumerate().filter(|(i, _)| in_block[*i]) {
            match inst {
                Inst::LocalAddr(off)
                | Inst::AllocaInit(off)
                | Inst::LoadLocal { off, .. }
                | Inst::StoreLocal { off, .. } => {
                    referenced.insert(*off);
                }
                Inst::Call { ret_slot_local, .. }
                | Inst::CallIndirect { ret_slot_local, .. }
                | Inst::CallExt { ret_slot_local, .. } => {
                    referenced.insert(*ret_slot_local);
                }
                _ => {}
            }
        }
    }
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
        if compact && !(lo_off..=hi_off).any(|off| referenced.contains(&off)) {
            i = j + 1;
            continue;
        }
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
    // Renumber the over-aligned region members in lockstep. A movable member
    // absent from `new_off` was dropped by the compact repack (no surviving
    // reference), so its entry goes too; the region bytes stay reserved
    // unless every member dropped.
    f.over_aligned
        .retain(|&(s, _)| !movable(s) || new_off.contains_key(&s));
    for e in &mut f.over_aligned {
        if let Some(&nn) = new_off.get(&e.0) {
            e.0 = nn;
        }
    }
    if f.over_aligned.is_empty() {
        f.frame_align = 0;
        f.realign_region_bytes = 0;
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

#[cfg(all(test, feature = "std"))]
mod tests {
    use super::super::super::ir::{Block, LoadKind, StoreKind, Terminator};
    use super::*;

    fn one_block(insts: Vec<Inst>, ret: ValueId, locals: i64) -> FunctionSsa {
        let n = insts.len() as u32;
        FunctionSsa {
            locals,
            synthetic_base: 1,
            inst_src: alloc::vec![(0, 0); n as usize],
            f32_values: alloc::vec![false; n as usize],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..n,
                terminator: Terminator::Return(ret),
                exit_acc: ret,
            }],
            insts,
            ..Default::default()
        }
    }

    /// Compact mode drops slots and multi-cell groups with no remaining
    /// reference and renumbers the survivor; the -O0 mode leaves a
    /// function with fewer than two shareable scalars untouched.
    #[test]
    fn compact_drops_unreferenced_slots_and_groups() {
        let build = || {
            let mut f = one_block(
                alloc::vec![
                    Inst::LocalAddr(-7),
                    Inst::Load {
                        addr: 0,
                        disp: 0,
                        kind: LoadKind::I64,
                        volatile: false,
                        align: 0,
                    },
                ],
                1,
                10,
            );
            f.multi_cell_slots = alloc::vec![(-5, 2)];
            f
        };
        let mut f = build();
        let map = coalesce(&mut f, true);
        assert_eq!(f.locals, 1);
        assert!(matches!(f.insts[0], Inst::LocalAddr(-1)));
        assert_eq!(map, BTreeMap::from([(-7, Some(-1))]));

        let mut f = build();
        assert!(coalesce(&mut f, false).is_empty());
        assert_eq!(f.locals, 10);
    }

    /// A 16-aligned over-aligned region coalesces: member entries are
    /// renumbered in lockstep with their slots, a dropped member's entry
    /// goes with it, and an emptied region clears the frame fields. Above
    /// 16 (a realigning frame) the function is left untouched.
    #[test]
    fn region_slots_renumber_in_lockstep() {
        let build = |align: i64| {
            let mut f = one_block(
                alloc::vec![
                    Inst::LocalAddr(-7),
                    Inst::Load {
                        addr: 0,
                        disp: 0,
                        kind: LoadKind::I64,
                        volatile: false,
                        align: 0,
                    },
                ],
                1,
                10,
            );
            // Slot -7 is live (the region member); slot -3's member has no
            // reference left and drops under compact.
            f.over_aligned = alloc::vec![(-7, 0), (-3, 16)];
            f.frame_align = align;
            f.realign_region_bytes = 32;
            f
        };
        let mut f = build(16);
        coalesce(&mut f, true);
        assert!(matches!(f.insts[0], Inst::LocalAddr(-1)));
        assert_eq!(
            f.over_aligned,
            alloc::vec![(-1, 0)],
            "the live member follows its slot; the dead member's entry drops"
        );
        assert_eq!((f.frame_align, f.realign_region_bytes), (16, 32));

        let mut f = build(32);
        assert!(coalesce(&mut f, true).is_empty());
        assert_eq!(f.locals, 10, "a realigning frame stays as emitted");

        // Every member dropped: the region clears entirely.
        let mut f = one_block(alloc::vec![Inst::Imm(0)], 0, 4);
        f.over_aligned = alloc::vec![(-2, 0)];
        f.frame_align = 16;
        f.realign_region_bytes = 16;
        coalesce(&mut f, true);
        assert!(f.over_aligned.is_empty());
        assert_eq!((f.frame_align, f.realign_region_bytes), (0, 0));
    }

    /// Stack-pointer asm bars slot sharing -- resume points and parked
    /// activations make CFG liveness under-approximate lifetime -- but not
    /// the compact drop, which rests on no instruction naming the slot. Two
    /// live-disjoint scalars that share without the asm stay dedicated with
    /// it, while the slots nothing names are dropped either way. -O0 leaves
    /// such a function untouched.
    #[test]
    fn sp_asm_keeps_slots_dedicated() {
        use super::super::super::ir::AsmBlock;
        let build = |sp: bool| {
            one_block(
                alloc::vec![
                    Inst::InlineAsm {
                        asm: alloc::boxed::Box::new(AsmBlock {
                            template: if sp {
                                b"mov %%rsp, (%%rdx)".to_vec()
                            } else {
                                b"nop".to_vec()
                            },
                            operands: alloc::vec![],
                            clobber_regs: 0,
                            clobber_fp_regs: 0,
                            clobber_memory: true,
                            volatile: true,
                        }),
                        args: alloc::vec![],
                    },
                    Inst::LoadLocal {
                        off: -9,
                        kind: LoadKind::I64,
                        volatile: false,
                    },
                    Inst::StoreLocal {
                        off: -8,
                        value: 1,
                        kind: StoreKind::I64,
                        volatile: false,
                    },
                ],
                1,
                10,
            )
        };
        let slot_offs = |f: &FunctionSsa| -> Vec<i64> {
            f.insts
                .iter()
                .filter_map(|i| match i {
                    Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } => Some(*off),
                    _ => None,
                })
                .collect()
        };
        // Without the stack-pointer reference the two disjoint scalars share.
        let mut plain = build(false);
        coalesce(&mut plain, true);
        assert_eq!(plain.locals, 1);
        let po = slot_offs(&plain);
        assert_eq!(po[0], po[1]);

        // With it each keeps its own slot; the eight unnamed ones still go.
        let mut f = build(true);
        coalesce(&mut f, true);
        assert_eq!(f.locals, 2);
        let o = slot_offs(&f);
        assert_ne!(o[0], o[1]);

        // -O0 has nothing to share and leaves the frame as emitted.
        let mut f0 = build(true);
        assert!(coalesce(&mut f0, false).is_empty());
        assert_eq!(f0.locals, 10);
    }

    /// An access left in the tape by block deletion (covered by no block)
    /// neither reserves nor keeps its slot.
    #[test]
    fn orphan_inst_does_not_keep_slot() {
        let mut f = one_block(
            alloc::vec![
                Inst::LocalAddr(-7),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                },
                Inst::StoreLocal {
                    off: -2,
                    value: 1,
                    kind: StoreKind::I64,
                    volatile: false,
                },
            ],
            1,
            10,
        );
        f.blocks[0].inst_range = 0..2;
        coalesce(&mut f, true);
        assert_eq!(f.locals, 1);
    }

    /// A constant-Add field address extends an unrecorded temporary's
    /// extent, so its interior cell rides with the base as one group and
    /// a shared scalar never lands on it. Locked in the -O0 mode.
    #[test]
    fn binopi_field_address_extends_group() {
        let mut f = one_block(
            alloc::vec![
                Inst::LocalAddr(-3),
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs_imm: 8,
                },
                Inst::Store {
                    addr: 1,
                    disp: 0,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                    align: 0,
                },
                Inst::LoadLocal {
                    off: -9,
                    kind: LoadKind::I64,
                    volatile: false,
                },
                Inst::StoreLocal {
                    off: -8,
                    value: 3,
                    kind: StoreKind::I64,
                    volatile: false,
                },
            ],
            3,
            9,
        );
        let map = coalesce(&mut f, false);
        assert_eq!(f.locals, 3);
        assert!(matches!(f.insts[0], Inst::LocalAddr(-2)));
        assert!(matches!(f.insts[3], Inst::LoadLocal { off: -3, .. }));
        assert!(matches!(f.insts[4], Inst::StoreLocal { off: -3, .. }));
        assert_eq!(
            map,
            BTreeMap::from([(-9, None), (-8, None), (-3, Some(-2)), (-2, Some(-1))])
        );
    }
}
