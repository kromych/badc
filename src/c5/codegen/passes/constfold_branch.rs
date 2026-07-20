//! Fold conditional branches whose condition is a known immediate.
//!
//! Walks every block's terminator. When the condition of a
//! `Terminator::Bz` or `Terminator::Bnz` resolves to an
//! `Inst::Imm(k)`, replace the terminator with an unconditional
//! `Terminator::Jmp` to whichever successor the constant selects.
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
    // Skip computed-goto functions: branch folding may drop or
    // renumber blocks, invalidating `Inst::BlockAddr` / the
    // computed_goto_targets block ids.
    if !func.computed_goto_targets.is_empty() {
        return false;
    }
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
    for (bidx, block) in func.blocks.iter_mut().enumerate() {
        let self_id = bidx as BlockId;
        let mut dropped: alloc::vec::Vec<BlockId> = alloc::vec::Vec::new();
        let new_term = match block.terminator {
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => fold(func.insts.as_slice(), cond).map(|k| {
                let (taken, not_taken) = if k == 0 {
                    (target, fall_through)
                } else {
                    (fall_through, target)
                };
                if not_taken != taken {
                    dropped.push(not_taken);
                }
                Terminator::Jmp(taken)
            }),
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => fold(func.insts.as_slice(), cond).map(|k| {
                let (taken, not_taken) = if k != 0 {
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

/// Resolve `v` to a constant. Names an `Inst::Imm` directly, or reaches
/// one through a chain of single-incoming phis: a phi with one
/// predecessor always takes that value, so the constant reaches the
/// condition. The chase is bounded by the instruction count so a phi
/// cycle cannot loop. Returns `None` for any other producer or for
/// `NO_VALUE`.
fn fold(insts: &[Inst], v: crate::c5::ir::ValueId) -> Option<i64> {
    let mut v = v as usize;
    for _ in 0..insts.len() {
        match insts.get(v)? {
            Inst::Imm(k) => return Some(*k),
            Inst::Phi { incoming, .. } if incoming.len() == 1 => {
                v = incoming[0].1 as usize;
            }
            _ => return None,
        }
    }
    None
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{Block, FunctionSsa, NO_VALUE, ValueId};
    use alloc::vec;

    fn fresh(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            n_params: 0,
            is_variadic: false,
            is_inline: false,
            is_always_inline: false,
            is_naked: false,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            param_fp_mask: 0,
            agg_descs: alloc::vec::Vec::new(),
            param_aggs: alloc::vec::Vec::new(),
            param_local_slots: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            ret_type_tag: 0,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            jump_tables: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
            has_returns_twice_call: false,
            did_unroll: false,
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
}
