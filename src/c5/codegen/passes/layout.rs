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
    for func in funcs.iter_mut() {
        run_one(func);
    }
}

fn run_one(func: &mut FunctionSsa) {
    if !func.computed_goto_targets.is_empty() || func.blocks.len() < 2 {
        return;
    }
    thread_jumps(func);
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

/// Follow the chain of empty unconditionally-branching blocks from
/// `start` and return the block an edge into `start` may target
/// instead. The final block must carry no phis (its incomings key
/// predecessor ids that a retarget would falsify); when it does, the
/// chain stops one hop short, at the empty block that holds the
/// edge's phi moves. A chain longer than the block count is a jump
/// cycle and is left alone.
fn thread_target(func: &FunctionSsa, start: BlockId) -> BlockId {
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
        return start;
    }
    if block_has_phis(func, cur) { prev } else { cur }
}

/// Retarget every terminator edge through [`thread_target`]. Bypassed
/// blocks keep their own edges; any that become unreachable are
/// placed after the reachable code by the layout order.
fn thread_jumps(func: &mut FunctionSsa) {
    for i in 0..func.blocks.len() {
        let term = func.blocks[i].terminator;
        let new_term = match term {
            Terminator::Jmp(t) => Terminator::Jmp(thread_target(func, t)),
            Terminator::FallThrough(t) => Terminator::FallThrough(thread_target(func, t)),
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => Terminator::Bz {
                cond,
                target: thread_target(func, target),
                fall_through: thread_target(func, fall_through),
            },
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => Terminator::Bnz {
                cond,
                target: thread_target(func, target),
                fall_through: thread_target(func, fall_through),
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
/// tree to the entry.
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

/// A retreating edge (target at or before the source in RPO) whose
/// target does not dominate its source enters a loop past its
/// header; such a multiple-entry loop has no rotation-safe header.
fn is_irreducible(func: &FunctionSsa, idom: &[BlockId], rpo: &[usize]) -> bool {
    for (b, block) in func.blocks.iter().enumerate() {
        if rpo[b] == usize::MAX {
            continue;
        }
        for s in successors(&block.terminator, &[], &func.jump_tables) {
            if rpo[s as usize] <= rpo[b] && !dominates(s, b as BlockId, idom) {
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
    // Membership rides one bitset row per header (merging the bodies
    // of multiple back edges); the rows convert to sorted lists at
    // the end.
    let words = func.blocks.len().div_ceil(64).max(1);
    let mut bodies: BTreeMap<BlockId, Vec<u64>> = BTreeMap::new();
    for (b, block) in func.blocks.iter().enumerate() {
        if rpo[b] == usize::MAX {
            continue;
        }
        let b = b as BlockId;
        for s in successors(&block.terminator, &[], &func.jump_tables) {
            // `b -> s` is a back edge iff the header `s` dominates `b`.
            if dominates(s, b, idom) {
                let body = bodies.entry(s).or_insert_with(|| alloc::vec![0u64; words]);
                collect_loop_body(s, b, preds, body);
            }
        }
    }
    bodies
        .into_iter()
        .map(|(header, bits)| {
            let mut body: Vec<BlockId> = Vec::new();
            for (w, &word) in bits.iter().enumerate() {
                let mut rest = word;
                while rest != 0 {
                    body.push((w as u32) * 64 + rest.trailing_zeros());
                    rest &= rest - 1;
                }
            }
            NaturalLoop { header, body }
        })
        .collect()
}

/// Add the header and every block reaching `back_src` without passing
/// through the header to the `body` bitset.
fn collect_loop_body(header: BlockId, back_src: BlockId, preds: &[Vec<BlockId>], body: &mut [u64]) {
    let insert = |v: BlockId, body: &mut [u64]| {
        let (w, m) = (v as usize / 64, 1u64 << (v % 64));
        let fresh = body[w] & m == 0;
        body[w] |= m;
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
        run_one(&mut f);
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
        run_one(&mut f);
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
        run_one(&mut f);
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
        thread_jumps(&mut f);
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
        thread_jumps(&mut f);
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
        run_one(&mut f);
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
        run_one(&mut f);
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
        run_one(&mut f);
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
        run_one(&mut f);
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
        run_one(&mut f);
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
}
