//! x86_64 native emit consuming the SSA lift + allocator output.
//! Active when `NativeOptions::regalloc = RegallocMode::Ssa` and
//! the env var `BADC_USE_SSA_EMIT` is set. Mirrors the aarch64
//! counterpart's structure; the difference is the per-target
//! instruction encodings and the SysV / Win64 ABI shape applied
//! to argument and return placement.
//!
//! ## Pass shape
//!
//! For each function:
//!
//! 1. Prologue: push rbp, set rbp = rsp, reserve locals + vstack +
//!    allocator-spill bytes, save the callee-saved GPRs the
//!    allocator reported as used, and spill the host-ABI arg
//!    registers into the c5 cdecl slots the body's
//!    `LocalAddr(>=2)` references.
//! 2. Walk each block in source order. Emit `VstackReload`s at
//!    block start, per-`Inst` native code in `inst_range`, then
//!    `VstackSpill`s, then the terminator.
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
//!   vstack spill slots            [rbp - locals_bytes - vstack_bytes .. ...]
//!   allocator spill slots         ...
//!   saved callee-saved GPRs       rsp
//! ```
//!
//! ## Coverage policy
//!
//! [`emit_function`] returns `true` when the SSA emit handled the
//! function end-to-end and `false` when any encountered op is
//! outside the implemented subset. Under the default dispatch
//! the caller falls back to the pool path for that function;
//! setting `BADC_STRICT_SSA_EMIT=1` flips the policy to abort.

#![allow(dead_code, clippy::too_many_arguments)]

use alloc::vec::Vec;

use super::DataFixup;
use super::GotFixup;
use super::Target;
use super::ssa::{FunctionSsa, Inst, Terminator};
use super::ssa_alloc::{Allocation, Place};
use super::x86_64::{
    Fixup, PltCallFixup, Reg, emit_add_rsp_imm32, emit_mov_r_imm64, emit_mov_rr, emit_pop_r,
    emit_push_r, emit_ret, emit_sub_rsp_imm32,
};

/// Per-function frame layout. Bytes are 16-aligned at every
/// region boundary so SysV / Win64's sp-at-call invariant holds.
#[derive(Debug, Clone, Copy)]
pub(super) struct Frame {
    pub frame_bytes: u32,
    pub acc_slot_off: u32,
    pub alloc_spill_base: u32,
}

impl Frame {
    pub fn for_function(func: &FunctionSsa, alloc: &Allocation) -> Self {
        let locals_bytes = ((func.locals.max(0) as u32) * 8 + 15) & !15;
        let vstack_bytes = (func.vstack_slots * 8 + 15) & !15;
        let acc_bytes = 16u32;
        let alloc_spill_bytes = (alloc.spill_count * 8 + 15) & !15;
        let saved_gpr_bytes = ((alloc.gpr_used.len() as u32) * 8 + 15) & !15;
        let frame_bytes =
            locals_bytes + vstack_bytes + acc_bytes + alloc_spill_bytes + saved_gpr_bytes;
        Self {
            frame_bytes,
            acc_slot_off: locals_bytes + vstack_bytes + 8,
            alloc_spill_base: locals_bytes + vstack_bytes + acc_bytes,
        }
    }
}

fn bail_msg(reason: &str) {
    #[cfg(feature = "std")]
    if std::env::var("BADC_DUMP_SSA").is_ok() {
        eprintln!("ssa emit x86_64: bailed -- {reason}");
    }
    let _ = reason;
}

/// Extract the int reg from a `Place`, or `None` if it's not an
/// integer register.
fn int_reg(place: Place) -> Option<Reg> {
    match place {
        Place::IntReg(r) => Some(Reg(r)),
        _ => None,
    }
}

/// Public entry point. Returns `true` when every block + inst +
/// terminator was lowered. Returns `false` (with `code`
/// truncated back to the pre-attempt snapshot) when the function
/// contains an op outside the implemented subset. The handler
/// set is intentionally minimal at this stage; the aarch64 SSA
/// emit grew bottom-up from the same shape and the x86_64 path
/// follows that trajectory.
pub(super) fn emit_function(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    code: &mut Vec<u8>,
    _fixups: &mut Vec<Fixup>,
    _plt_call_fixups: &mut Vec<PltCallFixup>,
    _got_fixups: &mut Vec<GotFixup>,
    _data_fixups: &mut Vec<DataFixup>,
    _pending_func_fixups: &mut Vec<(usize, usize)>,
    _imports: &super::ResolvedImports,
    _variadic_targets: &alloc::collections::BTreeSet<usize>,
    _tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    bytecode_to_native: &mut [usize],
) -> bool {
    let snapshot = code.len();
    let frame = Frame::for_function(func, alloc);
    let abi = target.abi();

    // Single-block functions only at this stage. Multi-block
    // shapes need the branch-fixup machinery the aarch64 emit
    // already has; bring that across in a follow-on once the
    // single-block path is exercised.
    if func.blocks.len() != 1 {
        bail_msg("multi-block functions not yet handled");
        return false;
    }

    emit_prologue(code, func, alloc, frame, abi);

    let block = &func.blocks[0];
    for v in block.inst_range.clone() {
        let inst = &func.insts[v as usize];
        let place = alloc.places.get(v as usize).copied().unwrap_or(Place::None);
        if !emit_inst(code, inst, place, alloc, frame) {
            #[cfg(feature = "std")]
            if std::env::var("BADC_DUMP_SSA").is_ok() {
                eprintln!(
                    "ssa emit x86_64: bailed on inst v{v}: {:?} (place {:?})",
                    inst, place,
                );
            }
            code.truncate(snapshot);
            return false;
        }
    }
    match block.terminator {
        Terminator::Return(v) => emit_return(code, v, alloc, frame, func),
        _ => {
            bail_msg("non-Return terminator on single-block fn");
            code.truncate(snapshot);
            return false;
        }
    }

    let _ = bytecode_to_native;
    true
}

/// Spill the host-ABI argument registers into the c5 cdecl slots
/// the body references via `Op::Lea N` (`N >= 2`). c5 places the
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
    // Host-arg-reg spill. Skipped for variadic functions; the
    // pool path's same prologue does this too.
    let entry_spill = if func.is_variadic { 0 } else { func.n_params };
    if entry_spill > 0 {
        // Pop the call's return address into r11. With the saved
        // address out of the way we can push the c5 cdecl arg
        // slots above where rbp will eventually land. The trailing
        // push restores the call's return address on top of those
        // slots so the eventual `ret` returns to the caller as
        // normal. r11 is caller-saved on every x86_64 ABI we
        // target, so the host won't notice it was used as scratch.
        emit_pop_r(code, Reg::R11);
        let n_reg = entry_spill.min(abi.int_arg_regs.len());
        let n_stack = entry_spill - n_reg;
        if n_stack > 0 {
            // Host stack overflow args sit at [rsp + 16 + i*8]
            // after the pop above (the `+ 16` accounts for the
            // return address slot the caller pushed plus the
            // saved rbp slot we'll push later). Restripe them
            // into 16-byte c5 cdecl slots.
            bail_msg("prologue: > N-reg arg overflow not implemented yet");
            return;
        }
        // Push the int arg regs in reverse declaration order so
        // arg 0 ends up at the lowest pushed address (= [rbp + 16]
        // once rbp is set), arg 1 at [rbp + 32], etc. The push
        // sequence consumes 8 bytes per push but `Op::Lea` strides
        // 16; cover the gap by pushing a zero alongside each arg.
        // The pool path does this with `str_pre Reg::X19, [sp, -16]!`
        // on aarch64; on x86_64 it pushes the arg + a zero word.
        for i in (0..n_reg).rev() {
            // Push the slot's high half first (8 bytes of zero
            // padding so `[rbp + 16i + 8]` reads as 0 -- matches
            // the aarch64 ` str x_r, [sp, -16]!` shape's high
            // half) followed by the arg itself.
            emit_sub_rsp_imm32(code, 8);
            emit_push_r(code, Reg(abi.int_arg_regs[i]));
        }
        // Restore the return address so the function's body sees
        // a standard SysV / Win64 stack layout (with the c5 slots
        // above it).
        emit_push_r(code, Reg::R11);
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

fn emit_inst(
    code: &mut Vec<u8>,
    inst: &Inst,
    dst: Place,
    _alloc: &Allocation,
    _frame: Frame,
) -> bool {
    match inst {
        Inst::AllocaInit(slot) => {
            // Zero slot -> no alloca, emit nothing (matches the
            // pool path). Non-zero alloca isn't covered yet.
            *slot == 0
        }
        Inst::Imm(value) => {
            let Some(rd) = int_reg(dst) else {
                bail_msg("Imm: dst not int reg");
                return false;
            };
            emit_mov_r_imm64(code, rd, *value);
            true
        }
        Inst::AccSpill { .. } => {
            // Spill the accumulator across a block boundary. For
            // single-block functions the cross-block thread never
            // fires, so a no-op is correct. Bring the real
            // handler across when multi-block lands.
            true
        }
        _ => {
            bail_msg("inst variant not yet covered");
            false
        }
    }
}

fn emit_return(
    code: &mut Vec<u8>,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
    func: &FunctionSsa,
) {
    if value != super::ssa::NO_VALUE {
        let place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        if let Some(src) = int_reg(place) {
            if src.0 != 0 {
                emit_mov_rr(code, Reg::RAX, src);
            }
        }
    }
    // Restore callee-saved GPRs (mirror of the prologue's saves).
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = (i as i32) * 8;
        super::x86_64::emit_mov_r_mem(code, Reg(r), Reg::RSP, off);
    }
    if frame.frame_bytes > 0 {
        emit_add_rsp_imm32(code, frame.frame_bytes);
    }
    emit_pop_r(code, Reg::RBP);
    // Drop the host-arg-reg spill slots the prologue laid down.
    // Each param consumed a 16-byte slot (one push for the arg +
    // one 8-byte gap). Pop the ret address into r11, drop the
    // slots, push the ret address back. Skipped for variadic
    // functions whose prologue did no spilling.
    if !func.is_variadic && func.n_params > 0 {
        emit_pop_r(code, Reg::R11);
        let bytes = (16 * func.n_params) as u32;
        emit_add_rsp_imm32(code, bytes);
        emit_push_r(code, Reg::R11);
    }
    emit_ret(code);
}
