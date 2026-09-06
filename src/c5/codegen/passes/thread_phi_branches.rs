//! Thread a branch on a phi of decided values past the merge.
//!
//! `if (!begin(p)) return -EFAULT;` after an inlined `begin` that
//! returns 0 from its check and 1 past its side effect merges the two
//! constants in a phi and branches on it. Each predecessor already
//! decides that branch, so it is sent to the successor its own value
//! selects; the merge and the test leave its path. Besides the compare,
//! this removes the edge from the block past the side effect to the
//! error return, which a checker following edges without values
//! (objtool's UACCESS rule over `stac` / `clac`) otherwise reports.
//!
//! The merge block and the straight line of jumps from it to the branch
//! may hold only phis and pure values consumed inside the line or by
//! the successors' phis on the branch block's edge; a threaded edge
//! feeds those phis from the predecessor's own incoming value.

use alloc::collections::BTreeSet;
use alloc::vec::Vec;

use super::constfold::imm_through_phis;
use super::constfold_branch::{block_index, edge_truth};
use crate::c5::codegen::ssa::mem2reg::predecessors;
use crate::c5::ir::{BinOp, BlockId, FunctionSsa, Inst, LoadKind, Terminator, ValueId};

/// A branch decided per predecessor of the phi it reads.
struct Site {
    /// The block holding the phi.
    head: BlockId,
    /// The block holding the branch; `head` itself or the end of a
    /// straight line of jumps from it.
    branch: BlockId,
    /// `head` through `branch`.
    chain: Vec<BlockId>,
    phi: ValueId,
    /// The branch tests `phi == 0` rather than `phi`.
    negate: bool,
    zero: BlockId,
    nonzero: BlockId,
}

/// Thread every decidable predecessor edge of every phi branch. Returns
/// whether any edge moved; the caller prunes a merge left without
/// predecessors.
pub(crate) fn run_one(func: &mut FunctionSsa) -> bool {
    let block_of = block_index(func);
    let mut preds = predecessors(func);
    let mut changed = false;
    for b in 0..func.blocks.len() {
        let Some(site) = site_of(func, &block_of, &preds, b as BlockId) else {
            continue;
        };
        for p in preds[site.head as usize].clone() {
            if site.chain.contains(&p) {
                continue;
            }
            let Some(nonzero) = decide(func, &site, p) else {
                continue;
            };
            let succ = if nonzero { site.nonzero } else { site.zero };
            if thread(func, &block_of, &site, p, succ) {
                preds[site.head as usize].retain(|&q| q != p);
                preds[succ as usize].push(p);
                changed = true;
            }
        }
    }
    changed
}

/// The site whose branch block `b` is, when its condition is a phi (or
/// a zero test of one) and the line from the phi's block to `b` holds
/// nothing the threaded edge could skip.
fn site_of(
    func: &FunctionSsa,
    block_of: &[BlockId],
    preds: &[Vec<BlockId>],
    b: BlockId,
) -> Option<Site> {
    let (cond, zero, nonzero) = match func.blocks[b as usize].terminator {
        Terminator::Bz {
            cond,
            target,
            fall_through,
        } => (cond, target, fall_through),
        Terminator::Bnz {
            cond,
            target,
            fall_through,
        } => (cond, fall_through, target),
        _ => return None,
    };
    if zero == nonzero {
        return None;
    }
    let (phi, negate) = phi_condition(func, cond)?;
    let head = *block_of.get(phi as usize)?;
    if head == BlockId::MAX {
        return None;
    }
    let mut chain = alloc::vec![head];
    let mut cur = head;
    while cur != b {
        let next = match func.blocks[cur as usize].terminator {
            Terminator::Jmp(t) | Terminator::FallThrough(t) => t,
            _ => return None,
        };
        if preds[next as usize].len() != 1 || chain.contains(&next) {
            return None;
        }
        chain.push(next);
        cur = next;
    }
    if chain.contains(&zero) || chain.contains(&nonzero) {
        return None;
    }
    let site = Site {
        head,
        branch: b,
        chain,
        phi,
        negate,
        zero,
        nonzero,
    };
    chain_is_skippable(func, block_of, &site).then_some(site)
}

/// `(phi, negate)` for a condition that is an integer phi or its zero
/// test.
fn phi_condition(func: &FunctionSsa, cond: ValueId) -> Option<(ValueId, bool)> {
    let (v, negate) = match func.insts.get(cond as usize)? {
        Inst::Phi { .. } => (cond, false),
        Inst::BinopI {
            op: BinOp::Eq,
            lhs,
            rhs_imm: 0,
        } => (*lhs, true),
        Inst::BinopI {
            op: BinOp::Ne,
            lhs,
            rhs_imm: 0,
        } => (*lhs, false),
        Inst::Binop { op, lhs, rhs }
            if matches!(op, BinOp::Eq | BinOp::Ne)
                && matches!(func.insts.get(*rhs as usize), Some(Inst::Imm(0))) =>
        {
            (*lhs, *op == BinOp::Eq)
        }
        _ => return None,
    };
    match func.insts.get(v as usize)? {
        Inst::Phi { kind, .. }
            if !matches!(
                kind,
                LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128
            ) =>
        {
            Some((v, negate))
        }
        _ => None,
    }
}

/// Whether the chain holds only phis (in `head`) and pure values, none
/// of them read outside the chain other than by a successor phi on the
/// branch block's edge that a phi of `head` feeds.
fn chain_is_skippable(func: &FunctionSsa, block_of: &[BlockId], site: &Site) -> bool {
    let mut defined: BTreeSet<ValueId> = BTreeSet::new();
    for &c in &site.chain {
        for i in func.blocks[c as usize].inst_range.clone() {
            match &func.insts[i as usize] {
                Inst::Phi { .. } if c == site.head => {}
                inst if inst.is_pure() => {}
                _ => return false,
            }
            defined.insert(i);
        }
    }
    let in_chain = |b: BlockId| site.chain.contains(&b);
    let head_phi = |v: ValueId| {
        block_of.get(v as usize) == Some(&site.head)
            && matches!(func.insts.get(v as usize), Some(Inst::Phi { .. }))
    };
    for (i, inst) in func.insts.iter().enumerate() {
        let b = block_of[i];
        if b == BlockId::MAX || in_chain(b) {
            continue;
        }
        if let Inst::Phi { incoming, .. } = inst {
            let patched = b == site.zero || b == site.nonzero;
            if incoming.iter().any(|&(pred, v)| {
                defined.contains(&v) && !(patched && pred == site.branch && head_phi(v))
            }) {
                return false;
            }
            continue;
        }
        let mut escapes = false;
        inst.for_each_operand(|v| escapes |= defined.contains(&v));
        if escapes {
            return false;
        }
    }
    for (b, block) in func.blocks.iter().enumerate() {
        if in_chain(b as BlockId) {
            continue;
        }
        let mut escapes = defined.contains(&block.exit_acc);
        block
            .terminator
            .for_each_operand(|v| escapes |= defined.contains(&v));
        if escapes {
            return false;
        }
    }
    true
}

/// Whether the branch condition is non-zero on the edge `p -> head`,
/// when the phi's incoming value from `p` decides it.
fn decide(func: &FunctionSsa, site: &Site, p: BlockId) -> Option<bool> {
    let Inst::Phi { incoming, .. } = &func.insts[site.phi as usize] else {
        return None;
    };
    let &(_, val) = incoming.iter().find(|&&(pred, _)| pred == p)?;
    let truth = match func.insts.get(val as usize)? {
        Inst::Imm(k) => *k != 0,
        _ => imm_through_phis(&func.insts, &[], val)
            .map(|k| k != 0)
            .or_else(|| edge_truth(func, p, site.head, val))?,
    };
    Some(truth != site.negate)
}

/// Move `p`'s edge into `head` to `succ`, feeding `succ`'s phis on the
/// branch block's edge from `p`'s own incoming values. Returns `false`,
/// with nothing changed, when `p`'s terminator is not a plain branch
/// or a phi of `succ` already takes a different value from `p`.
fn thread(
    func: &mut FunctionSsa,
    block_of: &[BlockId],
    site: &Site,
    p: BlockId,
    succ: BlockId,
) -> bool {
    let incoming_from = |func: &FunctionSsa, phi: ValueId, pred: BlockId| -> Option<ValueId> {
        let Inst::Phi { incoming, .. } = &func.insts[phi as usize] else {
            return None;
        };
        incoming.iter().find(|&&(q, _)| q == pred).map(|&(_, v)| v)
    };
    let mut pushes: Vec<(ValueId, ValueId)> = Vec::new();
    for i in func.blocks[succ as usize].inst_range.clone() {
        let Inst::Phi { incoming, .. } = &func.insts[i as usize] else {
            break;
        };
        let Some(&(_, v)) = incoming.iter().find(|&&(q, _)| q == site.branch) else {
            continue;
        };
        let v = if block_of.get(v as usize) == Some(&site.head)
            && matches!(func.insts[v as usize], Inst::Phi { .. })
        {
            match incoming_from(func, v, p) {
                Some(w) => w,
                None => return false,
            }
        } else {
            v
        };
        match incoming.iter().find(|&&(q, _)| q == p) {
            Some(&(_, w)) if w != v => return false,
            Some(_) => {}
            None => pushes.push((i, v)),
        }
    }
    let retarget = |t: &mut BlockId| {
        if *t == site.head {
            *t = succ;
        }
    };
    match &mut func.blocks[p as usize].terminator {
        Terminator::Jmp(t) | Terminator::FallThrough(t) => retarget(t),
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
            retarget(target);
            retarget(fall_through);
        }
        _ => return false,
    }
    for (phi, v) in pushes {
        if let Inst::Phi { incoming, .. } = &mut func.insts[phi as usize] {
            incoming.push((p, v));
        }
    }
    for i in func.blocks[site.head as usize].inst_range.clone() {
        if let Inst::Phi { incoming, .. } = &mut func.insts[i as usize] {
            incoming.retain(|&(q, _)| q != p);
        }
    }
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

    /// `if (!f())` after inlining `f`: b0 tests the parameter, b1 merges
    /// 0 and b3 merges 1 into b2's phi, b4 branches on it. Both
    /// predecessors are sent past the merge to the arm their constant
    /// selects, leaving the phi with no incoming edge.
    fn inlined_check(cond: Inst) -> FunctionSsa {
        fresh(
            vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::Imm(0),
                phi(vec![(1, 1), (3, 3)]),
                Inst::Imm(1),
                cond,
                Inst::Imm(-14),
                Inst::Imm(0),
            ],
            vec![
                block(
                    0..1,
                    Terminator::Bnz {
                        cond: 0,
                        target: 3,
                        fall_through: 1,
                    },
                ),
                block(1..2, Terminator::Jmp(2)),
                block(2..3, Terminator::Jmp(4)),
                block(3..4, Terminator::Jmp(2)),
                block(
                    4..5,
                    Terminator::Bnz {
                        cond: 4,
                        target: 6,
                        fall_through: 5,
                    },
                ),
                block(5..6, Terminator::Return(5)),
                block(6..7, Terminator::Return(6)),
            ],
        )
    }

    #[test]
    fn constant_incomings_thread_past_the_merge() {
        let mut f = inlined_check(Inst::Copy {
            value: 2,
            is_fp: false,
        });
        // The branch reads the phi through a copy the chain defines; the
        // copy is pure and read only by the branch.
        f.blocks[4].terminator = Terminator::Bnz {
            cond: 2,
            target: 6,
            fall_through: 5,
        };
        assert!(run_one(&mut f));
        assert_eq!(f.blocks[1].terminator, Terminator::Jmp(5));
        assert_eq!(f.blocks[3].terminator, Terminator::Jmp(6));
        assert!(matches!(&f.insts[2], Inst::Phi { incoming, .. } if incoming.is_empty()));
        assert!(!run_one(&mut f));
    }

    #[test]
    fn a_zero_test_of_the_phi_inverts_the_arms() {
        let mut f = inlined_check(Inst::BinopI {
            op: BinOp::Eq,
            lhs: 2,
            rhs_imm: 0,
        });
        assert!(run_one(&mut f));
        assert_eq!(f.blocks[1].terminator, Terminator::Jmp(6));
        assert_eq!(f.blocks[3].terminator, Terminator::Jmp(5));
    }

    #[test]
    fn a_successor_phi_takes_the_predecessors_own_value() {
        let mut f = inlined_check(Inst::BinopI {
            op: BinOp::Ne,
            lhs: 2,
            rhs_imm: 0,
        });
        // b6 merges the phi itself from b4; after threading b3 -> b6 it
        // merges b3's incoming.
        f.insts[6] = phi(vec![(4, 2)]);
        assert!(run_one(&mut f));
        assert!(
            matches!(&f.insts[6], Inst::Phi { incoming, .. } if incoming == &vec![(4, 2), (3, 3)])
        );
    }

    #[test]
    fn a_merge_value_read_outside_the_chain_is_kept() {
        let mut f = inlined_check(Inst::BinopI {
            op: BinOp::Ne,
            lhs: 2,
            rhs_imm: 0,
        });
        f.insts[6] = Inst::BinopI {
            op: BinOp::Add,
            lhs: 2,
            rhs_imm: 1,
        };
        assert!(!run_one(&mut f));
        assert_eq!(f.blocks[1].terminator, Terminator::Jmp(2));
    }

    #[test]
    fn a_side_effect_between_merge_and_branch_is_kept() {
        let mut f = inlined_check(Inst::Intrinsic {
            kind: 0,
            args: Vec::new(),
        });
        f.blocks[4].terminator = Terminator::Bnz {
            cond: 2,
            target: 6,
            fall_through: 5,
        };
        assert!(!run_one(&mut f));
    }

    #[test]
    fn a_short_circuit_edge_decides_without_a_constant() {
        // `a && b`: b1 branches on v1 and merges it into the phi on its
        // false edge, where it is known zero.
        let mut f = fresh(
            vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I64,
                },
                phi(vec![(1, 1), (0, 0)]),
                Inst::Imm(-1),
                Inst::Imm(0),
            ],
            vec![
                block(
                    0..1,
                    Terminator::Bz {
                        cond: 0,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(
                    1..2,
                    Terminator::Bnz {
                        cond: 1,
                        target: 4,
                        fall_through: 2,
                    },
                ),
                block(
                    2..3,
                    Terminator::Bnz {
                        cond: 2,
                        target: 4,
                        fall_through: 3,
                    },
                ),
                block(3..4, Terminator::Return(3)),
                block(4..5, Terminator::Return(4)),
            ],
        );
        assert!(run_one(&mut f));
        assert_eq!(
            f.blocks[1].terminator,
            Terminator::Bnz {
                cond: 1,
                target: 4,
                fall_through: 3
            }
        );
        // b0's edge carries `a` itself, zero on the `Bz` target edge.
        assert_eq!(
            f.blocks[0].terminator,
            Terminator::Bz {
                cond: 0,
                target: 3,
                fall_through: 1
            }
        );
        assert!(matches!(&f.insts[2], Inst::Phi { incoming, .. } if incoming.is_empty()));
    }
}
