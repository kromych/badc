//! Full unrolling of constant-trip loops.
//!
//! Runs under `-O` after `ssa_mem2reg` (loop-carried values are header
//! phis by then) and before the inliner, so a helper whose body was a
//! short counted loop becomes a single-block inline candidate and the
//! cloned call sites join the inliner's worklist. The post-inline
//! constant folder collapses the per-copy `Extend(Imm)` / `BinopI`
//! index chains the clones leave behind.
//!
//! The transform treats the loop body as a pseudo-callee spliced once
//! per iteration, reusing the inliner's remap primitives: its
//! "parameters" are the header's phis (`phi_i = Phi{(preheader,
//! init_i), (latch, r_i)}`) and its "returns" are the latch back-edge
//! operands `r_i`. Copy 0 binds each phi to `init_i`; copy k binds it
//! to copy k-1's remapped `r_i`. A final header-only clone binds the
//! phis to the exit-iteration values so every header-defined value
//! visible past the loop (including the header's `exit_acc`) resolves;
//! SSA dominance guarantees no value defined in the body or latch is
//! used outside the loop (the zero-trip path skips them). The loop's
//! blocks collapse into one straight-line block; all later block-id
//! references rewrite through `remap_blocks::remap_block_ids`.
//!
//! Eligible loops are the walker's canonical counted shape:
//!
//! * a natural loop whose header conditionally exits (`Bz` / `Bnz`
//!   with one successor in the loop, one out) and whose remaining
//!   blocks form a single-successor chain back to the header -- one
//!   body block, optionally followed by the walker's increment block
//!   as the latch;
//! * every header phi merges exactly the preheader and latch values;
//! * no volatile access (C99 6.7.3p6 forbids duplicating the access),
//!   `Mcpy`, atomic, intrinsic, `AllocaInit`, or `TailExt` in the
//!   loop; calls are cloned per copy;
//! * the trip count evaluates to a constant `<= MAX_TRIP` by abstract
//!   interpretation of the header condition and latch step over the
//!   shared VM evaluator (`vm::eval`), starting from constant phi
//!   inits;
//! * the loop is at most `MAX_LOOP_INSTS` instructions and the
//!   expansion at most `MAX_REGION_INSTS`.
//!
//! Functions with a computed goto or a `BlockAddr` (block ids shift),
//! or a returns-twice call (cloned call sites would multiply the
//! setjmp return points), keep their loops rolled.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec;
use alloc::vec::Vec;

use super::super::ssa::mem2reg::{dominators, predecessors};
use super::inline::{map_v, remap_caller_inst, remap_terminator};
use super::layout::{natural_loops, rpo_numbers};
use crate::c5::ir::{Block, BlockId, FunctionSsa, Inst, NO_VALUE, Terminator, ValueId};
use crate::c5::vm::eval;

/// Largest constant trip count that unrolls.
const MAX_TRIP: usize = 16;
/// Iteration bound while counting trips; a condition still true past
/// this is treated as unknown.
const COUNT_CAP: usize = 64;
/// Largest loop (header + chain instructions) that unrolls.
const MAX_LOOP_INSTS: usize = 40;
/// Cap on the expanded region: `(trip + 1) * loop_insts`.
const MAX_REGION_INSTS: usize = 600;
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
    // Block ids shift when the loop's blocks merge: a computed goto's
    // label set and any `BlockAddr` would need retargeting through a
    // block that no longer exists once its clones are inlined into the
    // merged region. A returns-twice call site must stay unique per
    // source occurrence (C99 7.13.2.1p3).
    if !func.computed_goto_targets.is_empty()
        || func.has_returns_twice_call
        || func.insts.iter().any(|i| matches!(i, Inst::BlockAddr(_)))
    {
        return;
    }
    for _ in 0..MAX_LOOPS_PER_FUNC {
        if func.insts.len() > MAX_FUNC_INSTS {
            return;
        }
        let Some(shape) = find_unrollable(func) else {
            return;
        };
        #[cfg(feature = "codegen_test")]
        if std::env::var("BADC_LOG_UNROLL").is_ok() {
            eprintln!(
                "[unroll] {n}: header=b{h} chain={c:?} trip={t} loop_insts={i}",
                n = func.name,
                h = shape.header,
                c = shape.chain,
                t = shape.trip,
                i = shape_inst_count(func, &shape)
            );
        }
        expand(func, &shape);
        // Record that a loop was expanded: the post-inline scalar
        // promotion re-runs mem2reg only on functions where unrolling
        // turned an array subscript into a constant offset.
        func.did_unroll = true;
    }
}

/// A loop that passed every gate. `chain` is the loop's non-header
/// blocks in execution order; the last entry is the latch.
struct LoopShape {
    header: BlockId,
    chain: Vec<BlockId>,
    exit: BlockId,
    /// One entry per header phi: `(phi id, preheader init operand,
    /// latch back-edge operand)`.
    phis: Vec<(ValueId, ValueId, ValueId)>,
    trip: usize,
}

fn find_unrollable(func: &FunctionSsa) -> Option<LoopShape> {
    if func.blocks.len() < 3 {
        return None;
    }
    let preds = predecessors(func);
    let idom = dominators(func);
    let rpo = rpo_numbers(func);
    let loops = natural_loops(func, &idom, &preds, &rpo);
    loops.iter().find_map(|l| {
        try_shape(func, l.header, &l.body, &preds).filter(|s| {
            s.trip <= MAX_TRIP && {
                let loop_insts = shape_inst_count(func, s);
                loop_insts <= MAX_LOOP_INSTS && (s.trip + 1) * loop_insts <= MAX_REGION_INSTS
            }
        })
    })
}

fn shape_inst_count(func: &FunctionSsa, s: &LoopShape) -> usize {
    core::iter::once(&s.header)
        .chain(s.chain.iter())
        .map(|&b| {
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
    if h == 0 || body.len() < 2 || body.len() > 3 {
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
    let (enter, exit) = match (
        body.binary_search(&s1).is_ok(),
        body.binary_search(&s2).is_ok(),
    ) {
        (true, false) => (s1, s2),
        (false, true) => (s2, s1),
        _ => return None,
    };
    // The non-header blocks form a single-successor chain back to the
    // header; anything else is a multi-block body and stays rolled.
    let mut chain: Vec<BlockId> = Vec::new();
    let mut cur = enter;
    while cur != h {
        if cur == 0 || chain.contains(&cur) || chain.len() >= body.len() {
            return None;
        }
        chain.push(cur);
        cur = match func.blocks[cur as usize].terminator {
            Terminator::Jmp(t) | Terminator::FallThrough(t) => t,
            _ => return None,
        };
    }
    if chain.len() + 1 != body.len() || chain.iter().any(|b| body.binary_search(b).is_err()) {
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
    if body.binary_search(&pre).is_ok() {
        return None;
    }
    let mut phis: Vec<(ValueId, ValueId, ValueId)> = Vec::new();
    for &b in core::iter::once(&h).chain(chain.iter()) {
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
        core::iter::once(&h)
            .chain(chain.iter())
            .any(|&b| func.blocks[b as usize].inst_range.contains(&v))
    };
    if phis.iter().any(|&(_, init, _)| in_loop(init)) {
        return None;
    }
    let trip = count_trips(func, cond, s1, exit, is_bz, &phis)?;
    Some(LoopShape {
        header: h,
        chain,
        exit,
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

/// Rebuild `func` with the loop's blocks replaced by one straight-line
/// block holding `trip` body copies plus the final header clone.
fn expand(func: &mut FunctionSsa, shape: &LoopShape) {
    let h = shape.header as usize;
    let trip = shape.trip;
    let copies = trip + 1;
    let n_old = func.insts.len();
    let n_blocks = func.blocks.len();
    let chain_set: BTreeSet<BlockId> = shape.chain.iter().copied().collect();

    // Dense position of each loop instruction, for the per-copy clone
    // table the extern-ref carry reads.
    let mut loop_pos: Vec<u32> = vec![u32::MAX; n_old];
    let mut loop_len = 0u32;
    for &b in core::iter::once(&shape.header).chain(shape.chain.iter()) {
        for pc in func.blocks[b as usize].inst_range.clone() {
            loop_pos[pc as usize] = loop_len;
            loop_len += 1;
        }
    }
    let mut clone_ids: Vec<Vec<ValueId>> = vec![vec![NO_VALUE; loop_len as usize]; copies];

    // Old -> new block ids: the chain blocks disappear; later ids
    // shift down. The removed ids alias the merged block so the map
    // is total; nothing references them after the expansion.
    let mut new_bid: Vec<BlockId> = Vec::with_capacity(n_blocks);
    let mut removed = 0u32;
    for b in 0..n_blocks as u32 {
        if chain_set.contains(&b) {
            removed += 1;
            new_bid.push(BlockId::MAX);
        } else {
            new_bid.push(b - removed);
        }
    }
    for &c in &chain_set {
        new_bid[c as usize] = new_bid[h];
    }

    let mut new_insts: Vec<Inst> = Vec::new();
    let mut new_inst_src: Vec<(u32, u32)> = Vec::new();
    let mut new_f32: Vec<bool> = Vec::new();
    // (old block id, start offset in `new_insts`) per surviving block.
    let mut new_block_starts: Vec<(usize, u32)> = Vec::new();
    // Running value remap. Loop instructions are overwritten per copy,
    // so between copies the entry holds the previous copy's clone --
    // exactly the back-edge view the next copy's phi bindings read.
    // After the merged block the header entries hold the final clone,
    // the view every outside use requires (only header values dominate
    // the exit). The block array is not ordered definitions-before-
    // uses, so emission runs to a fixed point as the inliner's splice
    // does: ids are structurally stable across passes and each pass
    // resolves one forward-reference level.
    let mut cur: Vec<ValueId> = vec![NO_VALUE; n_old];
    let mut guard = n_old + 2;
    loop {
        new_insts.clear();
        new_inst_src.clear();
        new_f32.clear();
        new_block_starts.clear();
        let before = cur.clone();
        for ob in 0..n_blocks {
            if chain_set.contains(&(ob as BlockId)) {
                continue;
            }
            new_block_starts.push((ob, new_insts.len() as u32));
            let mut emit = |pc: u32,
                            copy: Option<usize>,
                            cur: &mut Vec<ValueId>,
                            new_insts: &mut Vec<Inst>,
                            new_inst_src: &mut Vec<(u32, u32)>,
                            new_f32: &mut Vec<bool>| {
                let mut inst = func.insts[pc as usize].clone();
                remap_caller_inst(&mut inst, cur);
                let id = new_insts.len() as u32;
                cur[pc as usize] = id;
                if let Some(k) = copy {
                    clone_ids[k][loop_pos[pc as usize] as usize] = id;
                }
                new_insts.push(inst);
                new_inst_src.push(func.inst_src.get(pc as usize).copied().unwrap_or((0, 0)));
                new_f32.push(func.f32_values.get(pc as usize).copied().unwrap_or(false));
            };
            if ob == h {
                for k in 0..copies {
                    // Parallel phi binding: read every source before
                    // writing, so one phi's new binding cannot feed
                    // another's within the same copy.
                    let binds: Vec<(ValueId, ValueId)> = shape
                        .phis
                        .iter()
                        .map(|&(phi, init, back)| {
                            let src = if k == 0 { init } else { back };
                            (phi, map_v(src, &cur))
                        })
                        .collect();
                    for (phi, b) in binds {
                        cur[phi as usize] = b;
                    }
                    for pc in func.blocks[h].inst_range.clone() {
                        if matches!(func.insts[pc as usize], Inst::Phi { .. }) {
                            continue;
                        }
                        emit(
                            pc,
                            Some(k),
                            &mut cur,
                            &mut new_insts,
                            &mut new_inst_src,
                            &mut new_f32,
                        );
                    }
                    // The final clone is header-only: it materialises
                    // the exit-visible header values.
                    if k < trip {
                        for &cb in &shape.chain {
                            for pc in func.blocks[cb as usize].inst_range.clone() {
                                emit(
                                    pc,
                                    Some(k),
                                    &mut cur,
                                    &mut new_insts,
                                    &mut new_inst_src,
                                    &mut new_f32,
                                );
                            }
                        }
                    }
                }
            } else {
                for pc in func.blocks[ob].inst_range.clone() {
                    emit(
                        pc,
                        None,
                        &mut cur,
                        &mut new_insts,
                        &mut new_inst_src,
                        &mut new_f32,
                    );
                }
            }
        }
        if cur == before {
            break;
        }
        guard -= 1;
        if guard == 0 {
            break;
        }
    }

    // Blocks: surviving blocks keep their terminators (values through
    // the final remap; block ids stay old until `remap_block_ids`).
    // The merged block jumps straight to the exit -- the trip count
    // proved the final header clone's condition takes that edge.
    let mut new_blocks: Vec<Block> = Vec::with_capacity(new_block_starts.len());
    for (i, &(ob, start)) in new_block_starts.iter().enumerate() {
        let end = new_block_starts
            .get(i + 1)
            .map(|&(_, s)| s)
            .unwrap_or(new_insts.len() as u32);
        let old = &func.blocks[ob];
        let terminator = if ob == h {
            Terminator::Jmp(shape.exit)
        } else {
            let mut t = old.terminator;
            remap_terminator(&mut t, &cur);
            t
        };
        new_blocks.push(Block {
            start_pc: old.start_pc,
            inst_range: start..end,
            terminator,
            exit_acc: map_v(old.exit_acc, &cur),
        });
    }

    // Extern-ref carry: a reference on a loop instruction lands on
    // every clone (each cloned `Call` / `ImmData` / `ImmCode` /
    // `TlsAddr` still names the cross-TU symbol); a reference outside
    // retargets through the final remap.
    let retarget = |refs: &[(u32, u32)]| -> Vec<(u32, u32)> {
        let mut out = Vec::new();
        for &(idx, sym) in refs {
            let pos = loop_pos.get(idx as usize).copied().unwrap_or(u32::MAX);
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
        // One body copy: exactly one body Add(v_s, v_i) clone (counted
        // before constfold collapses it to an Imm).
        let body_adds = f
            .insts
            .iter()
            .filter(|i| matches!(i, Inst::Binop { op: BinOp::Add, .. }))
            .count();
        assert_eq!(body_adds, 1);
        super::super::constfold::run(core::slice::from_mut(&mut f));
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

    #[test]
    fn unknown_trip_bails() {
        // The condition reads a load, not a constant chain.
        let mut f = two_phi_loop(0, 3);
        f.insts[4] = Inst::Load {
            addr: 2,
            disp: 0,
            kind: LoadKind::I64,
            volatile: false,
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
