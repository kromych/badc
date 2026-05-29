//! Promotion of address-free local slots to SSA values (mem2reg).
//!
//! Runs under `-O` ahead of the register allocator. A local whose
//! address is never taken is accessed only through `LoadLocal` /
//! `StoreLocal` against a fixed frame slot; its value can live in a
//! register across the whole function instead of being spilled to
//! and reloaded from the frame. Promotion rewrites those loads and
//! stores into direct value references, inserting phi joins where
//! control flow merges two distinct definitions.
//!
//! This module currently provides the analysis prerequisites for the
//! transform: which slots may be promoted, and the control-flow
//! predecessor map phi placement needs.

// The phi-placement and rename passes that consume these analyses
// land in a follow-up; keep the building blocks compiling until then.
#![allow(dead_code)]

use alloc::collections::BTreeSet;
use alloc::vec::Vec;

use super::super::ir::{BlockId, FunctionSsa, Inst, Terminator};

/// Frame slots eligible for register promotion: those accessed only
/// via `LoadLocal` / `StoreLocal` and never via `LocalAddr`. A slot
/// whose address is taken may be read or written through that pointer
/// (including by a callee), so its definition point is not visible in
/// the SSA and it must stay resident in the frame.
pub(crate) fn promotable_slots(func: &FunctionSsa) -> BTreeSet<i64> {
    let mut touched: BTreeSet<i64> = BTreeSet::new();
    let mut address_taken: BTreeSet<i64> = BTreeSet::new();
    for inst in &func.insts {
        match inst {
            Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } => {
                touched.insert(*off);
            }
            Inst::LocalAddr(off) => {
                address_taken.insert(*off);
            }
            _ => {}
        }
    }
    touched.retain(|slot| !address_taken.contains(slot));
    touched
}

/// Successor block ids of a terminator, in branch order.
pub(crate) fn successors(term: &Terminator) -> Vec<BlockId> {
    match term {
        Terminator::Jmp(b) | Terminator::FallThrough(b) => alloc::vec![*b],
        Terminator::Bz {
            target,
            fall_through,
            ..
        }
        | Terminator::Bnz {
            target,
            fall_through,
            ..
        } => alloc::vec![*target, *fall_through],
        Terminator::Return(_) | Terminator::TailExt(_) => Vec::new(),
    }
}

/// Predecessor block ids for every block, indexed by `BlockId`.
/// Built by inverting each block's terminator successors.
pub(crate) fn predecessors(func: &FunctionSsa) -> Vec<Vec<BlockId>> {
    let mut preds: Vec<Vec<BlockId>> = alloc::vec![Vec::new(); func.blocks.len()];
    for (idx, block) in func.blocks.iter().enumerate() {
        for succ in successors(&block.terminator) {
            preds[succ as usize].push(idx as BlockId);
        }
    }
    preds
}

/// Sentinel for an undefined / unreachable immediate dominator.
const NO_BLOCK: BlockId = BlockId::MAX;

/// Depth-first postorder of the blocks reachable from the entry
/// (block 0). Blocks unreachable from the entry do not appear.
fn postorder(func: &FunctionSsa) -> Vec<BlockId> {
    let n = func.blocks.len();
    let mut order: Vec<BlockId> = Vec::with_capacity(n);
    let mut visited = alloc::vec![false; n];
    // Iterative DFS: stack holds (block, next-successor-index) so a
    // block is appended to the postorder only after all successors.
    let mut stack: Vec<(BlockId, usize)> = Vec::new();
    if n == 0 {
        return order;
    }
    visited[0] = true;
    stack.push((0, 0));
    while let Some(&(b, si)) = stack.last() {
        let succ = successors(&func.blocks[b as usize].terminator);
        if si < succ.len() {
            stack.last_mut().unwrap().1 += 1;
            let s = succ[si];
            if !visited[s as usize] {
                visited[s as usize] = true;
                stack.push((s, 0));
            }
        } else {
            order.push(b);
            stack.pop();
        }
    }
    order
}

/// Immediate dominator of every block, indexed by `BlockId`
/// (Cooper-Harvey-Kennedy iterative dominators, which handle
/// irreducible control flow from `goto`). `idom[entry] == entry`;
/// blocks unreachable from the entry get [`NO_BLOCK`].
pub(crate) fn dominators(func: &FunctionSsa) -> Vec<BlockId> {
    let n = func.blocks.len();
    let mut idom = alloc::vec![NO_BLOCK; n];
    if n == 0 {
        return idom;
    }
    let po = postorder(func);
    // Postorder number per block; entry has the highest number.
    let mut po_num = alloc::vec![usize::MAX; n];
    for (i, &b) in po.iter().enumerate() {
        po_num[b as usize] = i;
    }
    let preds = predecessors(func);
    idom[0] = 0;
    // Reverse postorder, entry first.
    let rpo: Vec<BlockId> = po.iter().rev().copied().collect();
    let mut changed = true;
    while changed {
        changed = false;
        for &b in &rpo {
            if b == 0 || po_num[b as usize] == usize::MAX {
                continue;
            }
            let mut new_idom = NO_BLOCK;
            for &p in &preds[b as usize] {
                if idom[p as usize] == NO_BLOCK {
                    continue;
                }
                new_idom = if new_idom == NO_BLOCK {
                    p
                } else {
                    intersect(p, new_idom, &idom, &po_num)
                };
            }
            if new_idom != NO_BLOCK && idom[b as usize] != new_idom {
                idom[b as usize] = new_idom;
                changed = true;
            }
        }
    }
    idom
}

/// Walk two finger pointers up the partial dominator tree until they
/// meet, the block with the smaller postorder number climbing first.
fn intersect(mut b1: BlockId, mut b2: BlockId, idom: &[BlockId], po_num: &[usize]) -> BlockId {
    while b1 != b2 {
        while po_num[b1 as usize] < po_num[b2 as usize] {
            b1 = idom[b1 as usize];
        }
        while po_num[b2 as usize] < po_num[b1 as usize] {
            b2 = idom[b2 as usize];
        }
    }
    b1
}

/// Dominance frontier of every block (Cytron et al.): the set of
/// blocks where a definition in this block stops dominating, i.e.
/// the phi-placement candidates. Indexed by `BlockId`.
pub(crate) fn dominance_frontiers(func: &FunctionSsa, idom: &[BlockId]) -> Vec<BTreeSet<BlockId>> {
    let n = func.blocks.len();
    let preds = predecessors(func);
    let mut df: Vec<BTreeSet<BlockId>> = alloc::vec![BTreeSet::new(); n];
    for b in 0..n {
        if preds[b].len() < 2 || idom[b] == NO_BLOCK {
            continue;
        }
        for &p in &preds[b] {
            if idom[p as usize] == NO_BLOCK {
                continue;
            }
            let mut runner = p;
            while runner != idom[b] {
                df[runner as usize].insert(b as BlockId);
                runner = idom[runner as usize];
            }
        }
    }
    df
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{Block, Inst, LoadKind, NO_VALUE, StoreKind, Terminator};
    use super::*;

    fn empty_block(term: Terminator) -> Block {
        Block {
            start_pc: 0,
            inst_range: 0..0,
            terminator: term,
            exit_acc: NO_VALUE,
        }
    }

    fn func_with(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            n_params: 0,
            is_variadic: false,
            inst_src: alloc::vec![(0, 0); insts.len()],
            insts,
            blocks,
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        }
    }

    #[test]
    fn address_taken_slot_is_not_promotable() {
        // Slot -1 is loaded and stored; slot -2 has its address
        // taken. Only -1 is promotable.
        let insts = alloc::vec![
            Inst::Imm(1),
            Inst::StoreLocal {
                off: -1,
                value: 0,
                kind: StoreKind::I64,
            },
            Inst::LoadLocal {
                off: -1,
                kind: LoadKind::I64,
            },
            Inst::LocalAddr(-2),
            Inst::StoreLocal {
                off: -2,
                value: 0,
                kind: StoreKind::I64,
            },
        ];
        let blocks = alloc::vec![empty_block(Terminator::Return(NO_VALUE))];
        let f = func_with(insts, blocks);
        let p = promotable_slots(&f);
        assert!(p.contains(&-1), "address-free slot -1 should be promotable");
        assert!(
            !p.contains(&-2),
            "address-taken slot -2 must not be promotable"
        );
    }

    #[test]
    fn dominance_of_a_diamond() {
        // 0 -> {1, 2} -> 3. Both arms join at 3.
        let blocks = alloc::vec![
            empty_block(Terminator::Bz {
                cond: NO_VALUE,
                target: 1,
                fall_through: 2,
            }),
            empty_block(Terminator::Jmp(3)),
            empty_block(Terminator::Jmp(3)),
            empty_block(Terminator::Return(NO_VALUE)),
        ];
        let f = func_with(Vec::new(), blocks);
        let idom = dominators(&f);
        // Every block is dominated directly by the entry.
        assert_eq!(idom, alloc::vec![0, 0, 0, 0]);
        let df = dominance_frontiers(&f, &idom);
        assert_eq!(df[0], BTreeSet::new());
        assert_eq!(df[1], BTreeSet::from([3]));
        assert_eq!(df[2], BTreeSet::from([3]));
        assert_eq!(df[3], BTreeSet::new());
    }

    #[test]
    fn dominance_of_a_loop() {
        // 0 -> 1(header); 1 -> {3(exit), 2(body)}; 2 -> 1(back edge).
        let blocks = alloc::vec![
            empty_block(Terminator::Jmp(1)),
            empty_block(Terminator::Bz {
                cond: NO_VALUE,
                target: 3,
                fall_through: 2,
            }),
            empty_block(Terminator::Jmp(1)),
            empty_block(Terminator::Return(NO_VALUE)),
        ];
        let f = func_with(Vec::new(), blocks);
        let idom = dominators(&f);
        assert_eq!(idom[0], 0);
        assert_eq!(idom[1], 0, "loop header dominated by entry, not body");
        assert_eq!(idom[2], 1);
        assert_eq!(idom[3], 1);
        let df = dominance_frontiers(&f, &idom);
        // The back edge puts the header in the body's (and its own)
        // dominance frontier.
        assert!(df[2].contains(&1), "back edge -> header in body DF");
        assert!(df[1].contains(&1), "loop header is in its own DF");
    }

    #[test]
    fn predecessors_invert_terminator_successors() {
        // Block 0 conditionally branches to 1 (target) / 2
        // (fall-through); both jump to 3.
        let blocks = alloc::vec![
            empty_block(Terminator::Bz {
                cond: NO_VALUE,
                target: 1,
                fall_through: 2,
            }),
            empty_block(Terminator::Jmp(3)),
            empty_block(Terminator::Jmp(3)),
            empty_block(Terminator::Return(NO_VALUE)),
        ];
        let f = func_with(Vec::new(), blocks);
        let preds = predecessors(&f);
        assert_eq!(preds[0], Vec::<BlockId>::new());
        assert_eq!(preds[1], alloc::vec![0]);
        assert_eq!(preds[2], alloc::vec![0]);
        assert_eq!(preds[3], alloc::vec![1, 2]);
    }
}
