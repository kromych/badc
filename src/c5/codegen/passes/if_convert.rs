//! If-conversion: a branch around one short arm, or between two, whose
//! join only merges values becomes straight-line code choosing them with
//! `Inst::Select`. An arm holds at most [`ARM_INSTS`] live integer
//! instructions that read no memory and cannot trap; the join merges the
//! two edges through at most [`JOIN_PHIS`] phis, none floating on x86-64,
//! which has no floating conditional move.

use alloc::vec::Vec;

use super::prune_unreachable;
use crate::c5::codegen::Target;
use crate::c5::codegen::ssa::mem2reg::predecessors;
use crate::c5::codegen::ssa::tape::{self, At, Insertion};
use crate::c5::ir::{
    BinOp, BlockId, FunctionSsa, Inst, LoadKind, NO_VALUE, Terminator, ValueId, is_comparison_op,
};

/// Instructions an arm runs unconditionally in place of the branch.
const ARM_INSTS: usize = 2;

/// Values a join may merge.
const JOIN_PHIS: usize = 2;

/// A join's phi, the values its select takes when the condition holds
/// and when it does not, and their kind.
type Pick = (ValueId, ValueId, ValueId, LoadKind);

pub(crate) fn run(funcs: &mut [FunctionSsa], target: Target) {
    for func in funcs {
        let mut changed = false;
        while convert_one(func, target) {
            changed = true;
        }
        if changed {
            prune_unreachable::run_one(func);
        }
    }
}

/// An integer value from its operands alone, which cannot trap.
fn speculable(inst: &Inst) -> bool {
    use crate::c5::ir::{is_divmod_op, is_fp_op};
    match *inst {
        Inst::Imm(_) | Inst::Extend { .. } | Inst::ShiftOp { .. } | Inst::Neg(_) => true,
        Inst::Copy { is_fp, .. } => !is_fp,
        Inst::Binop { op, .. } | Inst::BinopI { op, .. } => !is_divmod_op(op) && !is_fp_op(op),
        _ => false,
    }
}

/// A condition a select reads off the flags: a comparison or a mask.
pub(crate) fn flags_condition(inst: &Inst) -> bool {
    match *inst {
        Inst::BinopI { op: BinOp::And, .. } => true,
        Inst::Binop { op, .. } | Inst::BinopI { op, .. } => is_comparison_op(op),
        _ => false,
    }
}

/// The values of arm block `b` that something reads.
fn live_values(func: &FunctionSsa, uses: &[u32], b: BlockId) -> Vec<ValueId> {
    (func.blocks[b as usize].inst_range.clone())
        .filter(|&v| uses.get(v as usize).copied().unwrap_or(0) > 0)
        .collect()
}

/// The join arm block `b` jumps to, when `head` alone reaches it and its
/// work may run unconditionally.
fn arm_join(
    func: &FunctionSsa,
    preds: &[Vec<BlockId>],
    uses: &[u32],
    head: BlockId,
    b: BlockId,
) -> Option<BlockId> {
    let block = &func.blocks[b as usize];
    let Terminator::Jmp(join) = block.terminator else {
        return None;
    };
    let live = live_values(func, uses, b);
    let pure = (block.inst_range.clone()).all(|v| {
        let inst = &func.insts[v as usize];
        speculable(inst) || (inst.is_pure() && !live.contains(&v))
    });
    (preds[b as usize] == [head] && live.len() <= ARM_INSTS && pure).then_some(join)
}

/// Convert the first qualifying branch; whether one was converted.
fn convert_one(func: &mut FunctionSsa, target: Target) -> bool {
    let preds = predecessors(func);
    let uses = crate::c5::codegen::ssa::reg_alloc::compute_use_counts(func);
    for head in 0..func.blocks.len() as BlockId {
        let (cond, on_true, on_false) = match func.blocks[head as usize].terminator {
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => (cond, target, fall_through),
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => (cond, fall_through, target),
            _ => continue,
        };
        if on_true == on_false || on_true == head || on_false == head {
            continue;
        }
        // Both successors arms of one join, or one an arm of the other.
        let t_join = arm_join(func, &preds, &uses, head, on_true);
        let f_join = arm_join(func, &preds, &uses, head, on_false);
        let (arms, join, from_true, from_false) = match (t_join, f_join) {
            (Some(j), Some(k)) if j == k => (alloc::vec![on_true, on_false], j, on_true, on_false),
            (Some(j), _) if j == on_false => (alloc::vec![on_true], j, on_true, head),
            (_, Some(k)) if k == on_true => (alloc::vec![on_false], k, head, on_false),
            _ => continue,
        };
        let mut join_preds = preds[join as usize].clone();
        join_preds.sort_unstable();
        let mut want = alloc::vec![from_true, from_false];
        want.sort_unstable();
        if join_preds != want || join == head {
            continue;
        }
        let jrange = func.blocks[join as usize].inst_range.clone();
        // A phi nothing reads makes its incomes dead too, so an arm may
        // leave them uncopied: it takes no select.
        let (phis, dead): (Vec<ValueId>, Vec<ValueId>) = (jrange.clone())
            .take_while(|&v| matches!(func.insts[v as usize], Inst::Phi { .. }))
            .partition(|&v| uses.get(v as usize).copied().unwrap_or(0) > 0);
        if phis.is_empty() || phis.len() > JOIN_PHIS {
            continue;
        }
        let incoming = |phi: ValueId, from: BlockId| match &func.insts[phi as usize] {
            Inst::Phi { incoming, .. } => incoming.iter().find(|e| e.0 == from).map(|e| e.1),
            _ => None,
        };
        let mut picks: Vec<Pick> = Vec::new();
        for &phi in &phis {
            let Inst::Phi { kind, .. } = func.insts[phi as usize] else {
                unreachable!()
            };
            let fp = matches!(kind, LoadKind::F32 | LoadKind::F64);
            if fp && target.is_x86_64()
                || !matches!(kind, LoadKind::I64 | LoadKind::F32 | LoadKind::F64)
            {
                picks.clear();
                break;
            }
            match (incoming(phi, from_true), incoming(phi, from_false)) {
                (Some(a), Some(b)) => picks.push((phi, a, b, kind)),
                _ => {
                    picks.clear();
                    break;
                }
            }
        }
        if picks.len() != phis.len() {
            continue;
        }
        let arm_values: Vec<ValueId> = arms
            .iter()
            .flat_map(|&b| live_values(func, &uses, b))
            .collect();
        let tail = condition_tail(func, &uses, head, cond);
        apply(func, head, cond, &arm_values, join, (&picks, &dead), &tail);
        return true;
    }
    false
}

/// What follows the arms' copies at the end of `head`, so the condition's
/// flags reach the selects: a condition only the branch reads, after a
/// load only it reads where nothing in `head` past the load writes memory,
/// which a select may then read in its compare.
fn condition_tail(func: &FunctionSsa, uses: &[u32], head: BlockId, cond: ValueId) -> Vec<ValueId> {
    let inst = &func.insts[cond as usize];
    if uses.get(cond as usize) != Some(&1) || !flags_condition(inst) {
        return Vec::new();
    }
    let range = func.blocks[head as usize].inst_range.clone();
    let lhs = match *inst {
        Inst::Binop { lhs, .. } | Inst::BinopI { lhs, .. } => lhs,
        _ => NO_VALUE,
    };
    let plain_load = matches!(
        func.insts.get(lhs as usize),
        Some(
            Inst::Load {
                volatile: false,
                ..
            } | Inst::LoadLocal {
                volatile: false,
                ..
            } | Inst::LoadIndexed { .. }
        )
    );
    let moves = plain_load
        && uses.get(lhs as usize) == Some(&1)
        && range.contains(&lhs)
        && (lhs + 1..range.end).all(|v| !func.insts[v as usize].may_write_memory());
    if moves {
        alloc::vec![lhs, cond]
    } else {
        alloc::vec![cond]
    }
}

/// Copy the arms' values to the end of `head`, then the condition's tail
/// ([`condition_tail`]), then the selects.
fn apply(
    func: &mut FunctionSsa,
    head: BlockId,
    cond: ValueId,
    arm_values: &[ValueId],
    join: BlockId,
    (picks, dead): (&[Pick], &[ValueId]),
    tail: &[ValueId],
) {
    let n_old = func.insts.len() as ValueId;
    let hrange = func.blocks[head as usize].inst_range.clone();
    let at = if hrange.is_empty() {
        At::Empty(head)
    } else {
        At::After(hrange.end - 1)
    };
    // A copied value's readers name its copy, an insertion past the tape.
    let mut copies: Vec<(ValueId, ValueId)> = Vec::new();
    let mut ins: Vec<Insertion> = Vec::new();
    for &v in arm_values.iter().chain(tail) {
        let mut inst = func.insts[v as usize].clone();
        inst.for_each_operand_mut(|o| {
            if let Some(&(_, c)) = copies.iter().find(|e| e.0 == *o) {
                *o = c;
            }
        });
        copies.push((v, n_old + ins.len() as ValueId));
        ins.push(Insertion {
            at,
            inst,
            is_f32: func.f32_values.get(v as usize).copied().unwrap_or(false),
            copy_of: Some(v),
        });
    }
    let mapped = |v: ValueId| copies.iter().find(|e| e.0 == v).map_or(v, |e| e.1);
    let first_select = ins.len();
    for &(phi, a, b, kind) in picks {
        ins.push(Insertion {
            at,
            inst: Inst::Select {
                cond: mapped(cond),
                a: mapped(a),
                b: mapped(b),
                kind,
            },
            is_f32: func.f32_values.get(phi as usize).copied().unwrap_or(false),
            copy_of: None,
        });
    }
    let rewrite = tape::insert(func, &ins);
    for &phi in dead {
        func.insts[rewrite.remap[phi as usize] as usize] = Inst::Imm(0);
    }
    // The phis' readers read the selects; each phi is left an unread copy.
    let mut to: Vec<(ValueId, ValueId)> = Vec::with_capacity(picks.len());
    for (k, &(phi, _, _, kind)) in picks.iter().enumerate() {
        let at = rewrite.remap[phi as usize];
        let select = rewrite.ids[first_select + k];
        func.insts[at as usize] = Inst::Copy {
            value: select,
            is_fp: matches!(kind, LoadKind::F32 | LoadKind::F64),
        };
        to.push((at, select));
    }
    let redirect = |o: &mut ValueId| {
        if let Some(&(_, s)) = to.iter().find(|e| e.0 == *o) {
            *o = s;
        }
    };
    for inst in func.insts.iter_mut() {
        if !matches!(inst, Inst::Copy { value, .. } if to.iter().any(|e| e.1 == *value)) {
            inst.for_each_operand_mut(redirect);
        }
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE {
            redirect(&mut block.exit_acc);
        }
        block.terminator.for_each_operand_mut(redirect);
    }
    let block = &mut func.blocks[head as usize];
    block.terminator = Terminator::Jmp(join);
    if block.exit_acc == cond {
        block.exit_acc = NO_VALUE;
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{Block, InstSrc};

    fn block(inst_range: core::ops::Range<u32>, terminator: Terminator) -> Block {
        Block {
            start_pc: 0,
            inst_range,
            terminator,
            exit_acc: NO_VALUE,
        }
    }

    fn load(addr: ValueId, disp: i32) -> Inst {
        Inst::Load {
            addr,
            disp,
            kind: LoadKind::I64,
            volatile: false,
            align: 0,
            pc_rel: false,
        }
    }

    /// A join's phi nothing reads takes no select: its incomes, loads the
    /// use counts call dead and the arms keep, go with the arms, and the
    /// live phi alone becomes a select.
    #[test]
    fn a_phi_nothing_reads_takes_no_select() {
        let param = |idx| Inst::ParamRef {
            idx,
            kind: LoadKind::I64,
        };
        let phi = |a, b| Inst::Phi {
            incoming: alloc::vec![(1, a), (2, b)],
            kind: LoadKind::I64,
        };
        let insts = alloc::vec![
            param(0),
            param(1),
            Inst::BinopI {
                op: BinOp::And,
                lhs: 1,
                rhs_imm: 2,
            },
            Inst::Imm(255),
            load(0, 0),
            Inst::Imm(0),
            load(0, 8),
            phi(3, 5),
            phi(4, 6),
        ];
        let n = insts.len();
        let mut f = FunctionSsa {
            inst_src: alloc::vec![InstSrc::default(); n],
            f32_values: alloc::vec![false; n],
            insts,
            blocks: alloc::vec![
                block(
                    0..3,
                    Terminator::Bz {
                        cond: 2,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(3..5, Terminator::Jmp(3)),
                block(5..7, Terminator::Jmp(3)),
                block(7..9, Terminator::Return(7)),
            ],
            ..Default::default()
        };
        run(core::slice::from_mut(&mut f), Target::LinuxAarch64);
        assert_eq!(crate::c5::codegen::ssa::verify::check(&f), Ok(()));
        let selects = f.insts.iter().filter(|i| matches!(i, Inst::Select { .. }));
        assert_eq!(selects.count(), 1);
    }
}
