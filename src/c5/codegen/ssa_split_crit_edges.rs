//! Critical-edge splitting.
//!
//! A CFG edge `pred -> succ` is *critical* when `pred` has more than
//! one successor and `succ` has more than one predecessor. The
//! per-arch emit places phi-moves for `succ`'s phis at the end of
//! `pred`, before the conditional branch. Along the alternate
//! successor's edge, those moves still execute and clobber any
//! register that is live on the alternate path -- the
//! tdefl_flush_output_buffer shape under PHI_PROMOTE.
//!
//! The fix: for every critical edge, insert a synthetic empty block
//! that lives only on that edge. It holds the phi-moves and an
//! unconditional jump to the original successor. The pred's
//! conditional branch now targets the synthetic block, so the moves
//! execute only when the edge is taken.
//!
//! Pass runs after `ssa_mem2reg` / `ssa_inline` / `ssa_rotate` /
//! `ssa_constfold_branch`, all of which can change the CFG. Each
//! split inserts one `Terminator::Jmp` block; the inst range stays
//! empty so the emit's per-block walk sees no body instructions and
//! falls straight to `emit_phi_predecessor_moves` + the terminator.

use alloc::vec::Vec;

use super::super::ir::{Block, BlockId, FunctionSsa, Inst, Terminator};

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs {
        run_one(func);
    }
}

fn run_one(func: &mut FunctionSsa) {
    let n_original = func.blocks.len();
    if n_original == 0 {
        return;
    }
    // Skip computed-goto functions: inserting split blocks renumbers
    // block ids, which `Inst::BlockAddr` and computed_goto_targets
    // reference directly. Such functions carry no phis (mem2reg is
    // skipped for them), so there are no critical edges to split.
    if !func.computed_goto_targets.is_empty() {
        return;
    }
    // Count predecessors per block. Walking terminators is enough.
    let mut pred_count: Vec<u32> = alloc::vec![0; n_original];
    for block in &func.blocks {
        for succ in successors(&block.terminator) {
            if (succ as usize) < n_original {
                pred_count[succ as usize] += 1;
            }
        }
    }
    // Splits to apply, deferred so we don't mutate the block list
    // while we walk it. Each entry is `(pred, original_succ)`.
    let mut splits: Vec<(BlockId, BlockId)> = Vec::new();
    for (idx, block) in func.blocks.iter().enumerate().take(n_original) {
        let succs = successors(&block.terminator);
        if succs.len() < 2 {
            continue;
        }
        for succ in succs {
            if (succ as usize) >= n_original {
                continue;
            }
            if pred_count[succ as usize] <= 1 {
                continue;
            }
            // Skip when the successor has no phis. Without phis the
            // emit produces no predecessor-exit moves on this edge,
            // so the clobber-on-alternate-edge hazard cannot fire.
            let range = func.blocks[succ as usize].inst_range.clone();
            let has_phi = range
                .clone()
                .any(|id| matches!(func.insts[id as usize], Inst::Phi { .. }));
            if !has_phi {
                continue;
            }
            splits.push((idx as BlockId, succ));
        }
    }
    if splits.is_empty() {
        return;
    }
    // Each split appends one block whose inst_range is empty (a
    // zero-length window past `insts.len()`). The per-arch emit
    // skips the body loop trivially and falls through to the
    // phi-move + terminator pass.
    let insts_end = func.insts.len() as u32;
    for (pred, original_succ) in splits {
        let new_id = func.blocks.len() as BlockId;
        func.blocks.push(Block {
            start_pc: 0,
            inst_range: insts_end..insts_end,
            terminator: Terminator::Jmp(original_succ),
            exit_acc: super::super::ir::NO_VALUE,
        });
        // Rewire the predecessor's terminator: every reference to
        // `original_succ` becomes `new_id`. A predecessor may
        // legitimately reference the same successor via both arms
        // (`Bz target=S fall_through=S`); in that case both arms
        // route through the same synthetic block, which still
        // produces the right phi-moves once per edge taken.
        let term = func.blocks[pred as usize].terminator;
        let new_term = match term {
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => Terminator::Bz {
                cond,
                target: if target == original_succ {
                    new_id
                } else {
                    target
                },
                fall_through: if fall_through == original_succ {
                    new_id
                } else {
                    fall_through
                },
            },
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => Terminator::Bnz {
                cond,
                target: if target == original_succ {
                    new_id
                } else {
                    target
                },
                fall_through: if fall_through == original_succ {
                    new_id
                } else {
                    fall_through
                },
            },
            other => other,
        };
        func.blocks[pred as usize].terminator = new_term;
        // Rewire phi incomings at the original successor: every
        // entry naming `pred` now names `new_id`. Each split owns
        // a unique (pred, original_succ) pair, so this never
        // double-rewrites a single phi incoming.
        let start = func.blocks[original_succ as usize].inst_range.start;
        let end = func.blocks[original_succ as usize].inst_range.end;
        for id in start..end {
            let inst = &mut func.insts[id as usize];
            let Inst::Phi { incoming, .. } = inst else {
                continue;
            };
            for (b, _) in incoming.iter_mut() {
                if *b == pred {
                    *b = new_id;
                }
            }
        }
    }
}

fn successors(term: &Terminator) -> Vec<BlockId> {
    match term {
        Terminator::Jmp(b) | Terminator::FallThrough(b) => alloc::vec![*b],
        Terminator::Bz {
            target,
            fall_through,
            ..
        }
        | Terminator::Bnz {
            target,
            fall_through,
            ..
        } => alloc::vec![*target, *fall_through],
        // This pass is skipped for functions with a computed goto (its
        // run() guards on computed_goto_targets), so an indirect branch
        // never reaches here; its successors live on the function, not
        // the terminator.
        Terminator::GotoIndirect { .. } | Terminator::Return(_) | Terminator::TailExt(_) => {
            Vec::new()
        }
    }
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{Block, FunctionSsa, Inst, LoadKind, NO_VALUE, Terminator};
    use super::*;
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
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
            insts,
            blocks,
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        }
    }

    #[test]
    fn straight_line_function_no_split() {
        let mut f = fresh(
            vec![Inst::Imm(0)],
            vec![Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Return(0),
                exit_acc: 0,
            }],
        );
        let n_before = f.blocks.len();
        run_one(&mut f);
        assert_eq!(f.blocks.len(), n_before);
    }

    #[test]
    fn non_critical_edge_does_not_split() {
        // b0 -[Bz]-> b1 (single pred), fall b2 (single pred).
        // Neither successor has another predecessor, so no edge
        // is critical.
        let mut f = fresh(
            vec![Inst::Imm(0), Inst::Imm(1), Inst::Imm(2)],
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
                },
                Block {
                    start_pc: 0,
                    inst_range: 1..2,
                    terminator: Terminator::Return(1),
                    exit_acc: 1,
                },
                Block {
                    start_pc: 0,
                    inst_range: 2..3,
                    terminator: Terminator::Return(2),
                    exit_acc: 2,
                },
            ],
        );
        let n_before = f.blocks.len();
        run_one(&mut f);
        assert_eq!(f.blocks.len(), n_before);
    }

    #[test]
    fn critical_edge_gets_split_and_phi_incoming_rewired() {
        // CFG: b0 -[Bz]-> b3 (taken), fall b1
        //      b1 -[Jmp]-> b3
        //      b2 (unreachable header for the test) -> b3
        // b3 has a phi merging from b0 and b1 (two predecessors).
        // The b0 -> b3 edge is critical: b0 has 2 successors and
        // b3 has 2+ predecessors.
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Imm(1),
                Inst::Phi {
                    incoming: alloc::vec![(0, 0), (1, 1)],
                    kind: LoadKind::I64,
                },
            ],
            vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..1,
                    terminator: Terminator::Bz {
                        cond: 0,
                        target: 2,
                        fall_through: 1,
                    },
                    exit_acc: 0,
                },
                Block {
                    start_pc: 0,
                    inst_range: 1..2,
                    terminator: Terminator::Jmp(2),
                    exit_acc: 1,
                },
                Block {
                    start_pc: 0,
                    inst_range: 2..3,
                    terminator: Terminator::Return(2),
                    exit_acc: 2,
                },
            ],
        );
        run_one(&mut f);
        // One critical edge -> one synthetic block appended.
        assert_eq!(f.blocks.len(), 4);
        // b0's terminator points to the new block on the taken
        // arm; fall_through stays unchanged.
        assert!(matches!(
            f.blocks[0].terminator,
            Terminator::Bz {
                target: 3,
                fall_through: 1,
                ..
            }
        ));
        // The synthetic block jumps to the original successor and
        // has an empty inst range.
        assert!(matches!(f.blocks[3].terminator, Terminator::Jmp(2)));
        assert_eq!(f.blocks[3].inst_range.len(), 0);
        // b2's phi now reads from the synthetic block id on the
        // arm that was rewritten; the other arm (b1) is unchanged.
        let Inst::Phi { incoming, .. } = &f.insts[2] else {
            panic!("expected phi");
        };
        assert!(incoming.iter().any(|(b, _)| *b == 3));
        assert!(incoming.iter().any(|(b, _)| *b == 1));
        assert!(!incoming.iter().any(|(b, _)| *b == 0));
    }

    #[test]
    fn synthetic_block_has_no_value_exit_acc() {
        // Single critical edge as above; verify exit_acc is the
        // NO_VALUE sentinel so the emit's accumulator threading
        // sees a clean predecessor.
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Imm(1),
                Inst::Phi {
                    incoming: alloc::vec![(0, 0), (1, 1)],
                    kind: LoadKind::I64,
                },
            ],
            vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..1,
                    terminator: Terminator::Bz {
                        cond: 0,
                        target: 2,
                        fall_through: 1,
                    },
                    exit_acc: 0,
                },
                Block {
                    start_pc: 0,
                    inst_range: 1..2,
                    terminator: Terminator::Jmp(2),
                    exit_acc: 1,
                },
                Block {
                    start_pc: 0,
                    inst_range: 2..3,
                    terminator: Terminator::Return(2),
                    exit_acc: 2,
                },
            ],
        );
        run_one(&mut f);
        assert_eq!(f.blocks[3].exit_acc, NO_VALUE);
    }
}
