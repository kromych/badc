//! Block layout: fallthrough chains, loop rotation, branch inversion.
//!
//! The walker lowers `for` / `while` as (header, post, body, after)
//! with the header's exit test branching over `post`, so every
//! iteration takes three branches: header -> body, body -> post,
//! post -> header. This pass only reorders `func.blocks` and remaps
//! block ids (instructions never move between blocks), letting the
//! emitters' next-block jump elision collapse the reordered chains:
//!
//! * an edge into a chain of empty `Jmp` blocks is retargeted to the
//!   chain's end, stopping one hop short of a phi-carrying block
//!   (that hop holds the edge's phi moves);
//! * blocks are placed depth-first from the entry with every natural
//!   loop's body contiguous;
//! * a loop whose header conditionally exits the loop is rotated to
//!   bottom-test form: the header moves to the end of the loop's
//!   chain, and an unconditional latch is placed directly before it
//!   so the back edge falls through;
//! * a conditional whose taken target is the next block in layout is
//!   inverted (`Bz` <-> `Bnz`, arms swapped); the successor set is
//!   unchanged, so no critical edge appears after
//!   `split_crit_edges`.
//!
//! Functions with a computed goto (`BlockAddr` pins label blocks and
//! the flow can be irreducible) and functions with an irreducible
//! loop (a retreating edge whose target does not dominate its
//! source) keep their source order.

use alloc::collections::BTreeMap;
use alloc::vec::Vec;

use super::super::ssa::mem2reg::{dominators, predecessors, successors};
use crate::c5::ir::{BlockId, FunctionSsa, Inst, Terminator};

/// Sentinel matching `mem2reg`'s undefined immediate dominator.
const NO_BLOCK: BlockId = BlockId::MAX;

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    let mut chains = JumpChains::default();
    for func in funcs.iter_mut() {
        run_one(func, &mut chains);
    }
}

fn run_one(func: &mut FunctionSsa, chains: &mut JumpChains) {
    if !func.computed_goto_targets.is_empty() || func.blocks.len() < 2 {
        return;
    }
    thread_jumps(func, chains);
    let rpo = rpo_numbers(func);
    let idom = dominators(func);
    if is_irreducible(func, &idom, &rpo) {
        return;
    }
    let preds = predecessors(func);
    let loops = natural_loops(func, &idom, &preds, &rpo);
    let forest = LoopForest::build(func.blocks.len(), &loops);
    let order = layout_order(func, &loops, &forest);
    debug_assert_eq!(order.first(), Some(&0), "entry block must stay first");
    if order.first() != Some(&0) {
        return;
    }
    super::remap_blocks::permute_blocks(func, &order);
    invert_branches(func);
}

/// The unconditional target of a terminator, if any.
fn uncond_target(term: &Terminator) -> Option<BlockId> {
    match term {
        Terminator::Jmp(t) | Terminator::FallThrough(t) => Some(*t),
        _ => None,
    }
}

fn block_is_empty(func: &FunctionSsa, b: BlockId) -> bool {
    let r = &func.blocks[b as usize].inst_range;
    r.start >= r.end
}

fn block_has_phis(func: &FunctionSsa, b: BlockId) -> bool {
    let r = func.blocks[b as usize].inst_range.clone();
    r.into_iter()
        .any(|i| matches!(func.insts[i as usize], Inst::Phi { .. }))
}

/// Per-block chain end of the empty unconditionally-branching blocks
/// reachable from it, and the block one hop short of that end.
///
/// Chains overlap -- the chain from a block is its successor's chain
/// with one block in front -- so the ends are resolved once for the
/// whole function instead of per edge, which costs the chain's length
/// at every block along it. The buffers are owned by the pass and
/// refilled per function, so a unit of many small functions pays no
/// allocation per function.
#[derive(Default)]
struct JumpChains {
    /// Chain end per block, `NO_BLOCK` when the chain never terminates.
    end: Vec<BlockId>,
    /// Block preceding `end` on the chain; the block itself when the
    /// chain is empty.
    penultimate: Vec<BlockId>,
    /// Per block: 0 unvisited, 1 on the current path, 2 resolved.
    state: Vec<u8>,
    /// Blocks of the chain being resolved, unwound to assign their ends.
    path: Vec<BlockId>,
    /// Chain steps taken since the last `build`, counting the resolution
    /// walk and every walk a cyclic chain still forces. Resolving the
    /// ends once bounds this by the block count; walking per edge costs
    /// the chain's length at each of them. The scaling test reads it.
    hops: usize,
}

impl JumpChains {
    fn build(&mut self, func: &FunctionSsa) {
        let n = func.blocks.len();
        let JumpChains {
            end,
            penultimate,
            state,
            path,
            hops,
        } = self;
        *hops = 0;
        end.clear();
        end.resize(n, NO_BLOCK);
        penultimate.clear();
        penultimate.resize(n, NO_BLOCK);
        state.clear();
        state.resize(n, 0);
        path.clear();
        let hop = |b: BlockId| -> Option<BlockId> {
            if !block_is_empty(func, b) {
                return None;
            }
            uncond_target(&func.blocks[b as usize].terminator).filter(|&t| t != b)
        };
        for start in 0..n as BlockId {
            if state[start as usize] != 0 {
                continue;
            }
            let mut cur = start;
            // Walk until the chain reaches a resolved block, a block
            // that ends no chain, or the path itself (a jump cycle).
            let tail = loop {
                *hops += 1;
                if state[cur as usize] == 2 {
                    break Some(cur);
                }
                if state[cur as usize] == 1 {
                    break None; // cycle: the walk never terminates
                }
                state[cur as usize] = 1;
                path.push(cur);
                match hop(cur) {
                    Some(t) => cur = t,
                    None => {
                        end[cur as usize] = cur;
                        penultimate[cur as usize] = cur;
                        state[cur as usize] = 2;
                        path.pop();
                        break Some(cur);
                    }
                }
            };
            let terminates = tail.is_some_and(|t| end[t as usize] != NO_BLOCK);
            while let Some(b) = path.pop() {
                state[b as usize] = 2;
                if !terminates {
                    continue;
                }
                let t = hop(b).expect("a block on the path hops");
                end[b as usize] = end[t as usize];
                penultimate[b as usize] = if end[t as usize] == t {
                    b
                } else {
                    penultimate[t as usize]
                };
            }
        }
    }

    /// The block an edge into `start` may target instead. The chain's
    /// end must carry no phis (its incomings key predecessor ids that a
    /// retarget would falsify); when it does, the chain stops one hop
    /// short, at the empty block that holds the edge's phi moves.
    ///
    /// A chain that reaches a jump cycle has no end, so it is walked in
    /// the graph as it stands: retargeting rewrites the edges the walk
    /// reads, and only a cyclic chain's answer depends on how far that
    /// rewriting has got.
    fn target(&mut self, func: &FunctionSsa, start: BlockId) -> BlockId {
        self.hops += 1;
        let e = self.end[start as usize];
        if e == NO_BLOCK {
            let (t, hops) = walk_chain(func, start);
            self.hops += hops;
            return t;
        }
        if block_has_phis(func, e) {
            self.penultimate[start as usize]
        } else {
            e
        }
    }
}

/// Follow the chain of empty unconditionally-branching blocks from
/// `start`, stopping one hop short of a phi-carrying end. A chain
/// longer than the block count is a jump cycle and is left alone.
/// Returns the target and the steps the walk took.
fn walk_chain(func: &FunctionSsa, start: BlockId) -> (BlockId, usize) {
    let mut prev = start;
    let mut cur = start;
    let mut steps = 0usize;
    while steps <= func.blocks.len() {
        if !block_is_empty(func, cur) {
            break;
        }
        let Some(t) = uncond_target(&func.blocks[cur as usize].terminator) else {
            break;
        };
        if t == cur {
            break;
        }
        prev = cur;
        cur = t;
        steps += 1;
    }
    if steps > func.blocks.len() {
        return (start, steps);
    }
    (if block_has_phis(func, cur) { prev } else { cur }, steps)
}

/// Retarget every terminator edge through [`JumpChains::target`].
/// Bypassed blocks keep their own edges; any that become unreachable
/// are placed after the reachable code by the layout order.
fn thread_jumps(func: &mut FunctionSsa, chains: &mut JumpChains) {
    chains.build(func);
    for i in 0..func.blocks.len() {
        let term = func.blocks[i].terminator;
        let new_term = match term {
            Terminator::Jmp(t) => Terminator::Jmp(chains.target(func, t)),
            Terminator::FallThrough(t) => Terminator::FallThrough(chains.target(func, t)),
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => Terminator::Bz {
                cond,
                target: chains.target(func, target),
                fall_through: chains.target(func, fall_through),
            },
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => Terminator::Bnz {
                cond,
                target: chains.target(func, target),
                fall_through: chains.target(func, fall_through),
            },
            other => other,
        };
        func.blocks[i].terminator = new_term;
    }
}

/// Reverse-postorder number per block from a depth-first search at
/// the entry; `usize::MAX` for blocks unreachable from the entry.
pub(super) fn rpo_numbers(func: &FunctionSsa) -> Vec<usize> {
    let n = func.blocks.len();
    let mut po: Vec<BlockId> = Vec::with_capacity(n);
    let mut visited = alloc::vec![false; n];
    let mut stack: Vec<(BlockId, usize)> = Vec::new();
    visited[0] = true;
    stack.push((0, 0));
    while let Some(&(b, si)) = stack.last() {
        let succ = successors(&func.blocks[b as usize].terminator, &[], &func.jump_tables);
        if si < succ.len() {
            stack.last_mut().unwrap().1 += 1;
            let s = succ[si];
            if !visited[s as usize] {
                visited[s as usize] = true;
                stack.push((s, 0));
            }
        } else {
            po.push(b);
            stack.pop();
        }
    }
    let mut rpo = alloc::vec![usize::MAX; n];
    for (i, &b) in po.iter().enumerate() {
        rpo[b as usize] = po.len() - 1 - i;
    }
    rpo
}

/// Whether `a` dominates `b`, walking `b` up the immediate-dominator
/// tree to the entry. [`DomOrder`] answers the same question without the
/// walk and is what the passes call; this is the reference the test below
/// holds it to.
#[cfg(test)]
fn dominates(a: BlockId, b: BlockId, idom: &[BlockId]) -> bool {
    if a == b {
        return true;
    }
    let mut x = b;
    while x != 0 {
        let up = idom[x as usize];
        if up == NO_BLOCK || up == x {
            break;
        }
        if up == a {
            return true;
        }
        x = up;
    }
    a == 0 && idom[b as usize] != NO_BLOCK
}

/// Entry / exit numbering of the immediate-dominator forest, so an
/// ancestor test is two comparisons instead of a walk up the chain.
/// A per-edge query against the walk costs the tree depth, which on a
/// long chain of sequential regions is the block count.
struct DomOrder {
    /// Preorder entry number per block; `u32::MAX` for a block the
    /// forest walk never reached (no valid immediate dominator).
    tin: Vec<u32>,
    /// Exit number: the largest `tin` in the block's subtree.
    tout: Vec<u32>,
}

impl DomOrder {
    fn build(idom: &[BlockId]) -> Self {
        let n = idom.len();
        // Children per block, plus the roots: a block whose immediate
        // dominator is absent or itself heads its own tree.
        let mut child_head: Vec<u32> = alloc::vec![u32::MAX; n];
        let mut child_next: Vec<u32> = alloc::vec![u32::MAX; n];
        let mut roots: Vec<BlockId> = Vec::new();
        for b in (0..n).rev() {
            let up = idom[b];
            if up == NO_BLOCK || up as usize == b || up as usize >= n {
                roots.push(b as BlockId);
            } else {
                child_next[b] = child_head[up as usize];
                child_head[up as usize] = b as u32;
            }
        }
        let mut tin = alloc::vec![u32::MAX; n];
        let mut tout = alloc::vec![0u32; n];
        let mut clock = 0u32;
        let mut stack: Vec<(BlockId, bool)> = Vec::new();
        for &r in &roots {
            stack.push((r, false));
            while let Some((b, done)) = stack.pop() {
                if done {
                    tout[b as usize] = clock - 1;
                    continue;
                }
                if tin[b as usize] != u32::MAX {
                    continue; // a cycle in `idom` reaches this twice
                }
                tin[b as usize] = clock;
                clock += 1;
                stack.push((b, true));
                let mut c = child_head[b as usize];
                while c != u32::MAX {
                    stack.push((c as BlockId, false));
                    c = child_next[c as usize];
                }
            }
        }
        DomOrder { tin, tout }
    }

    /// Same relation as [`dominates`], read off the numbering.
    fn dominates(&self, a: BlockId, b: BlockId, idom: &[BlockId]) -> bool {
        if a == b {
            return true;
        }
        let (ta, tb) = (self.tin[a as usize], self.tin[b as usize]);
        if ta != u32::MAX && tb != u32::MAX && ta < tb && tb <= self.tout[a as usize] {
            return true;
        }
        // A chain that breaks before the entry block leaves the walk
        // short of it; the entry still dominates every reachable block.
        a == 0 && idom[b as usize] != NO_BLOCK
    }
}

/// A retreating edge (target at or before the source in RPO) whose
/// target does not dominate its source enters a loop past its
/// header; such a multiple-entry loop has no rotation-safe header.
fn is_irreducible(func: &FunctionSsa, idom: &[BlockId], rpo: &[usize]) -> bool {
    let dom = DomOrder::build(idom);
    for (b, block) in func.blocks.iter().enumerate() {
        if rpo[b] == usize::MAX {
            continue;
        }
        for s in successors(&block.terminator, &[], &func.jump_tables) {
            if rpo[s as usize] <= rpo[b] && !dom.dominates(s, b as BlockId, idom) {
                return true;
            }
        }
    }
    false
}

/// A natural loop: the header plus every block that can reach a back
/// edge's source without passing through the header.
pub(super) struct NaturalLoop {
    pub(super) header: BlockId,
    /// Member blocks, ascending.
    pub(super) body: Vec<BlockId>,
}

impl NaturalLoop {
    pub(super) fn contains(&self, b: BlockId) -> bool {
        self.body.binary_search(&b).is_ok()
    }
}

/// Natural loops keyed by header, merging the bodies of multiple back
/// edges that target the same header. Back edges from unreachable
/// blocks are ignored.
pub(super) fn natural_loops(
    func: &FunctionSsa,
    idom: &[BlockId],
    preds: &[Vec<BlockId>],
    rpo: &[usize],
) -> Vec<NaturalLoop> {
    // Back-edge sources grouped by header, so one header's bodies merge
    // in a single traversal.
    let mut back_srcs: BTreeMap<BlockId, Vec<BlockId>> = BTreeMap::new();
    let dom = DomOrder::build(idom);
    for (b, block) in func.blocks.iter().enumerate() {
        if rpo[b] == usize::MAX {
            continue;
        }
        let b = b as BlockId;
        for s in successors(&block.terminator, &[], &func.jump_tables) {
            // `b -> s` is a back edge iff the header `s` dominates `b`.
            if dom.dominates(s, b, idom) {
                back_srcs.entry(s).or_default().push(b);
            }
        }
    }
    // Membership rides one bitset reused across headers, cleared through
    // the member list each header produced. A row per header would cost
    // the function's whole block count per loop.
    let mut seen = alloc::vec![0u64; func.blocks.len().div_ceil(64).max(1)];
    let mut out: Vec<NaturalLoop> = Vec::with_capacity(back_srcs.len());
    for (header, srcs) in back_srcs {
        let mut body: Vec<BlockId> = Vec::new();
        for src in srcs {
            collect_loop_body(header, src, preds, &mut seen, &mut body);
        }
        for &b in &body {
            seen[b as usize / 64] &= !(1u64 << (b % 64));
        }
        body.sort_unstable();
        out.push(NaturalLoop { header, body });
    }
    out
}

/// Add the header and every block reaching `back_src` without passing
/// through the header to `seen` / `body`. `seen` carries the membership
/// already collected for this header, so a second back edge extends the
/// same body instead of re-walking it.
fn collect_loop_body(
    header: BlockId,
    back_src: BlockId,
    preds: &[Vec<BlockId>],
    seen: &mut [u64],
    body: &mut Vec<BlockId>,
) {
    let mut insert = |v: BlockId, body: &mut Vec<BlockId>| {
        let (w, m) = (v as usize / 64, 1u64 << (v % 64));
        let fresh = seen[w] & m == 0;
        if fresh {
            seen[w] |= m;
            body.push(v);
        }
        fresh
    };
    insert(header, body);
    if insert(back_src, body) {
        let mut stack = alloc::vec![back_src];
        while let Some(n) = stack.pop() {
            for &p in &preds[n as usize] {
                if insert(p, body) {
                    stack.push(p);
                }
            }
        }
    }
}

/// Per-block natural-loop nesting depth: the number of natural loops
/// whose body contains the block. Nested loop bodies are subsets, so
/// a block inside `k` enclosing loops is counted `k` times. Zero for
/// every block when the CFG carries a computed goto or is irreducible
/// (no rotation-safe loop structure); callers fall back to unweighted
/// ordering there. Reuses `natural_loops` so there is one loop-detection
/// path shared with the block-layout pass.
pub(crate) fn loop_depths(func: &FunctionSsa) -> Vec<u32> {
    let n = func.blocks.len();
    let mut depth = alloc::vec![0u32; n];
    if !func.computed_goto_targets.is_empty() || n < 2 {
        return depth;
    }
    let rpo = rpo_numbers(func);
    let idom = dominators(func);
    if is_irreducible(func, &idom, &rpo) {
        return depth;
    }
    let preds = predecessors(func);
    for l in natural_loops(func, &idom, &preds, &rpo) {
        for &b in &l.body {
            depth[b as usize] = depth[b as usize].saturating_add(1);
        }
    }
    depth
}

/// Loop nesting derived from body containment. Two distinct natural
/// loops of a reducible CFG are disjoint or strictly nested (loops
/// sharing a header were merged), so the smallest containing body is
/// unique.
struct LoopForest {
    /// Innermost loop containing each block, if any.
    innermost: Vec<Option<usize>>,
    /// Innermost loop strictly containing each loop, if any.
    parent: Vec<Option<usize>>,
}

impl LoopForest {
    fn build(n_blocks: usize, loops: &[NaturalLoop]) -> LoopForest {
        // Stamp bodies from the outermost in; the last (smallest) loop
        // to touch a block is its innermost, and a loop's parent is
        // whatever contained its header before its own stamp. Size
        // ties keep the lowest loop index, as a full smallest-scan
        // would. Linear in the bodies' total size.
        let mut order: Vec<usize> = (0..loops.len()).collect();
        order.sort_unstable_by(|&a, &b| (loops[b].body.len(), b).cmp(&(loops[a].body.len(), a)));
        let mut innermost: Vec<Option<usize>> = alloc::vec![None; n_blocks];
        let mut parent: Vec<Option<usize>> = alloc::vec![None; loops.len()];
        for li in order {
            parent[li] = innermost[loops[li].header as usize];
            for &b in &loops[li].body {
                innermost[b as usize] = Some(li);
            }
        }
        LoopForest { innermost, parent }
    }

    /// The outermost loop containing `b` that is strictly inside
    /// `level`, or `None` when `b` belongs to `level` directly.
    fn unit_loop(&self, b: BlockId, level: Option<usize>) -> Option<usize> {
        let mut li = self.innermost[b as usize]?;
        if Some(li) == level {
            return None;
        }
        while self.parent[li] != level {
            li = self.parent[li]?;
        }
        Some(li)
    }
}

/// Whether the loop can rotate to bottom-test form: the header's
/// conditional has exactly one arm leaving the loop, and the header
/// is not the function entry (which must stay first).
fn rotatable(func: &FunctionSsa, l: &NaturalLoop) -> bool {
    if l.header == 0 {
        return false;
    }
    match func.blocks[l.header as usize].terminator {
        Terminator::Bz {
            target,
            fall_through,
            ..
        }
        | Terminator::Bnz {
            target,
            fall_through,
            ..
        } => l.contains(target) != l.contains(fall_through),
        _ => false,
    }
}

/// Depth-first placement over the blocks of `level` (a loop's body,
/// or the whole function for `None`) starting at `entry`. Each inner
/// loop is laid out recursively and treated as one unit. Within a
/// rotated loop the header chunk moves to the end and an
/// unconditional latch is placed directly before it. Appends the
/// placed blocks to `out`.
fn lay_out(
    func: &FunctionSsa,
    loops: &[NaturalLoop],
    forest: &LoopForest,
    level: Option<usize>,
    entry: BlockId,
    placed: &mut [bool],
    out: &mut Vec<BlockId>,
) {
    let in_level = |b: BlockId| level.is_none_or(|li| loops[li].contains(b));
    // Chunks in placement order: a single block, or a whole inner
    // loop. Kept separate so rotation and the latch move reorder
    // units without breaking a unit's internal fallthroughs.
    let mut chunks: Vec<Vec<BlockId>> = Vec::new();
    let mut stack: Vec<BlockId> = alloc::vec![entry];
    while let Some(b) = stack.pop() {
        if placed[b as usize] || !in_level(b) {
            continue;
        }
        let mut chunk: Vec<BlockId> = Vec::new();
        match forest.unit_loop(b, level) {
            None => {
                placed[b as usize] = true;
                chunk.push(b);
                // Push the conditional's taken target first so the
                // fall-through arm pops first and chains.
                match func.blocks[b as usize].terminator {
                    Terminator::Jmp(t) | Terminator::FallThrough(t) => stack.push(t),
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
                        stack.push(target);
                        stack.push(fall_through);
                    }
                    Terminator::Return(_)
                    | Terminator::TailExt(_)
                    | Terminator::Unreachable
                    | Terminator::GotoIndirect { .. } => {}
                    // Case blocks chain in table order; the entries are
                    // remapped with the rest of the id surface.
                    Terminator::JumpTable { table, .. } => {
                        for &t in func.jump_tables[table as usize].iter().rev() {
                            stack.push(t);
                        }
                    }
                    // Label targets first (reversed), fall-through
                    // (row 0) last so it pops first and chains.
                    Terminator::AsmGoto { table } => {
                        for &t in func.jump_tables[table as usize].iter().rev() {
                            stack.push(t);
                        }
                    }
                }
            }
            Some(li) => {
                lay_out(
                    func,
                    loops,
                    forest,
                    Some(li),
                    loops[li].header,
                    placed,
                    &mut chunk,
                );
                // Exit successors, collected tail-first so the last
                // block's exit (the rotated header's) continues the
                // chain.
                let mut exits: Vec<BlockId> = Vec::new();
                for &cb in chunk.iter().rev() {
                    for s in
                        successors(&func.blocks[cb as usize].terminator, &[], &func.jump_tables)
                    {
                        if !loops[li].contains(s) && !exits.contains(&s) {
                            exits.push(s);
                        }
                    }
                }
                for &e in exits.iter().rev() {
                    stack.push(e);
                }
            }
        }
        chunks.push(chunk);
    }
    if let Some(li) = level {
        let l = &loops[li];
        let header_first = chunks.first().map(|c| c.as_slice()) == Some(&[l.header][..]);
        debug_assert!(header_first, "loop chain must start at its header");
        if header_first && chunks.len() >= 2 && rotatable(func, l) {
            let header_chunk = chunks.remove(0);
            chunks.push(header_chunk);
            move_latch_before_header(func, l.header, &mut chunks);
        }
    }
    for chunk in chunks {
        out.extend(chunk);
    }
}

/// Place an unconditional latch (a single-block chunk ending in
/// `Jmp(header)`) directly before the header chunk of a rotated loop
/// so the back edge falls through. Skipped when the chunk already
/// preceding the header reaches it by fallthrough.
fn move_latch_before_header(func: &FunctionSsa, header: BlockId, chunks: &mut Vec<Vec<BlockId>>) {
    let hpos = chunks.len() - 1;
    debug_assert_eq!(chunks[hpos].as_slice(), &[header]);
    if hpos == 0 {
        return;
    }
    let reaches_header = |b: BlockId| match func.blocks[b as usize].terminator {
        Terminator::Jmp(t) | Terminator::FallThrough(t) => t == header,
        Terminator::Bz { fall_through, .. } | Terminator::Bnz { fall_through, .. } => {
            fall_through == header
        }
        _ => false,
    };
    if chunks[hpos - 1].last().is_some_and(|&b| reaches_header(b)) {
        return;
    }
    let latch = chunks[..hpos].iter().rposition(|c| {
        c.len() == 1
            && matches!(
                func.blocks[c[0] as usize].terminator,
                Terminator::Jmp(t) | Terminator::FallThrough(t) if t == header
            )
    });
    if let Some(lp) = latch {
        let chunk = chunks.remove(lp);
        chunks.insert(chunks.len() - 1, chunk);
    }
}

/// Layout order for the whole function: old block ids in the new
/// emission order. Blocks unreachable from the entry keep their
/// relative order at the tail.
fn layout_order(func: &FunctionSsa, loops: &[NaturalLoop], forest: &LoopForest) -> Vec<BlockId> {
    let n = func.blocks.len();
    let mut placed = alloc::vec![false; n];
    let mut order: Vec<BlockId> = Vec::with_capacity(n);
    lay_out(func, loops, forest, None, 0, &mut placed, &mut order);
    for (b, done) in placed.iter().enumerate() {
        if !done {
            order.push(b as BlockId);
        }
    }
    order
}

/// Invert a conditional whose taken target is the next block in
/// layout so the emitters' next-block elision applies. The successor
/// set is unchanged.
fn invert_branches(func: &mut FunctionSsa) {
    for i in 0..func.blocks.len() {
        let next = (i + 1) as BlockId;
        let term = &mut func.blocks[i].terminator;
        match *term {
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } if target == next && fall_through != next => {
                *term = Terminator::Bnz {
                    cond,
                    target: fall_through,
                    fall_through: target,
                };
            }
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } if target == next && fall_through != next => {
                *term = Terminator::Bz {
                    cond,
                    target: fall_through,
                    fall_through: target,
                };
            }
            _ => {}
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{Block, LoadKind, NO_VALUE};
    use alloc::vec;

    fn func_with(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            inst_src: vec![(0, 0); insts.len()],
            f32_values: vec![false; insts.len()],
            insts,
            blocks,
            ..FunctionSsa::default()
        }
    }

    /// `DomOrder` answers the dominance query the reference walk does,
    /// over a chain, a diamond, a loop nest and an unreachable block.
    #[test]
    fn dom_order_matches_the_reference_walk() {
        let shapes: Vec<Vec<BlockId>> = vec![
            // idom arrays: index is the block, value its immediate dominator.
            vec![0, 0, 1, 2, 3, 4],             // chain
            vec![0, 0, 0, 0],                   // star from the entry
            vec![0, 0, 1, 1, 0],                // diamond
            vec![0, 0, 1, 1, 3, 3, 1],          // nest
            vec![0, 0, 1, NO_BLOCK, 1],         // one unreachable block
            vec![0, 0, 1, 2, 1, 4, 5, 0, 7, 8], // two chains off the entry
        ];
        for idom in shapes {
            let n = idom.len();
            let dom = DomOrder::build(&idom);
            for a in 0..n as BlockId {
                for b in 0..n as BlockId {
                    assert_eq!(
                        dom.dominates(a, b, &idom),
                        dominates(a, b, &idom),
                        "idom={idom:?} a={a} b={b}",
                    );
                }
            }
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

    /// Maximum number of emitted (non-elided) unconditional branches
    /// on any unconditional chain inside a loop that ends at the
    /// loop's header.
    fn max_backedge_uncond_branches(func: &FunctionSsa) -> usize {
        let rpo = rpo_numbers(func);
        let idom = dominators(func);
        let preds = predecessors(func);
        let loops = natural_loops(func, &idom, &preds, &rpo);
        let mut worst = 0;
        for l in &loops {
            for &b in &l.body {
                let mut cur = b;
                let mut count = 0usize;
                let mut steps = 0usize;
                while steps <= func.blocks.len() {
                    let Some(t) = uncond_target(&func.blocks[cur as usize].terminator) else {
                        break;
                    };
                    if t != cur + 1 {
                        count += 1;
                    }
                    cur = t;
                    steps += 1;
                    if cur == l.header {
                        worst = worst.max(count);
                        break;
                    }
                    if !l.contains(cur) {
                        break;
                    }
                }
            }
        }
        worst
    }

    /// The walker's for-loop shape: entry(0) -> header(1) with
    /// `Bz(after=4, body=3)`, post(2) -> header, body(3) -> post,
    /// after(4) returns. One instruction per block so nothing is
    /// empty except where noted.
    fn for_loop_shape() -> FunctionSsa {
        func_with(
            vec![
                Inst::Imm(0),
                Inst::Imm(1),
                Inst::Imm(2),
                Inst::Imm(3),
                Inst::Imm(4),
            ],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(
                    1..2,
                    Terminator::Bz {
                        cond: 1,
                        target: 4,
                        fall_through: 3,
                    },
                ),
                block(2..3, Terminator::Jmp(1)),
                block(3..4, Terminator::Jmp(2)),
                block(4..5, Terminator::Return(4)),
            ],
        )
    }

    #[test]
    fn for_loop_rotates_to_bottom_test() {
        let mut f = for_loop_shape();
        run_one(&mut f, &mut JumpChains::default());
        // Layout: entry, body, post, header, after. Old ids: 0 3 2 1 4.
        assert_eq!(f.blocks.len(), 5);
        // Entry branches to the rotated header at the loop bottom.
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(3)));
        // body falls into post, post falls into the header.
        assert!(matches!(f.blocks[1].terminator, Terminator::Jmp(2)));
        assert!(matches!(f.blocks[2].terminator, Terminator::Jmp(3)));
        // The rotated header inverted Bz -> Bnz: the back edge is the
        // taken conditional, the exit falls through.
        assert!(matches!(
            f.blocks[3].terminator,
            Terminator::Bnz {
                target: 1,
                fall_through: 4,
                ..
            }
        ));
        assert!(matches!(f.blocks[4].terminator, Terminator::Return(_)));
        assert_eq!(max_backedge_uncond_branches(&f), 0);
    }

    #[test]
    fn rotated_loop_keeps_instructions_in_their_blocks() {
        let mut f = for_loop_shape();
        run_one(&mut f, &mut JumpChains::default());
        // Each block kept its inst_range: old header's single Imm(1)
        // now sits in layout block 3.
        assert_eq!(f.blocks[3].inst_range, 1..2);
        assert!(matches!(f.insts[1], Inst::Imm(1)));
    }

    #[test]
    fn phi_incoming_ids_follow_the_permutation() {
        let mut f = for_loop_shape();
        // Give the post block a phi whose incoming names the body
        // block (old id 3, which the layout renumbers to 1).
        f.insts[2] = Inst::Phi {
            incoming: vec![(3, 3)],
            kind: LoadKind::I64,
        };
        run_one(&mut f, &mut JumpChains::default());
        // Layout: entry, body, post, header, after (old 0 3 2 1 4);
        // the post block keeps id 2, its incoming now names body = 1.
        let Inst::Phi { incoming, .. } = &f.insts[2] else {
            panic!("expected phi");
        };
        assert_eq!(incoming[0].0, 1);
    }

    #[test]
    fn empty_jump_chain_is_threaded() {
        // b0 -Jmp-> b1(empty) -Jmp-> b2(empty) -Jmp-> b3(ret).
        let mut f = func_with(
            vec![Inst::Imm(0), Inst::Imm(3)],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..1, Terminator::Jmp(2)),
                block(1..1, Terminator::Jmp(3)),
                block(1..2, Terminator::Return(1)),
            ],
        );
        thread_jumps(&mut f, &mut JumpChains::default());
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(3)));
    }

    #[test]
    fn threading_stops_before_a_phi_carrying_target() {
        // b0 -Jmp-> b1(empty) -Jmp-> b2(phi). The edge may skip to b1
        // at most: b1 holds the phi moves for the b1 -> b2 edge.
        let mut f = func_with(
            vec![
                Inst::Imm(0),
                Inst::Phi {
                    incoming: vec![(1, 0)],
                    kind: LoadKind::I64,
                },
            ],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..1, Terminator::Jmp(2)),
                block(1..2, Terminator::Return(1)),
            ],
        );
        thread_jumps(&mut f, &mut JumpChains::default());
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(1)));
    }

    #[test]
    fn computed_goto_function_is_untouched() {
        let mut f = for_loop_shape();
        f.computed_goto_targets = vec![1];
        let before: Vec<_> = f
            .blocks
            .iter()
            .map(|b| alloc::format!("{:?}", b.terminator))
            .collect();
        run_one(&mut f, &mut JumpChains::default());
        let after: Vec<_> = f
            .blocks
            .iter()
            .map(|b| alloc::format!("{:?}", b.terminator))
            .collect();
        assert_eq!(before, after);
    }

    #[test]
    fn irreducible_loop_is_left_in_source_order() {
        // b0 branches into both b1 and b2, which branch to each other:
        // a two-entry loop with no dominating header.
        let mut f = func_with(
            vec![Inst::Imm(0), Inst::Imm(1), Inst::Imm(2), Inst::Imm(3)],
            vec![
                block(
                    0..1,
                    Terminator::Bz {
                        cond: 0,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(
                    1..2,
                    Terminator::Bz {
                        cond: 1,
                        target: 3,
                        fall_through: 2,
                    },
                ),
                block(
                    2..3,
                    Terminator::Bz {
                        cond: 2,
                        target: 3,
                        fall_through: 1,
                    },
                ),
                block(3..4, Terminator::Return(3)),
            ],
        );
        let before: Vec<_> = f
            .blocks
            .iter()
            .map(|b| alloc::format!("{:?}", b.terminator))
            .collect();
        run_one(&mut f, &mut JumpChains::default());
        let after: Vec<_> = f
            .blocks
            .iter()
            .map(|b| alloc::format!("{:?}", b.terminator))
            .collect();
        assert_eq!(before, after);
    }

    #[test]
    fn do_while_shape_is_not_rotated() {
        // entry(0) -> body(1) -> cond(2) -Bnz-> body, fall after(3).
        // Already bottom-test; the header (body) must stay on top.
        let mut f = func_with(
            vec![Inst::Imm(0), Inst::Imm(1), Inst::Imm(2), Inst::Imm(3)],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..2, Terminator::Jmp(2)),
                block(
                    2..3,
                    Terminator::Bnz {
                        cond: 2,
                        target: 1,
                        fall_through: 3,
                    },
                ),
                block(3..4, Terminator::Return(3)),
            ],
        );
        run_one(&mut f, &mut JumpChains::default());
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(1)));
        assert!(matches!(f.blocks[1].terminator, Terminator::Jmp(2)));
        assert!(matches!(
            f.blocks[2].terminator,
            Terminator::Bnz {
                target: 1,
                fall_through: 3,
                ..
            }
        ));
        assert_eq!(max_backedge_uncond_branches(&f), 0);
    }

    #[test]
    fn two_continue_paths_carry_at_most_one_uncond_branch() {
        // for-loop whose body splits twice, both arms jumping to the
        // shared post block: entry(0) -> header(1) Bz(after=7, body=2);
        // body(2) Bz(c1=3, c2=4); c1(3) -Jmp-> post(5); c2(4) -Jmp->
        // post(5); post(5) -Jmp-> header; unused(6); after(7).
        let mut f = func_with(
            (0..8i64).map(Inst::Imm).collect(),
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(
                    1..2,
                    Terminator::Bz {
                        cond: 1,
                        target: 7,
                        fall_through: 2,
                    },
                ),
                block(
                    2..3,
                    Terminator::Bz {
                        cond: 2,
                        target: 3,
                        fall_through: 4,
                    },
                ),
                block(3..4, Terminator::Jmp(5)),
                block(4..5, Terminator::Jmp(5)),
                block(5..6, Terminator::Jmp(1)),
                block(6..7, Terminator::Return(6)),
                block(7..8, Terminator::Return(7)),
            ],
        );
        run_one(&mut f, &mut JumpChains::default());
        assert!(max_backedge_uncond_branches(&f) <= 1);
    }

    #[test]
    fn nested_loop_bodies_stay_contiguous() {
        // outer: header(1) Bz(after=6, body=2); inner loop inside the
        // outer body: header(2) Bz(back-to-outer=5, body=3); inner
        // body(3) -> inner post(4) -> inner header; outer post(5) ->
        // outer header; after(6).
        let mut f = func_with(
            (0..7i64).map(Inst::Imm).collect(),
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(
                    1..2,
                    Terminator::Bz {
                        cond: 1,
                        target: 6,
                        fall_through: 2,
                    },
                ),
                block(
                    2..3,
                    Terminator::Bz {
                        cond: 2,
                        target: 5,
                        fall_through: 3,
                    },
                ),
                block(3..4, Terminator::Jmp(4)),
                block(4..5, Terminator::Jmp(2)),
                block(5..6, Terminator::Jmp(1)),
                block(6..7, Terminator::Return(6)),
            ],
        );
        run_one(&mut f, &mut JumpChains::default());
        assert_eq!(max_backedge_uncond_branches(&f), 0);
        // Recover the inner loop on the permuted function and check
        // its blocks are adjacent in layout.
        let rpo = rpo_numbers(&f);
        let idom = dominators(&f);
        let preds = predecessors(&f);
        let loops = natural_loops(&f, &idom, &preds, &rpo);
        assert_eq!(loops.len(), 2);
        let inner = loops.iter().min_by_key(|l| l.body.len()).unwrap();
        let ids: Vec<u32> = inner.body.to_vec();
        let span = *ids.last().unwrap() - ids[0] + 1;
        assert_eq!(span as usize, ids.len(), "inner loop must be contiguous");
    }

    #[test]
    fn block_addr_remap_covered_by_permutation_utility() {
        // The layout pass skips computed-goto functions; the shared
        // permutation utility still remaps `BlockAddr` for callers
        // that reorder such functions (see remap_blocks tests).
        let mut f = func_with(
            vec![Inst::BlockAddr(1), Inst::Imm(1)],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..2, Terminator::Return(1)),
            ],
        );
        super::super::remap_blocks::permute_blocks(&mut f, &[1, 0]);
        assert!(matches!(f.insts[0], Inst::BlockAddr(0)));
    }

    /// A function of `n` empty blocks each jumping to the next, ending
    /// at a block that returns. `phi_end` gives the last block a phi, so
    /// the chain must stop one hop short of it.
    fn jump_chain(n: usize, phi_end: bool) -> FunctionSsa {
        let insts = if phi_end {
            vec![
                Inst::Imm(0),
                Inst::Phi {
                    incoming: vec![(n as BlockId, 0)],
                    kind: LoadKind::I64,
                },
            ]
        } else {
            vec![Inst::Imm(0)]
        };
        let last = insts.len() as u32;
        let mut blocks: Vec<Block> = (0..n)
            .map(|i| block(1..1, Terminator::Jmp(i as BlockId + 1)))
            .collect();
        blocks.push(block(1..last, Terminator::Return(0)));
        blocks[0] = block(0..1, Terminator::Jmp(1));
        func_with(insts, blocks)
    }

    /// The precomputed chain ends answer what the per-edge walk does,
    /// over a plain chain, a chain ending at a phi-carrying block, and a
    /// jump cycle (which is left alone).
    #[test]
    fn jump_chains_match_the_reference_walk() {
        let mut shapes = vec![
            jump_chain(1, false),
            jump_chain(6, false),
            jump_chain(6, true),
        ];
        // b0 -> b1 -> b2 -> b1: a cycle of empty jump blocks.
        shapes.push(func_with(
            vec![Inst::Imm(0)],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..1, Terminator::Jmp(2)),
                block(1..1, Terminator::Jmp(1)),
            ],
        ));
        for f in &shapes {
            let mut chains = JumpChains::default();
            chains.build(f);
            for b in 0..f.blocks.len() as BlockId {
                assert_eq!(
                    chains.target(f, b),
                    walk_chain(f, b).0,
                    "block {b} of a {}-block shape",
                    f.blocks.len(),
                );
            }
        }
    }

    /// Threading walked the chain from every edge, so a chain of N empty
    /// jump blocks cost N^2. Measured in chain steps -- the operation
    /// the per-edge walk repeats -- so the bound holds whatever the
    /// machine is doing. Quadrupling the chain must not quadruple the
    /// steps; 16x is what the per-edge walk would spend, and the
    /// reference walk is held to the same bound to confirm it does.
    #[test]
    fn jump_threading_is_not_quadratic_in_the_chain() {
        let hops = |n: usize| -> (usize, usize) {
            let mut f = jump_chain(n, false);
            // The reference is taken first: threading collapses the
            // chain the per-edge walk would have to follow.
            let per_edge: usize = (0..f.blocks.len() as BlockId)
                .map(|b| walk_chain(&f, b).1 + 1)
                .sum();
            let mut chains = JumpChains::default();
            thread_jumps(&mut f, &mut chains);
            (chains.hops, per_edge)
        };
        let (small, small_walk) = hops(500);
        let (large, large_walk) = hops(2000);
        assert!(small > 0, "no chain steps to compare");
        assert!(
            large < small * 6,
            "4x the chain cost {large} steps against {small}, \
             past the 6x headroom over linear",
        );
        // The per-edge walk this replaced fails the same bound at the
        // same sizes, so the bound separates the two.
        assert!(
            large_walk >= small_walk * 6,
            "the per-edge walk no longer costs the chain's length at each \
             edge ({small_walk} -> {large_walk} steps); the bound above no \
             longer proves anything",
        );
    }
}
