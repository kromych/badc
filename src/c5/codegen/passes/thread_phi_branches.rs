//! Thread a branch on decided values past the merge.
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
//! The condition is the phi, its zero test, or a computation of the merge
//! block's phis. The merge block and the straight line of jumps from it to
//! the branch hold only phis and pure values. A threaded edge feeds the
//! successors' phis from the predecessor's own values; any other reader of
//! the line keeps the edge, unless the edge was the line's last way in: the
//! line (a loop its entry values skip) then dies with it, and a surviving
//! reader of a merge phi reads the edge's value.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use super::constfold::imm_through_phis;
use super::constfold_branch::{block_index, edge_truth};
use super::merge_blocks::reads_alike;
use super::unroll::{bind_phis, eval_value};
use crate::c5::codegen::ssa::mem2reg::{predecessors, successors};
use crate::c5::ir::{BinOp, BlockId, FunctionSsa, Inst, LoadKind, Terminator, ValueId};

/// A branch decided per predecessor of the block whose phis it reads.
struct Site {
    /// The block holding the phis.
    head: BlockId,
    /// The block holding the branch; `head` itself or the end of a
    /// straight line of jumps from it.
    branch: BlockId,
    /// `head` through `branch`.
    chain: Vec<BlockId>,
    /// The phi the branch tests, itself or through a zero test.
    phi: Option<ValueId>,
    cond: ValueId,
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
        let decided: Vec<(BlockId, BlockId)> = preds[site.head as usize]
            .iter()
            .filter(|p| !site.chain.contains(p))
            .filter_map(|&p| {
                decide(func, &site, p).map(|nz| (p, if nz { site.nonzero } else { site.zero }))
            })
            .collect();
        if decided.is_empty() || !chain_is_pure(func, &site) {
            continue;
        }
        let contained = values_stay_in(func, &block_of, &site);
        for (p, succ) in decided {
            if contained {
                if thread(func, &block_of, &site, p, succ) {
                    preds[site.head as usize].retain(|&q| q != p);
                    preds[succ as usize].push(p);
                    changed = true;
                }
                continue;
            }
            // The line dies: the next round reads the function the prune left.
            if let Some(to) = dying_line(func, &block_of, &site, p, succ)
                && thread(func, &block_of, &site, p, succ)
            {
                forward(func, &to);
                return true;
            }
        }
    }
    changed
}

/// The site whose branch block `b` is: a phi, its zero test, or another
/// condition read from `b`'s own phis, and the line of jumps from the
/// phis' block to `b`.
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
    let (phi, negate, head) = match phi_condition(func, cond) {
        Some((phi, negate)) => (Some(phi), negate, *block_of.get(phi as usize)?),
        None if takes_constant(func, b, None) => (None, false, b),
        None => return None,
    };
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
    Some(Site {
        head,
        branch: b,
        chain,
        phi,
        cond,
        negate,
        zero,
        nonzero,
    })
}

/// Whether a phi of `b` takes an `Imm` from `pred`, or from any predecessor.
fn takes_constant(func: &FunctionSsa, b: BlockId, pred: Option<BlockId>) -> bool {
    let phis =
        func.blocks[b as usize]
            .inst_range
            .clone()
            .map_while(|v| match &func.insts[v as usize] {
                Inst::Phi { incoming, .. } => Some(incoming),
                _ => None,
            });
    let imm = |x: ValueId| matches!(func.insts.get(x as usize), Some(Inst::Imm(_)));
    phis.flat_map(|i| i.iter())
        .any(|&(q, x)| pred.is_none_or(|p| p == q) && imm(x))
}

/// Whether the chain holds only phis (in `head`) and pure values.
fn chain_is_pure(func: &FunctionSsa, site: &Site) -> bool {
    site.chain.iter().all(|&c| {
        func.blocks[c as usize]
            .inst_range
            .clone()
            .all(|i| match &func.insts[i as usize] {
                Inst::Phi { .. } => c == site.head,
                inst => inst.is_pure(),
            })
    })
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

/// Whether no value of the chain is read outside it, other than by a
/// successor phi on the branch block's edge that a phi of `head` feeds.
fn values_stay_in(func: &FunctionSsa, block_of: &[BlockId], site: &Site) -> bool {
    let defined: BTreeSet<ValueId> = site
        .chain
        .iter()
        .flat_map(|&c| func.blocks[c as usize].inst_range.clone())
        .collect();
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
/// when the values `p` feeds the head's phis decide it, at the IR's width
/// (the compares are narrowed later).
fn decide(func: &FunctionSsa, site: &Site, p: BlockId) -> Option<bool> {
    let Some(phi) = site.phi else {
        if !takes_constant(func, site.head, Some(p)) {
            return None;
        }
        let mut bound = BTreeMap::new();
        bind_phis(func, p, site.head, &mut bound);
        if bound.values().all(Option::is_none) {
            return None;
        }
        let c = eval_value(
            func,
            site.cond,
            &bound,
            &mut BTreeMap::new(),
            0,
            &func.cmp32,
        )?;
        return Some(c != 0);
    };
    let Inst::Phi { incoming, .. } = &func.insts[phi as usize] else {
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

/// When moving `p`'s edge to `succ` leaves the chain unreachable, each
/// head phi with the value `p` feeds it: every surviving read of a value
/// the dead blocks define is of a head phi, and that value reads alike.
fn dying_line(
    func: &FunctionSsa,
    block_of: &[BlockId],
    site: &Site,
    p: BlockId,
    succ: BlockId,
) -> Option<Vec<(ValueId, ValueId)>> {
    let mut live = alloc::vec![false; func.blocks.len()];
    let mut stack: Vec<BlockId> = alloc::vec![0];
    stack.extend(&func.computed_goto_targets);
    while let Some(b) = stack.pop() {
        if core::mem::replace(&mut live[b as usize], true) {
            continue;
        }
        let term = &func.blocks[b as usize].terminator;
        for s in successors(term, &func.computed_goto_targets, &func.jump_tables) {
            stack.push(if b == p && s == site.head { succ } else { s });
        }
    }
    if live[site.head as usize] {
        return None;
    }
    let mut to = Vec::new();
    for v in func.blocks[site.head as usize].inst_range.clone() {
        let Inst::Phi { incoming, .. } = &func.insts[v as usize] else {
            break;
        };
        to.push((v, incoming.iter().find(|&&(q, _)| q == p)?.1));
    }
    let dead = |v: ValueId| {
        block_of
            .get(v as usize)
            .is_some_and(|&b| b != BlockId::MAX && !live[b as usize])
    };
    let mut reads: Vec<ValueId> = Vec::new();
    for (b, block) in func.blocks.iter().enumerate().filter(|&(b, _)| live[b]) {
        for i in block.inst_range.clone() {
            match &func.insts[i as usize] {
                // `succ` takes over the branch block's edge from `p`.
                Inst::Phi { incoming, .. } => {
                    reads.extend(incoming.iter().filter_map(|&(q, v)| {
                        let q = if b as BlockId == succ && q == site.branch {
                            p
                        } else {
                            q
                        };
                        live[q as usize].then_some(v)
                    }))
                }
                inst => inst.for_each_operand(|v| reads.push(v)),
            }
        }
        block.terminator.for_each_operand(|v| reads.push(v));
        reads.push(block.exit_acc);
    }
    let mut wide = None;
    for v in reads.into_iter().filter(|&v| dead(v)) {
        let &(phi, w) = to.iter().find(|&&(phi, _)| phi == v)?;
        if !reads_alike(func, &mut wide, phi, w) {
            return None;
        }
    }
    Some(to)
}

/// Point every reader of each phi in `to` at its value.
fn forward(func: &mut FunctionSsa, to: &[(ValueId, ValueId)]) {
    let map = |v: &mut ValueId| {
        if let Some(&(_, w)) = to.iter().find(|&&(phi, _)| phi == *v) {
            *v = w;
        }
    };
    for inst in func.insts.iter_mut() {
        inst.for_each_operand_mut(map);
    }
    for block in func.blocks.iter_mut() {
        map(&mut block.exit_acc);
        block.terminator.for_each_operand_mut(map);
    }
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

    /// `b0` branches on a parameter into `b1` (0) or `b2` (`k`); `b3`
    /// merges them and branches on `cond`, a value it computes as `v4`.
    fn merge_tested(k: i64, cond: Inst) -> FunctionSsa {
        fresh(
            vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                Inst::Imm(0),
                Inst::Imm(k),
                phi(vec![(1, 1), (2, 2)]),
                cond,
            ],
            vec![
                block(
                    0..1,
                    Terminator::Bnz {
                        cond: 0,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(1..2, Terminator::Jmp(3)),
                block(2..3, Terminator::Jmp(3)),
                block(
                    3..5,
                    Terminator::Bnz {
                        cond: 4,
                        target: 5,
                        fall_through: 4,
                    },
                ),
                block(5..5, Terminator::Return(0)),
                block(5..5, Terminator::Return(0)),
            ],
        )
    }

    #[test]
    fn a_computation_of_the_merge_decides_each_edge() {
        let lt = Inst::BinopI {
            op: BinOp::Lt,
            lhs: 3,
            rhs_imm: 1,
        };
        let mut f = merge_tested(5, lt);
        assert!(run_one(&mut f));
        assert_eq!(f.blocks[1].terminator, Terminator::Jmp(5), "0 < 1");
        assert_eq!(f.blocks[2].terminator, Terminator::Jmp(4), "5 < 1 fails");
        // An extension reads the low word of 2^32 at the IR's width.
        let ext = Inst::Extend {
            value: 3,
            kind: LoadKind::I32,
            nsw: false,
        };
        let mut f = merge_tested(1 << 32, ext);
        assert!(run_one(&mut f));
        assert_eq!(f.blocks[2].terminator, Terminator::Jmp(4));
    }

    /// A loop entered from `b0` with `init`: `b1` tests `v2 < 16` for the
    /// body `b2`, which steps by the parameter; `b3` returns `ret`.
    fn counted(init: i64, ret: ValueId) -> FunctionSsa {
        fresh(
            vec![
                Inst::Imm(init),
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                phi(vec![(0, 0), (2, 4)]),
                Inst::BinopI {
                    op: BinOp::Lt,
                    lhs: 2,
                    rhs_imm: 16,
                },
                Inst::Binop {
                    op: BinOp::Add,
                    lhs: 2,
                    rhs: 1,
                },
            ],
            vec![
                block(0..2, Terminator::Jmp(1)),
                block(
                    2..4,
                    Terminator::Bnz {
                        cond: 3,
                        target: 2,
                        fall_through: 3,
                    },
                ),
                block(4..5, Terminator::Jmp(1)),
                block(5..5, Terminator::Return(ret)),
            ],
        )
    }

    #[test]
    fn a_loop_its_first_test_skips_dies_with_the_entry() {
        let mut f = counted(20, 2);
        assert!(run_one(&mut f));
        assert_eq!(f.blocks[0].terminator, Terminator::Jmp(3));
        // The phi read past the loop reads the entry's value.
        assert_eq!(f.blocks[3].terminator, Terminator::Return(0));
        assert!(super::super::prune_unreachable::run_one(&mut f));
        assert_eq!(f.blocks.len(), 2);
        // Entering the loop leaves the header reached: nothing moves.
        assert!(!run_one(&mut counted(0, 2)));
    }

    #[test]
    fn a_loop_that_outlives_its_entry_keeps_it() {
        // A second entry, from the parameter's arm.
        let mut f = counted(20, 2);
        f.blocks[0].terminator = Terminator::Bnz {
            cond: 1,
            target: 4,
            fall_through: 1,
        };
        f.insts.push(Inst::Imm(0));
        f.inst_src.push((0, 0));
        f.f32_values.push(false);
        f.blocks.push(block(5..6, Terminator::Jmp(1)));
        f.insts[2] = phi(vec![(0, 0), (2, 4), (4, 1)]);
        assert!(!run_one(&mut f));
        // The compare, not a phi, is read past the loop.
        assert!(!run_one(&mut counted(20, 3)));
    }

    #[test]
    fn a_float_read_past_the_loop_keeps_the_entry() {
        // b1 carries the counter v2 and a double v3 whose entry value is the
        // bit pattern of 1.0, an integer-file constant.
        let f = |ret: ValueId| {
            fresh(
                vec![
                    Inst::Imm(20),
                    Inst::Imm(0x3FF0_0000_0000_0000),
                    phi(vec![(0, 0), (2, 5)]),
                    Inst::Phi {
                        incoming: vec![(0, 1), (2, 3)],
                        kind: LoadKind::F64,
                    },
                    Inst::BinopI {
                        op: BinOp::Lt,
                        lhs: 2,
                        rhs_imm: 16,
                    },
                    Inst::BinopI {
                        op: BinOp::Add,
                        lhs: 2,
                        rhs_imm: 1,
                    },
                ],
                vec![
                    block(0..2, Terminator::Jmp(1)),
                    block(
                        2..5,
                        Terminator::Bnz {
                            cond: 4,
                            target: 2,
                            fall_through: 3,
                        },
                    ),
                    block(5..6, Terminator::Jmp(1)),
                    block(6..6, Terminator::Return(ret)),
                ],
            )
        };
        assert!(!run_one(&mut f(3)));
        assert!(run_one(&mut f(2)), "the counter reads alike");
    }

    #[test]
    fn a_loop_whose_test_writes_memory_keeps_its_entry() {
        let mut f = counted(20, 2);
        f.insts[4] = Inst::StoreLocal {
            off: -1,
            value: 2,
            kind: crate::c5::ir::StoreKind::I64,
            volatile: false,
            nsw: false,
        };
        f.blocks[1].inst_range = 2..5;
        f.blocks[2] = block(5..5, Terminator::Jmp(1));
        f.insts[2] = phi(vec![(0, 0), (2, 2)]);
        assert!(!run_one(&mut f));
    }
}
