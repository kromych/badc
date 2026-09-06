//! Critical-edge splitting.
//!
//! The per-arch emit places phi-moves for a successor's phis at the
//! end of the predecessor, before its terminator. A predecessor with
//! more than one successor therefore runs those moves on every one of
//! its edges, clobbering whatever register the phi's destination holds
//! on the paths the phi does not reach.
//!
//! The condition the emit needs is exactly: a block with more than one
//! successor must have no successor carrying a phi that names it. That
//! is the classic critical edge -- a phi block has two or more
//! predecessors -- stated as the property the emit reads, so a phi
//! reached over a single edge is covered too.
//!
//! The fix: for every such edge, insert a synthetic empty block that
//! lives only on that edge. It holds the phi-moves and an
//! unconditional jump to the original successor. The pred's
//! conditional branch now targets the synthetic block, so the moves
//! execute only when the edge is taken.
//!
//! Pass runs after `ssa_mem2reg` / `inline` / `rotate` /
//! `constfold_branch`, all of which can change the CFG. Each
//! split inserts one `Terminator::Jmp` block; the inst range stays
//! empty so the emit's per-block walk sees no body instructions and
//! falls straight to `emit_phi_predecessor_moves` + the terminator.

use alloc::vec::Vec;

use crate::c5::ir::{Block, BlockId, FunctionSsa, Inst, Terminator};

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs {
        run_one(func);
    }
}

/// True when `succ` opens with a phi that names `pred`, i.e. the edge
/// `pred -> succ` carries predecessor-exit moves. Phis lead a block, so
/// the scan stops at the first non-phi.
fn edge_carries_phi_moves(func: &FunctionSsa, pred: BlockId, succ: BlockId) -> bool {
    for id in func.blocks[succ as usize].inst_range.clone() {
        let Inst::Phi { incoming, .. } = &func.insts[id as usize] else {
            break;
        };
        if incoming.iter().any(|(b, _)| *b == pred) {
            return true;
        }
    }
    false
}

fn run_one(func: &mut FunctionSsa) {
    let n_original = func.blocks.len();
    if n_original == 0 {
        return;
    }
    // Splits to apply, deferred so we don't mutate the block list
    // while we walk it. Each entry is `(pred, original_succ)`.
    let mut splits: Vec<(BlockId, BlockId)> = Vec::new();
    for (idx, block) in func.blocks.iter().enumerate().take(n_original) {
        // An indirect branch reads an address-taken label's own block
        // address, so its edges cannot be routed through a synthetic
        // block. `emit_phi_predecessor_moves` refuses a function whose
        // computed-goto target carries a phi rather than run the moves
        // on every one of the branch's edges.
        if matches!(block.terminator, Terminator::GotoIndirect { .. }) {
            continue;
        }
        let succs = successors(&block.terminator, &func.jump_tables);
        if succs.len() < 2 {
            continue;
        }
        let first = splits.len();
        for succ in succs {
            if (succ as usize) >= n_original {
                continue;
            }
            // One split per (pred, succ) pair: a `Bz target=S
            // fall_through=S` names the same successor twice, and both
            // arms route through the one synthetic block.
            if splits[first..].iter().any(|&(_, s)| s == succ) {
                continue;
            }
            // Skip an edge the emit produces no moves for: without a phi
            // naming this predecessor there is nothing to run on the
            // alternate edge.
            if !edge_carries_phi_moves(func, idx as BlockId, succ) {
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
            exit_acc: crate::c5::ir::NO_VALUE,
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
            // Retarget every table entry naming the split successor;
            // repeated entries (case-value holes on the default block)
            // all route through the one synthetic block. An asm-goto
            // row is retargeted the same way: the label branch lands
            // on the synthetic block, which runs the phi-moves and
            // jumps on.
            Terminator::JumpTable { table, .. } | Terminator::AsmGoto { table } => {
                for t in func.jump_tables[table as usize].iter_mut() {
                    if *t == original_succ {
                        *t = new_id;
                    }
                }
                term
            }
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

fn successors(term: &Terminator, jump_tables: &[Vec<BlockId>]) -> Vec<BlockId> {
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
        // Distinct targets only, so a table's repeated entries yield
        // one split per (pred, succ) edge.
        Terminator::JumpTable { table, .. } | Terminator::AsmGoto { table } => {
            let mut out: Vec<BlockId> = Vec::new();
            for &t in &jump_tables[*table as usize] {
                if !out.contains(&t) {
                    out.push(t);
                }
            }
            out
        }
        // An indirect branch's successors live on the function, not the
        // terminator; `run_one` skips such a predecessor outright.
        Terminator::GotoIndirect { .. }
        | Terminator::Return(_)
        | Terminator::TailExt(_)
        | Terminator::Unreachable => Vec::new(),
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::{Block, FunctionSsa, Inst, LoadKind, NO_VALUE, Terminator};
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

    /// A conditional whose merge block carries a phi: the split must happen
    /// even though the function records an address-taken label. Taking a
    /// label's address without ever branching to it (the kernel's
    /// `_THIS_IP_`) leaves `computed_goto_targets` non-empty in a function
    /// the inliner has already given phis.
    #[test]
    fn address_taken_label_does_not_block_the_split() {
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
        f.computed_goto_targets = alloc::vec![1];
        run_one(&mut f);
        assert_eq!(f.blocks.len(), 4);
        assert!(matches!(
            f.blocks[0].terminator,
            Terminator::Bz {
                target: 3,
                fall_through: 1,
                ..
            }
        ));
        assert!(matches!(f.blocks[3].terminator, Terminator::Jmp(2)));
        // The label's block id is what `Inst::BlockAddr` and the target
        // list name, so the split must leave it alone.
        assert_eq!(f.computed_goto_targets, alloc::vec![1]);
        let Inst::Phi { incoming, .. } = &f.insts[2] else {
            panic!("expected phi");
        };
        assert!(incoming.iter().any(|(b, _)| *b == 3));
        assert!(!incoming.iter().any(|(b, _)| *b == 0));
    }

    /// The condition is the one the emit reads: a phi naming a
    /// two-successor predecessor. A single-predecessor successor is split
    /// too -- its moves would otherwise run on the alternate edge.
    #[test]
    fn single_predecessor_phi_edge_is_split() {
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Phi {
                    incoming: alloc::vec![(0, 0)],
                    kind: LoadKind::I64,
                },
                Inst::Imm(2),
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
        run_one(&mut f);
        assert_eq!(f.blocks.len(), 4);
        assert!(matches!(
            f.blocks[0].terminator,
            Terminator::Bz {
                target: 3,
                fall_through: 2,
                ..
            }
        ));
        let Inst::Phi { incoming, .. } = &f.insts[1] else {
            panic!("expected phi");
        };
        assert_eq!(incoming.as_slice(), &[(3, 0)]);
    }

    /// A successor named by both arms takes one synthetic block, and the
    /// phi's single incoming is renamed once.
    #[test]
    fn successor_named_by_both_arms_splits_once() {
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Phi {
                    incoming: alloc::vec![(0, 0)],
                    kind: LoadKind::I64,
                },
            ],
            vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..1,
                    terminator: Terminator::Bz {
                        cond: 0,
                        target: 1,
                        fall_through: 1,
                    },
                    exit_acc: 0,
                },
                Block {
                    start_pc: 0,
                    inst_range: 1..2,
                    terminator: Terminator::Return(1),
                    exit_acc: 1,
                },
            ],
        );
        run_one(&mut f);
        assert_eq!(f.blocks.len(), 3);
        assert!(matches!(
            f.blocks[0].terminator,
            Terminator::Bz {
                target: 2,
                fall_through: 2,
                ..
            }
        ));
        let Inst::Phi { incoming, .. } = &f.insts[1] else {
            panic!("expected phi");
        };
        assert_eq!(incoming.as_slice(), &[(2, 0)]);
    }

    /// An indirect branch reads a label's own block address, so its edges
    /// cannot be routed through a synthetic block. The pass leaves them; the
    /// emit refuses such a function instead.
    #[test]
    fn goto_indirect_predecessor_is_left_alone() {
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Phi {
                    incoming: alloc::vec![(0, 0)],
                    kind: LoadKind::I64,
                },
                Inst::Imm(2),
            ],
            vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..1,
                    terminator: Terminator::GotoIndirect { target: 0 },
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
        f.computed_goto_targets = alloc::vec![1, 2];
        let n_before = f.blocks.len();
        run_one(&mut f);
        assert_eq!(f.blocks.len(), n_before);
    }

    #[test]
    fn jump_table_entries_retargeted_to_trampoline() {
        // b0 -[JumpTable [1, 2, 1]]-> b1 (phi), b2 (no phi)
        // b3 -[Jmp]-> b1
        // b1 has two predecessors and a phi, so both table entries
        // naming it must retarget to one synthetic trampoline; the
        // phi's b0 incoming renames to the trampoline. b2 has a
        // single predecessor and stays a direct entry.
        let mut f = fresh(
            vec![
                Inst::Imm(0),
                Inst::Phi {
                    incoming: alloc::vec![(0, 0), (3, 3)],
                    kind: LoadKind::I64,
                },
                Inst::Imm(2),
                Inst::Imm(3),
            ],
            vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..1,
                    terminator: Terminator::JumpTable { idx: 0, table: 0 },
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
                Block {
                    start_pc: 0,
                    inst_range: 3..4,
                    terminator: Terminator::Jmp(1),
                    exit_acc: 3,
                },
            ],
        );
        f.jump_tables = alloc::vec![alloc::vec![1, 2, 1]];
        run_one(&mut f);
        assert_eq!(f.blocks.len(), 5);
        assert!(matches!(
            f.blocks[0].terminator,
            Terminator::JumpTable { idx: 0, table: 0 }
        ));
        assert_eq!(f.jump_tables[0], alloc::vec![4, 2, 4]);
        assert!(matches!(f.blocks[4].terminator, Terminator::Jmp(1)));
        assert_eq!(f.blocks[4].inst_range.len(), 0);
        let Inst::Phi { incoming, .. } = &f.insts[1] else {
            panic!("expected phi");
        };
        assert!(incoming.iter().any(|(b, _)| *b == 4));
        assert!(incoming.iter().any(|(b, _)| *b == 3));
        assert!(!incoming.iter().any(|(b, _)| *b == 0));
    }
}
