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
//!   over-aligned region           [fp + align_region_off ..]  (16-mode only)
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
use super::Target;
use super::encode::{
    BranchKind, Cond, Fixup, JB_D8_OFF, JB_PC_OFF, JB_SP_OFF, JB_X19_OFF, JB_X29_OFF, PltCallFixup,
    Reg, emit, emit_add_sp_imm, emit_mov_reg, emit_setjmp_aarch64, emit_sub_sp_imm, enc_add_imm,
    enc_add_reg, enc_adr, enc_adrp, enc_and_reg, enc_asrv, enc_b, enc_b_cond, enc_bl, enc_blr,
    enc_br, enc_cbnz, enc_cbz, enc_cinc, enc_cmp_reg, enc_cset, enc_eor_reg, enc_fadd_d,
    enc_fcmp_d, enc_fcmp_s, enc_fcvt_d_s, enc_fcvt_s_d, enc_fcvtzs_x_d, enc_fcvtzs_x_s,
    enc_fcvtzu_x_d, enc_fcvtzu_x_s, enc_fdiv_d, enc_fmov_d_to_x, enc_fmov_w_to_s, enc_fmov_x_to_d,
    enc_fmul_d, enc_fneg_d, enc_fsub_d, enc_ldaxr, enc_ldp_d_off, enc_ldp_d_post, enc_ldp_off,
    enc_ldp_post, enc_ldr_d_imm, enc_ldr_d_post, enc_ldr_imm, enc_ldr_post, enc_ldr_reg_lsl3,
    enc_ldr_s_imm, enc_ldr32_imm, enc_ldrb_imm, enc_ldrh_imm, enc_ldrsb_imm, enc_ldrsh_imm,
    enc_ldrsw_imm, enc_ldrsw_reg_lsl2, enc_lslv, enc_lsrv, enc_movz, enc_msub, enc_mul,
    enc_orr_reg, enc_ret, enc_scvtf_d_x, enc_scvtf_s_x, enc_sdiv, enc_stlxr, enc_stp_d_off,
    enc_stp_d_pre, enc_stp_off, enc_stp_pre, enc_str_d_imm, enc_str_d_pre, enc_str_imm,
    enc_str_pre, enc_str_s_imm, enc_str32_imm, enc_strb_imm, enc_strh_imm, enc_sub_imm,
    enc_sub_reg, enc_subs_imm, enc_ucvtf_d_x, enc_ucvtf_s_x, enc_udiv, load_imm64,
};
use super::ssa::emit_common::{
    MAX_UNPROBED_STACK_STEP, STACK_PROBE_PAGE, STACK_PROBE_UNROLL_MAX, build_arg_aggs,
    place_same_loc,
};
use super::ssa::reg_alloc::{Allocation, Place};
use super::{AddrPart, DataFixup};

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
    /// The body moves sp at runtime (`alloca` / C99 6.7.6.2 VLA), or the
    /// prologue realigns sp for an automatic object aligned above 16, so spill
    /// slots are addressed through fp and the epilogue re-establishes sp from
    /// fp before tearing the frame down.
    pub dynamic_sp: bool,
    /// Alignment the prologue forces on sp for automatic objects aligned above
    /// 16 (C11 6.7.5), a power of two > 16, or 0 when none. The realigned
    /// region sits below the static frame; the objects live at
    /// `[sp + region_off]`.
    pub realign_align: u32,
    /// Byte size of the realigned region, a multiple of 16.
    pub realign_region_bytes: u32,
    /// fp-relative byte offset (negative) of the over-aligned region when the
    /// region alignment is exactly 16, or 0 when none. fp and every frame
    /// region above it are 16-byte multiples, so the region base is 16-aligned
    /// with no sp move; its bytes are counted in `frame_bytes` and the objects
    /// live at `[fp + align_region_off + region_off]`.
    pub align_region_off: i64,
    /// fp-relative byte offset (negative) of the inline-asm scratch region
    /// (operand captures plus register saves), or 0 when the function has no
    /// inline asm. Frame storage rather than an sp carve around the template:
    /// an `asm goto` label published to a data section (a jump-label site) is
    /// reached by a branch patched in at run time, which bypasses every
    /// teardown path, so sp must already be balanced there. The bytes are
    /// counted in `frame_bytes`; slot `off` lives at
    /// `[sp + frame_bytes + asm_scratch_off + off]`, addressed like the
    /// allocator spill slots (fp-based when `dynamic_sp`).
    pub asm_scratch_off: i64,
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
    // An over-aligned region whose alignment is exactly 16 joins the static
    // frame between the spill region and the saved-register block: every
    // region above it is a 16-byte multiple, so its base is 16-aligned with
    // no sp move. Above 16 the prologue realigns sp instead. A region whose
    // members have no emitted access needs no bytes, the same decision
    // `compute_frame_base` makes for the locals region (`locals_bytes` is 0
    // exactly when no local access survives).
    let region_bytes = func.realign_region_bytes.max(0) as u32;
    let static_region_bytes = if func.frame_align == 16 && locals_bytes > 0 {
        region_bytes
    } else {
        0
    };
    // Inline-asm scratch, directly below the spill region and above the
    // over-aligned region and the sp-addressed saved registers. Sized for the
    // largest statement in the function. A naked function emits no prologue,
    // so it has no frame to host the region and keeps the sp carve.
    let asm_bytes = if func.is_naked {
        0
    } else {
        asm_scratch_bytes(func)
    };
    let frame_bytes = locals_bytes
        + alloc_spill_bytes
        + saved_gpr_bytes
        + saved_fpr_bytes
        + x19_save_bytes
        + asm_bytes
        + static_region_bytes;
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
        // An automatic object aligned above 16 realigns sp in the prologue
        // and lives in a region below the static frame, addressed sp-relative;
        // the frame is dynamic-sp so spills go through fp and the epilogue
        // restores sp from fp (C11 6.7.5). An alignment of exactly 16 keeps
        // the static frame and addresses the region fp-relative.
        dynamic_sp: super::ssa::emit_common::uses_dynamic_alloca(func) || func.frame_align > 16,
        realign_align: if func.frame_align > 16 {
            func.frame_align as u32
        } else {
            0
        },
        realign_region_bytes: if func.frame_align > 16 {
            region_bytes
        } else {
            0
        },
        align_region_off: if static_region_bytes > 0 {
            -((locals_bytes + alloc_spill_bytes + asm_bytes + static_region_bytes) as i64)
        } else {
            0
        },
        asm_scratch_off: if asm_bytes > 0 {
            -((locals_bytes + alloc_spill_bytes + asm_bytes) as i64)
        } else {
            0
        },
    }
}

/// Bytes of frame scratch the function's largest inline-asm statement
/// needs: 8 per operand capture and 8 per saved GP / FP register.
/// Derived from [`asm_save_masks`], which the emitter also saves from,
/// so the region always covers the emitted layout.
fn asm_scratch_bytes(func: &FunctionSsa) -> u32 {
    use super::super::ir::AsmConstraint;
    let mut max = 0u32;
    for inst in &func.insts {
        let Inst::InlineAsm { asm, .. } = inst else {
            continue;
        };
        // A no-op statement emits no staging (`emit_inline_asm_aarch64`),
        // so it needs no scratch.
        if super::ssa::emit_common::asm_statement_is_noop(
            asm,
            super::ssa::emit_common::AsmComments::A64,
        ) {
            continue;
        }
        let Ok(op_reg) =
            super::asm::assign_operand_regs(&asm.operands, asm.clobber_regs, asm.clobber_fp_regs)
        else {
            continue;
        };
        let Ok((used, fp_used)) = asm_save_masks(asm, &op_reg) else {
            continue;
        };
        let n_cap = asm
            .operands
            .iter()
            .filter(|o| !matches!(o.constraint, AsmConstraint::Imm))
            .count() as u32;
        max = max.max((n_cap + used.count_ones() + fp_used.count_ones()) * 8);
    }
    (max + 15) & !15
}

/// The GP / FP register masks an inline-asm statement saves around its
/// template: the clobber list (minus the emitter's x16/x17 scratch and
/// bit 31) plus every operand register. `w` operands must be a double
/// or a 16-byte vector (the SSA model's only FP shapes).
fn asm_save_masks(
    asm: &super::super::ir::AsmBlock,
    op_reg: &[Option<u8>],
) -> Result<(u32, u32), alloc::string::String> {
    use super::super::ir::AsmConstraint;
    let mut used: u32 = asm.clobber_regs & 0x7FFF_FFFF & !0x0003_0000;
    let mut fp_used: u32 = asm.clobber_fp_regs & 0xFF;
    for (i, op) in asm.operands.iter().enumerate() {
        let Some(r) = op_reg[i] else { continue };
        if matches!(op.constraint, AsmConstraint::Fp) {
            if op.width != 8 && op.width != 16 {
                return Err(alloc::string::String::from(
                    "aarch64 inline asm: `w` operands must be 8 or 16 bytes",
                ));
            }
            fp_used |= 1 << r;
        } else {
            used |= 1 << r;
        }
    }
    Ok((used, fp_used))
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
    // A function that realigns sp for an over-aligned automatic object needs
    // the frame pointer to restore sp on exit; it is never leaf-elided.
    if frame.realign_align != 0 {
        return false;
    }
    if !alloc.gpr_used.is_empty() || !alloc.fp_used.is_empty() {
        return false;
    }
    super::ssa::emit_common::function_makes_no_calls(func)
}

/// Whether the function signs its return address under
/// `-mbranch-protection=pac-ret`.
///
/// A full leaf never spills x30, so no stored return address exists to
/// protect. A `Terminator::TailExt` forwarder leaves through a tail
/// jump that runs no epilogue, so a signature taken at entry would
/// never be authenticated. Everything else takes the pair: `paciasp`
/// ahead of the first sp-moving prologue instruction and `autiasp`
/// after the last sp-restoring epilogue one, which is the window in
/// which sp -- the signing modifier -- holds its entry value.
fn signs_return_address(
    func: &FunctionSsa,
    frame: Frame,
    alloc: &Allocation,
    abi: super::Abi,
) -> bool {
    abi.hardening.pac_ret
        && !func.is_naked
        && !is_full_leaf(func, frame, alloc)
        && !func
            .blocks
            .iter()
            .any(|b| matches!(b.terminator, Terminator::TailExt(_)))
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
/// split of `ADD (immediate)` (24-bit reach); past that the offset is
/// built into `dst` and applied with the extended-register form (the
/// only register add that accepts SP as the source).
fn emit_sp_plus_off(code: &mut Vec<u8>, dst: Reg, off: u32) {
    if !super::encode::add_sub_imm24_in_range(off) {
        super::encode::load_imm64(code, dst, off as u64);
        emit(code, super::encode::enc_add_ext_reg(dst, Reg(31), dst));
        return;
    }
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
    if !super::encode::add_sub_imm24_in_range(off) {
        super::encode::load_imm64(code, dst, off as u64);
        emit(code, super::encode::enc_add_reg(dst, Reg(29), dst));
        return;
    }
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

/// Allocator-spill accessors. A static frame reads the slot at
/// `[sp + sp_off]`; a dynamic-sp frame (alloca / VLA,
/// `Frame::dynamic_sp`) reads the same byte at
/// `[fp - (frame_bytes - sp_off)]`, since sp moves at runtime while fp
/// stays put. The fp displacement uses the unscaled-signed `ldur` /
/// `stur` form in reach, else builds the address with the imm12 +
/// shift-12 split.
fn fp_spill_delta(frame: Frame, sp_off: u32) -> u32 {
    frame.frame_bytes - sp_off
}

/// Materialise `fp - delta` into `dst` (imm12 + shift-12 split, then
/// the register form past the 24-bit reach).
fn emit_fp_minus_off(code: &mut Vec<u8>, dst: Reg, delta: u32) {
    if !super::encode::add_sub_imm24_in_range(delta) {
        super::encode::load_imm64(code, dst, delta as u64);
        emit(code, super::encode::enc_sub_reg(dst, Reg(29), dst));
        return;
    }
    let hi = delta & !0xfff;
    let lo = delta & 0xfff;
    if hi != 0 {
        emit(
            code,
            super::encode::enc_sub_imm_lsl12(dst, Reg(29), hi >> 12),
        );
        if lo != 0 {
            emit(code, enc_sub_imm(dst, dst, lo));
        }
    } else {
        emit(code, enc_sub_imm(dst, Reg(29), lo));
    }
}

/// Spill-slot 8-byte load into `rt`. The fp-based out-of-reach form
/// builds the address into `rt` itself, mirroring [`emit_sp_ldr_x`].
fn emit_spill_ldr_x(code: &mut Vec<u8>, frame: Frame, rt: Reg, sp_off: u32) {
    if !frame.dynamic_sp {
        emit_sp_ldr_x(code, rt, sp_off);
        return;
    }
    let delta = fp_spill_delta(frame, sp_off);
    if delta <= 255 {
        emit(code, super::encode::enc_ldur(rt, Reg(29), -(delta as i32)));
    } else {
        emit_fp_minus_off(code, rt, delta);
        emit(code, enc_ldr_imm(rt, rt, 0));
    }
}

/// Spill-slot 8-byte store of `rt`; `addr_scratch` (distinct from
/// `rt`) carries the base when the displacement is out of reach.
fn emit_spill_str_x(code: &mut Vec<u8>, frame: Frame, rt: Reg, sp_off: u32, addr_scratch: Reg) {
    if !frame.dynamic_sp {
        emit_sp_str_x(code, rt, sp_off, addr_scratch);
        return;
    }
    let delta = fp_spill_delta(frame, sp_off);
    if delta <= 255 {
        emit(code, super::encode::enc_stur(rt, Reg(29), -(delta as i32)));
    } else {
        debug_assert_ne!(rt.0, addr_scratch.0, "spill str: addr scratch aliases data");
        emit_fp_minus_off(code, addr_scratch, delta);
        emit(code, enc_str_imm(rt, addr_scratch, 0));
    }
}

/// Spill-slot 8-byte store picking an IP-pool address scratch that
/// differs from the data register.
fn emit_spill_str_x_auto(code: &mut Vec<u8>, frame: Frame, rt: Reg, sp_off: u32) {
    let addr_scratch = if rt.0 == 16 { Reg(17) } else { Reg(16) };
    emit_spill_str_x(code, frame, rt, sp_off, addr_scratch);
}

/// Spill-slot 8-byte store at a site where only `borrow` (a live
/// register, stack-saved around the store) can carry the base.
fn emit_spill_str_x_borrow(code: &mut Vec<u8>, frame: Frame, rt: Reg, sp_off: u32, borrow: Reg) {
    if !frame.dynamic_sp {
        emit_sp_str_x_borrow(code, rt, sp_off, borrow);
        return;
    }
    let delta = fp_spill_delta(frame, sp_off);
    if delta <= 255 {
        emit(code, super::encode::enc_stur(rt, Reg(29), -(delta as i32)));
        return;
    }
    debug_assert_ne!(rt.0, borrow.0, "spill str borrow: borrow aliases data");
    emit(code, super::encode::enc_str_pre(borrow, Reg(31), -16));
    emit_fp_minus_off(code, borrow, delta);
    emit(code, enc_str_imm(rt, borrow, 0));
    emit(code, super::encode::enc_ldr_post(borrow, Reg(31), 16));
}

/// Spill-slot 8-byte FP load into d-reg `dt`; `addr_scratch` is a GPR.
fn emit_spill_ldr_d(code: &mut Vec<u8>, frame: Frame, dt: u8, sp_off: u32, addr_scratch: Reg) {
    if !frame.dynamic_sp {
        emit_sp_ldr_d(code, dt, sp_off, addr_scratch);
        return;
    }
    emit_fp_minus_off(code, addr_scratch, fp_spill_delta(frame, sp_off));
    emit(code, enc_ldr_d_imm(dt, addr_scratch, 0));
}

/// Spill-slot 8-byte FP store of d-reg `dt`; `addr_scratch` is a GPR.
fn emit_spill_str_d(code: &mut Vec<u8>, frame: Frame, dt: u8, sp_off: u32, addr_scratch: Reg) {
    if !frame.dynamic_sp {
        emit_sp_str_d(code, dt, sp_off, addr_scratch);
        return;
    }
    emit_fp_minus_off(code, addr_scratch, fp_spill_delta(frame, sp_off));
    emit(code, enc_str_d_imm(dt, addr_scratch, 0));
}

/// Spill-slot FP store / load with x16 as the address scratch.
fn emit_spill_str_d_auto(code: &mut Vec<u8>, frame: Frame, dt: u8, sp_off: u32) {
    emit_spill_str_d(code, frame, dt, sp_off, Reg(16));
}

fn emit_spill_ldr_d_auto(code: &mut Vec<u8>, frame: Frame, dt: u8, sp_off: u32) {
    emit_spill_ldr_d(code, frame, dt, sp_off, Reg(16));
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
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    data_sym_offsets: &alloc::collections::BTreeMap<alloc::string::String, i64>,
    asm_text_labels: &mut Vec<super::AsmTextLabel>,
    asm_section_text_refs: &mut Vec<super::AsmSectionTextRef>,
    // The text stream's mapping state spans the section, not the function: a
    // body ending in data leaves the counter off the instruction boundary and
    // the next function's first instruction pays the padding, as under GNU as.
    text_map_state: &mut Option<super::super::map_syms::MapClass>,
    no_fp_regs: bool,
    strict_align: bool,
    rodata: &mut super::RodataBuild,
    abs_jump_tables: bool,
    hardening: super::Hardening,
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
    let asm_sections = &mut *cx.asm_sections;
    let asm_extern_call_sites = &mut *cx.asm_extern_call_sites;
    let asm_sym_fixups = &mut *cx.asm_sym_fixups;
    let text_align = &mut *cx.text_align;
    let label_relocs = &mut *cx.label_relocs;
    let text_data_ranges = &mut *cx.text_data_ranges;
    let abi = {
        let mut a = target.abi();
        a.no_fp_varargs = no_fp_regs;
        a.strict_align = strict_align;
        a.hardening = hardening;
        a
    };
    if let Some(bytes) = super::ssa::emit_common::locals_bytes_over_limit(func) {
        bail_msg(&super::ssa::emit_common::frame_too_large_msg(bytes));
        return false;
    }
    let frame = compute_frame(func, alloc, abi, target);
    if frame.frame_bytes > super::ssa::emit_common::MAX_FRAME_BYTES {
        bail_msg(&super::ssa::emit_common::frame_too_large_msg(
            frame.frame_bytes as i64,
        ));
        return false;
    }
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
    let asm_extern_call_sites_snapshot = asm_extern_call_sites.len();
    let asm_sym_fixups_snapshot = asm_sym_fixups.len();
    // The section sink merges by name, so a rollback restores its full
    // per-section state rather than a length (see [`AsmSectionSink::restore`]).
    let asm_sections_snapshot = asm_sections.snapshot();
    let pending_func_fixups_snapshot = pending_func_fixups.len();
    let tls_index_fixups_snapshot = tls_index_fixups.len();
    let macho_tlv_fixups_snapshot = macho_tlv_fixups.len();
    let macho_tlv_descriptors_snapshot = macho_tlv_descriptors.len();
    let elf_tpoff_snapshot = elf_tpoff_fixups.len();

    // A `__attribute__((naked))` function emits no prologue/epilogue; its
    // inline-asm body is the entire function (an interrupt vector or ISR
    // returning via `eret`). The matching `Terminator::Return` emits nothing.
    if !func.is_naked {
        // The entry is this function's first instruction, so it pays any
        // realignment a preceding body left owing. The symbol keeps the
        // offset it was placed at, as a label does under GNU as.
        a64_align_asm_stream(code, text_data_ranges, text_map_state);
        // Branch protection: a function entry is reachable by `BLR` and
        // by a `BR` through x16/x17 (a PLT trampoline's), so it takes a
        // `BTI C` ahead of the prologue. A naked function is excluded --
        // its body is the whole function, and prefixing an instruction
        // would displace a hand-built entry sequence.
        //
        // `PACIASP` accepts both of those BTYPEs itself, so a signed
        // function needs no separate pad ahead of it.
        if signs_return_address(func, frame, alloc, abi) {
            emit(code, super::encode::PACIASP);
        } else if abi.hardening.bti {
            emit(code, super::encode::BTI_C);
        }
        emit_prologue(code, func, alloc, frame, abi);
    }
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
                        emit_spill_ldr_x(code, frame, scratch.primary, sp_off);
                        ext(code, scratch.primary);
                        emit_spill_str_x(code, frame, scratch.primary, sp_off, scratch.secondary);
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
    // Template `%lK` branches that reach their label's block with no operand
    // frame in the way; encoded against `block_offsets` once it is final.
    let mut direct_goto_branches: Vec<AsmGotoDirectBranch> = Vec::new();
    // GCC `&&label`: each `Inst::BlockAddr` emits an `ADR rd, .`
    // placeholder; `(site, target_block, rd)` is resolved against the
    // final `block_offsets` once every block has been laid out.
    let mut block_addr_fixups: Vec<(usize, BlockId, Reg)> = Vec::new();
    // Text-embedded jump tables: `(table_start, table_idx)` per
    // `Terminator::JumpTable`. Each 32-bit entry is patched to
    // `block_offset - table_start` once every block is laid out.
    let mut jump_table_fixups: Vec<(usize, u32)> = Vec::new();
    // ALTERNATIVE `.subsection` replacements, appended after the body once it
    // is laid out; the section relocs that point at their labels are then
    // rewritten to the region's final text offset. A bailed emit returns
    // false and drops this, so no snapshot is needed.
    let mut deferred_regions: Vec<DeferredAsmRegion> = Vec::new();
    // Blocks a `BR` can reach: switch-table successors and the blocks
    // whose address `&&label` took. Each needs a `BTI J` landing pad at
    // its head, recorded before the block loop so the pad lands at the
    // offset every branch fixup resolves to.
    let bti_targets = if abi.hardening.bti {
        super::super::indirect_branch_target_blocks(func)
    } else {
        alloc::collections::BTreeSet::new()
    };
    for (block_idx, block) in func.blocks.iter().enumerate() {
        // The landing pad is the block's first byte, so a realignment due
        // ahead of it comes before the offset every branch resolves to.
        let bti = bti_targets.contains(&(block_idx as BlockId));
        if bti {
            a64_align_asm_stream(code, text_data_ranges, text_map_state);
        }
        block_offsets[block_idx] = code.len();
        super::ssa::emit_common::record_block_start_pc(
            block_idx,
            block.start_pc,
            pc_to_native,
            code.len(),
        );
        if bti {
            emit(code, super::encode::BTI_J);
        }
        for v in block.inst_range.clone() {
            let inst = &func.insts[v as usize];
            let place = alloc.places.get(v as usize).copied().unwrap_or(Place::None);
            // A naked function's machine code is exactly its inline asm; the
            // compiler-inserted alloca/return-value scaffolding is dropped.
            if func.is_naked && !matches!(inst, Inst::InlineAsm { .. }) {
                continue;
            }
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
            // An inline-asm block takes the mapping state itself.
            if !matches!(inst, Inst::InlineAsm { .. }) {
                a64_align_asm_stream(code, text_data_ranges, text_map_state);
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
                        asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                        asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                        asm_sections.restore(&asm_sections_snapshot);
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
                    emit_spill_str_x_auto(code, frame, rd, sp_off);
                }
                continue;
            }
            // `asm goto`: the label branches patch against block
            // offsets via the enclosing `branch_fixups`, which
            // `emit_inst` has no access to; lower it here (same
            // pattern as `Inst::BlockAddr` above).
            if let Inst::InlineAsm { asm, args } = inst
                && let Terminator::AsmGoto { table } = block.terminator
            {
                if !emit_inline_asm_aarch64(
                    code,
                    asm,
                    args,
                    func,
                    alloc,
                    frame,
                    fixups,
                    name2entpc,
                    extern_data_names,
                    data_sym_offsets,
                    asm_sections,
                    asm_extern_call_sites,
                    asm_sym_fixups,
                    &mut deferred_regions,
                    text_data_ranges,
                    text_align,
                    text_map_state,
                    asm_text_labels,
                    asm_section_text_refs,
                    Some(AsmGotoCtxA64 {
                        row: &func.jump_tables[table as usize],
                        branch_fixups: &mut branch_fixups,
                        direct_goto: &mut direct_goto_branches,
                    }),
                ) {
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                    asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                    asm_sections.restore(&asm_sections_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
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
                    asm_sections: &mut *asm_sections,
                    asm_extern_call_sites: &mut *asm_extern_call_sites,
                    asm_sym_fixups: &mut *asm_sym_fixups,
                    text_align: &mut *text_align,
                    label_relocs: &mut *label_relocs,
                    text_data_ranges: &mut *text_data_ranges,
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
                    extern_data_names,
                    param_plan: &emit_param_plan,
                    name2entpc,
                    data_sym_offsets,
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
                    &mut deferred_regions,
                    text_map_state,
                    asm_text_labels,
                    asm_section_text_refs,
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
                asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                asm_sections.restore(&asm_sections_snapshot);
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
                    instr_offset: popped.instr_offset,
                    symbol_name: name.clone(),
                    direct_pcrel: None,
                });
            }
        }
        // The phi moves and the terminator below are instructions, except
        // for a naked function's synthetic return, which emits nothing.
        if !(func.is_naked && matches!(block.terminator, Terminator::Return(_))) {
            a64_align_asm_stream(code, text_data_ranges, text_map_state);
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
            asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
            asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
            asm_sections.restore(&asm_sections_snapshot);
            pending_func_fixups.truncate(pending_func_fixups_snapshot);
            tls_index_fixups.truncate(tls_index_fixups_snapshot);
            elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
            macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
            macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
            return false;
        }
        match block.terminator {
            // A naked function's inline-asm body provides its own return (eret);
            // emit no epilogue for the synthetic return.
            Terminator::Return(_) if func.is_naked => {}
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
                            asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                            asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                            asm_sections.restore(&asm_sections_snapshot);
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
                            asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                            asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                            asm_sections.restore(&asm_sections_snapshot);
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
                        asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                        asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                        asm_sections.restore(&asm_sections_snapshot);
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
            Terminator::JumpTable { idx, table } => {
                // Table dispatch through the read-only blob (kept out
                // of the code section so it never decodes as
                // instructions). The bounds check preceding this
                // terminator proves the index in range. Image output
                // reads a 32-bit table-relative entry and adds the
                // base back (no load-time relocation); relocatable
                // output loads an 8-byte absolute entry, the form
                // whose relocations name the targets directly.
                let iplace = alloc
                    .places
                    .get(idx as usize)
                    .copied()
                    .unwrap_or(Place::None);
                let rt = match materialize_int(code, iplace, scratch.primary, frame) {
                    Some(r) => r,
                    None => {
                        bail("JumpTable: idx Place not int", idx, iplace);
                        code.truncate(snapshot);
                        fixups.truncate(fixups_snapshot);
                        plt_call_fixups.truncate(plt_call_fixups_snapshot);
                        data_fixups.truncate(data_fixups_snapshot);
                        user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                        asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                        asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                        asm_sections.restore(&asm_sections_snapshot);
                        pending_func_fixups.truncate(pending_func_fixups_snapshot);
                        tls_index_fixups.truncate(tls_index_fixups_snapshot);
                        elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                        macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                        macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                        return false;
                    }
                };
                // rt is an allocated register or scratch.primary, never
                // scratch.secondary, so the table base cannot alias it.
                // The adrp+add pair reaches into the read-only blob, so
                // the writer patches it (RodataAddrFixup).
                let tbl = scratch.secondary;
                let addr_site = code.len();
                emit(code, enc_adrp(tbl, 0));
                emit(code, enc_add_imm(tbl, tbl, 0));
                if abs_jump_tables {
                    emit(code, enc_ldr_reg_lsl3(tbl, tbl, rt));
                } else {
                    emit(code, enc_ldrsw_reg_lsl2(scratch.primary, tbl, rt));
                    emit(code, enc_add_reg(tbl, tbl, scratch.primary));
                }
                emit(code, enc_br(tbl));
                jump_table_fixups.push((addr_site, table));
            }
            Terminator::AsmGoto { table } => {
                // The label branches were lowered inside the
                // `Inst::InlineAsm`; only the fall-through edge (row
                // entry 0) is emitted here.
                let fall = func.jump_tables[table as usize][0];
                if fall as usize != block_idx + 1 {
                    branch_fixups.push(BranchFixup {
                        site: code.len(),
                        target: fall,
                        kind: LocalBranchKind::B,
                    });
                    emit(code, enc_b(0));
                }
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
                        asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                        asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                        asm_sections.restore(&asm_sections_snapshot);
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
            // Sealed after a noreturn call (C11 6.7.4p8): control cannot
            // reach here. Emit a trap so a mis-marked returning call
            // faults rather than falling into the next block.
            Terminator::Unreachable => emit(code, 0xD420_0020), // brk #1
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
            asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
            asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
            asm_sections.restore(&asm_sections_snapshot);
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
    // Static-initializer slots holding one of this function's label
    // addresses: record the block's now-final text offset for the
    // object writers to relocate against.
    for r in &func.label_data_relocs {
        label_relocs.push(super::LabelReloc {
            data_offset: r.data_offset,
            text_offset: block_offsets[r.block as usize] as u64,
        });
    }
    // Rewrite `asm goto` section fields (`.long %l0 - .`) to the label
    // block's now-final text offset. Scoped to this function's contribution
    // via the entry snapshot; only this pass's relocs survived the loop.
    super::ssa::emit_common::resolve_asm_goto_relocs(
        asm_sections.relocs_mut(),
        &asm_sections_snapshot,
        &|bid| block_offsets[bid as usize],
    );
    // Append each ALTERNATIVE replacement after the function body, out of the
    // main sequence's fall-through path (GNU as puts it at the end of the
    // section), and rewrite the `.altinstructions` fields that point at its
    // labels to the region's final text offset.
    let mut deferred_bases: Vec<usize> = Vec::with_capacity(deferred_regions.len());
    if !deferred_regions.is_empty() {
        a64_align_asm_stream(code, text_data_ranges, text_map_state);
    }
    for region in &deferred_regions {
        let base = code.len();
        deferred_bases.push(base);
        code.extend_from_slice(&region.bytes);
        text_data_ranges.extend(region.data_ranges.iter().map(|&(o, n)| (base + o, n)));
        // A replacement branch to a symbol becomes a call fixup (same unit) or
        // a relocation (link-time), as a main-stream one does.
        for sb in &region.sym_branches {
            let native_offset = base + sb.region_off;
            match name2entpc.get(sb.name.as_str()) {
                Some(&ent_pc) => fixups.push(Fixup {
                    native_offset,
                    target_ent_pc: ent_pc,
                    kind: if sb.is_call {
                        BranchKind::Bl
                    } else {
                        BranchKind::B
                    },
                }),
                None => asm_extern_call_sites.push(super::UserExternCallSite {
                    instr_offset: native_offset,
                    symbol_name: sb.name.clone(),
                    is_tail: !sb.is_call,
                }),
            }
        }
    }
    super::ssa::emit_common::resolve_asm_deferred_relocs(
        asm_sections.relocs_mut(),
        &asm_sections_snapshot,
        &|idx| deferred_bases[idx as usize],
    );
    // Resolve replacement `%l[...]` asm-goto branches that leave an out-of-line
    // region: encode each against its target's final offset, now that both the
    // region base and the block layout are known.
    for (idx, region) in deferred_regions.iter().enumerate() {
        let base = deferred_bases[idx];
        for gb in &region.goto_branches {
            let target = match gb.target {
                DeferredGotoTarget::Code(off) => off,
                DeferredGotoTarget::Block(b) => block_offsets[b as usize],
            };
            let site = base + gb.region_off;
            let delta = target as i64 - site as i64;
            let word = match gb.kind {
                LabelBranch::Adr { rd } if (-(1 << 20)..(1 << 20)).contains(&delta) => {
                    Ok(enc_adr(Reg(rd), delta as i32))
                }
                LabelBranch::Adr { .. } => Err(()),
                ref kind => label_branch_word(kind, delta).map_err(|_| ()),
            };
            match word {
                Ok(w) => code[site..site + 4].copy_from_slice(&w.to_le_bytes()),
                Err(()) => {
                    bail_msg("aarch64 inline asm: replacement goto branch target out of range");
                    code.truncate(snapshot);
                    fixups.truncate(fixups_snapshot);
                    plt_call_fixups.truncate(plt_call_fixups_snapshot);
                    data_fixups.truncate(data_fixups_snapshot);
                    user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                    asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                    asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                    asm_sections.restore(&asm_sections_snapshot);
                    pending_func_fixups.truncate(pending_func_fixups_snapshot);
                    tls_index_fixups.truncate(tls_index_fixups_snapshot);
                    elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                    macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                    macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                    return false;
                }
            }
        }
    }
    // Encode each template `%l[...]` branch that reaches its label's block
    // with no operand frame in the way, now that the layout is final.
    for gb in &direct_goto_branches {
        let delta = block_offsets[gb.target as usize] as i64 - gb.site as i64;
        match label_branch_word(&gb.kind, delta) {
            Ok(w) => code[gb.site..gb.site + 4].copy_from_slice(&w.to_le_bytes()),
            Err(m) => {
                bail_msg(&m);
                code.truncate(snapshot);
                fixups.truncate(fixups_snapshot);
                plt_call_fixups.truncate(plt_call_fixups_snapshot);
                data_fixups.truncate(data_fixups_snapshot);
                user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
                asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                asm_sections.restore(&asm_sections_snapshot);
                pending_func_fixups.truncate(pending_func_fixups_snapshot);
                tls_index_fixups.truncate(tls_index_fixups_snapshot);
                elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
                macho_tlv_fixups.truncate(macho_tlv_fixups_snapshot);
                macho_tlv_descriptors.truncate(macho_tlv_descriptors_snapshot);
                return false;
            }
        }
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
            asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
            asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
            asm_sections.restore(&asm_sections_snapshot);
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
                    asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                    asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                    asm_sections.restore(&asm_sections_snapshot);
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
                    asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                    asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                    asm_sections.restore(&asm_sections_snapshot);
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
                    asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                    asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                    asm_sections.restore(&asm_sections_snapshot);
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
                    asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
                    asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
                    asm_sections.restore(&asm_sections_snapshot);
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

    // Materialize each jump table into the read-only blob: one
    // address fixup for the adrp+add site, one slot per entry (a
    // 4-byte `target - table_base` difference, or the relocatable
    // form's 8-byte absolute address left for the object's
    // relocations). Runs past the last bail site so a bailed function
    // leaves the blob untouched.
    for (addr_site, table) in &jump_table_fixups {
        let width: usize = if abs_jump_tables { 8 } else { 4 };
        while !rodata.bytes.len().is_multiple_of(width) {
            rodata.bytes.push(0);
        }
        let base = rodata.bytes.len() as u64;
        rodata.addr_fixups.push(super::RodataAddrFixup {
            code_offset: *addr_site,
            rodata_offset: base,
        });
        for (i, &t) in func.jump_tables[*table as usize].iter().enumerate() {
            let slot_offset = base + (i * width) as u64;
            let text_offset = block_offsets[t as usize] as u64;
            if abs_jump_tables {
                rodata.abs64.push(super::RodataAbs64 {
                    slot_offset,
                    text_offset,
                });
            } else {
                rodata.rel32.push(super::RodataRel32 {
                    slot_offset,
                    base_offset: base,
                    text_offset,
                });
            }
            rodata.bytes.resize(rodata.bytes.len() + width, 0);
        }
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

/// Store a word through sp to take the fault, if the stack ends here, on
/// the page the allocation just entered. `xzr` is always readable and the
/// store sets no flags, so the probe is usable at any point in the
/// lowering without holding a register.
fn emit_stack_probe(code: &mut Vec<u8>) {
    emit(code, super::encode::enc_str_imm(Reg(31), Reg::SP, 0));
}

/// Reserve the realigned region and align sp down to `realign_align`
/// (C11 6.7.5). The reservation descends in probed steps; the AND then
/// descends by up to `realign_align - 1` further bytes, which the probe
/// schedule cannot see. When the two together can outrun the unprobed
/// margin, a probe on each side of the AND keeps every step from a touched
/// address within one page, so a stack overflow still faults in the guard.
/// x16 is the emitter's reserved prologue scratch; AND-immediate cannot read
/// sp, so the alignment stages through it.
fn emit_realign_sp(code: &mut Vec<u8>, frame: Frame) {
    let slack = frame.realign_align - 1;
    let probe = frame.realign_region_bytes.saturating_add(slack) > MAX_UNPROBED_STACK_STEP;
    emit_stack_alloc(code, frame.realign_region_bytes, Some(Reg(16)));
    if probe {
        emit_stack_probe(code);
    }
    emit(code, enc_add_imm(Reg(16), Reg(31), 0));
    emit(
        code,
        super::encode::enc_and_sp_pow2(Reg(16), frame.realign_align.trailing_zeros()),
    );
    if probe {
        emit_stack_probe(code);
    }
}

/// Lower `sp -= bytes`, descending in probed steps when the amount is
/// larger than one step can safely cover.
///
/// A decrement of at most [`MAX_UNPROBED_STACK_STEP`] cannot place sp
/// below the guard region, so it needs no probe. Past that the
/// allocation walks down one page at a time and stores through sp after
/// each step, so an overflow faults inside the guard region instead of
/// writing into whatever mapping lies below it. `scratch` is a register
/// the caller does not need across the allocation; given one, a step
/// count above [`STACK_PROBE_UNROLL_MAX`] becomes a counted loop instead
/// of straight-line steps.
fn emit_stack_alloc(code: &mut Vec<u8>, bytes: u32, scratch: Option<Reg>) {
    if bytes <= MAX_UNPROBED_STACK_STEP {
        emit_sub_sp_imm(code, bytes);
        return;
    }
    let steps = bytes / STACK_PROBE_PAGE;
    let residual = bytes % STACK_PROBE_PAGE;
    let page_step = super::encode::enc_sub_imm_lsl12(Reg::SP, Reg::SP, 1);
    match scratch {
        Some(counter) if steps > STACK_PROBE_UNROLL_MAX => {
            super::encode::load_imm64(code, counter, steps as u64);
            let loop_start = code.len();
            emit(code, page_step);
            emit_stack_probe(code);
            emit(code, super::encode::enc_subs_imm(counter, counter, 1));
            let off = ((loop_start as i64) - (code.len() as i64)) / 4;
            emit(
                code,
                super::encode::enc_b_cond(super::encode::Cond::Ne, off as i32),
            );
        }
        _ => {
            for _ in 0..steps {
                emit(code, page_step);
                emit_stack_probe(code);
            }
        }
    }
    if residual > 0 {
        emit(code, super::encode::enc_sub_imm(Reg::SP, Reg::SP, residual));
        if residual > MAX_UNPROBED_STACK_STEP {
            emit_stack_probe(code);
        }
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
        // never a full leaf (`param_spill_bytes != 0`), so the frame
        // record always follows.
        emit_frame_and_saves(code, alloc, frame);
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
        // The vector half is skipped when the FP/SIMD file is off limits
        // (`no_fp_varargs`): the store itself would fault. The area stays
        // reserved so every offset above it is unchanged, and `va_start`
        // marks it exhausted.
        if !abi.no_fp_varargs {
            for i in 0..8u32 {
                // `str dN, [sp, #gr_save + i*16]` -- the d-register view
                // stores the low eightbyte of vN into the slot start; a
                // `va_arg(double)` reads it back from the same offset.
                emit(
                    code,
                    enc_str_d_imm(i as u8, Reg(31), AARCH64_GR_SAVE_BYTES + i * 16),
                );
            }
        }
        emit_frame_and_saves(code, alloc, frame);
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
                emit_stack_alloc(code, overflow_bytes, None);
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
                        emit_stack_alloc(code, pending_sub, None);
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
                emit_stack_alloc(code, pending_sub, None);
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
    // Standard frame: frame record, fp, frame allocation, callee
    // saves (folded into one pre-indexed group when the frame fits).
    emit_frame_and_saves(code, alloc, frame);
    emit_struct_param_scatter(code, func, abi, frame);
    if func.indirect_result_slot != 0 {
        // AAPCS64 6.9: save the caller-supplied x8 indirect-result
        // pointer into its body local; `return s;` writes the
        // aggregate result through it.
        emit_local_addr_fp(code, Place::IntReg(16), func.indirect_result_slot, frame);
        emit(code, enc_str_imm(Reg(8), Reg(16), 0));
    }
    // C11 6.7.5: reserve the over-aligned objects' region below the static
    // frame and align sp down into it. Done last, after all fp-relative setup;
    // the objects live at [sp + region_off]. Reserving before aligning keeps
    // the AND's descent inside bytes the reservation already claimed, so the
    // region cannot overlap the frame.
    if frame.realign_align > 0 {
        emit_realign_sp(code, frame);
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
    // The argument registers hold the incoming values, so the walk takes
    // no scratch register.
    emit_stack_alloc(code, cells, None);
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
            Some(super::ArgPlacement::StructRegs { regs, n, .. }) => {
                // Materialise the body local's address into x16, then store
                // each unit from its argument register. An integer
                // eightbyte stores at offset 8k; an HFA member stores at
                // its own offset with its natural size (d-register for 8
                // bytes, s-register for 4). x16/x17 are never argument
                // registers, so the source `regs` are untouched.
                let hfa = super::abi_classify::hfa_member_layout(
                    &func.agg_descs[*agg_idx as usize].fields,
                );
                emit_local_addr_fp(code, Place::IntReg(16), slot, frame);
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
            Some(super::ArgPlacement::StructStack { off, size, .. }) => {
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
                emit_local_addr_fp(code, Place::IntReg(16), slot, frame);
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
/// offsets are one slot per saved register, so the pair imm7 (scaled by
/// 8, range -512..504) and the 12-bit scaled immediate always cover
/// them. The allocator spill region, by contrast, can exceed that reach
/// and is addressed through the range-checked SP helpers. x19 is saved
/// just past the allocator-saved gprs, but only when the function
/// clobbers it; the slot is reserved either way so the surrounding
/// offsets stay fixed. Adjacent slots within each region save as
/// stp / ldp pairs; a region's odd tail saves alone.
///
/// When `fold != 0` (see [`frame_fold_bytes`]) the first save carries
/// the whole allocation -- frame plus the fp/lr slot pair -- as a
/// pre-indexed store of `-fold` bytes, replacing the prologue's
/// `stp x29, x30, [sp, #-16]!` / `sub sp` pair; the first save always
/// targets offset 0, so every other offset is unchanged.
fn emit_prologue_saved_regs(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame, fold: u32) {
    let mut alloc_pending = fold != 0;
    let fp = &alloc.fp_used;
    let mut i = 0usize;
    while i + 1 < fp.len() {
        if core::mem::take(&mut alloc_pending) {
            emit(
                code,
                enc_stp_d_pre(fp[i], fp[i + 1], Reg(31), -(fold as i32)),
            );
        } else {
            emit(
                code,
                enc_stp_d_off(fp[i], fp[i + 1], Reg(31), (i as i32) * 8),
            );
        }
        i += 2;
    }
    if i < fp.len() {
        if core::mem::take(&mut alloc_pending) {
            emit(code, enc_str_d_pre(fp[i], Reg(31), -(fold as i32)));
        } else {
            emit(code, enc_str_d_imm(fp[i], Reg(31), (i as u32) * 8));
        }
    }
    let saved_fpr_bytes = super::ssa::emit_common::slots16(fp.len() as u32);
    let gpr = &alloc.gpr_used;
    let mut i = 0usize;
    while i + 1 < gpr.len() {
        let off = (saved_fpr_bytes + (i as u32) * 8) as i32;
        if core::mem::take(&mut alloc_pending) {
            emit(
                code,
                enc_stp_pre(Reg(gpr[i]), Reg(gpr[i + 1]), Reg(31), -(fold as i32)),
            );
        } else {
            emit(
                code,
                enc_stp_off(Reg(gpr[i]), Reg(gpr[i + 1]), Reg(31), off),
            );
        }
        i += 2;
    }
    if i < gpr.len() {
        if core::mem::take(&mut alloc_pending) {
            emit(code, enc_str_pre(Reg(gpr[i]), Reg(31), -(fold as i32)));
        } else {
            let off = saved_fpr_bytes + (i as u32) * 8;
            emit(code, enc_str_imm(Reg(gpr[i]), Reg(31), off));
        }
    }
    if frame.uses_x19 {
        if core::mem::take(&mut alloc_pending) {
            emit(code, enc_str_pre(Reg(19), Reg(31), -(fold as i32)));
        } else {
            let saved_gpr_bytes = super::ssa::emit_common::slots16(gpr.len() as u32);
            emit(
                code,
                enc_str_imm(Reg(19), Reg(31), saved_fpr_bytes + saved_gpr_bytes),
            );
        }
    }
    debug_assert!(!alloc_pending, "frame fold requested with no callee save");
}

/// Re-establish `sp = fp - frame_bytes` in a dynamic-sp frame before
/// the epilogue's sp-relative restores. No-op for static frames. A
/// split displacement is computed into x16 and committed with one
/// write, so sp never rests above still-unrestored frame bytes (a
/// signal delivered mid-sequence pushes its frame below sp).
fn restore_dynamic_sp(code: &mut Vec<u8>, frame: Frame) {
    if !frame.dynamic_sp {
        return;
    }
    let bytes = frame.frame_bytes;
    if bytes < 4096 {
        emit(code, enc_sub_imm(Reg(31), Reg(29), bytes));
    } else {
        emit_fp_minus_off(code, Reg(16), bytes);
        emit(code, enc_add_imm(Reg(31), Reg(16), 0));
    }
}

/// Restore what [`emit_prologue_saved_regs`] saved, in mirror order
/// (x19, gprs descending, fp regs descending) so the offset-0 access
/// comes last and, when `fold != 0`, tears the frame down as a
/// post-indexed load of `fold` bytes, replacing the epilogue's
/// `add sp` and the fp/lr `ldp`. `fold` is the total writeback
/// (frame plus the fp/lr pair), or 0 for the unfolded shape.
fn emit_epilogue_restore_regs(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame, fold: u32) {
    let saved_fpr_bytes = super::ssa::emit_common::slots16(alloc.fp_used.len() as u32);
    let gpr = &alloc.gpr_used;
    if frame.uses_x19 {
        let saved_gpr_bytes = super::ssa::emit_common::slots16(gpr.len() as u32);
        let off = saved_fpr_bytes + saved_gpr_bytes;
        if off == 0 && fold != 0 {
            emit(code, enc_ldr_post(Reg(19), Reg(31), fold as i32));
        } else {
            emit(code, enc_ldr_imm(Reg(19), Reg(31), off));
        }
    }
    let mut i = gpr.len();
    if i % 2 == 1 {
        i -= 1;
        let off = saved_fpr_bytes + (i as u32) * 8;
        if off == 0 && fold != 0 {
            emit(code, enc_ldr_post(Reg(gpr[i]), Reg(31), fold as i32));
        } else {
            emit(code, enc_ldr_imm(Reg(gpr[i]), Reg(31), off));
        }
    }
    while i >= 2 {
        i -= 2;
        let off = (saved_fpr_bytes + (i as u32) * 8) as i32;
        if off == 0 && fold != 0 {
            emit(
                code,
                enc_ldp_post(Reg(gpr[i]), Reg(gpr[i + 1]), Reg(31), fold as i32),
            );
        } else {
            emit(
                code,
                enc_ldp_off(Reg(gpr[i]), Reg(gpr[i + 1]), Reg(31), off),
            );
        }
    }
    let fp = &alloc.fp_used;
    let mut i = fp.len();
    if i % 2 == 1 {
        i -= 1;
        if i == 0 && fold != 0 {
            emit(code, enc_ldr_d_post(fp[i], Reg(31), fold as i32));
        } else {
            emit(code, enc_ldr_d_imm(fp[i], Reg(31), (i as u32) * 8));
        }
    }
    while i >= 2 {
        i -= 2;
        if i == 0 && fold != 0 {
            emit(code, enc_ldp_d_post(fp[i], fp[i + 1], Reg(31), fold as i32));
        } else {
            emit(
                code,
                enc_ldp_d_off(fp[i], fp[i + 1], Reg(31), (i as i32) * 8),
            );
        }
    }
}

/// Frame bytes the folded prologue / epilogue shape can carry, or 0
/// when the fold does not apply. The folded shape extends the frame by
/// the 16-byte fp/lr slot pair at its top: the first callee save
/// pre-indexes `-(frame_bytes + 16)`, fp/lr store / load through the
/// signed-offset pair form at `[sp, #frame_bytes]`, and the last
/// restore post-indexes the whole amount back. All three must fit
/// their immediates: the scaled imm7 pair forms reach +-504/512, so a
/// pair-first frame folds up to 488 (16-aligned: 480); a single-register
/// bottom save uses the unscaled imm9 (+-255) and folds up to 224.
/// Both sides compute the fold from the same inputs so they agree.
fn frame_fold_bytes(alloc: &Allocation, frame: Frame) -> u32 {
    // A realigning function uses the unfolded shape so the epilogue's
    // `restore_dynamic_sp` (sub sp, fp, #frame_bytes) cleanly returns sp to the
    // static frame bottom before the sp-relative restores (C11 6.7.5).
    if frame.realign_align != 0 {
        return 0;
    }
    let n_bottom = if !alloc.fp_used.is_empty() {
        alloc.fp_used.len()
    } else if !alloc.gpr_used.is_empty() {
        alloc.gpr_used.len()
    } else if frame.uses_x19 {
        1
    } else {
        return 0;
    };
    debug_assert!(frame.frame_bytes >= 16, "saves imply a non-empty frame");
    let limit = if n_bottom >= 2 { 480 } else { 224 };
    if frame.frame_bytes <= limit {
        frame.frame_bytes
    } else {
        0
    }
}

/// Establish the frame record and fp, allocate the frame, and save the
/// callee-saved registers. The folded shape allocates everything with
/// the first callee save's pre-index and keeps fp and every offset
/// identical to the unfolded `stp fp/lr; mov fp, sp; sub sp` shape;
/// fp/lr restore first in the epilogue, so the `ret`-feeding lr load
/// issues off an address that depends on no other restore.
fn emit_frame_and_saves(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame) {
    let fold = frame_fold_bytes(alloc, frame);
    if fold != 0 {
        emit_prologue_saved_regs(code, alloc, frame, fold + 16);
        emit(code, enc_stp_off(Reg(29), Reg(30), Reg(31), fold as i32));
        emit(code, enc_add_imm(Reg(29), Reg(31), fold));
        return;
    }
    emit(code, enc_stp_pre(Reg(29), Reg(30), Reg(31), -16));
    emit(code, enc_add_imm(Reg(29), Reg(31), 0));
    if frame.frame_bytes > 0 {
        // x16 is the emitter's reserved prologue scratch.
        emit_stack_alloc(code, frame.frame_bytes, Some(Reg(16)));
    }
    emit_prologue_saved_regs(code, alloc, frame, 0);
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
/// back to the unfused `cbz` / `cbnz` path). The FP conditions map
/// as the `fcmp` + `cset` pair does, and `Cond::flip` is an exact
/// NZCV complement, so an inverted FP branch is taken on the
/// unordered (NaN) state exactly when C99 6.5.8p6 / 6.5.9p3
/// require the negated comparison to hold.
fn fused_branch_cond(
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    cond: super::super::ir::ValueId,
    negate: bool,
) -> Option<super::encode::Cond> {
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
    let positive = compare_cond(op).or_else(|| fp_compare_cond(op))?;
    Some(if negate { positive.flip() } else { positive })
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
    /// `Inst::ImmData` value-id -> cross-TU data symbol name, for an `i`-class
    /// inline-asm operand that names an external address in a section field.
    extern_data_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    param_plan: &'a [super::ArgPlacement],
    /// Function name -> entry PC, for resolving an inline-asm `bl` / `b` to a
    /// named symbol.
    name2entpc: &'a alloc::collections::BTreeMap<alloc::string::String, usize>,
    /// Internal-linkage data object name -> unified data offset, for a
    /// function-body inline-asm symbol operand naming a static.
    data_sym_offsets: &'a alloc::collections::BTreeMap<alloc::string::String, i64>,
}

/// Block-target branch context for an `asm goto` statement: the
/// `jump_tables` row (`[fall_through, label targets...]`) and the
/// enclosing function's branch-fixup lists. A template `%lK` branch lands
/// on a local restore trampoline whose final `b` is patched to the label's
/// block like any other block-local branch; with no operand frame to
/// release it is recorded in `direct_goto` and patched to the block
/// itself, so it and a `.long %lK - .` section field name one address.
struct AsmGotoCtxA64<'a> {
    row: &'a [super::super::ir::BlockId],
    branch_fixups: &'a mut Vec<BranchFixup>,
    direct_goto: &'a mut Vec<AsmGotoDirectBranch>,
}

/// A template `%lK` branch resolved straight to its label's block: the
/// branch's byte offset in the function's code, its form, and the block.
/// Encoded once the block layout is final.
struct AsmGotoDirectBranch {
    site: usize,
    kind: LabelBranch,
    target: u32,
}

/// A deferred ALTERNATIVE replacement region (`.subsection 1`): the encoded
/// replacement instructions, appended to `.text` after the function body so
/// the main sequence does not fall through into it. `labels` records each
/// local label's byte offset within `bytes` so the `.altinstructions`
/// entry's `.word 663f - .` resolves to the replacement's final text
/// offset once the region is placed.
struct DeferredAsmRegion {
    bytes: alloc::vec::Vec<u8>,
    labels: alloc::vec::Vec<(u32, usize)>,
    goto_branches: alloc::vec::Vec<DeferredGotoBranch>,
    sym_branches: alloc::vec::Vec<DeferredSymBranch>,
    /// Region-relative `(offset, length)` of each data run, recorded so the
    /// mapping symbols cover them once the region's text base is known.
    data_ranges: alloc::vec::Vec<(usize, usize)>,
}

/// A replacement `b` / `bl` to a symbol. The rel26 is a link-time or
/// whole-text decision, so the region carries a zero placeholder word and the
/// site is registered as a call fixup once the region's text base is known.
struct DeferredSymBranch {
    region_off: usize,
    name: alloc::string::String,
    is_call: bool,
}

/// A replacement `%l[...]` asm-goto branch that leaves the out-of-line region
/// for a target in the enclosing function. `region_off` is the branch's byte
/// offset within the region; the displacement is resolved once the region base
/// and block layout are final.
struct DeferredGotoBranch {
    region_off: usize,
    kind: LabelBranch,
    target: DeferredGotoTarget,
}

/// Where a `DeferredGotoBranch` lands.
enum DeferredGotoTarget {
    /// A fixed code offset in the function body -- the asm's operand-frame
    /// teardown trampoline (or fall-through exit) -- reached before the label.
    Code(usize),
    /// A block, branched to directly when the asm needs no teardown.
    Block(u32),
}

/// A template branch to a local (`Nf` / `Nb`) or `asm goto` (`%lK`)
/// label, recorded as a placeholder word and patched once the target
/// offset is known.
#[derive(Clone, Copy)]
enum LabelBranch {
    B,
    Bl,
    BCond(u8),
    Cb { nz: bool, rt: u8, is64: bool },
    Tb { nz: bool, rt: u8, bit: u8 },
    Adr { rd: u8 },
}

/// Encode a resolved label branch; `delta` is the byte displacement
/// from the branch instruction to its target. `Adr` is byte-granular
/// and handled by the caller.
fn label_branch_word(kind: &LabelBranch, delta: i64) -> Result<u32, alloc::string::String> {
    use alloc::string::String;
    if delta % 4 != 0 {
        return Err(String::from(
            "aarch64 inline asm: label target is not word-aligned",
        ));
    }
    let words = (delta / 4) as i32;
    let fits = |bits: u32| {
        let lim = 1i32 << (bits - 1);
        (-lim..lim).contains(&words)
    };
    Ok(match *kind {
        LabelBranch::B => {
            if !fits(26) {
                return Err(String::from(
                    "aarch64 inline asm: branch target out of range",
                ));
            }
            super::encode::enc_b(words)
        }
        LabelBranch::Bl => {
            if !fits(26) {
                return Err(String::from(
                    "aarch64 inline asm: branch target out of range",
                ));
            }
            super::encode::enc_bl(words)
        }
        // B.cond: 0101_0100 | imm19 << 5 | cond.
        LabelBranch::BCond(c) => {
            if !fits(19) {
                return Err(String::from(
                    "aarch64 inline asm: branch target out of range",
                ));
            }
            0x5400_0000 | (((words as u32) & 0x7_FFFF) << 5) | c as u32
        }
        // CBZ/CBNZ: sf | 0011_010z | imm19 << 5 | Rt.
        LabelBranch::Cb { nz, rt, is64 } => {
            if !fits(19) {
                return Err(String::from(
                    "aarch64 inline asm: branch target out of range",
                ));
            }
            (if is64 { 1u32 << 31 } else { 0 })
                | (if nz { 0x3500_0000 } else { 0x3400_0000 })
                | (((words as u32) & 0x7_FFFF) << 5)
                | rt as u32
        }
        // TBZ/TBNZ: bit<5> | 0011_011z | bit<4:0> << 19 | imm14 << 5 | Rt.
        LabelBranch::Tb { nz, rt, bit } => {
            if !fits(14) {
                return Err(String::from(
                    "aarch64 inline asm: branch target out of range",
                ));
            }
            ((bit as u32 >> 5) << 31)
                | (if nz { 0x3700_0000 } else { 0x3600_0000 })
                | ((bit as u32 & 31) << 19)
                | (((words as u32) & 0x3FFF) << 5)
                | rt as u32
        }
        LabelBranch::Adr { .. } => {
            return Err(String::from(
                "aarch64 inline asm: adr is not a branch encoding",
            ));
        }
    })
}

/// Resolve a label-branch instruction -- `b` / `b.cond` / `cbz` / `cbnz` /
/// `tbz` / `tbnz` / `adr` with a local label, `.`, or `%l[...]` target -- to
/// its `LabelBranch` kind. Register and bit-number operands are read through
/// `conv`, the same converter the table encoder uses, so the main stream and
/// the out-of-line replacement region admit the same set of forms.
fn build_label_branch(
    insn: &super::asm::AsmInsnA64,
    conv: &dyn Fn(&super::asm::AsmOpndA64) -> Result<super::table::Opnd, alloc::string::String>,
) -> Result<LabelBranch, alloc::string::String> {
    use super::asm::AsmOpndA64;
    use super::table::Opnd;
    use alloc::string::String;
    Ok(match insn.mnemonic.as_str() {
        "b" if insn.operands.len() == 1 => LabelBranch::B,
        "bl" if insn.operands.len() == 1 => LabelBranch::Bl,
        "cbz" | "cbnz" if insn.operands.len() == 2 => match conv(&insn.operands[0])? {
            Opnd::Reg { num: rt, is64, .. } => LabelBranch::Cb {
                nz: insn.mnemonic == "cbnz",
                rt,
                is64,
            },
            _ => {
                return Err(String::from(
                    "aarch64 inline asm: cbz/cbnz operand must be a register",
                ));
            }
        },
        "tbz" | "tbnz" if insn.operands.len() == 3 => {
            let (rt, is64) = match conv(&insn.operands[0])? {
                Opnd::Reg { num, is64, .. } => (num, is64),
                _ => {
                    return Err(String::from(
                        "aarch64 inline asm: tbz/tbnz operand must be a register",
                    ));
                }
            };
            let AsmOpndA64::Imm(bit) = insn.operands[1] else {
                return Err(String::from(
                    "aarch64 inline asm: tbz/tbnz bit number must be an immediate",
                ));
            };
            if bit < 0 || bit >= if is64 { 64 } else { 32 } {
                return Err(String::from(
                    "aarch64 inline asm: tbz/tbnz bit number out of range",
                ));
            }
            LabelBranch::Tb {
                nz: insn.mnemonic == "tbnz",
                rt,
                bit: bit as u8,
            }
        }
        "adr" if insn.operands.len() == 2 => match conv(&insn.operands[0])? {
            Opnd::Reg {
                num, is64: true, ..
            } => LabelBranch::Adr { rd: num },
            _ => {
                return Err(String::from(
                    "aarch64 inline asm: adr destination must be a 64-bit register",
                ));
            }
        },
        m => {
            // Both conditional spellings: `b.<cond>` and the bare `b<cond>`
            // (`bne`, `beq`), which GNU as also accepts.
            let cond = m
                .strip_prefix("b.")
                .and_then(super::asm::cond_code)
                .or_else(|| m.strip_prefix('b').and_then(super::asm::cond_code));
            match cond.filter(|_| insn.operands.len() == 1) {
                Some(c) => LabelBranch::BCond(c),
                None => {
                    return Err(String::from(
                        "aarch64 inline asm: label branch must be b/b.cond/cbz/cbnz",
                    ));
                }
            }
        }
    })
}

/// Encode an ALTERNATIVE `.subsection` replacement into a deferred region:
/// the machine bytes plus each local label's byte offset within them. A branch
/// to a local label (`Nf` / `Nb`) or `.` resolves within the region (the
/// displacement is target-minus-branch inside the region, invariant of where
/// the region lands), matching GNU-as local-label practice. A branch to an
/// `asm goto` label (`%l[...]`) leaves the region for the enclosing function
/// and is returned for the caller to resolve once the block layout is final. A
/// symbol target is rejected rather than mis-placed, since its bytes would need
/// a relocation at the final out-of-line offset. Instructions encode through
/// the same operand converter and table encoder as the main stream, so the
/// region admits exactly what an inline instruction does. `main_label` resolves
/// a main-stream label (`661b` / `662b`) for the `.org` length expression. The
/// returned goto sites are `(byte offset in the region, branch kind, label
/// index)`.
#[allow(clippy::type_complexity)]
fn encode_deferred_asm_region(
    text: &str,
    conv: &dyn Fn(&super::asm::AsmOpndA64) -> Result<super::table::Opnd, alloc::string::String>,
    main_label: &dyn Fn(&str) -> Option<usize>,
    sym_name: &dyn Fn(&str) -> Result<alloc::string::String, alloc::string::String>,
) -> Result<(DeferredAsmRegion, Vec<(usize, LabelBranch, u8)>), alloc::string::String> {
    use super::super::map_syms::MapClass;
    use super::asm::{AsmOpndA64, parse_template};
    use super::table::{self, Opnd};
    use alloc::string::String;
    let mut bytes: Vec<u8> = Vec::new();
    // The replacement is appended to `.text`, so it follows the same mapping
    // rule the main stream does.
    let mut map_state: Option<MapClass> = None;
    let mut data_ranges: Vec<(usize, usize)> = Vec::new();
    let mut labels: Vec<(u32, usize)> = Vec::new();
    // Branches to a region-local label, patched after the loop once every
    // label offset is known: `(byte offset in the region, kind, label, forward)`.
    let mut label_fixups: Vec<(usize, LabelBranch, u32, bool)> = Vec::new();
    let mut goto_sites: Vec<(usize, LabelBranch, u8)> = Vec::new();
    let mut sym_branches: Vec<DeferredSymBranch> = Vec::new();
    for stmt in text.split(['\n', ';']) {
        let mut stmt = stmt.trim();
        // Peel leading `N:` label definitions; a directive may follow one.
        while let Some(colon) = stmt.find(':') {
            let head = &stmt[..colon];
            if head.is_empty() || !head.bytes().all(|c| c.is_ascii_digit()) {
                break;
            }
            let num: u32 = head
                .parse()
                .map_err(|_| alloc::format!("inline asm: bad label `{head}:`"))?;
            labels.push((num, bytes.len()));
            stmt = stmt[colon + 1..].trim();
        }
        if stmt.is_empty() {
            continue;
        }
        // `.org <expr>`: pad forward to the target; a backward move is the
        // ALTERNATIVE length-mismatch assertion firing, an error as in GNU as.
        if let Some(rest) = stmt.strip_prefix(".org")
            && (rest.is_empty() || rest.starts_with(char::is_whitespace))
        {
            let expr = rest.trim();
            let cur = bytes.len() as i64;
            // The location counter `.` is the current region offset; a `Nb`
            // label resolves in the region (a `663b` / `664b` replacement
            // label) or falls back to the main stream (`661b` / `662b`). The
            // expression uses only label differences, so the main labels'
            // absolute offsets cancel.
            let resolve = |name: &str| -> Option<i64> {
                if name == "." {
                    return Some(cur);
                }
                let digits = name.strip_suffix(['b', 'f']).unwrap_or(name);
                if let Ok(n) = digits.parse::<u32>()
                    && let Some(off) = labels.iter().rev().find(|&&(l, _)| l == n)
                {
                    return Some(off.1 as i64);
                }
                main_label(name).map(|o| o as i64)
            };
            let target = super::ssa::emit_common::eval_asm_expr_with_labels(expr, &resolve)
                .ok_or_else(|| {
                    alloc::format!("inline asm: unsupported `.org` expression `{expr}`")
                })?;
            if target < cur {
                return Err(String::from(
                    "inline asm: ALTERNATIVE replacement and original differ in length",
                ));
            }
            bytes.resize(target as usize, 0);
            continue;
        }
        for insn in &parse_template(stmt.as_bytes())? {
            if let Some(num) = insn.label_def {
                labels.push((num, bytes.len()));
                continue;
            }
            // A layout directive resolves against the region's own counter,
            // which is where its labels are recorded.
            if let Some(item) = &insn.layout {
                let resolve = |name: &str| -> Option<i64> {
                    let num: u32 = name.strip_suffix(['b', 'f']).unwrap_or(name).parse().ok()?;
                    labels
                        .iter()
                        .rfind(|&&(n, _)| n == num)
                        .map(|&(_, off)| off as i64)
                };
                let resolved = super::ssa::emit_common::resolve_align_item(item, &resolve)?;
                let item = resolved.as_ref().unwrap_or(item);
                super::ssa::emit_common::push_a64_stream_layout(
                    item,
                    &mut bytes,
                    &mut data_ranges,
                    &resolve,
                    &|_| None,
                )?;
                map_state = super::ssa::emit_common::step_map_state(item, map_state, true);
                continue;
            }
            let class = super::ssa::emit_common::data_directive_class(&insn.mnemonic)
                .unwrap_or(MapClass::Code);
            if class == MapClass::Code {
                a64_align_asm_stream(&mut bytes, &mut data_ranges, &mut map_state);
            }
            map_state = Some(class);
            if !insn.bytes.is_empty() {
                if class == MapClass::Data {
                    data_ranges.push((bytes.len(), insn.bytes.len()));
                }
                bytes.extend_from_slice(&insn.bytes);
                continue;
            }
            if let Some(name) = &insn.sym_target {
                let is_call = insn.mnemonic == "bl";
                sym_branches.push(DeferredSymBranch {
                    region_off: bytes.len(),
                    name: sym_name(name)?,
                    is_call,
                });
                let word = if is_call {
                    super::encode::enc_bl(0)
                } else {
                    super::encode::enc_b(0)
                };
                bytes.extend_from_slice(&word.to_le_bytes());
                continue;
            }
            match insn.operands.last() {
                Some(&AsmOpndA64::Here(off)) => {
                    // `.` names the branch's own address, plus any offset.
                    let kind = build_label_branch(insn, conv)?;
                    let word = match kind {
                        LabelBranch::Adr { rd } => {
                            if !(-(1i32 << 20)..(1i32 << 20)).contains(&off) {
                                return Err(String::from(
                                    "aarch64 inline asm: adr target out of +/-1MiB range",
                                ));
                            }
                            super::encode::enc_adr(Reg(rd), off)
                        }
                        _ => label_branch_word(&kind, off as i64)?,
                    };
                    bytes.extend_from_slice(&word.to_le_bytes());
                }
                Some(&AsmOpndA64::Label { num, forward }) => {
                    label_fixups.push((bytes.len(), build_label_branch(insn, conv)?, num, forward));
                    bytes.extend_from_slice(&0u32.to_le_bytes());
                }
                Some(&AsmOpndA64::GotoLabel(k)) => {
                    goto_sites.push((bytes.len(), build_label_branch(insn, conv)?, k));
                    bytes.extend_from_slice(&0u32.to_le_bytes());
                }
                _ => {
                    let mut ops: Vec<Opnd> = Vec::with_capacity(insn.operands.len());
                    for o in &insn.operands {
                        ops.push(conv(o)?);
                    }
                    bytes.extend_from_slice(&table::encode(&insn.mnemonic, &ops)?.to_le_bytes());
                }
            }
        }
    }
    // What follows the region in `.text` is instructions, so a replacement
    // ending in data realigns here.
    a64_align_asm_stream(&mut bytes, &mut data_ranges, &mut map_state);
    // Resolve the region-local label branches: a forward reference binds the
    // next definition after the branch, a backward one the most recent at or
    // before it (GNU-as `Nf` / `Nb`). The displacement is region-relative and
    // holds wherever the region is finally placed.
    for &(site, ref kind, num, forward) in &label_fixups {
        let target = if forward {
            labels.iter().find(|&&(n, off)| n == num && off > site)
        } else {
            labels
                .iter()
                .rev()
                .find(|&&(n, off)| n == num && off <= site)
        };
        let Some(&(_, target)) = target else {
            return Err(String::from("aarch64 inline asm: undefined local label"));
        };
        let delta = target as i64 - site as i64;
        let word = if let LabelBranch::Adr { rd } = *kind {
            if !(-(1i64 << 20)..(1i64 << 20)).contains(&delta) {
                return Err(String::from(
                    "aarch64 inline asm: adr target out of +/-1MiB range",
                ));
            }
            super::encode::enc_adr(Reg(rd), delta as i32)
        } else {
            label_branch_word(kind, delta)?
        };
        bytes[site..site + 4].copy_from_slice(&word.to_le_bytes());
    }
    Ok((
        DeferredAsmRegion {
            bytes,
            labels,
            goto_branches: Vec::new(),
            sym_branches,
            data_ranges,
        },
        goto_sites,
    ))
}

/// The value of a template field's expression at stream offset `at`, over
/// the template's own label definitions. `None` when a leaf is unresolved.
fn template_expr_value(
    expr: &str,
    at: usize,
    label_defs: &[(u32, usize)],
    names: &[&str],
) -> Option<i64> {
    super::super::ssa::emit_common::eval_asm_expr_with_labels(expr, &|name| {
        super::super::ssa::emit_common::template_label_offset(name, at, label_defs, names)
    })
}

/// Bring a stream to the instruction boundary out of the data mapping
/// state, as GNU as does in an executable section, and leave `state` on the
/// instructions the caller is about to lay down. The gap is under one
/// instruction, so the shared fill lays it down as zeros; the padding is
/// part of the data run it follows.
fn a64_align_asm_stream(
    code: &mut Vec<u8>,
    text_data_ranges: &mut Vec<(usize, usize)>,
    state: &mut Option<super::super::map_syms::MapClass>,
) {
    let gap = super::super::ssa::emit_common::insn_align_gap(code.len() as i64, *state, true, true)
        as usize;
    *state = Some(super::super::map_syms::MapClass::Code);
    if gap == 0 {
        return;
    }
    text_data_ranges.push((code.len(), gap));
    super::super::ssa::emit_common::push_a64_exec_align_fill(code, gap);
}

/// Lower an `Inst::InlineAsm` (GCC extended asm) on AArch64. Assigns each
/// register operand a machine register per its constraint, saves the registers
/// the block overwrites, captures the operand values / addresses to a stack
/// region, loads the inputs, encodes the register-concrete template through the
/// table encoder, and stores the outputs back through their addresses. Raw-byte
/// pieces emit their literal bytes verbatim. `x16` / `x17` are the bridge
/// scratch, so the operand pool is `x0..x15`. `goto_ctx` is present for
/// the `asm goto` form (the statement is the last instruction of a
/// `Terminator::AsmGoto` block).
fn emit_inline_asm_aarch64(
    code: &mut Vec<u8>,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    fixups: &mut Vec<super::encode::Fixup>,
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    data_sym_offsets: &alloc::collections::BTreeMap<alloc::string::String, i64>,
    asm_sections: &mut super::ssa::emit_common::AsmSectionSink,
    asm_extern_call_sites: &mut Vec<super::UserExternCallSite>,
    asm_sym_fixups: &mut Vec<super::AsmSymFixup>,
    deferred_regions: &mut Vec<DeferredAsmRegion>,
    text_data_ranges: &mut Vec<(usize, usize)>,
    text_align: &mut usize,
    text_map_state: &mut Option<super::super::map_syms::MapClass>,
    asm_text_labels: &mut Vec<super::AsmTextLabel>,
    asm_section_text_refs: &mut Vec<super::AsmSectionTextRef>,
    goto_ctx: Option<AsmGotoCtxA64<'_>>,
) -> bool {
    use super::super::ir::AsmConstraint;
    use super::super::map_syms::MapClass;
    use super::asm::{AsmOpndA64, assign_operand_regs, parse_template};
    use super::encode::{enc_add_imm, enc_str_imm, enc_str32_imm, enc_strh_imm, enc_sub_imm};
    use super::table::{self, Opnd};
    use alloc::string::String;

    // A statement that lowers to nothing keeps only its IR-level ordering
    // effect; the operand staging around zero bytes of code is dead, and
    // `asm_scratch_bytes` reserved no region for it.
    if super::ssa::emit_common::asm_statement_is_noop(
        asm,
        super::ssa::emit_common::AsmComments::A64,
    ) {
        return true;
    }
    // Expand `%=` once so the code text and any `.pushsection` content
    // share one instance number, then split off the section blocks; the
    // arch parser sees only the code text.
    let Ok(raw_text) = core::str::from_utf8(&asm.template) else {
        bail_msg("aarch64 inline asm: non-UTF8 template");
        return false;
    };
    let stripped = super::ssa::emit_common::strip_asm_comments(
        raw_text,
        super::ssa::emit_common::AsmComments::A64,
    );
    let raw_text = stripped.as_deref().unwrap_or(raw_text);
    let expanded = super::ssa::emit_common::expand_template_uniq(raw_text);
    let text = expanded.as_deref().unwrap_or(raw_text);
    let reduced = match super::ssa::emit_common::strip_asm_conditionals(text) {
        Ok(r) => r,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    let text = reduced.as_deref().unwrap_or(text);
    // Assign operand registers before the GNU-as macro pass so it can
    // substitute each reference to its register name -- the same register the
    // operand capture and write-back below use.
    let op_reg = match assign_operand_regs(&asm.operands, asm.clobber_regs, asm.clobber_fp_regs) {
        Ok(r) => r,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    // The constant value of an `i`-class operand reference, if any.
    let const_of = |idx: u8| -> Option<i64> {
        let arg = *args.get(idx as usize)?;
        match func.insts.get(arg as usize) {
            Some(super::super::ir::Inst::Imm(v)) => Some(*v),
            // An unpromoted function (a computed goto opts out of mem2reg)
            // leaves an `"i"` constant operand a load of a constant local.
            _ => super::ssa::emit_common::asm_operand_local_const(func, arg),
        }
    };
    let gas_subst = |tok: &str| -> Option<String> {
        let body = tok.strip_prefix('%')?;
        let (force, digits) = match body.as_bytes().first()? {
            b'w' => (Some(false), &body[1..]),
            b'x' => (Some(true), &body[1..]),
            b'c' | b'P' => {
                let idx: u8 = body[1..].parse().ok()?;
                return const_of(idx).map(|v| alloc::format!("{v}"));
            }
            _ => (None, body),
        };
        let idx: u8 = digits.parse().ok()?;
        let r = op_reg.get(idx as usize).copied().flatten()?;
        // A `Q` operand substitutes as the whole memory reference `[xN]`
        // through its address register, matching the operand converter's
        // rule for the un-expanded `%N` form.
        if matches!(
            asm.operands.get(idx as usize).map(|o| o.constraint),
            Some(AsmConstraint::MemBase)
        ) {
            return Some(alloc::format!("[x{r}]"));
        }
        let wide = asm
            .operands
            .get(idx as usize)
            .map(|o| o.width >= 8)
            .unwrap_or(true);
        Some(alloc::format!(
            "{}{}",
            if force.unwrap_or(wide) { 'x' } else { 'w' },
            r
        ))
    };
    let gas = match super::ssa::emit_common::expand_asm_gas_macros(text, 4, &gas_subst) {
        Ok(e) => e,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    let text = gas.as_deref().unwrap_or(text);
    // Lift any ALTERNATIVE `.subsection` replacement out of the main stream;
    // it is encoded into a deferred region appended after the function body
    // (below), out of the main sequence's fall-through path.
    let (main_text, deferred_text) = super::ssa::emit_common::split_asm_subsections(text);
    let text = main_text.as_str();
    let extracted = match super::ssa::emit_common::extract_asm_sections(text, true) {
        Ok(e) => e,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    // Owned parts: the blocks are encoded in place below, once the operand
    // converter exists, while the code text stays borrowable.
    let (code_owned, mut section_blocks, sym_items) = match extracted {
        Some(ex) => (Some(ex.code), ex.blocks, ex.sym_items),
        None => (None, Vec::new(), Vec::new()),
    };
    let code_text: &str = code_owned.as_deref().unwrap_or(text);
    if let Err(m) = super::ssa::emit_common::reject_unit_symbol_items(&section_blocks) {
        bail_msg(&m);
        return false;
    }
    // The template's symbol directives declare names of the unit; the object
    // writer applies them, where every definition is known.
    if let Err(m) = asm_sections.push_sym_decls(&sym_items) {
        bail_msg(&m);
        return false;
    }
    let insns = match parse_template(code_text.as_bytes()) {
        Ok(i) => i,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    // Registers the block overwrites: the operand registers plus the explicit
    // clobber list. Every general register is saved around the block, since the
    // allocator may hold a live value in any of them; x16 / x17 are this
    // lowering's own scratch, reloaded after the template rather than carried
    // across it. `w` operands and FP clobbers are in the independent d0..d7
    // file and are saved separately. `asm_save_masks` is shared with the
    // frame-region sizing in `compute_frame`.
    let (used_mask, fp_used_mask) = match asm_save_masks(asm, &op_reg) {
        Ok(m) => m,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    let save_list: Vec<u8> = (0u8..31).filter(|r| used_mask & (1 << r) != 0).collect();
    let fp_save_list: Vec<u8> = (0u8..8).filter(|r| fp_used_mask & (1 << r) != 0).collect();

    let n = asm.operands.len();
    let n_saved = save_list.len();
    let n_fp_saved = fp_save_list.len();
    // An immediate-only operand is substituted into the template text and
    // has no runtime storage, so it takes no capture slot. Keeping the
    // region empty for a template whose only operands are immediates
    // matters beyond the saved bytes: the region is released on the paths
    // out of the template, and an `asm goto` label reached by a branch
    // planted at run time -- a jump-label or alternative patch site, whose
    // `%l` is a data reference rather than a branch in the template --
    // bypasses every one of them.
    let needs_cap: Vec<bool> = asm
        .operands
        .iter()
        .map(|o| !matches!(o.constraint, AsmConstraint::Imm))
        .collect();
    let mut cap_slot: Vec<usize> = alloc::vec![0; n];
    let mut n_cap = 0usize;
    for (i, &c) in needs_cap.iter().enumerate() {
        if c {
            cap_slot[i] = n_cap;
            n_cap += 1;
        }
    }
    // Region layout: captures first, then the saved GP registers, then the
    // saved FP registers, a 16-byte multiple. The region is frame storage at
    // `[sp + region_base + off]` (`Frame::asm_scratch_off`): sp does not move,
    // so an `asm goto` label reached by a run-time-patched branch -- a
    // published `%l` in a jump table, which bypasses every exit path of the
    // template -- leaves sp balanced. A naked function has no frame, so its
    // region is carved from sp around the template as a self-contained pair.
    let size = (((n_cap + n_saved + n_fp_saved) * 8) as u32 + 15) & !15;
    let carve = func.is_naked && size > 0;
    // An empty region means no entry or exit work: every capture, save and
    // operand load addresses it, and an operand with no register takes no
    // slot. The template's own realignment is per instruction below.
    let mut map_state = *text_map_state;
    if size > 0 {
        a64_align_asm_stream(code, text_data_ranges, &mut map_state);
    }
    let region_base: u32 = if carve {
        if size > MAX_UNPROBED_STACK_STEP {
            bail_msg("aarch64 inline asm: operand frame too large");
            return false;
        }
        emit(code, enc_sub_imm(Reg(31), Reg(31), size));
        0
    } else {
        debug_assert!(
            size == 0 || (frame.asm_scratch_off + size as i64) <= 0,
            "inline asm without a frame scratch region"
        );
        (frame.frame_bytes as i64 + frame.asm_scratch_off) as u32
    };
    // The carve moved sp under the allocator's sp-relative spill slots; frame
    // storage leaves sp alone.
    let spill_shift = if carve { size } else { 0 };
    let cap_off = |i: usize| region_base + (cap_slot[i] * 8) as u32;
    let save_off = |j: usize| region_base + ((n_cap + j) * 8) as u32;
    let fp_save_off = |k: usize| region_base + ((n_cap + n_saved + k) * 8) as u32;
    // Region slot accessors: the carve is always sp-based; frame storage
    // follows the spill addressing (sp-based, fp-based when `dynamic_sp`).
    let reg_ldr_x = |code: &mut Vec<u8>, rt: Reg, off: u32| {
        if carve {
            emit_sp_ldr_x(code, rt, off);
        } else {
            emit_spill_ldr_x(code, frame, rt, off);
        }
    };
    let reg_str_x = |code: &mut Vec<u8>, rt: Reg, off: u32| {
        if carve {
            emit_sp_str_x_auto(code, rt, off);
        } else {
            emit_spill_str_x_auto(code, frame, rt, off);
        }
    };
    let reg_ldr_d = |code: &mut Vec<u8>, dt: u8, off: u32| {
        if carve {
            emit_sp_ldr_d_auto(code, dt, off);
        } else {
            emit_spill_ldr_d_auto(code, frame, dt, off);
        }
    };
    let reg_str_d = |code: &mut Vec<u8>, dt: u8, off: u32| {
        if carve {
            emit_sp_str_d_auto(code, dt, off);
        } else {
            emit_spill_str_d_auto(code, frame, dt, off);
        }
    };

    // Save the clobbered registers, then capture each operand's value (input) /
    // address (output) -- both before any operand register is overwritten.
    for (j, &r) in save_list.iter().enumerate() {
        reg_str_x(code, Reg(r), save_off(j));
    }
    for (k, &r) in fp_save_list.iter().enumerate() {
        reg_str_d(code, r, fp_save_off(k));
    }
    for (i, &a) in args.iter().enumerate() {
        if !needs_cap.get(i).copied().unwrap_or(true) {
            continue;
        }
        let Some(place) = alloc.places.get(a as usize).copied() else {
            bail_msg("aarch64 inline asm: operand place missing");
            return false;
        };
        // A double `w` input captures its FP value; a 16-byte `w` operand's
        // SSA value is its address, so it captures like the integer operands.
        // Every other operand captures an integer value (input) or a
        // destination address (output).
        if matches!(asm.operands[i].constraint, AsmConstraint::Fp)
            && !asm.operands[i].is_output
            && asm.operands[i].width == 8
        {
            let Some(d) = materialize_fp_shifted(code, place, 16, frame, spill_shift) else {
                bail_msg("aarch64 inline asm: `w` operand not a floating-point place");
                return false;
            };
            reg_str_d(code, d, cap_off(i));
        } else {
            let Some(r) = materialize_int_shifted(code, place, Reg(16), frame, spill_shift) else {
                bail_msg("aarch64 inline asm: operand not an integer place");
                return false;
            };
            reg_str_x(code, r, cap_off(i));
        }
    }
    // Load inputs and memory addresses into their assigned registers; a `+`
    // read-write output loads its current value from the destination address.
    for (i, op) in asm.operands.iter().enumerate() {
        let Some(r) = op_reg[i] else { continue };
        if matches!(op.constraint, AsmConstraint::Fp) {
            // A double `w` input loads its captured FP value into the
            // d-register; a 16-byte `w` operand (input or read-write output)
            // loads the full q register through its captured address. A
            // read-write double output loads the current value the same way.
            if op.width == 16 {
                if !op.is_output || op.is_rw {
                    reg_ldr_x(code, Reg(16), cap_off(i)); // x16 = operand address
                    emit(code, super::encode::enc_ldr_q_imm(r, Reg(16), 0));
                }
            } else if !op.is_output {
                reg_ldr_d(code, r, cap_off(i));
            } else if op.is_rw {
                reg_ldr_x(code, Reg(16), cap_off(i)); // x16 = destination address
                emit(code, super::encode::enc_ldr_d_imm(r, Reg(16), 0));
            }
            continue;
        }
        if matches!(op.constraint, AsmConstraint::Mem | AsmConstraint::MemBase) || !op.is_output {
            reg_ldr_x(code, Reg(r), cap_off(i));
        } else if op.is_rw {
            reg_ldr_x(code, Reg(16), cap_off(i)); // x16 = destination address
            let ok = match op.width {
                8 => {
                    emit(code, super::encode::enc_ldr_imm(Reg(r), Reg(16), 0));
                    true
                }
                4 => {
                    emit(code, super::encode::enc_ldr32_imm(Reg(r), Reg(16), 0));
                    true
                }
                2 => {
                    emit(code, super::encode::enc_ldrh_imm(Reg(r), Reg(16), 0));
                    true
                }
                1 => {
                    emit(code, super::encode::enc_ldrb_imm(Reg(r), Reg(16), 0));
                    true
                }
                _ => false,
            };
            if !ok {
                bail_msg("aarch64 inline asm: unsupported read-write operand width");
                return false;
            }
        }
    }
    // Resolve one symbolic operand to a table operand; label references have
    // no table form and are handled by the branch path below.
    let conv = |o: &AsmOpndA64| -> Result<Opnd, String> {
        let resolve_ref = |idx: u8| -> Option<u8> { op_reg.get(idx as usize).copied().flatten() };
        Ok(match *o {
            AsmOpndA64::Imm(v) => Opnd::Imm(v),
            // `%cN` / `%PN`: the operand's compile-time constant, bare.
            AsmOpndA64::RefConst(idx) => match const_of(idx) {
                Some(v) => Opnd::Imm(v),
                None => {
                    return Err(String::from(
                        "aarch64 inline asm: non-constant `%c` operand",
                    ));
                }
            },
            AsmOpndA64::Lsl(s) => Opnd::Lsl(s),
            AsmOpndA64::Shift { kind, amount } => Opnd::Shift { kind, amount },
            AsmOpndA64::Extend { option, amount } => Opnd::Extend { option, amount },
            AsmOpndA64::SysReg(f) => Opnd::SysReg(f),
            AsmOpndA64::SysOp(b) => Opnd::SysOp(b),
            AsmOpndA64::Reg { num, is64, sp } => Opnd::Reg { num, is64, sp },
            AsmOpndA64::RegWb(num) => Opnd::RegWb(num),
            AsmOpndA64::VReg { num, is_d } => Opnd::VReg { num, is_d },
            AsmOpndA64::QReg(num) => Opnd::QReg(num),
            AsmOpndA64::VScalar { num, size } => Opnd::VScalar { num, size },
            AsmOpndA64::FpImm(v) => Opnd::FpImm(v),
            AsmOpndA64::VecReg { num, size, q } => Opnd::VecReg { num, size, q },
            AsmOpndA64::VecElem { num, size, index } => Opnd::VecElem { num, size, index },
            AsmOpndA64::VecList {
                first,
                count,
                size,
                q,
            } => Opnd::VecList {
                first,
                count,
                size,
                q,
            },
            AsmOpndA64::Ref { idx, is64 } => {
                let Some(r) = resolve_ref(idx) else {
                    // An immediate-only operand has no register; a bare `%N`
                    // uses its compile-time constant value.
                    if matches!(asm.operands[idx as usize].constraint, AsmConstraint::Imm) {
                        return match const_of(idx) {
                            Some(v) => Ok(Opnd::Imm(v)),
                            None => Err(String::from(
                                "aarch64 inline asm: non-constant immediate operand",
                            )),
                        };
                    }
                    return Err(String::from(
                        "aarch64 inline asm: operand reference is not a register",
                    ));
                };
                if matches!(asm.operands[idx as usize].constraint, AsmConstraint::Fp) {
                    // `%sN` selects the single view, `%dN` / bare the double.
                    Opnd::VReg {
                        num: r,
                        is_d: is64.unwrap_or(true),
                    }
                } else if matches!(
                    asm.operands[idx as usize].constraint,
                    AsmConstraint::MemBase
                ) {
                    // A `Q` operand substitutes as the whole memory
                    // reference `[xN]` through its address register.
                    Opnd::Mem {
                        base: r,
                        off: 0,
                        pre: false,
                    }
                } else {
                    let is64 = is64.unwrap_or(asm.operands[idx as usize].width >= 8);
                    Opnd::Reg {
                        num: r,
                        is64,
                        sp: false,
                    }
                }
            }
            // The vector views (`%N.T`, `%qN`, `{%N.T}`) name the SIMD file, so
            // they require a `w` operand.
            AsmOpndA64::RefVec { idx, size, q } => {
                let r = resolve_fp_ref(&op_reg, asm, idx)?;
                Opnd::VecReg { num: r, size, q }
            }
            AsmOpndA64::RefVecElem { idx, size, index } => {
                let r = resolve_fp_ref(&op_reg, asm, idx)?;
                Opnd::VecElem {
                    num: r,
                    size,
                    index,
                }
            }
            AsmOpndA64::RefVecList { idx, size, q } => {
                let r = resolve_fp_ref(&op_reg, asm, idx)?;
                Opnd::VecList {
                    first: r,
                    count: 1,
                    size,
                    q,
                }
            }
            AsmOpndA64::RefQ(idx) => {
                let r = resolve_fp_ref(&op_reg, asm, idx)?;
                Opnd::QReg(r)
            }
            AsmOpndA64::Mem { base, off, pre } => {
                let base = match base {
                    super::asm::MemBase::Reg(n) => n,
                    super::asm::MemBase::Ref(idx) => {
                        let Some(r) = resolve_ref(idx) else {
                            return Err(String::from(
                                "aarch64 inline asm: memory base is not a register",
                            ));
                        };
                        r
                    }
                };
                Opnd::Mem { base, off, pre }
            }
            AsmOpndA64::MemReg {
                base,
                index,
                option,
                shift,
            } => {
                let reg_of = |b: super::asm::MemBase| match b {
                    super::asm::MemBase::Reg(n) => Some(n),
                    super::asm::MemBase::Ref(idx) => resolve_ref(idx),
                };
                let (Some(base), Some(index)) = (reg_of(base), reg_of(index)) else {
                    return Err(String::from(
                        "aarch64 inline asm: memory operand is not a register",
                    ));
                };
                Opnd::MemReg {
                    base,
                    index,
                    option,
                    shift,
                }
            }
            AsmOpndA64::Cond(c) => Opnd::Cond(c),
            AsmOpndA64::Label { .. } | AsmOpndA64::GotoLabel(_) => {
                return Err(String::from(
                    "aarch64 inline asm: label reference outside a branch",
                ));
            }
            AsmOpndA64::Here(_) => {
                return Err(String::from(
                    "aarch64 inline asm: `.` reference outside a branch",
                ));
            }
            // The main-stream encoder routes a trailing symbol operand
            // through `encode_a64_sym_insn` before operand conversion; one
            // reaching here sits in an unsupported position (a deferred
            // ALTERNATIVE replacement, a non-final operand).
            // TODO symbol relocations in deferred replacement regions.
            AsmOpndA64::Sym { .. } | AsmOpndA64::MemSymLo12 { .. } => {
                return Err(String::from(
                    "aarch64 inline asm: symbol operand needs a relocation",
                ));
            }
            // TODO operand expressions over labels in function-body asm; a
            // function body has no section layout to fold one against.
            AsmOpndA64::ImmExpr(ref e) | AsmOpndA64::MemExpr { expr: ref e, .. } => {
                return Err(alloc::format!(
                    "aarch64 inline asm: operand expression `{e}` needs a section layout"
                ));
            }
            // TODO literal pools in function-body asm; a function body has no
            // section of its own to flush one into.
            AsmOpndA64::LitPool(_) => {
                return Err(String::from(
                    "aarch64 inline asm: `ldr` literal pool needs a file-scope section",
                ));
            }
        })
    };
    // `%lK` label indices this statement's section items reference -- a data
    // field (`.long %l0 - .`) or a section branch (`b %l[k]`). A statement
    // with exit work rewrites those relocs below, so the published address is
    // the same trampoline a template `%lK` branch takes.
    let data_goto_ks = core::cell::RefCell::new(Vec::<usize>::new());
    let goto_block = |idx: u8| -> Option<u32> {
        let ctx = goto_ctx.as_ref()?;
        let bid = ctx.row.get(1 + idx as usize).copied()?;
        data_goto_ks.borrow_mut().push(idx as usize);
        Some(bid)
    };
    // Assemble the instructions of a pushed section to bytes before layout.
    // The converter above resolves a reference to the enclosing template's
    // operands, which the file-scope encoder has no notion of.
    if !section_blocks.is_empty()
        && let Err(m) = encode_a64_asm_section_code(&mut section_blocks, &conv, &goto_block)
    {
        bail_msg(&m);
        return false;
    }
    // Local labels: definitions record the code offset they stand at; branches
    // to them emit a placeholder word and are patched once the block's layout
    // is final (a `Nb` reference binds to the most recent definition of N at
    // or before the branch, `Nf` to the next one after it).
    let mut label_defs: Vec<(u32, usize)> = Vec::new();
    let mut label_fixups: Vec<(usize, LabelBranch, u32, bool)> = Vec::new();
    // The template's intern table, telling an expression leaf apart from a
    // symbol the stream cannot relocate.
    let label_names = super::super::ssa::emit_common::scan_label_names(code_text);
    // Forward-referencing fields over template labels, settled below: a data
    // field as `(reference_site, field, width, expression)`, an instruction
    // operand by re-encoding its word.
    let mut expr_fixups: Vec<(usize, usize, usize, String)> = Vec::new();
    let mut insn_expr_fixups: Vec<(usize, String, Vec<Opnd>, usize, String)> = Vec::new();
    // `asm goto` label branches: `(site, kind, label_index)` per `%lK`
    // reference, patched to the label's restore trampoline (or to the
    // shared fall-through restore when the target is the fall-through
    // block).
    let mut goto_sites: Vec<(usize, LabelBranch, usize)> = Vec::new();

    // The mapping state the stream is in on entry; it spans the section, so
    // a template ending in data pads only where an instruction follows.
    let mut map_state = *text_map_state;

    // Code-stream label names, so a layout directive's expression can read a
    // named label's offset as it reads a numeric one.
    let stream_label_names = super::ssa::emit_common::scan_label_names(code_text);
    // Encode each template instruction; raw-byte pieces emit verbatim.
    for insn in &insns {
        if let Some(num) = insn.label_def {
            label_defs.push((num, code.len()));
            continue;
        }
        // A layout directive moves the location counter; `code` is the unit's
        // whole text stream, so its length is the section offset GNU as
        // resolves one against. Only a definition already emitted resolves.
        if let Some(item) = &insn.layout {
            let resolve = |name: &str| -> Option<i64> {
                let num = match stream_label_names.iter().position(|&n| n == name) {
                    Some(i) => super::ssa::emit_common::NAMED_LABEL_BASE + i as u32,
                    None => name.strip_suffix(['b', 'f'])?.parse().ok()?,
                };
                label_defs
                    .iter()
                    .rfind(|&&(n, _)| n == num)
                    .map(|&(_, off)| off as i64)
            };
            let resolved = match super::ssa::emit_common::resolve_align_item(item, &resolve) {
                Ok(r) => r,
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            };
            let item = resolved.as_ref().unwrap_or(item);
            match super::ssa::emit_common::push_a64_stream_layout(
                item,
                code,
                text_data_ranges,
                &resolve,
                &const_of,
            ) {
                Ok(n) => *text_align = (*text_align).max(n as usize),
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            }
            map_state = super::ssa::emit_common::step_map_state(item, map_state, true);
            continue;
        }
        // Every item but a data directive lays down instructions: a raw-byte
        // piece the parser encoded itself (`msr`, the barriers, the system
        // ops), `.inst`, and an assembled mnemonic.
        let class = super::super::ssa::emit_common::data_directive_class(&insn.mnemonic)
            .unwrap_or(MapClass::Code);
        if class == MapClass::Code {
            a64_align_asm_stream(code, text_data_ranges, &mut map_state);
        }
        map_state = Some(class);
        if !insn.bytes.is_empty() {
            if class == MapClass::Data {
                text_data_ranges.push((code.len(), insn.bytes.len()));
            }
            code.extend_from_slice(&insn.bytes);
            continue;
        }
        // A data directive with operand references (`.long %c0`): each
        // argument must resolve to a compile-time constant, emitted
        // little-endian at the directive width.
        if let Some(w) = super::super::ssa::emit_common::data_directive_width(&insn.mnemonic) {
            // `.word` is target-dependent: 4 bytes on AArch64.
            let w = if insn.mnemonic == ".word" { 4 } else { w };
            if class == MapClass::Data {
                text_data_ranges.push((code.len(), w * insn.operands.len()));
            }
            for o in &insn.operands {
                let v = match *o {
                    AsmOpndA64::Imm(v) => v,
                    AsmOpndA64::RefConst(idx) | AsmOpndA64::Ref { idx, .. } => {
                        match const_of(idx) {
                            Some(v) => v,
                            None => {
                                bail_msg("aarch64 inline asm: non-constant data-directive value");
                                return false;
                            }
                        }
                    }
                    // A value over template labels: the field width is the
                    // directive's, so only the value waits on the layout.
                    AsmOpndA64::ImmExpr(ref e) => {
                        match template_expr_value(e, code.len(), &label_defs, &label_names) {
                            Some(v) => v,
                            None if super::super::ssa::emit_common::is_template_label_expr(
                                e,
                                &label_names,
                            ) =>
                            {
                                expr_fixups.push((code.len(), code.len(), w, e.clone()));
                                0
                            }
                            None => {
                                bail_msg("aarch64 inline asm: unsupported data-directive value");
                                return false;
                            }
                        }
                    }
                    _ => {
                        bail_msg("aarch64 inline asm: unsupported data-directive value");
                        return false;
                    }
                };
                code.extend_from_slice(&(v as u64).to_le_bytes()[..w]);
            }
            continue;
        }
        // A direct `bl` / `b` to a symbol: resolve the name to its entry PC and
        // record a fixup the post-pass patches to a rel26 once every function's
        // address is final -- the same mechanism as a compiler-emitted call.
        if let Some(name) = &insn.sym_target {
            let is_call = insn.mnemonic == "bl";
            let (kind, word) = if is_call {
                (BranchKind::Bl, super::encode::enc_bl(0))
            } else {
                (BranchKind::B, super::encode::enc_b(0))
            };
            // The name may embed operand references; substituting them first
            // is what makes `__get_user_%c0` name `__get_user_4`.
            let name = match super::super::ssa::emit_common::resolve_asm_symbol_target(
                name,
                &super::super::ssa::emit_common::A64_SYMBOL_SUBST,
                &const_of,
            ) {
                Ok(n) => n,
                Err(e) => {
                    bail_msg(&e);
                    return false;
                }
            };
            let native_offset = code.len();
            match name2entpc.get(name.as_str()) {
                Some(&ent_pc) => fixups.push(Fixup {
                    native_offset,
                    target_ent_pc: ent_pc,
                    kind,
                }),
                // Not defined here: the callee's address is a link-time
                // decision, so the site becomes a call relocation against the
                // name, exactly as a compiler-emitted call to an extern
                // function does. The rel26 stays zero for the linker to patch.
                None => asm_extern_call_sites.push(super::UserExternCallSite {
                    instr_offset: native_offset,
                    symbol_name: name.clone(),
                    is_tail: !is_call,
                }),
            }
            emit(code, word);
            continue;
        }
        let goto_label = match insn.operands.last() {
            Some(&AsmOpndA64::GotoLabel(k)) => Some(k),
            _ => None,
        };
        if matches!(
            insn.operands.last(),
            Some(AsmOpndA64::Label { .. } | AsmOpndA64::Here(_))
        ) || goto_label.is_some()
        {
            let kind = match build_label_branch(insn, &conv) {
                Ok(k) => k,
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            };
            if let Some(k) = goto_label {
                let Some(ctx) = goto_ctx.as_ref() else {
                    bail_msg("aarch64 inline asm: `%l` label reference outside `asm goto`");
                    return false;
                };
                if 1 + k as usize >= ctx.row.len() {
                    bail_msg("aarch64 inline asm: `%l` label index out of range");
                    return false;
                }
                if matches!(kind, LabelBranch::Adr { .. }) {
                    bail_msg("aarch64 inline asm: adr cannot take an `asm goto` label");
                    return false;
                }
                goto_sites.push((code.len(), kind, k as usize));
                emit(code, 0);
                continue;
            }
            if let Some(&AsmOpndA64::Here(off)) = insn.operands.last() {
                // `.` names the branch's own address, plus any offset.
                let word = match kind {
                    LabelBranch::Adr { rd } => {
                        if !(-(1i32 << 20)..(1i32 << 20)).contains(&off) {
                            bail_msg("aarch64 inline asm: adr target out of +/-1MiB range");
                            return false;
                        }
                        super::encode::enc_adr(Reg(rd), off)
                    }
                    _ => match label_branch_word(&kind, off as i64) {
                        Ok(w) => w,
                        Err(m) => {
                            bail_msg(&m);
                            return false;
                        }
                    },
                };
                emit(code, word);
                continue;
            }
            let Some(&AsmOpndA64::Label { num, forward }) = insn.operands.last() else {
                unreachable!("guard admits Label, Here or GotoLabel; the first two handled above");
            };
            label_fixups.push((code.len(), kind, num, forward));
            emit(code, 0);
            continue;
        }
        // `movz` / `movk` with `:abs_gN:` over an expression that folds:
        // a function body has no layout pass, so only a constant resolves,
        // and it takes the same field encoding the section path applies.
        if let Some(AsmOpndA64::Sym {
            expr,
            spec:
                super::asm::SymSpec::MovwAbs {
                    group,
                    signed,
                    check,
                },
        }) = insn.operands.last()
            && matches!(insn.mnemonic.as_str(), "movz" | "movk")
            && let Some(v) = super::super::ssa::emit_common::eval_const_expr_ops(expr, &|_| None)
        {
            let (rd, is64) = match conv(&insn.operands[0]) {
                Ok(Opnd::Reg { num, is64, .. }) => (num, is64),
                _ => {
                    bail_msg("aarch64 inline asm: `:abs_g` destination must be a register");
                    return false;
                }
            };
            let movk = insn.mnemonic == "movk";
            if movk && *signed {
                bail_msg("aarch64 inline asm: `:abs_g<n>_s:` is not allowed on `movk`");
                return false;
            }
            let word = match a64_movw_placeholder(rd, is64, movk, *group) {
                Ok(w) => w,
                Err(m) => {
                    bail_msg(&alloc::format!("aarch64 {m}"));
                    return false;
                }
            };
            match super::patch::movw_const_word(word, *group, *signed, *check, v) {
                Ok(w) => emit(code, w),
                Err(m) => {
                    bail_msg(&alloc::format!("aarch64 inline asm: {m}"));
                    return false;
                }
            }
            continue;
        }
        // A symbol operand (`adrp %x0, sym`, `add ..., :lo12:sym`, a `:lo12:`
        // load/store, `movz`/`movk` `:abs_gN:sym`, a branch / `adr` / literal
        // `ldr` naming a symbol) takes the section path's shape encoder; the
        // site records a per-instruction relocation against the name, an
        // internal-linkage data object resolved to its offset.
        if matches!(
            insn.operands.last(),
            Some(AsmOpndA64::Sym { .. } | AsmOpndA64::MemSymLo12 { .. })
        ) {
            let (word, kind, expr) = match encode_a64_sym_insn(insn, &conv) {
                Ok(Some(t)) => t,
                Ok(None) => {
                    bail_msg("aarch64 inline asm: unsupported symbol operand");
                    return false;
                }
                Err(m) => {
                    bail_msg(&alloc::format!("aarch64 {m}"));
                    return false;
                }
            };
            // A function body has no section layout, so only `sym + constant`
            // resolves here; a label-difference expression does not.
            let Some((name, addend)) = super::ssa::emit_common::asm_expr_sym_addend(&expr) else {
                bail_msg(&alloc::format!(
                    "aarch64 inline asm: operand expression `{expr}` needs a section layout"
                ));
                return false;
            };
            let target = match data_sym_offsets.get(name.as_str()) {
                Some(&off) => super::ssa::emit_common::AsmSectionTarget::Data(off as u64),
                None => super::ssa::emit_common::AsmSectionTarget::Symbol(name),
            };
            asm_sym_fixups.push(super::AsmSymFixup {
                instr_offset: code.len(),
                kind,
                target,
                addend,
            });
            emit(code, word);
            continue;
        }
        let mut ops: Vec<Opnd> = Vec::new();
        // An operand expression over template labels resolves here when every
        // leaf is placed; a forward reference encodes zero and the word is
        // built again below, the field width being the encoding's either way.
        let mut pending: Option<(usize, String)> = None;
        for o in &insn.operands {
            if let AsmOpndA64::ImmExpr(e) = o
                && super::super::ssa::emit_common::is_template_label_expr(e, &label_names)
            {
                let v = template_expr_value(e, code.len(), &label_defs, &label_names);
                if v.is_none() {
                    pending = Some((ops.len(), e.clone()));
                }
                ops.push(Opnd::Imm(v.unwrap_or(0)));
                continue;
            }
            match conv(o) {
                Ok(opnd) => ops.push(opnd),
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            }
        }
        let site = code.len();
        match table::encode(&insn.mnemonic, &ops) {
            Ok(word) => emit(code, word),
            Err(m) => {
                bail_msg(&m);
                return false;
            }
        }
        if let Some((idx, expr)) = pending {
            insn_expr_fixups.push((site, insn.mnemonic.clone(), ops, idx, expr));
        }
    }
    // Settle the deferred expression fields and words: the layout is final,
    // so a forward reference now has its definition.
    for (site, at, width, expr) in &expr_fixups {
        let Some(v) = template_expr_value(expr, *site, &label_defs, &label_names) else {
            bail_msg(&alloc::format!(
                "aarch64 inline asm: expression `{expr}` is not a constant"
            ));
            return false;
        };
        code[*at..*at + *width].copy_from_slice(&(v as u64).to_le_bytes()[..*width]);
    }
    for (site, mnemonic, ops, idx, expr) in &insn_expr_fixups {
        let Some(v) = template_expr_value(expr, *site, &label_defs, &label_names) else {
            bail_msg(&alloc::format!(
                "aarch64 inline asm: expression `{expr}` is not a constant"
            ));
            return false;
        };
        let mut ops = ops.clone();
        ops[*idx] = Opnd::Imm(v);
        match table::encode(mnemonic, &ops) {
            Ok(word) => code[*site..*site + 4].copy_from_slice(&word.to_le_bytes()),
            Err(m) => {
                bail_msg(&m);
                return false;
            }
        }
    }
    // Patch the label branches now that every definition's offset is known.
    // A named label has exactly one definition, so direction does not apply.
    // Numeric references without an in-stream definition: the definition may
    // sit in one of the statement's pushed sections, resolved once those are
    // materialized below (`jmp 6f` shape). Only a forward reference reaches
    // one, as the sections follow the code textually.
    let mut pending_xsec: Vec<(usize, LabelBranch, u32)> = Vec::new();
    for &(site, ref kind, num, forward) in &label_fixups {
        let target = if num >= super::super::ssa::emit_common::NAMED_LABEL_BASE {
            label_defs.iter().find(|&&(n, _)| n == num).map(|&(_, o)| o)
        } else if forward {
            label_defs
                .iter()
                .find(|&&(n, off)| n == num && off > site)
                .map(|&(_, off)| off)
        } else {
            label_defs
                .iter()
                .rev()
                .find(|&&(n, off)| n == num && off <= site)
                .map(|&(_, off)| off)
        };
        let Some(target) = target else {
            if num < super::super::ssa::emit_common::NAMED_LABEL_BASE
                && forward
                && !section_blocks.is_empty()
            {
                pending_xsec.push((site, *kind, num));
                continue;
            }
            bail_msg("aarch64 inline asm: undefined local label");
            return false;
        };
        let delta = target as i64 - site as i64;
        // `adr` materializes a byte-granular PC-relative address (rel21,
        // unscaled), unlike the word-aligned, word-scaled branch offsets.
        if let LabelBranch::Adr { rd } = *kind {
            if !(-(1i64 << 20)..(1i64 << 20)).contains(&delta) {
                bail_msg("aarch64 inline asm: adr target out of +/-1MiB range");
                return false;
            }
            let word = super::encode::enc_adr(Reg(rd), delta as i32);
            code[site..site + 4].copy_from_slice(&word.to_le_bytes());
            continue;
        }
        match label_branch_word(kind, delta) {
            Ok(word) => code[site..site + 4].copy_from_slice(&word.to_le_bytes()),
            Err(m) => {
                bail_msg(&m);
                return false;
            }
        }
    }
    // A named label defined in the main stream is a definition of the unit,
    // as it is for GNU as: record it so the writers emit a `.text` symbol and
    // bind a same-name C reference to it. `.L`-prefixed names are
    // assembler-local, so no C reference spells one.
    {
        let names = super::super::ssa::emit_common::scan_label_names(code_text);
        for &(num, off) in &label_defs {
            let Some(idx) = num.checked_sub(super::super::ssa::emit_common::NAMED_LABEL_BASE)
            else {
                continue;
            };
            let Some(&name) = names.get(idx as usize) else {
                continue;
            };
            if name.starts_with(".L") {
                continue;
            }
            // One definition per name across the unit, as in GNU as.
            if asm_text_labels.iter().any(|l| l.name == name) {
                bail_msg(&alloc::format!(
                    "inline asm: symbol `{name}` is already defined"
                ));
                return false;
            }
            asm_text_labels.push(super::AsmTextLabel {
                name: alloc::string::String::from(name),
                text_offset: off,
            });
        }
    }
    // Resolve a numeric main-stream template label (`661b` / `662b`) to its
    // emitted text offset; `Nb` (or bare `N`) binds the last definition, `Nf`
    // the first.
    let main_label_off = |name: &str| -> Option<usize> {
        let digits = name.strip_suffix(['b', 'f']).unwrap_or(name);
        if digits.is_empty() || !digits.bytes().all(|c| c.is_ascii_digit()) {
            return None;
        }
        let num: u32 = digits.parse().ok()?;
        let mut defs = label_defs.iter().filter(|&&(n, _)| n == num);
        if name.ends_with('f') {
            defs.map(|&(_, off)| off).min()
        } else {
            defs.next_back().map(|&(_, off)| off)
        }
    };
    // Encode the ALTERNATIVE replacement (if any) into a deferred region;
    // its `.org` length assertion reads the main labels above. The region is
    // appended after the function body and its labels resolved to text
    // offsets once its base is known (see the caller's placement pass).
    let mut deferred_goto_sites: Vec<(usize, LabelBranch, u8)> = Vec::new();
    let deferred_idx: Option<u32> = if deferred_text.is_empty() {
        None
    } else {
        // A replacement branch names its target the same way a main-stream one
        // does, operand references included (`bl __get_user_%c0`).
        let sym_name = |name: &str| -> Result<String, String> {
            super::super::ssa::emit_common::resolve_asm_symbol_target(
                name,
                &super::super::ssa::emit_common::A64_SYMBOL_SUBST,
                &const_of,
            )
        };
        match encode_deferred_asm_region(&deferred_text, &conv, &main_label_off, &sym_name) {
            Ok((region, gotos)) => {
                let idx = deferred_regions.len() as u32;
                deferred_regions.push(region);
                deferred_goto_sites = gotos;
                Some(idx)
            }
            Err(m) => {
                bail_msg(&m);
                return false;
            }
        }
    };
    // The per-section reloc counts before this statement's contribution,
    // bounding the trampoline rewrite below to this statement's relocs.
    let sect_reloc_marks: Vec<usize> = if goto_ctx.is_some() && size > 0 {
        asm_sections
            .relocs_mut()
            .iter()
            .map(|s| s.relocs.len())
            .collect()
    } else {
        Vec::new()
    };
    // Materialize the `.pushsection` blocks now that every label's text
    // offset is known. A reference that names a numeric template label
    // resolves to its offset; any other name is a symbol relocation.
    if !section_blocks.is_empty() {
        let label_off = |name: &str| -> Option<super::ssa::emit_common::LabelLoc> {
            use super::ssa::emit_common::LabelLoc;
            // A replacement-region label (`663f` / `664f`) resolves into the
            // deferred region, rewritten to a text offset once it is placed.
            if let Some(region) = deferred_idx {
                let digits = name.strip_suffix(['b', 'f']).unwrap_or(name);
                if let Ok(num) = digits.parse::<u32>() {
                    let labels = &deferred_regions[region as usize].labels;
                    let hit = if name.ends_with('f') {
                        labels
                            .iter()
                            .filter(|&&(n, _)| n == num)
                            .map(|&(_, o)| o)
                            .min()
                    } else {
                        labels
                            .iter()
                            .rev()
                            .find(|&&(n, _)| n == num)
                            .map(|&(_, o)| o)
                    };
                    if let Some(off) = hit {
                        return Some(LabelLoc::Deferred { region, off });
                    }
                }
            }
            main_label_off(name).map(LabelLoc::Text)
        };
        // An `i`-class operand naming a link-time data address (`.quad %c0 - .`
        // where `%c0` is `&sym`) relocates against the data image, resolved
        // like the operand's own `ImmData` lowering.
        let operand_sym = |idx: u8| -> Option<(super::ssa::emit_common::AsmSectionTarget, i64)> {
            super::ssa::emit_common::asm_operand_data_target(
                &func.insts,
                *args.get(idx as usize)?,
                &|vid| extern_data_names.get(&vid).cloned(),
            )
        };
        // An `asm goto` label operand (`.long %l0 - .`) resolves through
        // `goto_block` to the row's block index. Its text offset is not final
        // here; the reloc carries the block and is rewritten after layout
        // (see resolve_asm_goto_relocs).
        let defined = match super::ssa::emit_common::materialize_asm_sections(
            &section_blocks,
            &|idx| const_of(idx),
            &label_off,
            &operand_sym,
            &goto_block,
            true,
            asm_sections,
        ) {
            Ok(d) => d,
            Err(m) => {
                bail_msg(&m);
                return false;
            }
        };
        // Bind each deferred main-stream branch to its section definition.
        // The two land in different object sections, so the site takes an
        // instruction-field relocation against the target section rather
        // than an in-stream displacement.
        for (site, kind, num) in pending_xsec.drain(..) {
            let name = alloc::format!("{num}");
            let Some(d) = defined.iter().find(|d| d.name == name) else {
                bail_msg("aarch64 inline asm: undefined local label");
                return false;
            };
            let (word, rkind) = match a64_label_branch_reloc(&kind) {
                Ok(t) => t,
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            };
            code[site..site + 4].copy_from_slice(&word.to_le_bytes());
            asm_section_text_refs.push(super::AsmSectionTextRef {
                instr_offset: site,
                section_index: d.section_index,
                section_offset: d.offset,
                addend: 0,
                absolute: false,
                kind: rkind,
            });
        }
    }
    // Store the register outputs back through their captured addresses (x16
    // holds the address; the operand pool is untouched). For `asm goto`
    // the outputs are stored on every exit path (GCC 11 output
    // semantics), so the sequence repeats on each trampoline.
    let emit_outputs = |code: &mut Vec<u8>| -> bool {
        for (i, op) in asm.operands.iter().enumerate() {
            if !op.is_output || matches!(op.constraint, AsmConstraint::Mem | AsmConstraint::MemBase)
            {
                continue;
            }
            let Some(r) = op_reg[i] else { continue };
            reg_ldr_x(code, Reg(16), cap_off(i));
            if matches!(op.constraint, AsmConstraint::Fp) {
                if op.width == 16 {
                    emit(code, super::encode::enc_str_q_imm(r, Reg(16), 0));
                } else {
                    emit(code, super::encode::enc_str_d_imm(r, Reg(16), 0));
                }
                continue;
            }
            match op.width {
                8 => emit(code, enc_str_imm(Reg(r), Reg(16), 0)),
                4 => emit(code, enc_str32_imm(Reg(r), Reg(16), 0)),
                2 => emit(code, enc_strh_imm(Reg(r), Reg(16), 0)),
                1 => emit(code, super::encode::enc_strb_imm(Reg(r), Reg(16), 0)),
                _ => return false,
            }
        }
        true
    };
    // Restore the saved registers; only the naked carve moves sp back.
    let emit_restore = |code: &mut Vec<u8>| {
        for (j, &r) in save_list.iter().enumerate() {
            reg_ldr_x(code, Reg(r), save_off(j));
        }
        for (k, &r) in fp_save_list.iter().enumerate() {
            reg_ldr_d(code, r, fp_save_off(k));
        }
        if carve {
            emit(code, enc_add_imm(Reg(31), Reg(31), size));
        }
    };
    if size > 0 {
        a64_align_asm_stream(code, text_data_ranges, &mut map_state);
    }
    let exit_start = code.len();
    if !emit_outputs(code) {
        bail_msg("aarch64 inline asm: unsupported output width");
        return false;
    }
    emit_restore(code);
    // `asm goto`: each `%lK` branch leaves mid-template, before the
    // store-backs and restore just emitted on the fall-through path, so
    // it lands on a trampoline that repeats them and branches to the
    // label's block through the enclosing function's branch fixups. A
    // label whose target is the fall-through block reuses the
    // fall-through exit sequence instead.
    if let Some(ctx) = goto_ctx {
        let mut tramp_at: Vec<Option<usize>> = alloc::vec![None; ctx.row.len() - 1];
        // Label indices needing a restore trampoline. With no exit work, a
        // `%lK` reference -- a template or replacement (`.subsection`) branch,
        // or a section data field -- names its block directly; with captures
        // or saves, every one routes through the trampolines built here, so a
        // branch a run-time patcher plants from a section field runs the same
        // store-backs and restores a template branch does.
        let mut tramp_ks: Vec<usize> = Vec::new();
        if size > 0 {
            tramp_ks.extend(goto_sites.iter().map(|&(_, _, k)| k));
            tramp_ks.extend(deferred_goto_sites.iter().map(|&(_, _, k)| k as usize));
            tramp_ks.extend(data_goto_ks.borrow().iter().copied());
        }
        if tramp_ks.iter().any(|&k| ctx.row[1 + k] != ctx.row[0]) {
            let skip_site = code.len();
            emit(code, 0); // b over the trampolines, patched below
            for &k in &tramp_ks {
                if ctx.row[1 + k] == ctx.row[0] || tramp_at[k].is_some() {
                    continue;
                }
                tramp_at[k] = Some(code.len());
                if !emit_outputs(code) {
                    bail_msg("aarch64 inline asm: unsupported output width");
                    return false;
                }
                emit_restore(code);
                ctx.branch_fixups.push(BranchFixup {
                    site: code.len(),
                    target: ctx.row[1 + k],
                    kind: LocalBranchKind::B,
                });
                emit(code, super::encode::enc_b(0));
            }
            let words = ((code.len() - skip_site) / 4) as i32;
            let word = super::encode::enc_b(words);
            code[skip_site..skip_site + 4].copy_from_slice(&word.to_le_bytes());
        }
        for &(site, ref kind, k) in &goto_sites {
            if size == 0 {
                ctx.direct_goto.push(AsmGotoDirectBranch {
                    site,
                    kind: *kind,
                    target: ctx.row[1 + k],
                });
                continue;
            }
            let target = tramp_at[k].unwrap_or(exit_start);
            match label_branch_word(kind, target as i64 - site as i64) {
                Ok(word) => code[site..site + 4].copy_from_slice(&word.to_le_bytes()),
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            }
        }
        // Record each out-of-line replacement `%lK` branch for the placement
        // pass, where the region base is known. With an operand frame it routes
        // through the teardown trampoline (or the fall-through exit when the
        // label is the fall-through block); frameless, it targets the block
        // directly, matching a plain out-of-line branch.
        if let Some(idx) = deferred_idx {
            for &(region_off, kind, k) in &deferred_goto_sites {
                let k = k as usize;
                let target = if size == 0 {
                    DeferredGotoTarget::Block(ctx.row[1 + k])
                } else if ctx.row[1 + k] == ctx.row[0] {
                    DeferredGotoTarget::Code(exit_start)
                } else {
                    DeferredGotoTarget::Code(
                        tramp_at[k].expect("trampoline built for framed deferred goto"),
                    )
                };
                deferred_regions[idx as usize]
                    .goto_branches
                    .push(DeferredGotoBranch {
                        region_off,
                        kind,
                        target,
                    });
            }
        }
        // Rewrite this statement's section `%l` fields from the label's block
        // to its trampoline (or the fall-through exit) while exit work is
        // pending; frameless fields keep the block and resolve with the
        // function's layout (`resolve_asm_goto_relocs`).
        if size > 0 && !data_goto_ks.borrow().is_empty() {
            use super::ssa::emit_common::AsmSectionTarget;
            let ks = data_goto_ks.borrow();
            let target_of = |bid: u32| -> Option<usize> {
                ks.iter()
                    .find(|&&k| ctx.row.get(1 + k).copied() == Some(bid))
                    .map(|&k| tramp_at[k].unwrap_or(exit_start))
            };
            for (i, s) in asm_sections.relocs_mut().iter_mut().enumerate() {
                let start = sect_reloc_marks.get(i).copied().unwrap_or(0);
                for r in s.relocs.iter_mut().skip(start) {
                    if let AsmSectionTarget::TextBlock(bid) = r.target
                        && let Some(off) = target_of(bid)
                    {
                        r.target = AsmSectionTarget::Text(off);
                    }
                }
            }
        }
    } else if !deferred_goto_sites.is_empty() {
        bail_msg("aarch64 inline asm: `%l` label reference outside `asm goto`");
        return false;
    }
    *text_map_state = map_state;
    true
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
    deferred_regions: &mut Vec<DeferredAsmRegion>,
    text_map_state: &mut Option<super::super::map_syms::MapClass>,
    asm_text_labels: &mut Vec<super::AsmTextLabel>,
    asm_section_text_refs: &mut Vec<super::AsmSectionTextRef>,
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
        extern_data_names,
        param_plan,
        name2entpc,
        data_sym_offsets,
    } = *fcx;
    // The bundled emit output now arrives in `cx`; recreate the per-field
    // names as disjoint reborrows so the per-`Inst` lowering below is unchanged.
    let code = &mut *cx.code;
    let plt_call_fixups = &mut *cx.plt_call_fixups;
    let data_fixups = &mut *cx.data_fixups;
    let pending_func_fixups = &mut *cx.pending_func_fixups;
    let tls_index_fixups = &mut *cx.tls_index_fixups;
    let elf_tpoff_fixups = &mut *cx.elf_tpoff_fixups;
    let asm_sections = &mut *cx.asm_sections;
    let asm_extern_call_sites = &mut *cx.asm_extern_call_sites;
    let asm_sym_fixups = &mut *cx.asm_sym_fixups;
    let text_data_ranges = &mut *cx.text_data_ranges;
    let text_align = &mut *cx.text_align;
    match inst {
        Inst::AllocaInit(slot) => {
            // Slot 0: this function doesn't use alloca. Non-zero:
            // the function moves sp at runtime; `Frame::dynamic_sp`
            // carries the fact to the spill addressing, the alloca
            // intrinsics, and the epilogue. No code either way.
            let _ = slot;
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
                        emit_spill_str_d_auto(code, frame, d, sp_off);
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
                    emit_spill_str_x(code, frame, scratch.primary, sp_off, scratch.secondary);
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
                emit_spill_str_x_auto(code, frame, rd, sp_off);
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
            let instr_offset = code.len();
            emit(code, enc_adrp(rd, 0));
            emit(code, enc_add_imm(rd, rd, 0));
            data_fixups.push(DataFixup {
                instr_offset,
                data_offset: *offset as u64,
                part: AddrPart::Whole,
            });
            if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit_spill_str_x_auto(code, frame, rd, sp_off);
            }
            true
        }
        Inst::ImmCode(target_ent_pc) => {
            let rd = match int_or_spill_scratch(dst, scratch) {
                Some(r) => r,
                None => return false,
            };
            let instr_offset = code.len();
            emit(code, enc_adrp(rd, 0));
            emit(code, enc_add_imm(rd, rd, 0));
            pending_func_fixups.push((instr_offset, *target_ent_pc));
            if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit_spill_str_x_auto(code, frame, rd, sp_off);
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
                emit_spill_str_x_auto(code, frame, rd, sp_off);
            }
            true
        }
        // Inst::BlockAddr is handled in emit_function's block loop
        // (it needs the local block_offsets table for its PC-relative
        // fixup), so it never reaches emit_inst.
        Inst::LocalAddr(off) => emit_local_addr(code, dst, *off, func, frame),
        Inst::Load {
            addr,
            disp,
            kind,
            align,
            ..
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
            narrow_bound(*align, abi),
        ),
        Inst::Store {
            addr,
            disp,
            value,
            kind,
            align,
            ..
        } => emit_store(
            code,
            dst,
            *addr,
            *disp,
            *value,
            *kind,
            alloc,
            frame,
            scratch,
            narrow_bound(*align, abi),
        ),
        Inst::LoadLocal { off, kind, .. } => emit_load_local(
            code,
            dst,
            *off,
            *kind,
            alloc.is_f32(v),
            func,
            frame,
            scratch,
        ),
        Inst::StoreLocal {
            off, value, kind, ..
        } => emit_store_local(code, dst, *off, *value, *kind, alloc, func, frame, scratch),
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
            align,
        } => emit_mcpy(
            code,
            dst,
            *d,
            *s,
            *size,
            *align,
            abi.strict_align,
            alloc,
            frame,
            scratch,
        ),
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
        Inst::Intrinsic { kind, args } => {
            emit_intrinsic(code, func, abi, *kind, args, dst, v, alloc, frame, scratch)
        }
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
                emit_spill_str_d_auto(code, frame, dd, sp_off);
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
                emit_spill_str_d_auto(code, frame, dd, sp_off);
            }
            true
        }
        Inst::Extend { value, kind } => {
            emit_extend(code, dst, *value, *kind, alloc, frame, scratch)
        }
        Inst::Bswap { value, width } => {
            emit_bswap(code, dst, *value, *width, alloc, frame, scratch)
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
                    // C99 6.3.1.4: when the result is `float`, convert the
                    // integer directly to single precision (one rounding)
                    // rather than to double followed by a narrowing `fcvt`.
                    let res_f32 = alloc.is_f32(v);
                    let enc = match (matches!(kind, FpCastKind::UIntToFp), res_f32) {
                        (true, true) => enc_ucvtf_s_x(dd, rn),
                        (true, false) => enc_ucvtf_d_x(dd, rn),
                        (false, true) => enc_scvtf_s_x(dd, rn),
                        (false, false) => enc_scvtf_d_x(dd, rn),
                    };
                    emit(code, enc);
                    if let Place::Spill(slot) = dst {
                        let sp_off = spill_off(frame, slot);
                        emit_spill_str_d_auto(code, frame, dd, sp_off);
                    }
                    true
                }
                FpCastKind::FpToInt | FpCastKind::UFpToInt => {
                    // C99 6.3.1.4: a `float` source truncates directly to
                    // the integer (one conversion) rather than widening to
                    // double first. Read the source in its single-precision
                    // view when it is f32-marked.
                    let src_f32 = alloc.is_f32(*value);
                    let dn = if src_f32 {
                        match materialize_fp_f32(code, src_place, SCRATCH_FP0, frame) {
                            Some(r) => r,
                            None => return false,
                        }
                    } else {
                        match materialize_fp(code, src_place, SCRATCH_FP0, frame) {
                            Some(r) => r,
                            None => return false,
                        }
                    };
                    let rd = match dst {
                        Place::IntReg(r) => Reg(r),
                        Place::Spill(_) => scratch.primary,
                        _ => return false,
                    };
                    let enc = match (matches!(kind, FpCastKind::UFpToInt), src_f32) {
                        (true, true) => enc_fcvtzu_x_s(rd, dn),
                        (true, false) => enc_fcvtzu_x_d(rd, dn),
                        (false, true) => enc_fcvtzs_x_s(rd, dn),
                        (false, false) => enc_fcvtzs_x_d(rd, dn),
                    };
                    emit(code, enc);
                    if let Place::Spill(slot) = dst {
                        let sp_off = spill_off(frame, slot);
                        emit_spill_str_x_auto(code, frame, rd, sp_off);
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
                        emit_spill_str_d_auto(code, frame, dd, sp_off);
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
                        emit_spill_str_d_auto(code, frame, dd, sp_off);
                    }
                    true
                }
            }
        }
        Inst::TlsAddr(offset) => emit_tls_addr(
            code,
            dst,
            frame,
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
        Inst::InlineAsm { asm, args } => emit_inline_asm_aarch64(
            code,
            asm,
            args,
            func,
            alloc,
            frame,
            fixups,
            name2entpc,
            extern_data_names,
            data_sym_offsets,
            asm_sections,
            asm_extern_call_sites,
            asm_sym_fixups,
            deferred_regions,
            text_data_ranges,
            text_align,
            text_map_state,
            asm_text_labels,
            asm_section_text_refs,
            None,
        ),
        // `BlockAddr` is materialized in `emit_function`'s block loop and
        // `TailExt` is a terminator, so neither reaches here; the segment
        // accesses are x86-only. Reaching this arm means a variant has no
        // aarch64 lowering, which is a compile failure, not silent output.
        other => {
            bail_msg(&alloc::format!(
                "inst variant not yet covered: {}",
                other.variant_name()
            ));
            false
        }
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
    frame: Frame,
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
    use super::encode::{enc_add_imm_lsl12, enc_blr, enc_ldr_reg_lsl3, enc_mrs_tpidr_el0};
    // A spilled destination materialises in the scratch every other
    // address-producing lowering uses, then stores to the slot; x17 stays
    // free for the store's base, and the three sequences below only read
    // `rd` after their last use of x16.
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => Reg(16),
        _ => {
            bail_msg("TlsAddr: dst not int reg / spill");
            return false;
        }
    };
    let emitted = match target {
        Target::LinuxAarch64 => {
            // AAPCS64 variant-1: the static TLS block sits above the thread
            // pointer after a 16-byte TCB reserve, so a variable at
            // `offset` in its unit's block reads `tp + 16 + offset`. The
            // local-exec form is the standard two-add sequence
            // (`tprel_hi12` + `tprel_lo12`), which covers a 24-bit TPOFF
            // and gives the linker two patchable immediates. A unit-local
            // access bakes the single-unit TPOFF; a cross-unit extern
            // bakes the 16-byte reserve as a placeholder. Both record an
            // `elf_tpoff_fixups` entry (at the first add) so the linker
            // rebases the pair against the merged TLS layout.
            let tpoff = if tls_extern_sym.is_some() {
                16u32
            } else {
                (offset + 16) as u32
            };
            if tpoff >= (1 << 24) {
                bail_msg("TlsAddr: tpoff exceeds the hi12/lo12 range");
                return false;
            }
            emit(code, enc_mrs_tpidr_el0(rd));
            let add_off = code.len();
            emit(code, enc_add_imm_lsl12(rd, rd, tpoff >> 12));
            emit(code, enc_add_imm(rd, rd, tpoff & 0xFFF));
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
    };
    if emitted {
        spill_local_addr_to_dst(code, dst, rd, frame);
    }
    emitted
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
            emit_spill_str_x_auto(code, frame, scratch.primary, sp_off);
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
        // Resolved to an `Imm` before lowering, by the SSA folds under
        // `-O` and by the walker otherwise; reaching here is a pass-
        // ordering bug.
        I::ConstantP => {
            bail_msg("Intrinsic::ConstantP must be resolved before lowering");
            false
        }
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
            // __vr_offs (+28) = -(8 - named_fp) * 16, or 0 when the
            // prologue skipped the vector save area: zero reads as
            // exhausted, so `va_arg` walks the general area then the
            // overflow stack.
            let vr_offs = if abi.no_fp_varargs {
                0
            } else {
                -((8u32.saturating_sub(named_fp) * 16) as i64)
            };
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
                    emit_spill_str_x_auto(code, frame, rd, sp_off);
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
            // alloca(n): move sp down by `n` rounded up to 16 bytes
            // and return the new sp. The 16-byte rounding keeps sp
            // aligned (AAPCS64 5.2.2.1); the frame's spill slots and
            // locals stay reachable through fp (`Frame::dynamic_sp`).
            // The storage is reclaimed by the epilogue's
            // `sub sp, fp, #frame_bytes`, or earlier by an
            // `AllocaRestore` closing a VLA scope (C99 6.2.4p2).
            if !frame.dynamic_sp {
                bail_msg("Alloca: AllocaInit didn't run for this function");
                return false;
            }
            if args.len() != 1 {
                bail_msg("Alloca: expected 1 arg");
                return false;
            }
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                bail_msg("Alloca: dst not int reg / spill");
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
            // rd = sp - aligned_size, the final sp value. rd is an
            // allocator register or x16; x17 holds the size, so the
            // two never alias.
            emit(code, enc_add_imm(rd, Reg(31), 0));
            emit(code, enc_sub_reg(rd, rd, scratch.secondary));
            // Walk sp down page by page, touching each, before committing
            // the final value: the same guard-region rule the prologue's
            // `emit_stack_alloc` follows, over a size known only at run
            // time. x17 (the dead size) carries the page count. The size
            // is 16-aligned, so the amount the settling `mov` covers past
            // the last probe is at most MAX_UNPROBED_STACK_STEP and needs
            // no probe of its own.
            emit(
                code,
                super::encode::enc_lsr_imm(scratch.secondary, scratch.secondary, 12),
            );
            emit(code, enc_cbz(scratch.secondary, 5));
            emit(code, super::encode::enc_sub_imm_lsl12(Reg(31), Reg(31), 1));
            emit_stack_probe(code);
            emit(
                code,
                super::encode::enc_subs_imm(scratch.secondary, scratch.secondary, 1),
            );
            emit(code, super::encode::enc_b_cond(super::encode::Cond::Ne, -3));
            emit(code, enc_add_imm(Reg(31), rd, 0));
            spill_local_addr_to_dst(code, dst, rd, frame);
            true
        }
        I::AllocaSave => {
            // Snapshot sp for a VLA block (C99 6.2.4p2).
            if !frame.dynamic_sp {
                bail_msg("AllocaSave: AllocaInit didn't run for this function");
                return false;
            }
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                bail_msg("AllocaSave: dst not int reg / spill");
                return false;
            };
            emit(code, enc_add_imm(rd, Reg(31), 0));
            spill_local_addr_to_dst(code, dst, rd, frame);
            true
        }
        I::AllocaRestore => {
            // Restore the saved sp on VLA block exit, reclaiming the
            // block's VLA storage (per iteration for a loop body).
            if !frame.dynamic_sp {
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
            emit(code, enc_add_imm(Reg(31), v, 0));
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
        I::X86FxSave | I::X86FxRestore => {
            // fxsave / fxrstor are x86-only; the AArch64 firmware path uses
            // its own FP state save and never reaches these.
            bail_msg("fxsave / fxrstor intrinsic is x86-only");
            false
        }
        I::X86Sgdt
        | I::X86Sidt
        | I::X86Sldt
        | I::X86Str
        | I::X86Lgdt
        | I::X86Lidt
        | I::X86Lldt
        | I::X86Clflush => {
            // x86 descriptor-table / clflush forms; AArch64 has no equivalent
            // and the source gates them on the target.
            bail_msg("descriptor-table intrinsic is x86-only");
            false
        }
        I::Divq128 => {
            // The `divq` 128/64 divide is x86-only; the source gates it on
            // `__x86_64__`, so AArch64 never reaches it.
            bail_msg("divq intrinsic is x86-64 only");
            false
        }
        I::AArch64DsbIsh => {
            // `dsb ish` (0xD5033B9F): data synchronisation barrier over the
            // inner shareable domain. No operand, no result.
            emit(code, 0xD503_3B9Fu32);
            true
        }
        I::AArch64Isb => {
            // `isb` (0xD5033FDF): instruction synchronisation barrier. No
            // operand, no result.
            emit(code, 0xD503_3FDFu32);
            true
        }
        I::AArch64DcCvau | I::AArch64IcIvau => {
            // `dc cvau, Xt` (0xD50B7B20|Rt) / `ic ivau, Xt` (0xD50B7520|Rt):
            // clean the data cache / invalidate the instruction cache to the
            // point of unification for the address in Xt. One pointer input.
            if args.len() != 1 {
                bail_msg("dc/ic cache op: expected 1 arg");
                return false;
            }
            let place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let rt = match materialize_int(code, place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            let base = if matches!(intrinsic, I::AArch64DcCvau) {
                0xD50B_7B20u32
            } else {
                0xD50B_7520u32
            };
            emit(code, base | (rt.0 as u32));
            true
        }
        I::AArch64ReadCacheType => {
            // `mrs Xt, ctr_el0` (0xD53B0020|Rt) reads the cache type
            // register; store it to the output operand's address (arg 0).
            if args.len() != 1 {
                bail_msg("mrs ctr_el0: expected 1 arg");
                return false;
            }
            let place = alloc
                .places
                .get(args[0] as usize)
                .copied()
                .unwrap_or(Place::None);
            let addr = match materialize_int(code, place, scratch.primary, frame) {
                Some(r) => r,
                None => return false,
            };
            let tmp = if addr.0 == scratch.secondary.0 {
                scratch.primary
            } else {
                scratch.secondary
            };
            emit(code, 0xD53B_0020u32 | (tmp.0 as u32));
            emit(code, enc_str_imm(tmp, addr, 0));
            true
        }
        I::Atomic128CmpXchg | I::Atomic128Xchg | I::Atomic128FetchAnd | I::Atomic128FetchOr => {
            emit_atomic128(code, intrinsic, args, alloc, frame, scratch)
        }
        I::Atomic128Load | I::Atomic128Store | I::Atomic128LoadEx | I::Atomic128StoreEx => {
            emit_atomic128_ldst(code, intrinsic, args, alloc, frame, scratch)
        }
        I::Atomic128StoreInsert => emit_atomic128_store_insert(code, args, alloc, frame, scratch),
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
                emit_spill_str_d_auto(code, frame, dd, sp_off);
            }
            true
        }
        I::FrameAddress => {
            // __builtin_frame_address(0): the current frame pointer (x29).
            // A level above 0 reaches here as this plus a load chain.
            // Materialise through scratch when the dst spilled.
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
        I::StackPointer => {
            // A `register T v asm("sp")` read: the current stack pointer.
            // ADD (immediate) reads register 31 as SP.
            let rd = match dst {
                Place::IntReg(r) => Reg(r),
                Place::Spill(_) => Reg(16),
                _ => {
                    bail_msg("StackPointer: dst not int reg / spill");
                    return false;
                }
            };
            emit(code, enc_add_imm(rd, Reg(31), 0));
            spill_local_addr_to_dst(code, dst, rd, frame);
            true
        }
        I::ReturnAddress => {
            // __builtin_return_address(0): the saved return address the
            // AAPCS64 prologue stored at [x29 + 8]. The parser admits
            // level 0 only, so there is no operand.
            let rd = match dst {
                Place::IntReg(r) => Reg(r),
                Place::Spill(_) => Reg(16),
                _ => {
                    bail_msg("ReturnAddress: dst not int reg / spill");
                    return false;
                }
            };
            // Under pac-ret the slot holds a signed pointer, which matches
            // no symbol range. `XPACLRI` strips x30 and no other register,
            // so the value is staged there; the epilogue reloads x30 from
            // the same slot. Holding the intrinsic keeps the function off
            // the full-leaf path, so that frame record always exists.
            // Unconditional, as gcc and clang emit it: the hint is a NOP
            // without FEAT_PAuth and an unsigned pointer survives it.
            emit(code, enc_ldr_imm(Reg(30), Reg(29), 8));
            emit(code, super::encode::XPACLRI);
            emit_mov_reg(code, rd, Reg(30));
            spill_local_addr_to_dst(code, dst, rd, frame);
            true
        }
        I::Clz
        | I::Ctz
        | I::Popcount
        | I::Clzll
        | I::Ctzll
        | I::Popcountll
        | I::Clrsb
        | I::Clrsbll
        | I::Parity
        | I::Parityll
        | I::Ffs
        | I::Ffsll
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
    emit_stack_alloc(code, plan.scratch_bytes, None);
    if !marshal_args(
        code, &plan, args, alloc, scratch, frame, arg_aggs, agg_descs, abi,
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
        emit_spill_str_x_auto(code, frame, Reg(0), sp_off);
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
        emit_stack_alloc(code, plan.scratch_bytes, None);
        if !marshal_args(
            code, &plan, args, alloc, scratch, frame, arg_aggs, agg_descs, abi,
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
    emit_stack_alloc(code, plan.scratch_bytes, None);
    if !marshal_args(
        code, &plan, args, alloc, scratch, frame, arg_aggs, agg_descs, abi,
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
        emit_local_addr_fp(code, Place::IntReg(8), ret_slot_off, frame);
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
            emit_local_addr_fp(code, Place::IntReg(scratch.primary.0), ret_slot_off, frame);
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
            emit_local_addr_fp(code, Place::IntReg(scratch.primary.0), ret_slot_off, frame);
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
                emit_spill_str_d_auto(code, frame, 0, sp_off);
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
            emit_spill_str_x_auto(code, frame, Reg(0), sp_off);
        }
        Place::None => {}
    }
}

/// Indirect call through a function-pointer value: marshal args per
/// the host ABI, capture the target into a callee-overwritable
/// scratch register that arg marshalling won't clobber, `blr`,
/// recover the return value.
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
    // Host ABI through a function pointer, for variadic and
    // non-variadic callees alike: `marshal_args` places the named
    // arguments per AAPCS64 (int / FP bank, overflow on the host
    // stack) and a variadic tail per the target's host variadic
    // placement (`variadic_on_stack` on macOS, `variadic_int_only`
    // on Windows arm64, both banks then the stack on Linux
    // aarch64) -- the same placement `emit_call` uses for a direct
    // call. A non-variadic call plans every argument as fixed,
    // mirroring the direct path; the walker lowers an unrecoverable
    // prototype as all-fixed non-variadic, which this placement
    // serves. The target pointer rides a non-arg-passing scratch
    // that `marshal_args` will not clobber, or a reserved stack
    // cell above the argument slots when no such scratch is free.
    let plan_fixed = if callee_variadic {
        fixed_args
    } else {
        args.len()
    };
    let mut plan =
        super::plan_call_args_aggs(args.len(), plan_fixed, fp_arg_mask, abi, &aggs, false);
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
    emit_stack_alloc(code, plan.scratch_bytes, None);
    if let Some(off) = staged_off {
        emit_sp_str_x_auto(code, target_reg, off);
    }
    if !marshal_args(
        code, &plan, args, alloc, scratch, frame, arg_aggs, agg_descs, abi,
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
    true
}

/// Compile-time-unrolled struct copy. `size` bytes from [src] to
/// [dst]; emits 8-byte ldr/str pairs for whole words and a
/// ldrb/strb tail for any sub-word remainder. The defined value
/// is `dst` -- mirrors C's `memcpy(dst, src, size)` return.
/// One load / store pair of `width` bytes (8, 4, 2 or 1) moving
/// `[sbase + soff]` to `[dbase + doff]` through `temp`.
#[allow(clippy::too_many_arguments)]
fn emit_copy_unit(
    code: &mut Vec<u8>,
    width: u32,
    temp: Reg,
    sbase: Reg,
    soff: u32,
    dbase: Reg,
    doff: u32,
) {
    let (ld, st) = match width {
        8 => (
            enc_ldr_imm(temp, sbase, soff),
            enc_str_imm(temp, dbase, doff),
        ),
        4 => (
            super::encode::enc_ldr32_imm(temp, sbase, soff),
            super::encode::enc_str32_imm(temp, dbase, doff),
        ),
        2 => (
            enc_ldrh_imm(temp, sbase, soff),
            enc_strh_imm(temp, dbase, doff),
        ),
        _ => (
            enc_ldrb_imm(temp, sbase, soff),
            enc_strb_imm(temp, dbase, doff),
        ),
    };
    emit(code, ld);
    emit(code, st);
}

/// Zero-extending load of `width` bytes (8, 4, 2 or 1) from
/// `[base + off]` into `rt`.
fn enc_load_unit(width: u32, rt: Reg, base: Reg, off: u32) -> u32 {
    match width {
        8 => enc_ldr_imm(rt, base, off),
        4 => super::encode::enc_ldr32_imm(rt, base, off),
        2 => enc_ldrh_imm(rt, base, off),
        _ => enc_ldrb_imm(rt, base, off),
    }
}

/// Load `width` bytes at `[base + off]` into the integer register
/// `dst`, using no access wider than `align` proves at that address
/// (see [`super::super::access_pieces`]). `tmp` holds each narrow
/// piece; it must differ from `base` and `dst`, and stays untouched
/// when one access suffices -- the only case in which `dst` may alias
/// `base`.
#[allow(clippy::too_many_arguments)]
fn emit_agg_load_int(
    code: &mut Vec<u8>,
    dst: Reg,
    base: Reg,
    off: u32,
    width: u32,
    align: u32,
    strict_align: bool,
    tmp: Reg,
) {
    for (i, (o, w)) in super::super::access_pieces(off, width, align, strict_align).enumerate() {
        if i == 0 {
            emit(code, enc_load_unit(w, dst, base, o));
            continue;
        }
        debug_assert!(dst.0 != base.0 && tmp.0 != base.0 && tmp.0 != dst.0);
        emit(code, enc_load_unit(w, tmp, base, o));
        emit(
            code,
            super::encode::enc_lsl_imm(tmp, tmp, ((o - off) * 8) as u8),
        );
        emit(code, super::encode::enc_orr_reg(dst, dst, tmp));
    }
}

/// As [`emit_agg_load_int`] with an FP register destination (`width`
/// 8 for a d-register, 4 for an s-register). The value composes in the
/// vector register itself, so `tmp` is the only register needed beyond
/// `base`: the first piece arrives through `fmov` (which clears the
/// element bits above it), the rest through element inserts.
#[allow(clippy::too_many_arguments)]
fn emit_agg_load_fp(
    code: &mut Vec<u8>,
    dst: u8,
    base: Reg,
    off: u32,
    width: u32,
    align: u32,
    strict_align: bool,
    tmp: Reg,
) {
    if super::super::access_unit(off, width, align, strict_align) == width {
        emit(
            code,
            if width == 8 {
                super::encode::enc_ldr_d_imm(dst, base, off)
            } else {
                super::encode::enc_ldr_s_imm(dst, base, off)
            },
        );
        return;
    }
    for (i, (o, w)) in super::super::access_pieces(off, width, align, strict_align).enumerate() {
        emit(code, enc_load_unit(w, tmp, base, o));
        if i == 0 {
            emit(
                code,
                if width == 8 {
                    super::encode::enc_fmov_x_to_d(dst, tmp)
                } else {
                    super::encode::enc_fmov_w_to_s(dst, tmp)
                },
            );
        } else {
            emit(code, super::encode::enc_ins_gen(dst, w, i as u32, tmp));
        }
    }
}

/// Alignment a scalar access must respect, or `None` when it may keep
/// its natural width: an access carries a bound only where the walker
/// proved one, and only `-mstrict-align` acts on it.
fn narrow_bound(align: u8, abi: super::Abi) -> Option<u32> {
    (abi.strict_align && align != 0).then_some(align as u32)
}

/// Zero-extending store of the low `width` bytes (8, 4, 2 or 1) of
/// `rt` to `[base + off]`.
fn enc_store_unit(width: u32, rt: Reg, base: Reg, off: u32) -> u32 {
    match width {
        8 => enc_str_imm(rt, base, off),
        4 => super::encode::enc_str32_imm(rt, base, off),
        2 => enc_strh_imm(rt, base, off),
        _ => enc_strb_imm(rt, base, off),
    }
}

/// Registers a narrowed scalar access borrows for its accumulator and
/// piece temp. They sit in the allocator's pool, so each is saved and
/// restored across the sequence; nothing between the save and the
/// restore addresses `sp`. Mirrors the reservation `emit_mcpy` makes.
const NARROW_BORROW: [u8; 7] = [9, 10, 11, 12, 13, 14, 15];

/// The first `N` borrow registers distinct from every register in
/// `avoid`. The pool is larger than any caller's avoid set, so the
/// pick always succeeds.
fn narrow_borrows<const N: usize>(avoid: &[u8]) -> [Reg; N] {
    let mut out = [Reg(0); N];
    let mut n = 0;
    for cand in NARROW_BORROW {
        if n == N {
            break;
        }
        if !avoid.contains(&cand) {
            out[n] = Reg(cand);
            n += 1;
        }
    }
    debug_assert_eq!(n, N, "narrow access: no free borrow register");
    out
}

/// Byte width of an integer load kind, and whether it sign-extends.
fn int_load_shape(kind: LoadKind) -> (u32, bool) {
    match kind {
        LoadKind::I64 => (8, false),
        LoadKind::I32 => (4, true),
        LoadKind::U32 => (4, false),
        LoadKind::I16 => (2, true),
        LoadKind::U16 => (2, false),
        LoadKind::I8 => (1, true),
        LoadKind::U8 => (1, false),
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => (0, false),
    }
}

/// Byte width of an integer store kind.
fn int_store_width(kind: StoreKind) -> u32 {
    match kind {
        StoreKind::I64 => 8,
        StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => 0,
    }
}

/// Lower an integer load at `[rn + disp]` whose address is proven only
/// `align`-aligned into accesses no wider than that, into `rd`. The
/// pieces compose zero-extended; a signed kind is sign-extended after.
fn emit_narrow_load(code: &mut Vec<u8>, rd: Reg, rn: Reg, disp: u32, kind: LoadKind, align: u32) {
    let (width, signed) = int_load_shape(kind);
    let [acc, tmp] = narrow_borrows::<2>(&[rn.0, rd.0]);
    emit(code, enc_str_pre(acc, Reg(31), -16));
    emit(code, enc_str_pre(tmp, Reg(31), -16));
    emit_agg_load_int(code, acc, rn, disp, width, align, true, tmp);
    match (signed, width) {
        (true, 4) => emit(code, super::encode::enc_sxtw(rd, acc)),
        (true, 2) => emit(code, super::encode::enc_sxth(rd, acc)),
        (true, 1) => emit(code, super::encode::enc_sxtb(rd, acc)),
        _ => emit_mov_reg(code, rd, acc),
    }
    emit(code, enc_ldr_post(tmp, Reg(31), 16));
    emit(code, enc_ldr_post(acc, Reg(31), 16));
}

/// Store companion to [`emit_narrow_load`]: write the low `width`
/// bytes of `rs` to `[rn + disp]` in `align`-wide pieces, most
/// significant last.
fn emit_narrow_store(code: &mut Vec<u8>, rs: Reg, rn: Reg, disp: u32, width: u32, align: u32) {
    let [tmp] = narrow_borrows::<1>(&[rn.0, rs.0]);
    emit(code, enc_str_pre(tmp, Reg(31), -16));
    for (i, (o, w)) in super::super::access_pieces(disp, width, align, true).enumerate() {
        let src = if i == 0 {
            rs
        } else {
            emit(
                code,
                super::encode::enc_lsr_imm(tmp, rs, ((o - disp) * 8) as u8),
            );
            tmp
        };
        emit(code, enc_store_unit(w, src, rn, o));
    }
    emit(code, enc_ldr_post(tmp, Reg(31), 16));
}

#[allow(clippy::too_many_arguments)]
fn emit_mcpy(
    code: &mut Vec<u8>,
    dst_place: Place,
    dst_val: u32,
    src_val: u32,
    size: i64,
    align: u32,
    strict_align: bool,
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
    // The scaled load/store immediate reaches 32760 for 8-byte accesses
    // but only 4095 for the byte tail, so a copy whose byte offset would
    // exceed that must advance the base pointers. `WINDOW` is 8-aligned and
    // below 4096, keeping every word and tail offset in range and letting a
    // single `add` (12-bit immediate) step both bases between windows.
    // Below 4096 the narrower units reach it too: their scaled immediates
    // cover 8190 (halfword) and 4095 (byte).
    const WINDOW: u32 = 4088;
    let unit = super::super::access_chunk(align, strict_align, 8);
    let copy_run = |code: &mut Vec<u8>, sbase: Reg, dbase: Reg, run: u32| {
        let words = run / unit;
        for w in 0..words {
            let off = w * unit;
            emit_copy_unit(code, unit, temp, sbase, off, dbase, off);
        }
        let tail_start = words * unit;
        for i in 0..(run - tail_start) {
            let off = tail_start + i;
            emit(code, enc_ldrb_imm(temp, sbase, off));
            emit(code, enc_strb_imm(temp, dbase, off));
        }
    };
    if bytes <= WINDOW {
        copy_run(code, src_r, dst_r, bytes);
    } else {
        // Advance working copies so `dst_r` (the memcpy return value) and
        // `src_r` are left unchanged. Pick two scratch registers distinct
        // from the bases and the data temp; save and restore them.
        let mut picks = [Reg(9), Reg(9)];
        let mut n = 0;
        for cand in [9u8, 13, 14, 15, 12, 11] {
            if cand != dst_r.0 && cand != src_r.0 && cand != temp.0 && n < 2 {
                picks[n] = Reg(cand);
                n += 1;
            }
        }
        let (wsrc, wdst) = (picks[0], picks[1]);
        emit(code, enc_str_pre(wsrc, Reg(31), -16));
        emit(code, enc_str_pre(wdst, Reg(31), -16));
        emit_mov_reg(code, wsrc, src_r);
        emit_mov_reg(code, wdst, dst_r);
        let mut pos = 0u32;
        while pos < bytes {
            let run = (bytes - pos).min(WINDOW);
            copy_run(code, wsrc, wdst, run);
            pos += run;
            if pos < bytes {
                emit(code, super::encode::enc_add_imm(wsrc, wsrc, run));
                emit(code, super::encode::enc_add_imm(wdst, wdst, run));
            }
        }
        emit(code, enc_ldr_post(wdst, Reg(31), 16));
        emit(code, enc_ldr_post(wsrc, Reg(31), 16));
    }
    emit(code, enc_ldr_post(temp, Reg(31), 16));
    // memcpy returns dst -- propagate into the Inst's `dst_place`.
    if let Some(rd) = int_reg(dst_place) {
        if rd.0 != dst_r.0 {
            emit_mov_reg(code, rd, dst_r);
        }
    } else if let Place::Spill(slot) = dst_place {
        let sp_off = spill_off(frame, slot);
        emit_spill_str_x_auto(code, frame, dst_r, sp_off);
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

/// x9..x15 save area for the 128-bit atomic sequence (7 borrowed working
/// registers, padded to a 16-byte multiple).
const ATOMIC128_SAVE_BYTES: u32 = 64;

/// Save x9..x15 so any value the allocator parked there survives the
/// sequence. Layout: `[sp+0]=x9 .. [sp+48]=x15`. sp moves down by
/// [`ATOMIC128_SAVE_BYTES`].
fn atomic128_save_working(code: &mut Vec<u8>) {
    use super::encode::{enc_stp_off, enc_stp_pre};
    emit(
        code,
        enc_stp_pre(Reg(9), Reg(10), Reg(31), -(ATOMIC128_SAVE_BYTES as i32)),
    );
    emit(code, enc_stp_off(Reg(11), Reg(12), Reg(31), 16));
    emit(code, enc_stp_off(Reg(13), Reg(14), Reg(31), 32));
    emit(code, enc_str_imm(Reg(15), Reg(31), 48));
}

/// Restore x9..x15 saved by [`atomic128_save_working`]. Run after the
/// prior value has been written back through its output addresses.
fn atomic128_restore_working(code: &mut Vec<u8>) {
    use super::encode::{enc_ldp_off, enc_ldp_post};
    emit(code, enc_ldr_imm(Reg(15), Reg(31), 48));
    emit(code, enc_ldp_off(Reg(13), Reg(14), Reg(31), 32));
    emit(code, enc_ldp_off(Reg(11), Reg(12), Reg(31), 16));
    emit(
        code,
        enc_ldp_post(Reg(9), Reg(10), Reg(31), ATOMIC128_SAVE_BYTES as i32),
    );
}

/// Materialise an operand into `target`, reading the saved copy when the
/// allocator placed it in a borrowed working register (x9..x15) that an
/// earlier operand move may already have clobbered.
fn atomic128_operand_into(
    code: &mut Vec<u8>,
    value: super::super::ir::ValueId,
    target: Reg,
    frame: Frame,
    alloc: &Allocation,
) -> bool {
    let place = alloc
        .places
        .get(value as usize)
        .copied()
        .unwrap_or(Place::None);
    if let Place::IntReg(r) = place
        && (9..=15).contains(&r)
    {
        emit_sp_ldr_x(code, target, (r as u32 - 9) * 8);
        return true;
    }
    match materialize_int_shifted(code, place, target, frame, ATOMIC128_SAVE_BYTES) {
        Some(r) => {
            if r.0 != target.0 {
                emit_mov_reg(code, target, r);
            }
            true
        }
        None => false,
    }
}

/// C11-style 128-bit atomic read-modify-write via an LDAXP / STLXP
/// exclusive-pair retry loop (ARM ARM B2.9), recognised from the GCC
/// inline-asm shape aarch64 code uses for `Int128` atomics. `args` is
/// `[ptr, &oldl, &oldh, in...]`: the inputs are `(cmpl, cmph, newl, newh)`
/// for `CmpXchg` and `(newl, newh)` otherwise. The prior 128-bit value is
/// written back through `&oldl` / `&oldh` (the caller reads it); there is
/// no register result.
fn emit_atomic128(
    code: &mut Vec<u8>,
    kind: super::super::op::Intrinsic,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    use super::super::op::Intrinsic as I;
    use super::encode::{Cond, enc_ccmp, enc_ldaxp, enc_orr_reg, enc_stlxp};
    let n_in = if matches!(kind, I::Atomic128CmpXchg) {
        4
    } else {
        2
    };
    if args.len() != 3 + n_in {
        bail_msg("atomic128: wrong operand count");
        return false;
    }
    let ptr = Reg(9);
    let oldl = Reg(10);
    let oldh = Reg(11);
    let status = scratch.secondary; // x17
    atomic128_save_working(code);
    if !atomic128_operand_into(code, args[0], ptr, frame, alloc) {
        bail_msg("atomic128: ptr operand not int reg / spill");
        return false;
    }
    // Inputs land in x12.. in declaration order: (cmpl,cmph,newl,newh) or
    // (newl,newh). Reads route through the save area if the allocator had
    // parked an input in a register a prior move already overwrote.
    for (k, &a) in args[3..].iter().enumerate() {
        if !atomic128_operand_into(code, a, Reg(12 + k as u8), frame, alloc) {
            bail_msg("atomic128: input operand not int reg / spill");
            return false;
        }
    }
    let loop_start = code.len();
    emit(code, enc_ldaxp(oldl, oldh, ptr));
    let (src_l, src_h, to_done) = match kind {
        I::Atomic128CmpXchg => {
            // Two-word equality: compare low, then high only when low matched.
            emit(code, enc_cmp_reg(oldl, Reg(12)));
            emit(code, enc_ccmp(oldh, Reg(13), 0, Cond::Eq));
            emit(code, enc_b_cond(Cond::Ne, 0));
            (Reg(14), Reg(15), Some(code.len() - 4))
        }
        I::Atomic128Xchg => (Reg(12), Reg(13), None),
        I::Atomic128FetchAnd => {
            emit(code, enc_and_reg(Reg(14), oldl, Reg(12)));
            emit(code, enc_and_reg(Reg(15), oldh, Reg(13)));
            (Reg(14), Reg(15), None)
        }
        I::Atomic128FetchOr => {
            emit(code, enc_orr_reg(Reg(14), oldl, Reg(12)));
            emit(code, enc_orr_reg(Reg(15), oldh, Reg(13)));
            (Reg(14), Reg(15), None)
        }
        _ => {
            bail_msg("atomic128: unexpected kind");
            return false;
        }
    };
    emit(code, enc_stlxp(status, src_l, src_h, ptr));
    let back = ((loop_start as i64) - (code.len() as i64)) / 4;
    emit(code, enc_cbnz(status, back as i32));
    // CmpXchg's mismatch branch lands here, past the store/retry.
    if let Some(to_done) = to_done {
        let delta = ((code.len() - to_done) / 4) as i32;
        code[to_done..to_done + 4].copy_from_slice(&enc_b_cond(Cond::Ne, delta).to_le_bytes());
    }
    // Write the prior value back through &oldl / &oldh.
    if !atomic128_writeback(code, args[1], oldl, frame, alloc, scratch.primary)
        || !atomic128_writeback(code, args[2], oldh, frame, alloc, scratch.primary)
    {
        return false;
    }
    atomic128_restore_working(code);
    true
}

/// Store `src` (a loaded old half) through the output address operand
/// `addr_val`, materialised into `addr_tmp`.
fn atomic128_writeback(
    code: &mut Vec<u8>,
    addr_val: super::super::ir::ValueId,
    src: Reg,
    frame: Frame,
    alloc: &Allocation,
    addr_tmp: Reg,
) -> bool {
    if !atomic128_operand_into(code, addr_val, addr_tmp, frame, alloc) {
        bail_msg("atomic128: output address not int reg / spill");
        return false;
    }
    emit(code, enc_str_imm(src, addr_tmp, 0));
    true
}

/// AArch64 128-bit atomic load / store, recognised from the inline-asm
/// idiom used for a 16-byte access without native LSE2. `Load`/`Store` are
/// the plain `LDP`/`STP` forms; `LoadEx`/`StoreEx` are the pre-LSE2 forms
/// built from an `LDXP`/`STXP` exclusive-pair retry loop (ARM ARM B2.9).
/// `args` is `[ptr, &l, &h]` for the loads (the value read from `ptr` is
/// written back through `&l` / `&h`) and `[ptr, l, h]` for the stores.
/// There is no register result. Borrowed working registers x9..x15 are
/// saved / restored so spilled operands can route through the save area.
fn emit_atomic128_ldst(
    code: &mut Vec<u8>,
    kind: super::super::op::Intrinsic,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    use super::super::op::Intrinsic as I;
    use super::encode::{enc_ldxp, enc_stxp};
    if args.len() != 3 {
        bail_msg("atomic128 ldst: wrong operand count");
        return false;
    }
    let ptr = Reg(9);
    let lo = Reg(10);
    let hi = Reg(11);
    let status = scratch.secondary; // x17
    atomic128_save_working(code);
    if !atomic128_operand_into(code, args[0], ptr, frame, alloc) {
        bail_msg("atomic128 ldst: ptr operand not int reg / spill");
        return false;
    }
    let is_load = matches!(kind, I::Atomic128Load | I::Atomic128LoadEx);
    match kind {
        // Plain LDP: a single non-exclusive 128-bit load. No store, so it
        // never faults on a read-only mapping.
        I::Atomic128Load => emit(code, enc_ldp_off(lo, hi, ptr, 0)),
        // Pre-LSE2 load: an LDXP/STXP loop storing the value it read back
        // unchanged, retried until the monitor holds. Leaves it in lo / hi.
        I::Atomic128LoadEx => {
            let loop_start = code.len();
            emit(code, enc_ldxp(lo, hi, ptr));
            emit(code, enc_stxp(status, lo, hi, ptr));
            let back = ((loop_start as i64) - (code.len() as i64)) / 4;
            emit(code, enc_cbnz(status, back as i32));
        }
        // Plain STP: materialise the two halves and store the pair.
        I::Atomic128Store => {
            if !atomic128_operand_into(code, args[1], Reg(12), frame, alloc)
                || !atomic128_operand_into(code, args[2], Reg(13), frame, alloc)
            {
                bail_msg("atomic128 ldst: store value not int reg / spill");
                return false;
            }
            emit(code, enc_stp_off(Reg(12), Reg(13), ptr, 0));
        }
        // Pre-LSE2 store: an LDXP (result discarded) / STXP loop. The new
        // value sits in x12 / x13, clear of the LDXP scratch lo / hi.
        I::Atomic128StoreEx => {
            if !atomic128_operand_into(code, args[1], Reg(12), frame, alloc)
                || !atomic128_operand_into(code, args[2], Reg(13), frame, alloc)
            {
                bail_msg("atomic128 ldst: store value not int reg / spill");
                return false;
            }
            let loop_start = code.len();
            emit(code, enc_ldxp(lo, hi, ptr));
            emit(code, enc_stxp(status, Reg(12), Reg(13), ptr));
            let back = ((loop_start as i64) - (code.len() as i64)) / 4;
            emit(code, enc_cbnz(status, back as i32));
        }
        _ => {
            bail_msg("atomic128 ldst: unexpected kind");
            return false;
        }
    }
    // Loads publish the read value through &l / &h.
    if is_load
        && (!atomic128_writeback(code, args[1], lo, frame, alloc, scratch.primary)
            || !atomic128_writeback(code, args[2], hi, frame, alloc, scratch.primary))
    {
        return false;
    }
    atomic128_restore_working(code);
    true
}

/// AArch64 128-bit masked store-insert: `*mem = (*mem & ~msk) | val`, from an
/// `LDXP` / `BIC` / `ORR` / `STXP` exclusive retry loop (no LSE2). `args` is
/// `[ptr, vl, vh, ml, mh]`; there is no register result. Borrowed working
/// registers x9..x15 are saved / restored so spilled operands can route
/// through the save area.
fn emit_atomic128_store_insert(
    code: &mut Vec<u8>,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    use super::encode::{enc_bic_reg, enc_ldxp, enc_orr_reg, enc_stxp};
    if args.len() != 5 {
        bail_msg("atomic128 store-insert: wrong operand count");
        return false;
    }
    let ptr = Reg(9);
    let lo = Reg(10);
    let hi = Reg(11);
    let status = scratch.secondary; // x17
    let (vl, vh, ml, mh) = (Reg(12), Reg(13), Reg(14), Reg(15));
    atomic128_save_working(code);
    if !atomic128_operand_into(code, args[0], ptr, frame, alloc) {
        bail_msg("atomic128 store-insert: ptr operand not int reg / spill");
        return false;
    }
    // Inputs land in x12..x15 as (vl, vh, ml, mh); reads route through the
    // save area if the allocator parked one in a working register.
    for (r, &a) in [vl, vh, ml, mh].iter().zip(&args[1..]) {
        if !atomic128_operand_into(code, a, *r, frame, alloc) {
            bail_msg("atomic128 store-insert: input operand not int reg / spill");
            return false;
        }
    }
    let loop_start = code.len();
    emit(code, enc_ldxp(lo, hi, ptr));
    emit(code, enc_bic_reg(lo, lo, ml)); // lo &= ~ml
    emit(code, enc_bic_reg(hi, hi, mh)); // hi &= ~mh
    emit(code, enc_orr_reg(lo, lo, vl)); // lo |= vl
    emit(code, enc_orr_reg(hi, hi, vh)); // hi |= vh
    emit(code, enc_stxp(status, lo, hi, ptr));
    let back = ((loop_start as i64) - (code.len() as i64)) / 4;
    emit(code, enc_cbnz(status, back as i32));
    atomic128_restore_working(code);
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

/// Region byte offset of an over-aligned automatic object's storage in the
/// frame's over-aligned region (C11 6.7.5), or None for an ordinary slot. The
/// region base is sp when the prologue realigned (`realign_align` > 0) and
/// `fp + align_region_off` for the static 16-aligned placement.
fn over_aligned_region_off(off: i64, func: &FunctionSsa, frame: Frame) -> Option<i64> {
    if off >= 0 || (frame.realign_align == 0 && frame.align_region_off == 0) {
        return None;
    }
    func.over_aligned
        .iter()
        .find(|&&(s, _)| s == off)
        .map(|&(_, region_off)| region_off)
}

/// Address of a local slot, redirecting an over-aligned automatic object to its
/// storage in the over-aligned region (C11 6.7.5). Callers that only
/// address synthetic / parameter slots (never over-aligned) use
/// [`emit_local_addr_fp`] directly and need no `func`.
fn emit_local_addr(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    func: &FunctionSsa,
    frame: Frame,
) -> bool {
    let Some(region_off) = over_aligned_region_off(off, func, frame) else {
        return emit_local_addr_fp(code, dst, off, frame);
    };
    if frame.align_region_off != 0 {
        return emit_fp_addr_bytes(code, dst, frame.align_region_off + region_off, frame);
    }
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => Reg(16),
        _ => {
            bail_msg("LocalAddr: dst not int reg / spill");
            return false;
        }
    };
    // `rd = sp + region_off`, through the shared sp-relative helper so an
    // offset past the immediate reach materialises rather than truncating.
    emit_sp_plus_off(code, rd, region_off.max(0) as u32);
    spill_local_addr_to_dst(code, dst, rd, frame);
    true
}

fn emit_local_addr_fp(code: &mut Vec<u8>, dst: Place, off: i64, frame: Frame) -> bool {
    emit_fp_addr_bytes(code, dst, local_slot_off(off, frame), frame)
}

/// Materialise `fp + bytes` into `dst` for any signed byte displacement.
fn emit_fp_addr_bytes(code: &mut Vec<u8>, dst: Place, bytes: i64, frame: Frame) -> bool {
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
    // Past the 24-bit immediate reach: build the displacement and apply
    // it with the register form.
    super::encode::load_imm64(code, rd, abs);
    if bytes >= 0 {
        emit(code, super::encode::enc_add_reg(rd, Reg(29), rd));
    } else {
        emit(code, super::encode::enc_sub_reg(rd, Reg(29), rd));
    }
    spill_local_addr_to_dst(code, dst, rd, frame);
    true
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
        emit_spill_str_x(code, frame, src, sp_off, addr_scratch);
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

/// `Inst::Bswap { value, width }` -- reverse the low `width` bytes,
/// zero-extended. 64-bit: `rev Xd`. 32-bit: `rev Wd` (the 32-bit write
/// zero-extends). 16-bit: `rev Wd` then `lsr Wd, #16`, which drops the
/// reversed upper halfword so operand bits above the width cannot
/// reach the result.
fn emit_bswap(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    width: u8,
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
            bail_msg("Bswap: dst not int reg / spill");
            return false;
        }
    };
    match width {
        2 => {
            emit(code, super::encode::enc_rev32(rd, rn));
            emit(code, super::encode::enc_lsr32_imm(rd, rd, 16));
        }
        4 => emit(code, super::encode::enc_rev32(rd, rn)),
        _ => emit(code, super::encode::enc_rev64(rd, rn)),
    }
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
    bound: Option<u32>,
) -> bool {
    // `disp` is a byte offset folded from a constant pointer addition.
    // index_fold only emits a displacement that is a multiple of the
    // access width and within the scaled-immediate range, so it passes
    // straight to the immediate-offset encoders below. That multiple
    // also lets `bound` -- recorded for the accessed address -- be read
    // as an alignment of the base that `disp` then advances.
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
        match bound {
            Some(a) => emit_agg_load_fp(code, dd, rn, disp, 4, a, true, scratch.secondary),
            None => emit(code, enc_ldr_s_imm(dd, rn, disp)),
        }
        if !keep_f32 {
            emit(code, enc_fcvt_d_s(dd, dd));
        }
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dd, sp_off);
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
        match bound {
            Some(a) => emit_agg_load_fp(code, dd, rn, disp, 8, a, true, scratch.secondary),
            None => emit(code, enc_ldr_d_imm(dd, rn, disp)),
        }
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dd, sp_off);
        }
        return true;
    }
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => scratch.secondary,
        Place::FpReg(_) | Place::None => return false,
    };
    if let Some(a) = bound {
        emit_narrow_load(code, rd, rn, disp, kind, a);
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rd, sp_off);
        }
        return true;
    }
    match kind {
        LoadKind::I64 => emit(code, enc_ldr_imm(rd, rn, disp)),
        LoadKind::I32 => emit(code, enc_ldrsw_imm(rd, rn, disp)),
        LoadKind::U32 => emit(code, enc_ldr32_imm(rd, rn, disp)),
        LoadKind::I16 => emit(code, enc_ldrsh_imm(rd, rn, disp)),
        LoadKind::U16 => emit(code, enc_ldrh_imm(rd, rn, disp)),
        LoadKind::I8 => emit(code, enc_ldrsb_imm(rd, rn, disp)),
        LoadKind::U8 => emit(code, enc_ldrb_imm(rd, rn, disp)),
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
    }
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit_spill_str_x_auto(code, frame, rd, sp_off);
    }
    true
}

/// Single-instruction fp-relative load for `Inst::LoadLocal`.
/// The c5 slot offset converts to a signed byte displacement;
/// `ldur` covers the unscaled 9-bit field `[-256, 255]`
/// directly. Falls back to the general path when the
/// displacement doesn't fit.
#[allow(clippy::too_many_arguments)]
fn emit_load_local(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    kind: LoadKind,
    keep_f32: bool,
    func: &FunctionSsa,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    // An over-aligned automatic object lives sp-relative in the realigned
    // region, not fp-relative; route it through `emit_local_addr` and load
    // through the materialised address (C11 6.7.5).
    let is_over = over_aligned_region_off(off, func, frame).is_some();
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
            && !is_over
            && disp >= 0
            && (disp as u32).is_multiple_of(4)
            && (disp as u32) <= 16380
        {
            emit(code, super::encode::enc_ldr_s_imm(dd, Reg(29), disp as u32));
        } else if !emit_local_addr(code, Place::IntReg(scratch.primary.0), off, func, frame) {
            return false;
        } else {
            emit(code, super::encode::enc_ldr_s_imm(dd, scratch.primary, 0));
        }
        if !keep_f32 {
            emit(code, super::encode::enc_fcvt_d_s(dd, dd));
        }
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dd, sp_off);
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
            && !is_over
            && disp >= 0
            && (disp as u32).is_multiple_of(8)
            && (disp as u32) < 32760
        {
            emit(code, super::encode::enc_ldr_d_imm(dd, Reg(29), disp as u32));
        } else if !emit_local_addr(code, Place::IntReg(scratch.primary.0), off, func, frame) {
            return false;
        } else {
            emit(code, super::encode::enc_ldr_d_imm(dd, scratch.primary, 0));
        }
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dd, sp_off);
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
        && !is_over
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
            LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
        };
        emit(code, word);
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rd, sp_off);
        }
        return true;
    }
    // Large displacement (or an over-aligned sp-relative object): materialise
    // the address into a scratch through the standard `LocalAddr` lowering,
    // then load through it. Same byte cost as the unfused path.
    if !emit_local_addr(code, Place::IntReg(scratch.primary.0), off, func, frame) {
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
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
    };
    emit(code, word);
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit_spill_str_x_auto(code, frame, rd, sp_off);
    }
    true
}

/// Single-instruction fp-relative store for `Inst::StoreLocal`.
/// Mirrors [`emit_load_local`].
#[allow(clippy::too_many_arguments)]
fn emit_store_local(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    func: &FunctionSsa,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    // An over-aligned automatic object lives sp-relative in the realigned
    // region; route it through `emit_local_addr` and store through the
    // materialised address (C11 6.7.5).
    let is_over = over_aligned_region_off(off, func, frame).is_some();
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
                && !is_over
                && disp >= 0
                && (disp as u32).is_multiple_of(4)
                && (disp as u32) < 16380
            {
                emit(code, super::encode::enc_str_s_imm(sn, Reg(29), disp as u32));
                true
            } else if !emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, func, frame) {
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
                emit_spill_str_d_auto(code, frame, sn, spill_off(frame, slot));
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
            emit_spill_str_d_auto(code, frame, dn, spill_off(frame, slot));
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
            && !is_over
            && disp >= 0
            && (disp as u32).is_multiple_of(8)
            && (disp as u32) < 32760
        {
            emit(code, super::encode::enc_str_d_imm(dn, Reg(29), disp as u32));
        } else if !emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, func, frame) {
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
                emit_spill_str_d_auto(code, frame, dn, sp_off);
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
        if (-256..256).contains(&disp) && !is_over {
            // Store the low `kind`-width bytes; the accumulator below
            // keeps the full source value, matching the c5 rule that
            // an assignment expression yields the stored value before
            // any re-narrowing on read-back (C99 6.5.16p3).
            let enc = match kind {
                StoreKind::I64 => super::encode::enc_stur(rv, Reg(29), disp),
                StoreKind::I32 => super::encode::enc_stur32(rv, Reg(29), disp),
                StoreKind::I16 => super::encode::enc_sturh(rv, Reg(29), disp),
                StoreKind::I8 => super::encode::enc_sturb(rv, Reg(29), disp),
                StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
            };
            emit(code, enc);
        } else if !emit_store_local_large_disp(code, off, rv, kind, func, scratch, frame) {
            return false;
        }
    } else if !emit_store_local_large_disp(code, off, rv, kind, func, scratch, frame) {
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
            emit_spill_str_x_auto(code, frame, rv, sp_off);
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
    func: &FunctionSsa,
    scratch: &ScratchPool,
    frame: Frame,
) -> bool {
    if !emit_local_addr(code, Place::IntReg(scratch.secondary.0), off, func, frame) {
        return false;
    }
    let enc = match kind {
        StoreKind::I64 => super::encode::enc_str_imm(rv, scratch.secondary, 0),
        StoreKind::I32 => super::encode::enc_str32_imm(rv, scratch.secondary, 0),
        StoreKind::I16 => super::encode::enc_strh_imm(rv, scratch.secondary, 0),
        StoreKind::I8 => super::encode::enc_strb_imm(rv, scratch.secondary, 0),
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
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
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
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
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
    };
    emit(code, word);
    if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit_spill_str_x_auto(code, frame, rd, sp_off);
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
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
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
        (StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128, _) => unreachable!(),
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
            emit_spill_str_x_auto(code, frame, rv, sp_off);
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
    bound: Option<u32>,
) -> bool {
    // `disp` is a width-aligned, in-range byte offset folded from a
    // constant pointer addition; it passes straight to the immediate-
    // offset store encoders, and lets `bound` be read as an alignment
    // of the base that `disp` then advances.
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
            match bound {
                Some(a) => {
                    emit(code, enc_fmov_d_to_x(scratch.secondary, sn));
                    emit_narrow_store(code, scratch.secondary, rn, disp, 4, a);
                }
                None => emit(code, enc_str_s_imm(sn, rn, disp)),
            }
            // Propagate the f32 accumulator to `dst` if parked elsewhere.
            if let Some(rd) = fp_reg(dst) {
                if rd != sn {
                    emit(code, super::encode::enc_fmov_s_s(rd, sn));
                }
            } else if let Place::Spill(slot) = dst {
                let sp_off = spill_off(frame, slot);
                emit_spill_str_d_auto(code, frame, sn, sp_off);
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
        match bound {
            Some(a) => {
                emit(code, enc_fmov_d_to_x(scratch.secondary, SCRATCH_FP1));
                emit_narrow_store(code, scratch.secondary, rn, disp, 4, a);
            }
            None => emit(code, enc_str_s_imm(SCRATCH_FP1, rn, disp)),
        }
        if let Some(rd) = fp_reg(dst) {
            if rd != dn {
                emit(code, enc_fmov_d_to_x(scratch.primary, dn));
                emit(code, enc_fmov_x_to_d(rd, scratch.primary));
            }
        } else if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dn, sp_off);
        }
        return true;
    }
    if let StoreKind::F64 = kind {
        // `double` lvalue store: a single 8-byte FP store; no narrow.
        let Some(dn) = materialize_fp(code, value_place, SCRATCH_FP0, frame) else {
            return false;
        };
        match bound {
            Some(a) => {
                emit(code, enc_fmov_d_to_x(scratch.secondary, dn));
                emit_narrow_store(code, scratch.secondary, rn, disp, 8, a);
            }
            None => emit(code, super::encode::enc_str_d_imm(dn, rn, disp)),
        }
        if let Some(rd) = fp_reg(dst) {
            if rd != dn {
                emit(code, super::encode::enc_fmov_d_d(rd, dn));
            }
        } else if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_d_auto(code, frame, dn, sp_off);
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
    match bound {
        Some(a) => emit_narrow_store(code, rs, rn, disp, int_store_width(kind), a),
        None => match kind {
            StoreKind::I64 => emit(code, enc_str_imm(rs, rn, disp)),
            StoreKind::I32 => emit(code, enc_str32_imm(rs, rn, disp)),
            StoreKind::I16 => emit(code, enc_strh_imm(rs, rn, disp)),
            StoreKind::I8 => emit(code, enc_strb_imm(rs, rn, disp)),
            StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => {
                unreachable!("FP store handled in the FP branch above")
            }
        },
    }
    if let Some(rd) = int_reg(dst) {
        if rd.0 != rs.0 {
            emit_mov_reg(code, rd, rs);
        }
    } else if let Place::Spill(slot) = dst {
        let sp_off = spill_off(frame, slot);
        emit_spill_str_x_auto(code, frame, rs, sp_off);
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
            emit_spill_str_d_auto(code, frame, dd, sp_off);
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
        // When the terminator's b.cond consumes the flags directly,
        // drop the cset materialisation -- the comparison value is
        // dead.
        if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
            return true;
        }
        emit(code, enc_cset(rd, cond));
        if let Place::Spill(slot) = dst {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, rd, sp_off);
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
            emit_spill_str_x_auto(code, frame, rd, sp_off);
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
            emit_spill_str_x_auto(code, frame, rd, sp_off);
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
            emit_spill_str_x_auto(code, frame, rd, sp_off);
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
        emit_spill_str_x_auto(code, frame, rd, sp_off);
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
            emit_spill_str_x_auto(code, frame, rd, sp_off);
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
            emit_spill_str_x_auto(code, frame, rd, sp_off);
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
            emit_spill_str_x_auto(code, frame, rd, sp_off);
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
            emit_spill_str_x_auto(code, frame, rd, sp_off);
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
        emit_spill_str_x_auto(code, frame, rd, sp_off);
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

/// Resolve a template vector-view reference (`%N.T`, `%qN`, `{%N.T}`) to the
/// SIMD register assigned to operand N, requiring a `w` constraint.
fn resolve_fp_ref(
    op_reg: &[Option<u8>],
    asm: &super::super::ir::AsmBlock,
    idx: u8,
) -> Result<u8, alloc::string::String> {
    use super::super::ir::AsmConstraint;
    if !matches!(
        asm.operands.get(idx as usize).map(|o| o.constraint),
        Some(AsmConstraint::Fp)
    ) {
        return Err(alloc::string::String::from(
            "aarch64 inline asm: vector operand view on a non-`w` operand",
        ));
    }
    op_reg.get(idx as usize).copied().flatten().ok_or_else(|| {
        alloc::string::String::from("aarch64 inline asm: operand reference is not a register")
    })
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
            // The shift compensates a temporary sp move; the fp-based
            // dynamic-sp form is immune to it.
            let shift = if frame.dynamic_sp { 0 } else { sp_shift };
            let sp_off = spill_off(frame, slot) + shift;
            emit_spill_ldr_x(code, frame, scratch, sp_off);
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
            // The shift compensates a temporary sp move; the fp-based
            // dynamic-sp form is immune to it.
            let shift = if frame.dynamic_sp { 0 } else { sp_shift };
            let sp_off = spill_off(frame, slot) + shift;
            // FP spill reloads need a GPR base when the slot is beyond
            // the scaled-imm12 reach; x16 is the primary scratch and
            // holds no int operand during an FP-value lowering.
            emit_spill_ldr_d(code, frame, scratch_d, sp_off, Reg(16));
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
            emit_spill_ldr_d(code, frame, scratch_d, sp_off, Reg(16));
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
        emit_spill_str_d_auto(code, frame, src, spill_off(frame, slot));
    }
    fn fp_spill_load(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, dst: u8) {
        emit_spill_ldr_d_auto(code, frame, dst, spill_off(frame, slot));
    }
    fn int_reg_mov(&self, code: &mut Vec<u8>, dst: u8, src: u8) {
        emit_mov_reg(code, Reg(dst), Reg(src));
    }
    fn int_spill_store(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8, base: u8) {
        emit_spill_str_x(code, frame, Reg(src), spill_off(frame, slot), Reg(base));
    }
    fn int_spill_load(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, dst: u8) {
        emit_spill_ldr_x(code, frame, Reg(dst), spill_off(frame, slot));
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
        emit_spill_ldr_x(code, frame, Reg(stage), spill_off(frame, src));
        // The value occupies `stage` and `hold` may carry a live cycle
        // source, so the store borrows `hold` via a stack save/restore when
        // the destination slot is out of reach.
        emit_spill_str_x_borrow(code, frame, Reg(stage), spill_off(frame, dst), Reg(hold));
    }
    fn int_spill_store_auto(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8) {
        emit_spill_str_x_auto(code, frame, Reg(src), spill_off(frame, slot));
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
    fn int_reg_load_imm(&self, code: &mut Vec<u8>, dst: u8, bits: i64) {
        super::encode::load_imm64(code, Reg(dst), bits as u64);
    }
    fn fp_reg_from_int_reg(&self, code: &mut Vec<u8>, dst: u8, src: u8, is_f64: bool) {
        if is_f64 {
            emit(code, super::encode::enc_fmov_x_to_d(dst, Reg(src)));
        } else {
            emit(code, super::encode::enc_fmov_w_to_s(dst, Reg(src)));
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
    abi: super::Abi,
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
        if let super::ArgPlacement::StructStack { off, size, align } = placement {
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
            // The outgoing stack slot is 8-aligned (AAPCS64 5.4.2); the
            // source is the caller's object, so its own alignment bounds
            // the unit.
            let unit = super::super::access_chunk(align, abi.strict_align, 8);
            let mut copied = 0u32;
            while copied + unit <= size {
                emit_copy_unit(
                    code,
                    unit,
                    scratch.secondary,
                    scratch.primary,
                    copied,
                    Reg(31),
                    off + copied,
                );
                copied += unit;
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
        let super::ArgPlacement::StructRegs { regs, n, align } = placement else {
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
            emit_agg_load_fp(
                code,
                cr.reg,
                base,
                off,
                msize,
                align,
                abi.strict_align,
                scratch.secondary,
            );
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
            super::ArgPlacement::StructRegs { regs, n, .. } if n > 0 && !regs[0].is_fp => {
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
        if let super::ArgPlacement::StructRegs { regs, n, .. } = placement
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
            super::ArgPlacement::StructRegs { regs, n, align } if !regs[0].is_fp => {
                let base = regs[0].reg;
                for k in (1..n as usize).rev() {
                    emit_agg_load_int(
                        code,
                        Reg(regs[k].reg),
                        Reg(base),
                        (k as u32) * 8,
                        8,
                        align,
                        abi.strict_align,
                        scratch.primary,
                    );
                }
                // The base's own eightbyte overwrites the base, so a
                // composed one accumulates in scratch first.
                if super::super::access_unit(0, 8, align, abi.strict_align) == 8 {
                    emit(code, enc_ldr_imm(Reg(base), Reg(base), 0));
                } else {
                    emit_agg_load_int(
                        code,
                        scratch.primary,
                        Reg(base),
                        0,
                        8,
                        align,
                        abi.strict_align,
                        scratch.secondary,
                    );
                    emit_mov_reg(code, Reg(base), scratch.primary);
                }
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
                emit_agg_load_fp(
                    code,
                    k as u8,
                    base,
                    *off,
                    *msize,
                    desc.align,
                    abi.strict_align,
                    scratch.secondary,
                );
            }
        } else if size <= 16 {
            if size > 8 {
                emit_agg_load_int(
                    code,
                    Reg(1),
                    base,
                    8,
                    8,
                    desc.align,
                    abi.strict_align,
                    scratch.secondary,
                );
            }
            emit_agg_load_int(
                code,
                Reg(0),
                base,
                0,
                8,
                desc.align,
                abi.strict_align,
                scratch.secondary,
            );
        } else {
            let dst = scratch.secondary;
            emit_local_addr_fp(code, Place::IntReg(dst.0), func.indirect_result_slot, frame);
            emit(code, enc_ldr_imm(dst, dst, 0));
            // Both endpoints are the caller's object, so its alignment
            // bounds the transfer unit.
            let unit = super::super::access_chunk(desc.align, abi.strict_align, 8);
            // The byte form's scaled immediate reaches 4095, so a copy
            // past that advances both bases; `WINDOW` is 8-aligned and
            // below 4096, keeping every unit and tail offset in range.
            const WINDOW: u32 = 4088;
            let mut pos = 0u32;
            while pos < size {
                let run = (size - pos).min(WINDOW);
                let mut copied = 0u32;
                while copied + unit <= run {
                    emit_copy_unit(code, unit, Reg(0), base, copied, dst, copied);
                    copied += unit;
                }
                while copied < run {
                    emit(code, enc_ldrb_imm(Reg(0), base, copied));
                    emit(code, enc_strb_imm(Reg(0), dst, copied));
                    copied += 1;
                }
                pos += run;
                if pos < size {
                    emit(code, super::encode::enc_add_imm(base, base, run));
                    emit(code, super::encode::enc_add_imm(dst, dst, run));
                }
            }
            if size > WINDOW {
                // The advanced `dst` no longer names the caller's buffer;
                // re-read the saved indirect-result pointer to return it.
                emit_local_addr_fp(code, Place::IntReg(dst.0), func.indirect_result_slot, frame);
                emit(code, enc_ldr_imm(dst, dst, 0));
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
                    emit_spill_ldr_d_auto(code, frame, 0, sp_off);
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
    // Leaf-function elision: prologue emitted no save, so the
    // epilogue emits no matching restore -- the function body is
    // bracketed only by the return-value materialization and the
    // ret. Keep the symmetry tight so any reader can pair the
    // two halves at a glance.
    if is_full_leaf(func, frame, alloc) {
        emit(code, enc_ret(Reg(30)));
        return;
    }
    // A dynamic-sp frame re-establishes `sp = fp - frame_bytes` first,
    // so the sp-relative restores below read the prologue-time
    // addresses regardless of the body's alloca moves.
    restore_dynamic_sp(code, frame);
    // Restore fp/lr first in the folded shape (the lr load feeds `ret`,
    // so it issues off sp before the writeback chain), then x19 and the
    // callee-saved GPRs / FP regs in mirror order of the prologue's
    // saves; the final restore's post-index tears the frame down. The
    // unfolded shape keeps the restore / `add sp` / fp-lr `ldp` order.
    let fold = frame_fold_bytes(alloc, frame);
    if fold != 0 {
        emit(code, enc_ldp_off(Reg(29), Reg(30), Reg(31), fold as i32));
        emit_epilogue_restore_regs(code, alloc, frame, fold + 16);
    } else {
        emit_epilogue_restore_regs(code, alloc, frame, 0);
        if frame.frame_bytes > 0 {
            // x16 is call-clobbered and carries no result, so it is free
            // to hold a frame size past the immediate reach.
            super::encode::emit_add_sp_imm_scratch(code, frame.frame_bytes, Reg(16));
        }
        emit(code, enc_ldp_post(Reg(29), Reg(30), Reg(31), 16));
    }
    // Drop whatever bytes the prologue allocated above the saved
    // fp/lr for c5 cdecl parameter slots. The single source of
    // truth is `prologue_param_spill_bytes`, recorded on
    // `frame.param_spill_bytes`; both prologue and epilogue read
    // from there so the two sides agree across every branch the
    // prologue takes (variadic, host-stack overflow,
    // ParamRef-elided, per-slot pending_sub flush).
    if frame.param_spill_bytes > 0 {
        emit_add_sp_imm(code, frame.param_spill_bytes);
    }
    // Every teardown above has completed, so sp holds the value
    // `paciasp` signed against.
    if signs_return_address(func, frame, alloc, abi) {
        emit(code, super::encode::AUTIASP);
    }
    emit(code, enc_ret(Reg(30)));
}

/// Extract the int reg from a `Place`, or None if it's not an
/// int placement.
fn int_reg(p: Place) -> Option<Reg> {
    p.int_reg_u8().map(Reg)
}

/// Encode instruction lines in an executable file-scope inline-asm section
/// (`.pushsection .text,"ax"`) to machine bytes. A file-scope block has no
/// operands, so every instruction must be register-concrete.
pub(crate) fn encode_a64_file_asm_section_code(
    blocks: &mut [super::ssa::emit_common::AsmSectionBlock],
) -> Result<(), alloc::string::String> {
    use super::asm::AsmOpndA64;
    use super::table::Opnd;
    let conv = |o: &AsmOpndA64| -> Result<Opnd, alloc::string::String> {
        Ok(match *o {
            AsmOpndA64::Imm(v) => Opnd::Imm(v),
            AsmOpndA64::FpImm(v) => Opnd::FpImm(v),
            AsmOpndA64::Lsl(s) => Opnd::Lsl(s),
            AsmOpndA64::Shift { kind, amount } => Opnd::Shift { kind, amount },
            AsmOpndA64::Extend { option, amount } => Opnd::Extend { option, amount },
            AsmOpndA64::SysReg(f) => Opnd::SysReg(f),
            AsmOpndA64::SysOp(b) => Opnd::SysOp(b),
            AsmOpndA64::Cond(c) => Opnd::Cond(c),
            AsmOpndA64::Reg { num, is64, sp } => Opnd::Reg { num, is64, sp },
            AsmOpndA64::RegWb(num) => Opnd::RegWb(num),
            AsmOpndA64::VReg { num, is_d } => Opnd::VReg { num, is_d },
            AsmOpndA64::QReg(num) => Opnd::QReg(num),
            AsmOpndA64::VScalar { num, size } => Opnd::VScalar { num, size },
            AsmOpndA64::VecReg { num, size, q } => Opnd::VecReg { num, size, q },
            AsmOpndA64::VecElem { num, size, index } => Opnd::VecElem { num, size, index },
            AsmOpndA64::VecList {
                first,
                count,
                size,
                q,
            } => Opnd::VecList {
                first,
                count,
                size,
                q,
            },
            AsmOpndA64::Mem { base, off, pre } => match base {
                super::asm::MemBase::Reg(b) => Opnd::Mem { base: b, off, pre },
                super::asm::MemBase::Ref(_) => {
                    return Err(alloc::string::String::from(
                        "inline asm: operand reference in a file-scope section",
                    ));
                }
            },
            AsmOpndA64::MemReg {
                base,
                index,
                option,
                shift,
            } => match (base, index) {
                (super::asm::MemBase::Reg(b), super::asm::MemBase::Reg(i)) => Opnd::MemReg {
                    base: b,
                    index: i,
                    option,
                    shift,
                },
                _ => {
                    return Err(alloc::string::String::from(
                        "inline asm: operand reference in a file-scope section",
                    ));
                }
            },
            _ => {
                return Err(alloc::string::String::from(
                    "inline asm: unsupported operand in a file-scope section",
                ));
            }
        })
    };
    // File-scope asm has no `asm goto` labels.
    encode_a64_asm_section_code(blocks, &conv, &|_| None)
}

/// Encode instruction lines in an executable inline-asm section
/// (`.pushsection .text,"ax"`) to machine bytes, replacing each `Code` item
/// with `CodeBytes`. `conv` resolves an operand to its table form: a
/// function-body block passes the enclosing template's converter, so a
/// pushed section may reference its operands; a file-scope block has none and
/// passes a register-concrete one. Everything else -- the literal pools, the
/// layout the operand expressions fold against, the symbol relocations -- is
/// the same in both positions.
pub(crate) fn encode_a64_asm_section_code(
    blocks: &mut [super::ssa::emit_common::AsmSectionBlock],
    conv: &dyn Fn(&super::asm::AsmOpndA64) -> Result<super::table::Opnd, alloc::string::String>,
    goto_block: &dyn Fn(u8) -> Option<u32>,
) -> Result<(), alloc::string::String> {
    use super::ssa::emit_common::AsmSectionItem;
    use super::table::{self, Opnd};
    assign_a64_literal_pools(blocks)?;
    // An operand expression over labels is folded before its instruction is
    // encoded: on A64 the value selects the form -- a scaled or unscaled
    // offset, `movz` or `movn` -- which a relocation applied to a finished
    // word cannot.
    let measured = a64_section_operand_layout(blocks)?;
    a64_for_each_section_item_mut(blocks, &mut |key, site, item| {
        {
            let AsmSectionItem::Code(text) = item else {
                return Ok(());
            };
            let mut insns = super::asm::parse_template(text.as_bytes())
                .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
            if let Some(measured) = &measured {
                let mut here = site.and_then(|s| measured.place(s));
                for insn in &mut insns {
                    fold_a64_layout_operands(insn, key, here, measured)
                        .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
                    here = here.map(|h| h + a64_insn_placeholder_len(insn) as i64);
                }
            }
            let mut bytes: Vec<u8> = Vec::new();
            let mut relocs: Vec<super::ssa::emit_common::AsmSectionReloc> = Vec::new();
            for insn in &insns {
                if !insn.bytes.is_empty() {
                    bytes.extend_from_slice(&insn.bytes);
                    continue;
                }
                if insn.label_def.is_some() {
                    return Err(alloc::format!(
                        "inline asm: `{text}` in a section needs a relocation"
                    ));
                }
                // A branch (or `adr`) to an `asm goto` label (`b %l[k]`)
                // leaves the section for a block of the function. The word
                // carries a zero displacement; the relocation names the
                // block, rewritten to its text offset after layout.
                if let Some(&super::asm::AsmOpndA64::GotoLabel(k)) = insn.operands.last() {
                    let bid = goto_block(k).ok_or_else(|| {
                        alloc::format!(
                            "inline asm: `%l{k}` names no `asm goto` label (section `{text}`)"
                        )
                    })?;
                    let branch = build_label_branch(insn, conv)
                        .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
                    let (word, kind) = a64_label_branch_reloc(&branch)
                        .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
                    relocs.push(super::ssa::emit_common::AsmSectionReloc {
                        offset: bytes.len() as u32,
                        width: 4,
                        kind,
                        pcrel: false,
                        branch: false,
                        signed: false,
                        target: super::ssa::emit_common::AsmSectionTarget::TextBlock(bid),
                        addend: 0,
                    });
                    bytes.extend_from_slice(&word.to_le_bytes());
                    continue;
                }
                if let Some((word, kind, expr)) = encode_a64_sym_insn(insn, conv)
                    .map_err(|m| alloc::format!("{m} (section `{text}`)"))?
                {
                    // An empty expression marks a `.`-relative form resolved
                    // in place: the word is final, no relocation.
                    if !expr.is_empty() {
                        relocs.push(super::ssa::emit_common::AsmSectionReloc {
                            offset: bytes.len() as u32,
                            width: 4,
                            kind,
                            pcrel: false,
                            branch: false,
                            signed: false,
                            target: super::ssa::emit_common::AsmSectionTarget::Expr(expr),
                            addend: 0,
                        });
                    }
                    bytes.extend_from_slice(&word.to_le_bytes());
                    continue;
                }
                let mut ops: Vec<Opnd> = Vec::with_capacity(insn.operands.len());
                for o in &insn.operands {
                    ops.push(conv(o).map_err(|m| alloc::format!("{m} (section `{text}`)"))?);
                }
                let word = table::encode(&insn.mnemonic, &ops)
                    .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
                bytes.extend_from_slice(&word.to_le_bytes());
            }
            *item = AsmSectionItem::CodeBytes {
                bytes,
                relocs,
                short: None,
            };
        }
        Ok(())
    })
}

/// Visitor of [`a64_for_each_section_item_mut`]: the section identity key,
/// the item's `(block, item)` index where it has one, and the item.
type A64SectionItemFn<'a> = dyn FnMut(
        &str,
        Option<(usize, usize)>,
        &mut super::ssa::emit_common::AsmSectionItem,
    ) -> Result<(), alloc::string::String>
    + 'a;

/// Apply `f` to every item of the blocks with the identity key of the section
/// it lands in, descending into `.rept` bodies as the shared walk does. The
/// key is the section an operand expression folds against. `site` is the
/// item's `(block, item)` index, `None` inside a `.rept` body, whose items
/// the measurement walk does not place individually.
fn a64_for_each_section_item_mut(
    blocks: &mut [super::ssa::emit_common::AsmSectionBlock],
    f: &mut A64SectionItemFn<'_>,
) -> Result<(), alloc::string::String> {
    fn walk(
        key: &str,
        bi: usize,
        top: bool,
        items: &mut [super::ssa::emit_common::AsmSectionItem],
        f: &mut A64SectionItemFn<'_>,
    ) -> Result<(), alloc::string::String> {
        for (ii, it) in items.iter_mut().enumerate() {
            if let super::ssa::emit_common::AsmSectionItem::Rept { items, .. } = it {
                walk(key, bi, false, items, f)?;
            } else {
                f(key, top.then_some((bi, ii)), it)?;
            }
        }
        Ok(())
    }
    for (bi, b) in blocks.iter_mut().enumerate() {
        let key = super::ssa::emit_common::section_key(b);
        walk(&key, bi, true, &mut b.items, f)?;
    }
    Ok(())
}

/// The label layout an operand expression folds against, or `None` when no
/// operand in the blocks needs one. Each code statement measures as
/// placeholder bytes of its assembled length, which the parse gives: an A64
/// instruction is one word whatever its operands hold. Sections start at zero
/// rather than at the sink's current length, which the values this serves do
/// not depend on.
fn a64_section_operand_layout(
    blocks: &[super::ssa::emit_common::AsmSectionBlock],
) -> Result<Option<super::ssa::emit_common::SectionLabelOffsets>, alloc::string::String> {
    use super::asm::AsmOpndA64;
    use super::ssa::emit_common::AsmSectionItem;
    let mut sized = blocks.to_vec();
    let mut needs = false;
    a64_for_each_section_item_mut(&mut sized, &mut |_, _, item| {
        let AsmSectionItem::Code(text) = item else {
            return Ok(());
        };
        let insns = super::asm::parse_template(text.as_bytes())
            .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
        needs |= insns
            .iter()
            .flat_map(|i| &i.operands)
            .any(|o| matches!(o, AsmOpndA64::ImmExpr(_) | AsmOpndA64::MemExpr { .. }));
        let len = insns.iter().map(a64_insn_placeholder_len).sum();
        *item = AsmSectionItem::CodeBytes {
            bytes: alloc::vec![0u8; len],
            relocs: Vec::new(),
            short: None,
        };
        Ok(())
    })?;
    if !needs {
        return Ok(None);
    }
    super::ssa::emit_common::measure_asm_section_offsets(
        &sized,
        &|_| None,
        true,
        &super::ssa::emit_common::AsmSectionSink::default(),
    )
    .map(Some)
}

/// The bytes a parsed statement occupies before it is encoded: a label
/// definition none, an assembled A64 instruction one word, and a statement
/// the parse already resolved to bytes its own length. The operand fold
/// advances the location counter by this, as the sizing pass measures by it.
fn a64_insn_placeholder_len(i: &super::asm::AsmInsnA64) -> usize {
    match i {
        i if i.label_def.is_some() => 0,
        i if i.bytes.is_empty() => 4,
        i => i.bytes.len(),
    }
}

/// Replace each operand the section layout values with the constant it folds
/// to, so the encoder selects the form from the value as GNU as does. `here`
/// is the instruction's section offset, which its expressions read as the
/// location counter.
fn fold_a64_layout_operands(
    insn: &mut super::asm::AsmInsnA64,
    key: &str,
    here: Option<i64>,
    measured: &super::ssa::emit_common::SectionLabelOffsets,
) -> Result<(), alloc::string::String> {
    use super::asm::AsmOpndA64;
    let fold = |e: &str| super::ssa::emit_common::fold_asm_operand_expr(e, key, here, measured);
    for o in &mut insn.operands {
        let folded = match o {
            AsmOpndA64::ImmExpr(expr) => AsmOpndA64::Imm(fold(expr)?),
            AsmOpndA64::MemExpr { base, expr, pre } => AsmOpndA64::Mem {
                base: *base,
                off: fold(expr)?,
                pre: *pre,
            },
            _ => continue,
        };
        *o = folded;
    }
    Ok(())
}

/// The `movz` / `movk` word an `:abs_gN:` operand relocates, with a zero
/// immediate and the group's shift. A 32-bit destination clears the operand
/// size bit and admits only the two groups that fit its width, as GNU as
/// does.
fn a64_movw_placeholder(
    rd: u8,
    is64: bool,
    movk: bool,
    group: u8,
) -> Result<u32, alloc::string::String> {
    if !is64 && group > 1 {
        return Err(alloc::format!(
            "inline asm: `:abs_g{group}` is not allowed for a 32-bit register"
        ));
    }
    let word = if movk {
        super::encode::enc_movk(super::Reg(rd), 0, group)
    } else {
        super::encode::enc_movz(super::Reg(rd), 0, group)
    };
    Ok(if is64 { word } else { word & !(1 << 31) })
}

/// The register shape of `o` after operand-reference resolution, for the
/// helpers that select an encoding from the register class (`%0` resolves
/// to the operand's assigned register in a function body; file-scope code
/// has none and the operand is already concrete).
fn concrete_reg_shape(
    o: &super::asm::AsmOpndA64,
    conv: &dyn Fn(&super::asm::AsmOpndA64) -> Result<super::table::Opnd, alloc::string::String>,
) -> super::asm::AsmOpndA64 {
    use super::asm::AsmOpndA64 as A;
    use super::table::Opnd;
    if matches!(o, A::Ref { .. } | A::RefQ(_)) {
        match conv(o) {
            Ok(Opnd::Reg { num, is64, sp }) => return A::Reg { num, is64, sp },
            Ok(Opnd::VReg { num, is_d }) => return A::VReg { num, is_d },
            Ok(Opnd::QReg(n)) => return A::QReg(n),
            _ => {}
        }
    }
    o.clone()
}

/// Encode a section or function-body instruction that references a symbol to
/// its placeholder word plus the relocation kind and symbol expression: `b` /
/// `bl` / `b.cond` / `cbz` / `cbnz` / `tbz` / `tbnz` / `adr` to a symbol,
/// `adrp`, `add ..., :lo12:`, a load/store with a `:lo12:` immediate, and the
/// `ldr` literal form. `Ok(None)` when the instruction references no symbol.
fn encode_a64_sym_insn(
    insn: &super::asm::AsmInsnA64,
    conv: &dyn Fn(&super::asm::AsmOpndA64) -> Result<super::table::Opnd, alloc::string::String>,
) -> Result<
    Option<(
        u32,
        super::ssa::emit_common::AsmRelocKind,
        alloc::string::String,
    )>,
    alloc::string::String,
> {
    use super::asm::AsmOpndA64;
    use super::ssa::emit_common::AsmRelocKind as K;
    use super::table::Opnd;
    // `b sym` / `bl sym` carry the name on the instruction, not an operand.
    if let Some(name) = &insn.sym_target {
        if name.contains('%') {
            return Err(alloc::string::String::from(
                "inline asm: operand reference in a file-scope branch target",
            ));
        }
        let link = insn.mnemonic == "bl";
        let word = if link {
            super::encode::enc_bl(0)
        } else {
            super::encode::enc_b(0)
        };
        return Ok(Some((word, K::A64Branch26 { link }, name.clone())));
    }
    // A load/store whose immediate is `:lo12:sym`: encode with a zero
    // offset; the access size names the LDST reloc width.
    if let Some(AsmOpndA64::MemSymLo12 { base, expr }) = insn.operands.last() {
        let rt = insn.operands.first().map(|o| concrete_reg_shape(o, conv));
        let size = a64_access_size(&insn.mnemonic, rt.as_ref())?;
        let mut ops: Vec<Opnd> = Vec::with_capacity(insn.operands.len());
        for o in &insn.operands[..insn.operands.len() - 1] {
            ops.push(conv(o)?);
        }
        ops.push(conv(&AsmOpndA64::Mem {
            base: *base,
            off: 0,
            pre: false,
        })?);
        let word = super::table::encode(&insn.mnemonic, &ops)?;
        return Ok(Some((word, K::A64LdstLo12(size), expr.clone())));
    }
    // A numeric-label reference (`b 1b`) resolves at materialize time, where
    // this call's label offsets are known; carry it as a symbol reference.
    // `.`-relative branches encode directly.
    let named;
    let (name, spec) = match insn.operands.last() {
        Some(AsmOpndA64::Sym { expr, spec }) => (expr, *spec),
        Some(&AsmOpndA64::Label { num, forward }) => {
            named = alloc::format!("{num}{}", if forward { 'f' } else { 'b' });
            (&named, super::asm::SymSpec::Addr)
        }
        Some(&AsmOpndA64::Here(off)) => {
            let kind = build_label_branch(insn, conv)?;
            let word = match kind {
                LabelBranch::Adr { rd } => super::encode::enc_adr(super::Reg(rd), off),
                _ => label_branch_word(&kind, off as i64)?,
            };
            return Ok(Some((word, K::Data, alloc::string::String::new())));
        }
        _ => return Ok(None),
    };
    match spec {
        super::asm::SymSpec::Addr => {}
        super::asm::SymSpec::Lo12 => {
            // `add Rd, Rn, :lo12:sym`.
            if insn.mnemonic != "add" || insn.operands.len() != 3 {
                return Err(alloc::string::String::from(
                    "inline asm: `:lo12:` operand outside `add` or a load/store",
                ));
            }
            let (rd, rn) = match (conv(&insn.operands[0])?, conv(&insn.operands[1])?) {
                (Opnd::Reg { num: rd, .. }, Opnd::Reg { num: rn, .. }) => (rd, rn),
                _ => {
                    return Err(alloc::string::String::from(
                        "inline asm: `add :lo12:` needs register operands",
                    ));
                }
            };
            let word = super::encode::enc_add_imm(super::Reg(rd), super::Reg(rn), 0);
            return Ok(Some((word, K::A64AddLo12, name.clone())));
        }
        // `movz` / `movk` with `:abs_gN:`. The placeholder carries the
        // group's shift and a zero immediate, which is the word GNU as
        // leaves for the relocation to fill.
        super::asm::SymSpec::MovwAbs {
            group,
            signed,
            check,
        } => {
            let movk = match insn.mnemonic.as_str() {
                "movz" => false,
                "movk" => true,
                _ => {
                    return Err(alloc::string::String::from(
                        "inline asm: `:abs_g` operand outside `movz` or `movk`",
                    ));
                }
            };
            // `movk` has no `movn` counterpart, so it cannot carry a group
            // whose negative values need one.
            if movk && signed {
                return Err(alloc::string::String::from(
                    "inline asm: `:abs_g<n>_s:` is not allowed on `movk`",
                ));
            }
            let (rd, is64) = match conv(&insn.operands[0])? {
                Opnd::Reg { num, is64, .. } => (num, is64),
                _ => {
                    return Err(alloc::string::String::from(
                        "inline asm: `:abs_g` destination must be a register",
                    ));
                }
            };
            let word = a64_movw_placeholder(rd, is64, movk, group)?;
            return Ok(Some((
                word,
                K::A64MovwAbs {
                    group,
                    signed,
                    check,
                },
                name.clone(),
            )));
        }
    }
    match insn.mnemonic.as_str() {
        "adrp" => {
            let rd = match conv(&insn.operands[0])? {
                Opnd::Reg {
                    num, is64: true, ..
                } => num,
                _ => {
                    return Err(alloc::string::String::from(
                        "inline asm: `adrp` destination must be a 64-bit register",
                    ));
                }
            };
            Ok(Some((
                super::encode::enc_adrp(super::Reg(rd), 0),
                K::A64AdrpPage21,
                name.clone(),
            )))
        }
        // `ldr Rt, sym` / `ldrsw Xt, sym`: a PC-relative literal load.
        "ldr" | "ldrsw" if insn.operands.len() == 2 => {
            let rt = concrete_reg_shape(&insn.operands[0], conv);
            let (word, _) = a64_ldr_literal_word(&insn.mnemonic, &rt).ok_or_else(|| {
                alloc::string::String::from(
                    "inline asm: `ldr` literal needs a register destination",
                )
            })?;
            Ok(Some((word, K::A64LdrLit19, name.clone())))
        }
        _ => {
            // The branch shapes share the label-branch classifier.
            let kind = build_label_branch(insn, conv)?;
            let (word, k) = a64_label_branch_reloc(&kind)?;
            Ok(Some((word, k, name.clone())))
        }
    }
}

/// Placeholder word (zero displacement) and relocation kind of a branch or
/// `adr` classified by [`build_label_branch`]; the relocation fills the
/// displacement field.
fn a64_label_branch_reloc(
    kind: &LabelBranch,
) -> Result<(u32, super::ssa::emit_common::AsmRelocKind), alloc::string::String> {
    use super::ssa::emit_common::AsmRelocKind as K;
    Ok(match *kind {
        LabelBranch::B => (label_branch_word(kind, 0)?, K::A64Branch26 { link: false }),
        LabelBranch::Bl => (label_branch_word(kind, 0)?, K::A64Branch26 { link: true }),
        LabelBranch::BCond(_) | LabelBranch::Cb { .. } => {
            (label_branch_word(kind, 0)?, K::A64Condbr19)
        }
        LabelBranch::Tb { .. } => (label_branch_word(kind, 0)?, K::A64Tstbr14),
        LabelBranch::Adr { rd } => (super::encode::enc_adr(super::Reg(rd), 0), K::A64Adr21),
    })
}

/// Assign the literal pools of an asm statement's sections. Each
/// `ldr Rt, =value` takes an entry of its section's pending pool, sharing one
/// with an earlier request of the same width and value, and becomes a literal
/// load of the entry's synthetic label. `.ltorg` and the end of the section
/// deposit what has accumulated, which is where GNU as flushes.
fn assign_a64_literal_pools(
    blocks: &mut [super::ssa::emit_common::AsmSectionBlock],
) -> Result<(), alloc::string::String> {
    use super::ssa::emit_common::{AsmPoolEntry, AsmSectionItem, section_key, subsection_order};
    if !blocks
        .iter()
        .flat_map(|b| &b.items)
        .any(|it| matches!(it, AsmSectionItem::Code(t) if t.contains('=')))
    {
        return Ok(());
    }
    let order = subsection_order(blocks);
    // Where each section's last block sits in the layout order: the flush
    // point for whatever `.ltorg` left pending.
    let mut last_of: alloc::collections::BTreeMap<alloc::string::String, usize> =
        alloc::collections::BTreeMap::new();
    for (pos, &bi) in order.iter().enumerate() {
        last_of.insert(section_key(&blocks[bi]), pos);
    }
    let uniq = super::ssa::emit_common::next_asm_instance();
    let mut seq = 0u32;
    let mut pending: alloc::collections::BTreeMap<alloc::string::String, Vec<AsmPoolEntry>> =
        alloc::collections::BTreeMap::new();
    for (pos, &bi) in order.iter().enumerate() {
        let key = section_key(&blocks[bi]);
        for item in &mut blocks[bi].items {
            match item {
                AsmSectionItem::LiteralPool(entries) => {
                    *entries = pending.remove(&key).unwrap_or_default();
                }
                AsmSectionItem::Code(text) if text.contains('=') => {
                    let Some(eq) = text.find('=') else { continue };
                    let insns = super::asm::parse_template(text.as_bytes())
                        .map_err(|m| alloc::format!("{m} (section `{text}`)"))?;
                    let pool_ops = insns
                        .iter()
                        .flat_map(|i| &i.operands)
                        .filter(|o| matches!(o, super::asm::AsmOpndA64::LitPool(_)))
                        .count();
                    if pool_ops == 0 {
                        continue;
                    }
                    if insns.len() != 1 || pool_ops != 1 || insns[0].operands.len() != 2 {
                        return Err(alloc::format!(
                            "inline asm: `{text}` is not a literal-pool load"
                        ));
                    }
                    let super::asm::AsmOpndA64::LitPool(expr) = &insns[0].operands[1] else {
                        return Err(alloc::format!(
                            "inline asm: `{text}` is not a literal-pool load"
                        ));
                    };
                    let (_, size) = a64_ldr_literal_word(&insns[0].mnemonic, &insns[0].operands[0])
                        .ok_or_else(|| {
                            alloc::format!("inline asm: `{text}` has no literal-pool load form")
                        })?;
                    let value = a64_pool_value(expr, size)?;
                    let entries = pending.entry(key.clone()).or_default();
                    let label = match entries.iter().find(|e| e.size == size && e.value == value) {
                        Some(e) => e.label.clone(),
                        None => {
                            let label = alloc::format!(".Lc5_ltorg_{uniq}_{seq}");
                            seq += 1;
                            entries.push(AsmPoolEntry {
                                size,
                                label: label.clone(),
                                value,
                            });
                            label
                        }
                    };
                    text.truncate(eq);
                    text.push_str(&label);
                }
                _ => {}
            }
        }
        if last_of.get(&key) == Some(&pos)
            && let Some(entries) = pending.remove(&key)
            && !entries.is_empty()
        {
            blocks[bi].items.push(AsmSectionItem::LiteralPool(entries));
        }
    }
    Ok(())
}

/// The value a `ldr Rt, =value` deposits: a constant truncated to the entry
/// width, or a link-time address the entry relocates to. GNU as has no
/// 16-byte relocation, so only the 4- and 8-byte entries take a symbol.
fn a64_pool_value(
    expr: &str,
    size: u8,
) -> Result<super::ssa::emit_common::AsmPoolValue, alloc::string::String> {
    use super::ssa::emit_common::AsmPoolValue;
    if let Some(v) = super::ssa::emit_common::eval_const_expr_wide(expr) {
        return Ok(AsmPoolValue::Const(v));
    }
    // The pool is assigned before layout, so a value here reduces to one
    // symbol and a constant; a label difference has nothing to fold against.
    let (name, addend) = super::asm::split_sym_addend(expr)
        .and_then(super::ssa::emit_common::asm_expr_sym_addend)
        .ok_or_else(|| alloc::format!("inline asm: bad literal-pool value `{expr}`"))?;
    if size == 16 {
        return Err(alloc::format!(
            "inline asm: literal-pool symbol `{name}` needs a 4- or 8-byte load"
        ));
    }
    Ok(AsmPoolValue::Sym { name, addend })
}

/// The LDR (literal) word for a destination register view, with the number
/// of bytes the load reads. `None` for a mnemonic or operand class that has
/// no literal form.
fn a64_ldr_literal_word(mnem: &str, rt: &super::asm::AsmOpndA64) -> Option<(u32, u8)> {
    use super::asm::AsmOpndA64 as O;
    Some(match (mnem, rt) {
        (
            "ldr",
            &O::Reg {
                num, is64: false, ..
            },
        ) => (0x1800_0000 | num as u32, 4),
        (
            "ldr",
            &O::Reg {
                num, is64: true, ..
            },
        ) => (0x5800_0000 | num as u32, 8),
        (
            "ldrsw",
            &O::Reg {
                num, is64: true, ..
            },
        ) => (0x9800_0000 | num as u32, 4),
        ("ldr", &O::VReg { num, is_d: false }) => (0x1C00_0000 | num as u32, 4),
        ("ldr", &O::VReg { num, is_d: true }) => (0x5C00_0000 | num as u32, 8),
        ("ldr", &O::QReg(num)) => (0x9C00_0000 | num as u32, 16),
        _ => return None,
    })
}

/// The access size in bytes of a load/store mnemonic, from the mnemonic's
/// width suffix or the register operand's class.
fn a64_access_size(
    mnem: &str,
    rt: Option<&super::asm::AsmOpndA64>,
) -> Result<u8, alloc::string::String> {
    use super::asm::AsmOpndA64;
    Ok(match mnem {
        "ldrb" | "strb" | "ldrsb" => 1,
        "ldrh" | "strh" | "ldrsh" => 2,
        "ldrsw" => 4,
        "ldr" | "str" => match rt {
            Some(AsmOpndA64::Reg { is64, .. }) => {
                if *is64 {
                    8
                } else {
                    4
                }
            }
            Some(AsmOpndA64::VReg { is_d, .. }) => {
                if *is_d {
                    8
                } else {
                    4
                }
            }
            Some(AsmOpndA64::QReg(_)) => 16,
            _ => {
                return Err(alloc::string::String::from(
                    "inline asm: `:lo12:` load/store needs a register operand",
                ));
            }
        },
        _ => {
            return Err(alloc::format!(
                "inline asm: `:lo12:` immediate on unsupported mnemonic `{mnem}`"
            ));
        }
    })
}

#[cfg(test)]
mod asm_scratch_tests {
    use super::super::super::ir::{AsmBlock, AsmConstraint, AsmOperand, AsmSeg};
    use super::*;

    fn asm_func(template: &str) -> FunctionSsa {
        let asm = AsmBlock {
            template: template.as_bytes().to_vec(),
            operands: alloc::vec![AsmOperand {
                constraint: AsmConstraint::Reg,
                is_output: false,
                is_rw: false,
                width: 8,
                seg: AsmSeg::None,
            }],
            clobber_regs: 0,
            clobber_fp_regs: 0,
            clobber_memory: true,
            volatile: true,
        };
        FunctionSsa {
            insts: alloc::vec![
                Inst::Imm(0),
                Inst::InlineAsm {
                    asm: alloc::boxed::Box::new(asm),
                    args: alloc::vec![0],
                },
            ],
            ..Default::default()
        }
    }

    /// A no-op template reserves no frame scratch; the same statement
    /// with one instruction reserves the operand's save + capture slots.
    #[test]
    fn noop_template_needs_no_scratch() {
        assert_eq!(asm_scratch_bytes(&asm_func("")), 0);
        assert_eq!(asm_scratch_bytes(&asm_func("// note ;")), 0);
        assert!(asm_scratch_bytes(&asm_func("nop")) > 0);
    }
}

#[cfg(test)]
mod tests {
    use super::super::ssa::emit_common::AsmSectionSink;
    use super::*;
    use crate::Compiler;

    /// File-scope section instructions referencing symbols encode to the
    /// words and relocations GNU as emits (byte-verified against `as`):
    /// same-section branches, `adr`, and the literal `ldr` fold with no
    /// relocation; `adrp` / `:lo12:` / `bl ext` keep theirs.
    #[test]
    fn file_scope_a64_symbol_relocs_match_gnu_as() {
        use super::super::ssa::emit_common::{
            AsmRelocKind, AsmSectionTarget, extract_file_scope_asm_sections,
            materialize_asm_sections,
        };
        let text = ".pushsection .t,\"ax\"\nf1:\n1:\ncbz x0, 2f\nb 1b\n2:\nb.eq 1b\n\
                    tbz x0, #3, 1b\nadr x1, 2b\nldr x2, 2b\nadrp x3, ext_obj\n\
                    add x3, x3, :lo12:ext_obj\nldr x4, [x3, :lo12:ext_obj]\n\
                    ldrb w5, [x3, :lo12:ext_obj]\nbl ext_func\nret\n.popsection\n";
        let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
        encode_a64_file_asm_section_code(&mut blocks).unwrap();
        let mut sink = AsmSectionSink::default();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            true,
            &mut sink,
        )
        .unwrap();
        // GNU as words for the same input (opcodes at each instruction).
        let want_words: [u32; 12] = [
            0xb4000040, // cbz x0, 2f (+8)
            0x17ffffff, // b 1b (-4)
            0x54ffffc0, // b.eq 1b (-8)
            0x361fffa0, // tbz x0,#3,1b (-12)
            0x10ffffc1, // adr x1, 2b (-8)
            0x58ffffa2, // ldr x2, 2b (-12)
            0x90000003, // adrp x3, ext_obj
            0x91000063, // add x3, x3, :lo12:ext_obj
            0xf9400064, // ldr x4, [x3, :lo12:ext_obj]
            0x39400065, // ldrb w5, [x3, :lo12:ext_obj]
            0x94000000, // bl ext_func
            0xd65f03c0, // ret
        ];
        let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
        let sec = sink.iter().find(|s| s.name == ".t").expect("`.t` emitted");
        assert_eq!(sec.bytes, bytes);
        let kinds: Vec<(u32, AsmRelocKind, &str)> = sec
            .relocs
            .iter()
            .map(|r| {
                let AsmSectionTarget::Symbol(n) = &r.target else {
                    panic!("symbol target expected, got {:?}", r.target)
                };
                (r.offset, r.kind, n.as_str())
            })
            .collect();
        assert_eq!(
            kinds,
            vec![
                (24, AsmRelocKind::A64AdrpPage21, "ext_obj"),
                (28, AsmRelocKind::A64AddLo12, "ext_obj"),
                (32, AsmRelocKind::A64LdstLo12(8), "ext_obj"),
                (36, AsmRelocKind::A64LdstLo12(1), "ext_obj"),
                (40, AsmRelocKind::A64Branch26 { link: true }, "ext_func"),
            ]
        );
    }

    /// The SIMD forms the crypto and CRC units need encode to the words GNU as
    /// emits: the bit-select group, shift-and-insert by immediate across every
    /// arrangement, the SHA1 / SHA512 updates, register-pair load/store in the
    /// s / d / q views with all three addressing modes, and the `mov` aliases
    /// of the element insert / duplicate / extract forms.
    #[test]
    fn file_scope_a64_simd_match_gnu_as() {
        use super::super::ssa::emit_common::{
            extract_file_scope_asm_sections, materialize_asm_sections,
        };
        let text = ".pushsection .t,\"ax\"\n\
                    bsl v1.16b, v2.16b, v3.16b\n\
                    bit v1.16b, v2.16b, v3.16b\n\
                    bif v2.16b, v7.16b, v22.16b\n\
                    bsl v1.8b, v2.8b, v3.8b\n\
                    bif v5.8b, v6.8b, v11.8b\n\
                    sri v1.4s, v17.4s, #20\n\
                    sri v1.4s, v17.4s, #1\n\
                    sri v1.4s, v4.4s, #32\n\
                    sri v3.8b, v17.8b, #1\n\
                    sri v3.8b, v17.8b, #8\n\
                    sri v3.8h, v17.8h, #16\n\
                    sri v3.2d, v17.2d, #64\n\
                    sri v3.2d, v17.2d, #1\n\
                    sri v3.16b, v17.16b, #3\n\
                    sha1su0 v0.4s, v1.4s, v2.4s\n\
                    sha1su1 v0.4s, v3.4s\n\
                    sha512h q3, q6, v7.2d\n\
                    sha512h2 q3, q1, v0.2d\n\
                    sha512su0 v0.2d, v1.2d\n\
                    sha512su1 v0.2d, v2.2d, v5.2d\n\
                    ldp q0, q1, [x2]\n\
                    ldp q0, q1, [x2, #16]\n\
                    ldp q11, q12, [x3], #0x20\n\
                    ldp q16, q17, [x4, #-128]!\n\
                    ldp q18, q19, [x5, #-96]\n\
                    stp q0, q1, [x2]\n\
                    stp q6, q7, [sp, #32]\n\
                    stp q11, q12, [x3], #0x20\n\
                    stp q16, q17, [x4, #-128]!\n\
                    ldp s0, s1, [x2, #8]\n\
                    ldp d0, d1, [x2, #16]\n\
                    stp d2, d3, [x2, #-16]!\n\
                    sli v1.4s, v17.4s, #20\n\
                    sli v3.8b, v17.8b, #0\n\
                    sli v3.2d, v17.2d, #63\n\
                    sri v1.2s, v2.2s, #12\n\
                    sri v1.4h, v2.4h, #5\n\
                    mov d19, v0.d[1]\n\
                    mov s3, v7.s[2]\n\
                    mov v17.d[1], v19.d[0]\n\
                    mov v2.h[2], v5.h[0]\n\
                    mov v2.b[15], v5.b[3]\n\
                    mov v2.s[1], v5.s[3]\n\
                    ins v17.d[1], v19.d[0]\n\
                    dup d19, v0.d[1]\n\
                    mov v3.d[0], x5\n\
                    mov x5, v3.d[1]\n\
                    mov w5, v3.s[2]\n\
                    .popsection\n";
        let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
        encode_a64_file_asm_section_code(&mut blocks).unwrap();
        let mut sink = AsmSectionSink::default();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            true,
            &mut sink,
        )
        .unwrap();
        let want_words: [u32; 48] = [
            0x6e631c41, // bsl v1.16b, v2.16b, v3.16b
            0x6ea31c41, // bit v1.16b, v2.16b, v3.16b
            0x6ef61ce2, // bif v2.16b, v7.16b, v22.16b
            0x2e631c41, // bsl v1.8b, v2.8b, v3.8b
            0x2eeb1cc5, // bif v5.8b, v6.8b, v11.8b
            0x6f2c4621, // sri v1.4s, v17.4s, #20
            0x6f3f4621, // sri v1.4s, v17.4s, #1
            0x6f204481, // sri v1.4s, v4.4s, #32
            0x2f0f4623, // sri v3.8b, v17.8b, #1
            0x2f084623, // sri v3.8b, v17.8b, #8
            0x6f104623, // sri v3.8h, v17.8h, #16
            0x6f404623, // sri v3.2d, v17.2d, #64
            0x6f7f4623, // sri v3.2d, v17.2d, #1
            0x6f0d4623, // sri v3.16b, v17.16b, #3
            0x5e023020, // sha1su0 v0.4s, v1.4s, v2.4s
            0x5e281860, // sha1su1 v0.4s, v3.4s
            0xce6780c3, // sha512h q3, q6, v7.2d
            0xce608423, // sha512h2 q3, q1, v0.2d
            0xcec08020, // sha512su0 v0.2d, v1.2d
            0xce658840, // sha512su1 v0.2d, v2.2d, v5.2d
            0xad400440, // ldp q0, q1, [x2]
            0xad408440, // ldp q0, q1, [x2, #16]
            0xacc1306b, // ldp q11, q12, [x3], #0x20
            0xadfc4490, // ldp q16, q17, [x4, #-128]!
            0xad7d4cb2, // ldp q18, q19, [x5, #-96]
            0xad000440, // stp q0, q1, [x2]
            0xad011fe6, // stp q6, q7, [sp, #32]
            0xac81306b, // stp q11, q12, [x3], #0x20
            0xadbc4490, // stp q16, q17, [x4, #-128]!
            0x2d410440, // ldp s0, s1, [x2, #8]
            0x6d410440, // ldp d0, d1, [x2, #16]
            0x6dbf0c42, // stp d2, d3, [x2, #-16]!
            0x6f345621, // sli v1.4s, v17.4s, #20
            0x2f085623, // sli v3.8b, v17.8b, #0
            0x6f7f5623, // sli v3.2d, v17.2d, #63
            0x2f344441, // sri v1.2s, v2.2s, #12
            0x2f1b4441, // sri v1.4h, v2.4h, #5
            0x5e180413, // mov d19, v0.d[1]
            0x5e1404e3, // mov s3, v7.s[2]
            0x6e180671, // mov v17.d[1], v19.d[0]
            0x6e0a04a2, // mov v2.h[2], v5.h[0]
            0x6e1f1ca2, // mov v2.b[15], v5.b[3]
            0x6e0c64a2, // mov v2.s[1], v5.s[3]
            0x6e180671, // ins v17.d[1], v19.d[0]
            0x5e180413, // dup d19, v0.d[1]
            0x4e081ca3, // mov v3.d[0], x5
            0x4e183c65, // mov x5, v3.d[1]
            0x0e143c65, // mov w5, v3.s[2]
        ];
        let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
        let sec = sink.iter().find(|s| s.name == ".t").expect("`.t` emitted");
        assert_eq!(sec.bytes, bytes);
    }

    /// Lane broadcast to a vector, the SIMD bit reverse, and `uxtw`. The
    /// broadcast shares the scalar form's imm5 but takes Q from the
    /// arrangement; `rbit` is byte arrangements only; `uxtw` is the 32-bit
    /// `orr`, whose W-register write does the widening.
    #[test]
    fn file_scope_a64_dup_rbit_uxtw_match_gnu_as() {
        use super::super::ssa::emit_common::{
            extract_file_scope_asm_sections, materialize_asm_sections,
        };
        let text = ".pushsection .t,\"ax\"\n\
                    dup v12.4s, v14.s[0]\n\
                    dup v0.4s, v0.s[3]\n\
                    dup v31.2s, v31.s[1]\n\
                    dup v1.8h, v2.h[7]\n\
                    dup v1.4h, v2.h[3]\n\
                    dup v3.16b, v4.b[15]\n\
                    dup v3.8b, v4.b[0]\n\
                    dup v5.2d, v6.d[1]\n\
                    rbit v16.16b, v0.16b\n\
                    rbit v0.8b, v1.8b\n\
                    rbit v31.16b, v31.16b\n\
                    uxtw x5, w5\n\
                    uxtw x0, w1\n\
                    .popsection\n";
        let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
        encode_a64_file_asm_section_code(&mut blocks).unwrap();
        let mut sink = AsmSectionSink::default();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            true,
            &mut sink,
        )
        .unwrap();
        let want_words: [u32; 13] = [
            0x4e0405cc, // dup v12.4s, v14.s[0]
            0x4e1c0400, // dup v0.4s, v0.s[3]
            0x0e0c07ff, // dup v31.2s, v31.s[1]
            0x4e1e0441, // dup v1.8h, v2.h[7]
            0x0e0e0441, // dup v1.4h, v2.h[3]
            0x4e1f0483, // dup v3.16b, v4.b[15]
            0x0e010483, // dup v3.8b, v4.b[0]
            0x4e1804c5, // dup v5.2d, v6.d[1]
            0x6e605810, // rbit v16.16b, v0.16b
            0x2e605820, // rbit v0.8b, v1.8b
            0x6e605bff, // rbit v31.16b, v31.16b
            0x2a0503e5, // uxtw x5, w5
            0x2a0103e0, // uxtw x0, w1
        ];
        let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
        let sec = sink.iter().find(|s| s.name == ".t").expect("`.t` emitted");
        assert_eq!(sec.bytes, bytes);
    }

    /// A relocation specifier may carry GNU as's optional `#` and a constant
    /// addend. Byte- and relocation-identical to `as`: `add x1, x2, #:lo12:sym`
    /// is 0x91000041 with ADD_ABS_LO12_NC, and the addend rides the relocation
    /// rather than the immediate field.
    #[test]
    fn file_scope_a64_hash_lo12_matches_gnu_as() {
        use super::super::ssa::emit_common::{
            AsmRelocKind, AsmSectionTarget, extract_file_scope_asm_sections,
            materialize_asm_sections,
        };
        let text = ".pushsection .t,\"ax\"\n\
                    add x1, x2, #:lo12:sym\n\
                    add x1, x2, :lo12:sym\n\
                    add sp, x0, #:lo12:sym2 + 4096\n\
                    ldr x4, [x3, #:lo12:sym]\n.popsection\n";
        let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
        encode_a64_file_asm_section_code(&mut blocks).unwrap();
        let mut sink = AsmSectionSink::default();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            true,
            &mut sink,
        )
        .unwrap();
        let want_words: [u32; 4] = [0x91000041, 0x91000041, 0x9100001f, 0xf9400064];
        let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
        let sec = sink.iter().find(|s| s.name == ".t").expect("`.t` emitted");
        assert_eq!(sec.bytes, bytes);
        let kinds: Vec<(u32, AsmRelocKind, &str, i64)> = sec
            .relocs
            .iter()
            .map(|r| {
                let AsmSectionTarget::Symbol(n) = &r.target else {
                    panic!("symbol target expected, got {:?}", r.target)
                };
                (r.offset, r.kind, n.as_str(), r.addend)
            })
            .collect();
        assert_eq!(
            kinds,
            vec![
                (0, AsmRelocKind::A64AddLo12, "sym", 0),
                (4, AsmRelocKind::A64AddLo12, "sym", 0),
                (8, AsmRelocKind::A64AddLo12, "sym2", 4096),
                (12, AsmRelocKind::A64LdstLo12(8), "sym", 0),
            ]
        );
    }

    /// Materialize one file-scope section and return the sink, for the
    /// `:abs_g` cases below.
    #[cfg(test)]
    fn materialize_one_section(text: &str) -> Result<AsmSectionSink, alloc::string::String> {
        use super::super::ssa::emit_common::{
            extract_file_scope_asm_sections, materialize_asm_sections,
        };
        let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
        encode_a64_file_asm_section_code(&mut blocks)?;
        let mut sink = AsmSectionSink::default();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            true,
            &mut sink,
        )?;
        Ok(sink)
    }

    /// A bare section name is that section's start, so a `.set` over a
    /// section-local difference folds and the `:abs_g` halves resolve at
    /// assembly with no relocation -- which is what GNU as does with the
    /// kernel's `tramp_alias`. Words from `as`; the value is negative, so
    /// the signed group's `movz` becomes a `movn` over the complement.
    #[test]
    fn file_scope_a64_abs_g_over_section_symbol_matches_gnu_as() {
        let text = ".pushsection .entry.tramp.text,\"ax\"\n\
                    tramp_start:\n\
                    nop\n\
                    nop\n\
                    tramp_exit:\n\
                    nop\n\
                    .popsection\n\
                    .pushsection .t,\"ax\"\n\
                    .set .Lalias, 0x1000 + tramp_exit - .entry.tramp.text\n\
                    movz x5, :abs_g2_s:.Lalias\n\
                    movk x5, :abs_g1_nc:.Lalias\n\
                    movk x5, :abs_g0_nc:.Lalias\n\
                    .set .Lneg, -0xc0d000 + tramp_exit - .entry.tramp.text\n\
                    movz x6, :abs_g2_s:.Lneg\n\
                    movk x6, :abs_g1_nc:.Lneg\n\
                    movk x6, :abs_g0_nc:.Lneg\n\
                    .popsection\n";
        let sink = materialize_one_section(text).unwrap();
        let want_words: [u32; 6] = [
            0xd2c00005, // movz x5, #0x0, lsl #32
            0xf2a00005, // movk x5, #0x0, lsl #16
            0xf2820105, // movk x5, #0x1008
            0x92c00006, // movn x6, #0x0, lsl #32   (0x1008 - 0xc0d000 < 0)
            0xf2bfe7e6, // movk x6, #0xff3f, lsl #16
            0xf2860106, // movk x6, #0x3008
        ];
        let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
        let sec = sink.iter().find(|s| s.name == ".t").expect("`.t` emitted");
        assert_eq!(sec.bytes, bytes);
        assert!(
            sec.relocs.is_empty(),
            "a folded `:abs_g` keeps no relocation, as GNU as emits none: {:?}",
            sec.relocs
        );
    }

    /// A `:abs_g` value that does not fold relocates, one relocation per
    /// half, against the named symbol. The placeholder words carry the
    /// group's shift and a zero immediate, as GNU as leaves them.
    #[test]
    fn file_scope_a64_abs_g_over_undefined_symbol_relocates() {
        let text = ".pushsection .t,\"ax\"\n\
                    .globl ext_sym\n\
                    movz x5, :abs_g2_s:ext_sym\n\
                    movk x5, :abs_g1_nc:ext_sym\n\
                    movk x5, :abs_g0_nc:ext_sym\n\
                    movz x6, :abs_g3:ext_sym\n\
                    movz x7, :abs_g0:ext_sym\n\
                    .popsection\n";
        use super::super::ssa::emit_common::AsmRelocKind;
        let sink = materialize_one_section(text).unwrap();
        let want_words: [u32; 5] = [
            0xd2c00005, // movz x5, #0x0, lsl #32
            0xf2a00005, // movk x5, #0x0, lsl #16
            0xf2800005, // movk x5, #0x0
            0xd2e00006, // movz x6, #0x0, lsl #48
            0xd2800007, // movz x7, #0x0
        ];
        let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
        let sec = sink.iter().find(|s| s.name == ".t").expect("`.t` emitted");
        assert_eq!(sec.bytes, bytes);
        let got: Vec<(u32, AsmRelocKind)> = sec.relocs.iter().map(|r| (r.offset, r.kind)).collect();
        assert_eq!(
            got,
            vec![
                (
                    0,
                    AsmRelocKind::A64MovwAbs {
                        group: 2,
                        signed: true,
                        check: Some(48)
                    }
                ),
                (
                    4,
                    AsmRelocKind::A64MovwAbs {
                        group: 1,
                        signed: false,
                        check: None
                    }
                ),
                (
                    8,
                    AsmRelocKind::A64MovwAbs {
                        group: 0,
                        signed: false,
                        check: None
                    }
                ),
                (
                    12,
                    AsmRelocKind::A64MovwAbs {
                        group: 3,
                        signed: false,
                        check: None
                    }
                ),
                (
                    16,
                    AsmRelocKind::A64MovwAbs {
                        group: 0,
                        signed: false,
                        check: Some(16)
                    }
                ),
            ]
        );
    }

    /// The checked groups reject a folded value outside the width the
    /// specifier names, and the no-check groups truncate. Boundaries and
    /// messages follow GNU as: `:abs_g0_s:` admits [-0x8000, 0x8000),
    /// `:abs_g0:` admits [0, 0x10000).
    #[test]
    fn file_scope_a64_abs_g_range_matches_gnu_as() {
        let one = |insn: &str| {
            materialize_one_section(&alloc::format!(
                ".pushsection .t,\"ax\"\n{insn}\n.popsection\n"
            ))
            .map(|s| {
                let sec = s.iter().find(|s| s.name == ".t").expect("`.t` emitted");
                u32::from_le_bytes(sec.bytes[..4].try_into().unwrap())
            })
        };
        // Signed group: the last value in range each way, and the first out.
        assert_eq!(one("movz x5, :abs_g0_s:0x7fff").unwrap(), 0xd28fffe5);
        assert_eq!(one("movz x5, :abs_g0_s:-0x8000").unwrap(), 0x928fffe5);
        assert!(
            one("movz x5, :abs_g0_s:0x8000")
                .unwrap_err()
                .contains("signed value out of range")
        );
        assert!(
            one("movz x5, :abs_g0_s:-0x8001")
                .unwrap_err()
                .contains("signed value out of range")
        );
        // The `_s` groups reach the top of a 48-bit signed value.
        assert_eq!(
            one("movz x5, :abs_g2_s:0x7fffffffffff").unwrap(),
            0xd2cfffe5
        );
        assert!(
            one("movz x5, :abs_g2_s:0x800000000000")
                .unwrap_err()
                .contains("signed value out of range")
        );
        // Unsigned checked group: no negative value, and no value past 2^16.
        assert_eq!(one("movz x5, :abs_g0:0xffff").unwrap(), 0xd29fffe5);
        assert!(
            one("movz x5, :abs_g0:0x10000")
                .unwrap_err()
                .contains("unsigned value out of range")
        );
        assert!(
            one("movz x5, :abs_g0:-1")
                .unwrap_err()
                .contains("unsigned value out of range")
        );
        // No-check groups truncate rather than reject, and keep `movz`
        // for a negative value -- only the signed groups take `movn`.
        assert_eq!(one("movz x5, :abs_g0_nc:0x10000").unwrap(), 0xd2800005);
        assert_eq!(one("movz x5, :abs_g0_nc:-1").unwrap(), 0xd29fffe5);
        assert_eq!(one("movz x5, :abs_g1_nc:0x123456789").unwrap(), 0xd2a468a5);
        assert_eq!(one("movz x5, :abs_g3:-1").unwrap(), 0xd2ffffe5);
    }

    /// A 32-bit destination clears the operand size bit and admits only
    /// the two groups that fit its width; GNU as rejects the rest for a
    /// `w` register. Words from `as`.
    #[test]
    fn file_scope_a64_abs_g_32bit_register_matches_gnu_as() {
        let one = |insn: &str| {
            materialize_one_section(&alloc::format!(
                ".pushsection .t,\"ax\"\n{insn}\n.popsection\n"
            ))
            .map(|s| {
                let sec = s.iter().find(|s| s.name == ".t").expect("`.t` emitted");
                u32::from_le_bytes(sec.bytes[..4].try_into().unwrap())
            })
        };
        assert_eq!(one("movz w6, :abs_g0_nc:0x5a827999").unwrap(), 0x528f3326);
        assert_eq!(one("movz w6, :abs_g1_nc:0x5a827999").unwrap(), 0x52ab5046);
        assert_eq!(one("movk w6, :abs_g0_nc:0x5a827999").unwrap(), 0x728f3326);
        assert_eq!(one("movk w6, :abs_g1_nc:0x5a827999").unwrap(), 0x72ab5046);
        // A negative signed group takes `movn` at either width.
        assert_eq!(one("movz w6, :abs_g0_s:-0x1234").unwrap(), 0x12824666);
        assert_eq!(one("movz x6, :abs_g0_s:-0x1234").unwrap(), 0x92824666);
        // Groups past the register's width have no encoding.
        for bad in ["movz w6, :abs_g2_nc:0x1", "movz w6, :abs_g3:0x1"] {
            assert!(
                one(bad)
                    .unwrap_err()
                    .contains("is not allowed for a 32-bit register"),
                "{bad}: {:?}",
                one(bad)
            );
        }
    }

    /// GNU as defines `_s` only on `movz` (a `movk` has no `movn` form to
    /// carry a negative value) and defines no `:abs_g3_s:` / `:abs_g3_nc:`
    /// / `:abs_g0_s_nc:` spelling.
    #[test]
    fn file_scope_a64_abs_g_rejects_what_gnu_as_rejects() {
        let one = |insn: &str| {
            materialize_one_section(&alloc::format!(
                ".pushsection .t,\"ax\"\n{insn}\n.popsection\n"
            ))
            .err()
            .unwrap_or_default()
        };
        assert!(one("movk x5, :abs_g0_s:sym").contains("not allowed on `movk`"));
        for bad in [
            "movz x5, :abs_g3_s:sym",
            "movz x5, :abs_g3_nc:sym",
            "movz x5, :abs_g0_s_nc:sym",
            "movz x5, :abs_g4:sym",
        ] {
            assert!(
                one(bad).contains("unknown relocation modifier"),
                "{bad}: {}",
                one(bad)
            );
        }
        assert!(one("add x5, x5, :abs_g0:sym").contains("outside `movz` or `movk`"));
    }

    /// An immediate or a memory offset written as a label difference is an
    /// absolute value the section layout supplies, and on A64 the value
    /// selects the encoding: `prfm` takes the scaled form only for a
    /// multiple of the access size and `prfum` otherwise, `ldr` likewise
    /// becomes `ldur`, and `mov` of a negative value becomes `movn`. Words
    /// from `as`, which emits no relocation for any of them. This is the
    /// kernel's vector-entry sequence in `arch/arm64/kernel/entry.S`.
    #[test]
    fn file_scope_a64_label_difference_operand_matches_gnu_as() {
        let text = ".pushsection .t,\"ax\"\n\
                    vs:\n\
                    nop\n\
                    1:\n\
                    prfm plil1strm, [x30, #(1b - vs)]\n\
                    add x30, x30, #(1b - vs + 4)\n\
                    ldr x0, [x30, #(1b - vs)]\n\
                    mov x0, #(2f - 1b)\n\
                    mov x1, #(vs - 2f)\n\
                    prfm plil1strm, [x30, #(2f - vs)]\n\
                    prfum plil1strm, [x30, #4]\n\
                    sub sp, sp, #(2f - vs)\n\
                    prfm plil1strm, [x30, #(2f - vs + 4)]\n\
                    2:\n\
                    nop\n\
                    .popsection\n";
        let sink = materialize_one_section(text).unwrap();
        let want_words: [u32; 11] = [
            0xd503201f, // nop
            0xf88043c9, // prfum plil1strm, [x30, #4]
            0x910023de, // add   x30, x30, #0x8
            0xf84043c0, // ldur  x0, [x30, #4]
            0xd2800480, // mov   x0, #0x24
            0x928004e1, // mov   x1, #-0x28
            0xf98017c9, // prfm  plil1strm, [x30, #40]
            0xf88043c9, // prfum plil1strm, [x30, #4]
            0xd100a3ff, // sub   sp, sp, #0x28
            0xf882c3c9, // prfum plil1strm, [x30, #44]
            0xd503201f, // nop
        ];
        let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
        let sec = sink.iter().find(|s| s.name == ".t").expect("`.t` emitted");
        assert_eq!(sec.bytes, bytes);
        assert!(
            sec.relocs.is_empty(),
            "a folded operand keeps no relocation: {:?}",
            sec.relocs
        );
    }

    /// An operand expression must reduce to an absolute value, as GNU as
    /// requires: an undefined symbol or a difference across sections has no
    /// relocation to carry it.
    #[test]
    fn file_scope_a64_operand_expression_rejects_what_gnu_as_rejects() {
        let one = |body: &str| {
            materialize_one_section(&alloc::format!(
                ".pushsection .t,\"ax\"\nvs:\nnop\n{body}\n.popsection\n"
            ))
            .err()
            .unwrap_or_default()
        };
        for bad in [
            "add x0, x0, #(ext_sym - vs)",
            "ldr x0, [x1, #(ext_sym - vs)]",
        ] {
            assert!(
                one(bad).contains("is not an absolute value in an instruction operand"),
                "{bad}: {}",
                one(bad)
            );
        }
    }

    /// The location counter in an instruction operand is the offset the
    /// instruction itself is placed at, and the fold precedes encoding, so
    /// the value still selects the form: `ldr` becomes `ldur` for an offset
    /// that is not a multiple of the access size, `prfm` stays scaled for one
    /// that is, and `mov` of a negative value becomes `movn`. Words from
    /// `as`, which emits no relocation for any of them. Each section carries
    /// its own counter.
    #[test]
    fn file_scope_a64_location_counter_operand_matches_gnu_as() {
        let text = ".pushsection .t,\"ax\"\n\
                    1:\n\
                    nop\n\
                    ldr x0, [x30, #(. - 1b)]\n\
                    add x0, x0, #(. - 1b)\n\
                    add x1, x1, #(2f - .)\n\
                    nop\n\
                    2:\n\
                    prfm plil1strm, [x30, #(. - 1b)]\n\
                    mov x7, #(1b - .)\n\
                    .set k, . - 1b\n\
                    add x4, x4, #k\n\
                    prfm plil1strm, [x30, #(. - 1b)]\n\
                    .popsection\n\
                    .pushsection .u,\"ax\"\n\
                    3:\n\
                    nop\n\
                    add x8, x8, #(. - 3b)\n\
                    .popsection\n";
        let sink = materialize_one_section(text).unwrap();
        let want_t: [u32; 9] = [
            0xd503201f, // nop
            0xf84043c0, // ldur  x0, [x30, #4]
            0x91002000, // add   x0, x0, #0x8
            0x91002021, // add   x1, x1, #0x8
            0xd503201f, // nop
            0xf88143c9, // prfum plil1strm, [x30, #20]
            0x928002e7, // mov   x7, #-0x18
            0x91007084, // add   x4, x4, #0x1c
            0xf98013c9, // prfm  plil1strm, [x30, #32]
        ];
        let want_u: [u32; 2] = [
            0xd503201f, // nop
            0x91001108, // add   x8, x8, #0x4
        ];
        for (name, want) in [(".t", &want_t[..]), (".u", &want_u[..])] {
            let bytes: Vec<u8> = want.iter().flat_map(|w| w.to_le_bytes()).collect();
            let sec = sink.iter().find(|s| s.name == name).expect("section");
            assert_eq!(sec.bytes, bytes, "{name}");
            assert!(sec.relocs.is_empty(), "{name}: {:?}", sec.relocs);
        }
    }

    /// A `.rept` whose count is a label difference defers to the section
    /// layer with its body held once, so a statement inside it stands at one
    /// offset per repetition and the counter has no single value. A label
    /// difference there is still constant and folds.
    #[test]
    fn file_scope_a64_location_counter_in_a_deferred_rept_is_rejected() {
        let body = |op: &str| {
            alloc::format!(
                ".pushsection .t,\"ax\"\n1:\nnop\nnop\n2:\nnop\n\
                 .rept (2b - 1b) / 4\n{op}\n.endr\n.popsection\n"
            )
        };
        let err = materialize_one_section(&body("add x0, x0, #(. - 1b)"))
            .err()
            .unwrap_or_default();
        assert!(
            err.contains("location counter `.` is not available here"),
            "{err}"
        );
        let sink = materialize_one_section(&body("add x0, x0, #(2b - 1b)")).unwrap();
        let want: [u32; 5] = [
            0xd503201f, 0xd503201f, 0xd503201f, //
            0x91002000, // add x0, x0, #0x8
            0x91002000,
        ];
        let bytes: Vec<u8> = want.iter().flat_map(|w| w.to_le_bytes()).collect();
        let sec = sink.iter().find(|s| s.name == ".t").expect("`.t` emitted");
        assert_eq!(sec.bytes, bytes);
    }

    /// The add/sub immediate field is unsigned, so GNU as encodes a negative
    /// immediate as the opposite operation on the negated value, `lsl #12`
    /// included. The scalar 64-bit `add` / `sub` and `sha1h` are covered here
    /// too; all match `as` byte for byte.
    #[test]
    fn file_scope_a64_negative_addsub_imm_matches_gnu_as() {
        use super::super::ssa::emit_common::{
            extract_file_scope_asm_sections, materialize_asm_sections,
        };
        let text = ".pushsection .t,\"ax\"\n\
                    cmp w4, #48 - (4 << 4)\n\
                    cmp x0, #-16\n\
                    cmn x0, #16\n\
                    add x1, x2, #-16\n\
                    sub x1, x2, #-16\n\
                    adds x1, x2, #-16\n\
                    subs x1, x2, #-16\n\
                    cmp w4, #-4096\n\
                    add x1, x2, #-4096\n\
                    sha1h s14, s12\n\
                    add d7, d7, d16\n\
                    sub d7, d7, d16\n\
                    .popsection\n";
        let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
        encode_a64_file_asm_section_code(&mut blocks).unwrap();
        let mut sink = AsmSectionSink::default();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            true,
            &mut sink,
        )
        .unwrap();
        let want_words: [u32; 12] = [
            0x3100409f, // cmp w4, #48 - (4 << 4)
            0xb100401f, // cmp x0, #-16
            0xb100401f, // cmn x0, #16
            0xd1004041, // add x1, x2, #-16
            0x91004041, // sub x1, x2, #-16
            0xf1004041, // adds x1, x2, #-16
            0xb1004041, // subs x1, x2, #-16
            0x3140049f, // cmp w4, #-4096
            0xd1400441, // add x1, x2, #-4096
            0x5e28098e, // sha1h s14, s12
            0x5ef084e7, // add d7, d7, d16
            0x7ef084e7, // sub d7, d7, d16
        ];
        let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
        let sec = sink.iter().find(|s| s.name == ".t").expect("`.t` emitted");
        assert_eq!(sec.bytes, bytes);
    }

    /// The memory copy / set family (FEAT_MOPS) encodes to the words GNU as
    /// emits. The cases cover both operand shapes, all three stages, and the
    /// read/write option suffixes, with the registers varied so the
    /// destination / size / source fields are each pinned.
    #[test]
    fn file_scope_a64_mops_match_gnu_as() {
        use super::super::ssa::emit_common::{
            extract_file_scope_asm_sections, materialize_asm_sections,
        };
        let text = ".pushsection .t,\"ax\"\n\
                    cpyfp [x1]!, [x2]!, x3!\n\
                    cpyfprt [x4]!, [x8]!, x16!\n\
                    cpyfpwn [x5]!, [x10]!, x20!\n\
                    cpyfptn [x30]!, [x29]!, x28!\n\
                    cpyp [x0]!, [x1]!, x2!\n\
                    cpym [x1]!, [x2]!, x3!\n\
                    cpye [x4]!, [x8]!, x16!\n\
                    cpypwn [x5]!, [x10]!, x20!\n\
                    cpyfprtwn [x30]!, [x29]!, x28!\n\
                    setp [x0]!, x1!, x2\n\
                    setpt [x1]!, x2!, x3\n\
                    setpn [x4]!, x8!, x16\n\
                    setptn [x5]!, x10!, x20\n\
                    setm [x30]!, x29!, x28\n\
                    sete [x0]!, x1!, x2\n\
                    seten [x1]!, x2!, x3\n\
                    setpn [x0]!, x1!, xzr\n.popsection\n";
        let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
        encode_a64_file_asm_section_code(&mut blocks).unwrap();
        let mut sink = AsmSectionSink::default();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            true,
            &mut sink,
        )
        .unwrap();
        let want_words: [u32; 17] = [
            0x19020461, // cpyfp [x1]!, [x2]!, x3!
            0x19082604, // cpyfprt [x4]!, [x8]!, x16!
            0x190a4685, // cpyfpwn [x5]!, [x10]!, x20!
            0x191df79e, // cpyfptn [x30]!, [x29]!, x28!
            0x1d010440, // cpyp [x0]!, [x1]!, x2!
            0x1d420461, // cpym [x1]!, [x2]!, x3!
            0x1d880604, // cpye [x4]!, [x8]!, x16!
            0x1d0a4685, // cpypwn [x5]!, [x10]!, x20!
            0x191d679e, // cpyfprtwn [x30]!, [x29]!, x28!
            0x19c20420, // setp [x0]!, x1!, x2
            0x19c31441, // setpt [x1]!, x2!, x3
            0x19d02504, // setpn [x4]!, x8!, x16
            0x19d43545, // setptn [x5]!, x10!, x20
            0x19dc47be, // setm [x30]!, x29!, x28
            0x19c28420, // sete [x0]!, x1!, x2
            0x19c3a441, // seten [x1]!, x2!, x3
            0x19df2420, // setpn [x0]!, x1!, xzr
        ];
        let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
        let sec = sink.iter().find(|s| s.name == ".t").expect("`.t` emitted");
        assert_eq!(sec.bytes, bytes);
    }

    /// The flow-form ALTERNATIVE at file scope: `.subsection 1` holds the
    /// replacement, `.previous` returns, the `.org` pair equalizes the
    /// lengths, and a `.rept` count over labels of the main subsection
    /// resolves at layout. Bytes match GNU as for the same input: the main
    /// stream first, the subsection-1 content appended after.
    #[test]
    fn file_scope_a64_subsection_org_rept_match_gnu_as() {
        use super::super::ssa::emit_common::{
            AsmComments, extract_file_scope_asm_sections, materialize_asm_sections,
            prepare_file_asm_text,
        };
        let text = ".text\nf:\n661:\nnop\nnop\n662:\n.subsection 1\n663:\nmov x1, #2\nmov x2, #3\n\
                    664:\n.previous\n.org . - (664b-663b) + (662b-661b)\n\
                    .org . - (662b-661b) + (664b-663b)\n\
                    661:\nnop\n662:\n.subsection 1\n663:\n.rept (662b-661b) / 4\nnop\n.endr\n664:\n\
                    .previous\n.org . - (664b-663b) + (662b-661b)\n\
                    .org . - (662b-661b) + (664b-663b)\nret\n";
        let text = prepare_file_asm_text(text, AsmComments::A64).unwrap();
        let mut blocks = extract_file_scope_asm_sections(&text, true).unwrap();
        encode_a64_file_asm_section_code(&mut blocks).unwrap();
        let mut sink = AsmSectionSink::default();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            true,
            &mut sink,
        )
        .unwrap();
        let want: Vec<u8> = [
            0xd503201fu32, // nop (661 first instance)
            0xd503201f,    // nop
            0xd503201f,    // nop (second instance)
            0xd65f03c0,    // ret
            0xd2800041,    // mov x1, #2 (subsection 1)
            0xd2800062,    // mov x2, #3
            0xd503201f,    // rept'd nop
        ]
        .iter()
        .flat_map(|w| w.to_le_bytes())
        .collect();
        assert_eq!(sink[0].bytes, want);
    }

    /// Materialize one file-scope asm text and return the named section.
    fn a64_file_asm_section(text: &str, name: &str) -> super::super::ssa::emit_common::AsmSection {
        a64_file_asm_sink(text)
            .iter()
            .find(|s| s.name == name)
            .expect("section emitted")
            .clone()
    }

    /// Expand, extract, encode and materialize one file-scope asm text.
    fn a64_file_asm_sink_result(text: &str) -> Result<AsmSectionSink, alloc::string::String> {
        use super::super::ssa::emit_common::{
            AsmComments, extract_file_scope_asm_sections, materialize_asm_sections,
            prepare_file_asm_text,
        };
        let text = prepare_file_asm_text(text, AsmComments::A64)?;
        let mut blocks = extract_file_scope_asm_sections(&text, true)?;
        encode_a64_file_asm_section_code(&mut blocks)?;
        let mut sink = AsmSectionSink::default();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            true,
            &mut sink,
        )?;
        Ok(sink)
    }

    fn a64_file_asm_sink(text: &str) -> AsmSectionSink {
        a64_file_asm_sink_result(text).expect("materializes")
    }

    /// A `.if` over a label difference guarding a `.error` is valued after
    /// layout: the branches emit no bytes, so the layout cannot depend on the
    /// outcome. Bytes are GNU as's for the same input, which reads the same
    /// difference at the `.if`. Covers both spellings the kernel vector
    /// tables use -- numeric labels through macro parameters, and `\@`-unique
    /// labels -- and an `.else` arm.
    #[test]
    fn file_scope_a64_deferred_if_matches_gnu_as() {
        let text = ".macro check_preamble_length start, end\n\
                    .if ((\\end-\\start) != (2 * 4))\n\
                    .error \"vector preamble length mismatch\"\n\
                    .endif\n.endm\n\
                    .macro valid_vect target\n.align 4\n661:\nnop\n\
                    stp x0, x1, [sp, #-16]!\n662:\nb \\target\n\
                    check_preamble_length 661b, 662b\n.endm\n\
                    .macro sized_vect\n.align 4\n.L__vect_start\\@:\n\
                    mrs x0, esr_el2\nret\n.L__vect_end\\@:\n\
                    .if ((.L__vect_end\\@ - .L__vect_start\\@) > 0x10)\n\
                    .error \"vector larger than its entry\"\n.endif\n\
                    .if ((.L__vect_end\\@ - .L__vect_start\\@) > 0x4)\n.else\n\
                    .error \"vector shorter than one instruction\"\n.endif\n.endm\n\
                    .text\n.globl v\nv:\nvalid_vect el1_sync\nvalid_vect el1_irq\n\
                    sized_vect\nsized_vect\nel1_sync:\nel1_irq:\nret\n";
        let want: Vec<u8> = [
            0xd503201fu32, // nop
            0xa9bf07e0,    // stp x0, x1, [sp, #-16]!
            0x1400000c,    // b el1_sync
            0xd503201f,    // .align 4 padding
            0xd503201f,    // nop
            0xa9bf07e0,    // stp x0, x1, [sp, #-16]!
            0x14000008,    // b el1_irq
            0xd503201f,    // .align 4 padding
            0xd53c5200,    // mrs x0, esr_el2
            0xd65f03c0,    // ret
            0xd503201f,    // .align 4 padding
            0xd503201f,
            0xd53c5200, // mrs x0, esr_el2
            0xd65f03c0, // ret
            0xd65f03c0, // ret
        ]
        .iter()
        .flat_map(|w| w.to_le_bytes())
        .collect();
        let sec = a64_file_asm_section(text, ".text");
        assert_eq!(sec.bytes, want);
        assert_eq!(sec.align, 16);
    }

    /// The same guard reports when the region it measures is the wrong size,
    /// with the `.error`'s own message.
    #[test]
    fn file_scope_a64_deferred_if_reports_a_failed_guard() {
        let text = ".macro check_preamble_length start, end\n\
                    .if ((\\end-\\start) != (2 * 4))\n\
                    .error \"vector preamble length mismatch\"\n\
                    .endif\n.endm\n\
                    .text\nv:\n661:\nnop\nnop\nnop\n662:\n\
                    check_preamble_length 661b, 662b\n";
        let err = a64_file_asm_sink_result(text).expect_err("guard reports");
        assert!(
            err.contains("`.error` vector preamble length mismatch"),
            "{err}"
        );
    }

    /// A branch, `adr`, `adrp` or `:lo12:` operand is an expression over
    /// symbols, not only a symbol with a constant addend: a label difference
    /// in the addend folds against the layout and the symbol keeps the
    /// relocation. The KVM hypervisor entry branches to a vector slot that
    /// way. Words and relocations measured with GNU as 2.46.1 for the same
    /// source.
    #[test]
    fn file_scope_a64_operand_symbol_expressions_match_gnu_as() {
        let text = ".text\n1:\nnop\nnop\n2:\nb __kvm_hyp_vector + (2b - 1b + (2 * 4))\n\
                    adr x0, sym + (2b - 1b)\nadrp x1, sym + (2b - 1b)\n\
                    add x1, x1, :lo12:(sym + (2b - 1b))\ncbz x2, sym + (2b - 1b)\n";
        let sec = a64_file_asm_section(text, ".text");
        let want: Vec<u8> = [
            0xd503201fu32, // nop
            0xd503201f,    // nop
            0x14000000,    // b __kvm_hyp_vector + 16
            0x10000000,    // adr x0, sym + 8
            0x90000001,    // adrp x1, sym + 8
            0x91000021,    // add x1, x1, :lo12:sym + 8
            0xb4000002,    // cbz x2, sym + 8
        ]
        .iter()
        .flat_map(|w| w.to_le_bytes())
        .collect();
        assert_eq!(sec.bytes, want);
        let relocs: Vec<_> = sec
            .relocs
            .iter()
            .map(|r| (r.offset, alloc::format!("{:?}", r.target), r.addend))
            .collect();
        let at = |n: &str| alloc::format!("Symbol(\"{n}\")");
        assert_eq!(
            relocs,
            [
                (8, at("__kvm_hyp_vector"), 16),
                (12, at("sym"), 8),
                (16, at("sym"), 8),
                (20, at("sym"), 8),
                (24, at("sym"), 8),
            ]
        );
    }

    /// A `.rept` count and a `.fill` count are expressions over the layout,
    /// the location counter included. Bytes measured with GNU as 2.46.1.
    #[test]
    fn file_scope_a64_counts_over_the_layout_match_gnu_as() {
        let text = ".text\na:\nnop\nnop\nb:\n.rept (b - a) / 4\nnop\n.endr\n\
                    .fill b + 20 - ., 1, 0xcc\n";
        let sec = a64_file_asm_section(text, ".text");
        let mut want: Vec<u8> = alloc::vec![];
        for _ in 0..4 {
            want.extend_from_slice(&0xd503201fu32.to_le_bytes());
        }
        want.extend_from_slice(&[0xcc; 12]);
        assert_eq!(sec.bytes, want);
    }

    /// A deferred condition the layout still cannot value is reported rather
    /// than guessed: a difference of labels in two sections is no distance.
    #[test]
    fn file_scope_a64_deferred_if_rejects_a_cross_section_difference() {
        let text = ".text\na:\nnop\n.section .other,\"ax\",@progbits\nb:\nnop\n.text\n\
                    .if ((b - a) != 4)\n.error \"mismatch\"\n.endif\n";
        let err = a64_file_asm_sink_result(text).expect_err("condition is not constant");
        assert!(err.contains("non-constant `.if` condition"), "{err}");
    }

    /// `ldr Rt, =value` deposits the value in the section's literal pool.
    /// The bytes are GNU as's for the same input: `.ltorg` flushes what has
    /// accumulated, identical requests share an entry, the entries land in
    /// width-ascending groups each aligned to its own width, a symbol entry
    /// takes an `R_AARCH64_ABS64`, and what no `.ltorg` flushed is deposited
    /// at the end of the section.
    #[test]
    fn file_scope_a64_literal_pool_matches_gnu_as() {
        use super::super::ssa::emit_common::{AsmRelocKind, AsmSectionTarget};
        let text = ".text\n.globl f\nf:\n\
                    ldr x0, =some_sym\n\
                    ldr w1, =0x12345678\n\
                    ldr x2, =some_sym\n\
                    ldr x3, =0x1122334455667788\n\
                    ldr w4, =0x12345678\n\
                    ldr x5, =other_sym + 8\n\
                    .ltorg\nret\n.globl g\ng:\nldr x6, =tail_sym\nret\n";
        let sec = a64_file_asm_section(text, ".text");
        let want: Vec<u8> = [
            0x58000100u32, // ldr x0, 20   (some_sym)
            0x180000a1,    // ldr w1, 18   (0x12345678)
            0x580000c2,    // ldr x2, 20   (shares the some_sym entry)
            0x580000e3,    // ldr x3, 28
            0x18000044,    // ldr w4, 18   (shares the 0x12345678 entry)
            0x580000e5,    // ldr x5, 30
            0x12345678,    // pool: the 4-byte group first
            0x00000000,    // padding to the 8-byte group
            0x00000000,    // some_sym (ABS64)
            0x00000000,
            0x55667788, // 0x1122334455667788
            0x11223344,
            0x00000000, // other_sym + 8 (ABS64)
            0x00000000,
            0xd65f03c0, // ret
            0x58000066, // ldr x6, 48
            0xd65f03c0, // ret
            0x00000000, // end-of-section pool: padding
            0x00000000, // tail_sym (ABS64)
            0x00000000,
        ]
        .iter()
        .flat_map(|w| w.to_le_bytes())
        .collect();
        assert_eq!(sec.bytes, want);
        assert_eq!(sec.align, 8);
        let relocs: Vec<_> = sec
            .relocs
            .iter()
            .map(|r| {
                (
                    r.offset,
                    r.width,
                    r.kind,
                    r.pcrel,
                    r.target.clone(),
                    r.addend,
                )
            })
            .collect();
        let sym = |n: &str| AsmSectionTarget::Symbol(alloc::string::String::from(n));
        assert_eq!(
            relocs,
            alloc::vec![
                (0x20, 8, AsmRelocKind::Data, false, sym("some_sym"), 0),
                (0x30, 8, AsmRelocKind::Data, false, sym("other_sym"), 8),
                (0x48, 8, AsmRelocKind::Data, false, sym("tail_sym"), 0),
            ]
        );
    }

    /// A pool entry is shared by width and value, not by register class: the
    /// `d`/`x` and `s`/`w` requests of one value take one entry each, and a
    /// symbol addend distinguishes entries. Bytes are GNU as's.
    #[test]
    fn file_scope_a64_literal_pool_widths_match_gnu_as() {
        let text = ".text\n.globl h\nh:\n\
                    ldr d2, =0x1111111122222222\n\
                    ldr x3, =0x1111111122222222\n\
                    ldr s4, =0x33445566\n\
                    ldr w5, =0x33445566\n\
                    .ltorg\n.globl i\ni:\n\
                    ldr x6, =sym_c\nldr x7, =sym_c+0\nldr x8, =sym_c+4\n\
                    .ltorg\n.globl j\nj:\n.ltorg\nnop\n";
        let sec = a64_file_asm_section(text, ".text");
        let want: Vec<u8> = [
            0x5c0000c2u32, // ldr d2, 14
            0x580000a3,    // ldr x3, 14 (shares the d2 entry)
            0x1c000044,    // ldr s4, 10
            0x18000025,    // ldr w5, 10 (shares the s4 entry)
            0x33445566,    // pool: 4-byte group
            0x00000000,    // padding to the 8-byte group
            0x22222222,    // 0x1111111122222222
            0x11111111,
            0x58000086, // ldr x6, 30
            0x58000067, // ldr x7, 30 (shares the sym_c entry)
            0x58000088, // ldr x8, 38
            0x00000000, // padding
            0x00000000, // sym_c (ABS64)
            0x00000000,
            0x00000000, // sym_c + 4 (ABS64)
            0x00000000,
            0xd503201f, // nop; the empty `.ltorg` deposits nothing
        ]
        .iter()
        .flat_map(|w| w.to_le_bytes())
        .collect();
        assert_eq!(sec.bytes, want);
        let relocs: Vec<_> = sec.relocs.iter().map(|r| (r.offset, r.addend)).collect();
        assert_eq!(relocs, alloc::vec![(0x30, 0), (0x38, 4)]);
    }

    /// A pool of one width raises the section's alignment to that width and
    /// pads to it: GNU as gives the 4-, 8- and 16-byte cases alignment 4, 8
    /// and 16, and a `q` entry zero-extends its 64-bit value.
    #[test]
    fn file_scope_a64_literal_pool_alignment_matches_gnu_as() {
        for (reg, value, align, want) in [
            (
                "w0",
                "0x11223344",
                4u32,
                alloc::vec![0x18000020u32, 0x11223344],
            ),
            (
                "x0",
                "0x1122334455667788",
                8,
                alloc::vec![0x58000040, 0x00000000, 0x55667788, 0x11223344],
            ),
            (
                "q0",
                "0x1122334455667788",
                16,
                alloc::vec![
                    0x9c000080, 0x00000000, 0x00000000, 0x00000000, 0x55667788, 0x11223344,
                    0x00000000, 0x00000000,
                ],
            ),
        ] {
            let text =
                alloc::format!(".section .p,\"ax\",@progbits\nldr {reg}, ={value}\n.ltorg\n");
            let sec = a64_file_asm_section(&text, ".p");
            let bytes: Vec<u8> = want.iter().flat_map(|w| w.to_le_bytes()).collect();
            assert_eq!(sec.bytes, bytes, "{reg}");
            assert_eq!(sec.align, align, "{reg}");
        }
    }

    /// Every LDR (literal) destination view encodes as GNU as does, with the
    /// same-section target folded into the 19-bit displacement.
    #[test]
    fn file_scope_a64_ldr_literal_views_match_gnu_as() {
        let text = ".section .lit,\"ax\",@progbits\nlit0:\n.word 1\n\
                    ldr w0, lit0\nldr x1, lit0\nldr s2, lit0\nldr d3, lit0\n\
                    ldr q4, lit0\nldrsw x5, lit0\n";
        let sec = a64_file_asm_section(text, ".lit");
        let want: Vec<u8> = [
            0x00000001u32, // .word 1
            0x18ffffe0,    // ldr w0, lit0
            0x58ffffc1,    // ldr x1, lit0
            0x1cffffa2,    // ldr s2, lit0
            0x5cffff83,    // ldr d3, lit0
            0x9cffff64,    // ldr q4, lit0
            0x98ffff45,    // ldrsw x5, lit0
        ]
        .iter()
        .flat_map(|w| w.to_le_bytes())
        .collect();
        assert_eq!(sec.bytes, want);
        assert!(sec.relocs.is_empty(), "same-section literal needs no reloc");
    }

    fn lift_and_alloc(src: &str, target: Target) -> (crate::c5::ir::FunctionSsa, Allocation) {
        let program = Compiler::new(src.into()).compile().expect("compile");
        let funcs =
            crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target, false, true)
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
        let mut asm_sections = AsmSectionSink::default();
        let mut asm_extern_call_sites = Vec::new();
        let mut asm_sym_fixups = Vec::new();
        let mut text_align: usize = 16;
        let mut label_relocs = Vec::new();
        let mut text_data_ranges = Vec::new();
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
                asm_sections: &mut asm_sections,
                asm_extern_call_sites: &mut asm_extern_call_sites,
                asm_sym_fixups: &mut asm_sym_fixups,
                text_align: &mut text_align,
                label_relocs: &mut label_relocs,
                text_data_ranges: &mut text_data_ranges,
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
                &alloc::collections::BTreeMap::new(),
                &alloc::collections::BTreeMap::new(),
                &mut Vec::new(),
                &mut Vec::new(),
                &mut None,
                false,
                false,
                &mut super::super::RodataBuild::default(),
                false,
                super::super::Hardening::NONE,
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
            crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target, false, true)
                .expect("ssa");
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
            .as_chunks::<4>()
            .0
            .iter()
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
        let mut asm_sections = AsmSectionSink::default();
        let mut asm_extern_call_sites = Vec::new();
        let mut asm_sym_fixups = Vec::new();
        let mut text_align: usize = 16;
        let mut label_relocs = Vec::new();
        let mut text_data_ranges = Vec::new();
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
                asm_sections: &mut asm_sections,
                asm_extern_call_sites: &mut asm_extern_call_sites,
                asm_sym_fixups: &mut asm_sym_fixups,
                text_align: &mut text_align,
                label_relocs: &mut label_relocs,
                text_data_ranges: &mut text_data_ranges,
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
                &alloc::collections::BTreeMap::new(),
                &alloc::collections::BTreeMap::new(),
                &mut Vec::new(),
                &mut Vec::new(),
                &mut None,
                false,
                false,
                &mut super::super::RodataBuild::default(),
                false,
                super::super::Hardening::NONE,
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
        let mut asm_sections = AsmSectionSink::default();
        let mut asm_extern_call_sites = Vec::new();
        let mut asm_sym_fixups = Vec::new();
        let mut text_align: usize = 16;
        let mut label_relocs = Vec::new();
        let mut text_data_ranges = Vec::new();
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
                asm_sections: &mut asm_sections,
                asm_extern_call_sites: &mut asm_extern_call_sites,
                asm_sym_fixups: &mut asm_sym_fixups,
                text_align: &mut text_align,
                label_relocs: &mut label_relocs,
                text_data_ranges: &mut text_data_ranges,
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
                &alloc::collections::BTreeMap::new(),
                &alloc::collections::BTreeMap::new(),
                &mut Vec::new(),
                &mut Vec::new(),
                &mut None,
                false,
                false,
                &mut super::super::RodataBuild::default(),
                false,
                super::super::Hardening::NONE,
            )
        };
        assert!(
            ok,
            "`test` should emit via the thin slice (cmp + cset + cbz + ldr params)"
        );
    }
}
