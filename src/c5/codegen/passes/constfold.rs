//! Post-inline constant folding. The inliner substitutes call-site
//! immediates into callee bodies and materialises callee-narrows
//! extends on them (`splice_param_ref`), leaving `Extend(Imm)` /
//! `Binop(Imm, Imm)` / `BinopI(Imm, k)` chains no earlier stage
//! re-folds. Folding them lets the downstream matchers (`rotate`'s
//! constant-count arm, `constfold_branch`, the immediate-form
//! encoders) see plain `Inst::Imm` / `Inst::BinopI` shapes.
//!
//! Rewrites, in-place to a bounded fixed point:
//!   * `Extend { Imm }` -> `Imm` (sign-extended per kind);
//!   * `BinopI { int op, Imm lhs, k }` -> `Imm`;
//!   * `Binop { int op, Imm, Imm }` -> `Imm`;
//!   * `Binop { rhs = Imm }` -> `BinopI` for [`binopi_safe`] ops when
//!     the immediate encodes without a per-use scratch
//!     materialisation or the `Imm` def has no other use;
//!   * `Binop { lhs = Imm }` -> the rhs-imm form via commutation or
//!     compare mirroring, then the rule above.
//!
//! Only a plain integer `Inst::Imm` whose `f32_values` flag is clear
//! participates: `ImmData` / `ImmCode` / `ImmExtCode` / `BlockAddr` /
//! `TlsAddr` / `LocalAddr` resolve to addresses at emit time, and an
//! f32 `Imm` carries the low-32 bit pattern in the IR while the
//! evaluator's register convention is f64-widened. Division the
//! evaluator computes but native code traps on (`/ 0`,
//! `i64::MIN / -1`) is refused by `eval::fold_binop`, so folding
//! never changes runtime behavior.
//!
//! Blocks and terminators are untouched and every rewrite is
//! in-place, so `inst_src` / `f32_values` stay parallel. Operand
//! `Imm`s made dead are reaped by the emit's use-count DCE.

use crate::c5::codegen::ssa::reg_alloc::for_each_operand;
use crate::c5::ir::{BinOp, FunctionSsa, Inst, LoadKind, NO_VALUE, Terminator, ValueId};
use crate::c5::vm::eval;
use alloc::vec;
use alloc::vec::Vec;

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs {
        run_one(func);
    }
}

/// Bound on fold rounds. A round resolves every chain whose defs
/// precede their uses on the inst tape; further rounds only pick up
/// cross-block back-references, which converge in practice within
/// two.
const MAX_ROUNDS: usize = 4;

pub(crate) fn run_one(func: &mut FunctionSsa) {
    for _ in 0..MAX_ROUNDS {
        if !fold_round(func) {
            return;
        }
    }
}

/// Node budget for one per-incoming evaluation. A shared operand is
/// re-evaluated per use, so the budget caps a wide expression tree
/// rather than its depth alone; it also terminates the recursion.
const SELECT_EVAL_BUDGET: u32 = 96;

/// Evaluate `v` with `pivot` bound to `bind`, over the same integer
/// `Extend` / `BinopI` / `Binop` set [`fold_round`] folds. Any other
/// def, and any operand the shared resolver cannot pin to an integer
/// immediate, makes the value unknown.
fn eval_with(
    func: &FunctionSsa,
    v: ValueId,
    pivot: ValueId,
    bind: i64,
    budget: &mut u32,
) -> Option<i64> {
    *budget = budget.checked_sub(1)?;
    if v == pivot {
        return Some(bind);
    }
    if let Some(k) = imm_of(func, v) {
        return Some(k);
    }
    if matches!(func.f32_values.get(v as usize), Some(true)) {
        return None;
    }
    match *func.insts.get(v as usize)? {
        Inst::Extend { value, kind } => Some(eval::eval_extend(
            eval_with(func, value, pivot, bind, budget)?,
            kind,
        )),
        Inst::BinopI { op, lhs, rhs_imm } => {
            eval::fold_binop(op, eval_with(func, lhs, pivot, bind, budget)?, rhs_imm)
        }
        Inst::Binop { op, lhs, rhs } => {
            let l = eval_with(func, lhs, pivot, bind, budget)?;
            let r = eval_with(func, rhs, pivot, bind, budget)?;
            eval::fold_binop(op, l, r)
        }
        _ => None,
    }
}

/// The set of integer constants a phi can produce, when every incoming
/// resolves to one and they do not all agree. An all-agreeing phi is
/// already a constant to [`imm_of`], and an FP-kind phi carries a bit
/// pattern the integer evaluator must not compute on.
fn select_values(func: &FunctionSsa, v: ValueId) -> Option<Vec<i64>> {
    let Some(Inst::Phi { incoming, kind }) = func.insts.get(v as usize) else {
        return None;
    };
    if matches!(kind, LoadKind::F32 | LoadKind::F64) {
        return None;
    }
    let mut values = Vec::with_capacity(incoming.len());
    for &(_, iv) in incoming {
        values.push(imm_of(func, iv)?);
    }
    let differs = values.iter().any(|k| Some(k) != values.first());
    differs.then_some(values)
}

/// Per-value list of the instruction indices that read it. Terminator
/// and `exit_acc` references are left out: neither is a foldable
/// consumer.
fn user_lists(func: &FunctionSsa) -> Vec<Vec<ValueId>> {
    let mut users: Vec<Vec<ValueId>> = vec![Vec::new(); func.insts.len()];
    for (i, inst) in func.insts.iter().enumerate() {
        for_each_operand(inst, |op| {
            if let Some(slot) = users.get_mut(op as usize) {
                slot.push(i as ValueId);
            }
        });
    }
    users
}

/// Fold a consumer of a select whose result is the same for every value
/// the select can produce. A `c ? 1 : 0` merges two immediates, so
/// `> 3ul` on it is 0 and a mask selecting none of the bits the
/// incomings differ in is that mask's value on either -- the condition
/// stays unknown, the consumer does not depend on it. Walks forward from
/// each select so the cost tracks the select's use chain, and folds a
/// consumer any distance down that chain: an intermediate whose value
/// does differ per incoming is walked through, not folded.
///
/// -O only. A value produced by a runtime condition is not a constant
/// expression (C99 6.6), so this cannot decide what the front end
/// accepts; it is the optimizer proving the consumer invariant.
pub(crate) fn fold_selects(func: &mut FunctionSsa) -> bool {
    let selects: Vec<(ValueId, Vec<i64>)> = (0..func.insts.len() as ValueId)
        .filter_map(|v| select_values(func, v).map(|values| (v, values)))
        .collect();
    if selects.is_empty() {
        return false;
    }
    let users = user_lists(func);
    // Per-walk visited marks, stamped with the walk's index so the reset
    // between selects is free rather than a scan of the whole tape.
    let mut seen = vec![0u32; func.insts.len()];
    let mut queue: Vec<ValueId> = Vec::new();
    let mut changed = false;
    for (walk, (pivot, values)) in selects.iter().enumerate() {
        let stamp = walk as u32 + 1;
        queue.clear();
        queue.extend_from_slice(&users[*pivot as usize]);
        while let Some(u) = queue.pop() {
            if core::mem::replace(&mut seen[u as usize], stamp) == stamp {
                continue;
            }
            if !matches!(
                func.insts[u as usize],
                Inst::Extend { .. } | Inst::BinopI { .. } | Inst::Binop { .. }
            ) {
                continue;
            }
            if !matches!(func.f32_values.get(u as usize), Some(true)) {
                let mut uniform = None;
                for &bind in values {
                    let mut budget = SELECT_EVAL_BUDGET;
                    match eval_with(func, u, *pivot, bind, &mut budget) {
                        Some(k) if uniform.is_none_or(|prev| prev == k) => uniform = Some(k),
                        _ => {
                            uniform = None;
                            break;
                        }
                    }
                }
                if let Some(k) = uniform {
                    func.insts[u as usize] = Inst::Imm(k);
                    changed = true;
                }
            }
            queue.extend_from_slice(&users[u as usize]);
        }
    }
    changed
}

/// Resolve every remaining deferred `__builtin_constant_p` to 0. Called
/// once the branch-fold fixed point stalls: no later pass discovers new
/// constants, so an operand still not an immediate never becomes one.
pub(crate) fn resolve_constant_p(func: &mut FunctionSsa) -> bool {
    let kind_id = crate::c5::op::Intrinsic::ConstantP as i64;
    let mut changed = false;
    for inst in &mut func.insts {
        if matches!(inst, Inst::Intrinsic { kind, .. } if *kind == kind_id) {
            *inst = Inst::Imm(0);
            changed = true;
        }
    }
    changed
}

/// Ops both per-arch emitters lower in `BinopI` form. The x86_64
/// `emit_binop_imm` panics on Div / Divu / Mod / Modu; the aarch64
/// one bails on Mod / Modu (no third scratch register). FP ops keep
/// register operands. Everything else has an immediate-form arm in
/// both emitters.
fn binopi_safe(op: BinOp) -> bool {
    matches!(
        op,
        BinOp::Add
            | BinOp::Sub
            | BinOp::Mul
            | BinOp::And
            | BinOp::Or
            | BinOp::Xor
            | BinOp::Shl
            | BinOp::Shr
            | BinOp::Shru
            | BinOp::Ror
            | BinOp::Eq
            | BinOp::Ne
            | BinOp::Lt
            | BinOp::Gt
            | BinOp::Le
            | BinOp::Ge
            | BinOp::Ult
            | BinOp::Ugt
            | BinOp::Ule
            | BinOp::Uge
    )
}

/// Whether `op` with immediate `imm` encodes in both per-arch
/// emitters without a per-use scratch materialisation of the
/// immediate. Derived from the two `emit_binop_imm` peephole sets:
/// shifts embed a 6-bit count, add/sub take imm12 (aarch64) / imm32
/// (x86_64), compares cmp-imm12 / cmp-imm32, mul lowers to a
/// shift-by-log2; `And 0xffffffff` and `Xor -1` have dedicated
/// single-instruction forms. Anything else loads the immediate into
/// a scratch register at every use, so rewriting a shared immediate
/// operand would duplicate its materialisation.
fn imm_encodes_free(op: BinOp, imm: i64) -> bool {
    match op {
        BinOp::Shl | BinOp::Shr | BinOp::Shru | BinOp::Ror => (0..64).contains(&imm),
        BinOp::Add | BinOp::Sub => imm.unsigned_abs() < 4096,
        BinOp::Mul => imm > 0 && (imm as u64).is_power_of_two(),
        BinOp::And => imm == 0xffff_ffff,
        BinOp::Xor => imm == -1,
        BinOp::Eq
        | BinOp::Ne
        | BinOp::Lt
        | BinOp::Gt
        | BinOp::Le
        | BinOp::Ge
        | BinOp::Ult
        | BinOp::Ugt
        | BinOp::Ule
        | BinOp::Uge => (0..4096).contains(&imm),
        _ => false,
    }
}

/// `imm OP x` recast as `x OP' imm`: the op itself for commutative
/// ops, the mirrored comparison for ordered compares. `None` for the
/// non-commutative rest (Sub, shifts, division, FP).
fn mirror(op: BinOp) -> Option<BinOp> {
    Some(match op {
        BinOp::Add | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor | BinOp::Eq | BinOp::Ne => op,
        BinOp::Lt => BinOp::Gt,
        BinOp::Gt => BinOp::Lt,
        BinOp::Le => BinOp::Ge,
        BinOp::Ge => BinOp::Le,
        BinOp::Ult => BinOp::Ugt,
        BinOp::Ugt => BinOp::Ult,
        BinOp::Ule => BinOp::Uge,
        BinOp::Uge => BinOp::Ule,
        _ => return None,
    })
}

/// Resolve `v` to its integer constant when its def is a plain
/// `Inst::Imm` not flagged f32. Out-of-range ids (`NO_VALUE`) and
/// address-bearing immediates resolve to `None`.
fn imm_of(func: &FunctionSsa, v: ValueId) -> Option<i64> {
    imm_through_phis(&func.insts, &func.f32_values, v)
}

/// Recursion budget for the multi-incoming phi merge. Each level
/// multiplies by the operand count, so the bound keeps the walk cheap
/// while still crossing the few merges a folded control-flow chain
/// stacks up.
const PHI_MERGE_DEPTH: u32 = 4;

/// Shared constant resolver: names an `Inst::Imm`, or reaches one
/// through phis. An empty `f32_values` accepts every `Imm`, for callers
/// with no float-immediate distinction to make.
pub(super) fn imm_through_phis(insts: &[Inst], f32_values: &[bool], v: ValueId) -> Option<i64> {
    imm_through_phis_depth(insts, f32_values, v, PHI_MERGE_DEPTH)
}

fn imm_through_phis_depth(
    insts: &[Inst],
    f32_values: &[bool],
    v: ValueId,
    depth: u32,
) -> Option<i64> {
    let mut i = v as usize;
    // Chase single-incoming (degenerate) phis to the constant they
    // collapse to: such a phi always takes its one predecessor's value.
    // prune_unreachable produces them when it drops a folded branch's
    // dead predecessor, so folding through them lets a chain built on the
    // survivor (an `Extend`, a `BinopI`) resolve on the next round.
    for _ in 0..insts.len() {
        match insts.get(i)? {
            Inst::Imm(k) if !matches!(f32_values.get(i), Some(true)) => return Some(*k),
            Inst::Phi { incoming, .. } if incoming.len() == 1 => {
                i = incoming[0].1 as usize;
            }
            // Every predecessor supplying the same constant makes the
            // merge that constant, whichever edge is taken. A `&&` / `||`
            // whose arms decide the same way reaches the fold in this
            // shape, as does any merge of equal constants an inline
            // exposed. The depth bound also terminates a loop phi, whose
            // back edge reaches itself.
            Inst::Phi { incoming, .. } => {
                if depth == 0 {
                    return None;
                }
                let mut vals = incoming
                    .iter()
                    .map(|&(_, v)| imm_through_phis_depth(insts, f32_values, v, depth - 1));
                let first = vals.next()??;
                return vals.all(|k| k == Some(first)).then_some(first);
            }
            _ => return None,
        }
    }
    None
}

/// Operand-reference counts, including terminator conditions and the
/// per-block `exit_acc`. Counts taken at round start over-approximate
/// after in-round rewrites drop references, which only defers a
/// single-use rewrite to the next round.
fn count_uses(func: &FunctionSsa) -> Vec<u32> {
    let n = func.insts.len();
    let mut counts = vec![0u32; n];
    let bump = |counts: &mut Vec<u32>, v: ValueId| {
        if v != NO_VALUE && (v as usize) < n {
            counts[v as usize] += 1;
        }
    };
    for inst in &func.insts {
        for_each_operand(inst, |op| bump(&mut counts, op));
        if let Inst::CallIndirect { target, .. } = inst {
            bump(&mut counts, *target);
        }
    }
    for block in &func.blocks {
        match block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => bump(&mut counts, cond),
            Terminator::Return(v) => bump(&mut counts, v),
            Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. } => {
                bump(&mut counts, target)
            }
            _ => {}
        }
        bump(&mut counts, block.exit_acc);
    }
    counts
}

fn fold_round(func: &mut FunctionSsa) -> bool {
    let uses = count_uses(func);
    // A shared immediate operand only moves into the instruction when
    // the encoding is materialisation-free; a sole use may always
    // move (the per-use materialisation replaces the def's).
    let to_imm_form = |op: BinOp, value_id: ValueId, imm: i64| -> bool {
        binopi_safe(op)
            && (imm_encodes_free(op, imm) || uses.get(value_id as usize).copied().unwrap_or(0) == 1)
    };
    let mut changed = false;
    for idx in 0..func.insts.len() {
        if matches!(func.f32_values.get(idx), Some(true)) {
            continue;
        }
        let new_inst = match &func.insts[idx] {
            Inst::Extend { value, kind } => {
                imm_of(func, *value).map(|k| Inst::Imm(eval::eval_extend(k, *kind)))
            }
            Inst::BinopI { op, lhs, rhs_imm } => imm_of(func, *lhs)
                .and_then(|l| eval::fold_binop(*op, l, *rhs_imm))
                .map(Inst::Imm),
            Inst::Binop { op, lhs, rhs } => match (imm_of(func, *lhs), imm_of(func, *rhs)) {
                (Some(l), Some(r)) => eval::fold_binop(*op, l, r).map(Inst::Imm),
                (None, Some(r)) if to_imm_form(*op, *rhs, r) => Some(Inst::BinopI {
                    op: *op,
                    lhs: *lhs,
                    rhs_imm: r,
                }),
                (Some(l), None) => {
                    mirror(*op)
                        .filter(|m| to_imm_form(*m, *lhs, l))
                        .map(|m| Inst::BinopI {
                            op: m,
                            lhs: *rhs,
                            rhs_imm: l,
                        })
                }
                _ => None,
            },
            // Deferred `__builtin_constant_p`: the operand folded to an
            // integer immediate, so the answer is 1. `imm_of` refuses
            // address-bearing immediates, which are not constants here.
            Inst::Intrinsic { kind, args }
                if *kind == crate::c5::op::Intrinsic::ConstantP as i64 =>
            {
                args.first()
                    .and_then(|&a| imm_of(func, a))
                    .map(|_| Inst::Imm(1))
            }
            _ => None,
        };
        if let Some(inst) = new_inst {
            func.insts[idx] = inst;
            changed = true;
        }
    }
    changed
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{Block, LoadKind, Terminator};
    use alloc::vec;
    use alloc::vec::Vec;

    fn fresh(insts: Vec<Inst>) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            has_returns_twice_call: false,
            did_unroll: false,
            did_inline: false,
            n_params: 0,
            is_variadic: false,
            is_inline: false,
            is_always_inline: false,
            is_naked: false,
            inst_src: vec![(0, 0); n],
            f32_values: vec![false; n],
            param_fp_mask: 0,
            agg_descs: Vec::new(),
            param_aggs: Vec::new(),
            param_local_slots: Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            ret_type_tag: 0,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            jump_tables: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
            over_aligned: Default::default(),
            frame_align: 0,
            realign_region_bytes: 0,
            insts,
            blocks: vec![Block {
                start_pc: 0,
                inst_range: 0..n as u32,
                terminator: Terminator::Return(crate::c5::ir::NO_VALUE),
                exit_acc: 0,
            }],
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        }
    }

    #[test]
    fn binop_of_two_imms_folds() {
        let mut f = fresh(vec![
            Inst::Imm(2),
            Inst::Imm(3),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(f.insts[2], Inst::Imm(5)));
    }

    #[test]
    fn chain_through_extend_folds_in_one_run() {
        // Post-inline shape: Imm -> callee-narrows Extend -> shift.
        let mut f = fresh(vec![
            Inst::Imm(0xff),
            Inst::Extend {
                value: 0,
                kind: LoadKind::I8,
            },
            Inst::BinopI {
                op: BinOp::Mul,
                lhs: 1,
                rhs_imm: 2,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(f.insts[1], Inst::Imm(-1)));
        assert!(matches!(f.insts[2], Inst::Imm(-2)));
    }

    #[test]
    fn div_mod_by_zero_is_refused() {
        for op in [BinOp::Div, BinOp::Mod, BinOp::Divu, BinOp::Modu] {
            let mut f = fresh(vec![
                Inst::Imm(7),
                Inst::Imm(0),
                Inst::Binop { op, lhs: 0, rhs: 1 },
            ]);
            run_one(&mut f);
            assert!(matches!(f.insts[2], Inst::Binop { .. }), "{op:?}");
        }
    }

    #[test]
    fn min_over_minus_one_is_refused() {
        for op in [BinOp::Div, BinOp::Mod] {
            let mut f = fresh(vec![
                Inst::Imm(i64::MIN),
                Inst::Imm(-1),
                Inst::Binop { op, lhs: 0, rhs: 1 },
            ]);
            run_one(&mut f);
            assert!(matches!(f.insts[2], Inst::Binop { .. }), "{op:?}");
        }
    }

    #[test]
    fn rhs_imm_rewrites_to_binopi_for_safe_ops() {
        let mut f = fresh(vec![
            Inst::LocalAddr(0),
            Inst::Imm(9),
            Inst::Binop {
                op: BinOp::Shru,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(
            f.insts[2],
            Inst::BinopI {
                op: BinOp::Shru,
                lhs: 0,
                rhs_imm: 9,
            }
        ));
    }

    #[test]
    fn div_mod_never_rewrite_to_binopi() {
        // Pins BINOPI_SAFE to the emitters' coverage: the x86_64
        // BinopI arm panics on Div / Divu / Mod / Modu and the
        // aarch64 arm bails on Mod / Modu.
        for op in [BinOp::Div, BinOp::Divu, BinOp::Mod, BinOp::Modu] {
            assert!(!binopi_safe(op), "{op:?}");
            let mut f = fresh(vec![
                Inst::LocalAddr(0),
                Inst::Imm(2),
                Inst::Binop { op, lhs: 0, rhs: 1 },
            ]);
            run_one(&mut f);
            assert!(matches!(f.insts[2], Inst::Binop { .. }), "{op:?}");
        }
        for op in [
            BinOp::Fadd,
            BinOp::Fsub,
            BinOp::Fmul,
            BinOp::Fdiv,
            BinOp::Feq,
            BinOp::Fne,
            BinOp::Flt,
            BinOp::Fgt,
            BinOp::Fle,
            BinOp::Fge,
        ] {
            assert!(!binopi_safe(op), "{op:?}");
        }
        for op in [
            BinOp::Add,
            BinOp::Sub,
            BinOp::Mul,
            BinOp::And,
            BinOp::Or,
            BinOp::Xor,
            BinOp::Shl,
            BinOp::Shr,
            BinOp::Shru,
            BinOp::Ror,
            BinOp::Eq,
            BinOp::Ne,
            BinOp::Lt,
            BinOp::Gt,
            BinOp::Le,
            BinOp::Ge,
            BinOp::Ult,
            BinOp::Ugt,
            BinOp::Ule,
            BinOp::Uge,
        ] {
            assert!(binopi_safe(op), "{op:?}");
        }
    }

    #[test]
    fn lhs_imm_commutes_and_mirrors() {
        // 5 + x -> x + 5.
        let mut f = fresh(vec![
            Inst::Imm(5),
            Inst::LocalAddr(0),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(
            f.insts[2],
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 1,
                rhs_imm: 5,
            }
        ));
        // 5 < x -> x > 5.
        let mut f = fresh(vec![
            Inst::Imm(5),
            Inst::LocalAddr(0),
            Inst::Binop {
                op: BinOp::Lt,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(
            f.insts[2],
            Inst::BinopI {
                op: BinOp::Gt,
                lhs: 1,
                rhs_imm: 5,
            }
        ));
        // 5 - x has no rhs-imm form; it must stay put.
        let mut f = fresh(vec![
            Inst::Imm(5),
            Inst::LocalAddr(0),
            Inst::Binop {
                op: BinOp::Sub,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(f.insts[2], Inst::Binop { op: BinOp::Sub, .. }));
    }

    #[test]
    fn f32_flagged_imm_does_not_fold() {
        // An f32 Imm carries the low-32 bit pattern; folding it with
        // the f64-widened evaluator convention would corrupt it.
        let mut f = fresh(vec![
            Inst::Imm(0x3f80_0000),
            Inst::Extend {
                value: 0,
                kind: LoadKind::I32,
            },
        ]);
        f.f32_values[0] = true;
        run_one(&mut f);
        assert!(matches!(f.insts[1], Inst::Extend { .. }));
    }

    #[test]
    fn address_imms_do_not_fold() {
        // ImmData is a data-segment offset patched at write time, not
        // an integer constant; it must survive as the BinopI operand.
        let mut f = fresh(vec![
            Inst::ImmData(64),
            Inst::Imm(8),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(f.insts[0], Inst::ImmData(64)));
        assert!(matches!(
            f.insts[2],
            Inst::BinopI {
                op: BinOp::Add,
                lhs: 0,
                rhs_imm: 8,
            }
        ));
    }

    #[test]
    fn shared_wide_imm_keeps_register_form() {
        // A scratch-materialised immediate (Xor with a wide constant)
        // shared by two ops must stay a register operand: rewriting
        // both would duplicate the constant materialisation per use.
        let mut f = fresh(vec![
            Inst::LocalAddr(0),
            Inst::Imm(0x0123_4567_89ab_cdef),
            Inst::Binop {
                op: BinOp::Xor,
                lhs: 0,
                rhs: 1,
            },
            Inst::Binop {
                op: BinOp::Xor,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(f.insts[2], Inst::Binop { .. }));
        assert!(matches!(f.insts[3], Inst::Binop { .. }));
    }

    #[test]
    fn single_use_wide_imm_rewrites() {
        let mut f = fresh(vec![
            Inst::LocalAddr(0),
            Inst::Imm(0x0123_4567_89ab_cdef),
            Inst::Binop {
                op: BinOp::Xor,
                lhs: 0,
                rhs: 1,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(
            f.insts[2],
            Inst::BinopI {
                op: BinOp::Xor,
                lhs: 0,
                rhs_imm: 0x0123_4567_89ab_cdef,
            }
        ));
    }

    #[test]
    fn extend_of_imm_folds_per_kind() {
        let mut f = fresh(vec![
            Inst::Imm(0x1_8000),
            Inst::Extend {
                value: 0,
                kind: LoadKind::I16,
            },
        ]);
        run_one(&mut f);
        assert!(matches!(f.insts[1], Inst::Imm(-32768)));
    }

    /// `phi(1, 0)` at index 2, with `insts[3..]` as the consumers under test.
    fn with_select(mut consumers: Vec<Inst>) -> FunctionSsa {
        let mut insts = vec![
            Inst::Imm(1),
            Inst::Imm(0),
            Inst::Phi {
                incoming: vec![(0, 0), (1, 1)],
                kind: LoadKind::I64,
            },
        ];
        insts.append(&mut consumers);
        fresh(insts)
    }

    #[test]
    fn select_invariant_comparison_folds() {
        // Both incomings are <= 3, so `ugt 3` is 0 either way. The select
        // itself is left alone: its value does depend on the condition.
        let mut f = with_select(vec![Inst::BinopI {
            op: BinOp::Ugt,
            lhs: 2,
            rhs_imm: 3,
        }]);
        assert!(fold_selects(&mut f));
        assert!(matches!(f.insts[3], Inst::Imm(0)));
        assert!(matches!(f.insts[2], Inst::Phi { .. }));
    }

    #[test]
    fn select_variant_consumer_is_left_alone() {
        // `+ 1` is 2 or 1: the consumer does depend on the condition.
        let mut f = with_select(vec![Inst::BinopI {
            op: BinOp::Add,
            lhs: 2,
            rhs_imm: 1,
        }]);
        assert!(!fold_selects(&mut f));
        assert!(matches!(f.insts[3], Inst::BinopI { .. }));
    }

    #[test]
    fn select_invariant_mask_folds_through_a_variant_chain() {
        // The `or` intermediates differ per incoming (5 / 4), so they are
        // walked through rather than folded; the mask over them selects
        // no bit either can set, so it folds.
        let mut f = with_select(vec![
            Inst::BinopI {
                op: BinOp::Or,
                lhs: 2,
                rhs_imm: 4,
            },
            Inst::BinopI {
                op: BinOp::And,
                lhs: 3,
                rhs_imm: 0x1_8000,
            },
        ]);
        assert!(fold_selects(&mut f));
        assert!(matches!(f.insts[3], Inst::BinopI { op: BinOp::Or, .. }));
        assert!(matches!(f.insts[4], Inst::Imm(0)));
    }

    #[test]
    fn select_with_a_non_constant_incoming_is_refused() {
        // A loop-carried phi has an incoming that is not an immediate, so
        // the set of values it can take is unknown.
        let mut f = fresh(vec![
            Inst::Imm(1),
            Inst::Load {
                addr: 0,
                disp: 0,
                kind: LoadKind::I64,
                volatile: false,
            },
            Inst::Phi {
                incoming: vec![(0, 0), (1, 1)],
                kind: LoadKind::I64,
            },
            Inst::BinopI {
                op: BinOp::Ugt,
                lhs: 2,
                rhs_imm: 3,
            },
        ]);
        assert!(!fold_selects(&mut f));
        assert!(matches!(f.insts[3], Inst::BinopI { .. }));
    }

    #[test]
    fn fp_kind_select_is_refused() {
        // An F64 phi merges bit patterns; the integer evaluator must not
        // compute on them.
        let mut f = fresh(vec![
            Inst::Imm(1),
            Inst::Imm(0),
            Inst::Phi {
                incoming: vec![(0, 0), (1, 1)],
                kind: LoadKind::F64,
            },
            Inst::BinopI {
                op: BinOp::Ugt,
                lhs: 2,
                rhs_imm: 3,
            },
        ]);
        assert!(!fold_selects(&mut f));
    }
}
