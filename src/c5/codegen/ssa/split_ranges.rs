//! Live-range splitting for values the allocator spilled.
//!
//! [`super::reg_alloc::allocate`] gives every SSA value one `Place` for
//! its whole live range, so a value that spills reloads at each of its
//! use sites -- including sites in a region where nothing forces it to
//! memory. A range that crosses one cold call is spilled everywhere,
//! and a loop body that only reads it pays a reload per read per
//! iteration.
//!
//! This pass gives such a value a second, shorter range the allocator
//! places on its own. It finds maximal runs of uses separated by no call
//! (and by no other instruction with register machinery of its own),
//! inserts an `Inst::Copy` of the value ahead of the run's first use,
//! and points the run's uses at the copy. The copy's range spans the run
//! only: it crosses no call, so it is not forced into a callee-saved
//! register, and the allocator can hand it a caller-saved one the rest
//! of the value's range could not have taken.
//!
//! A run covers one block, plus any block that follows it on the
//! instruction tape and has it as the only predecessor -- control
//! reaches such a block only through the run, so the copy dominates it.
//!
//! Correctness follows from SSA: the copy is dominated by the value's
//! definition (it sits where the value is already used), the value has a
//! single definition and so cannot change between the copy and the
//! rewritten uses, and every rewritten use is at a later point on the
//! tape. Phi operands are edge uses and terminator operands sit outside
//! every run, so neither is rewritten; a block's leading phi run is
//! never disturbed, since a copy only ever goes ahead of a non-phi use.
//!
//! Placement quality is not assumed: the function is allocated a second
//! time and the split is kept only when the loop-weighted count of
//! spill-slot accesses and copies drops. Otherwise the instruction tape
//! is restored and the first allocation returned, so the pass cannot
//! leave a function worse than the unsplit baseline. That guard is why
//! it runs at `-O` rather than behind a tier of its own.

use alloc::vec;
use alloc::vec::Vec;

use super::super::ir::{Block, FunctionSsa, Inst, NO_VALUE, Terminator, ValueId};
use super::Target;
use super::reg_alloc::{Allocation, Place};

/// A run of uses of one value over a contiguous stretch of the
/// instruction tape, with no barrier between the first and the last.
struct Run {
    /// The value whose uses the run covers.
    src: ValueId,
    /// FP-bank marker for the copy, taken from the source's own bank.
    is_fp: bool,
    /// Instruction index of the run's first use; the copy goes here.
    first: ValueId,
    /// Instruction index of the run's last use, inclusive.
    last: ValueId,
}

/// Whether an instruction ends a run: one whose lowering has register
/// machinery of its own -- a call, inline asm, an intrinsic, a
/// whole-struct copy, an atomic, a TLS address -- or one that stages
/// every operand through fixed scratch registers, where an operand in a
/// register costs what a reload costs (`Fma`). Correctness does not rest
/// on this list; the second allocation derives every constraint from the
/// rewritten function. It decides only where a split can pay.
fn is_barrier(inst: &Inst) -> bool {
    matches!(
        inst,
        Inst::Call { .. }
            | Inst::CallIndirect { .. }
            | Inst::CallExt { .. }
            | Inst::TailExt(_)
            | Inst::InlineAsm { .. }
            | Inst::Intrinsic { .. }
            | Inst::Mcpy { .. }
            | Inst::AtomicRmw { .. }
            | Inst::AtomicCas { .. }
            | Inst::TlsAddr(_)
            | Inst::Fma { .. }
    )
}

/// Runs worth splitting: two or more uses of a spilled value with no
/// barrier between them. Uses inside phis (edge uses) and in the
/// terminator (outside every run) are not counted.
///
/// A run reaches past its block's end into the next block on the tape
/// when that block has this one as its only predecessor: control then
/// enters it only from here, so the copy dominates its instructions and
/// the run stays one contiguous stretch of the tape.
fn plan(func: &FunctionSsa, alloc: &Allocation) -> Vec<Run> {
    let n = func.insts.len();
    let mut out: Vec<Run> = Vec::new();
    if alloc.spill_count == 0 || n == 0 {
        return out;
    }
    let preds = super::mem2reg::predecessors(func);
    // Blocks in tape order, so a chain link is a neighbouring pair.
    let mut order: Vec<usize> = (0..func.blocks.len()).collect();
    order.sort_unstable_by_key(|&b| func.blocks[b].inst_range.start);
    // Per value, the run it was last seen in plus that run's first and
    // last use, so a run is closed without re-scanning the block.
    let mut seen: Vec<u32> = vec![u32::MAX; n];
    let mut first: Vec<ValueId> = vec![0; n];
    let mut last: Vec<ValueId> = vec![0; n];
    let mut count: Vec<u32> = vec![0; n];
    // Values touched by the run being built, so closing it costs the
    // values it holds rather than the function's value count.
    let mut touched: Vec<ValueId> = Vec::new();
    let mut run_id: u32 = 0;
    let spilled = |v: ValueId| -> bool {
        matches!(alloc.places.get(v as usize), Some(Place::Spill(_)))
    };
    let mut prev: Option<usize> = None;
    for &b in &order {
        let block = &func.blocks[b];
        let chains = prev.is_some_and(|p| {
            func.blocks[p].inst_range.end == block.inst_range.start
                && preds[b].len() == 1
                && preds[b][0] as usize == p
                && !matches!(func.blocks[p].terminator, Terminator::AsmGoto { .. })
        });
        prev = Some(b);
        if !chains {
            close_run(&mut out, &mut touched, &count, &first, &last, func);
            run_id = run_id.wrapping_add(1);
        }
        for idx in block.inst_range.clone() {
            let inst = &func.insts[idx as usize];
            if is_barrier(inst) {
                close_run(&mut out, &mut touched, &count, &first, &last, func);
                run_id = run_id.wrapping_add(1);
                continue;
            }
            if matches!(inst, Inst::Phi { .. }) {
                continue;
            }
            super::reg_alloc::for_each_operand(inst, |op| {
                if op == NO_VALUE || op as usize >= n || !spilled(op) {
                    return;
                }
                let o = op as usize;
                if seen[o] != run_id {
                    seen[o] = run_id;
                    first[o] = idx;
                    count[o] = 0;
                    touched.push(op);
                }
                count[o] += 1;
                last[o] = idx;
            });
        }
    }
    close_run(&mut out, &mut touched, &count, &first, &last, func);
    out
}

/// Emit a `Run` for every value of the run being closed that carries at
/// least two uses, and clear the run's bookkeeping.
fn close_run(
    out: &mut Vec<Run>,
    touched: &mut Vec<ValueId>,
    count: &[u32],
    first: &[ValueId],
    last: &[ValueId],
    func: &FunctionSsa,
) {
    for &v in touched.iter() {
        let o = v as usize;
        if count[o] < 2 {
            continue;
        }
        out.push(Run {
            src: v,
            is_fp: super::reg_alloc::produces_fp_result(&func.insts[o]),
            first: first[o],
            last: last[o],
        });
    }
    touched.clear();
}

/// The parts of a [`FunctionSsa`] the rewrite replaces, kept so a split
/// that does not pay can be undone exactly.
struct Undo {
    insts: Vec<Inst>,
    inst_src: Vec<(u32, u32)>,
    f32_values: Vec<bool>,
    blocks: Vec<Block>,
    extern_call_refs: Vec<(u32, u32)>,
    extern_imm_code_refs: Vec<(u32, u32)>,
    extern_imm_data_refs: Vec<(u32, u32)>,
    extern_tls_refs: Vec<(u32, u32)>,
}

impl Undo {
    fn restore(self, func: &mut FunctionSsa) {
        func.insts = self.insts;
        func.inst_src = self.inst_src;
        func.f32_values = self.f32_values;
        func.blocks = self.blocks;
        func.extern_call_refs = self.extern_call_refs;
        func.extern_imm_code_refs = self.extern_imm_code_refs;
        func.extern_imm_data_refs = self.extern_imm_data_refs;
        func.extern_tls_refs = self.extern_tls_refs;
    }
}

/// Insert one `Inst::Copy` per run ahead of the run's first use and
/// point the run's uses at it. Rewrites the instruction tape, the
/// parallel per-value tables, every block range, and every value
/// reference through a single old-to-new id map, as
/// [`super::mem2reg::insert_phis`] does for phis.
fn apply(func: &mut FunctionSsa, runs: &[Run]) -> Undo {
    let n_old = func.insts.len();
    let mut undo = Undo {
        insts: Vec::new(),
        inst_src: Vec::new(),
        f32_values: Vec::new(),
        blocks: func.blocks.clone(),
        extern_call_refs: func.extern_call_refs.clone(),
        extern_imm_code_refs: func.extern_imm_code_refs.clone(),
        extern_imm_data_refs: func.extern_imm_data_refs.clone(),
        extern_tls_refs: func.extern_tls_refs.clone(),
    };
    // Runs by insertion point, so the copies of one point go in in a
    // fixed order and the output does not depend on plan order.
    let mut order: Vec<u32> = (0..runs.len() as u32).collect();
    order.sort_by_key(|&k| (runs[k as usize].first, k));
    let mut insts: Vec<Inst> = Vec::with_capacity(n_old + runs.len());
    let mut inst_src: Vec<(u32, u32)> = Vec::with_capacity(n_old + runs.len());
    let mut f32_values: Vec<bool> = Vec::with_capacity(n_old + runs.len());
    let mut remap: Vec<ValueId> = vec![NO_VALUE; n_old];
    let mut copy_id: Vec<ValueId> = vec![NO_VALUE; runs.len()];
    // Copies inserted strictly before each original index, so a block's
    // new bounds follow from its old ones. Index `n_old` closes the last
    // block's range. The tape order is otherwise preserved: instructions
    // covered by no block (`prune_unreachable` leaves them behind) keep
    // their slots, and blocks stay laid out as the pipeline left them.
    let mut before: Vec<u32> = vec![0; n_old + 1];
    for r in runs {
        before[r.first as usize + 1] += 1;
    }
    for old in 0..n_old {
        before[old + 1] += before[old];
    }
    let mut cur = 0usize;
    for old in 0..n_old {
        while cur < order.len() && runs[order[cur] as usize].first as usize == old {
            let k = order[cur] as usize;
            copy_id[k] = insts.len() as ValueId;
            insts.push(Inst::Copy {
                value: runs[k].src,
                is_fp: runs[k].is_fp,
            });
            inst_src.push(func.inst_src.get(old).copied().unwrap_or((0, 0)));
            f32_values.push(
                func.f32_values
                    .get(runs[k].src as usize)
                    .copied()
                    .unwrap_or(false),
            );
            cur += 1;
        }
        remap[old] = insts.len() as ValueId;
        insts.push(func.insts[old].clone());
        inst_src.push(func.inst_src.get(old).copied().unwrap_or((0, 0)));
        f32_values.push(func.f32_values.get(old).copied().unwrap_or(false));
    }
    for block in func.blocks.iter_mut() {
        let (s, e) = (block.inst_range.start, block.inst_range.end);
        block.inst_range = (s + before[s as usize])..(e + before[e as usize]);
    }
    let map = |op: &mut ValueId| {
        if *op != NO_VALUE && (*op as usize) < n_old {
            *op = remap[*op as usize];
        }
    };
    for inst in insts.iter_mut() {
        inst.for_each_operand_mut(map);
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE && (block.exit_acc as usize) < n_old {
            block.exit_acc = remap[block.exit_acc as usize];
        }
        block.terminator.for_each_operand_mut(map);
    }
    for table in [
        &mut func.extern_call_refs,
        &mut func.extern_imm_code_refs,
        &mut func.extern_imm_data_refs,
        &mut func.extern_tls_refs,
    ] {
        for (v, _) in table.iter_mut() {
            map(v);
        }
    }
    // Point each run's uses at its copy. The window opens after the
    // copy, so the copy keeps reading the original value even when a
    // later run of the same value shares the block.
    for (k, r) in runs.iter().enumerate() {
        let new_src = remap[r.src as usize];
        let from = copy_id[k] + 1;
        let to = remap[r.last as usize];
        for i in from..=to {
            if matches!(insts[i as usize], Inst::Phi { .. }) {
                continue;
            }
            insts[i as usize].for_each_operand_mut(|op| {
                if *op == new_src {
                    *op = copy_id[k];
                }
            });
        }
    }
    undo.insts = core::mem::replace(&mut func.insts, insts);
    undo.inst_src = core::mem::replace(&mut func.inst_src, inst_src);
    undo.f32_values = core::mem::replace(&mut func.f32_values, f32_values);
    undo
}

/// Loop-weighted count of the memory traffic and copies placement
/// forces the emit to issue: one per spilled definition, one per operand
/// reference naming a spilled value, and one per inserted copy. Charging
/// the copies is what keeps a split that only renames a value the second
/// allocation would have given a register anyway from looking free.
fn spill_traffic(func: &FunctionSsa, alloc: &Allocation) -> u64 {
    let weights = super::reg_alloc::block_weights(func);
    let spilled = |v: ValueId| -> bool {
        v != NO_VALUE && matches!(alloc.places.get(v as usize), Some(Place::Spill(_)))
    };
    let mut total: u64 = 0;
    for (b, block) in func.blocks.iter().enumerate() {
        let wb = weights[b];
        for idx in block.inst_range.clone() {
            let inst = &func.insts[idx as usize];
            if super::emit_common::is_dead_pure_counts(inst, idx, &alloc.use_counts) {
                continue;
            }
            if spilled(idx) {
                total = total.saturating_add(wb);
            }
            // A copy is one instruction whichever bank its operand sits
            // in -- a reload when the operand is spilled, a register
            // move otherwise -- so it is charged once and its operand is
            // not charged again.
            if matches!(inst, Inst::Copy { .. }) {
                total = total.saturating_add(wb);
                continue;
            }
            super::reg_alloc::for_each_operand(inst, |op| {
                if spilled(op) {
                    total = total.saturating_add(wb);
                }
            });
        }
        block.terminator.for_each_operand(|op| {
            if spilled(op) {
                total = total.saturating_add(wb);
            }
        });
    }
    total
}

/// Allocate `func`, then retry with the spilled values' call-free runs
/// split out. Returns whichever allocation carries less loop-weighted
/// spill traffic, leaving `func` matching the returned allocation.
pub(crate) fn allocate_split(func: &mut FunctionSsa, target: Target) -> Allocation {
    let base = super::reg_alloc::allocate(func, target);
    let runs = plan(func, &base);
    if runs.is_empty() {
        return base;
    }
    let base_traffic = spill_traffic(func, &base);
    let undo = apply(func, &runs);
    let alt = super::reg_alloc::allocate(func, target);
    if spill_traffic(func, &alt) < base_traffic {
        return alt;
    }
    undo.restore(func);
    base
}

#[cfg(test)]
mod tests {
    use super::*;
    use super::super::super::ir::{Block, LoadKind, StoreKind, Terminator};
    use super::super::reg_alloc::{RegBanks, with_pool_size_override};

    fn func_with(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            inst_src: vec![(0, 0); n],
            f32_values: vec![false; n],
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

    fn load() -> Inst {
        Inst::LoadLocal {
            off: 2,
            kind: LoadKind::I64,
            volatile: false,
        }
    }

    fn store_of(value: ValueId) -> Inst {
        Inst::StoreLocal {
            off: -1,
            value,
            kind: StoreKind::I64,
            volatile: false,
        }
    }

    fn call_of(args: Vec<ValueId>) -> Inst {
        Inst::CallExt {
            binding_idx: 0,
            args,
            fp_arg_mask: 0,
            fp_return: false,
            arg_aggs: Vec::new(),
            ret_agg: None,
            ret_slot_local: 0,
        }
    }

    /// An allocation that places `v0` in a spill slot and everything
    /// else in one register, which is all `plan` reads.
    fn alloc_spilling_v0(n: usize) -> Allocation {
        let mut places = vec![Place::IntReg(0); n];
        places[0] = Place::Spill(0);
        Allocation {
            places,
            spill_count: 1,
            gpr_used: Vec::new(),
            fp_used: Vec::new(),
            use_counts: vec![1; n],
            last_use: vec![0; n],
            sxtw_source: vec![NO_VALUE; n],
            sxtw_k: vec![0; n],
            branch_fused: vec![false; n],
            hints: vec![None; n],
            f32_values: vec![false; n],
            high_observed: Vec::new(),
        }
    }

    fn copies(func: &FunctionSsa) -> Vec<ValueId> {
        func.insts
            .iter()
            .enumerate()
            .filter(|(_, i)| matches!(i, Inst::Copy { .. }))
            .map(|(i, _)| i as ValueId)
            .collect()
    }

    #[test]
    fn two_uses_of_a_spilled_value_plan_one_run() {
        let f = func_with(
            vec![load(), store_of(0), store_of(0)],
            vec![block(0..3, Terminator::Return(NO_VALUE))],
        );
        let runs = plan(&f, &alloc_spilling_v0(3));
        assert_eq!(runs.len(), 1);
        assert_eq!((runs[0].src, runs[0].first, runs[0].last), (0, 1, 2));
        assert!(!runs[0].is_fp);
    }

    #[test]
    fn a_single_use_plans_no_run() {
        let f = func_with(
            vec![load(), store_of(0)],
            vec![block(0..2, Terminator::Return(NO_VALUE))],
        );
        assert!(plan(&f, &alloc_spilling_v0(2)).is_empty());
    }

    #[test]
    fn a_value_in_a_register_plans_no_run() {
        let f = func_with(
            vec![load(), store_of(0), store_of(0)],
            vec![block(0..3, Terminator::Return(NO_VALUE))],
        );
        let mut alloc = alloc_spilling_v0(3);
        alloc.places[0] = Place::IntReg(1);
        assert!(plan(&f, &alloc).is_empty());
    }

    #[test]
    fn a_call_between_two_uses_ends_the_run() {
        let f = func_with(
            vec![load(), store_of(0), call_of(Vec::new()), store_of(0)],
            vec![block(0..4, Terminator::Return(NO_VALUE))],
        );
        assert!(plan(&f, &alloc_spilling_v0(4)).is_empty());
    }

    /// Inline asm assigns its own registers to its operands, so it ends
    /// a run and its operands never join one.
    #[test]
    fn inline_asm_ends_the_run_and_keeps_its_operands() {
        let asm = Inst::InlineAsm {
            asm: alloc::boxed::Box::new(crate::c5::ir::AsmBlock {
                template: Vec::new(),
                operands: Vec::new(),
                clobber_regs: 0,
                clobber_fp_regs: 0,
                clobber_memory: false,
                volatile: true,
            }),
            args: alloc::vec![0],
        };
        let f = func_with(
            vec![load(), store_of(0), asm, store_of(0), store_of(0)],
            vec![block(0..5, Terminator::Return(NO_VALUE))],
        );
        let runs = plan(&f, &alloc_spilling_v0(5));
        assert_eq!(runs.len(), 1);
        assert_eq!((runs[0].first, runs[0].last), (3, 4));
        let mut f2 = f.clone();
        apply(&mut f2, &runs);
        let asm_args = f2
            .insts
            .iter()
            .find_map(|i| match i {
                Inst::InlineAsm { args, .. } => Some(args.clone()),
                _ => None,
            })
            .expect("asm survives");
        assert_eq!(asm_args, alloc::vec![0], "asm operand keeps naming v0");
    }

    /// The next block on the tape joins the run when this block is its
    /// only predecessor, and does not when it is reachable elsewhere.
    #[test]
    fn a_run_reaches_into_a_single_predecessor_block() {
        let insts = vec![load(), store_of(0), store_of(0)];
        let chained = func_with(
            insts.clone(),
            vec![
                block(0..2, Terminator::Jmp(1)),
                block(2..3, Terminator::Return(NO_VALUE)),
            ],
        );
        let runs = plan(&chained, &alloc_spilling_v0(3));
        assert_eq!(runs.len(), 1);
        assert_eq!((runs[0].first, runs[0].last), (1, 2));

        let joined = func_with(
            insts,
            vec![
                block(
                    0..2,
                    Terminator::Bz {
                        cond: 0,
                        target: 2,
                        fall_through: 1,
                    },
                ),
                block(2..3, Terminator::Return(NO_VALUE)),
                block(3..3, Terminator::Jmp(1)),
            ],
        );
        assert!(
            plan(&joined, &alloc_spilling_v0(3)).is_empty(),
            "a block with two predecessors does not join the run"
        );
    }

    /// A phi operand is a use on the edge, not at the phi, so a run that
    /// reaches over a phi must leave its incoming list alone.
    #[test]
    fn phi_operands_inside_the_window_are_not_rewritten() {
        let phi = Inst::Phi {
            incoming: alloc::vec![(0, 0)],
            kind: LoadKind::I64,
        };
        let mut f = func_with(
            vec![load(), store_of(0), phi, store_of(0)],
            vec![
                block(0..2, Terminator::Jmp(1)),
                block(2..4, Terminator::Return(NO_VALUE)),
            ],
        );
        let runs = plan(&f, &alloc_spilling_v0(4));
        assert_eq!(runs.len(), 1);
        apply(&mut f, &runs);
        let cp = copies(&f);
        assert_eq!(cp.len(), 1);
        let (phi_in, last_store) = f
            .insts
            .iter()
            .fold((None, None), |(p, s), i| match i {
                Inst::Phi { incoming, .. } => (Some(incoming.clone()), s),
                Inst::StoreLocal { value, .. } => (p, Some(*value)),
                _ => (p, s),
            });
        assert_eq!(phi_in.expect("phi survives")[0].1, 0, "edge use keeps v0");
        assert_eq!(last_store, Some(cp[0]), "the in-block use takes the copy");
    }

    /// The rewrite keeps the tape's order and every block's extent, so
    /// the leading phi run of a block stays leading.
    #[test]
    fn the_rewrite_keeps_block_extents_and_phi_position() {
        let phi = Inst::Phi {
            incoming: alloc::vec![(0, 1)],
            kind: LoadKind::I64,
        };
        let mut f = func_with(
            vec![load(), store_of(0), store_of(0), phi, store_of(3)],
            vec![
                block(0..3, Terminator::Jmp(1)),
                block(3..5, Terminator::Return(NO_VALUE)),
            ],
        );
        let runs = plan(&f, &alloc_spilling_v0(5));
        assert_eq!(runs.len(), 1);
        apply(&mut f, &runs);
        assert_eq!(f.insts.len(), 6);
        assert_eq!(f.blocks[0].inst_range, 0..4);
        assert_eq!(f.blocks[1].inst_range, 4..6);
        assert!(matches!(f.insts[4], Inst::Phi { .. }));
    }

    /// A run that does not pay leaves the function exactly as it was.
    #[test]
    fn a_rejected_split_restores_the_function() {
        let f = func_with(
            vec![load(), store_of(0), store_of(0)],
            vec![block(0..3, Terminator::Return(NO_VALUE))],
        );
        let mut split = f.clone();
        let runs = plan(&f, &alloc_spilling_v0(3));
        let undo = apply(&mut split, &runs);
        assert_eq!(split.insts.len(), 4);
        undo.restore(&mut split);
        assert_eq!(split.insts.len(), f.insts.len());
        assert_eq!(split.blocks[0].inst_range, f.blocks[0].inst_range);
        assert_eq!(
            alloc::format!("{:?}", split.insts),
            alloc::format!("{:?}", f.insts)
        );
    }

    /// The traffic metric charges a copy once whichever bank its operand
    /// sits in, so a split that only renames a register value cannot look
    /// free.
    #[test]
    fn the_traffic_metric_charges_every_copy() {
        let mut f = func_with(
            vec![load(), store_of(0), store_of(0)],
            vec![block(0..3, Terminator::Return(NO_VALUE))],
        );
        let base = alloc_spilling_v0(3);
        assert_eq!(spill_traffic(&f, &base), 3, "def plus two reloads");
        let runs = plan(&f, &base);
        apply(&mut f, &runs);
        let mut alt = alloc_spilling_v0(4);
        alt.places[0] = Place::Spill(0);
        alt.places[1] = Place::IntReg(1);
        assert_eq!(spill_traffic(&f, &alt), 2, "def plus the copy");
    }
    /// A copy between a comparison and the branch it feeds writes no
    /// host flags, so the fusion the allocator recognised survives one
    /// landing in that window.
    #[test]
    fn a_copy_in_the_branch_window_keeps_the_fusion() {
        let cmp = Inst::Binop {
            op: crate::c5::ir::BinOp::Eq,
            lhs: 1,
            rhs: 1,
        };
        let f = func_with(
            vec![
                load(),
                load(),
                cmp,
                Inst::Copy {
                    value: 0,
                    is_fp: false,
                },
                store_of(3),
            ],
            vec![
                block(
                    0..5,
                    Terminator::Bz {
                        cond: 2,
                        target: 1,
                        fall_through: 2,
                    },
                ),
                block(5..5, Terminator::Return(NO_VALUE)),
                block(5..5, Terminator::Return(NO_VALUE)),
            ],
        );
        let alloc = super::super::reg_alloc::allocate(&f, Target::host());
        assert!(alloc.branch_fused[2], "the compare still fuses");
    }

    /// Six values live across one call, so none may hold a caller-saved
    /// register for its whole range. The call-free stretch that follows
    /// reads the first four three times each and drops them, then holds
    /// the caller-saved bank with four values that cross no call, then
    /// reads the last two three times each. Under a bank smaller than
    /// six the last two spill, and their reuse -- the run the split
    /// targets -- falls where only the callee-saved bank is free.
    fn crossing_call_then_reuse() -> FunctionSsa {
        let mut insts: Vec<Inst> = Vec::new();
        for k in 0..6 {
            insts.push(Inst::LoadLocal {
                off: 2 + k,
                kind: LoadKind::I64,
                volatile: false,
            });
        }
        insts.push(call_of(Vec::new()));
        for v in 0..4 {
            for _ in 0..3 {
                insts.push(store_of(v));
            }
        }
        let w0 = insts.len() as ValueId;
        for k in 0..4 {
            insts.push(Inst::LoadLocal {
                off: 20 + k,
                kind: LoadKind::I64,
                volatile: false,
            });
        }
        for v in 4..6 {
            for _ in 0..3 {
                insts.push(store_of(v));
            }
        }
        // Read more often than the runs above, so the colorer places
        // them first and the copies meet a full caller-saved bank.
        for k in 0..4 {
            for _ in 0..4 {
                insts.push(store_of(w0 + k as ValueId));
            }
        }
        let n = insts.len() as u32;
        func_with(insts, vec![block(0..n, Terminator::Return(NO_VALUE))])
    }

    fn split_once(cap: usize) -> (FunctionSsa, Allocation) {
        with_pool_size_override(cap, cap, || {
            let mut f = crossing_call_then_reuse();
            let a = allocate_split(&mut f, Target::host());
            (f, a)
        })
    }

    #[test]
    fn a_value_spilled_by_a_call_crossing_gets_its_reuse_split() {
        assert!(
            (1..=6).any(|cap| !copies(&split_once(cap).0).is_empty()),
            "the reuse stretch is split out"
        );
    }

    /// No split range spans a call, so a copy never needs a
    /// callee-saved home for a reason the allocator cannot see.
    #[test]
    fn no_split_range_spans_a_call() {
        for cap in 1..=6 {
            let (f, _) = split_once(cap);
            let live = super::super::liveness::Liveness::compute(&f);
            for c in copies(&f) {
                for (i, inst) in f.insts.iter().enumerate() {
                    assert!(
                        !is_barrier(inst) || !live.live_after(&f, c, i as ValueId),
                        "copy v{c} is live across the barrier at v{i}"
                    );
                }
            }
        }
    }

    /// A copy the emit lowers writes its register, so a callee-saved
    /// color must reach the prologue's save list.
    #[test]
    fn a_callee_saved_split_copy_reaches_the_prologue_save_list() {
        let banks = RegBanks::for_target(Target::host());
        let mut checked = 0usize;
        for cap in 1..=6 {
            let (f, alloc) = split_once(cap);
            for c in copies(&f) {
                match alloc.places[c as usize] {
                    Place::IntReg(r) if banks.callee_gprs.contains(&r) => {
                        assert!(alloc.gpr_used.contains(&r), "callee-saved copy reg {r} saved");
                        checked += 1;
                    }
                    Place::FpReg(r) if banks.callee_fprs.contains(&r) => {
                        assert!(alloc.fp_used.contains(&r), "callee-saved copy reg {r} saved");
                        checked += 1;
                    }
                    _ => {}
                }
            }
        }
        assert!(checked > 0, "a copy landed in a callee-saved register");
    }

    /// Spill slots are shared by lifetime, so two values that are ever
    /// simultaneously live must never land on one slot -- the split's
    /// new values included.
    #[test]
    fn split_values_never_share_a_slot_with_an_interfering_value() {
        for cap in 1..=6 {
            let (f, alloc) = split_once(cap);
            let live = super::super::liveness::Liveness::compute(&f);
            let by_slot: Vec<(u32, ValueId)> = alloc
                .places
                .iter()
                .enumerate()
                .filter_map(|(v, p)| p.spill_slot().map(|s| (s, v as ValueId)))
                .collect();
            for (i, &(sa, a)) in by_slot.iter().enumerate() {
                for &(sb, b) in &by_slot[i + 1..] {
                    if sa != sb {
                        continue;
                    }
                    assert!(
                        !live.interfere(&f, a, b),
                        "v{a} and v{b} share slot {sa} while both live"
                    );
                }
            }
        }
    }

    /// A run that reaches into a chained block still ends at a call, so
    /// no split range spans one.
    #[test]
    fn a_call_in_a_chained_block_ends_the_run() {
        let f = func_with(
            vec![load(), store_of(0), call_of(Vec::new()), store_of(0)],
            vec![
                block(0..2, Terminator::Jmp(1)),
                block(2..4, Terminator::Return(NO_VALUE)),
            ],
        );
        assert!(plan(&f, &alloc_spilling_v0(4)).is_empty());
    }
}

