//! Block permutation and block-id remapping.
//!
//! [`permute_blocks`] reorders `func.blocks` and rewrites every
//! block-id reference to the new numbering. Instructions never move
//! between blocks: each block keeps its `inst_range` slice of the
//! flat `insts` array, so value ids, liveness, and the allocator's
//! input are unaffected. The complete block-id reference surface is
//! the terminators' targets (`Jmp`, `Bz`, `Bnz`, `FallThrough`),
//! `Phi::incoming` predecessor ids, `Inst::BlockAddr`, and
//! `FunctionSsa::computed_goto_targets`.

use alloc::vec::Vec;

use crate::c5::ir::{BlockId, FunctionSsa, Inst, Terminator};

/// Reorder `func.blocks` so old block `order[i]` becomes block `i`,
/// remapping every block-id reference. `order` must be a permutation
/// of `0..func.blocks.len()`.
pub(crate) fn permute_blocks(func: &mut FunctionSsa, order: &[BlockId]) {
    let n = func.blocks.len();
    assert_eq!(order.len(), n, "order must cover every block");
    let mut new_id: Vec<BlockId> = alloc::vec![BlockId::MAX; n];
    for (new_idx, &old) in order.iter().enumerate() {
        assert!(
            (old as usize) < n && new_id[old as usize] == BlockId::MAX,
            "order must be a permutation of the block ids"
        );
        new_id[old as usize] = new_idx as BlockId;
    }
    func.blocks = order
        .iter()
        .map(|&old| func.blocks[old as usize].clone())
        .collect();
    remap_block_ids(func, &new_id);
}

/// Rewrite every block-id reference through `new_id` (indexed by the
/// old id). The caller has already reordered `func.blocks` to match.
pub(crate) fn remap_block_ids(func: &mut FunctionSsa, new_id: &[BlockId]) {
    for block in func.blocks.iter_mut() {
        match &mut block.terminator {
            Terminator::Jmp(t) | Terminator::FallThrough(t) => *t = new_id[*t as usize],
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
                *target = new_id[*target as usize];
                *fall_through = new_id[*fall_through as usize];
            }
            Terminator::Return(_) | Terminator::TailExt(_) | Terminator::GotoIndirect { .. } => {}
        }
    }
    for inst in func.insts.iter_mut() {
        match inst {
            Inst::BlockAddr(b) => *b = new_id[*b as usize],
            Inst::Phi { incoming, .. } => {
                for (b, _) in incoming.iter_mut() {
                    *b = new_id[*b as usize];
                }
            }
            _ => {}
        }
    }
    for t in func.computed_goto_targets.iter_mut() {
        *t = new_id[*t as usize];
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

    #[test]
    fn permutation_remaps_terminators_phis_block_addrs_and_goto_targets() {
        // b0 -> b1 -> b2(ret); b1 holds a phi from b0 and a BlockAddr(2).
        let mut f = func_with(
            vec![
                Inst::Imm(1),
                Inst::Phi {
                    incoming: vec![(0, 0)],
                    kind: LoadKind::I64,
                },
                Inst::BlockAddr(2),
            ],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(
                    1..3,
                    Terminator::Bz {
                        cond: 1,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(3..3, Terminator::Return(NO_VALUE)),
            ],
        );
        f.computed_goto_targets = vec![2];
        // New order: [0, 2, 1] -- old b2 becomes b1, old b1 becomes b2.
        permute_blocks(&mut f, &[0, 2, 1]);
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(2)));
        assert!(matches!(f.blocks[1].terminator, Terminator::Return(_)));
        assert!(matches!(
            f.blocks[2].terminator,
            Terminator::Bz {
                target: 1,
                fall_through: 2,
                ..
            }
        ));
        let Inst::Phi { incoming, .. } = &f.insts[1] else {
            panic!("expected phi");
        };
        assert_eq!(incoming[0].0, 0);
        assert!(matches!(f.insts[2], Inst::BlockAddr(1)));
        assert_eq!(f.computed_goto_targets, vec![1]);
        // Instructions did not move: block ranges follow their blocks.
        assert_eq!(f.blocks[2].inst_range, 1..3);
    }

    #[test]
    #[should_panic(expected = "permutation")]
    fn duplicate_entry_in_order_panics() {
        let mut f = func_with(
            vec![Inst::Imm(0)],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..1, Terminator::Return(NO_VALUE)),
            ],
        );
        permute_blocks(&mut f, &[0, 0]);
    }

    #[test]
    #[should_panic(expected = "cover every block")]
    fn short_order_panics() {
        let mut f = func_with(
            vec![Inst::Imm(0)],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..1, Terminator::Return(NO_VALUE)),
            ],
        );
        permute_blocks(&mut f, &[0]);
    }
}
