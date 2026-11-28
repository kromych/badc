//! Registers a loop or a branch arm takes from the values that live
//! through it.
//!
//! The allocator gives a value one place for its whole range, so a value
//! live through a region that never reads it holds its register there, and
//! the region's own values spill once the file is full. A save stores such
//! a value's register to a slot where control enters the region and loads
//! it back at the region's exits; inside the region the register belongs
//! to values whose ranges lie in it. The colorer takes a save when a node
//! inside a region finds no free register and the saves cost less than the
//! node's spill, as it takes a save around a call.
//!
//! A loop qualifies when its header has one predecessor outside it and
//! each exit edge has a place for the load past the edge's phi moves: the
//! start of an exit target whose predecessors all lie in the loop and
//! which heads no loop, or the end of an exiting block with one successor.
//! The store goes ahead of the preheader's phi moves, which may write the
//! register for a header phi, so no preheader is a block loading past its
//! phi moves.
//!
//! A branch arm is a block whose one predecessor has other successors,
//! with the blocks it dominates that lie in the innermost loop holding it:
//! a case of a switch, or a side of an if. Its store goes at the start of
//! that block, which has no phis. Its loads go where a loop's do, except
//! that an exiting block storing at its end takes none, and a value live
//! out along an exit with no place for a load is not saved around it. On
//! a reducible graph the loops and the arms nest, so a node lies in a
//! chain of regions, and the colorer weighs the saves around each of them
//! up to the innermost loop.

use alloc::collections::BTreeSet;
use alloc::vec::Vec;
use core::cell::OnceCell;

use super::liveness::{BlockLiveness, Liveness};
use crate::c5::codegen::passes::layout::{
    LoopForest, NaturalLoop, is_irreducible, natural_loops, rpo_numbers,
};
use crate::c5::codegen::ssa::mem2reg::{dominators, predecessors, successors};
use crate::c5::ir::{BlockId, FunctionSsa, Inst, NO_VALUE, Terminator, ValueId};

const NO_REGION: u32 = u32::MAX;

/// Where a saved value is loaded back.
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub(crate) enum Reload {
    /// At the start of this exit target.
    Start(BlockId),
    /// At the end of this exiting block, past its phi moves.
    End(BlockId),
}

/// Where a region stores the values saved around it.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum Store {
    /// At the end of a loop's preheader, ahead of its phi moves.
    End(BlockId),
    /// At the start of a branch arm's first block.
    Start(BlockId),
}

/// A node a region may save: what the save costs and where it reloads.
pub(crate) struct Through {
    pub cost: u64,
    pub reloads: Vec<Reload>,
}

pub(crate) struct Region {
    pub store: Store,
    /// The innermost region around this one.
    pub parent: Option<u32>,
    pub is_loop: bool,
    /// The block a value living through the region is live into.
    head: BlockId,
    /// The edges leaving the region, from and to, with the place of the load
    /// of a value the target reads; `None` where none can go.
    exits: Vec<(BlockId, BlockId, Option<Reload>)>,
    /// The region and those inside it, as a range of the tree's preorder.
    span: (u32, u32),
}

/// One row per key, ascending.
struct Rows {
    start: Vec<u32>,
    items: Vec<u32>,
}

impl Rows {
    fn build(n: usize, mut pairs: Vec<(u32, u32)>) -> Self {
        pairs.sort_unstable();
        pairs.dedup();
        let mut start = alloc::vec![0u32; n + 1];
        for &(k, _) in &pairs {
            start[k as usize + 1] += 1;
        }
        for i in 0..n {
            start[i + 1] += start[i];
        }
        let items = pairs.into_iter().map(|(_, x)| x).collect();
        Rows { start, items }
    }

    fn row(&self, k: ValueId) -> &[u32] {
        let k = k as usize;
        match (self.start.get(k), self.start.get(k + 1)) {
            (Some(&a), Some(&b)) => &self.items[a as usize..b as usize],
            _ => &[],
        }
    }
}

struct Regions<'a> {
    loops: Vec<Region>,
    live: &'a BlockLiveness,
    weights: &'a [u64],
    /// Per block: the innermost region holding it.
    home: Vec<u32>,
    block_of: Vec<BlockId>,
    /// Per node: its members; the preorder numbers of the homes of the
    /// blocks reading it, and of those defining it.
    members: Rows,
    reads: Rows,
    defs: Rows,
    /// Per block: the nodes a phi takes from it as its own class's value,
    /// which no move reads.
    kept: Rows,
}

impl Regions<'_> {
    /// Whether region `outer` is `l` or encloses it.
    pub(crate) fn encloses(&self, outer: u32, l: u32) -> bool {
        let (a, b) = self.loops[outer as usize].span;
        (a..b).contains(&self.loops[l as usize].span.0)
    }

    fn holds(&self, l: u32, b: BlockId) -> bool {
        let h = self.home.get(b as usize).copied().unwrap_or(NO_REGION);
        h != NO_REGION && self.encloses(l, h)
    }

    /// Whether a preorder number of `row` falls in region `l`.
    fn meets(&self, l: u32, row: &[u32]) -> bool {
        let (a, b) = self.loops[l as usize].span;
        row.get(row.partition_point(|&p| p < a))
            .is_some_and(|&p| p < b)
    }

    fn weight(&self, b: BlockId) -> u64 {
        self.weights.get(b as usize).copied().unwrap_or(1)
    }

    /// The save of `node` around region `l`, when the node lives through it:
    /// live into it, and neither read nor defined in it.
    pub(crate) fn through(&self, l: u32, node: ValueId) -> Option<Through> {
        let r = &self.loops[l as usize];
        let v = *(self.members.row(node).iter()).find(|&&m| self.live.live_in(r.head, m))?;
        if self.meets(l, self.reads.row(node)) || self.meets(l, self.defs.row(node)) {
            return None;
        }
        let (Store::End(at) | Store::Start(at)) = r.store;
        let mut cost = self.weight(at);
        let mut reloads: Vec<Reload> = Vec::new();
        for &(b, s, at) in &r.exits {
            // A phi of the node's own class at the target takes the value
            // in place on this edge alone.
            let kept = self.kept.row(b).binary_search(&node).is_ok();
            if !kept && !self.live.live_in(s, v) {
                continue;
            }
            let at = at?;
            if kept && matches!(at, Reload::Start(_)) {
                return None;
            }
            if !reloads.contains(&at) {
                let (Reload::Start(x) | Reload::End(x)) = at;
                cost = cost.saturating_add(self.weight(x));
                reloads.push(at);
            }
        }
        (!reloads.is_empty()).then_some(Through { cost, reloads })
    }

    /// The innermost region `node`'s range lies inside: every member
    /// defined in it, none live into it or out of it.
    pub(crate) fn inside(&self, node: ValueId) -> Option<u32> {
        let ms = self.members.row(node);
        let mut l = self.home[self.block_of[*ms.first()? as usize] as usize];
        if l == NO_REGION {
            return None;
        }
        while !ms.iter().all(|&m| self.holds(l, self.block_of[m as usize])) {
            l = self.loops[l as usize].parent?;
        }
        loop {
            let r = &self.loops[l as usize];
            let out = |m: &u32| {
                self.live.live_in(r.head, *m)
                    || r.exits.iter().any(|&(_, s, _)| self.live.live_in(s, *m))
            };
            if !ms.iter().any(out) {
                return Some(l);
            }
            l = r.parent?;
        }
    }

    /// The regions a node inside `l` may save around: `l` and those around
    /// it up to the innermost loop.
    pub(crate) fn chain(&self, l: u32) -> impl Iterator<Item = u32> + '_ {
        core::iter::successors(Some(l), |&r| {
            let r = &self.loops[r as usize];
            if r.is_loop { None } else { r.parent }
        })
    }
}

/// The regions of a function, found when the colorer first asks: most
/// allocations spill nothing and ask nothing.
pub(crate) struct LoopSaves<'a> {
    func: &'a FunctionSsa,
    liveness: &'a Liveness,
    node_of: &'a [ValueId],
    weights: &'a [u64],
    found: OnceCell<Option<Regions<'a>>>,
}

impl<'a> LoopSaves<'a> {
    fn get(&self) -> Option<&Regions<'a>> {
        self.found
            .get_or_init(|| regions(self.func, self.liveness, self.node_of, self.weights))
            .as_ref()
    }

    /// Whether region `outer` is `l` or encloses it.
    pub(crate) fn encloses(&self, outer: u32, l: u32) -> bool {
        self.get().is_some_and(|r| r.encloses(outer, l))
    }

    pub(crate) fn is_loop(&self, l: u32) -> bool {
        self.get().is_some_and(|r| r.loops[l as usize].is_loop)
    }

    /// Where region `l` stores the values saved around it.
    pub(crate) fn store(&self, l: u32) -> Option<Store> {
        Some(self.get()?.loops.get(l as usize)?.store)
    }

    /// The save of `node` around region `l`, when the node lives through it:
    /// live into it, and neither read nor defined in it.
    pub(crate) fn through(&self, l: u32, node: ValueId) -> Option<Through> {
        self.get()?.through(l, node)
    }

    /// The innermost region `node`'s range lies inside.
    pub(crate) fn inside(&self, node: ValueId) -> Option<u32> {
        self.get()?.inside(node)
    }

    /// The regions a node inside `l` may save around: `l` and those around
    /// it up to the innermost loop.
    pub(crate) fn chain(&self, l: u32) -> impl Iterator<Item = u32> + '_ {
        self.get().into_iter().flat_map(move |r| r.chain(l))
    }
}

/// The saves of `func`'s loops and arms; none for fewer than three blocks.
pub(crate) fn analyze<'a>(
    func: &'a FunctionSsa,
    liveness: &'a Liveness,
    node_of: &'a [ValueId],
    weights: &'a [u64],
) -> LoopSaves<'a> {
    LoopSaves {
        func,
        liveness,
        node_of,
        weights,
        found: OnceCell::new(),
    }
}

/// A qualifying loop and its exit edges with their reloads.
struct Shape {
    natural: usize,
    header: BlockId,
    preheader: BlockId,
    exits: Vec<(BlockId, BlockId, Reload)>,
}

/// The qualifying loops and arms of `func` and what their saves need;
/// `None` when none qualifies.
fn regions<'a>(
    func: &FunctionSsa,
    liveness: &'a Liveness,
    node_of: &[ValueId],
    weights: &'a [u64],
) -> Option<Regions<'a>> {
    let nb = func.blocks.len();
    if nb < 3 {
        return None;
    }
    let rpo = rpo_numbers(func);
    let idom = dominators(func);
    let preds = predecessors(func);
    let loops = natural_loops(func, &idom, &preds, &rpo);
    let succs: Vec<Vec<BlockId>> = (func.blocks.iter())
        .map(|b| {
            successors(
                &b.terminator,
                &func.computed_goto_targets,
                &func.jump_tables,
            )
        })
        .collect();
    let shapes = loop_shapes(&loops, &preds, &succs);
    let forest = LoopForest::build(nb, &loops);
    let nest = Nesting::build(&idom, &rpo, &forest);
    let arms = if func.has_seh() || is_irreducible(func, &idom, &rpo) {
        Vec::new()
    } else {
        arm_heads(func, &nest.order, &preds, &succs)
    };
    if shapes.is_empty() && arms.is_empty() {
        return None;
    }
    let mut regions: Vec<Region> = Vec::with_capacity(shapes.len() + arms.len());
    let mut of_loop = alloc::vec![NO_REGION; loops.len()];
    for sh in &shapes {
        of_loop[sh.natural] = regions.len() as u32;
        regions.push(Region {
            store: Store::End(sh.preheader),
            parent: None,
            is_loop: true,
            head: sh.header,
            exits: sh
                .exits
                .iter()
                .map(|&(b, s, at)| (b, s, Some(at)))
                .collect(),
            span: (0, 0),
        });
    }
    let mut of_arm = alloc::vec![NO_REGION; nb];
    for &h in &arms {
        of_arm[h as usize] = regions.len() as u32;
        regions.push(Region {
            store: Store::Start(h),
            parent: None,
            is_loop: false,
            head: h,
            exits: Vec::new(),
            span: (0, 0),
        });
    }
    // Per natural loop, the innermost qualifying one holding it.
    let mut loop_up = alloc::vec![NO_REGION; loops.len()];
    for &l in &nest.loops {
        loop_up[l] = match (of_loop[l], forest.parent[l]) {
            (NO_REGION, Some(p)) => loop_up[p],
            (r, _) => r,
        };
    }
    let loop_of = |b: BlockId| forest.innermost[b as usize].map_or(NO_REGION, |l| loop_up[l]);
    // The innermost arm holding block `b` whose head is `from` or dominates it.
    let arm_of = |b: BlockId, mut from: BlockId| loop {
        let r = of_arm[from as usize];
        if r != NO_REGION && nest.arm_holds(from, b) {
            return r;
        }
        match idom.get(from as usize) {
            Some(&d) if from != 0 && (d as usize) < nb && d != from => from = d,
            _ => return NO_REGION,
        }
    };
    // Of an arm and a loop both holding a block, the inner one.
    let inner = |arm: u32, l: u32| match (arm, l) {
        (NO_REGION, x) | (x, NO_REGION) => x,
        _ if nest.arm_holds(regions[arm as usize].head, regions[l as usize].head) => l,
        _ => arm,
    };
    let home: Vec<u32> = (0..nb as BlockId)
        .map(|b| {
            let arm = if nest.reached(b) {
                arm_of(b, b)
            } else {
                NO_REGION
            };
            inner(arm, loop_of(b))
        })
        .collect();
    let parents: Vec<u32> = (regions.iter().enumerate())
        .map(|(r, region)| {
            let h = region.head;
            let arm = if h == 0 || !nest.reached(h) {
                NO_REGION
            } else {
                arm_of(h, idom[h as usize])
            };
            let l = if region.is_loop {
                forest.parent[shapes[r].natural].map_or(NO_REGION, |p| loop_up[p])
            } else {
                loop_of(h)
            };
            inner(arm, l)
        })
        .collect();
    for (region, p) in regions.iter_mut().zip(parents) {
        region.parent = (p != NO_REGION).then_some(p);
    }
    number(&mut regions);
    let mut out = Regions {
        loops: regions,
        live: liveness.block_liveness(),
        weights,
        home,
        block_of: block_index(func),
        members: Rows::build(0, Vec::new()),
        reads: Rows::build(0, Vec::new()),
        defs: Rows::build(0, Vec::new()),
        kept: Rows::build(0, Vec::new()),
    };
    arm_exits(&mut out, func, (&preds, &succs), (&loops, &shapes));
    node_rows(&mut out, func, node_of);
    Some(out)
}

/// The loops whose saves have a place: one predecessor outside, a reload
/// on every exit, and a preheader no exit loads at the end of.
fn loop_shapes(
    loops: &[NaturalLoop],
    preds: &[Vec<BlockId>],
    succs: &[Vec<BlockId>],
) -> Vec<Shape> {
    let headers: BTreeSet<BlockId> = loops.iter().map(|l| l.header).collect();
    let mut shapes: Vec<Shape> = Vec::new();
    for (natural, l) in loops.iter().enumerate() {
        let outside: Vec<BlockId> = (preds[l.header as usize].iter().copied())
            .filter(|&p| !l.contains(p))
            .collect();
        // The entry block runs ahead of the frame in the early-exit form.
        let [preheader] = outside[..] else {
            continue;
        };
        if preheader == 0 {
            continue;
        }
        let mut exits = Vec::new();
        let mut ok = true;
        for &b in &l.body {
            for &s in &succs[b as usize] {
                if l.contains(s) {
                    continue;
                }
                let dedicated = preds[s as usize].iter().all(|&p| l.contains(p));
                exits.push(if dedicated && !headers.contains(&s) {
                    (b, s, Reload::Start(s))
                } else if succs[b as usize].len() == 1 {
                    (b, s, Reload::End(b))
                } else {
                    ok = false;
                    break;
                });
            }
        }
        if ok {
            shapes.push(Shape {
                natural,
                header: l.header,
                preheader,
                exits,
            });
        }
    }
    let ends: BTreeSet<BlockId> = (shapes.iter().flat_map(|s| &s.exits))
        .filter_map(|&(_, _, at)| match at {
            Reload::End(b) => Some(b),
            Reload::Start(_) => None,
        })
        .collect();
    shapes.retain(|s| !ends.contains(&s.preheader));
    shapes
}

/// The dominator tree and the loop forest as preorder intervals.
struct Nesting<'f> {
    forest: &'f LoopForest,
    /// The reachable blocks in a preorder of the dominator tree.
    order: Vec<BlockId>,
    /// Per block: its preorder number, and the last of its subtree.
    tin: Vec<u32>,
    tout: Vec<u32>,
    /// The natural loops, outermost first; per loop, its preorder number in
    /// the forest, and the last of its subtree.
    loops: Vec<usize>,
    lin: Vec<u32>,
    lout: Vec<u32>,
}

impl<'f> Nesting<'f> {
    fn build(idom: &[BlockId], rpo: &[usize], forest: &'f LoopForest) -> Self {
        let n = idom.len();
        let mut kids: Vec<Vec<usize>> = alloc::vec![Vec::new(); n];
        for b in 1..n {
            let d = idom[b] as usize;
            if rpo[b] != usize::MAX && d < n && d != b {
                kids[d].push(b);
            }
        }
        let (order, tin, tout) = preorder(n, &[0], &kids);
        let mut lkids: Vec<Vec<usize>> = alloc::vec![Vec::new(); forest.parent.len()];
        let mut roots: Vec<usize> = Vec::new();
        for (l, p) in forest.parent.iter().enumerate() {
            match *p {
                Some(p) => lkids[p].push(l),
                None => roots.push(l),
            }
        }
        let (loops, lin, lout) = preorder(lkids.len(), &roots, &lkids);
        Nesting {
            forest,
            order: order.into_iter().map(|b| b as BlockId).collect(),
            tin,
            tout,
            loops,
            lin,
            lout,
        }
    }

    fn reached(&self, b: BlockId) -> bool {
        self.tin[b as usize] != u32::MAX
    }

    /// Whether the arm headed by `h` holds block `b`: `h` dominates it, and
    /// it lies in the innermost loop holding `h`.
    fn arm_holds(&self, h: BlockId, b: BlockId) -> bool {
        let (h, b) = (h as usize, b as usize);
        let dominated =
            self.reached(b as BlockId) && (self.tin[h]..=self.tout[h]).contains(&self.tin[b]);
        let within = |l: usize| {
            self.forest.innermost[b]
                .is_some_and(|k| (self.lin[l]..=self.lout[l]).contains(&self.lin[k]))
        };
        dominated && self.forest.innermost[h].is_none_or(within)
    }
}

/// A preorder of the forest under `roots`: the nodes in order, and per node
/// its number (`u32::MAX` unreached) and the last number in its subtree.
fn preorder(n: usize, roots: &[usize], kids: &[Vec<usize>]) -> (Vec<usize>, Vec<u32>, Vec<u32>) {
    let mut order = Vec::with_capacity(n);
    let mut tin = alloc::vec![u32::MAX; n];
    let mut tout = alloc::vec![0u32; n];
    let mut stack: Vec<(usize, bool)> = roots.iter().rev().map(|&r| (r, false)).collect();
    while let Some((x, done)) = stack.pop() {
        if done {
            tout[x] = order.len() as u32 - 1;
            continue;
        }
        if tin[x] != u32::MAX {
            continue;
        }
        tin[x] = order.len() as u32;
        order.push(x);
        stack.push((x, true));
        stack.extend(kids[x].iter().rev().map(|&k| (k, false)));
    }
    (order, tin, tout)
}

/// The heads of the arms: a reachable block whose one predecessor has
/// another successor and does not end in `asm goto`.
fn arm_heads(
    func: &FunctionSsa,
    order: &[BlockId],
    preds: &[Vec<BlockId>],
    succs: &[Vec<BlockId>],
) -> Vec<BlockId> {
    let mut out = Vec::new();
    for &h in order.iter().filter(|&&h| h != 0) {
        let mut from = preds[h as usize].clone();
        from.sort_unstable();
        from.dedup();
        let [p] = from[..] else {
            continue;
        };
        let p = p as usize;
        let branches = succs[p].iter().any(|&s| s != h);
        if branches && !matches!(func.blocks[p].terminator, Terminator::AsmGoto { .. }) {
            out.push(h);
        }
    }
    out.sort_unstable();
    out
}

/// Number the regions in a preorder of their tree.
fn number(regions: &mut [Region]) {
    let mut kids: Vec<Vec<u32>> = alloc::vec![Vec::new(); regions.len()];
    let mut stack: Vec<(u32, bool)> = Vec::new();
    for (r, region) in regions.iter().enumerate().rev() {
        match region.parent {
            Some(p) => kids[p as usize].push(r as u32),
            None => stack.push((r as u32, false)),
        }
    }
    let mut clock = 0u32;
    while let Some((r, done)) = stack.pop() {
        if done {
            regions[r as usize].span.1 = clock;
            continue;
        }
        regions[r as usize].span.0 = clock;
        clock += 1;
        stack.push((r, true));
        stack.extend(kids[r as usize].iter().map(|&k| (k, false)));
    }
}

/// Each arm's exit edges, with the load of a value live into the target at
/// the start of a target whose predecessors all lie in the arm and which
/// heads no loop, or at the end of an exiting block that jumps and stores
/// nothing at its end.
fn arm_exits(
    out: &mut Regions<'_>,
    func: &FunctionSsa,
    (preds, succs): (&[Vec<BlockId>], &[Vec<BlockId>]),
    (loops, shapes): (&[NaturalLoop], &[Shape]),
) {
    let headers: BTreeSet<BlockId> = loops.iter().map(|l| l.header).collect();
    let preheaders: BTreeSet<BlockId> = shapes.iter().map(|s| s.preheader).collect();
    let mut exits: Vec<(u32, BlockId, BlockId, Option<Reload>)> = Vec::new();
    for (b, block) in func.blocks.iter().enumerate() {
        let jumps = matches!(block.terminator, Terminator::Jmp(_));
        let end = (jumps && succs[b].len() == 1 && !preheaders.contains(&(b as BlockId)))
            .then_some(Reload::End(b as BlockId));
        for &s in &succs[b] {
            let mut r = out.home[b];
            while r != NO_REGION && !out.holds(r, s) {
                if !out.loops[r as usize].is_loop {
                    let dedicated = preds[s as usize].iter().all(|&p| out.holds(r, p));
                    let at = if dedicated && !headers.contains(&s) {
                        Some(Reload::Start(s))
                    } else {
                        end
                    };
                    exits.push((r, b as BlockId, s, at));
                }
                r = out.loops[r as usize].parent.unwrap_or(NO_REGION);
            }
        }
    }
    for (r, b, s, at) in exits {
        out.loops[r as usize].exits.push((b, s, at));
    }
}

/// The members of each node, and the regions reading and defining it.
fn node_rows(out: &mut Regions<'_>, func: &FunctionSsa, node_of: &[ValueId]) {
    let n = func.insts.len();
    let at = |b: BlockId| match out.home.get(b as usize) {
        Some(&h) if h != NO_REGION => Some(out.loops[h as usize].span.0),
        _ => None,
    };
    let mut members = Vec::new();
    let mut defs = Vec::new();
    let mut reads = Vec::new();
    let mut kept = Vec::new();
    let mut read = |v: ValueId, b: BlockId| {
        if v != NO_VALUE
            && (v as usize) < n
            && let Some(p) = at(b)
        {
            reads.push((node_of[v as usize], p));
        }
    };
    for (b, block) in func.blocks.iter().enumerate() {
        let b = b as BlockId;
        for i in block.inst_range.clone() {
            match &func.insts[i as usize] {
                Inst::Phi { incoming, .. } => {
                    for &(p, v) in incoming {
                        if node_of.get(v as usize) == Some(&node_of[i as usize]) {
                            kept.push((p, node_of[i as usize]));
                        } else {
                            read(v, p);
                        }
                    }
                }
                inst => inst.for_each_operand(|v| read(v, b)),
            }
        }
        block.terminator.for_each_operand(|v| read(v, b));
        read(block.exit_acc, b);
    }
    for (v, &b) in out.block_of.iter().enumerate() {
        if b == BlockId::MAX {
            continue;
        }
        members.push((node_of[v], v as u32));
        if let Some(p) = at(b) {
            defs.push((node_of[v], p));
        }
    }
    out.members = Rows::build(n, members);
    out.reads = Rows::build(n, reads);
    out.defs = Rows::build(n, defs);
    out.kept = Rows::build(func.blocks.len(), kept);
}

fn block_index(func: &FunctionSsa) -> Vec<BlockId> {
    let mut of = alloc::vec![BlockId::MAX; func.insts.len()];
    for (b, block) in func.blocks.iter().enumerate() {
        for i in block.inst_range.clone() {
            if let Some(slot) = of.get_mut(i as usize) {
                *slot = b as BlockId;
            }
        }
    }
    of
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{Block, InstSrc, LoadKind, StoreKind};

    fn load(off: i64) -> Inst {
        Inst::LoadLocal {
            disp: 0,
            off,
            kind: LoadKind::I64,
            volatile: false,
        }
    }

    fn store(value: ValueId) -> Inst {
        Inst::StoreLocal {
            disp: 0,
            off: -1,
            value,
            kind: StoreKind::I64,
            volatile: false,
            nsw: false,
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

    /// `v0` is read past an if whose arms are b1 and b2; b1 reads it not,
    /// b2 does, and `v3` is defined and read in b1 alone.
    fn diamond() -> FunctionSsa {
        let insts = alloc::vec![
            load(2),
            load(3),
            load(4),
            load(5),
            store(3),
            store(0),
            store(0)
        ];
        let n = insts.len();
        FunctionSsa {
            inst_src: alloc::vec![InstSrc::default(); n],
            f32_values: alloc::vec![false; n],
            insts,
            blocks: alloc::vec![
                block(
                    0..2,
                    Terminator::Bz {
                        cond: 1,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(2..5, Terminator::Jmp(3)),
                block(5..6, Terminator::Jmp(3)),
                block(6..7, Terminator::Return(NO_VALUE)),
            ],
            ..Default::default()
        }
    }

    /// A value an arm does not read is saved around it, loaded back at the
    /// end of the arm's jump to the join; the arm reading it does not take
    /// it, and a value defined and read in an arm lies inside it.
    #[test]
    fn an_arm_saves_a_value_it_does_not_read() {
        let f = diamond();
        let live = Liveness::compute(&f);
        let node_of: Vec<ValueId> = (0..f.insts.len() as ValueId).collect();
        let weights = alloc::vec![1u64; f.blocks.len()];
        let info = analyze(&f, &live, &node_of, &weights);
        let arm = |h: BlockId| {
            (0..)
                .find(|&r| info.store(r).is_none_or(|s| s == Store::Start(h)))
                .filter(|&r| info.store(r).is_some())
                .expect("arm")
        };
        let (b1, b2) = (arm(1), arm(2));
        let t = info.through(b1, 0).expect("v0 lives through b1");
        assert_eq!(t.reloads, alloc::vec![Reload::End(1)]);
        assert_eq!(t.cost, 2, "a store at the head and a load at the exit");
        assert!(info.through(b2, 0).is_none(), "b2 reads v0");
        assert_eq!(info.inside(3), Some(b1));
        assert_eq!(info.inside(0), None);
    }
}
