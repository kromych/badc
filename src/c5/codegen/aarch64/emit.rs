//! AArch64 native emit consuming the SSA + allocator output.
//! A per-function bail is a hard error -- the IR + emit contract
//! has to cover every shape the walker produces.
//!
//! ## Pass shape
//!
//! For each function:
//!
//! 1. Prologue: save fp / lr, set the frame pointer, reserve
//!    locals + allocator-spill bytes, save the callee-saved
//!    GPRs / FP regs the allocator reported as used, and spill
//!    the host-ABI argument registers into the c5 cdecl slots
//!    the body's `LocalAddr(>=2)` references.
//! 2. Walk each block in source order. Emit per-`Inst` native
//!    code in `inst_range`, then the terminator.
//! 3. Epilogue lands inline at every `Terminator::Return`: load
//!    the return value into x0, restore saved regs, drop the
//!    frame, `ret`.
//!
//! ## Frame layout (top -> bottom, growing down from caller's sp)
//!
//! ```text
//!   c5 cdecl param slots          [fp + 16*i]
//!   saved fp, saved lr            [fp +  0]
//!   locals area                   [fp - locals_bytes .. fp]
//!   allocator spill slots         ...
//!   saved callee-saved GPRs
//!   saved callee-saved FP regs    sp
//! ```
//!
//! Each `Place::Spill(N)` reads / writes 8-byte slot N inside the
//! allocator spill region; the byte address is
//! `fp - frame.alloc_spill_base - (N+1)*8`.
//!
//! ## Coverage policy
//!
//! [`emit_function`] returns `true` when the SSA emit handled the
//! function end-to-end and `false` when any encountered op is
//! outside the implemented subset. The caller (`aarch64::lower`)
//! turns `false` into a hard compile error -- the IR + emit
//! contract has to cover every shape the walker produces.

#![allow(dead_code, clippy::too_many_arguments)]

use alloc::vec::Vec;

use super::super::ir::{BinOp, BlockId, FunctionSsa, Inst, LoadKind, StoreKind, Terminator};
use super::DataFixup;
use super::Target;
use super::encode::{
    BranchKind, Cond, Fixup, JB_D8_OFF, JB_PC_OFF, JB_SP_OFF, JB_X19_OFF, JB_X29_OFF, PltCallFixup,
    Reg, emit, emit_add_sp_imm, emit_mov_reg, emit_setjmp_aarch64, emit_sub_sp_imm, enc_add_imm,
    enc_add_reg, enc_adr, enc_adrp, enc_and_reg, enc_asrv, enc_b, enc_b_cond, enc_bl, enc_blr,
    enc_br, enc_cbnz, enc_cbz, enc_cinc, enc_cmp_reg, enc_cset, enc_eor_reg, enc_fadd_d,
    enc_fcmp_d, enc_fcmp_s, enc_fcvt_d_s, enc_fcvt_s_d, enc_fcvtzs_x_d, enc_fcvtzu_x_d, enc_fdiv_d,
    enc_fmov_d_to_x, enc_fmov_w_to_s, enc_fmov_x_to_d, enc_fmul_d, enc_fneg_d, enc_fsub_d,
    enc_ldaxr, enc_ldp_post, enc_ldr_d_imm, enc_ldr_imm, enc_ldr_post, enc_ldr_s_imm,
    enc_ldr32_imm, enc_ldrb_imm, enc_ldrh_imm, enc_ldrsb_imm, enc_ldrsh_imm, enc_ldrsw_imm,
    enc_lslv, enc_lsrv, enc_movz, enc_msub, enc_mul, enc_orr_reg, enc_ret, enc_scvtf_d_x, enc_sdiv,
    enc_stlxr, enc_stp_pre, enc_str_d_imm, enc_str_imm, enc_str_pre, enc_str_s_imm, enc_str32_imm,
    enc_strb_imm, enc_strh_imm, enc_sub_imm, enc_sub_reg, enc_subs_imm, enc_ucvtf_d_x, enc_udiv,
    load_imm64,
};
use super::ssa::emit_common::{build_arg_aggs, place_same_loc};
use super::ssa::reg_alloc::{Allocation, Place};

/// Compute the aarch64 stack-frame layout for `func`. Fills the shared
/// [`Frame`]'s aarch64 fields; the x86_64-only fields stay at their defaults.
/// Per-function stack-frame layout for aarch64. Every region is an explicit
/// byte count so the prologue and epilogue read the same values.
#[derive(Debug, Clone, Copy)]
pub(crate) struct Frame {
    /// Total frame the prologue allocates: locals + allocator spills + saved
    /// callee-saved registers + any register-save area.
    pub frame_bytes: u32,
    /// Byte distance from the frame base down to the allocator spill region.
    pub alloc_spill_base: u32,
    /// Total bytes reserved for c5 cdecl parameter cells and host-stack overflow.
    pub param_spill_bytes: u32,
    /// Byte stride between adjacent parameter cells: 16 for the c5 cdecl cell,
    /// 8 for a host variadic callee's contiguous argument region.
    pub param_cell_stride: i64,
    /// Whether the function clobbers (and therefore saves) x19.
    pub uses_x19: bool,
    /// AAPCS64 variadic callee reads named parameters from the register save
    /// area rather than cdecl cells.
    pub va_named_redirect: bool,
    /// `FunctionSsa::param_fp_mask` for the named-parameter redirect.
    pub va_param_fp_mask: u32,
    /// Named-parameter count for the redirect's `plan_param_regs`.
    pub va_n_params: usize,
    /// ABI carried for the redirect's slot mapping.
    pub va_abi: super::Abi,
}

fn compute_frame(func: &FunctionSsa, alloc: &Allocation, abi: super::Abi, target: Target) -> Frame {
    let (locals_bytes, alloc_spill_bytes, saved_gpr_bytes) =
        super::ssa::emit_common::compute_frame_base(func, alloc);
    let saved_fpr_bytes = super::ssa::emit_common::slots16(alloc.fp_used.len() as u32);
    // Reserve the x19 slot only when the function actually
    // clobbers x19; the prologue / epilogue's store / load already
    // gates on the same condition, so a function that leaves x19
    // alone needs no slot and can drop the 16 bytes. The clobber
    // decision (TLS / indirect-call / intrinsic address scratch, or
    // a third modulo operand under spill) lives in the shared
    // `function_clobbers_scratch`, which knows each target's
    // reserved scratch set.
    let uses_x19 =
        !super::ssa::reg_alloc::function_clobbers_scratch(func, target, alloc.spill_count)
            .is_empty();
    let x19_save_bytes = if uses_x19 { 16u32 } else { 0 };
    let frame_bytes =
        locals_bytes + alloc_spill_bytes + saved_gpr_bytes + saved_fpr_bytes + x19_save_bytes;
    // A Windows-on-ARM64 variadic callee (Microsoft ARM64 calling
    // convention) receives every argument (named and variadic) in a
    // contiguous 8-byte-per-argument region: the first eight in
    // x0..x7 (spilled by the prologue into a 64-byte gr-save area
    // above the saved fp/lr), the rest on the incoming stack just
    // above it. The body reads its named parameters and `va_arg`
    // walks the variadic tail with a single 8-byte stride across
    // that region, so the cell stride is 8 rather than the 16-byte
    // c5 cdecl cell width, and the prologue allocates a fixed
    // 64-byte gr-save area. Every other aarch64 callee keeps the
    // 16-byte stride and its `prologue_param_spill_bytes` count.
    let (param_spill_bytes, param_cell_stride) = if win_arm64_variadic_callee(func, abi) {
        (WIN_ARM64_GR_SAVE_BYTES, 8)
    } else if aarch64_host_variadic_callee(func, abi) {
        // The AAPCS64 variadic callee reserves the 192-byte general +
        // vector register save area above the saved fp/lr. Named
        // parameters read from it through `local_slot_off`, not the
        // 16-byte cdecl cell, so the cell stride is unused here.
        (AARCH64_VA_SAVE_BYTES, 16)
    } else {
        (prologue_param_spill_bytes(func, alloc, abi), 16)
    };
    Frame {
        frame_bytes,
        alloc_spill_base: locals_bytes,
        uses_x19,
        param_spill_bytes,
        param_cell_stride,
        va_named_redirect: aarch64_host_variadic_callee(func, abi),
        va_param_fp_mask: func.param_fp_mask,
        va_n_params: func.n_params,
        va_abi: abi,
    }
}

/// Bytes the Windows-on-ARM64 variadic prologue reserves above the
/// saved fp/lr for the integer register-save area. The Microsoft ARM64
/// calling convention passes the first eight arguments in x0..x7; the
/// callee spills all eight into one contiguous 8-byte-stride region so
/// the named parameters (x0..x{fixed-1}) and the register-resident
/// variadic arguments (x{fixed}..x7) are addressable as cells and
/// `va_arg` walks them, then crosses into the incoming stack overflow
/// that sits immediately above. 8 registers * 8 bytes = 64, already
/// 16-aligned (AAPCS64 5.2.2.1 sp-at-public-interface alignment).
const WIN_ARM64_GR_SAVE_BYTES: u32 = 64;

/// True when the function is a variadic c5 callee compiled for the
/// Windows-on-ARM64 host variadic ABI (Microsoft ARM64 calling
/// convention). Among the aarch64 targets, Windows is the only one
/// whose `Abi` sets `variadic_int_only` (macOS sets `variadic_on_stack`,
/// Linux sets neither), so this gate selects Windows aarch64 alone and
/// leaves the macOS host-stack variadic path and the Linux aarch64
/// register-save-area path untouched. Under this ABI the named and
/// variadic arguments share the integer register bank x0..x7 (a
/// variadic floating-point argument rides an integer register as its
/// raw bit pattern) then the incoming stack; the prologue spills x0..x7
/// into the gr-save area, `va_start` points at the first variadic slot,
/// and `va_arg` advances 8.
fn win_arm64_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
    debug_assert!(
        !abi.variadic_int_only || matches!(abi.arch, super::Arch::Aarch64 | super::Arch::X86_64),
        "variadic_int_only is a Windows (aarch64 or x86_64) property"
    );
    // The x86_64 `variadic_int_only` target (Win64) is lowered by the
    // x86_64 emit; this aarch64 emit only ever runs on an aarch64 abi,
    // so the arch check is a guard against a future cross-wired call.
    func.is_variadic && abi.variadic_int_only && matches!(abi.arch, super::Arch::Aarch64)
}

/// Bytes the AAPCS64 variadic register save area occupies (AAPCS64
/// Appendix B). The general register save area holds x0..x7 at
/// `[gr_save + 0 .. 64]` (8 registers * 8 bytes); the vector register
/// save area holds q0..q7 at `[vr_save + 0 .. 128]` (8 registers * 16
/// bytes), of which `va_arg` reads the low eightbyte of each slot for a
/// `double`. Both totals are 16-aligned (AAPCS64 5.2.2.1 sp-at-public-
/// interface alignment); the combined 192-byte area sits above the saved
/// fp/lr.
const AARCH64_GR_SAVE_BYTES: u32 = 8 * 8;
const AARCH64_VR_SAVE_BYTES: u32 = 8 * 16;
const AARCH64_VA_SAVE_BYTES: u32 = AARCH64_GR_SAVE_BYTES + AARCH64_VR_SAVE_BYTES;

/// True when the function is a variadic c5 callee compiled for the
/// AAPCS64 host variadic ABI (Linux aarch64). Among the aarch64 targets
/// macOS sets `variadic_on_stack` and Windows sets `variadic_int_only`;
/// the plain AAPCS64 target sets neither, so this gate selects Linux
/// aarch64 alone and leaves the macOS host-stack variadic path and the
/// Windows gr-save path byte for byte. Under this ABI the named and
/// variadic arguments arrive in the standard argument-register banks
/// (x0..x7 + d0..d7) then the incoming stack; the prologue spills both
/// banks into a register save area (AAPCS64 Appendix B), the named
/// parameters read from that area (`local_slot_off` redirect), `va_start`
/// initialises the `__va_list` offsets and pointers, and `va_arg` walks
/// the general area, vector area, then the overflow stack per `kind`.
fn aarch64_host_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
    func.is_variadic
        && matches!(abi.arch, super::Arch::Aarch64)
        && !abi.variadic_on_stack
        && !abi.variadic_int_only
}

/// True when the callee spills its named parameters into the c5 cdecl
/// cells through the generic per-parameter prologue path
/// (`plan_param_regs` placements, 16-byte cells, FP bank). Non-variadic
/// callees always do. The macOS arm64 variadic ABI (`variadic_on_stack`)
/// does too: its named arguments arrive in the int / FP register banks
/// and only the variadic tail rides the stack. The other two variadic
/// hosts read their named parameters elsewhere and are excluded here: the
/// Windows-on-ARM64 callee (`variadic_int_only`) spills the whole x0..x7
/// bank into a dedicated 8-byte-stride gr-save area, and the Linux
/// aarch64 callee (`aarch64_host_variadic`) spills the general / vector
/// register save area and reads its named parameters from it through the
/// `local_slot_off` redirect -- both in `emit_prologue`, not this path.
fn spills_named_params_on_entry(func: &FunctionSsa, abi: super::Abi) -> bool {
    !func.is_variadic || abi.variadic_on_stack
}

/// Per-parameter incoming-register placement from `plan_call_args`.
/// Indexed by declared parameter position. A variadic callee that reads
/// its named parameters outside the generic cell-spill path (Windows
/// arm64 and Linux aarch64) and zero-param callees yield an empty plan.
/// Independent int / FP argument-register banks (AAPCS64 6.4.1) mean an
/// FP parameter is placed in d0..d7 without shifting the integer bank.
fn param_placements(func: &FunctionSsa, abi: super::Abi) -> alloc::vec::Vec<super::ArgPlacement> {
    if !spills_named_params_on_entry(func, abi) || func.n_params == 0 {
        return alloc::vec::Vec::new();
    }
    super::ssa::emit_common::param_placements_common(func, abi)
}

/// `(n_reg, n_stack)` split of the declared parameters: how many land
/// in argument registers (integer or FP) and how many overflow to the
/// host stack. The c5 cdecl cell layout requires the register-passed
/// parameters to form a contiguous prefix; that holds whenever neither
/// argument-register bank is exhausted before a later parameter of the
/// other bank. TODO: a list that exhausts the integer bank before a
/// trailing floating-point parameter would interleave register and
/// stack placements; such lists are not yet lowered (the debug
/// assertion fires).
fn param_reg_stack_split(func: &FunctionSsa, abi: super::Abi) -> (usize, usize) {
    let placements = param_placements(func, abi);
    let n_reg = placements
        .iter()
        .filter(|p| !matches!(p, super::ArgPlacement::Stack(_)))
        .count();
    // The contiguous-prefix (n_reg, n_stack) split is well defined only
    // when every scalar Stack placement forms a suffix. Interleaved
    // lists take the position-indexed cell spill in `emit_prologue` and
    // never reach this split.
    debug_assert!(
        !params_interleaved(func, abi),
        "param_reg_stack_split called on an interleaved placement"
    );
    (n_reg, placements.len() - n_reg)
}

/// True when a scalar stack-passed parameter precedes a register-passed
/// one. AAPCS64's independent integer and FP register files (6.4.1) let
/// an HFA exhaust the eight FP registers (NSRN = 8) while the integer
/// file is still open, so a later integer parameter takes a register
/// after an earlier scalar floating-point parameter has overflowed to
/// the stack. The contiguous-prefix c5 cdecl cell layout cannot express
/// that order; the interleaved prologue writes each parameter into its
/// own position's cell instead.
fn params_interleaved(func: &FunctionSsa, abi: super::Abi) -> bool {
    let placements = param_placements(func, abi);
    let first_stack = placements
        .iter()
        .position(|p| matches!(p, super::ArgPlacement::Stack(_)));
    let last_non_stack = placements
        .iter()
        .rposition(|p| !matches!(p, super::ArgPlacement::Stack(_)));
    matches!((first_stack, last_non_stack), (Some(fs), Some(ln)) if fs < ln)
}

/// Total bytes the prologue allocates above the saved fp/lr for
/// c5 cdecl parameter slots plus the host-stack overflow stripe.
/// Mirrors the prologue's branch structure exactly:
///
/// * Variadic callees: the caller pushes 16-byte cells onto the
///   c5 bytecode stack; the callee's prologue allocates nothing.
/// * Non-variadic with `n_params <= int_arg_regs.len()`:
///   `n_reg * 16`, unless every register-passed parameter is
///   `ParamRef`-seeded with no address taken and no surviving
///   `Load/StoreLocal` -- then the entire register-spilled
///   stripe drops out and the count is 0.
/// * Non-variadic with `n_params > int_arg_regs.len()`: full
///   `n_params * 16` (the host-stack overflow restripe shifts
///   the slot offsets for every register-passed slot, so the
///   register stripe cannot be elided).
/// * Struct-returning callees (slot 2 = hidden out-pointer):
///   the walker excludes them from `ParamRef` synthesis, so
///   `seeded` is empty, `can_elide` is false, and the full
///   `n_params * 16` is returned.
fn prologue_param_spill_bytes(func: &FunctionSsa, alloc: &Allocation, abi: super::Abi) -> u32 {
    if !spills_named_params_on_entry(func, abi) {
        return 0;
    }
    let entry_spill = func.n_params;
    if entry_spill == 0 {
        return 0;
    }
    // Interleaved lists use one position-indexed cell per parameter; no
    // register-stripe elision (the rare shape does not warrant the
    // seeded-slot scan).
    if params_interleaved(func, abi) {
        return entry_spill as u32 * 16;
    }
    let (n_reg, n_stack) = param_reg_stack_split(func, abi);

    let (seeded, addr_taken, needed) = super::ssa::emit_common::scan_param_slot_usage(func, alloc);

    // Elision is safe only when the entire register-passed
    // stripe is skippable. Host-stack overflow shifts slot
    // offsets for every register-passed slot, so the register
    // stripe cannot be elided when n_stack > 0; the overflow
    // bytes themselves are always allocated.
    let can_elide_reg = n_stack == 0
        && (0..n_reg).all(|i| {
            let slot = (i as i64) + 2;
            seeded.contains(&(i as u32)) && !addr_taken.contains(&slot) && !needed.contains(&slot)
        });
    let reg_bytes = if can_elide_reg {
        0
    } else {
        (n_reg as u32) * 16
    };
    let overflow_bytes = (n_stack as u32) * 16;
    reg_bytes + overflow_bytes
}

/// A function that meets every condition to skip the standard
/// stp fp/lr / mov fp,sp / ldp prologue triple: no callee it
/// must save lr for, no frame to allocate, no param spill, no
/// callee-saved GPR / FPR / x19 to spill. The walker's c5
/// internal call (`Inst::Call`) leaves the link register at the
/// caller's value when no callee is invoked; AAPCS64's leaf
/// convention then lets the function ret directly off the
/// caller-supplied lr without saving it.
fn is_full_leaf(func: &FunctionSsa, frame: Frame, alloc: &Allocation) -> bool {
    if frame.frame_bytes != 0 || frame.param_spill_bytes != 0 || frame.uses_x19 {
        return false;
    }
    if !alloc.gpr_used.is_empty() || !alloc.fp_used.is_empty() {
        return false;
    }
    super::ssa::emit_common::function_makes_no_calls(func)
}

fn bail_msg(reason: &str) {
    super::ssa::emit_common::bail_msg("aarch64", reason);
}

fn bail(reason: &str, value: u32, place: Place) {
    #[cfg(feature = "codegen_test")]
    if std::env::var("BADC_DUMP_SSA").is_ok() {
        eprintln!(
            "ssa emit aarch64: bailed -- {reason} v{value} place={:?}",
            place
        );
    }
    let _ = (reason, value, place);
}

/// SP-relative byte offset of allocator spill `slot` in the
/// current function's frame. Thin wrapper over the cross-target
/// math helper so the per-call sites read as `spill_off(frame,
/// slot)` rather than the four-argument call.
fn spill_off(frame: Frame, slot: u32) -> u32 {
    super::ssa::emit_common::spill_slot_sp_offset(frame.frame_bytes, frame.alloc_spill_base, slot)
}

/// Largest byte displacement reachable by the scaled-imm12 unsigned-
/// offset form of `LDR`/`STR` for a given access size, per the
/// Arm Architecture Reference Manual C6.2 (load/store unsigned
/// immediate): the imm12 field holds `off / size` and is 12 bits, so
/// `off` ranges over `[0, 4095 * size]`. Beyond this the base address
/// must be materialised into a register. The frame's allocator spill
/// region can exceed this reach when a function spills heavily (one
/// 8-byte slot per spilled value), so every SP-relative spill access
/// routes through the helpers below rather than the raw encoders.
fn sp_imm12_in_range(off: u32, access_size: u32) -> bool {
    off.is_multiple_of(access_size) && (off / access_size) < 4096
}

/// Materialise `sp + off` into `dst`. Uses the shift-12 + remainder
/// split of `ADD (immediate)` (24-bit reach), which covers any frame
/// size the prologue itself can allocate.
fn emit_sp_plus_off(code: &mut Vec<u8>, dst: Reg, off: u32) {
    let hi = off & !0xfff;
    let lo = off & 0xfff;
    if hi != 0 {
        emit(
            code,
            super::encode::enc_add_imm_lsl12(dst, Reg(31), hi >> 12),
        );
        if lo != 0 {
            emit(code, enc_add_imm(dst, dst, lo));
        }
    } else {
        emit(code, enc_add_imm(dst, Reg(31), lo));
    }
}

/// Materialise `fp + off` into `dst` using the same shift-12 +
/// remainder split as `emit_sp_plus_off`, but based on fp (x29).
/// Used by the host-ABI variadic `va_start` to compute the
/// frame-relative address of the first variadic argument: the macOS
/// arm64 incoming-stack slot, or the Windows arm64 gr-save slot.
fn emit_sp_plus_off_from_fp(code: &mut Vec<u8>, dst: Reg, off: u32) {
    let hi = off & !0xfff;
    let lo = off & 0xfff;
    if hi != 0 {
        emit(
            code,
            super::encode::enc_add_imm_lsl12(dst, Reg(29), hi >> 12),
        );
        if lo != 0 {
            emit(code, enc_add_imm(dst, dst, lo));
        }
    } else {
        emit(code, enc_add_imm(dst, Reg(29), lo));
    }
}

/// SP-relative 8-byte load into `rt` with automatic out-of-reach
/// handling. When `off` exceeds the scaled-imm12 reach the address is
/// built into `rt` itself (the loaded value overwrites it), so no
/// extra scratch is consumed.
fn emit_sp_ldr_x(code: &mut Vec<u8>, rt: Reg, off: u32) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_ldr_imm(rt, Reg(31), off));
    } else {
        emit_sp_plus_off(code, rt, off);
        emit(code, enc_ldr_imm(rt, rt, 0));
    }
}

/// SP-relative 8-byte store of `rt`. A store needs the data and the
/// computed address in distinct registers, so `addr_scratch` (which
/// must differ from `rt`) carries the base when `off` is out of reach.
fn emit_sp_str_x(code: &mut Vec<u8>, rt: Reg, off: u32, addr_scratch: Reg) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_str_imm(rt, Reg(31), off));
    } else {
        debug_assert_ne!(rt.0, addr_scratch.0, "sp str: addr scratch aliases data");
        emit_sp_plus_off(code, addr_scratch, off);
        emit(code, enc_str_imm(rt, addr_scratch, 0));
    }
}

/// SP-relative 8-byte store of `rt`, picking an address scratch from
/// the IP pool that differs from the data register. Use at sites where
/// neither scratch is otherwise live across the store.
fn emit_sp_str_x_auto(code: &mut Vec<u8>, rt: Reg, off: u32) {
    let addr_scratch = if rt.0 == 16 { Reg(17) } else { Reg(16) };
    emit_sp_str_x(code, rt, off, addr_scratch);
}

/// SP-relative 8-byte store of `rt` at a site where no register other
/// than `rt` is free to carry the base. The borrowed register is saved
/// to the stack with a pre-index push, which shifts SP by 16; the
/// stored displacement is compensated so it still targets the original
/// slot. Used by the parallel-copy spill-to-spill path, where both IP
/// scratches may hold live cycle values.
fn emit_sp_str_x_borrow(code: &mut Vec<u8>, rt: Reg, off: u32, borrow: Reg) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_str_imm(rt, Reg(31), off));
        return;
    }
    debug_assert_ne!(rt.0, borrow.0, "sp str borrow: borrow aliases data");
    emit(code, super::encode::enc_str_pre(borrow, Reg(31), -16));
    emit_sp_plus_off(code, borrow, off + 16);
    emit(code, enc_str_imm(rt, borrow, 0));
    emit(code, super::encode::enc_ldr_post(borrow, Reg(31), 16));
}

/// SP-relative 8-byte FP load into d-reg `dt`. The base address is
/// built into `addr_scratch` (a GPR) when out of reach.
fn emit_sp_ldr_d(code: &mut Vec<u8>, dt: u8, off: u32, addr_scratch: Reg) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_ldr_d_imm(dt, Reg(31), off));
    } else {
        emit_sp_plus_off(code, addr_scratch, off);
        emit(code, enc_ldr_d_imm(dt, addr_scratch, 0));
    }
}

/// SP-relative 8-byte FP store of d-reg `dt`. `addr_scratch` carries
/// the base when out of reach.
fn emit_sp_str_d(code: &mut Vec<u8>, dt: u8, off: u32, addr_scratch: Reg) {
    if sp_imm12_in_range(off, 8) {
        emit(code, enc_str_d_imm(dt, Reg(31), off));
    } else {
        emit_sp_plus_off(code, addr_scratch, off);
        emit(code, enc_str_d_imm(dt, addr_scratch, 0));
    }
}

/// SP-relative 8-byte FP store using x16 as the address scratch. Use
/// at sites lowering an FP value, where the GPR scratch holds no live
/// int operand.
fn emit_sp_str_d_auto(code: &mut Vec<u8>, dt: u8, off: u32) {
    emit_sp_str_d(code, dt, off, Reg(16));
}

/// SP-relative 8-byte FP load using x16 as the address scratch.
fn emit_sp_ldr_d_auto(code: &mut Vec<u8>, dt: u8, off: u32) {
    emit_sp_ldr_d(code, dt, off, Reg(16));
}

/// Branch placeholder recorded mid-walk; resolved once every
/// block's start offset is known.
#[derive(Debug, Clone, Copy)]
struct BranchFixup {
    /// Byte offset in `code` of the placeholder instruction.
    site: usize,
    /// Target block in the function's `blocks` table.
    target: BlockId,
    kind: LocalBranchKind,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum LocalBranchKind {
    /// Unconditional B; `imm26` field, +/-128 MiB reach.
    B,
    /// CBZ Xt, label.
    Cbz(Reg),
    /// CBNZ Xt, label.
    Cbnz(Reg),
    /// B.cond label.
    Bcc(Cond),
}

/// Public entry point. Returns `true` when every block + inst +
/// terminator was lowered. Returns `false` (and leaves `code`
/// unchanged) when the function contains an op outside the
/// implemented subset; the caller falls back or aborts per
/// policy.
///
/// `fixups` is the function-pointer / direct-call fixup table the
/// surrounding writer already maintains. The SSA emit appends one
/// `Fixup::Bl` per `Inst::Call`; the `apply_fixups` post-pass
/// resolves them once `pc_to_native` is final.
#[allow(clippy::too_many_arguments)]
pub(crate) fn emit_function(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    cx: &mut super::ssa::emit_common::EmitCtx,
    fixups: &mut Vec<Fixup>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_tls_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    macho_tlv_fixups: &mut Vec<super::MachoTlvFixup>,
    macho_tlv_descriptors: &mut Vec<super::MachoTlvDescriptor>,
) -> bool {
    // The bundled emit output arrives in `cx`; recreate the per-field names as
    // disjoint reborrows so the body below (including the per-`Inst` `cx` it
    // rebuilds for `emit_inst`) is unchanged.
    let code = &mut *cx.code;
    let plt_call_fixups = &mut *cx.plt_call_fixups;
    let data_fixups = &mut *cx.data_fixups;
    let user_extern_data_refs = &mut *cx.user_extern_data_refs;
    let pending_func_fixups = &mut *cx.pending_func_fixups;
    let tls_index_fixups = &mut *cx.tls_index_fixups;
    let elf_tpoff_fixups = &mut *cx.elf_tpoff_fixups;
    let ssa_line_rows = &mut *cx.ssa_line_rows;
    let pc_to_native = &mut *cx.pc_to_native;
    let prologue_native = &mut *cx.prologue_native;
    let abi = target.abi();
    let frame = compute_frame(func, alloc, abi, target);
    let scratch = ScratchPool::new();
    let snapshot = code.len();
    // Snapshot every fixup vector at function entry so a partial
    // emit can be rolled back cleanly. Without this, a bailed SSA
    // emit leaves queued fixups pointing into the truncated code
    // region and the caller's surrounding pass would patch later
    // code with the wrong offsets.
    let fixups_snapshot = fixups.len();
    let plt_call_fixups_snapshot = plt_call_fixups.len();
    let data_fixups_snapshot = data_fixups.len();
    let user_extern_data_refs_snapshot = user_extern_data_refs.len();
    let pending_func_fixups_snapshot = pending_func_fixups.len();
    let tls_index_fixups_snapshot = tls_index_fixups.len();
    let macho_tlv_fixups_snapshot = macho_tlv_fixups.len();
    let macho_tlv_descriptors_snapshot = macho_tlv_descriptors.len();
    let elf_tpoff_snapshot = elf_tpoff_fixups.len();

    emit_prologue(code, func, alloc, frame, abi);
    super::ssa::emit_common::record_post_prologue_pc(func, prologue_native, code.len());

    // Per-parameter incoming-register plan; consumed by the per-inst
    // `Inst::ParamRef` lowering to source each parameter from its
    // integer / FP argument register.
    let emit_param_plan = param_placements(func, abi);

    // Place the entry `Inst::ParamRef` values from their AAPCS64
    // argument registers into the allocator's chosen locations. The
    // per-inst `mov dst, arg_reg` is unsound when one parameter's
    // destination register is a later parameter's source argument
    // register: the move clobbers that source before it is read. The
    // placement is a parallel copy from the (distinct) argument
    // registers to the parameter homes exactly when those homes are
    // distinct -- then `schedule_place_moves` sequentializes it and
    // breaks any cycle through a scratch register. When two ParamRef
    // values share a home (sequentially-live parameters the allocator
    // packed into one register) the move set is not a permutation, so
    // the batch is skipped and each ParamRef is placed in program order.
    // That per-inst path is safe only while no parameter's home is a
    // later parameter's incoming register; the allocator's ParamRef
    // self-home hint keeps it so (each integer parameter prefers its own
    // incoming register, and those are distinct). The
    // `param-shuffle-clobber` check in `verify_allocation` guards the
    // invariant under the `codegen_test` feature.
    let mut param_prebatched: Vec<bool> = alloc::vec![false; func.insts.len()];
    {
        // Each integer parameter's incoming register comes from the
        // plan, not `int_arg_regs[i]`: an FP parameter earlier in the
        // list consumes a d-register and does not shift the integer
        // bank, so the i-th declared parameter is not the i-th integer
        // register.
        let param_plan = param_placements(func, abi);
        let mut moves: Vec<(Place, Place)> = Vec::new();
        let mut exts: Vec<(Place, LoadKind)> = Vec::new();
        let mut vids: Vec<usize> = Vec::new();
        let mut homes: Vec<Place> = Vec::new();
        for (vid, inst) in func.insts.iter().enumerate() {
            let Inst::ParamRef { idx, kind } = inst else {
                continue;
            };
            let i = *idx as usize;
            // A ParamRef with no consumers is dropped by the per-inst
            // dead-code skip; placing it here would only risk bailing
            // the batch on an unused FP parameter. Only integer / spill
            // homes are scheduled as a parallel copy; an FP-register
            // home (a floating-point parameter) stays on the per-inst
            // path.
            if super::ssa::emit_common::is_dead_pure(inst, vid as super::super::ir::ValueId, alloc)
            {
                continue;
            }
            let dst = alloc.places.get(vid).copied().unwrap_or(Place::None);
            if !matches!(dst, Place::IntReg(_) | Place::Spill(_)) {
                continue;
            }
            // An integer-dst ParamRef is always an integer parameter;
            // read its source integer register from the plan. A
            // stack-passed integer parameter has no register source and
            // stays on the per-inst home-cell path.
            let Some(super::ArgPlacement::IntReg(src)) = param_plan.get(i).copied() else {
                continue;
            };
            moves.push((Place::IntReg(src), dst));
            vids.push(vid);
            homes.push(dst);
            // The caller passes the raw 64-bit value; the callee
            // performs the C99 6.5.2.2p4 conversion. An I8/I16 extend
            // rewrites bits 8..63 / 16..63 and is always required; an
            // I32 extend touches only bits 32..63 and is skipped when
            // no consumer reads them (`high_observed` tracks exactly
            // that range).
            if matches!(kind, LoadKind::I8 | LoadKind::I16)
                || (matches!(kind, LoadKind::I32)
                    && alloc.high_observed.get(vid).copied().unwrap_or(true))
            {
                exts.push((dst, *kind));
            }
        }
        let homes_distinct = (0..homes.len())
            .all(|a| ((a + 1)..homes.len()).all(|b| !place_same_loc(homes[a], homes[b])));
        if !moves.is_empty() && homes_distinct {
            if !schedule_place_moves(code, &mut moves, frame, scratch.primary, scratch.secondary) {
                return false;
            }
            for (dst, kind) in exts {
                let ext = |code: &mut Vec<u8>, r: Reg| match kind {
                    LoadKind::I8 => emit(code, super::encode::enc_sxtb(r, r)),
                    LoadKind::I16 => emit(code, super::encode::enc_sxth(r, r)),
                    LoadKind::I32 => emit(code, super::encode::enc_sxtw(r, r)),
                    _ => {}
                };
                match dst {
                    Place::IntReg(r) => ext(code, Reg(r)),
                    Place::Spill(slot) => {
                        let sp_off = spill_off(frame, slot);
                        emit_sp_ldr_x(code, scratch.primary, sp_off);
                        ext(code, scratch.primary);
                        emit_sp_str_x(code, scratch.primary, sp_off, scratch.secondary);
                    }
                    Place::None | Place::FpReg(_) => {}
                }
            }
            for vid in vids {
                param_prebatched[vid] = true;
            }
        }
    }

    // Floating-point parameters: the same parallel-copy hazard applies in
    // the FP bank when one parameter's home d-register is a later
    // parameter's incoming argument register -- the per-inst `fmov dst,
    // arg` then clobbers that source before it is read. Schedule the FP
    // parameters as an FP parallel copy with d16 / d17 cycle-breaking
    // (mirroring the integer batch); the per-inst path handles any not
    // placed here (stack-passed, dead, or a non-permutation home set).
    {
        let param_plan = param_placements(func, abi);
        let mut fp_moves: Vec<(Place, Place)> = Vec::new();
        let mut fp_vids: Vec<usize> = Vec::new();
        let mut fp_homes: Vec<Place> = Vec::new();
        for (vid, inst) in func.insts.iter().enumerate() {
            let Inst::ParamRef { idx, kind } = inst else {
                continue;
            };
            if !matches!(kind, LoadKind::F32 | LoadKind::F64) {
                continue;
            }
            if super::ssa::emit_common::is_dead_pure(inst, vid as super::super::ir::ValueId, alloc)
            {
                continue;
            }
            let dst = alloc.places.get(vid).copied().unwrap_or(Place::None);
            if !matches!(dst, Place::FpReg(_) | Place::Spill(_)) {
                continue;
            }
            let i = *idx as usize;
            let Some(super::ArgPlacement::FpReg(src)) = param_plan.get(i).copied() else {
                continue;
            };
            fp_moves.push((Place::FpReg(src), dst));
            fp_vids.push(vid);
            fp_homes.push(dst);
        }
        let homes_distinct = (0..fp_homes.len())
            .all(|a| ((a + 1)..fp_homes.len()).all(|b| !place_same_loc(fp_homes[a], fp_homes[b])));
        if !fp_moves.is_empty() && homes_distinct {
            super::ssa::emit_common::schedule_fp_place_moves(
                &super::ssa::emit_common::Aarch64Backend,
                code,
                &mut fp_moves,
                frame,
                17,
                16,
            );
            for vid in fp_vids {
                param_prebatched[vid] = true;
            }
        }
    }

    let mut block_offsets: Vec<usize> = alloc::vec![0; func.blocks.len()];
    let mut branch_fixups: Vec<BranchFixup> = Vec::new();
    // GCC `&&label`: each `Inst::BlockAddr` emits an `ADR rd, .`
    // placeholder; `(site, target_block, rd)` is resolved against the
    // final `block_offsets` once every block has been laid out.
    let mut block_addr_fixups: Vec<(usize, BlockId, Reg)> = Vec::new();
    // Per-function alloca bookkeeping. Set by `Inst::AllocaInit`
    // and read by `Inst::Intrinsic { kind: Alloca }`; zero
    // means the function doesn't use alloca.
    let mut current_alloca_top: u32 = 0;

    for (block_idx, block) in func.blocks.iter().enumerate() {
        block_offsets[block_idx] = code.len();
        super::ssa::emit_common::record_block_start_pc(
            block_idx,
            block.start_pc,
            pc_to_native,
            code.len(),
        );
        for v in block.inst_range.clone() {
            let inst = &func.insts[v as usize];
            let place = alloc.places.get(v as usize).copied().unwrap_or(Place::None);
            // Skip pure insts whose value isn't consumed by any
            // other inst or terminator. Walker-side pattern folds
            // (LoadLocal, indexed-load) sometimes leave the
            // upstream `Add` / `BinopI` dead; the result
            // computation produces no machine code if no one
            // will read it.
            if super::ssa::emit_common::is_dead_pure(inst, v, alloc) {
                continue;
            }
            // ParamRef already placed by the entry parallel copy.
            if param_prebatched[v as usize] {
                continue;
            }
            super::ssa::emit_common::record_inst_src(func, v, code.len(), ssa_line_rows);
            // GCC `&&label`: materialize the block's address with a
            // PC-relative ADR. Handled here (not emit_inst) because the
            // fixup resolves against this function's local block_offsets
            // once every block is laid out -- walker IR leaves
            // block.start_pc at 0, so the pc_to_native path can't be used.
            if let Inst::BlockAddr(tb) = inst {
                let rd = match int_or_spill_scratch(place, &scratch) {
                    Some(r) => r,
                    None => {
                        bail("BlockAddr: dst not int reg / spill", v, place);
                        code.truncate(snapshot);
                        fixups.truncate(fixups_snapshot);
                        plt_call_fixups.truncate(plt_call_fixups_snapshot);
                        data_fixups.truncate(data_fixups_snapshot);
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        tls_index_fixups.truncate(tls_index_fixups_snapshot);
                        elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                        macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                        macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                        return false;
                    }
                };
                let adr_site = code.len();
                emit(code, enc_adr(rd, 0));
                block_addr_fixups.push((adr_site, *tb, rd));
                if let Place::Spill(slot) = place {
                    let sp_off = spill_off(frame, slot);
                    emit_sp_str_x_auto(code, rd, sp_off);
                }
                continue;
            }
            let data_fixups_pre_inst = data_fixups.len();
            let inst_ok = {
                let mut cx = super::ssa::emit_common::EmitCtx {
                    code: &mut *code,
                    plt_call_fixups: &mut *plt_call_fixups,
                    data_fixups: &mut *data_fixups,
                    user_extern_data_refs: &mut *user_extern_data_refs,
                    pending_func_fixups: &mut *pending_func_fixups,
                    tls_index_fixups: &mut *tls_index_fixups,
                    elf_tpoff_fixups: &mut *elf_tpoff_fixups,
                    ssa_line_rows: &mut *ssa_line_rows,
                    pc_to_native: &mut *pc_to_native,
                    prologue_native: &mut *prologue_native,
                };
                let fcx = FnCtx {
                    func,
                    alloc,
                    frame,
                    scratch: &scratch,
                    abi,
                    target,
                    imports,
                    variadic_targets,
                    extern_tls_names,
                    param_plan: &emit_param_plan,
                };
                emit_inst(
                    &mut cx,
                    inst,
                    v,
                    place,
                    &fcx,
                    fixups,
                    macho_tlv_fixups,
                    macho_tlv_descriptors,
                    &mut current_alloca_top,
                )
            };
            if !inst_ok {
                #[cfg(feature = "codegen_test")]
                if std::env::var("BADC_DUMP_SSA").is_ok() {
                    eprintln!(
                        "ssa emit: bailed on inst v{v}: {:?} (place {:?})",
                        inst, place,
                    );
                }
                code.truncate(snapshot);
                fixups.truncate(fixups_snapshot);
                plt_call_fixups.truncate(plt_call_fixups_snapshot);
                data_fixups.truncate(data_fixups_snapshot);
                user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                pending_func_fixups.truncate(pending_func_fixups_snapshot);
                tls_index_fixups.truncate(tls_index_fixups_snapshot);
                elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                return false;
            }
            // Convert the just-emitted ImmData's local `.data`
            // fixup into a named cross-TU reference when the
            // value-id appears in `extern_data_names`. The walker
            // emits `Inst::ImmData(0)` for every
            // `imm_data_extern`; this hop replaces the unit-local
            // `DataFixup` (which would lower to `.data section
            // symbol + 0`) with a `UserExternDataRef` carrying
            // the symbol name, so the ET_REL writer emits a
            // named undefined-data symbol + a reloc against it.
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
            &scratch,
            frame,
        ) {
            code.truncate(snapshot);
            fixups.truncate(fixups_snapshot);
            plt_call_fixups.truncate(plt_call_fixups_snapshot);
            data_fixups.truncate(data_fixups_snapshot);
            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
            pending_func_fixups.truncate(pending_func_fixups_snapshot);
            tls_index_fixups.truncate(tls_index_fixups_snapshot);
            elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
            return false;
        }
        match block.terminator {
            Terminator::Return(v) => emit_return(code, v, alloc, frame, &scratch, func, abi),
            Terminator::Jmp(t) => {
                // Fall through when the target is the next block in
                // layout rather than emitting a branch to it.
                if t as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target: t,
                        kind: LocalBranchKind::B,
                    });
                    emit(code, enc_b(0));
                }
            }
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => {
                if let Some(bcc) = fused_branch_cond(func, alloc, cond, /* negate */ true) {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target,
                        kind: LocalBranchKind::Bcc(bcc),
                    });
                    emit(code, enc_b_cond(bcc, 0));
                    if fall_through as usize != block_idx + 1 {
                        branch_fixups.push(BranchFixup {
                            site: code.len(),
                            target: fall_through,
                            kind: LocalBranchKind::B,
                        });
                        emit(code, enc_b(0));
                    }
                    continue;
                }
                let cond_place = alloc
                    .places
                    .get(cond as usize)
                    .copied()
                    .unwrap_or(Place::None);
                // The c5 conditional-branch ops treat the
                // accumulator as a 64-bit bit pattern: zero
                // branches Bz, anything else branches Bnz. An
                // FpReg-placed cond carries an f64 in d-reg
                // form; bridge it through `fmov x, d` so the
                // CBZ/CBNZ has an integer to compare on the
                // raw bit pattern.
                let rt = if let Place::FpReg(dr) = cond_place {
                    emit(code, enc_fmov_d_to_x(scratch.primary, dr));
                    scratch.primary
                } else {
                    match materialize_int(code, cond_place, scratch.primary, frame) {
                        Some(r) => r,
                        None => {
                            bail("Bz/Bnz: cond Place not int", cond, cond_place);
                            code.truncate(snapshot);
                            fixups.truncate(fixups_snapshot);
                            plt_call_fixups.truncate(plt_call_fixups_snapshot);
                            data_fixups.truncate(data_fixups_snapshot);
                            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                            pending_func_fixups.truncate(pending_func_fixups_snapshot);
                            tls_index_fixups.truncate(tls_index_fixups_snapshot);
                            elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                            return false;
                        }
                    }
                };
                branch_fixups.push(BranchFixup {
                    site: code.len(),
                    target,
                    kind: LocalBranchKind::Cbz(rt),
                });
                emit(code, enc_cbz(rt, 0));
                if fall_through as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target: fall_through,
                        kind: LocalBranchKind::B,
                    });
                    emit(code, enc_b(0));
                }
            }
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => {
                if let Some(bcc) = fused_branch_cond(func, alloc, cond, /* negate */ false) {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target,
                        kind: LocalBranchKind::Bcc(bcc),
                    });
                    emit(code, enc_b_cond(bcc, 0));
                    if fall_through as usize != block_idx + 1 {
                        branch_fixups.push(BranchFixup {
                            site: code.len(),
                            target: fall_through,
                            kind: LocalBranchKind::B,
                        });
                        emit(code, enc_b(0));
                    }
                    continue;
                }
                let cond_place = alloc
                    .places
                    .get(cond as usize)
                    .copied()
                    .unwrap_or(Place::None);
                // The c5 conditional-branch ops treat the
                // accumulator as a 64-bit bit pattern: zero
                // branches Bz, anything else branches Bnz. An
                // FpReg-placed cond carries an f64 in d-reg
                // form; bridge it through `fmov x, d` so the
                // CBZ/CBNZ has an integer to compare on the
                // raw bit pattern.
                let rt = if let Place::FpReg(dr) = cond_place {
                    emit(code, enc_fmov_d_to_x(scratch.primary, dr));
                    scratch.primary
                } else {
                    match materialize_int(code, cond_place, scratch.primary, frame) {
                        Some(r) => r,
                        None => {
                            bail("Bz/Bnz: cond Place not int", cond, cond_place);
                            code.truncate(snapshot);
                            fixups.truncate(fixups_snapshot);
                            plt_call_fixups.truncate(plt_call_fixups_snapshot);
                            data_fixups.truncate(data_fixups_snapshot);
                            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                            pending_func_fixups.truncate(pending_func_fixups_snapshot);
                            tls_index_fixups.truncate(tls_index_fixups_snapshot);
                            elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                            return false;
                        }
                    }
                };
                branch_fixups.push(BranchFixup {
                    site: code.len(),
                    target,
                    kind: LocalBranchKind::Cbnz(rt),
                });
                emit(code, enc_cbnz(rt, 0));
                if fall_through as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target: fall_through,
                        kind: LocalBranchKind::B,
                    });
                    emit(code, enc_b(0));
                }
            }
            Terminator::FallThrough(t) => {
                if t as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target: t,
                        kind: LocalBranchKind::B,
                    });
                    emit(code, enc_b(0));
                }
            }
            Terminator::GotoIndirect { target } => {
                // GCC computed goto: branch to the code address in
                // `target` (materialized by Inst::BlockAddr). Move it
                // into a register and `br`.
                let tplace = alloc
                    .places
                    .get(target as usize)
                    .copied()
                    .unwrap_or(Place::None);
                let rt = match materialize_int(code, tplace, scratch.primary, frame) {
                    Some(r) => r,
                    None => {
                        bail("GotoIndirect: target Place not int", target, tplace);
                        code.truncate(snapshot);
                        fixups.truncate(fixups_snapshot);
                        plt_call_fixups.truncate(plt_call_fixups_snapshot);
                        data_fixups.truncate(data_fixups_snapshot);
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        tls_index_fixups.truncate(tls_index_fixups_snapshot);
                        elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                        macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                        macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                        return false;
                    }
                };
                emit(code, enc_br(rt));
            }
            Terminator::TailExt(binding_idx) => {
                // Tail-jump through the GOT-patched trampoline:
                // `adrp x16, _ ; ldr x16, [x16, _] ; br x16`.
                // The writer fills the adrp / ldr immediates once
                // the trampoline target's RVA is final.
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
                        tls_index_fixups.truncate(tls_index_fixups_snapshot);
                        elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                        macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                        macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                        return false;
                    }
                };
                super::encode::emit_got_tail_jump(code, plt_call_fixups, import_index);
            }
        }
    }
    // Patch each `&&label` ADR against its block's final offset.
    for (site, target_block, rd) in &block_addr_fixups {
        let target_off = block_offsets[*target_block as usize] as i64;
        let rel = target_off - *site as i64;
        // ADR has a signed 21-bit byte immediate (+/-1 MiB).
        if !(-(1 << 20)..(1 << 20)).contains(&rel) {
            bail_msg("BlockAddr: ADR target out of +/-1MiB range");
            code.truncate(snapshot);
            fixups.truncate(fixups_snapshot);
            plt_call_fixups.truncate(plt_call_fixups_snapshot);
            data_fixups.truncate(data_fixups_snapshot);
            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
            pending_func_fixups.truncate(pending_func_fixups_snapshot);
            tls_index_fixups.truncate(tls_index_fixups_snapshot);
            elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
            return false;
        }
        let word = enc_adr(*rd, rel as i32);
        code[*site..*site + 4].copy_from_slice(&word.to_le_bytes());
    }
    // Patch the recorded branches.
    for fx in &branch_fixups {
        let target_off = block_offsets[fx.target as usize];
        let rel = (target_off as i64) - (fx.site as i64);
        if rel % 4 != 0 {
            bail_msg("branch fixup: rel not 4-aligned");
            code.truncate(snapshot);
            fixups.truncate(fixups_snapshot);
            plt_call_fixups.truncate(plt_call_fixups_snapshot);
            data_fixups.truncate(data_fixups_snapshot);
            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
            pending_func_fixups.truncate(pending_func_fixups_snapshot);
            tls_index_fixups.truncate(tls_index_fixups_snapshot);
            elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
            return false;
        }
        let imm = (rel / 4) as i32;
        let word = match fx.kind {
            LocalBranchKind::B => {
                if !(-(1 << 25)..(1 << 25)).contains(&imm) {
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
                enc_b(imm)
            }
            LocalBranchKind::Cbz(rt) => {
                if !(-(1 << 18)..(1 << 18)).contains(&imm) {
                    bail_msg("branch fixup: imm19 out of range");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
                enc_cbz(rt, imm)
            }
            LocalBranchKind::Cbnz(rt) => {
                if !(-(1 << 18)..(1 << 18)).contains(&imm) {
                    bail_msg("branch fixup: imm19 out of range");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
                enc_cbnz(rt, imm)
            }
            LocalBranchKind::Bcc(cond) => {
                if !(-(1 << 18)..(1 << 18)).contains(&imm) {
                    bail_msg("branch fixup: imm19 out of range");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
                enc_b_cond(cond, imm)
            }
        };
        let bytes = word.to_le_bytes();
        code[fx.site..fx.site + 4].copy_from_slice(&bytes);
    }
    true
}

/// Per-function scratch register reservation. AAPCS64 calls x16
/// (IP0) and x17 (IP1) scratch; the SSA emit uses them for
/// reload / store sequences without recording them on the
/// allocator's `gpr_used` list.
struct ScratchPool {
    primary: Reg,
    secondary: Reg,
}

/// FP scratch d-registers for reloading spilled / int-carried FP
/// operands. The allocator's FP pool is d0..d15, so d16 / d17 are
/// never assigned to a value; an int-to-FP `fmov` into one cannot
/// clobber an operand the same instruction still reads. They are
/// AAPCS64 caller-saved, used only within a single instruction's
/// lowering, so they need no prologue save.
const SCRATCH_FP0: u8 = 16;
const SCRATCH_FP1: u8 = 17;
/// Third FP scratch for the three-input fused multiply-add. d18 sits
/// outside the allocator's d0..d15 pool, like d16 / d17.
const SCRATCH_FP2: u8 = 18;

impl ScratchPool {
    fn new() -> Self {
        Self {
            primary: Reg(16),
            secondary: Reg(17),
        }
    }
}

/// Allocate `bytes` of stack frame. On the Windows targets a frame
/// larger than one page is page-walked in descending order, touching
/// each page so the guard page commits the next before the frame reaches
/// it; a single subtract that skips the guard page faults on the first
/// access. SysV / macOS grow the stack on demand and allocate with one
/// subtract. `counter` is a scratch register the prologue does not need
/// across the allocation.
fn emit_stack_alloc(code: &mut Vec<u8>, bytes: u32, abi: super::Abi, counter: Reg) {
    const PAGE: u32 = 4096;
    if !abi.stack_probe || bytes < PAGE {
        emit_sub_sp_imm(code, bytes);
        return;
    }
    let n_pages = bytes >> 12;
    let remainder = bytes & 0xfff;
    super::encode::load_imm64(code, counter, n_pages as u64);
    // loop: sub sp, sp, #PAGE; str counter, [sp]; subs counter, #1; b.ne loop
    let loop_start = code.len();
    emit(code, super::encode::enc_sub_imm_lsl12(Reg::SP, Reg::SP, 1));
    emit(code, super::encode::enc_str_imm(counter, Reg::SP, 0));
    emit(code, super::encode::enc_subs_imm(counter, counter, 1));
    let off = ((loop_start as i64) - (code.len() as i64)) / 4;
    emit(
        code,
        super::encode::enc_b_cond(super::encode::Cond::Ne, off as i32),
    );
    if remainder != 0 {
        emit(
            code,
            super::encode::enc_sub_imm(Reg::SP, Reg::SP, remainder),
        );
    }
}

/// Emit the function prologue.
fn emit_prologue(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
) {
    // Windows-on-ARM64 variadic gr-save area (Microsoft ARM64 calling
    // convention). The caller passes the first eight arguments (named
    // and variadic) in x0..x7 by position and the rest on the incoming
    // stack just above the call-site sp, with no shadow / home area
    // reserved. The callee allocates its own 64-byte gr-save area
    // directly above the saved fp/lr and spills all eight argument
    // registers into it, so the named parameters and the
    // register-resident variadic arguments form one contiguous
    // 8-byte-stride region whose top edge meets the incoming stack
    // overflow: `va_arg` walks the gr-save slots then crosses into the
    // stack arguments with no gap. The body reads its named parameters
    // through the same cells (`Frame::param_cell_stride` == 8).
    //
    // Spill ALL eight argument registers, not just the named ones: a
    // variadic argument that landed in a register (x{fixed}..x7) must
    // reach the gr-save area for `va_arg` to read it. The caller passes
    // every argument through the integer registers as a raw 8-byte
    // value (the walker widens variadic floating-point arguments to
    // double and passes `fp_arg_mask = 0` under `variadic_int_only`),
    // so the spill is uniformly integer; the body reads only the named
    // slots and the surplus stores feed `va_arg`.
    if win_arm64_variadic_callee(func, abi) {
        debug_assert_eq!(
            frame.param_spill_bytes, WIN_ARM64_GR_SAVE_BYTES,
            "win-arm64 variadic prologue must reserve the full gr-save area"
        );
        emit_sub_sp_imm(code, WIN_ARM64_GR_SAVE_BYTES);
        for (i, &r) in abi.int_arg_regs.iter().enumerate() {
            let off = (i as u32) * 8;
            emit(code, enc_str_imm(Reg(r), Reg(31), off));
        }
        // Standard frame below the gr-save area. A variadic callee is
        // never a full leaf (`param_spill_bytes != 0`), so the
        // stp / mov-fp pair always follows.
        emit(code, enc_stp_pre(Reg(29), Reg(30), Reg(31), -16));
        emit(code, enc_add_imm(Reg(29), Reg(31), 0));
        if frame.frame_bytes > 0 {
            emit_stack_alloc(code, frame.frame_bytes, abi, Reg(16));
        }
        emit_prologue_saved_regs(code, alloc, frame);
        return;
    }
    // AAPCS64 variadic register save area (AAPCS64 Appendix B). Reserve
    // 192 bytes above the saved fp/lr: the general register save area
    // (x0..x7) at `[fp + 16 .. fp + 80)` and the vector register save
    // area (q0..q7, low eightbyte used) at `[fp + 80 .. fp + 208)`. The
    // named parameters read their values from this area (`local_slot_off`
    // redirects positive c5 cdecl slots here) and `va_start` / `va_arg`
    // walk it for the variadic tail. The incoming stack overflow begins
    // immediately above the area at `[fp + 208 .. )` -- the value
    // `va_start` records as `__stack`.
    //
    // Spill ALL eight integer and eight vector argument registers, not
    // just the named ones: a variadic argument that landed in a register
    // (x{named_int}..x7 / d{named_fp}..d7) must reach the save area for
    // `va_arg` to read it. AAPCS64 has no caller-passed vector-count
    // (unlike System V's `al`), so the vector spill is unconditional.
    if aarch64_host_variadic_callee(func, abi) {
        debug_assert_eq!(
            frame.param_spill_bytes, AARCH64_VA_SAVE_BYTES,
            "aapcs64 variadic prologue must reserve the full register save area"
        );
        emit_sub_sp_imm(code, AARCH64_VA_SAVE_BYTES);
        for (i, &r) in abi.int_arg_regs.iter().enumerate() {
            emit(code, enc_str_imm(Reg(r), Reg(31), (i as u32) * 8));
        }
        for i in 0..8u32 {
            // `str dN, [sp, #gr_save + i*16]` -- the d-register view
            // stores the low eightbyte of vN into the slot start; a
            // `va_arg(double)` reads it back from the same offset.
            emit(
                code,
                enc_str_d_imm(i as u8, Reg(31), AARCH64_GR_SAVE_BYTES + i * 16),
            );
        }
        emit(code, enc_stp_pre(Reg(29), Reg(30), Reg(31), -16));
        emit(code, enc_add_imm(Reg(29), Reg(31), 0));
        if frame.frame_bytes > 0 {
            emit_stack_alloc(code, frame.frame_bytes, abi, Reg(16));
        }
        emit_prologue_saved_regs(code, alloc, frame);
        return;
    }
    // Host-arg-reg spill for non-variadic functions: spill each
    // declared int param into a 16-byte c5 cdecl slot above fp,
    // restripe any host-stack overflow into 16-byte slots.
    //
    // The total bytes this block allocates is computed once by
    // `prologue_param_spill_bytes` and stored on `frame`; the
    // epilogue reads it directly. Per-slot store-elision when
    // `Inst::ParamRef` seeded the slot saves the explicit store
    // but still allocates the 16-byte cell (replaced by a coalesced
    // `sub sp`) so the surrounding `LocalAddr` offsets stay stable.
    // When every register-passed parameter is ParamRef-seeded, has
    // no address taken, and has no surviving slot access, the
    // entire register stripe drops out (`frame.param_spill_bytes`
    // already reflects 0) and no instructions are emitted here.
    let entry_spill = if spills_named_params_on_entry(func, abi) {
        func.n_params
    } else {
        0
    };
    if entry_spill > 0 && frame.param_spill_bytes > 0 {
        if params_interleaved(func, abi) {
            emit_interleaved_param_cells(code, func, abi);
        } else {
            let (n_reg, n_stack) = param_reg_stack_split(func, abi);
            let placements = param_placements(func, abi);
            if n_stack > 0 {
                let overflow_bytes = (n_stack as u32) * 16;
                emit_sub_sp_imm(code, overflow_bytes);
                // Each scalar stack parameter's incoming offset is the
                // planner's placement offset, which accounts for any by-value
                // aggregate stack parameter (StructStack) that precedes it. A
                // plain index assumes an 8-byte stride and would read an
                // aggregate's bytes instead of the scalar.
                let mut slot_i = 0u32;
                for p in &placements {
                    if let super::ArgPlacement::Stack(off) = p {
                        let host_off = *off + overflow_bytes;
                        let c5_off = slot_i * 16;
                        emit(code, enc_ldr_imm(Reg(16), Reg(31), host_off));
                        emit(code, enc_str_imm(Reg(16), Reg(31), c5_off));
                        slot_i += 1;
                    }
                }
            }
            let (seeded_params, addr_taken_slots, needed_slots) =
                super::ssa::emit_common::scan_param_slot_usage(func, alloc);
            let mut pending_sub: u32 = 0;
            for i in (0..n_reg).rev() {
                let slot = (i as i64) + 2;
                let skip = seeded_params.contains(&(i as u32))
                    && !addr_taken_slots.contains(&slot)
                    && !needed_slots.contains(&slot);
                if skip {
                    pending_sub += 16;
                } else {
                    if pending_sub > 0 {
                        emit_sub_sp_imm(code, pending_sub);
                        pending_sub = 0;
                    }
                    // Source the incoming value from the parameter's
                    // argument register per the plan. An integer parameter's
                    // register is `plan.IntReg`, not `int_arg_regs[i]`: a
                    // floating-point parameter earlier in the list consumes
                    // a d-register and does not shift the integer bank. A
                    // floating-point parameter (always a `double` here -- a
                    // `float` parameter's positive cell is unobserved and
                    // elided) arrives in a d-register; move its bits into
                    // x16 and store them through the same 16-byte pre-
                    // decrement cell push the integer path uses.
                    match placements.get(i).copied() {
                        Some(super::ArgPlacement::FpReg(d)) => {
                            emit(code, enc_fmov_d_to_x(Reg(16), d));
                            emit(code, enc_str_pre(Reg(16), Reg(31), -16));
                        }
                        Some(super::ArgPlacement::IntReg(r)) => {
                            emit(code, enc_str_pre(Reg(r), Reg(31), -16))
                        }
                        // Aggregate parameter passed in registers: reserve
                        // its 16-byte cell here but leave the incoming
                        // argument registers untouched. The body reads the
                        // aggregate from a parser-reserved body local, not
                        // from this cell; `emit_struct_param_scatter` (run
                        // after the frame is established) stores the
                        // argument registers straight into that local. The
                        // cell is reserved only so the surrounding
                        // `LocalAddr` slot offsets stay stable.
                        Some(super::ArgPlacement::StructRegs { .. }) => {
                            emit_sub_sp_imm(code, 16);
                        }
                        // No register source (stack-passed or out of range):
                        // the overflow restripe above already filled the
                        // cell; reserve its 16 bytes without a store.
                        _ => emit_sub_sp_imm(code, 16),
                    }
                }
            }
            if pending_sub > 0 {
                emit_sub_sp_imm(code, pending_sub);
            }
        }
    }
    // Leaf-function elision: a function that makes no calls
    // (lr stays preserved), allocates no frame, spills no params,
    // saves no callee-regs, and never sets x19 has no work in the
    // standard prologue. AAPCS64 lets it skip the stp / mov-fp
    // pair entirely and ret directly off the caller's lr.
    if is_full_leaf(func, frame, alloc) {
        return;
    }
    // Standard frame: stp fp/lr; mov fp, sp; sub sp, sp, frame_bytes.
    emit(code, enc_stp_pre(Reg(29), Reg(30), Reg(31), -16));
    emit(code, enc_add_imm(Reg(29), Reg(31), 0));
    if frame.frame_bytes > 0 {
        emit_stack_alloc(code, frame.frame_bytes, abi, Reg(16));
    }
    emit_prologue_saved_regs(code, alloc, frame);
    emit_struct_param_scatter(code, func, abi, frame);
    if func.indirect_result_slot != 0 {
        // AAPCS64 6.9: save the caller-supplied x8 indirect-result
        // pointer into its body local; `return s;` writes the
        // aggregate result through it.
        emit_local_addr(code, Place::IntReg(16), func.indirect_result_slot, frame);
        emit(code, enc_str_imm(Reg(8), Reg(16), 0));
    }
}

/// Position-indexed parameter cell spill for an interleaved register /
/// stack placement (`params_interleaved`). Allocates one 16-byte cell
/// per declared parameter in a single block, then writes each scalar
/// parameter into the cell for its own position: an integer register
/// stores directly, an FP register routes its bits through x16, a
/// stack-passed scalar copies from the incoming overflow slot just
/// above the cell block. Aggregate parameters get a reserved cell and
/// are filled from their argument registers / incoming stack slot by
/// `emit_struct_param_scatter` once the frame is established; x16 is the
/// only scratch, so no argument register that scatter still needs is
/// disturbed. The single up-front allocation keeps every parameter's
/// cell at `[fp + 16 + position*16]`, matching `local_slot_off`, which
/// the two-phase contiguous-prefix layout cannot do for an interleaved
/// order.
fn emit_interleaved_param_cells(code: &mut Vec<u8>, func: &FunctionSsa, abi: super::Abi) {
    let placements = param_placements(func, abi);
    let cells = func.n_params as u32 * 16;
    emit_sub_sp_imm(code, cells);
    for (i, p) in placements.iter().enumerate() {
        let c5_off = (i as u32) * 16;
        match p {
            super::ArgPlacement::IntReg(r) => {
                emit(code, enc_str_imm(Reg(*r), Reg(31), c5_off));
            }
            super::ArgPlacement::FpReg(d) => {
                emit(code, enc_fmov_d_to_x(Reg(16), *d));
                emit(code, enc_str_imm(Reg(16), Reg(31), c5_off));
            }
            super::ArgPlacement::Stack(off) => {
                // The incoming overflow argument sits just above the
                // freshly allocated cell block.
                let host_off = cells + *off;
                emit(code, enc_ldr_imm(Reg(16), Reg(31), host_off));
                emit(code, enc_str_imm(Reg(16), Reg(31), c5_off));
            }
            // StructRegs / StructStack reserve their cell here and are
            // filled by `emit_struct_param_scatter`. By-reference
            // aggregate parameters are rejected upstream on AAPCS64, so
            // they do not reach this path.
            _ => {}
        }
    }
}

/// Store each register-passed aggregate parameter's incoming argument
/// registers into its parser-reserved body local. Runs after the
/// frame is established (fp set, frame allocated, callee saves done)
/// so the body local's fp-relative address is valid; the argument
/// registers (x0..x7 / d0..d7) still hold the caller-supplied values
/// at this point, as nothing between the entry and here clobbers
/// them. The body reads the aggregate from this local, so the entry
/// 16-byte argument cell stays unused (the walker emits no entry copy
/// for a tagged aggregate parameter).
fn emit_struct_param_scatter(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    abi: super::Abi,
    frame: Frame,
) {
    if func.param_aggs.iter().all(Option::is_none) {
        return;
    }
    let placements = param_placements(func, abi);
    for (i, agg) in func.param_aggs.iter().enumerate() {
        let Some(agg_idx) = agg else {
            continue;
        };
        let slot = func.param_local_slots.get(i).copied().unwrap_or(0);
        if slot >= 0 {
            continue;
        }
        match placements.get(i) {
            Some(super::ArgPlacement::StructRegs { regs, n }) => {
                // Materialise the body local's address into x16, then store
                // each unit from its argument register. An integer
                // eightbyte stores at offset 8k; an HFA member stores at
                // its own offset with its natural size (d-register for 8
                // bytes, s-register for 4). x16/x17 are never argument
                // registers, so the source `regs` are untouched.
                let hfa = super::abi_classify::hfa_member_layout(
                    &func.agg_descs[*agg_idx as usize].fields,
                );
                emit_local_addr(code, Place::IntReg(16), slot, frame);
                for (k, cr) in regs.iter().take(*n as usize).enumerate() {
                    if cr.is_fp {
                        let (off, msize) = hfa
                            .as_ref()
                            .and_then(|m| m.get(k).copied())
                            .unwrap_or(((k as u32) * 8, 8));
                        if msize == 8 {
                            emit(code, super::encode::enc_str_d_imm(cr.reg, Reg(16), off));
                        } else {
                            emit(code, super::encode::enc_str_s_imm(cr.reg, Reg(16), off));
                        }
                    } else {
                        emit(code, enc_str_imm(Reg(cr.reg), Reg(16), (k as u32) * 8));
                    }
                }
            }
            Some(super::ArgPlacement::StructStack { off, size }) => {
                // The aggregate spilled to the caller's stack argument
                // area, which sits above the saved fp/lr (16 bytes) and
                // the callee's c5 parameter cells (`param_spill_bytes`).
                // Copy its bytes from there into the body local the
                // parameter is read from; the cell reserved for this
                // parameter (param_reg_stack_split counts a StructStack as
                // a register slot, so a 16-byte cell is reserved) stays
                // unused. AAPCS64 5.4.2 rounds the stack slot up to 8
                // bytes; copy each whole eightbyte then a sub-eightbyte
                // tail. x17 is the value temp, fp the source base; x16 the
                // destination base, so no argument register is disturbed.
                let src = 16 + frame.param_spill_bytes + *off;
                let size = *size;
                debug_assert!(
                    src + size <= 4096 * 8,
                    "stack-arg offset beyond ldr imm12 reach"
                );
                emit_local_addr(code, Place::IntReg(16), slot, frame);
                let mut o = 0u32;
                while o + 8 <= size {
                    emit(code, enc_ldr_imm(Reg(17), Reg(29), src + o));
                    emit(code, enc_str_imm(Reg(17), Reg(16), o));
                    o += 8;
                }
                if o + 4 <= size {
                    emit(
                        code,
                        super::encode::enc_ldr32_imm(Reg(17), Reg(29), src + o),
                    );
                    emit(code, super::encode::enc_str32_imm(Reg(17), Reg(16), o));
                    o += 4;
                }
                if o + 2 <= size {
                    emit(code, super::encode::enc_ldrh_imm(Reg(17), Reg(29), src + o));
                    emit(code, super::encode::enc_strh_imm(Reg(17), Reg(16), o));
                    o += 2;
                }
                if o < size {
                    emit(code, super::encode::enc_ldrb_imm(Reg(17), Reg(29), src + o));
                    emit(code, super::encode::enc_strb_imm(Reg(17), Reg(16), o));
                }
            }
            _ => continue,
        }
    }
}

/// Save the allocator-reported callee-saved GPRs + FP regs at the
/// bottom of the frame. The saved-reg region sits just above sp; its
/// offsets are one slot per saved register, so the 12-bit scaled
/// immediate (range 0..32760 in multiples of 8) always covers them. The
/// allocator spill region, by contrast, can exceed that reach and is
/// addressed through the range-checked SP helpers. Using `stur` off fp
/// would silently truncate the 9-bit immediate for frames larger than
/// ~256 bytes. x19 is saved just past the allocator-saved gprs, but only
/// when the function clobbers it; the slot is reserved either way so the
/// surrounding offsets stay fixed.
fn emit_prologue_saved_regs(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame) {
    for (i, &r) in alloc.fp_used.iter().enumerate() {
        let off = (i as u32) * 8;
        emit(code, enc_str_d_imm(r, Reg(31), off));
    }
    let saved_fpr_bytes = super::ssa::emit_common::slots16(alloc.fp_used.len() as u32);
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = saved_fpr_bytes + (i as u32) * 8;
        emit(code, enc_str_imm(Reg(r), Reg(31), off));
    }
    if frame.uses_x19 {
        let saved_gpr_bytes = super::ssa::emit_common::slots16(alloc.gpr_used.len() as u32);
        let x19_save_off = saved_fpr_bytes + saved_gpr_bytes;
        emit(code, enc_str_imm(Reg(19), Reg(31), x19_save_off));
    }
}

/// Byte offset (positive) from fp to the start of the saved-reg
/// region. The region is the lowest portion of the frame.
fn alloc_save_base(frame: Frame, alloc: &Allocation) -> u32 {
    let saved_gpr_bytes = super::ssa::emit_common::slots16(alloc.gpr_used.len() as u32);
    let saved_fpr_bytes = super::ssa::emit_common::slots16(alloc.fp_used.len() as u32);
    // fp is at frame top; the saved-reg region sits at the
    // bottom. Distance from fp = frame_bytes - saved-region size.
    frame
        .frame_bytes
        .saturating_sub(saved_gpr_bytes + saved_fpr_bytes)
}

/// Return the aarch64 condition code to use for a `B.cond` when
/// `cond` was flagged as branch-fused by the allocator. `negate`
/// is true for `Bz` (branch when comparison failed); false for
/// `Bnz`. Returns `None` when fusion doesn't apply (caller falls
/// back to the unfused `cbz` / `cbnz` path).
fn fused_branch_cond(
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    cond: super::super::ir::ValueId,
    negate: bool,
) -> Option<super::encode::Cond> {
    use super::encode::Cond;
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
        BinOp::Eq => Cond::Eq,
        BinOp::Ne => Cond::Ne,
        BinOp::Lt => Cond::Lt,
        BinOp::Gt => Cond::Gt,
        BinOp::Le => Cond::Le,
        BinOp::Ge => Cond::Ge,
        BinOp::Ult => Cond::Lo,
        BinOp::Ugt => Cond::Hi,
        BinOp::Ule => Cond::Ls,
        BinOp::Uge => Cond::Hs,
        _ => return None,
    };
    if !negate {
        return Some(positive);
    }
    Some(match positive {
        Cond::Eq => Cond::Ne,
        Cond::Ne => Cond::Eq,
        Cond::Lt => Cond::Ge,
        Cond::Gt => Cond::Le,
        Cond::Le => Cond::Gt,
        Cond::Ge => Cond::Lt,
        Cond::Lo => Cond::Hs,
        Cond::Hi => Cond::Ls,
        Cond::Ls => Cond::Hi,
        Cond::Hs => Cond::Lo,
        _ => return None,
    })
}

/// Emit one SSA instruction. Returns `false` for any op the thin
/// slice doesn't handle yet so the caller can fall back.
#[allow(clippy::too_many_arguments)]
/// Read-only per-function context threaded through the per-instruction
/// lowering. Bundles the loop-invariant inputs so emit_inst's signature stays
/// short; Copy (references and small scalars).
#[derive(Clone, Copy)]
struct FnCtx<'a> {
    func: &'a FunctionSsa,
    alloc: &'a Allocation,
    frame: Frame,
    scratch: &'a ScratchPool,
    abi: super::Abi,
    target: Target,
    imports: &'a super::ResolvedImports,
    variadic_targets: &'a alloc::collections::BTreeSet<usize>,
    extern_tls_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    param_plan: &'a [super::ArgPlacement],
}

fn emit_inst(
    cx: &mut super::ssa::emit_common::EmitCtx,
    inst: &Inst,
    v: super::super::ir::ValueId,
    dst: Place,
    fcx: &FnCtx,
    fixups: &mut Vec<Fixup>,
    macho_tlv_fixups: &mut Vec<super::MachoTlvFixup>,
    macho_tlv_descriptors: &mut Vec<super::MachoTlvDescriptor>,
    current_alloca_top: &mut u32,
) -> bool {
    // Unpack the read-only per-function context into the per-field names the
    // lowering below uses, so the body is unchanged.
    let FnCtx {
        func,
        alloc,
        frame,
        scratch,
        abi,
        target,
        imports,
        variadic_targets,
        extern_tls_names,
        param_plan,
    } = *fcx;
    // The bundled emit output now arrives in `cx`; recreate the per-field
    // names as disjoint reborrows so the per-`Inst` lowering below is unchanged.
    let code = &mut *cx.code;
    let plt_call_fixups = &mut *cx.plt_call_fixups;
    let data_fixups = &mut *cx.data_fixups;
    let pending_func_fixups = &mut *cx.pending_func_fixups;
    let tls_index_fixups = &mut *cx.tls_index_fixups;
    let elf_tpoff_fixups = &mut *cx.elf_tpoff_fixups;
    match inst {
        Inst::AllocaInit(slot) => {
            // Slot 0: this function doesn't use alloca; emit
            // nothing (matches the pool path). Non-zero: the
            // bookkeeping slot lives at `[fp - slot*8]` and the
            // first alloca call subtracts from the value stored
            // there. Initialise the slot with its own address so
            // alloca(n) lands at `address - n`, the top of the
            // arena reserved by the prologue's local-slot count.
            if *slot == 0 {
                return true;
            }
            let top_offset = (*slot as u32) * 8;
            *current_alloca_top = top_offset;
            if top_offset < 4096 {
                emit(code, enc_sub_imm(Reg(16), Reg(29), top_offset));
            } else {
                let high = top_offset & !0xfff;
                let low = top_offset & 0xfff;
                emit(
                    code,
                    super::encode::enc_sub_imm_lsl12(Reg(16), Reg(29), high >> 12),
                );
                if low != 0 {
                    emit(code, enc_sub_imm(Reg(16), Reg(16), low));
                }
            }
            emit(code, enc_str_imm(Reg(16), Reg(16), 0));
            true
        }
        Inst::ParamRef { idx, kind } => {
            // Materialise the i-th AAPCS64 argument register into
            // the allocator's chosen `Place`, sign-extending the
            // low `kind` bytes per C99 6.3.1.3 so the value held
            // in the register is canonically 64-bit-sign-extended.
            // The prologue does not modify x0..x7 / d0..d7, so the
            // argument value is still in its incoming register at this
            // IR position. Narrow-load promotion downstream can then
            // collapse `Inst::Extend(ParamRef, kind)` to a plain copy
            // when the kinds match.
            let i = *idx as usize;
            // Floating-point parameter (C99 6.2.5p10): its value arrives
            // in a d-register named by the plan. Read that register into
            // the allocator's FP dst. A `float` (`LoadKind::F32`)
            // occupies the s-register view; the body re-narrows it
            // through the f32 store the walker seeded.
            if matches!(kind, LoadKind::F32 | LoadKind::F64) {
                let Some(super::ArgPlacement::FpReg(d)) = param_plan.get(i).copied() else {
                    bail_msg("ParamRef: FP param not in an FP argument register");
                    return false;
                };
                match dst {
                    Place::FpReg(r) => {
                        if r != d {
                            emit(code, super::encode::enc_fmov_d_d(r, d));
                        }
                    }
                    Place::Spill(slot) => {
                        let sp_off = spill_off(frame, slot);
                        emit_sp_str_d_auto(code, d, sp_off);
                    }
                    _ => {
                        bail_msg("ParamRef: FP param dst not fp reg / spill");
                        return false;
                    }
                }
                return true;
            }
            let Some(super::ArgPlacement::IntReg(arg_reg)) = param_plan.get(i).copied() else {
                bail_msg("ParamRef: int param not in an integer argument register");
                return false;
            };
            // The encoding to write `dst <- sign-extend(arg_reg)`.
            // For full-width kinds (I64), it is a plain mov. The
            // caller passes the raw 64-bit value, so an I8/I16
            // conversion always runs; an I32 extend touches only
            // bits 32..63 and is skipped when no consumer reads them.
            let high_dead = !alloc.high_observed.get(v as usize).copied().unwrap_or(true);
            let sign_extend = |code: &mut Vec<u8>, rd: Reg| {
                let rn = Reg(arg_reg);
                match kind {
                    LoadKind::I8 => emit(code, super::encode::enc_sxtb(rd, rn)),
                    LoadKind::I16 => emit(code, super::encode::enc_sxth(rd, rn)),
                    LoadKind::I32 if !high_dead => emit(code, super::encode::enc_sxtw(rd, rn)),
                    _ => emit_mov_reg(code, rd, rn),
                }
            };
            match dst {
                Place::IntReg(r) => sign_extend(code, Reg(r)),
                Place::Spill(slot) => {
                    sign_extend(code, scratch.primary);
                    let sp_off = spill_off(frame, slot);
                    emit_sp_str_x(code, scratch.primary, sp_off, scratch.secondary);
                }
                _ => {
                    bail_msg("ParamRef: dst not int reg / spill");
                    return false;
                }
            }
            true
        }
        Inst::Imm(value) => {
            let rd = match int_or_spill_scratch(dst, scratch) {
                Some(r) => r,
                None => return false,
            };
            load_imm64(code, rd, *value as u64);
            if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit_sp_str_x_auto(code, rd, sp_off);
            }
            true
        }
        Inst::ImmData(offset) => {
            let rd = match int_or_spill_scratch(dst, scratch) {
                Some(r) => r,
                None => return false,
            };
            // Encode `rd` in the adrp/add placeholder; the per-writer
            // `patch_adrp_add` reads rd back from the placeholder, so
            // the materialised address lands directly in the
            // allocator's chosen register.
            let adrp_offset = code.len();
            emit(code, enc_adrp(rd, 0));
            emit(code, enc_add_imm(rd, rd, 0));
            data_fixups.push(DataFixup {
                adrp_offset,
                data_offset: *offset as u64,
            });
            if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit_sp_str_x_auto(code, rd, sp_off);
            }
            true
        }
        Inst::ImmCode(target_ent_pc) => {
            let rd = match int_or_spill_scratch(dst, scratch) {
                Some(r) => r,
                None => return false,
            };
            let adrp_offset = code.len();
            emit(code, enc_adrp(rd, 0));
            emit(code, enc_add_imm(rd, rd, 0));
            pending_func_fixups.push((adrp_offset, *target_ent_pc));
            if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit_sp_str_x_auto(code, rd, sp_off);
            }
            true
        }
        Inst::ImmExtCode(binding_idx) => {
            // `adrp rd, page; add rd, rd, lo12` taking the address
            // of a dynamically-imported function. The pair resolves
            // to the import's shared stub via an `is_addr` PLT-call
            // fixup, so `&strcmp` yields the stub address.
            let rd = match int_or_spill_scratch(dst, scratch) {
                Some(r) => r,
                None => return false,
            };
            let import_index = match imports.index_of_binding(*binding_idx) {
                Some(i) => i,
                None => {
                    bail_msg("ImmExtCode: binding index has no resolved import");
                    return false;
                }
            };
            plt_call_fixups.push(super::encode::PltCallFixup {
                instr_offset: code.len(),
                import_index,
                is_tail: false,
                is_addr: true,
            });
            emit(code, enc_adrp(rd, 0));
            emit(code, enc_add_imm(rd, rd, 0));
            if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit_sp_str_x_auto(code, rd, sp_off);
            }
            true
        }
        // Inst::BlockAddr is handled in emit_function's block loop
        // (it needs the local block_offsets table for its PC-relative
        // fixup), so it never reaches emit_inst.
        Inst::LocalAddr(off) => emit_local_addr(code, dst, *off, frame),
        Inst::Load {
            addr, disp, kind, ..
        } => emit_load(
            code,
            dst,
            *addr,
            *disp,
            *kind,
            alloc.is_f32(v),
            alloc,
            frame,
            scratch,
        ),
        Inst::Store {
            addr,
            disp,
            value,
            kind,
            ..
        } => emit_store(
            code, dst, *addr, *disp, *value, *kind, alloc, frame, scratch,
        ),
        Inst::LoadLocal { off, kind, .. } => {
            emit_load_local(code, dst, *off, *kind, alloc.is_f32(v), frame, scratch)
        }
        Inst::StoreLocal {
            off, value, kind, ..
        } => emit_store_local(code, dst, *off, *value, *kind, alloc, frame, scratch),
        Inst::LoadIndexed {
            base,
            index,
            scale,
            kind,
        } => emit_load_indexed(
            code, dst, *base, *index, *scale, *kind, alloc, frame, scratch,
        ),
        Inst::StoreIndexed {
            base,
            index,
            scale,
            value,
            kind,
        } => emit_store_indexed(
            code, dst, *base, *index, *scale, *value, *kind, alloc, frame, scratch,
        ),
        Inst::Binop { op, lhs, rhs } => {
            emit_binop(code, *op, v, dst, *lhs, *rhs, alloc, frame, scratch)
        }
        Inst::BinopI { op, lhs, rhs_imm } => {
            emit_binop_imm(code, *op, v, dst, *lhs, *rhs_imm, alloc, frame, scratch)
        }
        Inst::Call {
            target_pc,
            args,
            fixed_args,
            fp_return,
            fp_arg_mask,
            arg_aggs,
            ret_agg,
            ret_slot_local,
            ..
        } => emit_call(
            code,
            dst,
            *target_pc,
            args,
            *fixed_args,
            alloc,
            frame,
            scratch,
            abi,
            fixups,
            variadic_targets.contains(target_pc),
            *fp_return,
            *fp_arg_mask,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
        ),
        Inst::CallExt {
            binding_idx,
            args,
            fp_arg_mask,
            arg_aggs,
            ret_agg,
            ret_slot_local,
            ..
        } => emit_call_ext(
            code,
            dst,
            *binding_idx,
            args,
            *fp_arg_mask,
            alloc,
            frame,
            scratch,
            abi,
            target,
            plt_call_fixups,
            imports,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
        ),
        Inst::CallIndirect {
            target,
            args,
            callee_variadic,
            fixed_args,
            fp_return,
            fp_arg_mask,
            arg_aggs,
            ret_agg,
            ret_slot_local,
            ..
        } => emit_call_indirect(
            code,
            dst,
            *target,
            args,
            *callee_variadic,
            *fixed_args,
            alloc,
            frame,
            scratch,
            abi,
            *fp_return,
            *fp_arg_mask,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
        ),
        Inst::Mcpy {
            dst: d,
            src: s,
            size,
        } => emit_mcpy(code, dst, *d, *s, *size, alloc, frame, scratch),
        Inst::AtomicRmw {
            op,
            addr,
            value,
            width,
        } => emit_atomic_rmw(code, dst, *op, *addr, *value, *width, alloc, frame, scratch),
        Inst::AtomicCas {
            addr,
            expected_addr,
            desired,
            width,
        } => emit_atomic_cas(
            code,
            dst,
            *addr,
            *expected_addr,
            *desired,
            *width,
            alloc,
            frame,
            scratch,
        ),
        Inst::Intrinsic { kind, args } => emit_intrinsic(
            code,
            func,
            abi,
            *kind,
            args,
            dst,
            v,
            alloc,
            frame,
            scratch,
            *current_alloca_top,
        ),
        Inst::Fneg(src) => {
            let src_place = alloc
                .places
                .get(*src as usize)
                .copied()
                .unwrap_or(Place::None);
            // C99 6.3.1.8: negation of a `float` is single-precision;
            // the result's f32 marker mirrors the operand's.
            let is_f32 = alloc.is_f32(v);
            let dn = match materialize_fp_for(code, *src, src_place, SCRATCH_FP0, frame, alloc) {
                Some(r) => r,
                None => return false,
            };
            let dd = match dst {
                Place::FpReg(r) => r,
                // Stage a spilled result through a reserved scratch
                // d-reg outside the allocator's d0..d15 pool; d0 may
                // hold a live value the caller still needs. The source
                // may already occupy SCRATCH_FP0, so use SCRATCH_FP1.
                Place::Spill(_) => SCRATCH_FP1,
                _ => return false,
            };
            if is_f32 {
                emit(code, super::encode::enc_fneg_s(dd, dn));
            } else {
                emit(code, enc_fneg_d(dd, dn));
            }
            if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit_sp_str_d_auto(code, dd, sp_off);
            }
            true
        }
        Inst::Fma {
            a,
            b,
            c,
            neg_product,
            neg_addend,
        } => {
            // C99 6.5p8 / FP_CONTRACT: the fused form rounds once. The
            // result width follows the operands; the marker mirrors `a`.
            let is_f32 = alloc.is_f32(v);
            let a_place = alloc
                .places
                .get(*a as usize)
                .copied()
                .unwrap_or(Place::None);
            let b_place = alloc
                .places
                .get(*b as usize)
                .copied()
                .unwrap_or(Place::None);
            let c_place = alloc
                .places
                .get(*c as usize)
                .copied()
                .unwrap_or(Place::None);
            // Each operand resolves to its own d-reg or, when spilled, a
            // dedicated scratch outside the d0..d15 pool (d16 / d17 / d18).
            let da = match materialize_fp_for(code, *a, a_place, SCRATCH_FP0, frame, alloc) {
                Some(r) => r,
                None => return false,
            };
            let dm = match materialize_fp_for(code, *b, b_place, SCRATCH_FP1, frame, alloc) {
                Some(r) => r,
                None => return false,
            };
            let dc = match materialize_fp_for(code, *c, c_place, SCRATCH_FP2, frame, alloc) {
                Some(r) => r,
                None => return false,
            };
            // A spilled result writes into SCRATCH_FP2 and stores after.
            // d18 is free unless `c` was itself spilled into it, in which
            // case the FMADD reads Da before writing Dd so the alias is
            // harmless. It must NOT reuse `dc` directly: when `c` lives
            // in an allocated register that register may hold a value
            // still needed by a later instruction (e.g. a loop-carried
            // operand reused as the addend across several fused ops).
            let dd = match dst {
                Place::FpReg(r) => r,
                Place::Spill(_) => SCRATCH_FP2,
                _ => return false,
            };
            emit(
                code,
                super::encode::enc_fma(dd, da, dm, dc, is_f32, *neg_product, *neg_addend),
            );
            if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit_sp_str_d_auto(code, dd, sp_off);
            }
            true
        }
        Inst::Extend { value, kind } => {
            emit_extend(code, dst, *value, *kind, alloc, frame, scratch)
        }
        Inst::FpCast { kind, value } => {
            use super::super::ir::FpCastKind;
            let src_place = alloc
                .places
                .get(*value as usize)
                .copied()
                .unwrap_or(Place::None);
            match kind {
                FpCastKind::IntToFp | FpCastKind::UIntToFp => {
                    let rn = match materialize_int(code, src_place, scratch.primary, frame) {
                        Some(r) => r,
                        None => return false,
                    };
                    let dd = match dst {
                        Place::FpReg(r) => r,
                        // Stage a spilled result through a reserved scratch
                        // d-reg outside the allocator's d0..d15 pool; d0
                        // may hold a live value the caller still needs.
                        Place::Spill(_) => SCRATCH_FP0,
                        _ => return false,
                    };
                    let enc = if matches!(kind, FpCastKind::UIntToFp) {
                        enc_ucvtf_d_x(dd, rn)
                    } else {
                        enc_scvtf_d_x(dd, rn)
                    };
                    emit(code, enc);
                    if let Place::Spill(slot) = dst {
                        let sp_off = spill_off(frame, slot);
                        emit_sp_str_d_auto(code, dd, sp_off);
                    }
                    true
                }
                FpCastKind::FpToInt | FpCastKind::UFpToInt => {
                    let dn = match materialize_fp(code, src_place, SCRATCH_FP0, frame) {
                        Some(r) => r,
                        None => return false,
                    };
                    let rd = match dst {
                        Place::IntReg(r) => Reg(r),
                        Place::Spill(_) => scratch.primary,
                        _ => return false,
                    };
                    let enc = if matches!(kind, FpCastKind::UFpToInt) {
                        enc_fcvtzu_x_d(rd, dn)
                    } else {
                        enc_fcvtzs_x_d(rd, dn)
                    };
                    emit(code, enc);
                    if let Place::Spill(slot) = dst {
                        let sp_off = spill_off(frame, slot);
                        emit_sp_str_x_auto(code, rd, sp_off);
                    }
                    true
                }
                // C99 6.3.1.5: widen single to double (`fcvt Dd, Sn`)
                // or narrow double to single (`fcvt Sd, Dn`). The
                // single-precision view occupies the low 32 bits of the
                // same physical V register, so the source f32 is read as
                // an s-reg and the f64 result written as a d-reg (and
                // vice versa) with no separate move.
                FpCastKind::F32ToF64 => {
                    let dn = match materialize_fp_f32(code, src_place, SCRATCH_FP0, frame) {
                        Some(r) => r,
                        None => return false,
                    };
                    let dd = match dst {
                        Place::FpReg(r) => r,
                        Place::Spill(_) => SCRATCH_FP0,
                        _ => return false,
                    };
                    emit(code, enc_fcvt_d_s(dd, dn));
                    if let Place::Spill(slot) = dst {
                        let sp_off = spill_off(frame, slot);
                        emit_sp_str_d_auto(code, dd, sp_off);
                    }
                    true
                }
                FpCastKind::F64ToF32 => {
                    let dn = match materialize_fp(code, src_place, SCRATCH_FP0, frame) {
                        Some(r) => r,
                        None => return false,
                    };
                    let dd = match dst {
                        Place::FpReg(r) => r,
                        Place::Spill(_) => SCRATCH_FP0,
                        _ => return false,
                    };
                    emit(code, enc_fcvt_s_d(dd, dn));
                    if let Place::Spill(slot) = dst {
                        let sp_off = spill_off(frame, slot);
                        emit_sp_str_d_auto(code, dd, sp_off);
                    }
                    true
                }
            }
        }
        Inst::TlsAddr(offset) => emit_tls_addr(
            code,
            dst,
            *offset,
            target,
            tls_index_fixups,
            macho_tlv_fixups,
            macho_tlv_descriptors,
            elf_tpoff_fixups,
            extern_tls_names.get(&v).map(|s| s.as_str()),
        ),
        Inst::Phi { .. } => {
            // The value is materialised by the predecessor-exit
            // moves emitted just before each branch terminator
            // that targets this block; at the IR position the
            // phi's allocated Place already holds the merged
            // value.
            true
        }
        _ => false,
    }
}

/// `Inst::TlsAddr` lowering. Routes through the per-target TLS
/// access shape -- Linux variant 1 (TPIDR_EL0 + tcb + offset),
/// Windows TEB->TLS slot via `_tls_index` and the per-thread
/// pointer table at `[x18, #0x58]`, or Apple's TLV descriptor
/// table with the bootstrap getter. The 12-bit add immediate
/// limit on the per-variable offset matches the pool path; any
/// `_Thread_local` larger than 4080 bytes from `.tdata` falls
/// back to the pool path through the false return.
#[allow(clippy::too_many_arguments)]
fn emit_tls_addr(
    code: &mut Vec<u8>,
    dst: Place,
    offset: i64,
    target: Target,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    macho_tlv_fixups: &mut Vec<super::MachoTlvFixup>,
    macho_tlv_descriptors: &mut Vec<super::MachoTlvDescriptor>,
    elf_tpoff_fixups: &mut Vec<super::ElfTpoffFixup>,
    // Set for a cross-unit `extern _Thread_local` access: the variable's
    // name. The descriptor is keyed by symbol (the linker resolves the
    // offset) rather than by the placeholder `offset`.
    tls_extern_sym: Option<&str>,
) -> bool {
    use super::encode::{enc_blr, enc_ldr_reg_lsl3, enc_mrs_tpidr_el0};
    let Some(rd) = int_reg(dst) else {
        bail_msg("TlsAddr: dst not int reg");
        return false;
    };
    match target {
        Target::LinuxAarch64 => {
            // AAPCS64 variant-1: the static TLS block sits above the thread
            // pointer after a 16-byte TCB reserve, so a variable at
            // `offset` in its unit's block reads `tp + 16 + offset`. A
            // unit-local access bakes that immediate; a cross-unit extern
            // emits the 16-byte reserve as a placeholder. Both record an
            // `elf_tpoff_fixups` entry so the linker rebases the immediate
            // when more than one unit contributes TLS storage (Local) or
            // resolves it by symbol (Extern). The 12-bit add immediate caps
            // a single unit's TLS at 4080 bytes; a wider block would need
            // the two-add tprel_hi12 / lo12 sequence (TODO).
            let imm = if tls_extern_sym.is_some() {
                16u32
            } else {
                (offset + 16) as u32
            };
            if imm >= 4096 {
                bail_msg("TlsAddr: tpoff exceeds 12-bit add immediate");
                return false;
            }
            emit(code, enc_mrs_tpidr_el0(rd));
            let add_off = code.len();
            emit(code, enc_add_imm(rd, rd, imm));
            elf_tpoff_fixups.push(super::ElfTpoffFixup {
                imm_offset: add_off,
                target: match tls_extern_sym {
                    Some(name) => super::ElfTpoffTarget::Extern(name.into()),
                    None => super::ElfTpoffTarget::Local(offset as u64),
                },
            });
            true
        }
        Target::WindowsAarch64 => {
            // Windows/aarch64 TLS: x18 is the TEB pointer per the
            // platform ABI; TEB+0x58 holds the per-thread TLS
            // array. Index by `_tls_index` (loaded into x17) and
            // pick the slot for this module; x16 then holds the
            // module's TLS block base. x16 and x17 are AAPCS64
            // scratches outside the SSA allocator pool
            // (callee=[20..27], caller=[9..15]). A unit-local
            // access bakes the variable's offset within its own
            // block into the final `add`. A cross-unit `extern
            // _Thread_local` offset is unknown until the link
            // merges the TLS blocks, so emit a 0 placeholder and
            // record an `elf_tpoff_fixups` entry keyed by symbol;
            // the linker resolves it against the merged TLS layout
            // and rewrites the `add` imm12. The TEB path indexes a
            // module-relative block, so the offset baked in is the
            // raw block offset with no thread-pointer bias -- the
            // linker tells this path apart from the variant-1 ELF
            // path by the `_tls_index` fixup the TEB sequence
            // always records.
            if tls_extern_sym.is_none() && offset >= 4096 {
                bail_msg("TlsAddr: offset exceeds 12-bit add immediate");
                return false;
            }
            emit(code, enc_ldr_imm(Reg(16), Reg(18), 0x58));
            let pair_off = code.len();
            tls_index_fixups.push(super::TlsIndexFixup {
                instr_offset: pair_off,
            });
            emit(code, enc_adrp(Reg(17), 0));
            emit(code, enc_ldr32_imm(Reg(17), Reg(17), 0));
            emit(code, enc_ldr_reg_lsl3(Reg(16), Reg(16), Reg(17)));
            let add_off = code.len();
            let imm = if tls_extern_sym.is_some() {
                0
            } else {
                offset as u32
            };
            emit(code, enc_add_imm(rd, Reg(16), imm));
            // Both forms record a fixup so the linker rebases the imm12 to
            // the variable's offset in the merged TLS block: a unit-local
            // access is correct only when its defining unit sits at block
            // base 0, and the same variable read `extern` from another unit
            // must resolve to the identical offset.
            elf_tpoff_fixups.push(super::ElfTpoffFixup {
                imm_offset: add_off,
                target: match tls_extern_sym {
                    Some(name) => super::ElfTpoffTarget::Extern(name.into()),
                    None => super::ElfTpoffTarget::Local(offset as u64),
                },
            });
            true
        }
        Target::MacOSAarch64 => {
            // A unit-local access dedups by offset (one descriptor per
            // variable). A cross-unit extern access dedups by symbol --
            // its `offset_in_block` is a placeholder the linker fills, so
            // distinct externs must not collapse onto one offset-0 slot.
            let descriptor_index = match tls_extern_sym {
                Some(name) => match macho_tlv_descriptors
                    .iter()
                    .position(|d| d.symbol.as_deref() == Some(name))
                {
                    Some(i) => i,
                    None => {
                        macho_tlv_descriptors.push(super::MachoTlvDescriptor {
                            offset_in_block: 0,
                            symbol: Some(name.into()),
                        });
                        macho_tlv_descriptors.len() - 1
                    }
                },
                None => match macho_tlv_descriptors
                    .iter()
                    .position(|d| d.symbol.is_none() && d.offset_in_block == offset as u64)
                {
                    Some(i) => i,
                    None => {
                        macho_tlv_descriptors.push(super::MachoTlvDescriptor {
                            offset_in_block: offset as u64,
                            symbol: None,
                        });
                        macho_tlv_descriptors.len() - 1
                    }
                },
            };
            let adrp_off = code.len();
            macho_tlv_fixups.push(super::MachoTlvFixup {
                adrp_offset: adrp_off,
                descriptor_index,
            });
            emit(code, enc_adrp(Reg(0), 0));
            emit(code, enc_add_imm(Reg(0), Reg(0), 0));
            emit(code, enc_ldr_imm(Reg(16), Reg(0), 0));
            emit(code, enc_blr(Reg(16)));
            if rd.0 != 0 {
                emit_mov_reg(code, rd, Reg(0));
            }
            true
        }
        _ => {
            bail_msg("TlsAddr: target not aarch64");
            false
        }
    }
}

/// AAPCS64 `va_arg` (Appendix B). Reads the packed `(kind << 16) | size`
/// descriptor the parser folded for the type operand and walks the
/// `__va_list` struct: a general (integer / pointer) argument from the
/// general register save area while `__gr_offs < 0`, a floating-point
/// argument from the vector area while `__vr_offs < 0`, and the overflow
/// stack once the bank is exhausted. Returns the address of the slot
/// holding the argument; the `<stdarg.h>` macro dereferences it as the
/// requested type.
///
/// The struct pointer is held in `scratch.secondary` (x17) across the
/// whole sequence; the working register / argument address is staged in
/// `scratch.primary` (x16). A third register (x9 or x10, whichever the
/// destination does not own) carries the save-area top / new cursor; it
/// is saved and restored around the sequence so a live value it may hold
/// is preserved. AArch64 has no store-to-memory-add, so the writeback of
/// the consumed offset requires the branch (a conditional store is not
/// available).
fn emit_va_arg_aapcs64(
    code: &mut Vec<u8>,
    args: &[u32],
    dst: Place,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    if args.len() != 2 {
        bail_msg("VaArg: expected 2 args (ap, descriptor)");
        return false;
    }
    let descriptor = match func.insts.get(args[1] as usize) {
        Some(Inst::Imm(d)) => *d,
        _ => {
            bail_msg("VaArg: descriptor operand is not a constant");
            return false;
        }
    };
    let kind = (descriptor >> 16) & 0xffff;
    let is_fp = kind == 1;
    let ap_place = alloc
        .places
        .get(args[0] as usize)
        .copied()
        .unwrap_or(Place::None);
    let ap_r = match materialize_int(code, ap_place, scratch.secondary, frame) {
        Some(r) => r,
        None => {
            bail_msg("VaArg: &ap not in int reg / spill");
            return false;
        }
    };
    let ap = if ap_r.0 != scratch.secondary.0 {
        emit_mov_reg(code, scratch.secondary, ap_r);
        scratch.secondary
    } else {
        ap_r
    };
    // Bank-specific fields: integer -> __gr_offs (+24), __gr_top (+8),
    // 8-byte register stride; floating-point -> __vr_offs (+28),
    // __vr_top (+16), 16-byte register stride. The overflow stack uses an
    // 8-byte stride for both classes (AAPCS64 rounds each variadic
    // argument to an eightbyte; a double overflow argument occupies one).
    // TODO: an HFA composite argument rides the vector save area with
    // one 16-byte slot per member (AAPCS64 B.5) and needs per-member
    // composition into a contiguous temporary; the descriptor currently
    // classes every aggregate as general-register.
    let (off_field, top_field, reg_step): (u32, u32, u32) =
        if is_fp { (28, 16, 16) } else { (24, 8, 8) };
    // A by-value aggregate (integer class) spans `ceil(size/8)` eightbytes
    // in consecutive integer registers / overflow slots, so the cursor
    // advances by that span rather than a single eightbyte. A scalar's
    // size is at most 8, leaving the advance unchanged.
    let size = (descriptor & 0xffff) as u32;
    let slot_bytes = (size + 7) & !7u32;
    let reg_advance = if is_fp { reg_step } else { slot_bytes.max(8) };
    let stack_advance = if is_fp { 8 } else { slot_bytes.max(8) };
    let dst_reg = if let Place::IntReg(r) = dst {
        Some(r)
    } else {
        None
    };
    let borrow = if dst_reg == Some(9) { Reg(10) } else { Reg(9) };
    emit(code, enc_str_pre(borrow, Reg(31), -16));
    // x16 = offs (the signed 32-bit field, sign-extended into x16).
    emit(code, enc_ldrsw_imm(scratch.primary, ap, off_field));
    // cmp x16, #0 ; b.ge on_stack -- offs >= 0 means the register bank is
    // exhausted and the argument sits on the overflow stack.
    emit(code, enc_subs_imm(Reg(31), scratch.primary, 0));
    emit(code, enc_b_cond(Cond::Ge, 0));
    let to_stack = code.len() - 4;
    // --- register path ---
    // borrow = top ; borrow = top + offs (the argument address).
    emit(code, enc_ldr_imm(borrow, ap, top_field));
    emit(code, enc_add_reg(borrow, borrow, scratch.primary));
    // x16 = offs + advance (the next offset) ; write it back (32-bit).
    emit(
        code,
        enc_add_imm(scratch.primary, scratch.primary, reg_advance),
    );
    emit(code, enc_str32_imm(scratch.primary, ap, off_field));
    // AAPCS64 B.5 post-increment check: a composite whose span crosses
    // the save area's high edge (offs + span > 0) spilled to the stack
    // at the call; take the overflow path. The incremented offset stays
    // written back, keeping later register-bank reads exhausted.
    emit(code, enc_subs_imm(Reg(31), scratch.primary, 0));
    emit(code, enc_b_cond(Cond::Gt, 0));
    let to_stack_straddle = code.len() - 4;
    // Land the address uniformly in x16.
    emit_mov_reg(code, scratch.primary, borrow);
    emit(code, enc_b(0));
    let to_done = code.len() - 4;
    // --- overflow-stack path ---
    let stack_lbl = code.len();
    let delta = ((stack_lbl - to_stack) / 4) as i32;
    code[to_stack..to_stack + 4].copy_from_slice(&enc_b_cond(Cond::Ge, delta).to_le_bytes());
    let delta = ((stack_lbl - to_stack_straddle) / 4) as i32;
    code[to_stack_straddle..to_stack_straddle + 4]
        .copy_from_slice(&enc_b_cond(Cond::Gt, delta).to_le_bytes());
    // x16 = __stack ; borrow = __stack + advance (next cursor) ; write back.
    emit(code, enc_ldr_imm(scratch.primary, ap, 0));
    emit(code, enc_add_imm(borrow, scratch.primary, stack_advance));
    emit(code, enc_str_imm(borrow, ap, 0));
    // --- done: x16 holds the argument address. ---
    let done_lbl = code.len();
    let delta = ((done_lbl - to_done) / 4) as i32;
    code[to_done..to_done + 4].copy_from_slice(&enc_b(delta).to_le_bytes());
    // Restore the borrowed register (sp returns to its frame position)
    // before delivering a spilled result through the sp-relative store.
    emit(code, enc_ldr_post(borrow, Reg(31), 16));
    match dst {
        Place::IntReg(r) if r != scratch.primary.0 => emit_mov_reg(code, Reg(r), scratch.primary),
        Place::IntReg(_) => {}
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_x_auto(code, scratch.primary, sp_off);
        }
        Place::None => {}
        Place::FpReg(_) => {
            bail_msg("VaArg: dst is an FP register (the result is a pointer)");
            return false;
        }
    }
    true
}

/// `Inst::Intrinsic` lowering. Each variant matches the pool
/// path's shape in [`super::encode::lower_op`] but pulls its
/// operands from the allocator's `Place`s rather than off the c5
/// stack / accumulator.
fn emit_intrinsic(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    abi: super::Abi,
    kind: i64,
    args: &[u32],
    dst: Place,
    v: super::super::ir::ValueId,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
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
        I::VaStart if aarch64_host_variadic_callee(func, abi) => {
            // AAPCS64 `va_start` (Appendix B). args[0] = the `__va_list`
            // pointer (the array-form `va_list` decayed to `&ap[0]`);
            // args[1] = &last (unused -- the named-argument counts come
            // from the prototype, not the last named argument's address).
            // Initialise the 32-byte struct:
            //   __stack  (+0)  = first incoming stack argument
            //   __gr_top (+8)  = high edge of the general save area
            //   __vr_top (+16) = high edge of the vector save area
            //   __gr_offs (+24) = -(8 - named_int) * 8   (counts up to 0)
            //   __vr_offs (+28) = -(8 - named_fp) * 16
            if args.len() != 2 {
                bail_msg("VaStart: expected 2 args");
                return false;
            }
            let n = func.n_params;
            let mut named_int = 0u32;
            let mut named_fp = 0u32;
            for i in 0..n {
                if (func.param_fp_mask & (1u32 << i)) != 0 {
                    named_fp += 1;
                } else {
                    named_int += 1;
                }
            }
            let ap_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let ap_r = match materialize_int(code, ap_place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            // The struct pointer must survive the field writes; keep it in
            // scratch.primary so the secondary is free to stage each value.
            let ap = if ap_r.0 != scratch.primary.0 {
                emit_mov_reg(code, scratch.primary, ap_r);
                scratch.primary
            } else {
                ap_r
            };
            // __stack (+0) = fp + 16 + 192 + named-stack-overflow. Incoming
            // stack arguments begin just above the register save area at
            // [fp + 208]; the named parameters that overflowed the argument
            // registers occupy the low slots there, so the variadic tail
            // begins past them.
            let named_stack_bytes: u32 = super::plan_param_regs(n, func.param_fp_mask, abi)
                .placements
                .iter()
                .filter(|q| matches!(q, super::ArgPlacement::Stack(_)))
                .count() as u32
                * 8;
            emit_sp_plus_off_from_fp(
                code,
                scratch.secondary,
                16 + AARCH64_VA_SAVE_BYTES + named_stack_bytes,
            );
            emit(code, enc_str_imm(scratch.secondary, ap, 0));
            // __gr_top (+8) = fp + 16 + 64 (high edge of the general area).
            emit_sp_plus_off_from_fp(code, scratch.secondary, 16 + AARCH64_GR_SAVE_BYTES);
            emit(code, enc_str_imm(scratch.secondary, ap, 8));
            // __vr_top (+16) = fp + 16 + 192 (high edge of the vector area).
            emit_sp_plus_off_from_fp(code, scratch.secondary, 16 + AARCH64_VA_SAVE_BYTES);
            emit(code, enc_str_imm(scratch.secondary, ap, 16));
            // __gr_offs (+24) = -(8 - named_int) * 8. A named integer
            // parameter past the eight argument registers overflows to the
            // stack, which this offset does not cover (the same assumption
            // `local_slot_off` makes for the named-parameter redirect).
            let gr_offs = -((8u32.saturating_sub(named_int) * 8) as i64);
            load_imm64(code, scratch.secondary, gr_offs as u64);
            emit(code, enc_str32_imm(scratch.secondary, ap, 24));
            // __vr_offs (+28) = -(8 - named_fp) * 16.
            let vr_offs = -((8u32.saturating_sub(named_fp) * 16) as i64);
            load_imm64(code, scratch.secondary, vr_offs as u64);
            emit(code, enc_str32_imm(scratch.secondary, ap, 28));
            true
        }
        I::VaStart => {
            // __builtin_va_start(&ap, &last). args[0] = &ap,
            // args[1] = &last. Set *ap = address of the first
            // variadic argument.
            if args.len() != 2 {
                bail_msg("VaStart: expected 2 args");
                return false;
            }
            let ap_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let ap_r = match materialize_int(code, ap_place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            if win_arm64_variadic_callee(func, abi) {
                // Windows-on-ARM64 variadic ABI (Microsoft ARM64 calling
                // convention): the prologue spilled x0..x7 into the
                // 64-byte gr-save area at `[fp + 16 .. fp + 80)`, one
                // 8-byte slot per argument position. The named arguments
                // occupy the first `n_params` slots; the first variadic
                // argument is slot `n_params` at `fp + 16 + n_params*8`.
                // The gr-save area's top edge (`fp + 80`) meets the
                // incoming stack overflow, so the single cursor `va_arg`
                // advances by 8 walks the register-saved variadic
                // arguments then crosses into the stack arguments with no
                // gap (the same fixed-count / base / stride the prologue
                // and `c5_slot_to_fp_offset` use).
                debug_assert!(
                    func.n_params <= abi.int_arg_regs.len(),
                    "win-arm64 variadic callee assumes named params fit the int arg bank"
                );
                let off = 16 + (func.n_params as u32) * 8;
                emit_sp_plus_off_from_fp(code, scratch.secondary, off);
                emit(code, enc_str_imm(scratch.secondary, ap_r, 0));
                return true;
            }
            if func.is_variadic && abi.variadic_on_stack {
                // macOS arm64 variadic ABI: the named arguments arrive
                // in argument registers (spilled to c5 cdecl cells by
                // the prologue) and the variadic arguments sit on the
                // incoming stack above the named arguments' stack
                // overflow. The named arguments are no longer adjacent
                // to the variadic tail, so `&last` cannot locate it;
                // compute the address from the frame.
                //
                // The prologue allocates `frame.param_spill_bytes` of
                // c5 cdecl cells plus the standard 16-byte fp/lr save
                // below fp, so the incoming-stack region begins at
                // `fp + param_spill_bytes + 16`. The named arguments
                // that overflowed the registers occupy the low
                // `n_stack * 8` bytes of that region (AAPCS64 8-byte
                // stack stride); the variadic tail follows.
                let (_, n_stack) = param_reg_stack_split(func, abi);
                let named_overflow_bytes = (n_stack as u32) * 8;
                let off = frame.param_spill_bytes + 16 + named_overflow_bytes;
                // The c5 cdecl cell region the prologue allocates keeps
                // fp 16-aligned (each cell is 16 bytes, the fp/lr save
                // is 16 bytes); a non-16-aligned `off` would mean the
                // frame accounting and the incoming-stack region
                // disagree.
                debug_assert_eq!(
                    (frame.param_spill_bytes + 16) % 16,
                    0,
                    "va_start: c5 cdecl cell region must keep fp 16-aligned"
                );
                emit_sp_plus_off_from_fp(code, scratch.secondary, off);
                emit(code, enc_str_imm(scratch.secondary, ap_r, 0));
                return true;
            }
            // macOS arm64 (`variadic_on_stack`) and Windows arm64
            // (`win_arm64_variadic_callee`) return above; Linux aarch64
            // takes the `aarch64_host_variadic_callee` arm. No other
            // aarch64 variadic callee shape reaches here.
            bail_msg("VaStart: variadic callee not matched by a host-ABI branch");
            false
        }
        I::VaArg if abi.aarch64_host_variadic() => {
            // The AAPCS64 `va_list` is a `__va_list` struct on this
            // target, so `va_arg` walks the general / vector save areas
            // regardless of whether the current function is itself
            // variadic: a non-variadic forwarder (the `c5_v*printf`
            // shims) receives a forwarded `va_list` and must read it the
            // same way. Gate on the target ABI, not `func.is_variadic`.
            emit_va_arg_aapcs64(code, args, dst, func, alloc, frame, scratch)
        }
        I::VaArg => {
            // __builtin_va_arg(&ap) returns *ap (the address of the
            // current variadic slot) and advances *ap to the next. The
            // stride is a property of the va_list layout the target
            // builds, not of the current function, so a non-variadic
            // forwarder (e.g. libc's `vsnprintf` taking a `va_list`) walks
            // the same stride the variadic caller produced; this does not
            // depend on `func.is_variadic`. Linux aarch64 routes its
            // variadic intrinsics through the register-save-area arm above
            // (gated on `aarch64_host_variadic`), so the cursor arm is
            // reached only by macOS arm64 (`variadic_on_stack`) and
            // Windows arm64 (`variadic_int_only`), both of which lay
            // variadic arguments at 8-byte stride (the incoming stack,
            // respectively the gr-save area + stack overflow). args[0] =
            // &ap, args[1] = the packed `(kind << 16) | size` descriptor.
            // A scalar occupies one eightbyte; a by-value aggregate spans
            // `ceil(size/8)` consecutive eightbytes, so the cursor
            // advances by the aggregate's eightbyte span. va_arg returns
            // the slot address; the caller's load / Mcpy reads `size`
            // bytes from it.
            if args.is_empty() {
                bail_msg("VaArg: expected at least the ap argument");
                return false;
            }
            let va_stride: u32 = match args.get(1).and_then(|a| func.insts.get(*a as usize)) {
                Some(super::super::ir::Inst::Imm(d)) => (((*d & 0xffff) as u32 + 7) & !7).max(8),
                _ => 8,
            };
            let ap_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let ap_r = match materialize_int(code, ap_place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            // The result is loaded into a work register, the cursor is
            // advanced by 16, then the result is delivered to the
            // destination. The work register and the advance temporary
            // must each differ from the cursor address `ap_r` so the
            // writeback stores to the right slot. A spilled destination
            // stages in a scratch register and stores afterward.
            let rd = match dst {
                Place::IntReg(r) if r != ap_r.0 => Reg(r),
                _ if scratch.secondary.0 != ap_r.0 => scratch.secondary,
                _ => scratch.primary,
            };
            let adv = if scratch.primary.0 != ap_r.0 && scratch.primary.0 != rd.0 {
                scratch.primary
            } else if scratch.secondary.0 != ap_r.0 && scratch.secondary.0 != rd.0 {
                scratch.secondary
            } else {
                // Both scratch registers hold the cursor and the staged
                // result (cursor and destination both spilled). x19 is
                // a callee-saved register reserved by the prologue for
                // any function with an intrinsic -- which a VaArg is --
                // so it serves as a third scratch here.
                Reg(19)
            };
            emit(code, enc_ldr_imm(rd, ap_r, 0));
            emit(code, enc_add_imm(adv, rd, va_stride));
            emit(code, enc_str_imm(adv, ap_r, 0));
            match dst {
                Place::IntReg(r) if rd.0 != r => emit_mov_reg(code, Reg(r), rd),
                Place::Spill(slot) => {
                    let sp_off = spill_off(frame, slot);
                    emit_sp_str_x_auto(code, rd, sp_off);
                }
                _ => {}
            }
            true
        }
        I::VaEnd => {
            // No teardown for the cursor model. args[0] is unused.
            true
        }
        I::VaCopy if abi.aarch64_host_variadic() => {
            // AAPCS64 `va_copy` is a 32-byte `__va_list` struct copy
            // (Appendix B): three pointers plus two offsets. args[0] =
            // &dst struct, args[1] = &src struct. Like `va_arg`, gate on
            // the target ABI so a non-variadic forwarder copies the
            // struct it received rather than a single cursor word.
            if args.len() != 2 {
                bail_msg("VaCopy: expected 2 args");
                return false;
            }
            let dst_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let src_place = alloc
                .places
                .get(args[1] as usize)
                .copied()
                .unwrap_or(Place::None);
            let dst_r = match materialize_int(code, dst_place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            let src_r = match materialize_int(code, src_place, scratch.secondary, frame) {
                Some(r) => r,
                None => return false,
            };
            // Transfer register distinct from both pointer registers. x9
            // / x10 / x11 are AAPCS64 caller-saved temporaries outside the
            // allocator's reach here; save and restore the chosen one so a
            // live value it may hold is preserved across the copy.
            let borrow = [9u8, 10, 11]
                .into_iter()
                .map(Reg)
                .find(|r| r.0 != dst_r.0 && r.0 != src_r.0)
                .expect("a caller-saved transfer register is always free");
            emit(code, enc_str_pre(borrow, Reg(31), -16));
            for off in [0u32, 8, 16, 24] {
                emit(code, enc_ldr_imm(borrow, src_r, off));
                emit(code, enc_str_imm(borrow, dst_r, off));
            }
            emit(code, enc_ldr_post(borrow, Reg(31), 16));
            true
        }
        I::VaCopy => {
            // __builtin_va_copy(&dst, &src). args[0] = &dst,
            // args[1] = &src. *dst = *src.
            if args.len() != 2 {
                bail_msg("VaCopy: expected 2 args");
                return false;
            }
            let dst_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let src_place = alloc
                .places
                .get(args[1] as usize)
                .copied()
                .unwrap_or(Place::None);
            let dst_r = match materialize_int(code, dst_place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            let src_r = match materialize_int(code, src_place, scratch.secondary, frame) {
                Some(r) => r,
                None => return false,
            };
            emit(code, enc_ldr_imm(scratch.secondary, src_r, 0));
            emit(code, enc_str_imm(scratch.secondary, dst_r, 0));
            true
        }
        I::Alloca => {
            // alloca(n): round n up to 16-byte alignment, load
            // the current arena top from the bookkeeping slot
            // (initialised by `Inst::AllocaInit`), subtract n
            // to get the new top, write it back, return the new
            // top. `args[0]` carries the requested size; the
            // result of the intrinsic is the new top pointer.
            if current_alloca_top == 0 {
                bail_msg("Alloca: AllocaInit didn't run for this function");
                return false;
            }
            if args.len() != 1 {
                bail_msg("Alloca: expected 1 arg");
                return false;
            }
            let Some(rd) = int_reg(dst) else {
                bail_msg("Alloca: dst not int reg");
                return false;
            };
            let size_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let n = match materialize_int(code, size_place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            // x17 = (n + 15) & ~15 -- the 16-byte-aligned size.
            emit(code, enc_add_imm(scratch.secondary, n, 15));
            emit(
                code,
                super::encode::enc_and_imm_neg16(scratch.secondary, scratch.secondary),
            );
            // x16 = &arena_top -- the bookkeeping slot's address.
            let top_offset = current_alloca_top;
            if top_offset < 4096 {
                emit(code, enc_sub_imm(scratch.primary, Reg(29), top_offset));
            } else {
                let high = top_offset & !0xfff;
                let low = top_offset & 0xfff;
                emit(
                    code,
                    super::encode::enc_sub_imm_lsl12(scratch.primary, Reg(29), high >> 12),
                );
                if low != 0 {
                    emit(code, enc_sub_imm(scratch.primary, scratch.primary, low));
                }
            }
            // *x16 -= aligned_size; rd = new top.
            emit(code, enc_ldr_imm(rd, scratch.primary, 0));
            emit(code, enc_sub_reg(rd, rd, scratch.secondary));
            // Trap on arena underflow: a bumped pointer below the
            // per-frame arena floor (x16 - ALLOCA_ARENA_SLOTS*8) would
            // scribble the saved-register area, so fault deterministically
            // rather than corrupt the stack. TODO: lower alloca to a real
            // SP decrement for unbounded sizes.
            let arena_bytes = (crate::c5::op::ALLOCA_ARENA_SLOTS * 8) as u32;
            emit(
                code,
                super::encode::enc_sub_imm_lsl12(
                    scratch.secondary,
                    scratch.primary,
                    arena_bytes >> 12,
                ),
            );
            emit(code, super::encode::enc_cmp_reg(rd, scratch.secondary));
            emit(code, super::encode::enc_b_cond(super::encode::Cond::Hs, 2));
            emit(code, 0xD420_0020); // brk #1
            emit(code, enc_str_imm(rd, scratch.primary, 0));
            true
        }
        I::AllocaSave => {
            // Read the arena top for a VLA block snapshot (C99 6.7.6.2).
            if current_alloca_top == 0 {
                bail_msg("AllocaSave: AllocaInit didn't run for this function");
                return false;
            }
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                bail_msg("AllocaSave: dst not int reg / spill");
                return false;
            };
            emit_arena_top_addr(code, scratch.secondary, current_alloca_top);
            emit(code, enc_ldr_imm(rd, scratch.secondary, 0));
            spill_local_addr_to_dst(code, dst, rd, frame);
            true
        }
        I::AllocaRestore => {
            // Restore the arena top on VLA block exit.
            if current_alloca_top == 0 {
                bail_msg("AllocaRestore: AllocaInit didn't run for this function");
                return false;
            }
            if args.len() != 1 {
                bail_msg("AllocaRestore: expected 1 arg");
                return false;
            }
            let v_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let v = match materialize_int(code, v_place, scratch.primary, frame) {
                Some(r) => r,
                None => {
                    bail_msg("AllocaRestore: arg not int reg / spill / fp");
                    return false;
                }
            };
            emit_arena_top_addr(code, scratch.secondary, current_alloca_top);
            emit(code, enc_str_imm(v, scratch.secondary, 0));
            true
        }
        I::SetjmpAArch64 => {
            // c5 binds <setjmp.h>'s setjmp() to this intrinsic on
            // Windows aarch64 because msvcrt's longjmp routes
            // through SEH and refuses a CRT-free `jmp_buf`. The
            // inline expansion mirrors the pool path: 25 AArch64
            // words that save x19-x28, x29, the resume PC, sp,
            // and d8-d15 into [env].
            if args.len() != 1 {
                bail_msg("Setjmp: expected 1 arg");
                return false;
            }
            let env_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let env_r = match materialize_int(code, env_place, scratch.primary, frame) {
                Some(r) => r,
                None => {
                    bail_msg("Setjmp: env not int reg / spill / fp");
                    return false;
                }
            };
            // The helper reads env from x19; route it there.
            if env_r.0 != 19 {
                emit_mov_reg(code, Reg(19), env_r);
            }
            emit_setjmp_aarch64(code);
            // After the helper, x19 holds 0 on the initial pass and
            // the longjmp val on a matching longjmp return. Route
            // x19 into dst (or spill to the dst slot) -- the
            // helper's saved-PC points past the helper's last
            // instruction, so the longjmp BR lands here.
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                bail_msg("Setjmp: dst not int reg / spill");
                return false;
            };
            if rd.0 != 19 {
                emit_mov_reg(code, rd, Reg(19));
            }
            spill_local_addr_to_dst(code, dst, rd, frame);
            true
        }
        I::LongjmpAArch64 => {
            // c5 binds <setjmp.h>'s longjmp() to this intrinsic on
            // Windows aarch64. args[0] = env, args[1] = val. The
            // helper restores the saved register set, materializes
            // x19 = (val != 0) ? val : 1 per C99 7.13.2.1p2, and
            // branches to the saved PC.
            if args.len() != 2 {
                bail_msg("Longjmp: expected 2 args");
                return false;
            }
            let env_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let val_place = alloc
                .places
                .get(args[1] as usize)
                .copied()
                .unwrap_or(Place::None);
            let env_r = match materialize_int(code, env_place, Reg(16), frame) {
                Some(r) => r,
                None => {
                    bail_msg("Longjmp: env not int reg / spill / fp");
                    return false;
                }
            };
            if env_r.0 != 16 {
                emit_mov_reg(code, Reg(16), env_r);
            }
            // Stash val in x17 (the secondary scratch in this
            // module) before the upcoming restores clobber x19.
            let val_r = match materialize_int(code, val_place, Reg(17), frame) {
                Some(r) => r,
                None => {
                    bail_msg("Longjmp: val not int reg / spill / fp");
                    return false;
                }
            };
            if val_r.0 != 17 {
                emit_mov_reg(code, Reg(17), val_r);
            }
            // Restore x19-x28 + x29 from [x16 + offset].
            for (i, off) in (JB_X19_OFF..JB_X29_OFF).step_by(8).enumerate() {
                emit(code, enc_ldr_imm(Reg(19 + i as u8), Reg(16), off));
            }
            emit(code, enc_ldr_imm(Reg(29), Reg(16), JB_X29_OFF));
            // Resume PC into x10, sp into x9. x10 is caller-saved
            // (setjmp's caller doesn't expect it preserved); x18
            // is the Windows TEB pointer and stays untouched.
            emit(code, enc_ldr_imm(Reg(10), Reg(16), JB_PC_OFF));
            emit(code, enc_ldr_imm(Reg(9), Reg(16), JB_SP_OFF));
            emit(code, enc_add_imm(Reg(31), Reg(9), 0));
            for (i, off) in (JB_D8_OFF..JB_D8_OFF + 64).step_by(8).enumerate() {
                emit(code, enc_ldr_d_imm(8 + i as u8, Reg(16), off));
            }
            // cmp val, #0 ; cinc x19, val, eq -- 0 becomes 1,
            // anything else passes through unchanged.
            emit(code, enc_subs_imm(Reg(31), Reg(17), 0));
            emit(code, enc_cinc(Reg(19), Reg(17), Cond::Eq));
            emit(code, enc_br(Reg(10)));
            true
        }
        // fma / fmaf lower to Inst::Fma at the call site, so they never
        // reach the Inst::Intrinsic dispatch.
        I::Fma | I::Fmaf => false,
        I::Trap => {
            // `brk #0` (0xD4200000) raises a breakpoint / illegal-state
            // exception. Execution does not continue past it.
            emit(code, 0xD420_0000u32);
            true
        }
        I::CpuRelax => {
            // `yield` (0xD503203F), the AArch64 spin-loop hint.
            emit(code, 0xD503_203Fu32);
            true
        }
        I::AtomicThreadFence => {
            // `dmb ish` (0xD5033BBF), a full barrier across the inner
            // shareable domain (C11 7.17.4 seq_cst). No operand, no result.
            emit(code, 0xD503_3BBFu32);
            true
        }
        I::X87StoreControlWord | I::X87LoadControlWord => {
            // The x87 FPU control word is x86-only; AArch64 source never
            // reaches for it (the guarding HAVE_GCC_ASM_FOR_X87 is unset).
            bail_msg("x87 control word intrinsic is x86-only");
            false
        }
        I::Cpuid | I::Xgetbv => {
            // cpuid / xgetbv are x86-only; the source gates them on
            // MA_X86 / MA_X64, so AArch64 never reaches them.
            bail_msg("cpuid / xgetbv intrinsic is x86-only");
            false
        }
        I::Sqrt
        | I::Sqrtf
        | I::Fabs
        | I::Fabsf
        | I::Floor
        | I::Floorf
        | I::Ceil
        | I::Ceilf
        | I::Trunc
        | I::Truncf => {
            if args.len() != 1 {
                bail_msg("unary FP intrinsic: expected 1 arg");
                return false;
            }
            let src_place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let is_f32 = alloc.is_f32(v);
            let dn = match materialize_fp_for(code, args[0], src_place, SCRATCH_FP0, frame, alloc) {
                Some(r) => r,
                None => return false,
            };
            let dd = match dst {
                Place::FpReg(r) => r,
                Place::Spill(_) => SCRATCH_FP1,
                _ => return false,
            };
            use super::encode::{
                enc_fabs_d, enc_fabs_s, enc_frintm_d, enc_frintm_s, enc_frintp_d, enc_frintp_s,
                enc_frintz_d, enc_frintz_s, enc_fsqrt_d, enc_fsqrt_s,
            };
            let inst = match intrinsic {
                I::Sqrt | I::Sqrtf if is_f32 => enc_fsqrt_s(dd, dn),
                I::Sqrt | I::Sqrtf => enc_fsqrt_d(dd, dn),
                I::Fabs | I::Fabsf if is_f32 => enc_fabs_s(dd, dn),
                I::Fabs | I::Fabsf => enc_fabs_d(dd, dn),
                I::Floor | I::Floorf if is_f32 => enc_frintm_s(dd, dn),
                I::Floor | I::Floorf => enc_frintm_d(dd, dn),
                I::Ceil | I::Ceilf if is_f32 => enc_frintp_s(dd, dn),
                I::Ceil | I::Ceilf => enc_frintp_d(dd, dn),
                _ if is_f32 => enc_frintz_s(dd, dn),
                _ => enc_frintz_d(dd, dn),
            };
            emit(code, inst);
            if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit_sp_str_d_auto(code, dd, sp_off);
            }
            true
        }
        I::FrameAddress => {
            // __builtin_frame_address(0): the current frame pointer (x29).
            // The level argument (args[0]) is ignored; only level 0 is
            // supported. Materialise through scratch when the dst spilled.
            let rd = match dst {
                Place::IntReg(r) => Reg(r),
                Place::Spill(_) => Reg(16),
                _ => {
                    bail_msg("FrameAddress: dst not int reg / spill");
                    return false;
                }
            };
            emit(code, enc_add_imm(rd, Reg(29), 0));
            spill_local_addr_to_dst(code, dst, rd, frame);
            true
        }
        I::Clz
        | I::Ctz
        | I::Popcount
        | I::Clzll
        | I::Ctzll
        | I::Popcountll
        | I::Bswap16
        | I::Bswap32
        | I::Bswap64 => {
            // The integer bit-count and byte-swap builtins are lowered to a
            // portable shift / mask sequence in the walker; they never reach
            // codegen as an `Inst::Intrinsic`.
            bail_msg("intrinsic: bit builtin reached codegen");
            false
        }
        I::AtomicLoad
        | I::AtomicStore
        | I::AtomicExchange
        | I::AtomicFetchAdd
        | I::AtomicFetchSub
        | I::AtomicFetchAnd
        | I::AtomicFetchOr
        | I::AtomicFetchXor
        | I::AtomicCompareExchangeStrong => {
            // C11 atomic operations are lowered to load / store /
            // read-modify-write at the call site; they never reach
            // codegen as an `Inst::Intrinsic`.
            bail_msg("intrinsic: atomic op reached codegen");
            false
        }
    }
}

/// External library call: arg marshalling identical to
/// `emit_call`, but the branch target is a PLT trampoline rather
/// than a c5 function. The trampoline gets a `PltCallFixup`
/// recorded; the writer's post-pass patches the BL displacement
/// once trampolines are laid out at the tail of the code blob.
#[allow(clippy::too_many_arguments)]
fn emit_call_ext(
    code: &mut Vec<u8>,
    dst: Place,
    binding_idx: i64,
    args: &[u32],
    fp_arg_mask: u32,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    abi: super::Abi,
    target: Target,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    imports: &super::ResolvedImports,
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
    ret_agg: Option<u32>,
    ret_slot_off: i64,
) -> bool {
    let import_index = match imports.index_of_binding(binding_idx) {
        Some(i) => i,
        None => return false,
    };
    let imp = &imports.imports[import_index];
    // Variadic calls feed `fixed_args` to the planner so it can
    // place the variadic tail per the host's variadic ABI
    // (macOS arm64: all on the stack; Win arm64 / Win64: int regs
    // first, then stack; Linux: standard register sequence). The
    // walker stamps the FP-arg bit mask from each `Expr::Call`'s
    // per-arg type so the planner routes FP args to d0..d7
    // instead of x0..x7.
    let fixed = if imp.is_variadic {
        imp.fixed_args.min(args.len())
    } else {
        args.len()
    };
    // With no by-value struct argument this reduces to the scalar
    // placement; a tagged aggregate rides through the host-ABI
    // argument-register packing.
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    let plan = super::plan_call_args_aggs(args.len(), fixed, fp_arg_mask, abi, &aggs, false);
    emit_sub_sp_imm(code, plan.scratch_bytes);
    if !marshal_args(
        code, &plan, args, alloc, scratch, frame, arg_aggs, agg_descs,
    ) {
        return false;
    }
    setup_indirect_result(code, ret_agg, ret_slot_off, agg_descs, frame);
    plt_call_fixups.push(PltCallFixup {
        instr_offset: code.len(),
        import_index,
        is_tail: false,
        is_addr: false,
    });
    // BL: non-tail libc call -- the AAPCS64 return goes back
    // into main below for the result handling + `return`
    // epilogue. The apply_plt_call_fixups patcher only
    // rewrites imm26, so the placeholder opcode has to be BL
    // (`0x94000000`) not B (`0x14000000`); otherwise printf
    // ret's to main's caller and main's epilogue never runs.
    emit(code, enc_bl(0));
    // AAPCS64 returns `long double` (IEEE binary128) in v0 as a
    // single 128-bit Q register. c5 stores `long double` in an
    // 8-byte FP64 slot, so a `long double` libc return needs a
    // truncation pass before it becomes the c5 accumulator. The
    // libgcc helper `__trunctfdf2` takes binary128 in v0 and
    // returns FP64 in d0; the codegen pre-includes it on
    // LinuxAarch64. macOS / Windows AArch64 alias `long double`
    // to `double`, so v0 is already FP64 on those targets and
    // the truncation step is skipped.
    //
    // The follow-up must be `BL`, not `B`: the patcher only
    // rewrites imm26, so the placeholder opcode determines
    // whether LR gets set. With `B`, the trampoline's `ret`
    // reads the unchanged LR and jumps back to the same site.
    if imp.returns_long_double && target == Target::LinuxAarch64 {
        let trunc_idx = imports
            .imports
            .iter()
            .position(|i| i.local_name == "__trunctfdf2")
            .unwrap_or(usize::MAX);
        if trunc_idx == usize::MAX {
            bail_msg("CallExt: returns_long_double but __trunctfdf2 not in imports");
            return false;
        }
        plt_call_fixups.push(PltCallFixup {
            instr_offset: code.len(),
            import_index: trunc_idx,
            is_tail: false,
            is_addr: false,
        });
        emit(code, enc_bl(0));
    }
    emit_add_sp_imm(code, plan.scratch_bytes);
    if ret_agg.is_some() {
        finish_call_result(
            code,
            ret_agg,
            ret_slot_off,
            agg_descs,
            dst,
            frame,
            scratch,
            false,
        );
        return true;
    }
    use crate::c5::compiler::types as ty_helpers;
    let return_type_tag = imp.return_type_tag;
    let bare = ty_helpers::strip_unsigned(return_type_tag);
    let returns_fp = ty_helpers::is_float_ty(bare) || ty_helpers::is_double_ty(bare);
    if returns_fp {
        // A float / double result is FP-classed (`Inst::CallExt::fp_return`)
        // and already sits in d0 (double) / s0 (single) on AAPCS64. An f32
        // value is FP-classed as the single in s0 -- the same form
        // `FpCast(F64ToF32)` produces and `StoreLocal F32` / `FpCast(F32ToF64)`
        // consume -- so route it into the FP place dst with no widening and
        // no GPR bridge. (The prior GPR-bridged path widened to d0 because
        // the integer-class convention carried the f64-widened bits.)
        move_call_result(code, dst, frame, true);
        return true;
    }
    // Long double is not FP-classed (is_floating_scalar excludes it), so it
    // is bridged through x0 like an integer return; sub-word integer
    // returns receive the same sign / zero extension the pool path applies.
    if imp.returns_long_double {
        emit(code, enc_fmov_d_to_x(Reg(0), 0));
    } else {
        let ext = super::return_extension(return_type_tag, target);
        emit_extend_x0_for_return(code, ext);
    }
    if let Some(rd) = int_reg(dst) {
        if rd.0 != 0 {
            emit_mov_reg(code, rd, Reg(0));
        }
    } else if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit_sp_str_x_auto(code, Reg(0), sp_off);
    }
    true
}

/// Emit the same sub-word sign / zero extension the pool path's
/// `emit_extend_x19_for_return` issues, but targeted at x0 since
/// the SSA emit's accumulator stays in x0 through the call's
/// dst-place propagation. `ReturnExt::None` is a no-op.
fn emit_extend_x0_for_return(code: &mut Vec<u8>, ext: super::ReturnExt) {
    use super::ReturnExt;
    // The four encodings below match the pool path's helper:
    //   sxtb x0, w0    -- sign-extend byte
    //   sxth x0, w0    -- sign-extend half
    //   sxtw x0, w0    -- sign-extend word
    //   uxtb w0, w0    -- zero-extend byte
    //   uxth w0, w0    -- zero-extend half
    //   mov  w0, w0    -- zero-extend word (clears upper bits)
    let word = match ext {
        ReturnExt::None => return,
        ReturnExt::Sign8 => 0x93401C00,
        ReturnExt::Sign16 => 0x93403C00,
        ReturnExt::Sign32 => 0x93407C00,
        ReturnExt::Zero8 => 0x53001C00,
        ReturnExt::Zero16 => 0x53003C00,
        ReturnExt::Zero32 => 0x2A0003E0,
    };
    emit(code, word);
}

/// Recover the codegen `Target` from the ABI struct so
/// `return_extension` can compute the per-target extension shape.
/// The ABI struct carries enough state to distinguish each
/// target's variadic / arg-placement rules; the host-arg-reg list
/// is what we discriminate on here because it's stable across
/// every target's `Abi::for_target`.
fn target_for_ext(abi: super::Abi) -> Target {
    // Same arg-reg signature differentiates AAPCS64 vs the x86_64
    // ABIs that share `Target` ids; the SSA emit only runs on
    // aarch64 today so this is enough to compute the extension.
    if abi.int_arg_regs.len() == 8 {
        Target::MacOSAarch64
    } else {
        Target::LinuxAarch64
    }
}

/// Direct call to a c5 user function at ent_pc `target_pc`.
/// Marshalls args into the host-ABI int arg registers (the FP
/// path isn't part of the thin slice yet -- bail out on any FP-
/// kind arg), copies overflow args onto the host stack, BL the
/// placeholder, and records a `Fixup::Bl` for the outer fixup
/// pass to resolve. Result lands in x0; the SSA emit moves it to
/// the inst's `dst` if needed.
#[allow(clippy::too_many_arguments)]
fn emit_call(
    code: &mut Vec<u8>,
    dst: Place,
    target_pc: usize,
    args: &[u32],
    fixed_args: usize,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    abi: super::Abi,
    fixups: &mut Vec<Fixup>,
    callee_is_variadic: bool,
    fp_return: bool,
    fp_arg_mask: u32,
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
    ret_agg: Option<u32>,
    ret_slot_off: i64,
) -> bool {
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    if callee_is_variadic
        && (abi.variadic_on_stack || abi.variadic_int_only || abi.aarch64_host_variadic())
    {
        // Host variadic ABI: marshal the named (fixed) and variadic
        // arguments through `plan_call_args`, identical to a libc
        // variadic call (`emit_call_ext`).
        //
        //  * macOS arm64 (`variadic_on_stack`, Apple "Writing ARM64
        //    Code for Apple Platforms"): named arguments follow AAPCS64
        //    6.4.1 (int bank x0..x7 / FP bank d0..d7, overflow to the
        //    stack); every variadic argument rides the stack at 8-byte
        //    stride. The callee spills its named register arguments to
        //    its c5 cdecl cells and reads the variadic tail off the
        //    incoming stack; `va_start` points at the first stack slot.
        //  * Windows arm64 (`variadic_int_only`, Microsoft ARM64
        //    calling convention): named arguments follow AAPCS64; every
        //    variadic argument rides the integer register bank x0..x7
        //    (a floating-point variadic argument as its raw bit pattern,
        //    the walker already widened it to double and passed
        //    `fp_arg_mask` 0) then the incoming stack. The callee spills
        //    x0..x7 into its gr-save area; `va_start` points at the
        //    first variadic slot there.
        //  * Linux aarch64 (`aarch64_host_variadic`, AAPCS64 Appendix B):
        //    named and variadic arguments follow AAPCS64 6.4.1 alike --
        //    the int bank x0..x7, the FP bank d0..d7, then the stack. The
        //    callee spills both banks into its general / vector register
        //    save area; `va_start` records the offsets and `va_arg` walks
        //    the areas then the overflow stack.
        let plan =
            super::plan_call_args_aggs(args.len(), fixed_args, fp_arg_mask, abi, &aggs, false);
        emit_sub_sp_imm(code, plan.scratch_bytes);
        if !marshal_args(
            code, &plan, args, alloc, scratch, frame, arg_aggs, agg_descs,
        ) {
            return false;
        }
        // A variadic callee may still return an aggregate by value; load
        // the indirect-result pointer into x8 for a >16-byte return and
        // recover the eightbytes from x0/x1 afterwards, as the
        // non-variadic path does. Without this the struct result is
        // dropped (the scalar bridge leaves the result slot unwritten).
        setup_indirect_result(code, ret_agg, ret_slot_off, agg_descs, frame);
        fixups.push(Fixup {
            native_offset: code.len(),
            target_ent_pc: target_pc,
            kind: BranchKind::Bl,
        });
        emit(code, enc_bl(0));
        emit_add_sp_imm(code, plan.scratch_bytes);
        finish_call_result(
            code,
            ret_agg,
            ret_slot_off,
            agg_descs,
            dst,
            frame,
            scratch,
            fp_return,
        );
        return true;
    }
    // Every aarch64 variadic callee is marshaled by a host-ABI branch
    // above: macOS arm64 (`variadic_on_stack`), Windows arm64
    // (`variadic_int_only`), or Linux aarch64 (`aarch64_host_variadic`). A
    // variadic callee reaching this point would fall through to the
    // non-variadic path and be marshaled without the host variadic
    // protocol, a silent miscompile; fail the emit instead.
    if callee_is_variadic {
        bail_msg("Call: variadic callee not matched by a host-ABI branch");
        return false;
    }
    // Non-variadic: marshal through the host ABI. `fp_arg_mask`
    // comes from the argument types (set by the walker) rather than
    // register placement, since a floating-point constant rides an
    // integer register as its `Imm` bit pattern. Feeding the mask to
    // the planner routes the FP args to d0..d7 instead of x0..x7.
    let plan = super::plan_call_args_aggs(args.len(), args.len(), fp_arg_mask, abi, &aggs, false);
    emit_sub_sp_imm(code, plan.scratch_bytes);
    if !marshal_args(
        code, &plan, args, alloc, scratch, frame, arg_aggs, agg_descs,
    ) {
        return false;
    }
    setup_indirect_result(code, ret_agg, ret_slot_off, agg_descs, frame);
    // Branch placeholder + fixup. The pool path's apply_fixups
    // resolves `target_ent_pc` -> `pc_to_native` once
    // the map is final.
    fixups.push(Fixup {
        native_offset: code.len(),
        target_ent_pc: target_pc,
        kind: BranchKind::Bl,
    });
    emit(code, enc_bl(0));
    emit_add_sp_imm(code, plan.scratch_bytes);
    finish_call_result(
        code,
        ret_agg,
        ret_slot_off,
        agg_descs,
        dst,
        frame,
        scratch,
        fp_return,
    );
    true
}

/// Before a call returning an aggregate larger than 16 bytes, point
/// the AAPCS64 x8 indirect-result register at the caller's result
/// temp. Runs after `marshal_args` so the argument registers are
/// already set; the slot address is recomputed from fp.
fn setup_indirect_result(
    code: &mut Vec<u8>,
    ret_agg: Option<u32>,
    ret_slot_off: i64,
    agg_descs: &[super::super::ir::AggDesc],
    frame: Frame,
) {
    if let Some(ai) = ret_agg
        && agg_descs[ai as usize].size > 16
        && super::abi_classify::hfa_member_layout(&agg_descs[ai as usize].fields).is_none()
    {
        // An HFA larger than 16 bytes (three or four members) still returns
        // in v-registers, not through x8.
        emit_local_addr(code, Place::IntReg(8), ret_slot_off, frame);
    }
}

/// Materialise a call's result. An aggregate of at most 16 bytes
/// arrives in x0/x1 and is stored into the result temp; a larger one
/// was written through x8 by the callee, so nothing remains. A scalar
/// return uses the standard register bridge.
#[allow(clippy::too_many_arguments)]
fn finish_call_result(
    code: &mut Vec<u8>,
    ret_agg: Option<u32>,
    ret_slot_off: i64,
    agg_descs: &[super::super::ir::AggDesc],
    dst: Place,
    frame: Frame,
    scratch: &ScratchPool,
    fp_return: bool,
) {
    if let Some(ai) = ret_agg {
        let desc = &agg_descs[ai as usize];
        let size = desc.size;
        if let Some(members) = super::abi_classify::hfa_member_layout(&desc.fields) {
            // AAPCS64 6.9: an HFA result arrives with member k in v[k].
            // Store each into the result temp at its byte offset.
            emit_local_addr(code, Place::IntReg(scratch.primary.0), ret_slot_off, frame);
            for (k, (off, msize)) in members.iter().enumerate() {
                if *msize == 8 {
                    emit(
                        code,
                        super::encode::enc_str_d_imm(k as u8, scratch.primary, *off),
                    );
                } else {
                    emit(
                        code,
                        super::encode::enc_str_s_imm(k as u8, scratch.primary, *off),
                    );
                }
            }
        } else if size <= 16 {
            emit_local_addr(code, Place::IntReg(scratch.primary.0), ret_slot_off, frame);
            emit(code, enc_str_imm(Reg(0), scratch.primary, 0));
            if size > 8 {
                emit(code, enc_str_imm(Reg(1), scratch.primary, 8));
            }
        }
        return;
    }
    move_call_result(code, dst, frame, fp_return);
}

/// Common return-value bridge shared by `emit_call` and
/// `emit_call_indirect`. An integer-classed result rides x0 (AAPCS64
/// 6.4.1); a floating-point scalar rides d0, whose low 32 bits are the
/// s0 an f32 occupies (AAPCS64 6.4.2), which is where `emit_return`
/// leaves it. When the callee returns a floating-point scalar
/// (`fp_return`) this copies d0 into the FP-classed destination, or
/// bridges it to a GPR via `fmov x, d0` when the destination is
/// integer-classed.
fn move_call_result(code: &mut Vec<u8>, dst: Place, frame: Frame, fp_return: bool) {
    if fp_return {
        // A floating-point scalar result arrives in d0 (C99 6.2.5p10 /
        // AAPCS64 6.4.2). A `float` result occupies s0, the low 32
        // bits of d0; a d-register copy preserves it.
        match dst {
            Place::FpReg(r) => {
                if r != 0 {
                    emit(code, super::encode::enc_fmov_d_d(r, 0));
                }
            }
            Place::IntReg(r) => emit(code, enc_fmov_d_to_x(Reg(r), 0)),
            Place::Spill(slot) => {
                let sp_off = spill_off(frame, slot);
                emit_sp_str_d_auto(code, 0, sp_off);
            }
            Place::None => {}
        }
        return;
    }
    match dst {
        Place::IntReg(r) => {
            if r != 0 {
                emit_mov_reg(code, Reg(r), Reg(0));
            }
        }
        Place::FpReg(r) => {
            // A non-FP call whose result the allocator FP-classed
            // (rare): reinterpret the integer x0 pattern into d.
            emit(code, enc_fmov_x_to_d(r, Reg(0)));
        }
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot);
            // The allocator gives Spill the same 8-byte slot
            // regardless of result kind, so store the wide
            // pattern via x0 directly.
            emit_sp_str_x_auto(code, Reg(0), sp_off);
        }
        Place::None => {}
    }
}

/// Indirect call through a function-pointer value. Mirrors the
/// pool path's indirect-call lowering: marshal args per the host
/// ABI, capture the target into a callee-overwritable scratch
/// register that arg marshalling won't clobber, `blr`, recover
/// the return value.
/// FP args and variadic indirect callees aren't part of the thin
/// slice; either case returns false.
#[allow(clippy::too_many_arguments)]
fn emit_call_indirect(
    code: &mut Vec<u8>,
    dst: Place,
    target: u32,
    args: &[u32],
    callee_variadic: bool,
    fixed_args: usize,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    abi: super::Abi,
    fp_return: bool,
    fp_arg_mask: u32,
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
    ret_agg: Option<u32>,
    ret_slot_off: i64,
) -> bool {
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    let target_place = alloc
        .places
        .get(target as usize)
        .copied()
        .unwrap_or(Place::None);
    // Collect the registers currently holding arg-source values
    // for this call. AAPCS64 doesn't assign these scratch
    // registers to int-arg slots, but the SSA allocator's
    // caller-saved pool includes them and may park an arg's
    // source value in one. The target stage must avoid those
    // registers while the marshal still reads them.
    let mut arg_source_regs: alloc::vec::Vec<u8> = alloc::vec::Vec::with_capacity(args.len());
    for &a in args {
        if let Some(Place::IntReg(r)) = alloc.places.get(a as usize) {
            arg_source_regs.push(*r);
        }
    }
    // Capture the function pointer into a caller-saved scratch
    // disjoint from the arg sources. Prefer x9, then x10..x15 --
    // none are arg-passing registers per AAPCS64, so they are
    // safe to clobber via the blr. When every candidate holds an
    // arg source the marshal still reads, the host-ABI branch
    // stages the pointer in a reserved stack cell instead, and the
    // c5-stack branch captures after its pushes have consumed the
    // sources; a blind fallback here overwrote a live source.
    const TARGET_SCRATCH_CANDIDATES: &[u8] = &[9, 10, 11, 12, 13, 14, 15];
    let free_target_reg = TARGET_SCRATCH_CANDIDATES
        .iter()
        .copied()
        .find(|r| !arg_source_regs.contains(r))
        .map(Reg);
    if (callee_variadic
        && (abi.variadic_on_stack || abi.variadic_int_only || abi.aarch64_host_variadic()))
        || !aggs.is_empty()
        || ret_agg.is_some()
    {
        // Host ABI through a function pointer, taken for a host
        // variadic callee or any call passing an aggregate by value
        // (aggregates are placed by `marshal_args`, which the
        // c5-stack push path below does not handle): the named
        // arguments follow AAPCS64 (int / FP bank) and the variadic tail
        // rides the host stack at 8-byte stride (macOS,
        // `variadic_on_stack`), the integer register bank then the
        // stack (Windows arm64, `variadic_int_only`), or both banks then
        // the stack (Linux aarch64, `aarch64_host_variadic`) -- the same
        // placement `emit_call` uses for a direct variadic call. The
        // target pointer rides a non-arg-passing scratch that
        // `marshal_args` will not clobber, or a reserved stack cell
        // above the argument slots when no such scratch is free.
        let mut plan =
            super::plan_call_args_aggs(args.len(), fixed_args, fp_arg_mask, abi, &aggs, false);
        let staged_off = match free_target_reg {
            Some(_) => None,
            None => {
                // One 16-byte cell keeps SP 16-aligned; the argument
                // slots stay below the original scratch_bytes.
                plan.scratch_bytes += 16;
                Some(plan.scratch_bytes - 16)
            }
        };
        let target_r = match materialize_int(code, target_place, scratch.primary, frame) {
            Some(r) => r,
            None => return false,
        };
        let target_reg = match free_target_reg {
            Some(r) => {
                if target_r.0 != r.0 {
                    emit_mov_reg(code, r, target_r);
                }
                r
            }
            None => {
                if target_r.0 != scratch.primary.0 {
                    emit_mov_reg(code, scratch.primary, target_r);
                }
                scratch.primary
            }
        };
        emit_sub_sp_imm(code, plan.scratch_bytes);
        if let Some(off) = staged_off {
            emit_sp_str_x_auto(code, target_reg, off);
        }
        if !marshal_args(
            code, &plan, args, alloc, scratch, frame, arg_aggs, agg_descs,
        ) {
            return false;
        }
        setup_indirect_result(code, ret_agg, ret_slot_off, agg_descs, frame);
        // The marshal consumed every argument source, so x9 is free
        // to carry the staged pointer to the blr.
        let call_reg = match staged_off {
            Some(off) => {
                emit_sp_ldr_x(code, Reg(9), off);
                Reg(9)
            }
            None => target_reg,
        };
        emit(code, enc_blr(call_reg));
        emit_add_sp_imm(code, plan.scratch_bytes);
        finish_call_result(
            code,
            ret_agg,
            ret_slot_off,
            agg_descs,
            dst,
            frame,
            scratch,
            fp_return,
        );
        return true;
    }
    // Indirect calls keep the c5-stack push shape regardless of
    // whether the callee is variadic. Variadic c5 callees read
    // their args off the 16-byte-stride stack (their prologue
    // skips the host-arg-reg spill); non-variadic callees pull
    // their args from x0..x7 + host stack overflow, ignoring the
    // c5 stack pushes. Mirroring the pool path's indirect-call
    // shape -- push every arg first, then load the prefix into
    // host arg regs, then blr -- handles both at the indirect
    // call site without needing the callee's variadic flag.
    // `fp_arg_mask` is supplied by the caller from the argument types;
    // the reload loop below routes each masked argument into its
    // d-register per the plan.
    for (i, &arg_id) in args.iter().rev().enumerate() {
        let arg_place = alloc
            .places
            .get(arg_id as usize)
            .copied()
            .unwrap_or(Place::None);
        let sp_shift = (i as u32) * 16;
        let src = if let Place::FpReg(_) = arg_place {
            // FP value: load into d-reg, then move bit pattern
            // into x16 for the 16-byte stride push.
            let dn = match materialize_fp_shifted(code, arg_place, 0, frame, sp_shift) {
                Some(r) => r,
                None => return false,
            };
            emit(code, enc_fmov_d_to_x(scratch.primary, dn));
            scratch.primary
        } else {
            match materialize_int_shifted(code, arg_place, scratch.primary, frame, sp_shift) {
                Some(r) => r,
                None => return false,
            }
        };
        emit(code, enc_str_pre(src, Reg(31), -16));
    }
    let pushed_bytes = (args.len() as u32) * 16;
    // The pushes consumed every argument source, so x9 holds no live
    // value; capture the pointer here, with SP shifted by the pushes.
    let target_reg = Reg(9);
    let target_r =
        match materialize_int_shifted(code, target_place, target_reg, frame, pushed_bytes) {
            Some(r) => r,
            None => return false,
        };
    if target_r.0 != target_reg.0 {
        emit_mov_reg(code, target_reg, target_r);
    }
    // Load the prefix into host arg regs from the c5-stride
    // stack we just laid down. Non-variadic callees expect this
    // shape; variadic callees ignore the host arg regs but read
    // the same slots through the address-of-local path. Stack
    // overflow (args
    // past 8) stays on the c5 stack at `[sp + i*16]`, which the
    // callee prologue's overflow restripe loop also reads from.
    let plan = super::plan_call_args_aggs(args.len(), args.len(), fp_arg_mask, abi, &aggs, false);
    emit_sub_sp_imm(code, plan.scratch_bytes);
    for (i, &placement) in plan.placements.iter().enumerate() {
        match placement {
            super::ArgPlacement::IntReg(r) => {
                let src_off = plan.scratch_bytes + (i as u32) * 16;
                emit(code, enc_ldr_imm(Reg(r), Reg(31), src_off));
            }
            super::ArgPlacement::FpReg(r) => {
                let src_off = plan.scratch_bytes + (i as u32) * 16;
                emit(code, enc_ldr_d_imm(r, Reg(31), src_off));
            }
            super::ArgPlacement::Stack(off) => {
                let src_off = plan.scratch_bytes + (i as u32) * 16;
                emit(code, enc_ldr_imm(scratch.primary, Reg(31), src_off));
                emit(code, enc_str_imm(scratch.primary, Reg(31), off));
            }
            // This path plans with the scalar `plan_call_args`, so
            // aggregate placements never occur here.
            super::ArgPlacement::StructRegs { .. }
            | super::ArgPlacement::StructByRefReg(_)
            | super::ArgPlacement::StructByRefStack(_)
            | super::ArgPlacement::StructStack { .. } => {
                unreachable!("aggregate arg placement on the scalar indirect path")
            }
        }
    }
    emit(code, enc_blr(target_reg));
    emit_add_sp_imm(code, plan.scratch_bytes);
    // Drop the 16-byte-stride argument pushes.
    emit_add_sp_imm(code, pushed_bytes);
    move_call_result(code, dst, frame, fp_return);
    true
}

/// Compile-time-unrolled struct copy. `size` bytes from [src] to
/// [dst]; emits 8-byte ldr/str pairs for whole words and a
/// ldrb/strb tail for any sub-word remainder. The defined value
/// is `dst` -- mirrors C's `memcpy(dst, src, size)` return.
fn emit_mcpy(
    code: &mut Vec<u8>,
    dst_place: Place,
    dst_val: u32,
    src_val: u32,
    size: i64,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    if size < 0 {
        bail_msg("Mcpy: negative size");
        return false;
    }
    let dst_place_in = alloc
        .places
        .get(dst_val as usize)
        .copied()
        .unwrap_or(Place::None);
    let src_place_in = alloc
        .places
        .get(src_val as usize)
        .copied()
        .unwrap_or(Place::None);
    let dst_r = match materialize_int(code, dst_place_in, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let src_r = match materialize_int(code, src_place_in, scratch.secondary, frame) {
        Some(r) => r,
        None => return false,
    };
    // Mcpy needs a third register for each ldr/str pair. The
    // allocator pool covers x9..x15 + x20..x27 (target-dependent)
    // and may hold a live value in any of them; the SSA emit
    // sees only `Place`s, not liveness past this inst. Reserve
    // x10 unconditionally and save/restore it through one 16-byte
    // stack slot so it doesn't matter whether the allocator has
    // x10 in active use. The slot is dropped before the next
    // instruction sees sp.
    //
    // Pick a temp distinct from both bases. The save/restore
    // protects whatever the allocator parked in the chosen reg;
    // the aliasing check ensures we don't pick a temp that shares
    // a number with `dst_r` or `src_r`, which would corrupt the
    // base on the first ldr/str pair.
    let temp = if dst_r.0 != 10 && src_r.0 != 10 {
        Reg(10)
    } else if dst_r.0 != 11 && src_r.0 != 11 {
        Reg(11)
    } else {
        Reg(12)
    };
    let bytes = size as u32;
    emit(code, enc_str_pre(temp, Reg(31), -16));
    let words = bytes / 8;
    for w in 0..words {
        let off = w * 8;
        emit(code, enc_ldr_imm(temp, src_r, off));
        emit(code, enc_str_imm(temp, dst_r, off));
    }
    let tail_start = words * 8;
    for i in 0..(bytes - tail_start) {
        let off = tail_start + i;
        emit(code, enc_ldrb_imm(temp, src_r, off));
        emit(code, enc_strb_imm(temp, dst_r, off));
    }
    emit(code, enc_ldr_post(temp, Reg(31), 16));
    // memcpy returns dst -- propagate into the Inst's `dst_place`.
    if let Some(rd) = int_reg(dst_place) {
        if rd.0 != dst_r.0 {
            emit_mov_reg(code, rd, dst_r);
        }
    } else if let Place::Spill(slot) = dst_place {
        let sp_off = spill_off(frame, slot);
        emit_sp_str_x_auto(code, dst_r, sp_off);
    }
    true
}

/// Bytes the atomic lowering reserves to save the four borrowed
/// working registers x9..x12 (two `stp` pairs). 16-byte aligned so the
/// `stp`/`ldp` pre/post-index forms apply.
const ATOMIC_SAVE_BYTES: u32 = 32;

/// Save x9..x12 (the borrowed working registers) onto the stack and
/// return their reload site for [`atomic_restore_working`]. The SSA
/// emit sees only `Place`s, not liveness past this instruction, so a
/// value the allocator parked in any caller-pool register survives the
/// save / restore. sp moves down by [`ATOMIC_SAVE_BYTES`].
fn atomic_save_working(code: &mut Vec<u8>) {
    emit(
        code,
        enc_stp_pre(Reg(9), Reg(10), Reg(31), -(ATOMIC_SAVE_BYTES as i32)),
    );
    // Second pair at [sp+16] without a second writeback; storing at
    // offset 0 would overwrite x9/x10's slot.
    emit(
        code,
        super::encode::enc_stp_off(Reg(11), Reg(12), Reg(31), 16),
    );
}

/// Restore x9..x12 saved by [`atomic_save_working`]. Run after the
/// result is held in a reserved scratch (x16 / x17), since the result
/// must outlive the reload.
fn atomic_restore_working(code: &mut Vec<u8>) {
    emit(
        code,
        super::encode::enc_ldp_off(Reg(11), Reg(12), Reg(31), 16),
    );
    emit(
        code,
        enc_ldp_post(Reg(9), Reg(10), Reg(31), ATOMIC_SAVE_BYTES as i32),
    );
}

/// Materialise an operand into a designated register, copying it out
/// of its allocator register when needed so the caller can clobber the
/// source. `sp_shift` accounts for the working-register save area.
fn atomic_operand_into(
    code: &mut Vec<u8>,
    value: super::super::ir::ValueId,
    target: Reg,
    frame: Frame,
    sp_shift: u32,
    alloc: &Allocation,
) -> bool {
    let place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    // An operand the allocator placed in a borrowed working register
    // (x9..x12) may already have been overwritten by an earlier
    // operand move; read its saved copy from the save area instead
    // ([sp+0]=x9 .. [sp+24]=x12, laid out by `atomic_save_working`).
    if let Place::IntReg(r) = place
        && (9..=12).contains(&r)
    {
        emit_sp_ldr_x(code, target, (r as u32 - 9) * 8);
        return true;
    }
    match materialize_int_shifted(code, place, target, frame, sp_shift) {
        Some(r) => {
            if r.0 != target.0 {
                emit_mov_reg(code, target, r);
            }
            true
        }
        None => false,
    }
}

/// Write the result `src` of an atomic op into the inst's `dst`
/// `Place`. Run after the working registers are restored so a spilled
/// result lands at the unshifted sp offset.
fn write_atomic_result(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    super::ssa::emit_common::write_atomic_result(
        &super::ssa::emit_common::Aarch64Backend,
        code,
        dst,
        src.0,
        frame,
    );
}

/// C11 7.17.7.2-7.17.7.5 atomic read-modify-write via an LDAXR / STLXR
/// retry loop (ARM ARM C6.2): load-acquire the prior value, compute the
/// new value, store-release it exclusively, and retry while the monitor
/// was lost. The acquire / release pair carries the
/// sequentially-consistent ordering. The prior value is the result.
#[allow(clippy::too_many_arguments)]
fn emit_atomic_rmw(
    code: &mut Vec<u8>,
    dst: Place,
    op: super::super::ir::AtomicRmwOp,
    addr: super::super::ir::ValueId,
    value: super::super::ir::ValueId,
    width: u8,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    use super::super::ir::AtomicRmwOp as Op;
    // x9 = addr, x10 = operand (borrowed, saved); x16 = old (result,
    // reserved so it survives the reload); x11 = new, w12 = status.
    let a = Reg(9);
    let operand = Reg(10);
    let old = scratch.primary; // x16
    let new = Reg(11);
    let status = Reg(12);
    atomic_save_working(code);
    if !atomic_operand_into(code, addr, a, frame, ATOMIC_SAVE_BYTES, alloc)
        || !atomic_operand_into(code, value, operand, frame, ATOMIC_SAVE_BYTES, alloc)
    {
        bail_msg("AtomicRmw: operand not int reg / spill");
        return false;
    }
    let loop_start = code.len();
    emit(code, enc_ldaxr(old, a, width));
    let new_reg = match op {
        Op::Xchg => operand,
        Op::Add => {
            emit(code, enc_add_reg(new, old, operand));
            new
        }
        Op::Sub => {
            emit(code, enc_sub_reg(new, old, operand));
            new
        }
        Op::And => {
            emit(code, enc_and_reg(new, old, operand));
            new
        }
        Op::Or => {
            emit(code, enc_orr_reg(new, old, operand));
            new
        }
        Op::Xor => {
            emit(code, enc_eor_reg(new, old, operand));
            new
        }
    };
    emit(code, enc_stlxr(status, new_reg, a, width));
    // cbnz w12, loop -- retry while the store-exclusive failed.
    let back = ((loop_start as i64) - (code.len() as i64)) / 4;
    emit(code, enc_cbnz(status, back as i32));
    atomic_restore_working(code);
    write_atomic_result(code, dst, old, frame);
    true
}

/// C11 7.17.7.4 atomic compare-and-exchange via an LDAXR / STLXR retry
/// loop (ARM ARM C6.2). On a match the loop store-releases `desired`
/// and the result is 1; on a mismatch the observed value is written
/// back into `*expected_addr` and the result is 0.
#[allow(clippy::too_many_arguments)]
fn emit_atomic_cas(
    code: &mut Vec<u8>,
    dst: Place,
    addr: super::super::ir::ValueId,
    expected_addr: super::super::ir::ValueId,
    desired: super::super::ir::ValueId,
    width: u8,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    // x9 = addr, x10 = expected_addr, x11 = desired (borrowed, saved);
    // x16 = cur (result, reserved); x12 = expected value; w17 = status.
    let a = Reg(9);
    let exp_addr = Reg(10);
    let desired_r = Reg(11);
    let cur = scratch.primary; // x16
    let expected = Reg(12);
    let status = scratch.secondary; // x17
    atomic_save_working(code);
    if !atomic_operand_into(code, addr, a, frame, ATOMIC_SAVE_BYTES, alloc)
        || !atomic_operand_into(
            code,
            expected_addr,
            exp_addr,
            frame,
            ATOMIC_SAVE_BYTES,
            alloc,
        )
        || !atomic_operand_into(code, desired, desired_r, frame, ATOMIC_SAVE_BYTES, alloc)
    {
        bail_msg("AtomicCas: operand not int reg / spill");
        return false;
    }
    // Load the comparand once; `*expected_addr` is a thread-local object
    // stable across the loop. Sub-width loads zero-extend, matching the
    // zero-extended LDAXR result so the 64-bit compare is exact.
    match width {
        1 => emit(code, enc_ldrb_imm(expected, exp_addr, 0)),
        2 => emit(code, enc_ldrh_imm(expected, exp_addr, 0)),
        4 => emit(code, enc_ldr32_imm(expected, exp_addr, 0)),
        _ => emit(code, enc_ldr_imm(expected, exp_addr, 0)),
    }
    let loop_start = code.len();
    emit(code, enc_ldaxr(cur, a, width));
    emit(code, enc_cmp_reg(cur, expected));
    // b.ne fail -- patched once the failure path's offset is known.
    emit(code, enc_b_cond(Cond::Ne, 0));
    let to_fail = code.len() - 4;
    emit(code, enc_stlxr(status, desired_r, a, width));
    let back = ((loop_start as i64) - (code.len() as i64)) / 4;
    emit(code, enc_cbnz(status, back as i32));
    // Success: result = 1, branch past the failure path.
    emit(code, enc_movz(cur, 1, 0));
    emit(code, enc_b(0));
    let to_done = code.len() - 4;
    // Failure: write the observed value back to *expected_addr, result = 0.
    let fail_lbl = code.len();
    let delta = ((fail_lbl - to_fail) / 4) as i32;
    code[to_fail..to_fail + 4].copy_from_slice(&enc_b_cond(Cond::Ne, delta).to_le_bytes());
    match width {
        1 => emit(code, enc_strb_imm(cur, exp_addr, 0)),
        2 => emit(code, enc_strh_imm(cur, exp_addr, 0)),
        4 => emit(code, enc_str32_imm(cur, exp_addr, 0)),
        _ => emit(code, enc_str_imm(cur, exp_addr, 0)),
    }
    emit(code, enc_movz(cur, 0, 0));
    let done_lbl = code.len();
    let delta = ((done_lbl - to_done) / 4) as i32;
    code[to_done..to_done + 4].copy_from_slice(&enc_b(delta).to_le_bytes());
    atomic_restore_working(code);
    write_atomic_result(code, dst, cur, frame);
    true
}

/// Translate a c5-stack slot index (the operand of an
/// address-of-local emit) into a byte offset relative to fp.
/// Mirror of the pool path's
use super::ssa::emit_common::c5_slot_to_fp_offset;

/// fp-relative byte offset of a c5 slot. Locals (`off < 0`) and the
/// ordinary parameter cells go through `c5_slot_to_fp_offset` at the
/// frame's cell stride. For an AAPCS64 host variadic callee (Linux
/// aarch64) the named parameters are not pushed as cdecl cells -- they
/// arrive in the argument registers and the prologue spills them into
/// the register save area above the saved fp/lr. A named-parameter
/// access (`off >= 2`, parameter index `off - 2`) is therefore
/// redirected to that parameter's slot in the save area: an integer /
/// pointer parameter to `[fp + 16 + int_rank*8]` within the 64-byte
/// general area, a floating-point parameter to
/// `[fp + 16 + 64 + fp_rank*16]` within the 128-byte vector area, where
/// the rank is the parameter's position within its argument-register
/// bank (the independent int / FP banks of AAPCS64 6.4.1). Locals are
/// unaffected.
fn local_slot_off(off: i64, frame: Frame) -> i64 {
    if off >= 2 && frame.va_named_redirect {
        let p = (off - 2) as usize;
        // Named parameters arrive per AAPCS64 6.4.1: the first eight integer
        // and eight floating-point parameters in the argument-register banks
        // (the prologue spills them into the general / vector save area), the
        // rest on the incoming stack. Use the shared planner so the redirect
        // lands on the same placement the caller produced. The save area sits
        // at `[fp + 16 .. fp + 208)`: general area (x0..x7) at
        // `[fp + 16 .. fp + 80)`, vector area (q0..q7) at `[fp + 80 ..
        // fp + 208)`; the incoming stack overflow begins at `[fp + 208 ..)`.
        let plan = super::plan_param_regs(frame.va_n_params, frame.va_param_fp_mask, frame.va_abi);
        match plan.placements.get(p) {
            Some(super::ArgPlacement::Stack(soff)) => {
                // Overflow named parameter: read from the incoming stack at
                // [fp + 208 + soff], past the register save area.
                16 + AARCH64_VA_SAVE_BYTES as i64 + *soff as i64
            }
            Some(super::ArgPlacement::FpReg(_)) => {
                let fp_rank = plan.placements[..p]
                    .iter()
                    .filter(|q| matches!(q, super::ArgPlacement::FpReg(_)))
                    .count() as i64;
                16 + AARCH64_GR_SAVE_BYTES as i64 + fp_rank * 16
            }
            _ => {
                let int_rank = plan.placements[..p]
                    .iter()
                    .filter(|q| matches!(q, super::ArgPlacement::IntReg(_)))
                    .count() as i64;
                16 + int_rank * 8
            }
        }
    } else {
        c5_slot_to_fp_offset(off, frame.param_cell_stride)
    }
}

fn emit_local_addr(code: &mut Vec<u8>, dst: Place, off: i64, frame: Frame) -> bool {
    // Materialise the address through scratch.primary when the
    // allocator chose a spill slot for this LocalAddr, then store
    // the computed value into the spill slot. Register places
    // address straight into the chosen reg.
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => Reg(16),
        _ => {
            bail_msg("LocalAddr: dst not int reg / spill");
            return false;
        }
    };
    let bytes = local_slot_off(off, frame);
    let abs = bytes.unsigned_abs();
    // Up to imm12 fits in a single add/sub-imm.
    if abs < 4096 {
        let imm = abs as u32;
        if bytes >= 0 {
            emit(code, enc_add_imm(rd, Reg(29), imm));
        } else {
            emit(code, enc_sub_imm(rd, Reg(29), imm));
        }
        spill_local_addr_to_dst(code, dst, rd, frame);
        return true;
    }
    // 24-bit reach via two add/sub-imm: shift-12 hi half + plain
    // lo half.
    if abs < (1u64 << 24) {
        let hi = abs & !0xfff;
        let lo = abs & 0xfff;
        if bytes >= 0 {
            if hi != 0 {
                emit(
                    code,
                    super::encode::enc_add_imm_lsl12(rd, Reg(29), (hi >> 12) as u32),
                );
            }
            if lo != 0 {
                let base = if hi != 0 { rd } else { Reg(29) };
                emit(code, enc_add_imm(rd, base, lo as u32));
            }
        } else {
            if hi != 0 {
                emit(
                    code,
                    super::encode::enc_sub_imm_lsl12(rd, Reg(29), (hi >> 12) as u32),
                );
            }
            if lo != 0 {
                let base = if hi != 0 { rd } else { Reg(29) };
                emit(code, enc_sub_imm(rd, base, lo as u32));
            }
        }
        spill_local_addr_to_dst(code, dst, rd, frame);
        return true;
    }
    bail_msg(&alloc::format!(
        "LocalAddr: offset {bytes} exceeds 24-bit reach"
    ));
    false
}

/// Pick the working register for a single-result int inst:
/// the allocator's chosen reg when it picked one, or
/// `scratch.primary` when the result will land in a spill slot.
/// FpReg / None destinations return `None` so the caller can
/// bail.
fn int_or_spill_scratch(dst: Place, scratch: &ScratchPool) -> Option<Reg> {
    match dst {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(_) => Some(scratch.primary),
        Place::FpReg(_) | Place::None => None,
    }
}

/// Persist the just-computed LocalAddr value into its spill slot
/// when the allocator placed it there. No-op for register places
/// (the address already landed in the chosen reg).
fn spill_local_addr_to_dst(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        // `emit_local_addr` already chose `src` from the scratch pool;
        // the other scratch carries the base when the slot is beyond
        // the scaled-imm12 reach.
        let addr_scratch = if src.0 == 16 { Reg(17) } else { Reg(16) };
        emit_sp_str_x(code, src, sp_off, addr_scratch);
    }
}

/// Materialize the per-frame alloca-arena bookkeeping slot address
/// (`fp - top_offset`) into `reg`. Mirrors the `AllocaInit` /
/// `Alloca` address computation for the VLA save / restore ops.
fn emit_arena_top_addr(code: &mut Vec<u8>, reg: Reg, top_offset: u32) {
    if top_offset < 4096 {
        emit(code, enc_sub_imm(reg, Reg(29), top_offset));
    } else {
        let high = top_offset & !0xfff;
        let low = top_offset & 0xfff;
        emit(
            code,
            super::encode::enc_sub_imm_lsl12(reg, Reg(29), high >> 12),
        );
        if low != 0 {
            emit(code, enc_sub_imm(reg, reg, low));
        }
    }
}

/// `Inst::Extend { value, kind }` -- sign-extend the low bytes of a
/// GPR value to 64 bits via the `SXTB` / `SXTH` / `SXTW` aliases.
fn emit_extend(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    kind: LoadKind,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    let src_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match materialize_int(code, src_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rd = match int_or_spill_scratch(dst, scratch) {
        Some(r) => r,
        None => {
            bail_msg("Extend: dst not int reg / spill");
            return false;
        }
    };
    let enc = match kind {
        LoadKind::I8 => super::encode::enc_sxtb(rd, rn),
        LoadKind::I16 => super::encode::enc_sxth(rd, rn),
        LoadKind::I32 => super::encode::enc_sxtw(rd, rn),
        _ => {
            bail_msg("Extend: unsupported kind");
            return false;
        }
    };
    emit(code, enc);
    spill_local_addr_to_dst(code, dst, rd, frame);
    true
}

fn emit_load(
    code: &mut Vec<u8>,
    dst: Place,
    addr: u32,
    disp: i32,
    kind: LoadKind,
    keep_f32: bool,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    // `disp` is a byte offset folded from a constant pointer addition.
    // index_fold only emits a displacement that is a multiple of the
    // access width and within the scaled-immediate range, so it passes
    // straight to the immediate-offset encoders below.
    let disp = disp as u32;
    let addr_place = alloc
        .places
        .get(addr as usize)
        .copied()
        .unwrap_or(Place::None);
    let rn = match materialize_int(code, addr_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    // F32 loads read into the s-view of a v-register. When the value is
    // single-precision (C99 6.3.1.8), it stays f32 (no widen). The
    // archive-reload path (lift_program) leaves the value untagged and
    // consumes it as f64, so widen via `fcvt Dd, Sn` there.
    if let LoadKind::F32 = kind {
        let dd = match dst {
            Place::FpReg(r) => r,
            // A spilled f32 / f64 stages through a reserved scratch
            // d-reg outside the allocator's d0..d15 pool; d0 may hold a
            // live value the caller still needs.
            Place::Spill(_) => SCRATCH_FP0,
            _ => {
                bail_msg("Load F32: dst not fp reg / spill");
                return false;
            }
        };
        emit(code, enc_ldr_s_imm(dd, rn, disp));
        if !keep_f32 {
            emit(code, enc_fcvt_d_s(dd, dd));
        }
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_d_auto(code, dd, sp_off);
        }
        return true;
    }
    if let LoadKind::F64 = kind {
        // `double` lvalue: a single 8-byte FP load into a d-reg.
        let dd = match dst {
            Place::FpReg(r) => r,
            Place::Spill(_) => SCRATCH_FP0,
            _ => {
                bail_msg("Load F64: dst not fp reg / spill");
                return false;
            }
        };
        emit(code, enc_ldr_d_imm(dd, rn, disp));
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_d_auto(code, dd, sp_off);
        }
        return true;
    }
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return false,
    };
    match kind {
        LoadKind::I64 => emit(code, enc_ldr_imm(rd, rn, disp)),
        LoadKind::I32 => emit(code, enc_ldrsw_imm(rd, rn, disp)),
        LoadKind::U32 => emit(code, enc_ldr32_imm(rd, rn, disp)),
        LoadKind::I16 => emit(code, enc_ldrsh_imm(rd, rn, disp)),
        LoadKind::U16 => emit(code, enc_ldrh_imm(rd, rn, disp)),
        LoadKind::I8 => emit(code, enc_ldrsb_imm(rd, rn, disp)),
        LoadKind::U8 => emit(code, enc_ldrb_imm(rd, rn, disp)),
        LoadKind::F32 | LoadKind::F64 => unreachable!(),
    }
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit_sp_str_x_auto(code, rd, sp_off);
    }
    true
}

/// Single-instruction fp-relative load for `Inst::LoadLocal`.
/// The c5 slot offset converts to a signed byte displacement;
/// `ldur` covers the unscaled 9-bit field `[-256, 255]`
/// directly. Falls back to the general path when the
/// displacement doesn't fit.
fn emit_load_local(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    kind: LoadKind,
    keep_f32: bool,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    // F32 reads into the s-view of a v-register. A single-precision
    // value (C99 6.3.1.8) stays f32; the archive-reload path leaves it
    // untagged and widens to f64 via `fcvt Dd, Sn`.
    if matches!(kind, LoadKind::F32) {
        let dd = match dst {
            Place::FpReg(r) => r,
            // Stage a spilled load through a reserved scratch d-reg
            // outside the allocator's d0..d15 pool; d0 may hold a
            // live value the caller still needs.
            Place::Spill(_) => SCRATCH_FP0,
            _ => {
                bail_msg("LoadLocal F32: dst not fp reg / spill");
                return false;
            }
        };
        let bytes = local_slot_off(off, frame);
        if let Ok(disp) = i32::try_from(bytes)
            && disp >= 0
            && (disp as u32).is_multiple_of(4)
            && (disp as u32) <= 16380
        {
            emit(code, super::encode::enc_ldr_s_imm(dd, Reg(29), disp as u32));
        } else if !emit_local_addr(code, Place::IntReg(scratch.primary.0), off, frame) {
            return false;
        } else {
            emit(code, super::encode::enc_ldr_s_imm(dd, scratch.primary, 0));
        }
        if !keep_f32 {
            emit(code, super::encode::enc_fcvt_d_s(dd, dd));
        }
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_d_auto(code, dd, sp_off);
        }
        return true;
    }
    if matches!(kind, LoadKind::F64) {
        // `double` local: a single 8-byte FP load; no widen.
        let dd = match dst {
            Place::FpReg(r) => r,
            Place::Spill(_) => SCRATCH_FP0,
            _ => {
                bail_msg("LoadLocal F64: dst not fp reg / spill");
                return false;
            }
        };
        let bytes = local_slot_off(off, frame);
        if let Ok(disp) = i32::try_from(bytes)
            && disp >= 0
            && (disp as u32).is_multiple_of(8)
            && (disp as u32) < 32760
        {
            emit(code, super::encode::enc_ldr_d_imm(dd, Reg(29), disp as u32));
        } else if !emit_local_addr(code, Place::IntReg(scratch.primary.0), off, frame) {
            return false;
        } else {
            emit(code, super::encode::enc_ldr_d_imm(dd, scratch.primary, 0));
        }
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_d_auto(code, dd, sp_off);
        }
        return true;
    }
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return false,
    };
    let bytes = local_slot_off(off, frame);
    if let Ok(disp) = i32::try_from(bytes)
        && (-256..256).contains(&disp)
    {
        // Fits the unscaled 9-bit signed field; load directly
        // with the kind-specific unscaled encoder.
        let word = match kind {
            LoadKind::I64 => super::encode::enc_ldur(rd, Reg(29), disp),
            LoadKind::I32 => super::encode::enc_ldursw(rd, Reg(29), disp),
            LoadKind::U32 => super::encode::enc_ldur32(rd, Reg(29), disp),
            LoadKind::I16 => super::encode::enc_ldursh(rd, Reg(29), disp),
            LoadKind::U16 => super::encode::enc_ldurh(rd, Reg(29), disp),
            LoadKind::I8 => super::encode::enc_ldursb(rd, Reg(29), disp),
            LoadKind::U8 => super::encode::enc_ldurb(rd, Reg(29), disp),
            LoadKind::F32 | LoadKind::F64 => unreachable!(),
        };
        emit(code, word);
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_x_auto(code, rd, sp_off);
        }
        return true;
    }
    // Large displacement: materialise the address into a scratch
    // through the standard `LocalAddr` lowering, then load
    // through it. Same byte cost as the unfused path.
    if !emit_local_addr(code, Place::IntReg(scratch.primary.0), off, frame) {
        return false;
    }
    let word = match kind {
        LoadKind::I64 => super::encode::enc_ldr_imm(rd, scratch.primary, 0),
        LoadKind::I32 => super::encode::enc_ldrsw_imm(rd, scratch.primary, 0),
        LoadKind::U32 => super::encode::enc_ldr32_imm(rd, scratch.primary, 0),
        LoadKind::I16 => super::encode::enc_ldrsh_imm(rd, scratch.primary, 0),
        LoadKind::U16 => super::encode::enc_ldrh_imm(rd, scratch.primary, 0),
        LoadKind::I8 => super::encode::enc_ldrsb_imm(rd, scratch.primary, 0),
        LoadKind::U8 => super::encode::enc_ldrb_imm(rd, scratch.primary, 0),
        LoadKind::F32 | LoadKind::F64 => unreachable!(),
    };
    emit(code, word);
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit_sp_str_x_auto(code, rd, sp_off);
    }
    true
}

/// Single-instruction fp-relative store for `Inst::StoreLocal`.
/// Mirrors [`emit_load_local`].
fn emit_store_local(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    if matches!(kind, StoreKind::F32) {
        // `float` local store. A single-precision value (C99 6.3.1.8)
        // is already an f32 in the s-view (`str s`, no narrow); a wider
        // f64 value narrows via `fcvt Sd, Dn` first. Mirrors the
        // `Store` F32 path so a mem2reg-promoted slot round-trips
        // identically to the prior address-taken `LocalAddr + Store`.
        let value_place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        // `str s` takes the byte offset scaled by 4; the slot offset is
        // 4-aligned. A displacement past the unsigned-offset range falls
        // back to materialising the address in a scratch register.
        let store_to_slot = |code: &mut Vec<u8>, sn: u8| -> bool {
            let bytes = local_slot_off(off, frame);
            if let Ok(disp) = i32::try_from(bytes)
                && disp >= 0
                && (disp as u32).is_multiple_of(4)
                && (disp as u32) < 16380
            {
                emit(code, super::encode::enc_str_s_imm(sn, Reg(29), disp as u32));
                true
            } else if !emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, frame) {
                false
            } else {
                emit(code, super::encode::enc_str_s_imm(sn, scratch.secondary, 0));
                true
            }
        };
        if alloc.is_f32(value) {
            let sn = match materialize_fp_f32(code, value_place, SCRATCH_FP0, frame) {
                Some(r) => r,
                None => {
                    bail_msg("StoreLocal F32: value not fp reg / spill");
                    return false;
                }
            };
            if !store_to_slot(code, sn) {
                return false;
            }
            if let Some(rd) = fp_reg(dst) {
                if rd != sn {
                    emit(code, super::encode::enc_fmov_s_s(rd, sn));
                }
            } else if let Place::Spill(slot) = dst {
                emit_sp_str_d_auto(code, sn, spill_off(frame, slot));
            }
            return true;
        }
        // Wider f64 value: narrow into SCRATCH_FP1 (outside the d0..d15
        // pool) so an allocator-held source d-reg whose f64 value is
        // still live is not clobbered by the S-view write.
        let dn = match value_place {
            Place::FpReg(r) => r,
            Place::IntReg(_) | Place::Spill(_) => {
                let rs = match materialize_int(code, value_place, scratch.secondary, frame) {
                    Some(r) => r,
                    None => return false,
                };
                emit(code, enc_fmov_x_to_d(SCRATCH_FP0, rs));
                SCRATCH_FP0
            }
            Place::None => {
                bail_msg("StoreLocal F32: value None");
                return false;
            }
        };
        emit(code, super::encode::enc_fcvt_s_d(SCRATCH_FP1, dn));
        if !store_to_slot(code, SCRATCH_FP1) {
            return false;
        }
        if let Some(rd) = fp_reg(dst) {
            if rd != dn {
                emit(code, enc_fmov_d_to_x(scratch.primary, dn));
                emit(code, enc_fmov_x_to_d(rd, scratch.primary));
            }
        } else if let Place::Spill(slot) = dst {
            emit_sp_str_d_auto(code, dn, spill_off(frame, slot));
        }
        return true;
    }
    if matches!(kind, StoreKind::F64) {
        // `double` local store: a single 8-byte FP store; no narrow.
        let value_place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        let Some(dn) = materialize_fp(code, value_place, SCRATCH_FP0, frame) else {
            bail_msg("StoreLocal F64: value not fp reg / spill / int reg");
            return false;
        };
        let bytes = local_slot_off(off, frame);
        if let Ok(disp) = i32::try_from(bytes)
            && disp >= 0
            && (disp as u32).is_multiple_of(8)
            && (disp as u32) < 32760
        {
            emit(code, super::encode::enc_str_d_imm(dn, Reg(29), disp as u32));
        } else if !emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, frame) {
            return false;
        } else {
            emit(code, super::encode::enc_str_d_imm(dn, scratch.secondary, 0));
        }
        // c5 store-op leaves the value in the accumulator; propagate
        // to dst if the allocator parked it elsewhere.
        match dst {
            Place::FpReg(r) if r != dn => {
                emit(code, super::encode::enc_fmov_d_d(r, dn));
            }
            Place::Spill(slot) => {
                let sp_off = spill_off(frame, slot);
                emit_sp_str_d_auto(code, dn, sp_off);
            }
            _ => {}
        }
        return true;
    }
    let value_place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    // Materialise the value first; the address path below picks a
    // scratch register based on whether the displacement fits the
    // unscaled 9-bit field. c5 spills an FP-typed accumulator into
    // a local temp through the store-local path (the bit pattern
    // fits 8 bytes
    // regardless of type), so an FpReg value bridges through
    // `fmov d -> x` into a GPR before the store; otherwise it
    // routes through the normal int materialisation.
    let rv = if let Place::FpReg(dr) = value_place {
        emit(code, super::encode::enc_fmov_d_to_x(scratch.primary, dr));
        scratch.primary
    } else {
        match materialize_int(code, value_place, scratch.primary, frame) {
            Some(r) => r,
            None => return false,
        }
    };
    let bytes = local_slot_off(off, frame);
    if let Ok(disp) = i32::try_from(bytes) {
        if (-256..256).contains(&disp) {
            // Store the low `kind`-width bytes; the accumulator below
            // keeps the full source value, matching the c5 rule that
            // an assignment expression yields the stored value before
            // any re-narrowing on read-back (C99 6.5.16p3).
            let enc = match kind {
                StoreKind::I64 => super::encode::enc_stur(rv, Reg(29), disp),
                StoreKind::I32 => super::encode::enc_stur32(rv, Reg(29), disp),
                StoreKind::I16 => super::encode::enc_sturh(rv, Reg(29), disp),
                StoreKind::I8 => super::encode::enc_sturb(rv, Reg(29), disp),
                StoreKind::F32 | StoreKind::F64 => unreachable!(),
            };
            emit(code, enc);
        } else if !emit_store_local_large_disp(code, off, rv, kind, scratch, frame) {
            return false;
        }
    } else if !emit_store_local_large_disp(code, off, rv, kind, scratch, frame) {
        return false;
    }
    // c5 store ops leave the stored value in the accumulator;
    // propagate to dst if the allocator parked it elsewhere.
    match dst {
        Place::IntReg(r) => {
            let rd = Reg(r);
            if rd.0 != rv.0 {
                emit_mov_reg(code, rd, rv);
            }
        }
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_x_auto(code, rv, sp_off);
        }
        Place::None => {}
        Place::FpReg(_) => return false,
    }
    true
}

/// Address-via-scratch fallback for [`emit_store_local`] when the
/// fp displacement exceeds the unscaled 9-bit field.
fn emit_store_local_large_disp(
    code: &mut Vec<u8>,
    off: i64,
    rv: Reg,
    kind: StoreKind,
    scratch: &ScratchPool,
    frame: Frame,
) -> bool {
    if !emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, frame) {
        return false;
    }
    let enc = match kind {
        StoreKind::I64 => super::encode::enc_str_imm(rv, scratch.secondary, 0),
        StoreKind::I32 => super::encode::enc_str32_imm(rv, scratch.secondary, 0),
        StoreKind::I16 => super::encode::enc_strh_imm(rv, scratch.secondary, 0),
        StoreKind::I8 => super::encode::enc_strb_imm(rv, scratch.secondary, 0),
        StoreKind::F32 | StoreKind::F64 => unreachable!(),
    };
    emit(code, enc);
    true
}

/// Lower `Inst::LoadIndexed`: `dst = *(kind*)(base + index * scale)`.
/// Emitted as one scaled-indexed load (`ldr Xt, [Xn, Xm, lsl #N]`)
/// when `scale` matches the natural width of `kind`. F32 indexed
/// loads aren't a shape the walker produces today (no `float arr[]`
/// access path goes through the indexed fold yet); the FP variant
/// would need a separate `ldr St, [Xn, Xm, lsl #2]` + `fcvt d, s`.
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
    scratch: &ScratchPool,
) -> bool {
    if matches!(kind, LoadKind::F32 | LoadKind::F64) {
        bail_msg("LoadIndexed: FP not implemented");
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
    let rn = match materialize_int(code, base_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rm = match materialize_int(code, index_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return false,
    };
    let expected_scale: u8 = match kind {
        LoadKind::I64 => 8,
        LoadKind::I32 | LoadKind::U32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::F32 | LoadKind::F64 => unreachable!(),
    };
    if scale != expected_scale {
        bail_msg("LoadIndexed: scale doesn't match access width");
        return false;
    }
    let word = match kind {
        LoadKind::I64 => super::encode::enc_ldr_reg_lsl3(rd, rn, rm),
        LoadKind::I32 => super::encode::enc_ldrsw_reg_lsl2(rd, rn, rm),
        LoadKind::U32 => super::encode::enc_ldr32_reg_lsl2(rd, rn, rm),
        LoadKind::I16 => super::encode::enc_ldrsh_reg_lsl1(rd, rn, rm),
        LoadKind::U16 => super::encode::enc_ldrh_reg_lsl1(rd, rn, rm),
        LoadKind::I8 => super::encode::enc_ldrsb_reg(rd, rn, rm),
        LoadKind::U8 => super::encode::enc_ldrb_reg(rd, rn, rm),
        LoadKind::F32 | LoadKind::F64 => unreachable!(),
    };
    emit(code, word);
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit_sp_str_x_auto(code, rd, sp_off);
    }
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
    scratch: &ScratchPool,
) -> bool {
    if matches!(kind, StoreKind::F32 | StoreKind::F64) {
        bail_msg("StoreIndexed: FP not implemented");
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
    let rn = match materialize_int(code, base_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rm = match materialize_int(code, index_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return false,
    };
    let expected_scale: u8 = match kind {
        StoreKind::I64 => 8,
        StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        StoreKind::F32 | StoreKind::F64 => unreachable!(),
    };
    if scale != expected_scale {
        bail_msg("StoreIndexed: scale doesn't match access width");
        return false;
    }
    // The store needs three registers -- base, index, value -- but only
    // two scratch registers exist. Pick a scratch for the value that
    // collides with neither base nor index; when a spilled base and
    // index occupy both, fold the index into the base so the
    // register-offset form is no longer needed and a scratch frees up.
    let vscratch;
    let addr_reg; // Some(addr) selects the plain `[addr]` store.
    if scratch.primary != rn && scratch.primary != rm {
        vscratch = scratch.primary;
        addr_reg = None;
    } else if scratch.secondary != rn && scratch.secondary != rm {
        vscratch = scratch.secondary;
        addr_reg = None;
    } else {
        let shift = scale.trailing_zeros();
        emit(
            code,
            super::encode::enc_add_reg_lsl(scratch.primary, rn, rm, shift),
        );
        addr_reg = Some(scratch.primary);
        vscratch = scratch.secondary;
    }
    // Reuse the FP-bridge path from `emit_store_local` for the
    // I64-store-of-FpReg shape.
    let rv = if let StoreKind::I64 = kind
        && let Place::FpReg(dr) = value_place
    {
        emit(code, super::encode::enc_fmov_d_to_x(vscratch, dr));
        vscratch
    } else {
        match materialize_int(code, value_place, vscratch, frame) {
            Some(r) => r,
            None => return false,
        }
    };
    let word = match (kind, addr_reg) {
        (StoreKind::I64, None) => super::encode::enc_str_reg_lsl3(rv, rn, rm),
        (StoreKind::I32, None) => super::encode::enc_str32_reg_lsl2(rv, rn, rm),
        (StoreKind::I16, None) => super::encode::enc_strh_reg_lsl1(rv, rn, rm),
        (StoreKind::I8, None) => super::encode::enc_strb_reg(rv, rn, rm),
        (StoreKind::I64, Some(a)) => super::encode::enc_str_imm(rv, a, 0),
        (StoreKind::I32, Some(a)) => super::encode::enc_str32_imm(rv, a, 0),
        (StoreKind::I16, Some(a)) => super::encode::enc_strh_imm(rv, a, 0),
        (StoreKind::I8, Some(a)) => super::encode::enc_strb_imm(rv, a, 0),
        (StoreKind::F32 | StoreKind::F64, _) => unreachable!(),
    };
    emit(code, word);
    // c5 store-op leaves the stored value in the accumulator.
    match dst {
        Place::IntReg(r) => {
            let rd = Reg(r);
            if rd.0 != rv.0 {
                emit_mov_reg(code, rd, rv);
            }
        }
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_x_auto(code, rv, sp_off);
        }
        Place::None => {}
        Place::FpReg(_) => return false,
    }
    true
}

fn emit_store(
    code: &mut Vec<u8>,
    dst: Place,
    addr: u32,
    disp: i32,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    // `disp` is a width-aligned, in-range byte offset folded from a
    // constant pointer addition; it passes straight to the immediate-
    // offset store encoders.
    let disp = disp as u32;
    // The c5 store ops leave the stored value in the accumulator
    // afterward, so `dst` may be a register or spill slot the
    // allocator wants the value parked in. We compute the value
    // in a register, store it through the address, then copy to
    // dst if it isn't already there.
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
    let rn = match materialize_int(code, addr_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    if let StoreKind::F32 = kind {
        // C99 6.3.1.8 / 6.3.1.5: a single-precision value is already an
        // f32 in the s-view, so store it directly (`str s`, no narrow).
        // A double value (the archive-reload boundary, or a `double`
        // assigned to a `float` lvalue the walker didn't pre-narrow) is
        // narrowed via `fcvt Sd, Dn` first.
        if alloc.is_f32(value) {
            let sn = match materialize_fp_f32(code, value_place, SCRATCH_FP0, frame) {
                Some(r) => r,
                None => return false,
            };
            emit(code, enc_str_s_imm(sn, rn, disp));
            // Propagate the f32 accumulator to `dst` if parked elsewhere.
            if let Some(rd) = fp_reg(dst) {
                if rd != sn {
                    emit(code, super::encode::enc_fmov_s_s(rd, sn));
                }
            } else if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit_sp_str_d_auto(code, sn, sp_off);
            }
            return true;
        }
        // Stage the value as a d-reg holding the f64 pattern.
        // For an FpReg source the materialise already gives us
        // that; for an IntReg / Spill the source register holds
        // the int-encoded f64 bit pattern (c5's Imm path), so
        // an fmov x->d reinterprets the bits as f64.
        let dn = match value_place {
            Place::FpReg(r) => r,
            Place::IntReg(_) | Place::Spill(_) => {
                let rs = match materialize_int(code, value_place, scratch.secondary, frame) {
                    Some(r) => r,
                    None => return false,
                };
                emit(code, enc_fmov_x_to_d(SCRATCH_FP0, rs));
                SCRATCH_FP0
            }
            Place::None => return false,
        };
        // Narrow into SCRATCH_FP1 (d17, outside the allocator's d0..d15
        // pool) so dn -- which may be an allocator-held d-reg whose f64
        // value is still live across this store -- is not clobbered.
        // `fcvt Sd, Dn` writes the S view and zeroes the rest of the
        // V register, so narrowing in place over a pooled register
        // would destroy a value the surrounding code still reads.
        emit(code, enc_fcvt_s_d(SCRATCH_FP1, dn));
        emit(code, enc_str_s_imm(SCRATCH_FP1, rn, disp));
        if let Some(rd) = fp_reg(dst) {
            if rd != dn {
                emit(code, enc_fmov_d_to_x(scratch.primary, dn));
                emit(code, enc_fmov_x_to_d(rd, scratch.primary));
            }
        } else if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_d_auto(code, dn, sp_off);
        }
        return true;
    }
    if let StoreKind::F64 = kind {
        // `double` lvalue store: a single 8-byte FP store; no narrow.
        let Some(dn) = materialize_fp(code, value_place, SCRATCH_FP0, frame) else {
            return false;
        };
        emit(code, super::encode::enc_str_d_imm(dn, rn, disp));
        if let Some(rd) = fp_reg(dst) {
            if rd != dn {
                emit(code, super::encode::enc_fmov_d_d(rd, dn));
            }
        } else if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_d_auto(code, dn, sp_off);
        }
        return true;
    }
    // For an I64 store whose value lives in an FpReg (c5's f64
    // store path uses StoreKind::I64 to write 8 raw bytes), bridge
    // d-reg -> GPR via fmov. Lower-width stores from an FpReg
    // aren't a shape c5 emits.
    let rs = if let StoreKind::I64 = kind
        && let Place::FpReg(dr) = value_place
    {
        emit(code, enc_fmov_d_to_x(scratch.secondary, dr));
        scratch.secondary
    } else {
        match materialize_int(code, value_place, scratch.secondary, frame) {
            Some(r) => r,
            None => return false,
        }
    };
    match kind {
        StoreKind::I64 => emit(code, enc_str_imm(rs, rn, disp)),
        StoreKind::I32 => emit(code, enc_str32_imm(rs, rn, disp)),
        StoreKind::I16 => emit(code, enc_strh_imm(rs, rn, disp)),
        StoreKind::I8 => emit(code, enc_strb_imm(rs, rn, disp)),
        StoreKind::F32 | StoreKind::F64 => {
            unreachable!("FP store handled in the FP branch above")
        }
    }
    if let Some(rd) = int_reg(dst) {
        if rd.0 != rs.0 {
            emit_mov_reg(code, rd, rs);
        }
    } else if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit_sp_str_x_auto(code, rs, sp_off);
    }
    true
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
    scratch: &ScratchPool,
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
    // FP arithmetic + comparison branch. Both operands live in
    // d-regs; arithmetic produces a d-reg; comparisons produce a
    // GPR (cset). The scratch d-regs (d0 / d1) reload spilled
    // operands; the matching int scratch slots aren't disturbed
    // because no int materialisation runs in this branch.
    if fp_arith_enc(op).is_some() {
        // C99 6.3.1.8: pick the single- vs double-precision encoder by
        // the result's width. A `float op float` result is f32 and the
        // operands are themselves f32; a `double` result is f64.
        let is_f32 = alloc.is_f32(v);
        let dn = match materialize_fp_for(code, lhs, lhs_place, SCRATCH_FP0, frame, alloc) {
            Some(r) => r,
            None => return false,
        };
        let dm = match materialize_fp_for(code, rhs, rhs_place, SCRATCH_FP1, frame, alloc) {
            Some(r) => r,
            None => return false,
        };
        let dd = match dst {
            Place::FpReg(r) => r,
            // Stage a spilled result through a reserved scratch d-reg
            // outside the allocator's d0..d15 pool; d0 may hold a live
            // value the caller still needs. `arith` reads dn / dm
            // before writing dd, so reusing SCRATCH_FP0 (a possible
            // operand source) is safe.
            Place::Spill(_) => SCRATCH_FP0,
            _ => return false,
        };
        let word = if is_f32 {
            match op {
                BinOp::Fadd => super::encode::enc_fadd_s(dd, dn, dm),
                BinOp::Fsub => super::encode::enc_fsub_s(dd, dn, dm),
                BinOp::Fmul => super::encode::enc_fmul_s(dd, dn, dm),
                BinOp::Fdiv => super::encode::enc_fdiv_s(dd, dn, dm),
                _ => return false,
            }
        } else {
            match op {
                BinOp::Fadd => enc_fadd_d(dd, dn, dm),
                BinOp::Fsub => enc_fsub_d(dd, dn, dm),
                BinOp::Fmul => enc_fmul_d(dd, dn, dm),
                BinOp::Fdiv => enc_fdiv_d(dd, dn, dm),
                _ => return false,
            }
        };
        emit(code, word);
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_d_auto(code, dd, sp_off);
        }
        return true;
    }
    if let Some(cond) = fp_compare_cond(op) {
        // The compare width follows the operands' precision: two f32
        // operands use `fcmp Sn, Sm`, else `fcmp Dn, Dm`.
        let is_f32 = alloc.is_f32(lhs) || alloc.is_f32(rhs);
        let dn = match materialize_fp_for(code, lhs, lhs_place, SCRATCH_FP0, frame, alloc) {
            Some(r) => r,
            None => return false,
        };
        let dm = match materialize_fp_for(code, rhs, rhs_place, SCRATCH_FP1, frame, alloc) {
            Some(r) => r,
            None => return false,
        };
        let rd = match dst {
            Place::IntReg(r) => Reg(r),
            Place::Spill(_) => scratch.primary,
            _ => return false,
        };
        if is_f32 {
            emit(code, enc_fcmp_s(dn, dm));
        } else {
            emit(code, enc_fcmp_d(dn, dm));
        }
        emit(code, enc_cset(rd, cond));
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_x_auto(code, rd, sp_off);
        }
        return true;
    }
    // Integer binop path. The result lands in a GPR; if the
    // allocator picked a spill slot, route through
    // `scratch.primary` and store afterwards. Using
    // scratch.primary as the rd is safe even when the lhs
    // materialise wrote it there: `add rd, rn, rm` reads rn
    // before writing rd, so a self-aliasing destination doesn't
    // corrupt the operand.
    let (rd, spill_to) = match dst {
        Place::IntReg(r) => (Reg(r), None),
        Place::Spill(slot) => (scratch.primary, Some(slot)),
        _ => return false,
    };
    // sxtw / sxth / sxtb fold for the walker-shape sign-narrow
    // pair `Binop(Shl, X, Imm(K)); Binop(Shr, _, Imm(K))`. The
    // allocator marked this Shr and stashed the K (32 / 48 / 56);
    // emit one sign-extend instead of two shifts.
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
        let rn = match materialize_int(code, src_place, scratch.primary, frame) {
            Some(r) => r,
            None => return false,
        };
        let k = alloc.sxtw_k.get(v as usize).copied().unwrap_or(0);
        let word = match k {
            32 => super::encode::enc_sxtw(rd, rn),
            48 => super::encode::enc_sxth(rd, rn),
            56 => super::encode::enc_sxtb(rd, rn),
            _ => return false,
        };
        emit(code, word);
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_x_auto(code, rd, sp_off);
        }
        return true;
    }
    let rn = match materialize_int(code, lhs_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    let rm = match materialize_int(code, rhs_place, scratch.secondary, frame) {
        Some(r) => r,
        None => return false,
    };
    if let Some(cond) = compare_cond(op) {
        emit(code, enc_cmp_reg(rn, rm));
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        emit(code, enc_cset(rd, cond));
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_x_auto(code, rd, sp_off);
        }
        return true;
    }
    if matches!(op, BinOp::Mod | BinOp::Modu) {
        // rem = rn - (rn / rm) * rm. The msub reads the dividend (rn)
        // and divisor (rm), so the quotient must occupy a register
        // distinct from both. A spilled operand was materialised into
        // a scratch register, so the quotient cannot blindly reuse
        // `scratch.secondary` -- when the divisor is spilled it sits
        // there, and the divide would overwrite it before the msub
        // reads it. Pick a free scratch or the result register that
        // aliases neither operand.
        // x19 is reserved by the prologue for a spilling function that
        // contains a modulo, so it is a safe third scratch when the
        // dividend, divisor and result all occupy the other registers.
        let quot = [scratch.secondary, scratch.primary, rd, Reg(19)]
            .into_iter()
            .find(|r| r.0 != rn.0 && r.0 != rm.0)
            .unwrap_or(Reg(19));
        let divider = if matches!(op, BinOp::Mod) {
            enc_sdiv(quot, rn, rm)
        } else {
            enc_udiv(quot, rn, rm)
        };
        emit(code, divider);
        emit(code, enc_msub(rd, quot, rm, rn));
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_x_auto(code, rd, sp_off);
        }
        return true;
    }
    let word = match op {
        BinOp::Add => enc_add_reg(rd, rn, rm),
        BinOp::Sub => enc_sub_reg(rd, rn, rm),
        BinOp::Mul => enc_mul(rd, rn, rm),
        BinOp::Div => enc_sdiv(rd, rn, rm),
        BinOp::Divu => enc_udiv(rd, rn, rm),
        BinOp::And => enc_and_reg(rd, rn, rm),
        BinOp::Or => enc_orr_reg(rd, rn, rm),
        BinOp::Xor => enc_eor_reg(rd, rn, rm),
        BinOp::Shl => enc_lslv(rd, rn, rm),
        BinOp::Shr => enc_asrv(rd, rn, rm),
        BinOp::Shru => enc_lsrv(rd, rn, rm),
        BinOp::Ror => super::encode::enc_rorv(rd, rn, rm),
        _ => return false,
    };
    emit(code, word);
    if let Some(slot) = spill_to {
        let sp_off = spill_off(frame, slot);
        emit_sp_str_x_auto(code, rd, sp_off);
    }
    true
}

/// Map an FP arithmetic binop to its d-reg encoder. Returns
/// `None` for non-arithmetic ops so the caller can try the
/// comparison or integer paths.
fn fp_arith_enc(op: BinOp) -> Option<fn(u8, u8, u8) -> u32> {
    Some(match op {
        BinOp::Fadd => enc_fadd_d,
        BinOp::Fsub => enc_fsub_d,
        BinOp::Fmul => enc_fmul_d,
        BinOp::Fdiv => enc_fdiv_d,
        _ => return None,
    })
}

/// Map an FP comparison binop to the AArch64 condition code the
/// matching fcmp + cset pair should use. Returns `None` for any
/// non-FP-compare op.
fn fp_compare_cond(op: BinOp) -> Option<Cond> {
    Some(match op {
        BinOp::Feq => Cond::Eq,
        BinOp::Fne => Cond::Ne,
        BinOp::Flt => Cond::Mi,
        BinOp::Fgt => Cond::Gt,
        BinOp::Fle => Cond::Ls,
        BinOp::Fge => Cond::Ge,
        _ => return None,
    })
}

/// Map a comparison binop to the matching `Cond` for the
/// cmp / cset pair.
fn compare_cond(op: BinOp) -> Option<Cond> {
    Some(match op {
        BinOp::Eq => Cond::Eq,
        BinOp::Ne => Cond::Ne,
        BinOp::Lt => Cond::Lt,
        BinOp::Gt => Cond::Gt,
        BinOp::Le => Cond::Le,
        BinOp::Ge => Cond::Ge,
        BinOp::Ult => Cond::Lo,
        BinOp::Ugt => Cond::Hi,
        BinOp::Ule => Cond::Ls,
        BinOp::Uge => Cond::Hs,
        _ => return None,
    })
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
    scratch: &ScratchPool,
) -> bool {
    let (rd, spill_to) = match dst {
        Place::IntReg(r) => (Reg(r), None),
        Place::Spill(slot) => (scratch.primary, Some(slot)),
        _ => return false,
    };
    let lhs_place = alloc
        .places
        .get(lhs as usize)
        .copied()
        .unwrap_or(Place::None);
    // sxtw / sxth / sxtb fold: the allocator pre-flagged this
    // `BinopI(Shr, _, K)` as the upper half of a sign-narrow pair
    // (`Shl K; Shr K`). The matching Shl was decremented to zero
    // uses and DCE'd; we emit a single sign-extend whose source is
    // the Shl's lhs (the original pre-narrow value).
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
        let rn = match materialize_int(code, src_place, scratch.primary, frame) {
            Some(r) => r,
            None => return false,
        };
        let word = match rhs_imm {
            32 => super::encode::enc_sxtw(rd, rn),
            48 => super::encode::enc_sxth(rd, rn),
            56 => super::encode::enc_sxtb(rd, rn),
            _ => unreachable!(),
        };
        emit(code, word);
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_x_auto(code, rd, sp_off);
        }
        return true;
    }
    let rn = match materialize_int(code, lhs_place, scratch.primary, frame) {
        Some(r) => r,
        None => return false,
    };
    // Per-op peepholes for immediate-form binops. Avoid the
    // `load_imm64 -> reg-form op` pair when the immediate fits a
    // direct encoding.
    //   * Shl / Shr / Shru by 0..63 -> single-op LSL / ASR / LSR
    //     by immediate (UBFM / SBFM aliases).
    //   * Mul by a power of two in 0..63 -> LSL by log2.
    //   * Add / Sub with 12-bit imm -> direct enc_add_imm /
    //     enc_sub_imm.
    let imm_u64 = rhs_imm as u64;
    let imm_pow2_shift = if rhs_imm > 0 && imm_u64.is_power_of_two() {
        let s = imm_u64.trailing_zeros();
        if s < 64 { Some(s as u8) } else { None }
    } else {
        None
    };
    let shift_amount = if (0..64).contains(&rhs_imm) {
        Some(rhs_imm as u8)
    } else {
        None
    };
    let imm12 = u32::try_from(rhs_imm).ok().filter(|v| *v < (1u32 << 12));
    // Magnitude of a negative immediate that fits the 12-bit field.
    // `x + (-k) == x - k` and `x - (-k) == x + k` in two's complement,
    // so an Add / Sub with a small negative immediate swaps to the
    // other form's direct encoding instead of materialising the
    // sign-extended constant (movz + 3x movk) into a scratch register.
    let imm12_neg = if rhs_imm < 0 {
        let m = rhs_imm.unsigned_abs();
        if m < (1u64 << 12) {
            u32::try_from(m).ok()
        } else {
            None
        }
    } else {
        None
    };
    let used_peephole = match op {
        BinOp::Shl => shift_amount.map(|s| super::encode::enc_lsl_imm(rd, rn, s)),
        BinOp::Shr => shift_amount.map(|s| super::encode::enc_asr_imm(rd, rn, s)),
        BinOp::Shru => shift_amount.map(|s| super::encode::enc_lsr_imm(rd, rn, s)),
        BinOp::Ror => shift_amount.map(|s| super::encode::enc_ror_imm(rd, rn, s)),
        BinOp::Mul => imm_pow2_shift.map(|s| super::encode::enc_lsl_imm(rd, rn, s)),
        BinOp::Add => imm12
            .map(|v| enc_add_imm(rd, rn, v))
            .or_else(|| imm12_neg.map(|v| enc_sub_imm(rd, rn, v))),
        BinOp::Sub => imm12
            .map(|v| enc_sub_imm(rd, rn, v))
            .or_else(|| imm12_neg.map(|v| enc_add_imm(rd, rn, v))),
        // `x ^ -1` is bitwise NOT -> `mvn`, one instruction instead of
        // materialising the all-ones constant (movz + 3x movk) into a
        // scratch and xoring. `mvn` reads the same operand, so the
        // allocator's liveness is unchanged.
        BinOp::Xor if rhs_imm == -1 => Some(super::encode::enc_mvn(rd, rn)),
        // `x & 0xffffffff` zero-extends the low word; a 32-bit move does
        // it in one instruction, avoiding the load-imm64 + and-register
        // pair (the immediate has no logical-immediate-AND short form
        // the rest of this path would otherwise use).
        BinOp::And if rhs_imm as u64 == 0xffff_ffff => Some(super::encode::enc_mov_w_w(rd, rn)),
        _ => None,
    };
    if let Some(word) = used_peephole {
        emit(code, word);
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_x_auto(code, rd, sp_off);
        }
        return true;
    }
    // Compare-with-12-bit-immediate: emit `cmp Xn, #imm12`
    // (subs xzr, Xn, #imm12) and skip the imm-into-scratch load.
    // The 12-bit unsigned-immediate form covers 0..4095; outside
    // that range we fall through to the load-imm64 + cmp-reg path.
    if compare_cond(op).is_some()
        && let Some(imm) = imm12
    {
        emit(code, enc_subs_imm(Reg::SP, rn, imm));
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        let cond = compare_cond(op).unwrap();
        emit(code, enc_cset(rd, cond));
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_x_auto(code, rd, sp_off);
        }
        return true;
    }
    load_imm64(code, scratch.secondary, rhs_imm as u64);
    let rm = scratch.secondary;
    if compare_cond(op).is_some() {
        emit(code, enc_cmp_reg(rn, rm));
        // When the terminator's b.cond will consume the flags
        // directly, drop the cset materialisation -- the
        // comparison value is dead.
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        let cond = compare_cond(op).unwrap();
        emit(code, enc_cset(rd, cond));
        if let Some(slot) = spill_to {
            let sp_off = spill_off(frame, slot);
            emit_sp_str_x_auto(code, rd, sp_off);
        }
        return true;
    }
    if matches!(op, BinOp::Mod | BinOp::Modu) {
        // Need a third scratch reg distinct from rn / rm; the
        // walker doesn't emit Mod / Modu under BinopI, so falling
        // back to the non-immediate path is safe.
        return false;
    }
    let word = match op {
        BinOp::Add => enc_add_reg(rd, rn, rm),
        BinOp::Sub => enc_sub_reg(rd, rn, rm),
        BinOp::Mul => enc_mul(rd, rn, rm),
        BinOp::Div => enc_sdiv(rd, rn, rm),
        BinOp::Divu => enc_udiv(rd, rn, rm),
        BinOp::And => enc_and_reg(rd, rn, rm),
        BinOp::Or => enc_orr_reg(rd, rn, rm),
        BinOp::Xor => enc_eor_reg(rd, rn, rm),
        BinOp::Shl => enc_lslv(rd, rn, rm),
        BinOp::Shr => enc_asrv(rd, rn, rm),
        BinOp::Shru => enc_lsrv(rd, rn, rm),
        BinOp::Ror => super::encode::enc_rorv(rd, rn, rm),
        _ => return false,
    };
    emit(code, word);
    if let Some(slot) = spill_to {
        let sp_off = spill_off(frame, slot);
        emit_sp_str_x_auto(code, rd, sp_off);
    }
    true
}

/// Materialise a value's `Place` into a register the lowering
/// can name in an instruction operand. Spills get loaded into
/// `scratch`; register places are returned as-is. Spill slots
/// are addressed through sp with the 12-bit scaled immediate;
/// fp-relative addressing through `ldur` would silently
/// truncate the 9-bit immediate for frames > 256 bytes and read
/// from the wrong slot. `sp_shift` is any amount the caller has
/// temporarily pushed sp down by (e.g. emit_call's outgoing-arg
/// scratch region) -- it gets added to the in-frame offset so the
/// load still hits the correct spill slot.
fn materialize_int(code: &mut Vec<u8>, place: Place, scratch: Reg, frame: Frame) -> Option<Reg> {
    materialize_int_shifted(code, place, scratch, frame, 0)
}

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
            let sp_off = spill_off(frame, slot) + sp_shift;
            emit_sp_ldr_x(code, scratch, sp_off);
            Some(scratch)
        }
        Place::FpReg(_) | Place::None => None,
    }
}

/// Materialise a floating-point value's `Place` into a d-reg.
/// Spilled FP values land in the 8-byte spill region as 64-bit
/// patterns (the SSA model's only FP width is f64 since c5
/// widens every load through `fcvt`).
fn materialize_fp(code: &mut Vec<u8>, place: Place, scratch_d: u8, frame: Frame) -> Option<u8> {
    materialize_fp_shifted(code, place, scratch_d, frame, 0)
}

fn materialize_fp_shifted(
    code: &mut Vec<u8>,
    place: Place,
    scratch_d: u8,
    frame: Frame,
    sp_shift: u32,
) -> Option<u8> {
    match place {
        Place::FpReg(r) => Some(r),
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot) + sp_shift;
            // FP spill reloads need a GPR base when the slot is beyond
            // the scaled-imm12 reach; x16 is the primary scratch and
            // holds no int operand during an FP-value lowering.
            emit_sp_ldr_d(code, scratch_d, sp_off, Reg(16));
            Some(scratch_d)
        }
        // c5's constant-folder emits FP values as `Imm` of the
        // int-encoded f64 bit pattern; the allocator places those
        // in IntRegs. Reinterpret the bit pattern as an f64 via
        // `fmov d, x` and return the scratch d-reg.
        Place::IntReg(r) => {
            emit(code, enc_fmov_x_to_d(scratch_d, Reg(r)));
            Some(scratch_d)
        }
        Place::None => None,
    }
}

/// Materialise a single-precision (`f32`) value's `Place` into the
/// low 32 bits of a v-register. A `Place::FpReg` already holds the
/// f32 in its s-view; a `Place::Spill` reloads the 64-bit slot (a
/// single-precision write zeroes the upper half, so the low 32 bits
/// carry the f32). A `Place::IntReg` holds an f32 constant's int-
/// encoded bit pattern in the low 32 bits; reinterpret it through
/// `fmov s, w` (not the 64-bit `fmov d, x`, which would read garbage
/// upper bits and misalign the single value).
fn materialize_fp_f32(code: &mut Vec<u8>, place: Place, scratch_d: u8, frame: Frame) -> Option<u8> {
    match place {
        Place::FpReg(r) => Some(r),
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot);
            emit_sp_ldr_d(code, scratch_d, sp_off, Reg(16));
            Some(scratch_d)
        }
        Place::IntReg(r) => {
            emit(code, enc_fmov_w_to_s(scratch_d, Reg(r)));
            Some(scratch_d)
        }
        Place::None => None,
    }
}

/// Materialise an FP operand, choosing the single- vs double-
/// precision reinterpret of an int-register constant by the value's
/// f32 marker.
fn materialize_fp_for(
    code: &mut Vec<u8>,
    v: super::super::ir::ValueId,
    place: Place,
    scratch_d: u8,
    frame: Frame,
    alloc: &Allocation,
) -> Option<u8> {
    if alloc.is_f32(v) {
        materialize_fp_f32(code, place, scratch_d, frame)
    } else {
        materialize_fp(code, place, scratch_d, frame)
    }
}

/// Extract the d-reg number from a `Place::FpReg`, or `None` for
/// any other place. The d-reg index is the same as the s-reg
/// index (single-precision uses the low 32 bits of the same
/// physical register).
fn fp_reg(place: Place) -> Option<u8> {
    place.fp_reg_u8()
}

/// Resolve a set of register-to-register copies `(src, tgt)` so
/// that no copy writes to a register still needed as the source
/// of another pending copy. Processed leaf-first (target not in
/// any source) until the worklist drains; cycles are broken by
/// routing one source through `scratch`. The caller must pass a
/// `scratch` that lives outside the allocator's bank so it cannot
/// collide with any pending source or target.
fn schedule_int_reg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>, scratch: Reg) {
    super::ssa::emit_common::schedule_reg_moves_via_scratch(
        code,
        moves,
        scratch.0,
        |code, t, s| emit_mov_reg(code, Reg(t), Reg(s)),
    );
}

/// Sequentialize a parallel copy over d-registers. Mirrors
/// [`schedule_int_reg_moves`] with `fmov d, d` for the register
/// copies. `scratch_d` must lie outside the allocator's d-register
/// pool so it collides with no pending source or target.
fn schedule_dreg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>, scratch_d: u8) {
    super::ssa::emit_common::schedule_reg_moves_via_scratch(
        code,
        moves,
        scratch_d,
        |code, t, s| emit(code, super::encode::enc_fmov_d_d(t, s)),
    );
}

/// Emit the predecessor-exit moves for each `Inst::Phi` at the head
/// of every CFG successor of `self_block`. The phi's incoming entry
/// for `self_block` names the reaching value at this block's exit;
/// the move places it in the phi's allocated `Place` so the phi
/// position itself is a no-op in the inst stream. Cycles in the
/// IntReg -> IntReg move set are broken via the schedule helper
/// (one scratch-mediated copy per cycle); Spill destinations route
/// through the materialise helper.
///
/// TODO: extend to FpReg dst / src once a real fixture demands it;
/// the current promotion path admits only int-store slots
/// (`slot_stores_only_int`) so the FP case never arises today.
fn emit_phi_predecessor_moves(
    code: &mut Vec<u8>,
    self_block: super::super::ir::BlockId,
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    scratch: &ScratchPool,
    frame: Frame,
) -> bool {
    // d16 / d17 are reserved FP scratch outside the allocator's d0..d15 pool;
    // `scratch.primary` / `secondary` are the reserved integer scratch.
    super::ssa::emit_common::emit_phi_predecessor_moves(
        &super::ssa::emit_common::Aarch64Backend,
        code,
        self_block,
        func,
        alloc,
        frame,
        scratch.primary.0,
        scratch.secondary.0,
        17,
        16,
    )
}

/// Compare two `Place`s by physical location identity. Distinct
/// `Place` variants never alias; same-variant places alias when their
/// register number or spill slot matches.
/// Emit a single resolved location-to-location move. `stage` is a
/// scratch register used only for the spill-to-spill case (load then
/// store); `hold` is borrowed (saved/restored on the stack) to carry
/// the base when a spill-to-spill destination slot lies beyond the
/// scaled-imm12 reach. Both must lie outside the allocator's bank.
/// Sequentialize a parallel copy over physical locations (integer
/// registers and stack spill slots). Leaves -- destinations that are
/// not the source of any other pending move -- are emitted first;
/// when only cycles remain, one cycle source is saved into the
/// persistent `hold` register and every move reading that location is
/// redirected to read `hold`, exposing a new leaf. `hold` and `stage`
/// must both lie outside the allocator's bank so they cannot collide
/// with any pending source or destination. Returns false if any
/// operand is an FP or `None` location, which this path does not lower.
fn schedule_place_moves(
    code: &mut Vec<u8>,
    moves: &mut Vec<(Place, Place)>,
    frame: Frame,
    hold: Reg,
    stage: Reg,
) -> bool {
    super::ssa::emit_common::schedule_place_moves(
        &super::ssa::emit_common::Aarch64Backend,
        code,
        moves,
        frame,
        hold.0,
        stage.0,
    )
}

/// Emit a single resolved FP location-to-location move over `FpReg`
/// and `Spill` places. `stage_d` is the scratch d-reg for the
/// spill-to-spill case (load then store); it must lie outside the
/// allocator's FP pool. `IntReg` and `None` places never reach here
/// (an FP phi's home and its operands are FP-classed).
impl super::ssa::emit_common::EmitBackend for super::ssa::emit_common::Aarch64Backend {
    type Frame = Frame;
    fn fp_reg_mov(&self, code: &mut Vec<u8>, dst: u8, src: u8) {
        emit(code, super::encode::enc_fmov_d_d(dst, src));
    }
    fn fp_spill_store(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8) {
        // FP phi moves keep all values in d-regs, so the GPR scratch x16 is
        // free to carry the base for out-of-reach slots.
        emit_sp_str_d_auto(code, src, spill_off(frame, slot));
    }
    fn fp_spill_load(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, dst: u8) {
        emit_sp_ldr_d_auto(code, dst, spill_off(frame, slot));
    }
    fn int_reg_mov(&self, code: &mut Vec<u8>, dst: u8, src: u8) {
        emit_mov_reg(code, Reg(dst), Reg(src));
    }
    fn int_spill_store(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8, base: u8) {
        emit_sp_str_x(code, Reg(src), spill_off(frame, slot), Reg(base));
    }
    fn int_spill_load(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, dst: u8) {
        emit_sp_ldr_x(code, Reg(dst), spill_off(frame, slot));
    }
    fn int_spill_to_spill(
        &self,
        code: &mut Vec<u8>,
        frame: Frame,
        src: u32,
        dst: u32,
        stage: u8,
        hold: u8,
    ) {
        emit_sp_ldr_x(code, Reg(stage), spill_off(frame, src));
        // The value occupies `stage` and `hold` may carry a live cycle
        // source, so the store borrows `hold` via a stack save/restore when
        // the destination slot is out of reach.
        emit_sp_str_x_borrow(code, Reg(stage), spill_off(frame, dst), Reg(hold));
    }
    fn int_spill_store_auto(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8) {
        emit_sp_str_x_auto(code, Reg(src), spill_off(frame, slot));
    }
    fn break_place_cycle(
        &self,
        code: &mut Vec<u8>,
        moves: &mut Vec<(Place, Place)>,
        frame: Frame,
        hold: u8,
        stage: u8,
    ) {
        // Stage one cycle source into `hold` and redirect every move that
        // reads it. A single cycle drains completely before the next break.
        let cyc = moves
            .iter()
            .map(|(s, _)| *s)
            .find(|s| !place_same_loc(*s, Place::IntReg(hold)))
            .unwrap_or(moves[0].0);
        super::ssa::emit_common::emit_place_move(
            self,
            code,
            cyc,
            Place::IntReg(hold),
            frame,
            stage,
            hold,
        );
        for m in moves.iter_mut() {
            if place_same_loc(m.0, cyc) {
                m.0 = Place::IntReg(hold);
            }
        }
    }
}

/// Place every call argument into its AAPCS64 target slot in an
/// order that survives source / target overlaps. With the
/// allocator's caller-saved bank covering x0..x15, an argument's
/// value can sit in another argument's target arg register; a
/// naive sequential `mov tgt_i, src_i` would clobber a still-
/// needed source. Resolution uses the classical parallel-copy
/// algorithm: drain leaves (target not a source of any other
/// pending move) first; break the residual cycles with one
/// scratch-mediated copy. The permutation-safe order is:
///
///   * Stack slots first -- their sources are read into a scratch
///     and stored to the host-stack overflow region, preserving
///     any source register that a later pass touches.
///   * Integer reg-to-reg moves next, scheduled through
///     [`schedule_int_reg_moves`] so cycles drop to a single
///     scratch-mediated copy.
///   * Spill / Imm / FpReg sources for `IntReg` placements then
///     materialise directly into the target arg register
///     (`materialize_int_shifted` writes its load into the dst).
///   * FP arg-register moves last. d-reg cycles are extremely
///     rare in real code; today this still emits sequentially
///     via the encoder scratch and relies on the allocator not
///     producing a d-reg permutation.
fn marshal_args(
    code: &mut Vec<u8>,
    plan: &super::CallPlan,
    args: &[u32],
    alloc: &Allocation,
    scratch: &ScratchPool,
    frame: Frame,
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
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
            if let Place::FpReg(_) = ap {
                let dn = match materialize_fp_shifted(code, ap, 0u8, frame, plan.scratch_bytes) {
                    Some(r) => r,
                    None => return false,
                };
                emit(code, enc_str_d_imm(dn, Reg(31), off));
            } else {
                let src = match materialize_int_shifted(
                    code,
                    ap,
                    scratch.primary,
                    frame,
                    plan.scratch_bytes,
                ) {
                    Some(r) => r,
                    None => return false,
                };
                emit(code, enc_str_imm(src, Reg(31), off));
            }
        }
    }

    // Aggregates passed on the caller's stack (AAPCS64 5.4.2): copy the
    // source bytes to [sp + off] here, before the register-argument
    // marshal below. The source address is read from a value register
    // that the register marshal can overwrite, so it must be consumed
    // while still live; x16/x17 are scratch and hold no argument value
    // at this point.
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::StructStack { off, size } = placement {
            let src = match materialize_int_shifted(
                code,
                arg_place(i),
                scratch.primary,
                frame,
                plan.scratch_bytes,
            ) {
                Some(r) => r,
                None => return false,
            };
            if src.0 != scratch.primary.0 {
                emit_mov_reg(code, scratch.primary, src);
            }
            let mut copied = 0u32;
            while copied + 8 <= size {
                emit(
                    code,
                    enc_ldr_imm(scratch.secondary, scratch.primary, copied),
                );
                emit(code, enc_str_imm(scratch.secondary, Reg(31), off + copied));
                copied += 8;
            }
            while copied < size {
                emit(
                    code,
                    enc_ldrb_imm(scratch.secondary, scratch.primary, copied),
                );
                emit(code, enc_strb_imm(scratch.secondary, Reg(31), off + copied));
                copied += 1;
            }
        }
    }

    // FP args before int args: an FP value can sit in an integer
    // register as a raw bit pattern (`Inst::Imm` with the f64 bit
    // pattern, allocator places it in an IntReg). The int marshal
    // below may overwrite arg-target integer registers, including
    // the source register of such a value, so the FP fmov must
    // snapshot it into the destination d-reg first.
    // FP arguments. A value already in a d-register may sit in
    // another FP argument's target d-register (AAPCS64 passes
    // successive FP args in d0, d1, ...), so the d-to-d moves form a
    // parallel copy. Schedule those first so every d-register source
    // is consumed before any Spill / IntReg source materialises into
    // its target d-register. SCRATCH_FP1 breaks any cycle and lies
    // outside the allocator's d-register pool.
    let mut fp_moves: Vec<(u8, u8)> = Vec::new();
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::FpReg(r) = placement
            && let Place::FpReg(s) = arg_place(i)
            && s != r
        {
            fp_moves.push((s, r));
        }
    }
    schedule_dreg_moves(code, &mut fp_moves, SCRATCH_FP1);
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::FpReg(r) = placement {
            let ap = arg_place(i);
            match ap {
                // Register-to-register moves were scheduled above.
                Place::FpReg(_) => {}
                Place::Spill(_) | Place::IntReg(_) | Place::None => {
                    let src = match materialize_fp_shifted(code, ap, r, frame, plan.scratch_bytes) {
                        Some(rr) => rr,
                        None => return false,
                    };
                    if src != r {
                        emit(code, super::encode::enc_fmov_d_d(r, src));
                    }
                }
            }
        }
    }

    // AAPCS64 6.8.2 HFA arguments: each member passes in its own FP
    // register, loaded from the source aggregate's address. Run after the
    // scalar-FP moves (so any d-register source they read is consumed) and
    // before the integer marshal (so the source address, still in an
    // integer register, is not yet overwritten). Members are memory loads,
    // so they join no FP move cycle; the base goes through scratch.primary,
    // reused per aggregate. Integer-class `StructRegs` (regs[0] is a GPR)
    // are left to the eightbyte path below.
    for (i, &placement) in plan.placements.iter().enumerate() {
        let super::ArgPlacement::StructRegs { regs, n } = placement else {
            continue;
        };
        if n == 0 || !regs[0].is_fp {
            continue;
        }
        let members = arg_aggs.get(i).copied().flatten().and_then(|idx| {
            super::abi_classify::hfa_member_layout(&agg_descs[idx as usize].fields)
        });
        let base = match materialize_int_shifted(
            code,
            arg_place(i),
            scratch.primary,
            frame,
            plan.scratch_bytes,
        ) {
            Some(r) => r,
            None => return false,
        };
        for (k, cr) in regs.iter().take(n as usize).enumerate() {
            let (off, msize) = members
                .as_ref()
                .and_then(|m| m.get(k).copied())
                .unwrap_or(((k as u32) * 8, 8));
            if msize == 8 {
                emit(code, super::encode::enc_ldr_d_imm(cr.reg, base, off));
            } else {
                emit(code, super::encode::enc_ldr_s_imm(cr.reg, base, off));
            }
        }
    }

    // Integer-register placements plus aggregate base addresses are
    // one parallel register move. A scalar `IntReg` arg moves
    // src->target; a `StructRegs` arg positions its base address into
    // its own first eightbyte register `regs[0]`, from which the
    // eightbytes load below (the base register is overwritten by its
    // own eightbyte last). Routing the base through that per-aggregate
    // register -- never a shared scratch -- keeps one aggregate's load
    // from clobbering another aggregate's still-pending base, which a
    // naive sequential scheme does when two aggregates' register
    // ranges overlap. `schedule_int_reg_moves` breaks cycles via
    // scratch.primary.
    let mut int_moves: Vec<(u8, u8)> = Vec::new();
    for (i, &placement) in plan.placements.iter().enumerate() {
        match placement {
            super::ArgPlacement::IntReg(r) => {
                if let Place::IntReg(s) = arg_place(i)
                    && s != r
                {
                    int_moves.push((s, r));
                }
            }
            // HFA aggregates (regs[0] is an FP register) loaded above.
            super::ArgPlacement::StructRegs { regs, n } if n > 0 && !regs[0].is_fp => {
                let dst = regs[0].reg;
                if let Place::IntReg(s) = arg_place(i)
                    && s != dst
                {
                    int_moves.push((s, dst));
                }
            }
            _ => {}
        }
    }
    schedule_int_reg_moves(code, &mut int_moves, scratch.primary);

    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::IntReg(r) = placement {
            let ap = arg_place(i);
            match ap {
                Place::IntReg(_) => {}
                Place::FpReg(dn) => {
                    emit(code, enc_fmov_d_to_x(Reg(r), dn));
                }
                Place::Spill(_) | Place::None => {
                    let src = match materialize_int_shifted(
                        code,
                        ap,
                        Reg(r),
                        frame,
                        plan.scratch_bytes,
                    ) {
                        Some(rr) => rr,
                        None => return false,
                    };
                    if src.0 != r {
                        emit_mov_reg(code, Reg(r), src);
                    }
                }
            }
        }
    }

    // Aggregate bases that were not already register-resident (spill /
    // computed) materialise into the aggregate's first eightbyte
    // register, the same destination the move loop used for the
    // register-resident case.
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::StructRegs { regs, n } = placement
            && n > 0
            && !regs[0].is_fp
            && !matches!(arg_place(i), Place::IntReg(_))
        {
            let dst = regs[0].reg;
            let src = match materialize_int_shifted(
                code,
                arg_place(i),
                Reg(dst),
                frame,
                plan.scratch_bytes,
            ) {
                Some(rr) => rr,
                None => return false,
            };
            if src.0 != dst {
                emit_mov_reg(code, Reg(dst), src);
            }
        }
    }

    // Load each aggregate's eightbytes from the base now in `regs[0]`.
    // The high eightbytes load first; `regs[0]` (the base) is read
    // last, overwritten by its own eightbyte. Integer-only here
    // (homogeneous floating-point aggregates are excluded upstream),
    // so every eightbyte register is general-purpose.
    for &placement in plan.placements.iter() {
        match placement {
            // Integer-class aggregate: load the eightbytes from the base in
            // regs[0]. An HFA (regs[0] is an FP register) loaded above.
            super::ArgPlacement::StructRegs { regs, n } if !regs[0].is_fp => {
                let base = regs[0].reg;
                for k in (1..n as usize).rev() {
                    emit(
                        code,
                        enc_ldr_imm(Reg(regs[k].reg), Reg(base), (k as u32) * 8),
                    );
                }
                emit(code, enc_ldr_imm(Reg(base), Reg(base), 0));
            }
            super::ArgPlacement::StructByRefReg(_) | super::ArgPlacement::StructByRefStack(_) => {
                // Not produced for AAPCS64 in this phase: >16-byte
                // aggregates keep the existing address-passing
                // convention (untagged scalar pointer argument).
                bail_msg("aarch64 marshal: by-reference aggregate arg not yet emitted");
                return false;
            }
            _ => {}
        }
    }

    true
}

/// Emit the function epilogue + `ret` for a Return terminator.
fn emit_return(
    code: &mut Vec<u8>,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    func: &FunctionSsa,
    abi: super::Abi,
) {
    // Host-ABI aggregate return (AAPCS64 6.9). `value` is the
    // struct's address. An aggregate of at most 16 bytes returns its
    // eightbytes in x0/x1; a larger one is copied through the caller-
    // supplied x8 pointer (saved to `indirect_result_slot` by the
    // prologue) and that pointer is returned in x0.
    if let Some(ai) = func.ret_agg {
        let desc = &func.agg_descs[ai as usize];
        let size = desc.size;
        let place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        let saddr = materialize_int(code, place, scratch.primary, frame).unwrap_or(scratch.primary);
        if saddr.0 != scratch.primary.0 {
            emit_mov_reg(code, scratch.primary, saddr);
        }
        let base = scratch.primary;
        if let Some(members) = super::abi_classify::hfa_member_layout(&desc.fields) {
            // AAPCS64 6.9: a homogeneous floating-point aggregate returns
            // member k in v[k] (d-register for an F64 member, s-register
            // for an F32). Load each from its byte offset in the source.
            for (k, (off, msize)) in members.iter().enumerate() {
                if *msize == 8 {
                    emit(code, super::encode::enc_ldr_d_imm(k as u8, base, *off));
                } else {
                    emit(code, super::encode::enc_ldr_s_imm(k as u8, base, *off));
                }
            }
        } else if size <= 16 {
            if size > 8 {
                emit(code, enc_ldr_imm(Reg(1), base, 8));
            }
            emit(code, enc_ldr_imm(Reg(0), base, 0));
        } else {
            let dst = scratch.secondary;
            emit_local_addr(code, Place::IntReg(dst.0), func.indirect_result_slot, frame);
            emit(code, enc_ldr_imm(dst, dst, 0));
            let mut copied = 0u32;
            while copied + 8 <= size {
                emit(code, enc_ldr_imm(Reg(0), base, copied));
                emit(code, enc_str_imm(Reg(0), dst, copied));
                copied += 8;
            }
            while copied < size {
                emit(code, enc_ldrb_imm(Reg(0), base, copied));
                emit(code, enc_strb_imm(Reg(0), dst, copied));
                copied += 1;
            }
            emit_mov_reg(code, Reg(0), dst);
        }
    } else if value != super::super::ir::NO_VALUE {
        // Move the return value into x0. c5's calling convention
        // ferries every return value (including f64 bit patterns)
        // through the int return register, matching the pool path's
        // `mov x0, x19` epilogue. FpReg-placed values reach x0 via
        // `fmov x, d`; int values flow through the standard
        // materialise + mov. NO_VALUE marks an implicit return with
        // no live accumulator -- harmless because c5 calls never
        // read the result of a void-returning function.
        let place = alloc
            .places
            .get(value as usize)
            .copied()
            .unwrap_or(Place::None);
        // A floating-point scalar result is returned in d0 (C99
        // 6.2.5p10 / AAPCS64 6.4.2). A `float` result occupies s0, the
        // low 32 bits of d0, which a d-register copy / 8-byte FP load
        // preserves. The value's producing instruction determines the
        // register file even when the allocator spilled it.
        let returns_fp = func.ret_is_fp
            || ((value as usize) < func.insts.len()
                && super::ssa::reg_alloc::produces_fp_result(&func.insts[value as usize]));
        if let Place::FpReg(r) = place {
            if r != 0 {
                emit(code, super::encode::enc_fmov_d_d(0, r));
            }
        } else if returns_fp {
            // The function returns a floating-point scalar in d0 but the
            // value is GPR / spill resident -- a bare FP constant
            // materializes as an integer immediate, and any value whose
            // producing instruction is integer-classed lands in a GPR.
            // The 8 bytes hold the f64 bit pattern (the low 32 are an
            // f32's s0); reinterpret them into d0.
            match place {
                Place::Spill(slot) => {
                    let sp_off = spill_off(frame, slot);
                    emit_sp_ldr_d_auto(code, 0, sp_off);
                }
                _ => {
                    let src = materialize_int(code, place, scratch.primary, frame)
                        .unwrap_or(scratch.primary);
                    emit(code, enc_fmov_x_to_d(0, src));
                }
            }
        } else if let Some(src) = materialize_int(code, place, scratch.primary, frame)
            && src.0 != 0
        {
            emit_mov_reg(code, Reg(0), src);
        }
    }
    // Restore saved callee-saved GPRs + FP regs (mirror of
    // prologue). Addressing through sp uses `enc_ldr_imm`'s
    // 12-bit scaled immediate (range 0..32760 in multiples of
    // 8); the matching prologue uses `enc_str_imm` at the same
    // offsets.
    let saved_fpr_bytes = super::ssa::emit_common::slots16(alloc.fp_used.len() as u32);
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        let off = saved_fpr_bytes + (i as u32) * 8;
        emit(code, enc_ldr_imm(Reg(r), Reg(31), off));
    }
    for (i, &r) in alloc.fp_used.iter().enumerate() {
        let off = (i as u32) * 8;
        emit(code, enc_ldr_d_imm(r, Reg(31), off));
    }
    // Restore x19 from the dedicated slot above the allocator saves;
    // mirror of the prologue's save, emitted only when the function
    // clobbers x19.
    if frame.uses_x19 {
        let saved_gpr_bytes = super::ssa::emit_common::slots16(alloc.gpr_used.len() as u32);
        let x19_save_off = saved_fpr_bytes + saved_gpr_bytes;
        emit(code, enc_ldr_imm(Reg(19), Reg(31), x19_save_off));
    }
    // Leaf-function elision: prologue emitted no save, so the
    // epilogue emits no matching restore -- the function body is
    // bracketed only by the return-value materialization and the
    // ret. Keep the symmetry tight so any reader can pair the
    // two halves at a glance.
    if is_full_leaf(func, frame, alloc) {
        emit(code, enc_ret(Reg(30)));
        return;
    }
    // Tear down the frame.
    if frame.frame_bytes > 0 {
        emit_add_sp_imm(code, frame.frame_bytes);
    }
    emit(code, enc_ldp_post(Reg(29), Reg(30), Reg(31), 16));
    // Drop whatever bytes the prologue allocated above the saved
    // fp/lr for c5 cdecl parameter slots. The single source of
    // truth is `prologue_param_spill_bytes`, recorded on
    // `frame.param_spill_bytes`; both prologue and epilogue read
    // from there so the two sides agree across every branch the
    // prologue takes (variadic, host-stack overflow,
    // ParamRef-elided, per-slot pending_sub flush).
    let _ = (func, abi);
    if frame.param_spill_bytes > 0 {
        emit_add_sp_imm(code, frame.param_spill_bytes);
    }
    emit(code, enc_ret(Reg(30)));
}

/// Extract the int reg from a `Place`, or None if it's not an
/// int placement.
fn int_reg(p: Place) -> Option<Reg> {
    p.int_reg_u8().map(Reg)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::Compiler;

    fn lift_and_alloc(src: &str, target: Target) -> (crate::c5::ir::FunctionSsa, Allocation) {
        let program = Compiler::new(src.into()).compile().expect("compile");
        let funcs = crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target)
            .expect("produce_ssa_funcs");
        let main = funcs.into_iter().next().expect("at least one function");
        let alloc = super::super::ssa::reg_alloc::allocate(&main, target);
        (main, alloc)
    }

    /// A `return 42;` function emits a small, well-formed
    /// aarch64 sequence: prologue, materialise 42, mov to x0,
    /// epilogue, ret. The exact length isn't load-bearing here
    /// -- the test exists to lock in that the thin slice
    /// completes without falling back.
    #[test]
    fn emit_return_42() {
        let (func, alloc) = lift_and_alloc("int main(void) { return 42; }", Target::MacOSAarch64);
        let mut code = Vec::new();
        let mut fx = Vec::new();
        let mut plt = Vec::new();
        let mut data_fx = Vec::new();
        let mut pf_fx = Vec::new();
        let imps = super::super::ResolvedImports::default();
        let variadic_targets: alloc::collections::BTreeSet<usize> =
            alloc::collections::BTreeSet::new();
        let mut tls_idx = Vec::new();
        let mut user_data_refs: Vec<super::super::UserExternDataRef> = Vec::new();
        let extern_data_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
            alloc::collections::BTreeMap::new();
        let extern_tls_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
            alloc::collections::BTreeMap::new();
        let mut tlv_fx = Vec::new();
        let mut tlv_desc = Vec::new();
        let mut pc_to_native = alloc::vec![usize::MAX; func.end_pc + 1];
        let mut ssa_line_rows: Vec<(usize, u32, u32)> = Vec::new();
        let mut prologue_native: alloc::collections::BTreeMap<usize, usize> =
            alloc::collections::BTreeMap::new();
        let mut elf_tpoff = Vec::new();
        let ok = {
            let mut cx = super::super::ssa::emit_common::EmitCtx {
                code: &mut code,
                plt_call_fixups: &mut plt,
                data_fixups: &mut data_fx,
                user_extern_data_refs: &mut user_data_refs,
                pending_func_fixups: &mut pf_fx,
                tls_index_fixups: &mut tls_idx,
                elf_tpoff_fixups: &mut elf_tpoff,
                ssa_line_rows: &mut ssa_line_rows,
                pc_to_native: &mut pc_to_native,
                prologue_native: &mut prologue_native,
            };
            emit_function(
                &func,
                &alloc,
                Target::MacOSAarch64,
                &mut cx,
                &mut fx,
                &extern_data_names,
                &extern_tls_names,
                &imps,
                &variadic_targets,
                &mut tlv_fx,
                &mut tlv_desc,
            )
        };
        assert!(
            ok,
            "expected SSA emit to handle a single-return function; got fallback"
        );
        assert!(!code.is_empty(), "emit produced no bytes");
        // Every aarch64 instruction is 4 bytes -- a non-multiple
        // of 4 means we encoded a wrong-width op.
        assert_eq!(code.len() % 4, 0, "code length must be 4-aligned");
        // Last instruction must be `ret x30` (0xd65f03c0).
        let tail = &code[code.len() - 4..];
        assert_eq!(
            u32::from_le_bytes([tail[0], tail[1], tail[2], tail[3]]),
            0xd65f03c0,
            "function must end with `ret`",
        );
    }

    /// An indexed store `a[i] = v` needs three registers: base, index,
    /// and value. AArch64 has two scratch registers, so when all three
    /// spill, base and index take both and the value would otherwise
    /// reuse the base register. Forcing all three operands to spill must
    /// precompute the address (`add xN, base, index, lsl #shift`) and
    /// store from a register distinct from the base.
    #[test]
    fn store_indexed_spilled_operands_precompute_address() {
        let target = Target::MacOSAarch64;
        // Compile for the target, not the host: `long` is 64-bit on the
        // aarch64 target but 32-bit on a Windows host, which would change
        // the element scale and drop the StoreIndexed.
        let program = Compiler::with_target(
            "void store_at(long *a, int i, long v){ a[i] = v; } int main(void){ return 0; }".into(),
            target,
        )
        .compile()
        .expect("compile");
        let mut funcs =
            crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target).expect("ssa");
        // StoreIndexed is produced by the index fold, which the lowering
        // runs after `produce_ssa_funcs`.
        crate::c5::codegen::passes::index_fold::run(&mut funcs);
        let func = funcs
            .into_iter()
            .find(|f| {
                f.insts
                    .iter()
                    .any(|i| matches!(i, crate::c5::ir::Inst::StoreIndexed { .. }))
            })
            .expect("a function with a StoreIndexed");
        let (base, index, value, scale, kind) = func
            .insts
            .iter()
            .find_map(|i| match i {
                crate::c5::ir::Inst::StoreIndexed {
                    base,
                    index,
                    scale,
                    value,
                    kind,
                } => Some((*base, *index, *value, *scale, *kind)),
                _ => None,
            })
            .expect("StoreIndexed operands");
        let mut alloc = super::super::ssa::reg_alloc::allocate(&func, target);
        alloc.places[base as usize] = Place::Spill(0);
        alloc.places[index as usize] = Place::Spill(1);
        alloc.places[value as usize] = Place::Spill(2);
        // The frame must reserve the three slots the test forces, or the
        // spill-offset computation underflows.
        alloc.spill_count = alloc.spill_count.max(3);
        let frame = compute_frame(&func, &alloc, target.abi(), target);
        let scratch = ScratchPool {
            primary: Reg(16),
            secondary: Reg(17),
        };
        let mut code = Vec::new();
        let ok = emit_store_indexed(
            &mut code,
            Place::None,
            base,
            index,
            scale,
            value,
            kind,
            &alloc,
            frame,
            &scratch,
        );
        assert!(ok, "emit_store_indexed bailed");
        let words: Vec<u32> = code
            .chunks_exact(4)
            .map(|c| u32::from_le_bytes([c[0], c[1], c[2], c[3]]))
            .collect();
        // The precomputed address: `add x16, x16, x17, lsl #3` for an
        // 8-byte element.
        let add_word: u32 = 0x8B11_0E10;
        assert!(
            words.contains(&add_word),
            "expected a precomputed-address add; got {words:08x?}",
        );
        // No store may use one register as both base and value.
        for &w in &words {
            let op = w >> 22;
            let is_str = op == 0x3E0 || op == 0x2E0 || op == 0x3E4 || op == 0x2E4;
            if is_str {
                let rt = w & 0x1f;
                let rn = (w >> 5) & 0x1f;
                assert_ne!(rt, rn, "store reuses base x{rn} as the value register");
            }
        }
    }

    /// `return 1 + 2;` exercises the Binop + BinopI handlers
    /// (the walker emits `Imm 1; Psh; Imm 2; Add` plus the
    /// int-promotion shl/shr; the walker's BinopI imm-fold may
    /// rewrite the Add into BinopI directly).
    #[test]
    fn emit_return_one_plus_two() {
        let (func, alloc) =
            lift_and_alloc("int main(void) { return 1 + 2; }", Target::MacOSAarch64);
        let mut code = Vec::new();
        let mut fx = Vec::new();
        let mut plt = Vec::new();
        let mut data_fx = Vec::new();
        let mut pf_fx = Vec::new();
        let imps = super::super::ResolvedImports::default();
        let variadic_targets: alloc::collections::BTreeSet<usize> =
            alloc::collections::BTreeSet::new();
        let mut tls_idx = Vec::new();
        let mut user_data_refs: Vec<super::super::UserExternDataRef> = Vec::new();
        let extern_data_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
            alloc::collections::BTreeMap::new();
        let extern_tls_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
            alloc::collections::BTreeMap::new();
        let mut tlv_fx = Vec::new();
        let mut tlv_desc = Vec::new();
        let mut pc_to_native = alloc::vec![usize::MAX; func.end_pc + 1];
        let mut ssa_line_rows: Vec<(usize, u32, u32)> = Vec::new();
        let mut prologue_native: alloc::collections::BTreeMap<usize, usize> =
            alloc::collections::BTreeMap::new();
        let mut elf_tpoff = Vec::new();
        let ok = {
            let mut cx = super::super::ssa::emit_common::EmitCtx {
                code: &mut code,
                plt_call_fixups: &mut plt,
                data_fixups: &mut data_fx,
                user_extern_data_refs: &mut user_data_refs,
                pending_func_fixups: &mut pf_fx,
                tls_index_fixups: &mut tls_idx,
                elf_tpoff_fixups: &mut elf_tpoff,
                ssa_line_rows: &mut ssa_line_rows,
                pc_to_native: &mut pc_to_native,
                prologue_native: &mut prologue_native,
            };
            emit_function(
                &func,
                &alloc,
                Target::MacOSAarch64,
                &mut cx,
                &mut fx,
                &extern_data_names,
                &extern_tls_names,
                &imps,
                &variadic_targets,
                &mut tlv_fx,
                &mut tlv_desc,
            )
        };
        assert!(ok, "binop handler should cover Add + Shl + Shr");
        assert_eq!(code.len() % 4, 0);
    }

    /// `if (x > 0) return 1; else return 0;` exercises the
    /// comparison binop path (cmp + cset), the branch terminator
    /// path (CBZ + fixup), and the multi-block walk.
    #[test]
    fn emit_if_else_returns() {
        let (func, alloc) = lift_and_alloc(
            "int test(int x) { if (x > 0) return 1; else return 0; } \
             int main(void) { return test(5); }",
            Target::MacOSAarch64,
        );
        // The first function is `test`; the walker order is
        // declaration order, but `Inst::Call` for main isn't in
        // the thin slice yet, so we only check that `test` emits
        // cleanly. main will fall back.
        let mut code = Vec::new();
        let mut fx = Vec::new();
        let mut plt = Vec::new();
        let mut data_fx = Vec::new();
        let mut pf_fx = Vec::new();
        let imps = super::super::ResolvedImports::default();
        let variadic_targets: alloc::collections::BTreeSet<usize> =
            alloc::collections::BTreeSet::new();
        let mut tls_idx = Vec::new();
        let mut user_data_refs: Vec<super::super::UserExternDataRef> = Vec::new();
        let extern_data_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
            alloc::collections::BTreeMap::new();
        let extern_tls_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
            alloc::collections::BTreeMap::new();
        let mut tlv_fx = Vec::new();
        let mut tlv_desc = Vec::new();
        let mut pc_to_native = alloc::vec![usize::MAX; func.end_pc + 1];
        let mut ssa_line_rows: Vec<(usize, u32, u32)> = Vec::new();
        let mut prologue_native: alloc::collections::BTreeMap<usize, usize> =
            alloc::collections::BTreeMap::new();
        let mut elf_tpoff = Vec::new();
        let ok = {
            let mut cx = super::super::ssa::emit_common::EmitCtx {
                code: &mut code,
                plt_call_fixups: &mut plt,
                data_fixups: &mut data_fx,
                user_extern_data_refs: &mut user_data_refs,
                pending_func_fixups: &mut pf_fx,
                tls_index_fixups: &mut tls_idx,
                elf_tpoff_fixups: &mut elf_tpoff,
                ssa_line_rows: &mut ssa_line_rows,
                pc_to_native: &mut pc_to_native,
                prologue_native: &mut prologue_native,
            };
            emit_function(
                &func,
                &alloc,
                Target::MacOSAarch64,
                &mut cx,
                &mut fx,
                &extern_data_names,
                &extern_tls_names,
                &imps,
                &variadic_targets,
                &mut tlv_fx,
                &mut tlv_desc,
            )
        };
        assert!(
            ok,
            "`test` should emit via the thin slice (cmp + cset + cbz + ldr params)"
        );
    }
}
