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
//! This pass reuses storage whose live ranges do not overlap and compacts the
//! frame. Two slot populations share:
//!
//!   * scalar slots, referenced only by `LoadLocal` / `StoreLocal`, colored
//!     over exact gen/kill liveness;
//!   * address-taken objects (declared aggregates, aggregate-return
//!     temporaries, `LocalAddr`-reached scalars), colored as whole cell
//!     groups over a coarser lifetime: a group is live from its first
//!     store or address-take to its last load. All its accesses must be
//!     accounted for, so a group is admitted only when every value derived
//!     from its address resolves to a load / store / copy / by-value call
//!     argument inside the object. Any other flow of the address -- a plain
//!     pointer call argument, a stored pointer, asm, an atomic, a phi --
//!     escapes the object and pins it for the whole function: C block scope
//!     alone does not bound the lifetime once the address has flowed.
//!     TODO: prove shorter lifetimes for escaped objects from scoping.
//!
//! Reserved storage keeps a dedicated block: escaped objects, volatile
//! slots, over-aligned region members, and slots the emit reaches through a
//! `FunctionSsa` field rather than an instruction (`indirect_result_slot`,
//! `param_local_slots`, both written by the prologue).
//!
//! The pass always coalesces the whole movable frame (declared locals
//! included) so the emitted machine code is independent of whether debug
//! info is requested. `run` returns, per function, a map from each original
//! movable slot offset to its post-coalesce classification, which the DWARF
//! emitter consumes: an EXCLUSIVE slot (the new offset backs exactly one
//! original slot) carries `Some(new_off)` and its location is rewritten to
//! the new offset; a SHARED slot (the new offset backs disjoint-lifetime
//! storage) carries `None` and its location is dropped, since no single
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
/// than two slots can share: slots whose every access mem2reg promoted or
/// the branch folds pruned are dropped and the survivors are renumbered
/// densely, so a spliced-then-promoted callee region stops occupying the
/// frame. Without it (the -O0 mode) a function that has nothing to share
/// is left untouched.
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

/// What a value means to the frame: an address into a movable object's
/// cells (`Some(byte_off)` when the offset from the base is a constant),
/// or nothing this pass tracks.
#[derive(Clone, Copy, PartialEq)]
enum Ref {
    Ptr(i64, Option<i64>),
    Other,
}

/// Resolve `v` to a [`Ref`], memoised, with an in-progress guard against
/// the cyclic references the unordered SSA tape may carry (a cycle
/// resolves to `Other`; the phi feeding it escapes its operands through
/// the use scan). Address arithmetic that cannot stay inside one object
/// records the operand bases in `escaped`: adding two addresses, or
/// subtracting addresses of different objects (C99 6.5.6p9 defines the
/// difference only within one array). A same-object difference is an
/// integer with no reconstructible address, so it neither escapes nor
/// propagates.
fn resolve(
    insts: &[Inst],
    v: ValueId,
    movable: &impl Fn(i64) -> bool,
    state: &mut [u8],
    memo: &mut [Ref],
    escaped: &mut BTreeSet<i64>,
) -> Ref {
    let vi = v as usize;
    if vi >= insts.len() {
        return Ref::Other;
    }
    match state[vi] {
        1 => return Ref::Other,
        2 => return memo[vi],
        _ => {}
    }
    state[vi] = 1;
    let imm = |id: ValueId| match insts.get(id as usize) {
        Some(Inst::Imm(k)) => Some(*k),
        _ => None,
    };
    let r = match &insts[vi] {
        Inst::LocalAddr(s) if movable(*s) => Ref::Ptr(*s, Some(0)),
        Inst::BinopI {
            op: op @ (BinOp::Add | BinOp::Sub),
            lhs,
            rhs_imm,
        } => match resolve(insts, *lhs, movable, state, memo, escaped) {
            Ref::Ptr(b, o) => {
                let k = if *op == BinOp::Add {
                    *rhs_imm
                } else {
                    -*rhs_imm
                };
                Ref::Ptr(b, o.map(|o| o + k))
            }
            _ => Ref::Other,
        },
        Inst::Binop {
            op: BinOp::Add,
            lhs,
            rhs,
        } => {
            let rl = resolve(insts, *lhs, movable, state, memo, escaped);
            let rr = resolve(insts, *rhs, movable, state, memo, escaped);
            match (rl, rr) {
                (Ref::Ptr(a, _), Ref::Ptr(b, _)) => {
                    escaped.insert(a);
                    escaped.insert(b);
                    Ref::Other
                }
                (Ref::Ptr(b, o), _) => Ref::Ptr(b, o.and_then(|o| imm(*rhs).map(|k| o + k))),
                (_, Ref::Ptr(b, o)) => Ref::Ptr(b, o.and_then(|o| imm(*lhs).map(|k| o + k))),
                _ => Ref::Other,
            }
        }
        Inst::Binop {
            op: BinOp::Sub,
            lhs,
            rhs,
        } => {
            let rl = resolve(insts, *lhs, movable, state, memo, escaped);
            let rr = resolve(insts, *rhs, movable, state, memo, escaped);
            match (rl, rr) {
                (Ref::Ptr(a, _), Ref::Ptr(b, _)) => {
                    if a != b {
                        escaped.insert(a);
                        escaped.insert(b);
                    }
                    Ref::Other
                }
                (Ref::Ptr(b, o), _) => Ref::Ptr(b, o.and_then(|o| imm(*rhs).map(|k| o - k))),
                (_, Ref::Ptr(b, _)) => {
                    escaped.insert(b);
                    Ref::Other
                }
                _ => Ref::Other,
            }
        }
        _ => Ref::Other,
    };
    state[vi] = 2;
    memo[vi] = r;
    r
}

/// Group event kinds. `START` (address take) begins the lifetime but
/// touches no memory, so it never interferes by itself.
const READ: u8 = 1;
const WRITE: u8 = 2;
const START: u8 = 4;

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

    // A dynamic-sp function (alloca / VLA) coalesces like any other: the
    // runtime allocations are sp-carved below the frame, disjoint from the
    // fp-relative locals, and a pointer into them resolves to no slot base.
    // The alloca-top slot named by `AllocaInit` is reserved with the
    // prologue-written slots below.
    let alloca_top = f
        .insts
        .iter()
        .find_map(|i| match i {
            Inst::AllocaInit(slot) if *slot > 0 => Some(-*slot),
            _ => None,
        })
        .unwrap_or(0);

    // Leave a realigning function (an automatic object aligned above 16,
    // C11 6.7.5) uncoalesced: its dynamic-sp frame is the expensive shape
    // already and stays as emitted. A 16-aligned region keeps the static
    // frame; its member slots are reserved below and
    // `FunctionSsa::over_aligned` is renumbered in lockstep.
    if f.frame_align > 16 {
        return BTreeMap::new();
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

    let ni = f.insts.len();
    let mut state = alloc::vec![0u8; ni];
    let mut memo = alloc::vec![Ref::Other; ni];
    let mut escaped: BTreeSet<i64> = BTreeSet::new();
    for v in 0..ni {
        resolve(&f.insts, v as ValueId, &movable, &mut state, &mut memo, &mut escaped);
    }
    let refs = memo;
    let base_of = |v: ValueId| match refs.get(v as usize) {
        Some(Ref::Ptr(b, o)) => Some((*b, *o)),
        _ => None,
    };

    // Recorded object sizes: declared aggregates and struct-by-value
    // parameter copies (seeded from the parser) plus synthetic aggregates
    // (`alloc_synthetic_struct`). Pooled inline regions overlay different
    // callees' objects at one base, so the max size bounds every access.
    let mut recorded: BTreeMap<i64, i64> = BTreeMap::new();
    for &(base, cells) in &f.multi_cell_slots {
        if movable(base) && cells >= 1 {
            let e = recorded.entry(base).or_insert(0);
            *e = (*e).max(cells);
        }
    }

    // Use scan: classify every reference to a resolved address, extending
    // each base's byte extent from constant-offset accesses (a parser
    // temporary -- a struct call result, a compound literal -- carries no
    // recorded size) and collecting per-instruction group events. Anything
    // outside the whitelist escapes the base. A variable-offset access
    // stays inside its object (C99 6.5.6p8), so it is admitted only for a
    // base whose size is recorded; an unrecorded base gives it no bound.
    let mut extent: BTreeMap<i64, i64> = BTreeMap::new();
    // (pc, base_or_slot, kind); direct slot events carry the cell offset
    // and are mapped to their group after group formation.
    let mut raw_events: Vec<(u32, i64, u8)> = Vec::new();
    {
        // Constant access at `base+off..+width`: extend the extent; a range
        // reaching below the base leaves the object and escapes it.
        let touch = |extent: &mut BTreeMap<i64, i64>,
                     escaped: &mut BTreeSet<i64>,
                     base: i64,
                     off: Option<i64>,
                     width: i64| {
            match off {
                Some(o) if o >= 0 => {
                    let e = extent.entry(base).or_insert(0);
                    *e = (*e).max(o + width);
                    true
                }
                Some(_) => {
                    escaped.insert(base);
                    false
                }
                None => {
                    if recorded.contains_key(&base) {
                        true
                    } else {
                        escaped.insert(base);
                        false
                    }
                }
            }
        };
        for (i, inst) in f.insts.iter().enumerate().filter(|(i, _)| in_block[*i]) {
            let pc = i as u32;
            match inst {
                // Address arithmetic already consumed by `resolve`.
                Inst::BinopI {
                    op: BinOp::Add | BinOp::Sub,
                    ..
                }
                | Inst::Binop {
                    op: BinOp::Add | BinOp::Sub,
                    ..
                } => {}
                // An integer pointer comparison reads no memory and its
                // result carries no reconstructible address (C99 6.5.8).
                Inst::Binop {
                    op:
                        BinOp::Eq
                        | BinOp::Ne
                        | BinOp::Lt
                        | BinOp::Gt
                        | BinOp::Le
                        | BinOp::Ge
                        | BinOp::Ult
                        | BinOp::Ugt
                        | BinOp::Ule
                        | BinOp::Uge,
                    ..
                } => {}
                Inst::Load {
                    addr,
                    disp,
                    kind,
                    volatile,
                    ..
                } => {
                    if let Some((base, off)) = base_of(*addr) {
                        // A volatile object must keep its own storage across
                        // control transfers the CFG does not model.
                        if *volatile {
                            escaped.insert(base);
                        } else if touch(
                            &mut extent,
                            &mut escaped,
                            base,
                            off.map(|o| o + *disp as i64),
                            load_width(*kind),
                        ) {
                            raw_events.push((pc, base, READ));
                        }
                    }
                }
                Inst::Store {
                    addr,
                    disp,
                    value,
                    kind,
                    volatile,
                    ..
                } => {
                    if let Some((base, off)) = base_of(*addr) {
                        if *volatile {
                            escaped.insert(base);
                        } else if touch(
                            &mut extent,
                            &mut escaped,
                            base,
                            off.map(|o| o + *disp as i64),
                            store_width(*kind),
                        ) {
                            raw_events.push((pc, base, WRITE));
                        }
                    }
                    // A stored address flows to memory this pass does not
                    // follow.
                    if let Some((base, _)) = base_of(*value) {
                        escaped.insert(base);
                    }
                }
                Inst::Mcpy { dst, src, size, .. } => {
                    if let Some((base, off)) = base_of(*dst) {
                        // A variable-offset block write has no field bound;
                        // decline it rather than trust the recorded size.
                        if off.is_some() && touch(&mut extent, &mut escaped, base, off, *size) {
                            raw_events.push((pc, base, WRITE));
                        } else if off.is_none() {
                            escaped.insert(base);
                        }
                    }
                    if let Some((base, off)) = base_of(*src) {
                        if off.is_some() && touch(&mut extent, &mut escaped, base, off, *size) {
                            raw_events.push((pc, base, READ));
                        } else if off.is_none() {
                            escaped.insert(base);
                        }
                    }
                }
                Inst::Call {
                    args,
                    arg_aggs,
                    ret_agg,
                    ret_slot_local,
                    ..
                }
                | Inst::CallIndirect {
                    args,
                    arg_aggs,
                    ret_agg,
                    ret_slot_local,
                    ..
                }
                | Inst::CallExt {
                    args,
                    arg_aggs,
                    ret_agg,
                    ret_slot_local,
                    ..
                } => {
                    for (k, &a) in args.iter().enumerate() {
                        let Some((base, off)) = base_of(a) else {
                            continue;
                        };
                        // A by-value aggregate argument is read (and, on the
                        // memory-passed ABIs, scratched) during the call and
                        // the callee's copy dies at its return, so the call
                        // is a bounded access. A plain pointer argument the
                        // callee may retain escapes.
                        match arg_aggs.get(k).copied().flatten() {
                            Some(ai) if off.is_some() => {
                                let size = f
                                    .agg_descs
                                    .get(ai as usize)
                                    .map(|d| d.size as i64)
                                    .unwrap_or(0);
                                if touch(&mut extent, &mut escaped, base, off, size) {
                                    raw_events.push((pc, base, READ | WRITE));
                                }
                            }
                            _ => {
                                escaped.insert(base);
                            }
                        }
                    }
                    if let Inst::CallIndirect { target, .. } = inst
                        && let Some((base, _)) = base_of(*target)
                    {
                        escaped.insert(base);
                    }
                    // An aggregate return writes its whole result through
                    // the out-pointer; the pointer is emit-internal (never a
                    // C-level lvalue address), so the call bounds it.
                    if let Some(ai) = ret_agg
                        && movable(*ret_slot_local)
                        && let Some(d) = f.agg_descs.get(*ai as usize)
                    {
                        let e = extent.entry(*ret_slot_local).or_insert(0);
                        *e = (*e).max(d.size as i64);
                        raw_events.push((pc, *ret_slot_local, WRITE));
                    }
                }
                Inst::LocalAddr(base) if movable(*base) => {
                    raw_events.push((pc, *base, START));
                }
                Inst::LoadLocal { off, volatile, .. } if movable(*off) => {
                    if *volatile {
                        // Group membership is not known yet; recheck below.
                        raw_events.push((pc, *off, READ));
                        escaped.insert(*off);
                    } else {
                        raw_events.push((pc, *off, READ));
                    }
                }
                Inst::StoreLocal {
                    off,
                    value,
                    volatile,
                    ..
                } if movable(*off) => {
                    raw_events.push((pc, *off, WRITE));
                    if *volatile {
                        escaped.insert(*off);
                    }
                    if let Some((base, _)) = base_of(*value) {
                        escaped.insert(base);
                    }
                }
                other => {
                    // Everything else -- asm, atomics, intrinsics, phis,
                    // segment accesses, non-address arithmetic -- launders
                    // or retains the address.
                    super::reg_alloc::for_each_operand(other, |v| {
                        if let Some((base, _)) = base_of(v) {
                            escaped.insert(base);
                        }
                    });
                }
            }
        }
    }
    // An address reaching a terminator escapes.
    for blk in &f.blocks {
        let mut t = blk.terminator;
        t.for_each_operand_mut(|v| {
            if let Some((base, _)) = base_of(*v) {
                escaped.insert(base);
            }
        });
    }
    // Group formation: one cell interval per address-reached object, from
    // the recorded sizes, the derived extents, and a one-cell interval per
    // bare taken address. Overlapping intervals merge (pooled inline
    // regions overlay objects at one base); adjacent distinct objects stay
    // distinct so they can share.
    let mut ranges: Vec<(i64, i64)> = Vec::new();
    for (&base, &cells) in &recorded {
        ranges.push((base, base + cells - 1));
    }
    for (&base, &bytes) in &extent {
        ranges.push((base, base + (bytes + 7) / 8 - 1));
    }
    for r in refs.iter() {
        if let Ref::Ptr(b, _) = r {
            ranges.push((*b, *b));
        }
    }
    ranges.retain(|&(lo, _)| movable(lo));
    for r in &mut ranges {
        r.1 = r.1.min(-1 - floor);
    }
    ranges.sort_unstable();
    let mut groups: Vec<(i64, i64)> = Vec::new();
    for (lo, hi) in ranges {
        match groups.last_mut() {
            Some(g) if lo <= g.1 => g.1 = g.1.max(hi),
            _ => groups.push((lo, hi)),
        }
    }
    let group_of = |off: i64| -> Option<usize> {
        match groups.binary_search_by(|g| g.0.cmp(&off)) {
            Ok(i) => Some(i),
            Err(i) => (i > 0 && groups[i - 1].1 >= off).then(|| i - 1),
        }
    };
    let mut agg_cells: BTreeSet<i64> = BTreeSet::new();
    for &(lo, hi) in &groups {
        for off in lo..=hi {
            agg_cells.insert(off);
        }
    }

    // Slots the emit reaches only through a `FunctionSsa` field, never an
    // instruction: the prologue stores of the indirect-result pointer, of a
    // narrow float parameter, and of a by-value aggregate parameter all
    // land here, so their lifetime starts at entry.
    let mut field_slots: BTreeSet<i64> = BTreeSet::new();
    if movable(f.indirect_result_slot) {
        field_slots.insert(f.indirect_result_slot);
    }
    for &s in &f.param_local_slots {
        if movable(s) {
            field_slots.insert(s);
        }
    }
    // The alloca-top slot stays dedicated. Its `AllocaInit` operand is a
    // positive slot index the emit reads only as a dynamic-sp flag, so it
    // is not renumbered.
    if movable(alloca_top) {
        field_slots.insert(alloca_top);
    }
    // An over-aligned region member's slot keys region storage, not a frame
    // cell; sharing it would misplace the partner. It is renumbered in
    // lockstep with `over_aligned` below.
    let region_slots: BTreeSet<i64> = f.over_aligned.iter().map(|&(s, _)| s).collect();

    // Split the groups: a group is shareable only when nothing pins it and
    // its every access is on the event tape. An event-free group (all
    // accesses promoted or pruned) is reserved so the compact repack can
    // drop it whole.
    let ng = groups.len();
    let mut shareable = alloc::vec![false; ng];
    let mut has_events = alloc::vec![false; ng];
    for &(_, base, kind) in &raw_events {
        if kind != START
            && let Some(g) = group_of(base)
        {
            has_events[g] = true;
        }
    }
    for (g, &(lo, hi)) in groups.iter().enumerate() {
        let pinned = dedicated
            || !has_events[g]
            || (lo..=hi).any(|off| {
                escaped.contains(&off)
                    || field_slots.contains(&off)
                    || region_slots.contains(&off)
            });
        shareable[g] = !pinned;
    }

    // Reserved single slots and scalar candidates over the remaining
    // directly-accessed cells.
    let mut reserved_single: BTreeSet<i64> = BTreeSet::new();
    let mut candidates: BTreeSet<i64> = BTreeSet::new();
    for (_, inst) in f.insts.iter().enumerate().filter(|(i, _)| in_block[*i]) {
        if let Inst::LoadLocal { off, volatile, .. } | Inst::StoreLocal { off, volatile, .. } =
            inst
            && movable(*off)
            && !agg_cells.contains(off)
        {
            if *volatile || region_slots.contains(off) || field_slots.contains(off) {
                reserved_single.insert(*off);
            } else {
                candidates.insert(*off);
            }
        }
    }
    for &off in &field_slots {
        if !agg_cells.contains(&off) {
            reserved_single.insert(off);
        }
    }
    candidates.retain(|off| !reserved_single.contains(off));
    // Under `dedicated` no slot may share storage; every candidate keeps its
    // own offset through the reserved path, which drops the unreferenced.
    if dedicated {
        reserved_single.append(&mut candidates);
    }
    let n_shareable = shareable.iter().filter(|&&s| s).count();
    // Nothing to share leaves the -O0 frame untouched; the compact mode
    // still repacks so unreferenced slots are dropped.
    if !compact && candidates.len() < 2 && n_shareable < 2 {
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

    // CFG edges, shared by the scalar and the group dataflow. Both are
    // monotone from the empty set and run off a worklist, so the sweep
    // count tracks loop depth and the least fixed point is order-free.
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
    let mut preds: Vec<Vec<usize>> = alloc::vec![Vec::new(); nb];
    for (b, ss) in succ.iter().enumerate() {
        for &s in ss {
            preds[s].push(b);
        }
    }

    // Backward scalar liveness to a fixed point.
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

    // Scalar interference. Walk each block backward; `live` starts at
    // live_out[b]. At a StoreLocal def of slot s, s interferes with every
    // other live slot, then leaves the live set; a LoadLocal use adds its
    // slot.
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

    // Group lifetime: a shareable group is busy from its first event (a
    // store, or the address take that every access data-depends on) to its
    // last read. Partial stores cannot kill a group, so reads gen and
    // nothing kills: two dataflow problems bound the busy range, "a read
    // is still reachable" (backward) and "some event has happened"
    // (forward), and two groups interfere when one has an access inside
    // the other's busy range.
    let sidx: Vec<usize> = (0..ng).filter(|&g| shareable[g]).collect();
    let sg_of: BTreeMap<usize, usize> = sidx.iter().enumerate().map(|(i, &g)| (g, i)).collect();
    let nsg = sidx.len();
    let gwords = nsg.div_ceil(64);
    // Per-block event tape over the shareable groups, in pc order.
    let mut block_events: Vec<Vec<(u32, usize, u8)>> = alloc::vec![Vec::new(); nb];
    {
        let mut events_at: BTreeMap<u32, Vec<(usize, u8)>> = BTreeMap::new();
        for &(pc, base, kind) in &raw_events {
            if let Some(g) = group_of(base)
                && let Some(&sg) = sg_of.get(&g)
            {
                events_at.entry(pc).or_default().push((sg, kind));
            }
        }
        for (b, blk) in f.blocks.iter().enumerate() {
            for (&pc, evs) in events_at.range(blk.inst_range.start..blk.inst_range.end) {
                for &(sg, kind) in evs {
                    block_events[b].push((pc, sg, kind));
                }
            }
        }
    }
    let mut g_read = alloc::vec![0u64; nb * gwords];
    let mut g_event = alloc::vec![0u64; nb * gwords];
    for (b, evs) in block_events.iter().enumerate() {
        for &(_, sg, kind) in evs {
            g_event[b * gwords + sg / 64] |= 1u64 << (sg % 64);
            if kind & READ != 0 {
                g_read[b * gwords + sg / 64] |= 1u64 << (sg % 64);
            }
        }
    }
    // Backward: r_in = has_read | r_out.
    let mut r_in = alloc::vec![0u64; nb * gwords];
    let mut r_out = alloc::vec![0u64; nb * gwords];
    let mut work: Vec<usize> = (0..nb).collect();
    let mut queued = alloc::vec![true; nb];
    while let Some(b) = work.pop() {
        queued[b] = false;
        let mut grew = false;
        for w in 0..gwords {
            let mut out = 0u64;
            for &s in &succ[b] {
                out |= r_in[s * gwords + w];
            }
            r_out[b * gwords + w] = out;
            let v = g_read[b * gwords + w] | out;
            if v != r_in[b * gwords + w] {
                r_in[b * gwords + w] = v;
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
    // Forward: s_out = s_in | has_event.
    let mut s_in = alloc::vec![0u64; nb * gwords];
    let mut s_out = alloc::vec![0u64; nb * gwords];
    let mut work: Vec<usize> = (0..nb).collect();
    let mut queued = alloc::vec![true; nb];
    while let Some(b) = work.pop() {
        queued[b] = false;
        let mut grew = false;
        for w in 0..gwords {
            let mut inb = 0u64;
            for &p in &preds[b] {
                inb |= s_out[p * gwords + w];
            }
            s_in[b * gwords + w] = inb;
            let v = g_event[b * gwords + w] | inb;
            if v != s_out[b * gwords + w] {
                s_out[b * gwords + w] = v;
                grew = true;
            }
        }
        if grew {
            for &s in &succ[b] {
                if !queued[s] {
                    queued[s] = true;
                    work.push(s);
                }
            }
        }
    }
    // Group interference: walk each block's events backward; `live` holds
    // the groups a later read still reaches, `first_ev` the pc of each
    // group's first in-block event. An access of g at pc interferes with
    // every other live group already started at pc; two groups accessed by
    // the same instruction interfere directly.
    let mut g_interfere = alloc::vec![0u64; nsg * gwords];
    let mark = |a: usize, b: usize, gi: &mut Vec<u64>| {
        gi[a * gwords + b / 64] |= 1u64 << (b % 64);
        gi[b * gwords + a / 64] |= 1u64 << (a % 64);
    };
    for (b, evs) in block_events.iter().enumerate() {
        if evs.is_empty() {
            continue;
        }
        let mut first_ev: BTreeMap<usize, u32> = BTreeMap::new();
        for &(pc, sg, _) in evs {
            first_ev.entry(sg).or_insert(pc);
        }
        let mut live = r_out[b * gwords..(b + 1) * gwords].to_vec();
        let mut i = evs.len();
        while i > 0 {
            let hi = i;
            let pc = evs[i - 1].0;
            while i > 0 && evs[i - 1].0 == pc {
                i -= 1;
            }
            let at_pc = &evs[i..hi];
            for &(_, sg, kind) in at_pc {
                if kind == START {
                    continue;
                }
                for w in 0..gwords {
                    let mut m = live[w];
                    if w == sg / 64 {
                        m &= !(1u64 << (sg % 64));
                    }
                    while m != 0 {
                        let h = w * 64 + m.trailing_zeros() as usize;
                        m &= m - 1;
                        let started = s_in[b * gwords + h / 64] & (1u64 << (h % 64)) != 0
                            || first_ev.get(&h).is_some_and(|&fp| fp < pc);
                        if started {
                            mark(sg, h, &mut g_interfere);
                        }
                    }
                }
                for &(_, other, okind) in at_pc {
                    if other != sg && okind != START {
                        mark(sg, other, &mut g_interfere);
                    }
                }
            }
            for &(_, sg, kind) in at_pc {
                if kind & READ != 0 {
                    live[sg / 64] |= 1u64 << (sg % 64);
                }
            }
        }
    }
    // Colour the shareable groups, widest first, so a colour's width is
    // fixed by its first member and later members always fit.
    let mut order: Vec<usize> = (0..nsg).collect();
    let width = |sg: usize| {
        let (lo, hi) = groups[sidx[sg]];
        hi - lo + 1
    };
    order.sort_by_key(|&sg| (-width(sg), groups[sidx[sg]].0));
    let mut g_color = alloc::vec![usize::MAX; nsg];
    let mut g_color_used = alloc::vec![0u32; nsg + 1];
    let mut g_ncolors = 0usize;
    let mut g_color_width: Vec<i64> = Vec::new();
    for (i, &sg) in order.iter().enumerate() {
        let stamp = i as u32 + 1;
        for w in 0..gwords {
            let mut bits = g_interfere[sg * gwords + w];
            while bits != 0 {
                let j = w * 64 + bits.trailing_zeros() as usize;
                bits &= bits - 1;
                if g_color[j] != usize::MAX {
                    g_color_used[g_color[j]] = stamp;
                }
            }
        }
        let mut c = 0;
        while g_color_used[c] == stamp {
            c += 1;
        }
        g_color[sg] = c;
        if c == g_ncolors {
            g_ncolors += 1;
            g_color_width.push(width(sg));
        }
    }

    // Compact the movable region. Magnitudes are assigned just past the
    // floor: reserved groups first (each a contiguous block, order
    // preserved so the base stays the lowest address and interior pointer
    // arithmetic still lands), then reserved singles, then one block per
    // group colour with every member packed against its high end, then one
    // slot per scalar colour. Slots at or below the floor and the
    // parameter slots (positive offsets) are not in the map and keep their
    // offset.
    // In compact mode a reserved group no live instruction or
    // `FunctionSsa` field reaches -- every access was promoted or sits in
    // a deleted block -- is dropped rather than repacked.
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
    for (g, &(lo, hi)) in groups.iter().enumerate() {
        if shareable[g] {
            continue;
        }
        if compact && !(lo..=hi).any(|off| referenced.contains(&off)) {
            continue;
        }
        let width = hi - lo + 1;
        for off in lo..=hi {
            new_off.insert(off, -(next_mag + 1 + (hi - off)));
        }
        next_mag += width;
    }
    for &off in &reserved_single {
        next_mag += 1;
        new_off.insert(off, -next_mag);
    }
    let mut g_color_mag: Vec<i64> = alloc::vec![0; g_ncolors];
    for c in 0..g_ncolors {
        g_color_mag[c] = next_mag;
        next_mag += g_color_width[c];
    }
    // Cells of a colour's shared block map to the members' original
    // offsets; whether any is exclusive is decided per colour below.
    let mut shared_group_cells: BTreeSet<i64> = BTreeSet::new();
    let mut g_members = alloc::vec![0usize; g_ncolors];
    for sg in 0..nsg {
        g_members[g_color[sg]] += 1;
    }
    for sg in 0..nsg {
        let (lo, hi) = groups[sidx[sg]];
        let w = hi - lo + 1;
        let mag = g_color_mag[g_color[sg]];
        for off in lo..=hi {
            new_off.insert(off, -(mag + 1 + (hi - off)));
            if g_members[g_color[sg]] > 1 {
                shared_group_cells.insert(off);
            }
        }
        debug_assert!(w <= g_color_width[g_color[sg]]);
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
    // offset that backs exactly one original slot holds that slot's value
    // for its whole scope, so the location is rewritten to the new offset
    // (exclusive). Storage shared by disjoint lifetimes -- a multi-member
    // scalar colour, or any cell of a multi-member group colour -- has no
    // single stable location, so the slot's location is dropped (shared).
    let mut reverse_count: BTreeMap<i64, usize> = BTreeMap::new();
    for &new in new_off.values() {
        *reverse_count.entry(new).or_insert(0) += 1;
    }
    new_off
        .into_iter()
        .map(|(orig, new)| {
            if reverse_count.get(&new).copied().unwrap_or(0) == 1
                && !shared_group_cells.contains(&orig)
            {
                (orig, Some(new))
            } else {
                (orig, None)
            }
        })
        .collect()
}

fn load_width(kind: crate::c5::ir::LoadKind) -> i64 {
    use crate::c5::ir::LoadKind::*;
    match kind {
        I8 | U8 => 1,
        I16 | U16 => 2,
        I32 | U32 | F32 => 4,
        I64 | F64 => 8,
    }
}

fn store_width(kind: crate::c5::ir::StoreKind) -> i64 {
    use crate::c5::ir::StoreKind::*;
    match kind {
        I8 => 1,
        I16 => 2,
        I32 | F32 => 4,
        I64 | F64 => 8,
    }
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

    /// Two arrays with variable-index accesses in disjoint program ranges
    /// share one block; interleaving their accesses keeps them apart.
    #[test]
    fn disjoint_groups_share_and_overlap_does_not() {
        let arr = |la_slot: i64, base: ValueId| -> Vec<Inst> {
            alloc::vec![
                Inst::LocalAddr(la_slot),
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: base,
                    rhs: 0,
                },
                Inst::Store {
                    addr: base + 1,
                    disp: 0,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                    align: 0,
                },
                Inst::Load {
                    addr: base + 1,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                },
            ]
        };
        // v0 is the variable index (a param-slot load).
        let mut insts = alloc::vec![Inst::LoadLocal {
            off: 2,
            kind: LoadKind::I64,
            volatile: false,
        }];
        insts.extend(arr(-8, 1));
        insts.extend(arr(-4, 5));
        let mut f = one_block(insts, 8, 8);
        f.multi_cell_slots = alloc::vec![(-8, 4), (-4, 4)];
        let map = coalesce(&mut f, true);
        assert_eq!(f.locals, 4, "disjoint 4-cell arrays share one block");
        assert!(matches!(f.insts[1], Inst::LocalAddr(-4)));
        assert!(matches!(f.insts[5], Inst::LocalAddr(-4)));
        assert_eq!(map.get(&-8), Some(&None), "shared storage drops the location");

        // Interleaved: A write, B write, A read, B read.
        let mut insts = alloc::vec![Inst::LoadLocal {
            off: 2,
            kind: LoadKind::I64,
            volatile: false,
        }];
        insts.extend(alloc::vec![
            Inst::LocalAddr(-8),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 1,
                rhs: 0,
            },
            Inst::Store {
                addr: 2,
                disp: 0,
                value: 0,
                kind: StoreKind::I64,
                volatile: false,
                align: 0,
            },
            Inst::LocalAddr(-4),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 4,
                rhs: 0,
            },
            Inst::Store {
                addr: 5,
                disp: 0,
                value: 0,
                kind: StoreKind::I64,
                volatile: false,
                align: 0,
            },
            Inst::Load {
                addr: 2,
                disp: 0,
                kind: LoadKind::I64,
                volatile: false,
                align: 0,
            },
            Inst::Load {
                addr: 5,
                disp: 0,
                kind: LoadKind::I64,
                volatile: false,
                align: 0,
            },
        ]);
        let mut f = one_block(insts, 8, 9);
        f.multi_cell_slots = alloc::vec![(-8, 4), (-4, 4)];
        coalesce(&mut f, true);
        assert_eq!(f.locals, 8, "overlapping lifetimes keep both blocks");
        let (a, b) = match (&f.insts[1], &f.insts[4]) {
            (Inst::LocalAddr(a), Inst::LocalAddr(b)) => (*a, *b),
            _ => unreachable!(),
        };
        assert_ne!(a, b);
    }

    /// A by-value aggregate call argument is a bounded access, so the
    /// object still shares; a plain pointer argument escapes it and pins
    /// dedicated storage for the whole function.
    #[test]
    fn call_argument_escape_is_by_value_aware() {
        use super::super::super::ir::AggDesc;
        let build = |by_value: bool| {
            let mut f = one_block(
                alloc::vec![
                    Inst::LoadLocal {
                        off: 2,
                        kind: LoadKind::I64,
                        volatile: false,
                    },
                    Inst::LocalAddr(-8),
                    Inst::Binop {
                        op: BinOp::Add,
                        lhs: 1,
                        rhs: 0,
                    },
                    Inst::Store {
                        addr: 2,
                        disp: 0,
                        value: 0,
                        kind: StoreKind::I64,
                        volatile: false,
                        align: 0,
                    },
                    Inst::CallExt {
                        binding_idx: 0,
                        args: alloc::vec![1],
                        fp_arg_mask: 0,
                        fp_return: false,
                        arg_aggs: if by_value {
                            alloc::vec![Some(0)]
                        } else {
                            alloc::vec![]
                        },
                        ret_agg: None,
                        ret_slot_local: 0,
                    },
                    Inst::LocalAddr(-4),
                    Inst::Binop {
                        op: BinOp::Add,
                        lhs: 5,
                        rhs: 0,
                    },
                    Inst::Store {
                        addr: 6,
                        disp: 0,
                        value: 0,
                        kind: StoreKind::I64,
                        volatile: false,
                        align: 0,
                    },
                    Inst::Load {
                        addr: 6,
                        disp: 0,
                        kind: LoadKind::I64,
                        volatile: false,
                        align: 0,
                    },
                ],
                8,
                9,
            );
            f.multi_cell_slots = alloc::vec![(-8, 4), (-4, 4)];
            f.agg_descs = alloc::vec![AggDesc {
                size: 32,
                align: 8,
                fields: alloc::vec![],
            }];
            f
        };
        let mut f = build(true);
        coalesce(&mut f, true);
        assert_eq!(f.locals, 4, "a by-value argument does not escape");

        let mut f = build(false);
        coalesce(&mut f, true);
        assert_eq!(f.locals, 8, "a pointer argument escapes for the whole function");
    }

    /// The address take anchors the start of a group's lifetime: a take
    /// hoisted above another group's access forbids sharing, the same
    /// shape with the take after it shares. Locks the escape-independent
    /// half of the lifetime rule.
    #[test]
    fn address_take_starts_lifetime() {
        let seq = |take_first: bool| {
            let (b_take, a) = if take_first { (0, 1) } else { (4, 0) };
            let mut insts = alloc::vec![Inst::Imm(7); 6];
            insts[b_take] = Inst::LocalAddr(-8);
            insts[a] = Inst::LocalAddr(-4);
            insts[a + 1] = Inst::Store {
                addr: a as ValueId,
                disp: 0,
                value: (a + 3) as ValueId % 6,
                kind: StoreKind::I64,
                volatile: false,
                align: 0,
            };
            insts[a + 2] = Inst::Load {
                addr: a as ValueId,
                disp: 0,
                kind: LoadKind::I64,
                volatile: false,
                align: 0,
            };
            insts[5] = Inst::Load {
                addr: b_take as ValueId,
                disp: 0,
                kind: LoadKind::I64,
                volatile: false,
                align: 0,
            };
            let mut f = one_block(insts, 5, 9);
            f.multi_cell_slots = alloc::vec![(-8, 4), (-4, 4)];
            f
        };
        // Store value operand must not be an address; keep it an Imm cell.
        let mut early = seq(true);
        if let Inst::Store { value, .. } = &mut early.insts[2] {
            *value = 3;
        }
        coalesce(&mut early, true);
        assert_eq!(early.locals, 8, "a take before the other group's store interferes");

        let mut late = seq(false);
        if let Inst::Store { value, .. } = &mut late.insts[1] {
            *value = 3;
        }
        coalesce(&mut late, true);
        assert_eq!(late.locals, 4, "a take after the other group's last read shares");
    }

    /// A pointer stored to memory escapes its object, and groups of
    /// different sizes pack against their colour's high end so interior
    /// offsets keep their meaning.
    #[test]
    fn stored_pointer_escapes_and_sizes_pack() {
        let mut f = one_block(
            alloc::vec![
                Inst::LocalAddr(-8),
                Inst::StoreLocal {
                    off: -10,
                    value: 0,
                    kind: StoreKind::I64,
                    volatile: false,
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                },
            ],
            2,
            10,
        );
        f.multi_cell_slots = alloc::vec![(-8, 4)];
        coalesce(&mut f, true);
        assert_eq!(f.locals, 5, "escaped 4-cell block plus the pointer cell");
        assert!(matches!(f.insts[0], Inst::LocalAddr(-4)));

        // A 4-cell and a 2-cell disjoint pair: one 4-cell block, the small
        // group at the high end.
        let mut f = one_block(
            alloc::vec![
                Inst::LocalAddr(-8),
                Inst::Store {
                    addr: 0,
                    disp: 0,
                    value: 4,
                    kind: StoreKind::I64,
                    volatile: false,
                    align: 0,
                },
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                },
                Inst::LocalAddr(-2),
                Inst::Imm(7),
                Inst::Store {
                    addr: 3,
                    disp: 8,
                    value: 4,
                    kind: StoreKind::I64,
                    volatile: false,
                    align: 0,
                },
                Inst::Load {
                    addr: 3,
                    disp: 8,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                },
            ],
            6,
            9,
        );
        f.multi_cell_slots = alloc::vec![(-8, 4), (-2, 2)];
        coalesce(&mut f, true);
        assert_eq!(f.locals, 4);
        assert!(matches!(f.insts[0], Inst::LocalAddr(-4)));
        assert!(
            matches!(f.insts[3], Inst::LocalAddr(-2)),
            "the 2-cell group packs against the colour's high end"
        );
    }
}
