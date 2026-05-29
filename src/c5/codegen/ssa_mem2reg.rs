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
