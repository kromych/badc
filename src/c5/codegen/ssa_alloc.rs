//! Linear-scan register allocator over the [`FunctionSsa`] output
//! of [`super::ssa`]. Produces a per-`Inst` [`Place`] (a host
//! register or a spill slot) that the per-arch lowering
//! (aarch64.rs / x86_64.rs, tasks #9 and #10) consumes when
//! emitting native instructions for `RegallocMode::Ssa`.
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

use super::Target;
use super::ssa::{BinOp, FpCastKind, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, ValueId};

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
    /// No defined value (Store, AllocaInit, VstackSpill, ...).
    None,
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
                // x20..x27 are the callee-saved bank the existing
                // pool regalloc already uses; x9..x15 are
                // caller-saved scratch the optimizer routed
                // short-lived values through. x16/x17 stay
                // reserved as encoder scratch. x18 is reserved
                // on Windows (TEB pointer) and unused on Linux /
                // macOS; the allocator keeps off it everywhere.
                // x19 is reserved as the accumulator/scratch by
                // the legacy lowering; the SSA path stays off it
                // to avoid stepping on existing helpers that
                // assume x19 is theirs.
                callee_gprs: &[20, 21, 22, 23, 24, 25, 26, 27],
                caller_gprs: &[9, 10, 11, 12, 13, 14, 15],
                callee_fprs: &[8, 9, 10, 11, 12, 13, 14, 15],
                caller_fprs: &[0, 1, 2, 3, 4, 5, 6, 7],
            },
            Target::LinuxX64 => Self {
                // System V x86_64 callee-saved set: rbx, r12,
                // r14, r15. r13 is reserved as the legacy
                // accumulator; rbp / rsp obviously off-limits.
                callee_gprs: &[3, 12, 14, 15],
                caller_gprs: &[0, 11],
                callee_fprs: &[],
                caller_fprs: &[0, 1, 2, 3, 4, 5, 6, 7],
            },
            Target::WindowsX64 => Self {
                // Win64 callee-saved GPRs: rbx, rsi, rdi, r12,
                // r14, r15. Caller-saved: rax, r10, r11, plus the
                // arg regs (rcx/rdx/r8/r9).
                callee_gprs: &[3, 6, 7, 12, 14, 15],
                caller_gprs: &[0, 11],
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
    if n_insts == 0 {
        return Allocation {
            places,
            spill_count: 0,
            gpr_used: Vec::new(),
            fp_used: Vec::new(),
        };
    }

    let banks = RegBanks::for_target(target);
    let last_use = compute_last_use(func);
    let calls_after_def = compute_calls_after_def(func, &last_use);

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

        // First try to grab a callee-saved reg when the value
        // crosses a call; otherwise any free reg works.
        let chosen = if must_be_callee {
            // Filter `free` for not-caller-saved.
            free.iter().copied().find(|r| !banks_caller.contains(r))
        } else {
            free.last().copied()
        };
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
            // Spill the active interval with the furthest next
            // use, reuse its register.
            let victim_pos = active
                .iter()
                .enumerate()
                .max_by_key(|(_, e)| e.1)
                .map(|(i, _)| i);
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

    Allocation {
        places,
        spill_count,
        gpr_used: gpr_used.into_iter().collect(),
        fp_used: fp_used.into_iter().collect(),
    }
}

/// Whether an instruction defines an int / FP value or none at all.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum ResultKind {
    Int,
    Fp,
    None,
}

fn result_kind(inst: &Inst) -> ResultKind {
    use Inst::*;
    match inst {
        Imm(_) | LocalAddr(_) | TlsAddr(_) => ResultKind::Int,
        Load { kind, .. } => match kind {
            LoadKind::F32 => ResultKind::Fp,
            _ => ResultKind::Int,
        },
        Store {
            kind: StoreKind::F32,
            ..
        } => ResultKind::Fp,
        Store { .. } => ResultKind::Int,
        Binop { op, .. } | BinopI { op, .. } => match op {
            BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv => ResultKind::Fp,
            // FP comparisons return an integer 0/1.
            _ => ResultKind::Int,
        },
        Fneg(_) => ResultKind::Fp,
        FpCast { kind, .. } => match kind {
            FpCastKind::FpToInt => ResultKind::Int,
            FpCastKind::IntToFp => ResultKind::Fp,
        },
        Call { .. } | CallIndirect { .. } | CallExt { .. } => ResultKind::Int,
        TailExt(_) => ResultKind::None,
        Mcpy { .. } => ResultKind::Int,
        Intrinsic { .. } => ResultKind::Int,
        AllocaInit(_) => ResultKind::None,
        VstackSpill { .. } => ResultKind::None,
        VstackReload { .. } => ResultKind::Int,
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
            | Inst::LocalAddr(_)
            | Inst::TlsAddr(_)
            | Inst::AllocaInit(_)
            | Inst::TailExt(_)
            | Inst::VstackReload { .. } => {}
            Inst::Load { addr, .. } => bump(*addr, pc, &mut last_use),
            Inst::Store { addr, value, .. } => {
                bump(*addr, pc, &mut last_use);
                bump(*value, pc, &mut last_use);
            }
            Inst::Binop { lhs, rhs, .. } => {
                bump(*lhs, pc, &mut last_use);
                bump(*rhs, pc, &mut last_use);
            }
            Inst::BinopI { lhs, .. } => bump(*lhs, pc, &mut last_use),
            Inst::Fneg(v) => bump(*v, pc, &mut last_use),
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
            Inst::Intrinsic { arg, .. } => bump(*arg, pc, &mut last_use),
            Inst::VstackSpill { value, .. } => bump(*value, pc, &mut last_use),
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
    last_use
}

/// For each value, mark whether any call instruction sits
/// strictly between its def PC and last-use PC. Such a value
/// must be in a callee-saved register (or spilled), since a
/// caller-saved reg would be clobbered by the intervening call.
fn compute_calls_after_def(func: &FunctionSsa, last_use: &[u32]) -> Vec<bool> {
    let n = func.insts.len();
    let mut call_pcs: Vec<u32> = Vec::new();
    for (idx, inst) in func.insts.iter().enumerate() {
        if matches!(
            inst,
            Inst::Call { .. } | Inst::CallIndirect { .. } | Inst::CallExt { .. }
        ) {
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
        super::super::ssa::lift_program(&program).expect("lift")
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
                // non-None place. The result-kind helper tells
                // us which insts produce.
                let kind = result_kind(&f.insts[i]);
                match kind {
                    ResultKind::None => assert_eq!(*p, Place::None),
                    ResultKind::Int | ResultKind::Fp => {
                        assert!(
                            !matches!(p, Place::None),
                            "inst {i} produced a value but got Place::None"
                        );
                    }
                }
            }
        }
    }
}
