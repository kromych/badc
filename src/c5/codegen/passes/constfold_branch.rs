//! Fold conditional branches whose outcome is already decided.
//!
//! Walks every block's terminator. When the condition of a
//! `Terminator::Bz` or `Terminator::Bnz` is known zero or known
//! non-zero, replace the terminator with an unconditional
//! `Terminator::Jmp` to whichever successor that selects. An
//! `Inst::Imm` decides directly; a phi decides when every predecessor
//! agrees, counting the edge a short-circuit operand arrives on (see
//! `truthy`), which needs no constant to be materialised.
//!
//! The per-arch emit otherwise materialises the constant condition
//! into a register and emits a conditional branch; when the
//! parallel-copy phi-moves emitted at the predecessor exit happen
//! to target the same register the condition occupies, the
//! condition is clobbered before the branch reads it. Folding the
//! branch removes both the wasted compare-and-branch and the
//! register-overlap hazard.
//!
//! Folding a terminator only makes code unreachable, but after
//! `prune_unreachable` drops the not-taken predecessor a merge phi can
//! collapse to a single incoming, exposing a fresh constant condition
//! downstream. `fold` therefore reads a merge of equal constants, one
//! incoming included, and the driver in [`super::simplify_branches`]
//! alternates this pass with the prune to a fixed point.

use crate::c5::ir::{BlockId, FunctionSsa, Inst, Terminator};

/// Fold every constant-condition terminator in `func`. Returns whether
/// any terminator changed, so a driver can iterate with the prune.
pub(crate) fn run_one(func: &mut FunctionSsa) -> bool {
    let mut changed = false;
    // Out-edges the fold deletes: (source block, successor it no longer
    // reaches). Folding a Bz/Bnz/JumpTable to a Jmp drops the not-taken
    // out-edges; the source block usually stays reachable (the taken edge,
    // or another path in), so `prune_unreachable` -- which only removes
    // wholly unreachable blocks -- would leave the successor's phi with a
    // stale incoming from this block. Drop it here so the phi reflects the
    // real predecessor set and can collapse to a single incoming, which
    // `fold` then resolves.
    let mut removed_edges: alloc::vec::Vec<(BlockId, BlockId)> = alloc::vec::Vec::new();
    let block_of = block_index(func);
    let decided = |cond| truthy(func, &block_of, cond, TRUTH_DEPTH);
    let decisions: alloc::vec::Vec<Option<bool>> = func
        .blocks
        .iter()
        .map(|b| match b.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => decided(cond),
            _ => None,
        })
        .collect();
    for (bidx, block) in func.blocks.iter_mut().enumerate() {
        let self_id = bidx as BlockId;
        let mut dropped: alloc::vec::Vec<BlockId> = alloc::vec::Vec::new();
        let nonzero = decisions[bidx];
        let new_term = match block.terminator {
            Terminator::Bz {
                target,
                fall_through,
                ..
            } => nonzero.map(|nz| {
                let (taken, not_taken) = if nz {
                    (fall_through, target)
                } else {
                    (target, fall_through)
                };
                if not_taken != taken {
                    dropped.push(not_taken);
                }
                Terminator::Jmp(taken)
            }),
            Terminator::Bnz {
                target,
                fall_through,
                ..
            } => nonzero.map(|nz| {
                let (taken, not_taken) = if nz {
                    (target, fall_through)
                } else {
                    (fall_through, target)
                };
                if not_taken != taken {
                    dropped.push(not_taken);
                }
                Terminator::Jmp(taken)
            }),
            // A constant in-range index selects one table entry; out of
            // range the terminator is unreachable (the lowering's bounds
            // check precedes it) and is left alone. Every distinct target
            // other than the taken one loses this block as a predecessor.
            Terminator::JumpTable { idx, table } => fold(func.insts.as_slice(), idx)
                .and_then(|k| {
                    func.jump_tables[table as usize]
                        .get(k as u64 as usize)
                        .copied()
                })
                .map(|taken| {
                    for &t in &func.jump_tables[table as usize] {
                        if t != taken && !dropped.contains(&t) {
                            dropped.push(t);
                        }
                    }
                    Terminator::Jmp(taken)
                }),
            _ => None,
        };
        if let Some(t) = new_term {
            block.terminator = t;
            for nt in dropped {
                removed_edges.push((self_id, nt));
            }
            changed = true;
        }
    }
    // Drop each deleted edge's incoming from the successor's phis.
    for (from, to) in removed_edges {
        let Some(block) = func.blocks.get(to as usize) else {
            continue;
        };
        for i in block.inst_range.clone() {
            if let Inst::Phi { incoming, .. } = &mut func.insts[i as usize] {
                incoming.retain(|&(pred, _)| pred != from);
            }
        }
    }
    changed
}

/// Fold a conditional branch whose arms do no work to a jump down its
/// fall-through arm: both arms reach one block over blocks of pure values
/// nothing outside them reads, and each phi there that is read takes the
/// same value over either arm. Returns whether any terminator changed.
pub(crate) fn fold_converging_arms(func: &mut FunctionSsa) -> bool {
    use crate::c5::codegen::ssa::reg_alloc::{compute_use_counts, for_each_operand};
    let block_of = block_index(func);
    let n = func.insts.len();
    // A value read outside its block other than by a phi on an edge out
    // of that block.
    let mut read_away = alloc::vec![false; n];
    for (b, block) in func.blocks.iter().enumerate() {
        let mut note = |v: crate::c5::ir::ValueId, from: BlockId| {
            if (v as usize) < n && block_of[v as usize] != from {
                read_away[v as usize] = true;
            }
        };
        for i in block.inst_range.clone() {
            match &func.insts[i as usize] {
                Inst::Phi { incoming, .. } => incoming.iter().for_each(|&(p, v)| note(v, p)),
                inst => for_each_operand(inst, |v| note(v, b as BlockId)),
            }
        }
        block.terminator.for_each_operand(|v| note(v, b as BlockId));
    }
    let forwards_to = |s: BlockId| -> Option<BlockId> {
        let block = func.blocks.get(s as usize)?;
        let (Terminator::Jmp(next) | Terminator::FallThrough(next)) = block.terminator else {
            return None;
        };
        let quiet = block.inst_range.clone().all(|i| {
            let inst = &func.insts[i as usize];
            !matches!(inst, Inst::Phi { .. }) && inst.is_pure() && !read_away[i as usize]
        });
        (s != 0 && quiet).then_some(next)
    };
    // The block an arm entered from `b` reaches, and the edge it arrives on.
    let reach = |b: BlockId, arm: BlockId| {
        let (mut at, mut from) = (arm, b);
        for _ in 0..func.blocks.len() {
            match forwards_to(at) {
                Some(next) if next != at => (from, at) = (at, next),
                _ => break,
            }
        }
        (at, from)
    };
    let uses = compute_use_counts(func);
    let agree = |d: BlockId, p: BlockId, q: BlockId| {
        let income = |incoming: &[(BlockId, crate::c5::ir::ValueId)], e: BlockId| {
            incoming.iter().find(|&&(x, _)| x == e).map(|&(_, v)| v)
        };
        p == q
            || func.blocks[d as usize]
                .inst_range
                .clone()
                .all(|i| match &func.insts[i as usize] {
                    Inst::Phi { incoming, .. } if uses[i as usize] > 0 => {
                        match (income(incoming, p), income(incoming, q)) {
                            (Some(x), Some(y)) => {
                                x == y
                                    || fold(&func.insts, x)
                                        .is_some_and(|k| fold(&func.insts, y) == Some(k))
                            }
                            _ => false,
                        }
                    }
                    _ => true,
                })
    };
    let folds: alloc::vec::Vec<(usize, BlockId, BlockId)> = (0..func.blocks.len())
        .filter_map(|b| {
            let (Terminator::Bz {
                target,
                fall_through,
                ..
            }
            | Terminator::Bnz {
                target,
                fall_through,
                ..
            }) = func.blocks[b].terminator
            else {
                return None;
            };
            let (dt, from_t) = reach(b as BlockId, target);
            let (df, from_f) = reach(b as BlockId, fall_through);
            (dt == df && dt != b as BlockId && agree(dt, from_t, from_f)).then_some((
                b,
                target,
                fall_through,
            ))
        })
        .collect();
    for &(b, target, fall_through) in &folds {
        func.blocks[b].terminator = Terminator::Jmp(fall_through);
        if target == fall_through {
            continue;
        }
        for i in func.blocks[target as usize].inst_range.clone() {
            if let Inst::Phi { incoming, .. } = &mut func.insts[i as usize] {
                incoming.retain(|&(pred, _)| pred != b as BlockId);
            }
        }
    }
    !folds.is_empty()
}

/// Rewrite a branch testing `x == 0` / `x != 0` into the branch on `x`
/// itself: `Bz(x != 0)` -> `Bz(x)`, `Bz(x == 0)` -> `Bnz(x)`, and the
/// `Bnz` duals. The compare computes exactly the zero test the
/// terminator performs, so this holds for every integer `x` and lets
/// the per-arch emit branch on `x`'s register directly (`cbz` / `cbnz`,
/// `test` + `jcc`). An FP-classed `x` keeps its compare: the
/// terminator tests the raw bit pattern, which differs from an FP
/// compare at -0.0. A compare `narrow` marked 32-bit reads the low word
/// only, and so does the branch that replaces it (`low_word_tests`),
/// which leaves the high word of `x` unread. The compare stays for its
/// other consumers and goes dead otherwise. A
/// 32-bit extension or low-word mask the branch alone reads is zero
/// exactly when its operand's low word is, so the branch tests that word.
///
/// Runs once per function immediately before register allocation: the
/// compare shape is what the mid-end folds key on (a null test of a
/// symbol address, a range-settled comparison), so stripping it any
/// earlier starves them.
pub(crate) fn strip_zero_test_conds(func: &mut FunctionSsa) -> bool {
    use crate::c5::codegen::ssa::reg_alloc::{compute_use_counts, for_each_operand};
    use crate::c5::ir::{BinOp, LoadKind};
    // `(lhs, negate)` when `v` is an integer zero test of `lhs`;
    // `negate` for the `==` form, which inverts the branch sense.
    let zero_test = |func: &FunctionSsa, v: crate::c5::ir::ValueId| {
        let (op, lhs) = match func.insts.get(v as usize)? {
            Inst::BinopI {
                op,
                lhs,
                rhs_imm: 0,
            } => (*op, *lhs),
            Inst::Binop { op, lhs, rhs }
                if matches!(func.insts.get(*rhs as usize), Some(Inst::Imm(0))) =>
            {
                (*op, *lhs)
            }
            _ => return None,
        };
        let negate = match op {
            BinOp::Eq => true,
            BinOp::Ne => false,
            _ => return None,
        };
        let producer = func.insts.get(lhs as usize)?;
        if crate::c5::codegen::ssa::reg_alloc::produces_fp_result(producer)
            || matches!(func.f32_values.get(lhs as usize), Some(true))
        {
            return None;
        }
        Some((lhs, negate, super::narrow::is_cmp32(&func.cmp32, v)))
    };
    let mut uses = compute_use_counts(func);
    let low_word_of = |func: &FunctionSsa, uses: &[u32], v: crate::c5::ir::ValueId| match func
        .insts
        .get(v as usize)?
    {
        Inst::Extend {
            value,
            kind: LoadKind::I32 | LoadKind::U32,
            ..
        }
        | Inst::BinopI {
            op: BinOp::And,
            lhs: value,
            rhs_imm: 0xFFFF_FFFF,
        } if uses[v as usize] == 1 => Some((*value, false, true)),
        _ => None,
    };
    let mut changed = false;
    for bidx in 0..func.blocks.len() {
        // Chains (`(x != 0) != 0`) resolve one link per round; the
        // bound covers any tape.
        for _ in 0..func.insts.len() {
            let term = func.blocks[bidx].terminator;
            let (cond, target, fall_through, on_zero) = match term {
                Terminator::Bz {
                    cond,
                    target,
                    fall_through,
                } => (cond, target, fall_through, true),
                Terminator::Bnz {
                    cond,
                    target,
                    fall_through,
                } => (cond, target, fall_through, false),
                _ => break,
            };
            let Some((lhs, negate, low_word)) =
                zero_test(func, cond).or_else(|| low_word_of(func, &uses, cond))
            else {
                break;
            };
            // The branch reads `lhs` in place of `cond`, which dies with
            // its last reader.
            let release = |u: &mut [u32], v: crate::c5::ir::ValueId| {
                if let Some(c) = u.get_mut(v as usize) {
                    *c = c.saturating_sub(1);
                }
            };
            if let Some(c) = uses.get_mut(lhs as usize) {
                *c += 1;
            }
            release(&mut uses, cond);
            if uses[cond as usize] == 0 && func.insts[cond as usize].is_pure() {
                for_each_operand(&func.insts[cond as usize], |op| release(&mut uses, op));
            }
            // Each link replaces the test: only the last compare's width counts.
            if func.low_word_tests.len() < func.blocks.len() {
                func.low_word_tests.resize(func.blocks.len(), false);
            }
            func.low_word_tests[bidx] = low_word;
            func.blocks[bidx].terminator = if on_zero != negate {
                Terminator::Bz {
                    cond: lhs,
                    target,
                    fall_through,
                }
            } else {
                Terminator::Bnz {
                    cond: lhs,
                    target,
                    fall_through,
                }
            };
            changed = true;
        }
    }
    changed
}

/// A branch on the low word of `x ^ y` that it alone reads tests whether
/// `x` and `y` differ in that word: the exclusive-or becomes the 32-bit
/// `x != y` it computes, which the emit fuses with the branch (`cmp w0,
/// #imm` / `cmpl $imm`) as it does a compare the source spelled. A
/// mixed-signedness `==` at 32 bits reaches the branch in this shape.
/// Taken where the fused form is no longer: the instructions between the
/// exclusive-or and the branch keep the flags, and on AArch64 an
/// immediate `cmp` encodes or `eor` cannot encode either.
///
/// A comparison of such an exclusive-or with zero, at either width, is
/// the same comparison of its operands.
///
/// Runs after [`strip_zero_test_conds`], which leaves the low-word test.
pub(crate) fn low_word_xor_to_compare(func: &mut FunctionSsa, is_x86: bool) -> bool {
    use crate::c5::codegen::ssa::reg_alloc::{compute_use_counts, flags_survive};
    use crate::c5::ir::BinOp;
    let uses = compute_use_counts(func);
    let mut changed = false;
    for v in 0..func.insts.len() {
        let (op, x) = match func.insts[v] {
            Inst::BinopI {
                op: op @ (BinOp::Eq | BinOp::Ne),
                lhs,
                rhs_imm: 0,
            } => (op, lhs),
            _ => continue,
        };
        if uses.get(x as usize) != Some(&1) {
            continue;
        }
        func.insts[v] = match func.insts[x as usize] {
            Inst::Binop {
                op: BinOp::Xor,
                lhs,
                rhs,
            } => Inst::Binop { op, lhs, rhs },
            Inst::BinopI {
                op: BinOp::Xor,
                lhs,
                rhs_imm,
            } => Inst::BinopI { op, lhs, rhs_imm },
            _ => continue,
        };
        changed = true;
    }
    for bidx in 0..func.blocks.len() {
        let block = &func.blocks[bidx];
        let (Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. }) = block.terminator else {
            continue;
        };
        if func.low_word_tests.get(bidx) != Some(&true)
            || uses.get(cond as usize) != Some(&1)
            || !block.inst_range.contains(&cond)
        {
            continue;
        }
        let shorter = match func.insts[cond as usize] {
            Inst::Binop { op: BinOp::Xor, .. } => true,
            Inst::BinopI {
                op: BinOp::Xor,
                rhs_imm,
                ..
            } => {
                is_x86
                    || crate::c5::codegen::aarch64::emit::cmp_imm12(rhs_imm).is_some()
                    || crate::c5::codegen::aarch64::encode::encode_logical_imm(rhs_imm as u64, true)
                        .is_none()
            }
            _ => false,
        };
        let window = ((cond + 1)..block.inst_range.end).all(|p| {
            let inst = &func.insts[p as usize];
            inst.is_lifetime_marker()
                || (inst.is_pure() && uses[p as usize] == 0)
                || flags_survive(inst, is_x86)
        });
        if !shorter || !window {
            continue;
        }
        if let Inst::Binop { op, .. } | Inst::BinopI { op, .. } = &mut func.insts[cond as usize] {
            *op = BinOp::Ne;
        }
        if func.cmp32.len() <= cond as usize {
            func.cmp32.resize(func.insts.len(), false);
        }
        func.cmp32[cond as usize] = true;
        func.low_word_tests[bidx] = false;
        changed = true;
    }
    changed
}

/// Resolve `v` to a constant: an `Inst::Imm`, or one reached through
/// phis -- a single-incoming phi always takes that value, and a merge
/// whose predecessors all supply the same constant is that constant.
/// Returns `None` for any other producer or for `NO_VALUE`.
fn fold(insts: &[Inst], v: crate::c5::ir::ValueId) -> Option<i64> {
    super::constfold::imm_through_phis(insts, &[], v)
}

/// Recursion budget for the truthiness merge, bounding the operand
/// fan-out the same way the constant merge does.
const TRUTH_DEPTH: u32 = 4;

/// Whether `v` is zero or non-zero wherever it is used as a branch
/// condition, when that is decidable without knowing its value.
///
/// A constant decides directly. A phi decides when every predecessor
/// agrees, and an incoming that arrives from a block which branched on
/// that very value is decided by the edge it came in on: `a && b` and
/// `a || b` merge the deciding operand itself on the short-circuit edge,
/// where the branch just taken fixes its truthiness. Recording the
/// operand rather than a fresh 0 / 1 keeps the non-folding case one
/// instruction shorter, so the fold reconstructs the fact here.
fn truthy(
    func: &FunctionSsa,
    block_of: &[BlockId],
    v: crate::c5::ir::ValueId,
    depth: u32,
) -> Option<bool> {
    let idx = v as usize;
    match func.insts.get(idx)? {
        Inst::Imm(k) => Some(*k != 0),
        Inst::Phi { incoming, .. } => {
            if depth == 0 || incoming.is_empty() {
                return None;
            }
            // A phi no block contains has no incoming edges to reason
            // about; `block_index` marks it with the sentinel.
            let here = *block_of.get(idx)?;
            if here == BlockId::MAX {
                return None;
            }
            let mut merged: Option<bool> = None;
            for &(pred, val) in incoming {
                let decided = edge_truth(func, pred, here, val)
                    .or_else(|| truthy(func, block_of, val, depth - 1))?;
                match merged {
                    Some(m) if m != decided => return None,
                    _ => merged = Some(decided),
                }
            }
            merged
        }
        _ => None,
    }
}

/// The truthiness `val` must have on the edge `pred -> here`, when
/// `pred` ended in a branch on `val` itself. A branch with both arms at
/// the same block decides nothing.
pub(super) fn edge_truth(
    func: &FunctionSsa,
    pred: BlockId,
    here: BlockId,
    val: crate::c5::ir::ValueId,
) -> Option<bool> {
    let (cond, zero_edge, nonzero_edge) = match func.blocks.get(pred as usize)?.terminator {
        // `Bz` takes `target` when the condition is zero.
        Terminator::Bz {
            cond,
            target,
            fall_through,
        } => (cond, target, fall_through),
        // `Bnz` takes `target` when it is non-zero.
        Terminator::Bnz {
            cond,
            target,
            fall_through,
        } => (cond, fall_through, target),
        _ => return None,
    };
    if cond != val || zero_edge == nonzero_edge {
        return None;
    }
    if here == zero_edge {
        Some(false)
    } else if here == nonzero_edge {
        Some(true)
    } else {
        None
    }
}

/// `block_of[inst] = owning block id`, for the edge lookup above.
/// `BlockId::MAX` marks an instruction no block contains -- what a
/// folded-away arm leaves behind in the flat array.
pub(crate) fn block_index(func: &FunctionSsa) -> alloc::vec::Vec<BlockId> {
    let mut of = alloc::vec![BlockId::MAX; func.insts.len()];
    for (b, blk) in func.blocks.iter().enumerate() {
        for i in blk.inst_range.clone() {
            if let Some(slot) = of.get_mut(i as usize) {
                *slot = b as BlockId;
            }
        }
    }
    of
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{BinOp, Block, FunctionSsa, NO_VALUE, ValueId};
    use alloc::vec;

    fn fresh(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            seh_scopes: Vec::new(),
            block_seh: Vec::new(),
            funclet_slots: Vec::new(),
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            ssp: crate::c5::ir::SspFacts::default(),
            n_params: 0,
            is_variadic: false,
            is_inline: false,
            is_always_inline: false,
            is_noinline: false,
            is_naked: false,
            is_noreturn: false,
            conv: crate::c5::codegen::CallConv::Target,
            general_regs_only: false,
            tls_dynamic: false,
            section: None,
            patchable_entry: None,
            no_instrument: false,
            no_stack_protector: false,
            is_weak: false,
            is_internal: false,
            const_params: 0,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            cmp32: Vec::new(),
            div32: Vec::new(),
            low_word_tests: Vec::new(),
            param_fp_mask: crate::c5::ir::FpMask::EMPTY,
            param_widths: crate::c5::ir::ArgWidths::default(),
            agg_descs: alloc::vec::Vec::new(),
            param_aggs: alloc::vec::Vec::new(),
            param_local_slots: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            ret_type_tag: None,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            label_data_relocs: Vec::new(),
            jump_tables: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
            array_slots: Vec::new(),
            over_aligned: Default::default(),
            frame_align: 0,
            realign_region_bytes: 0,
            has_returns_twice_call: false,
            did_unroll: false,
            did_inline: false,
            insts,
            blocks,
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        }
    }

    /// `b0: if (p0)` to `b1` or `b2`, each holding `arm` and jumping to
    /// `b3`, whose phi merges `v1` (from `b1`) and `v2` (from `b2`) and
    /// whose return reads `ret`.
    fn diamond(arms: [Inst; 2], ret: ValueId) -> FunctionSsa {
        use crate::c5::ir::LoadKind;
        let [t, f] = arms;
        let block = |range: core::ops::Range<u32>, terminator| Block {
            start_pc: 0,
            inst_range: range,
            terminator,
            exit_acc: NO_VALUE,
        };
        fresh(
            vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I64,
                },
                t,
                f,
                Inst::Phi {
                    incoming: vec![(1, 1), (2, 2)],
                    kind: LoadKind::I64,
                },
            ],
            vec![
                block(
                    0..1,
                    Terminator::Bnz {
                        cond: 0,
                        target: 1,
                        fall_through: 2,
                    },
                ),
                block(1..2, Terminator::Jmp(3)),
                block(2..3, Terminator::Jmp(3)),
                block(3..4, Terminator::Return(ret)),
            ],
        )
    }

    #[test]
    fn a_branch_whose_arms_do_no_work_and_agree_becomes_a_jump() {
        let store = Inst::StoreLocal {
            disp: 0,
            off: -1,
            value: 0,
            kind: crate::c5::ir::StoreKind::I64,
            volatile: false,
            nsw: false,
        };
        for (arms, ret, folds) in [
            ([Inst::Imm(7), Inst::Imm(7)], 3, true),
            ([Inst::Imm(1), Inst::Imm(2)], 3, false),
            // A phi nothing reads takes any values.
            ([Inst::Imm(1), Inst::Imm(2)], 0, true),
            ([store, Inst::Imm(7)], 0, false),
        ] {
            let mut f = diamond(arms.clone(), ret);
            assert_eq!(
                fold_converging_arms(&mut f),
                folds,
                "{arms:?} returning v{ret}"
            );
            if folds {
                assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(2)));
            }
        }
    }

    #[test]
    fn an_arm_that_is_the_merge_loses_its_phi_income() {
        // `b0: if (p0)` straight to `b3` or through `b2`.
        let mut f = diamond([Inst::Imm(7), Inst::Imm(7)], 3);
        f.blocks[0].terminator = Terminator::Bnz {
            cond: 0,
            target: 3,
            fall_through: 2,
        };
        if let Inst::Phi { incoming, .. } = &mut f.insts[3] {
            incoming[0] = (0, 1);
        }
        f.blocks[0].inst_range = 0..2;
        f.blocks[1].inst_range = 2..2;
        assert!(fold_converging_arms(&mut f));
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(2)));
        assert!(matches!(&f.insts[3], Inst::Phi { incoming, .. } if incoming[..] == [(2, 2)]));
    }

    #[test]
    fn bz_on_imm_zero_folds_to_jmp_target() {
        let mut f = fresh(
            vec![Inst::Imm(0)],
            vec![Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Bz {
                    cond: 0,
                    target: 1,
                    fall_through: 2,
                },
                exit_acc: 0,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(1)));
    }

    #[test]
    fn bz_on_imm_nonzero_folds_to_jmp_fall() {
        let mut f = fresh(
            vec![Inst::Imm(42)],
            vec![Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Bz {
                    cond: 0,
                    target: 1,
                    fall_through: 2,
                },
                exit_acc: 0,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(2)));
    }

    #[test]
    fn bnz_on_imm_zero_folds_to_jmp_fall() {
        let mut f = fresh(
            vec![Inst::Imm(0)],
            vec![Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Bnz {
                    cond: 0,
                    target: 1,
                    fall_through: 2,
                },
                exit_acc: 0,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(2)));
    }

    #[test]
    fn bnz_on_imm_nonzero_folds_to_jmp_target() {
        let mut f = fresh(
            vec![Inst::Imm(1)],
            vec![Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Bnz {
                    cond: 0,
                    target: 1,
                    fall_through: 2,
                },
                exit_acc: 0,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(1)));
    }

    #[test]
    fn bz_through_single_incoming_phi_folds() {
        // A degenerate phi (one incoming) collapses to its value: the
        // branch resolves as if the immediate were the condition.
        let mut f = fresh(
            vec![
                Inst::Imm(1),
                Inst::Phi {
                    incoming: vec![(0, 0)],
                    kind: crate::c5::ir::LoadKind::I64,
                },
            ],
            vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..1,
                    terminator: Terminator::Jmp(1),
                    exit_acc: 0,
                },
                Block {
                    start_pc: 0,
                    inst_range: 1..2,
                    terminator: Terminator::Bz {
                        cond: 1,
                        target: 2,
                        fall_through: 3,
                    },
                    exit_acc: 1,
                },
            ],
        );
        run_one(&mut f);
        // cond resolves to 1 (nonzero) -> Bz takes the fall-through.
        assert!(matches!(f.blocks[1].terminator, Terminator::Jmp(3)));
    }

    #[test]
    fn folded_edge_drops_stale_phi_incoming() {
        // b0 Bz{Imm(1)} folds to Jmp(fall=b2); the b0 -> b1 (target) edge is
        // gone, so b1's merge phi -- which listed b0 and b3 as predecessors --
        // must drop the b0 incoming even though b0 stays reachable.
        let mut f = fresh(
            vec![
                Inst::Imm(1), // v0  b0 condition
                Inst::Imm(5), // v1  b2's value
                Inst::Phi {
                    incoming: vec![(0, 0), (3, 1)],
                    kind: crate::c5::ir::LoadKind::I64,
                }, // v2  b1 merge phi (from b0 and b3)
            ],
            vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..1,
                    terminator: Terminator::Bz {
                        cond: 0,
                        target: 1,
                        fall_through: 2,
                    },
                    exit_acc: 0,
                }, // b0
                Block {
                    start_pc: 0,
                    inst_range: 2..3,
                    terminator: Terminator::Return(2),
                    exit_acc: 2,
                }, // b1
                Block {
                    start_pc: 0,
                    inst_range: 1..2,
                    terminator: Terminator::Return(1),
                    exit_acc: 1,
                }, // b2
                Block {
                    start_pc: 0,
                    inst_range: 3..3,
                    terminator: Terminator::Jmp(1),
                    exit_acc: NO_VALUE as ValueId,
                }, // b3 -> b1
            ],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(2)));
        let Inst::Phi { incoming, .. } = &f.insts[2] else {
            panic!("expected phi");
        };
        assert_eq!(
            incoming.len(),
            1,
            "the removed b0 edge's incoming is dropped"
        );
        assert_eq!(
            incoming[0].0, 3,
            "only the surviving b3 predecessor remains"
        );
    }

    #[test]
    fn bz_through_two_incoming_phi_is_left_untouched() {
        // A real merge (two incomings) is not a constant; leave it.
        let mut f = fresh(
            vec![
                Inst::Imm(1),
                Inst::Imm(0),
                Inst::Phi {
                    incoming: vec![(0, 0), (1, 1)],
                    kind: crate::c5::ir::LoadKind::I64,
                },
            ],
            vec![Block {
                start_pc: 0,
                inst_range: 0..3,
                terminator: Terminator::Bz {
                    cond: 2,
                    target: 1,
                    fall_through: 2,
                },
                exit_acc: 2,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Bz { .. }));
    }

    #[test]
    fn non_imm_condition_is_left_untouched() {
        let mut f = fresh(
            vec![Inst::LocalAddr(0)],
            vec![Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Bz {
                    cond: 0,
                    target: 1,
                    fall_through: 2,
                },
                exit_acc: 0,
            }],
        );
        let before = f.blocks[0].terminator;
        run_one(&mut f);
        assert_eq!(
            format!("{:?}", f.blocks[0].terminator),
            format!("{:?}", before)
        );
    }

    #[test]
    fn no_value_condition_is_left_untouched() {
        let mut f = fresh(
            vec![Inst::Imm(0)],
            vec![Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Bz {
                    cond: NO_VALUE as ValueId,
                    target: 1,
                    fall_through: 2,
                },
                exit_acc: 0,
            }],
        );
        run_one(&mut f);
        assert!(matches!(f.blocks[0].terminator, Terminator::Bz { .. }));
    }

    fn zero_test_blocks(term: Terminator) -> Vec<Block> {
        vec![
            Block {
                start_pc: 0,
                inst_range: 0..2,
                terminator: term,
                exit_acc: 1,
            },
            Block {
                start_pc: 0,
                inst_range: 2..2,
                terminator: Terminator::Return(NO_VALUE as ValueId),
                exit_acc: NO_VALUE as ValueId,
            },
            Block {
                start_pc: 0,
                inst_range: 2..2,
                terminator: Terminator::Return(NO_VALUE as ValueId),
                exit_acc: NO_VALUE as ValueId,
            },
        ]
    }

    /// `Bz(x != 0)` branches on `x`; `Bz(x == 0)` becomes `Bnz(x)`.
    #[test]
    fn branch_on_a_zero_test_takes_the_operand() {
        let load = Inst::LoadLocal {
            disp: 0,
            off: 2,
            kind: crate::c5::ir::LoadKind::I64,
            volatile: false,
        };
        let mut f = fresh(
            vec![
                load.clone(),
                Inst::BinopI {
                    op: BinOp::Ne,
                    lhs: 0,
                    rhs_imm: 0,
                },
            ],
            zero_test_blocks(Terminator::Bz {
                cond: 1,
                target: 1,
                fall_through: 2,
            }),
        );
        assert!(strip_zero_test_conds(&mut f));
        assert!(matches!(
            f.blocks[0].terminator,
            Terminator::Bz { cond: 0, .. }
        ));
        let mut g = fresh(
            vec![
                load,
                Inst::BinopI {
                    op: BinOp::Eq,
                    lhs: 0,
                    rhs_imm: 0,
                },
            ],
            zero_test_blocks(Terminator::Bz {
                cond: 1,
                target: 1,
                fall_through: 2,
            }),
        );
        assert!(strip_zero_test_conds(&mut g));
        assert!(matches!(
            g.blocks[0].terminator,
            Terminator::Bnz { cond: 0, .. }
        ));
    }

    /// A 32-bit zero test reads the low word, and so does the branch that
    /// replaces it: over a wrapped sum whose renormalization was dropped
    /// the register can be non-zero above a zero low word. A 64-bit test
    /// reads the register.
    #[test]
    fn narrow_zero_test_tests_the_low_word() {
        let load = |kind| Inst::LoadLocal {
            disp: 0,
            off: 2,
            kind,
            volatile: false,
        };
        let sum = Inst::Binop {
            op: BinOp::Add,
            lhs: 0,
            rhs: 0,
        };
        let test = Inst::BinopI {
            op: BinOp::Ne,
            lhs: 1,
            rhs_imm: 0,
        };
        let term = Terminator::Bz {
            cond: 2,
            target: 1,
            fall_through: 2,
        };
        use crate::c5::ir::LoadKind;
        let mut f = fresh(
            vec![load(LoadKind::I32), sum, test.clone()],
            zero_test_blocks(term),
        );
        f.cmp32 = vec![false, false, true];
        assert!(strip_zero_test_conds(&mut f));
        assert!(matches!(
            f.blocks[0].terminator,
            Terminator::Bz { cond: 1, .. }
        ));
        assert_eq!(f.low_word_tests.first(), Some(&true));
        let mut g = fresh(
            vec![load(LoadKind::I64), load(LoadKind::I32), test],
            zero_test_blocks(term),
        );
        g.cmp32 = vec![false, false, false];
        assert!(strip_zero_test_conds(&mut g));
        assert!(matches!(
            g.blocks[0].terminator,
            Terminator::Bz { cond: 1, .. }
        ));
        assert_eq!(g.low_word_tests.first(), Some(&false));
    }

    /// `Bz(v1)` over `v1 = narrow(v0)`: a 32-bit extension or low-word
    /// mask the branch alone reads is zero exactly when the low word of
    /// `v0` is. A 16-bit extension, or one another consumer reads, stays.
    #[test]
    fn branch_on_a_32_bit_extension_tests_the_low_word() {
        use crate::c5::ir::LoadKind;
        let ext = |kind| Inst::Extend {
            value: 0,
            kind,
            nsw: false,
        };
        let mask = Inst::BinopI {
            op: BinOp::And,
            lhs: 0,
            rhs_imm: 0xFFFF_FFFF,
        };
        let term = Terminator::Bz {
            cond: 1,
            target: 1,
            fall_through: 2,
        };
        let run = |narrow: Inst, read_again: bool| {
            let load = Inst::LoadLocal {
                disp: 0,
                off: 2,
                kind: LoadKind::I64,
                volatile: false,
            };
            let mut f = fresh(vec![load, narrow], zero_test_blocks(term));
            if read_again {
                f.blocks[1].terminator = Terminator::Return(1);
            }
            strip_zero_test_conds(&mut f);
            let Terminator::Bz { cond, .. } = f.blocks[0].terminator else {
                panic!("expected Bz, got {:?}", f.blocks[0].terminator);
            };
            (cond, f.low_word_tests.first().copied().unwrap_or(false))
        };
        assert_eq!(run(ext(LoadKind::I32), false), (0, true));
        assert_eq!(run(ext(LoadKind::U32), false), (0, true));
        assert_eq!(run(mask.clone(), false), (0, true));
        assert_eq!(run(ext(LoadKind::I16), false), (1, false));
        assert_eq!(run(mask, true), (1, false));
    }

    /// `Bz(narrow(v0) != 0)`: once the compare is stripped and dead, the
    /// extension has the branch alone and goes too. A compare another
    /// consumer keeps still reads the extension, which stays.
    #[test]
    fn stripped_compare_releases_its_extension() {
        use crate::c5::ir::LoadKind;
        let build = |read_again: bool| {
            let mut f = fresh(
                vec![
                    Inst::LoadLocal {
                        disp: 0,
                        off: 2,
                        kind: LoadKind::I64,
                        volatile: false,
                    },
                    Inst::Extend {
                        value: 0,
                        kind: LoadKind::I32,
                        nsw: false,
                    },
                    Inst::BinopI {
                        op: BinOp::Ne,
                        lhs: 1,
                        rhs_imm: 0,
                    },
                ],
                zero_test_blocks(Terminator::Bz {
                    cond: 2,
                    target: 1,
                    fall_through: 2,
                }),
            );
            f.blocks[0].inst_range = 0..3;
            f.cmp32 = vec![false, false, true];
            if read_again {
                f.blocks[1].terminator = Terminator::Return(2);
            }
            assert!(strip_zero_test_conds(&mut f));
            let Terminator::Bz { cond, .. } = f.blocks[0].terminator else {
                panic!("expected Bz, got {:?}", f.blocks[0].terminator);
            };
            (cond, f.low_word_tests.first().copied().unwrap_or(false))
        };
        assert_eq!(build(false), (0, true));
        assert_eq!(build(true), (1, true));
    }

    /// A zero test of an FP-classed value is not a bit-pattern test
    /// (-0.0 compares equal to 0), so the branch keeps the compare.
    #[test]
    fn zero_test_of_an_fp_value_keeps_its_compare() {
        let mut f = fresh(
            vec![
                Inst::LoadLocal {
                    disp: 0,
                    off: 2,
                    kind: crate::c5::ir::LoadKind::F64,
                    volatile: false,
                },
                Inst::BinopI {
                    op: BinOp::Eq,
                    lhs: 0,
                    rhs_imm: 0,
                },
            ],
            zero_test_blocks(Terminator::Bz {
                cond: 1,
                target: 1,
                fall_through: 2,
            }),
        );
        assert!(!strip_zero_test_conds(&mut f));
        assert!(matches!(
            f.blocks[0].terminator,
            Terminator::Bz { cond: 1, .. }
        ));
    }
}
