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

use crate::c5::ir::{FunctionSsa, Inst, Terminator};

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
    for block in func.blocks.iter_mut() {
        let new_term = match block.terminator {
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => fold(func.insts.as_slice(), cond)
                .map(|k| Terminator::Jmp(if k == 0 { target } else { fall_through })),
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => fold(func.insts.as_slice(), cond)
                .map(|k| Terminator::Jmp(if k != 0 { target } else { fall_through })),
            // A constant in-range index selects one table entry; out of
            // range the terminator is unreachable (the lowering's bounds
            // check precedes it) and is left alone.
            Terminator::JumpTable { idx, table } => fold(func.insts.as_slice(), idx)
                .and_then(|k| {
                    func.jump_tables[table as usize]
                        .get(k as u64 as usize)
                        .copied()
                })
                .map(Terminator::Jmp),
            _ => None,
        };
        if let Some(t) = new_term {
            block.terminator = t;
            changed = true;
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
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            param_fp_mask: 0,
            agg_descs: alloc::vec::Vec::new(),
            param_aggs: alloc::vec::Vec::new(),
            param_local_slots: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
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
