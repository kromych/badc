//! Forward one-input phis and merge straight-line blocks.
//!
//! A block with one predecessor is dominated by it, so a phi there is a
//! copy of its incoming value. A block `S` whose only predecessor `P`
//! ends in a jump to it runs exactly when `P` does: its instructions join
//! `P`'s and `P` takes its terminator. The branch folds leave both shapes
//! when they remove the other edges into a merge, and what reads a block
//! at a time -- the compare-and-branch fusion, the block-local forwarding
//! -- then sees the whole line. A block entered other than over a
//! terminator edge stays: the entry, an address-taken label, a table row.

use alloc::vec;
use alloc::vec::Vec;

use super::constfold_branch::edge_truth;
use crate::c5::codegen::ssa::mem2reg::predecessors;
use crate::c5::codegen::ssa::reg_alloc::{produces_fp_result, wide_values};
use crate::c5::codegen::ssa::tape;
use crate::c5::ir::{BlockId, FunctionSsa, Inst, NO_VALUE, Terminator, ValueId};

const NO_BLOCK: BlockId = BlockId::MAX;

/// Returns whether the function changed.
pub(crate) fn run_one(func: &mut FunctionSsa) -> bool {
    if func.blocks.len() < 2 {
        return false;
    }
    let preds = predecessors(func);
    let forwarded = forward_phis(func, &preds);
    let merged = merge(func, &preds);
    forwarded || merged
}

/// Point the readers of every one-input phi at its value. A block's phis
/// go together or not at all, so the ones that stay still lead it. A phi
/// stays when [`reads_alike`] fails and when its predecessor branches on
/// the value: `constfold_branch` decides a test of the phi from that edge.
fn forward_phis(func: &mut FunctionSsa, preds: &[Vec<BlockId>]) -> bool {
    let mut to: Vec<(ValueId, ValueId)> = Vec::new();
    let mut wide: Option<Vec<bool>> = None;
    for (b, block) in func.blocks.iter().enumerate().skip(1) {
        let [p] = preds[b][..] else {
            continue;
        };
        let first = to.len();
        for i in block.inst_range.clone() {
            let Inst::Phi { incoming, .. } = &func.insts[i as usize] else {
                break;
            };
            let forwardable = match incoming[..] {
                [(q, v)] => {
                    q == p
                        && !block.inst_range.contains(&v)
                        && (v as usize) < func.insts.len()
                        && edge_truth(func, p, b as BlockId, v).is_none()
                        && reads_alike(func, &mut wide, i, v)
                }
                _ => false,
            };
            if !forwardable {
                to.truncate(first);
                break;
            }
            to.push((i, incoming[0].1));
        }
    }
    if to.is_empty() {
        return false;
    }
    let mut target: Vec<ValueId> = (0..func.insts.len() as ValueId).collect();
    for &(phi, v) in &to {
        target[phi as usize] = v;
    }
    // A value may itself be a forwarded phi; the bound covers a cycle.
    let resolve = |mut v: ValueId| {
        for _ in 0..to.len() {
            if v == NO_VALUE || target[v as usize] == v {
                break;
            }
            v = target[v as usize];
        }
        v
    };
    for inst in func.insts.iter_mut() {
        inst.for_each_operand_mut(|op| *op = resolve(*op));
    }
    for block in func.blocks.iter_mut() {
        block.exit_acc = resolve(block.exit_acc);
        block.terminator.for_each_operand_mut(|v| *v = resolve(*v));
    }
    for &(phi, _) in &to {
        func.insts[phi as usize] = Inst::Imm(0);
        if let Some(f) = func.f32_values.get_mut(phi as usize) {
            *f = false;
        }
    }
    true
}

/// Whether a reader treats `v` as it treats `phi`: the same register
/// file, and for a float the same scalar and vector width.
fn reads_alike(func: &FunctionSsa, wide: &mut Option<Vec<bool>>, phi: ValueId, v: ValueId) -> bool {
    let is_f32 = |x: ValueId| func.f32_values.get(x as usize).copied().unwrap_or(false);
    let fp = produces_fp_result(&func.insts[phi as usize]);
    if fp != produces_fp_result(&func.insts[v as usize]) || is_f32(phi) != is_f32(v) {
        return false;
    }
    if !fp {
        return true;
    }
    let wide = wide.get_or_insert_with(|| wide_values(func));
    wide[phi as usize] == wide[v as usize]
}

/// Merge every block into the predecessor that only jumps to it, when no
/// other edge enters it.
fn merge(func: &mut FunctionSsa, preds: &[Vec<BlockId>]) -> bool {
    let n = func.blocks.len();
    let mut pinned = vec![false; n];
    pinned[0] = true;
    let listed = func
        .computed_goto_targets
        .iter()
        .chain(func.label_data_relocs.iter().map(|r| &r.block))
        .chain(func.jump_tables.iter().flatten());
    for &b in listed {
        pinned[b as usize] = true;
    }
    for inst in &func.insts {
        if let Inst::BlockAddr(b) = inst {
            pinned[*b as usize] = true;
        }
    }
    // `next[p]`: the block merged into `p`.
    let mut next = vec![NO_BLOCK; n];
    let mut absorbed = vec![false; n];
    for s in 1..n {
        let [p] = preds[s][..] else {
            continue;
        };
        let jumps_here = matches!(
            func.blocks[p as usize].terminator,
            Terminator::Jmp(t) | Terminator::FallThrough(t) if t as usize == s
        );
        let leads_with_phi = func.blocks[s]
            .inst_range
            .clone()
            .next()
            .is_some_and(|i| matches!(func.insts[i as usize], Inst::Phi { .. }));
        if pinned[s] || p as usize == s || !jumps_here || leads_with_phi {
            continue;
        }
        next[p as usize] = s as BlockId;
        absorbed[s] = true;
    }
    // A cycle of absorbed blocks has no head and is unreachable.
    let mut chains: Vec<Vec<BlockId>> = Vec::new();
    for head in 0..n {
        if absorbed[head] || next[head] == NO_BLOCK {
            continue;
        }
        let mut chain = vec![head as BlockId];
        let mut at = next[head];
        while at != NO_BLOCK {
            chain.push(at);
            at = next[at as usize];
        }
        chains.push(chain);
    }
    if chains.is_empty() {
        return false;
    }
    let mut into: Vec<BlockId> = (0..n as BlockId).collect();
    for chain in &chains {
        let (head, last) = (chain[0] as usize, chain[chain.len() - 1] as usize);
        func.blocks[head].terminator = func.blocks[last].terminator;
        func.blocks[head].exit_acc = func.blocks[last].exit_acc;
        for &b in &chain[1..] {
            func.blocks[b as usize].terminator = Terminator::Unreachable;
            func.blocks[b as usize].exit_acc = NO_VALUE;
            into[b as usize] = chain[0];
        }
    }
    // The successors of a chain's last block now follow its head.
    for inst in func.insts.iter_mut() {
        if let Inst::Phi { incoming, .. } = inst {
            for (pred, _) in incoming.iter_mut() {
                if let Some(&head) = into.get(*pred as usize) {
                    *pred = head;
                }
            }
        }
    }
    tape::concat(func, &chains);
    // The absorbed blocks are empty and unreachable.
    super::prune_unreachable::run_one(func);
    true
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{BinOp, Block, LabelDataReloc, LoadKind};

    fn fresh(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            inst_src: vec![(0, 0); insts.len()],
            f32_values: vec![false; insts.len()],
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

    fn phi(incoming: Vec<(BlockId, ValueId)>) -> Inst {
        Inst::Phi {
            incoming,
            kind: LoadKind::I64,
        }
    }

    fn param(idx: u32) -> Inst {
        Inst::ParamRef {
            idx,
            kind: LoadKind::I64,
        }
    }

    fn lt(lhs: ValueId, rhs_imm: i64) -> Inst {
        Inst::BinopI {
            op: BinOp::Lt,
            lhs,
            rhs_imm,
        }
    }

    fn bz(cond: ValueId, target: BlockId, fall_through: BlockId) -> Terminator {
        Terminator::Bz {
            cond,
            target,
            fall_through,
        }
    }

    /// `if (a < 3 && b < 7)` once `thread_phi_branches` has sent the
    /// short-circuit edge past the merge: b1 computes the second test,
    /// b2 holds its one-input phi and the branch on it.
    fn second_operand_behind_a_phi() -> FunctionSsa {
        fresh(
            vec![
                param(0),          // v0  b0
                lt(0, 3),          // v1  b0
                param(1),          // v2  b1
                lt(2, 7),          // v3  b1
                phi(vec![(1, 3)]), // v4  b2
                Inst::Imm(1),      // v5  b3
                Inst::Imm(0),      // v6  b4
            ],
            vec![
                block(0..2, bz(1, 4, 1)),
                block(2..4, Terminator::Jmp(2)),
                block(4..5, bz(4, 4, 3)),
                block(5..6, Terminator::Return(5)),
                block(6..7, Terminator::Return(6)),
            ],
        )
    }

    #[test]
    fn the_second_operand_of_a_conjunction_branches_in_its_own_block() {
        let mut f = second_operand_behind_a_phi();
        f.blocks[2].exit_acc = 4;
        assert!(run_one(&mut f));
        assert_eq!(f.blocks.len(), 4);
        // b1 took the branch, which now reads the comparison; b3 and b4
        // moved down one id.
        assert_eq!(f.blocks[1].inst_range, 2..5);
        assert_eq!(f.blocks[1].terminator, bz(3, 3, 2));
        assert_eq!(f.blocks[1].exit_acc, 3);
        assert!(matches!(f.insts[4], Inst::Imm(0)));
        assert_eq!(f.blocks[0].terminator, bz(1, 3, 1));
        assert!(!run_one(&mut f));
    }

    #[test]
    fn a_successor_phi_names_the_merged_block() {
        let mut f = second_operand_behind_a_phi();
        // b4 merges the phi from b2 and a constant from b0.
        f.insts[6] = phi(vec![(0, 0), (2, 4)]);
        assert!(run_one(&mut f));
        assert!(
            matches!(&f.insts[6], Inst::Phi { incoming, .. } if incoming == &vec![(0, 0), (1, 3)])
        );
    }

    #[test]
    fn a_distant_block_moves_behind_its_predecessor() {
        // b0 -> b2 -> b1: b2's instructions sit after b1's on the tape and
        // read a value of b0.
        let mut f = fresh(
            vec![
                param(0),     // v0  b0
                Inst::Imm(9), // v1  b1
                lt(0, 5),     // v2  b2
            ],
            vec![
                block(0..1, Terminator::Jmp(2)),
                block(1..2, Terminator::Return(1)),
                block(2..3, bz(2, 1, 1)),
            ],
        );
        assert!(run_one(&mut f));
        assert_eq!(f.blocks.len(), 2);
        assert_eq!(f.blocks[0].inst_range, 0..2);
        assert!(matches!(f.insts[1], Inst::BinopI { lhs: 0, .. }));
        assert_eq!(f.blocks[0].terminator, bz(1, 1, 1));
        assert_eq!(f.blocks[1].terminator, Terminator::Return(2));
    }

    #[test]
    fn a_line_of_three_blocks_becomes_one() {
        let mut f = fresh(
            vec![param(0), lt(0, 1), lt(1, 2)],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..2, Terminator::FallThrough(2)),
                block(2..3, Terminator::Return(2)),
            ],
        );
        assert!(run_one(&mut f));
        assert_eq!(f.blocks.len(), 1);
        assert_eq!(f.blocks[0].inst_range, 0..3);
        assert_eq!(f.blocks[0].terminator, Terminator::Return(2));
    }

    #[test]
    fn a_jump_table_dispatch_moves_with_its_block() {
        let mut f = fresh(
            vec![param(0), Inst::Imm(1), Inst::Imm(2)],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..1, Terminator::JumpTable { idx: 0, table: 0 }),
                block(1..2, Terminator::Return(1)),
                block(2..3, Terminator::Return(2)),
            ],
        );
        f.jump_tables = vec![vec![2, 3, 2]];
        assert!(run_one(&mut f));
        assert_eq!(f.blocks.len(), 3);
        assert_eq!(
            f.blocks[0].terminator,
            Terminator::JumpTable { idx: 0, table: 0 }
        );
        assert_eq!(f.jump_tables[0], vec![1, 2, 1]);
    }

    /// A loop body of two blocks: the latch joins the body, and the
    /// header's phi names the block that now holds the back edge.
    #[test]
    fn a_latch_merges_into_the_loop_body() {
        let mut f = fresh(
            vec![
                Inst::Imm(0),              // v0  b0
                phi(vec![(0, 0), (3, 4)]), // v1  b1
                lt(1, 10),                 // v2  b1
                Inst::Imm(5),              // v3  b2
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 1,
                    rhs_imm: 1,
                }, // v4  b3
            ],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..3, bz(2, 4, 2)),
                block(3..4, Terminator::Jmp(3)),
                block(4..5, Terminator::Jmp(1)),
                block(5..5, Terminator::Return(1)),
            ],
        );
        assert!(run_one(&mut f));
        assert_eq!(f.blocks.len(), 4);
        assert_eq!(f.blocks[2].inst_range, 3..5);
        assert_eq!(f.blocks[2].terminator, Terminator::Jmp(1));
        assert!(
            matches!(&f.insts[1], Inst::Phi { incoming, .. } if incoming == &vec![(0, 0), (2, 4)])
        );
        // The header keeps its two predecessors and stays apart.
        assert_eq!(f.blocks[0].terminator, Terminator::Jmp(1));
    }

    /// The entry is where the function's address points.
    #[test]
    fn the_entry_block_stays() {
        // b1 is the entry's only predecessor and only jumps to it.
        let mut f = fresh(
            vec![param(0), Inst::Imm(1), Inst::Imm(2)],
            vec![
                block(0..1, bz(0, 1, 2)),
                block(1..2, Terminator::Jmp(0)),
                block(2..3, Terminator::Return(2)),
            ],
        );
        assert!(!run_one(&mut f));
        assert_eq!(f.blocks.len(), 3);
    }

    #[test]
    fn a_block_that_jumps_to_itself_stays() {
        // b1 has two predecessors, b0 and itself.
        let mut f = fresh(
            vec![Inst::Imm(0), Inst::Imm(1)],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..2, Terminator::Jmp(1)),
            ],
        );
        assert!(!run_one(&mut f));
        assert_eq!(f.blocks.len(), 2);
    }

    /// Blocks entered other than over a terminator edge keep their
    /// identity.
    #[test]
    fn an_indirectly_entered_block_stays() {
        let line = || {
            fresh(
                vec![Inst::Imm(0), Inst::Imm(1)],
                vec![
                    block(0..1, Terminator::Jmp(1)),
                    block(1..2, Terminator::Return(1)),
                ],
            )
        };
        let mut f = line();
        assert!(run_one(&mut f), "the plain line merges");

        let mut f = line();
        f.insts[0] = Inst::BlockAddr(1);
        assert!(!run_one(&mut f), "address-taken label");

        let mut f = line();
        f.label_data_relocs = vec![LabelDataReloc {
            data_offset: 0,
            block: 1,
        }];
        assert!(!run_one(&mut f), "label address in static data");

        // A row no dispatch names any more still lists the block.
        let mut f = line();
        f.jump_tables = vec![vec![1]];
        assert!(!run_one(&mut f), "jump-table row");
    }

    #[test]
    fn a_computed_goto_target_stays() {
        let mut f = fresh(
            vec![Inst::BlockAddr(1), Inst::Imm(1)],
            vec![
                block(0..1, Terminator::GotoIndirect { target: 0 }),
                block(1..2, Terminator::Return(1)),
            ],
        );
        f.computed_goto_targets = vec![1];
        assert!(!run_one(&mut f));
    }

    #[test]
    fn an_asm_goto_row_target_stays() {
        // b1 is the fall-through row entry of b0's asm goto and b2 its
        // label; b3 follows b1 over a plain jump and merges.
        let mut f = fresh(
            vec![Inst::Imm(0), Inst::Imm(1), Inst::Imm(2), Inst::Imm(3)],
            vec![
                block(0..1, Terminator::AsmGoto { table: 0 }),
                block(1..2, Terminator::Jmp(3)),
                block(2..3, Terminator::Return(2)),
                block(3..4, Terminator::Return(3)),
            ],
        );
        f.jump_tables = vec![vec![1, 2]];
        assert!(run_one(&mut f));
        assert_eq!(f.blocks.len(), 3);
        assert_eq!(f.blocks[1].inst_range, 1..3);
        assert_eq!(f.blocks[1].terminator, Terminator::Return(2));
        assert_eq!(f.jump_tables[0], vec![1, 2]);
    }

    /// The predecessor branches on the phi's value, so the edge fixes the
    /// phi's truth and `constfold_branch` reads it there.
    #[test]
    fn a_phi_decided_by_its_edge_stays() {
        let mut f = fresh(
            vec![
                param(0),          // v0  b0
                phi(vec![(0, 0)]), // v1  b1
                Inst::Imm(7),      // v2  b2
            ],
            vec![
                block(0..1, bz(0, 1, 2)),
                block(1..2, Terminator::Return(1)),
                block(2..3, Terminator::Return(2)),
            ],
        );
        assert!(!run_one(&mut f));
        assert!(matches!(f.insts[1], Inst::Phi { .. }));
    }

    /// A float constant lives in the integer file and its phi in the FP
    /// file: readers of the phi take an FP register.
    #[test]
    fn a_phi_in_another_register_file_stays_and_holds_its_block() {
        let mut f = fresh(
            vec![
                Inst::Imm(0x3ff0_0000_0000_0000),
                Inst::Phi {
                    incoming: vec![(0, 0)],
                    kind: LoadKind::F64,
                },
            ],
            vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..2, Terminator::Return(1)),
            ],
        );
        assert!(!run_one(&mut f));
        assert_eq!(f.blocks.len(), 2);
    }

    #[test]
    fn the_phis_of_a_block_go_together_or_not_at_all() {
        let mut f = fresh(
            vec![
                param(0),                         // v0  b0
                Inst::Imm(0x3ff0_0000_0000_0000), // v1  b0
                phi(vec![(0, 0)]),                // v2  b1
                Inst::Phi {
                    incoming: vec![(0, 1)],
                    kind: LoadKind::F64,
                }, // v3  b1
            ],
            vec![
                block(0..2, Terminator::Jmp(1)),
                block(2..4, Terminator::Return(2)),
            ],
        );
        assert!(!run_one(&mut f));
        assert!(matches!(f.insts[2], Inst::Phi { .. }));
    }

    /// One incoming value but two predecessors: the value does not
    /// dominate the block.
    #[test]
    fn a_phi_short_of_a_predecessor_stays() {
        let mut f = fresh(
            vec![
                param(0),          // v0  b0
                Inst::Imm(4),      // v1  b1
                phi(vec![(1, 1)]), // v2  b2
            ],
            vec![
                block(0..1, bz(0, 2, 1)),
                block(1..2, Terminator::Jmp(2)),
                block(2..3, Terminator::Return(2)),
            ],
        );
        assert!(!run_one(&mut f));
    }

    #[test]
    fn a_chain_of_phis_resolves_to_the_value() {
        // b1 and b2 each hold a one-input phi; b0 branches, so neither
        // block merges into it, and b2's phi reads b1's.
        let mut f = fresh(
            vec![
                param(0),          // v0  b0
                param(1),          // v1  b0
                phi(vec![(0, 1)]), // v2  b1
                lt(2, 3),          // v3  b1
                phi(vec![(1, 2)]), // v4  b2
                Inst::Imm(0),      // v5  b3
            ],
            vec![
                block(0..2, bz(0, 3, 1)),
                block(2..4, bz(3, 3, 2)),
                block(4..5, Terminator::Return(4)),
                block(5..6, Terminator::Return(5)),
            ],
        );
        assert!(run_one(&mut f));
        assert_eq!(f.blocks.len(), 4);
        assert!(matches!(f.insts[3], Inst::BinopI { lhs: 1, .. }));
        assert_eq!(f.blocks[2].terminator, Terminator::Return(1));
    }
}
