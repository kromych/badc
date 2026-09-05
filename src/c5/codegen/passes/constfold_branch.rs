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
//! downstream. `fold` therefore chases single-incoming (degenerate)
//! phis, and the driver in [`super::simplify_branches`] alternates this
//! pass with the prune to a fixed point.

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

/// Rewrite a branch testing `x == 0` / `x != 0` into the branch on `x`
/// itself: `Bz(x != 0)` -> `Bz(x)`, `Bz(x == 0)` -> `Bnz(x)`, and the
/// `Bnz` duals. The compare computes exactly the zero test the
/// terminator performs, so this holds for every integer `x` and lets
/// the per-arch emit branch on `x`'s register directly (`cbz` / `cbnz`,
/// `test` + `jcc`). An FP-classed `x` keeps its compare: the
/// terminator tests the raw bit pattern, which differs from an FP
/// compare at -0.0. The compare stays for its other consumers and goes
/// dead otherwise.
///
/// Runs once per function immediately before register allocation: the
/// compare shape is what the mid-end folds key on (a null test of a
/// symbol address, a range-settled comparison), so stripping it any
/// earlier starves them.
pub(crate) fn strip_zero_test_conds(func: &mut FunctionSsa) -> bool {
    use crate::c5::ir::BinOp;
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
        Some((lhs, negate))
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
            let Some((lhs, negate)) = zero_test(func, cond) else {
                break;
            };
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
pub(super) fn block_index(func: &FunctionSsa) -> alloc::vec::Vec<BlockId> {
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
            conv: crate::c5::codegen::CallConv::Target,
            section: None,
            patchable_entry: None,
            no_instrument: false,
            is_weak: false,
            is_internal: false,
            const_params: 0,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            cmp32: Vec::new(),
            param_fp_mask: 0,
            agg_descs: alloc::vec::Vec::new(),
            param_aggs: alloc::vec::Vec::new(),
            param_local_slots: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            ret_type_tag: 0,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            label_data_relocs: Vec::new(),
            jump_tables: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
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

    /// A zero test of an FP-classed value is not a bit-pattern test
    /// (-0.0 compares equal to 0), so the branch keeps the compare.
    #[test]
    fn zero_test_of_an_fp_value_keeps_its_compare() {
        let mut f = fresh(
            vec![
                Inst::LoadLocal {
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
