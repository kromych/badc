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
    populate_return_hints(func, target, &mut hints);
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
    // Call-argument coalescing hints. Run after `last_use` and
    // `calls_after_def` so the per-value safety guards can read them.
    // The prior unconditional ABI-hint pass was reverted in commit
    // 1609bbc after it sent a value to a caller-saved arg register
    // even when the value's interval extended past the call --
    // a later use then read the call-clobbered register. Restrict
    // the hint to values whose last use is exactly this call so the
    // call consumes them and there is no surviving live range to
    // protect.
    populate_call_arg_hints(func, target, &last_use, &calls_after_def, &mut hints);
    populate_call_result_hints(func, target, &calls_after_def, &mut hints);
    // Back-edge phi source per inst: if v_src is an incoming source for
    // some phi v_phi where v_src is defined later in PC order than the
    // phi, record v_phi against v_src. At v_src's pick site below the
    // scan transfers v_phi's reg to v_src so the phi result and its
    // back-edge source share a single physical register. Without this
    // the predecessor-exit move from b_pred to v_phi at the loop header
    // reads v_src from a register that the passthrough block clobbered
    // between v_src's def and the back edge.
    let back_edge_phi_of: Vec<ValueId> = compute_back_edge_phi_of(func);

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

        // Back-edge phi source: this inst writes the value that some
        // earlier phi reads from its predecessor block. Force the dst
        // into the phi's register so the predecessor-exit move at the
        // back edge becomes a self-mov. Manually retire the phi result
        // from the active list -- by SSA semantics the phi value is
        // logically dead from here onward, replaced by this inst's
        // result, and subsequent reads of the phi value land on the
        // same register that this inst writes into.
        if kind == ResultKind::Int && back_edge_phi_of[idx] != NO_VALUE {
            let phi_v = back_edge_phi_of[idx];
            if let Place::IntReg(r) = places[phi_v as usize] {
                if let Some(pos) = active_int.iter().position(|(v, _, _)| *v == phi_v) {
                    active_int.remove(pos);
                    free_int.push(r);
                }
                if hints[idx].is_none() {
                    hints[idx] = Some(r);
                }
            }
        }

        // For a Binop / BinopI / Extend / Fneg whose lhs operand dies
        // at this very pc, set the dst's hint to lhs's register so the
        // 2-operand fusion kicks in (x86_64 `add Rd, Rm` with Rd == lhs;
        // aarch64 `add Rd, Rn, Rm` with Rd == Rn drops the prior mov).
        // For commutative Binops (Add, Mul, And, Or, Xor) also try rhs
        // when lhs lives past pc but rhs dies -- x86_64's emit detects
        // `rhs_aliases_rd && commutative` and folds the staging mov.
        // Apply only when the hint is still empty and the candidate reg
        // satisfies the must-be-callee constraint; an already-set hint
        // (call-result / phi / param-ref / call-arg) takes priority.
        if hints[idx].is_none() {
            let coalesce_src = match inst {
                Inst::Binop { op, lhs, rhs } => {
                    let lhs_dies =
                        (*lhs as usize) < last_use.len() && last_use[*lhs as usize] == pc;
                    let rhs_dies =
                        (*rhs as usize) < last_use.len() && last_use[*rhs as usize] == pc;
                    // Set matches the x86_64 emit's `rhs_aliases_rd
                    // && commutative` fast path. Eq / Ne / Fadd /
                    // Fmul are mathematically commutative but reach
                    // the dst via different codegen paths that do
                    // not collapse the staging mov when dst == rhs.
                    let commutative = matches!(
                        op,
                        BinOp::Add | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor
                    );
                    if lhs_dies {
                        Some(*lhs)
                    } else if rhs_dies && commutative {
                        Some(*rhs)
                    } else {
                        None
                    }
                }
                Inst::BinopI { lhs, .. } => Some(*lhs),
                Inst::Extend { value, .. } => Some(*value),
                Inst::Fneg(v) => Some(*v),
                // Load's address register is read once at the load and
                // freed; the load writes the same bank (int) so dst can
                // reuse the addr's register if it dies here. x86_64
                // `mov rd, [rd]` and aarch64 `ldr rd, [rd]` both read
                // the operand before writing the result.
                Inst::Load { addr, .. } => Some(*addr),
                // Mcpy returns its `dst` pointer (memcpy contract).
                // When the dst operand dies at the Mcpy, the result
                // can reuse its register: the unrolled-copy loop
                // reads dst_r as the store base but never overwrites
                // it, so dst_r still carries the same pointer after
                // the loop. The final `mov result_r, dst_r` then
                // self-mov-elides.
                Inst::Mcpy { dst: m_dst, .. } => Some(*m_dst),
                _ => None,
            };
            if let Some(src) = coalesce_src
                && src != NO_VALUE
                && (src as usize) < last_use.len()
                && last_use[src as usize] == pc
            {
                let src_place = places[src as usize];
                let src_reg = match (kind, src_place) {
                    (ResultKind::Int, Place::IntReg(r)) => Some(r),
                    (ResultKind::Fp, Place::FpReg(r)) => Some(r),
                    _ => None,
                };
                if let Some(r) = src_reg
                    && (!must_be_callee || !banks.caller_gprs.contains(&r))
                {
                    // Retire src's interval to the free pool early: it
                    // would expire at pc + 1 anyway, and the dst pick
                    // below now sees src's reg as free.
                    let bank_active = match kind {
                        ResultKind::Int => &mut active_int,
                        ResultKind::Fp => &mut active_fp,
                        ResultKind::None => unreachable!(),
                    };
                    let bank_free = match kind {
                        ResultKind::Int => &mut free_int,
                        ResultKind::Fp => &mut free_fp,
                        ResultKind::None => unreachable!(),
                    };
                    if let Some(pos) = bank_active.iter().position(|(v, _, _)| *v == src) {
                        bank_active.remove(pos);
                        bank_free.push(r);
                        hints[idx] = Some(r);
                    }
                }
            }
        }
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
                // ParamRefs materialise in inst order. Hinting
                // ParamRef(pi)'s value into int_args[k] for any k
                // beyond pi writes through a register that a later
                // ParamRef(k) still needs to read, scrambling the
                // incoming arguments. Refuse the hint in that shape;
                // the value goes through the regular pick path
                // instead of the coalesced arg-reg.
                if let Inst::ParamRef { idx: pi, .. } = func.insts[vu]
                    && (pi as usize) < int_args.len()
                    && int_args[(pi as usize)..]
                        .iter()
                        .skip(1)
                        .any(|&later| later == r)
                {
                    continue;
                }
                hints[vu] = Some(r);
            }
        }
    }
}

/// Hint each `Inst::Call*`'s defined value to the ABI return register
/// so the post-call capture mov drops out when the result's interval
/// is call-clobber-free. Guarded by `!calls_after_def[idx]` -- a
/// caller-saved return register would be clobbered by any later call's
/// prologue or arg setup.
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

/// Populate coalescing hints for ABI-fixed registers so the linear
/// scan lands call arguments directly in their ABI register, captures
/// a call result in the return register, and keeps a Return-value in
/// the return register. The pick-reg path honours each hint only when
/// the register is free and live-across-call-compatible, so a missed
/// hint falls back to the default policy.
fn populate_return_hints(func: &FunctionSsa, target: Target, hints: &mut [Option<u8>]) {
    // Hint the value feeding `Terminator::Return` to the ABI return
    // register so the exit move drops out. Two cases are honoured:
    //
    //   * Leaf functions (no `Inst::Call*` anywhere). Empirically
    //     safe -- no call can clobber the caller-saved return register.
    //   * Single-block functions where the Return value's def has
    //     no call between it and the terminator. Straight-line
    //     control flow means there is no back-edge / phi-merge gap
    //     that the broader per-value relaxation otherwise surfaces
    //     (see task #197 -- the lua regression on broader relaxations
    //     does not appear in straight-line shapes).
    let has_call = func.insts.iter().any(|inst| {
        matches!(
            inst,
            Inst::Call { .. } | Inst::CallIndirect { .. } | Inst::CallExt { .. }
        )
    });
    let single_block = func.blocks.len() == 1;
    if has_call && !single_block {
        return;
    }
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
            if has_call {
                // Single-block branch: require v's def to live in
                // this block AND no call after the def. Without
                // these guards the hint clobbers v across the call.
                let (start, end) = (block.inst_range.start, block.inst_range.end);
                if v < start || v >= end {
                    continue;
                }
                let intervening_call = (v + 1..end).any(|pc| {
                    matches!(
                        func.insts[pc as usize],
                        Inst::Call { .. } | Inst::CallIndirect { .. } | Inst::CallExt { .. }
                    )
                });
                if intervening_call {
                    continue;
                }
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
/// For each SSA value, the phi value-id whose back-edge incoming slot
/// this value fills. `NO_VALUE` for any value that does not write a
/// back-edge phi source. A back-edge source is a phi `v_phi` with an
/// incoming `(_, v_src)` where `v_src > v_phi`: `v_src` is defined
/// later in PC order than the phi reading it, i.e. the value flows
/// around a loop. Only the first phi that names the value is recorded;
/// a value that feeds multiple back-edge phis is handled by the first
/// and the rest fall through to the regular allocation path.
fn compute_back_edge_phi_of(func: &FunctionSsa) -> Vec<ValueId> {
    let n = func.insts.len();
    let mut be_of: Vec<ValueId> = alloc::vec![NO_VALUE; n];
    for (idx, inst) in func.insts.iter().enumerate() {
        let Inst::Phi { incoming, .. } = inst else {
            continue;
        };
        let phi_pc = idx as ValueId;
        for (_, src) in incoming {
            if *src == NO_VALUE {
                continue;
            }
            if *src > phi_pc && (*src as usize) < n && be_of[*src as usize] == NO_VALUE {
                be_of[*src as usize] = phi_pc;
            }
        }
    }
    be_of
}

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
                    if *src == NO_VALUE || (*src as usize) >= hints.len() {
                        continue;
                    }
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
                if *src == NO_VALUE || (*src as usize) >= hints.len() {
                    continue;
                }
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
    for (idx, inst) in func.insts.iter().enumerate() {
        let pc = idx as u32;
        for_each_operand(inst, |target| {
            if target != NO_VALUE
                && (target as usize) < last_use.len()
                && last_use[target as usize] < pc
            {
                last_use[target as usize] = pc;
            }
        });
    }
    // Each block's exit_acc keeps that value live to the end of the
    // block, and the terminator may consume operands too. Bump every
    // such carrier to `end_pc` so a value defined inside the block
    // but read only by the terminator (the common Return-value case)
    // has its interval cover any intervening call. Without this the
    // forward scan leaves `last_use[v]` at v's own def PC, the
    // `compute_calls_after_def` interval test then misses the
    // intervening call, and a downstream coalescing hint can place
    // `v` in a caller-saved register that the call clobbers.
    for b in &func.blocks {
        let end_pc = b.inst_range.end;
        let mut bump = |v: ValueId| {
            if v != NO_VALUE && (v as usize) < last_use.len() && last_use[v as usize] < end_pc {
                last_use[v as usize] = end_pc;
            }
        };
        bump(b.exit_acc);
        match &b.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => bump(*cond),
            Terminator::Return(v) => bump(*v),
            _ => {}
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
    // phi_live_out: per-predecessor set of phi-incoming values --
    // these must be live at the end of the predecessor regardless
    // of where they are defined (a loop body whose phi reads a value
    // defined in that same body needs the value to survive the back
    // edge, but `~kill[B]` would otherwise drop it).
    let mut used_set = vec![0u64; nblocks * words];
    let mut kill = vec![0u64; nblocks * words];
    let mut phi_live_out = vec![0u64; nblocks * words];
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
            if let Inst::Phi { incoming, .. } = &func.insts[idx as usize] {
                for (pred, v) in incoming {
                    if *v != NO_VALUE {
                        bit(&mut phi_live_out, (*pred as usize) * words, *v);
                    }
                }
                continue;
            }
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
    //   live_out[b] = phi_live_out[b] | U live_in[succ];
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
                scratch[w] |= phi_live_out[base + w];
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
    // Call-arg coalescing: the upper bound is `first < end`. A
    // call at exactly `last_use` is the value's consumer; its arg
    // marshal reads the value before the callee runs, so the
    // value lives in a caller-saved arg-register and
    // `populate_call_arg_hints` can hint it to the matching slot.
    // Five emit-layer prerequisites are in tree: the ParamRef
    // ordering guard, the x86_64 + aarch64 CallIndirect target-
    // scratch pickers, and the scratch-aware cycle-break in both
    // per-arch `schedule_int_reg_moves` implementations.
    let mut out = vec![false; n];
    for (idx, &end) in last_use.iter().enumerate() {
        let def = idx as u32;
        let lo = call_pcs.binary_search(&(def + 1)).unwrap_or_else(|i| i);
        if let Some(&first) = call_pcs.get(lo)
            && first < end
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

    /// For commutative Binops (Add, Mul, And, Or, Xor) the in-loop
    /// coalesce hint targets rhs when lhs lives past pc and rhs dies
    /// at pc. The x86_64 emit's `rhs_aliases_rd && commutative` fast
    /// path then folds the staging mov to `OP rd, lhs` directly.
    #[test]
    fn binop_rhs_coalesce_fires_when_lhs_outlives_rhs() {
        use crate::c5::codegen::ssa_build::SsaBuilder;
        use crate::c5::ir::StoreKind;

        // v_lhs lives past the binop (consumed by the Store addr and
        // also returned). v_rhs dies at the binop. The binop is Add
        // (commutative). Return v_lhs (not v_sum) so the return hint
        // does not steal the binop's slot.
        let mut b = SsaBuilder::new(0, 0, false);
        let v_lhs = b.imm(7);
        let v_rhs = b.imm(11);
        let v_sum = b.binop(super::super::super::ir::BinOp::Add, v_lhs, v_rhs);
        b.store(v_lhs, v_sum, StoreKind::I64);
        b.return_(v_lhs);
        let func = b.finish();

        let alloc = allocate(&func, Target::LinuxX64);
        let rhs_place = alloc.places[v_rhs as usize];
        let sum_place = alloc.places[v_sum as usize];
        assert_eq!(
            sum_place, rhs_place,
            "v_sum should reuse v_rhs's freed register",
        );
    }

    /// `Inst::Load { addr }` reads `addr` and writes the result into
    /// the same bank. When `addr` dies at the load, the dst hint
    /// targets its register so the x86_64 `mov rd, [rd]` and aarch64
    /// `ldr rd, [rd]` shapes self-elide the staging mov. Returning a
    /// constant rather than the load lets `populate_return_hints`
    /// skip the load result so the in-loop coalesce gets the slot.
    #[test]
    fn load_addr_coalesce_fires_when_addr_dies_at_load() {
        use crate::c5::codegen::ssa_build::SsaBuilder;
        use crate::c5::ir::LoadKind;
        use crate::c5::ir::StoreKind;

        let mut b = SsaBuilder::new(0, 0, false);
        let v_addr = b.imm(0x1000);
        let v_load = b.load(v_addr, LoadKind::I64);
        let v_zero = b.imm(0);
        b.store(v_zero, v_load, StoreKind::I64);
        b.return_(v_zero);
        let func = b.finish();

        // x86_64 `mov rd, [rd]` and aarch64 `ldr rd, [rd]` both read
        // the addr operand before writing the result, so the coalesce
        // arm fires identically across targets.
        for target in [
            Target::MacOSAarch64,
            Target::LinuxAarch64,
            Target::WindowsAarch64,
            Target::LinuxX64,
            Target::WindowsX64,
        ] {
            let alloc = allocate(&func, target);
            let addr_place = alloc.places[v_addr as usize];
            let load_place = alloc.places[v_load as usize];
            assert_eq!(
                load_place, addr_place,
                "v_load should reuse v_addr's freed register on {target:?}",
            );
        }
    }

    /// `Inst::Mcpy { dst, src, size }` returns its `dst` pointer.
    /// When `dst` dies at the Mcpy, the result re-uses its register
    /// so the final `mov result, dst` self-elides. `b.mcpy()`
    /// discards push's ValueId so the test locates the Mcpy inst by
    /// scanning the finished function. Return a constant so the
    /// return-hint pass does not pre-empt the Mcpy result's slot.
    #[test]
    fn mcpy_dst_coalesce_fires_when_dst_dies_at_mcpy() {
        use crate::c5::codegen::ssa_build::SsaBuilder;

        let mut b = SsaBuilder::new(0, 0, false);
        let v_dst = b.imm(0x2000);
        let v_src = b.imm(0x3000);
        b.mcpy(v_dst, v_src, 8);
        let v_zero = b.imm(0);
        b.return_(v_zero);
        let func = b.finish();

        let mcpy_idx = func
            .insts
            .iter()
            .position(|i| matches!(i, Inst::Mcpy { .. }))
            .expect("Mcpy inst");
        // The coalesce hint is target-independent: the Mcpy emit on
        // every supported target reads the dst-pointer operand once
        // and never overwrites it, so the result-reuse arm fires
        // identically. Exercise every target so an arch-specific
        // emit change that violates the no-overwrite invariant fails
        // here at allocation time rather than later in a fixture.
        for target in [
            Target::MacOSAarch64,
            Target::LinuxAarch64,
            Target::WindowsAarch64,
            Target::LinuxX64,
            Target::WindowsX64,
        ] {
            let alloc = allocate(&func, target);
            let dst_place = alloc.places[v_dst as usize];
            let mcpy_place = alloc.places[mcpy_idx];
            assert_eq!(
                mcpy_place, dst_place,
                "Mcpy result should reuse v_dst's freed register on {target:?}",
            );
        }
    }

    /// A loop header `phi(v_init, v_back)` with `v_back` defined in the
    /// loop body shares a single physical register with the phi result.
    /// Without this coalesce, the passthrough block between v_back's
    /// def and the loop header phi (the for-loop step or any
    /// terminator-only block) is free to clobber `v_back`'s register
    /// for unrelated values, and the predecessor-exit move at the back
    /// edge reads the wrong value.
    #[test]
    fn phi_back_edge_source_coalesces_with_phi_result() {
        use crate::c5::ir::{Block, FunctionSsa};
        // CFG:
        //   b0 -> b1
        //   b1: phi(b0:v_zero, b2:v_step); Bz exit b2
        //   b2: v_step = v_phi + 1; Jmp b1
        //   b3 (exit): Return v_phi
        let insts = alloc::vec![
            // block 0: v0 = Imm(0)
            Inst::Imm(0),
            // block 1: v1 = Phi { incoming=[b0:v0, b2:v3] }
            Inst::Phi {
                incoming: alloc::vec![(0, 0), (2, 3)],
                kind: LoadKind::I64,
            },
            // block 2: v2 = Imm(1); v3 = v1 + v2
            Inst::Imm(1),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 1,
                rhs: 2,
            },
            // block 3 (exit): no inst; Return v1
        ];
        let blocks = alloc::vec![
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
                    target: 3,
                    fall_through: 2,
                },
                exit_acc: 1,
            },
            Block {
                start_pc: 0,
                inst_range: 2..4,
                terminator: Terminator::Jmp(1),
                exit_acc: 3,
            },
            Block {
                start_pc: 0,
                inst_range: 4..4,
                terminator: Terminator::Return(1),
                exit_acc: 1,
            },
        ];
        let func = FunctionSsa {
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            n_params: 0,
            is_variadic: false,
            is_inline: false,
            inst_src: alloc::vec![(0, 0); insts.len()],
            insts,
            blocks,
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        };
        for target in [
            Target::MacOSAarch64,
            Target::LinuxAarch64,
            Target::WindowsAarch64,
            Target::LinuxX64,
            Target::WindowsX64,
        ] {
            let alloc = allocate(&func, target);
            let phi_place = alloc.places[1];
            let step_place = alloc.places[3];
            assert_eq!(
                phi_place, step_place,
                "phi result (v1) and its back-edge source (v3) must coalesce on {target:?}",
            );
        }
    }
}
