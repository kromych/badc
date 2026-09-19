//! Which blocks reach the machine code, and where each branch lands.
//!
//! Whether a block emits any byte is decided by the allocation: a split
//! critical edge whose phi moves all stay in place, a join holding only
//! phis, a block of values nobody reads. `passes::layout` runs before the
//! allocation and sees none of them, so a branch would land on a block that
//! is only a branch, and a jump would go over blocks that emit nothing.
//!
//! The plan is read-only and leaves the function and its allocation as they
//! are: a phi block cannot be deleted without renumbering the value-indexed
//! tables, and an edge routed past its split block in the IR would be a
//! critical edge again. Both emitters read the same plan, so the elision
//! and the conditional shape are decided once.

use alloc::vec::Vec;

use super::emit_common::{edge_moves, inst_emits_nothing};
use super::reg_alloc::Allocation;
use crate::c5::codegen::passes::layout::JumpChains;
use crate::c5::ir::{BlockId, FunctionSsa, Terminator};

const NO_BLOCK: BlockId = BlockId::MAX;

pub(crate) struct BlockPlan {
    /// Per block: where a direct edge into it lands.
    target: Vec<BlockId>,
    /// Per block: no edge lands on it and it emits nothing.
    skipped: Vec<bool>,
    /// Per block: the next block in layout order that is emitted.
    next: Vec<BlockId>,
}

/// What a `Bz` / `Bnz` terminator emits.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum CondShape {
    /// Both arms land on one block: no test.
    Jump(BlockId),
    /// Branch to `taken` on the condition (on its negation under `negate`),
    /// then reach `other`.
    Branch {
        taken: BlockId,
        other: BlockId,
        negate: bool,
    },
}

impl BlockPlan {
    pub(crate) fn build(func: &FunctionSsa, alloc: &Allocation) -> BlockPlan {
        let n = func.blocks.len();
        let mut plan = BlockPlan {
            target: (0..n as BlockId).collect(),
            skipped: alloc::vec![false; n],
            next: alloc::vec![NO_BLOCK; n],
        };
        // A naked function's blocks hold its inline asm only and neither
        // emitter lowers anything else in them.
        if !func.is_naked {
            let hops: Vec<BlockId> = (0..n as BlockId)
                .map(|b| forwards_to(func, alloc, b).unwrap_or(NO_BLOCK))
                .collect();
            let mut chains = JumpChains::default();
            chains.build_with(n, |b| Some(hops[b as usize]).filter(|&t| t != NO_BLOCK));
            let pinned = pinned_blocks(func);
            for (b, &pinned) in pinned.iter().enumerate() {
                // A chain that runs into a jump cycle has no end: its
                // blocks stay, so the cycle keeps an instruction.
                if let Some(end) = chains.end(b as BlockId) {
                    plan.target[b] = end;
                    plan.skipped[b] = end != b as BlockId && !pinned;
                }
            }
        }
        let mut next = NO_BLOCK;
        for b in (0..n).rev() {
            plan.next[b] = next;
            if !plan.skipped[b] {
                next = b as BlockId;
            }
        }
        plan
    }

    /// The block a direct edge into `b` lands on.
    pub(crate) fn resolve(&self, b: BlockId) -> BlockId {
        self.target[b as usize]
    }

    pub(crate) fn is_skipped(&self, b: usize) -> bool {
        self.skipped[b]
    }

    /// Where control is once the code of `block_idx` runs off its end. The
    /// next emitted block may itself emit nothing (a pinned one): running
    /// into it is running into the block its edges land on.
    fn runs_into(&self, block_idx: usize) -> BlockId {
        match self.next[block_idx] {
            NO_BLOCK => NO_BLOCK,
            next => self.resolve(next),
        }
    }

    /// Whether the code of `block_idx` runs into the block an edge to `t`
    /// lands on.
    pub(crate) fn falls_into(&self, block_idx: usize, t: BlockId) -> bool {
        self.runs_into(block_idx) == self.resolve(t)
    }

    /// The shape of `block_idx`'s conditional terminator. The taken arm
    /// being the next emitted block swaps the arms, so the test falls
    /// through into it.
    pub(crate) fn cond_shape(
        &self,
        block_idx: usize,
        target: BlockId,
        fall_through: BlockId,
        negate: bool,
    ) -> CondShape {
        let (t, f) = (self.resolve(target), self.resolve(fall_through));
        if t == f {
            CondShape::Jump(t)
        } else if self.runs_into(block_idx) == t {
            CondShape::Branch {
                taken: f,
                other: t,
                negate: !negate,
            }
        } else {
            CondShape::Branch {
                taken: t,
                other: f,
                negate,
            }
        }
    }
}

/// The successor `b` hands every edge on to: `b` emits nothing, leaves by
/// one unconditional edge, and that edge's phi moves all stay in place.
fn forwards_to(func: &FunctionSsa, alloc: &Allocation, b: BlockId) -> Option<BlockId> {
    let block = &func.blocks[b as usize];
    let (Terminator::Jmp(t) | Terminator::FallThrough(t)) = block.terminator else {
        return None;
    };
    let silent = block
        .inst_range
        .clone()
        .all(|v| inst_emits_nothing(&func.insts[v as usize], v, alloc));
    (t != b && silent && edge_moves(func, alloc, b, t).is_empty()).then_some(t)
}

/// Blocks that stay where they are: the entry, which the prologue runs
/// into, and every block whose address something other than a direct edge
/// holds -- a label address, a jump-table slot (which also takes the
/// landing pad of an indirect branch), an `asm goto` label, whose template
/// branch has the reach its instruction gives it.
fn pinned_blocks(func: &FunctionSsa) -> Vec<bool> {
    let mut pinned = alloc::vec![false; func.blocks.len()];
    let mut pin = |b: BlockId| {
        if let Some(p) = pinned.get_mut(b as usize) {
            *p = true;
        }
    };
    pin(0);
    func.computed_goto_targets.iter().for_each(|&b| pin(b));
    func.label_data_relocs.iter().for_each(|r| pin(r.block));
    for block in &func.blocks {
        match block.terminator {
            Terminator::JumpTable { table, .. } => {
                func.jump_tables[table as usize]
                    .iter()
                    .for_each(|&b| pin(b));
            }
            // Row entry 0 is the fall-through, a direct edge.
            Terminator::AsmGoto { table } => {
                func.jump_tables[table as usize][1..]
                    .iter()
                    .for_each(|&b| pin(b));
            }
            _ => {}
        }
    }
    pinned
}

#[cfg(test)]
mod tests {
    use super::super::reg_alloc::{Place, RegBanks};
    use super::*;
    use crate::c5::codegen::Target;
    use crate::c5::ir::{Block, Inst, LabelDataReloc, LoadKind, NO_VALUE, StoreKind, ValueId};

    fn func_with(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            inst_src: alloc::vec![(0, 0); n],
            f32_values: alloc::vec![false; n],
            insts,
            blocks,
            ..Default::default()
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

    /// Every value read once and placed as `places` says.
    fn alloc_with(places: Vec<Place>) -> Allocation {
        let n = places.len();
        Allocation {
            places,
            spill_count: 0,
            gpr_used: Vec::new(),
            fp_used: Vec::new(),
            fp_scratch: RegBanks::for_target(Target::host()).fp_scratch,
            use_counts: alloc::vec![1; n],
            last_use: alloc::vec![0; n],
            cmp32: alloc::vec![false; n],
            sxtw_source: alloc::vec![NO_VALUE; n],
            sxtw_k: alloc::vec![0; n],
            branch_fused: alloc::vec![false; n],
            hints: alloc::vec![None; n],
            f32_values: alloc::vec![false; n],
            high_observed: Vec::new(),
            high_clear: Vec::new(),
            wide: alloc::vec![false; n],
            asm_preserve: (u32::MAX, u32::MAX),
        }
    }

    fn phi(incoming: &[(BlockId, ValueId)], kind: LoadKind) -> Inst {
        Inst::Phi {
            incoming: incoming.to_vec(),
            kind,
        }
    }

    fn skipped(plan: &BlockPlan) -> Vec<usize> {
        (0..plan.skipped.len())
            .filter(|&b| plan.is_skipped(b))
            .collect()
    }

    /// `b0: v0; Jmp b1 / b1: Jmp b2 / b2: v1 = Phi[b1: v0]; Jmp b3 /
    /// b3: Return v1`, with `v1` placed in `phi_place`.
    fn chain(phi_place: Place) -> (FunctionSsa, Allocation) {
        let f = func_with(
            alloc::vec![Inst::Imm(5), phi(&[(1, 0)], LoadKind::I64)],
            alloc::vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..1, Terminator::Jmp(2)),
                block(1..2, Terminator::Jmp(3)),
                block(2..2, Terminator::Return(1)),
            ],
        );
        (f, alloc_with(alloc::vec![Place::IntReg(3), phi_place]))
    }

    #[test]
    fn a_chain_of_blocks_without_code_lands_on_its_end() {
        let (f, a) = chain(Place::IntReg(3));
        let plan = BlockPlan::build(&f, &a);
        assert_eq!(skipped(&plan), [1, 2]);
        assert_eq!(
            (plan.resolve(1), plan.resolve(2), plan.resolve(3)),
            (3, 3, 3)
        );
        assert!(plan.falls_into(0, 1), "block 0 runs into block 3");
    }

    #[test]
    fn an_edge_that_moves_a_value_keeps_its_block() {
        let (f, a) = chain(Place::IntReg(4));
        let plan = BlockPlan::build(&f, &a);
        // The move sits at the end of b1; the phi block behind it is silent.
        assert_eq!(skipped(&plan), [2]);
        assert_eq!((plan.resolve(1), plan.resolve(2)), (1, 3));
        let (f, a) = chain(Place::Spill(0));
        assert_eq!(skipped(&BlockPlan::build(&f, &a)), [2]);
    }

    #[test]
    fn a_constant_into_an_fp_phi_keeps_its_block() {
        let f = func_with(
            alloc::vec![Inst::Imm(0), phi(&[(1, 0)], LoadKind::F64)],
            alloc::vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..1, Terminator::Jmp(2)),
                block(1..2, Terminator::Return(1)),
            ],
        );
        let a = alloc_with(alloc::vec![Place::IntReg(0), Place::FpReg(0)]);
        assert!(skipped(&BlockPlan::build(&f, &a)).is_empty());
    }

    #[test]
    fn only_dead_pure_values_and_phis_are_no_code() {
        let store = Inst::StoreLocal {
            off: -1,
            value: 0,
            kind: StoreKind::I64,
            volatile: false,
        };
        for (inst, uses, silent) in [
            (Inst::Imm(9), 0, true),
            (Inst::Imm(9), 1, false),
            (store, 0, false),
        ] {
            let f = func_with(
                alloc::vec![Inst::Imm(1), inst],
                alloc::vec![
                    block(0..1, Terminator::Jmp(1)),
                    block(1..2, Terminator::Jmp(2)),
                    block(2..2, Terminator::Return(0)),
                ],
            );
            let mut a = alloc_with(alloc::vec![Place::IntReg(0), Place::IntReg(1)]);
            a.use_counts[1] = uses;
            let plan = BlockPlan::build(&f, &a);
            assert_eq!(
                plan.is_skipped(1),
                silent,
                "{:?} read {uses} times",
                f.insts[1]
            );
        }
    }

    #[test]
    fn a_jump_cycle_keeps_its_blocks() {
        // b1 <-> b2, b3 -> b3, and b4 leading into the first cycle.
        let f = func_with(
            alloc::vec![Inst::Imm(1)],
            alloc::vec![
                block(
                    0..1,
                    Terminator::Bnz {
                        cond: 0,
                        target: 4,
                        fall_through: 3,
                    }
                ),
                block(1..1, Terminator::Jmp(2)),
                block(1..1, Terminator::Jmp(1)),
                block(1..1, Terminator::Jmp(3)),
                block(1..1, Terminator::Jmp(1)),
            ],
        );
        let plan = BlockPlan::build(&f, &alloc_with(alloc::vec![Place::IntReg(0)]));
        assert!(skipped(&plan).is_empty());
        assert_eq!(
            (1..5).map(|b| plan.resolve(b)).collect::<Vec<_>>(),
            [1, 2, 3, 4]
        );
    }

    /// Five blocks without code behind the entry, all jumping to `b6`.
    fn addressed() -> FunctionSsa {
        let mut blocks = alloc::vec![block(0..1, Terminator::Jmp(1))];
        blocks.extend((1..6).map(|_| block(1..1, Terminator::Jmp(6))));
        blocks.push(block(1..1, Terminator::Return(0)));
        func_with(alloc::vec![Inst::Imm(1)], blocks)
    }

    #[test]
    fn addressed_blocks_are_kept_and_direct_edges_pass_them() {
        let a = alloc_with(alloc::vec![Place::IntReg(0)]);
        let plan = BlockPlan::build(&addressed(), &a);
        assert_eq!(skipped(&plan), [1, 2, 3, 4, 5]);

        let mut f = addressed();
        f.computed_goto_targets = alloc::vec![1];
        f.label_data_relocs = alloc::vec![LabelDataReloc {
            data_offset: 0,
            block: 2,
        }];
        f.jump_tables = alloc::vec![alloc::vec![3, 6], alloc::vec![5, 4]];
        f.blocks[0].terminator = Terminator::JumpTable { idx: 0, table: 0 };
        f.blocks[6].terminator = Terminator::AsmGoto { table: 1 };
        let plan = BlockPlan::build(&f, &a);
        // Row entry 0 of the `asm goto` is its fall-through, a direct edge.
        assert_eq!(skipped(&plan), [5]);
        // A direct edge still passes a kept block, and code that runs into
        // one runs into the block behind it.
        assert_eq!(plan.resolve(1), 6);
        assert!(plan.falls_into(3, 6) && plan.falls_into(4, 6));
    }

    #[test]
    fn a_naked_function_keeps_every_block() {
        let (mut f, a) = chain(Place::IntReg(3));
        f.is_naked = true;
        let plan = BlockPlan::build(&f, &a);
        assert!(skipped(&plan).is_empty());
        assert_eq!(plan.resolve(1), 1);
    }

    #[test]
    fn conditional_shape_follows_where_the_arms_land() {
        // b0: Bnz v0 -> b1 | b2; b1, b2 without code; b3, b4 with code.
        let build = |t1: BlockId, t2: BlockId| {
            let f = func_with(
                alloc::vec![Inst::Imm(1), Inst::Imm(2), Inst::Imm(3)],
                alloc::vec![
                    block(
                        0..1,
                        Terminator::Bnz {
                            cond: 0,
                            target: 1,
                            fall_through: 2,
                        }
                    ),
                    block(1..1, Terminator::Jmp(t1)),
                    block(1..1, Terminator::Jmp(t2)),
                    block(1..2, Terminator::Return(1)),
                    block(2..3, Terminator::Return(2)),
                ],
            );
            let a = alloc_with(alloc::vec![Place::IntReg(0); 3]);
            BlockPlan::build(&f, &a)
        };
        assert_eq!(build(4, 4).cond_shape(0, 1, 2, false), CondShape::Jump(4));
        // The taken arm lands on the next emitted block: the test inverts.
        assert_eq!(
            build(3, 4).cond_shape(0, 1, 2, false),
            CondShape::Branch {
                taken: 4,
                other: 3,
                negate: true
            }
        );
        assert_eq!(
            build(4, 3).cond_shape(0, 1, 2, true),
            CondShape::Branch {
                taken: 4,
                other: 3,
                negate: true
            }
        );
    }
}
