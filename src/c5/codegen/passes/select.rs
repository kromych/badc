//! Diamond-to-select conversion (C99 6.5.15 and an if-else over pure
//! values).
//!
//! A branch whose two arms only carry their merged value -- each arm
//! holds dead-pure instructions and jumps to a join whose single phi
//! takes exactly those two edges -- becomes one [`Inst::Select`] at the
//! end of the branch block. The arms stay a branch unless both values
//! are cheap to evaluate speculatively ([`speculable`]): C99 6.5.15
//! evaluates exactly one arm, so an arm with an observable evaluation
//! -- a call, a store, a load, a divide -- keeps its branch. The same
//! holds for a value the branch block does not dominate, which a
//! select there could not read.
//!
//! The select's condition is the branch's, so the allocator's
//! comparison fusion turns the pair into one `cmp` + `csel` /
//! `cmovcc` with no materialised boolean. The orphaned arm blocks fall
//! to [`super::prune_unreachable`].

use alloc::collections::BTreeSet;
use alloc::vec::Vec;

use crate::c5::codegen::ssa::mem2reg::{DomOrder, SuccGraph, dominators_of, predecessors};
use crate::c5::codegen::ssa::reg_alloc::compute_use_counts;
use crate::c5::codegen::ssa::tape::{self, At, Insertion};
use crate::c5::ir::{BinOp, BlockId, FunctionSsa, Inst, LoadKind, NO_VALUE, Terminator, ValueId};

/// Whether evaluating `v` is unobservable and non-trapping, so a
/// select may evaluate it on both sides where C99 6.5.15 evaluates
/// one. Register-resident integer arithmetic only: no load (a
/// faulting address), no divide (a zero divisor), no call, no FP.
pub(crate) fn speculable(func: &FunctionSsa, v: ValueId) -> bool {
    if func.f32_values.get(v as usize).copied().unwrap_or(false) {
        return false;
    }
    match func.insts.get(v as usize) {
        Some(
            Inst::Imm(_)
            | Inst::ImmData(_)
            | Inst::ImmCode(_)
            | Inst::ImmExtCode(_)
            | Inst::BlockAddr(_)
            | Inst::LocalAddr(_)
            | Inst::TlsAddr(_)
            | Inst::ParamRef { .. }
            | Inst::ParamPart { .. }
            | Inst::Extend { .. }
            | Inst::Bswap { .. }
            | Inst::BitCount { .. }
            | Inst::Neg(_)
            | Inst::Copy { .. },
        ) => true,
        Some(Inst::Binop { op, .. } | Inst::BinopI { op, .. }) => !matches!(
            op,
            BinOp::Div
                | BinOp::Mod
                | BinOp::Divu
                | BinOp::Modu
                | BinOp::Mulh
                | BinOp::Mulhu
                | BinOp::Fadd
                | BinOp::Fsub
                | BinOp::Fmul
                | BinOp::Fdiv
                | BinOp::Feq
                | BinOp::Fne
                | BinOp::Flt
                | BinOp::Fgt
                | BinOp::Fle
                | BinOp::Fge
        ),
        _ => false,
    }
}

/// One convertible diamond: the branch block, its condition, the two
/// arm blocks, the join, and the join's phi with its two incomes.
struct Diamond {
    h: BlockId,
    t: BlockId,
    f: BlockId,
    join: BlockId,
    cond: ValueId,
    phi: ValueId,
    on_true: ValueId,
    on_false: ValueId,
}

/// Convert every convertible diamond. Returns whether any converted;
/// the caller prunes the orphaned arm blocks.
pub(crate) fn run_one(func: &mut FunctionSsa) -> bool {
    let uses = compute_use_counts(func);
    let preds = predecessors(func);
    let graph = SuccGraph::new(func);
    let idom = dominators_of(&graph);
    let dom = DomOrder::build(&idom);
    let mut block_of = alloc::vec![BlockId::MAX; func.insts.len()];
    for (b, blk) in func.blocks.iter().enumerate() {
        for v in blk.inst_range.clone() {
            block_of[v as usize] = b as BlockId;
        }
    }
    let dominated_by_h = |v: ValueId, h: BlockId| -> bool {
        let db = block_of.get(v as usize).copied().unwrap_or(BlockId::MAX);
        db == h || dom.dominates(db, h, &idom)
    };
    // Blocks a conversion may not remove: address-taken labels and
    // jump-table targets.
    let mut pinned: BTreeSet<BlockId> = func.computed_goto_targets.iter().copied().collect();
    for row in &func.jump_tables {
        pinned.extend(row.iter().copied());
    }
    let mut diamonds: Vec<Diamond> = Vec::new();
    for (h, blk) in func.blocks.iter().enumerate() {
        let (cond, t, f) = match blk.terminator {
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => (cond, fall_through, target),
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => (cond, target, fall_through),
            _ => continue,
        };
        let h = h as BlockId;
        if cond == NO_VALUE
            || t == f
            || pinned.contains(&t)
            || pinned.contains(&f)
            || preds[t as usize].as_slice() != [h]
            || preds[f as usize].as_slice() != [h]
        {
            continue;
        }
        let (bt, bf) = (&func.blocks[t as usize], &func.blocks[f as usize]);
        let (Terminator::Jmp(jt), Terminator::Jmp(jf)) = (bt.terminator, bf.terminator) else {
            continue;
        };
        if jt != jf {
            continue;
        }
        let j = jt;
        if preds[j as usize].len() != 2
            || !preds[j as usize].contains(&t)
            || !preds[j as usize].contains(&f)
        {
            continue;
        }
        // A live definition in an arm would vanish with the block.
        let dead_range = |r: &core::ops::Range<u32>| {
            r.clone().all(|v| {
                let inst = &func.insts[v as usize];
                inst.is_lifetime_marker() || (inst.is_pure() && uses[v as usize] == 0)
            })
        };
        if !dead_range(&bt.inst_range) || !dead_range(&bf.inst_range) {
            continue;
        }
        // The join's single phi; a merge of more than one value keeps
        // its branch until the shared condition fuses for several
        // selects at once.
        let bj = &func.blocks[j as usize];
        let (phi, on_true, on_false) = match func.insts.get(bj.inst_range.start as usize) {
            Some(Inst::Phi { incoming, kind }) if *kind == LoadKind::I64 && incoming.len() == 2 => {
                let income = |p: BlockId| {
                    incoming
                        .iter()
                        .find(|&&(q, _)| q == p)
                        .map(|&(_, v)| v)
                        .unwrap_or(NO_VALUE)
                };
                let (vt, vf) = (income(t), income(f));
                if vt == NO_VALUE
                    || vf == NO_VALUE
                    || !speculable(func, vt)
                    || !speculable(func, vf)
                    || !dominated_by_h(vt, h)
                    || !dominated_by_h(vf, h)
                {
                    continue;
                }
                (bj.inst_range.start, vt, vf)
            }
            _ => continue,
        };
        diamonds.push(Diamond {
            h,
            t,
            f,
            join: j,
            cond,
            phi,
            on_true,
            on_false,
        });
    }
    if diamonds.is_empty() {
        return false;
    }
    // One select per diamond, at the end of the branch block so the
    // condition and the select stay adjacent for the fusion. Sort by
    // insertion point first: block ids do not follow the tape (a
    // nested construct fills its blocks out of id order), and the
    // tape insertion expects ascending positions.
    let at_of = |d: &Diamond| -> At {
        match func.blocks[d.h as usize].inst_range.end.checked_sub(1) {
            Some(last) => At::After(last),
            None => At::Empty(d.h),
        }
    };
    diamonds.sort_by_key(|d| at_of(d).order(&func.blocks));
    let mut ins: Vec<Insertion> = Vec::new();
    for d in &diamonds {
        ins.push(Insertion {
            at: at_of(d),
            inst: Inst::Select {
                cond: d.cond,
                on_true: d.on_true,
                on_false: d.on_false,
            },
            is_f32: false,
        });
    }
    let (rewrite, _undo) = tape::insert(func, &ins);
    // The join's phi readers read the select now; the phi merges
    // nothing and turns inert.
    for (d, sel) in diamonds.iter().zip(rewrite.ids.iter()) {
        let old_phi = rewrite.remap[d.phi as usize];
        let mut swap = |v: &mut ValueId| {
            if *v == old_phi {
                *v = *sel;
            }
        };
        for inst in func.insts.iter_mut() {
            inst.for_each_operand_mut(&mut swap);
        }
        for block in func.blocks.iter_mut() {
            swap(&mut block.exit_acc);
            block.terminator.for_each_operand_mut(&mut swap);
        }
        func.insts[old_phi as usize] = Inst::Imm(0);
    }
    // The branch points straight at the join; the arm blocks orphan
    // and their instructions turn inert so no dead reader keeps a
    // value alive.
    for d in &diamonds {
        func.blocks[d.h as usize].terminator = Terminator::Jmp(d.join);
        for b in [d.t, d.f] {
            for v in func.blocks[b as usize].inst_range.clone() {
                func.insts[v as usize] = Inst::Imm(0);
            }
        }
    }
    super::prune_unreachable::run_one(func);
    true
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::Block;

    fn func(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            inst_src: alloc::vec![(0, 0); n],
            f32_values: alloc::vec![false; n],
            insts,
            blocks,
            ..Default::default()
        }
    }

    fn block(range: core::ops::Range<u32>, terminator: Terminator, exit_acc: ValueId) -> Block {
        Block {
            start_pc: 0,
            inst_range: range,
            terminator,
            exit_acc,
        }
    }

    fn phi(incoming: Vec<(BlockId, ValueId)>) -> Inst {
        Inst::Phi {
            incoming,
            kind: LoadKind::I64,
        }
    }

    fn select_count(func: &FunctionSsa) -> usize {
        func.insts
            .iter()
            .filter(|i| matches!(i, Inst::Select { .. }))
            .count()
    }

    /// `int tern(int a, int b, int c) { return c ? a : b; }` as mem2reg
    /// leaves it: block 0 branches on the third parameter, blocks 1 and
    /// 3 carry the arm values in their exit accumulators over dead
    /// immediates, block 2 joins them in a phi.
    fn build_tern() -> FunctionSsa {
        func(
            vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I32,
                }, // v0 (b0)
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I32,
                }, // v1 (b0)
                Inst::ParamRef {
                    idx: 2,
                    kind: LoadKind::I32,
                }, // v2 (b0)
                Inst::Imm(0),              // v3 (b1, dead)
                Inst::Imm(0),              // v4 (b3, dead)
                phi(vec![(1, 0), (3, 1)]), // v5 (b2)
            ],
            vec![
                block(
                    0..3,
                    Terminator::Bz {
                        cond: 2,
                        target: 3,
                        fall_through: 1,
                    },
                    2,
                ),
                block(3..4, Terminator::Jmp(2), 0),
                block(5..6, Terminator::Return(5), 5),
                block(4..5, Terminator::Jmp(2), 1),
            ],
        )
    }

    #[test]
    fn a_ternary_diamond_with_dead_arms_becomes_a_select() {
        let mut f = build_tern();
        assert!(run_one(&mut f), "the diamond converts");
        assert_eq!(select_count(&f), 1, "one select replaces the phi");
        assert_eq!(f.blocks.len(), 2, "the arm blocks are pruned");
        let Inst::Select {
            cond,
            on_true,
            on_false,
        } = f
            .insts
            .iter()
            .find_map(|i| match i {
                Inst::Select {
                    cond,
                    on_true,
                    on_false,
                } => Some((*cond, *on_true, *on_false)),
                _ => None,
            })
            .map(|(cond, on_true, on_false)| Inst::Select {
                cond,
                on_true,
                on_false,
            })
            .unwrap()
        else {
            panic!("expected a select");
        };
        assert_eq!(cond, 2, "the select tests the branch condition");
        assert_eq!(on_true, 0, "the fall-through arm is the true arm");
        assert_eq!(on_false, 1, "the taken arm is the false arm");
    }

    #[test]
    fn an_arm_with_a_live_computation_keeps_its_branch() {
        // The first arm's value is computed inside the arm block, so
        // the block holds a live instruction and the conversion cannot
        // remove it (nor would the branch block dominate the value).
        let mut f = func(
            vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I32,
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I32,
                },
                Inst::ParamRef {
                    idx: 2,
                    kind: LoadKind::I32,
                },
                Inst::BinopI {
                    op: BinOp::Add,
                    lhs: 0,
                    rhs_imm: 1,
                },
                phi(vec![(1, 3), (3, 1)]),
            ],
            vec![
                block(
                    0..3,
                    Terminator::Bz {
                        cond: 2,
                        target: 3,
                        fall_through: 1,
                    },
                    2,
                ),
                block(3..4, Terminator::Jmp(2), 3),
                block(4..5, Terminator::Return(4), 4),
                block(4..4, Terminator::Jmp(2), 1),
            ],
        );
        assert!(!run_one(&mut f), "a computed arm keeps its branch");
        assert_eq!(select_count(&f), 0);
    }

    #[test]
    fn a_load_arm_keeps_its_branch() {
        // The load sits in the branch block, so the rule that fires is
        // the speculation one: evaluating a load on the untaken side
        // may fault where the branch never would.
        let mut f = func(
            vec![
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I32,
                },
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I32,
                },
                Inst::ParamRef {
                    idx: 2,
                    kind: LoadKind::I32,
                },
                Inst::LoadLocal {
                    off: -1,
                    kind: LoadKind::I32,
                    volatile: false,
                },
                Inst::Imm(0),
                phi(vec![(1, 3), (3, 1)]),
            ],
            vec![
                block(
                    0..4,
                    Terminator::Bz {
                        cond: 2,
                        target: 3,
                        fall_through: 1,
                    },
                    2,
                ),
                block(4..5, Terminator::Jmp(2), 3),
                block(5..6, Terminator::Return(5), 5),
                block(5..5, Terminator::Jmp(2), 1),
            ],
        );
        assert!(!run_one(&mut f), "a loaded arm keeps its branch");
        assert_eq!(select_count(&f), 0);
    }

    /// Two diamonds whose block ids run against the tape order: the
    /// first-discovered diamond's branch block holds the later
    /// instructions. The inserts sort by tape position, which the tape
    /// insertion requires.
    #[test]
    fn diamonds_out_of_block_order_still_insert_sorted() {
        let mut f = func(
            vec![
                // The later-id diamond's blocks, first on the tape.
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I32,
                }, // v0 (b5)
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I32,
                }, // v1 (b5)
                Inst::ParamRef {
                    idx: 2,
                    kind: LoadKind::I32,
                }, // v2 (b5)
                Inst::Imm(0),              // v3 (b6)
                Inst::Imm(0),              // v4 (b7)
                phi(vec![(6, 0), (7, 1)]), // v5 (b8)
                // The earlier-id diamond's blocks, later on the tape.
                Inst::ParamRef {
                    idx: 0,
                    kind: LoadKind::I32,
                }, // v6 (b4)
                Inst::ParamRef {
                    idx: 1,
                    kind: LoadKind::I32,
                }, // v7 (b4)
                Inst::ParamRef {
                    idx: 2,
                    kind: LoadKind::I32,
                }, // v8 (b4)
                Inst::Imm(0),              // v9 (b1)
                Inst::Imm(0),              // v10 (b2)
                phi(vec![(1, 6), (2, 7)]), // v11 (b3)
            ],
            vec![
                block(6..6, Terminator::Jmp(5), NO_VALUE), // b0 entry
                block(9..10, Terminator::Jmp(3), 6),       // b1
                block(10..11, Terminator::Jmp(3), 7),      // b2
                block(11..12, Terminator::Return(11), 11), // b3
                block(
                    6..9,
                    Terminator::Bz {
                        cond: 8,
                        target: 2,
                        fall_through: 1,
                    },
                    8,
                ), // b4
                block(
                    0..3,
                    Terminator::Bz {
                        cond: 2,
                        target: 7,
                        fall_through: 6,
                    },
                    2,
                ), // b5
                block(3..4, Terminator::Jmp(8), 0),        // b6
                block(4..5, Terminator::Jmp(8), 1),        // b7
                block(5..6, Terminator::Jmp(4), 5),        // b8
            ],
        );
        assert!(run_one(&mut f), "both diamonds convert");
        assert_eq!(select_count(&f), 2, "one select per diamond");
        assert_eq!(
            crate::c5::codegen::ssa::verify::check(&f),
            Ok(()),
            "the converted function stays well-formed"
        );
    }
}
