//! Full unrolling of constant-trip loops.
//!
//! Runs under `-O` after `ssa_mem2reg` (loop-carried values are header
//! phis by then) and before the inliner, so a helper whose body was a
//! short counted loop becomes a single-block inline candidate and the
//! cloned call sites join the inliner's worklist. Each expansion is
//! constant-folded before the next one is looked for, which collapses
//! the per-copy `Extend(Imm)` / `BinopI` index chains the clones leave
//! behind: what a copy passes at a call site is a literal only once
//! that chain does, and the interprocedural parameter facts are read
//! off the argument's own instruction.
//!
//! The transform treats the loop body as a pseudo-callee spliced once
//! per iteration, reusing the inliner's remap primitives: its
//! "parameters" are the header's phis (`phi_i = Phi{(preheader,
//! init_i), (latch, r_i)}`) and its "returns" are the latch back-edge
//! operands `r_i`. Copy 0 binds each phi to `init_i`; copy k binds it
//! to copy k-1's remapped `r_i`. A final header-only clone binds the
//! phis to the exit-iteration values so every header-defined value
//! visible past the loop (including the header's `exit_acc`) resolves.
//! All later block-id references rewrite through
//! `remap_blocks::remap_block_ids`.
//!
//! Eligible loops are the walker's canonical counted shape:
//!
//! * a natural loop whose header conditionally exits (`Bz` / `Bnz`
//!   with one successor in the loop, one out) and whose remaining
//!   blocks form a chain back to the header, each with a single
//!   successor inside the loop;
//! * every header phi merges exactly the preheader and latch values;
//! * no volatile access (C99 6.7.3p6 forbids duplicating the access),
//!   `Mcpy`, atomic, intrinsic, `AllocaInit`, or `TailExt` in the
//!   loop; calls are cloned per copy;
//! * the trip count evaluates to a constant `<= MAX_TRIP` by abstract
//!   interpretation of the header condition and latch step over the
//!   shared VM evaluator (`vm::eval`), starting from constant phi
//!   inits;
//! * the expansion is at most `MAX_REGION_INSTS` instructions and
//!   `MAX_REGION_BLOCKS` blocks.
//!
//! A chain block may end in a conditional branch whose other successor
//! leaves the loop -- the shape a `break` (C99 6.8.6.3) compiles to.
//! Each copy then keeps its own branch, so the expansion is a sequence
//! of blocks rather than one: a copy's block ends where a mid-body
//! branch ends it, and with no such branch the whole region collapses
//! to the single block the counted shape produced before. The header's
//! own branch never ends a block: the trip count decided which way it
//! goes in every copy.
//!
//! A value the loop defines and a block past it reads has to be
//! rebuilt where the copies rejoin. SSA dominance puts every such read
//! in a block the loop is the only way into, so the rebuild runs over
//! exactly those blocks: each records the exit edges reaching it, takes
//! a phi merging the per-copy clones where more than one does, and
//! forwards the clone where one does. Without a mid-body exit every
//! block sees the same single edge and nothing is rebuilt.
//!
//! Functions with a computed goto or a `BlockAddr` (block ids shift),
//! or a returns-twice call (cloned call sites would multiply the
//! setjmp return points), keep their loops rolled.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec;
use alloc::vec::Vec;

use super::super::ssa::mem2reg::{self, dominators, predecessors};
use super::super::ssa::reg_alloc::produces_fp_result;
use super::inline::{map_v, remap_inst_operands};
use super::layout::{natural_loops, rpo_numbers};
use crate::c5::ir::{Block, BlockId, FunctionSsa, Inst, LoadKind, NO_VALUE, Terminator, ValueId};
use crate::c5::vm::eval;

/// Largest constant trip count that unrolls.
const MAX_TRIP: usize = 16;
/// Iteration bound while counting trips; a condition still true past
/// this is treated as unknown.
const COUNT_CAP: usize = 64;
/// Cap on the expanded region: `(trip + 1) * loop_insts`, an upper
/// bound on what the copies emit. Growth is the only size axis; the
/// rolled body size is not a separate gate, since a large body that
/// iterates a few times expands by almost nothing.
const MAX_REGION_INSTS: usize = 600;
/// Cap on the expansion of a loop whose body branches out of it. Half
/// the budget above, because a copy runs only if no exit before it
/// fired: the growth is paid for whether or not the trip count is
/// reached. Measured over `tests/snapshots`: the full budget lets a
/// trip-12 body of soft-float conversions expand, which quadruples
/// that function's frame.
const MAX_EXIT_REGION_INSTS: usize = MAX_REGION_INSTS / 2;
/// Cap on the blocks the expansion emits, bounding the per-block cost
/// of every pass downstream of it.
const MAX_REGION_BLOCKS: usize = 24;
/// Largest block count a loop may have. A body with mid-body exits
/// needs more than the counted shape's header / body / latch.
const MAX_LOOP_BLOCKS: usize = 6;
/// Per-function bounds: loops expanded, and the instruction count
/// past which no further loop is attempted.
const MAX_LOOPS_PER_FUNC: usize = 16;
const MAX_FUNC_INSTS: usize = 4096;

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        run_one(func);
    }
}

fn run_one(func: &mut FunctionSsa) {
    // Block ids shift when the loop's blocks are replaced: a computed
    // goto's label set and any `BlockAddr` would need retargeting
    // through a block that no longer exists once its clones are
    // emitted. A returns-twice call site must stay unique per source
    // occurrence (C99 7.13.2.1p3).
    if !func.computed_goto_targets.is_empty()
        || func.has_returns_twice_call
        || func.insts.iter().any(|i| matches!(i, Inst::BlockAddr(_)))
        // An asm-goto label edge may enter a loop body from outside the
        // loop; expanding iterations would bind it to one copy.
        || func
            .blocks
            .iter()
            .any(|b| matches!(b.terminator, Terminator::AsmGoto { .. }))
    {
        return;
    }
    for _ in 0..MAX_LOOPS_PER_FUNC {
        if func.insts.len() > MAX_FUNC_INSTS {
            return;
        }
        let Some(plan) = find_unrollable(func) else {
            return;
        };
        #[cfg(feature = "codegen_test")]
        if std::env::var("BADC_LOG_UNROLL").is_ok() {
            eprintln!(
                "[unroll] {n}: header=b{h} chain={c:?} exits={e:?} trip={t} loop_insts={i}",
                n = func.name,
                h = plan.shape.header,
                c = plan.shape.chain,
                e = plan.shape.chain_exits,
                t = plan.shape.trip,
                i = shape_inst_count(func, &plan.shape)
            );
        }
        expand(func, &plan);
        // Record that a loop was expanded: the post-inline scalar
        // promotion re-runs mem2reg only on functions where unrolling
        // turned an array subscript into a constant offset.
        func.did_unroll = true;
        // Fold the copies' index chains before the next round reads a
        // loop bound and before the passes between here and the
        // inliner read a call site's arguments.
        super::constfold::run_one(func);
    }
}

/// A loop that passed every gate. `chain` is the loop's non-header
/// blocks in execution order; the last entry is the latch.
struct LoopShape {
    header: BlockId,
    chain: Vec<BlockId>,
    /// Target of the header's own exit edge.
    exit: BlockId,
    /// Per chain block, the block its branch leaves the loop for;
    /// `None` when it ends in an unconditional edge.
    chain_exits: Vec<Option<BlockId>>,
    /// One entry per header phi: `(phi id, preheader init operand,
    /// latch back-edge operand)`.
    phis: Vec<(ValueId, ValueId, ValueId)>,
    trip: usize,
}

impl LoopShape {
    fn blocks(&self) -> impl Iterator<Item = BlockId> + '_ {
        core::iter::once(self.header).chain(self.chain.iter().copied())
    }

    /// The block `b`'s terminator leaves the loop for, if any. The
    /// header's exit edge is not one of these: the trip count decides
    /// it, so no copy branches on it.
    fn branch_out(&self, b: BlockId) -> Option<BlockId> {
        self.chain
            .iter()
            .position(|&c| c == b)
            .and_then(|j| self.chain_exits[j])
    }

    /// Blocks the expansion emits: one per copy, plus one more after
    /// every mid-body branch.
    fn region_blocks(&self) -> usize {
        self.trip * self.chain_exits.iter().filter(|e| e.is_some()).count() + 1
    }
}

fn find_unrollable(func: &FunctionSsa) -> Option<Expansion> {
    if func.blocks.len() < 3 {
        return None;
    }
    let preds = predecessors(func);
    let idom = dominators(func);
    let rpo = rpo_numbers(func);
    let loops = natural_loops(func, &idom, &preds, &rpo);
    loops.iter().find_map(|l| {
        let shape = try_shape(func, l.header, &l.body, &preds).filter(|s| {
            let cap = if s.chain_exits.iter().any(Option::is_some) {
                MAX_EXIT_REGION_INSTS
            } else {
                MAX_REGION_INSTS
            };
            s.trip <= MAX_TRIP
                && (s.trip + 1) * shape_inst_count(func, s) <= cap
                && s.region_blocks() <= MAX_REGION_BLOCKS
        })?;
        Expansion::build(func, shape, &preds)
    })
}

fn shape_inst_count(func: &FunctionSsa, s: &LoopShape) -> usize {
    s.blocks()
        .map(|b| {
            let r = &func.blocks[b as usize].inst_range;
            (r.end - r.start) as usize
        })
        .sum()
}

fn try_shape(
    func: &FunctionSsa,
    header: BlockId,
    body: &[BlockId],
    preds: &[Vec<BlockId>],
) -> Option<LoopShape> {
    let h = header;
    // Entry block 0 has the function's implicit entry edge; a loop
    // block there has an extra predecessor the phi gate cannot see.
    if h == 0 || body.len() < 2 || body.len() > MAX_LOOP_BLOCKS {
        return None;
    }
    // The header conditionally exits: one successor in the loop, one out.
    let (cond, s1, s2, is_bz) = match func.blocks[h as usize].terminator {
        Terminator::Bz {
            cond,
            target,
            fall_through,
        } => (cond, target, fall_through, true),
        Terminator::Bnz {
            cond,
            target,
            fall_through,
        } => (cond, target, fall_through, false),
        _ => return None,
    };
    let in_body = |b: BlockId| body.binary_search(&b).is_ok();
    let (enter, exit) = match (in_body(s1), in_body(s2)) {
        (true, false) => (s1, s2),
        (false, true) => (s2, s1),
        _ => return None,
    };
    // The non-header blocks form a chain back to the header, each with
    // exactly one successor inside the loop; a second in-loop successor
    // is a multi-block body and stays rolled.
    let mut chain: Vec<BlockId> = Vec::new();
    let mut chain_exits: Vec<Option<BlockId>> = Vec::new();
    let mut cur = enter;
    while cur != h {
        if cur == 0 || chain.contains(&cur) || chain.len() >= body.len() {
            return None;
        }
        chain.push(cur);
        let (next, out) = match func.blocks[cur as usize].terminator {
            Terminator::Jmp(t) | Terminator::FallThrough(t) => (t, None),
            Terminator::Bz {
                target,
                fall_through,
                ..
            }
            | Terminator::Bnz {
                target,
                fall_through,
                ..
            } => match (in_body(target), in_body(fall_through)) {
                (true, false) => (target, Some(fall_through)),
                (false, true) => (fall_through, Some(target)),
                _ => return None,
            },
            _ => return None,
        };
        // The entry block's implicit entry edge is in no predecessor
        // list, so the rebuild cannot see what reaches it.
        if out == Some(0) {
            return None;
        }
        chain_exits.push(out);
        cur = next;
    }
    if chain.len() + 1 != body.len() || chain.iter().any(|b| !in_body(*b)) {
        return None;
    }
    let latch = *chain.last()?;
    // Exactly two header predecessors: the latch and one preheader
    // outside the loop. More entries mean a side entry the phi
    // rewrite cannot express.
    let hp = &preds[h as usize];
    if hp.len() != 2 {
        return None;
    }
    let pre = match (hp[0] == latch, hp[1] == latch) {
        (true, false) => hp[1],
        (false, true) => hp[0],
        _ => return None,
    };
    if in_body(pre) {
        return None;
    }
    let mut phis: Vec<(ValueId, ValueId, ValueId)> = Vec::new();
    for b in core::iter::once(h).chain(chain.iter().copied()) {
        for pc in func.blocks[b as usize].inst_range.clone() {
            match &func.insts[pc as usize] {
                Inst::Phi { incoming, .. } => {
                    if b != h || incoming.len() != 2 {
                        return None;
                    }
                    let (mut init, mut back) = (None, None);
                    for &(pb, v) in incoming {
                        if pb == latch {
                            back = Some(v);
                        } else if pb == pre {
                            init = Some(v);
                        } else {
                            return None;
                        }
                    }
                    let (init, back) = (init?, back?);
                    if init == NO_VALUE || back == NO_VALUE {
                        return None;
                    }
                    phis.push((pc, init, back));
                }
                // A volatile access is performed strictly per the
                // abstract machine (C99 5.1.2.3p2 / 6.7.3p6); cloning
                // duplicates it.
                Inst::Load { volatile: true, .. }
                | Inst::Store { volatile: true, .. }
                | Inst::LoadLocal { volatile: true, .. }
                | Inst::StoreLocal { volatile: true, .. } => return None,
                Inst::Mcpy { .. }
                | Inst::AtomicRmw { .. }
                | Inst::AtomicCas { .. }
                | Inst::Intrinsic { .. }
                | Inst::AllocaInit(_)
                | Inst::TailExt(_)
                | Inst::BlockAddr(_) => return None,
                _ => {}
            }
        }
    }
    if phis.is_empty() {
        return None;
    }
    // Each init must be defined outside the loop so copy 0 can
    // reference it directly.
    let in_loop = |v: ValueId| {
        core::iter::once(h)
            .chain(chain.iter().copied())
            .any(|b| func.blocks[b as usize].inst_range.contains(&v))
    };
    if phis.iter().any(|&(_, init, _)| in_loop(init)) {
        return None;
    }
    let trip = count_trips(func, cond, s1, exit, is_bz, &phis)?;
    Some(LoopShape {
        header: h,
        chain,
        exit,
        chain_exits,
        phis,
        trip,
    })
}

/// Constant evaluation of `v` under phi bindings `state`, over the
/// shared VM operator semantics. Values outside the binding set that
/// are not constant-computable (loads, calls, other phis, address
/// immediates, f32 patterns) are unknown.
fn eval_value(
    func: &FunctionSsa,
    v: ValueId,
    state: &BTreeMap<ValueId, Option<i64>>,
    cache: &mut BTreeMap<ValueId, Option<i64>>,
    depth: usize,
) -> Option<i64> {
    if v == NO_VALUE || depth > 64 {
        return None;
    }
    if let Some(&s) = state.get(&v) {
        return s;
    }
    if let Some(&c) = cache.get(&v) {
        return c;
    }
    if func.f32_values.get(v as usize).copied().unwrap_or(false) {
        return None;
    }
    let r = match func.insts.get(v as usize)? {
        Inst::Imm(k) => Some(*k),
        Inst::Extend { value, kind } => {
            eval_value(func, *value, state, cache, depth + 1).map(|x| eval::eval_extend(x, *kind))
        }
        Inst::BinopI { op, lhs, rhs_imm } => eval_value(func, *lhs, state, cache, depth + 1)
            .and_then(|l| eval::fold_binop(*op, l, *rhs_imm)),
        Inst::Binop { op, lhs, rhs } => eval_value(func, *lhs, state, cache, depth + 1)
            .zip(eval_value(func, *rhs, state, cache, depth + 1))
            .and_then(|(l, r)| eval::fold_binop(*op, l, r)),
        _ => None,
    };
    cache.insert(v, r);
    r
}

/// Count iterations by abstract interpretation: bind each phi to its
/// constant init, evaluate the header condition, and step every phi
/// through its latch operand. A phi whose value stops being constant
/// carries `None` and poisons only what reads it. Unknown condition
/// or more than `COUNT_CAP` iterations means no constant trip.
///
/// A mid-body exit only shortens the run, so the header's count stays
/// an upper bound on the copies that can execute.
fn count_trips(
    func: &FunctionSsa,
    cond: ValueId,
    target: BlockId,
    exit: BlockId,
    is_bz: bool,
    phis: &[(ValueId, ValueId, ValueId)],
) -> Option<usize> {
    let mut state: BTreeMap<ValueId, Option<i64>> = BTreeMap::new();
    {
        let empty = BTreeMap::new();
        let mut cache = BTreeMap::new();
        for &(phi, init, _) in phis {
            let v = eval_value(func, init, &empty, &mut cache, 0);
            state.insert(phi, v);
        }
    }
    for k in 0..=COUNT_CAP {
        let mut cache = BTreeMap::new();
        let c = eval_value(func, cond, &state, &mut cache, 0)?;
        // The branch takes `target` when the condition fires (`Bz`:
        // cond == 0; `Bnz`: cond != 0) and the fall-through arm
        // otherwise; the loop exits when that successor is `exit`.
        let fired = if is_bz { c == 0 } else { c != 0 };
        if fired == (target == exit) {
            return Some(k);
        }
        if k == COUNT_CAP {
            return None;
        }
        let next: Vec<(ValueId, Option<i64>)> = phis
            .iter()
            .map(|&(phi, _, back)| (phi, eval_value(func, back, &state, &mut cache, 0)))
            .collect();
        for (phi, v) in next {
            state.insert(phi, v);
        }
    }
    None
}

/// Exit edges reaching a block. Only whether more than one does, and
/// which one when just one does, decides how a value is rebuilt.
#[derive(Clone, Copy, PartialEq, Eq, Default)]
struct Sources {
    /// `(region block, copy)` of the first edge seen.
    one: Option<(usize, usize)>,
    many: bool,
}

impl Sources {
    fn add(&mut self, e: (usize, usize)) -> bool {
        match self.one {
            None => {
                self.one = Some(e);
                true
            }
            Some(f) if f != e && !self.many => {
                self.many = true;
                true
            }
            _ => false,
        }
    }

    fn merge(&mut self, other: &Sources) -> bool {
        let mut changed = other.one.is_some_and(|e| self.add(e));
        if other.many && !self.many {
            self.many = true;
            changed = true;
        }
        changed
    }
}

/// The expansion's plan: the loop's blocks in copy order, the emitted
/// block each entry lands in, and the rebuild of the values the copies
/// carry past the loop.
struct Expansion {
    shape: LoopShape,
    /// Block count of the function the plan was built against; emitted
    /// region block `r` is named by the block id `n_blocks + r`.
    n_blocks: usize,
    /// Schedule entries per copy: the header plus the chain.
    stride: usize,
    /// `(copy, loop block)` in execution order; the last entry is the
    /// header-only final copy.
    sched: Vec<(usize, BlockId)>,
    /// Emitted region block per schedule entry.
    region_of: Vec<u32>,
    n_region: usize,
    /// Predecessors of the function the plan was built against.
    preds: Vec<Vec<BlockId>>,
    /// Exit edges reaching each block the loop is the only way into.
    sources: Vec<Sources>,
    /// Per such block, the loop values a read past the loop needs
    /// rebuilt there.
    need: BTreeMap<BlockId, BTreeMap<ValueId, LoadKind>>,
    /// Dense position of every loop instruction, header phis included.
    loop_pos: Vec<u32>,
    chain_set: BTreeSet<BlockId>,
}

impl Expansion {
    /// `None` when a value the loop defines is read where the rebuild
    /// cannot reach or in a register file it cannot name.
    fn build(func: &FunctionSsa, shape: LoopShape, preds: &[Vec<BlockId>]) -> Option<Expansion> {
        let h = shape.header;
        let n_blocks = func.blocks.len();
        let stride = 1 + shape.chain.len();
        let mut loop_pos: Vec<u32> = vec![u32::MAX; func.insts.len()];
        let mut loop_len = 0u32;
        for b in shape.blocks() {
            for pc in func.blocks[b as usize].inst_range.clone() {
                loop_pos[pc as usize] = loop_len;
                loop_len += 1;
            }
        }
        let mut sched: Vec<(usize, BlockId)> = Vec::with_capacity(shape.trip * stride + 1);
        for k in 0..shape.trip {
            sched.push((k, h));
            sched.extend(shape.chain.iter().map(|&c| (k, c)));
        }
        sched.push((shape.trip, h));
        // A copy stays one block until a mid-body branch ends it; with
        // no such branch the region is the single block the counted
        // shape produced.
        let mut region_of: Vec<u32> = Vec::with_capacity(sched.len());
        let mut r = 0u32;
        for i in 0..sched.len() {
            if i > 0 && shape.branch_out(sched[i - 1].1).is_some() {
                r += 1;
            }
            region_of.push(r);
        }
        let n_region = r as usize + 1;
        let chain_set: BTreeSet<BlockId> = shape.chain.iter().copied().collect();
        let in_loop = |b: BlockId| b == h || chain_set.contains(&b);
        // Without a mid-body exit every read past the loop reaches the
        // final copy over the header's one edge, so nothing is rebuilt.
        let multi_exit = shape.chain_exits.iter().any(Option::is_some);

        let mut sources: Vec<Sources> = vec![Sources::default(); n_blocks];
        let mut need: BTreeMap<BlockId, BTreeMap<ValueId, LoadKind>> = BTreeMap::new();
        if multi_exit {
            // Blocks the loop is the only way into: every predecessor
            // is a loop block or another such block. SSA dominance puts
            // every read of a loop value in one of them, so this is
            // where the rebuild runs.
            let mut fed: Vec<bool> = (0..n_blocks)
                .map(|b| b != 0 && !in_loop(b as BlockId) && !preds[b].is_empty())
                .collect();
            loop {
                let mut changed = false;
                for b in 0..n_blocks {
                    if fed[b] && !preds[b].iter().all(|&p| in_loop(p) || fed[p as usize]) {
                        fed[b] = false;
                        changed = true;
                    }
                }
                if !changed {
                    break;
                }
            }

            // Exit edges, then their forward closure over those blocks.
            let mut seed = |t: BlockId, e: (usize, usize)| {
                if fed[t as usize] {
                    sources[t as usize].add(e);
                }
            };
            for (i, &(k, b)) in sched.iter().enumerate() {
                if let Some(t) = shape.branch_out(b) {
                    seed(t, (region_of[i] as usize, k));
                }
            }
            seed(shape.exit, (n_region - 1, shape.trip));
            loop {
                let mut changed = false;
                for b in 0..n_blocks {
                    if !fed[b] || sources[b] == Sources::default() {
                        continue;
                    }
                    let from = sources[b];
                    for s in mem2reg::successors(
                        &func.blocks[b].terminator,
                        &func.computed_goto_targets,
                        &func.jump_tables,
                    ) {
                        if fed[s as usize] {
                            changed |= sources[s as usize].merge(&from);
                        }
                    }
                }
                if !changed {
                    break;
                }
            }

            // Values read past the loop, propagated back to every block
            // on the way from an exit edge to the read.
            let mut work: Vec<(BlockId, ValueId, LoadKind)> = Vec::new();
            let mut demand =
                |b: BlockId, v: ValueId, kind: Option<LoadKind>, w: &mut Vec<_>| -> bool {
                    if loop_pos.get(v as usize).copied().unwrap_or(u32::MAX) == u32::MAX {
                        return true;
                    }
                    let (Some(kind), true) = (kind.or_else(|| phi_kind(func, v)), fed[b as usize])
                    else {
                        return false;
                    };
                    if need.entry(b).or_default().insert(v, kind).is_none() {
                        w.push((b, v, kind));
                    }
                    true
                };
            for (bi, block) in func.blocks.iter().enumerate() {
                let bi = bi as BlockId;
                if in_loop(bi) {
                    continue;
                }
                let mut ok = true;
                for pc in block.inst_range.clone() {
                    match &func.insts[pc as usize] {
                        Inst::Phi { incoming, kind } => {
                            for &(p, v) in incoming {
                                if !in_loop(p) {
                                    ok &= demand(p, v, Some(*kind), &mut work);
                                }
                            }
                        }
                        inst => inst.for_each_operand(|v| ok &= demand(bi, v, None, &mut work)),
                    }
                }
                block
                    .terminator
                    .for_each_operand(|v| ok &= demand(bi, v, None, &mut work));
                ok &= demand(bi, block.exit_acc, None, &mut work);
                if !ok {
                    return None;
                }
            }
            while let Some((b, v, kind)) = work.pop() {
                for &p in &preds[b as usize] {
                    if !in_loop(p) && !demand(p, v, Some(kind), &mut work) {
                        return None;
                    }
                }
            }
            // A rebuild with no exit edge reaching it names a block the
            // expansion leaves unreachable -- a zero trip count drops
            // every mid-body exit -- and no id answers its reads.
            if need
                .keys()
                .any(|&b| sources[b as usize] == Sources::default())
            {
                return None;
            }
        }
        Some(Expansion {
            shape,
            n_blocks,
            stride,
            sched,
            region_of,
            n_region,
            // Read only by the rebuild, which a single-exit shape skips.
            preds: if multi_exit {
                preds.to_vec()
            } else {
                Vec::new()
            },
            sources,
            need,
            loop_pos,
            chain_set,
        })
    }

    /// Block id naming emitted region block `r`; `remap_block_ids`
    /// resolves it with every other block reference.
    fn virt(&self, r: usize) -> BlockId {
        (self.n_blocks + r) as BlockId
    }

    fn in_loop(&self, v: ValueId) -> bool {
        self.loop_pos.get(v as usize).copied().unwrap_or(u32::MAX) != u32::MAX
    }

    /// Copy `k`'s view of `v`: its clone when the loop defines it, the
    /// running remap otherwise.
    fn clone_at(&self, v: ValueId, k: usize, clones: &[Vec<ValueId>], cur: &[ValueId]) -> ValueId {
        match self.loop_pos.get(v as usize).copied().unwrap_or(u32::MAX) {
            u32::MAX => map_v(v, cur),
            pos => clones[k][pos as usize],
        }
    }

    /// The values `v` arrives with on the edges into `b`: one per copy
    /// of a loop predecessor, and the rebuilt value of any other.
    fn edge_values(
        &self,
        b: BlockId,
        v: ValueId,
        clones: &[Vec<ValueId>],
        cur: &[ValueId],
        rebuilt: &BTreeMap<(BlockId, ValueId), ValueId>,
    ) -> Vec<(BlockId, ValueId)> {
        let mut out = Vec::new();
        for &p in &self.preds[b as usize] {
            self.pred_values(p, v, clones, cur, rebuilt, &mut out);
        }
        out
    }

    fn pred_values(
        &self,
        p: BlockId,
        v: ValueId,
        clones: &[Vec<ValueId>],
        cur: &[ValueId],
        rebuilt: &BTreeMap<(BlockId, ValueId), ValueId>,
        out: &mut Vec<(BlockId, ValueId)>,
    ) {
        if p == self.shape.header {
            let x = self.clone_at(v, self.shape.trip, clones, cur);
            if x != NO_VALUE {
                out.push((self.virt(self.n_region - 1), x));
            }
        } else if let Some(j) = self.shape.chain.iter().position(|&c| c == p) {
            for k in 0..self.shape.trip {
                let x = self.clone_at(v, k, clones, cur);
                if x != NO_VALUE {
                    out.push((
                        self.virt(self.region_of[k * self.stride + 1 + j] as usize),
                        x,
                    ));
                }
            }
        } else {
            let x = rebuilt.get(&(p, v)).copied().unwrap_or(map_v(v, cur));
            // A loop value with no rebuilt id at `p` reaches it over no
            // edge the trip count kept, so the predecessor is gone too.
            if x != NO_VALUE || !self.in_loop(v) {
                out.push((p, x));
            }
        }
    }

    /// Rebuild an outside phi's incoming list against the expansion.
    fn rebuild_incoming(
        &self,
        incoming: &[(BlockId, ValueId)],
        clones: &[Vec<ValueId>],
        cur: &[ValueId],
        rebuilt: &BTreeMap<(BlockId, ValueId), ValueId>,
    ) -> Vec<(BlockId, ValueId)> {
        let mut out = Vec::with_capacity(incoming.len());
        for &(p, v) in incoming {
            self.pred_values(p, v, clones, cur, rebuilt, &mut out);
        }
        out
    }
}

/// The register-file class a rebuilt value's phi carries. Integer
/// values move as `I64`, the whole integer class; a floating value
/// needs the width its definition names, and one that names none keeps
/// the loop rolled.
fn phi_kind(func: &FunctionSsa, v: ValueId) -> Option<LoadKind> {
    let inst = func.insts.get(v as usize)?;
    if !produces_fp_result(inst) {
        return Some(LoadKind::I64);
    }
    match inst {
        Inst::Load { kind, .. }
        | Inst::LoadLocal { kind, .. }
        | Inst::LoadIndexed { kind, .. }
        | Inst::SegLoad { kind, .. }
        | Inst::ParamRef { kind, .. }
        | Inst::Phi { kind, .. } => Some(*kind),
        _ if func.f32_values.get(v as usize).copied().unwrap_or(false) => Some(LoadKind::F32),
        _ => None,
    }
}

/// Rebuild `func` with the loop's blocks replaced by the copies the
/// trip count proved, and the values crossing each exit edge merged
/// where the copies rejoin.
fn expand(func: &mut FunctionSsa, plan: &Expansion) {
    let shape = &plan.shape;
    let h = shape.header;
    let n_old = func.insts.len();
    let n_blocks = func.blocks.len();
    let loop_len = plan.loop_pos.iter().filter(|&&p| p != u32::MAX).count();
    let mut clone_ids: Vec<Vec<ValueId>> = vec![vec![NO_VALUE; loop_len]; shape.trip + 1];

    // Old -> new block ids. The chain blocks disappear and the header's
    // id opens the emitted region; ids past it shift by the region's
    // block count. The removed ids alias the region's first block so
    // the map is total; nothing references them after the rebuild.
    let mut new_bid: Vec<BlockId> = vec![BlockId::MAX; n_blocks + plan.n_region];
    let mut next = 0u32;
    let mut base = 0u32;
    for b in 0..n_blocks as BlockId {
        if plan.chain_set.contains(&b) {
            continue;
        }
        new_bid[b as usize] = next;
        if b == h {
            base = next;
            next += plan.n_region as u32;
        } else {
            next += 1;
        }
    }
    for &c in &plan.chain_set {
        new_bid[c as usize] = base;
    }
    for r in 0..plan.n_region {
        new_bid[n_blocks + r] = base + r as u32;
    }

    let mut new_insts: Vec<Inst> = Vec::new();
    let mut new_inst_src: Vec<(u32, u32)> = Vec::new();
    let mut new_f32: Vec<bool> = Vec::new();
    let mut new_blocks: Vec<Block> = Vec::new();
    // Running value remap. Loop instructions are overwritten per copy,
    // so between copies the entry holds the previous copy's clone --
    // exactly the back-edge view the next copy's phi bindings read.
    // After the region the header entries hold the final clone. The
    // block array is not ordered definitions-before-uses, so emission
    // runs to a fixed point as the inliner's splice does: ids are
    // structurally stable across passes and each pass resolves one
    // forward-reference level.
    let mut cur: Vec<ValueId> = vec![NO_VALUE; n_old];
    // Rebuilt view of a loop value at a block past the loop.
    let mut rebuilt: BTreeMap<(BlockId, ValueId), ValueId> = BTreeMap::new();
    let mut guard = n_old + 4;
    loop {
        new_insts.clear();
        new_inst_src.clear();
        new_f32.clear();
        new_blocks.clear();
        let (was_cur, was_clones, was_rebuilt) = (cur.clone(), clone_ids.clone(), rebuilt.clone());
        for ob in 0..n_blocks as BlockId {
            if plan.chain_set.contains(&ob) {
                continue;
            }
            if ob == h {
                emit_region(
                    func,
                    plan,
                    &mut clone_ids,
                    &mut cur,
                    &mut new_insts,
                    &mut new_inst_src,
                    &mut new_f32,
                    &mut new_blocks,
                );
            } else {
                emit_outside(
                    func,
                    plan,
                    ob,
                    &clone_ids,
                    &mut cur,
                    &mut rebuilt,
                    &mut new_insts,
                    &mut new_inst_src,
                    &mut new_f32,
                    &mut new_blocks,
                );
            }
        }
        if cur == was_cur && clone_ids == was_clones && rebuilt == was_rebuilt {
            break;
        }
        guard -= 1;
        if guard == 0 {
            break;
        }
    }

    // Extern-ref carry: a reference on a loop instruction lands on
    // every clone (each cloned `Call` / `ImmData` / `ImmCode` /
    // `TlsAddr` still names the cross-TU symbol); a reference outside
    // retargets through the final remap.
    let retarget = |refs: &[(u32, u32)]| -> Vec<(u32, u32)> {
        let mut out = Vec::new();
        for &(idx, sym) in refs {
            let pos = plan.loop_pos.get(idx as usize).copied().unwrap_or(u32::MAX);
            if pos != u32::MAX {
                for ids in clone_ids.iter() {
                    let nv = ids[pos as usize];
                    if nv != NO_VALUE {
                        out.push((nv, sym));
                    }
                }
            } else {
                let nv = map_v(idx, &cur);
                if nv != NO_VALUE {
                    out.push((nv, sym));
                }
            }
        }
        out
    };
    func.extern_call_refs = retarget(&func.extern_call_refs);
    func.extern_imm_code_refs = retarget(&func.extern_imm_code_refs);
    func.extern_imm_data_refs = retarget(&func.extern_imm_data_refs);
    func.extern_tls_refs = retarget(&func.extern_tls_refs);

    func.insts = new_insts;
    func.inst_src = new_inst_src;
    func.f32_values = new_f32;
    func.blocks = new_blocks;
    super::remap_blocks::remap_block_ids(func, &new_bid);
}

/// Emit the copies in place of the loop's blocks.
#[allow(clippy::too_many_arguments)]
fn emit_region(
    func: &FunctionSsa,
    plan: &Expansion,
    clone_ids: &mut [Vec<ValueId>],
    cur: &mut [ValueId],
    new_insts: &mut Vec<Inst>,
    new_inst_src: &mut Vec<(u32, u32)>,
    new_f32: &mut Vec<bool>,
    new_blocks: &mut Vec<Block>,
) {
    let shape = &plan.shape;
    let mut start = new_insts.len() as u32;
    let mut start_pc = func.blocks[shape.header as usize].start_pc;
    for (i, &(k, b)) in plan.sched.iter().enumerate() {
        if b == shape.header {
            // Parallel phi binding: read every source before writing,
            // so one phi's new binding cannot feed another's within the
            // same copy. The binding is the copy's clone of the phi.
            let binds: Vec<(ValueId, ValueId)> = shape
                .phis
                .iter()
                .map(|&(phi, init, back)| (phi, map_v(if k == 0 { init } else { back }, cur)))
                .collect();
            for (phi, val) in binds {
                cur[phi as usize] = val;
                clone_ids[k][plan.loop_pos[phi as usize] as usize] = val;
            }
        }
        for pc in func.blocks[b as usize].inst_range.clone() {
            if matches!(func.insts[pc as usize], Inst::Phi { .. }) {
                continue;
            }
            let mut inst = func.insts[pc as usize].clone();
            remap_inst_operands(&mut inst, cur);
            let id = new_insts.len() as ValueId;
            cur[pc as usize] = id;
            clone_ids[k][plan.loop_pos[pc as usize] as usize] = id;
            new_insts.push(inst);
            new_inst_src.push(func.inst_src.get(pc as usize).copied().unwrap_or((0, 0)));
            new_f32.push(func.f32_values.get(pc as usize).copied().unwrap_or(false));
        }
        let last = i + 1 == plan.sched.len();
        if !last && plan.region_of[i + 1] == plan.region_of[i] {
            continue;
        }
        // The final copy jumps straight to the exit: the trip count
        // proved its header condition takes that edge. Any other block
        // ends here because the copy branches out of the loop, so it
        // keeps that branch with the in-loop arm retargeted at the next
        // region block.
        let terminator = if last {
            Terminator::Jmp(shape.exit)
        } else {
            let mut t = func.blocks[b as usize].terminator;
            let inside = plan.virt(plan.region_of[i + 1] as usize);
            let out = shape.branch_out(b).expect("region block ends on a branch");
            match &mut t {
                Terminator::Bz {
                    cond,
                    target,
                    fall_through,
                }
                | Terminator::Bnz {
                    cond,
                    target,
                    fall_through,
                } => {
                    *cond = plan.clone_at(*cond, k, clone_ids, cur);
                    if *target == out {
                        *fall_through = inside;
                    } else {
                        *target = inside;
                    }
                }
                _ => unreachable!("only a conditional branch ends a region block"),
            }
            t
        };
        new_blocks.push(Block {
            start_pc,
            inst_range: start..new_insts.len() as u32,
            terminator,
            exit_acc: plan.clone_at(func.blocks[b as usize].exit_acc, k, clone_ids, cur),
        });
        start = new_insts.len() as u32;
        if !last {
            start_pc = func.blocks[plan.sched[i + 1].1 as usize].start_pc;
        }
    }
}

/// Emit a block outside the loop, led by the phis rebuilding the loop
/// values a read past the loop needs there.
#[allow(clippy::too_many_arguments)]
fn emit_outside(
    func: &FunctionSsa,
    plan: &Expansion,
    ob: BlockId,
    clone_ids: &[Vec<ValueId>],
    cur: &mut [ValueId],
    rebuilt: &mut BTreeMap<(BlockId, ValueId), ValueId>,
    new_insts: &mut Vec<Inst>,
    new_inst_src: &mut Vec<(u32, u32)>,
    new_f32: &mut Vec<bool>,
    new_blocks: &mut Vec<Block>,
) {
    let old = &func.blocks[ob as usize];
    let start = new_insts.len() as u32;
    let src = old
        .inst_range
        .clone()
        .next()
        .and_then(|pc| func.inst_src.get(pc as usize).copied())
        .unwrap_or((0, 0));
    // More than one exit edge reaching here means the copies rejoin,
    // and the value each carries is merged by a phi; a single edge
    // already delivers a clone that dominates the block.
    if let Some(need) = plan.need.get(&ob) {
        for (&v, &kind) in need {
            if let (false, Some((_, k))) = (
                plan.sources[ob as usize].many,
                plan.sources[ob as usize].one,
            ) {
                rebuilt.insert((ob, v), plan.clone_at(v, k, clone_ids, cur));
                continue;
            }
            let incoming = plan.edge_values(ob, v, clone_ids, cur, rebuilt);
            rebuilt.insert((ob, v), new_insts.len() as ValueId);
            new_insts.push(Inst::Phi { incoming, kind });
            new_inst_src.push(src);
            new_f32.push(func.f32_values.get(v as usize).copied().unwrap_or(false));
        }
    }
    for pc in old.inst_range.clone() {
        let mut inst = func.insts[pc as usize].clone();
        if let Inst::Phi { incoming, .. } = &mut inst {
            *incoming = plan.rebuild_incoming(incoming, clone_ids, cur, rebuilt);
        } else {
            inst.for_each_operand_mut(|v| *v = resolve(*v, ob, rebuilt, cur));
        }
        cur[pc as usize] = new_insts.len() as ValueId;
        new_insts.push(inst);
        new_inst_src.push(func.inst_src.get(pc as usize).copied().unwrap_or((0, 0)));
        new_f32.push(func.f32_values.get(pc as usize).copied().unwrap_or(false));
    }
    let mut terminator = old.terminator;
    terminator.for_each_operand_mut(|v| *v = resolve(*v, ob, rebuilt, cur));
    new_blocks.push(Block {
        start_pc: old.start_pc,
        inst_range: start..new_insts.len() as u32,
        terminator,
        exit_acc: resolve(old.exit_acc, ob, rebuilt, cur),
    });
}

/// A block's view of `v`: the value rebuilt there when the loop defines
/// it, the running remap otherwise.
fn resolve(
    v: ValueId,
    b: BlockId,
    rebuilt: &BTreeMap<(BlockId, ValueId), ValueId>,
    cur: &[ValueId],
) -> ValueId {
    match rebuilt.get(&(b, v)) {
        Some(&id) => id,
        None => map_v(v, cur),
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::codegen::ssa::reg_alloc::for_each_operand;
    use crate::c5::ir::{BinOp, LoadKind, StoreKind};

    fn func_with(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            inst_src: vec![(0, 0); insts.len()],
            f32_values: vec![false; insts.len()],
            insts,
            blocks,
            ..FunctionSsa::default()
        }
    }

    fn block(range: core::ops::Range<u32>, terminator: Terminator) -> Block {
        Block {
            start_pc: 0,
            inst_range: range,
            terminator,
            exit_acc: NO_VALUE,
        }
    }

    /// The walker's counted-loop shape with two loop-carried phis:
    ///
    ///   b0 entry: v0 = Imm(init_i), v1 = Imm(42); Jmp b1
    ///   b1 header: v2 = phi_i{(b0, v0), (b3, v6)},
    ///              v3 = phi_s{(b0, v1), (b3, v5)},
    ///              v4 = Lt(v2, bound); Bz -> b4 (exit) / b2 (body)
    ///   b2 body:  v5 = Add(v3, v2); Jmp b3
    ///   b3 latch: v6 = Add(v2, 1); Jmp b1
    ///   b4 exit:  v7 = Add(v2, 100); Return(v3)
    ///
    /// The exit uses both the phi (v3) and a header-computed value
    /// through the phi (v7's operand v2), covering exit-value
    /// resolution through the final header clone.
    fn two_phi_loop(init_i: i64, bound: i64) -> FunctionSsa {
        func_with(
            vec![
                Inst::Imm(init_i),
                Inst::Imm(42),
                Inst::Phi {
                    incoming: vec![(0, 0), (3, 6)],
                    kind: LoadKind::I64,
                },
                Inst::Phi {
                    incoming: vec![(0, 1), (3, 5)],
                    kind: LoadKind::I64,
                },
                Inst::BinopI {
                    op: BinOp::Lt,
                    lhs: 2,
                    rhs_imm: bound,
                },
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 3,
                    rhs: 2,
                },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 2,
                    rhs_imm: 1,
                },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 2,
                    rhs_imm: 100,
                },
            ],
            vec![
                block(0..2, Terminator::Jmp(1)),
                block(
                    2..5,
                    Terminator::Bz {
                        cond: 4,
                        target: 4,
                        fall_through: 2,
                    },
                ),
                block(5..6, Terminator::Jmp(3)),
                block(6..7, Terminator::Jmp(1)),
                block(7..8, Terminator::Return(3)),
            ],
        )
    }

    /// Structural integrity: block ranges partition the tape in order
    /// and every operand of every instruction resolves to a defined id.
    fn assert_well_formed(f: &FunctionSsa) {
        let mut expect = 0u32;
        for b in &f.blocks {
            assert_eq!(b.inst_range.start, expect, "ranges must be contiguous");
            assert!(b.inst_range.end >= b.inst_range.start);
            expect = b.inst_range.end;
            match b.terminator {
                Terminator::Jmp(t) | Terminator::FallThrough(t) => {
                    assert!((t as usize) < f.blocks.len())
                }
                Terminator::Bz {
                    target,
                    fall_through,
                    ..
                }
                | Terminator::Bnz {
                    target,
                    fall_through,
                    ..
                } => {
                    assert!((target as usize) < f.blocks.len());
                    assert!((fall_through as usize) < f.blocks.len());
                }
                _ => {}
            }
        }
        assert_eq!(expect as usize, f.insts.len(), "ranges must cover the tape");
        assert_eq!(f.inst_src.len(), f.insts.len());
        assert_eq!(f.f32_values.len(), f.insts.len());
        for inst in &f.insts {
            for_each_operand(inst, |v| {
                assert!(
                    v != NO_VALUE && (v as usize) < f.insts.len(),
                    "operand {v} out of range in {inst:?}"
                );
            });
        }
    }

    fn returned_imm(f: &FunctionSsa) -> Option<i64> {
        for b in &f.blocks {
            if let Terminator::Return(v) = b.terminator
                && let Some(Inst::Imm(k)) = f.insts.get(v as usize)
            {
                return Some(*k);
            }
        }
        None
    }

    #[test]
    fn two_phi_loop_unrolls_to_constant() {
        let mut f = two_phi_loop(0, 3);
        run_one(&mut f);
        assert_eq!(f.blocks.len(), 3, "header + chain collapse to one block");
        assert!(!f.insts.iter().any(|i| matches!(i, Inst::Phi { .. })));
        assert!(
            !f.blocks
                .iter()
                .any(|b| matches!(b.terminator, Terminator::Bz { .. } | Terminator::Bnz { .. }))
        );
        assert_well_formed(&f);
        // 42 + (0 + 1 + 2) folds through the copies' Binop chain.
        super::super::constfold::run(core::slice::from_mut(&mut f));
        assert_eq!(returned_imm(&f), Some(45));
    }

    #[test]
    fn exit_values_resolve_through_final_header_clone() {
        let mut f = two_phi_loop(0, 3);
        // Return the header-computed v7 = phi_i + 100 instead of phi_s.
        f.blocks[4].terminator = Terminator::Return(7);
        run_one(&mut f);
        assert_well_formed(&f);
        super::super::constfold::run(core::slice::from_mut(&mut f));
        // At the exit the induction phi holds the bound.
        assert_eq!(returned_imm(&f), Some(103));
    }

    #[test]
    fn trip_zero_passes_preheader_values_through() {
        let mut f = two_phi_loop(5, 3);
        run_one(&mut f);
        assert_well_formed(&f);
        // Merged block holds only the final header clone: the cond
        // BinopI and the exit-visible v7 clone; no body/latch copies.
        assert!(!f.insts.iter().any(|i| matches!(i, Inst::Phi { .. })));
        let Terminator::Return(v) = f.blocks.last().unwrap().terminator else {
            panic!("expected Return");
        };
        assert!(
            matches!(f.insts[v as usize], Inst::Imm(42)),
            "zero-trip exit reads the preheader init, got {:?}",
            f.insts[v as usize]
        );
    }

    #[test]
    fn trip_one_unrolls_single_copy() {
        let mut f = two_phi_loop(0, 1);
        run_one(&mut f);
        assert_well_formed(&f);
        // One body copy: three outside insts, the header's non-phi
        // inst twice, the body and latch once each.
        assert_eq!(f.insts.len(), 3 + 2 + 2);
        // The accumulator advanced once, by copy 0's induction value.
        assert_eq!(returned_imm(&f), Some(42));
    }

    #[test]
    fn trip_above_cap_bails() {
        for bound in [17, 100] {
            let mut f = two_phi_loop(0, bound);
            let before = alloc::format!("{:?}", f.insts);
            run_one(&mut f);
            assert_eq!(
                before,
                alloc::format!("{:?}", f.insts),
                "trip {bound} must stay rolled"
            );
            assert_eq!(f.blocks.len(), 5);
        }
    }

    /// `two_phi_loop` with `pad` extra body instructions, so the body
    /// size can be set independently of the loop's shape.
    fn padded_loop(bound: i64, pad: usize) -> FunctionSsa {
        let mut f = two_phi_loop(0, bound);
        let body = f.blocks[2].inst_range.clone();
        for k in 0..pad {
            f.insts.insert(
                body.end as usize + k,
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 2,
                    rhs_imm: k as i64,
                },
            );
        }
        // Ids at or past the insertion point shift by `pad`.
        let bump = |v: &mut ValueId| {
            if *v >= body.end {
                *v += pad as u32;
            }
        };
        for inst in &mut f.insts {
            if let Inst::Phi { incoming, .. } = inst {
                for (_, v) in incoming.iter_mut() {
                    bump(v);
                }
            }
        }
        for b in &mut f.blocks {
            if b.inst_range.start >= body.end {
                b.inst_range.start += pad as u32;
            }
            if b.inst_range.end >= body.end {
                b.inst_range.end += pad as u32;
            }
            if let Terminator::Return(v) = &mut b.terminator {
                bump(v);
            }
        }
        f.inst_src = vec![(0, 0); f.insts.len()];
        f.f32_values = vec![false; f.insts.len()];
        f
    }

    #[test]
    fn body_size_gates_on_the_expansion_not_the_rolled_loop() {
        // A 75-instruction body at trip 3 expands to 4 * 75, under the
        // region cap, so it unrolls however large the rolled loop is.
        let mut f = padded_loop(3, 70);
        let rolled = f.blocks.len();
        run_one(&mut f);
        assert_well_formed(&f);
        assert!(f.blocks.len() < rolled, "large body, trip 3 must unroll");
        assert!(!f.insts.iter().any(|i| matches!(i, Inst::Phi { .. })));
        // The same body at trip 8 expands to 9 * 75, past the cap, and
        // stays rolled: growth, not body size, is what the cap bounds.
        let mut f = padded_loop(8, 70);
        run_one(&mut f);
        assert_eq!(
            f.blocks.len(),
            rolled,
            "expansion past the cap stays rolled"
        );
    }

    #[test]
    fn unknown_trip_bails() {
        // The condition reads a load, not a constant chain.
        let mut f = two_phi_loop(0, 3);
        f.insts[4] = Inst::Load {
            addr: 2,
            disp: 0,
            kind: LoadKind::I64,
            volatile: false,
            align: 0,
        };
        run_one(&mut f);
        assert_eq!(f.blocks.len(), 5);
    }

    #[test]
    fn volatile_access_bails() {
        let mut f = two_phi_loop(0, 3);
        // Body add becomes a volatile store of the phi.
        f.insts[5] = Inst::Store {
            addr: 2,
            disp: 0,
            value: 3,
            kind: StoreKind::I64,
            volatile: true,
            align: 0,
        };
        run_one(&mut f);
        assert_eq!(f.blocks.len(), 5);
    }

    #[test]
    fn computed_goto_function_bails() {
        let mut f = two_phi_loop(0, 3);
        f.computed_goto_targets = vec![2];
        run_one(&mut f);
        assert_eq!(f.blocks.len(), 5);
    }

    #[test]
    fn clone_counts_match_copy_structure() {
        let mut f = two_phi_loop(0, 3);
        let trip = 3usize;
        run_one(&mut f);
        assert_well_formed(&f);
        // Outside insts appear once; header non-phi insts trip + 1
        // times; body / latch insts trip times. Phis vanish.
        let outside = 3; // v0, v1, v7
        let header_nonphi = 1; // v4
        let chain = 2; // v5, v6
        assert_eq!(
            f.insts.len(),
            outside + header_nonphi * (trip + 1) + chain * trip
        );
    }

    /// `two_phi_loop` with a mid-body exit: the body branches out of
    /// the loop to its own landing block, which joins the header's
    /// exit block at a phi.
    ///
    ///   b0 entry: v0 = Imm(init_i), v1 = Imm(42); Jmp b1
    ///   b1 header: v2 = phi_i{(b0, v0), (b3, v7)},
    ///              v3 = phi_s{(b0, v1), (b3, v6)},
    ///              v4 = Lt(v2, bound); Bz -> b4 (exit) / b2 (body)
    ///   b2 body:  v5 = Load(v2), v6 = Add(v3, v2);
    ///             Bz v5 -> b5 (mid-body exit) / b3
    ///   b3 latch: v7 = Add(v2, 1); Jmp b1
    ///   b4, b5:   empty; Jmp b6
    ///   b6 join:  v8 = phi{(b4, v3), (b5, v6)}; Return(v8)
    fn multi_exit_loop(init_i: i64, bound: i64) -> FunctionSsa {
        func_with(
            vec![
                Inst::Imm(init_i),
                Inst::Imm(42),
                Inst::Phi {
                    incoming: vec![(0, 0), (3, 7)],
                    kind: LoadKind::I64,
                },
                Inst::Phi {
                    incoming: vec![(0, 1), (3, 6)],
                    kind: LoadKind::I64,
                },
                Inst::BinopI {
                    op: BinOp::Lt,
                    lhs: 2,
                    rhs_imm: bound,
                },
                Inst::Load {
                    addr: 2,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 0,
                },
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 3,
                    rhs: 2,
                },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 2,
                    rhs_imm: 1,
                },
                Inst::Phi {
                    incoming: vec![(4, 3), (5, 6)],
                    kind: LoadKind::I64,
                },
            ],
            vec![
                block(0..2, Terminator::Jmp(1)),
                block(
                    2..5,
                    Terminator::Bz {
                        cond: 4,
                        target: 4,
                        fall_through: 2,
                    },
                ),
                block(
                    5..7,
                    Terminator::Bz {
                        cond: 5,
                        target: 5,
                        fall_through: 3,
                    },
                ),
                block(7..8, Terminator::Jmp(1)),
                block(8..8, Terminator::Jmp(6)),
                block(8..8, Terminator::Jmp(6)),
                block(8..9, Terminator::Return(8)),
            ],
        )
    }

    /// Every phi in `f`, as its incoming list.
    fn phis(f: &FunctionSsa) -> Vec<Vec<(BlockId, ValueId)>> {
        f.insts
            .iter()
            .filter_map(|i| match i {
                Inst::Phi { incoming, .. } => Some(incoming.clone()),
                _ => None,
            })
            .collect()
    }

    #[test]
    fn mid_body_exit_peels_into_per_copy_blocks() {
        let trip = 3usize;
        let mut f = multi_exit_loop(0, trip as i64);
        run_one(&mut f);
        assert_well_formed(&f);
        // One block per copy, each ending in its own copy of the
        // mid-body branch, plus the final header-only copy; the
        // entry, the two landing blocks and the join are unchanged.
        assert_eq!(f.blocks.len(), 4 + trip + 1);
        let branches = f
            .blocks
            .iter()
            .filter(|b| matches!(b.terminator, Terminator::Bz { .. } | Terminator::Bnz { .. }))
            .count();
        assert_eq!(branches, trip, "one mid-body branch per copy");
        // The header's phis are gone; the mid-body exit's landing block
        // took one merging every copy, and the join reads it.
        let merges = phis(&f);
        assert_eq!(merges.len(), 2);
        assert_eq!(merges[0].len(), trip, "one edge per copy at the landing");
        assert_eq!(merges[1].len(), 2, "the join keeps its two edges");
    }

    #[test]
    fn mid_body_exit_values_match_the_rolled_loop() {
        // Exit-block value: the induction phi never leaves early here
        // (the load is not constant, so both edges stay live), and the
        // join's header-side operand is the final accumulator clone.
        let mut f = multi_exit_loop(0, 3);
        run_one(&mut f);
        assert_well_formed(&f);
        let join = phis(&f).pop().expect("join phi");
        let (_, header_side) = join[0];
        super::super::constfold::run(core::slice::from_mut(&mut f));
        // 42 + (0 + 1 + 2) reaches the join over the header's edge.
        assert!(
            matches!(f.insts[header_side as usize], Inst::Imm(45)),
            "header-edge operand folds to the exit accumulator, got {:?}",
            f.insts[header_side as usize]
        );
    }

    #[test]
    fn mid_body_exit_read_with_no_surviving_edge_stays_rolled() {
        // The header exits at once, so no copy of the body runs and the
        // mid-body exit's landing block is left with no predecessor;
        // the join reads a value over that edge, which no id answers.
        let mut f = multi_exit_loop(5, 3);
        let before = alloc::format!("{:?}", f.insts);
        run_one(&mut f);
        assert_eq!(before, alloc::format!("{:?}", f.insts));
        assert_eq!(f.blocks.len(), 7);
    }

    #[test]
    fn extern_refs_carry_onto_every_clone() {
        // Body carries a cross-TU call and a data-address immediate.
        let mut f = func_with(
            vec![
                Inst::Imm(0),
                Inst::Phi {
                    incoming: vec![(0, 0), (2, 5)],
                    kind: LoadKind::I64,
                },
                Inst::BinopI {
                    op: BinOp::Lt,
                    lhs: 1,
                    rhs_imm: 2,
                },
                Inst::ImmData(64),
                Inst::Call {
                    target_pc: 900,
                    args: vec![3],
                    fixed_args: 1,
                    fp_return: false,
                    fp_arg_mask: 0,
                    arg_aggs: Vec::new(),
                    ret_agg: None,
                    ret_slot_local: 0,
                },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 1,
                    rhs_imm: 1,
                },
            ],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(
                    1..3,
                    Terminator::Bz {
                        cond: 2,
                        target: 3,
                        fall_through: 2,
                    },
                ),
                block(3..6, Terminator::Jmp(1)),
                block(6..6, Terminator::Return(NO_VALUE)),
            ],
        );
        f.extern_call_refs = vec![(4, 11)];
        f.extern_imm_data_refs = vec![(3, 12)];
        run_one(&mut f);
        assert_well_formed(&f);
        assert_eq!(f.extern_call_refs.len(), 2, "one call ref per copy");
        assert_eq!(f.extern_imm_data_refs.len(), 2);
        for &(idx, sym) in &f.extern_call_refs {
            assert_eq!(sym, 11);
            assert!(matches!(
                f.insts[idx as usize],
                Inst::Call { target_pc: 900, .. }
            ));
        }
        for &(idx, sym) in &f.extern_imm_data_refs {
            assert_eq!(sym, 12);
            assert!(matches!(f.insts[idx as usize], Inst::ImmData(64)));
        }
    }
}
