//! Registers a loop takes from the values that live through it.
//!
//! The allocator gives a value one place for its whole range, so a value
//! live through an inner loop that never reads it holds its register
//! there, and the loop's own values spill once the file is full. A loop
//! save stores such a value's register to a slot at the end of the loop's
//! preheader and loads it back at the loop's exits; inside the loop the
//! register belongs to values whose ranges lie in the loop. The colorer
//! takes a save when a node inside a loop finds no free register and the
//! saves cost less than the node's spill, as it takes a save around a
//! call.
//!
//! A loop qualifies when its header has one predecessor outside it and
//! each exit edge has a place for the load past the edge's phi moves: the
//! start of an exit target whose predecessors all lie in the loop and
//! which heads no loop, or the end of an exiting block with one successor.
//! The store goes ahead of the preheader's phi moves, which may write the
//! register for a header phi, so no preheader is a block loading past its
//! phi moves.

use alloc::collections::BTreeSet;
use alloc::vec::Vec;

use super::liveness::Liveness;
use crate::c5::codegen::passes::layout::{natural_loops, rpo_numbers};
use crate::c5::codegen::ssa::mem2reg::{dominators, predecessors, successors};
use crate::c5::ir::{BlockId, FunctionSsa, Inst, NO_VALUE, ValueId};

/// Where a saved value is loaded back.
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub(crate) enum Reload {
    /// At the start of this exit target.
    Start(BlockId),
    /// At the end of this exiting block, past its phi moves.
    End(BlockId),
}

/// A node a loop may save: what the save costs and where it reloads.
pub(crate) struct Through {
    pub node: ValueId,
    pub cost: u64,
    pub reloads: Vec<Reload>,
}

pub(crate) struct SaveLoop {
    pub preheader: BlockId,
    /// The innermost qualifying loop around this one.
    pub parent: Option<u32>,
    /// Nodes live through the loop that nothing in it reads, by node.
    pub through: Vec<Through>,
}

pub(crate) struct LoopSaves {
    pub loops: Vec<SaveLoop>,
    /// Per node: the innermost qualifying loop its range lies inside.
    pub inside: Vec<Option<u32>>,
}

impl LoopSaves {
    /// Whether loop `outer` is `l` or encloses it.
    pub(crate) fn encloses(&self, outer: u32, mut l: u32) -> bool {
        loop {
            if l == outer {
                return true;
            }
            match self.loops[l as usize].parent {
                Some(p) => l = p,
                None => return false,
            }
        }
    }

    /// The save of `node` around loop `l`, when the node lives through it.
    pub(crate) fn through(&self, l: u32, node: ValueId) -> Option<&Through> {
        let t = &self.loops[l as usize].through;
        t.binary_search_by_key(&node, |x| x.node)
            .ok()
            .map(|i| &t[i])
    }
}

/// A qualifying loop's body, sorted, and its exit edges with their reloads.
struct Shape {
    header: BlockId,
    preheader: BlockId,
    body: Vec<BlockId>,
    exits: Vec<(BlockId, Reload)>,
}

impl Shape {
    fn contains(&self, b: BlockId) -> bool {
        self.body.binary_search(&b).is_ok()
    }
}

/// The qualifying loops of `func`, the nodes each may save, and the loop
/// each node lies inside; `None` when no loop qualifies.
pub(crate) fn analyze(
    func: &FunctionSsa,
    liveness: &Liveness,
    node_of: &[ValueId],
    weights: &[u64],
) -> Option<LoopSaves> {
    if func.blocks.len() < 3 {
        return None;
    }
    let rpo = rpo_numbers(func);
    let idom = dominators(func);
    let preds = predecessors(func);
    let loops = natural_loops(func, &idom, &preds, &rpo);
    if loops.is_empty() {
        return None;
    }
    let succs: Vec<Vec<BlockId>> = (func.blocks.iter())
        .map(|b| {
            successors(
                &b.terminator,
                &func.computed_goto_targets,
                &func.jump_tables,
            )
        })
        .collect();
    let headers: BTreeSet<BlockId> = loops.iter().map(|l| l.header).collect();
    let mut shapes: Vec<Shape> = Vec::new();
    for l in &loops {
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
        let mut body = l.body.clone();
        body.sort_unstable();
        let mut exits = Vec::new();
        let mut ok = true;
        for &b in &body {
            for &s in &succs[b as usize] {
                if l.contains(s) {
                    continue;
                }
                let dedicated = preds[s as usize].iter().all(|&p| l.contains(p));
                exits.push(if dedicated && !headers.contains(&s) {
                    (s, Reload::Start(s))
                } else if succs[b as usize].len() == 1 {
                    (s, Reload::End(b))
                } else {
                    ok = false;
                    break;
                });
            }
        }
        if ok {
            shapes.push(Shape {
                header: l.header,
                preheader,
                body,
                exits,
            });
        }
    }
    let ends: BTreeSet<BlockId> = (shapes.iter().flat_map(|s| &s.exits))
        .filter_map(|&(_, at)| match at {
            Reload::End(b) => Some(b),
            Reload::Start(_) => None,
        })
        .collect();
    shapes.retain(|s| !ends.contains(&s.preheader));
    if shapes.is_empty() {
        return None;
    }
    // Innermost first: a smaller body is a deeper loop.
    shapes.sort_by_key(|s| s.body.len());
    let n = func.insts.len();
    let block_of = block_index(func);
    let live = liveness.block_liveness();
    let weight = |b: BlockId| weights.get(b as usize).copied().unwrap_or(1);
    let mut members: Vec<Vec<ValueId>> = alloc::vec![Vec::new(); n];
    for (v, &node) in node_of.iter().enumerate() {
        if block_of[v] != BlockId::MAX {
            members[node as usize].push(v as ValueId);
        }
    }
    let mut out = LoopSaves {
        loops: Vec::with_capacity(shapes.len()),
        inside: alloc::vec![None; n],
    };
    for (idx, sh) in shapes.iter().enumerate() {
        // Nodes read inside the loop: by an instruction or a block end of
        // the body, or by a phi incoming from a body block.
        let mut read = alloc::vec![false; n];
        let mut mark = |v: ValueId| {
            if v != NO_VALUE && (v as usize) < n {
                read[node_of[v as usize] as usize] = true;
            }
        };
        for (i, inst) in func.insts.iter().enumerate() {
            match inst {
                Inst::Phi { incoming, .. } => {
                    for &(p, v) in incoming {
                        if sh.contains(p) {
                            mark(v);
                        }
                    }
                }
                _ if sh.contains(block_of[i]) => inst.for_each_operand(&mut mark),
                _ => {}
            }
        }
        for &b in &sh.body {
            let block = &func.blocks[b as usize];
            block.terminator.for_each_operand(&mut mark);
            mark(block.exit_acc);
        }
        let mut through: Vec<Through> = Vec::new();
        let mut seen = BTreeSet::new();
        live.for_each_live_in(sh.header, |v| {
            let node = node_of[v as usize];
            if read[node as usize] || sh.contains(block_of[v as usize]) || !seen.insert(node) {
                return;
            }
            let mut cost = weight(sh.preheader);
            let mut reloads: Vec<Reload> = Vec::new();
            for &(s, at) in &sh.exits {
                if live.live_in(s, v) && !reloads.contains(&at) {
                    let (Reload::Start(x) | Reload::End(x)) = at;
                    cost = cost.saturating_add(weight(x));
                    reloads.push(at);
                }
            }
            if !reloads.is_empty() {
                through.push(Through {
                    node,
                    cost,
                    reloads,
                });
            }
        });
        through.sort_by_key(|t| t.node);
        let parent = (idx + 1..shapes.len())
            .find(|&j| shapes[j].contains(sh.header))
            .map(|j| j as u32);
        out.loops.push(SaveLoop {
            preheader: sh.preheader,
            parent,
            through,
        });
        // A node whose members are defined in the loop and live neither
        // into its header nor out of it.
        for (node, ms) in members.iter().enumerate() {
            if ms.is_empty() || out.inside[node].is_some() {
                continue;
            }
            let lies_inside = ms.iter().all(|&m| {
                sh.contains(block_of[m as usize])
                    && !live.live_in(sh.header, m)
                    && sh.exits.iter().all(|&(s, _)| !live.live_in(s, m))
            });
            if lies_inside {
                out.inside[node] = Some(idx as u32);
            }
        }
    }
    Some(out)
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
