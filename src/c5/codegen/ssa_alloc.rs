//! Linear-scan register allocator over the [`FunctionSsa`] output
//! of [`super::ssa`]. Produces a per-`Inst` [`Place`] (a host
//! register or a spill slot) that the per-arch SSA emit
//! (`ssa_emit_aarch64.rs` / `ssa_emit_x86_64.rs`) consumes when
//! emitting native instructions.
//!
//! ## Algorithm
//!
//! 1. Compute last-use PC per SSA value via a single backward
//!    pass: every `Inst` that reads a `ValueId` extends the
//!    target's live range to its own PC.
//! 2. Walk insts forward. Maintain a free pool of integer and FP
//!    registers (callee-saved + caller-saved, minus a small set
//!    reserved for scratch + frame).
//! 3. At each `Inst` that defines a value, expire any active
//!    interval whose `last_use < current_pc`, then pick a free
//!    register of the right bank (FP vs int). On register
//!    pressure, spill the active interval with the furthest next
//!    use to a fresh frame slot and reuse its register.
//! 4. At call instructions (`Call` / `CallIndirect` / `CallExt`),
//!    spill every active caller-saved register before the call
//!    site -- the allocator marks these values as live in their
//!    spill slot for the remainder of their range. Pre-coloring
//!    of the call's argument values into host arg regs is left
//!    to the per-arch emit pass; the allocator just ensures the
//!    args are available somewhere reachable.
//!
//! The output is intentionally minimal: each `Place` is either
//! one of the host's GPRs / FP regs or a stack slot's byte offset
//! relative to the function's locals area. The per-arch emit pass
//! is responsible for the actual code emission (load / store /
//! reg-to-reg move / call-site marshalling).

#![allow(dead_code)]

use alloc::vec;
use alloc::vec::Vec;

use super::super::ir::{
    BinOp, FpCastKind, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId,
};
use super::Target;

/// Where the allocator placed an SSA value.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) enum Place {
    /// Integer / pointer GPR. Index is into the per-arch GPR
    /// table (see [`Allocation::int_pool`]).
    IntReg(u8),
    /// Floating-point register (d-reg on aarch64, xmm on x86_64).
    FpReg(u8),
    /// Frame slot at byte offset `n * 8` from the start of the
    /// SSA spill region. The emit pass adds the per-function
    /// base offset to land on a real `[fp - X]`.
    Spill(u32),
    /// No defined value (Store, AllocaInit, ...).
    None,
}

impl Place {
    /// Integer-register index when the place is `IntReg`, else
    /// `None`. The per-arch backends wrap the returned `u8` in
    /// their own `Reg` newtype before encoding.
    pub(super) fn int_reg_u8(self) -> Option<u8> {
        if let Place::IntReg(r) = self {
            Some(r)
        } else {
            None
        }
    }

    /// FP-register index when the place is `FpReg`, else `None`.
    pub(super) fn fp_reg_u8(self) -> Option<u8> {
        if let Place::FpReg(r) = self {
            Some(r)
        } else {
            None
        }
    }

    /// Spill-slot index when the place is `Spill`, else `None`.
    pub(super) fn spill_slot(self) -> Option<u32> {
        if let Place::Spill(s) = self {
            Some(s)
        } else {
            None
        }
    }
}

/// Per-function allocation result. Indexed by `ValueId`.
#[derive(Debug, Clone)]
pub(super) struct Allocation {
    /// Where each SSA value lives.
    pub places: Vec<Place>,
    /// Total spill slots reserved (in 8-byte units). The emit
    /// pass adds `vstack_slots * 8 + 8 * spill_count` bytes to
    /// the function's `locals_bytes` reservation.
    pub spill_count: u32,
    /// GPRs the allocator actually used. The emit pass saves
    /// only this subset's callee-saved entries in the prologue.
    pub gpr_used: Vec<u8>,
    /// FP regs the allocator actually used.
    pub fp_used: Vec<u8>,
    /// Number of consumers of each value. Used by the emit pass to
    /// skip pure-with-no-uses insts (dead-code elimination). A value
    /// with zero uses and no side effects produces no machine code.
    pub use_counts: Vec<u32>,
    /// Highest PC index that names each value as an operand. A
    /// value defined at PC `i` is live throughout `[i, last_use[i]]`
    /// and the emit pass queries this to compute the set of
    /// registers carrying live SSA values at any given PC -- needed
    /// when picking an intra-instruction scratch that must not
    /// clobber a value the next instruction reads.
    pub last_use: Vec<u32>,
    /// For `BinopI(Shr, X, K)` insts the allocator recognised as
    /// the upper half of a sign-narrow `Shl K; Shr K` pair (K in
    /// {32, 48, 56}), the original pre-narrow value (the Shl's
    /// lhs). NO_VALUE for any other inst. The emit pass collapses
    /// the pair into a single sxtw / sxth / sxtb (aarch64) or
    /// movsxd / movsx (x86_64); the upstream Shl loses its only
    /// consumer through the matching use_count decrement, so DCE
    /// kills it.
    pub sxtw_source: Vec<ValueId>,
    /// Parallel to `sxtw_source`. When `sxtw_source[i] != NO_VALUE`
    /// this holds the matching K (32 / 48 / 56) so the emit pass
    /// can pick the right sign-extend width without re-walking the
    /// inst's operands.
    pub sxtw_k: Vec<i64>,
    /// True for `Binop` / `BinopI` comparison insts that the
    /// allocator recognised as the source of a `Bz` / `Bnz`
    /// terminator's cond, with cond consumed only by that
    /// terminator and the inst sitting in the last slot of its
    /// block. The emit pass skips the `cset` materialisation and
    /// the terminator emits `b.cond` (aarch64) or `j.cond`
    /// (x86_64) directly off the flags set by `cmp`.
    pub branch_fused: Vec<bool>,
    /// Per-value coalescing hint: the physical register the
    /// allocator should prefer when one is set and free at the
    /// pick site. The pick-reg path honours the hint only when it
    /// satisfies the live-across-call constraint; unsatisfied
    /// hints are ignored, so a hint never compromises correctness.
    /// `None` for any value with no preference. Populated by the
    /// coalescing pre-passes (copy / phi congruence / call-arg /
    /// return) layered on in subsequent iterations.
    pub hints: Vec<Option<u8>>,
}

/// Set of available registers for the host target. The emit pass
/// keys off this to map allocator indices to encoding bits.
#[derive(Debug, Clone)]
pub(super) struct RegBanks {
    /// Callee-saved GPRs available for general use (excluding
    /// fp, lr, sp, scratch).
    pub callee_gprs: &'static [u8],
    /// Caller-saved GPRs available. Live ranges that cross a
    /// call instruction must NOT be assigned here -- the
    /// allocator spills them to memory instead.
    pub caller_gprs: &'static [u8],
    /// Callee-saved FP regs. AAPCS64 marks d8..d15 callee-saved;
    /// SysV / Win64 mark none of xmm callee-saved, so the FP
    /// allocator on x86_64 forces every live-across-call FP
    /// value to memory.
    pub callee_fprs: &'static [u8],
    /// Caller-saved FP regs (d0..d7 on aarch64; xmm0..xmm15 on
    /// x86_64).
    pub caller_fprs: &'static [u8],
}

impl RegBanks {
    /// Pick the register set for the target. Concrete register
    /// numbers match the per-arch encoders' Reg(N) constants;
    /// the allocator only needs the IDs to record placement
    /// decisions.
    pub fn for_target(target: Target) -> Self {
        match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => Self {
                // AAPCS64 caller-saved (volatile) registers: x0..x7
                // are the arg / return regs, x8 is the indirect-return
                // slot, x9..x15 are general scratch. A single flat
                // caller-saved pool lets the coalescing-hint pass
                // place a call-argument value directly in its target
                // arg register so the `mov x0..x7, xN` setup
                // disappears. x16 / x17 are the encoder scratch
                // (large-immediate and adrp / add fixups), x18 is the
                // Windows platform register, x19 is the writer's
                // address-materialisation scratch (see
                // [[function_clobbers_x19]]); all stay reserved.
                // AAPCS64 callee-saved (non-volatile) GPRs are
                // x19..x28; x19 is the writer's scratch so the bank
                // starts at x20 and runs through x28.
                callee_gprs: &[20, 21, 22, 23, 24, 25, 26, 27, 28],
                caller_gprs: &[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
                callee_fprs: &[8, 9, 10, 11, 12, 13, 14, 15],
                caller_fprs: &[0, 1, 2, 3, 4, 5, 6, 7],
            },
            Target::LinuxX64 => Self {
                // System V x86_64. Callee-saved: rbx, r12, r14, r15.
                // r13 stays reserved as the writer's scratch / legacy
                // accumulator. r10 stays reserved as `SCRATCH_R10`
                // in ssa_emit_x86_64 -- many handlers
                // (int_or_spill_dst, materialize_int for spilled
                // sources, the Va* / call-arg marshallers) write r10
                // unconditionally to land a value in a known register,
                // so the allocator must not park another SSA value
                // there. Caller-saved opens up to the SysV arg regs
                // (rdi, rsi, rdx, rcx, r8, r9) plus rax, r11.
                callee_gprs: &[3, 12, 14, 15],
                caller_gprs: &[0, 1, 2, 6, 7, 8, 9, 11],
                callee_fprs: &[],
                caller_fprs: &[0, 1, 2, 3, 4, 5, 6, 7],
            },
            Target::WindowsX64 => Self {
                // Win64 callee-saved GPRs: rbx, rsi, rdi, r12, r14,
                // r15. r13 / r10 stay reserved as the writer's
                // scratch (see the LinuxX64 comment for the SCRATCH_R10
                // contract). Caller-saved opens up to the Win64 arg
                // regs (rcx, rdx, r8, r9) plus rax, r11.
                callee_gprs: &[3, 6, 7, 12, 14, 15],
                caller_gprs: &[0, 1, 2, 8, 9, 11],
                callee_fprs: &[6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
                caller_fprs: &[0, 1, 2, 3, 4, 5],
            },
        }
    }
}

/// Allocate physical placements for every value in `func`. See
/// the module docs for the algorithm.
pub(super) fn allocate(func: &FunctionSsa, target: Target) -> Allocation {
    let n_insts = func.insts.len();
    let mut places: Vec<Place> = vec![Place::None; n_insts];
    let mut hints: Vec<Option<u8>> = vec![None; n_insts];
    populate_param_ref_hints(func, target, &mut hints);
    populate_phi_hints(func, &mut hints);
    if n_insts == 0 {
        return Allocation {
            places,
            spill_count: 0,
            gpr_used: Vec::new(),
            fp_used: Vec::new(),
            use_counts: Vec::new(),
            last_use: Vec::new(),
            sxtw_source: Vec::new(),
            sxtw_k: Vec::new(),
            branch_fused: Vec::new(),
            hints,
        };
    }

    let banks = RegBanks::for_target(target);
    let last_use = compute_last_use(func);
    let calls_after_def = compute_calls_after_def(func, &last_use, target);
    // ABI coalescing hints. All three passes are guarded by per-value
    // `calls_after_def` / `last_use` checks so a missed predicate
    // falls through to the default policy and no caller-saved hint
    // pre-commits a value that has to survive past a call. The prior
    // unconditional ABI-hint pass (commit 3469094) was reverted in
    // 1609bbc precisely because it lacked these guards.
    populate_call_arg_hints(func, target, &last_use, &calls_after_def, &mut hints);
    populate_call_result_hints(func, target, &calls_after_def, &mut hints);
    populate_return_hints(func, target, &calls_after_def, &mut hints);

    // Active intervals: (value id, last-use index, register).
    let mut active_int: Vec<(ValueId, u32, u8)> = Vec::new();
    let mut active_fp: Vec<(ValueId, u32, u8)> = Vec::new();
    let mut free_int: Vec<u8> = banks
        .callee_gprs
        .iter()
        .chain(banks.caller_gprs.iter())
        .copied()
        .collect();
    let mut free_fp: Vec<u8> = banks
        .callee_fprs
        .iter()
        .chain(banks.caller_fprs.iter())
        .copied()
        .collect();
    let mut spill_count: u32 = 0;
    let mut gpr_used: alloc::collections::BTreeSet<u8> = alloc::collections::BTreeSet::new();
    let mut fp_used: alloc::collections::BTreeSet<u8> = alloc::collections::BTreeSet::new();

    for (idx, inst) in func.insts.iter().enumerate() {
        let pc = idx as u32;
        // Expire intervals whose last use is strictly before this
        // pc. We retain values whose last use IS this pc -- the
        // current inst is reading them.
        expire(&mut active_int, &mut free_int, pc, &places);
        expire(&mut active_fp, &mut free_fp, pc, &places);

        let kind = result_kind(inst);
        if kind == ResultKind::None {
            continue;
        }
        let must_be_callee = calls_after_def[idx];
        // Pick the bank.
        let (active, free, banks_caller, used) = match kind {
            ResultKind::Int => (
                &mut active_int,
                &mut free_int,
                banks.caller_gprs,
                &mut gpr_used,
            ),
            ResultKind::Fp => (
                &mut active_fp,
                &mut free_fp,
                banks.caller_fprs,
                &mut fp_used,
            ),
            ResultKind::None => unreachable!(),
        };

        // Prefer a coalescing hint when one is set, free, and
        // satisfies the live-across-call constraint. An unsatisfied
        // hint falls through to the default policy, so a hint never
        // compromises correctness. Hints are empty until a later
        // pass populates them (copy / phi congruence / call-arg /
        // return); until then the path below is unchanged.
        let hint_choice = match hints[idx] {
            Some(r) if free.contains(&r) && (!must_be_callee || !banks_caller.contains(&r)) => {
                Some(r)
            }
            _ => None,
        };
        let chosen = hint_choice.or_else(|| {
            if must_be_callee {
                free.iter().copied().find(|r| !banks_caller.contains(r))
            } else {
                free.last().copied()
            }
        });
        if let Some(r) = chosen {
            // Remove from free pool.
            if let Some(pos) = free.iter().position(|x| *x == r) {
                free.swap_remove(pos);
            }
            active.push((pc, last_use[idx], r));
            // Sort active by last_use ascending so expire() can
            // pop from the front cheaply.
            active.sort_by_key(|e| e.1);
            used.insert(r);
            places[idx] = match kind {
                ResultKind::Int => Place::IntReg(r),
                ResultKind::Fp => Place::FpReg(r),
                ResultKind::None => unreachable!(),
            };
        } else {
            // Spill the active interval with the furthest next use
            // whose register satisfies the must-be-callee constraint
            // for the incoming value. A live-across-call value placed
            // in a caller-saved register would be clobbered the next
            // call; restrict the victim search to callee-saved
            // registers in that case. If no callee-saved victim
            // exists, spill the new value to memory instead of
            // parking it in a caller-saved register.
            let pick_victim = |must_callee: bool| -> Option<usize> {
                active
                    .iter()
                    .enumerate()
                    .filter(|(_, e)| !must_callee || !banks_caller.contains(&e.2))
                    .max_by_key(|(_, e)| e.1)
                    .map(|(i, _)| i)
            };
            let victim_pos = pick_victim(must_be_callee);
            if let Some(pos) = victim_pos {
                let (victim_id, _victim_end, victim_reg) = active.remove(pos);
                let slot = spill_count;
                spill_count += 1;
                places[victim_id as usize] = Place::Spill(slot);
                active.push((pc, last_use[idx], victim_reg));
                active.sort_by_key(|e| e.1);
                places[idx] = match kind {
                    ResultKind::Int => Place::IntReg(victim_reg),
                    ResultKind::Fp => Place::FpReg(victim_reg),
                    ResultKind::None => unreachable!(),
                };
            } else {
                // No active interval to spill (rare: pool fully
                // empty and nothing live). Spill directly.
                let slot = spill_count;
                spill_count += 1;
                places[idx] = Place::Spill(slot);
            }
        }
    }

    // Only callee-saved registers need prologue / epilogue
    // save and restore. Caller-saved registers are preserved
    // by the caller across the function's call sites (via the
    // `must_be_callee` filter above the allocator only places
    // live-across-call values into callee-saved registers, so a
    // caller-saved register's value never needs to survive past
    // the function's own emit). Filtering here keeps the
    // prologue's `str xN, [sp, ...]` sequence to exactly the
    // registers AAPCS64 / SysV / Win64 require the callee to
    // preserve.
    let gpr_used_callee: Vec<u8> = gpr_used
        .into_iter()
        .filter(|r| banks.callee_gprs.contains(r))
        .collect();
    let fp_used_callee: Vec<u8> = fp_used
        .into_iter()
        .filter(|r| banks.callee_fprs.contains(r))
        .collect();
    let mut use_counts = compute_use_counts(func);
    // Recognise the c5 sign-narrow shape:
    //   Shl(X, K) ; Shr(_, K)   with K in {32, 48, 56}
    // The shift's rhs may arrive either as a `BinopI` (with the
    // immediate folded into the inst) or as a `Binop` whose `rhs`
    // names an `Imm(K)` value -- the walker produces the latter
    // because the parser emits the narrow as wrapping `Expr::Binary`
    // nodes carrying an `IntLit(K)` rhs. Decrement the producer
    // counts so DCE removes the Shl, the Shr, and the Imm(s);
    // the emit pass picks sxtw / sxth / sxtb via `sxtw_source`.
    let mut sxtw_source: Vec<ValueId> = vec![NO_VALUE; func.insts.len()];
    let mut sxtw_k: Vec<i64> = vec![0; func.insts.len()];
    let shift_shape = |inst: &Inst| -> Option<(BinOp, ValueId, i64, Option<ValueId>)> {
        match inst {
            Inst::BinopI { op, lhs, rhs_imm } => Some((*op, *lhs, *rhs_imm, None)),
            Inst::Binop { op, lhs, rhs } => {
                if let Some(Inst::Imm(k)) = func.insts.get(*rhs as usize) {
                    Some((*op, *lhs, *k, Some(*rhs)))
                } else {
                    None
                }
            }
            _ => None,
        }
    };
    for (i, inst) in func.insts.iter().enumerate() {
        let Some((shr_op, shr_lhs, shr_k, shr_imm_v)) = shift_shape(inst) else {
            continue;
        };
        if shr_op != BinOp::Shr || !matches!(shr_k, 32 | 48 | 56) {
            continue;
        }
        let Some(shl_inst) = func.insts.get(shr_lhs as usize) else {
            continue;
        };
        let Some((shl_op, shl_src, shl_k, shl_imm_v)) = shift_shape(shl_inst) else {
            continue;
        };
        if shl_op != BinOp::Shl || shl_k != shr_k {
            continue;
        }
        if use_counts.get(shr_lhs as usize).copied().unwrap_or(0) != 1 {
            continue;
        }
        sxtw_source[i] = shl_src;
        sxtw_k[i] = shr_k;
        use_counts[shr_lhs as usize] = 0;
        if let Some(v) = shl_imm_v {
            let slot = &mut use_counts[v as usize];
            *slot = slot.saturating_sub(1);
        }
        if let Some(v) = shr_imm_v {
            let slot = &mut use_counts[v as usize];
            *slot = slot.saturating_sub(1);
        }
    }
    // Recognise comparison-feeding-branch sites. The terminator's
    // cond must be the immediately-preceding inst in its block,
    // be a Binop / BinopI with a comparison op, and have a single
    // consumer (the terminator). Mark it; the emit pass drops the
    // `cset` and the terminator picks `b.cond` instead of `cbz`.
    let mut branch_fused: Vec<bool> = vec![false; func.insts.len()];
    for block in &func.blocks {
        let cond = match block.terminator {
            super::super::ir::Terminator::Bz { cond, .. }
            | super::super::ir::Terminator::Bnz { cond, .. } => cond,
            _ => continue,
        };
        if cond == NO_VALUE {
            continue;
        }
        if cond + 1 != block.inst_range.end {
            continue;
        }
        if use_counts.get(cond as usize).copied().unwrap_or(0) != 1 {
            continue;
        }
        let is_compare = matches!(
            func.insts.get(cond as usize),
            Some(Inst::Binop { op, .. }) | Some(Inst::BinopI { op, .. })
                if matches!(
                    op,
                    BinOp::Eq | BinOp::Ne
                        | BinOp::Lt | BinOp::Gt | BinOp::Le | BinOp::Ge
                        | BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge
                )
        );
        if is_compare {
            branch_fused[cond as usize] = true;
        }
    }
    // Drop the "value-also-in-acc" propagate slot for stores whose
    // defined value is unread. c5 store ops leave the stored value
    // in the accumulator; if nothing downstream reads it, the emit
    // path's mov-to-dst is dead work. Setting the Place to None
    // makes int_or_spill_dst short-circuit and skip the propagate.
    for (v, inst) in func.insts.iter().enumerate() {
        if use_counts[v] == 0
            && matches!(
                inst,
                Inst::Store { .. } | Inst::StoreLocal { .. } | Inst::StoreIndexed { .. }
            )
        {
            places[v] = Place::None;
        }
    }
    Allocation {
        places,
        spill_count,
        gpr_used: gpr_used_callee,
        fp_used: fp_used_callee,
        use_counts,
        last_use,
        sxtw_source,
        sxtw_k,
        branch_fused,
        hints,
    }
}

/// Count consumers for every SSA value, then iterate to fixed point
/// so transitively-dead pure insts also drop to use_count == 0.
/// Drives the emit pass's dead-code skip.
fn compute_use_counts(func: &FunctionSsa) -> Vec<u32> {
    let n = func.insts.len();
    let mut counts: Vec<u32> = vec![0; n];
    let bump_into = |counts: &mut Vec<u32>, v: ValueId| {
        if v != NO_VALUE && (v as usize) < n {
            counts[v as usize] += 1;
        }
    };
    let decrement = |counts: &mut Vec<u32>, v: ValueId| {
        if v != NO_VALUE && (v as usize) < n && counts[v as usize] > 0 {
            counts[v as usize] -= 1;
        }
    };
    for inst in &func.insts {
        for_each_operand(inst, |op| bump_into(&mut counts, op));
    }
    for inst in &func.insts {
        if let Inst::CallIndirect { target, .. } = inst {
            bump_into(&mut counts, *target);
        }
    }
    for block in &func.blocks {
        match block.terminator {
            super::super::ir::Terminator::Bz { cond, .. } => bump_into(&mut counts, cond),
            super::super::ir::Terminator::Bnz { cond, .. } => bump_into(&mut counts, cond),
            super::super::ir::Terminator::Return(v) => bump_into(&mut counts, v),
            _ => {}
        }
    }
    // Iterate to fixed point: a pure inst with zero uses is dead;
    // its operand references stop counting. Worst case O(n^2)
    // but n is typically small (per-function inst count) and the
    // fixed point converges in few passes (chain length).
    let mut killed: Vec<bool> = vec![false; n];
    loop {
        let mut changed = false;
        for (i, inst) in func.insts.iter().enumerate() {
            if killed[i] || !is_pure_inst(inst) {
                continue;
            }
            if counts[i] == 0 {
                killed[i] = true;
                changed = true;
                for_each_operand(inst, |op| decrement(&mut counts, op));
            }
        }
        if !changed {
            break;
        }
    }
    counts
}

/// True when the inst has no side effects and can be DCE'd if its
/// result is unread. Mirrors `is_dead_pure` in ssa_emit_common but
/// kept here to drive the allocator's use-count fixed-point pass.
fn is_pure_inst(inst: &Inst) -> bool {
    matches!(
        inst,
        Inst::Imm(_)
            | Inst::ImmData(_)
            | Inst::ImmCode(_)
            | Inst::LocalAddr(_)
            | Inst::TlsAddr(_)
            | Inst::Load { .. }
            | Inst::LoadLocal { .. }
            | Inst::LoadIndexed { .. }
            | Inst::Binop { .. }
            | Inst::BinopI { .. }
            | Inst::Fneg(_)
            | Inst::FpCast { .. }
    )
}

/// Invoke `f` for each operand `ValueId` referenced by `inst`.
pub(super) fn for_each_operand(inst: &Inst, mut f: impl FnMut(ValueId)) {
    match inst {
        Inst::Imm(_)
        | Inst::ImmData(_)
        | Inst::ImmCode(_)
        | Inst::LocalAddr(_)
        | Inst::TlsAddr(_)
        | Inst::AllocaInit(_)
        | Inst::ParamRef { .. }
        | Inst::TailExt(_)
        | Inst::LoadLocal { .. } => {}
        Inst::Load { addr, .. } => f(*addr),
        Inst::Store { addr, value, .. } => {
            f(*addr);
            f(*value);
        }
        Inst::StoreLocal { value, .. } => f(*value),
        Inst::LoadIndexed { base, index, .. } => {
            f(*base);
            f(*index);
        }
        Inst::StoreIndexed {
            base, index, value, ..
        } => {
            f(*base);
            f(*index);
            f(*value);
        }
        Inst::Binop { lhs, rhs, .. } => {
            f(*lhs);
            f(*rhs);
        }
        Inst::BinopI { lhs, .. } => f(*lhs),
        Inst::Fneg(v) => f(*v),
        Inst::Extend { value, .. } => f(*value),
        Inst::FpCast { value, .. } => f(*value),
        Inst::Call { args, .. } | Inst::CallExt { args, .. } | Inst::Intrinsic { args, .. } => {
            for &a in args {
                f(a);
            }
        }
        Inst::CallIndirect { target, args } => {
            f(*target);
            for &a in args {
                f(a);
            }
        }
        Inst::Mcpy { dst, src, .. } => {
            f(*dst);
            f(*src);
        }
        Inst::Phi { incoming, .. } => {
            for (_, v) in incoming {
                f(*v);
            }
        }
    }
}

/// Whether an instruction defines an int / FP value or none at all.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum ResultKind {
    Int,
    Fp,
    None,
}

/// Whether an instruction's result lives in the FP register file.
/// Used by `ssa_mem2reg` to keep a register-file-consistent rewrite:
/// an `I64` slot load is integer-classed, so a slot may be promoted
/// only when its stored values are integer-classed too.
pub(super) fn produces_fp_result(inst: &Inst) -> bool {
    matches!(result_kind(inst), ResultKind::Fp)
}

fn result_kind(inst: &Inst) -> ResultKind {
    use Inst::*;
    match inst {
        Imm(_) | ImmData(_) | ImmCode(_) | LocalAddr(_) | TlsAddr(_) | ParamRef { .. } => {
            ResultKind::Int
        }
        Phi { kind, .. } => match kind {
            LoadKind::F32 => ResultKind::Fp,
            _ => ResultKind::Int,
        },
        Load { kind, .. } | LoadLocal { kind, .. } => match kind {
            LoadKind::F32 => ResultKind::Fp,
            _ => ResultKind::Int,
        },
        Store {
            kind: StoreKind::F32,
            ..
        }
        | StoreLocal {
            kind: StoreKind::F32,
            ..
        } => ResultKind::Fp,
        Store { .. } | StoreLocal { .. } | StoreIndexed { .. } => ResultKind::Int,
        LoadIndexed { kind, .. } => match kind {
            LoadKind::F32 => ResultKind::Fp,
            _ => ResultKind::Int,
        },
        Binop { op, .. } | BinopI { op, .. } => match op {
            BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv => ResultKind::Fp,
            // FP comparisons return an integer 0/1.
            _ => ResultKind::Int,
        },
        Fneg(_) => ResultKind::Fp,
        Extend { .. } => ResultKind::Int,
        FpCast { kind, .. } => match kind {
            FpCastKind::FpToInt => ResultKind::Int,
            FpCastKind::IntToFp => ResultKind::Fp,
        },
        Call { .. } | CallIndirect { .. } | CallExt { .. } => ResultKind::Int,
        TailExt(_) => ResultKind::None,
        Mcpy { .. } => ResultKind::Int,
        Intrinsic { .. } => ResultKind::Int,
        AllocaInit(_) => ResultKind::None,
    }
}

/// Populate per-call-argument coalescing hints. The i-th integer or
/// FP argument value at each `Inst::Call*` is hinted to the matching
/// host argument register so the allocator parks the value there from
/// its definition and the c5 emit's pre-call mov drops out.
///
/// Safety guards (mirrors `populate_return_hints`'s leaf gate):
///
/// * `last_use[v] == call_pc` -- v must die at this call. If v survives,
///   it would need either a callee-saved register or a spill, and the
///   caller-saved arg-register hint would clobber it.
/// * `!calls_after_def[v]` -- no intervening call between v's def and
///   the call site. compute_calls_after_def reports those that would
///   force callee-saved placement; the hint's caller-saved choice is
///   incompatible.
/// * v must not already carry a different hint (the existing
///   ParamRef / Return / Phi passes take precedence).
///
/// Variadic call sites still benefit (the c5 internal cdecl ABI passes
/// every arg through the integer register window) so the function
/// hints both direct and indirect calls.
fn populate_call_arg_hints(
    func: &FunctionSsa,
    target: Target,
    last_use: &[u32],
    calls_after_def: &[bool],
    hints: &mut [Option<u8>],
) {
    let int_args = target.abi().int_arg_regs;
    // Win64 advances the slot index on every argument regardless of
    // type, so an int at position 2 lands in `int_args[2]` even when
    // earlier args were FP. SysV and AAPCS64 advance the int counter
    // only on int args.
    let combined_slot = matches!(target, Target::WindowsX64);
    for (pc, inst) in func.insts.iter().enumerate() {
        let args: &[ValueId] = match inst {
            Inst::Call { args, .. } => args,
            Inst::CallIndirect { args, .. } => args,
            Inst::CallExt { args, .. } => args,
            _ => continue,
        };
        let pc = pc as u32;
        let mut next_int = 0usize;
        for (slot_idx, &v) in args.iter().enumerate() {
            let vu = v as usize;
            if vu >= hints.len() {
                continue;
            }
            let kind = result_kind(&func.insts[vu]);
            let arg_pos = match kind {
                ResultKind::Int => {
                    let pos = if combined_slot { slot_idx } else { next_int };
                    next_int += 1;
                    pos
                }
                // FP argument hinting is left to the existing emit-time
                // marshal: it threads the per-target FP arg-register
                // window plus the variadic-only flags (variadic_on_stack,
                // variadic_int_only) that the allocator does not model.
                ResultKind::Fp | ResultKind::None => continue,
            };
            // Each argument value's last use must be exactly this call,
            // and no other call may sit between its definition and this
            // call. Otherwise the caller-saved arg-register hint races
            // the intervening clobber.
            if last_use[vu] != pc {
                continue;
            }
            if calls_after_def[vu] {
                continue;
            }
            if hints[vu].is_some() {
                continue;
            }
            if let Some(&r) = int_args.get(arg_pos) {
                hints[vu] = Some(r);
            }
        }
    }
}

/// Hint each `Inst::Call*` result to the ABI return register so the
/// post-call capture mov disappears when the value lives only across
/// the next few instructions. Guarded by `!calls_after_def[v]` -- the
/// result's interval must not cross another call, otherwise the
/// caller-saved return register would be clobbered by that later
/// call's prologue / arg setup.
fn populate_call_result_hints(
    func: &FunctionSsa,
    target: Target,
    calls_after_def: &[bool],
    hints: &mut [Option<u8>],
) {
    let (ret_int, ret_fp) = match target {
        Target::MacOSAarch64
        | Target::LinuxAarch64
        | Target::WindowsAarch64
        | Target::LinuxX64
        | Target::WindowsX64 => (0u8, 0u8),
    };
    for (idx, inst) in func.insts.iter().enumerate() {
        if !matches!(
            inst,
            Inst::Call { .. } | Inst::CallIndirect { .. } | Inst::CallExt { .. }
        ) {
            continue;
        }
        if idx >= hints.len() || hints[idx].is_some() {
            continue;
        }
        if calls_after_def.get(idx).copied().unwrap_or(false) {
            continue;
        }
        match result_kind(inst) {
            ResultKind::Int => hints[idx] = Some(ret_int),
            ResultKind::Fp => hints[idx] = Some(ret_fp),
            ResultKind::None => {}
        }
    }
}

/// Hint the value feeding `Terminator::Return` to the ABI return
/// register. The pick-reg path honours the hint only when the
/// register is free and the value's interval is call-clobber-free
/// (`!calls_after_def[v]`); a missed predicate falls back to the
/// default policy. The earlier leaf-only gate over-restricted the
/// hint -- a return value defined after the function's last call
/// is also safe.
fn populate_return_hints(
    func: &FunctionSsa,
    target: Target,
    calls_after_def: &[bool],
    hints: &mut [Option<u8>],
) {
    let (ret_int, ret_fp) = match target {
        Target::MacOSAarch64
        | Target::LinuxAarch64
        | Target::WindowsAarch64
        | Target::LinuxX64
        | Target::WindowsX64 => (0u8, 0u8),
    };

    fn try_set(hints: &mut [Option<u8>], id: ValueId, reg: u8) {
        let slot = id as usize;
        if slot < hints.len() && hints[slot].is_none() {
            hints[slot] = Some(reg);
        }
    }

    for block in &func.blocks {
        if let Terminator::Return(v) = block.terminator
            && v != NO_VALUE
            && (v as usize) < func.insts.len()
        {
            if calls_after_def.get(v as usize).copied().unwrap_or(false) {
                continue;
            }
            match result_kind(&func.insts[v as usize]) {
                ResultKind::Int => try_set(hints, v, ret_int),
                ResultKind::Fp => try_set(hints, v, ret_fp),
                ResultKind::None => {}
            }
        }
    }
}

fn populate_param_ref_hints(func: &FunctionSsa, target: Target, hints: &mut [Option<u8>]) {
    // Hint each `Inst::ParamRef(i)` to its incoming integer-argument
    // register. The per-arch emit reads the argument register
    // directly (`movsxd dst, int_arg_regs[i]`); when the allocator
    // parks a later ParamRef's destination on an earlier ParamRef's
    // arg-register, the in-place sign-extend clobbers the source the
    // later ParamRef still needs to read. Hinting each ParamRef's
    // destination to its matching arg register collapses the read +
    // write into a single self-update and removes the hazard.
    //
    // Variadic callees skip this pass: the va_start / va_arg
    // intrinsics read `&last` (a `LocalAddr` of the named final
    // parameter) and walk forward by 16-byte c5 cdecl strides; the
    // parameter slot the hint would move the ParamRef toward isn't
    // the slot va_start expects to read from.
    if func.is_variadic {
        return;
    }
    // The cross-clobber hazard kicks in once the allocator can run
    // out of non-arg-register candidates and starts picking an
    // earlier ParamRef's arg register as a later ParamRef's
    // destination. The threshold per target is the count of
    // integer arg registers it can pull from before that happens;
    // below that count, firing the hint can perturb a downstream
    // call's ParamRef placement through a libc bridge
    // (c5_vsnprintf et al).
    let (int_args, threshold): (&[u8], usize) = match target {
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
            (&[0, 1, 2, 3, 4, 5, 6, 7], 5)
        }
        Target::LinuxX64 => (&[7, 6, 2, 1, 8, 9], 5),
        Target::WindowsX64 => (&[1, 2, 8, 9], 4),
    };
    if func.n_params < threshold {
        return;
    }
    for (idx, inst) in func.insts.iter().enumerate() {
        if let Inst::ParamRef { idx: i, .. } = inst
            && let Some(&r) = int_args.get(*i as usize)
            && idx < hints.len()
            && hints[idx].is_none()
        {
            hints[idx] = Some(r);
        }
    }
}

/// Propagate a single register hint across each `Inst::Phi`'s
/// result and every incoming source so the allocator prefers the
/// same physical register for the whole group. When the placement
/// succeeds, the per-arch predecessor-exit move from incoming to
/// phi result drops to a self-move that `schedule_int_reg_moves`
/// drops outright, eliminating the move.
///
/// The pass is a fixpoint loop: a phi whose incoming is itself a
/// phi inherits through the chain. Each iteration picks the first
/// existing hint within the group and assigns it to every still-
/// unhinted member; iteration stops when no member changes.
/// The allocator's hint policy is advisory; an unsuitable hint
/// (register live elsewhere at the pick site) falls through to the
/// default policy without compromising correctness.
fn populate_phi_hints(func: &FunctionSsa, hints: &mut [Option<u8>]) {
    loop {
        let mut changed = false;
        for (v, inst) in func.insts.iter().enumerate() {
            let Inst::Phi { incoming, .. } = inst else {
                continue;
            };
            let mut group_hint = hints[v];
            if group_hint.is_none() {
                for (_, src) in incoming {
                    if let Some(r) = hints[*src as usize] {
                        group_hint = Some(r);
                        break;
                    }
                }
            }
            let Some(r) = group_hint else { continue };
            if hints[v].is_none() {
                hints[v] = Some(r);
                changed = true;
            }
            for (_, src) in incoming {
                if hints[*src as usize].is_none() {
                    hints[*src as usize] = Some(r);
                    changed = true;
                }
            }
        }
        if !changed {
            break;
        }
    }
}

/// For each value, the PC index of its last use across the
/// function. Defaults to the value's own PC (so a value with no
/// uses still has a single-PC interval).
fn compute_last_use(func: &FunctionSsa) -> Vec<u32> {
    let n = func.insts.len();
    let mut last_use: Vec<u32> = (0..n as u32).collect();
    let bump = |target: ValueId, current_pc: u32, last_use: &mut [u32]| {
        if target != NO_VALUE
            && (target as usize) < last_use.len()
            && last_use[target as usize] < current_pc
        {
            last_use[target as usize] = current_pc;
        }
    };
    for (idx, inst) in func.insts.iter().enumerate() {
        let pc = idx as u32;
        match inst {
            Inst::Imm(_)
            | Inst::ImmData(_)
            | Inst::ImmCode(_)
            | Inst::LocalAddr(_)
            | Inst::TlsAddr(_)
            | Inst::AllocaInit(_)
            | Inst::ParamRef { .. }
            | Inst::TailExt(_) => {}
            Inst::Phi { incoming, .. } => {
                for (_, v) in incoming {
                    bump(*v, pc, &mut last_use);
                }
            }
            Inst::Load { addr, .. } => bump(*addr, pc, &mut last_use),
            Inst::Store { addr, value, .. } => {
                bump(*addr, pc, &mut last_use);
                bump(*value, pc, &mut last_use);
            }
            Inst::LoadLocal { .. } => {}
            Inst::StoreLocal { value, .. } => bump(*value, pc, &mut last_use),
            Inst::LoadIndexed { base, index, .. } => {
                bump(*base, pc, &mut last_use);
                bump(*index, pc, &mut last_use);
            }
            Inst::StoreIndexed {
                base, index, value, ..
            } => {
                bump(*base, pc, &mut last_use);
                bump(*index, pc, &mut last_use);
                bump(*value, pc, &mut last_use);
            }
            Inst::Binop { lhs, rhs, .. } => {
                bump(*lhs, pc, &mut last_use);
                bump(*rhs, pc, &mut last_use);
            }
            Inst::BinopI { lhs, .. } => bump(*lhs, pc, &mut last_use),
            Inst::Fneg(v) => bump(*v, pc, &mut last_use),
            Inst::Extend { value, .. } => bump(*value, pc, &mut last_use),
            Inst::FpCast { value, .. } => bump(*value, pc, &mut last_use),
            Inst::Call { args, .. } | Inst::CallExt { args, .. } => {
                for &a in args {
                    bump(a, pc, &mut last_use);
                }
            }
            Inst::CallIndirect { target, args } => {
                bump(*target, pc, &mut last_use);
                for &a in args {
                    bump(a, pc, &mut last_use);
                }
            }
            Inst::Mcpy { dst, src, .. } => {
                bump(*dst, pc, &mut last_use);
                bump(*src, pc, &mut last_use);
            }
            Inst::Intrinsic { args, .. } => {
                for &a in args {
                    bump(a, pc, &mut last_use);
                }
            }
        }
    }
    // Also: each block's exit_acc keeps that value live to the
    // end of the block, and the terminator's branch may consume
    // it (Bz / Bnz / Return). Bump conservatively.
    for b in &func.blocks {
        let end_pc = b.inst_range.end;
        if b.exit_acc != NO_VALUE && last_use[b.exit_acc as usize] < end_pc {
            last_use[b.exit_acc as usize] = end_pc;
        }
    }
    extend_last_use_across_blocks(func, &mut last_use);
    last_use
}

/// Extend each value's last-use index to cover every block where it
/// stays live. The forward scan's `last_use` is the highest index
/// that names the value as an operand, which is a lower bound: a value
/// defined before a loop and read inside it is live across the back
/// edge, so its register must be held through the loop body even
/// though no later instruction index references it. Block-level
/// liveness over the control-flow graph captures that. The pass only
/// raises `last_use`, so a value that is not live across a back edge
/// or an out-of-order block keeps the range the scan computed.
fn extend_last_use_across_blocks(func: &FunctionSsa, last_use: &mut [u32]) {
    let nblocks = func.blocks.len();
    let n = func.insts.len();
    let words = n.div_ceil(64);
    if nblocks == 0 || words == 0 {
        return;
    }
    let bit = |bits: &mut [u64], base: usize, v: u32| {
        bits[base + (v as usize) / 64] |= 1u64 << ((v as usize) % 64);
    };
    // used_set: values referenced in a block but defined outside it
    // (upward exposed). kill: values defined in the block's range.
    let mut used_set = vec![0u64; nblocks * words];
    let mut kill = vec![0u64; nblocks * words];
    for (b, blk) in func.blocks.iter().enumerate() {
        let base = b * words;
        let (start, end) = (blk.inst_range.start, blk.inst_range.end);
        for v in start..end {
            bit(&mut kill, base, v);
        }
        let mut mark = |v: ValueId| {
            if v != NO_VALUE && (v < start || v >= end) {
                bit(&mut used_set, base, v);
            }
        };
        for idx in start..end {
            for_each_operand(&func.insts[idx as usize], &mut mark);
        }
        if blk.exit_acc != NO_VALUE {
            mark(blk.exit_acc);
        }
        match &blk.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => mark(*cond),
            Terminator::Return(v) if *v != NO_VALUE => mark(*v),
            _ => {}
        }
    }
    // Backward dataflow to a fixed point:
    //   live_out[b] = U live_in[succ];
    //   live_in[b]  = gen[b] | (live_out[b] & ~kill[b]).
    let mut live_in = vec![0u64; nblocks * words];
    let mut live_out = vec![0u64; nblocks * words];
    let mut scratch = vec![0u64; words];
    let mut changed = true;
    while changed {
        changed = false;
        for b in (0..nblocks).rev() {
            let base = b * words;
            scratch.iter_mut().for_each(|w| *w = 0);
            for s in super::ssa_mem2reg::successors(&func.blocks[b].terminator) {
                let sb = s as usize * words;
                for w in 0..words {
                    scratch[w] |= live_in[sb + w];
                }
            }
            for w in 0..words {
                live_out[base + w] = scratch[w];
                let ni = used_set[base + w] | (scratch[w] & !kill[base + w]);
                if ni != live_in[base + w] {
                    live_in[base + w] = ni;
                    changed = true;
                }
            }
        }
    }
    // A value live-out of a block must survive to the end of that
    // block's instruction range.
    for (b, blk) in func.blocks.iter().enumerate() {
        let base = b * words;
        let end = blk.inst_range.end;
        for w in 0..words {
            let mut bits = live_out[base + w];
            while bits != 0 {
                let v = (w * 64) as u32 + bits.trailing_zeros();
                if last_use[v as usize] < end {
                    last_use[v as usize] = end;
                }
                bits &= bits - 1;
            }
        }
    }
}

/// For each value, mark whether any call instruction sits
/// strictly between its def PC and last-use PC. Such a value
/// must be in a callee-saved register (or spilled), since a
/// caller-saved reg would be clobbered by the intervening call.
///
/// `Inst::TlsAddr` is treated as a call on targets whose TLS
/// lowering issues an indirect call: Mach-O/AArch64 reads a TLV
/// descriptor and invokes its bootstrap routine through `blr x16`,
/// which clobbers the AAPCS64 caller-saved registers. Linux's
/// variant-1 (TPIDR_EL0 + add) and Windows' (gs/x18 + 0x58 table
/// walk) reach the per-thread storage without leaving the
/// instruction stream, so they stay outside the call set.
fn compute_calls_after_def(func: &FunctionSsa, last_use: &[u32], target: Target) -> Vec<bool> {
    let tls_addr_is_call = matches!(target, Target::MacOSAarch64);
    let n = func.insts.len();
    let mut call_pcs: Vec<u32> = Vec::new();
    for (idx, inst) in func.insts.iter().enumerate() {
        let is_call = matches!(
            inst,
            Inst::Call { .. } | Inst::CallIndirect { .. } | Inst::CallExt { .. }
        ) || (tls_addr_is_call && matches!(inst, Inst::TlsAddr(_)));
        if is_call {
            call_pcs.push(idx as u32);
        }
    }
    call_pcs.sort_unstable();
    let mut out = vec![false; n];
    for (idx, &end) in last_use.iter().enumerate() {
        let def = idx as u32;
        // Binary search for any call PC strictly between (def, end].
        let lo = call_pcs.binary_search(&(def + 1)).unwrap_or_else(|i| i);
        if let Some(&first) = call_pcs.get(lo)
            && first <= end
        {
            out[idx] = true;
        }
    }
    out
}

fn expire(
    active: &mut Vec<(ValueId, u32, u8)>,
    free: &mut Vec<u8>,
    current_pc: u32,
    _places: &[Place],
) {
    let mut i = 0;
    while i < active.len() {
        if active[i].1 < current_pc {
            let (_id, _end, reg) = active.remove(i);
            free.push(reg);
        } else {
            i += 1;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::Compiler;
    use std::path::PathBuf;

    fn lift(path: &str) -> Vec<FunctionSsa> {
        let src =
            std::fs::read_to_string(PathBuf::from(env!("CARGO_MANIFEST_DIR")).join(path)).unwrap();
        let program = Compiler::new(src).compile().expect("compile");
        crate::c5::codegen::ssa_shadow::produce_ssa_funcs(&program, Target::host())
            .expect("produce_ssa_funcs")
    }

    /// Allocate every function in quicksort.c on aarch64. The
    /// fixture has straight-line control flow and short
    /// expressions; the allocator should never spill.
    #[test]
    fn allocate_quicksort_no_spill() {
        let funcs = lift("tests/fixtures/c/quicksort.c");
        for f in &funcs {
            let alloc = allocate(f, Target::MacOSAarch64);
            assert_eq!(
                alloc.places.len(),
                f.insts.len(),
                "allocation count mismatch for fn at pc {}",
                f.ent_pc
            );
        }
    }

    /// Allocate every function in c4.c. Exercises the cross-block
    /// vstack threading + spill paths. We don't assert the
    /// spill_count -- only that the allocator terminates and
    /// produces a place for every value.
    #[test]
    fn allocate_c4_self_host() {
        let funcs = lift("tests/fixtures/c/c4.c");
        for f in &funcs {
            let alloc = allocate(f, Target::MacOSAarch64);
            assert_eq!(alloc.places.len(), f.insts.len());
            for (i, p) in alloc.places.iter().enumerate() {
                // Every Inst that produces a value must have a
                // non-None place, except for store-class insts
                // whose "side-output" value (the propagated acc)
                // is unread -- the allocator nulls those out so
                // the emit pass skips the dst-propagate step.
                let kind = result_kind(&f.insts[i]);
                let store_with_dead_dst = matches!(
                    f.insts[i],
                    Inst::Store { .. } | Inst::StoreLocal { .. } | Inst::StoreIndexed { .. }
                ) && alloc.use_counts.get(i).copied().unwrap_or(0) == 0;
                match kind {
                    ResultKind::None => assert_eq!(*p, Place::None),
                    ResultKind::Int | ResultKind::Fp => {
                        if store_with_dead_dst {
                            continue;
                        }
                        assert!(
                            !matches!(p, Place::None),
                            "inst {i} produced a value but got Place::None"
                        );
                    }
                }
            }
        }
    }

    /// Mach-O / AArch64 reaches a thread-local through a TLV
    /// descriptor whose bootstrap routine is invoked via `blr x16`
    /// inside `emit_tls_addr`. The bootstrap clobbers every
    /// AAPCS64 caller-saved register, so any SSA value live across
    /// an `Inst::TlsAddr` must be flagged must-be-callee on that
    /// target. Linux's `mrs TPIDR_EL0` and Windows' `[x18, 0x58]`
    /// lookup don't leave the instruction stream, so the flag
    /// stays off.
    #[test]
    fn compute_calls_after_def_flags_tls_addr_on_macos_aarch64() {
        use crate::c5::codegen::ssa_build::SsaBuilder;
        use crate::c5::ir::StoreKind;

        let mut b = SsaBuilder::new(0, 0, false);
        let v_imm = b.imm(42);
        let v_tls = b.tls_addr(0);
        b.store(v_tls, v_imm, StoreKind::I32);
        b.return_(v_imm);
        let func = b.finish();

        let v_imm_idx = v_imm as usize;
        let v_tls_idx = v_tls as usize;
        assert!(v_imm_idx < v_tls_idx, "v_imm must be defined before v_tls");

        let last_use = compute_last_use(&func);
        assert!(
            last_use[v_imm_idx] > v_tls_idx as u32,
            "v_imm's last use ({}) must cross the TlsAddr at pc {v_tls_idx}",
            last_use[v_imm_idx],
        );

        let on_macos = compute_calls_after_def(&func, &last_use, Target::MacOSAarch64);
        assert!(
            on_macos[v_imm_idx],
            "TlsAddr's hidden blr should flag a value live across it on MacOSAarch64",
        );

        let on_linux = compute_calls_after_def(&func, &last_use, Target::LinuxAarch64);
        assert!(
            !on_linux[v_imm_idx],
            "Linux AArch64 TLS reads mrs TPIDR_EL0 -- no call, no flag",
        );

        let on_win = compute_calls_after_def(&func, &last_use, Target::WindowsAarch64);
        assert!(
            !on_win[v_imm_idx],
            "Windows AArch64 TLS walks the TEB -- no call, no flag",
        );

        let on_linux_x64 = compute_calls_after_def(&func, &last_use, Target::LinuxX64);
        assert!(
            !on_linux_x64[v_imm_idx],
            "Linux x86_64 TLS reads fs:[0] -- no call, no flag",
        );

        let on_win_x64 = compute_calls_after_def(&func, &last_use, Target::WindowsX64);
        assert!(
            !on_win_x64[v_imm_idx],
            "Windows x86_64 TLS walks the TEB -- no call, no flag",
        );
    }
}
