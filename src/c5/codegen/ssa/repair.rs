//! Restore SSA form after a CFG edit gives a value a second definition.
//!
//! Moving an edge `p -> head` past the head to one of its successors
//! leaves the head's values short of dominating the blocks the edge now
//! reaches: a head phi is still the value at the end of the head's
//! blocks, while the moved edge carries the phi's incoming from `p`. Each
//! read outside the head is renamed to the definition that reaches it,
//! with a phi where two meet: the on-demand construction with trivial-phi
//! removal of Braun et al., "Simple and Efficient Construction of Static
//! Single Assignment Form" (CC 2013), explored with a worklist.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use super::tape::{self, At, Insertion};
use crate::c5::ir::{BlockId, FunctionSsa, Inst, LoadKind, ValueId};

/// A value that is the definition at the end of each `home` block, while
/// each edge in `edges` carries its own value.
pub(crate) struct Redefined {
    pub value: ValueId,
    pub kind: LoadKind,
    pub home: Vec<BlockId>,
    /// `(from, to, v)`: the edge `from -> to` carries `v`.
    pub edges: Vec<(BlockId, BlockId, ValueId)>,
}

/// A value, or the one reaching the start of a block.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum Src {
    Val(ValueId),
    Entry(BlockId),
}

/// A read of a [`Redefined`] value outside its home.
enum Read {
    /// The operands of the instruction at this index.
    Operand(ValueId, Src),
    /// The incoming of the phi at this index from the block.
    Incoming(ValueId, BlockId, Src),
    /// The terminator and the exit value of the block.
    End(BlockId, Src),
}

/// Per [`Redefined`]: the blocks that need a phi, with each
/// predecessor's source, and the reads with theirs.
pub(crate) struct Plan {
    phis: BTreeMap<BlockId, Vec<(BlockId, Src)>>,
    reads: Vec<Read>,
}

/// The phis and renames that rename every read of each item outside its
/// home, over the CFG whose predecessor lists are `preds`, or `None` when
/// a read is reached by no definition.
pub(crate) fn plan(
    func: &FunctionSsa,
    preds: &[Vec<BlockId>],
    items: &[Redefined],
) -> Option<Vec<Plan>> {
    let live = reachable(func, preds);
    items
        .iter()
        .map(|r| plan_one(func, preds, &live, r))
        .collect()
}

fn plan_one(
    func: &FunctionSsa,
    preds: &[Vec<BlockId>],
    live: &[bool],
    r: &Redefined,
) -> Option<Plan> {
    let home = |b: BlockId| r.home.contains(&b);
    let on_edge = |q: BlockId, b: BlockId| match r.edges.iter().find(|e| e.0 == q && e.1 == b) {
        Some(&(_, _, v)) => Src::Val(v),
        None if home(q) => Src::Val(r.value),
        None => Src::Entry(q),
    };
    let mut reads = Vec::new();
    let mut want: Vec<BlockId> = Vec::new();
    for (b, block) in func.blocks.iter().enumerate() {
        let b = b as BlockId;
        if !live[b as usize] {
            continue;
        }
        for i in block.inst_range.clone() {
            match &func.insts[i as usize] {
                // Read at the end of the predecessor, a home phi's too.
                Inst::Phi { incoming, .. } => {
                    for &(q, v) in incoming {
                        if v != r.value || home(q) || !live[q as usize] {
                            continue;
                        }
                        let src = on_edge(q, b);
                        if let Src::Entry(e) = src {
                            want.push(e);
                        }
                        reads.push(Read::Incoming(i, q, src));
                    }
                }
                _ if home(b) => {}
                inst => {
                    let mut reads_it = false;
                    inst.for_each_operand(|v| reads_it |= v == r.value);
                    if reads_it {
                        want.push(b);
                        reads.push(Read::Operand(i, Src::Entry(b)));
                    }
                }
            }
        }
        if home(b) {
            continue;
        }
        let mut reads_it = block.exit_acc == r.value;
        block
            .terminator
            .for_each_operand(|v| reads_it |= v == r.value);
        if reads_it {
            want.push(b);
            reads.push(Read::End(b, Src::Entry(b)));
        }
    }
    // The sources each block's start merges, from its predecessors.
    let mut nodes: BTreeMap<BlockId, Vec<(BlockId, Src)>> = BTreeMap::new();
    while let Some(b) = want.pop() {
        if nodes.contains_key(&b) {
            continue;
        }
        let mut ps = preds[b as usize].clone();
        ps.sort_unstable();
        ps.dedup();
        if ps.is_empty() || ps.iter().any(|&q| !live[q as usize]) {
            return None;
        }
        let incoming: Vec<(BlockId, Src)> = ps.iter().map(|&q| (q, on_edge(q, b))).collect();
        want.extend(incoming.iter().filter_map(|&(_, s)| match s {
            Src::Entry(q) => Some(q),
            Src::Val(_) => None,
        }));
        nodes.insert(b, incoming);
    }
    // A start whose sources, itself aside, are one source is that source.
    let mut same: BTreeMap<BlockId, Src> = BTreeMap::new();
    loop {
        let mut changed = false;
        for (&b, incoming) in &nodes {
            if same.contains_key(&b) {
                continue;
            }
            let distinct: BTreeSet<Src> = incoming
                .iter()
                .map(|&(_, s)| resolve(&same, s))
                .filter(|&s| s != Src::Entry(b))
                .collect();
            match distinct.len() {
                0 => return None,
                1 => {
                    same.insert(b, *distinct.first()?);
                    changed = true;
                }
                _ => {}
            }
        }
        if !changed {
            break;
        }
    }
    let phis = nodes
        .into_iter()
        .filter(|(b, _)| !same.contains_key(b))
        .map(|(b, incoming)| {
            let incoming = incoming
                .into_iter()
                .map(|(q, s)| (q, resolve(&same, s)))
                .collect();
            (b, incoming)
        })
        .collect();
    let reads = reads
        .into_iter()
        .map(|read| match read {
            Read::Operand(i, s) => Read::Operand(i, resolve(&same, s)),
            Read::Incoming(i, q, s) => Read::Incoming(i, q, resolve(&same, s)),
            Read::End(b, s) => Read::End(b, resolve(&same, s)),
        })
        .collect();
    Some(Plan { phis, reads })
}

/// `s` through the starts [`plan_one`] found equal to one source.
fn resolve(same: &BTreeMap<BlockId, Src>, mut s: Src) -> Src {
    for _ in 0..=same.len() {
        match s {
            Src::Entry(b) => match same.get(&b) {
                Some(&t) => s = t,
                None => return s,
            },
            Src::Val(_) => return s,
        }
    }
    s
}

/// Blocks reachable from the entry and the computed-goto targets over
/// `preds`.
fn reachable(func: &FunctionSsa, preds: &[Vec<BlockId>]) -> Vec<bool> {
    let mut succs: Vec<Vec<BlockId>> = alloc::vec![Vec::new(); preds.len()];
    for (b, ps) in preds.iter().enumerate() {
        for &q in ps {
            succs[q as usize].push(b as BlockId);
        }
    }
    let mut live = alloc::vec![false; preds.len()];
    let mut stack: Vec<BlockId> = alloc::vec![0];
    stack.extend(&func.computed_goto_targets);
    while let Some(b) = stack.pop() {
        if !core::mem::replace(&mut live[b as usize], true) {
            stack.extend(&succs[b as usize]);
        }
    }
    live
}

/// Insert the phis of `plans` and rename the reads, in the CFG the plans
/// were made over.
pub(crate) fn apply(func: &mut FunctionSsa, items: &[Redefined], plans: &[Plan]) {
    let mut placed: Vec<(usize, BlockId, Insertion)> = Vec::new();
    for (k, (r, p)) in items.iter().zip(plans).enumerate() {
        for &b in p.phis.keys() {
            let range = &func.blocks[b as usize].inst_range;
            let at = if range.is_empty() {
                At::Empty(b)
            } else {
                At::Before(range.start)
            };
            let inst = Inst::Phi {
                incoming: Vec::new(),
                kind: r.kind,
            };
            let is_f32 = func
                .f32_values
                .get(r.value as usize)
                .copied()
                .unwrap_or(false);
            placed.push((k, b, Insertion { at, inst, is_f32 }));
        }
    }
    placed.sort_by_key(|(_, _, i)| i.at.order(&func.blocks));
    let slot: BTreeMap<(usize, BlockId), usize> = placed
        .iter()
        .enumerate()
        .map(|(j, &(k, b, _))| ((k, b), j))
        .collect();
    let insertions: Vec<Insertion> = placed.into_iter().map(|(_, _, i)| i).collect();
    let (rw, _) = tape::insert(func, &insertions);
    let id_of = |k: usize, s: Src| match s {
        Src::Val(v) => rw.remap[v as usize],
        Src::Entry(b) => rw.ids[slot[&(k, b)]],
    };
    for (k, (r, p)) in items.iter().zip(plans).enumerate() {
        for (&b, incoming) in &p.phis {
            let merged: Vec<(BlockId, ValueId)> =
                incoming.iter().map(|&(q, s)| (q, id_of(k, s))).collect();
            if let Inst::Phi { incoming, .. } = &mut func.insts[rw.ids[slot[&(k, b)]] as usize] {
                *incoming = merged;
            }
        }
        let old = rw.remap[r.value as usize];
        let rename = |v: &mut ValueId, new: ValueId| {
            if *v == old {
                *v = new;
            }
        };
        for read in &p.reads {
            match *read {
                Read::Operand(i, s) => {
                    let new = id_of(k, s);
                    func.insts[rw.remap[i as usize] as usize]
                        .for_each_operand_mut(|v| rename(v, new));
                }
                Read::Incoming(i, q, s) => {
                    let new = id_of(k, s);
                    if let Inst::Phi { incoming, .. } =
                        &mut func.insts[rw.remap[i as usize] as usize]
                    {
                        for (pred, v) in incoming.iter_mut() {
                            if *pred == q {
                                rename(v, new);
                            }
                        }
                    }
                }
                Read::End(b, s) => {
                    let new = id_of(k, s);
                    let block = &mut func.blocks[b as usize];
                    rename(&mut block.exit_acc, new);
                    block.terminator.for_each_operand_mut(|v| rename(v, new));
                }
            }
        }
    }
}
