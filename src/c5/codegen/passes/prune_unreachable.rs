//! Delete blocks unreachable from the entry after branch folding.
//!
//! `constfold_branch` rewrites a constant-condition `Bz`/`Bnz` to an
//! unconditional `Jmp`, which orphans the not-taken successor. Left in
//! `func.blocks`, that block's instructions are still lowered --
//! including calls and address-of references to external symbols -- so
//! a dead `if (0) ext();` at -O emitted a relocation against `ext` and
//! left it undefined at link. This pass deletes blocks unreachable from
//! block 0, drops their external-reference table entries and the phi
//! predecessors that named them, and renumbers the survivors.
//!
//! Runs after `constfold_branch`. A jump table's target blocks are
//! reachable through the indirect dispatch, not a terminator edge, so
//! reachability seeds them from `func.jump_tables`; `remap_block_ids`
//! renumbers those target lists after compaction. Computed-goto
//! functions are still skipped: their reachable set is every
//! address-taken label (`Inst::BlockAddr`), which is not tracked as a
//! successor graph, and `constfold_branch` leaves computed goto
//! untouched anyway.

use alloc::vec::Vec;

use super::remap_blocks::remap_block_ids;
use crate::c5::ir::{BlockId, FunctionSsa, Inst, Terminator};

fn push_successors(t: &Terminator, out: &mut Vec<BlockId>) {
    match *t {
        Terminator::Jmp(b) | Terminator::FallThrough(b) => out.push(b),
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
            out.push(target);
            out.push(fall_through);
        }
        Terminator::Return(_)
        | Terminator::TailExt(_)
        | Terminator::Unreachable
        | Terminator::GotoIndirect { .. }
        | Terminator::JumpTable { .. }
        | Terminator::AsmGoto { .. } => {}
    }
}

/// Delete blocks unreachable from the entry. Returns whether any block
/// was removed, so a driver can iterate with the branch fold.
pub(crate) fn run_one(func: &mut FunctionSsa) -> bool {
    if !func.computed_goto_targets.is_empty() {
        return false;
    }
    let n = func.blocks.len();
    if n == 0 {
        return false;
    }
    // Reachability from block 0 through terminator successors, plus a
    // jump table's target blocks (reached via its indirect dispatch,
    // recorded in `func.jump_tables` rather than the terminator).
    let mut reachable = alloc::vec![false; n];
    reachable[0] = true;
    let mut stack = alloc::vec![0 as BlockId];
    let mut succ = Vec::new();
    while let Some(b) = stack.pop() {
        succ.clear();
        push_successors(&func.blocks[b as usize].terminator, &mut succ);
        if let Terminator::JumpTable { table, .. } | Terminator::AsmGoto { table } =
            &func.blocks[b as usize].terminator
        {
            succ.extend_from_slice(&func.jump_tables[*table as usize]);
        }
        for &s in &succ {
            if !reachable[s as usize] {
                reachable[s as usize] = true;
                stack.push(s);
            }
        }
    }
    if reachable.iter().all(|&r| r) {
        return false;
    }

    // Values defined in doomed blocks: drop their external-reference
    // table entries so no relocation or undefined symbol survives.
    let mut dead_value = alloc::vec![false; func.insts.len()];
    for (b, blk) in func.blocks.iter().enumerate() {
        if !reachable[b] {
            for v in blk.inst_range.clone() {
                dead_value[v as usize] = true;
            }
        }
    }
    let keep = |refs: &[(u32, u32)]| -> Vec<(u32, u32)> {
        refs.iter()
            .copied()
            .filter(|&(v, _)| !dead_value[v as usize])
            .collect()
    };
    func.extern_call_refs = keep(&func.extern_call_refs);
    func.extern_imm_code_refs = keep(&func.extern_imm_code_refs);
    func.extern_imm_data_refs = keep(&func.extern_imm_data_refs);
    func.extern_tls_refs = keep(&func.extern_tls_refs);

    // Drop every phi incoming that names a doomed predecessor -- an
    // edge from an unreachable block is never taken. This covers phis
    // in doomed blocks too: those instructions stay in the flat `insts`
    // array after compaction, and leaving a removed-block id in them
    // would make the block-id remap here (and later passes') index out
    // of range.
    for inst in func.insts.iter_mut() {
        if let Inst::Phi { incoming, .. } = inst {
            incoming.retain(|&(pred, _)| (pred as usize) < n && reachable[pred as usize]);
        }
    }

    // Compact the survivors (original order preserved) and renumber.
    let mut order = Vec::new();
    let mut new_id = alloc::vec![BlockId::MAX; n];
    for (old, &live) in reachable.iter().enumerate() {
        if live {
            new_id[old] = order.len() as BlockId;
            order.push(old as BlockId);
        }
    }
    func.blocks = order
        .iter()
        .map(|&o| func.blocks[o as usize].clone())
        .collect();
    remap_block_ids(func, &new_id);
    true
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{Block, NO_VALUE};
    use alloc::vec;

    fn fresh(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
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

    #[test]
    fn drops_block_orphaned_by_a_folded_branch() {
        // b0 -> b1 (folded Jmp); b2 (Call ext) is now unreachable and
        // carries the only extern_call_ref.
        let mut f = fresh(
            vec![
                Inst::Imm(0), // v0 (b0)
                Inst::Imm(0), // v1 (b1)
                Inst::Call {
                    target_pc: 2,
                    args: Vec::new(),
                    fixed_args: 0,
                    fp_return: false,
                    fp_arg_mask: 0,
                    arg_aggs: Vec::new(),
                    ret_agg: None,
                    ret_slot_local: 0,
                }, // v2 (b2, dead)
            ],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..2, Terminator::Return(1)),
                block(2..3, Terminator::Jmp(1)),
            ],
        );
        f.extern_call_refs = vec![(2, 7)];
        run_one(&mut f);
        assert_eq!(f.blocks.len(), 2, "the unreachable block is removed");
        assert!(
            f.extern_call_refs.is_empty(),
            "the dead call's extern ref is dropped"
        );
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(1)));
        assert!(matches!(f.blocks[1].terminator, Terminator::Return(_)));
    }

    #[test]
    fn keeps_a_fully_reachable_function_unchanged() {
        let mut f = fresh(
            vec![Inst::Imm(0), Inst::Imm(0)],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..2, Terminator::Return(1)),
            ],
        );
        run_one(&mut f);
        assert_eq!(f.blocks.len(), 2);
    }

    #[test]
    fn prunes_a_phi_incoming_from_a_removed_predecessor() {
        // b0 -> b1; b2 (dead) also branches to b1, and b1's phi lists
        // both b0 and b2 as predecessors.
        let mut f = fresh(
            vec![
                Inst::Imm(0), // v0 (b0)
                Inst::Phi {
                    incoming: vec![(0, 0), (2, 0)],
                    kind: crate::c5::ir::LoadKind::I64,
                }, // v1 (b1)
                Inst::Imm(0), // v2 (b2, dead)
            ],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..2, Terminator::Return(1)),
                block(2..3, Terminator::Jmp(1)),
            ],
        );
        run_one(&mut f);
        assert_eq!(f.blocks.len(), 2);
        let Inst::Phi { incoming, .. } = &f.insts[1] else {
            panic!("expected phi");
        };
        assert_eq!(incoming.len(), 1, "the b2 incoming is dropped");
        assert_eq!(incoming[0].0, 0, "b0 survives as block 0");
    }

    #[test]
    fn prunes_orphan_in_a_jump_table_function_keeping_table_targets() {
        // b0 dispatches to [b1, b3]; b2 is orphaned (a folded-away
        // canary body carrying the only extern ref) and must be pruned
        // while the jump-table targets survive and are remapped.
        let mut f = fresh(
            vec![
                Inst::Imm(0), // v0 (b0)
                Inst::Imm(0), // v1 (b1)
                Inst::Call {
                    target_pc: 9,
                    args: Vec::new(),
                    fixed_args: 0,
                    fp_return: false,
                    fp_arg_mask: 0,
                    arg_aggs: Vec::new(),
                    ret_agg: None,
                    ret_slot_local: 0,
                }, // v2 (b2, dead)
                Inst::Imm(0), // v3 (b3)
            ],
            vec![
                block(0..1, Terminator::JumpTable { idx: 0, table: 0 }),
                block(1..2, Terminator::Return(1)),
                block(2..3, Terminator::Unreachable),
                block(3..4, Terminator::Return(3)),
            ],
        );
        f.jump_tables = vec![vec![1, 3]];
        f.extern_call_refs = vec![(2, 7)];
        run_one(&mut f);
        assert_eq!(f.blocks.len(), 3, "the orphaned block is removed");
        assert!(
            f.extern_call_refs.is_empty(),
            "the dead call's extern ref is dropped"
        );
        // b3 was renumbered to 2; the table now names [b1, b2].
        assert_eq!(f.jump_tables[0], vec![1, 2]);
    }
}
