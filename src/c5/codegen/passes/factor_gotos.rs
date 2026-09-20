//! One indirect branch per function: every `GotoIndirect` jumps to one
//! dispatch block, placed after the first site, that branches on a phi of
//! the targets. A label then has one indirect predecessor, so a value live
//! across the dispatch merges there over ordinary edges, which can be
//! split; `ssa::block_plan` repeats the branch at each site.

use alloc::vec::Vec;

use crate::c5::ir::{Block, BlockId, FunctionSsa, Inst, LoadKind, Terminator, ValueId};

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs.iter_mut() {
        run_one(func);
    }
}

/// Returns whether `func` changed.
pub(crate) fn run_one(func: &mut FunctionSsa) -> bool {
    let sites: Vec<(BlockId, ValueId)> = func
        .blocks
        .iter()
        .enumerate()
        .filter_map(|(b, block)| match block.terminator {
            Terminator::GotoIndirect { target } => Some((b as BlockId, target)),
            _ => None,
        })
        .collect();
    if sites.len() < 2 {
        return false;
    }
    let phi = func.insts.len() as ValueId;
    func.insts.push(Inst::Phi {
        incoming: sites.clone(),
        kind: LoadKind::I64,
    });
    func.inst_src.resize(func.insts.len(), (0, 0));
    func.f32_values.resize(func.insts.len(), false);
    let dispatch = func.blocks.len() as BlockId;
    func.blocks.push(Block {
        start_pc: 0,
        inst_range: phi..phi + 1,
        terminator: Terminator::GotoIndirect { target: phi },
        exit_acc: phi,
    });
    for &(b, _) in &sites {
        func.blocks[b as usize].terminator = Terminator::Jmp(dispatch);
    }
    let first = sites[0].0;
    let order: Vec<BlockId> = (0..=first)
        .chain(core::iter::once(dispatch))
        .chain(first + 1..dispatch)
        .collect();
    super::remap_blocks::permute_blocks(func, &order);
    true
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{LabelDataReloc, NO_VALUE};
    use alloc::vec;

    fn block(range: core::ops::Range<u32>, terminator: Terminator) -> Block {
        Block {
            start_pc: 0,
            inst_range: range,
            terminator,
            exit_acc: NO_VALUE,
        }
    }

    /// b0 dispatches; b1 (a label) and b2 each dispatch again; b3 (a label
    /// whose address is also in static data) returns.
    fn interpreter() -> FunctionSsa {
        let insts = vec![
            Inst::BlockAddr(1),
            Inst::BlockAddr(3),
            Inst::Imm(0),
            Inst::Imm(8),
            Inst::Imm(16),
        ];
        let mut f = FunctionSsa {
            inst_src: vec![(0, 0); insts.len()],
            f32_values: vec![false; insts.len()],
            insts,
            blocks: vec![
                block(0..3, Terminator::GotoIndirect { target: 2 }),
                block(3..4, Terminator::GotoIndirect { target: 3 }),
                block(4..5, Terminator::GotoIndirect { target: 4 }),
                block(5..5, Terminator::Return(NO_VALUE)),
            ],
            ..FunctionSsa::default()
        };
        f.computed_goto_targets = vec![1, 3];
        f.label_data_relocs = vec![LabelDataReloc {
            data_offset: 0,
            block: 3,
        }];
        f
    }

    #[test]
    fn every_site_jumps_to_one_dispatch_block_after_the_first() {
        let mut f = interpreter();
        assert!(run_one(&mut f));
        // Old b0 stays, the dispatch block is b1, old b1..b3 shift by one.
        assert_eq!(f.blocks.len(), 5);
        for site in [0, 2, 3] {
            assert_eq!(f.blocks[site].terminator, Terminator::Jmp(1), "b{site}");
        }
        let Terminator::GotoIndirect { target } = f.blocks[1].terminator else {
            panic!("dispatch: {:?}", f.blocks[1].terminator);
        };
        let Inst::Phi { incoming, kind } = &f.insts[target as usize] else {
            panic!("dispatch target is not a phi");
        };
        assert_eq!(*kind, LoadKind::I64);
        assert_eq!(incoming, &vec![(0, 2), (2, 3), (3, 4)]);
        assert_eq!(f.blocks[1].inst_range, target..target + 1);
        // The labels follow the renumbering.
        assert_eq!(f.computed_goto_targets, vec![2, 4]);
        assert!(matches!(f.insts[0], Inst::BlockAddr(2)));
        assert!(matches!(f.insts[1], Inst::BlockAddr(4)));
        assert_eq!(f.label_data_relocs[0].block, 4);
        assert_eq!(f.insts.len(), f.inst_src.len());
        assert_eq!(f.insts.len(), f.f32_values.len());
    }

    #[test]
    fn a_single_indirect_branch_is_left_alone() {
        let mut f = interpreter();
        f.blocks[1].terminator = Terminator::Jmp(3);
        f.blocks[2].terminator = Terminator::Jmp(3);
        let before = f.clone();
        assert!(!run_one(&mut f));
        assert_eq!(f.blocks.len(), before.blocks.len());
        assert_eq!(f.insts.len(), before.insts.len());
        assert_eq!(
            f.blocks[0].terminator,
            Terminator::GotoIndirect { target: 2 }
        );
    }
}
