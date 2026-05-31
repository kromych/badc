//! x86_64 native emit consuming the SSA + allocator output.
//! Mirrors the aarch64 counterpart's structure; the difference
//! is the per-target instruction encodings and the SysV / Win64
//! ABI shape applied to argument and return placement.
//!
//! ## Pass shape
//!
//! For each function:
//!
//! 1. Prologue: push rbp, set rbp = rsp, reserve locals +
//!    allocator-spill bytes, save the callee-saved GPRs the
//!    allocator reported as used, and spill the host-ABI arg
//!    registers into the c5 cdecl slots the body's
//!    `LocalAddr(>=2)` references.
//! 2. Walk each block in source order. Emit per-`Inst` native
//!    code in `inst_range`, then the terminator.
//! 3. Epilogue lands inline at every `Terminator::Return`: move
//!    the return value into rax, restore saved regs, drop the
//!    frame, pop rbp, ret.
//!
//! ## Frame layout (top -> bottom, growing down from caller's rsp)
//!
//! ```text
//!   c5 cdecl param slots          [rbp + 16*i + 16]
//!   saved rbp, ret address        [rbp]
//!   locals area                   [rbp - locals_bytes .. rbp]
//!   allocator spill slots         ...
//!   saved callee-saved GPRs       rsp
//! ```
//!
//! ## Coverage policy
//!
//! [`emit_function`] returns `true` when the SSA emit handled the
//! function end-to-end and `false` when any encountered op is
//! outside the implemented subset. The caller (`x86_64::lower`)
//! turns `false` into a hard compile error -- the IR + emit
//! contract has to cover every shape the walker produces.

#![allow(dead_code, clippy::too_many_arguments)]

use alloc::vec::Vec;

use super::super::ir::{BinOp, FpCastKind, FunctionSsa, Inst, LoadKind, StoreKind, Terminator};
use super::DataFixup;
use super::GotFixup;
use super::Target;
use super::ssa_alloc::{Allocation, Place};
use super::x86_64::{
    Cc, Fixup, PltCallFixup, Reg, emit_add_rr, emit_add_rsp_imm32, emit_addsd, emit_and_rr,
    emit_cmp_rr, emit_cvtsd2ss, emit_cvtsi2sd, emit_cvtss2sd, emit_cvttsd2si, emit_divsd,
    emit_imul_rr, emit_lea_r_mem, emit_mov_mem_r, emit_mov_r_imm64, emit_mov_r_mem, emit_mov_rr,
    emit_movapd_xmm_xmm, emit_movq_xmm_r, emit_movsd_mem_xmm, emit_movsd_xmm_mem,
    emit_movss_mem_xmm, emit_movss_xmm_mem, emit_movsx_r_mem16, emit_movsxd_r_mem,
    emit_movzx_r_mem16, emit_movzx_r_r8, emit_mulsd, emit_or_rr, emit_pop_r, emit_push_r, emit_ret,
    emit_sar_r_cl, emit_setcc_r8, emit_shl_r_cl, emit_shr_r_cl, emit_sub_rr, emit_sub_rsp_imm32,
    emit_subsd, emit_ucomisd, emit_xor_rr, emit_xorpd,
};

/// Per-function frame layout. Bytes are 16-aligned at every
/// region boundary so SysV / Win64's sp-at-call invariant holds.
#[derive(Debug, Clone, Copy)]
pub(super) struct Frame {
    pub frame_bytes: u32,
    pub alloc_spill_base: u32,
    /// Total bytes the prologue allocates between the return
    /// address and the saved rbp for c5 cdecl parameter slots
    /// and host-stack overflow. The epilogue reads this directly
    /// so prologue and epilogue agree on one byte count regardless
    /// of which branch the prologue took.
    pub param_spill_bytes: u32,
}

impl Frame {
    pub fn for_function(func: &FunctionSsa, alloc: &Allocation, abi: super::Abi) -> Self {
        let declared_locals_bytes = super::ssa_emit_common::slots16(func.locals.max(0) as u32);
        // After mem2reg + dead-store elimination, every reference to
        // user-local slots (negative `off`) may be gone. The
        // surviving `func.insts` is the source of truth; when no
        // `LoadLocal` / `StoreLocal` / `LocalAddr` references a
        // negative slot the prologue need not allocate locals
        // storage (C99 6.2.4p2: a never-observed object needs no
        // storage). Param cells use non-negative `off` and are
        // sized by `param_spill_bytes`, so they are not affected.
        let any_local_access = func.insts.iter().any(|i| match i {
            Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } => *off < 0,
            Inst::LocalAddr(off) => *off < 0,
            _ => false,
        });
        let locals_bytes = if any_local_access {
            declared_locals_bytes
        } else {
            0
        };
        let alloc_spill_bytes = super::ssa_emit_common::slots16(alloc.spill_count);
        let saved_gpr_bytes = super::ssa_emit_common::slots16(alloc.gpr_used.len() as u32);
        let frame_bytes = locals_bytes + alloc_spill_bytes + saved_gpr_bytes;
        let param_spill_bytes = prologue_param_spill_bytes(func, alloc, abi);
        Self {
            frame_bytes,
            alloc_spill_base: locals_bytes,
            param_spill_bytes,
        }
    }
}

/// Registers that are caller-saved on both SysV AMD64 and Win64.
/// Used as the candidate pool for `pick_caller_saved_scratch`.
/// The intersection of the two ABIs' caller-saved sets is rax,
/// rcx, rdx, r8, r9, r10, r11; rsi and rdi are caller-saved on
/// SysV but callee-saved on Win64, so they are excluded. Order
/// favours r11, r10 (rarely call args) then rax / rcx / rdx /
/// r8 / r9 (call args).
const CALLER_SAVED_INT_SCRATCHES: &[u8] = &[11, 10, 0, 1, 2, 8, 9];

/// Pick a caller-saved x86_64 GPR that is neither `rd` nor any
/// register in `operand_regs`. Returns `None` when every
/// candidate in `CALLER_SAVED_INT_SCRATCHES` is excluded -- callers
/// then bail the emit rather than silently fall through to a
/// callee-saved register (which would violate the System V /
/// Win64 callee-save contract and corrupt the caller's state on
/// return). Used by emit handlers that need an intra-instruction
/// scratch (BinopI immediate-materialise, VaArg staging, alloca
/// bookkeeping, ...).
fn pick_caller_saved_scratch(rd: Reg, operand_regs: &[Reg]) -> Option<Reg> {
    for cand in CALLER_SAVED_INT_SCRATCHES {
        if *cand == rd.0 {
            continue;
        }
        if operand_regs.iter().any(|r| r.0 == *cand) {
            continue;
        }
        return Some(Reg(*cand));
    }
    None
}

/// Same as `pick_caller_saved_scratch`, but additionally avoids
/// any register that carries an SSA value live across the current
/// instruction. `pc` is the current instruction's index; a value
/// `x` is live across `pc` when `x < pc < alloc.last_use[x]`. The
/// chosen scratch is then disjoint from `rd`, the operand list,
/// and every register the next instructions need to read.
fn pick_caller_saved_scratch_live_aware(
    rd: Reg,
    operand_regs: &[Reg],
    pc: u32,
    alloc: &Allocation,
) -> Option<Reg> {
    let mut live: alloc::vec::Vec<Reg> = alloc::vec::Vec::with_capacity(operand_regs.len() + 4);
    live.extend_from_slice(operand_regs);
    for (idx, place) in alloc.places.iter().enumerate() {
        let last = alloc.last_use.get(idx).copied().unwrap_or(0);
        let i = idx as u32;
        if i < pc
            && pc < last
            && let Place::IntReg(r) = place
        {
            live.push(Reg(*r));
        }
    }
    pick_caller_saved_scratch(rd, &live)
}

/// Total bytes the prologue allocates between the return
/// address and the saved rbp for c5 cdecl parameter slots plus
/// host-stack overflow. Mirrors the prologue's branch structure
/// exactly so prologue and epilogue agree on one value:
///
/// * Variadic callees: the caller pushes 16-byte cells onto the
///   bytecode stack; the callee allocates nothing.
/// * Non-variadic, n_params within `int_arg_regs.len()`:
///   `n_reg * 16`, or 0 when every register-passed parameter is
///   `ParamRef`-seeded with no address taken and no surviving
///   `Load/StoreLocal` -- in which case the entire register
///   stripe drops out and no `pop r10` / `push r10` dance is
///   needed to preserve the return address.
/// * Non-variadic, host-stack overflow: full `n_params * 16`.
/// * Struct-returning callees: the walker excludes them from
///   `ParamRef` synthesis, so `seeded` is empty, the elision
///   check fails, and `n_params * 16` is returned.
/// A function that meets every condition to skip the standard
/// push rbp / mov rbp,rsp / pop rbp prologue triple: no callee
/// it must reserve frame for, no param spill, no callee-saved
/// GPR to spill. The caller-pushed return address sits at top of
/// stack untouched, so the function can ret directly with no
/// stack adjustment.
fn is_full_leaf(func: &FunctionSsa, frame: Frame, alloc: &Allocation) -> bool {
    if frame.frame_bytes != 0 || frame.param_spill_bytes != 0 {
        return false;
    }
    if !alloc.gpr_used.is_empty() {
        return false;
    }
    !func.insts.iter().any(|inst| {
        matches!(
            inst,
            Inst::Call { .. }
                | Inst::CallIndirect { .. }
                | Inst::CallExt { .. }
                | Inst::TailExt(_)
                | Inst::Intrinsic { .. }
                | Inst::TlsAddr(_)
        )
    })
}

/// Per-parameter elidability scan. Returns the `(elidable, n_reg,
/// n_stack)` triple `emit_prologue` and `prologue_param_spill_bytes`
/// both consume. `elidable[i]` is true when parameter `i` has a
/// surviving `Inst::ParamRef`, no `LocalAddr`, and no live
/// `Load/StoreLocal` against its c5-cdecl arg slot -- i.e. the body
/// reads the value through the host arg register the SysV / Win64
/// ABI placed it in, and the cell that the cdecl prologue would
/// otherwise allocate at `[rbp + 16*(i+1)]` is unobserved.
///
/// Variadic and zero-parameter callees return an empty mask;
/// host-stack overflow parameters (idx >= int_arg_regs.len()) are
/// never elidable because the c5 emit always reads the cell.
fn param_elidable_mask(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> (alloc::vec::Vec<bool>, usize, usize) {
    if func.is_variadic || func.n_params == 0 {
        return (alloc::vec::Vec::new(), 0, 0);
    }
    let n_reg = func.n_params.min(abi.int_arg_regs.len());
    let n_stack = func.n_params - n_reg;
    let mut seeded: alloc::collections::BTreeSet<u32> = alloc::collections::BTreeSet::new();
    let mut addr_taken: alloc::collections::BTreeSet<i64> = alloc::collections::BTreeSet::new();
    let mut needed: alloc::collections::BTreeSet<i64> = alloc::collections::BTreeSet::new();
    for (idx, inst) in func.insts.iter().enumerate() {
        match inst {
            Inst::ParamRef { idx: i, .. } => {
                seeded.insert(*i);
            }
            Inst::LocalAddr(off) if *off >= 2 => {
                addr_taken.insert(*off);
            }
            Inst::LoadLocal { off, .. } if *off >= 2 => {
                let alive = alloc.use_counts.get(idx).copied().unwrap_or(0) > 0;
                if alive {
                    needed.insert(*off);
                }
            }
            Inst::StoreLocal { off, .. } if *off >= 2 => {
                needed.insert(*off);
            }
            _ => {}
        }
    }
    let mut elidable = alloc::vec::Vec::with_capacity(n_reg);
    for i in 0..n_reg {
        let slot = (i as i64) + 2;
        let ok =
            seeded.contains(&(i as u32)) && !addr_taken.contains(&slot) && !needed.contains(&slot);
        elidable.push(ok);
    }
    (elidable, n_reg, n_stack)
}

fn prologue_param_spill_bytes(func: &FunctionSsa, alloc: &Allocation, abi: super::Abi) -> u32 {
    let (elidable, n_reg, n_stack) = param_elidable_mask(func, alloc, abi);
    // The reg-stripe stays allocated when any single parameter
    // needs its cell (address-taken or LoadLocal-surviving), so the
    // c5 cdecl offsets `[rbp + 16*(i+1)]` remain stable for the
    // body. The mov store for each individually elidable parameter
    // is skipped at emit time. Stack-overflow parameters always
    // need their cell.
    let any_reg_needed = elidable.iter().any(|e| !e);
    let reg_bytes = if any_reg_needed || n_stack > 0 {
        (n_reg as u32) * 16
    } else {
        0
    };
    let overflow_bytes = (n_stack as u32) * 16;
    reg_bytes + overflow_bytes
}

fn bail_msg(reason: &str) {
    super::ssa_emit_common::bail_msg("x86_64", reason);
}

/// Extract the int reg from a `Place`, or `None` if it's not an
/// integer register.
fn int_reg(place: Place) -> Option<Reg> {
    place.int_reg_u8().map(Reg)
}

/// Scratch register for handlers whose dst is a spill: r10 is
/// r10 is in the SSA allocator's `caller_gprs` pool (see
/// `RegBanks::for_target` for `LinuxX64` / `WindowsX64`), so any
/// emit handler that reuses it as a scratch must first check
/// whether the current instruction's `rd` / operand places alias
/// r10 -- otherwise the scratch write clobbers a live value.
/// Emit handlers that need a register guaranteed free of
/// allocator interference use r13 (reserved by the codegen and
/// outside both pools).
const SCRATCH_R10: Reg = Reg(10);
/// Secondary / tertiary int scratches for emit handlers that
/// need more than one register beyond `rd`. rcx and rdx are also
/// in the allocator's `caller_gprs` pool, so callers must check
/// for aliasing with `rd` / operand places exactly as with
/// `SCRATCH_R10`. Used by emit handlers that work over a base,
/// an index, and a value (indexed stores) where one register
/// isn't enough.
const SCRATCH_RCX: Reg = Reg(1);
const SCRATCH_RDX: Reg = Reg(2);

/// Scratch XMM registers for FP handlers. The SSA allocator's
/// caller_fprs pool covers `xmm0..xmm7` and callee_fprs is empty
/// on SysV (no callee-saved xmm), so any allocator-held FP value
/// lives in xmm0..xmm7. xmm14 / xmm15 sit outside both banks and
/// stay free as primary / secondary scratches.
const SCRATCH_XMM14: Reg = Reg(14);
const SCRATCH_XMM15: Reg = Reg(15);

/// Extract the FP reg from a `Place`, or `None` if it's not an
/// xmm register.
fn fp_reg(place: Place) -> Option<Reg> {
    place.fp_reg_u8().map(Reg)
}

/// Pick the working xmm a single-result FP-producing handler writes
/// into: the allocator's chosen reg for `FpReg`, or `SCRATCH_XMM14`
/// for `Spill`. Other place kinds (`IntReg`, `None`) are not legal
/// for the FP handlers.
fn fp_or_spill_dst(dst: Place) -> Option<Reg> {
    match dst {
        Place::FpReg(r) => Some(Reg(r)),
        Place::Spill(_) => Some(SCRATCH_XMM14),
        _ => None,
    }
}

/// Read an FP value's `Place` into a usable xmm register. `FpReg`
/// returns the allocator's chosen reg directly; `Spill` loads the
/// spilled bit pattern into `scratch`; `IntReg` reinterprets the
/// register's bit pattern as an f64 via `movq xmm, gpr` (c5's
/// constant-folder represents f64 constants as `Imm` of the f64 bit
/// pattern, which the allocator places in an IntReg).
fn materialize_fp(code: &mut Vec<u8>, place: Place, scratch: Reg, frame: Frame) -> Option<Reg> {
    materialize_fp_shifted(code, place, scratch, frame, 0)
}

fn materialize_fp_shifted(
    code: &mut Vec<u8>,
    place: Place,
    scratch: Reg,
    frame: Frame,
    sp_shift: u32,
) -> Option<Reg> {
    match place {
        Place::FpReg(r) => Some(Reg(r)),
        Place::Spill(slot) => {
            let sp_off = spill_slot_sp_offset(frame, slot) + sp_shift as i32;
            emit_movsd_xmm_mem(code, scratch, Reg::RSP, sp_off);
            Some(scratch)
        }
        Place::IntReg(r) => {
            emit_movq_xmm_r(code, scratch, Reg(r));
            Some(scratch)
        }
        Place::None => None,
    }
}

/// If `dst` is `Place::Spill`, store `src` (an xmm reg) into the
/// matching spill slot. No-op for FpReg / IntReg / None.
fn fp_spill_dst_to_slot(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    if let Place::Spill(slot) = dst {
        let sp_off = spill_slot_sp_offset(frame, slot);
        emit_movsd_mem_xmm(code, Reg::RSP, sp_off, src);
    }
}

/// Map an FP arithmetic [`BinOp`] to its SSE2 encoder. Returns
/// `None` for any non-FP-arith op.
fn fp_arith_enc(op: BinOp) -> Option<fn(&mut Vec<u8>, Reg, Reg)> {
    Some(match op {
        BinOp::Fadd => emit_addsd,
        BinOp::Fsub => emit_subsd,
        BinOp::Fmul => emit_mulsd,
        BinOp::Fdiv => emit_divsd,
        _ => return None,
    })
}

/// How a `setcc` result needs to be combined with the parity flag
/// for the IEEE-754 NaN semantics required by C99 6.5.9 / 6.5.8.
/// `ucomisd` sets ZF=PF=CF=1 on an unordered (NaN) comparison;
/// a bare `setcc` on Cc::B / Cc::E / Cc::Be / Cc::Ne would then
/// disagree with `!(NaN < x)` / `(NaN != x)`.
#[derive(Clone, Copy)]
enum FpCmpNanFix {
    /// CC already evaluates to 0 on an unordered compare (Cc::A
    /// and Cc::Ae both require CF=0, which NaN never satisfies).
    None,
    /// AND with `setnp` (PF=0) to clear the result when NaN.
    /// Used by `==`, `<`, `<=` per C99 6.5.9p3 / 6.5.8p6.
    AndNotP,
    /// OR with `setp` (PF=1) so the result is 1 on NaN. Used by
    /// `!=` per C99 6.5.9p3.
    OrP,
}

/// Map an FP comparison [`BinOp`] to the x86_64 condition code the
/// matching `ucomisd` + `setcc` pair should use plus the NaN-fix
/// needed after the `setcc`. Returns `None` for any non-FP-compare
/// op.
fn fp_compare_cc(op: BinOp) -> Option<(Cc, FpCmpNanFix)> {
    Some(match op {
        BinOp::Feq => (Cc::E, FpCmpNanFix::AndNotP),
        BinOp::Fne => (Cc::Ne, FpCmpNanFix::OrP),
        BinOp::Flt => (Cc::B, FpCmpNanFix::AndNotP),
        BinOp::Fgt => (Cc::A, FpCmpNanFix::None),
        BinOp::Fle => (Cc::Be, FpCmpNanFix::AndNotP),
        BinOp::Fge => (Cc::Ae, FpCmpNanFix::None),
        _ => return None,
    })
}

/// Pick the working register a single-result int-producing handler
/// writes into: the allocator's chosen reg for `IntReg`, or
/// `SCRATCH_R10` for `Spill`. Other place kinds (FpReg, None) are
/// not legal for the handlers that call this helper.
fn int_or_spill_dst(dst: Place) -> Option<Reg> {
    match dst {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(_) => Some(SCRATCH_R10),
        _ => None,
    }
}

/// Byte offset from rsp of allocator spill slot `slot`. Spill
/// slot 0 sits at the top of the allocator-spill region (next to
/// the accumulator slot); slot N+1 sits 8 bytes below slot N. The
/// region itself lives at `[rbp - alloc_spill_base ..
/// rbp - alloc_spill_base - alloc_spill_bytes]`, and rsp =
/// rbp - frame_bytes, so a slot at `rbp - alloc_spill_base
/// - (N+1)*8` is `frame_bytes - alloc_spill_base - (N+1)*8` from
/// rsp. Mirror of the aarch64 module's formula.
fn spill_slot_sp_offset(frame: Frame, slot: u32) -> i32 {
    super::ssa_emit_common::spill_slot_sp_offset(frame.frame_bytes, frame.alloc_spill_base, slot)
        as i32
}

/// If `dst` is a `Spill` place, write the just-produced value in
/// `src` into the spill slot. No-op for register places (the
/// caller already wrote into the allocator's chosen reg).
fn spill_dst_to_slot(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    if let Place::Spill(slot) = dst {
        let sp_off = spill_slot_sp_offset(frame, slot);
        emit_mov_mem_r(code, Reg::RSP, sp_off, src);
    }
}

/// Read a value's `Place` into a usable register: returns the
/// allocator's chosen reg directly for `IntReg`, or loads the
/// spilled value into `scratch` and returns `scratch` for `Spill`.
/// Returns `None` for `FpReg` / `None` so the caller can bail.
fn materialize_int(code: &mut Vec<u8>, place: Place, scratch: Reg, frame: Frame) -> Option<Reg> {
    materialize_int_shifted(code, place, scratch, frame, 0)
}

/// Like [`materialize_int`] but accounts for a temporary `rsp`
/// adjustment that hasn't been undone yet (e.g. the call-args
/// scratch frame). Spill offsets are computed from the
/// post-prologue rsp, so callers that pushed extra bytes on top
/// must pass that delta as `sp_shift` so the load reaches the
/// correct slot.
fn materialize_int_shifted(
    code: &mut Vec<u8>,
    place: Place,
    scratch: Reg,
    frame: Frame,
    sp_shift: u32,
) -> Option<Reg> {
    match place {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(slot) => {
            let sp_off = spill_slot_sp_offset(frame, slot) + sp_shift as i32;
            emit_mov_r_mem(code, scratch, Reg::RSP, sp_off);
            Some(scratch)
        }
        Place::FpReg(r) => {
            // Reinterpret the xmm-resident f64 as its 8-byte bit
            // pattern via `movq scratch, xmm[r]`. Used at c5-internal
            // call sites that route every argument through the
            // integer arg bank (the callee's prologue spills only
            // int_arg_regs into the c5 cdecl slots).
            super::x86_64::emit_movq_r_xmm(code, scratch, Reg(r));
            Some(scratch)
        }
        Place::None => None,
    }
}

/// Resolve a set of register-to-register copies `(src, tgt)` so
/// no copy writes to a register still needed as the source of
/// another pending copy. Mirrors the AArch64 emit's scheduler:
/// drain leaves (target not a source of any other pending move)
/// first, then break cycles by routing one source through
/// `scratch`. The caller must pass a `scratch` whose register
/// lives outside the allocator's bank.
/// Emit the predecessor-exit moves for each `Inst::Phi` at the head
/// of every CFG successor of `self_block`. Mirrors the aarch64
/// helper: IntReg -> IntReg pairs schedule through the parallel-copy
/// helper so cycles drop to one scratch-mediated copy; Spill
/// destinations route through the materialise helper and a store
/// against rsp.
///
/// TODO: extend to FpReg dst / src once a real fixture demands it;
/// the current promotion path admits only int-store slots
/// (`slot_stores_only_int`) so the FP case never arises today.
fn emit_phi_predecessor_moves(
    code: &mut Vec<u8>,
    self_block: super::super::ir::BlockId,
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    use super::super::ir::Terminator;
    let succs: Vec<super::super::ir::BlockId> = match func.blocks[self_block as usize].terminator {
        Terminator::Jmp(t) | Terminator::FallThrough(t) => alloc::vec![t],
        Terminator::Bz {
            target,
            fall_through,
            ..
        }
        | Terminator::Bnz {
            target,
            fall_through,
            ..
        } => alloc::vec![target, fall_through],
        Terminator::Return(_) | Terminator::TailExt(_) => alloc::vec![],
    };
    for succ in succs {
        let head = func.blocks[succ as usize].inst_range.start;
        let end = func.blocks[succ as usize].inst_range.end;
        let mut int_moves: Vec<(u8, u8)> = Vec::new();
        let mut other_moves: Vec<(Place, Place)> = Vec::new();
        for id in head..end {
            let inst = &func.insts[id as usize];
            let super::super::ir::Inst::Phi { incoming, .. } = inst else {
                break;
            };
            let Some((_, src_v)) = incoming.iter().find(|(b, _)| *b == self_block) else {
                continue;
            };
            let dst_place = alloc
                .places
                .get(id as usize)
                .copied()
                .unwrap_or(Place::None);
            let src_place = alloc
                .places
                .get(*src_v as usize)
                .copied()
                .unwrap_or(Place::None);
            match (src_place, dst_place) {
                (Place::None, _) | (_, Place::None) => {}
                (Place::IntReg(s), Place::IntReg(t)) => {
                    if s != t {
                        int_moves.push((s, t));
                    }
                }
                _ => other_moves.push((src_place, dst_place)),
            }
        }
        // The parallel-copy cycle-break temporary must be
        // disjoint from every cycle source / destination
        // register. Pick a caller-saved scratch from the
        // candidate pool that no incoming move uses; if every
        // candidate is occupied the function falls through to
        // r13 and the resulting ABI violation is caught by
        // `pick_caller_saved_scratch_fallthrough_is_rare` so
        // future codegen changes notice the constraint.
        let mut used: alloc::vec::Vec<Reg> = alloc::vec::Vec::with_capacity(int_moves.len() * 2);
        for (s, t) in &int_moves {
            used.push(Reg(*s));
            used.push(Reg(*t));
        }
        // The moves run at the predecessor's terminator PC. A scratch
        // that holds an SSA value live across the terminator (i.e.
        // live-out of this block) would be clobbered. The live-aware
        // picker excludes any such register from the candidate set.
        let terminator_pc = func.blocks[self_block as usize]
            .inst_range
            .end
            .saturating_sub(1);
        let Some(cycle_scratch) =
            pick_caller_saved_scratch_live_aware(Reg(0xff), &used, terminator_pc, alloc)
        else {
            bail_msg(
                "phi predecessor-exit move: cycle-break exhausted the caller-saved candidate pool",
            );
            return false;
        };
        schedule_int_reg_moves(code, &mut int_moves, cycle_scratch);
        for (src_place, dst_place) in other_moves {
            match dst_place {
                Place::IntReg(t) => {
                    if materialize_int(code, src_place, Reg(t), frame).is_none() {
                        return false;
                    }
                }
                Place::Spill(slot) => {
                    let Some(scratch) =
                        pick_caller_saved_scratch_live_aware(Reg(0xff), &[], terminator_pc, alloc)
                    else {
                        bail_msg("phi predecessor-exit Spill: no caller-saved scratch available");
                        return false;
                    };
                    let src_r = match materialize_int(code, src_place, scratch, frame) {
                        Some(r) => r,
                        None => return false,
                    };
                    let sp_off = spill_slot_sp_offset(frame, slot);
                    emit_mov_mem_r(code, Reg::RSP, sp_off, src_r);
                }
                Place::FpReg(_) | Place::None => return false,
            }
        }
    }
    true
}

fn schedule_int_reg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>, scratch: Reg) {
    moves.retain(|(s, t)| s != t);
    while !moves.is_empty() {
        let mut progress = false;
        let mut i = 0;
        while i < moves.len() {
            let (s, t) = moves[i];
            let tgt_still_a_source = moves.iter().any(|(other_s, _)| *other_s == t);
            if !tgt_still_a_source {
                emit_mov_rr(code, Reg(t), Reg(s));
                moves.swap_remove(i);
                progress = true;
            } else {
                i += 1;
            }
        }
        if !progress {
            let saved = moves[0].0;
            emit_mov_rr(code, scratch, Reg(saved));
            for m in moves.iter_mut() {
                if m.0 == saved {
                    m.0 = scratch.0;
                }
            }
        }
    }
}

/// Place every argument into its System V / Win64 target slot in
/// an order that survives source / target overlaps. With the
/// allocator's caller-saved bank covering the arg registers
/// (rdi rsi rdx rcx r8 r9 / rcx rdx r8 r9), an argument's value
/// can sit in another argument's target arg register; a naive
/// sequential per-arg `mov target_i, src_i` would clobber a
/// still-needed source. Resolution uses the classical
/// parallel-copy algorithm: drain leaves (target not a source of
/// any other pending move) first; break the residual cycles with
/// one scratch-mediated copy. Pass ordering mirrors the AArch64
/// emit:
///
///   * Stack slots first -- their sources are read into
///     `SCRATCH_R10` and stored to the host-stack overflow
///     region, preserving any source register a later pass
///     touches.
///   * FP arg-register placements next. A value held in an
///     integer register as a raw f64 bit pattern (the constant-
///     folder emits `Inst::Imm` for f64 literals) is moved into
///     the target xmm before the int marshal can overwrite the
///     source.
///   * Integer reg-to-reg moves, scheduled through
///     [`schedule_int_reg_moves`] so cycles drop to a single
///     scratch-mediated copy.
///   * Spill sources for `IntReg` placements then materialise
///     directly into the target arg register
///     (`materialize_int_shifted` writes its load into the dst).
fn marshal_args(
    code: &mut Vec<u8>,
    plan: &super::CallPlan,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    site: &str,
) -> bool {
    let arg_place = |i: usize| -> Place {
        alloc
            .places
            .get(args[i] as usize)
            .copied()
            .unwrap_or(Place::None)
    };

    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::Stack(off) = placement {
            let ap = arg_place(i);
            let src =
                match materialize_int_shifted(code, ap, SCRATCH_R10, frame, plan.scratch_bytes) {
                    Some(s) => s,
                    None => {
                        bail_msg(&alloc::format!("{site}: stack arg not in int reg / spill"));
                        return false;
                    }
                };
            emit_mov_mem_r(code, Reg::RSP, off as i32, src);
        }
    }

    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::FpReg(r) = placement {
            let ap = arg_place(i);
            let src = match materialize_fp_shifted(code, ap, Reg(r), frame, plan.scratch_bytes) {
                Some(s) => s,
                None => {
                    bail_msg(&alloc::format!(
                        "{site}: fp arg not in fp reg / spill / int reg"
                    ));
                    return false;
                }
            };
            if src.0 != r {
                emit_movapd_xmm_xmm(code, Reg(r), src);
            }
        }
    }

    let mut int_moves: Vec<(u8, u8)> = Vec::new();
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::IntReg(r) = placement
            && let Place::IntReg(s) = arg_place(i)
            && s != r
        {
            int_moves.push((s, r));
        }
    }
    schedule_int_reg_moves(code, &mut int_moves, SCRATCH_R10);

    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::IntReg(r) = placement {
            let ap = arg_place(i);
            match ap {
                Place::IntReg(_) => {}
                Place::Spill(_) | Place::None => {
                    let src = match materialize_int_shifted(
                        code,
                        ap,
                        Reg(r),
                        frame,
                        plan.scratch_bytes,
                    ) {
                        Some(s) => s,
                        None => {
                            bail_msg(&alloc::format!("{site}: int arg not in int reg / spill"));
                            return false;
                        }
                    };
                    if src.0 != r {
                        emit_mov_rr(code, Reg(r), src);
                    }
                }
                Place::FpReg(s) => {
                    // Win64 mirrors variadic FP args into both the
                    // matching xmm register and the integer slot
                    // (rcx / rdx / r8 / r9), so the call-arg plan
                    // can name the integer placement with the value
                    // sitting in xmm.
                    super::x86_64::emit_movq_r_xmm(code, Reg(r), Reg(s));
                }
            }
        }
    }

    true
}

/// Public entry point. Returns `true` when every block + inst +
/// terminator was lowered. Returns `false` (with `code`
/// truncated back to the pre-attempt snapshot) when the function
/// contains an op outside the implemented subset. The handler
/// set is intentionally minimal at this stage; the aarch64 SSA
/// emit grew bottom-up from the same shape and the x86_64 path
/// follows that trajectory.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_function(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    code: &mut Vec<u8>,
    fixups: &mut Vec<Fixup>,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    _got_fixups: &mut Vec<GotFixup>,
    data_fixups: &mut Vec<DataFixup>,
    user_extern_data_refs: &mut Vec<super::UserExternDataRef>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    tls_total_size: usize,
    pc_to_native: &mut [usize],
    prologue_native: &mut alloc::collections::BTreeMap<usize, usize>,
    ssa_line_rows: &mut Vec<(usize, u32, u32)>,
) -> bool {
    let snapshot = code.len();
    let fixups_snapshot = fixups.len();
    let plt_call_fixups_snapshot = plt_call_fixups.len();
    let data_fixups_snapshot = data_fixups.len();
    let user_extern_data_refs_snapshot = user_extern_data_refs.len();
    let pending_func_fixups_snapshot = pending_func_fixups.len();
    let abi = target.abi();
    let frame = Frame::for_function(func, alloc, abi);

    emit_prologue(code, func, alloc, frame, abi);
    super::ssa_emit_common::record_post_prologue_pc(func, prologue_native, code.len());

    let mut block_offsets: Vec<usize> = alloc::vec![0; func.blocks.len()];
    let mut branch_fixups: Vec<BranchFixup> = Vec::new();
    // Set by `Inst::AllocaInit` (slot != 0) and read by the
    // matching `Inst::Intrinsic(Alloca)`. Zero means the
    // function doesn't use alloca.
    let mut current_alloca_top: u32 = 0;

    for (block_idx, block) in func.blocks.iter().enumerate() {
        block_offsets[block_idx] = code.len();
        super::ssa_emit_common::record_block_start_pc(
            block_idx,
            block.start_pc,
            pc_to_native,
            code.len(),
        );
        // Tail-call opportunity: when the block's last instruction is
        // a direct `Inst::Call` whose result is the same block's
        // `Terminator::Return` value, lower the call as `marshal_args;
        // epilogue; jmp target` instead of `call target; capture;
        // epilogue; ret`. Saves one call+ret pair per recursion level
        // and removes the post-call rax-to-place mov. See
        // `detect_tail_call` for the safety preconditions.
        let tail_call = detect_tail_call(func, block, abi, variadic_targets);
        for v in block.inst_range.clone() {
            let inst = &func.insts[v as usize];
            let place = alloc.places.get(v as usize).copied().unwrap_or(Place::None);
            if super::ssa_emit_common::is_dead_pure(inst, v, alloc) {
                continue;
            }
            // The tail-call Call's args setup is folded into the
            // terminator emit; skip the per-inst emit so we don't
            // emit the `call` instruction and the post-call capture.
            if let Some((tail_pc, _, _)) = tail_call
                && (v as usize) == tail_pc
            {
                continue;
            }
            super::ssa_emit_common::record_inst_src(func, v, code.len(), ssa_line_rows);
            let data_fixups_pre_inst = data_fixups.len();
            if !emit_inst(
                code,
                inst,
                v,
                place,
                alloc,
                frame,
                abi,
                target,
                fixups,
                plt_call_fixups,
                data_fixups,
                pending_func_fixups,
                imports,
                variadic_targets,
                tls_index_fixups,
                tls_total_size,
                &mut current_alloca_top,
            ) {
                #[cfg(feature = "std")]
                if std::env::var("BADC_DUMP_SSA").is_ok() {
                    eprintln!(
                        "ssa emit x86_64: bailed on inst v{v}: {:?} (place {:?})",
                        inst, place,
                    );
                }
                code.truncate(snapshot);
                fixups.truncate(fixups_snapshot);
                plt_call_fixups.truncate(plt_call_fixups_snapshot);
                data_fixups.truncate(data_fixups_snapshot);
                user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                pending_func_fixups.truncate(pending_func_fixups_snapshot);
                return false;
            }
            // Convert the just-emitted ImmData's local `.data`
            // fixup into a named cross-TU reference when the
            // value-id appears in `extern_data_names`. See the
            // matching comment in ssa_emit_aarch64.
            if let Inst::ImmData(_) = inst
                && let Some(name) = extern_data_names.get(&v)
                && data_fixups.len() > data_fixups_pre_inst
            {
                let popped = data_fixups.pop().unwrap();
                user_extern_data_refs.push(super::UserExternDataRef {
                    instr_offset: popped.adrp_offset,
                    symbol_name: name.clone(),
                });
            }
        }
        // Predecessor-exit moves for any phi at every CFG
        // successor's head. A Return / TailExt block has no
        // successor; the helper is a no-op there.
        if !emit_phi_predecessor_moves(
            code,
            block_idx as super::super::ir::BlockId,
            func,
            alloc,
            frame,
        ) {
            code.truncate(snapshot);
            fixups.truncate(fixups_snapshot);
            plt_call_fixups.truncate(plt_call_fixups_snapshot);
            data_fixups.truncate(data_fixups_snapshot);
            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
            pending_func_fixups.truncate(pending_func_fixups_snapshot);
            return false;
        }
        match block.terminator {
            Terminator::Return(v) => {
                if let Some((_, target_pc, args)) = tail_call {
                    if !emit_tail_call(code, target_pc, args, alloc, frame, abi, fixups, func) {
                        code.truncate(snapshot);
                        fixups.truncate(fixups_snapshot);
                        plt_call_fixups.truncate(plt_call_fixups_snapshot);
                        data_fixups.truncate(data_fixups_snapshot);
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        return false;
                    }
                } else {
                    emit_return(code, v, alloc, frame, func)
                }
            }
            Terminator::Jmp(t) => {
                branch_fixups.push(BranchFixup {
                    site: code.len() + 1, // rel32 follows the 1-byte opcode
                    target: t,
                    kind: LocalBranchKind::Jmp,
                });
                super::x86_64::emit_jmp_rel32(code, 0);
            }
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => {
                if let Some(cc) = fused_branch_cc(func, alloc, cond, /* negate */ true) {
                    branch_fixups.push(BranchFixup {
                        site: code.len() + 2,
                        target,
                        kind: LocalBranchKind::Jcc(cc),
                    });
                    super::x86_64::emit_jcc_rel32(code, cc, 0);
                    if fall_through as usize != block_idx + 1 {
                        branch_fixups.push(BranchFixup {
                            site: code.len() + 1,
                            target: fall_through,
                            kind: LocalBranchKind::Jmp,
                        });
                        super::x86_64::emit_jmp_rel32(code, 0);
                    }
                    continue;
                }
                let cond_place = alloc
                    .places
                    .get(cond as usize)
                    .copied()
                    .unwrap_or(Place::None);
                let Some(rc) = materialize_int(code, cond_place, SCRATCH_R10, frame) else {
                    bail_msg("Bz: cond Place not int reg / spill / fp");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    return false;
                };
                // `cmp rc, 0` sets ZF=1 iff rc==0; je takes the
                // branch on ZF=1.
                super::x86_64::emit_cmp_r_imm32(code, rc, 0);
                branch_fixups.push(BranchFixup {
                    site: code.len() + 2, // 0x0F 0x8x + rel32
                    target,
                    kind: LocalBranchKind::Jcc(Cc::E),
                });
                super::x86_64::emit_jcc_rel32(code, Cc::E, 0);
                if fall_through as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len() + 1,
                        target: fall_through,
                        kind: LocalBranchKind::Jmp,
                    });
                    super::x86_64::emit_jmp_rel32(code, 0);
                }
            }
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => {
                if let Some(cc) = fused_branch_cc(func, alloc, cond, /* negate */ false) {
                    branch_fixups.push(BranchFixup {
                        site: code.len() + 2,
                        target,
                        kind: LocalBranchKind::Jcc(cc),
                    });
                    super::x86_64::emit_jcc_rel32(code, cc, 0);
                    if fall_through as usize != block_idx + 1 {
                        branch_fixups.push(BranchFixup {
                            site: code.len() + 1,
                            target: fall_through,
                            kind: LocalBranchKind::Jmp,
                        });
                        super::x86_64::emit_jmp_rel32(code, 0);
                    }
                    continue;
                }
                let cond_place = alloc
                    .places
                    .get(cond as usize)
                    .copied()
                    .unwrap_or(Place::None);
                let Some(rc) = materialize_int(code, cond_place, SCRATCH_R10, frame) else {
                    bail_msg("Bnz: cond Place not int reg / spill / fp");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    return false;
                };
                super::x86_64::emit_cmp_r_imm32(code, rc, 0);
                branch_fixups.push(BranchFixup {
                    site: code.len() + 2,
                    target,
                    kind: LocalBranchKind::Jcc(Cc::Ne),
                });
                super::x86_64::emit_jcc_rel32(code, Cc::Ne, 0);
                if fall_through as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len() + 1,
                        target: fall_through,
                        kind: LocalBranchKind::Jmp,
                    });
                    super::x86_64::emit_jmp_rel32(code, 0);
                }
            }
            Terminator::FallThrough(t) => {
                if t as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len() + 1,
                        target: t,
                        kind: LocalBranchKind::Jmp,
                    });
                    super::x86_64::emit_jmp_rel32(code, 0);
                }
            }
            Terminator::TailExt(binding_idx) => {
                // The parser emits `Terminator::TailExt` for the
                // sys-trampoline bodies: the matching indirect
                // call already placed every arg in the host ABI's
                // argument registers / shadow-space slots, so the
                // emit just forwards control through the PLT
                // trampoline and lets the libc fn's `ret` carry
                // us back to the original caller.
                let import_index = match imports.index_of_binding(binding_idx) {
                    Some(i) => i,
                    None => {
                        bail_msg("TailExt: no import slot for binding");
                        code.truncate(snapshot);
                        fixups.truncate(fixups_snapshot);
                        plt_call_fixups.truncate(plt_call_fixups_snapshot);
                        data_fixups.truncate(data_fixups_snapshot);
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        return false;
                    }
                };
                plt_call_fixups.push(PltCallFixup {
                    instr_offset: code.len(),
                    import_index,
                    is_tail: true,
                });
                super::x86_64::emit_jmp_rel32(code, 0);
            }
        }
    }
    // Patch recorded branches. `site` is the byte offset of the
    // first rel32 byte; rel32 is computed from the byte *after*
    // the rel32 field (which on x86_64 is `site + 4`).
    for fx in &branch_fixups {
        let target_off = block_offsets[fx.target as usize];
        let next_pc = fx.site + 4;
        let rel = (target_off as i64) - (next_pc as i64);
        let imm = match i32::try_from(rel) {
            Ok(v) => v,
            Err(_) => {
                bail_msg("branch fixup: rel32 out of range");
                code.truncate(snapshot);
                fixups.truncate(fixups_snapshot);
                plt_call_fixups.truncate(plt_call_fixups_snapshot);
                data_fixups.truncate(data_fixups_snapshot);
                user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                pending_func_fixups.truncate(pending_func_fixups_snapshot);
                return false;
            }
        };
        let bytes = imm.to_le_bytes();
        code[fx.site..fx.site + 4].copy_from_slice(&bytes);
        let _ = fx.kind;
    }

    true
}

#[derive(Debug, Clone, Copy)]
struct BranchFixup {
    /// Byte offset of the rel32 field in `code`.
    site: usize,
    target: super::super::ir::BlockId,
    kind: LocalBranchKind,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum LocalBranchKind {
    Jmp,
    Jcc(Cc),
}

/// Spill the host-ABI argument registers into the c5 cdecl slots
/// the body references via address-of-local with slot index
/// `N >= 2`. c5 places the
/// first declared parameter at `[rbp + 16]`, the second at
/// `[rbp + 32]`, etc. AMD64 SysV / Win64 push the return address
/// before `call`, so the prologue needs to interleave the saved
/// rbp with the param slots: pop the return address into r11,
/// push each arg in caller order, push the return address back,
/// then save rbp and proceed.
fn emit_prologue(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
) {
    // Host-arg-reg spill. `frame.param_spill_bytes` is the
    // single source of truth for how many bytes get allocated
    // here; the epilogue reads the same value to undo the same
    // bytes. Variadic callees, fully-Native callees with every
    // parameter `ParamRef`-seeded, and 0-param callees all
    // produce 0 and skip the entire `pop r10` / `push r10`
    // dance (the return address stays at the top of the stack
    // where the caller pushed it).
    let entry_spill = if func.is_variadic { 0 } else { func.n_params };
    if entry_spill > 0 && frame.param_spill_bytes > 0 {
        emit_pop_r(code, Reg::R10);
        let (elidable, n_reg, n_stack) = param_elidable_mask(func, alloc, abi);
        if n_stack > 0 {
            let overflow_bytes = (n_stack as u32) * 16;
            emit_sub_rsp_imm32(code, overflow_bytes);
            for i in 0..n_stack {
                let host_off = (overflow_bytes as i32) + (abi.shadow_space as i32) + (i as i32) * 8;
                emit_mov_r_mem(code, Reg::RAX, Reg::RSP, host_off);
                emit_mov_mem_r(code, Reg::RSP, (i as i32) * 16, Reg::RAX);
            }
        }
        for i in (0..n_reg).rev() {
            emit_sub_rsp_imm32(code, 16);
            // The cell at [rsp + 0] holds the value the body reads
            // through `LoadLocal { off: i+2 }`. When mem2reg has
            // promoted the parameter into a register (no LocalAddr,
            // no live LoadLocal) the cell sits unobserved and the
            // mov store is dead per C99 6.2.4p2; skip emitting it.
            // The stack space is still reserved so the surviving
            // non-elidable parameters keep their fixed offsets.
            if !elidable.get(i).copied().unwrap_or(false) {
                emit_mov_mem_r(code, Reg::RSP, 0, Reg(abi.int_arg_regs[i]));
            }
        }
        emit_push_r(code, Reg::R10);
    }

    // Leaf-function elision: a function that makes no calls
    // (the caller's return address stays at top of stack), has no
    // frame to allocate, spills no params, and saves no callee
    // regs has no work in the standard prologue. SysV / Win64 let
    // it ret directly off the caller-pushed return address with
    // rsp unchanged.
    if is_full_leaf(func, frame, alloc) {
        return;
    }
    // Standard frame: push rbp; mov rbp, rsp; sub rsp, frame_bytes.
    emit_push_r(code, Reg::RBP);
    emit_mov_rr(code, Reg::RBP, Reg::RSP);
    if frame.frame_bytes > 0 {
        emit_sub_rsp_imm32(code, frame.frame_bytes);
    }
    // Save callee-saved GPRs the allocator reported as used. We
    // keep them at the bottom of the frame at sp + saved_fpr_bytes
    // (= 0 on x86_64 since the allocator's fp pool is xmm-only).
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = (i as i32) * 8;
        super::x86_64::emit_mov_mem_r(code, Reg::RSP, off, Reg(r));
    }
}

/// Return the x86_64 condition code to use for `Jcc` when the
/// terminator's cond was flagged as branch-fused by the allocator.
/// `negate` is true for `Bz` (branch when comparison failed).
fn fused_branch_cc(
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    cond: super::super::ir::ValueId,
    negate: bool,
) -> Option<Cc> {
    if !alloc
        .branch_fused
        .get(cond as usize)
        .copied()
        .unwrap_or(false)
    {
        return None;
    }
    let op = match func.insts.get(cond as usize)? {
        Inst::Binop { op, .. } | Inst::BinopI { op, .. } => *op,
        _ => return None,
    };
    let positive = match op {
        BinOp::Eq => Cc::E,
        BinOp::Ne => Cc::Ne,
        BinOp::Lt => Cc::L,
        BinOp::Gt => Cc::G,
        BinOp::Le => Cc::Le,
        BinOp::Ge => Cc::Ge,
        BinOp::Ult => Cc::B,
        BinOp::Ugt => Cc::A,
        BinOp::Ule => Cc::Be,
        BinOp::Uge => Cc::Ae,
        _ => return None,
    };
    if !negate {
        return Some(positive);
    }
    Some(match positive {
        Cc::E => Cc::Ne,
        Cc::Ne => Cc::E,
        Cc::L => Cc::Ge,
        Cc::G => Cc::Le,
        Cc::Le => Cc::G,
        Cc::Ge => Cc::L,
        Cc::B => Cc::Ae,
        Cc::A => Cc::Be,
        Cc::Be => Cc::A,
        Cc::Ae => Cc::B,
        _ => return None,
    })
}

#[allow(clippy::too_many_arguments)]
fn emit_inst(
    code: &mut Vec<u8>,
    inst: &Inst,
    v: super::super::ir::ValueId,
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    target: Target,
    fixups: &mut Vec<Fixup>,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    data_fixups: &mut Vec<DataFixup>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    tls_total_size: usize,
    current_alloca_top: &mut u32,
) -> bool {
    match inst {
        Inst::AllocaInit(slot) => {
            // Slot 0: this function doesn't use alloca; emit
            // nothing. Non-zero: the bookkeeping slot lives at
            // `[rbp - slot*8]`; the matching `Inst::Intrinsic`
            // (alloca) reads + writes it to allocate from a
            // per-frame arena. Initialise the slot with its own
            // address so `alloca(n)` lands at `address - n`, the
            // top of the arena reserved by the prologue's
            // local-slot count.
            if *slot == 0 {
                return true;
            }
            let top_offset = (*slot as u32) * 8;
            *current_alloca_top = top_offset;
            let disp = -(top_offset as i32);
            emit_lea_r_mem(code, SCRATCH_R10, Reg::RBP, disp);
            emit_mov_mem_r(code, SCRATCH_R10, 0, SCRATCH_R10);
            true
        }
        Inst::ParamRef { idx, kind } => {
            // Materialise the i-th host-ABI argument register into
            // the allocator's chosen `Place`, sign-extending the
            // low `kind` bytes per C99 6.3.1.3 so the value held
            // in the register is canonically 64-bit-sign-extended.
            // The prologue does not modify the arg registers (rdi
            // rsi rdx rcx r8 r9 on System V; rcx rdx r8 r9 on
            // Win64), so the arg value is still in its incoming
            // register at this IR position. Narrow-load promotion
            // downstream can then collapse `Inst::Extend` to a
            // plain copy when the kinds match.
            let arg_reg = match abi.int_arg_regs.get(*idx as usize) {
                Some(&r) => Reg(r),
                None => {
                    bail_msg("ParamRef: idx out of range for int_arg_regs");
                    return false;
                }
            };
            let sign_extend = |code: &mut Vec<u8>, rd: Reg| match kind {
                LoadKind::I8 => super::x86_64::emit_movsx_r_r8(code, rd, arg_reg),
                LoadKind::I16 => super::x86_64::emit_movsx_r_r16(code, rd, arg_reg),
                LoadKind::I32 => super::x86_64::emit_movsxd_r_r(code, rd, arg_reg),
                _ => emit_mov_rr(code, rd, arg_reg),
            };
            match dst {
                Place::IntReg(r) => sign_extend(code, Reg(r)),
                Place::Spill(_) => {
                    sign_extend(code, SCRATCH_R10);
                    spill_dst_to_slot(code, dst, SCRATCH_R10, frame);
                }
                _ => {
                    bail_msg("ParamRef: dst not int reg / spill");
                    return false;
                }
            }
            true
        }
        Inst::Imm(value) => {
            let Some(rd) = int_or_spill_dst(dst) else {
                bail_msg("Imm: dst not int reg / spill");
                return false;
            };
            emit_mov_r_imm64(code, rd, *value);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        Inst::LocalAddr(off) => {
            let Some(rd) = int_or_spill_dst(dst) else {
                bail_msg("LocalAddr: dst not int reg / spill");
                return false;
            };
            // c5 cdecl: param i (i >= 2) sits at [rbp + 16*(i-1)];
            // locals (i < 0) sit at [rbp + 8*i]. Compute the byte
            // offset and emit `lea rd, [rbp + disp]`. The 32-bit
            // signed `disp` covers any frame our compiler emits;
            // larger frames bail.
            let bytes = c5_slot_to_fp_offset(*off);
            let disp = match i32::try_from(bytes) {
                Ok(d) => d,
                Err(_) => {
                    bail_msg("LocalAddr: offset doesn't fit in disp32");
                    return false;
                }
            };
            emit_lea_r_mem(code, rd, Reg::RBP, disp);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        Inst::Load { addr, kind } => emit_load(code, dst, *addr, *kind, alloc, frame),
        Inst::Store { addr, value, kind } => {
            emit_store(code, dst, v, *addr, *value, *kind, alloc, frame)
        }
        Inst::LoadLocal { off, kind } => emit_load_local(code, dst, *off, *kind, frame),
        Inst::StoreLocal { off, value, kind } => {
            emit_store_local(code, dst, v, *off, *value, *kind, alloc, frame)
        }
        Inst::LoadIndexed {
            base,
            index,
            scale,
            kind,
        } => emit_load_indexed(code, dst, *base, *index, *scale, *kind, alloc, frame),
        Inst::StoreIndexed {
            base,
            index,
            scale,
            value,
            kind,
        } => emit_store_indexed(
            code, dst, *base, *index, *scale, *value, *kind, alloc, frame,
        ),
        Inst::Binop { op, lhs, rhs } => emit_binop(code, *op, v, dst, *lhs, *rhs, alloc, frame),
        Inst::BinopI { op, lhs, rhs_imm } => {
            emit_binop_imm(code, *op, v, dst, *lhs, *rhs_imm, alloc, frame)
        }
        Inst::Call { target_pc, args } => emit_call(
            code,
            dst,
            *target_pc,
            args,
            alloc,
            frame,
            abi,
            fixups,
            variadic_targets.contains(target_pc),
        ),
        Inst::CallExt {
            binding_idx,
            args,
            fp_arg_mask,
        } => emit_call_ext(
            code,
            dst,
            *binding_idx,
            args,
            *fp_arg_mask,
            alloc,
            frame,
            abi,
            target,
            plt_call_fixups,
            imports,
        ),
        Inst::ImmData(offset) => emit_imm_data(code, dst, *offset, data_fixups, frame),
        Inst::ImmCode(target_ent_pc) => {
            emit_imm_code(code, dst, *target_ent_pc, pending_func_fixups, frame)
        }
        Inst::Mcpy {
            dst: d,
            src: s,
            size,
        } => emit_mcpy(code, dst, *d, *s, *size, alloc, frame),
        Inst::CallIndirect { target, args } => {
            emit_call_indirect(code, dst, *target, args, alloc, frame, abi)
        }
        Inst::Intrinsic { kind, args } => {
            emit_intrinsic(code, *kind, args, dst, v, alloc, frame, *current_alloca_top)
        }
        Inst::Fneg(value) => emit_fneg(code, dst, v, *value, alloc, frame),
        Inst::Extend { value, kind } => emit_extend(code, dst, *value, *kind, alloc, frame),
        Inst::FpCast { kind, value } => emit_fp_cast(code, dst, *kind, *value, alloc, frame),
        Inst::TlsAddr(offset) => emit_tls_addr(
            code,
            dst,
            *offset,
            target,
            tls_index_fixups,
            tls_total_size,
            frame,
        ),
        Inst::Phi { .. } => {
            // The value is materialised by the predecessor-exit
            // moves emitted just before each branch terminator
            // that targets this block; at the IR position the
            // phi's allocated Place already holds the merged
            // value.
            true
        }
        other => {
            bail_msg(&alloc::format!(
                "inst variant not yet covered: {}",
                inst_variant_name(other)
            ));
            let _ = frame;
            false
        }
    }
}

/// Human-readable name of an `Inst` variant for bail diagnostics.
fn inst_variant_name(inst: &super::super::ir::Inst) -> &'static str {
    use super::super::ir::Inst;
    match inst {
        Inst::Imm(_) => "Imm",
        Inst::ImmData(_) => "ImmData",
        Inst::ImmCode(_) => "ImmCode",
        Inst::LocalAddr(_) => "LocalAddr",
        Inst::TlsAddr(_) => "TlsAddr",
        Inst::Load { .. } => "Load",
        Inst::Store { .. } => "Store",
        Inst::LoadLocal { .. } => "LoadLocal",
        Inst::StoreLocal { .. } => "StoreLocal",
        Inst::LoadIndexed { .. } => "LoadIndexed",
        Inst::StoreIndexed { .. } => "StoreIndexed",
        Inst::Binop { .. } => "Binop",
        Inst::BinopI { .. } => "BinopI",
        Inst::Fneg(_) => "Fneg",
        Inst::Extend { .. } => "Extend",
        Inst::FpCast { .. } => "FpCast",
        Inst::Call { .. } => "Call",
        Inst::CallIndirect { .. } => "CallIndirect",
        Inst::CallExt { .. } => "CallExt",
        Inst::TailExt(_) => "TailExt",
        Inst::Mcpy { .. } => "Mcpy",
        Inst::Intrinsic { .. } => "Intrinsic",
        Inst::AllocaInit(_) => "AllocaInit",
        Inst::ParamRef { .. } => "ParamRef",
        Inst::Phi { .. } => "Phi",
    }
}

/// `Inst::TlsAddr` lowering. Routes through the per-target TLS
/// access shape. Linux variant-2 layout: `var = fs:[0] - (tls_total
/// - offset)`. The Windows path emits a TEB `gs:[0x58]` table
/// lookup indexed by `_tls_index` plus a final `lea`, and pushes
/// the writer fixup so the linker can patch the `_tls_index`
/// slot's RVA.
fn emit_tls_addr(
    code: &mut Vec<u8>,
    dst: Place,
    offset: i64,
    target: Target,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    tls_total_size: usize,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("TlsAddr: dst not int reg / spill");
        return false;
    };
    match target {
        Target::LinuxX64 => {
            let tpoff = (tls_total_size as i64) - offset;
            if !(0..=i32::MAX as i64).contains(&tpoff) {
                bail_msg("TlsAddr: tpoff out of i32 range");
                return false;
            }
            // mov rd, qword ptr fs:[0]
            //   FS prefix 64; REX.W=1, REX.R = (rd >= 8);
            //   opcode 8B; ModR/M mod=00 reg=rd.lo rm=100 (SIB);
            //   SIB scale=00 index=100 (none) base=101 (disp32);
            //   disp32 = 0.
            let rex = 0x48 | (((rd.0 >> 3) & 1) << 2);
            code.push(0x64);
            code.push(rex);
            code.push(0x8B);
            code.push(0x04 | ((rd.0 & 7) << 3));
            code.push(0x25);
            code.extend_from_slice(&0u32.to_le_bytes());
            // sub rd, imm32
            //   REX.W=1, REX.B = (rd >= 8);
            //   opcode 81 /5;
            //   ModR/M mod=11 reg=5 rm=rd.lo;
            //   imm32 = tpoff.
            let rex_sub = 0x48 | ((rd.0 >> 3) & 1);
            code.push(rex_sub);
            code.push(0x81);
            code.push(0xE8 | (rd.0 & 7));
            code.extend_from_slice(&(tpoff as i32).to_le_bytes());
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        Target::WindowsX64 => {
            if !(i32::MIN as i64..=i32::MAX as i64).contains(&offset) {
                bail_msg("TlsAddr: offset out of i32 range");
                return false;
            }
            // PE/x86_64 TLS reads gs:[0x58] (the TEB) for the TLS
            // array, indexes it by `_tls_index`, and adds the
            // per-variable offset. The SSA allocator covers rax /
            // r11 / etc.; use SCRATCH_R10 (r10, outside the
            // allocator's pool) for the TEB pointer and `rd`
            // itself for the index load -- the index is only live
            // across one mov so reusing the destination is safe.
            //
            // mov r10, gs:[0x58]           ; TEB
            // mov rd_w, [rip+disp32]       ; _tls_index slot
            //                              ;   (zero-extends to rd)
            // mov r10, [r10 + rd*8]        ; tls_array[idx]
            // lea rd, [r10 + offset]
            code.extend_from_slice(&[0x65, 0x4C, 0x8B, 0x14, 0x25, 0x58, 0, 0, 0]);
            // mov rd.lo_dword, [rip+disp32]:
            //   REX.R = (rd >= 8); opcode 8B;
            //   ModR/M mod=00 reg=rd.lo rm=101 (rip-relative);
            //   disp32 = 0 (patched).
            let rex_idx = if rd.0 >= 8 { 0x44 } else { 0x00 };
            if rex_idx != 0 {
                code.push(rex_idx);
            }
            // The writer's TLS-index fixup patches the 4-byte
            // displacement at `instr_offset + 2`. With a REX
            // prefix the disp32 lives at `instr_offset + 3` if
            // we anchor to the REX, so anchor to the opcode byte
            // instead -- `instr_offset + 2` then lands on the
            // disp32 regardless of whether a REX was emitted.
            let mov_idx_offset = code.len();
            code.push(0x8B);
            code.push(0x05 | ((rd.0 & 7) << 3));
            code.extend_from_slice(&0i32.to_le_bytes());
            tls_index_fixups.push(super::TlsIndexFixup {
                instr_offset: mov_idx_offset,
            });
            // mov r10, [r10 + rd*8]:
            //   REX = 0x4D | (rd.high ? 0x02 : 0)  (W=1, R=1 to
            //                                       reach r10 dest,
            //                                       X = rd>=8,
            //                                       B=1 for r10 base)
            //   opcode 8B; ModR/M mod=00 reg=010 (r10.lo)
            //                       rm=100 (SIB);
            //   SIB scale=11 (*8), index=rd.lo, base=010 (r10.lo).
            let rex_idx_sib = 0x4D | (if rd.0 >= 8 { 0x02 } else { 0 });
            code.push(rex_idx_sib);
            code.push(0x8B);
            code.push(0x14);
            code.push(0xC2 | ((rd.0 & 7) << 3));
            // lea rd, [r10 + offset]:
            //   REX.W=1, REX.R = (rd >= 8), REX.B=1 (r10 base);
            //   opcode 8D;
            //   ModR/M mod=10 (disp32), reg=rd.lo, rm=010 (r10).
            let rex_lea = 0x49 | (if rd.0 >= 8 { 0x04 } else { 0 });
            code.push(rex_lea);
            code.push(0x8D);
            code.push(0x82 | ((rd.0 & 7) << 3));
            code.extend_from_slice(&(offset as i32).to_le_bytes());
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        _ => {
            bail_msg("TlsAddr: target not x86_64");
            false
        }
    }
}

use super::ssa_emit_common::c5_slot_to_fp_offset;

/// Single-instruction rbp-relative load for `Inst::LoadLocal`.
/// The c5 slot offset folds into the load's ModR/M disp
/// directly, skipping the `LocalAddr` materialisation the
/// `LocalAddr` + `Load` pair would have required.
fn emit_load_local(code: &mut Vec<u8>, dst: Place, off: i64, kind: LoadKind, frame: Frame) -> bool {
    let disp = match i32::try_from(c5_slot_to_fp_offset(off)) {
        Ok(v) => v,
        Err(_) => {
            bail_msg("LoadLocal: offset doesn't fit in disp32");
            return false;
        }
    };
    if matches!(kind, LoadKind::F32) {
        let dd = match fp_or_spill_dst(dst) {
            Some(r) => r,
            None => {
                bail_msg("LoadLocal F32: dst not fp reg / spill");
                return false;
            }
        };
        emit_movss_xmm_mem(code, dd, Reg::RBP, disp);
        emit_cvtss2sd(code, dd, dd);
        fp_spill_dst_to_slot(code, dst, dd, frame);
        return true;
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("LoadLocal: dst not int reg / spill");
        return false;
    };
    match kind {
        LoadKind::I64 => emit_mov_r_mem(code, rd, Reg::RBP, disp),
        LoadKind::I32 => emit_movsxd_r_mem(code, rd, Reg::RBP, disp),
        LoadKind::U32 => super::x86_64::emit_mov_r32_mem(code, rd, Reg::RBP, disp),
        LoadKind::I16 => emit_movsx_r_mem16(code, rd, Reg::RBP, disp),
        LoadKind::U16 => emit_movzx_r_mem16(code, rd, Reg::RBP, disp),
        LoadKind::I8 => super::x86_64::emit_movsx_r_mem8(code, rd, Reg::RBP, disp),
        LoadKind::U8 => super::x86_64::emit_movzx_r_mem8(code, rd, Reg::RBP, disp),
        LoadKind::F32 => unreachable!(),
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Single-instruction rbp-relative store for `Inst::StoreLocal`.
/// Mirrors [`emit_load_local`]; the c5 store ops leave the
/// stored value in the accumulator, so the destination `Place`
/// receives a copy after the store lands.
fn emit_store_local(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    off: i64,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    if matches!(kind, StoreKind::F32) {
        bail_msg("StoreLocal: F32 routes through LocalAddr + Store");
        return false;
    }
    let disp = match i32::try_from(c5_slot_to_fp_offset(off)) {
        Ok(v) => v,
        Err(_) => {
            bail_msg("StoreLocal: offset doesn't fit in disp32");
            return false;
        }
    };
    let value_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    // c5 spills an FP-typed accumulator into a local temp through
    // the store-local path (the bit pattern fits 8 bytes either
    // way), so an FpReg value bridges through `movq r, xmm` into
    // a GPR before the store; otherwise it routes through the
    // normal int materialisation.
    let rv = if let Place::FpReg(xr) = value_place {
        let Some(scratch) = pick_caller_saved_scratch_live_aware(Reg(0), &[], v, alloc) else {
            bail_msg("StoreLocal FpReg: no caller-saved scratch available");
            return false;
        };
        super::x86_64::emit_movq_r_xmm(code, scratch, Reg(xr));
        scratch
    } else {
        match materialize_int(code, value_place, SCRATCH_R10, frame) {
            Some(r) => r,
            None => {
                bail_msg("StoreLocal: value not int reg / spill");
                return false;
            }
        }
    };
    // Store the low `kind`-width bytes; the accumulator below keeps
    // the full source value, matching the c5 rule that an
    // assignment expression yields the stored value before any
    // re-narrowing on read-back (C99 6.5.16p3).
    match kind {
        StoreKind::I64 => emit_mov_mem_r(code, Reg::RBP, disp, rv),
        StoreKind::I32 => super::x86_64::emit_mov_mem32_r(code, Reg::RBP, disp, rv),
        StoreKind::I16 => super::x86_64::emit_mov_mem16_r(code, Reg::RBP, disp, rv),
        StoreKind::I8 => super::x86_64::emit_mov_mem8_r(code, Reg::RBP, disp, rv),
        StoreKind::F32 => unreachable!(),
    }
    // Mirror the store value into the destination Place.
    if let Some(rd) = int_or_spill_dst(dst) {
        if rd.0 != rv.0 {
            emit_mov_rr(code, rd, rv);
        }
        spill_dst_to_slot(code, dst, rd, frame);
    }
    true
}

/// Lower `Inst::LoadIndexed`: `dst = *(kind*)(base + index * scale)`.
/// Emitted as a single MOVSXD/MOV/MOVSX/MOVZX with SIB-byte
/// addressing (`[base + index * scale]`). F32 indexed loads aren't
/// a shape the walker produces today.
#[allow(clippy::too_many_arguments)]
fn emit_load_indexed(
    code: &mut Vec<u8>,
    dst: Place,
    base: u32,
    index: u32,
    scale: u8,
    kind: LoadKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    if matches!(kind, LoadKind::F32) {
        bail_msg("LoadIndexed: F32 not implemented");
        return false;
    }
    let expected_scale: u8 = match kind {
        LoadKind::I64 => 8,
        LoadKind::I32 | LoadKind::U32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::F32 => unreachable!(),
    };
    if scale != expected_scale {
        bail_msg("LoadIndexed: scale doesn't match access width");
        return false;
    }
    let base_place = alloc
        .places
        .get(base as usize)
        .copied()
        .unwrap_or(Place::None);
    let index_place = alloc
        .places
        .get(index as usize)
        .copied()
        .unwrap_or(Place::None);
    let rbase = match materialize_int(code, base_place, SCRATCH_R10, frame) {
        Some(r) => r,
        None => {
            bail_msg("LoadIndexed: base Place not int reg / spill");
            return false;
        }
    };
    let rindex = match materialize_int(code, index_place, SCRATCH_RCX, frame) {
        Some(r) => r,
        None => {
            bail_msg("LoadIndexed: index Place not int reg / spill");
            return false;
        }
    };
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("LoadIndexed: dst not int reg / spill");
        return false;
    };
    match kind {
        LoadKind::I64 => super::x86_64::emit_mov_r_sib(code, rd, rbase, rindex, scale),
        LoadKind::I32 => super::x86_64::emit_movsxd_r_sib(code, rd, rbase, rindex, scale),
        LoadKind::U32 => super::x86_64::emit_mov_r32_sib(code, rd, rbase, rindex, scale),
        LoadKind::I16 => super::x86_64::emit_movsx_r_sib16(code, rd, rbase, rindex, scale),
        LoadKind::U16 => super::x86_64::emit_movzx_r_sib16(code, rd, rbase, rindex, scale),
        LoadKind::I8 => super::x86_64::emit_movsx_r_sib8(code, rd, rbase, rindex, scale),
        LoadKind::U8 => super::x86_64::emit_movzx_r_sib8(code, rd, rbase, rindex, scale),
        LoadKind::F32 => unreachable!(),
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Lower `Inst::StoreIndexed`: `*(kind*)(base + index * scale) = value`.
#[allow(clippy::too_many_arguments)]
fn emit_store_indexed(
    code: &mut Vec<u8>,
    dst: Place,
    base: u32,
    index: u32,
    scale: u8,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    if matches!(kind, StoreKind::F32) {
        bail_msg("StoreIndexed: F32 not implemented");
        return false;
    }
    let expected_scale: u8 = match kind {
        StoreKind::I64 => 8,
        StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        StoreKind::F32 => unreachable!(),
    };
    if scale != expected_scale {
        bail_msg("StoreIndexed: scale doesn't match access width");
        return false;
    }
    let base_place = alloc
        .places
        .get(base as usize)
        .copied()
        .unwrap_or(Place::None);
    let index_place = alloc
        .places
        .get(index as usize)
        .copied()
        .unwrap_or(Place::None);
    let value_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let rbase = match materialize_int(code, base_place, SCRATCH_R10, frame) {
        Some(r) => r,
        None => {
            bail_msg("StoreIndexed: base Place not int reg / spill");
            return false;
        }
    };
    let rindex = match materialize_int(code, index_place, SCRATCH_RCX, frame) {
        Some(r) => r,
        None => {
            bail_msg("StoreIndexed: index Place not int reg / spill");
            return false;
        }
    };
    let rv = if let Place::FpReg(xr) = value_place
        && matches!(kind, StoreKind::I64)
    {
        super::x86_64::emit_movq_r_xmm(code, SCRATCH_RDX, Reg(xr));
        SCRATCH_RDX
    } else {
        match materialize_int(code, value_place, SCRATCH_RDX, frame) {
            Some(r) => r,
            None => {
                bail_msg("StoreIndexed: value Place not int reg / spill");
                return false;
            }
        }
    };
    match kind {
        StoreKind::I64 => super::x86_64::emit_mov_sib_r(code, rbase, rindex, scale, rv),
        StoreKind::I32 => super::x86_64::emit_mov_sib_r32(code, rbase, rindex, scale, rv),
        StoreKind::I16 => super::x86_64::emit_mov_sib_r16(code, rbase, rindex, scale, rv),
        StoreKind::I8 => super::x86_64::emit_mov_sib_r8(code, rbase, rindex, scale, rv),
        StoreKind::F32 => unreachable!(),
    }
    // c5 store-op leaves the value in the accumulator.
    if let Some(rd) = int_or_spill_dst(dst) {
        if rd.0 != rv.0 {
            emit_mov_rr(code, rd, rv);
        }
        spill_dst_to_slot(code, dst, rd, frame);
    }
    true
}

fn emit_load(
    code: &mut Vec<u8>,
    dst: Place,
    addr: u32,
    kind: LoadKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let addr_place = alloc
        .places
        .get(addr as usize)
        .copied()
        .unwrap_or(Place::None);
    // Spill-tolerant base materialisation: load a spilled address
    // into r10 first, write into rd next, then spill rd to its
    // slot if the allocator wants it parked there. Matches the
    // aarch64 module's primary-scratch shape.
    let base = match materialize_int(code, addr_place, SCRATCH_R10, frame) {
        Some(r) => r,
        None => {
            bail_msg("Load: addr Place not int reg / spill");
            return false;
        }
    };
    if let LoadKind::F32 = kind {
        // `float` lvalue: load 4 bytes into the low dword of an
        // xmm and widen to f64. The result is an xmm; routes
        // through the FP dst Place.
        let dd = match fp_or_spill_dst(dst) {
            Some(r) => r,
            None => {
                bail_msg("Load F32: dst not fp reg / spill");
                return false;
            }
        };
        emit_movss_xmm_mem(code, dd, base, 0);
        emit_cvtss2sd(code, dd, dd);
        fp_spill_dst_to_slot(code, dst, dd, frame);
        return true;
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("Load: dst not int reg / spill");
        return false;
    };
    match kind {
        LoadKind::I64 => emit_mov_r_mem(code, rd, base, 0),
        LoadKind::I32 => emit_movsxd_r_mem(code, rd, base, 0),
        LoadKind::U32 => super::x86_64::emit_mov_r32_mem(code, rd, base, 0),
        LoadKind::I16 => emit_movsx_r_mem16(code, rd, base, 0),
        LoadKind::U16 => emit_movzx_r_mem16(code, rd, base, 0),
        LoadKind::I8 => super::x86_64::emit_movsx_r_mem8(code, rd, base, 0),
        LoadKind::U8 => super::x86_64::emit_movzx_r_mem8(code, rd, base, 0),
        LoadKind::F32 => unreachable!(),
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

fn emit_store(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    addr: u32,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let addr_place = alloc
        .places
        .get(addr as usize)
        .copied()
        .unwrap_or(Place::None);
    let value_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    // Pick a caller-saved scratch for the addr-Place spill load
    // (the materialise helper only writes to it when addr_place
    // is a Spill; an IntReg place returns the underlying reg
    // directly). The value-Place picks a separate scratch below.
    // The picker's live check uses strict `pc < last_use` so a
    // value whose last use is this Store (last_use == v) is not
    // flagged live; passing its register through `operand_regs`
    // forces the picker to skip it, otherwise the spill load
    // would overwrite the value register and the store would
    // write the address back into the lvalue (C99 6.5.16.1).
    let mut addr_operands: alloc::vec::Vec<Reg> = alloc::vec::Vec::new();
    if let Place::IntReg(r) = value_place {
        addr_operands.push(Reg(r));
    }
    let Some(addr_scratch) = pick_caller_saved_scratch_live_aware(Reg(0), &addr_operands, v, alloc)
    else {
        bail_msg("Store: no caller-saved scratch for addr spill load");
        return false;
    };
    let base = match materialize_int(code, addr_place, addr_scratch, frame) {
        Some(r) => r,
        None => {
            bail_msg("Store: addr Place not int reg / spill");
            return false;
        }
    };
    if let StoreKind::F32 = kind {
        // `float` lvalue store: narrow the f64 in xmm to f32 and
        // write the low dword. The narrowed value also feeds dst
        // when the allocator parked the stored f64 result there.
        let dn = match materialize_fp(code, value_place, SCRATCH_XMM14, frame) {
            Some(r) => r,
            None => {
                bail_msg("Store F32: value not fp reg / spill / int reg");
                return false;
            }
        };
        // Narrow into SCRATCH_XMM15 so dn (which may be an
        // allocator-held xmm holding the wider f64 the result Place
        // expects) survives.
        emit_cvtsd2ss(code, SCRATCH_XMM15, dn);
        emit_movss_mem_xmm(code, base, 0, SCRATCH_XMM15);
        match dst {
            Place::FpReg(r) if r != dn.0 => emit_movapd_xmm_xmm(code, Reg(r), dn),
            Place::Spill(_) => fp_spill_dst_to_slot(code, dst, dn, frame),
            _ => {}
        }
        return true;
    }
    let value_scratch = if base.0 == SCRATCH_R10.0 {
        Reg::RCX
    } else {
        SCRATCH_R10
    };
    let Some(rs) = materialize_int(code, value_place, value_scratch, frame) else {
        bail_msg("Store: value Place not int reg / spill");
        return false;
    };
    match kind {
        StoreKind::I64 => emit_mov_mem_r(code, base, 0, rs),
        StoreKind::I32 => super::x86_64::emit_mov_mem32_r(code, base, 0, rs),
        StoreKind::I16 => super::x86_64::emit_mov_mem16_r(code, base, 0, rs),
        StoreKind::I8 => super::x86_64::emit_mov_mem8_r(code, base, 0, rs),
        StoreKind::F32 => unreachable!(),
    }
    // Stored value also feeds dst when the allocator wants it
    // parked (Store ops leave the written value in the
    // accumulator per the c5 stack-machine semantics).
    match dst {
        Place::IntReg(r) if r != rs.0 => emit_mov_rr(code, Reg(r), rs),
        Place::Spill(_) => spill_dst_to_slot(code, dst, rs, frame),
        _ => {}
    }
    true
}

/// `Inst::Extend { value, kind }` -- sign-extend the low bytes of a
/// GPR value to 64 bits via `MOVSX` / `MOVSXD`.
fn emit_extend(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    kind: LoadKind,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let rd = match int_or_spill_dst(dst) {
        Some(r) => r,
        None => {
            bail_msg("Extend: dst not int reg / spill");
            return false;
        }
    };
    let rn = match materialize_int(code, src_place, rd, frame) {
        Some(r) => r,
        None => {
            bail_msg("Extend: value not int reg / spill");
            return false;
        }
    };
    match kind {
        LoadKind::I8 => super::x86_64::emit_movsx_r_r8(code, rd, rn),
        LoadKind::I16 => super::x86_64::emit_movsx_r_r16(code, rd, rn),
        LoadKind::I32 => super::x86_64::emit_movsxd_r_r(code, rd, rn),
        _ => {
            bail_msg("Extend: unsupported kind");
            return false;
        }
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// `Inst::Fneg(v)` -- flip the IEEE 754 sign bit of an f64.
/// Builds the `1 << 63` sign-bit mask on the fly into
/// `SCRATCH_XMM15` (movq xmm, r10 after loading the immediate
/// into r10) and xors in place.
fn emit_fneg(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let dd = match fp_or_spill_dst(dst) {
        Some(r) => r,
        None => {
            bail_msg("Fneg: dst not fp reg / spill");
            return false;
        }
    };
    let dn = match materialize_fp(code, src_place, dd, frame) {
        Some(r) => r,
        None => {
            bail_msg("Fneg: value not fp reg / spill / int reg");
            return false;
        }
    };
    if dn.0 != dd.0 {
        emit_movapd_xmm_xmm(code, dd, dn);
    }
    // Build the sign-bit mask 0x8000_0000_0000_0000 in an integer
    // scratch and transfer to SCRATCH_XMM15, then xorpd in place.
    // r10 is in the caller_gprs pool since the bank flattening, so
    // pick a scratch disjoint from every live SSA value at this PC;
    // otherwise the immediate load clobbers a value the consumer
    // (typically a downstream Fbinop / Fcmp) needs to read back.
    let Some(scratch_int) = pick_caller_saved_scratch_live_aware(Reg(0), &[], v, alloc) else {
        bail_msg("Fneg: no caller-saved scratch available");
        return false;
    };
    emit_mov_r_imm64(code, scratch_int, i64::MIN);
    emit_movq_xmm_r(code, SCRATCH_XMM15, scratch_int);
    emit_xorpd(code, dd, SCRATCH_XMM15);
    fp_spill_dst_to_slot(code, dst, dd, frame);
    true
}

/// `Inst::FpCast { kind, value }` -- int <-> f64 conversion. For
/// `IntToFp`, `CVTSI2SD` widens a signed 64-bit GPR into an xmm.
/// For `FpToInt`, `CVTTSD2SI` rounds-to-zero an xmm into a 64-bit
/// signed int.
fn emit_fp_cast(
    code: &mut Vec<u8>,
    dst: Place,
    kind: FpCastKind,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    match kind {
        FpCastKind::IntToFp => {
            let rn = match materialize_int(code, src_place, SCRATCH_R10, frame) {
                Some(r) => r,
                None => {
                    bail_msg("FpCast IntToFp: value not int reg / spill");
                    return false;
                }
            };
            let dd = match fp_or_spill_dst(dst) {
                Some(r) => r,
                None => {
                    bail_msg("FpCast IntToFp: dst not fp reg / spill");
                    return false;
                }
            };
            emit_cvtsi2sd(code, dd, rn);
            fp_spill_dst_to_slot(code, dst, dd, frame);
            true
        }
        FpCastKind::FpToInt => {
            let dn = match materialize_fp(code, src_place, SCRATCH_XMM14, frame) {
                Some(r) => r,
                None => {
                    bail_msg("FpCast FpToInt: value not fp reg / spill / int reg");
                    return false;
                }
            };
            let Some(rd) = int_or_spill_dst(dst) else {
                bail_msg("FpCast FpToInt: dst not int reg / spill");
                return false;
            };
            emit_cvttsd2si(code, rd, dn);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
    }
}

#[allow(clippy::too_many_arguments)]
fn emit_binop(
    code: &mut Vec<u8>,
    op: BinOp,
    v: super::super::ir::ValueId,
    dst: Place,
    lhs: u32,
    rhs: u32,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let lhs_place = alloc
        .places
        .get(lhs as usize)
        .copied()
        .unwrap_or(Place::None);
    let rhs_place = alloc
        .places
        .get(rhs as usize)
        .copied()
        .unwrap_or(Place::None);
    // FP arithmetic: scalar f64 in xmm. Stage lhs into dst, then
    // `op dst, rhs`. Both operands land via materialize_fp; rhs may
    // need a different scratch than lhs.
    if let Some(arith) = fp_arith_enc(op) {
        let dd = match fp_or_spill_dst(dst) {
            Some(r) => r,
            None => {
                bail_msg("Fbinop: dst not fp reg / spill");
                return false;
            }
        };
        let dn = match materialize_fp(code, lhs_place, dd, frame) {
            Some(r) => r,
            None => {
                bail_msg("Fbinop: lhs not fp reg / spill / int reg");
                return false;
            }
        };
        if dn.0 != dd.0 {
            emit_movapd_xmm_xmm(code, dd, dn);
        }
        let dm = match materialize_fp(code, rhs_place, SCRATCH_XMM15, frame) {
            Some(r) => r,
            None => {
                bail_msg("Fbinop: rhs not fp reg / spill / int reg");
                return false;
            }
        };
        arith(code, dd, dm);
        fp_spill_dst_to_slot(code, dst, dd, frame);
        return true;
    }
    // FP comparison: ucomisd + setcc + (optional parity-fix
    // setcc + AND/OR) on the result reg. `ucomisd` sets ZF / CF
    // / PF; PF=1 signals an unordered (NaN) compare. C99 6.5.9p3
    // / 6.5.8p6 require `==`, `<`, `<=` to yield 0 on NaN and
    // `!=` to yield 1, so the cc-only `setb` / `sete` / `setbe`
    // / `setne` paths get an explicit AND-with-`setnp` /
    // OR-with-`setp` fixup.
    if let Some((cc, nan_fix)) = fp_compare_cc(op) {
        let dn = match materialize_fp(code, lhs_place, SCRATCH_XMM14, frame) {
            Some(r) => r,
            None => {
                bail_msg("Fcmp: lhs not fp reg / spill / int reg");
                return false;
            }
        };
        let dm = match materialize_fp(code, rhs_place, SCRATCH_XMM15, frame) {
            Some(r) => r,
            None => {
                bail_msg("Fcmp: rhs not fp reg / spill / int reg");
                return false;
            }
        };
        emit_ucomisd(code, dn, dm);
        let Some(rd) = int_or_spill_dst(dst) else {
            bail_msg("Fcmp: dst not int reg / spill");
            return false;
        };
        emit_setcc_r8(code, cc, rd);
        emit_movzx_r_r8(code, rd, rd);
        match nan_fix {
            FpCmpNanFix::None => {}
            FpCmpNanFix::AndNotP | FpCmpNanFix::OrP => {
                // Need a 64-bit scratch distinct from `rd` for the
                // parity-fix setcc. r10 is in the caller_gprs pool
                // since the bank flattening, so use the live-aware
                // picker to land on a register the allocator has
                // not parked another live value in.
                let Some(scratch) = pick_caller_saved_scratch_live_aware(rd, &[], v, alloc) else {
                    bail_msg("Fcmp: no caller-saved scratch available");
                    return false;
                };
                let fix_cc = if matches!(nan_fix, FpCmpNanFix::AndNotP) {
                    super::x86_64::Cc::Np
                } else {
                    super::x86_64::Cc::P
                };
                emit_setcc_r8(code, fix_cc, scratch);
                emit_movzx_r_r8(code, scratch, scratch);
                if matches!(nan_fix, FpCmpNanFix::AndNotP) {
                    emit_and_rr(code, rd, scratch);
                } else {
                    emit_or_rr(code, rd, scratch);
                }
            }
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("Binop: dst not int reg / spill");
        return false;
    };
    // sxtw / movsx fold for the walker-shape sign-narrow pair
    // `Binop(Shl, X, Imm(K)); Binop(Shr, _, Imm(K))`. The
    // allocator marked this Shr and stashed the K (32 / 48 / 56);
    // emit one movsxd / movsx instead of two shifts.
    let sxtw_source = alloc
        .sxtw_source
        .get(v as usize)
        .copied()
        .unwrap_or(super::super::ir::NO_VALUE);
    if sxtw_source != super::super::ir::NO_VALUE {
        let src_place = alloc
            .places
            .get(sxtw_source as usize)
            .copied()
            .unwrap_or(Place::None);
        let src_reg = match src_place {
            Place::IntReg(r) => Reg(r),
            Place::Spill(slot) => {
                let sp_off = spill_slot_sp_offset(frame, slot);
                emit_mov_r_mem(code, rd, Reg::RSP, sp_off);
                rd
            }
            _ => {
                bail_msg("Binop sxtw: src not int reg / spill");
                return false;
            }
        };
        let k = alloc.sxtw_k.get(v as usize).copied().unwrap_or(0);
        match k {
            32 => super::x86_64::emit_movsxd_r_r(code, rd, src_reg),
            48 => super::x86_64::emit_movsx_r_r16(code, rd, src_reg),
            56 => super::x86_64::emit_movsx_r_r8(code, rd, src_reg),
            _ => {
                bail_msg("Binop sxtw: unexpected K");
                return false;
            }
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // Stage lhs into rd first, so the two-operand ops below can
    // `op rd, rm` and land the result in rd. When lhs is a spill,
    // load directly into rd to skip a redundant mov. When rhs is
    // a spill, materialise via SCRATCH_R10. The conflict case
    // (rd == r10 and rhs spilled) uses rcx as the rhs scratch.
    let rhs_scratch = if rd.0 == SCRATCH_R10.0 {
        Reg::RCX
    } else {
        SCRATCH_R10
    };
    let rhs_aliases_rd = matches!(rhs_place, Place::IntReg(r) if r == rd.0);
    // When the allocator places both rhs and dst in the same register
    // and lhs is spilled, the lhs spill-load below writes rd before
    // any rhs-staging mov runs, destroying the rhs value. Preserve
    // rhs into the scratch first so the downstream
    // rhs_aliases_rd / stage_rhs_to_scratch paths read the right
    // operand.
    let rhs_preserved_in_scratch = rhs_aliases_rd && matches!(lhs_place, Place::Spill(_));
    if rhs_preserved_in_scratch {
        emit_mov_rr(code, rhs_scratch, rd);
    }
    let rn = match lhs_place {
        Place::IntReg(r) => Reg(r),
        Place::Spill(slot) => {
            let sp_off = spill_slot_sp_offset(frame, slot);
            emit_mov_r_mem(code, rd, Reg::RSP, sp_off);
            rd
        }
        _ => {
            bail_msg("Binop: lhs not int reg / spill");
            return false;
        }
    };
    // Div / Mod hijack rax + rdx (SDM: IDIV's implicit operand
    // is rdx:rax and the result is rax (quot), rdx (rem)). They
    // need their own marshalling separate from the two-operand
    // path below.
    if matches!(op, BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu) {
        return emit_binop_divmod(code, op, v, dst, rd, rn, rhs_place, alloc, frame);
    }
    // x86_64's two-operand op `OP rd, rm` mutates rd. The standard
    // sequence below stages LHS into rd then emits `OP rd, rm`.
    // When rhs is an IntReg whose register is rd, materialize_int
    // would return rd as `rm`; the subsequent `mov rd, rn` would
    // then overwrite the rhs value, and the op would compute
    // `lhs OP lhs` instead of `lhs OP rhs`.
    //
    // For commutative ops (Add, Mul, And, Or, Xor) the work to fix
    // this is zero: rd already holds the value we want, so emit
    // `OP rd, rn` directly -- rd <- rhs OP lhs == lhs OP rhs.
    //
    // For non-commutative ops (Sub, Lt, Gt, ...) we must stage
    // rhs into the scratch before the `mov rd, rn` clobbers it.
    let commutative = matches!(
        op,
        BinOp::Add | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor
    );
    let is_cmp = matches!(
        op,
        BinOp::Eq
            | BinOp::Ne
            | BinOp::Lt
            | BinOp::Gt
            | BinOp::Le
            | BinOp::Ge
            | BinOp::Ult
            | BinOp::Ugt
            | BinOp::Ule
            | BinOp::Uge
    );
    if rhs_aliases_rd && commutative {
        // When rhs was preserved into rhs_scratch above (lhs Spill case),
        // rd now holds lhs from the spill load and the second operand
        // is rhs_scratch; otherwise rd still holds rhs and rn holds lhs.
        let other = if rhs_preserved_in_scratch {
            rhs_scratch
        } else {
            rn
        };
        match op {
            BinOp::Add => emit_add_rr(code, rd, other),
            BinOp::Mul => emit_imul_rr(code, rd, other),
            BinOp::And => emit_and_rr(code, rd, other),
            BinOp::Or => emit_or_rr(code, rd, other),
            BinOp::Xor => emit_xor_rr(code, rd, other),
            _ => unreachable!(),
        }
        return true;
    }
    // Comparison ops read both operands, set flags, then setcc+
    // movzx writes the dst. The dst is not used as an input, so
    // the staging `mov rd, rn` below is unnecessary; the rhs may
    // even live in `rd` itself (rhs_aliases_rd), and `cmp rn, rm`
    // still reads it before any write touches rd. Skip the stage
    // and the scratch-mov for cmp ops.
    let stage_rhs_to_scratch = rhs_aliases_rd && !is_cmp;
    let Some(rm) = (if rhs_preserved_in_scratch {
        Some(rhs_scratch)
    } else if stage_rhs_to_scratch {
        emit_mov_rr(code, rhs_scratch, rd);
        Some(rhs_scratch)
    } else if let Place::IntReg(r) = rhs_place {
        Some(Reg(r))
    } else {
        materialize_int(code, rhs_place, rhs_scratch, frame)
    }) else {
        bail_msg("Binop: rhs not int reg / spill");
        return false;
    };
    // x86_64's two-operand ops mutate the destination, so stage
    // the LHS into rd first (preserves SSA semantics where the
    // result is `lhs OP rhs`). Cmp ops skip this -- they read
    // rn / rm directly and write dst via setcc+movzx.
    if !is_cmp && rd.0 != rn.0 {
        emit_mov_rr(code, rd, rn);
    }
    match op {
        BinOp::Add => emit_add_rr(code, rd, rm),
        BinOp::Sub => emit_sub_rr(code, rd, rm),
        BinOp::Mul => emit_imul_rr(code, rd, rm),
        BinOp::And => emit_and_rr(code, rd, rm),
        BinOp::Or => emit_or_rr(code, rd, rm),
        BinOp::Xor => emit_xor_rr(code, rd, rm),
        BinOp::Eq | BinOp::Ne | BinOp::Lt | BinOp::Gt | BinOp::Le | BinOp::Ge => {
            // cmp lhs, rhs ; setcc rd_low ; movzx rd, rd_low. The
            // `mov rd, rn` above clobbered rd to the lhs already;
            // reverse that into a cmp directly off rn. Write setcc
            // into rd's own low byte (rather than cl) so a live SSA
            // value parked in rcx is not destroyed.
            emit_cmp_rr(code, rn, rm);
            if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
                return true;
            }
            let cc = match op {
                BinOp::Eq => Cc::E,
                BinOp::Ne => Cc::Ne,
                BinOp::Lt => Cc::L,
                BinOp::Gt => Cc::G,
                BinOp::Le => Cc::Le,
                BinOp::Ge => Cc::Ge,
                _ => unreachable!(),
            };
            emit_setcc_r8(code, cc, rd);
            emit_movzx_r_r8(code, rd, rd);
        }
        BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge => {
            emit_cmp_rr(code, rn, rm);
            if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
                return true;
            }
            let cc = match op {
                BinOp::Ult => Cc::B,
                BinOp::Ugt => Cc::A,
                BinOp::Ule => Cc::Be,
                BinOp::Uge => Cc::Ae,
                _ => unreachable!(),
            };
            emit_setcc_r8(code, cc, rd);
            emit_movzx_r_r8(code, rd, rd);
        }
        BinOp::Shl | BinOp::Shr | BinOp::Shru | BinOp::Ror => {
            // x86 shifts read the count from cl. When rd is rcx
            // the in-place shift would need both the lhs and the
            // count in rcx at once: stage the lhs into a scratch
            // disjoint from rcx and rm, shift there, then move the
            // result back to rd. The earlier `mov rd, rn` (line
            // above) left rd holding the lhs.
            if rd.0 == Reg::RCX.0 {
                let Some(scratch) = pick_caller_saved_scratch(rd, &[rm]) else {
                    bail_msg("Binop shift: no caller-saved scratch available");
                    return false;
                };
                // When the picker's choice carries an SSA value live
                // across this PC, push / pop the scratch around the
                // shift sequence so the live value survives. The
                // sequence below only touches registers (mov / mov /
                // shl / mov), so the 8-byte misalignment between push
                // and pop is irrelevant.
                let scratch_holds_live = alloc.places.iter().enumerate().any(|(idx, p)| {
                    let i = idx as u32;
                    let last = alloc.last_use.get(idx).copied().unwrap_or(0);
                    matches!(p, Place::IntReg(r) if *r == scratch.0) && i < v && v < last
                });
                if scratch_holds_live {
                    emit_push_r(code, scratch);
                }
                emit_mov_rr(code, scratch, rd);
                if rm.0 != Reg::RCX.0 {
                    emit_mov_rr(code, Reg::RCX, rm);
                }
                match op {
                    BinOp::Shl => emit_shl_r_cl(code, scratch),
                    BinOp::Shr => emit_sar_r_cl(code, scratch),
                    BinOp::Shru => emit_shr_r_cl(code, scratch),
                    BinOp::Ror => super::x86_64::emit_ror_r_cl(code, scratch),
                    _ => unreachable!(),
                }
                emit_mov_rr(code, rd, scratch);
                if scratch_holds_live {
                    emit_pop_r(code, scratch);
                }
            } else {
                // The shift writes rcx with the count below. When the
                // allocator parked an SSA value live across this PC
                // in rcx -- and the shift isn't in the must-be-callee
                // call set so values legitimately land in rcx -- the
                // mov destroys it. push / pop rcx around the shift
                // when that case fires; the body is reg-to-reg only,
                // so the 8-byte misalignment is harmless.
                let rcx_holds_live = rd.0 != Reg::RCX.0
                    && rm.0 != Reg::RCX.0
                    && alloc.places.iter().enumerate().any(|(idx, p)| {
                        let i = idx as u32;
                        let last = alloc.last_use.get(idx).copied().unwrap_or(0);
                        matches!(p, Place::IntReg(r) if *r == Reg::RCX.0) && i < v && v < last
                    });
                if rcx_holds_live {
                    emit_push_r(code, Reg::RCX);
                }
                if rm.0 != Reg::RCX.0 {
                    emit_mov_rr(code, Reg::RCX, rm);
                }
                match op {
                    BinOp::Shl => emit_shl_r_cl(code, rd),
                    BinOp::Shr => emit_sar_r_cl(code, rd),
                    BinOp::Shru => emit_shr_r_cl(code, rd),
                    BinOp::Ror => super::x86_64::emit_ror_r_cl(code, rd),
                    _ => unreachable!(),
                }
                if rcx_holds_live {
                    emit_pop_r(code, Reg::RCX);
                }
            }
        }
        _ => {
            bail_msg("Binop: variant not yet covered");
            return false;
        }
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Lower `BinOp::{Div,Mod,Divu,Modu}` on x86_64. IDIV / DIV
/// require the dividend in rdx:rax (low half in rax) and write
/// the quotient back to rax and remainder to rdx, so the
/// surrounding allocator-chosen value in rax (if any) must be
/// preserved across the divide. The 8-byte preserve uses
/// `push %rax` / `pop %rax`; the temporary 8-byte misalignment
/// is fine -- IDIV doesn't read/write the stack, and SysV /
/// Win64 only require 16-byte alignment at `call` sites.
///
/// `rn` is the already-materialised dividend; `rhs_place` is the
/// divisor's place so we can route it directly into r10 (which
/// IDIV's reg/mem operand can name, and which is never in any
/// allocator pool).
fn emit_binop_divmod(
    code: &mut Vec<u8>,
    op: BinOp,
    v: super::super::ir::ValueId,
    dst: Place,
    rd: Reg,
    rn: Reg,
    rhs_place: Place,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let want_remainder = matches!(op, BinOp::Mod | BinOp::Modu);
    let is_unsigned = matches!(op, BinOp::Divu | BinOp::Modu);

    // Pick a divisor scratch register disjoint from rd, rn, rax,
    // rdx, and every register holding an SSA value live across
    // this PC. The fixed `r10` choice was safe before the
    // caller_gprs pool included it; now the allocator can park a
    // live value in r10, and materialising the divisor into r10
    // would clobber rn or rd when one of them aliases r10's
    // previous live value.
    let Some(divisor_reg) =
        pick_caller_saved_scratch_live_aware(rd, &[rn, Reg::RAX, Reg::RDX], v, alloc)
    else {
        bail_msg("Binop divmod: no caller-saved scratch available");
        return false;
    };
    let Some(div_src) = materialize_int(code, rhs_place, divisor_reg, frame) else {
        bail_msg("Binop divmod: rhs not int reg / spill");
        return false;
    };
    if div_src.0 != divisor_reg.0 {
        emit_mov_rr(code, divisor_reg, div_src);
    }
    // Preserve rax / rdx: the allocator can park a live value in
    // either register and the divmod must not destroy it. rax
    // receives the dividend low half and the quotient; rdx
    // receives the dividend high half (cqo / xor edx,edx) and the
    // remainder. Skip the save when rd will overwrite the register
    // anyway, since the value living there is dead the moment rd
    // commits its result.
    let preserve_rax = rd.0 != Reg::RAX.0;
    let preserve_rdx = rd.0 != Reg::RDX.0;
    if preserve_rax {
        emit_push_r(code, Reg::RAX);
    }
    if preserve_rdx {
        emit_push_r(code, Reg::RDX);
    }
    // rax := dividend low half.
    if rn.0 != Reg::RAX.0 {
        emit_mov_rr(code, Reg::RAX, rn);
    }
    // rdx := dividend high half. Signed uses CQO to sign-extend
    // rax; unsigned zero-extends with `xor edx, edx`.
    if is_unsigned {
        emit_xor_rr(code, Reg::RDX, Reg::RDX);
        super::x86_64::emit_div_r(code, divisor_reg);
    } else {
        super::x86_64::emit_cqo(code);
        super::x86_64::emit_idiv_r(code, divisor_reg);
    }
    // Capture result into rd before restoring rdx / rax.
    let result_src = if want_remainder { Reg::RDX } else { Reg::RAX };
    if rd.0 != result_src.0 {
        emit_mov_rr(code, rd, result_src);
    }
    if preserve_rdx {
        emit_pop_r(code, Reg::RDX);
    }
    if preserve_rax {
        emit_pop_r(code, Reg::RAX);
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

#[allow(clippy::too_many_arguments)]
fn emit_binop_imm(
    code: &mut Vec<u8>,
    op: BinOp,
    v: super::super::ir::ValueId,
    dst: Place,
    lhs: u32,
    rhs_imm: i64,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("BinopI: dst not int reg / spill");
        return false;
    };
    let lhs_place = alloc
        .places
        .get(lhs as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match lhs_place {
        Place::IntReg(r) => Reg(r),
        Place::Spill(slot) => {
            let sp_off = spill_slot_sp_offset(frame, slot);
            emit_mov_r_mem(code, rd, Reg::RSP, sp_off);
            rd
        }
        _ => {
            bail_msg("BinopI: lhs not int reg / spill");
            return false;
        }
    };
    // sxtw fold via movsxd / movsx -- mirrors the aarch64 path.
    let sxtw_source = alloc
        .sxtw_source
        .get(v as usize)
        .copied()
        .unwrap_or(super::super::ir::NO_VALUE);
    if sxtw_source != super::super::ir::NO_VALUE {
        let src_place = alloc
            .places
            .get(sxtw_source as usize)
            .copied()
            .unwrap_or(Place::None);
        let src_reg = match src_place {
            Place::IntReg(r) => Reg(r),
            Place::Spill(slot) => {
                let sp_off = spill_slot_sp_offset(frame, slot);
                emit_mov_r_mem(code, rd, Reg::RSP, sp_off);
                rd
            }
            _ => {
                bail_msg("BinopI sxtw: src not int reg / spill");
                return false;
            }
        };
        match rhs_imm {
            32 => super::x86_64::emit_movsxd_r_r(code, rd, src_reg),
            48 => super::x86_64::emit_movsx_r_r16(code, rd, src_reg),
            56 => super::x86_64::emit_movsx_r_r8(code, rd, src_reg),
            _ => unreachable!(),
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // Per-op peepholes for immediate-form binops. These avoid
    // the 10-byte `mov rcx, imm64` materialisation when the
    // immediate fits a shorter form. Fall back to the rcx-scratch
    // path below for anything that doesn't.
    //
    //   * Mul by power of two -> shl rd, log2(imm).
    //   * Shl / Shr / Shru by 0..63 -> shl / sar / shr by imm8.
    //   * Add / Sub / And / Or / Xor with i32-fitting imm -> the
    //     existing immediate-form encoders (`emit_*_r_imm32`).
    let imm_fits_i32 = i32::try_from(rhs_imm).is_ok();
    let imm_is_pow2 = rhs_imm > 0 && (rhs_imm as u64).is_power_of_two();
    let shift_amount = if (0..64).contains(&rhs_imm) {
        Some(rhs_imm as u8)
    } else {
        None
    };
    let used_peephole = match op {
        BinOp::Mul if imm_is_pow2 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_shl_r_imm8(code, rd, (rhs_imm as u64).trailing_zeros() as u8);
            true
        }
        BinOp::Shl if shift_amount.is_some() => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_shl_r_imm8(code, rd, shift_amount.unwrap());
            true
        }
        BinOp::Shr if shift_amount.is_some() => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_sar_r_imm8(code, rd, shift_amount.unwrap());
            true
        }
        BinOp::Shru if shift_amount.is_some() => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_shr_r_imm8(code, rd, shift_amount.unwrap());
            true
        }
        BinOp::Ror if shift_amount.is_some() => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_ror_r_imm8(code, rd, shift_amount.unwrap());
            true
        }
        BinOp::Add if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_add_r_imm32(code, rd, rhs_imm as i32);
            true
        }
        BinOp::Sub if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_sub_r_imm32(code, rd, rhs_imm as i32);
            true
        }
        BinOp::And if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_and_r_imm32(code, rd, rhs_imm as i32);
            true
        }
        BinOp::Or if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_or_r_imm32(code, rd, rhs_imm as i32);
            true
        }
        BinOp::Xor if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::x86_64::emit_xor_r_imm32(code, rd, rhs_imm as i32);
            true
        }
        _ => false,
    };
    if used_peephole {
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // Compare-with-i32-immediate peephole: emit `cmp rn, imm32`
    // and skip the `mov rcx, imm64` materialisation. The shorter
    // imm32 form covers the operand range typical for `BinopI`
    // comparisons against small constants; outside that range we
    // fall through to the rcx-scratch path below.
    let is_signed_cmp = matches!(
        op,
        BinOp::Eq | BinOp::Ne | BinOp::Lt | BinOp::Gt | BinOp::Le | BinOp::Ge
    );
    let is_unsigned_cmp = matches!(op, BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge);
    if (is_signed_cmp || is_unsigned_cmp) && imm_fits_i32 {
        super::x86_64::emit_cmp_r_imm32(code, rn, rhs_imm as i32);
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        let cc = match op {
            BinOp::Eq => Cc::E,
            BinOp::Ne => Cc::Ne,
            BinOp::Lt => Cc::L,
            BinOp::Gt => Cc::G,
            BinOp::Le => Cc::Le,
            BinOp::Ge => Cc::Ge,
            BinOp::Ult => Cc::B,
            BinOp::Ugt => Cc::A,
            BinOp::Ule => Cc::Be,
            BinOp::Uge => Cc::Ae,
            _ => unreachable!(),
        };
        emit_setcc_r8(code, cc, rd);
        emit_movzx_r_r8(code, rd, rd);
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // Commutative ops with `rd != rn` can fold the staging mov
    // into the immediate materialisation: `mov rd, imm; OP rd,
    // rn` is two instructions and produces `imm OP rn == lhs OP
    // imm` by commutativity. The non-commutative path below uses
    // r13 as a scratch (r13 sits outside both
    // `caller_gprs` and `callee_gprs` in `RegBanks::for_target`,
    // so the allocator never picks r13 for an SSA value).
    let commutative = matches!(
        op,
        BinOp::Add | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor
    );
    if commutative && rd.0 != rn.0 {
        super::x86_64::emit_mov_r_imm64(code, rd, rhs_imm);
        match op {
            BinOp::Add => emit_add_rr(code, rd, rn),
            BinOp::Mul => emit_imul_rr(code, rd, rn),
            BinOp::And => emit_and_rr(code, rd, rn),
            BinOp::Or => emit_or_rr(code, rd, rn),
            BinOp::Xor => emit_xor_rr(code, rd, rn),
            _ => unreachable!(),
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // Materialise the immediate into a caller-saved scratch
    // disjoint from `rd` and `rn`, then stage `rd = lhs` (when
    // rd != rn) before the two-operand op. The scratch is
    // chosen per-instruction so it never collides with the
    // operand registers.
    let Some(scratch) = pick_caller_saved_scratch_live_aware(rd, &[rn], v, alloc) else {
        bail_msg("BinopI imm64: no caller-saved scratch available");
        return false;
    };
    super::x86_64::emit_mov_r_imm64(code, scratch, rhs_imm);
    if rd.0 != rn.0 {
        emit_mov_rr(code, rd, rn);
    }
    match op {
        BinOp::Add => emit_add_rr(code, rd, scratch),
        BinOp::Sub => emit_sub_rr(code, rd, scratch),
        BinOp::Mul => emit_imul_rr(code, rd, scratch),
        BinOp::And => emit_and_rr(code, rd, scratch),
        BinOp::Or => emit_or_rr(code, rd, scratch),
        BinOp::Xor => emit_xor_rr(code, rd, scratch),
        BinOp::Eq | BinOp::Ne | BinOp::Lt | BinOp::Gt | BinOp::Le | BinOp::Ge => {
            emit_cmp_rr(code, rn, scratch);
            if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
                return true;
            }
            let cc = match op {
                BinOp::Eq => Cc::E,
                BinOp::Ne => Cc::Ne,
                BinOp::Lt => Cc::L,
                BinOp::Gt => Cc::G,
                BinOp::Le => Cc::Le,
                BinOp::Ge => Cc::Ge,
                _ => unreachable!(),
            };
            emit_setcc_r8(code, cc, rd);
            emit_movzx_r_r8(code, rd, rd);
        }
        BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge => {
            emit_cmp_rr(code, rn, scratch);
            if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
                return true;
            }
            let cc = match op {
                BinOp::Ult => Cc::B,
                BinOp::Ugt => Cc::A,
                BinOp::Ule => Cc::Be,
                BinOp::Uge => Cc::Ae,
                _ => unreachable!(),
            };
            emit_setcc_r8(code, cc, rd);
            emit_movzx_r_r8(code, rd, rd);
        }
        BinOp::Shl | BinOp::Shr | BinOp::Shru => {
            // Shift count already in cl via the `mov rcx, imm` above.
            if rd.0 == Reg::RCX.0 {
                bail_msg("BinopI shift: dst aliases rcx");
                return false;
            }
            match op {
                BinOp::Shl => emit_shl_r_cl(code, rd),
                BinOp::Shr => emit_sar_r_cl(code, rd),
                BinOp::Shru => emit_shr_r_cl(code, rd),
                _ => unreachable!(),
            }
        }
        _ => {
            bail_msg("BinopI: variant not yet covered");
            return false;
        }
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

fn emit_call(
    code: &mut Vec<u8>,
    dst: Place,
    target_pc: usize,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    fixups: &mut Vec<Fixup>,
    callee_is_variadic: bool,
) -> bool {
    if callee_is_variadic {
        // c5's variadic ABI keeps the c5 stack: each arg is pushed
        // at a 16-byte stride matching the accumulator push. The
        // callee's prologue (`emit_prologue` with
        // `entry_spill = 0`) skips the host-arg-reg spill and
        // reads its args through the address-of-local path at
        // `[rbp + 16*(N-1)]`; `va_start` continues the walk past
        // the last named arg. Push args in reverse so args[0] --
        // the first declared arg -- lands on top of the stack at
        // `[rbp + 16]`.
        for (i, &arg_id) in args.iter().rev().enumerate() {
            let arg_place = alloc
                .places
                .get(arg_id as usize)
                .copied()
                .unwrap_or(Place::None);
            // Each prior push moved rsp another 16 bytes down.
            let sp_shift = (i as u32) * 16;
            let src = match materialize_int_shifted(code, arg_place, SCRATCH_R10, frame, sp_shift) {
                Some(r) => r,
                None => {
                    bail_msg("Call (variadic): arg not in int reg / spill");
                    return false;
                }
            };
            emit_sub_rsp_imm32(code, 16);
            emit_mov_mem_r(code, Reg::RSP, 0, src);
        }
        let call_site = code.len();
        fixups.push(Fixup {
            native_offset: call_site,
            target_ent_pc: target_pc,
            kind: super::x86_64::BranchKind::Call,
        });
        super::x86_64::emit_call_rel32(code, 0);
        if !args.is_empty() {
            emit_add_rsp_imm32(code, (args.len() as u32) * 16);
        }
        if let Some(rd) = int_or_spill_dst(dst) {
            if rd.0 != Reg::RAX.0 {
                emit_mov_rr(code, rd, Reg::RAX);
            }
            spill_dst_to_slot(code, dst, rd, frame);
        }
        return true;
    }
    // c5-internal call convention: every argument rides an int
    // register (or stack slot), even for f64 -- the callee's
    // prologue (`emit_prologue`) spills `int_arg_regs[0..n_params]`
    // into the c5 cdecl slots without distinguishing FP / int
    // params, so an FP arg routed through xmm would land in an
    // uninitialised slot. `fp_arg_mask = 0` keeps `plan_call_args`
    // on the int-reg path.
    let plan = super::plan_call_args(args.len(), args.len(), 0, abi);
    if plan.scratch_bytes > 0 {
        emit_sub_rsp_imm32(code, plan.scratch_bytes);
    }
    if !marshal_args(code, &plan, args, alloc, frame, "Call") {
        return false;
    }
    // Record a fixup for the call's rel32 field. `emit_call_rel32`
    // emits opcode 0xE8 then 4 bytes of rel32; `target_ent_pc`
    // resolves to the function's native offset in the post-pass.
    let call_site = code.len();
    fixups.push(Fixup {
        native_offset: call_site,
        target_ent_pc: target_pc,
        kind: super::x86_64::BranchKind::Call,
    });
    super::x86_64::emit_call_rel32(code, 0);
    if plan.scratch_bytes > 0 {
        emit_add_rsp_imm32(code, plan.scratch_bytes);
    }
    // c5 internal call return convention: the bit pattern lives
    // in rax (int-shaped dst reads rax); f64 returns additionally
    // live in xmm0 (FpReg-shaped dst reads xmm0). `emit_return`
    // mirrors xmm0 into rax for f64 returns so an int-shaped
    // caller reads it uniformly.
    match dst {
        Place::FpReg(r) => {
            if r != Reg::XMM0.0 {
                emit_movapd_xmm_xmm(code, Reg(r), Reg::XMM0);
            }
        }
        Place::IntReg(r) => {
            if r != Reg::RAX.0 {
                emit_mov_rr(code, Reg(r), Reg::RAX);
            }
        }
        Place::Spill(_) => {
            spill_dst_to_slot(code, dst, Reg::RAX, frame);
        }
        Place::None => {}
    }
    true
}

fn emit_call_ext(
    code: &mut Vec<u8>,
    dst: Place,
    binding_idx: i64,
    args: &[u32],
    fp_arg_mask: u32,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    target: Target,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    imports: &super::ResolvedImports,
) -> bool {
    let import_index = match imports.index_of_binding(binding_idx) {
        Some(i) => i,
        None => return false,
    };
    let imp = &imports.imports[import_index];
    let fixed = if imp.is_variadic {
        imp.fixed_args.min(args.len())
    } else {
        args.len()
    };
    let plan = super::plan_call_args(args.len(), fixed, fp_arg_mask, abi);
    let xmm_used = plan
        .placements
        .iter()
        .filter(|p| matches!(p, super::ArgPlacement::FpReg(_)))
        .count() as u8;
    if plan.scratch_bytes > 0 {
        emit_sub_rsp_imm32(code, plan.scratch_bytes);
    }
    if !marshal_args(code, &plan, args, alloc, frame, "CallExt") {
        return false;
    }
    // System V AMD64 ABI 3.2.3: when the callee is variadic, `al`
    // must hold the number of XMM argument registers used (printf
    // and friends consult `al` in their prologue to decide whether
    // to spill xmm0..xmm7 into the va-save area). Non-variadic
    // SysV callees treat `al` as don't-care; zero it for
    // determinism. Win64 has no such requirement and clears
    // `variadic_zero_xmm_count` in its `Abi`.
    if abi.variadic_zero_xmm_count {
        if imp.is_variadic {
            super::x86_64::emit_mov_al_imm8(code, xmm_used);
        } else {
            super::x86_64::emit_xor_eax_eax(code);
        }
    }
    let call_site = code.len();
    plt_call_fixups.push(PltCallFixup {
        instr_offset: call_site,
        import_index,
        is_tail: false,
    });
    super::x86_64::emit_call_rel32(code, 0);
    if plan.scratch_bytes > 0 {
        emit_add_rsp_imm32(code, plan.scratch_bytes);
    }
    // Sub-word integer returns get the standard sign / zero
    // extension into rax. FP returns arrive in xmm0 (SysV 3.2.3,
    // Win64 returns scalars/SSE in xmm0); route into the
    // allocator's chosen Place, which may be an FpReg, an IntReg
    // (holding the f64 bit pattern -- c5's accumulator is one big
    // 8-byte slot), or a spill slot.
    //
    // SysV long-double sits in x87 st0 (binary128 mantissa
    // truncated to the x87 80-bit format). c5 stores long double
    // in an 8-byte slot, so emit `fstp QWORD PTR [rsp]` to round
    // st0 to f64 and route the f64 bit pattern through the same
    // dst dispatch.
    use crate::c5::compiler::types as ty_helpers;
    let return_type_tag = imp.return_type_tag;
    let bare = ty_helpers::strip_unsigned(return_type_tag);
    let returns_long_double = imp.returns_long_double;
    if returns_long_double && matches!(target, Target::LinuxX64) {
        emit_sub_rsp_imm32(code, 16);
        // fstp QWORD PTR [rsp] -- `DD /3`, mod=00, rm=100 (SIB
        // follows), SIB = 0x24 (base = rsp, no index).
        code.extend_from_slice(&[0xDD, 0x1C, 0x24]);
        let scratch = match dst {
            Place::IntReg(r) if r != Reg::RAX.0 => Reg(r),
            _ => SCRATCH_R10,
        };
        emit_mov_r_mem(code, scratch, Reg::RSP, 0);
        emit_add_rsp_imm32(code, 16);
        match dst {
            Place::IntReg(r) => {
                if Reg(r).0 != scratch.0 {
                    emit_mov_rr(code, Reg(r), scratch);
                }
            }
            Place::Spill(_) => {
                spill_dst_to_slot(code, dst, scratch, frame);
            }
            Place::FpReg(r) => {
                super::x86_64::emit_movq_xmm_r(code, Reg(r), scratch);
            }
            Place::None => {}
        }
        return true;
    }
    if ty_helpers::is_float_ty(bare) || ty_helpers::is_double_ty(bare) {
        match dst {
            Place::FpReg(r) => {
                if r != Reg::XMM0.0 {
                    emit_movapd_xmm_xmm(code, Reg(r), Reg::XMM0);
                }
            }
            Place::IntReg(r) => {
                super::x86_64::emit_movq_r_xmm(code, Reg(r), Reg::XMM0);
            }
            Place::Spill(_) => {
                fp_spill_dst_to_slot(code, dst, Reg::XMM0, frame);
            }
            Place::None => {}
        }
        return true;
    }
    let ext = super::return_extension(return_type_tag, target);
    super::x86_64::emit_extend_rax_for_return(code, ext);
    if let Some(rd) = int_or_spill_dst(dst) {
        if rd.0 != Reg::RAX.0 {
            emit_mov_rr(code, rd, Reg::RAX);
        }
        spill_dst_to_slot(code, dst, rd, frame);
    }
    true
}

fn emit_call_indirect(
    code: &mut Vec<u8>,
    dst: Place,
    target: u32,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
) -> bool {
    let target_place = alloc
        .places
        .get(target as usize)
        .copied()
        .unwrap_or(Place::None);
    // Capture the target pointer into r11 before arg marshalling
    // can clobber it. r11 is caller-saved on every x86_64 ABI we
    // target; the SSA allocator's pool includes r11 (caller_gprs)
    // but the value held there can be no longer live than the
    // target itself since the SSA emit hijacks r11 for the call.
    let target_r = match materialize_int(code, target_place, Reg::R11, frame) {
        Some(r) => r,
        None => {
            bail_msg("CallIndirect: target not int reg / spill");
            return false;
        }
    };
    if target_r.0 != Reg::R11.0 {
        emit_mov_rr(code, Reg::R11, target_r);
    }
    let plan = super::plan_call_args(args.len(), args.len(), 0, abi);
    if plan.scratch_bytes > 0 {
        emit_sub_rsp_imm32(code, plan.scratch_bytes);
    }
    if !marshal_args(code, &plan, args, alloc, frame, "CallIndirect") {
        return false;
    }
    super::x86_64::emit_call_r(code, Reg::R11);
    if plan.scratch_bytes > 0 {
        emit_add_rsp_imm32(code, plan.scratch_bytes);
    }
    match dst {
        Place::FpReg(r) => {
            if r != Reg::XMM0.0 {
                emit_movapd_xmm_xmm(code, Reg(r), Reg::XMM0);
            }
        }
        Place::IntReg(r) => {
            if r != Reg::RAX.0 {
                emit_mov_rr(code, Reg(r), Reg::RAX);
            }
        }
        Place::Spill(_) => {
            spill_dst_to_slot(code, dst, Reg::RAX, frame);
        }
        Place::None => {}
    }
    true
}

fn emit_intrinsic(
    code: &mut Vec<u8>,
    kind: i64,
    args: &[u32],
    dst: Place,
    v: super::super::ir::ValueId,
    alloc: &Allocation,
    frame: Frame,
    current_alloca_top: u32,
) -> bool {
    use crate::c5::op::Intrinsic as I;
    let intrinsic = match I::from_i64(kind) {
        Some(i) => i,
        None => {
            bail_msg("intrinsic: unknown discriminant");
            return false;
        }
    };
    match intrinsic {
        I::VaStart => {
            // __builtin_va_start(&ap, &last). args[0] = &ap,
            // args[1] = &last. *ap = &last + 16 (next c5 slot,
            // 16-byte stride mirroring the aarch64 path).
            if args.len() != 2 {
                bail_msg("VaStart: expected 2 args");
                return false;
            }
            let ap = match alloc.places.get(args[0] as usize).copied() {
                Some(Place::IntReg(r)) => Reg(r),
                _ => {
                    bail_msg("VaStart: &ap not in int reg");
                    return false;
                }
            };
            let last = match alloc.places.get(args[1] as usize).copied() {
                Some(Place::IntReg(r)) => Reg(r),
                _ => {
                    bail_msg("VaStart: &last not in int reg");
                    return false;
                }
            };
            // scratch = &last + 16 ; mov [ap], scratch. The
            // scratch is a caller-saved register chosen so it
            // does not collide with `ap` or `last`; both are
            // intra-instruction so the call-site does not need to
            // preserve the register across the op.
            let Some(scratch) = pick_caller_saved_scratch_live_aware(ap, &[last], v, alloc) else {
                bail_msg("VaStart: no caller-saved scratch available");
                return false;
            };
            emit_lea_r_mem(code, scratch, last, 16);
            emit_mov_mem_r(code, ap, 0, scratch);
            true
        }
        I::VaArg => {
            // Returns *ap, advances *ap by 16. args[0] = &ap.
            if args.len() != 1 {
                bail_msg("VaArg: expected 1 arg");
                return false;
            }
            let Some(rd) = int_reg(dst) else {
                bail_msg("VaArg: dst not int reg");
                return false;
            };
            let ap = match alloc.places.get(args[0] as usize).copied() {
                Some(Place::IntReg(r)) => Reg(r),
                _ => {
                    bail_msg("VaArg: &ap not in int reg");
                    return false;
                }
            };
            // rd = *ap (old cursor) ; r13 = rd + 16 ; *ap = r13.
            // `ap` and `rd` can land on the same physical register
            // when the LocalAddr feeding `&ap` and the VaArg dst
            // share a slot. The advance/store sequence then needs
            // `&ap` preserved across `mov rd, [ap]`. r13 is outside
            // the allocator pool so it cannot collide with `ap`,
            // `rd`, or any other live SSA value.
            if rd.0 == ap.0 {
                let Some(scratch) = pick_caller_saved_scratch_live_aware(rd, &[], v, alloc) else {
                    bail_msg("VaArg: no caller-saved scratch available");
                    return false;
                };
                emit_mov_rr(code, scratch, ap);
                emit_mov_r_mem(code, rd, scratch, 0);
                emit_lea_r_mem(code, rd, rd, 16);
                emit_mov_mem_r(code, scratch, 0, rd);
                emit_lea_r_mem(code, rd, rd, -16);
            } else {
                let Some(scratch) = pick_caller_saved_scratch_live_aware(rd, &[ap], v, alloc)
                else {
                    bail_msg("VaArg: no caller-saved scratch available");
                    return false;
                };
                emit_mov_r_mem(code, rd, ap, 0);
                emit_lea_r_mem(code, scratch, rd, 16);
                emit_mov_mem_r(code, ap, 0, scratch);
            }
            true
        }
        I::VaEnd => {
            // No teardown for the cursor model.
            true
        }
        I::VaCopy => {
            // __builtin_va_copy(&dst, &src). *dst = *src.
            if args.len() != 2 {
                bail_msg("VaCopy: expected 2 args");
                return false;
            }
            let dst_p = match alloc.places.get(args[0] as usize).copied() {
                Some(Place::IntReg(r)) => Reg(r),
                _ => {
                    bail_msg("VaCopy: &dst not in int reg");
                    return false;
                }
            };
            let src_p = match alloc.places.get(args[1] as usize).copied() {
                Some(Place::IntReg(r)) => Reg(r),
                _ => {
                    bail_msg("VaCopy: &src not in int reg");
                    return false;
                }
            };
            // Pick a caller-saved scratch disjoint from dst_p
            // and src_p so the staging load does not clobber an
            // allocator-held value live across the intrinsic.
            let Some(scratch) = pick_caller_saved_scratch_live_aware(dst_p, &[src_p], v, alloc)
            else {
                bail_msg("VaCopy: no caller-saved scratch available");
                return false;
            };
            emit_mov_r_mem(code, scratch, src_p, 0);
            emit_mov_mem_r(code, dst_p, 0, scratch);
            true
        }
        I::Alloca => {
            // alloca(n): bump the per-frame arena's top down by
            // `n` rounded up to 16 bytes. The bookkeeping slot
            // lives at `[rbp - current_alloca_top]` (initialised
            // by the matching `Inst::AllocaInit`); the new top is
            // returned in `dst`.
            if current_alloca_top == 0 {
                bail_msg("Alloca: AllocaInit didn't run for this function");
                return false;
            }
            if args.len() != 1 {
                bail_msg("Alloca: expected 1 arg");
                return false;
            }
            let Some(rd) = int_or_spill_dst(dst) else {
                bail_msg("Alloca: dst not int reg / spill");
                return false;
            };
            let size_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            // Pick a caller-saved scratch for the size, disjoint
            // from rd. Stage size into it, then round up to a
            // 16-byte multiple.
            let Some(size_reg) = pick_caller_saved_scratch_live_aware(rd, &[], v, alloc) else {
                bail_msg("Alloca: no caller-saved scratch for size");
                return false;
            };
            let n = match materialize_int(code, size_place, size_reg, frame) {
                Some(r) => r,
                None => {
                    bail_msg("Alloca: size not int reg / spill / fp");
                    return false;
                }
            };
            if n.0 != size_reg.0 {
                emit_mov_rr(code, size_reg, n);
            }
            super::x86_64::emit_add_r_imm32(code, size_reg, 15);
            super::x86_64::emit_and_r_imm32(code, size_reg, -16);
            // Pick a second caller-saved scratch for the
            // bookkeeping-slot address, disjoint from rd and the
            // size register. The op then reads the old top, sub
            // size, writes back, and returns the new top.
            let Some(addr_reg) = pick_caller_saved_scratch_live_aware(rd, &[size_reg], v, alloc)
            else {
                bail_msg("Alloca: no caller-saved scratch for bookkeeping addr");
                return false;
            };
            let disp = -(current_alloca_top as i32);
            emit_lea_r_mem(code, addr_reg, Reg::RBP, disp);
            let rd_phys = if matches!(dst, Place::Spill(_)) {
                let Some(r) =
                    pick_caller_saved_scratch_live_aware(rd, &[size_reg, addr_reg], v, alloc)
                else {
                    bail_msg("Alloca: no caller-saved scratch for spill dst");
                    return false;
                };
                r
            } else {
                rd
            };
            emit_mov_r_mem(code, rd_phys, addr_reg, 0);
            super::x86_64::emit_sub_rr(code, rd_phys, size_reg);
            emit_mov_mem_r(code, addr_reg, 0, rd_phys);
            spill_dst_to_slot(code, dst, rd_phys, frame);
            true
        }
        I::SetjmpAArch64 | I::LongjmpAArch64 => {
            bail_msg("intrinsic: AArch64 setjmp / longjmp on non-AArch64 target");
            false
        }
    }
}

fn emit_imm_data(
    code: &mut Vec<u8>,
    dst: Place,
    offset: i64,
    data_fixups: &mut Vec<DataFixup>,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("ImmData: dst not int reg / spill");
        return false;
    };
    let instr_offset = code.len();
    data_fixups.push(DataFixup {
        adrp_offset: instr_offset,
        data_offset: offset as u64,
    });
    // `lea rd, [rip + 0]` placeholder; the writer patches the
    // disp32 once the data segment's runtime address is known.
    super::x86_64::emit_lea_r_rip32(code, rd, 0);
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

fn emit_imm_code(
    code: &mut Vec<u8>,
    dst: Place,
    target_ent_pc: usize,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        bail_msg("ImmCode: dst not int reg / spill");
        return false;
    };
    let instr_offset = code.len();
    pending_func_fixups.push((instr_offset, target_ent_pc));
    super::x86_64::emit_lea_r_rip32(code, rd, 0);
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

fn emit_mcpy(
    code: &mut Vec<u8>,
    dst_place: Place,
    dst_val: u32,
    src_val: u32,
    size: i64,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    if size < 0 {
        bail_msg("Mcpy: negative size");
        return false;
    }
    let dst_in = alloc
        .places
        .get(dst_val as usize)
        .copied()
        .unwrap_or(Place::None);
    let src_in = alloc
        .places
        .get(src_val as usize)
        .copied()
        .unwrap_or(Place::None);
    // Materialise both bases. r10 / rcx are caller-saved scratch
    // regs outside the SSA allocator pool, so they can't clobber
    // anything live.
    let Some(dst_r) = materialize_int(code, dst_in, SCRATCH_R10, frame) else {
        bail_msg("Mcpy: dst base not int reg / spill");
        return false;
    };
    let src_scratch = if dst_r.0 == SCRATCH_R10.0 {
        Reg::RCX
    } else {
        SCRATCH_R10
    };
    let Some(src_r) = materialize_int(code, src_in, src_scratch, frame) else {
        bail_msg("Mcpy: src base not int reg / spill");
        return false;
    };
    // Pick a per-iteration temp distinct from both bases, then
    // save / restore it across the copy. The SSA allocator's
    // pool for LinuxX64 includes rax and r11; the prologue may
    // have parked a live value in either. A push/pop pair around
    // the loop preserves whatever the allocator stashed there.
    let temp = if dst_r.0 != Reg::RAX.0 && src_r.0 != Reg::RAX.0 {
        Reg::RAX
    } else if dst_r.0 != Reg::R11.0 && src_r.0 != Reg::R11.0 {
        Reg::R11
    } else if dst_r.0 != Reg::RCX.0 && src_r.0 != Reg::RCX.0 {
        Reg::RCX
    } else {
        // Both r10 (one of the bases here -- only happens when
        // either materialise loaded into r10) and rcx are taken.
        // Fall back to rdx, which is also outside every pool.
        Reg::RDX
    };
    emit_push_r(code, temp);
    let bytes = size as u32;
    let words = bytes / 8;
    for w in 0..words {
        // After push, [base + off] still resolves correctly
        // because the bases are register-typed (not sp-relative).
        let off = (w * 8) as i32;
        emit_mov_r_mem(code, temp, src_r, off);
        emit_mov_mem_r(code, dst_r, off, temp);
    }
    let tail_start = words * 8;
    for i in 0..(bytes - tail_start) {
        let off = (tail_start + i) as i32;
        super::x86_64::emit_movzx_r_mem8(code, temp, src_r, off);
        super::x86_64::emit_mov_mem8_r(code, dst_r, off, temp);
    }
    emit_pop_r(code, temp);
    // memcpy returns dst; propagate into the inst's dst.
    match dst_place {
        Place::IntReg(r) if r != dst_r.0 => emit_mov_rr(code, Reg(r), dst_r),
        Place::Spill(_) => spill_dst_to_slot(code, dst_place, dst_r, frame),
        _ => {}
    }
    true
}

/// Decide whether `block` ends in a tail-call shape: the block's
/// `Terminator::Return` value is the same block's last instruction,
/// and that instruction is a direct `Inst::Call` whose arguments
/// fit in the host integer-arg-register window. Returns
/// `Some((call_pc, target_pc, args))` when the shape matches and
/// every safety precondition holds.
///
/// Preconditions (in order):
///   * The terminator is `Return(v)` and `v` is the PC of the last
///     instruction in the block.
///   * That instruction is `Inst::Call { target_pc, args }`. Indirect
///     and external calls are out of scope for this pass.
///   * `args.len() <= abi.int_arg_regs.len()` -- no host-stack-overflow
///     argument; the epilogue would otherwise have to negotiate the
///     overflow stripe and the caller's stack at the same time.
///   * The callee isn't this function's variadic-marker call: c5's
///     internal cdecl-vs-variadic split is encoded by the callee's
///     own prologue, but the tail call site can't tell from here, so
///     keep the tail conversion off when *this* function is variadic
///     (its arg slots stay on the c5 stack rather than reg cells).
///   * The function has no `LocalAddr` to a negative slot: any such
///     address could have been passed to the callee in an earlier
///     call's argument, and tearing down our frame before the jmp
///     would invalidate it.
///   * The function records no callee-saved register use
///     (`alloc.gpr_used.is_empty()`): the epilogue would emit per-reg
///     restores between the arg marshal and the jmp, all of which
///     are callee-saved (rbx / r12 / r14 / r15 / rsi / rdi on Win64)
///     and so don't alias the caller-saved arg-register window the
///     tail call has just populated. Restricted on this first pass
///     for tractability; the more general path can drop this gate
///     once it is shown to be safe via an explicit save-before-marshal
///     dance.
fn detect_tail_call<'a>(
    func: &'a FunctionSsa,
    block: &super::super::ir::Block,
    abi: super::Abi,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
) -> Option<(usize, usize, &'a [u32])> {
    let Terminator::Return(v) = block.terminator else {
        return None;
    };
    if v == super::super::ir::NO_VALUE {
        return None;
    }
    let inst_end = block.inst_range.end;
    if inst_end == 0 || v + 1 != inst_end {
        return None;
    }
    let (target_pc, args) = match &func.insts[v as usize] {
        Inst::Call { target_pc, args } => (*target_pc, args.as_slice()),
        _ => return None,
    };
    if args.len() > abi.int_arg_regs.len() {
        return None;
    }
    if func.is_variadic {
        return None;
    }
    // Variadic callees use a different call ABI (c5-stack 16-byte
    // pushes rather than the host int-arg-register window), so the
    // tail conversion's `marshal_args` would deliver garbage. The
    // regular `emit_call` path branches on this same flag.
    if variadic_targets.contains(&target_pc) {
        return None;
    }
    // Any `LocalAddr` -- whether to a user-local (negative `off`) or
    // a c5 cdecl param cell (positive `off >= 2`) -- could have been
    // passed as an argument to an earlier call or stored where the
    // callee will read it. Tearing down our frame before the `jmp`
    // would make that address dangle; the param cells in particular
    // get overwritten by the tail-callee's own prologue.
    if func.insts.iter().any(|i| matches!(i, Inst::LocalAddr(_))) {
        return None;
    }
    Some((v as usize, target_pc, args))
}

/// Emit a tail call as `marshal_args; epilogue; jmp target`.
/// `args` are placed into the host integer arg-register window using
/// the same planner the regular `Inst::Call` path uses; the epilogue
/// mirrors `emit_return`'s frame teardown (callee-saved restores +
/// `add rsp` + `pop rbp` + cdecl-cell drop) but skips the return
/// value staging and ends in `jmp rel32` instead of `ret`. The
/// callee's own `ret` instruction returns control to *our* caller.
#[allow(clippy::too_many_arguments)]
fn emit_tail_call(
    code: &mut Vec<u8>,
    target_pc: usize,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    fixups: &mut Vec<Fixup>,
    func: &FunctionSsa,
) -> bool {
    // Marshal arguments into their ABI-prescribed registers. The
    // caller-saved arg-reg window is disjoint from `alloc.gpr_used`
    // (only callee-saved regs land there), so the epilogue's
    // restores below cannot clobber the marshalled values.
    let plan = super::plan_call_args(args.len(), args.len(), 0, abi);
    // `detect_tail_call` rejects arg counts above `int_arg_regs.len()`,
    // so no `Stack(offset)` placements ever reach here. `scratch_bytes`
    // may still be nonzero on Win64 (the 32-byte shadow space rides
    // above the arg-reg window), but that area is already part of our
    // caller's frame -- after the epilogue restores rsp the callee
    // sees it exactly as a non-tail caller would have set it up.
    if plan
        .placements
        .iter()
        .any(|p| matches!(p, super::ArgPlacement::Stack(_)))
    {
        unreachable!(
            "ICE: tail-call planner returned a Stack arg placement; \
             detect_tail_call should have rejected arg_count > int_arg_regs"
        );
    }
    if !marshal_args(code, &plan, args, alloc, frame, "TailCall") {
        return false;
    }
    // Mirror emit_return's epilogue, omitting the return-value
    // staging (the callee's own `ret` carries the value back).
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = (i as i32) * 8;
        super::x86_64::emit_mov_r_mem(code, Reg(r), Reg::RSP, off);
    }
    if !is_full_leaf(func, frame, alloc) {
        if frame.frame_bytes > 0 {
            emit_add_rsp_imm32(code, frame.frame_bytes);
        }
        emit_pop_r(code, Reg::RBP);
        if frame.param_spill_bytes > 0 {
            emit_add_rsp_imm32(code, frame.param_spill_bytes);
        }
    }
    // Record a Call-kind fixup at the rel32 byte; the post-link pass
    // resolves `target_ent_pc` to its native byte offset like a
    // regular intra-unit call. The opcode emitted here is `jmp`
    // (E9 rel32), not `call`, so the callee's own `ret` returns to
    // our caller rather than to this instruction.
    let jmp_site = code.len();
    fixups.push(Fixup {
        native_offset: jmp_site,
        target_ent_pc: target_pc,
        kind: super::x86_64::BranchKind::Jmp,
    });
    super::x86_64::emit_jmp_rel32(code, 0);
    true
}

fn emit_return(
    code: &mut Vec<u8>,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
    func: &FunctionSsa,
) {
    // The integer return value may live in a callee-saved
    // register that the prologue saved and the epilogue is about
    // to restore (e.g. rbx, r12). When the function has any such
    // register the restore loop writes them, so stage the value
    // through rcx (caller-saved, never in `gpr_used`) before the
    // restore overwrites the source and move rcx into rax after.
    // Functions with no callee-saved GPRs to restore (the common
    // case after frame elision lands on leaf-shaped bodies) take
    // the direct path: a single `mov rax, src` -- or nothing when
    // src already lives in rax. FP returns ride xmm0 directly;
    // xmm0 is outside the GPR restore loop, but the integer
    // mirror into rax happens after the restore so the bit
    // pattern is available to int-shaped callers.
    let return_place = if value != super::super::ir::NO_VALUE {
        alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None)
    } else {
        Place::None
    };
    let return_is_fp = matches!(return_place, Place::FpReg(_));
    let needs_staging = !alloc.gpr_used.is_empty();
    let staged_int = if needs_staging {
        match return_place {
            Place::IntReg(r) if r != Reg::RCX.0 => {
                emit_mov_rr(code, Reg::RCX, Reg(r));
                true
            }
            Place::IntReg(_) => true,
            Place::Spill(slot) => {
                let sp_off = spill_slot_sp_offset(frame, slot);
                super::x86_64::emit_mov_r_mem(code, Reg::RCX, Reg::RSP, sp_off);
                true
            }
            _ => false,
        }
    } else {
        false
    };
    if return_is_fp {
        // SCRATCH_XMM14 is outside the allocator's pool, so a
        // spilled f64 lands there without clobbering an
        // allocator-held xmm.
        if let Some(dn) = materialize_fp(code, return_place, SCRATCH_XMM14, frame)
            && dn.0 != Reg::XMM0.0
        {
            emit_movapd_xmm_xmm(code, Reg::XMM0, dn);
        }
    }
    // Restore callee-saved GPRs (mirror of the prologue's saves).
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = (i as i32) * 8;
        super::x86_64::emit_mov_r_mem(code, Reg(r), Reg::RSP, off);
    }
    if staged_int {
        emit_mov_rr(code, Reg::RAX, Reg::RCX);
    } else if !needs_staging {
        // No callee-saved restore to navigate around; place the
        // return value into rax directly. A source that already
        // lives in rax needs no instruction.
        match return_place {
            Place::IntReg(r) if r != Reg::RAX.0 => {
                emit_mov_rr(code, Reg::RAX, Reg(r));
            }
            Place::Spill(slot) => {
                let sp_off = spill_slot_sp_offset(frame, slot);
                super::x86_64::emit_mov_r_mem(code, Reg::RAX, Reg::RSP, sp_off);
            }
            _ => {}
        }
    }
    if !staged_int && return_is_fp {
        super::x86_64::emit_movq_r_xmm(code, Reg::RAX, Reg::XMM0);
    }
    // Leaf-function elision: prologue emitted no save, so the
    // epilogue emits no matching restore. The function lowers to
    // the return-value materialization, then `ret`.
    if is_full_leaf(func, frame, alloc) {
        emit_ret(code);
        return;
    }
    if frame.frame_bytes > 0 {
        emit_add_rsp_imm32(code, frame.frame_bytes);
    }
    emit_pop_r(code, Reg::RBP);
    // Drop whatever bytes the prologue allocated for c5 cdecl
    // parameter slots above the return address. The single
    // source of truth is `prologue_param_spill_bytes`, recorded
    // on `frame.param_spill_bytes`; both prologue and epilogue
    // read from there so the two sides agree across every
    // branch the prologue takes (variadic, host-stack overflow,
    // ParamRef-elided, n_params == 0). When 0, the `pop r11`
    // / `push r11` dance is skipped entirely because the return
    // address is already on top of the stack.
    let _ = func;
    if frame.param_spill_bytes > 0 {
        emit_pop_r(code, Reg::R11);
        emit_add_rsp_imm32(code, frame.param_spill_bytes);
        emit_push_r(code, Reg::R11);
    }
    emit_ret(code);
}

#[cfg(test)]
mod scratch_picker_tests {
    use super::*;

    #[test]
    fn pick_returns_some_when_no_operands() {
        // With rd = rax and no operands, the helper should return
        // the first preference (r11) per the CALLER_SAVED_INT_SCRATCHES
        // ordering.
        assert_eq!(pick_caller_saved_scratch(Reg(0), &[]), Some(Reg(11)));
    }

    #[test]
    fn pick_skips_rd() {
        // rd = r11 forces the helper past the first preference;
        // the next entry (r10) wins.
        assert_eq!(pick_caller_saved_scratch(Reg(11), &[]), Some(Reg(10)));
    }

    #[test]
    fn pick_skips_operand_regs() {
        // rd = r11, operands hold r10 and rax (0) -> rcx (1) wins.
        assert_eq!(
            pick_caller_saved_scratch(Reg(11), &[Reg(10), Reg(0)]),
            Some(Reg(1))
        );
    }

    #[test]
    fn pick_returns_none_when_pool_exhausted() {
        // The candidate pool is CALLER_SAVED_INT_SCRATCHES = [11, 10,
        // 0, 1, 2, 8, 9]. Excluding all seven via rd + 6 operands
        // forces the fallthrough. The helper must return None so
        // callers bail rather than fall through to a callee-saved
        // register (which would violate the System V / Win64 callee-
        // save contract).
        let rd = Reg(11);
        let operands = [Reg(10), Reg(0), Reg(1), Reg(2), Reg(8), Reg(9)];
        assert_eq!(pick_caller_saved_scratch(rd, &operands), None);
    }

    #[test]
    fn pick_returns_none_when_every_candidate_in_operands() {
        // rd is outside the pool entirely (rdi = 7, callee-saved on
        // Win64 / caller-saved on SysV but not in our intersection
        // pool); every entry of CALLER_SAVED_INT_SCRATCHES is in
        // the operand list. Helper must return None.
        let rd = Reg(7);
        let operands = [Reg(11), Reg(10), Reg(0), Reg(1), Reg(2), Reg(8), Reg(9)];
        assert_eq!(pick_caller_saved_scratch(rd, &operands), None);
    }
}
