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
//!   over-aligned region           [rbp + align_region_off ..]  (16-mode only)
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

use super::super::ir::{
    AsmSeg, BinOp, FpCastKind, FunctionSsa, Inst, LoadKind, StoreKind, Terminator,
};
use super::GotFixup;
use super::Target;
use super::encode::{
    Cc, Fixup, PltCallFixup, Reg, emit_add_rsp_imm32, emit_addsd, emit_addss, emit_cvtsd2ss,
    emit_cvtsi2sd, emit_cvtsi2ss, emit_cvtss2sd, emit_cvttsd2si, emit_cvttss2si, emit_divsd,
    emit_divss, emit_imul_r_mem, emit_jcc_rel8, emit_jmp_rel8, emit_lea_r_mem,
    emit_lock_cmpxchg_mem_r, emit_lock_xadd_mem_r, emit_mov_mem_r, emit_mov_r_imm64,
    emit_mov_r_mem, emit_mov_rr, emit_movapd_xmm_xmm, emit_movq_xmm_r, emit_movsd_mem_xmm,
    emit_movsd_xmm_mem, emit_movss_mem_xmm, emit_movss_xmm_mem, emit_movsx_r_mem16,
    emit_movsxd_r_mem, emit_movups_mem_xmm, emit_movups_xmm_mem, emit_movzx_r_mem16,
    emit_movzx_r_r8, emit_mulsd, emit_mulss, emit_pop_r, emit_push_r, emit_ret, emit_ri, emit_rm,
    emit_rr, emit_setcc_r8, emit_shift_cl, emit_shift_ri, emit_sub_rsp_imm32, emit_subsd,
    emit_subss, emit_ucomisd, emit_ucomiss, emit_unary_r, emit_vfmadd231sd, emit_vfmadd231ss,
    emit_vfmsub231sd, emit_vfmsub231ss, emit_vfnmadd231sd, emit_vfnmadd231ss, emit_vfnmsub231sd,
    emit_vfnmsub231ss, emit_xchg_mem_r, emit_xchg_rr, emit_xorpd, emit_xorps,
};
use super::ssa::emit_common::{
    MAX_UNPROBED_STACK_STEP, STACK_PROBE_PAGE, STACK_PROBE_UNROLL_MAX, build_arg_aggs,
    place_same_loc,
};
use super::ssa::reg_alloc::{Allocation, Place};
use super::table::Mnem;
use super::{AddrPart, DataFixup};

/// Per-function frame layout. Bytes are 16-aligned at every
/// region boundary so SysV / Win64's sp-at-call invariant holds.
/// Compute the x86_64 stack-frame layout for `func`. Fills the shared
/// [`Frame`]'s x86_64 fields; the aarch64-only fields stay at their defaults.
/// Per-function stack-frame layout for x86_64. Every region is an explicit
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
    /// rbp-relative base of the System V register save area; 0 when unused.
    pub va_reg_save_off: i32,
    /// Bytes of saved non-volatile xmm scratch (Win64), 16 per register;
    /// 0 on System V.
    pub saved_fpr_bytes: u32,
    /// rbp-relative base of the inline-asm scratch region (operand captures
    /// plus register saves); 0 when the function has no inline asm. Frame
    /// storage rather than pushes: a setjmp-style template may save rsp and
    /// be resumed later by a longjmp-style one after the memory below rsp
    /// was reused, so nothing the block needs afterwards may live there.
    pub asm_scratch_off: i32,
    /// The body moves rsp at runtime (`alloca` / C99 6.7.6.2 VLA), or the
    /// prologue realigns rsp for an automatic object aligned above 16, so
    /// spill slots are addressed through rbp and the epilogue re-establishes
    /// rsp from rbp before tearing the frame down.
    pub dynamic_sp: bool,
    /// Alignment the prologue forces on rsp for automatic objects aligned
    /// above 16 (C11 6.7.5), a power of two > 16, or 0 when none. The
    /// realigned region sits below the static frame; the objects live at
    /// `[rsp + region_off]`.
    pub realign_align: u32,
    /// Byte size of the realigned region, a multiple of 16.
    pub realign_region_bytes: u32,
    /// rbp-relative byte offset (negative) of the over-aligned region when the
    /// region alignment is exactly 16, or 0 when none. rbp and every frame
    /// region above it are 16-byte multiples, so the region base is 16-aligned
    /// with no rsp move; its bytes are counted in `frame_bytes` and the
    /// objects live at `[rbp + align_region_off + region_off]`.
    pub align_region_off: i64,
}

fn compute_frame(func: &FunctionSsa, alloc: &Allocation, abi: super::Abi) -> Frame {
    let (locals_bytes, alloc_spill_bytes, saved_gpr_bytes) =
        super::ssa::emit_common::compute_frame_base(func, alloc);
    // System V variadic callees reserve the 176-byte register save
    // area (System V AMD64 3.5.7) at the bottom of the frame. It is
    // added to `frame_bytes` only; `alloc_spill_base` (and thus the
    // spill / locals offsets, which are measured from rbp down by
    // `alloc_spill_base`) is unchanged, so the existing regions keep
    // their rbp-relative positions and the save area takes the lowest
    // bytes.
    let va_save_bytes = if sysv_variadic_callee(func, abi) {
        SYSV_REG_SAVE_BYTES
    } else {
        0
    };
    // The save area sits above the saved-callee-GPR region
    // (addressed bottom-up from rsp) and below the locals / spill
    // region (addressed top-down from rbp), so neither region's
    // offset formula changes. Its base is the gp area start.
    let va_reg_save_off = if va_save_bytes > 0 {
        -((locals_bytes + alloc_spill_bytes + va_save_bytes) as i32)
    } else {
        0
    };
    // Saved non-volatile xmm scratch (Win64): 16 bytes per register,
    // placed at the bottom of the frame below the saved-GPR region.
    let saved_fpr_bytes = alloc.fp_used.len() as u32 * 16;
    // Inline-asm scratch, directly below the va save area (or the spill
    // region when there is none) and above the rsp-addressed saved
    // registers. Sized for the largest block in the function.
    let asm_bytes = asm_scratch_bytes(func);
    let asm_scratch_off = if asm_bytes > 0 {
        -((locals_bytes + alloc_spill_bytes + va_save_bytes + asm_bytes) as i32)
    } else {
        0
    };
    // An over-aligned region whose alignment is exactly 16 joins the static
    // frame between the rbp-addressed regions and the rsp-addressed saved-
    // register block: every region above it is a 16-byte multiple, so its
    // base is 16-aligned with no rsp move. Above 16 the prologue realigns
    // rsp instead. A region whose members have no emitted access needs no
    // bytes, the same decision `compute_frame_base` makes for the locals
    // region (`locals_bytes` is 0 exactly when no local access survives).
    let region_bytes = func.realign_region_bytes.max(0) as u32;
    let static_region_bytes = if func.frame_align == 16 && locals_bytes > 0 {
        region_bytes
    } else {
        0
    };
    let frame_bytes = locals_bytes
        + alloc_spill_bytes
        + saved_gpr_bytes
        + va_save_bytes
        + saved_fpr_bytes
        + asm_bytes
        + static_region_bytes;
    let param_spill_bytes = prologue_param_spill_bytes(func, alloc, abi);
    // A Win64 variadic callee receives every argument (named and
    // variadic) in a contiguous 8-byte-per-argument region: the
    // first four in rcx/rdx/r8/r9 (spilled by the prologue into
    // the caller-reserved home area at `[rbp + 16 + i*8]`), the
    // rest on the incoming stack just above it. The body reads its
    // named parameters and `va_arg` walks the variadic tail with a
    // single 8-byte stride across that region, so the cell stride
    // is 8 rather than the 16-byte c5 cdecl cell width. Every other
    // callee keeps the 16-byte stride.
    let param_cell_stride = if win64_variadic_callee(func, abi) {
        8
    } else {
        16
    };
    // An automatic object aligned above 16 realigns rsp in the prologue and
    // lives in a region below the static frame, addressed sp-relative; the
    // frame is dynamic-sp so spills go through rbp and the epilogue restores
    // rsp from rbp (C11 6.7.5). An alignment of exactly 16 keeps the static
    // frame and addresses the region rbp-relative.
    let realign_align = if func.frame_align > 16 {
        func.frame_align as u32
    } else {
        0
    };
    Frame {
        frame_bytes,
        alloc_spill_base: locals_bytes,
        param_spill_bytes,
        param_cell_stride,
        va_reg_save_off,
        saved_fpr_bytes,
        asm_scratch_off,
        dynamic_sp: super::ssa::emit_common::uses_dynamic_alloca(func) || realign_align > 0,
        realign_align,
        realign_region_bytes: if realign_align > 0 { region_bytes } else { 0 },
        align_region_off: if static_region_bytes > 0 {
            -((locals_bytes + alloc_spill_bytes + va_save_bytes + asm_bytes + static_region_bytes)
                as i64)
        } else {
            0
        },
    }
}

/// Bytes of frame scratch the function's largest inline-asm block needs:
/// 16 per saved xmm, 8 per saved GP register, 8 per operand capture.
/// Mirrors the save-list computation in [`emit_inline_asm`].
fn asm_scratch_bytes(func: &FunctionSsa) -> u32 {
    let mut max = 0u32;
    for inst in &func.insts {
        let Inst::InlineAsm { asm, args } = inst else {
            continue;
        };
        // A no-op statement emits no staging (`emit_inline_asm`), so it
        // needs no scratch.
        if super::ssa::emit_common::asm_statement_is_noop(
            asm,
            super::ssa::emit_common::AsmComments::X86,
        ) {
            continue;
        }
        let Ok(op_reg) =
            super::asm::assign_operand_regs(&asm.operands, asm.clobber_regs, asm.clobber_fp_regs)
        else {
            continue;
        };
        let Ok((used, fp_used, _)) = asm_save_masks_and_stage(asm, &op_reg) else {
            continue;
        };
        let bytes = fp_used.count_ones() * 16 + used.count_ones() * 8 + args.len() as u32 * 8;
        max = max.max(bytes);
    }
    super::ssa::emit_common::align16(max)
}

/// The GP / FP register masks an inline-asm statement saves around its
/// body, and the staging register its capture / load / store-back
/// sequences run through. The stage must not alias any GP operand
/// register (a `register T v asm("reg")` binding can pin an operand to
/// any GPR, including r10 / r11), so it is chosen per statement: r10 /
/// r11 first (outside the allocator banks, nothing to save), then any
/// clobbered non-operand register (already saved), then a free
/// allocator-visible register, added to the save mask. Sizing
/// (`asm_scratch_bytes`) and emission (`emit_inline_asm`) share this so
/// the frame region always covers the emitted save list.
fn asm_save_masks_and_stage(
    asm: &super::super::ir::AsmBlock,
    op_reg: &[Option<u8>],
) -> Result<(u32, u32, Reg), alloc::string::String> {
    use super::super::ir::AsmConstraint;
    let mut used = asm.clobber_regs;
    let mut fp_used = asm.clobber_fp_regs;
    // GP registers the stage must avoid: every operand register (bound
    // ones included -- their value is live into and out of the body).
    let mut operand_gp = 0u32;
    for (i, op) in asm.operands.iter().enumerate() {
        let Some(r) = op_reg[i] else { continue };
        if matches!(op.constraint, AsmConstraint::Fp) {
            fp_used |= 1 << r;
            continue;
        }
        operand_gp |= 1 << r;
        if !matches!(op.constraint, AsmConstraint::Bound(_)) {
            used |= 1 << r;
        }
    }
    const STAGE_CANDIDATES: [u8; 14] = [10, 11, 0, 3, 1, 2, 6, 7, 8, 9, 12, 13, 14, 15];
    // The stage carries no value across the template, so a clobbered
    // register serves at no cost (it is saved regardless); r10 / r11
    // are free even unclobbered. A free allocator-visible register may
    // hold a live value, so it is the last resort and joins the save
    // list.
    let free = |r: u8| operand_gp & (1 << r) == 0;
    let stage = [10u8, 11]
        .into_iter()
        .find(|&r| free(r))
        .or_else(|| {
            STAGE_CANDIDATES
                .iter()
                .copied()
                .find(|&r| free(r) && asm.clobber_regs & (1 << r) != 0)
        })
        .or_else(|| STAGE_CANDIDATES.iter().copied().find(|&r| free(r)))
        .ok_or_else(|| {
            alloc::string::String::from("inline asm: no register left for operand staging")
        })?;
    if stage != 10 && stage != 11 && asm.clobber_regs & (1 << stage) == 0 {
        used |= 1 << stage;
    }
    Ok((used, fp_used, Reg(stage)))
}

/// True when the function is a variadic c5 callee compiled for the
/// Win64 host variadic ABI (Microsoft x64 calling convention). Win64
/// is the only x86_64 target whose `Abi` sets `position_indexed_args`
/// (the by-position rcx/rdx/r8/r9 placement); SysV x86_64 leaves it
/// clear, so this gate selects Win64 alone and leaves the SysV
/// variadic c5 path on its 16-byte cdecl stack-push shape byte for
/// byte. Under this ABI named arguments arrive in argument registers
/// and the variadic tail rides the incoming stack at 8-byte stride;
/// the prologue spills the named register arguments into the caller's
/// home area, `va_start` points at the first variadic 8-byte slot, and
/// `va_arg` advances 8.
fn win64_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
    debug_assert!(
        !abi.position_indexed_args || matches!(abi.arch, super::Arch::X86_64),
        "position_indexed_args is a Win64 x86_64 property"
    );
    func.is_variadic && abi.position_indexed_args
}

/// Bytes the System V AMD64 register save area occupies (ABI 3.5.7):
/// the six integer argument registers (rdi rsi rdx rcx r8 r9) at
/// `[base + 0 .. 48]` followed by the eight XMM argument registers
/// (xmm0..xmm7) at `[base + 48 .. 176]`. `va_start`'s gp_offset /
/// fp_offset and `va_arg`'s 48 / 176 bounds all derive from this
/// single layout.
const SYSV_GP_SAVE_BYTES: u32 = 6 * 8;
const SYSV_FP_SAVE_BYTES: u32 = 8 * 16;
const SYSV_REG_SAVE_BYTES: u32 = SYSV_GP_SAVE_BYTES + SYSV_FP_SAVE_BYTES;

/// True when the function is a variadic c5 callee compiled for the
/// System V AMD64 host variadic ABI (Linux x86_64). System V is the
/// x86_64 target with `shadow_space == 0`, no `position_indexed_args`
/// (the standard rdi/rsi/.../xmm bank placement), and
/// `variadic_zero_xmm_count` set (the caller passes the XMM-argument
/// count in `al`). Win64 (shadow_space 32, position_indexed_args,
/// no al) and every aarch64 target are excluded, so this gate selects
/// Linux x86_64 alone.
///
/// Under this ABI the named arguments arrive in the standard argument
/// registers (integer bank rdi.. + FP bank xmm0..), the variadic tail
/// rides the same banks then the incoming stack, the callee prologue
/// spills rdi..r9 + xmm0..xmm7 into a register save area (System V
/// AMD64 3.5.7), `va_start` initialises the `__va_list_tag` offsets and
/// pointers, and `va_arg` walks the gp area, fp area, then the overflow
/// area per `kind`.
fn sysv_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
    func.is_variadic
        && matches!(abi.arch, super::Arch::X86_64)
        && abi.shadow_space == 0
        && !abi.position_indexed_args
        && abi.variadic_zero_xmm_count
}

/// Registers that are caller-saved on both SysV AMD64 and Win64.
/// Candidate pool for `pick_caller_saved_scratch`, used to find an
/// *additional* scratch beyond the dedicated fixed scratch r10 / r11.
/// The intersection of the two ABIs' caller-saved sets is rax, rcx,
/// rdx, r8, r9, r10, r11; rsi and rdi are caller-saved on SysV but
/// callee-saved on Win64, so they are excluded. r10 / r11 are the
/// reserved fixed scratch (`SCRATCH_R10` / `SCRATCH_R11`) and are
/// excluded so a pick never aliases a register the caller already
/// committed as scratch. Order favours rax (rarely a call argument)
/// then the argument registers rcx / rdx / r8 / r9.
const CALLER_SAVED_INT_SCRATCHES: &[u8] = &[0, 1, 2, 8, 9];

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
///   stripe drops out and no `pop r10` / `push r10` sequence is
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
fn is_full_leaf(func: &FunctionSsa, frame: Frame, alloc: &Allocation, abi: super::Abi) -> bool {
    if frame.frame_bytes != 0 || frame.param_spill_bytes != 0 {
        return false;
    }
    // A function that realigns rsp for an over-aligned automatic object needs
    // the frame pointer to restore rsp on exit; it is never leaf-elided.
    if frame.realign_align != 0 {
        return false;
    }
    // A Win64 variadic callee must establish rbp so the prologue can
    // spill its named register arguments into the caller's home area
    // and the body / `va_arg` can address that area through rbp; it is
    // never leaf-elided.
    if win64_variadic_callee(func, abi) {
        return false;
    }
    // A System V variadic callee must establish rbp and a frame for its
    // register save area (System V AMD64 3.5.7) and named-parameter
    // cells; it is never leaf-elided.
    if sysv_variadic_callee(func, abi) {
        return false;
    }
    if !alloc.gpr_used.is_empty() {
        return false;
    }
    // A saved non-volatile xmm scratch (Win64) needs a frame to hold it
    // and an epilogue to restore it.
    if !alloc.fp_used.is_empty() {
        return false;
    }
    super::ssa::emit_common::function_makes_no_calls(func)
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
/// Per-parameter incoming-register placement from `plan_call_args`.
/// Indexed by declared parameter position. Variadic and zero-param
/// callees yield an empty plan. Consumed by the prologue spill and
/// the `Inst::ParamRef` lowering to resolve each parameter's incoming
/// integer / FP register through the independent argument-register
/// banks.
fn param_placements(func: &FunctionSsa, abi: super::Abi) -> alloc::vec::Vec<super::ArgPlacement> {
    if func.is_variadic || func.n_params == 0 {
        return alloc::vec::Vec::new();
    }
    super::ssa::emit_common::param_placements_common(func, abi)
}

/// `(n_reg, n_stack)` split of the declared parameters: how many land
/// in argument registers (integer or FP) and how many overflow to the
/// host stack. The entry-spill prologue fills each c5 cdecl cell from
/// its own placement, so the register-passed and stack-passed
/// parameters need not form a contiguous prefix and suffix: a by-value
/// aggregate consuming no argument register (System V AMD64 MEMORY
/// class) or a Win64 aggregate overflowing past the positional
/// registers interleaves the two, and the per-placement fill handles
/// it directly.
fn param_reg_stack_split(func: &FunctionSsa, abi: super::Abi) -> (usize, usize) {
    let placements = param_placements(func, abi);
    // The count of register-passed (non-stack) placements and the count
    // of stack-passed ones. The entry-spill prologue fills each c5 cdecl
    // cell by its own placement, so the two need not form a contiguous
    // register prefix and stack suffix; a by-value aggregate consuming no
    // argument register (System V MEMORY class) or a Win64 aggregate
    // overflowing past the positional registers may interleave them.
    let n_reg = placements
        .iter()
        .filter(|p| !matches!(p, super::ArgPlacement::Stack(_)))
        .count();
    (n_reg, placements.len() - n_reg)
}

fn param_elidable_mask(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> (alloc::vec::Vec<bool>, usize, usize) {
    if func.is_variadic || func.n_params == 0 {
        return (alloc::vec::Vec::new(), 0, 0);
    }
    // Register-passed vs host-stack-overflow split comes from the
    // same `plan_call_args` the caller runs. Independent int / FP
    // argument-register banks (System V AMD64 3.2.3) mean the count
    // of register-passed parameters can exceed `int_arg_regs.len()`
    // (e.g. eight floating-point parameters in xmm0..xmm7 alongside
    // integer parameters), so the count is derived from the plan
    // rather than `n_params.min(int_arg_regs.len())`.
    let (n_reg, n_stack) = param_reg_stack_split(func, abi);
    let (seeded, addr_taken, needed) = super::ssa::emit_common::scan_param_slot_usage(func, alloc);
    // A parameter whose incoming argument register the per-inst
    // `ParamRef` path clobbers before it is read must keep its c5 cdecl
    // home cell so it can read the value back from that cell rather than
    // from the clobbered register (see `compute_param_from_home`).
    // mem2reg may otherwise have promoted the parameter into a register
    // and left its slot unobserved, which would mark it elidable and
    // drop the home spill the per-inst read depends on.
    let clobbered = param_home_clobber_set(func, alloc, abi);
    let mut elidable = alloc::vec::Vec::with_capacity(n_reg);
    for i in 0..n_reg {
        let slot = (i as i64) + 2;
        let ok = seeded.contains(&(i as u32))
            && !addr_taken.contains(&slot)
            && !needed.contains(&slot)
            && !clobbered.get(i).copied().unwrap_or(false);
        elidable.push(ok);
    }
    (elidable, n_reg, n_stack)
}

/// A register parameter that the entry parallel copy
/// ([`emit_function`]'s prebatch) cannot place atomically and that the
/// per-inst `Inst::ParamRef` path therefore lowers with a register read
/// whose incoming argument register an earlier-emitted `ParamRef`'s
/// home write already clobbered.
///
/// The entry parallel copy avoids the hazard by placing every register
/// parameter from its (distinct) argument register at once. It runs only
/// when the parameter homes are pairwise distinct, the parallel-copy
/// precondition. When two homes coincide the batch is skipped and the
/// per-inst path runs; a parameter whose argument register is then
/// clobbered must read its prologue-spilled c5 cdecl home cell instead.
/// This returns the per-parameter mask of exactly those at-risk
/// parameters; it is empty whenever the batch runs (every parameter is
/// placed atomically, so none is at risk). The mask depends only on
/// `alloc.places` and `Inst::ParamRef` order, neither of which the
/// resulting home-cell spill changes, so the elidability scan and the
/// prologue both consult it without a fixpoint.
fn param_home_clobber_set(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> alloc::vec::Vec<bool> {
    if func.is_variadic || func.n_params == 0 {
        return alloc::vec::Vec::new();
    }
    // The clobber set tracks the integer argument-register bank only.
    // Floating-point parameters arrive in the separate FP bank, so an
    // FP `ParamRef`'s write can never clobber an integer parameter's
    // incoming register (and vice versa). The mask spans the
    // register-passed parameters; FP entries stay `false`.
    let param_plan = param_placements(func, abi);
    let n_reg = param_plan
        .iter()
        .filter(|p| !matches!(p, super::ArgPlacement::Stack(_)))
        .count();
    let mut mask = alloc::vec![false; n_reg];
    if n_reg == 0 {
        return mask;
    }
    // Floating-point parameters are never placed by the integer entry
    // batch, so the per-inst `ParamRef` path always lowers them and the
    // same clobber hazard applies within the FP bank: an FP parameter
    // whose incoming xmm an earlier-emitted FP `ParamRef`'s destination
    // overwrites must read its prologue-spilled home cell. This pass is
    // independent of the integer `homes_distinct` gate below.
    {
        let mut written_fp: alloc::collections::BTreeSet<u8> = alloc::collections::BTreeSet::new();
        for (vid, inst) in func.insts.iter().enumerate() {
            let Inst::ParamRef { idx, kind } = inst else {
                continue;
            };
            if !matches!(kind, LoadKind::F32 | LoadKind::F64) {
                continue;
            }
            let i = *idx as usize;
            if i >= n_reg {
                continue;
            }
            if super::ssa::emit_common::is_dead_pure(inst, vid as super::super::ir::ValueId, alloc)
            {
                continue;
            }
            let Some(super::ArgPlacement::FpReg(arg_reg)) = param_plan.get(i).copied() else {
                continue;
            };
            if written_fp.contains(&arg_reg) {
                mask[i] = true;
            }
            if let Some(Place::FpReg(r)) = alloc.places.get(vid).copied() {
                written_fp.insert(r);
            }
        }
    }
    // Mirror the prebatch eligibility and the `homes_distinct` gate in
    // `emit_function`: the entry parallel copy batches every register
    // parameter whose home is an integer register or a spill slot, and
    // runs only when those homes are pairwise distinct. When it runs no
    // parameter is at risk.
    let mut batch_homes: alloc::vec::Vec<Place> = alloc::vec::Vec::new();
    for (vid, inst) in func.insts.iter().enumerate() {
        let Inst::ParamRef { idx, .. } = inst else {
            continue;
        };
        if (*idx as usize) >= n_reg {
            continue;
        }
        if super::ssa::emit_common::is_dead_pure(inst, vid as super::super::ir::ValueId, alloc) {
            continue;
        }
        let dst = alloc.places.get(vid).copied().unwrap_or(Place::None);
        if matches!(dst, Place::IntReg(_) | Place::Spill(_)) {
            batch_homes.push(dst);
        }
    }
    let homes_distinct = (0..batch_homes.len()).all(|a| {
        ((a + 1)..batch_homes.len()).all(|b| !place_same_loc(batch_homes[a], batch_homes[b]))
    });
    if !batch_homes.is_empty() && homes_distinct {
        return mask;
    }
    // Per-inst path: a later parameter whose argument register was
    // already written by an earlier `ParamRef`'s home placement is
    // clobbered before it can be read.
    let mut written: alloc::collections::BTreeSet<u8> = alloc::collections::BTreeSet::new();
    for (vid, inst) in func.insts.iter().enumerate() {
        let Inst::ParamRef { idx, .. } = inst else {
            continue;
        };
        let i = *idx as usize;
        if i >= n_reg {
            continue;
        }
        // Only integer parameters participate in the integer-bank
        // clobber tracking; an FP parameter's incoming xmm register is
        // disjoint from `int_arg_regs`.
        let Some(super::ArgPlacement::IntReg(arg_reg)) = param_plan.get(i).copied() else {
            continue;
        };
        if written.contains(&arg_reg) {
            mask[i] = true;
        }
        if let Some(Place::IntReg(r)) = alloc.places.get(vid).copied() {
            written.insert(r);
        }
    }
    mask
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

/// Per-parameter mask: `mask[idx]` is true when the per-inst
/// `Inst::ParamRef` for register parameter `idx` must read its value
/// from the prologue-spilled c5 cdecl home cell rather than from the
/// incoming host argument register.
///
/// The hazard: the allocator can color several `ParamRef` values into
/// one register (sequentially-live parameters consumed by intervening
/// stores). When the destination register an earlier-emitted
/// `ParamRef` writes is a later parameter's incoming argument register,
/// the write clobbers that argument value before the later `ParamRef`
/// reads it. The home cell is immune because the prologue stored it
/// before any body instruction ran. The set is exactly the clobber set
/// from [`param_home_clobber_set`]: each at-risk parameter is forced
/// non-elidable by [`param_elidable_mask`], so its home cell exists. A
/// mem2reg-promoted parameter is at risk too -- the earlier
/// non-elidable-only gate left such a promoted parameter reading a
/// clobbered argument register.
fn compute_param_from_home(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> alloc::vec::Vec<bool> {
    param_home_clobber_set(func, alloc, abi)
}

fn bail_msg(reason: &str) {
    super::ssa::emit_common::bail_msg("x86_64", reason);
}

/// Report a bail and yield the handler's `false` result.
/// Placeholder for a `$LABEL` immediate: outside the signed-byte range, so
/// form selection takes the 32-bit immediate field the relocation needs, and
/// distinctive enough to confirm the field landed at the end of the encoding.
const ABS_LABEL_PLACEHOLDER: i64 = 0x1234_5678;
const ABS_LABEL_PLACEHOLDER_BYTES: [u8; 4] = (ABS_LABEL_PLACEHOLDER as u32).to_le_bytes();

fn fail(reason: &str) -> bool {
    bail_msg(reason);
    false
}

/// A value's allocated `Place`, `Place::None` when out of range.
fn place_of(alloc: &Allocation, v: u32) -> Place {
    alloc.places.get(v as usize).copied().unwrap_or(Place::None)
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
/// allocator interference use r10 (reserved by the codegen and
/// outside both pools). Caller-saved, so reserving it forces no
/// prologue save.
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
/// Reserved secondary scratch outside both allocator pools (see the
/// note on `SCRATCH_R10`). Handlers that already commit `SCRATCH_R10`
/// to one operand and need a second guaranteed-free register use this;
/// it never aliases an allocator-chosen `rd`, a staged dividend in
/// `SCRATCH_R10`, or any argument register. r11 is caller-saved, so
/// reserving it forces no prologue save.
const SCRATCH_R11: Reg = Reg(11);

/// Scratch XMM registers for FP handlers. The SSA allocator's
/// caller_fprs pool covers `xmm0..xmm7` and callee_fprs is empty
/// on SysV (no callee-saved xmm), so any allocator-held FP value
/// lives in xmm0..xmm7. xmm14 / xmm15 sit outside both banks and
/// stay free as primary / secondary scratches.
const SCRATCH_XMM14: Reg = Reg(14);
const SCRATCH_XMM15: Reg = Reg(15);
/// Third FP scratch for the three-input fused multiply-add, holding a
/// spilled accumulator. xmm13 is outside the allocator's xmm0..xmm7
/// pool, like xmm14 / xmm15.
const SCRATCH_XMM13: Reg = Reg(13);

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
            let (sb, sp_off) = spill_slot_addr_shifted(frame, slot, sp_shift);
            emit_movsd_xmm_mem(code, scratch, sb, sp_off);
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
        let (sb, sp_off) = spill_slot_addr(frame, slot);
        emit_movsd_mem_xmm(code, sb, sp_off, src);
    }
}

/// Map an FP arithmetic [`BinOp`] to its scalar SSE encoder. `is_f32`
/// selects the single-precision (`addss` / ...) vs double-precision
/// (`addsd` / ...) form per C99 6.3.1.8. Returns `None` for any
/// non-FP-arith op.
fn fp_arith_enc_for(op: BinOp, is_f32: bool) -> Option<fn(&mut Vec<u8>, Reg, Reg)> {
    Some(if is_f32 {
        match op {
            BinOp::Fadd => emit_addss,
            BinOp::Fsub => emit_subss,
            BinOp::Fmul => emit_mulss,
            BinOp::Fdiv => emit_divss,
            _ => return None,
        }
    } else {
        match op {
            BinOp::Fadd => emit_addsd,
            BinOp::Fsub => emit_subsd,
            BinOp::Fmul => emit_mulsd,
            BinOp::Fdiv => emit_divsd,
            _ => return None,
        }
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

/// Map an integer comparison [`BinOp`] to its x86_64 condition code
/// (signed L / G / LE / GE, unsigned B / A / BE / AE per C99 6.5.8).
/// `None` for any non-comparison op.
fn int_cmp_cc(op: BinOp) -> Option<Cc> {
    Some(match op {
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
    })
}

/// After a flags-setting compare: `true` when a fused branch consumes
/// the flags directly and the boolean materialisation is elided, else
/// `setcc` + `movzx` the result into `rd`.
fn finish_int_cmp(
    code: &mut Vec<u8>,
    v: super::super::ir::ValueId,
    cc: Cc,
    rd: Reg,
    alloc: &Allocation,
) -> bool {
    if alloc.branch_fused.get(v as usize).copied().unwrap_or(false) {
        return true;
    }
    emit_setcc_r8(code, cc, rd);
    emit_movzx_r_r8(code, rd, rd);
    false
}

/// Read an integer operand's place into a register, borrowing `rd`
/// as the load target for a spilled operand (the caller writes `rd`
/// afterwards anyway). `None` for an FP / absent place.
fn int_operand_into_rd(code: &mut Vec<u8>, place: Place, rd: Reg, frame: Frame) -> Option<Reg> {
    match place {
        Place::IntReg(r) => Some(Reg(r)),
        Place::Spill(slot) => {
            let (sb, off) = spill_slot_addr(frame, slot);
            emit_mov_r_mem(code, rd, sb, off);
            Some(rd)
        }
        _ => None,
    }
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

/// `(base, disp)` pair addressing allocator spill slot `slot`. Every
/// spill access routes through here so the dynamic-sp choice cannot be
/// bypassed. A static frame uses `[rsp + off]`; a dynamic-sp frame
/// (alloca / VLA) uses `[rbp + off - frame_bytes]`, the same byte,
/// since rsp no longer has a fixed relation to the slot once the body
/// moves it.
fn spill_slot_addr(frame: Frame, slot: u32) -> (Reg, i32) {
    spill_slot_addr_shifted(frame, slot, 0)
}

/// Like [`spill_slot_addr`], but for callers that temporarily pushed
/// rsp down by `sp_shift` bytes. The shift applies only to the
/// rsp-based form; the rbp-based form is immune to rsp moves.
///
/// The base offset: spill slot 0 sits at the top of the allocator-spill
/// region, slot N+1 eight bytes below slot N. The region lives at
/// `[rbp - alloc_spill_base .. - alloc_spill_bytes]` and rsp =
/// rbp - frame_bytes, so the slot is `frame_bytes - alloc_spill_base
/// - (N+1)*8` from rsp. Mirror of the aarch64 module's formula.
fn spill_slot_addr_shifted(frame: Frame, slot: u32, sp_shift: u32) -> (Reg, i32) {
    let off = super::ssa::emit_common::spill_slot_sp_offset(
        frame.frame_bytes,
        frame.alloc_spill_base,
        slot,
    ) as i32;
    if frame.dynamic_sp {
        (Reg::RBP, off - frame.frame_bytes as i32)
    } else {
        (Reg::RSP, off + sp_shift as i32)
    }
}

/// If `dst` is a `Spill` place, write the just-produced value in
/// `src` into the spill slot. No-op for register places (the
/// caller already wrote into the allocator's chosen reg).
fn spill_dst_to_slot(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    if let Place::Spill(slot) = dst {
        let (sb, sp_off) = spill_slot_addr(frame, slot);
        emit_mov_mem_r(code, sb, sp_off, src);
    }
}

/// Read a value's `Place` into a usable register: returns the
/// allocator's chosen reg directly for `IntReg`, or loads the
/// spilled value into `scratch` and returns `scratch` for `Spill`.
/// Returns `None` for `FpReg` / `None` so the caller can bail.
fn materialize_int(code: &mut Vec<u8>, place: Place, scratch: Reg, frame: Frame) -> Option<Reg> {
    materialize_int_shifted(code, place, scratch, frame, 0)
}

/// Materialize up to two integer operands into distinct registers. A
/// register-resident operand keeps its register; a spilled operand is
/// loaded into one of the reserved scratch registers (`r10` / `r11`)
/// that holds no other operand. Both scratch registers sit outside the
/// allocator's pool, so loading a spilled operand cannot clobber an
/// allocated value. Returns `None` if an operand is neither a register
/// nor a spill slot.
fn materialize_int_operands_distinct(
    code: &mut Vec<u8>,
    places: &[Place],
    frame: Frame,
) -> Option<alloc::vec::Vec<Reg>> {
    let mut regs: alloc::vec::Vec<Option<Reg>> = alloc::vec![None; places.len()];
    let mut occupied = [false; 16];
    for (i, &p) in places.iter().enumerate() {
        match p {
            Place::IntReg(r) => {
                regs[i] = Some(Reg(r));
                occupied[r as usize] = true;
            }
            Place::Spill(_) => {}
            _ => return None,
        }
    }
    let pool = [SCRATCH_R10, SCRATCH_R11];
    for (i, &p) in places.iter().enumerate() {
        if regs[i].is_some() {
            continue;
        }
        let scratch = pool.iter().copied().find(|s| !occupied[s.0 as usize])?;
        occupied[scratch.0 as usize] = true;
        materialize_int(code, p, scratch, frame)?;
        regs[i] = Some(scratch);
    }
    Some(
        regs.into_iter()
            .map(|r| r.expect("operand register assigned"))
            .collect(),
    )
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
            let (sb, sp_off) = spill_slot_addr_shifted(frame, slot, sp_shift);
            emit_mov_r_mem(code, scratch, sb, sp_off);
            Some(scratch)
        }
        Place::FpReg(r) => {
            // Reinterpret the xmm-resident f64 as its 8-byte bit
            // pattern via `movq scratch, xmm[r]`. Used at c5-internal
            // call sites that route every argument through the
            // integer arg bank (the callee's prologue spills only
            // int_arg_regs into the c5 cdecl slots).
            super::encode::emit_movq_r_xmm(code, scratch, Reg(r));
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
/// helper, which breaks register cycles with `xchg` (no scratch) and
/// routes a spill-touching cycle through `hold`; Spill destinations
/// route through the materialise helper and a store against rsp.
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
    // r10 / r11 (int) and xmm15 / xmm14 (fp) are reserved scratch outside the
    // allocator's banks, so they hold no value live across the terminator.
    super::ssa::emit_common::emit_phi_predecessor_moves(
        &super::ssa::emit_common::X64Backend,
        code,
        self_block,
        func,
        alloc,
        frame,
        SCRATCH_R10.0,
        SCRATCH_R11.0,
        SCRATCH_XMM15.0,
        SCRATCH_XMM14.0,
    )
}

/// Compare two `Place`s by physical location identity. Distinct
/// `Place` variants never alias; same-variant places alias when their
/// register number or spill slot matches.
/// Emit a single resolved location-to-location move. `stage` is a
/// scratch register used only for the spill-to-spill case (load then
/// store); it must lie outside the allocator's bank.
/// Sequentialize a parallel copy over physical locations (integer
/// registers and stack spill slots). Leaves -- destinations that are
/// not the source of any other pending move -- are emitted first;
/// when only cycles remain, one cycle source is saved into the
/// persistent `hold` register and every move reading that location is
/// redirected to read `hold`, exposing a new leaf. `hold` and `stage`
/// must lie outside the allocator's bank so they cannot collide with
/// any pending source or destination. Returns false if any operand is
/// an FP or `None` location, which this path does not lower.
fn schedule_place_moves(
    code: &mut Vec<u8>,
    moves: &mut Vec<(Place, Place)>,
    frame: Frame,
    hold: Reg,
    stage: Reg,
) -> bool {
    super::ssa::emit_common::schedule_place_moves(
        &super::ssa::emit_common::X64Backend,
        code,
        moves,
        frame,
        hold.0,
        stage.0,
    )
}

/// Sequentialize a parallel copy over xmm registers. Mirrors
/// [`schedule_int_reg_moves`] with `movapd` for the register copies:
/// drain leaves (a target that is not the source of any other
/// pending move) first; break a residual cycle by routing one cycle
/// source through `scratch`. `scratch` must lie outside the
/// allocator's xmm pool so it collides with no pending source or
/// target.
fn schedule_xmm_reg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>, scratch: Reg) {
    super::ssa::emit_common::schedule_reg_moves_via_scratch(
        code,
        moves,
        scratch.0,
        |code, t, s| emit_movapd_xmm_xmm(code, Reg(t), Reg(s)),
    );
}

/// Emit a single resolved FP location-to-location move over `FpReg`
/// and `Spill` places. `stage` is the scratch xmm for the
/// spill-to-spill case (load then store); it must lie outside the
/// allocator's xmm pool. `IntReg` and `None` places never reach here
/// (an FP phi's home and its operands are FP-classed).
impl super::ssa::emit_common::EmitBackend for super::ssa::emit_common::X64Backend {
    type Frame = Frame;
    fn fp_reg_mov(&self, code: &mut Vec<u8>, dst: u8, src: u8) {
        emit_movapd_xmm_xmm(code, Reg(dst), Reg(src));
    }
    fn fp_spill_store(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_movsd_mem_xmm(code, sb, off, Reg(src));
    }
    fn fp_spill_load(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, dst: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_movsd_xmm_mem(code, Reg(dst), sb, off);
    }
    fn int_reg_mov(&self, code: &mut Vec<u8>, dst: u8, src: u8) {
        emit_mov_rr(code, Reg(dst), Reg(src));
    }
    fn int_spill_store(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8, _base: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_mov_mem_r(code, sb, off, Reg(src));
    }
    fn int_spill_load(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, dst: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_mov_r_mem(code, Reg(dst), sb, off);
    }
    fn int_spill_to_spill(
        &self,
        code: &mut Vec<u8>,
        frame: Frame,
        src: u32,
        dst: u32,
        stage: u8,
        _hold: u8,
    ) {
        let (sb, src_off) = spill_slot_addr(frame, src);
        let (_, dst_off) = spill_slot_addr(frame, dst);
        emit_mov_r_mem(code, Reg(stage), sb, src_off);
        emit_mov_mem_r(code, sb, dst_off, Reg(stage));
    }
    fn int_spill_store_auto(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_mov_mem_r(code, sb, off, Reg(src));
    }
    fn break_place_cycle(
        &self,
        code: &mut Vec<u8>,
        moves: &mut Vec<(Place, Place)>,
        frame: Frame,
        hold: u8,
        stage: u8,
    ) {
        // Break a register-register edge with `xchg` (no scratch, not locked
        // for register operands): the exchange satisfies that move and leaves
        // the displaced value in the source for the move that reads it. An edge
        // touching a spill slot has no register swap, so route one such source
        // through `hold`. A single cycle drains before the next break.
        if let Some(i) = moves
            .iter()
            .position(|(s, t)| matches!(s, Place::IntReg(_)) && matches!(t, Place::IntReg(_)))
        {
            let (s, t) = moves[i];
            let (Place::IntReg(sr), Place::IntReg(tr)) = (s, t) else {
                unreachable!()
            };
            emit_xchg_rr(code, Reg(sr), Reg(tr));
            moves.swap_remove(i);
            for m in moves.iter_mut() {
                if place_same_loc(m.0, t) {
                    m.0 = s;
                }
            }
            moves.retain(|(s, t)| !place_same_loc(*s, *t));
        } else {
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
    fn int_reg_load_imm(&self, code: &mut Vec<u8>, dst: u8, bits: i64) {
        emit_mov_r_imm64(code, Reg(dst), bits);
    }
    fn fp_reg_from_int_reg(&self, code: &mut Vec<u8>, dst: u8, src: u8, _is_f64: bool) {
        // `movq xmm, r` copies all 64 bits; for an f32 the constant occupies
        // the low 32 (the immediate load zero-extends), which a scalar-single
        // op reads, so one form serves both widths.
        emit_movq_xmm_r(code, Reg(dst), Reg(src));
    }
}

/// Sequentialize a parallel copy over FP locations (xmm registers and
/// stack spill slots) for FP-classed phi predecessor moves. Mirrors
/// [`schedule_place_moves`] with `movsd` / `movapd`: leaves first,
/// then break a residual cycle by holding one cycle source in `hold`.
/// `hold` and `stage` must lie outside the allocator's xmm pool so
/// they collide with no pending source or destination.
fn schedule_int_reg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>) {
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
            // Only cycle members remain, all register to register, so
            // break a cycle with `xchg` (no scratch): the exchange
            // satisfies one move -- the target receives the source's
            // value -- and leaves the displaced value in the source for
            // the move that reads it.
            let (s, t) = moves[0];
            emit_xchg_rr(code, Reg(s), Reg(t));
            moves.swap_remove(0);
            for m in moves.iter_mut() {
                if m.0 == t {
                    m.0 = s;
                }
            }
            moves.retain(|(s, t)| s != t);
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
/// an `xchg`. Pass ordering mirrors the AArch64 emit:
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
///     [`schedule_int_reg_moves`], which breaks cycles with `xchg`
///     and so needs no scratch.
///   * Spill sources for `IntReg` placements then materialise
///     directly into the target arg register
///     (`materialize_int_shifted` writes its load into the dst).
/// Resolve a call's `arg_aggs` indices into the `ArgAgg` vector the
/// struct-aware planner consumes; empty when the call passes no
/// aggregate by value.
#[allow(clippy::too_many_arguments)]
fn marshal_args(
    code: &mut Vec<u8>,
    plan: &super::CallPlan,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    site: &str,
) -> bool {
    let arg_place = |i: usize| -> Place { place_of(alloc, args[i]) };
    let fail_site = |m: &str| -> bool { fail(&alloc::format!("{site}: {m}")) };

    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::Stack(off) = placement {
            let ap = arg_place(i);
            let Some(src) =
                materialize_int_shifted(code, ap, SCRATCH_R10, frame, plan.scratch_bytes)
            else {
                return fail_site("stack arg not in int reg / spill");
            };
            emit_mov_mem_r(code, Reg::RSP, off as i32, src);
        }
    }

    // Aggregate arguments passed on the outgoing stack (System V AMD64
    // MEMORY class, > 16 bytes): copy the struct inline to [rsp + off].
    // The destination is memory and never serves as a move source, but
    // the struct's base address sits in an argument register that the
    // register-move phase below overwrites, so this copy runs first
    // while the base is still live (mirroring the scalar Stack arm).
    // The address rides SCRATCH_R10, the per-word temp SCRATCH_R11;
    // both lie outside the allocator pools.
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::StructStack { off, size, align } = placement {
            let Some(src) =
                materialize_int_shifted(code, arg_place(i), SCRATCH_R10, frame, plan.scratch_bytes)
            else {
                return fail_site("by-stack aggregate base not in int reg / spill");
            };
            if src.0 != SCRATCH_R10.0 {
                emit_mov_rr(code, SCRATCH_R10, src);
            }
            // The outgoing stack slot is 8-aligned (System V AMD64
            // 3.2.3); the source is the caller's object, so its own
            // alignment bounds the unit.
            let unit = super::super::access_chunk(align, abi.strict_align, 8);
            let words = size / unit;
            for w in 0..words {
                let o = (w * unit) as i32;
                emit_load_unit(code, unit, SCRATCH_R11, SCRATCH_R10, o);
                emit_store_unit(code, unit, Reg::RSP, off as i32 + o, SCRATCH_R11);
            }
            for b in (words * unit)..size {
                let o = b as i32;
                super::encode::emit_movzx_r_mem8(code, SCRATCH_R11, SCRATCH_R10, o);
                super::encode::emit_mov_mem8_r(code, Reg::RSP, off as i32 + o, SCRATCH_R11);
            }
        }
    }

    // FP arguments. A value already held in an xmm register may sit
    // in another FP argument's target xmm, so the xmm-to-xmm moves
    // form a parallel copy that a naive sequential emit would clobber
    // (System V passes successive FP args in xmm0, xmm1, ...).
    // Schedule the register-to-register moves first so every xmm
    // argument source is consumed before any Spill / IntReg source
    // materialises into its target xmm -- otherwise a Spill load into
    // xmmN would overwrite a value another argument still reads from
    // xmmN. SCRATCH_XMM15 breaks any cycle and lies outside the
    // allocator's xmm pool.
    let mut fp_moves: Vec<(u8, u8)> = Vec::new();
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::FpReg(r) = placement
            && let Place::FpReg(s) = arg_place(i)
            && s != r
        {
            fp_moves.push((s, r));
        }
    }
    schedule_xmm_reg_moves(code, &mut fp_moves, SCRATCH_XMM15);
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::FpReg(r) = placement {
            match arg_place(i) {
                // Register-to-register moves were scheduled above.
                Place::FpReg(_) => {}
                ap @ (Place::Spill(_) | Place::IntReg(_)) => {
                    let Some(src) =
                        materialize_fp_shifted(code, ap, Reg(r), frame, plan.scratch_bytes)
                    else {
                        return fail_site("fp arg not in fp reg / spill / int reg");
                    };
                    if src.0 != r {
                        emit_movapd_xmm_xmm(code, Reg(r), src);
                    }
                }
                Place::None => return fail_site("fp arg not in fp reg / spill / int reg"),
            }
        }
    }

    // System V aggregates whose eightbytes are all SSE: no integer
    // eightbyte register can hold the base, so materialize the source
    // address into a scratch GPR and load each eightbyte's xmm. Runs
    // after the scalar-FP moves (their xmm sources consumed); the loads
    // touch only SCRATCH_R10 and the aggregate's own xmm targets, so
    // they cannot disturb the integer parallel move below. Mixed
    // SSE/INTEGER aggregates are deferred: their integer eightbyte
    // targets are argument GPRs that may still be another argument's
    // pending source, so their base rides the parallel move instead.
    for (i, &placement) in plan.placements.iter().enumerate() {
        let super::ArgPlacement::StructRegs { regs, n, align } = placement else {
            continue;
        };
        if n == 0 || !regs.iter().take(n as usize).all(|c| c.is_fp) {
            continue;
        }
        let Some(base) =
            materialize_int_shifted(code, arg_place(i), SCRATCH_R10, frame, plan.scratch_bytes)
        else {
            return fail_site("fp aggregate base not in int reg / spill");
        };
        if base.0 != SCRATCH_R10.0 {
            emit_mov_rr(code, SCRATCH_R10, base);
        }
        for (k, cr) in regs.iter().take(n as usize).enumerate() {
            emit_agg_load_sse(
                code,
                Reg(cr.reg),
                SCRATCH_R10,
                (k as i32) * 8,
                align,
                abi.strict_align,
                SCRATCH_R11,
            );
        }
    }

    // First INTEGER eightbyte register of an aggregate, if any: the
    // aggregate's base address is routed there by the parallel move and
    // the eightbyte loads below read from it (that register's own
    // eightbyte loads last).
    let agg_base_reg = |regs: &[super::ClassReg; 4], n: u8| -> Option<u8> {
        regs.iter()
            .take(n as usize)
            .find(|c| !c.is_fp)
            .map(|c| c.reg)
    };

    // Integer-register placements plus aggregate base addresses are one
    // parallel register move (System V AMD64 3.2.3). A scalar `IntReg`
    // arg moves src->target; a `StructRegs` arg positions its base
    // address into its own first integer eightbyte register, from
    // which the eightbytes load below (the base register is overwritten
    // by its own eightbyte last). Routing the base through that per-
    // aggregate register -- never a shared scratch -- keeps one
    // aggregate's load from clobbering another's still-pending base.
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
            // All-SSE aggregates loaded above.
            super::ArgPlacement::StructRegs { regs, n, .. } => {
                if let Some(dst) = agg_base_reg(&regs, n)
                    && let Place::IntReg(s) = arg_place(i)
                    && s != dst
                {
                    int_moves.push((s, dst));
                }
            }
            _ => {}
        }
    }
    schedule_int_reg_moves(code, &mut int_moves);

    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::IntReg(r) = placement {
            let ap = arg_place(i);
            match ap {
                Place::IntReg(_) => {}
                Place::Spill(_) | Place::None => {
                    let Some(src) =
                        materialize_int_shifted(code, ap, Reg(r), frame, plan.scratch_bytes)
                    else {
                        return fail_site("int arg not in int reg / spill");
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
                    super::encode::emit_movq_r_xmm(code, Reg(r), Reg(s));
                }
            }
        }
    }

    // Aggregate bases not already register-resident (spill / computed)
    // materialise into the aggregate's first integer eightbyte
    // register, the same destination the move loop used for the
    // register-resident case.
    for (i, &placement) in plan.placements.iter().enumerate() {
        if let super::ArgPlacement::StructRegs { regs, n, .. } = placement
            && let Some(dst) = agg_base_reg(&regs, n)
            && !matches!(arg_place(i), Place::IntReg(_))
        {
            let Some(src) =
                materialize_int_shifted(code, arg_place(i), Reg(dst), frame, plan.scratch_bytes)
            else {
                return fail_site("aggregate base not in int reg / spill");
            };
            if src.0 != dst {
                emit_mov_rr(code, Reg(dst), src);
            }
        }
    }

    // Load each aggregate's eightbytes from the base now in its first
    // integer eightbyte register: SSE eightbytes first (they leave the
    // base intact), then the remaining integer eightbytes high-first,
    // the base register's own eightbyte last since the load overwrites
    // it. All-SSE aggregates were loaded above.
    for &placement in plan.placements.iter() {
        if let super::ArgPlacement::StructRegs { regs, n, align } = placement
            && let Some(base) = agg_base_reg(&regs, n)
        {
            for (k, cr) in regs.iter().take(n as usize).enumerate() {
                if cr.is_fp {
                    emit_agg_load_sse(
                        code,
                        Reg(cr.reg),
                        Reg(base),
                        (k as i32) * 8,
                        align,
                        abi.strict_align,
                        SCRATCH_R10,
                    );
                }
            }
            for (k, cr) in regs.iter().take(n as usize).enumerate().rev() {
                if !cr.is_fp && cr.reg != base {
                    emit_agg_load_int(
                        code,
                        Reg(cr.reg),
                        Reg(base),
                        (k as i32) * 8,
                        8,
                        align,
                        abi.strict_align,
                        SCRATCH_R10,
                    );
                }
            }
            let base_off = regs
                .iter()
                .take(n as usize)
                .position(|c| !c.is_fp && c.reg == base)
                .unwrap_or(0);
            let disp = (base_off as i32) * 8;
            // The base's own eightbyte overwrites the base, so a
            // composed one accumulates in scratch first.
            if super::super::access_unit(disp as u32, 8, align, abi.strict_align) == 8 {
                emit_mov_r_mem(code, Reg(base), Reg(base), disp);
            } else {
                emit_agg_load_int(
                    code,
                    SCRATCH_R10,
                    Reg(base),
                    disp,
                    8,
                    align,
                    abi.strict_align,
                    SCRATCH_R11,
                );
                emit_mov_rr(code, Reg(base), SCRATCH_R10);
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
pub(crate) fn emit_function(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    cx: &mut super::ssa::emit_common::EmitCtx,
    fixups: &mut Vec<Fixup>,
    _got_fixups: &mut Vec<GotFixup>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_code_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_tls_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    ret_tags: &alloc::collections::BTreeMap<usize, i64>,
    tls_total_size: usize,
    fn_unwind: &mut Vec<super::FnUnwind>,
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    asm_section_text_refs: &mut Vec<super::AsmSectionTextRef>,
    asm_text_abs_refs: &mut Vec<super::AsmTextAbsRef>,
    asm_text_labels: &mut Vec<super::AsmTextLabel>,
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
    let snapshot = code.len();
    let fixups_snapshot = fixups.len();
    let plt_call_fixups_snapshot = plt_call_fixups.len();
    let data_fixups_snapshot = data_fixups.len();
    let user_extern_data_refs_snapshot = user_extern_data_refs.len();
    let asm_section_text_refs_snapshot = asm_section_text_refs.len();
    let asm_text_abs_refs_snapshot = asm_text_abs_refs.len();
    let asm_text_labels_snapshot = asm_text_labels.len();
    let asm_extern_call_sites_snapshot = asm_extern_call_sites.len();
    let asm_sym_fixups_snapshot = asm_sym_fixups.len();
    let asm_sections_snapshot = asm_sections.snapshot();
    // A cross-unit `extern _Thread_local` access (`extern_tls_names` maps
    // the access value-id to the referenced symbol) and a same-unit one
    // both record an `ElfTpoffFixup` the linker resolves against the
    // merged TLS layout; see `emit_tls_addr`.
    let elf_tpoff_snapshot = elf_tpoff_fixups.len();
    let pending_func_fixups_snapshot = pending_func_fixups.len();
    // Roll every output buffer back to its pre-function snapshot and
    // bail; the `tls` form also drops the recorded tpoff fixups.
    macro_rules! bail_rollback {
        () => {{
            code.truncate(snapshot);
            fixups.truncate(fixups_snapshot);
            plt_call_fixups.truncate(plt_call_fixups_snapshot);
            data_fixups.truncate(data_fixups_snapshot);
            user_extern_data_refs.truncate(user_extern_data_refs_snapshot);
            asm_section_text_refs.truncate(asm_section_text_refs_snapshot);
            asm_text_abs_refs.truncate(asm_text_abs_refs_snapshot);
            asm_text_labels.truncate(asm_text_labels_snapshot);
            asm_extern_call_sites.truncate(asm_extern_call_sites_snapshot);
            asm_sym_fixups.truncate(asm_sym_fixups_snapshot);
            asm_sections.restore(&asm_sections_snapshot);
            pending_func_fixups.truncate(pending_func_fixups_snapshot);
            return false;
        }};
        (tls) => {{
            elf_tpoff_fixups.truncate(elf_tpoff_snapshot);
            bail_rollback!();
        }};
    }
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
    let frame = compute_frame(func, alloc, abi);
    if frame.frame_bytes > super::ssa::emit_common::MAX_FRAME_BYTES {
        bail_msg(&super::ssa::emit_common::frame_too_large_msg(
            frame.frame_bytes as i64,
        ));
        return false;
    }

    // A per-inst `Inst::ParamRef` materialises its parameter from the
    // incoming host argument register. The allocator can pack several
    // sequentially-live parameters into one register, each consumed by
    // an intervening store before the next is produced, and the
    // destination register it picks for an earlier parameter may be a
    // later parameter's incoming argument register. The earlier
    // `ParamRef`'s write then overwrites that argument value before the
    // later `ParamRef` reads it. A non-elidable register parameter is
    // spilled by the prologue to its c5 cdecl home cell, which survives
    // the clobber; `param_from_home[i]` marks the parameters that must
    // read their home cell rather than the argument register. The flag
    // is set only for the parameters actually at risk -- a non-elidable
    // parameter whose argument register is the destination of an
    // earlier-emitted `ParamRef` -- so the common case stays a
    // register-to-register move.
    let param_from_home = compute_param_from_home(func, alloc, abi);
    // Per-parameter incoming-register plan; consumed by the per-inst
    // `Inst::ParamRef` lowering to source each FP parameter from its
    // xmm argument register.
    let param_plan = param_placements(func, abi);

    // A `__attribute__((naked))` function emits no prologue: its body (inline
    // asm) is the entire machine code, so there is no frame to set up or
    // unwind. The matching `Terminator::Return` below emits no epilogue.
    let mut uw = if func.is_naked {
        super::FnUnwind::default()
    } else {
        // Indirect-branch tracking: a function entry is reachable by an
        // indirect call, so it opens with `endbr64` ahead of the
        // prologue. `snapshot` still names the function's first byte, so
        // the unwind offsets `emit_prologue` records stay relative to it.
        // A naked function is excluded -- its body is the whole function.
        if abi.hardening.cf_protection_branch {
            super::encode::emit_endbr64(code);
        }
        emit_prologue(code, func, alloc, frame, abi, snapshot)
    };
    uw.begin = snapshot as u32;
    super::ssa::emit_common::record_post_prologue_pc(func, prologue_native, code.len());

    // Place the entry `Inst::ParamRef` values from their host argument
    // registers into the allocator's chosen locations. Emitting each
    // ParamRef independently in instruction order is unsound when one
    // parameter's destination register is a later parameter's source
    // argument register: the naive `mov dst, arg_reg` clobbers that
    // source before it is read (the allocator can swap two pointer
    // parameters between, say, rsi and rcx).
    //
    // The placement is a parallel copy from the (distinct) argument
    // registers to the parameter homes precisely when those homes are
    // distinct -- then `schedule_place_moves` sequentializes it and
    // breaks any cycle through a scratch register. When two ParamRef
    // values share a home (sequentially-live parameters the allocator
    // packed into one register) the move set is not a permutation, so
    // the batch is skipped and each ParamRef is placed in program order.
    // That per-inst path is safe only while no parameter's home is a
    // later parameter's incoming register; the allocator's ParamRef
    // self-home hint keeps it so. The `param-shuffle-clobber` check in
    // `verify_allocation` guards the invariant under `codegen_test`.
    let mut param_prebatched: Vec<bool> = alloc::vec![false; func.insts.len()];
    {
        // Each integer parameter's incoming register comes from the
        // plan, not `int_arg_regs[i]`: a floating-point parameter
        // earlier in the list consumes an FP register and does not
        // shift the integer bank, so the i-th declared parameter is not
        // the i-th integer register.
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
            // An integer-dst ParamRef is always an integer parameter
            // (an FP scalar is FP-classed and never lands in an int
            // register). Read its source integer register from the
            // plan; a stack-passed integer parameter has no register
            // source and stays on the per-inst home-cell path.
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
            // r10 / r11 are reserved scratch (never an argument register
            // and never in the allocator's bank), so they cannot collide
            // with any pending parameter source or destination.
            if !schedule_place_moves(code, &mut moves, frame, SCRATCH_R10, SCRATCH_R11) {
                return false;
            }
            for (dst, kind) in exts {
                let ext = |code: &mut Vec<u8>, r: Reg| match kind {
                    LoadKind::I8 => super::encode::emit_movsx_r_r8(code, r, r),
                    LoadKind::I16 => super::encode::emit_movsx_r_r16(code, r, r),
                    LoadKind::I32 => super::encode::emit_movsxd_r_r(code, r, r),
                    _ => {}
                };
                match dst {
                    Place::IntReg(r) => ext(code, Reg(r)),
                    Place::Spill(slot) => {
                        let (sb, sp_off) = spill_slot_addr(frame, slot);
                        emit_mov_r_mem(code, SCRATCH_R10, sb, sp_off);
                        ext(code, SCRATCH_R10);
                        emit_mov_mem_r(code, sb, sp_off, SCRATCH_R10);
                    }
                    Place::None | Place::FpReg(_) => {}
                }
            }
            for vid in vids {
                param_prebatched[vid] = true;
            }
        }
    }

    let mut block_offsets: Vec<usize> = alloc::vec![0; func.blocks.len()];
    let mut branch_fixups: Vec<BranchFixup> = Vec::new();
    // GCC `&&label`: each `Inst::BlockAddr` emits a `lea rd, [rip+disp32]`
    // placeholder; `(lea_start, target_block)` is resolved against the
    // final `block_offsets` after the relaxation passes settle (only the
    // disp32 is patched, so the destination register need not be saved).
    let mut block_addr_fixups: Vec<(usize, u32)> = Vec::new();
    // Jump tables: `(lea_start, table_idx)` per
    // `Terminator::JumpTable`. Each table is materialized into the
    // read-only blob after the relaxation passes settle; the lea at
    // `lea_start` becomes a writer-resolved address fixup.
    let mut jump_table_fixups: Vec<(usize, u32)> = Vec::new();
    // Branch relaxation. The block loop runs once with every local
    // branch in the rel32 long form (`branch_short` empty), then, when
    // `relax_branches` finds shortenable branches, once more with the
    // rel8 form for those branches. The second pass re-records every
    // code-offset metadatum (relocations, line rows, pc map) against
    // the shortened layout, so no recorded offset needs remapping. The
    // snapshots mark the buffers' lengths after the prologue, where the
    // re-emitted body begins.
    let mut branch_short: Vec<bool> = Vec::new();
    let body_code = code.len();
    let body_fixups = fixups.len();
    let body_plt = plt_call_fixups.len();
    let body_data = data_fixups.len();
    let body_uext = user_extern_data_refs.len();
    let body_asm_xsec = asm_section_text_refs.len();
    let body_asm_abs = asm_text_abs_refs.len();
    let body_asm_labels = asm_text_labels.len();
    let body_pending = pending_func_fixups.len();
    let body_tls = tls_index_fixups.len();
    let body_elf_tpoff = elf_tpoff_fixups.len();
    let body_line_rows = ssa_line_rows.len();
    let body_asm_extern = asm_extern_call_sites.len();
    let body_asm_sym = asm_sym_fixups.len();
    // The section sink merges by name, so a re-emit restores its full
    // per-section state rather than a length (see [`AsmSectionSink::restore`]).
    let body_asm_sections = asm_sections.snapshot();

    // Blocks an indirect branch can enter: switch-table successors and
    // the blocks whose address `&&label` took. Each opens with `endbr64`
    // under indirect-branch tracking, recorded before the block loop so
    // the pad lands at the offset every branch fixup resolves to.
    let endbr_targets = if abi.hardening.cf_protection_branch {
        super::indirect_branch_target_blocks(func)
    } else {
        alloc::collections::BTreeSet::new()
    };

    'emit: loop {
        // Re-collected each relaxation pass; resolved after the loop.
        block_addr_fixups.clear();
        jump_table_fixups.clear();

        for (block_idx, block) in func.blocks.iter().enumerate() {
            block_offsets[block_idx] = code.len();
            super::ssa::emit_common::record_block_start_pc(
                block_idx,
                block.start_pc,
                pc_to_native,
                code.len(),
            );
            if endbr_targets.contains(&(block_idx as super::super::ir::BlockId)) {
                super::encode::emit_endbr64(code);
            }
            // Tail-call opportunity: when the block's last instruction is
            // a direct `Inst::Call` whose result is the same block's
            // `Terminator::Return` value, lower the call as `marshal_args;
            // epilogue; jmp target` instead of `call target; capture;
            // epilogue; ret`. Saves one call+ret pair per recursion level
            // and removes the post-call rax-to-place mov. See
            // `detect_tail_call` for the safety preconditions.
            let tail_call = detect_tail_call(func, block, abi, variadic_targets, ret_tags, target);
            for v in block.inst_range.clone() {
                let inst = &func.insts[v as usize];
                let place = place_of(alloc, v);
                // A naked function's machine code is exactly its inline asm; the
                // compiler-inserted alloca/return-value scaffolding is dropped.
                if func.is_naked && !matches!(inst, Inst::InlineAsm { .. }) {
                    continue;
                }
                if super::ssa::emit_common::is_dead_pure(inst, v, alloc) {
                    continue;
                }
                // ParamRef already placed by the entry parallel copy.
                if param_prebatched[v as usize] {
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
                super::ssa::emit_common::record_inst_src(func, v, code.len(), ssa_line_rows);
                // GCC `&&label`: materialize the block's address with a
                // PC-relative lea. Handled here (not emit_inst) because the
                // disp32 resolves against this function's local
                // block_offsets once every block is laid out -- walker IR
                // leaves block.start_pc at 0, so the writer's pc_to_native
                // path can't be used.
                if let Inst::BlockAddr(tb) = inst {
                    let Some(rd) = int_or_spill_dst(place) else {
                        bail_msg("BlockAddr: dst not int reg / spill");
                        bail_rollback!(tls);
                    };
                    let lea_start = code.len();
                    super::encode::emit_lea_r_rip32(code, rd, 0);
                    block_addr_fixups.push((lea_start, *tb));
                    spill_dst_to_slot(code, place, rd, frame);
                    continue;
                }
                // `asm goto`: the label branches patch against block
                // offsets via the enclosing `branch_fixups`, which
                // `emit_inst` has no access to; lower it here (same
                // pattern as `Inst::BlockAddr` above).
                if let Inst::InlineAsm { asm, args } = inst
                    && let Terminator::AsmGoto { table } = block.terminator
                {
                    if !emit_inline_asm(
                        code,
                        asm,
                        args,
                        func,
                        alloc,
                        frame,
                        fixups,
                        name2entpc,
                        extern_data_names,
                        extern_code_names,
                        asm_sections,
                        asm_extern_call_sites,
                        asm_sym_fixups,
                        data_fixups,
                        pending_func_fixups,
                        user_extern_data_refs,
                        asm_section_text_refs,
                        asm_text_abs_refs,
                        asm_text_labels,
                        text_align,
                        Some(AsmGotoCtx {
                            row: &func.jump_tables[table as usize],
                            branch_fixups: &mut branch_fixups,
                            branch_short: &branch_short,
                        }),
                    ) {
                        bail_rollback!(tls);
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
                        abi,
                        target,
                        imports,
                        variadic_targets,
                        extern_tls_names,
                        extern_data_names,
                        extern_code_names,
                        tls_total_size,
                        param_from_home: &param_from_home,
                        param_plan: &param_plan,
                        name2entpc,
                    };
                    emit_inst(
                        &mut cx,
                        inst,
                        v,
                        place,
                        &fcx,
                        fixups,
                        asm_section_text_refs,
                        asm_text_abs_refs,
                        asm_text_labels,
                    )
                };
                if !inst_ok {
                    #[cfg(feature = "codegen_test")]
                    if std::env::var("BADC_DUMP_SSA").is_ok() {
                        eprintln!(
                            "ssa emit x86_64: bailed on inst v{v}: {:?} (place {:?})",
                            inst, place,
                        );
                    }
                    bail_rollback!(tls);
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
                        instr_offset: popped.instr_offset,
                        symbol_name: name.clone(),
                        direct_pcrel: None,
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
                bail_rollback!();
            }
            match block.terminator {
                // A naked function's inline-asm body provides its own return
                // (e.g. `iretq`); emit no epilogue for the synthetic return.
                Terminator::Return(_) if func.is_naked => {}
                Terminator::Return(v) => {
                    if let Some((tail_pc, target_pc, args)) = tail_call {
                        let fp_arg_mask = match &func.insts[tail_pc] {
                            Inst::Call { fp_arg_mask, .. } => *fp_arg_mask,
                            _ => 0,
                        };
                        if !emit_tail_call(
                            code,
                            target_pc,
                            args,
                            alloc,
                            frame,
                            abi,
                            fixups,
                            func,
                            fp_arg_mask,
                        ) {
                            bail_rollback!();
                        }
                    } else {
                        emit_return(code, v, alloc, frame, func, abi, asm_extern_call_sites)
                    }
                }
                Terminator::Jmp(t) => {
                    // Fall through when the target is the next block in
                    // layout rather than emitting a jump to it.
                    if t as usize != block_idx + 1 {
                        emit_local_branch(
                            code,
                            &mut branch_fixups,
                            &branch_short,
                            LocalBranchKind::Jmp,
                            t,
                        );
                    }
                }
                Terminator::Bz {
                    cond,
                    target,
                    fall_through,
                } => {
                    if let Some(fused) = fused_branch_cc(func, alloc, cond, /* negate */ true) {
                        emit_fused_branch(
                            code,
                            &mut branch_fixups,
                            &branch_short,
                            fused,
                            target,
                            fall_through,
                        );
                        if fall_through as usize != block_idx + 1 {
                            emit_local_branch(
                                code,
                                &mut branch_fixups,
                                &branch_short,
                                LocalBranchKind::Jmp,
                                fall_through,
                            );
                        }
                        continue;
                    }
                    let cond_place = place_of(alloc, cond);
                    let Some(rc) = materialize_int(code, cond_place, SCRATCH_R10, frame) else {
                        bail_msg("Bz: cond Place not int reg / spill / fp");
                        bail_rollback!();
                    };
                    // `test rc, rc` sets ZF=1 iff rc==0; je takes the
                    // branch on ZF=1. Shorter than `cmp rc, 0`.
                    super::encode::emit_rr(code, Mnem::Test, 8, rc, rc);
                    emit_local_branch(
                        code,
                        &mut branch_fixups,
                        &branch_short,
                        LocalBranchKind::Jcc(Cc::E),
                        target,
                    );
                    if fall_through as usize != block_idx + 1 {
                        emit_local_branch(
                            code,
                            &mut branch_fixups,
                            &branch_short,
                            LocalBranchKind::Jmp,
                            fall_through,
                        );
                    }
                }
                Terminator::Bnz {
                    cond,
                    target,
                    fall_through,
                } => {
                    if let Some(fused) = fused_branch_cc(func, alloc, cond, /* negate */ false) {
                        emit_fused_branch(
                            code,
                            &mut branch_fixups,
                            &branch_short,
                            fused,
                            target,
                            fall_through,
                        );
                        if fall_through as usize != block_idx + 1 {
                            emit_local_branch(
                                code,
                                &mut branch_fixups,
                                &branch_short,
                                LocalBranchKind::Jmp,
                                fall_through,
                            );
                        }
                        continue;
                    }
                    let cond_place = place_of(alloc, cond);
                    let Some(rc) = materialize_int(code, cond_place, SCRATCH_R10, frame) else {
                        bail_msg("Bnz: cond Place not int reg / spill / fp");
                        bail_rollback!();
                    };
                    super::encode::emit_rr(code, Mnem::Test, 8, rc, rc);
                    emit_local_branch(
                        code,
                        &mut branch_fixups,
                        &branch_short,
                        LocalBranchKind::Jcc(Cc::Ne),
                        target,
                    );
                    if fall_through as usize != block_idx + 1 {
                        emit_local_branch(
                            code,
                            &mut branch_fixups,
                            &branch_short,
                            LocalBranchKind::Jmp,
                            fall_through,
                        );
                    }
                }
                Terminator::FallThrough(t) => {
                    if t as usize != block_idx + 1 {
                        emit_local_branch(
                            code,
                            &mut branch_fixups,
                            &branch_short,
                            LocalBranchKind::Jmp,
                            t,
                        );
                    }
                }
                Terminator::GotoIndirect { target } => {
                    // GCC computed goto: branch to the code address in
                    // `target` (materialized by Inst::BlockAddr) via
                    // `jmp r64`.
                    let tplace = place_of(alloc, target);
                    let Some(rt) = materialize_int(code, tplace, SCRATCH_R10, frame) else {
                        bail_msg("GotoIndirect: target Place not int reg / spill");
                        bail_rollback!();
                    };
                    emit_hardened_jmp_r(code, rt, abi, asm_extern_call_sites);
                }
                Terminator::JumpTable { idx, table } => {
                    // Table dispatch through the read-only blob (kept
                    // out of the code section so it never decodes as
                    // instructions). The bounds check preceding this
                    // terminator proves the index in range. Image
                    // output reads a 32-bit table-relative entry and
                    // adds the base back (no load-time relocation);
                    // relocatable output loads an 8-byte absolute
                    // entry, the form whose relocations name the
                    // targets directly.
                    let iplace = place_of(alloc, idx);
                    let Some(rt) = materialize_int(code, iplace, SCRATCH_R10, frame) else {
                        bail_msg("JumpTable: idx Place not int reg / spill");
                        bail_rollback!();
                    };
                    // rt is an allocated register or SCRATCH_R10, never
                    // r11, so the table base cannot alias it. The lea's
                    // disp32 crosses into the read-only blob, so the
                    // writer patches it (RodataAddrFixup).
                    let lea_start = code.len();
                    super::encode::emit_lea_r_rip32(code, SCRATCH_R11, 0);
                    if abs_jump_tables {
                        super::encode::emit_mov_r_sib(code, SCRATCH_R10, SCRATCH_R11, rt, 8);
                    } else {
                        super::encode::emit_movsxd_r_sib(code, SCRATCH_R10, SCRATCH_R11, rt, 4);
                        super::encode::emit_rr(code, Mnem::Add, 8, SCRATCH_R10, SCRATCH_R11);
                    }
                    emit_hardened_jmp_r(code, SCRATCH_R10, abi, asm_extern_call_sites);
                    jump_table_fixups.push((lea_start, table));
                }
                Terminator::AsmGoto { table } => {
                    // The label branches were lowered inside the
                    // `Inst::InlineAsm`; only the fall-through edge
                    // (row entry 0) is emitted here.
                    let fall = func.jump_tables[table as usize][0];
                    if fall as usize != block_idx + 1 {
                        emit_local_branch(
                            code,
                            &mut branch_fixups,
                            &branch_short,
                            LocalBranchKind::Jmp,
                            fall,
                        );
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
                            bail_rollback!();
                        }
                    };
                    plt_call_fixups.push(PltCallFixup {
                        instr_offset: code.len(),
                        import_index,
                        is_tail: true,
                        is_addr: false,
                    });
                    super::encode::emit_jmp_rel32(code, 0);
                }
                // Sealed after a noreturn call (C11 6.7.4p8): control
                // cannot reach here. Emit ud2 so a mis-marked returning
                // call faults rather than falling into the next block.
                Terminator::Unreachable => {
                    code.push(0x0F);
                    code.push(0x0B); // ud2
                }
            }
        }

        // First pass emitted every branch long; decide which can shrink and,
        // if any, reset the body-appended buffers and re-emit. A pass that
        // finds nothing to shorten produces the final layout.
        if branch_short.is_empty() {
            let branches: Vec<(usize, usize, usize, bool)> = branch_fixups
                .iter()
                .map(|fx| {
                    let (opcode_start, long_size) = match fx.kind {
                        LocalBranchKind::Jmp => (fx.site - 1, 5),
                        LocalBranchKind::Jcc(_) => (fx.site - 2, 6),
                    };
                    (opcode_start, long_size, fx.target as usize, fx.pinned_long)
                })
                .collect();
            branch_short = relax_branches(&branches, &block_offsets);
            if branch_short.iter().any(|&s| s) {
                // pc_to_native is index-keyed and overwritten in place by
                // the second pass, so it needs no reset.
                code.truncate(body_code);
                fixups.truncate(body_fixups);
                plt_call_fixups.truncate(body_plt);
                data_fixups.truncate(body_data);
                user_extern_data_refs.truncate(body_uext);
                asm_section_text_refs.truncate(body_asm_xsec);
                asm_text_abs_refs.truncate(body_asm_abs);
                asm_text_labels.truncate(body_asm_labels);
                pending_func_fixups.truncate(body_pending);
                tls_index_fixups.truncate(body_tls);
                elf_tpoff_fixups.truncate(body_elf_tpoff);
                ssa_line_rows.truncate(body_line_rows);
                asm_extern_call_sites.truncate(body_asm_extern);
                asm_sym_fixups.truncate(body_asm_sym);
                asm_sections.restore(&body_asm_sections);
                for b in block_offsets.iter_mut() {
                    *b = 0;
                }
                branch_fixups.clear();
                continue 'emit;
            }
        }
        break 'emit;
    }

    // Patch each `&&label` lea against its block's final offset. The
    // disp32 sits 3 bytes into the 7-byte lea and is measured from the
    // byte after the instruction (`lea_start + LEA_RIP32_LEN`).
    for (lea_start, target_block) in &block_addr_fixups {
        let target_off = block_offsets[*target_block as usize] as i64;
        let rel = target_off - (*lea_start as i64 + super::encode::LEA_RIP32_LEN as i64);
        let imm = match i32::try_from(rel) {
            Ok(v) => v,
            Err(_) => {
                bail_msg("BlockAddr: lea disp32 out of range");
                bail_rollback!();
            }
        };
        code[*lea_start + 3..*lea_start + 7].copy_from_slice(&imm.to_le_bytes());
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
        &body_asm_sections,
        &|bid| block_offsets[bid as usize],
    );

    // Patch recorded branches. The displacement is measured from the
    // byte after the displacement field: `site + 1` for the rel8 short
    // form, `site + 4` for rel32. `relax_branches` guarantees a short
    // branch's target is within the signed 8-bit range.
    for fx in &branch_fixups {
        let target_off = block_offsets[fx.target as usize];
        if fx.short {
            let rel = (target_off as i64) - (fx.site as i64 + 1);
            let imm = match i8::try_from(rel) {
                Ok(v) => v,
                Err(_) => {
                    bail_msg("branch fixup: rel8 out of range");
                    bail_rollback!(tls);
                }
            };
            code[fx.site] = imm as u8;
        } else {
            let rel = (target_off as i64) - (fx.site as i64 + 4);
            let imm = match i32::try_from(rel) {
                Ok(v) => v,
                Err(_) => {
                    bail_msg("branch fixup: rel32 out of range");
                    bail_rollback!(tls);
                }
            };
            code[fx.site..fx.site + 4].copy_from_slice(&imm.to_le_bytes());
        }
    }

    // Materialize each jump table into the read-only blob: one
    // address fixup for the lea site, one slot per entry (a 4-byte
    // `target - table_base` difference, or the relocatable form's
    // 8-byte absolute address left for the object's relocations).
    // Runs past the last bail site so a bailed function leaves the
    // blob untouched.
    for (lea_start, table) in &jump_table_fixups {
        let width: usize = if abs_jump_tables { 8 } else { 4 };
        while !rodata.bytes.len().is_multiple_of(width) {
            rodata.bytes.push(0);
        }
        let base = rodata.bytes.len() as u64;
        rodata.addr_fixups.push(super::RodataAddrFixup {
            code_offset: *lea_start,
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

    // The function emitted end-to-end. Record its [begin, end) extent
    // for the PE writer's per-function unwind table now that no bail
    // can truncate `code`.
    uw.end = code.len() as u32;
    fn_unwind.push(uw);
    true
}

#[derive(Debug, Clone, Copy)]
struct BranchFixup {
    /// Byte offset of the displacement field in `code` (rel8 for a
    /// short branch, rel32 otherwise).
    site: usize,
    target: super::super::ir::BlockId,
    kind: LocalBranchKind,
    /// `true` when the branch was emitted in the 2-byte rel8 form.
    short: bool,
    /// `true` when the branch sits in an inline-asm template, whose bytes
    /// are emitted before relaxation runs and may not change length.
    pinned_long: bool,
}

/// Emit a fused terminator's branch shape: the single `jcc`, or the
/// parity pair an FP `==` / `!=` needs (`JpOr` sends the unordered
/// case to `target`, `JnpAnd` to `fall_through`). The caller emits
/// the trailing `jmp fall_through` when the layout needs one.
fn emit_fused_branch(
    code: &mut alloc::vec::Vec<u8>,
    branch_fixups: &mut alloc::vec::Vec<BranchFixup>,
    branch_short: &[bool],
    fused: FusedBranch,
    target: super::super::ir::BlockId,
    fall_through: super::super::ir::BlockId,
) {
    match fused {
        FusedBranch::Jcc(cc) => {
            emit_local_branch(
                code,
                branch_fixups,
                branch_short,
                LocalBranchKind::Jcc(cc),
                target,
            );
        }
        FusedBranch::JpOr(cc) => {
            emit_local_branch(
                code,
                branch_fixups,
                branch_short,
                LocalBranchKind::Jcc(Cc::P),
                target,
            );
            emit_local_branch(
                code,
                branch_fixups,
                branch_short,
                LocalBranchKind::Jcc(cc),
                target,
            );
        }
        FusedBranch::JnpAnd(cc) => {
            emit_local_branch(
                code,
                branch_fixups,
                branch_short,
                LocalBranchKind::Jcc(Cc::P),
                fall_through,
            );
            emit_local_branch(
                code,
                branch_fixups,
                branch_short,
                LocalBranchKind::Jcc(cc),
                target,
            );
        }
    }
}

/// Emit a local branch to `target`, choosing the 2-byte rel8 short form
/// when `branch_short[idx]` is set (idx = this branch's emission index),
/// and record the fixup. `branch_short` is empty on the first all-long
/// emission pass and is populated by `relax_branches` for the second.
fn emit_local_branch(
    code: &mut alloc::vec::Vec<u8>,
    branch_fixups: &mut alloc::vec::Vec<BranchFixup>,
    branch_short: &[bool],
    kind: LocalBranchKind,
    target: super::super::ir::BlockId,
) {
    let idx = branch_fixups.len();
    let short = branch_short.get(idx).copied().unwrap_or(false);
    match kind {
        LocalBranchKind::Jmp => {
            // EB cb (rel8) / E9 cd (rel32): displacement follows the
            // 1-byte opcode in both forms.
            branch_fixups.push(BranchFixup {
                site: code.len() + 1,
                target,
                kind,
                short,
                pinned_long: false,
            });
            if short {
                super::encode::emit_jmp_rel8(code, 0);
            } else {
                super::encode::emit_jmp_rel32(code, 0);
            }
        }
        LocalBranchKind::Jcc(cc) => {
            // 7x cb (rel8): displacement at +1. 0F 8x cd (rel32): at +2.
            let site = if short {
                code.len() + 1
            } else {
                code.len() + 2
            };
            branch_fixups.push(BranchFixup {
                site,
                target,
                kind,
                short,
                pinned_long: false,
            });
            if short {
                super::encode::emit_jcc_rel8(code, cc, 0);
            } else {
                super::encode::emit_jcc_rel32(code, cc, 0);
            }
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum LocalBranchKind {
    Jmp,
    Jcc(Cc),
}

impl LocalBranchKind {
    /// Bytes preceding the displacement field in the rel32 form: `E9` for
    /// `jmp`, `0F 8x` for `jcc`.
    fn opcode_len(self) -> usize {
        match self {
            LocalBranchKind::Jmp => 1,
            LocalBranchKind::Jcc(_) => 2,
        }
    }
}

/// Decide, per local branch, whether its target is close enough to use
/// the 2-byte rel8 encoding (`EB`/`7x`) instead of the 5/6-byte rel32
/// form (`E9`/`0F 8x`).
///
/// Each entry of `branches` is `(opcode_start, long_size, target_block,
/// pinned_long)` in emission order, where `opcode_start` is the all-long
/// byte offset of the instruction's first byte, `long_size` is 5 (jmp) or
/// 6 (jcc), and `block_offsets` holds each block's all-long byte offset.
/// Both short forms are 2 bytes, so a shortened branch removes
/// `long_size - 2` bytes at its `opcode_start`. A pinned branch keeps the
/// long form whatever its displacement.
///
/// Shortening one branch only reduces the magnitude of every other
/// branch's displacement, so the shortenable set is a monotone fixpoint:
/// start all-long and repeatedly mark a branch short once its
/// displacement -- recomputed against the bytes already removed by the
/// branches marked short so far -- fits a signed 8-bit field. The check
/// excludes a forward branch's own saving, so the estimate is never
/// optimistic: a branch marked short fits in the final layout.
fn relax_branches(
    branches: &[(usize, usize, usize, bool)],
    block_offsets: &[usize],
) -> alloc::vec::Vec<bool> {
    let n = branches.len();
    let mut short = alloc::vec![false; n];
    loop {
        // prefix[k] = bytes removed by short branches among branches[0..k].
        // `opcode_start` is non-decreasing in emission order, so the bytes
        // removed before an offset are a prefix indexed by partition_point.
        let mut prefix = alloc::vec![0usize; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + if short[i] { branches[i].1 - 2 } else { 0 };
        }
        let saved_before =
            |off: usize| -> usize { prefix[branches.partition_point(|b| b.0 < off)] };
        let mut changed = false;
        for i in 0..n {
            if short[i] || branches[i].3 {
                continue;
            }
            let (opcode_start, _long, target, _) = branches[i];
            let instr_end = (opcode_start - saved_before(opcode_start)) + 2;
            let tgt = block_offsets[target] - saved_before(block_offsets[target]);
            let rel = tgt as i64 - instr_end as i64;
            if (-128..=127).contains(&rel) {
                short[i] = true;
                changed = true;
            }
        }
        if !changed {
            break;
        }
    }
    short
}

/// Store a word through rsp to take the fault, if the stack ends here,
/// on the page the allocation just entered. Immediate source and
/// `mov`'s flag transparency keep the probe usable at any point in the
/// lowering: it needs no register and preserves the flags.
fn emit_stack_probe(code: &mut Vec<u8>) {
    super::encode::emit_mi(code, Mnem::Mov, 8, Reg::RSP, 0, 0);
}

/// Reserve the realigned region and align rsp down to `realign_align`
/// (C11 6.7.5). The reservation descends in probed steps; the AND then
/// descends by up to `realign_align - 1` further bytes, which the probe
/// schedule cannot see. When the two together can outrun the unprobed
/// margin, a probe on each side of the AND keeps every step from a touched
/// address within one page, so a stack overflow still faults in the guard.
fn emit_realign_rsp(code: &mut Vec<u8>, frame: Frame) {
    let slack = frame.realign_align - 1;
    let probe = frame.realign_region_bytes.saturating_add(slack) > MAX_UNPROBED_STACK_STEP;
    emit_stack_alloc(code, frame.realign_region_bytes, Some(Reg::R11));
    if probe {
        emit_stack_probe(code);
    }
    super::encode::emit_ri(code, Mnem::And, 8, Reg::RSP, -(frame.realign_align as i32));
    if probe {
        emit_stack_probe(code);
    }
}

/// Lower `rsp -= bytes`, descending in probed steps when the amount is
/// larger than one step can safely cover.
///
/// A decrement of at most [`MAX_UNPROBED_STACK_STEP`] cannot place rsp
/// below the guard region, so it needs no probe. Past that the
/// allocation walks down one page at a time and stores through rsp after
/// each step, so an overflow faults inside the guard region instead of
/// writing into whatever mapping lies below it. `scratch` is a register
/// the caller does not need across the allocation; given one, a step
/// count above [`STACK_PROBE_UNROLL_MAX`] becomes a counted loop instead
/// of straight-line steps.
fn emit_stack_alloc(code: &mut Vec<u8>, bytes: u32, scratch: Option<Reg>) {
    if bytes <= MAX_UNPROBED_STACK_STEP {
        emit_sub_rsp_imm32(code, bytes);
        return;
    }
    let steps = bytes / STACK_PROBE_PAGE;
    let residual = bytes % STACK_PROBE_PAGE;
    match scratch {
        Some(counter) if steps > STACK_PROBE_UNROLL_MAX => {
            super::encode::emit_mov_r_imm64(code, counter, steps as i64);
            let loop_start = code.len();
            emit_sub_rsp_imm32(code, STACK_PROBE_PAGE);
            emit_stack_probe(code);
            super::encode::emit_ri(code, Mnem::Sub, 8, counter, 1);
            super::encode::emit_jcc_rel32(code, super::encode::Cc::Ne, 0);
            let rel = ((loop_start as i64) - (code.len() as i64)) as i32;
            let patch_at = code.len() - 4;
            code[patch_at..patch_at + 4].copy_from_slice(&rel.to_le_bytes());
        }
        _ => {
            for _ in 0..steps {
                emit_sub_rsp_imm32(code, STACK_PROBE_PAGE);
                emit_stack_probe(code);
            }
        }
    }
    if residual > 0 {
        emit_sub_rsp_imm32(code, residual);
        if residual > MAX_UNPROBED_STACK_STEP {
            emit_stack_probe(code);
        }
    }
}

/// then save rbp and proceed.
///
/// `func_start` is `code.len()` at function entry; the returned
/// [`super::FnUnwind`] records every prologue instruction boundary
/// relative to it so the PE writer can build a Win64 `UNWIND_INFO`
/// for the frame. `begin` / `end` are filled by the caller.
/// Save the callee-saved registers the allocator reported: the non-volatile
/// xmm scratch at the frame bottom (full 128-bit movups, the caller's value
/// may occupy the upper lanes) and the callee-saved GPRs directly above at
/// sp + saved_fpr_bytes. SysV leaves fp_used empty. One source for the
/// offsets so the prologue and every return path agree.
fn save_callee_saved(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame) {
    for (i, &r) in alloc.fp_used.iter().enumerate() {
        emit_movups_mem_xmm(code, Reg::RSP, (i as i32) * 16, Reg(r));
    }
    let saved_fpr_bytes = frame.saved_fpr_bytes as i32;
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        super::encode::emit_mov_mem_r(code, Reg::RSP, saved_fpr_bytes + (i as i32) * 8, Reg(r));
    }
}

/// Re-establish `rsp = rbp - frame_bytes` in a dynamic-sp frame before
/// the epilogue's rsp-relative restores. No-op for static frames. Every
/// return path calls this ahead of [`restore_callee_saved`].
fn restore_dynamic_sp(code: &mut Vec<u8>, frame: Frame) {
    if frame.dynamic_sp {
        emit_lea_r_mem(code, Reg::RSP, Reg::RBP, -(frame.frame_bytes as i32));
    }
}

/// Restore what [`save_callee_saved`] saved, in mirror order. Every return
/// path routes through this so the saved-region offsets cannot drift.
fn restore_callee_saved(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame) {
    let saved_fpr_bytes = frame.saved_fpr_bytes as i32;
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        super::encode::emit_mov_r_mem(code, Reg(r), Reg::RSP, saved_fpr_bytes + (i as i32) * 8);
    }
    for (i, &r) in alloc.fp_used.iter().enumerate() {
        emit_movups_xmm_mem(code, Reg(r), Reg::RSP, (i as i32) * 16);
    }
}

/// Emit the function prologue: spill the host-ABI argument registers
/// into the c5 cdecl parameter cells the body references via
/// address-of-local with slot index `N >= 2` (the first declared
/// parameter at `[rbp + 16]`, the second at `[rbp + 32]`, ...), then
/// establish the frame and save the callee-saved registers. SysV /
/// Win64 push the return address before `call`, so the cell block is
/// interleaved with the saved rbp: pop the return address into r10,
/// reserve the cells, fill each from its placement, push the return
/// address back.
fn emit_prologue(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    func_start: usize,
) -> super::FnUnwind {
    let mut uw = super::FnUnwind {
        param_spill_bytes: frame.param_spill_bytes,
        frame_bytes: frame.frame_bytes,
        ..super::FnUnwind::default()
    };
    let rel = |code: &Vec<u8>| (code.len() - func_start) as u32;
    // Host-arg-reg spill. `frame.param_spill_bytes` is the
    // single source of truth for how many bytes get allocated
    // here; the epilogue reads the same value to undo the same
    // bytes. Variadic callees, fully-Native callees with every
    // parameter `ParamRef`-seeded, and 0-param callees all
    // produce 0 and skip the entire `pop r10` / `push r10`
    // sequence (the return address stays at the top of the stack
    // where the caller pushed it).
    let entry_spill = if func.is_variadic { 0 } else { func.n_params };
    if entry_spill > 0 && frame.param_spill_bytes > 0 {
        emit_pop_r(code, Reg::R10);
        let (elidable, _n_reg, _n_stack) = param_elidable_mask(func, alloc, abi);
        let placements = param_placements(func, abi);
        // One contiguous c5 cdecl cell block, `n_params` 16-byte cells.
        // Parameter `i` reads its value through `LoadLocal { off: i+2 }`
        // from cell `[rsp + 16*i]` here (equivalently `[rbp + 16*(i+1)]`
        // after the frame is established). The incoming argument area --
        // the caller's outgoing stack, including any shadow space --
        // begins at `[rsp + cells]`; a stack-passed parameter sits at the
        // planner's byte offset within it. Filling each cell by its own
        // placement (rather than as a contiguous register prefix plus a
        // contiguous stack suffix) lets a register-passed parameter and a
        // stack-passed one interleave, which happens when a by-value
        // aggregate that consumes no argument register sits between
        // register parameters (System V MEMORY class), or when a Win64
        // aggregate overflows past the four positional registers.
        let cells = frame.param_spill_bytes;
        debug_assert_eq!(cells, (func.n_params as u32) * 16);
        // The argument registers hold the incoming values and r10 the
        // popped return address, so the walk takes no scratch register.
        emit_stack_alloc(code, cells, None);
        for i in 0..func.n_params {
            let cell = (i as i32) * 16;
            match placements.get(i).copied() {
                // A register parameter whose home cell is unobserved
                // (mem2reg promoted it, no LocalAddr / live LoadLocal)
                // has a dead store per C99 6.2.4p2; the cell stays
                // reserved so the other parameters keep their offsets.
                Some(super::ArgPlacement::IntReg(r)) => {
                    if !elidable.get(i).copied().unwrap_or(false) {
                        emit_mov_mem_r(code, Reg::RSP, cell, Reg(r));
                    }
                }
                Some(super::ArgPlacement::FpReg(x)) => {
                    if !elidable.get(i).copied().unwrap_or(false) {
                        emit_movsd_mem_xmm(code, Reg::RSP, cell, Reg(x));
                    }
                }
                // Stack-overflow scalar: restripe from the incoming stack
                // into the cell. `off` already includes any shadow space.
                Some(super::ArgPlacement::Stack(off)) => {
                    let src = (cells as i32) + off as i32;
                    emit_mov_r_mem(code, Reg::RAX, Reg::RSP, src);
                    emit_mov_mem_r(code, Reg::RSP, cell, Reg::RAX);
                }
                // Aggregate parameters keep a dead cell; their value is
                // placed later from the argument registers
                // (`emit_struct_param_scatter`) or copied from the
                // incoming stack (`emit_struct_stack_param_copy`).
                _ => {}
            }
        }
        emit_push_r(code, Reg::R10);
        // Net stack effect of the group is -M; the unwinder recovers
        // it as one UWOP_ALLOC at the end of the re-push.
        uw.arg_spill_end = rel(code);
    }

    // Leaf-function elision: a function that makes no calls
    // (the caller's return address stays at top of stack), has no
    // frame to allocate, spills no params, and saves no callee
    // regs has no work in the standard prologue. SysV / Win64 let
    // it ret directly off the caller-pushed return address with
    // rsp unchanged.
    if is_full_leaf(func, frame, alloc, abi) {
        uw.leaf = true;
        return uw;
    }
    // Standard frame: push rbp; mov rbp, rsp; sub rsp, frame_bytes.
    emit_push_r(code, Reg::RBP);
    uw.push_rbp_end = rel(code);
    emit_mov_rr(code, Reg::RBP, Reg::RSP);
    uw.set_fpreg_end = rel(code);
    // Win64 variadic callee home-area spill (Microsoft x64 calling
    // convention). The caller passes the first four arguments in
    // rcx/rdx/r8/r9 by position and reserves 32 bytes of home area
    // above the return address; the callee spills those registers into
    // the home slots at `[rbp + 16 + i*8]` so the named parameters are
    // readable through the body's c5 cdecl cell path (cell stride 8,
    // set on `Frame`) and the home area joins the incoming stack
    // overflow into one contiguous 8-byte-stride region the variadic
    // tail occupies. Arguments past the fourth already sit on the
    // incoming stack at `[rbp + 16 + i*8]`, so they need no spill. The
    // Win64 host variadic ABI (Microsoft x64 calling convention) routes
    // every argument (named and variadic) through the integer registers
    // as a raw 8-byte value (the caller widens floating-point arguments
    // to double and passes `fp_arg_mask = 0`), so the spill is uniformly
    // integer.
    //
    // Spill ALL four argument registers, not just the named ones: a
    // variadic argument that landed in a register (rdx/r8/r9 for the
    // second through fourth argument position) must reach the home area
    // for `va_arg` to read it, and the caller reserves the full 32-byte
    // home regardless of the argument count, so the stores never fall
    // outside it. The body reads only the named slots; the surplus
    // stores feed `va_arg`.
    if win64_variadic_callee(func, abi) {
        for (i, &reg) in abi.int_arg_regs.iter().enumerate() {
            let home_off = (16 + i * 8) as i32;
            emit_mov_mem_r(code, Reg::RBP, home_off, Reg(reg));
        }
    }
    if frame.frame_bytes > 0 {
        // A single `sub rsp,N` lowers to one instruction the unwinder
        // can describe with `UWOP_ALLOC`; a probed frame lowers to a
        // multi-step walk with no single `sub` and is left undescribed
        // (SizeOfProlog still covers it, and the frame-pointer rule
        // recovers RSP exactly at any body fault, which is where the
        // unwinder samples). `frame_alloc_end == 0` is the "no single
        // sub" sentinel `build_unwind_codes` reads.
        let single_sub = frame.frame_bytes <= MAX_UNPROBED_STACK_STEP;
        // r11 is caller-saved, is no target's argument register, and
        // carries no live value in the prologue.
        emit_stack_alloc(code, frame.frame_bytes, Some(Reg::R11));
        if single_sub {
            uw.frame_alloc_end = rel(code);
        }
    }
    // System V variadic callee register save area (System V AMD64
    // 3.5.7). Spill the six integer argument registers rdi rsi rdx rcx
    // r8 r9 into the gp area at `[reg_save + 0 .. 48]` and the eight XMM
    // argument registers xmm0..xmm7 into the fp area at
    // `[reg_save + 48 .. 176]`. The named parameters read their values
    // from this area too (`local_slot_off` redirects positive c5 cdecl
    // slots here), and `va_start` / `va_arg` walk it for the variadic
    // tail. `reg_save` is `[rbp + va_reg_save_off]`; the spill writes
    // address it through rbp so it is independent of the rsp moves the
    // body makes for outgoing-call scratch.
    //
    // The XMM spill is guarded by the caller-passed XMM-register count
    // in `al` (System V AMD64 3.2.3): when the caller passed no
    // floating-point arguments (`al == 0`) the XMM save area is unused,
    // and skipping the eight `movsd` stores avoids touching xmm regs the
    // caller never set. The integer spill is unconditional -- the gp
    // area always holds the (named + variadic) integer arguments.
    if sysv_variadic_callee(func, abi) {
        let reg_save = frame.va_reg_save_off;
        for (i, &reg) in abi.int_arg_regs.iter().enumerate() {
            emit_mov_mem_r(code, Reg::RBP, reg_save + (i as i32) * 8, Reg(reg));
        }
        // Under `-mno-sse` the XMM save is omitted entirely: the target
        // environment faults on any XMM access and its callers do not
        // maintain the `al` count, so even the guarded form is unsafe.
        if !abi.no_fp_varargs {
            // test al, al ; je past_fp_save
            super::encode::emit_test_al_al(code);
            super::encode::emit_jcc_rel32(code, Cc::E, 0);
            // The rel32 operand occupies the four bytes just emitted; the
            // jump is relative to the end of the je instruction (which is
            // where the XMM stores begin).
            let rel32_at = code.len() - 4;
            let fp_save_start = code.len();
            for i in 0..8u32 {
                let off = reg_save + SYSV_GP_SAVE_BYTES as i32 + (i as i32) * 16;
                emit_movsd_mem_xmm(code, Reg::RBP, off, Reg(i as u8));
            }
            let rel = (code.len() - fp_save_start) as i32;
            code[rel32_at..rel32_at + 4].copy_from_slice(&rel.to_le_bytes());
        }
    }
    // The allocator's FP register pool (`callee_fprs`) is empty for both
    // SysV and Win64, so it never assigns an SSA value to a non-volatile
    // xmm. The only non-volatile xmm exposure is the emit pass's fixed
    // FP scratch (xmm13/14/15), which the allocator lists in `fp_used`
    // for Win64 functions that perform FP work. Save those at the bottom
    // of the frame (lowest addresses) with the full 128-bit `movups`,
    // since the caller's value may occupy the upper lanes. SysV leaves
    // `fp_used` empty.
    save_callee_saved(code, alloc, frame);
    emit_struct_param_scatter(code, func, frame, abi);
    emit_struct_stack_param_copy(code, func, frame, abi);
    // C11 6.7.5: reserve the over-aligned objects' region below the static
    // frame and align rsp down into it. Done last, after the callee-saved
    // stores (which stay at rbp-frame_bytes, where the epilogue's
    // restore_dynamic_sp puts rsp back); the objects live at [rsp + region_off].
    // Reserving before aligning keeps the AND's descent inside bytes the
    // reservation already claimed, so the region cannot overlap the frame.
    if frame.realign_align > 0 {
        emit_realign_rsp(code, frame);
    }
    uw
}

/// Copy each aggregate parameter the host ABI passes inline on the
/// stack (System V AMD64 MEMORY class with size > 16, or a Win64
/// aggregate that overflows past the four positional registers) into its
/// parser-reserved body local. The caller placed the struct in its
/// outgoing argument area, which sits above the return address at callee
/// entry; after the c5 cdecl entry spill (`n_params` 16-byte cells) it is
/// reachable at `[rbp + 16 + n_params*16 + off]`, where `off` is the
/// planner's byte offset of the parameter in the outgoing area. The dead
/// cell the entry spill reserves for the aggregate keeps the slot->cell
/// map positional; the body reads the struct from the synthetic body
/// local this copy fills. Runs after the frame is set up, so the
/// addresses are rbp-relative and SCRATCH_R10 is free.
fn emit_struct_stack_param_copy(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    frame: Frame,
    abi: super::Abi,
) {
    if func.param_aggs.iter().all(Option::is_none) {
        return;
    }
    let placements = param_placements(func, abi);
    if !placements
        .iter()
        .any(|p| matches!(p, super::ArgPlacement::StructStack { .. }))
    {
        return;
    }
    let base = 16 + (func.n_params as i64) * 16;
    for (i, &placement) in placements.iter().enumerate() {
        let super::ArgPlacement::StructStack { off, size, .. } = placement else {
            continue;
        };
        let slot = func.param_local_slots.get(i).copied().unwrap_or(0);
        if slot >= 0 {
            continue;
        }
        let src_off = base + off as i64;
        let dst_off = local_slot_off(slot, func, frame, abi);
        let words = (size / 8) as i64;
        for w in 0..words {
            let o = w * 8;
            emit_mov_r_mem(code, SCRATCH_R10, Reg::RBP, (src_off + o) as i32);
            emit_mov_mem_r(code, Reg::RBP, (dst_off + o) as i32, SCRATCH_R10);
        }
        for b in (words * 8)..(size as i64) {
            super::encode::emit_movzx_r_mem8(code, SCRATCH_R10, Reg::RBP, (src_off + b) as i32);
            super::encode::emit_mov_mem8_r(code, Reg::RBP, (dst_off + b) as i32, SCRATCH_R10);
        }
    }
}

/// Store each register-passed aggregate parameter's incoming argument
/// registers into its parser-reserved body local (System V AMD64
/// 3.2.3). Runs after the frame is established; the argument registers
/// still hold the caller-supplied values, since nothing between entry
/// and here clobbers them. The body reads the aggregate from this
/// local, so the entry argument cell stays unused.
fn emit_struct_param_scatter(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    frame: Frame,
    abi: super::Abi,
) {
    if func.param_aggs.iter().all(Option::is_none) {
        return;
    }
    let placements = param_placements(func, abi);
    for (i, agg) in func.param_aggs.iter().enumerate() {
        if agg.is_none() {
            continue;
        }
        let Some(super::ArgPlacement::StructRegs { regs, n, .. }) = placements.get(i) else {
            continue;
        };
        let slot = func.param_local_slots.get(i).copied().unwrap_or(0);
        if slot >= 0 {
            continue;
        }
        let base = local_slot_off(slot, func, frame, abi);
        for (k, cr) in regs.iter().take(*n as usize).enumerate() {
            let off = (base + (k as i64) * 8) as i32;
            if cr.is_fp {
                super::encode::emit_movsd_mem_xmm(code, Reg::RBP, off, Reg(cr.reg));
            } else {
                super::encode::emit_mov_mem_r(code, Reg::RBP, off, Reg(cr.reg));
            }
        }
    }
}

/// Branch shape for a fused compare's terminator. An integer compare
/// and the parity-clean FP compares take one `jcc`; `ucomisd` raises
/// PF on an unordered (NaN) compare, so `==` / `!=` need it tested by
/// a second branch (C99 6.5.9p3: `==` yields 0 on NaN, `!=` yields 1).
enum FusedBranch {
    /// `jcc target`.
    Jcc(Cc),
    /// Taken when PF=1 or `cc` holds: `jp target ; jcc target`.
    JpOr(Cc),
    /// Taken when PF=0 and `cc` holds: `jp fall_through ; jcc target`.
    JnpAnd(Cc),
}

/// Whether a fused `Flt` / `Fle` compare emits `ucomisd rhs, lhs`.
/// The swap turns them into the `>` / `>=` shapes whose `A` / `Ae`
/// (and inverted `Be` / `B`) condition codes are exact under the
/// unordered flag state, so the branch needs no parity test. The
/// compare emit and [`fused_branch_cc`] both derive the swap from the
/// inst so they agree.
fn fused_fp_swaps_operands(op: BinOp) -> bool {
    matches!(op, BinOp::Flt | BinOp::Fle)
}

/// Return the branch shape to use when the terminator's cond was
/// flagged as branch-fused by the allocator. `negate` is true for
/// `Bz` (branch when comparison failed).
fn fused_branch_cc(
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    cond: super::super::ir::ValueId,
    negate: bool,
) -> Option<FusedBranch> {
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
    if let Some(positive) = int_cmp_cc(op) {
        // A `cmp`-set flag state is never "unordered": inverting the
        // cc is the exact negation.
        let cc = if negate {
            invert_cc(positive)?
        } else {
            positive
        };
        return Some(FusedBranch::Jcc(cc));
    }
    // FP compares. `ucomisd` leaves ZF=PF=CF=1 on NaN: `A` / `Ae` are
    // false there and their inversions `Be` / `B` true, matching C99
    // 6.5.8p6 for the ordered compares (`Flt` / `Fle` were emitted
    // operand-swapped into those shapes); `==` / `!=` carry the
    // parity test in the branch shape.
    Some(match op {
        BinOp::Fgt | BinOp::Flt => FusedBranch::Jcc(if negate { Cc::Be } else { Cc::A }),
        BinOp::Fge | BinOp::Fle => FusedBranch::Jcc(if negate { Cc::B } else { Cc::Ae }),
        BinOp::Feq => {
            if negate {
                FusedBranch::JpOr(Cc::Ne)
            } else {
                FusedBranch::JnpAnd(Cc::E)
            }
        }
        BinOp::Fne => {
            if negate {
                FusedBranch::JnpAnd(Cc::E)
            } else {
                FusedBranch::JpOr(Cc::Ne)
            }
        }
        _ => return None,
    })
}

/// Logical complement of an integer-compare condition code.
fn invert_cc(cc: Cc) -> Option<Cc> {
    Some(match cc {
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
/// Read-only per-function context threaded through the per-instruction
/// lowering. Bundles the loop-invariant inputs so emit_inst's signature stays
/// short; Copy (references and small scalars).
#[derive(Clone, Copy)]
struct FnCtx<'a> {
    func: &'a FunctionSsa,
    alloc: &'a Allocation,
    frame: Frame,
    abi: super::Abi,
    target: Target,
    imports: &'a super::ResolvedImports,
    variadic_targets: &'a alloc::collections::BTreeSet<usize>,
    extern_tls_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    /// `Inst::ImmData` value-id -> cross-TU data symbol name, for an `i`-class
    /// inline-asm operand that names an external address, whether in a section
    /// field or via a `%a` address operand.
    extern_data_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    /// `Inst::ImmCode` value-id -> cross-TU function symbol name, for a `%c`
    /// function operand a replacement `call` / `jmp` in a section relocates
    /// against (`call %c[new]` in `.altinstr_replacement`).
    extern_code_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    tls_total_size: usize,
    param_from_home: &'a [bool],
    param_plan: &'a [super::ArgPlacement],
    /// Function name -> entry PC, for resolving an inline-asm `call`/`jmp` to a
    /// bare symbol into a relocation.
    name2entpc: &'a alloc::collections::BTreeMap<alloc::string::String, usize>,
}

fn emit_inst(
    cx: &mut super::ssa::emit_common::EmitCtx,
    inst: &Inst,
    v: super::super::ir::ValueId,
    dst: Place,
    fcx: &FnCtx,
    fixups: &mut Vec<Fixup>,
    asm_section_text_refs: &mut Vec<super::AsmSectionTextRef>,
    asm_text_abs_refs: &mut Vec<super::AsmTextAbsRef>,
    asm_text_labels: &mut Vec<super::AsmTextLabel>,
) -> bool {
    // Unpack the read-only per-function context into the per-field names the
    // lowering below uses, so the body is unchanged.
    let FnCtx {
        func,
        alloc,
        frame,
        abi,
        target,
        imports,
        variadic_targets,
        extern_tls_names,
        extern_data_names,
        extern_code_names,
        tls_total_size,
        param_from_home,
        param_plan,
        name2entpc,
    } = *fcx;
    // The bundled emit output now arrives in `cx`; recreate the per-field
    // names as disjoint reborrows so the per-`Inst` lowering below is unchanged.
    let code = &mut *cx.code;
    let plt_call_fixups = &mut *cx.plt_call_fixups;
    let data_fixups = &mut *cx.data_fixups;
    let user_extern_data_refs = &mut *cx.user_extern_data_refs;
    let pending_func_fixups = &mut *cx.pending_func_fixups;
    let tls_index_fixups = &mut *cx.tls_index_fixups;
    let elf_tpoff_fixups = &mut *cx.elf_tpoff_fixups;
    let asm_sections = &mut *cx.asm_sections;
    let asm_extern_call_sites = &mut *cx.asm_extern_call_sites;
    match inst {
        Inst::AllocaInit(slot) => {
            // Slot 0: this function doesn't use alloca. Non-zero:
            // the function moves rsp at runtime; `Frame::dynamic_sp`
            // carries the fact to the spill addressing, the alloca
            // intrinsics, and the epilogue. No code either way.
            let _ = slot;
            true
        }
        Inst::ParamRef { idx, kind } => {
            // Materialise the i-th host-ABI argument into the
            // allocator's chosen `Place`, sign-extending the low
            // `kind` bytes per C99 6.3.1.3 so the value held in the
            // register is canonically 64-bit-sign-extended.
            //
            // The incoming argument register (rdi rsi rdx rcx r8 r9
            // on System V; rcx rdx r8 r9 on Win64) is not always
            // pristine at this IR position: when an earlier-emitted
            // `ParamRef` wrote to this parameter's argument register
            // (the allocator packed sequentially-live parameters into
            // one register), reading it would take the earlier
            // parameter's value. `param_from_home` marks those at-risk
            // parameters; they are non-elidable, so the prologue
            // spilled them to their c5 cdecl home cell at
            // `[rbp + (idx+1)*16]`, which survives the clobber. The
            // unmarked parameters read the argument register directly.
            // Narrow-load promotion downstream can then collapse
            // `Inst::Extend` to a plain copy when the kinds match.
            let i = *idx as usize;
            // Floating-point parameter (C99 6.2.5p10): its value arrives
            // in an FP argument register named by the plan. Read that
            // xmm register into the allocator's FP dst (FpReg or Spill).
            // A `float` (`LoadKind::F32`) occupies the low 32 bits of the
            // s-register; the body re-narrows it through the f32 store
            // the walker seeded. A scalar copy preserves the relevant
            // bits for either width.
            if matches!(kind, LoadKind::F32 | LoadKind::F64) {
                // An at-risk FP parameter (its incoming xmm overwritten by
                // an earlier FP `ParamRef`'s destination, per
                // `param_home_clobber_set`) reads its prologue-spilled c5
                // cdecl home cell instead of the clobbered register. The
                // prologue stored the cell from the pristine argument
                // register before any body instruction ran.
                if param_from_home.get(i).copied().unwrap_or(false) {
                    let home_off =
                        c5_slot_to_fp_offset(*idx as i64 + 2, frame.param_cell_stride) as i32;
                    let load = |code: &mut Vec<u8>, r: Reg| {
                        if matches!(kind, LoadKind::F32) {
                            emit_movss_xmm_mem(code, r, Reg::RBP, home_off);
                        } else {
                            emit_movsd_xmm_mem(code, r, Reg::RBP, home_off);
                        }
                    };
                    match dst {
                        Place::FpReg(r) => load(code, Reg(r)),
                        Place::Spill(_) => {
                            load(code, SCRATCH_XMM14);
                            fp_spill_dst_to_slot(code, dst, SCRATCH_XMM14, frame);
                        }
                        _ => return fail("ParamRef: FP param dst not fp reg / spill"),
                    }
                    return true;
                }
                let Some(super::ArgPlacement::FpReg(x)) = param_plan.get(i).copied() else {
                    return fail("ParamRef: FP param not in an FP argument register");
                };
                let xmm = Reg(x);
                match dst {
                    Place::FpReg(r) => {
                        if r != x {
                            emit_movapd_xmm_xmm(code, Reg(r), xmm);
                        }
                    }
                    Place::Spill(_) => fp_spill_dst_to_slot(code, dst, xmm, frame),
                    _ => return fail("ParamRef: FP param dst not fp reg / spill"),
                }
                return true;
            }
            let from_home = param_from_home.get(i).copied().unwrap_or(false);
            let home_off = c5_slot_to_fp_offset(*idx as i64 + 2, frame.param_cell_stride) as i32;
            // The incoming integer register comes from the plan, not the
            // absolute parameter index: a floating-point parameter
            // earlier in the list consumes an FP register and does not
            // shift the integer bank, so the i-th declared parameter is
            // not the i-th integer register. A stack-passed integer
            // parameter has no incoming register and is always read from
            // its prologue-filled home cell.
            let arg_reg = match param_plan.get(i).copied() {
                Some(super::ArgPlacement::IntReg(r)) => Reg(r),
                _ if from_home => Reg(0),
                _ => return fail("ParamRef: int param has no incoming integer register"),
            };
            // The caller passes the raw 64-bit value, so an I8/I16
            // conversion always runs; an I32 extend touches only
            // bits 32..63 and is skipped when no consumer reads them.
            let high_dead = !alloc.high_observed.get(v as usize).copied().unwrap_or(true);
            let materialize = |code: &mut Vec<u8>, rd: Reg| {
                if from_home {
                    match kind {
                        LoadKind::I8 => {
                            super::encode::emit_movsx_r_mem8(code, rd, Reg::RBP, home_off)
                        }
                        LoadKind::I16 => {
                            super::encode::emit_movsx_r_mem16(code, rd, Reg::RBP, home_off)
                        }
                        LoadKind::I32 if !high_dead => {
                            super::encode::emit_movsxd_r_mem(code, rd, Reg::RBP, home_off)
                        }
                        _ => emit_mov_r_mem(code, rd, Reg::RBP, home_off),
                    }
                } else {
                    match kind {
                        LoadKind::I8 => super::encode::emit_movsx_r_r8(code, rd, arg_reg),
                        LoadKind::I16 => super::encode::emit_movsx_r_r16(code, rd, arg_reg),
                        LoadKind::I32 if !high_dead => {
                            super::encode::emit_movsxd_r_r(code, rd, arg_reg)
                        }
                        _ => emit_mov_rr(code, rd, arg_reg),
                    }
                }
            };
            match dst {
                Place::IntReg(r) => materialize(code, Reg(r)),
                Place::Spill(_) => {
                    materialize(code, SCRATCH_R10);
                    spill_dst_to_slot(code, dst, SCRATCH_R10, frame);
                }
                _ => return fail("ParamRef: dst not int reg / spill"),
            }
            true
        }
        Inst::Imm(value) => {
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("Imm: dst not int reg / spill");
            };
            emit_mov_r_imm64(code, rd, *value);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        Inst::LocalAddr(off) => {
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("LocalAddr: dst not int reg / spill");
            };
            // c5 cdecl: param i (i >= 2) sits at [rbp + 16*(i-1)]; locals
            // (i < 0) sit at [rbp + 8*i]. An over-aligned automatic object is
            // addressed sp-relative in the realigned region; a System V
            // variadic callee redirects named-parameter slots into the
            // register save area (see `local_slot_base_disp`). The 32-bit
            // signed `disp` covers any frame our compiler emits; larger bail.
            let (base, bytes) = local_slot_base_disp(*off, func, frame, abi);
            let Ok(disp) = i32::try_from(bytes) else {
                return fail("LocalAddr: offset doesn't fit in disp32");
            };
            emit_lea_r_mem(code, rd, base, disp);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
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
            None,
            alloc.is_f32(v),
            alloc,
            frame,
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
            v,
            *addr,
            *disp,
            *value,
            *kind,
            None,
            alloc,
            frame,
            narrow_bound(*align, abi),
        ),
        Inst::SegLoad {
            addr, kind, seg, ..
        } => emit_load(
            code,
            dst,
            *addr,
            0,
            *kind,
            seg_prefix(*seg),
            alloc.is_f32(v),
            alloc,
            frame,
            None,
        ),
        Inst::SegStore {
            addr,
            value,
            kind,
            seg,
            ..
        } => emit_store(
            code,
            dst,
            v,
            *addr,
            0,
            *value,
            *kind,
            seg_prefix(*seg),
            alloc,
            frame,
            None,
        ),
        Inst::LoadLocal { off, kind, .. } => {
            emit_load_local(code, dst, *off, *kind, alloc.is_f32(v), frame, func, abi)
        }
        Inst::StoreLocal {
            off, value, kind, ..
        } => emit_store_local(code, dst, v, *off, *value, *kind, alloc, frame, func, abi),
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
            abi,
            fixups,
            variadic_targets.contains(target_pc),
            *fp_return,
            *fp_arg_mask,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
            func,
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
            abi,
            target,
            plt_call_fixups,
            imports,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
            func,
        ),
        Inst::ImmData(offset) => emit_imm_data(code, dst, *offset, data_fixups, frame),
        Inst::ImmCode(target_ent_pc) => {
            emit_imm_code(code, dst, *target_ent_pc, pending_func_fixups, frame)
        }
        Inst::ImmExtCode(binding_idx) => {
            emit_imm_ext_code(code, dst, *binding_idx, plt_call_fixups, imports, frame)
        }
        // Inst::BlockAddr is handled in emit_function's block loop
        // (it needs the local block_offsets table for its PC-relative
        // lea fixup), so it never reaches emit_inst.
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
        ),
        Inst::AtomicRmw {
            op,
            addr,
            value,
            width,
        } => emit_atomic_rmw(code, dst, *op, *addr, *value, *width, alloc, frame),
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
            abi,
            *fp_return,
            *fp_arg_mask,
            arg_aggs,
            &func.agg_descs,
            *ret_agg,
            *ret_slot_local,
            func,
            asm_extern_call_sites,
        ),
        Inst::Intrinsic { kind, args } => {
            emit_intrinsic(code, *kind, args, dst, v, func, alloc, frame, abi)
        }
        Inst::InlineAsm { asm, args } => emit_inline_asm(
            code,
            asm,
            args,
            func,
            alloc,
            frame,
            fixups,
            name2entpc,
            extern_data_names,
            extern_code_names,
            asm_sections,
            asm_extern_call_sites,
            &mut *cx.asm_sym_fixups,
            data_fixups,
            pending_func_fixups,
            user_extern_data_refs,
            asm_section_text_refs,
            asm_text_abs_refs,
            asm_text_labels,
            cx.text_align,
            None,
        ),
        Inst::Fneg(value) => emit_fneg(code, dst, v, *value, alloc, frame),
        Inst::Fma {
            a,
            b,
            c,
            neg_product,
            neg_addend,
        } => emit_fma(
            code,
            dst,
            v,
            *a,
            *b,
            *c,
            *neg_product,
            *neg_addend,
            alloc,
            frame,
        ),
        Inst::Extend { value, kind } => emit_extend(code, dst, *value, *kind, alloc, frame),
        Inst::Bswap { value, width } => emit_bswap(code, dst, *value, *width, alloc, frame),
        Inst::Copy { value, is_fp } => emit_copy(code, dst, *value, *is_fp, alloc, frame),
        Inst::FpCast { kind, value } => emit_fp_cast(code, dst, v, *kind, *value, alloc, frame),
        Inst::TlsAddr(offset) => emit_tls_addr(
            code,
            dst,
            *offset,
            v,
            target,
            tls_index_fixups,
            elf_tpoff_fixups,
            extern_tls_names,
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
                other.variant_name()
            ));
            let _ = frame;
            false
        }
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
    v: super::super::ir::ValueId,
    target: Target,
    tls_index_fixups: &mut Vec<super::TlsIndexFixup>,
    elf_tpoff_fixups: &mut Vec<super::ElfTpoffFixup>,
    extern_tls_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    tls_total_size: usize,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("TlsAddr: dst not int reg / spill");
    };
    match target {
        Target::LinuxX64 => {
            // A cross-unit `extern _Thread_local` carries the referenced
            // symbol in `extern_tls_names`; its TPOFF is unknown until
            // the link merges the TLS blocks, so emit a 0 placeholder and
            // record an extern fixup. A same-unit access bakes the
            // single-unit TPOFF (`tls_total_size - offset`, correct for an
            // in-memory or single-object emit) and also records a fixup so
            // the linker re-patches it against the merged layout when more
            // than one unit contributes TLS storage.
            let extern_sym = extern_tls_names.get(&v).cloned();
            // Variant-2 TPOFF is negative: the block sits below the
            // thread pointer, `var = fs:[0] + (offset - tls_total)`.
            // Emitting an `add` with the signed immediate (rather than
            // a `sub` of the magnitude) keeps the field patchable with
            // the standard negative TPOFF value.
            let tpoff = if extern_sym.is_some() {
                0
            } else {
                let t = offset - (tls_total_size as i64);
                if !(i32::MIN as i64..=0).contains(&t) {
                    return fail("TlsAddr: tpoff out of i32 range");
                }
                t
            };
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
            // add rd, imm32
            //   REX.W=1, REX.B = (rd >= 8);
            //   opcode 81 /0;
            //   ModR/M mod=11 reg=0 rm=rd.lo;
            //   imm32 = tpoff (patched by the linker per the fixup).
            let rex_add = 0x48 | ((rd.0 >> 3) & 1);
            code.push(rex_add);
            code.push(0x81);
            code.push(0xC0 | (rd.0 & 7));
            let imm_offset = code.len();
            code.extend_from_slice(&(tpoff as i32).to_le_bytes());
            elf_tpoff_fixups.push(super::ElfTpoffFixup {
                imm_offset,
                target: match extern_sym {
                    Some(name) => super::ElfTpoffTarget::Extern(name),
                    None => super::ElfTpoffTarget::Local(offset as u64),
                },
            });
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        Target::WindowsX64 => {
            if !(i32::MIN as i64..=i32::MAX as i64).contains(&offset) {
                return fail("TlsAddr: offset out of i32 range");
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
            // lea rd, [r10 + disp32]: r10 already holds the module's TLS
            // block base, so disp32 is the variable's offset within the
            // merged block with no thread-pointer bias. A cross-unit
            // `extern _Thread_local` offset is unknown until the link merges
            // the TLS blocks, so emit a 0 placeholder; a same-unit access
            // bakes its raw block offset. Both record an `elf_tpoff_fixups`
            // entry so the linker rebases the disp32 to the merged offset
            // (Local) or resolves it by symbol (Extern).
            //   REX.W=1, REX.R = (rd >= 8), REX.B=1 (r10 base);
            //   opcode 8D;
            //   ModR/M mod=10 (disp32), reg=rd.lo, rm=010 (r10).
            let extern_sym = extern_tls_names.get(&v).cloned();
            let disp: i64 = if extern_sym.is_some() { 0 } else { offset };
            let rex_lea = 0x49 | (if rd.0 >= 8 { 0x04 } else { 0 });
            code.push(rex_lea);
            code.push(0x8D);
            code.push(0x82 | ((rd.0 & 7) << 3));
            let imm_offset = code.len();
            code.extend_from_slice(&(disp as i32).to_le_bytes());
            elf_tpoff_fixups.push(super::ElfTpoffFixup {
                imm_offset,
                target: match extern_sym {
                    Some(name) => super::ElfTpoffTarget::Extern(name),
                    None => super::ElfTpoffTarget::Local(offset as u64),
                },
            });
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        _ => fail("TlsAddr: target not x86_64"),
    }
}

use super::ssa::emit_common::c5_slot_to_fp_offset;

/// rbp-relative byte offset of the c5 cdecl slot `off` for the
/// current callee, accounting for the System V variadic register
/// save area.
///
/// For a non-variadic callee (and every non-SysV target) this is the
/// plain `c5_slot_to_fp_offset`: positive c5 cdecl parameter cells at
/// `[rbp + 16 + (off-2)*stride]`, negative locals at `[rbp + off*8]`.
///
/// For a System V variadic callee (System V AMD64 3.5.7) the named
/// parameters are not pushed as positive cells -- they arrive in the
/// argument registers and the prologue spills them into the register
/// save area at the bottom of the frame. A named-parameter access
/// (`off >= 2`, parameter index `off - 2`) is therefore redirected to
/// that parameter's slot in the save area: an integer / pointer
/// parameter to `[reg_save + int_rank*8]` within the 48-byte gp area,
/// a floating-point parameter to `[reg_save + 48 + fp_rank*16]` within
/// the 128-byte fp area, where `reg_save = rbp - frame_bytes` and the
/// rank is the parameter's position within its argument-register bank
/// (the independent int / FP banks of System V AMD64 3.2.3). Locals
/// (`off < 0`) are unaffected.
fn local_slot_off(off: i64, func: &FunctionSsa, frame: Frame, abi: super::Abi) -> i64 {
    if off >= 2 && sysv_variadic_callee(func, abi) {
        let reg_save = frame.va_reg_save_off as i64;
        let p = (off - 2) as usize;
        // Named parameters arrive per the host ABI: the first six integer
        // and eight floating-point parameters in argument registers (the
        // prologue spills them into the register save area), the rest on
        // the incoming stack just above the return address. Use the shared
        // planner so the redirect lands on the same placement the caller
        // produced; the parameter's bank rank is the count of same-bank
        // register placements before it (an overflow parameter consumes no
        // register slot).
        let plan = super::plan_param_regs(func.n_params, func.param_fp_mask, abi);
        match plan.placements.get(p) {
            Some(super::ArgPlacement::Stack(soff)) => {
                // Overflow named parameter: the register save area does not
                // cover it. Read from the incoming stack at [rbp + 16 + soff],
                // matching the caller's stack-argument placement.
                16 + *soff as i64
            }
            Some(super::ArgPlacement::FpReg(_)) => {
                let fp_rank = plan.placements[..p]
                    .iter()
                    .filter(|q| matches!(q, super::ArgPlacement::FpReg(_)))
                    .count() as i64;
                reg_save + SYSV_GP_SAVE_BYTES as i64 + fp_rank * 16
            }
            _ => {
                let int_rank = plan.placements[..p]
                    .iter()
                    .filter(|q| matches!(q, super::ArgPlacement::IntReg(_)))
                    .count() as i64;
                reg_save + int_rank * 8
            }
        }
    } else {
        c5_slot_to_fp_offset(off, frame.param_cell_stride)
    }
}

/// Segment-override prefix byte for an x86 named address space:
/// `%gs:` is 0x65, `%fs:` is 0x64. `None` carries no override.
fn seg_prefix(seg: AsmSeg) -> Option<u8> {
    match seg {
        AsmSeg::Gs => Some(0x65),
        AsmSeg::Fs => Some(0x64),
        AsmSeg::None => None,
    }
}

/// Width-dispatched integer load `rd = *(kind*)[base + disp]`
/// (MOV / MOVSXD / MOVSX / MOVZX per C99 6.3.1.3).
fn emit_load_kind_mem(
    code: &mut Vec<u8>,
    kind: LoadKind,
    rd: Reg,
    base: Reg,
    disp: i32,
    seg: Option<u8>,
) {
    // A segment override is a legacy prefix preceding the opcode (and REX).
    if let Some(p) = seg {
        code.push(p);
    }
    match kind {
        LoadKind::I64 => emit_mov_r_mem(code, rd, base, disp),
        LoadKind::I32 => emit_movsxd_r_mem(code, rd, base, disp),
        LoadKind::U32 => super::encode::emit_mov_r32_mem(code, rd, base, disp),
        LoadKind::I16 => emit_movsx_r_mem16(code, rd, base, disp),
        LoadKind::U16 => emit_movzx_r_mem16(code, rd, base, disp),
        LoadKind::I8 => super::encode::emit_movsx_r_mem8(code, rd, base, disp),
        LoadKind::U8 => super::encode::emit_movzx_r_mem8(code, rd, base, disp),
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
    }
}

/// Width-dispatched integer store `*(kind*)[base + disp] = src`.
fn emit_store_kind_mem(
    code: &mut Vec<u8>,
    kind: StoreKind,
    base: Reg,
    disp: i32,
    src: Reg,
    seg: Option<u8>,
) {
    if let Some(p) = seg {
        code.push(p);
    }
    match kind {
        StoreKind::I64 => emit_mov_mem_r(code, base, disp, src),
        StoreKind::I32 => super::encode::emit_mov_mem32_r(code, base, disp, src),
        StoreKind::I16 => super::encode::emit_mov_mem16_r(code, base, disp, src),
        StoreKind::I8 => super::encode::emit_mov_mem8_r(code, base, disp, src),
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
    }
}

/// Mirror a just-stored FP value into `dst` (movapd into a distinct
/// FP register, or a spill store).
fn mirror_fp_dst(code: &mut Vec<u8>, dst: Place, dn: Reg, frame: Frame) {
    match dst {
        Place::FpReg(r) if r != dn.0 => emit_movapd_xmm_xmm(code, Reg(r), dn),
        Place::Spill(_) => fp_spill_dst_to_slot(code, dst, dn, frame),
        _ => {}
    }
}

/// FP load `dst = *(f32/f64*)[base + disp]`. `movss` reads the 4-byte
/// storage into the low dword; a single-precision value (C99 6.3.1.8)
/// stays f32 unless the consumer needs the `cvtss2sd` widening.
/// `movsd` covers the 8-byte `double` lvalue.
#[allow(clippy::too_many_arguments)]
fn emit_load_fp_mem(
    code: &mut Vec<u8>,
    dst: Place,
    kind: LoadKind,
    keep_f32: bool,
    base: Reg,
    disp: i32,
    seg: Option<u8>,
    frame: Frame,
    bound: Option<u32>,
    site: &str,
) -> bool {
    let Some(dd) = fp_or_spill_dst(dst) else {
        return fail(&alloc::format!("{site}: dst not fp reg / spill"));
    };
    if matches!(kind, LoadKind::F80 | LoadKind::F128) {
        if !matches!(kind, LoadKind::F80) {
            return fail(&alloc::format!("{site}: binary128 load on x86-64"));
        }
        // `fld m80` + `fstp m64` narrows the stored x87 value to the
        // f64 the compute path carries, through the red zone (no call
        // intervenes; x87 accesses carry no alignment requirement, so
        // the strict-align compose path does not apply).
        if let Some(p) = seg {
            code.push(p);
        }
        super::encode::emit_fld_m80(code, base, disp);
        super::encode::emit_fstp_m64(code, Reg::RSP, -8);
        emit_movsd_xmm_mem(code, dd, Reg::RSP, -8);
        fp_spill_dst_to_slot(code, dst, dd, frame);
        return true;
    }
    // A bounded access composes in a GPR and crosses via `movq`, which
    // zeroes the register above the composed bytes exactly as the
    // `movss` / `movsd` it replaces does.
    if let Some(a) = bound {
        let width = if matches!(kind, LoadKind::F32) { 4 } else { 8 };
        let acc = emit_narrow_compose(code, base, disp, width, a, &[]);
        super::encode::emit_movq_xmm_r(code, dd, acc);
        if matches!(kind, LoadKind::F32) && !keep_f32 {
            emit_cvtss2sd(code, dd, dd);
        }
        fp_spill_dst_to_slot(code, dst, dd, frame);
        return true;
    }
    // Segment override precedes the mandatory SSE prefix and the opcode.
    if let Some(p) = seg {
        code.push(p);
    }
    if matches!(kind, LoadKind::F32) {
        emit_movss_xmm_mem(code, dd, base, disp);
        if !keep_f32 {
            emit_cvtss2sd(code, dd, dd);
        }
    } else {
        emit_movsd_xmm_mem(code, dd, base, disp);
    }
    fp_spill_dst_to_slot(code, dst, dd, frame);
    true
}

/// FP store `*(f32/f64*)[base + disp] = value`. A single-precision
/// value (C99 6.3.1.8) writes directly via `movss`; a wider f64 value
/// (a `double` assigned to a `float` the walker didn't pre-narrow)
/// narrows via `cvtsd2ss` into SCRATCH_XMM15 first so `dn` (which may
/// be an allocator-held xmm the result Place expects) survives.
/// `movsd` covers the 8-byte `double` store. The stored value also
/// feeds `dst` per the c5 store-leaves-value rule (C99 6.5.16p3).
#[allow(clippy::too_many_arguments)]
fn emit_store_fp_mem(
    code: &mut Vec<u8>,
    dst: Place,
    value_place: Place,
    value_is_f32: bool,
    kind: StoreKind,
    base: Reg,
    disp: i32,
    seg: Option<u8>,
    frame: Frame,
    bound: Option<u32>,
    site: &str,
) -> bool {
    let Some(dn) = materialize_fp(code, value_place, SCRATCH_XMM14, frame) else {
        return fail(&alloc::format!(
            "{site}: value not fp reg / spill / int reg"
        ));
    };
    if matches!(kind, StoreKind::F80 | StoreKind::F128) {
        if !matches!(kind, StoreKind::F80) {
            return fail(&alloc::format!("{site}: binary128 store on x86-64"));
        }
        // `fld m64` widens the f64 exactly; `fstp m80` writes the 10
        // significant bytes and leaves the object's padding untouched,
        // as gcc's stores do. The round trip rides the red zone.
        emit_movsd_mem_xmm(code, Reg::RSP, -8, dn);
        super::encode::emit_fld_m64(code, Reg::RSP, -8);
        if let Some(p) = seg {
            code.push(p);
        }
        super::encode::emit_fstp_m80(code, base, disp);
        mirror_fp_dst(code, dst, dn, frame);
        return true;
    }
    // Emit the segment override immediately before the store opcode, past any
    // value materialisation / narrowing the branches do first.
    let push_seg = |code: &mut Vec<u8>| {
        if let Some(p) = seg {
            code.push(p);
        }
    };
    let narrowed = |code: &mut Vec<u8>, src: Reg, width: u32, a: u32| {
        super::encode::emit_movq_r_xmm(code, SCRATCH_R11, src);
        emit_narrow_store(code, SCRATCH_R11, base, disp, width, a);
    };
    if matches!(kind, StoreKind::F32) {
        let src = if value_is_f32 {
            dn
        } else {
            emit_cvtsd2ss(code, SCRATCH_XMM15, dn);
            SCRATCH_XMM15
        };
        match bound {
            Some(a) => narrowed(code, src, 4, a),
            None => {
                push_seg(code);
                emit_movss_mem_xmm(code, base, disp, src);
            }
        }
    } else {
        match bound {
            Some(a) => narrowed(code, dn, 8, a),
            None => {
                push_seg(code);
                emit_movsd_mem_xmm(code, base, disp, dn);
            }
        }
    }
    mirror_fp_dst(code, dst, dn, frame);
    true
}

/// Single-instruction rbp-relative load for `Inst::LoadLocal`.
/// The c5 slot offset folds into the load's ModR/M disp
/// directly, skipping the `LocalAddr` materialisation the
/// `LocalAddr` + `Load` pair would have required.
/// Base register and byte displacement for addressing a local slot. An
/// over-aligned automatic object lives in the over-aligned region: at
/// `[rsp + region_off]` when the prologue realigned rsp (alignment above 16),
/// at `[rbp + align_region_off + region_off]` for the static 16-aligned
/// placement; every other slot is `[rbp + local_slot_off]` (C11 6.7.5).
fn local_slot_base_disp(off: i64, func: &FunctionSsa, frame: Frame, abi: super::Abi) -> (Reg, i64) {
    if off < 0
        && (frame.align_region_off != 0 || frame.realign_align > 0)
        && let Some(&(_, region_off)) = func.over_aligned.iter().find(|&&(s, _)| s == off)
    {
        if frame.align_region_off != 0 {
            (Reg::RBP, frame.align_region_off + region_off)
        } else {
            (Reg::RSP, region_off)
        }
    } else {
        (Reg::RBP, local_slot_off(off, func, frame, abi))
    }
}

fn emit_load_local(
    code: &mut Vec<u8>,
    dst: Place,
    off: i64,
    kind: LoadKind,
    keep_f32: bool,
    frame: Frame,
    func: &FunctionSsa,
    abi: super::Abi,
) -> bool {
    let (base, bytes) = local_slot_base_disp(off, func, frame, abi);
    let Ok(disp) = i32::try_from(bytes) else {
        return fail("LoadLocal: offset doesn't fit in disp32");
    };
    if matches!(
        kind,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128
    ) {
        return emit_load_fp_mem(
            code,
            dst,
            kind,
            keep_f32,
            base,
            disp,
            None,
            frame,
            None,
            "LoadLocal",
        );
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("LoadLocal: dst not int reg / spill");
    };
    emit_load_kind_mem(code, kind, rd, base, disp, None);
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
    _v: super::super::ir::ValueId,
    off: i64,
    value: u32,
    kind: StoreKind,
    alloc: &Allocation,
    frame: Frame,
    func: &FunctionSsa,
    abi: super::Abi,
) -> bool {
    let (base, bytes) = local_slot_base_disp(off, func, frame, abi);
    let Ok(disp) = i32::try_from(bytes) else {
        return fail("StoreLocal: offset doesn't fit in disp32");
    };
    let value_place = place_of(alloc, value);
    if matches!(
        kind,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128
    ) {
        // Mirrors the `Store` FP path so a mem2reg-promoted slot
        // round-trips identically to the prior address-taken
        // `LocalAddr + Store` form.
        return emit_store_fp_mem(
            code,
            dst,
            value_place,
            alloc.is_f32(value),
            kind,
            base,
            disp,
            None,
            frame,
            None,
            "StoreLocal",
        );
    }
    // c5 spills an FP-typed accumulator into a local temp through
    // the store-local path (the bit pattern fits 8 bytes either
    // way), so an FpReg value bridges through `movq r, xmm` into
    // a GPR before the store; otherwise it routes through the
    // normal int materialisation.
    let rv = if let Place::FpReg(xr) = value_place {
        // The FP value bridges through a GPR for the integer store. r10
        // is reserved outside both allocator banks and holds nothing
        // live on this path (the store reads only `value`), so it is
        // always available -- a caller-saved pick can come up empty
        // under saturation.
        let scratch = SCRATCH_R10;
        super::encode::emit_movq_r_xmm(code, scratch, Reg(xr));
        scratch
    } else {
        match materialize_int(code, value_place, SCRATCH_R10, frame) {
            Some(r) => r,
            None => return fail("StoreLocal: value not int reg / spill"),
        }
    };
    // Store the low `kind`-width bytes; the accumulator below keeps
    // the full source value, matching the c5 rule that an
    // assignment expression yields the stored value before any
    // re-narrowing on read-back (C99 6.5.16p3).
    emit_store_kind_mem(code, kind, base, disp, rv, None);
    // Mirror the store value into the destination Place.
    mirror_int_dst(code, dst, rv, frame);
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
    if matches!(
        kind,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128
    ) {
        return fail("LoadIndexed: FP not implemented");
    }
    let expected_scale: u8 = match kind {
        LoadKind::I64 => 8,
        LoadKind::I32 | LoadKind::U32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
    };
    if scale != expected_scale {
        return fail("LoadIndexed: scale doesn't match access width");
    }
    let base_place = place_of(alloc, base);
    let index_place = place_of(alloc, index);
    let Some(regs) = materialize_int_operands_distinct(code, &[base_place, index_place], frame)
    else {
        return fail("LoadIndexed: base / index not int reg / spill");
    };
    let (rbase, rindex) = (regs[0], regs[1]);
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("LoadIndexed: dst not int reg / spill");
    };
    match kind {
        LoadKind::I64 => super::encode::emit_mov_r_sib(code, rd, rbase, rindex, scale),
        LoadKind::I32 => super::encode::emit_movsxd_r_sib(code, rd, rbase, rindex, scale),
        LoadKind::U32 => super::encode::emit_mov_r32_sib(code, rd, rbase, rindex, scale),
        LoadKind::I16 => super::encode::emit_movsx_r_sib16(code, rd, rbase, rindex, scale),
        LoadKind::U16 => super::encode::emit_movzx_r_sib16(code, rd, rbase, rindex, scale),
        LoadKind::I8 => super::encode::emit_movsx_r_sib8(code, rd, rbase, rindex, scale),
        LoadKind::U8 => super::encode::emit_movzx_r_sib8(code, rd, rbase, rindex, scale),
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => unreachable!(),
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
    if matches!(
        kind,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128
    ) {
        return fail("StoreIndexed: FP not implemented");
    }
    let expected_scale: u8 = match kind {
        StoreKind::I64 => 8,
        StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
    };
    if scale != expected_scale {
        return fail("StoreIndexed: scale doesn't match access width");
    }
    let base_place = place_of(alloc, base);
    let index_place = place_of(alloc, index);
    let value_place = place_of(alloc, value);
    let Some(regs) = materialize_int_operands_distinct(code, &[base_place, index_place], frame)
    else {
        return fail("StoreIndexed: base / index not int reg / spill");
    };
    let (rbase, rindex) = (regs[0], regs[1]);
    // The store also needs the value in a register distinct from the
    // base and index. r10 / r11 are the only reserved scratch; when both
    // already hold the spilled base and index there is none left, so the
    // effective address is precomputed into r10 (consuming the base and
    // index registers) and the freed r11 receives the value.
    let fp_value = matches!(value_place, Place::FpReg(_)) && matches!(kind, StoreKind::I64);
    let free = [SCRATCH_R10, SCRATCH_R11]
        .into_iter()
        .find(|s| s.0 != rbase.0 && s.0 != rindex.0);
    let mut precomputed_addr: Option<Reg> = None;
    let rv = if fp_value {
        let Place::FpReg(xr) = value_place else {
            unreachable!()
        };
        let target = match free {
            Some(s) => s,
            None => {
                super::encode::emit_lea_r_sib(code, SCRATCH_R10, rbase, rindex, scale);
                precomputed_addr = Some(SCRATCH_R10);
                SCRATCH_R11
            }
        };
        super::encode::emit_movq_r_xmm(code, target, Reg(xr));
        target
    } else if let Place::IntReg(r) = value_place {
        Reg(r)
    } else {
        match free {
            Some(s) => match materialize_int(code, value_place, s, frame) {
                Some(r) => r,
                None => return fail("StoreIndexed: value not int reg / spill"),
            },
            None => {
                super::encode::emit_lea_r_sib(code, SCRATCH_R10, rbase, rindex, scale);
                precomputed_addr = Some(SCRATCH_R10);
                match materialize_int(code, value_place, SCRATCH_R11, frame) {
                    Some(r) => r,
                    None => return fail("StoreIndexed: value not int reg / spill"),
                }
            }
        }
    };
    match precomputed_addr {
        Some(addr) => match kind {
            StoreKind::I64 => super::encode::emit_mov_mem_r(code, addr, 0, rv),
            StoreKind::I32 => super::encode::emit_mov_mem_r32(code, addr, 0, rv),
            StoreKind::I16 => super::encode::emit_mov_mem_r16(code, addr, 0, rv),
            StoreKind::I8 => super::encode::emit_mov_mem_r8(code, addr, 0, rv),
            StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
        },
        None => match kind {
            StoreKind::I64 => super::encode::emit_mov_sib_r(code, rbase, rindex, scale, rv),
            StoreKind::I32 => super::encode::emit_mov_sib_r32(code, rbase, rindex, scale, rv),
            StoreKind::I16 => super::encode::emit_mov_sib_r16(code, rbase, rindex, scale, rv),
            StoreKind::I8 => super::encode::emit_mov_sib_r8(code, rbase, rindex, scale, rv),
            StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => unreachable!(),
        },
    }
    // c5 store-op leaves the value in the accumulator.
    mirror_int_dst(code, dst, rv, frame);
    true
}

fn emit_load(
    code: &mut Vec<u8>,
    dst: Place,
    addr: u32,
    disp: i32,
    kind: LoadKind,
    seg: Option<u8>,
    keep_f32: bool,
    alloc: &Allocation,
    frame: Frame,
    bound: Option<u32>,
) -> bool {
    let addr_place = place_of(alloc, addr);
    // Spill-tolerant base materialisation: load a spilled address
    // into r10 first, write into rd next, then spill rd to its
    // slot if the allocator wants it parked there. Matches the
    // aarch64 module's primary-scratch shape.
    let Some(base) = materialize_int(code, addr_place, SCRATCH_R10, frame) else {
        return fail("Load: addr Place not int reg / spill");
    };
    if matches!(
        kind,
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128
    ) {
        return emit_load_fp_mem(
            code, dst, kind, keep_f32, base, disp, seg, frame, bound, "Load",
        );
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("Load: dst not int reg / spill");
    };
    match bound {
        Some(a) => emit_narrow_load(code, rd, base, disp, kind, a),
        None => emit_load_kind_mem(code, kind, rd, base, disp, seg),
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

fn emit_store(
    code: &mut Vec<u8>,
    dst: Place,
    _v: super::super::ir::ValueId,
    addr: u32,
    disp: i32,
    value: u32,
    kind: StoreKind,
    seg: Option<u8>,
    alloc: &Allocation,
    frame: Frame,
    bound: Option<u32>,
) -> bool {
    let addr_place = place_of(alloc, addr);
    let value_place = place_of(alloc, value);
    // Scratch for the addr-Place spill load (the materialise helper
    // only writes to it when addr_place is a Spill; an IntReg place
    // returns the underlying reg directly). r10 is reserved outside
    // both allocator banks, so it never aliases the value's
    // allocator-chosen register and never holds a live SSA value the
    // spill load could clobber -- a caller-saved pick can come up
    // empty under saturation. The value-Place uses the separate
    // reserved r11 scratch below, disjoint from r10.
    let addr_scratch = SCRATCH_R10;
    let Some(base) = materialize_int(code, addr_place, addr_scratch, frame) else {
        return fail("Store: addr Place not int reg / spill");
    };
    if matches!(
        kind,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128
    ) {
        return emit_store_fp_mem(
            code,
            dst,
            value_place,
            alloc.is_f32(value),
            kind,
            base,
            disp,
            seg,
            frame,
            bound,
            "Store",
        );
    }
    // The value scratch must be disjoint from `base` and must not be a
    // register the allocator parked a value live across this Store in.
    // The earlier fixed `RCX` fallback (used when `base` landed in
    // SCRATCH_R10) clobbered a long-lived value the allocator had
    // placed in rcx -- e.g. a base pointer read by a later indexed
    // load -- because rcx carries SSA values once the bank flattening
    // lets the allocator use it. A spilled value materialised into rcx
    // then overwrote that live value before its last use. `base` is
    // either the addr register place or the live-aware addr scratch,
    // both inside the allocator's caller-saved bank; r11 is reserved
    // outside both allocator banks (see the `SCRATCH_R10` note) so it
    // can never be `base` and never holds a live allocator value, which
    // makes it a safe value scratch under any register pressure. A
    // value-Place already in an int register needs no scratch and
    // `materialize_int` returns it directly.
    let value_scratch = match value_place {
        Place::IntReg(r) => Reg(r),
        _ => SCRATCH_R11,
    };
    let Some(rs) = materialize_int(code, value_place, value_scratch, frame) else {
        return fail("Store: value Place not int reg / spill");
    };
    match bound {
        Some(a) => emit_narrow_store(code, rs, base, disp, int_store_width(kind), a),
        None => emit_store_kind_mem(code, kind, base, disp, rs, seg),
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
    let src_place = place_of(alloc, value);
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("Extend: dst not int reg / spill");
    };
    let Some(rn) = materialize_int(code, src_place, rd, frame) else {
        return fail("Extend: value not int reg / spill");
    };
    match kind {
        LoadKind::I8 => super::encode::emit_movsx_r_r8(code, rd, rn),
        LoadKind::I16 => super::encode::emit_movsx_r_r16(code, rd, rn),
        LoadKind::I32 => super::encode::emit_movsxd_r_r(code, rd, rn),
        _ => return fail("Extend: unsupported kind"),
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// `Inst::Copy { value, is_fp }` -- move `value` into this
/// instruction's own place. Bit-exact in both banks, so a
/// single-precision operand keeps its pattern.
fn emit_copy(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    is_fp: bool,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = place_of(alloc, value);
    if is_fp {
        let Some(dd) = fp_or_spill_dst(dst) else {
            return fail("Copy: dst not fp reg / spill");
        };
        let Some(dn) = materialize_fp(code, src_place, dd, frame) else {
            return fail("Copy: value not fp reg / spill / int reg");
        };
        if dn.0 != dd.0 {
            emit_movapd_xmm_xmm(code, dd, dn);
        }
        fp_spill_dst_to_slot(code, dst, dd, frame);
    } else {
        let Some(rd) = int_or_spill_dst(dst) else {
            return fail("Copy: dst not int reg / spill");
        };
        let Some(rn) = materialize_int(code, src_place, rd, frame) else {
            return fail("Copy: value not int reg / spill");
        };
        if rd != rn {
            emit_mov_rr(code, rd, rn);
        }
        spill_dst_to_slot(code, dst, rd, frame);
    }
    true
}

/// `Inst::Bswap { value, width }` -- reverse the low `width` bytes,
/// zero-extended. 64-bit: `bswap r64`. 32-bit: `bswap r32` (reads the
/// low dword, zero-extends). 16-bit: `movzx` clears the upper bits the
/// rotate would keep, then `rol dst16, 8` swaps the two low bytes.
fn emit_bswap(
    code: &mut Vec<u8>,
    dst: Place,
    value: u32,
    width: u8,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = place_of(alloc, value);
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("Bswap: dst not int reg / spill");
    };
    let Some(rn) = materialize_int(code, src_place, rd, frame) else {
        return fail("Bswap: value not int reg / spill");
    };
    match width {
        2 => {
            super::encode::emit_movzx_r_r16(code, rd, rn);
            emit_shift_ri(code, Mnem::Rol, 2, rd, 8);
        }
        4 => {
            if rd != rn {
                super::encode::emit_mov_r32_r32(code, rd, rn);
            }
            super::encode::emit_bswap_r(code, rd, 4);
        }
        _ => {
            emit_mov_rr(code, rd, rn);
            super::encode::emit_bswap_r(code, rd, 8);
        }
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// `Inst::Fma { a, b, c, neg_product, neg_addend }` -- fused multiply
/// add `dst = (neg_product ? -(a*b) : a*b) + (neg_addend ? -c : c)`
/// with a single rounding (C99 6.5p8 / FP_CONTRACT). FMA3 (Haswell+)
/// is the assumed x86_64 baseline. The `231` form computes
/// `dst = a*b OP dst`, so the addend `c` is staged into `dst` first;
/// the two multiplicands are forced into the scratch xmms outside the
/// allocator pool so that staging `c` cannot clobber them.
fn emit_fma(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    a: u32,
    b: u32,
    c: u32,
    neg_product: bool,
    neg_addend: bool,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let is_f32 = alloc.is_f32(v);
    let a_place = place_of(alloc, a);
    let b_place = place_of(alloc, b);
    let c_place = place_of(alloc, c);
    let Some(ra) = materialize_fp(code, a_place, SCRATCH_XMM14, frame) else {
        return fail("Fma: a not fp reg / spill / int reg");
    };
    if ra.0 != SCRATCH_XMM14.0 {
        emit_movapd_xmm_xmm(code, SCRATCH_XMM14, ra);
    }
    let Some(rb) = materialize_fp(code, b_place, SCRATCH_XMM15, frame) else {
        return fail("Fma: b not fp reg / spill / int reg");
    };
    if rb.0 != SCRATCH_XMM15.0 {
        emit_movapd_xmm_xmm(code, SCRATCH_XMM15, rb);
    }
    // The destination also supplies the accumulator. A spilled result
    // routes through a third scratch outside the pool.
    let dd = match dst {
        Place::FpReg(r) => Reg(r),
        Place::Spill(_) => SCRATCH_XMM13,
        _ => return fail("Fma: dst not fp reg / spill"),
    };
    let Some(rc) = materialize_fp(code, c_place, dd, frame) else {
        return fail("Fma: c not fp reg / spill / int reg");
    };
    if rc.0 != dd.0 {
        emit_movapd_xmm_xmm(code, dd, rc);
    }
    let (a14, b15) = (SCRATCH_XMM14, SCRATCH_XMM15);
    match (neg_product, neg_addend, is_f32) {
        (false, false, false) => emit_vfmadd231sd(code, dd, a14, b15),
        (false, true, false) => emit_vfmsub231sd(code, dd, a14, b15),
        (true, false, false) => emit_vfnmadd231sd(code, dd, a14, b15),
        (true, true, false) => emit_vfnmsub231sd(code, dd, a14, b15),
        (false, false, true) => emit_vfmadd231ss(code, dd, a14, b15),
        (false, true, true) => emit_vfmsub231ss(code, dd, a14, b15),
        (true, false, true) => emit_vfnmadd231ss(code, dd, a14, b15),
        (true, true, true) => emit_vfnmsub231ss(code, dd, a14, b15),
    }
    fp_spill_dst_to_slot(code, dst, dd, frame);
    true
}

/// `Inst::Fneg(v)` -- flip the IEEE 754 sign bit. For a `double`
/// the mask is `1 << 63`; for a single-precision value (C99 6.3.1.8)
/// the mask is `1 << 31`, flipping the sign bit of the f32 held in
/// the low dword. Builds the mask on the fly into `SCRATCH_XMM15`
/// (movq xmm, r10 after loading the immediate into r10) and xors in
/// place.
fn emit_fneg(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = place_of(alloc, value);
    let Some(dd) = fp_or_spill_dst(dst) else {
        return fail("Fneg: dst not fp reg / spill");
    };
    let Some(dn) = materialize_fp(code, src_place, dd, frame) else {
        return fail("Fneg: value not fp reg / spill / int reg");
    };
    if dn.0 != dd.0 {
        emit_movapd_xmm_xmm(code, dd, dn);
    }
    // Build the sign-bit mask in an integer scratch and transfer to
    // SCRATCH_XMM15, then xorpd in place. r10 is reserved outside both
    // allocator banks and holds nothing live on this path (Fneg reads
    // only its FP `value`), so the mask load clobbers no allocator
    // value.
    let scratch_int = SCRATCH_R10;
    let mask: i64 = if alloc.is_f32(v) {
        0x8000_0000
    } else {
        i64::MIN
    };
    emit_mov_r_imm64(code, scratch_int, mask);
    emit_movq_xmm_r(code, SCRATCH_XMM15, scratch_int);
    emit_xorpd(code, dd, SCRATCH_XMM15);
    fp_spill_dst_to_slot(code, dst, dd, frame);
    true
}

/// `sqrt` / `fabs` intrinsic -- a unary FP operation lowering to a
/// single hardware instruction. `sqrt` uses `SQRTSD` / `SQRTSS`; `fabs`
/// clears the IEEE 754 sign bit by AND-ing with the inverted-sign mask
/// (C99 7.12.7), built in an integer scratch and transferred to
/// SCRATCH_XMM15, mirroring `emit_fneg`.
fn emit_fp_unary(
    code: &mut Vec<u8>,
    dst: Place,
    v: super::super::ir::ValueId,
    value: u32,
    kind: super::super::op::Intrinsic,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    use super::super::op::Intrinsic as I;
    use super::encode::{emit_andpd, emit_roundsd, emit_roundss, emit_sqrtsd, emit_sqrtss};
    let src_place = place_of(alloc, value);
    let Some(dd) = fp_or_spill_dst(dst) else {
        return fail("fp_unary: dst not fp reg / spill");
    };
    let Some(dn) = materialize_fp(code, src_place, dd, frame) else {
        return fail("fp_unary: value not fp reg / spill / int reg");
    };
    let is_f32 = alloc.is_f32(v);
    match kind {
        I::Sqrt | I::Sqrtf => {
            if is_f32 {
                emit_sqrtss(code, dd, dn);
            } else {
                emit_sqrtsd(code, dd, dn);
            }
        }
        I::Fabs | I::Fabsf => {
            if dn.0 != dd.0 {
                emit_movapd_xmm_xmm(code, dd, dn);
            }
            let mask: i64 = if is_f32 { 0x7fff_ffff } else { i64::MAX };
            emit_mov_r_imm64(code, SCRATCH_R10, mask);
            emit_movq_xmm_r(code, SCRATCH_XMM15, SCRATCH_R10);
            emit_andpd(code, dd, SCRATCH_XMM15);
        }
        I::Floor | I::Floorf | I::Ceil | I::Ceilf | I::Trunc | I::Truncf => {
            // ROUNDSD/ROUNDSS rounding-mode immediate, with bit 3 set to
            // suppress the precision (inexact) exception: 0x09 floor
            // (toward -inf), 0x0A ceil (toward +inf), 0x0B trunc (toward
            // zero).
            let imm: u8 = match kind {
                I::Floor | I::Floorf => 0x09,
                I::Ceil | I::Ceilf => 0x0A,
                _ => 0x0B,
            };
            if is_f32 {
                emit_roundss(code, dd, dn, imm);
            } else {
                emit_roundsd(code, dd, dn, imm);
            }
        }
        _ => return fail("fp_unary: not a unary FP intrinsic"),
    }
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
    v: super::super::ir::ValueId,
    kind: FpCastKind,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let src_place = place_of(alloc, value);
    match kind {
        FpCastKind::IntToFp => {
            let Some(rn) = materialize_int(code, src_place, SCRATCH_R10, frame) else {
                return fail("FpCast IntToFp: value not int reg / spill");
            };
            let Some(dd) = fp_or_spill_dst(dst) else {
                return fail("FpCast IntToFp: dst not fp reg / spill");
            };
            // Break the false dependency `cvtsi2*` carries on the
            // destination's prior contents (it merges into the low
            // element, leaving a read-after-write chain otherwise).
            emit_xorps(code, dd, dd);
            // C99 6.3.1.4: a `float` result converts directly to single
            // precision (one rounding) rather than to double + narrow.
            if alloc.is_f32(v) {
                emit_cvtsi2ss(code, dd, rn);
            } else {
                emit_cvtsi2sd(code, dd, rn);
            }
            fp_spill_dst_to_slot(code, dst, dd, frame);
            true
        }
        FpCastKind::UIntToFp => {
            // Unsigned 64-bit to double. SSE2 has no unsigned convert
            // before AVX512: when bit 63 is clear the signed convert is
            // exact; otherwise halve the value -- OR-ing the discarded
            // low bit back in as the sticky bit so the narrowing rounds
            // correctly -- convert, and double.
            let Some(src) = materialize_int(code, src_place, SCRATCH_R10, frame) else {
                return fail("FpCast UIntToFp: value not int reg / spill");
            };
            let Some(dd) = fp_or_spill_dst(dst) else {
                return fail("FpCast UIntToFp: dst not fp reg / spill");
            };
            // Modifiable scratch copies so a live source register is not
            // clobbered by the shift/and below.
            let rn = SCRATCH_R10;
            let t = SCRATCH_R11;
            // C99 6.3.1.4: a `float` result converts in single precision.
            let res_f32 = alloc.is_f32(v);
            // Break the false dependency the converts carry on `dd`;
            // covers both branch targets since it precedes the test.
            emit_xorps(code, dd, dd);
            emit_mov_rr(code, rn, src);
            emit_rr(code, Mnem::Test, 8, rn, rn);
            emit_jcc_rel8(code, Cc::S, 0);
            let js_fixup = code.len() - 1;
            if res_f32 {
                emit_cvtsi2ss(code, dd, rn);
            } else {
                emit_cvtsi2sd(code, dd, rn);
            }
            emit_jmp_rel8(code, 0);
            let jmp_fixup = code.len() - 1;
            let big = code.len();
            code[js_fixup] = (big - js_fixup - 1) as i8 as u8;
            emit_mov_rr(code, t, rn);
            emit_shift_ri(code, Mnem::Shr, 8, t, 1);
            emit_ri(code, Mnem::And, 8, rn, 1);
            emit_rr(code, Mnem::Or, 8, t, rn);
            if res_f32 {
                emit_cvtsi2ss(code, dd, t);
                emit_addss(code, dd, dd);
            } else {
                emit_cvtsi2sd(code, dd, t);
                emit_addsd(code, dd, dd);
            }
            let done = code.len();
            code[jmp_fixup] = (done - jmp_fixup - 1) as i8 as u8;
            fp_spill_dst_to_slot(code, dst, dd, frame);
            true
        }
        FpCastKind::FpToInt => {
            let Some(dn) = materialize_fp(code, src_place, SCRATCH_XMM14, frame) else {
                return fail("FpCast FpToInt: value not fp reg / spill / int reg");
            };
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("FpCast FpToInt: dst not int reg / spill");
            };
            // C99 6.3.1.4: a `float` source truncates directly to the
            // integer (`cvttss2si` reads the single in the low dword)
            // rather than widening to double first.
            if alloc.is_f32(value) {
                emit_cvttss2si(code, rd, dn);
            } else {
                emit_cvttsd2si(code, rd, dn);
            }
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        FpCastKind::UFpToInt => {
            // Double to unsigned 64-bit. SSE2 `cvttsd2si` is signed: a
            // value in [2^63, 2^64) saturates to the integer
            // indefinite. Compare with 2^63: below it the signed
            // truncate is exact; at or above, subtract 2^63, truncate
            // the in-range remainder, and set bit 63.
            let Some(src_xmm) = materialize_fp(code, src_place, SCRATCH_XMM14, frame) else {
                return fail("FpCast UFpToInt: value not fp reg / spill / int reg");
            };
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("FpCast UFpToInt: dst not int reg / spill");
            };
            // Modifiable copy so the `subsd` below cannot clobber a
            // live source xmm.
            let dn = SCRATCH_XMM14;
            emit_movapd_xmm_xmm(code, dn, src_xmm);
            let two63 = SCRATCH_XMM15;
            emit_mov_r_imm64(code, SCRATCH_R11, 0x43E0000000000000u64 as i64);
            emit_movq_xmm_r(code, two63, SCRATCH_R11);
            emit_ucomisd(code, dn, two63);
            emit_jcc_rel8(code, Cc::Ae, 0);
            let jae_fixup = code.len() - 1;
            emit_cvttsd2si(code, rd, dn);
            emit_jmp_rel8(code, 0);
            let jmp_fixup = code.len() - 1;
            let big = code.len();
            code[jae_fixup] = (big - jae_fixup - 1) as i8 as u8;
            emit_subsd(code, dn, two63);
            emit_cvttsd2si(code, rd, dn);
            emit_mov_r_imm64(code, SCRATCH_R11, 0x8000000000000000u64 as i64);
            emit_rr(code, Mnem::Or, 8, rd, SCRATCH_R11);
            let done = code.len();
            code[jmp_fixup] = (done - jmp_fixup - 1) as i8 as u8;
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        // C99 6.3.1.5: widen single to double (`cvtss2sd`) or narrow
        // double to single (`cvtsd2ss`). The single value lives in the
        // low dword of the xmm; `cvtss2sd` reads it, `cvtsd2ss` writes
        // it, so both are register-to-register with no separate move.
        FpCastKind::F32ToF64 => {
            let Some(dn) = materialize_fp(code, src_place, SCRATCH_XMM14, frame) else {
                return fail("FpCast F32ToF64: value not fp reg / spill / int reg");
            };
            let Some(dd) = fp_or_spill_dst(dst) else {
                return fail("FpCast F32ToF64: dst not fp reg / spill");
            };
            emit_cvtss2sd(code, dd, dn);
            fp_spill_dst_to_slot(code, dst, dd, frame);
            true
        }
        FpCastKind::F64ToF32 => {
            let Some(dn) = materialize_fp(code, src_place, SCRATCH_XMM14, frame) else {
                return fail("FpCast F64ToF32: value not fp reg / spill / int reg");
            };
            let Some(dd) = fp_or_spill_dst(dst) else {
                return fail("FpCast F64ToF32: dst not fp reg / spill");
            };
            emit_cvtsd2ss(code, dd, dn);
            fp_spill_dst_to_slot(code, dst, dd, frame);
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
    let lhs_place = place_of(alloc, lhs);
    let rhs_place = place_of(alloc, rhs);
    // FP arithmetic: scalar f64 in xmm. `op dst, rhs` overwrites
    // dst, so rhs must be captured into a register distinct from
    // dst before lhs is staged into dst. The allocator can color
    // rhs to the same xmm as dst; `materialize_fp` returns an
    // `FpReg` source in place without copying, so staging lhs into
    // dst would then clobber rhs. Capture rhs first, forcing a copy
    // into `SCRATCH_XMM15` when it aliases dst.
    if let Some(arith) = fp_arith_enc_for(op, alloc.is_f32(v)) {
        let Some(dd) = fp_or_spill_dst(dst) else {
            return fail("Fbinop: dst not fp reg / spill");
        };
        let dm = match rhs_place {
            Place::FpReg(r) if r == dd.0 => {
                emit_movapd_xmm_xmm(code, SCRATCH_XMM15, dd);
                SCRATCH_XMM15
            }
            _ => match materialize_fp(code, rhs_place, SCRATCH_XMM15, frame) {
                Some(r) => r,
                None => return fail("Fbinop: rhs not fp reg / spill / int reg"),
            },
        };
        let Some(dn) = materialize_fp(code, lhs_place, dd, frame) else {
            return fail("Fbinop: lhs not fp reg / spill / int reg");
        };
        if dn.0 != dd.0 {
            emit_movapd_xmm_xmm(code, dd, dn);
        }
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
        let Some(dn) = materialize_fp(code, lhs_place, SCRATCH_XMM14, frame) else {
            return fail("Fcmp: lhs not fp reg / spill / int reg");
        };
        let Some(dm) = materialize_fp(code, rhs_place, SCRATCH_XMM15, frame) else {
            return fail("Fcmp: rhs not fp reg / spill / int reg");
        };
        // When a fused branch reads the flags, `Flt` / `Fle` compare
        // with the operands swapped so the branch takes the
        // parity-clean `A` / `Ae` shapes (see `fused_fp_swaps_operands`).
        let fused = alloc.branch_fused.get(v as usize).copied().unwrap_or(false);
        let (dn, dm) = if fused && fused_fp_swaps_operands(op) {
            (dm, dn)
        } else {
            (dn, dm)
        };
        // The compare width follows the operands' precision (C99
        // 6.3.1.8): two f32 operands use `ucomiss`, else `ucomisd`.
        if alloc.is_f32(lhs) || alloc.is_f32(rhs) {
            emit_ucomiss(code, dn, dm);
        } else {
            emit_ucomisd(code, dn, dm);
        }
        if fused {
            return true;
        }
        let Some(rd) = int_or_spill_dst(dst) else {
            return fail("Fcmp: dst not int reg / spill");
        };
        emit_setcc_r8(code, cc, rd);
        emit_movzx_r_r8(code, rd, rd);
        match nan_fix {
            FpCmpNanFix::None => {}
            FpCmpNanFix::AndNotP | FpCmpNanFix::OrP => {
                // Need a 64-bit scratch distinct from `rd` for the
                // parity-fix setcc. r10 / r11 are reserved outside both
                // allocator banks and hold nothing live on the Fcmp
                // path (only the two FP operands, both in xmm), so one
                // of them is always disjoint from `rd` -- a caller-saved
                // pick can come up empty under saturation.
                let scratch = if rd.0 == SCRATCH_R10.0 {
                    SCRATCH_R11
                } else {
                    SCRATCH_R10
                };
                let fix_cc = if matches!(nan_fix, FpCmpNanFix::AndNotP) {
                    super::encode::Cc::Np
                } else {
                    super::encode::Cc::P
                };
                emit_setcc_r8(code, fix_cc, scratch);
                emit_movzx_r_r8(code, scratch, scratch);
                if matches!(nan_fix, FpCmpNanFix::AndNotP) {
                    emit_rr(code, Mnem::And, 8, rd, scratch);
                } else {
                    emit_rr(code, Mnem::Or, 8, rd, scratch);
                }
            }
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("Binop: dst not int reg / spill");
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
        let src_place = place_of(alloc, sxtw_source);
        let Some(src_reg) = int_operand_into_rd(code, src_place, rd, frame) else {
            return fail("Binop sxtw: src not int reg / spill");
        };
        let k = alloc.sxtw_k.get(v as usize).copied().unwrap_or(0);
        match k {
            32 => super::encode::emit_movsxd_r_r(code, rd, src_reg),
            48 => super::encode::emit_movsx_r_r16(code, rd, src_reg),
            56 => super::encode::emit_movsx_r_r8(code, rd, src_reg),
            _ => return fail("Binop sxtw: unexpected K"),
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // A spilled second operand is read in place through the op's
    // memory-source form, so it needs no scratch register. The prior
    // path staged a spilled rhs into a fixed scratch (rcx when rd was
    // r10), which clobbered a live lhs already resident in that
    // register under high pressure. Shifts are excluded: x86 reads the
    // shift count from cl, not from a memory operand.
    if let Place::Spill(rhs_slot) = rhs_place {
        let (rhs_base, rhs_off) = spill_slot_addr(frame, rhs_slot);
        let cmp_cc = int_cmp_cc(op);
        let arith = matches!(
            op,
            BinOp::Add | BinOp::Sub | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor
        );
        if arith || cmp_cc.is_some() {
            let Some(rn) = int_operand_into_rd(code, lhs_place, rd, frame) else {
                return fail("Binop: lhs not int reg / spill");
            };
            if let Some(cc) = cmp_cc {
                emit_rm(code, Mnem::Cmp, 8, rn, rhs_base, rhs_off);
                if finish_int_cmp(code, v, cc, rd, alloc) {
                    return true;
                }
            } else {
                if rd.0 != rn.0 {
                    emit_mov_rr(code, rd, rn);
                }
                match op {
                    BinOp::Add => emit_rm(code, Mnem::Add, 8, rd, rhs_base, rhs_off),
                    BinOp::Sub => emit_rm(code, Mnem::Sub, 8, rd, rhs_base, rhs_off),
                    BinOp::Mul => emit_imul_r_mem(code, rd, rhs_base, rhs_off),
                    BinOp::And => emit_rm(code, Mnem::And, 8, rd, rhs_base, rhs_off),
                    BinOp::Or => emit_rm(code, Mnem::Or, 8, rd, rhs_base, rhs_off),
                    BinOp::Xor => emit_rm(code, Mnem::Xor, 8, rd, rhs_base, rhs_off),
                    _ => unreachable!(),
                }
            }
            spill_dst_to_slot(code, dst, rd, frame);
            return true;
        }
    }

    // Stage lhs into rd first, so the two-operand ops below can
    // `op rd, rm` and land the result in rd. A spilled rhs for an
    // arithmetic or compare op was already handled in place above; the
    // remaining spilled-rhs case is a shift, whose count this scratch
    // carries. A register rhs needs the scratch only to preserve itself
    // when it aliases rd.
    //
    // The scratch must not be rcx for a shift: the shift count is moved
    // into rcx (cl) by the shift arm below, which preserves any live SSA
    // value the allocator parked in rcx with a push / pop around that
    // move. Materialising a spilled count straight into rcx here would
    // overwrite that live value before the push could save it. r11 is
    // reserved outside both allocator banks (see the `SCRATCH_R10`
    // note), so it is always a safe count scratch; the non-shift path
    // keeps the cheaper r10 / rcx choice.
    let is_shift = matches!(op, BinOp::Shl | BinOp::Shr | BinOp::Shru | BinOp::Ror);
    let rhs_scratch = if is_shift {
        if rd.0 == SCRATCH_R10.0 {
            SCRATCH_R11
        } else {
            SCRATCH_R10
        }
    } else if rd.0 == SCRATCH_R10.0 {
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
    let Some(rn) = int_operand_into_rd(code, lhs_place, rd, frame) else {
        return fail("Binop: lhs not int reg / spill");
    };
    // Div / Mod / Mulh / Mulhu hijack rax + rdx (SDM: IDIV's implicit
    // operand is rdx:rax and the result is rax (quot), rdx (rem);
    // one-operand IMUL / MUL multiply rax and write rdx:rax). They
    // need their own marshalling separate from the two-operand
    // path below.
    if matches!(
        op,
        BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu | BinOp::Mulh | BinOp::Mulhu
    ) {
        // When the rhs aliased rd and was saved into the scratch
        // above (because the spilled lhs load just overwrote rd), it
        // now lives in that scratch register, not its original
        // place; reading the original place would take the lhs as the
        // second operand.
        let rhs_place = if rhs_preserved_in_scratch {
            Place::IntReg(rhs_scratch.0)
        } else {
            rhs_place
        };
        return emit_binop_rdx_rax(code, op, dst, rd, rn, rhs_place, frame);
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
            BinOp::Add => emit_rr(code, Mnem::Add, 8, rd, other),
            BinOp::Mul => emit_rr(code, Mnem::Imul, 8, rd, other),
            BinOp::And => emit_rr(code, Mnem::And, 8, rd, other),
            BinOp::Or => emit_rr(code, Mnem::Or, 8, rd, other),
            BinOp::Xor => emit_rr(code, Mnem::Xor, 8, rd, other),
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
        return fail("Binop: rhs not int reg / spill");
    };
    // `lea rd, [rn + rm]` folds the staging mov and the add into one
    // address-unit op when the result lands in a different register
    // than the lhs. It reads both operands before writing rd (so it is
    // correct even were rd to alias rm) and sets no flags, which an
    // add-result consumer never reads. The rd == rn case is already a
    // single `add rd, rm`, so it stays on the path below.
    if matches!(op, BinOp::Add) && rd.0 != rn.0 {
        super::encode::emit_lea_r_sib(code, rd, rn, rm, 1);
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // x86_64's two-operand ops mutate the destination, so stage
    // the LHS into rd first (preserves SSA semantics where the
    // result is `lhs OP rhs`). Cmp ops skip this -- they read
    // rn / rm directly and write dst via setcc+movzx.
    if !is_cmp && rd.0 != rn.0 {
        emit_mov_rr(code, rd, rn);
    }
    match op {
        BinOp::Add => emit_rr(code, Mnem::Add, 8, rd, rm),
        BinOp::Sub => emit_rr(code, Mnem::Sub, 8, rd, rm),
        BinOp::Mul => emit_rr(code, Mnem::Imul, 8, rd, rm),
        BinOp::And => emit_rr(code, Mnem::And, 8, rd, rm),
        BinOp::Or => emit_rr(code, Mnem::Or, 8, rd, rm),
        BinOp::Xor => emit_rr(code, Mnem::Xor, 8, rd, rm),
        BinOp::Eq
        | BinOp::Ne
        | BinOp::Lt
        | BinOp::Gt
        | BinOp::Le
        | BinOp::Ge
        | BinOp::Ult
        | BinOp::Ugt
        | BinOp::Ule
        | BinOp::Uge => {
            // cmp lhs, rhs ; setcc rd_low ; movzx rd, rd_low unless a
            // fused branch reads the flags. Write setcc into rd's own
            // low byte (rather than cl) so a live SSA value parked in
            // rcx is not destroyed.
            emit_rr(code, Mnem::Cmp, 8, rn, rm);
            if finish_int_cmp(code, v, int_cmp_cc(op).unwrap(), rd, alloc) {
                return true;
            }
        }
        BinOp::Shl | BinOp::Shr | BinOp::Shru | BinOp::Ror => {
            // x86 shifts read the count from cl. The shared helper moves
            // the count (here a register, `rm`) into rcx and shifts rd,
            // preserving any live rcx, and stages through a reserved
            // scratch when rd is rcx. The `mov rd, rn` above left rd
            // holding the lhs to be shifted.
            return emit_shift_by_count_reg(
                code,
                op,
                v,
                dst,
                rd,
                ShiftCount::Reg(rm),
                alloc,
                frame,
            );
        }
        _ => {
            // Every representable integer binop is handled above. A new
            // op variant here is an IR producer/consumer mismatch, not a
            // register-pressure shape -- fail loudly rather than emit a
            // subset-bail that surfaces as an ICE downstream.
            panic!("Binop: unhandled integer op variant {op:?}");
        }
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// Lower `BinOp::{Div,Mod,Divu,Modu,Mulh,Mulhu}` on x86_64. All six
/// use the implicit rdx:rax pair: IDIV / DIV take the dividend there
/// (low half in rax) and write the quotient to rax and the remainder
/// to rdx; one-operand IMUL / MUL multiply rax by the operand and
/// write the 128-bit product to rdx:rax. The surrounding
/// allocator-chosen values in rax / rdx must be preserved across the
/// sequence. The 8-byte preserve uses `push %rax` / `pop %rax`; the
/// temporary 8-byte misalignment is fine -- none of these read or
/// write the stack, and SysV / Win64 only require 16-byte alignment
/// at `call` sites.
///
/// `rn` is the already-materialised lhs; `rhs_place` is the second
/// operand's place so we can route it directly into r10 (which the
/// one-operand reg/mem field can name, and which is never in any
/// allocator pool).
fn emit_binop_rdx_rax(
    code: &mut Vec<u8>,
    op: BinOp,
    dst: Place,
    rd: Reg,
    rn: Reg,
    rhs_place: Place,
    frame: Frame,
) -> bool {
    let is_mulh = matches!(op, BinOp::Mulh | BinOp::Mulhu);
    // The high half of the product lands in rdx, as the remainder does.
    let want_rdx = is_mulh || matches!(op, BinOp::Mod | BinOp::Modu);
    let is_unsigned = matches!(op, BinOp::Divu | BinOp::Modu | BinOp::Mulhu);

    // Preserve rax / rdx: the allocator can park a live value in
    // either register and the sequence must not destroy it. rax
    // receives the lhs and the quotient / low product half; rdx
    // receives the dividend high half (cqo / xor edx,edx) and the
    // remainder / high product half. Skip the save when rd will
    // overwrite the register anyway, since the value living there is
    // dead the moment rd commits its result.
    let preserve_rax = rd.0 != Reg::RAX.0;
    let preserve_rdx = rd.0 != Reg::RDX.0;
    let pushed_bytes = (preserve_rax as i32 + preserve_rdx as i32) * 8;

    // Resolve the second operand. All four one-operand forms accept
    // r/m64, so a spilled operand is named directly through its stack
    // slot (its rsp offset shifted by the rax/rdx preservation pushes
    // below) and a register operand outside the implicit rdx:rax pair
    // is used in place -- neither needs a scratch register, which the
    // surrounding high-pressure allocation may not have free. An
    // operand that aliases rax or rdx is copied into the dedicated
    // scratch before the rax setup overwrites those registers; the
    // scratch is free unless it already holds the lhs (a spilled lhs).
    enum RmOperand {
        Reg(Reg),
        Mem(Reg, i32),
    }
    let rm_operand = match rhs_place {
        Place::IntReg(r) if r != Reg::RAX.0 && r != Reg::RDX.0 => RmOperand::Reg(Reg(r)),
        Place::Spill(slot) => {
            let (sb, off) = spill_slot_addr_shifted(frame, slot, pushed_bytes as u32);
            RmOperand::Mem(sb, off)
        }
        Place::IntReg(r) => {
            // An operand in rax / rdx must be copied out before the
            // rax setup overwrites those registers. The copy target
            // must not collide with the staged lhs: a spilled lhs is
            // materialised into rd, which for a spilled dst is
            // SCRATCH_R10, so SCRATCH_R10 is not always free here.
            // SCRATCH_R11 is reserved outside both allocator pools
            // and never holds the lhs, so it is always available.
            let rhs_scratch = if rn.0 == SCRATCH_R10.0 {
                SCRATCH_R11
            } else {
                SCRATCH_R10
            };
            emit_mov_rr(code, rhs_scratch, Reg(r));
            RmOperand::Reg(rhs_scratch)
        }
        _ => return fail("Binop rdx:rax: rhs not int reg / spill"),
    };

    if preserve_rax {
        emit_push_r(code, Reg::RAX);
    }
    if preserve_rdx {
        emit_push_r(code, Reg::RDX);
    }
    // rax := lhs (dividend low half, or multiplicand).
    if rn.0 != Reg::RAX.0 {
        emit_mov_rr(code, Reg::RAX, rn);
    }
    // A divide needs rdx seeded with the dividend's high half: signed
    // uses CQO to sign-extend rax, unsigned zero-extends with
    // `xor edx, edx`. A multiply reads only rax and overwrites rdx.
    if !is_mulh {
        if is_unsigned {
            emit_rr(code, Mnem::Xor, 8, Reg::RDX, Reg::RDX);
        } else {
            super::encode::emit_cqo(code);
        }
    }
    let mnem = match (is_mulh, is_unsigned) {
        (true, true) => Mnem::Mul,
        (true, false) => Mnem::Imul,
        (false, true) => Mnem::Div,
        (false, false) => Mnem::Idiv,
    };
    match rm_operand {
        RmOperand::Reg(r) => super::encode::emit_unary_r(code, mnem, 8, r),
        RmOperand::Mem(sb, off) => super::encode::emit_unary_m(code, mnem, 8, sb, off),
    }
    // Capture result into rd before restoring rdx / rax.
    let result_src = if want_rdx { Reg::RDX } else { Reg::RAX };
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

/// Source of a variable shift count for `emit_shift_by_count_reg`.
enum ShiftCount {
    /// Count already resident in a register; moved into cl.
    Reg(Reg),
    /// Count is a compile-time immediate; loaded into cl. Reached
    /// only for an out-of-range `BinopI` shift (C99 6.5.7p3 makes
    /// such a count undefined), kept well-formed rather than bailed.
    Imm(i64),
}

/// Lower `rd = rd OP count` for a variable-count shift / rotate, with
/// the value to shift already staged in `rd`. x86 reads the count
/// from cl, so the count is moved into rcx and the shift issued
/// against rd. When the allocator parked a live SSA value in rcx
/// (rcx is in the caller-saved pool), it is preserved with push /
/// pop around the move; the body is register-to-register only, so
/// the transient 8-byte misalignment is irrelevant (no call site
/// intervenes). When `rd` itself is rcx the value to shift and the
/// count would both need rcx at once, so the shift is staged in a
/// reserved scratch and copied back.
#[allow(clippy::too_many_arguments)]
fn emit_shift_by_count_reg(
    code: &mut Vec<u8>,
    op: BinOp,
    v: super::super::ir::ValueId,
    dst: Place,
    rd: Reg,
    count: ShiftCount,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    let count_reg = match count {
        ShiftCount::Reg(r) => Some(r),
        ShiftCount::Imm(_) => None,
    };
    let do_shift = |code: &mut Vec<u8>, target: Reg| match op {
        BinOp::Shl => emit_shift_cl(code, Mnem::Shl, 8, target),
        BinOp::Shr => emit_shift_cl(code, Mnem::Sar, 8, target),
        BinOp::Shru => emit_shift_cl(code, Mnem::Shr, 8, target),
        BinOp::Ror => emit_shift_cl(code, Mnem::Ror, 8, target),
        _ => unreachable!("emit_shift_by_count_reg: non-shift op {op:?}"),
    };
    if rd.0 == Reg::RCX.0 {
        // Stage the value in a scratch disjoint from rcx and the count
        // register; r11 is reserved outside both allocator banks and
        // never aliases rd, the count, or any live value.
        let scratch = SCRATCH_R11;
        emit_mov_rr(code, scratch, rd);
        match count {
            ShiftCount::Reg(r) if r.0 != Reg::RCX.0 => emit_mov_rr(code, Reg::RCX, r),
            ShiftCount::Reg(_) => {}
            ShiftCount::Imm(imm) => super::encode::emit_mov_r_imm64(code, Reg::RCX, imm),
        }
        do_shift(code, scratch);
        emit_mov_rr(code, rd, scratch);
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // Save rcx whenever any value is allocated there (unless the count
    // already sits in rcx, in which case nothing below writes it). A
    // `def < v < last_use` pc-interval test is not a liveness test: a
    // value carried around a loop back edge is live at the shift while
    // the shift's pc lies outside the interval.
    let _ = v;
    let rcx_holds_live = count_reg.map(|r| r.0).unwrap_or(u8::MAX) != Reg::RCX.0
        && alloc
            .places
            .iter()
            .any(|p| matches!(p, Place::IntReg(r) if *r == Reg::RCX.0));
    if rcx_holds_live {
        emit_push_r(code, Reg::RCX);
    }
    match count {
        ShiftCount::Reg(r) if r.0 != Reg::RCX.0 => emit_mov_rr(code, Reg::RCX, r),
        ShiftCount::Reg(_) => {}
        ShiftCount::Imm(imm) => super::encode::emit_mov_r_imm64(code, Reg::RCX, imm),
    }
    do_shift(code, rd);
    if rcx_holds_live {
        emit_pop_r(code, Reg::RCX);
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
        return fail("BinopI: dst not int reg / spill");
    };
    let lhs_place = place_of(alloc, lhs);
    let Some(rn) = int_operand_into_rd(code, lhs_place, rd, frame) else {
        return fail("BinopI: lhs not int reg / spill");
    };
    // sxtw fold via movsxd / movsx -- mirrors the aarch64 path.
    let sxtw_source = alloc
        .sxtw_source
        .get(v as usize)
        .copied()
        .unwrap_or(super::super::ir::NO_VALUE);
    if sxtw_source != super::super::ir::NO_VALUE {
        let src_place = place_of(alloc, sxtw_source);
        let Some(src_reg) = int_operand_into_rd(code, src_place, rd, frame) else {
            return fail("BinopI sxtw: src not int reg / spill");
        };
        match rhs_imm {
            32 => super::encode::emit_movsxd_r_r(code, rd, src_reg),
            48 => super::encode::emit_movsx_r_r16(code, rd, src_reg),
            56 => super::encode::emit_movsx_r_r8(code, rd, src_reg),
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
            emit_shift_ri(
                code,
                Mnem::Shl,
                8,
                rd,
                (rhs_imm as u64).trailing_zeros() as u8,
            );
            true
        }
        // Multiply by 3 / 5 / 9 is one `lea rd, [rn + rn*2/4/8]`: a
        // single-cycle address-unit operation instead of the multi-cycle
        // `imul`. The base and index are both `rn`, so the result may
        // reuse `rn` (the effective address is read before the write).
        BinOp::Mul if matches!(rhs_imm, 3 | 5 | 9) => {
            super::encode::emit_lea_r_sib(code, rd, rn, rn, (rhs_imm - 1) as u8);
            true
        }
        // `imul rd, rn, imm32` reads `rn` and writes `rd` in one
        // instruction, so it needs neither a staging mov nor an
        // immediate-scratch register. This covers the multiply by a
        // non-power-of-two constant that the scratch path below cannot
        // lower when no caller-saved register is free.
        BinOp::Mul if imm_fits_i32 => {
            super::encode::emit_imul_r_r_imm32(code, rd, rn, rhs_imm as i32);
            true
        }
        BinOp::Shl if shift_amount.is_some() => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            emit_shift_ri(code, Mnem::Shl, 8, rd, shift_amount.unwrap());
            true
        }
        BinOp::Shr if shift_amount.is_some() => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            emit_shift_ri(code, Mnem::Sar, 8, rd, shift_amount.unwrap());
            true
        }
        BinOp::Shru if shift_amount.is_some() => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            emit_shift_ri(code, Mnem::Shr, 8, rd, shift_amount.unwrap());
            true
        }
        BinOp::Ror if shift_amount.is_some() => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            emit_shift_ri(code, Mnem::Ror, 8, rd, shift_amount.unwrap());
            true
        }
        // `lea rd, [rn +/- imm]` computes the sum into a different
        // register in one instruction, folding away the `mov rd, rn`
        // copy the destructive `add` / `sub` forms below would need. lea
        // writes no flags, which is fine: no consumer reads the carry of
        // a `BinopI` result (see the inc/dec note). Restricted to rd !=
        // rn (the in-place forms below are already one instruction) and
        // to a displacement that fits the signed 32-bit `lea` field.
        BinOp::Add if rd.0 != rn.0 && imm_fits_i32 => {
            super::encode::emit_lea_r_mem(code, rd, rn, rhs_imm as i32);
            true
        }
        BinOp::Sub if rd.0 != rn.0 && imm_fits_i32 && rhs_imm != i64::from(i32::MIN) => {
            super::encode::emit_lea_r_mem(code, rd, rn, -(rhs_imm as i32));
            true
        }
        // A step of one encodes as `inc` / `dec` (three bytes) rather
        // than `add` / `sub` with an immediate (seven). The flags differ
        // -- `inc` / `dec` leave the carry flag unchanged -- but the
        // result register is identical and no consumer reads the carry
        // of a `BinopI` result.
        BinOp::Add if rhs_imm == 1 || rhs_imm == -1 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            if rhs_imm == 1 {
                super::encode::emit_unary_r(code, Mnem::Inc, 8, rd);
            } else {
                super::encode::emit_unary_r(code, Mnem::Dec, 8, rd);
            }
            true
        }
        BinOp::Sub if rhs_imm == 1 || rhs_imm == -1 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            if rhs_imm == 1 {
                super::encode::emit_unary_r(code, Mnem::Dec, 8, rd);
            } else {
                super::encode::emit_unary_r(code, Mnem::Inc, 8, rd);
            }
            true
        }
        BinOp::Add if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::encode::emit_ri(code, Mnem::Add, 8, rd, rhs_imm as i32);
            true
        }
        BinOp::Sub if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::encode::emit_ri(code, Mnem::Sub, 8, rd, rhs_imm as i32);
            true
        }
        // `x & 0xffffffff` is a zero-extension of the low 32 bits. A
        // 32-bit `mov rd, rn` clears the upper half, materialising the
        // mask in one instruction with no immediate-scratch register.
        // The imm32 AND form cannot encode this value: `and r64, imm32`
        // sign-extends the immediate, so 0xffffffff would become
        // 0xffffffffffffffff and mask nothing.
        BinOp::And if rhs_imm == 0xffff_ffff => {
            super::encode::emit_mov_r32_r32(code, rd, rn);
            true
        }
        BinOp::And if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::encode::emit_ri(code, Mnem::And, 8, rd, rhs_imm as i32);
            true
        }
        BinOp::Or if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::encode::emit_ri(code, Mnem::Or, 8, rd, rhs_imm as i32);
            true
        }
        BinOp::Xor if imm_fits_i32 => {
            if rd.0 != rn.0 {
                emit_mov_rr(code, rd, rn);
            }
            super::encode::emit_ri(code, Mnem::Xor, 8, rd, rhs_imm as i32);
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
    if let Some(cc) = int_cmp_cc(op)
        && imm_fits_i32
    {
        // A compare against 0 is the shorter `test rn, rn`; ZF / SF /
        // CF / OF match `cmp rn, 0`, so the dependent setcc / jcc is
        // unchanged.
        if rhs_imm == 0 {
            super::encode::emit_rr(code, Mnem::Test, 8, rn, rn);
        } else {
            super::encode::emit_ri(code, Mnem::Cmp, 8, rn, rhs_imm as i32);
        }
        if finish_int_cmp(code, v, cc, rd, alloc) {
            return true;
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // Commutative ops with `rd != rn` can fold the staging mov
    // into the immediate materialisation: `mov rd, imm; OP rd,
    // rn` is two instructions and produces `imm OP rn == lhs OP
    // imm` by commutativity. The non-commutative path below uses
    // r11 as a scratch (r11 sits outside both
    // `caller_gprs` and `callee_gprs` in `RegBanks::for_target`,
    // so the allocator never picks r11 for an SSA value).
    let commutative = matches!(
        op,
        BinOp::Add | BinOp::Mul | BinOp::And | BinOp::Or | BinOp::Xor
    );
    if commutative && rd.0 != rn.0 {
        super::encode::emit_mov_r_imm64(code, rd, rhs_imm);
        match op {
            BinOp::Add => emit_rr(code, Mnem::Add, 8, rd, rn),
            BinOp::Mul => emit_rr(code, Mnem::Imul, 8, rd, rn),
            BinOp::And => emit_rr(code, Mnem::And, 8, rd, rn),
            BinOp::Or => emit_rr(code, Mnem::Or, 8, rd, rn),
            BinOp::Xor => emit_rr(code, Mnem::Xor, 8, rd, rn),
            _ => unreachable!(),
        }
        spill_dst_to_slot(code, dst, rd, frame);
        return true;
    }
    // A shift by a count outside 0..63 is the only `BinopI` shift
    // shape that reaches here (the in-range case took the imm8
    // peephole above). C99 6.5.7p3 makes a count >= the operand
    // width undefined; route it through cl like the register-shift
    // path so the emit stays well-formed rather than bailing.
    if matches!(op, BinOp::Shl | BinOp::Shr | BinOp::Shru | BinOp::Ror) {
        if rd.0 != rn.0 {
            emit_mov_rr(code, rd, rn);
        }
        return emit_shift_by_count_reg(
            code,
            op,
            v,
            dst,
            rd,
            ShiftCount::Imm(rhs_imm),
            alloc,
            frame,
        );
    }
    // Materialise the immediate into the reserved r11 scratch, then
    // stage `rd = lhs` (when rd != rn) before the two-operand op. r11
    // sits outside both allocator banks (`RegBanks::for_target`), so
    // it never aliases `rd` or `rn` and is always free under any
    // register pressure -- unlike a caller-saved pick, which a
    // saturated allocation can leave with no candidate.
    let scratch = SCRATCH_R11;
    super::encode::emit_mov_r_imm64(code, scratch, rhs_imm);
    if rd.0 != rn.0 {
        emit_mov_rr(code, rd, rn);
    }
    match op {
        BinOp::Add => emit_rr(code, Mnem::Add, 8, rd, scratch),
        BinOp::Sub => emit_rr(code, Mnem::Sub, 8, rd, scratch),
        BinOp::Mul => emit_rr(code, Mnem::Imul, 8, rd, scratch),
        BinOp::And => emit_rr(code, Mnem::And, 8, rd, scratch),
        BinOp::Or => emit_rr(code, Mnem::Or, 8, rd, scratch),
        BinOp::Xor => emit_rr(code, Mnem::Xor, 8, rd, scratch),
        BinOp::Eq
        | BinOp::Ne
        | BinOp::Lt
        | BinOp::Gt
        | BinOp::Le
        | BinOp::Ge
        | BinOp::Ult
        | BinOp::Ugt
        | BinOp::Ule
        | BinOp::Uge => {
            emit_rr(code, Mnem::Cmp, 8, rn, scratch);
            if finish_int_cmp(code, v, int_cmp_cc(op).unwrap(), rd, alloc) {
                return true;
            }
        }
        _ => {
            // Every representable integer `BinopI` op is covered above.
            // A new op variant reaching here is a producer/consumer
            // mismatch, not a register-pressure shape -- fail loudly.
            panic!("BinopI: unhandled integer op variant {op:?}");
        }
    }
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

#[allow(clippy::too_many_arguments)]
/// Store a register-classed <= 16-byte aggregate return into the
/// caller's result temp at `[rbp + base]`. Eightbytes are classified
/// (System V AMD64 3.2.3): INTEGER arrive in rax:rdx, SSE in
/// xmm0:xmm1; Win64 register returns classify as one INTEGER
/// eightbyte in rax. Variadic and non-variadic callees return
/// identically, so every call shape shares this store.
fn store_agg_return(
    code: &mut Vec<u8>,
    desc: &super::super::ir::AggDesc,
    base: i64,
    abi: super::Abi,
) {
    let eb_classes = match super::abi_classify::classify_aggregate(
        desc.size,
        desc.align,
        &desc.fields,
        abi,
        true,
    ) {
        super::abi_classify::AggClass::Regs(c) => c,
        _ => alloc::vec::Vec::new(),
    };
    let int_ret = [Reg::RAX, Reg::RDX];
    let mut int_i = 0usize;
    let mut sse_i = 0u8;
    for (k, class) in eb_classes.iter().enumerate() {
        let disp = (base + (k as i64) * 8) as i32;
        if matches!(class, super::abi_classify::RegClass::Sse) {
            emit_movsd_mem_xmm(code, Reg::RBP, disp, Reg(Reg::XMM0.0 + sse_i));
            sse_i += 1;
        } else {
            emit_mov_mem_r(code, Reg::RBP, disp, int_ret[int_i]);
            int_i += 1;
        }
    }
}

/// Store a register-classed aggregate return (tagged by `ret_agg`)
/// into the caller's result temp; `true` when the call returned an
/// aggregate and the scalar result routing must be skipped.
#[allow(clippy::too_many_arguments)]
fn store_ret_agg(
    code: &mut Vec<u8>,
    ret_agg: Option<u32>,
    agg_descs: &[super::super::ir::AggDesc],
    ret_slot_local: i64,
    func: &FunctionSsa,
    frame: Frame,
    abi: super::Abi,
) -> bool {
    let Some(ai) = ret_agg else {
        return false;
    };
    let base = local_slot_off(ret_slot_local, func, frame, abi);
    store_agg_return(code, &agg_descs[ai as usize], base, abi);
    true
}

/// Route a call's xmm0 FP result into `dst`: `movapd` into an FP
/// register, a spill store, or `movq` into an integer register.
fn xmm0_result_to_dst(code: &mut Vec<u8>, dst: Place, frame: Frame) {
    match dst {
        Place::FpReg(r) => {
            if r != Reg::XMM0.0 {
                emit_movapd_xmm_xmm(code, Reg(r), Reg::XMM0);
            }
        }
        Place::Spill(_) => fp_spill_dst_to_slot(code, dst, Reg::XMM0, frame),
        Place::IntReg(r) => super::encode::emit_movq_r_xmm(code, Reg(r), Reg::XMM0),
        Place::None => {}
    }
}

/// Mirror an integer result in `src` into an integer-or-spill `dst`
/// through the shared working-register pick; no-op for an FP dst.
fn mirror_int_dst(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    if let Some(rd) = int_or_spill_dst(dst) {
        if rd.0 != src.0 {
            emit_mov_rr(code, rd, src);
        }
        spill_dst_to_slot(code, dst, rd, frame);
    }
}

/// Route an integer result in `src` into any `dst` kind: register
/// copy, direct spill store, or `movq` into an FP register.
fn int_result_to_dst(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    match dst {
        Place::IntReg(r) => {
            if r != src.0 {
                emit_mov_rr(code, Reg(r), src);
            }
        }
        Place::Spill(_) => spill_dst_to_slot(code, dst, src, frame),
        Place::FpReg(r) => super::encode::emit_movq_xmm_r(code, Reg(r), src),
        Place::None => {}
    }
}

/// Number of XMM argument registers a call plan uses (System V AMD64
/// 3.2.3: a variadic call reports it in `al`).
fn xmm_arg_count(plan: &super::CallPlan) -> u8 {
    plan.placements
        .iter()
        .filter(|p| matches!(p, super::ArgPlacement::FpReg(_)))
        .count() as u8
}

/// Post-call tail shared by the host variadic `Call` branches: drop
/// the arg scratch window, then store an aggregate return or route
/// the scalar result into `dst`.
#[allow(clippy::too_many_arguments)]
fn finish_variadic_call(
    code: &mut Vec<u8>,
    scratch_bytes: u32,
    dst: Place,
    fp_return: bool,
    ret_agg: Option<u32>,
    agg_descs: &[super::super::ir::AggDesc],
    ret_slot_local: i64,
    func: &FunctionSsa,
    frame: Frame,
    abi: super::Abi,
) -> bool {
    if scratch_bytes > 0 {
        emit_add_rsp_imm32(code, scratch_bytes);
    }
    // A variadic callee returns a <=16-byte aggregate exactly like a
    // non-variadic one; classify the eightbytes (SSE ones arrive in
    // xmm0/xmm1, not rax:rdx).
    if store_ret_agg(code, ret_agg, agg_descs, ret_slot_local, func, frame, abi) {
        return true;
    }
    // c5 internal call return convention: an integer / pointer
    // result lives in rax, a floating-point result in xmm0 (C99
    // 6.2.5p10).
    if fp_return {
        xmm0_result_to_dst(code, dst, frame);
    } else {
        mirror_int_dst(code, dst, Reg::RAX, frame);
    }
    true
}

fn emit_call(
    code: &mut Vec<u8>,
    dst: Place,
    target_pc: usize,
    args: &[u32],
    fixed_args: usize,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    fixups: &mut Vec<Fixup>,
    callee_is_variadic: bool,
    fp_return: bool,
    fp_arg_mask: u32,
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
    ret_agg: Option<u32>,
    ret_slot_local: i64,
    func: &FunctionSsa,
) -> bool {
    // Resolve the call's struct arguments once. With no tagged
    // aggregate this is empty and `plan_call_args_aggs` reduces to the
    // scalar `plan_call_args` placement, so every branch can run the
    // aggregate planner uniformly.
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    if callee_is_variadic && abi.position_indexed_args {
        // Win64 host variadic ABI (Microsoft x64 calling convention):
        // the first four arguments (named and variadic) ride
        // rcx/rdx/r8/r9 by position, the rest the incoming stack at
        // 8-byte stride above the 32-byte home area. The c5-internal
        // variadic convention carries every argument as a raw 8-byte
        // integer value, so the walker widened the variadic
        // floating-point arguments to double and passed `fp_arg_mask`
        // 0; `plan_call_args` then routes every argument through the
        // integer side (position-indexed int registers, then stack).
        // This is the same marshal `emit_call_ext` performs for a
        // libc variadic call; Win64 sets `variadic_zero_xmm_count`
        // false, so no `al` is emitted. A by-value aggregate argument
        // the classifier tagged rides through `plan_call_args_aggs`.
        let plan =
            super::plan_call_args_aggs(args.len(), fixed_args, fp_arg_mask, abi, &aggs, false);
        if plan.scratch_bytes > 0 {
            emit_stack_alloc(code, plan.scratch_bytes, None);
        }
        if !marshal_args(
            code,
            &plan,
            args,
            alloc,
            frame,
            abi,
            "Call (Win64 variadic)",
        ) {
            return false;
        }
        let call_site = code.len();
        fixups.push(Fixup {
            native_offset: call_site,
            target_ent_pc: target_pc,
            kind: super::encode::BranchKind::Call,
        });
        super::encode::emit_call_rel32(code, 0);
        return finish_variadic_call(
            code,
            plan.scratch_bytes,
            dst,
            fp_return,
            ret_agg,
            agg_descs,
            ret_slot_local,
            func,
            frame,
            abi,
        );
    }
    if callee_is_variadic && abi.variadic_zero_xmm_count && !abi.position_indexed_args {
        // System V AMD64 host variadic ABI (Linux x86_64). The named
        // and variadic arguments ride the standard argument-register
        // banks (integer rdi.. + FP xmm0..) then overflow to the stack,
        // exactly like a libc variadic call (System V AMD64 3.2.3). The
        // walker passes the real `fp_arg_mask` (FP varargs ride
        // xmm0..xmm7), so `plan_call_args` places floating-point
        // arguments in the FP bank. `al` carries the number of XMM
        // argument registers used so the callee prologue's guarded XMM
        // save runs only when needed. A by-value aggregate argument the
        // classifier tagged (a 9-16 byte variadic struct spans two
        // eightbytes, all-or-nothing) rides through `plan_call_args_aggs`.
        let plan =
            super::plan_call_args_aggs(args.len(), fixed_args, fp_arg_mask, abi, &aggs, false);
        let xmm_used = xmm_arg_count(&plan);
        if plan.scratch_bytes > 0 {
            emit_stack_alloc(code, plan.scratch_bytes, None);
        }
        if !marshal_args(code, &plan, args, alloc, frame, abi, "Call (SysV variadic)") {
            return false;
        }
        super::encode::emit_mov_al_imm8(code, xmm_used);
        let call_site = code.len();
        fixups.push(Fixup {
            native_offset: call_site,
            target_ent_pc: target_pc,
            kind: super::encode::BranchKind::Call,
        });
        super::encode::emit_call_rel32(code, 0);
        return finish_variadic_call(
            code,
            plan.scratch_bytes,
            dst,
            fp_return,
            ret_agg,
            agg_descs,
            ret_slot_local,
            func,
            frame,
            abi,
        );
    }
    // Every x86_64 variadic callee is marshaled by a host-ABI branch
    // above: Win64 (`position_indexed_args`) or System V AMD64
    // (`variadic_zero_xmm_count`, no `position_indexed_args`). A variadic
    // callee reaching this point would fall through to the non-variadic
    // path and be marshaled without the host variadic register protocol,
    // a silent miscompile; fail the emit instead.
    if callee_is_variadic {
        return fail("Call: variadic callee not matched by a host-ABI branch");
    }
    // c5-internal call convention: integer / pointer arguments ride
    // the integer argument-register bank, floating-point scalars ride
    // the FP bank (System V AMD64 3.2.3). The callee's prologue spills
    // each incoming register into its 16-byte c5 cdecl cell using the
    // same `plan_call_args` placement, so the int and FP banks stay
    // independent on both ends. `fp_arg_mask` comes from the
    // argument types (set by the walker) rather than register
    // placement, since a floating-point constant rides an integer
    // register as its `Imm` bit pattern.
    let plan = super::plan_call_args_aggs(args.len(), args.len(), fp_arg_mask, abi, &aggs, false);
    if plan.scratch_bytes > 0 {
        emit_stack_alloc(code, plan.scratch_bytes, None);
    }
    if !marshal_args(code, &plan, args, alloc, frame, abi, "Call") {
        return false;
    }
    // Record a fixup for the call's rel32 field. `emit_call_rel32`
    // emits opcode 0xE8 then 4 bytes of rel32; `target_ent_pc`
    // resolves to the function's native offset in the post-pass.
    let call_site = code.len();
    fixups.push(Fixup {
        native_offset: call_site,
        target_ent_pc: target_pc,
        kind: super::encode::BranchKind::Call,
    });
    super::encode::emit_call_rel32(code, 0);
    if plan.scratch_bytes > 0 {
        emit_add_rsp_imm32(code, plan.scratch_bytes);
    }
    // Host-ABI aggregate return (System V AMD64 3.2.3): a <= 16-byte
    // aggregate arrives in rax:rdx; store it into the caller's result
    // temp. (> 16-byte returns keep the out-pointer convention and
    // never set `ret_agg`.)
    if store_ret_agg(code, ret_agg, agg_descs, ret_slot_local, func, frame, abi) {
        return true;
    }
    // c5 internal call return convention: an integer / pointer
    // result lives in rax; a floating-point result lives in xmm0
    // (the callee's `Return` places it there per C99 6.2.5p10 and
    // the SysV / Win64 scalar-FP-return rule). `fp_return` selects
    // which register the result is read from for every dst kind,
    // including a spill slot.
    if fp_return {
        xmm0_result_to_dst(code, dst, frame);
    } else {
        int_result_to_dst(code, dst, Reg::RAX, frame);
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
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
    ret_agg: Option<u32>,
    ret_slot_local: i64,
    func: &FunctionSsa,
) -> bool {
    let Some(import_index) = imports.index_of_binding(binding_idx) else {
        return false;
    };
    let imp = &imports.imports[import_index];
    let fixed = if imp.is_variadic {
        imp.fixed_args.min(args.len())
    } else {
        args.len()
    };
    // With no by-value struct argument this reduces to the scalar
    // `plan_call_args` placement; a tagged aggregate rides through the
    // host-ABI argument-register packing instead.
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    let plan = super::plan_call_args_aggs(args.len(), fixed, fp_arg_mask, abi, &aggs, false);
    let xmm_used = xmm_arg_count(&plan);
    if plan.scratch_bytes > 0 {
        emit_stack_alloc(code, plan.scratch_bytes, None);
    }
    if !marshal_args(code, &plan, args, alloc, frame, abi, "CallExt") {
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
            super::encode::emit_mov_al_imm8(code, xmm_used);
        } else {
            super::encode::emit_xor_eax_eax(code);
        }
    }
    let call_site = code.len();
    plt_call_fixups.push(PltCallFixup {
        instr_offset: call_site,
        import_index,
        is_tail: false,
        is_addr: false,
    });
    super::encode::emit_call_rel32(code, 0);
    if plan.scratch_bytes > 0 {
        emit_add_rsp_imm32(code, plan.scratch_bytes);
    }
    // Host-ABI aggregate return (System V AMD64 3.2.3): a <= 16-byte
    // aggregate arrives in rax:rdx (INTEGER) / xmm0:xmm1 (SSE); store each
    // eightbyte into the caller's result temp. The walker tags `ret_agg`
    // for the register-returned class; > 16-byte returns use the OutPtr
    // hidden-argument path and do not reach here.
    if store_ret_agg(code, ret_agg, agg_descs, ret_slot_local, func, frame, abi) {
        return true;
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
        int_result_to_dst(code, dst, scratch, frame);
        return true;
    }
    if ty_helpers::is_float_ty(bare) || ty_helpers::is_double_ty(bare) {
        // A float / double result is FP-classed (`Inst::CallExt::fp_return`).
        // An f32 result is the single in the low 32 bits of xmm0 -- the same
        // form `FpCast(F64ToF32)` produces and `StoreLocal F32` /
        // `FpCast(F32ToF64)` consume -- so route it without widening. (The
        // prior GPR-bridged path widened via cvtss2sd because the
        // integer-class convention carried the f64-widened bits.)
        xmm0_result_to_dst(code, dst, frame);
        return true;
    }
    let ext = super::return_extension(return_type_tag, target);
    super::encode::emit_extend_rax_for_return(code, ext);
    mirror_int_dst(code, dst, Reg::RAX, frame);
    true
}

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
    abi: super::Abi,
    fp_return: bool,
    fp_arg_mask: u32,
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
    ret_agg: Option<u32>,
    ret_slot_local: i64,
    func: &super::super::ir::FunctionSsa,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) -> bool {
    let target_place = place_of(alloc, target);
    // Collect every register `marshal_args` reads or writes for
    // this call; the staged target must avoid all of them.
    //
    //   * Arg SOURCES: the marshal reads each argument from its
    //     allocator placement. Staging the target over an arg
    //     source corrupts that arg before the marshal copies it.
    //   * Arg DESTINATIONS (`abi.int_arg_regs[0..n]`, e.g.
    //     rcx/rdx/r8/r9 on Win64, rdi/rsi/rdx/rcx/r8/r9 on SysV):
    //     the marshal writes each argument into its target arg
    //     register. Staging the target into an arg-destination
    //     register lets the marshal overwrite it before the
    //     `call`, sending control to the first argument's value.
    //   * SCRATCH_R10: the marshal's parallel-register-move scratch
    //     (`schedule_int_reg_moves`) and spill/stack staging
    //     register; it is clobbered mid-marshal.
    // A Win64 variadic indirect call (the pointed-to prototype is
    // variadic and the target is Win64) splits the arguments into the
    // named prefix and the variadic tail: the planner places the named
    // prefix per Win64 position-indexing and the variadic tail at
    // 8-byte stride past the home area (Microsoft x64 calling
    // convention). The walker widened the variadic floating-point
    // arguments to double and passed `fp_arg_mask` 0, so every argument
    // rides the integer side. Every other dialect (SysV, or a
    // non-variadic Win64 callee) treats all arguments as fixed, which
    // leaves `fixed = args.len()` and the placement unchanged.
    let fixed = if callee_variadic && abi.position_indexed_args {
        fixed_args.min(args.len())
    } else {
        args.len()
    };
    // A by-value aggregate argument the classifier tagged rides through
    // `plan_call_args_aggs`, which lays its eightbytes into the argument
    // registers / stack (System V AMD64 3.2.3); with no tagged aggregate
    // this reduces to the scalar placement.
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    let plan = super::plan_call_args_aggs(args.len(), fixed, fp_arg_mask, abi, &aggs, false);
    // Collect every register `marshal_args` reads or writes for this
    // call; the staged target pointer must avoid all of them.
    //   * Arg SOURCES: each argument is read from its allocator
    //     placement; staging the target over a source corrupts it.
    //   * Arg DESTINATIONS: every integer register the plan writes -- a
    //     scalar `IntReg`, a by-reference base, or an aggregate's
    //     integer eightbytes -- is overwritten before the `call`.
    //   * SCRATCH_R10: the marshal's parallel-move / staging scratch.
    let mut blocked: alloc::vec::Vec<Reg> =
        alloc::vec::Vec::with_capacity(args.len() + abi.int_arg_regs.len() + 2);
    for &a in args {
        if let Some(Place::IntReg(r)) = alloc.places.get(a as usize) {
            blocked.push(Reg(*r));
        }
    }
    for p in &plan.placements {
        match p {
            super::ArgPlacement::IntReg(r) | super::ArgPlacement::StructByRefReg(r) => {
                blocked.push(Reg(*r));
            }
            super::ArgPlacement::StructRegs { regs, n, .. } => {
                for cr in &regs[..*n as usize] {
                    if !cr.is_fp {
                        blocked.push(Reg(cr.reg));
                    }
                }
            }
            _ => {}
        }
    }
    blocked.push(SCRATCH_R10);
    // A System V variadic indirect call sets `al` to the XMM-argument
    // count just before the `call` (System V AMD64 3.2.3). The target
    // pointer must not be staged in rax, or the `mov al, imm8` would
    // corrupt its low byte; block rax for the target scratch.
    let sysv_variadic_call = callee_variadic && abi.sysv_host_variadic();
    if sysv_variadic_call {
        blocked.push(Reg::RAX);
    }
    // Capture the target pointer into a caller-saved scratch before arg
    // marshalling can clobber it. rax is the usual pick: no ABI assigns
    // it to an argument slot, so it is blocked only on a System V
    // variadic call (where it carries the XMM count). The pool excludes
    // the marshal's reserved scratch r10 / r11, so a pick never aliases
    // it. When everything is blocked the `else` branch below spills the
    // target to the stack.
    let target_scratch = pick_caller_saved_scratch(Reg(0xff), &blocked);
    // System V AMD64 3.2.3: a variadic call passes the XMM-argument
    // count in `al`. Computed from the plan and emitted after the
    // marshal (which never writes rax, blocked above for the target).
    let xmm_used = xmm_arg_count(&plan);
    if let Some(target_scratch) = target_scratch {
        // A free caller-saved register is available: stage the
        // target there, then marshal. The marshal never writes
        // `target_scratch` (it is neither an arg source nor r10).
        let Some(target_r) = materialize_int(code, target_place, target_scratch, frame) else {
            return fail("CallIndirect: target not int reg / spill");
        };
        if target_r.0 != target_scratch.0 {
            emit_mov_rr(code, target_scratch, target_r);
        }
        if plan.scratch_bytes > 0 {
            emit_stack_alloc(code, plan.scratch_bytes, None);
        }
        if !marshal_args(code, &plan, args, alloc, frame, abi, "CallIndirect") {
            return false;
        }
        if sysv_variadic_call {
            super::encode::emit_mov_al_imm8(code, xmm_used);
        }
        emit_hardened_call_r(code, target_scratch, abi, extern_sites);
        if plan.scratch_bytes > 0 {
            emit_add_rsp_imm32(code, plan.scratch_bytes);
        }
    } else {
        // Every caller-saved register is an arg source (and r10 is
        // reserved for the marshal). No register survives the
        // marshal, so spill the target to a fresh 16-byte stack
        // slot above the marshal's scratch window, marshal, then
        // reload into SCRATCH_R10 for the `call`. The 16-byte slot
        // keeps the call-site sp 16-aligned (SysV / Win64 require
        // 16-byte alignment at `call`).
        let Some(target_r) = materialize_int(code, target_place, SCRATCH_R10, frame) else {
            return fail("CallIndirect: target not int reg / spill");
        };
        let slot_bytes = 16u32;
        emit_sub_rsp_imm32(code, slot_bytes);
        emit_mov_mem_r(code, Reg::RSP, 0, target_r);
        if plan.scratch_bytes > 0 {
            emit_stack_alloc(code, plan.scratch_bytes, None);
        }
        // rsp is now slot_bytes + scratch_bytes below the frame baseline.
        // marshal_args reloads spilled argument sources at
        // `spill_offset + plan.scratch_bytes`; the target slot must be
        // folded into that shift, or every spilled-source reload reads
        // slot_bytes too low (a spilled arg loads garbage and the call
        // jumps through a corrupt register).
        let mut shifted = plan.clone();
        shifted.scratch_bytes = plan.scratch_bytes + slot_bytes;
        if !marshal_args(code, &shifted, args, alloc, frame, abi, "CallIndirect") {
            return false;
        }
        // The target slot sits just above the marshal's scratch
        // window, at [rsp + scratch_bytes] after the second sub.
        emit_mov_r_mem(code, SCRATCH_R10, Reg::RSP, plan.scratch_bytes as i32);
        if sysv_variadic_call {
            super::encode::emit_mov_al_imm8(code, xmm_used);
        }
        emit_hardened_call_r(code, SCRATCH_R10, abi, extern_sites);
        if plan.scratch_bytes > 0 {
            emit_add_rsp_imm32(code, plan.scratch_bytes);
        }
        emit_add_rsp_imm32(code, slot_bytes);
    }
    // Host-ABI aggregate return through a function pointer (System V
    // AMD64 3.2.3): a <= 16-byte aggregate arrives in rax:rdx; store it
    // into the caller's result temp. The walker tags `ret_agg` only for
    // the register-returned class, so > 16-byte (out-pointer) returns do
    // not reach here.
    if store_ret_agg(code, ret_agg, agg_descs, ret_slot_local, func, frame, abi) {
        return true;
    }
    // A floating-point return rides xmm0 (C99 6.2.5p10); an integer
    // / pointer return rides rax. `fp_return` selects the source for
    // every dst kind.
    if fp_return {
        xmm0_result_to_dst(code, dst, frame);
    } else {
        int_result_to_dst(code, dst, Reg::RAX, frame);
    }
    true
}

/// System V AMD64 `va_arg` (ABI 3.5.7). `args[0]` is the
/// `__va_list_tag` pointer; `args[1]` is the packed
/// `(kind << 16) | size` descriptor the parser folded as an
/// `Inst::Imm`. The intrinsic returns the address of the slot holding
/// the next argument (the `<stdarg.h>` macro dereferences it as the
/// requested type) and advances the matching offset / pointer in the
/// struct.
///
/// Integer / pointer (kind 0): if `gp_offset < 48` the value sits in
/// the register save area at `reg_save_area + gp_offset` and
/// `gp_offset` advances by 8; otherwise it sits in the overflow area
/// at `overflow_arg_area`, which advances by 8.
///
/// Floating-point (kind 1): if `fp_offset < 176` the value sits at
/// `reg_save_area + fp_offset` and `fp_offset` advances by 16;
/// otherwise it sits at `overflow_arg_area`, which advances by 8.
///
/// Struct layout (matching `<stdarg.h>` / libc): gp_offset at +0,
/// fp_offset at +4, overflow_arg_area at +8, reg_save_area at +16.
fn emit_va_arg_sysv(
    code: &mut Vec<u8>,
    args: &[u32],
    dst: Place,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
    if args.len() != 2 {
        return fail("VaArg: expected 2 args (ap, descriptor)");
    }
    // Recover the packed descriptor from the `Inst::Imm` the parser
    // folded for the type operand.
    let descriptor = match func.insts.get(args[1] as usize) {
        Some(Inst::Imm(d)) => *d,
        _ => return fail("VaArg: descriptor operand is not a constant"),
    };
    let kind = (descriptor >> 16) & 0xffff;
    let is_fp = kind == 1;
    // Cursor pointer (struct address) held in r11, outside the
    // allocator's banks. The result address is computed in r10; both
    // are disjoint from the allocator-chosen `dst`.
    let Some(ap_place) = alloc.places.get(args[0] as usize).copied() else {
        return fail("VaArg: &ap value id out of range");
    };
    let Some(ap) = materialize_int(code, ap_place, SCRATCH_R11, frame) else {
        return fail("VaArg: &ap not in int reg / spill");
    };
    // r11 must hold the struct pointer across the whole sequence; if
    // `materialize_int` returned an allocator register, move it into r11
    // so the offset writebacks don't clobber a live value.
    let ap = if ap.0 != SCRATCH_R11.0 {
        emit_mov_rr(code, SCRATCH_R11, ap);
        SCRATCH_R11
    } else {
        ap
    };
    // A by-value integer-class aggregate spans `ceil(size/8)` eightbytes
    // in consecutive gp save-area slots (System V AMD64 3.5.7); it rides
    // the register save area only if all its eightbytes fit
    // (`gp_offset + aligned <= 48`), else the whole aggregate sits in the
    // overflow area. A scalar's aligned size is 8, leaving the bound and
    // step at their single-eightbyte values. Floating-point arguments are
    // single doubles (the classifier declines HFAs), so they keep the
    // 16-byte fp-slot step and 176-byte bound.
    let aligned = (((descriptor & 0xffff) as i32 + 7) & !7).max(8);
    let (off_disp, bound, step): (i32, i32, i32) = if is_fp {
        (4, 176, 16)
    } else {
        (0, 48 - (aligned - 8), aligned)
    };
    // r10 = current offset (gp_offset or fp_offset, a u32 field; the
    // 32-bit load zero-extends into r10). The whole sequence touches
    // only r10 and r11 -- both reserved outside the allocator's banks --
    // plus the in-memory va_list fields, so it never clobbers a live
    // allocator value (the consuming `t += va_arg(...)` keeps `t` in an
    // allocator register that an earlier draft overwrote via rcx).
    super::encode::emit_mov_r32_mem(code, SCRATCH_R10, ap, off_disp);
    // cmp r10d, bound ; jae use_overflow
    super::encode::emit_ri(code, Mnem::Cmp, 8, SCRATCH_R10, bound);
    super::encode::emit_jcc_rel32(code, Cc::Ae, 0);
    let jae_rel32_at = code.len() - 4;
    // --- register-save path ---
    // r10 = offset + reg_save_area (at [ap + 16]) = the argument slot,
    // then bump the offset field in memory by step.
    super::encode::emit_rm(code, Mnem::Add, 8, SCRATCH_R10, ap, 16);
    super::encode::emit_mi(code, Mnem::Add, 4, ap, off_disp, step);
    // jmp done
    super::encode::emit_jmp_rel32(code, 0);
    let jmp_rel32_at = code.len() - 4;
    // --- overflow path ---
    let overflow_start = code.len();
    let rel_to_overflow = (overflow_start - (jae_rel32_at + 4)) as i32;
    code[jae_rel32_at..jae_rel32_at + 4].copy_from_slice(&rel_to_overflow.to_le_bytes());
    // r10 = overflow_arg_area (at [ap + 8]) = the argument slot, then
    // bump it in memory by the argument's eightbyte span. System V AMD64
    // 3.5.7 rounds each overflow argument to an eightbyte; a scalar or a
    // `double` occupies one, a by-value aggregate `ceil(size/8)`.
    let ov_step = if is_fp { 8 } else { aligned };
    emit_mov_r_mem(code, SCRATCH_R10, ap, 8);
    super::encode::emit_mi(code, Mnem::Add, 8, ap, 8, ov_step);
    // --- done: r10 holds the argument address; deliver it to dst. ---
    let done = code.len();
    let rel_to_done = (done - (jmp_rel32_at + 4)) as i32;
    code[jmp_rel32_at..jmp_rel32_at + 4].copy_from_slice(&rel_to_done.to_le_bytes());
    int_result_to_dst(code, dst, SCRATCH_R10, frame);
    true
}

/// Block-target branch context for an `asm goto` statement. The
/// template's `%lK` branches leave the statement, so they must run the
/// register-restore sequence first; each referenced label gets a local
/// trampoline (restore + jump) whose final jump rides the enclosing
/// function's `BranchFixup` machinery to the target block.
struct AsmGotoCtx<'a> {
    /// `jump_tables` row: `[fall_through, label targets...]`.
    row: &'a [super::super::ir::BlockId],
    branch_fixups: &'a mut alloc::vec::Vec<BranchFixup>,
    branch_short: &'a [bool],
}

/// Access width of a template memory operand. A memory reference carries no
/// width of its own: a `%N` size modifier wins, else the AT&T size suffix,
/// else a GP register operand of the same instruction. `None` leaves the
/// choice to the caller's default.
fn asm_mem_size(
    modifier: Option<super::super::ir::AsmRegSize>,
    insn: &super::asm::AsmInsn,
    operands: &[super::super::ir::AsmOperand],
    op_reg: &[Option<u8>],
) -> Option<super::super::ir::AsmRegSize> {
    use super::super::ir::{AsmConstraint, AsmRegSize};
    use super::asm::AsmOpnd;
    modifier.or(insn.suffix).or_else(|| {
        insn.operands.iter().find_map(|o| match *o {
            AsmOpnd::Reg { reg, size } if reg < super::asm::XMM_BASE => Some(size),
            AsmOpnd::Ref { idx, size }
                if op_reg.get(idx as usize).copied().flatten().is_some()
                    && !matches!(
                        operands[idx as usize].constraint,
                        AsmConstraint::Fp | AsmConstraint::Mem
                    ) =>
            {
                Some(size.unwrap_or(AsmRegSize::from_width(operands[idx as usize].width)))
            }
            _ => None,
        })
    })
}

/// RIP-relative target of an inline-asm `%a` address operand: an
/// `i`-class operand naming a link-time data address (`&global`,
/// optionally offset by a constant).
enum AsmRipSym {
    /// Cross-TU global: `offset` is the constant byte offset added to the
    /// named symbol.
    Extern {
        name: alloc::string::String,
        offset: i64,
    },
    /// Global defined in this unit: `data_offset` is its byte offset in the
    /// merged data segment.
    Local { data_offset: i64 },
    /// Function defined in this unit, named by its entry PC. Resolved
    /// through the same channel as an `Inst::ImmCode` function-pointer
    /// literal, so the reference reaches the function's own body.
    Text { ent_pc: usize },
}

/// Resolve an inline-asm `%a` / `%c` address operand to a RIP-relative
/// relocation target. `arg` is the operand's SSA value-id; the accepted
/// shape is a C99 6.6p9 address constant -- the address of a static-storage
/// object or of a function, plus a constant byte offset. Returns `None`
/// when the operand is not a link-time address.
fn asm_riprel_target(
    func: &FunctionSsa,
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_code_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    arg: u32,
) -> Option<AsmRipSym> {
    use super::ssa::emit_common::{asm_operand_code_base, asm_operand_data_target};
    if let Some((target, addend)) =
        asm_operand_data_target(&func.insts, arg, &|v| extern_data_names.get(&v).cloned())
    {
        use super::ssa::emit_common::AsmSectionTarget;
        return Some(match target {
            AsmSectionTarget::Symbol(name) => AsmRipSym::Extern {
                name,
                offset: addend,
            },
            AsmSectionTarget::Data(off) => AsmRipSym::Local {
                data_offset: off as i64,
            },
            _ => return None,
        });
    }
    let (base_vid, ent_pc, offset) = asm_operand_code_base(&func.insts, arg)?;
    // `name2entpc` holds the unit's own definitions. One of them takes the
    // entry-PC channel, which reaches the emitted body; every other name is
    // cross-TU and relocates by name. The in-unit channel names the entry,
    // so a byte offset into the body has nowhere to ride.
    if name2entpc.values().any(|&pc| pc == ent_pc) {
        return (offset == 0).then_some(AsmRipSym::Text { ent_pc });
    }
    extern_code_names
        .get(&base_vid)
        .map(|name| AsmRipSym::Extern {
            name: name.clone(),
            offset,
        })
}

/// Encode replacement instructions in an executable inline-asm section
/// (`.pushsection .altinstr_replacement,"ax"`) to bytes and relocations,
/// replacing each `Code` item with `CodeBytes`. The x86 ALTERNATIVE puts
/// its replacement in a separate section, so there is no fall-through from
/// the main sequence; the bytes and their relocations lay out like any
/// other section data. Only a direct `call` / `jmp` to a symbol (a bare
/// name or a `%c` function operand), a `jmp` / `jcc` to an `asm goto` label
/// (`%lK`, via `goto_block`), and self-contained instructions are assembled;
/// a replacement referencing a register operand or a memory location is
/// rejected rather than mis-encoded.
fn encode_x86_asm_section_code(
    blocks: &mut [super::ssa::emit_common::AsmSectionBlock],
    func: &FunctionSsa,
    args: &[u32],
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_code_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    goto_block: &dyn Fn(u8) -> Option<u32>,
    op_reg: &[Option<u8>],
    operands: &[super::super::ir::AsmOperand],
) -> Result<(), alloc::string::String> {
    use super::super::ir::Inst;
    use super::ssa::emit_common::{AsmSectionItem, AsmSectionTarget};
    // A same-TU function operand is an `ImmCode` whose ent_pc reverses to its
    // name here; a cross-TU one carries its name in `extern_code_names`.
    let mut entpc2name: alloc::collections::BTreeMap<usize, &str> =
        alloc::collections::BTreeMap::new();
    for (n, &pc) in name2entpc {
        entpc2name.entry(pc).or_insert(n.as_str());
    }
    let operand_target = |idx: u8| -> Option<AsmSectionTarget> {
        let arg = *args.get(idx as usize)?;
        if let Some(name) = extern_code_names.get(&arg) {
            return Some(AsmSectionTarget::Symbol(name.clone()));
        }
        match func.insts.get(arg as usize) {
            Some(Inst::ImmCode(pc)) => entpc2name
                .get(pc)
                .map(|n| AsmSectionTarget::Symbol(alloc::string::String::from(*n))),
            _ => super::ssa::emit_common::asm_operand_data_target(&func.insts, arg, &|v| {
                extern_data_names.get(&v).cloned()
            })
            .map(|(t, _)| t),
        }
    };
    // A `%N` naming an `i`-class operand with a compile-time constant.
    let imm_of = |idx: u8| -> Option<i64> {
        match func.insts.get(*args.get(idx as usize)? as usize) {
            Some(Inst::Imm(v)) => Some(*v),
            _ => None,
        }
    };
    // A `%a[N]` operand naming a link-time data address (`&global`): its reloc
    // target and the constant byte offset added to it.
    let addr_of = |idx: u8| -> Option<(AsmSectionTarget, i64)> {
        let arg = *args.get(idx as usize)?;
        super::ssa::emit_common::asm_operand_data_target(&func.insts, arg, &|v| {
            extern_data_names.get(&v).cloned()
        })
    };
    let mut mode = super::table::Mode::Bits64;
    let mut fold = super::ssa::emit_common::AsmParseFold::default();
    for b in blocks.iter_mut() {
        fold.enter_block(&*b);
        for item in b.items.iter_mut() {
            if let AsmSectionItem::Code(text) = item {
                let f = |e: &str| fold.fold(e, &imm_of);
                let refs = SectionOperandRefs {
                    op_reg,
                    operands,
                    imm_of: &imm_of,
                    addr_of: &addr_of,
                    fold: &f,
                    file_scope: false,
                };
                *item = encode_one_x86_section_insn(
                    text,
                    &mut mode,
                    &operand_target,
                    goto_block,
                    &refs,
                )?;
            }
            fold.note_item(item, &imm_of);
        }
    }
    Ok(())
}

/// Encode a file-scope inline-asm named section's instructions to bytes,
/// reusing the function-body per-instruction encoder with an empty operand
/// context: file-scope asm has no numbered operands, `asm goto` labels, or
/// register assignments, so only self-contained instructions and a direct
/// `call` / `jmp` to a bare symbol assemble.
///
/// The `.code16` / `.code32` / `.code64` state is a property of the assembler's
/// input stream, so it carries across the walk in section order rather than
/// resetting per section.
pub(crate) fn encode_x86_file_asm_section_code(
    blocks: &mut [super::ssa::emit_common::AsmSectionBlock],
    class: crate::c5::ElfClass,
) -> Result<(), alloc::string::String> {
    use super::ssa::emit_common::{AsmSectionItem, AsmSectionTarget};
    let operand_target = |_: u8| -> Option<AsmSectionTarget> { None };
    let goto_block = |_: u8| -> Option<u32> { None };
    let imm_of = |_: u8| -> Option<i64> { None };
    let addr_of = |_: u8| -> Option<(AsmSectionTarget, i64)> { None };
    let mut mode = if class.is32() {
        super::table::Mode::Bits32
    } else {
        super::table::Mode::Bits64
    };
    // Inside a deferred `.rept` nothing folds: the count, and with it every
    // offset the body's copies take, is settled by the layout.
    fn encode_rept(
        items: &mut [super::ssa::emit_common::AsmSectionItem],
        mode: &mut super::table::Mode,
        operand_target: &dyn Fn(u8) -> Option<super::ssa::emit_common::AsmSectionTarget>,
        goto_block: &dyn Fn(u8) -> Option<u32>,
        refs: &SectionOperandRefs<'_>,
    ) -> Result<(), alloc::string::String> {
        use super::ssa::emit_common::AsmSectionItem;
        for it in items {
            if let AsmSectionItem::Rept { items, .. } = it {
                encode_rept(items, mode, operand_target, goto_block, refs)?;
            } else if let AsmSectionItem::Code(text) = it {
                *it = encode_one_x86_section_insn(text, mode, operand_target, goto_block, refs)?;
            }
        }
        Ok(())
    }
    let mut fold = super::ssa::emit_common::AsmParseFold::default();
    for b in blocks.iter_mut() {
        fold.enter_block(&*b);
        for item in b.items.iter_mut() {
            if let AsmSectionItem::Rept { items, .. } = item {
                let none = |_: &str| None;
                let refs = SectionOperandRefs {
                    op_reg: &[],
                    operands: &[],
                    imm_of: &imm_of,
                    addr_of: &addr_of,
                    fold: &none,
                    file_scope: true,
                };
                encode_rept(items, &mut mode, &operand_target, &goto_block, &refs)?;
            } else if let AsmSectionItem::Code(text) = item {
                let f = |e: &str| fold.fold(e, &imm_of);
                let refs = SectionOperandRefs {
                    op_reg: &[],
                    operands: &[],
                    imm_of: &imm_of,
                    addr_of: &addr_of,
                    fold: &f,
                    file_scope: true,
                };
                *item = encode_one_x86_section_insn(
                    text,
                    &mut mode,
                    &operand_target,
                    &goto_block,
                    &refs,
                )?;
            }
            fold.note_item(item, &imm_of);
        }
    }
    Ok(())
}

/// Opcode of a branch whose displacement field is rel8 only.
pub(crate) fn short_branch_opcode(mnem: &str) -> Option<u8> {
    Some(match mnem {
        "loopne" | "loopnz" => 0xE0,
        "loope" | "loopz" => 0xE1,
        "loop" => 0xE2,
        "jrcxz" | "jecxz" | "jcxz" => 0xE3,
        _ => return None,
    })
}

/// Address-size prefix of an `E3 rel8` branch. The counter the name spells is
/// the instruction's address size: the mode's default takes no prefix, the
/// mode's other address size takes `67`, and a width the mode cannot address
/// has no encoding, as GNU as rejects it.
fn e3_branch_prefix(
    mnem: &str,
    mode: super::table::Mode,
) -> Result<Option<u8>, alloc::string::String> {
    let width: u8 = match mnem {
        "jcxz" => 2,
        "jecxz" => 4,
        "jrcxz" => 8,
        _ => return Ok(None),
    };
    let dflt = mode.addrsize();
    let alt = if dflt == 2 { 4 } else { dflt / 2 };
    if width == dflt {
        Ok(None)
    } else if width == alt {
        Ok(Some(0x67))
    } else {
        Err(alloc::format!(
            "inline asm: `{mnem}` does not encode in {}-bit mode",
            dflt * 8
        ))
    }
}

/// A branch target's section target: a bare name resolves through the label,
/// section and `.set` maps; an expression over them (`jmp sym + 4`) is valued
/// where the section materializes.
fn branch_section_target(text: &str) -> super::ssa::emit_common::AsmSectionTarget {
    use super::ssa::emit_common::{AsmSectionTarget, is_asm_symbol_name};
    if is_asm_symbol_name(text) {
        AsmSectionTarget::Symbol(alloc::string::String::from(text))
    } else {
        AsmSectionTarget::Expr(alloc::string::String::from(text))
    }
}

/// The `rel8` encoding of a direct branch: `EB` for `jmp`, `70+cc` for a
/// `jcc`. GNU as takes it whenever the target is a label of the branch's own
/// section within a signed-byte displacement, in every code-size mode; the
/// layout makes that choice, so both forms are handed to it. A `call` has no
/// short form.
fn short_branch_form(
    opcode: u8,
    target: &super::ssa::emit_common::AsmSectionTarget,
) -> super::ssa::emit_common::AsmShortBranch {
    use super::ssa::emit_common::{AsmRelocKind, AsmSectionReloc, AsmShortBranch};
    AsmShortBranch {
        bytes: alloc::vec![opcode, 0],
        reloc: AsmSectionReloc {
            offset: 1,
            width: 1,
            kind: AsmRelocKind::JumpRel,
            pcrel: true,
            branch: false,
            signed: false,
            target: target.clone(),
            addend: -1,
        },
    }
}

/// Legacy prefixes in GNU as order: segment, address size, operand size, then
/// repeat / lock. `body` carries the size prefixes at its front and `pending`
/// the bytes prefix statements deposited. Returns the count of `body` bytes
/// taken; the rest is the caller's to append.
fn push_legacy_prefixes(
    out: &mut alloc::vec::Vec<u8>,
    body: &[u8],
    seg: Option<u8>,
    pending: &[u8],
) -> usize {
    let is_seg = |b: u8| matches!(b, 0x26 | 0x2E | 0x36 | 0x3E | 0x64 | 0x65);
    let sizes = body.iter().take_while(|b| matches!(b, 0x66 | 0x67)).count();
    out.extend(seg);
    out.extend(pending.iter().copied().filter(|&b| is_seg(b)));
    out.extend_from_slice(&body[..sizes]);
    out.extend(pending.iter().copied().filter(|&b| !is_seg(b)));
    sizes
}

/// Byte width of a near-branch displacement and whether the operand-size
/// prefix selects it. The displacement follows the operand size, which is 32
/// in long and 32-bit modes and 16 in 16-bit mode; an AT&T size suffix
/// (`calll` in a `.code16` stub) names the other one.
fn branch_rel_width(
    mode: super::table::Mode,
    suffix: Option<super::super::ir::AsmRegSize>,
) -> (u8, bool) {
    let dflt: u8 = if mode == super::table::Mode::Bits16 {
        2
    } else {
        4
    };
    let want = match suffix.map(|s| s.bytes()) {
        Some(2) => 2,
        Some(4) => 4,
        _ => dflt,
    };
    (want, want != dflt)
}

/// Template-operand resolution for a replacement instruction: the register
/// assignments, `i`-class constant immediates, and link-time data addresses
/// (`%a`) its operand references resolve through. Built by
/// `encode_x86_asm_section_code` from the enclosing statement's operand list.
struct SectionOperandRefs<'a> {
    op_reg: &'a [Option<u8>],
    operands: &'a [super::super::ir::AsmOperand],
    imm_of: &'a dyn Fn(u8) -> Option<i64>,
    addr_of: &'a dyn Fn(u8) -> Option<(super::ssa::emit_common::AsmSectionTarget, i64)>,
    /// The value an operand expression already has at this point of the
    /// stream, when the walk's [`AsmParseFold`] can prove it is a constant.
    /// A folded immediate or displacement encodes as a literal, taking the
    /// narrow field GNU as picks at the same point.
    fold: &'a dyn Fn(&str) -> Option<i64>,
    /// File-scope / `.S`-unit text is basic asm, where `%kN` is an opmask
    /// register; an extended-asm statement's section text keeps GCC's
    /// `%k<N>` operand-modifier reading.
    file_scope: bool,
}

/// Encode one replacement instruction to a `CodeBytes` item. A direct
/// `call` / `jmp` to a symbol emits `E8`/`E9` with a zero rel32 and a
/// `PLT32` branch relocation (addend -4), matching a compiler-emitted
/// call; a `jmp` / `jcc` to an `asm goto` label (`%lK`) emits the same
/// `E9` / `0F 8x` rel32 with a `PC32` relocation (addend -4) to the label's
/// caller block. Otherwise the operands resolve to registers, immediates,
/// and memory references: a template operand (`%N`) takes its register or
/// `i`-class constant, a register-indirect / displacement memory operand
/// encodes with no relocation, and a `%a[N]` operand naming a link-time
/// address lowers to a RIP-relative reference with a `PC32` relocation
/// against the symbol. A form that resolves to none of these is rejected.
fn encode_one_x86_section_insn(
    text: &str,
    mode: &mut super::table::Mode,
    operand_target: &dyn Fn(u8) -> Option<super::ssa::emit_common::AsmSectionTarget>,
    goto_block: &dyn Fn(u8) -> Option<u32>,
    refs: &SectionOperandRefs<'_>,
) -> Result<super::ssa::emit_common::AsmSectionItem, alloc::string::String> {
    use super::super::ir::{AsmConstraint, AsmRegSize, AsmSeg};
    use super::asm::{AsmMemBase, AsmOpnd, Concrete, Mnemonic};
    use super::ssa::emit_common::{
        AsmRelocKind, AsmSectionItem, AsmSectionReloc, AsmSectionTarget,
    };
    // An encoding-mode directive sets the state the rest of the stream
    // assembles under and deposits no bytes.
    if let Some(m) = match text {
        ".code16" => Some(super::table::Mode::Bits16),
        ".code32" => Some(super::table::Mode::Bits32),
        ".code64" => Some(super::table::Mode::Bits64),
        _ => None,
    } {
        *mode = m;
        return Ok(AsmSectionItem::CodeBytes {
            bytes: alloc::vec::Vec::new(),
            relocs: alloc::vec::Vec::new(),
            short: None,
        });
    }
    let mode = *mode;
    let insns = if refs.file_scope {
        super::asm::parse_file_template(text.as_bytes())
    } else {
        super::asm::parse_template(text.as_bytes())
    }
    .map_err(|m| alloc::format!("inline asm: replacement `{text}`: {m}"))?;
    // Each leading `lock` / `rep` / segment prefix parses as its own entry and
    // rides in front of the instruction's bytes. A prefix statement standing
    // alone is the instruction, so the run stops one short of the end.
    let prefix: alloc::vec::Vec<u8> = insns
        .split_last()
        .map_or(&[][..], |(_, head)| head)
        .iter()
        .map_while(|i| match i.mnemonic {
            Mnemonic::Prefix(b) => Some(b),
            _ => None,
        })
        .collect();
    let [insn] = &insns[prefix.len()..] else {
        return Err(alloc::format!(
            "inline asm: replacement `{text}` is not a single instruction"
        ));
    };
    let prefix = prefix.as_slice();
    let mnem = match insn.mnemonic {
        Mnemonic::Table(n) => n,
        _ => "",
    };
    // REX is a 64-bit-mode prefix; the other modes read the byte as an
    // instruction, so GNU as rejects it there.
    if mode != super::table::Mode::Bits64
        && (insn.rex.is_some()
            || matches!(insn.mnemonic, Mnemonic::Prefix(b) if (0x40..=0x4F).contains(&b)))
    {
        return Err(alloc::format!(
            "inline asm: replacement `{text}` takes a `rex` prefix outside 64-bit mode"
        ));
    }
    // A prefixed branch or symbol push has no meaning; the prefix applies
    // on the general operand path below. The direct-branch forms are built
    // by hand and carry neither prefix byte, so one on them would be
    // dropped rather than encoded.
    if (!prefix.is_empty() || insn.rex.is_some())
        && (matches!(
            insn.operands.first(),
            Some(AsmOpnd::GotoLabel(_) | AsmOpnd::ImmSym { .. } | AsmOpnd::Label { .. })
        ) || (!insn.sym_exprs.is_empty() && insn.operands.is_empty()))
    {
        return Err(alloc::format!(
            "inline asm: replacement `{text}` prefix on a branch"
        ));
    }
    // A `jmp` / `jcc` to an `asm goto` label (`%lK`): the replacement leaves
    // the alternative for a caller block (`jmp %l[t_no]` in `_static_cpu_has`).
    // Emit the rel32 form with a zero displacement and a `PC32` relocation to
    // the label's block, deferred as `TextBlock` and rewritten to the block's
    // text offset after layout -- the GNU as cross-section branch (addend -4).
    if let Some(&AsmOpnd::GotoLabel(k)) = insn.operands.first() {
        let cc = jcc_cond(mnem);
        if cc.is_none() && !matches!(mnem, "jmp" | "jmpq") {
            return Err(alloc::format!(
                "inline asm: replacement `{text}` label operand on a non-jump"
            ));
        }
        let bid = goto_block(k).ok_or_else(|| {
            alloc::format!("inline asm: replacement `{text}` `%l{k}` names no `asm goto` label")
        })?;
        let mut bytes = alloc::vec::Vec::new();
        let offset = match cc {
            Some(cc) => {
                super::encode::emit_jcc_rel32(&mut bytes, cc, 0);
                2
            }
            None => {
                super::encode::emit_jmp_rel32(&mut bytes, 0);
                1
            }
        };
        let reloc = AsmSectionReloc {
            offset,
            width: 4,
            kind: AsmRelocKind::Data,
            pcrel: true,
            branch: false,
            signed: false,
            target: AsmSectionTarget::TextBlock(bid),
            addend: -4,
        };
        return Ok(AsmSectionItem::CodeBytes {
            bytes,
            relocs: alloc::vec![reloc],
            short: None,
        });
    }
    // The count- and rcx-conditional branches take a rel8 field only, so a
    // label target resolves to a one-byte displacement rather than the
    // mode-width one the other branches take.
    if let Some(op) = short_branch_opcode(mnem) {
        let prefix = e3_branch_prefix(mnem, mode).map_err(|m| alloc::format!("{m} (`{text}`)"))?;
        let target = if let Some(&AsmOpnd::Label { num, forward }) = insn.operands.first() {
            Some(AsmSectionTarget::Symbol(alloc::format!(
                "{num}{}",
                if forward { 'f' } else { 'b' }
            )))
        } else {
            insn.sym_exprs
                .first()
                .filter(|n| insn.operands.is_empty() && !n.contains('%'))
                .map(|t| branch_section_target(t))
        };
        if let Some(target) = target {
            let mut bytes = alloc::vec::Vec::new();
            bytes.extend(prefix);
            bytes.extend([op, 0]);
            return Ok(AsmSectionItem::CodeBytes {
                relocs: alloc::vec![AsmSectionReloc {
                    offset: bytes.len() as u32 - 1,
                    width: 1,
                    // Not `JumpRel`: these have no wider form, so GNU as
                    // fixes them up rather than relaxing them, and a global
                    // target keeps its relocation as it does for `call`.
                    kind: AsmRelocKind::Data,
                    pcrel: true,
                    branch: false,
                    signed: false,
                    target,
                    addend: -1,
                }],
                bytes,
                short: None,
            });
        }
        // `jcxz` / `jecxz` have no catalogue row to fall back to.
        if matches!(mnem, "jcxz" | "jecxz") {
            return Err(alloc::format!(
                "inline asm: replacement `{text}`: `{mnem}` takes a label target"
            ));
        }
    }
    let is_call = mnem.starts_with("call");
    let is_jmp = matches!(mnem, "jmp" | "jmpq");
    if is_call || is_jmp {
        // A bare-symbol branch target carries no operands; an operand form
        // (`jmp *sym(%rip)`) encodes through the operand path below.
        let target = if let Some(name) = insn.sym_exprs.first().filter(|_| insn.operands.is_empty())
        {
            if name.contains('%') {
                return Err(alloc::format!(
                    "inline asm: replacement `{text}` call target embeds an operand"
                ));
            }
            Some(branch_section_target(name))
        } else if let Some(&AsmOpnd::RefConst { idx, .. }) = insn.operands.first() {
            Some(operand_target(idx).ok_or_else(|| {
                alloc::format!("inline asm: replacement `{text}` call target is not a symbol")
            })?)
        } else if let Some(&AsmOpnd::Label { num, forward }) = insn.operands.first() {
            // A numeric-label target resolves at materialize time against
            // this statement's section labels.
            Some(AsmSectionTarget::Symbol(alloc::format!(
                "{num}{}",
                if forward { 'f' } else { 'b' }
            )))
        } else {
            // An indirect target (`call *%rdi`) encodes on the general
            // operand path below.
            None
        };
        if let Some(target) = target {
            let (rel, prefixed) = branch_rel_width(mode, insn.suffix);
            let mut bytes = alloc::vec::Vec::new();
            if prefixed {
                bytes.push(0x66);
            }
            bytes.push(if is_call { 0xE8u8 } else { 0xE9 });
            let offset = bytes.len() as u32;
            bytes.resize(bytes.len() + rel as usize, 0);
            let reloc = AsmSectionReloc {
                offset,
                width: rel,
                kind: if is_call {
                    AsmRelocKind::Data
                } else {
                    AsmRelocKind::JumpRel
                },
                pcrel: true,
                // Only long mode reaches a call target through a PLT slot.
                branch: mode == super::table::Mode::Bits64,
                signed: false,
                target,
                addend: -(rel as i64),
            };
            let short = (!is_call && !prefixed).then(|| short_branch_form(0xEB, &reloc.target));
            return Ok(AsmSectionItem::CodeBytes {
                bytes,
                relocs: alloc::vec![reloc],
                short,
            });
        }
    }
    // A `jcc` to a symbol or a numeric label -- a section-local label (this
    // or another statement of the section) or an external name: the rel32
    // form with a branch relocation the writer resolves against the label's
    // symbol (a same-section target patches at materialize time).
    if let Some(cc) = jcc_cond(mnem) {
        let target = if insn.operands.is_empty()
            && let Some(name) = insn.sym_exprs.first()
        {
            if name.contains('%') {
                return Err(alloc::format!(
                    "inline asm: replacement `{text}` branch target embeds an operand"
                ));
            }
            Some(branch_section_target(name))
        } else if let Some(&AsmOpnd::Label { num, forward }) = insn.operands.first() {
            Some(AsmSectionTarget::Symbol(alloc::format!(
                "{num}{}",
                if forward { 'f' } else { 'b' }
            )))
        } else {
            None
        };
        if let Some(target) = target {
            let (rel, prefixed) = branch_rel_width(mode, insn.suffix);
            let mut bytes = alloc::vec::Vec::new();
            if prefixed {
                bytes.push(0x66);
            }
            bytes.extend_from_slice(&[0x0F, 0x80 | (cc as u8)]);
            let offset = bytes.len() as u32;
            bytes.resize(bytes.len() + rel as usize, 0);
            let reloc = AsmSectionReloc {
                offset,
                width: rel,
                kind: AsmRelocKind::JumpRel,
                pcrel: true,
                branch: mode == super::table::Mode::Bits64,
                signed: false,
                target,
                addend: -(rel as i64),
            };
            let short = (!prefixed).then(|| short_branch_form(0x70 | (cc as u8), &reloc.target));
            return Ok(AsmSectionItem::CodeBytes {
                bytes,
                relocs: alloc::vec![reloc],
                short,
            });
        }
    }
    // Resolve each operand to a concrete register, immediate, or memory
    // reference. A template operand assigned a register uses it; an `i`-class
    // operand uses its constant. A base register is a `%%reg` or an operand's
    // register; a `%a[N]` operand naming an `i`-class link-time address
    // resolves to no register and lowers to a RIP-relative reference.
    let mem_size = |insn: &super::asm::AsmInsn| {
        asm_mem_size(None, insn, refs.operands, refs.op_reg).unwrap_or(AsmRegSize::Quad)
    };
    let reg_of = |idx: u8, modifier: Option<AsmRegSize>| -> Option<Concrete> {
        let width = refs.operands.get(idx as usize)?.width;
        let size = modifier.unwrap_or(AsmRegSize::from_width(width));
        match refs.op_reg.get(idx as usize).copied().flatten() {
            Some(r) if matches!(refs.operands[idx as usize].constraint, AsmConstraint::Fp) => {
                Some(Concrete::Reg {
                    reg: super::asm::XMM_BASE + r,
                    size,
                })
            }
            Some(r) => Some(Concrete::Reg { reg: r, size }),
            None => (refs.imm_of)(idx).map(Concrete::Imm),
        }
    };
    // A memory base / index that names an operand resolves to its assigned GP
    // register (an FP operand is not an address register).
    let base_reg = |b: AsmMemBase| -> Option<u8> {
        match b {
            AsmMemBase::Reg { num, .. } => Some(num),
            AsmMemBase::Ref(i) => refs.op_reg.get(i as usize).copied().flatten().filter(|_| {
                !matches!(
                    refs.operands.get(i as usize).map(|o| o.constraint),
                    Some(AsmConstraint::Fp)
                )
            }),
        }
    };
    let mut concrete = alloc::vec::Vec::new();
    // A symbolic disp32 operand: its reloc target, the symbol addend, the
    // operand's index in `concrete`, and whether the reference is PC-relative
    // (a RIP-relative `%a` / `%c`) or absolute (a no-base scaled-index
    // `sym(,%index,scale)`). The disp32 field is located by re-encoding. At
    // most one such operand per instruction.
    let mut sym_disp: Option<(AsmSectionTarget, i64, usize, bool)> = None;
    // A `$symbol` immediate: its reloc target, the symbol addend, and the
    // operand's index in `concrete`. The field is located by re-encoding, as
    // for a symbolic displacement. At most one per instruction.
    let mut sym_imm: Option<(AsmSectionTarget, i64, usize)> = None;
    // A `__seg_gs` / `__seg_fs` memory operand's segment override; a template
    // `%%gs:` rides `insn.seg` instead, and the two never conflict.
    let mut operand_seg: Option<u8> = None;
    // The relocation target of the operand expression an operand names: the
    // section engine evaluates it against the layout when the section
    // materializes.
    let expr_target = |i: u8| -> Result<AsmSectionTarget, alloc::string::String> {
        insn.sym_exprs
            .get(i as usize)
            .map(|e| AsmSectionTarget::Expr(e.clone()))
            .ok_or_else(|| {
                alloc::format!("inline asm: replacement `{text}` operand expression is missing")
            })
    };
    for o in &insn.operands {
        match *o {
            AsmOpnd::Imm(v) => concrete.push(Concrete::Imm(v)),
            AsmOpnd::ImmSym { expr } => {
                // An expression that is already a constant encodes as the
                // literal, taking the operand's narrowest form.
                if let Some(v) = insn
                    .sym_exprs
                    .get(expr as usize)
                    .and_then(|e| (refs.fold)(e))
                {
                    concrete.push(Concrete::Imm(v));
                    continue;
                }
                if sym_imm.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one symbol immediate"
                    ));
                }
                sym_imm = Some((expr_target(expr)?, 0, concrete.len()));
                concrete.push(Concrete::Imm(IMM_PROBE[0].1));
            }
            AsmOpnd::Reg { reg, size } => concrete.push(Concrete::Reg { reg, size }),
            AsmOpnd::HighReg(n) => concrete.push(Concrete::HighReg(n)),
            AsmOpnd::Ref { idx, size } => {
                // A memory-constraint (`m`) operand holds its address in the
                // assigned register; `%N` is the register-indirect reference
                // `(%r)`, the same lowering the code stream uses (a `lea %N`
                // then computes the address). Any other operand resolves to a
                // register or an `i`-class constant.
                let op = refs.operands.get(idx as usize);
                let mem = matches!(op.map(|o| o.constraint), Some(AsmConstraint::Mem))
                    .then(|| refs.op_reg.get(idx as usize).copied().flatten())
                    .flatten();
                match mem {
                    Some(base) => {
                        let width = op.map(|o| o.width).unwrap_or(8);
                        let size = asm_mem_size(size, insn, refs.operands, refs.op_reg)
                            .unwrap_or(AsmRegSize::from_width(width));
                        operand_seg = match op.map(|o| o.seg) {
                            Some(AsmSeg::Gs) => Some(0x65),
                            Some(AsmSeg::Fs) => Some(0x64),
                            _ => operand_seg,
                        };
                        concrete.push(Concrete::Mem {
                            base,
                            index: None,
                            scale: 1,
                            disp: 0,
                            size,
                        });
                    }
                    None => concrete.push(reg_of(idx, size).ok_or_else(|| {
                        alloc::format!(
                            "inline asm: replacement `{text}` operand `%{idx}` is not a register or constant"
                        )
                    })?),
                }
            }
            AsmOpnd::Mem {
                base,
                index,
                scale,
                disp,
            } => {
                let size = mem_size(insn);
                // A `%a[N]` (base-only operand naming an `i`-class link-time
                // address) resolves to no register. A scaled index cannot ride
                // the RIP-relative form.
                let sym = match base {
                    AsmMemBase::Ref(bi) if index.is_none() => (refs.addr_of)(bi),
                    _ => None,
                };
                match (base_reg(base), sym) {
                    (Some(b), _) => {
                        let index = match index {
                            Some(i) => Some(base_reg(i).ok_or_else(|| {
                                alloc::format!(
                                    "inline asm: replacement `{text}` memory index is not a register"
                                )
                            })?),
                            None => None,
                        };
                        concrete.push(Concrete::Mem {
                            base: b,
                            index,
                            scale,
                            disp,
                            size,
                        });
                    }
                    (None, Some((target, off))) => {
                        if sym_disp.is_some() {
                            return Err(alloc::format!(
                                "inline asm: replacement `{text}` has more than one memory operand"
                            ));
                        }
                        sym_disp = Some((target, off + disp as i64, concrete.len(), true));
                        concrete.push(Concrete::RipRel { disp: 0, size });
                    }
                    (None, None) => {
                        return Err(alloc::format!(
                            "inline asm: replacement `{text}` memory base is not a register operand"
                        ));
                    }
                }
            }
            // `disp(%%rip)` with a literal displacement (`leaq (%rip), %r8`):
            // the address is `rip + disp`, computed at run time.
            AsmOpnd::RipRel { disp } => concrete.push(Concrete::RipRel {
                disp,
                size: mem_size(insn),
            }),
            // `%cN(%%rip)` / `%PN(%%rip)`: a constant becomes the disp32
            // literal; a link-time address takes a RIP-relative relocation.
            AsmOpnd::RipRelRef { idx, .. } => {
                let size = mem_size(insn);
                match (refs.imm_of)(idx) {
                    Some(v) => concrete.push(Concrete::RipRel {
                        disp: i32::try_from(v).map_err(|_| {
                            alloc::format!(
                                "inline asm: replacement `{text}` RIP-relative displacement out of range"
                            )
                        })?,
                        size,
                    }),
                    None => {
                        let (target, off) = (refs.addr_of)(idx).ok_or_else(|| {
                            alloc::format!(
                                "inline asm: replacement `{text}` `%c`/`%P` operand is not a constant or address"
                            )
                        })?;
                        if sym_disp.is_some() {
                            return Err(alloc::format!(
                                "inline asm: replacement `{text}` has more than one memory operand"
                            ));
                        }
                        sym_disp = Some((target, off, concrete.len(), true));
                        concrete.push(Concrete::RipRel { disp: 0, size });
                    }
                }
            }
            // An absolute address with no base register, written as a literal,
            // as a symbol expression, or as a bare `%cN` / `%PN` operand: the
            // absolute disp form, its field relocated when a symbol names it.
            AsmOpnd::AbsMem { disp, sym } => {
                let size = mem_size(insn);
                let Some(expr) = sym else {
                    concrete.push(Concrete::AbsMem { disp, size });
                    continue;
                };
                if sym_disp.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one memory operand"
                    ));
                }
                sym_disp = Some((expr_target(expr)?, 0, concrete.len(), false));
                concrete.push(Concrete::AbsMem {
                    disp: abs_probe(super::asm::addr_size(insn, mode)).0,
                    size,
                });
            }
            AsmOpnd::AbsMemRef { idx, .. } => {
                let size = mem_size(insn);
                match (refs.imm_of)(idx) {
                    Some(v) => concrete.push(Concrete::AbsMem {
                        disp: i32::try_from(v).map_err(|_| {
                            alloc::format!(
                                "inline asm: replacement `{text}` absolute displacement out of range"
                            )
                        })?,
                        size,
                    }),
                    None => {
                        let (target, off) = (refs.addr_of)(idx).ok_or_else(|| {
                            alloc::format!(
                                "inline asm: replacement `{text}` `%c`/`%P` operand is not a constant or address"
                            )
                        })?;
                        if sym_disp.is_some() {
                            return Err(alloc::format!(
                                "inline asm: replacement `{text}` has more than one memory operand"
                            ));
                        }
                        sym_disp = Some((target, off, concrete.len(), true));
                        concrete.push(Concrete::RipRel { disp: 0, size });
                    }
                }
            }
            // `disp(,%index,scale)`: a no-base scaled-index reference. A symbol
            // displacement takes an absolute reloc; a literal encodes directly.
            AsmOpnd::IndexMem {
                index,
                scale,
                disp,
                sym,
            } => {
                let size = mem_size(insn);
                let index = base_reg(index).ok_or_else(|| {
                    alloc::format!(
                        "inline asm: replacement `{text}` memory index is not a register"
                    )
                })?;
                match sym {
                    Some(expr) => {
                        if sym_disp.is_some() {
                            return Err(alloc::format!(
                                "inline asm: replacement `{text}` has more than one memory operand"
                            ));
                        }
                        sym_disp = Some((expr_target(expr)?, 0, concrete.len(), false));
                        concrete.push(Concrete::IndexMem {
                            index,
                            scale,
                            disp: 0,
                            size,
                        });
                    }
                    None => concrete.push(Concrete::IndexMem {
                        index,
                        scale,
                        disp,
                        size,
                    }),
                }
            }
            // `disp+sym(%base[, %index, scale])`: a based reference whose
            // symbol displacement takes an absolute reloc. The probe
            // displacement forces the disp32 form; the field is zeroed once
            // located.
            AsmOpnd::SymMem {
                base,
                index,
                scale,
                expr,
            } => {
                let size = mem_size(insn);
                let base = base_reg(base).ok_or_else(|| {
                    alloc::format!("inline asm: replacement `{text}` memory base is not a register")
                })?;
                let index = match index {
                    Some(i) => Some(base_reg(i).ok_or_else(|| {
                        alloc::format!(
                            "inline asm: replacement `{text}` memory index is not a register"
                        )
                    })?),
                    None => None,
                };
                // A displacement expression that is already a constant
                // encodes as the literal, taking the narrowest based form.
                if let Some(v) = insn
                    .sym_exprs
                    .get(expr as usize)
                    .and_then(|e| (refs.fold)(e))
                    .and_then(|v| i32::try_from(v).ok())
                {
                    concrete.push(Concrete::Mem {
                        base,
                        index,
                        scale,
                        disp: v,
                        size,
                    });
                    continue;
                }
                if sym_disp.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one memory operand"
                    ));
                }
                sym_disp = Some((expr_target(expr)?, 0, concrete.len(), false));
                concrete.push(Concrete::Mem {
                    base,
                    index,
                    scale,
                    disp: RIPREL_PROBE_DISP,
                    size,
                });
            }
            // `sym(%%rip)` / `(sym - 1b)(%%rip)`: a RIP-relative reference to
            // what the displacement expression leaves symbolic; the disp32
            // takes a PC-relative relocation.
            AsmOpnd::SymRipRel { expr } => {
                let size = mem_size(insn);
                if sym_disp.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one memory operand"
                    ));
                }
                sym_disp = Some((expr_target(expr)?, 0, concrete.len(), true));
                concrete.push(Concrete::RipRel { disp: 0, size });
            }
            // `Nf(%%rip)`: the address of a section label, a `lea` source. The
            // materializer values the label, so the reference is a PC-relative
            // relocation against it like any other symbolic displacement.
            AsmOpnd::LabelAddr { num, forward } => {
                if sym_disp.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one memory operand"
                    ));
                }
                sym_disp = Some((
                    AsmSectionTarget::Symbol(local_label_name(num, forward)),
                    0,
                    concrete.len(),
                    true,
                ));
                concrete.push(Concrete::RipRel {
                    disp: 0,
                    size: mem_size(insn),
                });
            }
            // `$Nf`: the label's address as an absolute immediate.
            AsmOpnd::ImmLabel { num, forward } => {
                if sym_imm.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one symbol immediate"
                    ));
                }
                sym_imm = Some((
                    AsmSectionTarget::Symbol(local_label_name(num, forward)),
                    0,
                    concrete.len(),
                ));
                concrete.push(Concrete::Imm(IMM_PROBE[0].1));
            }
            // A bare `Nf` outside a branch is AT&T's absolute memory address
            // (the boot stubs patch their own operands through one). The
            // displacement is the address size wide and takes an absolute
            // relocation against the label.
            AsmOpnd::Label { num, forward } => {
                if sym_disp.is_some() {
                    return Err(alloc::format!(
                        "inline asm: replacement `{text}` has more than one memory operand"
                    ));
                }
                sym_disp = Some((
                    AsmSectionTarget::Symbol(local_label_name(num, forward)),
                    0,
                    concrete.len(),
                    false,
                ));
                concrete.push(Concrete::AbsMem {
                    disp: abs_probe(super::asm::addr_size(insn, mode)).0,
                    size: mem_size(insn),
                });
            }
            _ => {
                return Err(alloc::format!(
                    "inline asm: replacement instruction `{text}` operand is not a \
                     register or immediate"
                ));
            }
        }
    }
    // Encode the instruction body; a segment override rides in front of it.
    let addr = super::asm::addr_size(insn, mode);
    let encode = |ops: &[Concrete]| {
        let mut out = alloc::vec::Vec::new();
        super::asm::encode_in(&mut out, mode, addr, insn.mnemonic, insn.suffix, ops)?;
        if let Some(rex) = insn.rex {
            super::asm::splice_rex(&mut out, 0, rex)?;
        }
        Ok(out)
    };
    // A `$symbol` immediate: settle the field's width and signedness before
    // the body is encoded, since both follow from the form the probe value
    // selects. The widest probe that encodes wins, matching GNU as, which
    // relocates a symbol immediate in the operand size's own field rather
    // than in a shortened one.
    let tail = super::asm::imm_field_tail(insn.mnemonic);
    let imm_field = match sym_imm {
        Some((_, _, idx)) => Some(
            locate_sym_imm_field(&concrete, idx, tail, &encode).ok_or_else(|| {
                alloc::format!(
                    "inline asm: replacement `{text}` symbol immediate has no encodable field"
                )
            })?,
        ),
        None => None,
    };
    if let (Some((_, _, idx)), Some(f)) = (&sym_imm, &imm_field) {
        concrete[*idx] = Concrete::Imm(f.probe);
    }
    let mut body =
        encode(&concrete).map_err(|m| alloc::format!("inline asm: replacement `{text}`: {m}"))?;
    let mut bytes = alloc::vec::Vec::new();
    let sizes = push_legacy_prefixes(&mut bytes, &body, insn.seg.or(operand_seg), prefix);
    // A field of `body` past the size prefixes lands in `bytes` shifted by the
    // segment and repeat / lock bytes only, the size prefixes having moved
    // ahead of them.
    let seg_len = bytes.len() as u32 - sizes as u32;
    let mut relocs = alloc::vec::Vec::new();
    if let Some((target, off, idx, pcrel)) = sym_disp {
        // Locate the disp32 field: re-encode with a distinct displacement in
        // that operand, keeping its form; exactly those four bytes differ.
        let mut probe = concrete.clone();
        probe[idx] = match concrete[idx] {
            Concrete::RipRel { size, .. } => Concrete::RipRel {
                disp: RIPREL_PROBE_DISP,
                size,
            },
            Concrete::IndexMem {
                index, scale, size, ..
            } => Concrete::IndexMem {
                index,
                scale,
                disp: RIPREL_PROBE_DISP,
                size,
            },
            // The body already carries the first probe displacement (which
            // forces the disp32 form); vary every field byte again.
            Concrete::Mem {
                base,
                index,
                scale,
                size,
                ..
            } => Concrete::Mem {
                base,
                index,
                scale,
                disp: RIPREL_PROBE_DISP2,
                size,
            },
            // An absolute address's field is the address size wide, so its
            // probe pair is chosen to differ in every byte of that width.
            Concrete::AbsMem { size, .. } => Concrete::AbsMem {
                disp: abs_probe(addr).1,
                size,
            },
            other => other,
        };
        let probe_bytes =
            encode(&probe).map_err(|m| alloc::format!("inline asm: replacement `{text}`: {m}"))?;
        let (field, width) = differing_run(&body, &probe_bytes)
            .filter(|&(_, n)| matches!(n, 2 | 4))
            .ok_or_else(|| {
                alloc::format!(
                    "inline asm: replacement `{text}` displacement field is not a 2- or 4-byte run"
                )
            })?;
        body[field..field + width].fill(0);
        // A PC-relative field's addend is the symbol offset less the field's
        // own end skew and any bytes trailing it (the immediate of `testb
        // $imm, sym(%rip)`), matching gcc. An absolute field is patched with
        // the symbol value plus the offset directly.
        let trailing = body.len() - (field + width);
        let addend = if pcrel {
            off - width as i64 - trailing as i64
        } else {
            off
        };
        relocs.push(AsmSectionReloc {
            offset: seg_len + field as u32,
            width: width as u8,
            kind: AsmRelocKind::Data,
            pcrel,
            branch: false,
            // An absolute disp32 is sign-extended into a 64-bit address, so it
            // takes `R_X86_64_32S`; under a 32- or 16-bit address size the
            // field is the whole address and takes the zero-extended flavour.
            signed: !pcrel && width == 4 && addr == 8,
            target,
            addend,
        });
    }
    if let (Some((target, off, _)), Some(f)) = (sym_imm, imm_field) {
        body[f.start..f.start + f.width as usize].fill(0);
        relocs.push(AsmSectionReloc {
            offset: seg_len + f.start as u32,
            width: f.width,
            kind: AsmRelocKind::Data,
            pcrel: false,
            branch: false,
            signed: f.signed,
            target,
            addend: off,
        });
    }
    bytes.extend_from_slice(&body[sizes..]);
    Ok(AsmSectionItem::CodeBytes {
        bytes,
        relocs,
        short: None,
    })
}

/// Where a `$symbol` immediate lands in an instruction's encoding.
struct SymImmField {
    /// Probe value that selects this field; the body encodes with it and the
    /// field bytes are zeroed afterwards.
    probe: i64,
    start: usize,
    width: u8,
    /// The form's immediate slot is the sign-extended class, so the field
    /// takes `R_X86_64_32S` rather than `R_X86_64_32`.
    signed: bool,
}

/// Probe pairs for locating a symbol immediate's field, widest first. Both
/// members of a pair differ in every byte of the field and stay inside the
/// signed range of their width, so a form that accepts one accepts the other.
/// The 8-byte pair comes last: an instruction that also has a 4-byte form
/// (`movq $sym, %rax`) takes it, as GNU as does, and only an imm64-only form
/// (`movabsq`) falls through.
const IMM_PROBE: [(u8, i64, i64); 4] = [
    (4, 0x5B3D_71A7, 0x24C2_8E58),
    (2, 0x5B3D, 0x24C2),
    (1, 0x5B, 0x24),
    (8, 0x5B3D_71A7_2C4E_1936, 0x24C2_8E58_53B1_E6C9),
];

/// A value only an unsigned imm32 slot accepts: a signed imm32 slot rejects
/// it, which is how the sign-extended class is told apart.
const IMM_UNSIGNED_PROBE: i64 = 0x8000_0000;

/// Encode a concrete operand list, or report why it does not encode.
type EncodeFn<'a> =
    dyn Fn(&[super::asm::Concrete]) -> Result<alloc::vec::Vec<u8>, alloc::string::String> + 'a;

/// Settle a symbol immediate's field by re-encoding. Each probe pair encodes
/// the instruction twice; the bytes that differ are the field, which x86
/// places last (`tail` bytes from the end for the form that trails it), so a
/// run reaching that point is the whole field and a shorter one means the
/// probe did not fill it.
fn locate_sym_imm_field(
    concrete: &[super::asm::Concrete],
    idx: usize,
    tail: usize,
    encode: &EncodeFn<'_>,
) -> Option<SymImmField> {
    use super::asm::Concrete;
    let with = |v: i64| {
        let mut ops = concrete.to_vec();
        ops[idx] = Concrete::Imm(v);
        encode(&ops).ok()
    };
    for (width, p1, p2) in IMM_PROBE {
        // A probe the form rejects (a 16-bit field asked for a 32-bit value)
        // rules that width out, not the search.
        let (Some(a), Some(b)) = (with(p1), with(p2)) else {
            continue;
        };
        let Some((start, len)) = differing_run(&a, &b) else {
            continue;
        };
        let end = start + len;
        if len != width as usize || (end != a.len() && end + tail != a.len()) {
            continue;
        }
        // The signed imm32 class rejects a value above `i32::MAX`, so an
        // encoding that changes length or fails there is the sign-extended
        // form. Narrower fields carry no such distinction.
        let signed = width == 4 && with(IMM_UNSIGNED_PROBE).is_none_or(|u| u.len() != a.len());
        return Some(SymImmField {
            probe: p1,
            start,
            width,
            signed,
        });
    }
    None
}

/// The value of a template field's expression at stream offset `at`: a
/// template label takes the offset its definition stands at, a section label
/// the offset the measured layout gives it. `None` when a leaf is unresolved.
fn template_expr_value(
    expr: &str,
    at: usize,
    label_defs: &[(u32, usize)],
    names: &[&str],
    measure: &super::ssa::emit_common::SectionLabelOffsets,
) -> Option<i64> {
    let resolve = |name: &str| -> Option<i64> {
        // A bare decimal is an integer literal; a GNU as numeric label is
        // referenced only as `Nb` / `Nf`. Leave literals for the evaluator.
        if name.bytes().all(|c| c.is_ascii_digit()) {
            return None;
        }
        measure
            .offset(name)
            .or_else(|| super::ssa::emit_common::template_label_offset(name, at, label_defs, names))
    };
    super::ssa::emit_common::eval_asm_expr_with_labels(expr, &resolve)
}

/// A local label's name as the section materializer resolves it: the number
/// plus its search direction.
fn local_label_name(num: u32, forward: bool) -> alloc::string::String {
    alloc::format!("{num}{}", if forward { 'f' } else { 'b' })
}

/// The probe pair for locating an absolute-address displacement, whose field
/// is the address size wide: both members differ in every byte of that field.
fn abs_probe(addr: u8) -> (i32, i32) {
    if addr == 2 {
        (0x5B3D, 0x24C2)
    } else {
        (RIPREL_PROBE_DISP, RIPREL_PROBE_DISP2)
    }
}

/// A distinctive displacement for locating a RIP-relative disp32 field by
/// re-encoding: every byte differs from a zero field.
const RIPREL_PROBE_DISP: i32 = 0x5B3D_71A7u32 as i32;

/// The byte-wise complement of [`RIPREL_PROBE_DISP`], for locating a field
/// that already carries the first probe: every byte differs again.
const RIPREL_PROBE_DISP2: i32 = 0xA4C2_8E58u32 as i32;

/// Byte offset of the four-byte run that differs between two encodings that
/// vary only in a RIP-relative displacement. Returns `None` unless exactly
/// four contiguous bytes differ -- an encoder-invariant check that the disp32
/// is the sole variable field.
fn riprel_disp32_field(a: &[u8], b: &[u8]) -> Option<usize> {
    differing_run(a, b).filter(|&(_, n)| n == 4).map(|(s, _)| s)
}

/// The single contiguous run of bytes two equal-length encodings differ in,
/// as (offset, length). `None` when they differ nowhere or in more than one
/// run -- the encoder-invariant check that the probed field is the only
/// variable one.
fn differing_run(a: &[u8], b: &[u8]) -> Option<(usize, usize)> {
    if a.len() != b.len() {
        return None;
    }
    let differ = |i: usize| a.get(i).zip(b.get(i)).is_some_and(|(x, y)| x != y);
    let first = (0..a.len()).find(|&i| differ(i))?;
    let end = (first..a.len()).find(|&i| !differ(i)).unwrap_or(a.len());
    (end..a.len())
        .all(|i| !differ(i))
        .then_some((first, end - first))
}

/// Lower an `Inst::InlineAsm` (GCC extended asm with operands). Assigns
/// each register operand a machine register per its constraint, saves
/// the registers it and the clobber list overwrite, loads the inputs,
/// encodes the register-concrete template, and stores the outputs back
/// through their addresses. Operand values / addresses are captured to
/// the stack first (via r10) so an operand living in a register the asm
/// then overwrites is read before it is clobbered -- the shape the
/// register-tied intrinsics above use, generalised over the constraints.
/// `goto_ctx` is present for the `asm goto` form (the statement is the
/// last instruction of a `Terminator::AsmGoto` block).
///
/// A template branch to a label of its own stream starts on the rel8 form
/// and is lengthened, permanently, when the settled layout leaves its
/// displacement outside the byte's reach: the attempt grows the set and
/// this driver rolls the outputs back and lays the template out again.
/// Each round either grows the set or is final, the rule
/// `measure_asm_section_offsets` applies to a pushed section's branches.
fn emit_inline_asm(
    code: &mut Vec<u8>,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    fixups: &mut Vec<super::encode::Fixup>,
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_code_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    asm_sections: &mut super::ssa::emit_common::AsmSectionSink,
    asm_extern_call_sites: &mut Vec<super::UserExternCallSite>,
    asm_sym_fixups: &mut Vec<super::AsmSymFixup>,
    data_fixups: &mut Vec<DataFixup>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    user_extern_data_refs: &mut Vec<super::UserExternDataRef>,
    asm_section_text_refs: &mut Vec<super::AsmSectionTextRef>,
    asm_text_abs_refs: &mut Vec<super::AsmTextAbsRef>,
    asm_text_labels: &mut Vec<super::AsmTextLabel>,
    text_align: &mut usize,
    mut goto_ctx: Option<AsmGotoCtx<'_>>,
) -> bool {
    let mut long_sites: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    let base = (
        code.len(),
        fixups.len(),
        asm_extern_call_sites.len(),
        asm_sym_fixups.len(),
        data_fixups.len(),
        pending_func_fixups.len(),
        user_extern_data_refs.len(),
        *text_align,
    );
    let sink_base = asm_sections.snapshot();
    loop {
        let known = long_sites.len();
        let round_ctx = goto_ctx.as_mut().map(|c| AsmGotoCtx {
            row: c.row,
            branch_fixups: &mut *c.branch_fixups,
            branch_short: c.branch_short,
        });
        if !emit_inline_asm_once(
            code,
            asm,
            args,
            func,
            alloc,
            frame,
            fixups,
            name2entpc,
            extern_data_names,
            extern_code_names,
            asm_sections,
            asm_extern_call_sites,
            asm_sym_fixups,
            data_fixups,
            pending_func_fixups,
            user_extern_data_refs,
            asm_section_text_refs,
            asm_text_abs_refs,
            asm_text_labels,
            text_align,
            round_ctx,
            &mut long_sites,
        ) {
            return false;
        }
        if long_sites.len() == known {
            return true;
        }
        code.truncate(base.0);
        fixups.truncate(base.1);
        asm_extern_call_sites.truncate(base.2);
        asm_sym_fixups.truncate(base.3);
        data_fixups.truncate(base.4);
        pending_func_fixups.truncate(base.5);
        user_extern_data_refs.truncate(base.6);
        *text_align = base.7;
        asm_sections.restore(&sink_base);
    }
}

/// One layout attempt under the branch forms `long_sites` fixes. Returns
/// with the set grown, ahead of any patching or section materialization,
/// when a short branch does not reach; the driver above rolls back what
/// the attempt emitted.
fn emit_inline_asm_once(
    code: &mut Vec<u8>,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    fixups: &mut Vec<super::encode::Fixup>,
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_code_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    asm_sections: &mut super::ssa::emit_common::AsmSectionSink,
    asm_extern_call_sites: &mut Vec<super::UserExternCallSite>,
    asm_sym_fixups: &mut Vec<super::AsmSymFixup>,
    data_fixups: &mut Vec<DataFixup>,
    pending_func_fixups: &mut Vec<(usize, usize)>,
    user_extern_data_refs: &mut Vec<super::UserExternDataRef>,
    asm_section_text_refs: &mut Vec<super::AsmSectionTextRef>,
    asm_text_abs_refs: &mut Vec<super::AsmTextAbsRef>,
    asm_text_labels: &mut Vec<super::AsmTextLabel>,
    text_align: &mut usize,
    mut goto_ctx: Option<AsmGotoCtx<'_>>,
    long_sites: &mut alloc::collections::BTreeSet<usize>,
) -> bool {
    use super::super::ir::{AsmConstraint, AsmRegSize, AsmSeg, Inst};
    use super::asm::{AsmOpnd, Concrete};
    // A statement that lowers to nothing keeps only its IR-level ordering
    // effect; the operand staging around zero bytes of code is dead, and
    // `asm_scratch_bytes` reserved no region for it.
    if super::ssa::emit_common::asm_statement_is_noop(
        asm,
        super::ssa::emit_common::AsmComments::X86,
    ) {
        return true;
    }
    // Expand `%=` once so the code text and any `.pushsection` content
    // share one instance number, then split off the section blocks; the
    // arch parser sees only the code text.
    let Ok(raw_text) = core::str::from_utf8(&asm.template) else {
        return fail("inline asm: non-UTF8 template");
    };
    let stripped = super::ssa::emit_common::strip_asm_comments(
        raw_text,
        super::ssa::emit_common::AsmComments::X86,
    );
    let raw_text = stripped.as_deref().unwrap_or(raw_text);
    let expanded = super::ssa::emit_common::expand_template_uniq(raw_text);
    let text = expanded.as_deref().unwrap_or(raw_text);
    // Rename any numeric label defined more than once in one asm instance to
    // per-definition unique names, so the code and section resolvers below see
    // single-definition labels.
    let multidef = super::ssa::emit_common::rewrite_multidef_local_labels(text);
    let text = multidef.as_deref().unwrap_or(text);
    // The operand register assignment is needed both for the code stream and,
    // ahead of it, for the GNU-as macro pass and a replacement instruction that
    // references a template operand (`popcntl %1, %0`); compute it once, first.
    let op_reg =
        match super::asm::assign_operand_regs(&asm.operands, asm.clobber_regs, asm.clobber_fp_regs)
        {
            Ok(r) => r,
            Err(m) => {
                bail_msg(&m);
                return false;
            }
        };
    // Expand any GNU-as macro directives (`.macro` / `.irp` / `.ifc` / `.set` /
    // `.if`) before section extraction, substituting each register operand to
    // its assigned AT&T name so the macro's register-name comparisons resolve.
    let const_of = |idx: u8| -> Option<i64> {
        let arg = *args.get(idx as usize)?;
        match func.insts.get(arg as usize) {
            Some(Inst::Imm(v)) => Some(*v),
            // An unpromoted function (a computed goto opts out of mem2reg)
            // leaves an `"i"` constant operand a load of a constant local.
            _ => super::ssa::emit_common::asm_operand_local_const(func, arg),
        }
    };
    let gas_subst = |tok: &str| -> Option<alloc::string::String> {
        let body = tok.strip_prefix('%')?;
        let (modifier, digits) = match body.as_bytes().first() {
            Some(m) if m.is_ascii_alphabetic() => (Some(*m), &body[1..]),
            _ => (None, body),
        };
        let idx: u8 = digits.parse().ok()?;
        if matches!(modifier, Some(b'c') | Some(b'P') | Some(b'n')) {
            let v = const_of(idx)?;
            return Some(alloc::format!(
                "{}",
                if modifier == Some(b'n') { -v } else { v }
            ));
        }
        let op = asm.operands.get(idx as usize)?;
        if !matches!(
            op.constraint,
            AsmConstraint::Reg
                | AsmConstraint::Fixed(_)
                | AsmConstraint::Bound(_)
                | AsmConstraint::Match(_)
        ) {
            return None;
        }
        let r = op_reg.get(idx as usize).copied().flatten()?;
        let width = match modifier {
            Some(b'b') => 1,
            Some(b'w') => 2,
            Some(b'k') => 4,
            Some(b'q') => 8,
            _ => op.width,
        };
        super::asm::gpr_att_name(r, width).map(|n| alloc::format!("%{n}"))
    };
    let gas = match super::ssa::emit_common::expand_asm_gas_macros(text, 4, &gas_subst) {
        Ok(e) => e,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    let text = gas.as_deref().unwrap_or(text);
    let mut extracted = match super::ssa::emit_common::extract_asm_sections(text, false) {
        Ok(e) => e,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    if let Some(ex) = &extracted {
        if let Err(m) = super::ssa::emit_common::reject_unit_symbol_items(&ex.blocks) {
            bail_msg(&m);
            return false;
        }
        // The template's symbol directives declare names of the unit; the
        // object writer applies them, where every definition is known.
        if let Err(m) = asm_sections.push_sym_decls(&ex.sym_items) {
            bail_msg(&m);
            return false;
        }
    }
    // Encode any replacement instructions in an executable section
    // (`.altinstr_replacement,"ax"`) to bytes and relocations before layout. A
    // `%lK` goto branch resolves through the enclosing `asm goto` row to its
    // target block (index `1 + K`), the same mapping the code stream uses. The
    // row slice carries its own lifetime, so this holds no borrow of `goto_ctx`.
    let goto_row: Option<&[super::super::ir::BlockId]> = goto_ctx.as_ref().map(|c| c.row);
    let goto_block = |k: u8| -> Option<u32> { goto_row?.get(1 + k as usize).copied() };
    if let Some(ex) = extracted.as_mut()
        && let Err(m) = encode_x86_asm_section_code(
            &mut ex.blocks,
            func,
            args,
            name2entpc,
            extern_data_names,
            extern_code_names,
            &goto_block,
            &op_reg,
            &asm.operands,
        )
    {
        bail_msg(&m);
        return false;
    }
    let (code_text, section_blocks) = match &extracted {
        Some(ex) => (ex.code.as_str(), ex.blocks.as_slice()),
        None => (text, &[][..]),
    };
    let insns = match super::asm::parse_template(code_text.as_bytes()) {
        Ok(i) => i,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    if let Err(m) = super::asm::check_operand_refs(&insns, asm.operands.len()) {
        bail_msg(&m);
        return false;
    }
    // Code-stream label names, so a `.skip` expression can size its padding
    // from a named code label (a multiply-defined numeric label renamed above).
    let code_label_names = super::asm::scan_label_names(code_text);
    // Names the unit binds weak, as the section relaxation reads them: an
    // in-stream definition of one does not satisfy a branch in place, since
    // the link may bind another definition, so the field keeps a relocation
    // against the name, as GNU as keeps it.
    let weak_names = super::ssa::emit_common::asm_weak_only_names(section_blocks, asm_sections);
    let weak_target_name = |num: u32| -> Option<alloc::string::String> {
        let idx = num.checked_sub(super::asm::NAMED_LABEL_BASE)?;
        let name = *code_label_names.get(idx as usize)?;
        weak_names
            .contains(name)
            .then(|| alloc::string::String::from(name))
    };
    // Label numbers the code stream defines, by instruction index, so a
    // branch knows before layout whether its target lands in this stream
    // and on which side of the reference.
    let stream_defs: alloc::vec::Vec<(u32, usize)> = insns
        .iter()
        .enumerate()
        .filter_map(|(ii, insn)| insn.label_def.map(|n| (n, ii)))
        .collect();
    // Registers the asm overwrites: the operand registers plus the explicit
    // clobber list (a bound operand's register is the one the asm was asked
    // to see and affect, so it is not saved around the block). GP registers
    // save to 8-byte scratch slots; `x` (xmm) operands and FP clobbers live
    // in the independent XMM file and take 16-byte slots. `stage` carries
    // the capture / load / store-back sequences below.
    let (used, fp_used, stage) = match asm_save_masks_and_stage(asm, &op_reg) {
        Ok(t) => t,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    let save_list: alloc::vec::Vec<u8> = (0u8..16).filter(|r| used & (1 << r) != 0).collect();
    let fp_save_list: alloc::vec::Vec<u8> = (0u8..16).filter(|r| fp_used & (1 << r) != 0).collect();
    // With nothing to run on the way out -- no register outputs to store
    // back, no saved registers to restore -- a `%lK` branch goes straight to
    // the label's block instead of a teardown trampoline, so the template
    // branch and a `.long %lK - .` section field name one address. Runtime
    // patchers that read the section entry and rewrite the branch require
    // that. TODO with exit work pending, a section field still names the
    // block, so a patched-in branch skips the store-backs and restores; the
    // aarch64 lowering rewrites such fields to the restore trampoline.
    let goto_direct = save_list.is_empty()
        && fp_save_list.is_empty()
        && !asm.operands.iter().any(|op| {
            op.is_output && !matches!(op.constraint, AsmConstraint::Mem | AsmConstraint::Bound(_))
        });
    // Register saves and operand captures live in the frame's asm scratch
    // region (rbp-relative), never below rsp: a setjmp-style template saves
    // rsp mid-block and a later longjmp-style one resumes it after the
    // memory below that rsp was reused by other calls. rbp survives such a
    // round trip (the resuming template restores it), so frame slots do.
    // Layout from the region base up: xmm saves, GP saves, captures.
    let fp_area = fp_save_list.len() as i32 * 16;
    let base = frame.asm_scratch_off;
    debug_assert!(
        base != 0 || (fp_area == 0 && save_list.is_empty() && asm.operands.is_empty()),
        "inline asm without a frame scratch region"
    );
    let gp_off = |k: usize| -> i32 { base + fp_area + 8 * k as i32 };
    let cap_off = |i: usize| -> i32 { base + fp_area + 8 * (save_list.len() + i) as i32 };
    for (k, &r) in fp_save_list.iter().enumerate() {
        super::encode::emit_movups_mem_xmm(code, Reg::RBP, base + k as i32 * 16, Reg(r));
    }
    for (k, &r) in save_list.iter().enumerate() {
        super::encode::emit_mov_mem_r(code, Reg::RBP, gp_off(k), Reg(r));
    }
    // Capture each operand's value (input) / address (output) into its
    // slot before any asm register is written. An allocator-visible
    // stage (r10 and r11 both held by operands or clobbers) may itself
    // be some operand value's allocated register, so register-resident
    // operands are captured in a first pass, before a spill load writes
    // the stage.
    let passes = if stage == SCRATCH_R10 || stage == SCRATCH_R11 {
        1
    } else {
        2
    };
    for pass in 0..passes {
        for (i, &a) in args.iter().enumerate() {
            let Some(place) = alloc.places.get(a as usize).copied() else {
                return fail("inline asm: operand place missing");
            };
            if passes == 2 && (pass == 1) != matches!(place, Place::Spill(_)) {
                continue;
            }
            let Some(r) = materialize_int(code, place, stage, frame) else {
                return fail("inline asm: operand not an integer place");
            };
            super::encode::emit_mov_mem_r(code, Reg::RBP, cap_off(i), r);
        }
    }
    // Load inputs into their registers; a `+` output loads its current
    // value from the destination address. A memory operand instead loads its
    // captured address into the register -- the instruction dereferences it.
    for (i, op) in asm.operands.iter().enumerate() {
        let Some(r) = op_reg[i] else { continue };
        if matches!(op.constraint, AsmConstraint::Fp) {
            // The captured slot holds the operand's address (a 16-byte value is
            // addressed, not passed in a register); load its 128 bits into the
            // assigned xmm. An output-only `=x` is written by the asm, so skip
            // its load; a `+x` needs the current value.
            if !op.is_output || op.is_rw {
                super::encode::emit_mov_r_mem(code, stage, Reg::RBP, cap_off(i));
                super::encode::emit_movups_xmm_mem(code, Reg(r), stage, 0);
            }
            continue;
        }
        // Nothing moves into a bound operand: it has no storage behind it.
        if matches!(op.constraint, AsmConstraint::Bound(_)) {
            continue;
        }
        let reg = Reg(r);
        if matches!(op.constraint, AsmConstraint::Mem) || !op.is_output {
            // A memory operand loads its captured address; a plain input
            // loads its value. Both come from the captured slot.
            super::encode::emit_mov_r_mem(code, reg, Reg::RBP, cap_off(i));
        } else if op.is_rw {
            super::encode::emit_mov_r_mem(code, stage, Reg::RBP, cap_off(i));
            emit_asm_load_width(code, reg, stage, op.width);
        }
    }
    // Local labels: definitions record the code offset they stand at; a
    // jmp / jcc / lea referencing a label records its displacement field as
    // `(field, label, forward, field_width, instruction_index)`, patched
    // once every definition's offset is known. A relaxable branch's field
    // is one byte wide until `long_sites` holds its instruction.
    let mut label_defs: alloc::vec::Vec<(u32, usize)> = alloc::vec::Vec::new();
    let mut label_fixups: alloc::vec::Vec<(usize, u32, bool, u8, usize)> = alloc::vec::Vec::new();
    // `$LABEL` address immediates: `(imm32_field, label_number, forward)`,
    // resolved to an absolute `.text` relocation once every definition's
    // offset is known.
    let mut abs_label_fixups: alloc::vec::Vec<(usize, u32, bool)> = alloc::vec::Vec::new();
    // Fields over template labels (`.byte 662f-661b`, `subl $(2f - 1b)`):
    // `(reference_site, field, width, expression)`. Only a forward reference
    // reaches here; a backward one is a value where the field is laid down,
    // so the encoding sees it and takes the narrow form where one fits.
    let mut expr_fixups: alloc::vec::Vec<(usize, usize, u8, alloc::string::String)> =
        alloc::vec::Vec::new();
    // `asm goto` label branches: `(rel32_site, branch_kind, label_index)`
    // per `%lK` reference, patched to the label's block directly when
    // `goto_direct`, else to the label's teardown trampoline (or to the
    // shared fall-through teardown when the label target is the
    // fall-through block).
    let mut goto_sites: alloc::vec::Vec<(usize, LocalBranchKind, usize)> = alloc::vec::Vec::new();
    // The constant value of an `i`-class operand reference, if any.
    let const_of = |idx: u8| -> Option<i64> {
        let arg = *args.get(idx as usize)?;
        match func.insts.get(arg as usize) {
            Some(Inst::Imm(v)) => Some(*v),
            // An unpromoted function (a computed goto opts out of mem2reg)
            // leaves an `"i"` constant operand a load of a constant local.
            _ => super::ssa::emit_common::asm_operand_local_const(func, arg),
        }
    };
    // Section-label offsets, so a `.skip` in the main stream can size its
    // padding against the replacement length (`775f - 774f`, both in a
    // `.pushsection`) before the sections are materialized below.
    // Measured against the sink the sections merge into below, so this and
    // the materialization settle every branch form the same way and a
    // replacement length means the same to both.
    let section_measure = match super::ssa::emit_common::measure_asm_section_offsets(
        section_blocks,
        &const_of,
        false,
        asm_sections,
    ) {
        Ok(m) => m,
        Err(m) => {
            bail_msg(&m);
            return false;
        }
    };
    // Whether the last byte the stream took came from an instruction; the
    // template opens right after the function's compiled code, so it does.
    // Alignment padding depends on it (see `push_x86_exec_align_fill`).
    let mut after_insn = true;
    // Start of the run of legacy prefix bytes a `lock` / `rep` / segment
    // statement deposited; the instruction they lead re-places them.
    let mut prefix_run: Option<usize> = None;
    // Encode each template instruction with its operands resolved to the
    // assigned registers, explicit registers, and immediates.
    for (ii, insn) in insns.iter().enumerate() {
        let pending_at = if matches!(insn.mnemonic, super::asm::Mnemonic::Prefix(_)) {
            prefix_run.get_or_insert(code.len());
            None
        } else {
            prefix_run.take()
        };
        // A local-label definition marks the current offset; it emits no bytes.
        if let Some(num) = insn.label_def {
            label_defs.push((num, code.len()));
            continue;
        }
        // `.align` / `.p2align` / `.balign`: pad `code` (the unit's whole
        // text stream, so its length is a section offset) to the boundary, as
        // GNU as does section-relative. A boundary above the section default
        // raises the section alignment, so the padding holds absolutely; the
        // default fill is the GNU as multi-byte NOP sequence, which an
        // explicit one-byte-NOP fill also selects. The padding leaves no
        // instruction boundary of its own.
        //
        // An operand over template labels resolves against the definitions
        // already emitted, as GNU as resolves one where the directive stands.
        if let Some(super::ssa::emit_common::AsmSectionItem::Align { spec, fill, max }) =
            &insn.layout
        {
            let at = code.len();
            let n = match spec.bytes(&|name| {
                super::ssa::emit_common::template_label_offset(
                    name,
                    at,
                    &label_defs,
                    &code_label_names,
                )
                .filter(|&off| off <= at as i64)
            }) {
                Ok(n) => n,
                Err(e) => return fail(&e),
            };
            *text_align = (*text_align).max(n as usize);
            let gap = super::ssa::emit_common::align_gap(at as i64, n as i64, *max) as usize;
            if let Err(e) =
                super::ssa::emit_common::push_align_fill(code, gap, *fill, true, false, after_insn)
            {
                return fail(&e);
            }
            continue;
        }
        // A raw-byte piece emits its literal bytes with no operand resolution.
        // Both spellings a piece can take -- a hex-byte run and a `.byte`
        // family directive -- are data as far as alignment is concerned.
        if insn.mnemonic == super::asm::Mnemonic::RawBytes {
            code.extend_from_slice(&insn.bytes);
            after_insn = false;
            continue;
        }
        // `.skip count, fill`: pad with `count` fill bytes. `count` resolves
        // against the section replacement length and the template labels
        // already emitted (the ALTERNATIVE old site is padded to the longer of
        // the two so a boot-time patch fits).
        if insn.mnemonic == super::asm::Mnemonic::Skip {
            let expr = insn.sym_exprs.first().map_or("0", |e| e.as_str());
            let Some(count) = template_expr_value(
                expr,
                code.len(),
                &label_defs,
                &code_label_names,
                &section_measure,
            ) else {
                return fail("inline asm: `.skip` count is not a constant");
            };
            if count < 0 {
                return fail("inline asm: `.skip` count is negative");
            }
            let unit: &[u8] = if insn.bytes.is_empty() {
                &[0]
            } else {
                &insn.bytes
            };
            for _ in 0..count {
                code.extend_from_slice(unit);
            }
            after_insn = false;
            continue;
        }
        // A data directive with operand references (`.long %c0`): each
        // argument must resolve to a compile-time constant, emitted
        // little-endian at the directive width.
        if let super::asm::Mnemonic::Data(w) = insn.mnemonic {
            for o in &insn.operands {
                let v = match *o {
                    AsmOpnd::Imm(v) => v,
                    AsmOpnd::RefConst { idx, .. } | AsmOpnd::Ref { idx, .. } => {
                        match const_of(idx) {
                            Some(v) => v,
                            None => return fail("inline asm: non-constant data-directive value"),
                        }
                    }
                    // A value over template labels: the field width is the
                    // directive's, so only the value waits on the layout.
                    AsmOpnd::ImmSym { expr } => {
                        let Some(text) = insn.sym_exprs.get(expr as usize) else {
                            return fail("inline asm: data-directive expression is missing");
                        };
                        match template_expr_value(
                            text,
                            code.len(),
                            &label_defs,
                            &code_label_names,
                            &section_measure,
                        ) {
                            Some(v) => v,
                            None => {
                                expr_fixups.push((code.len(), code.len(), w, text.clone()));
                                0
                            }
                        }
                    }
                    _ => return fail("inline asm: unsupported data-directive value"),
                };
                code.extend_from_slice(&(v as u64).to_le_bytes()[..w as usize]);
            }
            after_insn = false;
            continue;
        }
        // `%P` / `%c` naming a link-time address (not a compile-time
        // constant): the operand's captured value is the address. `lea`
        // materializes it into the destination; `call` / `jmp` branch
        // through it (r11 scratch).
        if let Some((k, idx)) = insn
            .operands
            .iter()
            .enumerate()
            .find_map(|(k, o)| match *o {
                AsmOpnd::RefConst { idx, .. } if const_of(idx).is_none() => Some((k, idx)),
                _ => None,
            })
        {
            let name = match insn.mnemonic {
                super::asm::Mnemonic::Table(n) => n,
                _ => "",
            };
            match name {
                "lea" | "leaq" if k == 0 && insn.operands.len() == 2 => {
                    let dst = match insn.operands[1] {
                        AsmOpnd::Reg { reg, .. } if reg < 16 => reg,
                        AsmOpnd::Ref { idx, .. } => match op_reg[idx as usize] {
                            Some(r) => r,
                            None => {
                                return fail("inline asm: `lea` destination must be a register");
                            }
                        },
                        _ => return fail("inline asm: `lea` destination must be a register"),
                    };
                    super::encode::emit_mov_r_mem(code, Reg(dst), Reg::RBP, cap_off(idx as usize));
                }
                "call" | "callq" | "jmp" | "jmpq" if insn.operands.len() == 1 => {
                    super::encode::emit_mov_r_mem(code, stage, Reg::RBP, cap_off(idx as usize));
                    // FF /2 (call) / FF /4 (jmp) through the stage register.
                    if stage.0 >= 8 {
                        code.push(0x41);
                    }
                    code.push(0xFF);
                    code.push(if name.starts_with("call") { 0xD0 } else { 0xE0 } | (stage.0 & 7));
                }
                _ => {
                    return fail("inline asm: `%c`/`%P` address operand outside lea/call/jmp");
                }
            }
            after_insn = true;
            continue;
        }
        // The direct-branch forms below carry no REX byte, so a prefix on one
        // would be dropped rather than encoded.
        if insn.rex.is_some()
            && (matches!(
                insn.operands.first(),
                Some(AsmOpnd::Label { .. } | AsmOpnd::GotoLabel(_))
            ) || (!insn.sym_exprs.is_empty() && insn.operands.is_empty()))
        {
            return fail("inline asm: a `rex` prefix on a direct branch");
        }
        // A jmp / jcc to a local label. A target the unit binds weak is not
        // satisfied by its in-stream definition: the field keeps the rel32
        // form and relocates against the name. A target this stream defines
        // relaxes to the rel8 form unless a round below lengthened it; a
        // target outside the stream keeps rel32 for the section pass.
        if let Some(&AsmOpnd::Label { num, forward }) = insn.operands.first() {
            let super::asm::Mnemonic::Table(name) = insn.mnemonic else {
                return fail("inline asm: label operand on a non-jump");
            };
            let cc = jcc_cond(name);
            if cc.is_none() && !matches!(name, "jmp" | "jmpq") {
                return fail("inline asm: label operand on a non-jump");
            }
            if let Some(n) = weak_target_name(num) {
                match cc {
                    Some(cc) => super::encode::emit_jcc_rel32(code, cc, 0),
                    None => super::encode::emit_jmp_rel32(code, 0),
                }
                asm_sym_fixups.push(super::AsmSymFixup {
                    instr_offset: code.len() - 4,
                    kind: super::ssa::emit_common::AsmRelocKind::JumpRel,
                    target: super::ssa::emit_common::AsmSectionTarget::Symbol(n),
                    addend: -4,
                });
                after_insn = true;
                continue;
            }
            let in_stream = stream_defs.iter().any(|&(n, di)| {
                n == num
                    && (num >= super::asm::NAMED_LABEL_BASE
                        || if forward { di > ii } else { di < ii })
            });
            let width: u8 = if in_stream && !long_sites.contains(&ii) {
                match cc {
                    Some(cc) => super::encode::emit_jcc_rel8(code, cc, 0),
                    None => super::encode::emit_jmp_rel8(code, 0),
                }
                1
            } else {
                match cc {
                    Some(cc) => super::encode::emit_jcc_rel32(code, cc, 0),
                    None => super::encode::emit_jmp_rel32(code, 0),
                }
                4
            };
            label_fixups.push((code.len() - width as usize, num, forward, width, ii));
            after_insn = true;
            continue;
        }
        // A `$LABEL` operand (`pushq $1f`, `movq $1f, %rax`) is the label's
        // address as an absolute immediate. It resolves through the ordinary
        // operand path below with a placeholder that forces the 32-bit
        // immediate field; the field then carries an `R_X86_64_32S` relocation
        // against the label's text offset, recorded once the definition is
        // known. A narrower field has no room for the relocation.
        let abs_label = match insn.operands.first() {
            Some(&AsmOpnd::ImmLabel { num, forward }) => Some((num, forward)),
            _ => None,
        };
        // `lea LABEL(%rip), %reg`: materialize a template-local label's
        // address. The table emits the RIP-relative form with a zero rel32
        // (its last four bytes); the label fixup pass patches it like the
        // jump displacements.
        if let Some(&AsmOpnd::LabelAddr { num, forward }) = insn.operands.first() {
            if !matches!(insn.mnemonic, super::asm::Mnemonic::Table("lea")) {
                return fail("inline asm: a label address requires `lea`");
            }
            let [_, dst] = insn.operands.as_slice() else {
                return fail("inline asm: `lea` needs a destination register");
            };
            let (reg, width) = match *dst {
                AsmOpnd::Reg { reg, size } if reg < 16 => (reg, size.bytes()),
                AsmOpnd::Ref { idx, size } => match op_reg[idx as usize] {
                    Some(r)
                        if !matches!(
                            asm.operands[idx as usize].constraint,
                            AsmConstraint::Fp | AsmConstraint::Mem
                        ) =>
                    {
                        (
                            r,
                            size.unwrap_or(AsmRegSize::from_width(
                                asm.operands[idx as usize].width,
                            ))
                            .bytes(),
                        )
                    }
                    _ => return fail("inline asm: `lea` destination must be a register"),
                },
                _ => return fail("inline asm: `lea` destination must be a register"),
            };
            let tops = [
                super::table::Opnd::Reg { num: reg, width },
                super::table::Opnd::RipRel { disp: 0, width },
            ];
            match super::table::encode(super::table::Mnem::Lea, None, &tops) {
                Ok(bytes) => code.extend_from_slice(&bytes),
                Err(m) => {
                    bail_msg(&m);
                    return false;
                }
            }
            label_fixups.push((code.len() - 4, num, forward, 4, ii));
            after_insn = true;
            continue;
        }
        // A jmp / jcc to an `asm goto` label (`%lK`): emit the rel32
        // form and record the site for the trampoline patch below.
        if let Some(&AsmOpnd::GotoLabel(k)) = insn.operands.first() {
            let Some(ctx) = goto_ctx.as_ref() else {
                return fail("inline asm: `%l` label reference outside `asm goto`");
            };
            if 1 + k as usize >= ctx.row.len() {
                return fail("inline asm: `%l` label index out of range");
            }
            let super::asm::Mnemonic::Table(name) = insn.mnemonic else {
                return fail("inline asm: label operand on a non-jump");
            };
            let cc = jcc_cond(name);
            if cc.is_none() && !matches!(name, "jmp" | "jmpq") {
                return fail("inline asm: label operand on a non-jump");
            }
            let site = code.len();
            match cc {
                Some(cc) => super::encode::emit_jcc_rel32(code, cc, 0),
                None => super::encode::emit_jmp_rel32(code, 0),
            }
            let kind = match cc {
                Some(cc) => LocalBranchKind::Jcc(cc),
                None => LocalBranchKind::Jmp,
            };
            goto_sites.push((site, kind, k as usize));
            after_insn = true;
            continue;
        }
        // A direct `call` / `jmp` to a symbol: resolve the name to its entry
        // and emit the E8/E9 opcode plus a rel32 the fixup pass patches once
        // every function's address is final. Other instructions also carry a
        // symbol expression (a `$symbol` immediate, a symbol-displacement memory
        // operand); those resolve through their operand arms below.
        if let Some(name) = insn.sym_exprs.first().filter(|_| insn.operands.is_empty())
            && matches!(insn.mnemonic, super::asm::Mnemonic::Table("call" | "jmp"))
        {
            let is_call =
                matches!(insn.mnemonic, super::asm::Mnemonic::Table(n) if n.starts_with("call"));
            // The name may embed operand references; substituting them first
            // is what makes `__get_user_%c0` name `__get_user_4`.
            let name = match super::super::ssa::emit_common::resolve_asm_symbol_target(
                name,
                &super::super::ssa::emit_common::X64_SYMBOL_SUBST,
                &const_of,
            ) {
                Ok(n) => n,
                Err(e) => return fail(&e),
            };
            // The code stream's branch channels name a symbol with no addend.
            // TODO carry an addend on the call site and the fixup.
            if !super::super::ssa::emit_common::is_asm_symbol_name(&name) {
                return fail(
                    "inline asm: a branch to a symbol expression is only supported in a section",
                );
            }
            // native_offset is the opcode byte; the fixup pass patches the
            // rel32 at +1 and computes the displacement from the 5-byte end.
            let native_offset = code.len();
            match name2entpc.get(name.as_str()) {
                Some(&ent_pc) => fixups.push(super::encode::Fixup {
                    native_offset,
                    target_ent_pc: ent_pc,
                    kind: super::encode::BranchKind::Call,
                }),
                // Not defined here: the callee's address is a link-time
                // decision, so the site becomes a call relocation against the
                // name, exactly as a compiler-emitted call to an extern
                // function does. The rel32 stays zero for the linker to patch.
                None => asm_extern_call_sites.push(super::UserExternCallSite {
                    instr_offset: native_offset,
                    symbol_name: name.clone(),
                    is_tail: !is_call,
                }),
            }
            code.push(if is_call { 0xE8 } else { 0xE9 });
            code.extend_from_slice(&[0u8; 4]);
            after_insn = true;
            continue;
        }
        // A `jcc` to a bare symbol resolves against a section label; only
        // file-scope section code carries that resolution.
        if !insn.sym_exprs.is_empty()
            && insn.operands.is_empty()
            && matches!(insn.mnemonic, super::asm::Mnemonic::Table(n) if jcc_cond(n).is_some())
        {
            return fail(
                "inline asm: a conditional branch to a symbol is only supported in file-scope asm",
            );
        }
        let mut concrete: alloc::vec::Vec<Concrete> = alloc::vec::Vec::new();
        // A `__seg_gs` / `__seg_fs`-qualified memory operand references its
        // object through a segment override; the prefix rides the enclosing
        // instruction (an extended-asm instruction reaches at most one such
        // operand). `None` unless a resolved memory operand carries a segment.
        let mut operand_seg: Option<u8> = None;
        // A `%a` address operand naming a link-time symbol lowers to a
        // RIP-relative reference; the relocation against the symbol is
        // recorded after the instruction encodes, at its disp32 field. Holds
        // the target and the operand's template displacement (folded into the
        // reloc addend). At most one memory operand per instruction.
        let mut riprel_reloc: Option<(AsmRipSym, i64)> = None;
        // A `$expr` immediate, and a memory displacement, whose value the
        // stream has not reached: the placeholder fixes the wide field and
        // the expression settles into it below.
        let mut imm_expr: Option<alloc::string::String> = None;
        let mut disp_expr: Option<alloc::string::String> = None;
        // An immediate encodes after the memory operand's disp32, so a
        // RIP-relative form would put the relocation on the wrong bytes.
        // Instructions carrying one keep the register-indirect addressing.
        let has_imm_operand = insn.operands.iter().any(|o| match *o {
            AsmOpnd::Imm(_) | AsmOpnd::RefConst { .. } => true,
            AsmOpnd::Ref { idx, .. } => op_reg.get(idx as usize).copied().flatten().is_none(),
            _ => false,
        });
        for o in &insn.operands {
            let c = match *o {
                AsmOpnd::Imm(val) => Concrete::Imm(val),
                AsmOpnd::HighReg(n) => Concrete::HighReg(n),
                // `%cN` / `%PN` with a compile-time constant (the address
                // case was handled above): a bare immediate.
                AsmOpnd::RefConst { idx, .. } => match const_of(idx) {
                    Some(v) => Concrete::Imm(v),
                    None => return fail("inline asm: non-constant `%c`/`%P` operand"),
                },
                // A bare `%cN` / `%PN` memory reference: a constant addresses
                // absolutely (the percpu form under a `%%gs:` / `%%fs:`
                // override), a link-time address RIP-relative, as for `%a`.
                // TODO: gcc spells a `%c` symbol operand as an absolute
                // reference, which a non-PIC code model needs.
                AsmOpnd::AbsMemRef { idx, .. } => {
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg)
                        .unwrap_or(AsmRegSize::Quad);
                    match const_of(idx) {
                        Some(v) => match i32::try_from(v) {
                            Ok(disp) => Concrete::AbsMem { disp, size },
                            Err(_) => {
                                return fail("inline asm: absolute displacement out of range");
                            }
                        },
                        None => match args.get(idx as usize).and_then(|a| {
                            asm_riprel_target(
                                func,
                                name2entpc,
                                extern_data_names,
                                extern_code_names,
                                *a,
                            )
                        }) {
                            Some(sym) => {
                                riprel_reloc = Some((sym, 0));
                                Concrete::RipRel { disp: 0, size }
                            }
                            None => {
                                return fail(
                                    "inline asm: `%c`/`%P` memory operand is not a constant or address",
                                );
                            }
                        },
                    }
                }
                AsmOpnd::Reg { reg, size } => Concrete::Reg { reg, size },
                AsmOpnd::Ref { idx, size } => {
                    let width = asm.operands[idx as usize].width;
                    match op_reg[idx as usize] {
                        Some(r)
                            if matches!(
                                asm.operands[idx as usize].constraint,
                                AsmConstraint::Mem
                            ) =>
                        {
                            // The C operand type is only the default width.
                            let size = asm_mem_size(size, insn, &asm.operands, &op_reg)
                                .unwrap_or(AsmRegSize::from_width(width));
                            operand_seg = match asm.operands[idx as usize].seg {
                                AsmSeg::Gs => Some(0x65),
                                AsmSeg::Fs => Some(0x64),
                                AsmSeg::None => operand_seg,
                            };
                            // A file-scope object addresses RIP-relative, as
                            // gcc does; the captured-address register serves
                            // a local, a computed address, and the segment
                            // forms, whose base is not a link-time address.
                            let sym = if has_imm_operand
                                || !matches!(asm.operands[idx as usize].seg, AsmSeg::None)
                            {
                                None
                            } else {
                                args.get(idx as usize).and_then(|a| {
                                    asm_riprel_target(
                                        func,
                                        name2entpc,
                                        extern_data_names,
                                        extern_code_names,
                                        *a,
                                    )
                                })
                            };
                            match sym {
                                Some(sym) => {
                                    riprel_reloc = Some((sym, 0));
                                    Concrete::RipRel { disp: 0, size }
                                }
                                None => Concrete::Mem {
                                    base: r,
                                    index: None,
                                    scale: 1,
                                    disp: 0,
                                    size,
                                },
                            }
                        }
                        Some(r)
                            if matches!(
                                asm.operands[idx as usize].constraint,
                                AsmConstraint::Fp
                            ) =>
                        {
                            Concrete::Reg {
                                reg: super::asm::XMM_BASE + r,
                                size: size.unwrap_or(AsmRegSize::from_width(width)),
                            }
                        }
                        Some(r) => Concrete::Reg {
                            reg: r,
                            size: size.unwrap_or(AsmRegSize::from_width(width)),
                        },
                        // A `%N` naming an immediate-only operand: use its
                        // constant value.
                        None => match func.insts.get(args[idx as usize] as usize) {
                            Some(Inst::Imm(v)) => Concrete::Imm(*v),
                            _ => return fail("inline asm: non-constant immediate operand"),
                        },
                    }
                }
                // An explicit `disp(%reg)` memory reference; 64-bit default.
                AsmOpnd::Mem {
                    base,
                    index,
                    scale,
                    disp,
                } => {
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg);
                    let resolve = |b: super::asm::AsmMemBase| -> Option<u8> {
                        match b {
                            super::asm::AsmMemBase::Reg { num, .. } => Some(num),
                            super::asm::AsmMemBase::Ref(idx) => {
                                op_reg.get(idx as usize).copied().flatten().filter(|_| {
                                    !matches!(
                                        asm.operands[idx as usize].constraint,
                                        AsmConstraint::Fp
                                    )
                                })
                            }
                        }
                    };
                    // A `%a` / `disp(%N)` operand whose `%N` is an `i`-class
                    // symbolic address (`&global`) resolves to no register:
                    // emit a RIP-relative reference the linker resolves against
                    // the symbol, as gcc does for `%a` (`sym(%rip)`). A scaled
                    // index cannot ride the RIP-relative form.
                    let sym = match base {
                        super::asm::AsmMemBase::Ref(bi) if index.is_none() => {
                            args.get(bi as usize).and_then(|a| {
                                asm_riprel_target(
                                    func,
                                    name2entpc,
                                    extern_data_names,
                                    extern_code_names,
                                    *a,
                                )
                            })
                        }
                        _ => None,
                    };
                    let base = match (resolve(base), sym) {
                        (Some(b), _) => b,
                        (None, Some(sym)) => {
                            riprel_reloc = Some((sym, disp as i64));
                            concrete.push(Concrete::RipRel {
                                disp: 0,
                                size: size.unwrap_or(AsmRegSize::Quad),
                            });
                            continue;
                        }
                        (None, None) => {
                            return fail("inline asm: memory base must be a register operand");
                        }
                    };
                    let index = match index {
                        Some(i) => match resolve(i) {
                            Some(r) => Some(r),
                            None => {
                                return fail("inline asm: memory index must be a register operand");
                            }
                        },
                        None => None,
                    };
                    Concrete::Mem {
                        base,
                        index,
                        scale,
                        disp,
                        size: size.unwrap_or(AsmRegSize::Quad),
                    }
                }
                // An absolute `seg:disp` reference; the segment prefix rides
                // the instruction. Access width as for `disp(%reg)`. A symbol
                // address needs a relocation the function-body stream does not
                // carry, so only the literal form assembles here.
                AsmOpnd::AbsMem { sym: Some(_), .. } => {
                    return fail(
                        "inline asm: an absolute symbol address is only supported in \
                         file-scope asm",
                    );
                }
                AsmOpnd::AbsMem { disp, sym: None } => {
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg);
                    Concrete::AbsMem {
                        disp,
                        size: size.unwrap_or(AsmRegSize::Quad),
                    }
                }
                // A literal-displacement `disp(%rip)`: encode the RIP-relative
                // form (mod=00 rm=101 + disp32) with no relocation; the address
                // is `rip + disp`. Access width as for `disp(%reg)`.
                AsmOpnd::RipRel { disp } => {
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg);
                    Concrete::RipRel {
                        disp,
                        size: size.unwrap_or(AsmRegSize::Quad),
                    }
                }
                // `%cN(%%rip)` / `%PN(%%rip)`: a compile-time constant becomes
                // the disp32 literal; a link-time address takes a RIP-relative
                // relocation, as for `%a`.
                AsmOpnd::RipRelRef { idx, .. } => {
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg)
                        .unwrap_or(AsmRegSize::Quad);
                    match const_of(idx) {
                        Some(v) => match i32::try_from(v) {
                            Ok(disp) => Concrete::RipRel { disp, size },
                            Err(_) => {
                                return fail("inline asm: RIP-relative displacement out of range");
                            }
                        },
                        None => match args.get(idx as usize).and_then(|a| {
                            asm_riprel_target(
                                func,
                                name2entpc,
                                extern_data_names,
                                extern_code_names,
                                *a,
                            )
                        }) {
                            Some(sym) => {
                                riprel_reloc = Some((sym, 0));
                                Concrete::RipRel { disp: 0, size }
                            }
                            None => {
                                return fail(
                                    "inline asm: `%c`/`%P` RIP-relative operand is not a constant or address",
                                );
                            }
                        },
                    }
                }
                // `disp(,%index,scale)`: a no-base scaled-index reference. A
                // symbol displacement needs an absolute relocation the
                // function-body stream does not carry (as for `$symbol`); it is
                // assembled only in file-scope asm.
                AsmOpnd::IndexMem {
                    index,
                    scale,
                    disp,
                    sym,
                } => {
                    if sym.is_some() {
                        return fail(
                            "inline asm: a symbol-displacement memory operand is only supported in file-scope asm",
                        );
                    }
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg)
                        .unwrap_or(AsmRegSize::Quad);
                    let index = match index {
                        super::asm::AsmMemBase::Reg { num, .. } => num,
                        super::asm::AsmMemBase::Ref(i) => {
                            match op_reg.get(i as usize).copied().flatten().filter(|_| {
                                !matches!(asm.operands[i as usize].constraint, AsmConstraint::Fp)
                            }) {
                                Some(r) => r,
                                None => {
                                    return fail(
                                        "inline asm: memory index must be a register operand",
                                    );
                                }
                            }
                        }
                    };
                    Concrete::IndexMem {
                        index,
                        scale,
                        disp,
                        size,
                    }
                }
                // `disp+sym(%base)`: a symbol displacement, as for the
                // no-base form above.
                // A displacement expression over template labels is a value
                // the stream settles; one naming a symbol needs a relocation
                // only file-scope section code carries.
                AsmOpnd::SymMem {
                    base,
                    index,
                    scale,
                    expr,
                } => {
                    let sym_only = "inline asm: a symbol-displacement memory operand is only \
                                    supported in file-scope asm";
                    let Some(text) = insn.sym_exprs.get(expr as usize) else {
                        return fail(sym_only);
                    };
                    if !super::ssa::emit_common::is_template_label_expr(text, &code_label_names) {
                        return fail(sym_only);
                    }
                    let disp = match template_expr_value(
                        text,
                        code.len(),
                        &label_defs,
                        &code_label_names,
                        &section_measure,
                    ) {
                        Some(v) => match i32::try_from(v) {
                            Ok(d) => d,
                            Err(_) => return fail("inline asm: displacement out of range"),
                        },
                        None => {
                            disp_expr = Some(text.clone());
                            RIPREL_PROBE_DISP
                        }
                    };
                    let reg_of = |b: super::asm::AsmMemBase| -> Option<u8> {
                        match b {
                            super::asm::AsmMemBase::Reg { num, .. } => Some(num),
                            super::asm::AsmMemBase::Ref(i) => {
                                op_reg.get(i as usize).copied().flatten()
                            }
                        }
                    };
                    let (Some(base), index) = (reg_of(base), index.map(reg_of)) else {
                        return fail("inline asm: memory base is not a register");
                    };
                    if index == Some(None) {
                        return fail("inline asm: memory index is not a register");
                    }
                    Concrete::Mem {
                        base,
                        index: index.flatten(),
                        scale,
                        disp,
                        size: asm_mem_size(None, insn, &asm.operands, &op_reg)
                            .unwrap_or(AsmRegSize::Quad),
                    }
                }
                // `sym(%%rip)`: a PC-relative reference to a named symbol,
                // resolved by name through the same relocation channel as a
                // `%a` operand.
                AsmOpnd::SymRipRel { expr } => {
                    let size = asm_mem_size(None, insn, &asm.operands, &op_reg)
                        .unwrap_or(AsmRegSize::Quad);
                    // The in-function channel names a symbol and an offset,
                    // so a displacement over a label difference has nowhere
                    // to resolve and is refused rather than mis-encoded.
                    let Some((name, addend)) = insn
                        .sym_exprs
                        .get(expr as usize)
                        .and_then(|e| super::super::ssa::emit_common::asm_expr_sym_addend(e))
                    else {
                        return fail(
                            "inline asm: a memory displacement over a label difference is only \
                             supported in file-scope asm",
                        );
                    };
                    riprel_reloc = Some((AsmRipSym::Extern { name, offset: 0 }, addend));
                    Concrete::RipRel { disp: 0, size }
                }
                // A `$expr` immediate, under the same rule as a displacement.
                AsmOpnd::ImmSym { expr } => {
                    let Some(text) = insn.sym_exprs.get(expr as usize) else {
                        return fail("inline asm: symbol immediate expression is missing");
                    };
                    match template_expr_value(
                        text,
                        code.len(),
                        &label_defs,
                        &code_label_names,
                        &section_measure,
                    ) {
                        Some(v) => Concrete::Imm(v),
                        None if super::ssa::emit_common::is_template_label_expr(
                            text,
                            &code_label_names,
                        ) =>
                        {
                            imm_expr = Some(text.clone());
                            Concrete::Imm(ABS_LABEL_PLACEHOLDER)
                        }
                        None => {
                            return fail(
                                "inline asm: `$symbol` address immediate is only supported in \
                                 file-scope asm",
                            );
                        }
                    }
                }
                // A label address immediate encodes as a placeholder wide
                // enough to force the imm32 field; the relocation replaces it.
                AsmOpnd::ImmLabel { .. } => Concrete::Imm(ABS_LABEL_PLACEHOLDER),
                // Handled above (jmp / jcc / lea referencing a local label); a
                // label reaching operand resolution rode an unsupported form.
                AsmOpnd::Label { .. } | AsmOpnd::LabelAddr { .. } | AsmOpnd::GotoLabel(_) => {
                    return fail("inline asm: misplaced label reference");
                }
            };
            concrete.push(c);
        }
        // A RIP-relative symbolic operand puts its disp32 at the end of the
        // instruction; a trailing immediate would displace it, so the reloc
        // offset below would be wrong. Reject that combination rather than
        // relocate the wrong bytes.
        if riprel_reloc.is_some() && concrete.iter().any(|c| matches!(c, Concrete::Imm(_))) {
            return fail("inline asm: a symbolic RIP-relative operand with an immediate");
        }
        if abs_label.is_some()
            && concrete
                .iter()
                .filter(|c| matches!(c, Concrete::Imm(_)))
                .count()
                > 1
        {
            return fail("inline asm: a label address immediate with a second immediate");
        }
        // A segment override comes from a template `%gs:` / `%fs:` or from a
        // `__seg_gs` / `__seg_fs` memory operand; the two never conflict on one
        // instruction. It joins the prefix statements ahead of the instruction.
        let pending = match pending_at {
            Some(at) => code.split_off(at),
            None => alloc::vec::Vec::new(),
        };
        let insn_at = code.len();
        let addr = super::asm::addr_size(insn, super::table::Mode::Bits64);
        let mut body = alloc::vec::Vec::new();
        if let Err(m) = super::asm::encode(&mut body, addr, insn.mnemonic, insn.suffix, &concrete) {
            bail_msg(&m);
            return false;
        }
        let sizes = push_legacy_prefixes(code, &body, insn.seg.or(operand_seg), &pending);
        code.extend_from_slice(&body[sizes..]);
        if let Some(rex) = insn.rex
            && let Err(m) = super::asm::splice_rex(code, insn_at, rex)
        {
            bail_msg(&m);
            return false;
        }
        // The label address immediate occupies the last four bytes; the
        // placeholder confirms the chosen form put it there.
        if let Some((num, forward)) = abs_label {
            if code.len() < 4 || code[code.len() - 4..] != ABS_LABEL_PLACEHOLDER_BYTES {
                return fail("inline asm: a label address immediate requires a wider form");
            }
            let at = code.len() - 4;
            code[at..].fill(0);
            abs_label_fixups.push((at, num, forward));
        }
        // The displacement is the last four bytes; an immediate would follow
        // it, so a form carrying one is refused rather than patched wrong.
        if let Some(text) = disp_expr.take() {
            if concrete.iter().any(|c| matches!(c, Concrete::Imm(_))) {
                return fail("inline asm: an expression displacement with an immediate");
            }
            if code.len() < 4 || code[code.len() - 4..] != RIPREL_PROBE_DISP.to_le_bytes() {
                return fail("inline asm: an expression displacement requires a wider form");
            }
            let at = code.len() - 4;
            code[at..].fill(0);
            expr_fixups.push((insn_at, at, 4, text));
        }
        // The same placement rule for a `$expr` immediate.
        if let Some(text) = imm_expr.take() {
            if code.len() < 4 || code[code.len() - 4..] != ABS_LABEL_PLACEHOLDER_BYTES {
                return fail("inline asm: an expression immediate requires a wider form");
            }
            let at = code.len() - 4;
            code[at..].fill(0);
            expr_fixups.push((insn_at, at, 4, text));
        }
        // Record the RIP-relative relocation against the operand's symbol.
        // The disp32 occupies the last four bytes of the instruction just
        // encoded; both channels place the reloc at `instr_offset + 3`, so
        // anchor three bytes before it. gcc's addend is the operand's
        // constant offset less the 4-byte PC-relative end skew.
        if let Some((sym, disp)) = riprel_reloc.take() {
            let instr_offset = code.len() - 4 - 3;
            match sym {
                AsmRipSym::Extern { name, offset } => {
                    user_extern_data_refs.push(super::UserExternDataRef {
                        instr_offset,
                        symbol_name: name,
                        direct_pcrel: Some(offset + disp - 4),
                    });
                }
                AsmRipSym::Local { data_offset } => {
                    data_fixups.push(DataFixup {
                        instr_offset,
                        data_offset: (data_offset + disp) as u64,
                        part: AddrPart::Whole,
                    });
                }
                AsmRipSym::Text { ent_pc } if disp == 0 => {
                    pending_func_fixups.push((instr_offset, ent_pc));
                }
                AsmRipSym::Text { .. } => {
                    return fail(
                        "inline asm: a displacement on an in-unit function address is not supported",
                    );
                }
            }
        }
        after_insn = true;
    }
    // Settle each deferred expression field: the layout is final, so a
    // forward reference now has its definition.
    for (site, at, width, text) in &expr_fixups {
        let Some(v) = template_expr_value(
            text,
            *site,
            &label_defs,
            &code_label_names,
            &section_measure,
        ) else {
            bail_msg(&alloc::format!(
                "inline asm: expression `{text}` is not a constant"
            ));
            return false;
        };
        let w = *width as usize;
        code[*at..*at + w].copy_from_slice(&(v as u64).to_le_bytes()[..w]);
    }
    // Patch each label reference now that every definition's offset is
    // known. A forward `Nf` takes the nearest matching definition after the
    // reference; a backward `Nb`, the nearest at or before it (GNU as
    // local-label rule). A named label has exactly one definition, so the
    // direction is ignored. The displacement is measured from the end of
    // its field. A reference with no main-stream definition may name a
    // label placed in one of the template's pushed sections; defer it to
    // the section pass.
    let mut pending_xsec: alloc::vec::Vec<(usize, u32, bool)> = alloc::vec::Vec::new();
    // The same, for `$LABEL` address immediates, whose field is absolute.
    let mut pending_abs_xsec: alloc::vec::Vec<(usize, u32, bool)> = alloc::vec::Vec::new();
    // The main-stream definition a label reference at `at` binds to: a named
    // label has one definition; a forward `Nf` the nearest after `at`, a
    // backward `Nb` the nearest at or before it.
    let resolve_label = |at: usize, num: u32, forward: bool| -> Option<usize> {
        if num >= super::asm::NAMED_LABEL_BASE {
            label_defs.iter().find(|&&(n, _)| n == num).map(|&(_, o)| o)
        } else if forward {
            label_defs
                .iter()
                .filter(|&&(n, off)| n == num && off > at)
                .map(|&(_, off)| off)
                .min()
        } else {
            label_defs
                .iter()
                .filter(|&&(n, off)| n == num && off <= at)
                .map(|&(_, off)| off)
                .max()
        }
    };
    // Lengthen every short branch this layout leaves outside the byte's
    // reach and hand the grown set back for the next round.
    let known_long = long_sites.len();
    for &(at, num, forward, width, ii) in &label_fixups {
        if width == 1
            && let Some(target) = resolve_label(at, num, forward)
            && !(-128..=127).contains(&(target as i64 - (at as i64 + 1)))
        {
            long_sites.insert(ii);
        }
    }
    if long_sites.len() != known_long {
        return true;
    }
    for &(at, num, forward, width, _) in &label_fixups {
        match resolve_label(at, num, forward) {
            Some(target) => {
                let w = width as usize;
                let rel = target as i64 - (at + w) as i64;
                code[at..at + w].copy_from_slice(&rel.to_le_bytes()[..w]);
            }
            // Only a target this stream defines takes the short form.
            None if width == 4 => pending_xsec.push((at, num, forward)),
            None => return fail("inline asm: undefined local label"),
        }
    }
    // A `$LABEL` immediate binds to the same main-stream definition, but the
    // field carries an absolute `.text` relocation rather than an in-stream
    // displacement. A label the main stream does not define is deferred to the
    // pushed sections, as a branch displacement is.
    for &(at, num, forward) in &abs_label_fixups {
        match resolve_label(at, num, forward) {
            Some(target) => asm_text_abs_refs.push(super::AsmTextAbsRef {
                field_offset: at,
                target_offset: target,
            }),
            None => pending_abs_xsec.push((at, num, forward)),
        }
    }
    // A named label defined in the main stream is a definition of the unit,
    // as it is for GNU as: record it so the writers emit a local `.text`
    // symbol and bind a same-name C reference to it. `.L`-prefixed names are
    // assembler-local (and the renames this emit generates for multiply
    // defined numeric labels carry that prefix), so no C reference spells one.
    for &(num, off) in &label_defs {
        if num < super::asm::NAMED_LABEL_BASE {
            continue;
        }
        let Some(&name) = code_label_names.get((num - super::asm::NAMED_LABEL_BASE) as usize)
        else {
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
    // Materialize the `.pushsection` blocks now that every label's text
    // offset is known. A reference that names a template label resolves
    // to its offset; any other name is a symbol relocation.
    if !section_blocks.is_empty() {
        let names = super::asm::scan_label_names(code_text);
        use super::ssa::emit_common::LabelLoc;
        let label_off = |name: &str| -> Option<LabelLoc> {
            let num = if let Some(i) = names.iter().position(|&n| n == name) {
                super::asm::NAMED_LABEL_BASE + i as u32
            } else {
                let digits = name.strip_suffix(['b', 'f']).unwrap_or(name);
                if digits.is_empty() || !digits.bytes().all(|c| c.is_ascii_digit()) {
                    return None;
                }
                digits.parse().ok()?
            };
            // Sections follow the code textually; a `Nb` (or bare `N`)
            // reference binds to the last definition, `Nf` to the first.
            let forward = name.ends_with('f') && !names.contains(&name);
            let mut defs = label_defs.iter().filter(|&&(n, _)| n == num);
            if forward {
                defs.map(|&(_, off)| off).min()
            } else {
                defs.next_back().map(|&(_, off)| off)
            }
            .map(LabelLoc::Text)
        };
        // An `i`-class operand naming a link-time data address (`.long %c0 - .`
        // where `%c0` is `&sym` or a string literal) relocates against the
        // data image, resolved like the operand's own `ImmData` lowering.
        let operand_sym = |idx: u8| -> Option<(super::ssa::emit_common::AsmSectionTarget, i64)> {
            super::ssa::emit_common::asm_operand_data_target(
                &func.insts,
                *args.get(idx as usize)?,
                &|vid| extern_data_names.get(&vid).cloned(),
            )
        };
        // An `asm goto` label operand (`.long %l0 - .`): the goto row's block
        // index. Its text offset is not final here; the reloc carries the
        // block and is rewritten after layout (see resolve_asm_goto_relocs).
        let goto_block = |idx: u8| -> Option<u32> {
            let ctx = goto_ctx.as_ref()?;
            ctx.row.get(1 + idx as usize).copied()
        };
        let defined = match super::ssa::emit_common::materialize_asm_sections(
            section_blocks,
            &|idx| const_of(idx),
            &label_off,
            &operand_sym,
            &goto_block,
            false,
            asm_sections,
        ) {
            Ok(d) => d,
            Err(m) => {
                bail_msg(&m);
                return false;
            }
        };
        // Bind each deferred main-stream reference to its section definition.
        // The pushed sections follow the main stream textually, so only a
        // forward reference reaches one; the two land in different object
        // sections, so the reference becomes a PC-relative relocation against
        // the target section's symbol rather than an in-stream displacement.
        for (at, num, forward) in pending_xsec.drain(..) {
            let name = if num >= super::asm::NAMED_LABEL_BASE {
                match code_label_names.get((num - super::asm::NAMED_LABEL_BASE) as usize) {
                    Some(n) => alloc::string::String::from(*n),
                    None => return fail("inline asm: undefined local label"),
                }
            } else {
                alloc::format!("{num}")
            };
            let hit = if forward {
                defined.iter().find(|d| d.name == name)
            } else {
                None
            };
            match hit {
                Some(d) => asm_section_text_refs.push(super::AsmSectionTextRef {
                    instr_offset: at,
                    section_index: d.section_index,
                    section_offset: d.offset,
                    addend: -4,
                    absolute: false,
                    kind: super::ssa::emit_common::AsmRelocKind::Data,
                }),
                None => return fail("inline asm: undefined local label"),
            }
        }
        // The absolute form of the same binding: no end skew, and the field
        // takes an absolute relocation against the section symbol.
        for (at, num, forward) in pending_abs_xsec.drain(..) {
            let name = if num >= super::asm::NAMED_LABEL_BASE {
                match code_label_names.get((num - super::asm::NAMED_LABEL_BASE) as usize) {
                    Some(n) => alloc::string::String::from(*n),
                    None => return fail("inline asm: undefined local label"),
                }
            } else {
                alloc::format!("{num}")
            };
            match forward
                .then(|| defined.iter().find(|d| d.name == name))
                .flatten()
            {
                Some(d) => asm_section_text_refs.push(super::AsmSectionTextRef {
                    instr_offset: at,
                    section_index: d.section_index,
                    section_offset: d.offset,
                    addend: 0,
                    absolute: true,
                    kind: super::ssa::emit_common::AsmRelocKind::Data,
                }),
                None => {
                    return fail("inline asm: `$LABEL` address immediate names no local label");
                }
            }
        }
    }
    // A deferred reference with no section to resolve against is undefined.
    if !pending_xsec.is_empty() {
        return fail("inline asm: undefined local label");
    }
    if !pending_abs_xsec.is_empty() {
        return fail("inline asm: `$LABEL` address immediate names no local label");
    }

    // Flag outputs: the template's condition flags are still live here (the
    // label fixups above patch bytes and emit none), so materialize each
    // `=@cc<cond>` with `set<cond>` into its assigned register's low byte and
    // zero-extend it. This must precede the store-back loop, whose `mov`s
    // would otherwise be the first instructions after the template.
    for (i, op) in asm.operands.iter().enumerate() {
        let AsmConstraint::Flags(nibble) = op.constraint else {
            continue;
        };
        let Some(cc) = super::encode::Cc::from_nibble(nibble) else {
            return fail("inline asm: bad flag-output condition");
        };
        let Some(r) = op_reg[i] else {
            return fail("inline asm: flag output without a register");
        };
        super::encode::emit_setcc_r8(code, cc, Reg(r));
        super::encode::emit_movzx_r_r8(code, Reg(r), Reg(r));
    }
    // Store the register outputs back through their captured addresses. A
    // memory operand needs no store-back: the instruction wrote memory.
    // For `asm goto` the outputs are stored on every exit path (GCC 11
    // output semantics), so the sequence repeats on each trampoline.
    let emit_outputs = |code: &mut Vec<u8>| {
        for (i, op) in asm.operands.iter().enumerate() {
            if !op.is_output
                || matches!(op.constraint, AsmConstraint::Mem | AsmConstraint::Bound(_))
            {
                continue;
            }
            let Some(r) = op_reg[i] else { continue };
            super::encode::emit_mov_r_mem(code, stage, Reg::RBP, cap_off(i));
            if matches!(op.constraint, AsmConstraint::Fp) {
                super::encode::emit_movups_mem_xmm(code, stage, 0, Reg(r));
            } else {
                emit_asm_store_width(code, stage, Reg(r), op.width);
            }
        }
    };
    // Restore the saved registers from their frame slots.
    let emit_restore = |code: &mut Vec<u8>| {
        for (k, &r) in save_list.iter().enumerate() {
            super::encode::emit_mov_r_mem(code, Reg(r), Reg::RBP, gp_off(k));
        }
        for (k, &r) in fp_save_list.iter().enumerate() {
            super::encode::emit_movups_xmm_mem(code, Reg(r), Reg::RBP, base + k as i32 * 16);
        }
    };
    let exit_start = code.len();
    emit_outputs(code);
    emit_restore(code);
    // `asm goto`: each `%lK` branch leaves mid-template, before the
    // store-backs and restore just emitted on the fall-through path, so
    // it lands on a trampoline that repeats them and jumps to the
    // label's block through the enclosing function's branch fixups. A
    // label whose target is the fall-through block reuses the
    // fall-through exit sequence instead. With an empty exit sequence
    // (`goto_direct`) the template branch itself rides the enclosing
    // function's branch fixups, pinned to its already-emitted long form.
    if let Some(ctx) = goto_ctx.as_mut()
        && goto_direct
    {
        for &(site, kind, k) in &goto_sites {
            ctx.branch_fixups.push(BranchFixup {
                site: site + kind.opcode_len(),
                target: ctx.row[1 + k],
                kind,
                short: false,
                pinned_long: true,
            });
        }
    } else if let Some(ctx) = goto_ctx.as_mut() {
        let mut tramp_at: alloc::vec::Vec<Option<usize>> = alloc::vec![None; ctx.row.len() - 1];
        if goto_sites
            .iter()
            .any(|&(_, _, k)| ctx.row[1 + k] != ctx.row[0])
        {
            let skip_site = code.len() + 1;
            super::encode::emit_jmp_rel32(code, 0);
            for &(_, _, k) in &goto_sites {
                if ctx.row[1 + k] == ctx.row[0] || tramp_at[k].is_some() {
                    continue;
                }
                tramp_at[k] = Some(code.len());
                emit_outputs(code);
                emit_restore(code);
                emit_local_branch(
                    code,
                    ctx.branch_fixups,
                    ctx.branch_short,
                    LocalBranchKind::Jmp,
                    ctx.row[1 + k],
                );
            }
            let rel = (code.len() - (skip_site + 4)) as i32;
            code[skip_site..skip_site + 4].copy_from_slice(&rel.to_le_bytes());
        }
        for &(site, kind, k) in &goto_sites {
            let target = tramp_at[k].unwrap_or(exit_start);
            let at = site + kind.opcode_len();
            let rel = target as i64 - (at + 4) as i64;
            code[at..at + 4].copy_from_slice(&(rel as i32).to_le_bytes());
        }
    }
    true
}

/// Map a conditional-jump mnemonic to its condition code, folding the
/// synonym spellings (`jc`==`jb`, `jnae`==`jb`, ...). `None` for `jmp` and
/// for any non-jcc mnemonic.
pub(super) fn jcc_cond(name: &str) -> Option<super::encode::Cc> {
    use super::encode::Cc;
    Some(match name {
        "je" | "jz" => Cc::E,
        "jne" | "jnz" => Cc::Ne,
        "js" => Cc::S,
        "jns" => Cc::Ns,
        "jl" | "jnge" => Cc::L,
        "jge" | "jnl" => Cc::Ge,
        "jg" | "jnle" => Cc::G,
        "jle" | "jng" => Cc::Le,
        "jb" | "jc" | "jnae" => Cc::B,
        "jae" | "jnb" | "jnc" => Cc::Ae,
        "ja" | "jnbe" => Cc::A,
        "jbe" | "jna" => Cc::Be,
        "jo" => Cc::O,
        "jno" => Cc::No,
        "jp" | "jpe" => Cc::P,
        "jnp" | "jpo" => Cc::Np,
        _ => return None,
    })
}

/// Load the low `width` bytes at `[base]` into `dst` (zero-extended).
fn emit_asm_load_width(code: &mut Vec<u8>, dst: Reg, base: Reg, width: u8) {
    match width {
        1 => super::encode::emit_movzx_r_mem8(code, dst, base, 0),
        2 => super::encode::emit_movzx_r_mem16(code, dst, base, 0),
        4 => super::encode::emit_mov_r_mem32(code, dst, base, 0),
        _ => super::encode::emit_mov_r_mem(code, dst, base, 0),
    }
}

/// Store the low `width` bytes of `src` to `[base]`.
fn emit_asm_store_width(code: &mut Vec<u8>, base: Reg, src: Reg, width: u8) {
    match width {
        1 => super::encode::emit_mov_mem_r8(code, base, 0, src),
        2 => super::encode::emit_mov_mem_r16(code, base, 0, src),
        4 => super::encode::emit_mov_mem_r32(code, base, 0, src),
        _ => super::encode::emit_mov_mem_r(code, base, 0, src),
    }
}

fn emit_intrinsic(
    code: &mut Vec<u8>,
    kind: i64,
    args: &[u32],
    dst: Place,
    v: super::super::ir::ValueId,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
) -> bool {
    use crate::c5::op::Intrinsic as I;
    // Byte stride between adjacent variadic arguments in the cursor
    // va_list. System V AMD64 routes its variadic intrinsics through the
    // register-save-area arms below (gated on `sysv_host_variadic`), so
    // the only x86_64 target reaching the cursor arms is Win64 (Microsoft
    // x64 calling convention), which packs the variadic tail at 8-byte
    // stride in the home area + incoming stack.
    let va_stride: i32 = 8;
    let Some(intrinsic) = I::from_i64(kind) else {
        return fail("intrinsic: unknown discriminant");
    };
    // Force args[idx]'s value into `scratch`; the register-tied arms
    // below stage operands into fixed registers around a clobber
    // window. `pushed` is the number of 8-byte pushes the arm has
    // emitted so far: rsp has moved by that much since the allocator
    // laid out its rsp-relative spill slots, so a spilled place must be
    // read through the shifted form.
    let materialize_at =
        |code: &mut Vec<u8>, idx: usize, scratch: Reg, pushed: u32| -> Option<Reg> {
            let place = alloc.places.get(args[idx] as usize).copied()?;
            let r = materialize_int_shifted(code, place, scratch, frame, 8 * pushed)?;
            if r.0 != scratch.0 {
                super::encode::emit_mov_rr(code, scratch, r);
            }
            Some(scratch)
        };
    match intrinsic {
        // Resolved to an `Imm` before lowering, by the SSA folds under
        // `-O` and by the walker otherwise; reaching here is a pass-
        // ordering bug.
        I::ConstantP => fail("Intrinsic::ConstantP must be resolved before lowering"),
        I::VaStart if sysv_variadic_callee(func, abi) => {
            // System V AMD64 `va_start` (ABI 3.5.7). args[0] = the
            // `__va_list_tag` pointer (the array-form `va_list` decayed
            // to `&ap[0]`), args[1] = &last (unused -- the named-argument
            // counts come from the prototype, not the last named
            // argument's address). Initialise the struct:
            //   gp_offset        = num_named_int * 8
            //   fp_offset        = 48 + num_named_fp * 16
            //   overflow_arg_area = first incoming stack argument
            //   reg_save_area     = base of the prologue-spilled area
            if args.len() != 2 {
                return fail("VaStart: expected 2 args");
            }
            // Named integer / FP argument counts from the prototype:
            // `param_fp_mask` bit i set means named parameter i is
            // floating-point. The gp area skips the named integer
            // arguments (each 8 bytes); the fp area starts at offset 48
            // and skips the named FP arguments (each 16 bytes).
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
            // gp_offset / fp_offset index the next argument register the
            // save area holds; they saturate at the bank size (six GP, eight
            // FP) so a callee whose named parameters fill or overflow a bank
            // sends `va_arg` straight to the overflow area.
            let gp_offset = named_int.min(6) * 8;
            // With the XMM save area unpopulated (`-mno-sse`), report the
            // FP bank exhausted so `va_arg` walks gp then overflow only.
            let fp_offset = if abi.no_fp_varargs {
                SYSV_REG_SAVE_BYTES
            } else {
                SYSV_GP_SAVE_BYTES + named_fp.min(8) * 16
            };
            let Some(ap_place) = alloc.places.get(args[0] as usize).copied() else {
                return fail("VaStart: &ap value id out of range");
            };
            let Some(ap) = materialize_int(code, ap_place, SCRATCH_R11, frame) else {
                return fail("VaStart: &ap not in int reg / spill");
            };
            // gp_offset (u32) at [ap + 0], fp_offset (u32) at [ap + 4].
            super::encode::emit_mov_mem32_imm32(code, ap, 0, gp_offset as i32);
            super::encode::emit_mov_mem32_imm32(code, ap, 4, fp_offset as i32);
            // overflow_arg_area (ptr) at [ap + 8] = first variadic stack
            // argument. Incoming stack arguments sit just above the return
            // address at [rbp + 16]; the named parameters that overflowed
            // the argument registers occupy the low slots there, so the
            // variadic tail begins past them.
            let named_stack_bytes: i32 = super::plan_param_regs(n, func.param_fp_mask, abi)
                .placements
                .iter()
                .filter(|q| matches!(q, super::ArgPlacement::Stack(_)))
                .count() as i32
                * 8;
            emit_lea_r_mem(code, SCRATCH_R10, Reg::RBP, 16 + named_stack_bytes);
            emit_mov_mem_r(code, ap, 8, SCRATCH_R10);
            // reg_save_area (ptr) at [ap + 16] = base of the spilled gp
            // area.
            emit_lea_r_mem(code, SCRATCH_R10, Reg::RBP, frame.va_reg_save_off);
            emit_mov_mem_r(code, ap, 16, SCRATCH_R10);
            true
        }
        // The System V `va_list` is a `__va_list_tag` struct on this
        // target, so `va_arg` walks the gp/fp save areas regardless of
        // whether the current function is itself variadic: a non-
        // variadic forwarder (the `c5_v*printf` shims) receives a
        // forwarded `va_list` and must read it the same way. Gate on the
        // target ABI, not `func.is_variadic`.
        I::VaArg if abi.sysv_host_variadic() => {
            emit_va_arg_sysv(code, args, dst, func, alloc, frame)
        }
        I::VaCopy if abi.sysv_host_variadic() => {
            // System V `va_copy` is a 24-byte `__va_list_tag` struct copy
            // (ABI 3.5.7). args[0] = &dst struct, args[1] = &src struct.
            if args.len() != 2 {
                return fail("VaCopy: expected 2 args");
            }
            let Some(src_place) = alloc.places.get(args[1] as usize).copied() else {
                return fail("VaCopy: &src value id out of range");
            };
            let Some(src_p) = materialize_int(code, src_place, SCRATCH_R11, frame) else {
                return fail("VaCopy: &src not in int reg / spill");
            };
            let Some(dst_place) = alloc.places.get(args[0] as usize).copied() else {
                return fail("VaCopy: &dst value id out of range");
            };
            // Both pointers ride the reserved r10 / r11 scratches (rcx
            // is in the allocator's caller pool and may hold a live
            // value across the intrinsic). The copied word borrows a
            // pool register around a push/pop pair, mirroring
            // emit_mcpy; the spill loads above run before the push so
            // rsp-relative offsets stay valid.
            let Some(dst_p) = materialize_int(code, dst_place, SCRATCH_R10, frame) else {
                return fail("VaCopy: &dst not in int reg / spill");
            };
            let temp = if dst_p.0 != Reg::RAX.0 && src_p.0 != Reg::RAX.0 {
                Reg::RAX
            } else if dst_p.0 != Reg::RCX.0 && src_p.0 != Reg::RCX.0 {
                Reg::RCX
            } else {
                Reg::RDX
            };
            emit_push_r(code, temp);
            // Copy the three 8-byte `__va_list_tag` words (ABI 3.5.7):
            // gp_offset + fp_offset packed in the first, then
            // overflow_arg_area and reg_save_area.
            for off in [0i32, 8, 16] {
                emit_mov_r_mem(code, temp, src_p, off);
                emit_mov_mem_r(code, dst_p, off, temp);
            }
            emit_pop_r(code, temp);
            true
        }
        I::VaStart => {
            // __builtin_va_start(&ap, &last). args[0] = &ap,
            // args[1] = &last. *ap = &last + va_stride, the address of
            // the first variadic slot one stride past the last named
            // parameter. System V routes its `va_start` through the
            // register-save-area arm above, so only the Win64 host
            // variadic ABI reaches here: it lays named and variadic
            // arguments at 8-byte stride (named register arguments
            // spilled by the prologue into the home area, the variadic
            // tail on the incoming stack). va_start runs only in the
            // variadic function itself, whose named parameters already
            // use `va_stride` (`Frame::param_cell_stride`), so
            // `&last + va_stride` lands on the first variadic argument.
            if args.len() != 2 {
                return fail("VaStart: expected 2 args");
            }
            // Both pointer operands can land in spill slots under
            // register pressure, so materialize each into a reserved
            // scratch. r10 / r11 sit outside both allocator banks, so
            // they never alias an allocator-chosen `ap` / `last`. The
            // `last + va_stride` advance reuses the `last` register, so
            // the peak register need is two.
            let Some(ap_place) = alloc.places.get(args[0] as usize).copied() else {
                return fail("VaStart: &ap value id out of range");
            };
            let Some(last_place) = alloc.places.get(args[1] as usize).copied() else {
                return fail("VaStart: &last value id out of range");
            };
            let Some(ap) = materialize_int(code, ap_place, SCRATCH_R11, frame) else {
                return fail("VaStart: &ap not in int reg / spill");
            };
            let Some(last) = materialize_int(code, last_place, SCRATCH_R10, frame) else {
                return fail("VaStart: &last not in int reg / spill");
            };
            // advance = last + va_stride ; mov [ap], advance. When
            // `last` is an allocator register it may still be live after
            // VaStart, so the advance lands in r10 rather than
            // clobbering it; when `last` was spilled it already sits in
            // the throwaway r10 copy, which is reused. r10 is outside
            // both pools, so it never aliases `ap` or the
            // allocator-chosen `last`.
            let advance = SCRATCH_R10;
            emit_lea_r_mem(code, advance, last, va_stride);
            emit_mov_mem_r(code, ap, 0, advance);
            true
        }
        I::VaArg => {
            // Returns *ap, advances *ap by va_stride. args[0] = &ap.
            // args[1] (when present) is the packed type descriptor; the
            // Win64 / cursor single-region walk ignores the kind, so only
            // args[0] is read.
            if args.is_empty() {
                return fail("VaArg: expected at least the ap argument");
            }
            // The cursor address `ap`, the loaded result, and the
            // advance temporary must each occupy a distinct register so
            // the writeback stores through the cursor rather than through
            // the just-loaded value. Both the `&ap` operand and the
            // result can land in spill slots under register pressure, and
            // the allocator may even pick the same physical register for
            // the result and `&ap`. r10 / r11 sit outside both allocator
            // banks, so they never alias an allocator-chosen place; the
            // cursor is held in r11 (forced there whenever it would
            // otherwise alias the work register), the value is loaded
            // into a work register, the advance into r10, and the value
            // is then delivered to the destination.
            let Some(ap_place) = alloc.places.get(args[0] as usize).copied() else {
                return fail("VaArg: &ap value id out of range");
            };
            // Cursor address. A spilled `&ap` loads into r11; a register
            // operand is moved into r11 when it would alias the work
            // register so the load can't clobber it.
            let ap = match ap_place {
                Place::IntReg(r) => {
                    let work_aliases = match dst {
                        Place::IntReg(d) => d == r,
                        _ => false,
                    };
                    if work_aliases {
                        emit_mov_rr(code, SCRATCH_R11, Reg(r));
                        SCRATCH_R11
                    } else {
                        Reg(r)
                    }
                }
                Place::Spill(slot) => {
                    let (sb, sp_off) = spill_slot_addr(frame, slot);
                    emit_mov_r_mem(code, SCRATCH_R11, sb, sp_off);
                    SCRATCH_R11
                }
                _ => return fail("VaArg: &ap not in int reg / spill"),
            };
            // Work register holding the loaded result: the destination
            // register when distinct from the cursor, otherwise r10. The
            // cursor was forced to r11 above whenever the destination
            // register aliased it, so `work` here never equals `ap`.
            let work = match dst {
                Place::IntReg(d) if Reg(d).0 != ap.0 => Reg(d),
                _ => SCRATCH_R10,
            };
            // work = *ap (old cursor) ; r10 = work + va_stride ; *ap =
            // r10. r10 is the advance temporary; it differs from `ap`
            // (r11 or an allocator reg) and from `work` (only r10 when
            // the dst is spilled, in which case `work` is dead after the
            // store back).
            emit_mov_r_mem(code, work, ap, 0);
            let advance = SCRATCH_R10;
            if advance.0 == work.0 {
                // Destination spilled: store the result before reusing
                // r10 for the advance.
                spill_dst_to_slot(code, dst, work, frame);
                emit_lea_r_mem(code, advance, work, va_stride);
                emit_mov_mem_r(code, ap, 0, advance);
            } else {
                emit_lea_r_mem(code, advance, work, va_stride);
                emit_mov_mem_r(code, ap, 0, advance);
                spill_dst_to_slot(code, dst, work, frame);
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
                return fail("VaCopy: expected 2 args");
            }
            // Both pointer operands can land in spill slots under
            // register pressure. Load the source value into r10 before
            // materializing the destination pointer, so r11 can hold the
            // source pointer and then be reused for the destination
            // pointer -- the peak register need is two. r10 / r11 sit
            // outside both allocator banks, so they never alias an
            // allocator-chosen place.
            let Some(dst_place) = alloc.places.get(args[0] as usize).copied() else {
                return fail("VaCopy: &dst value id out of range");
            };
            let Some(src_place) = alloc.places.get(args[1] as usize).copied() else {
                return fail("VaCopy: &src value id out of range");
            };
            let Some(src_p) = materialize_int(code, src_place, SCRATCH_R11, frame) else {
                return fail("VaCopy: &src not in int reg / spill");
            };
            let scratch = SCRATCH_R10;
            emit_mov_r_mem(code, scratch, src_p, 0);
            let Some(dst_p) = materialize_int(code, dst_place, SCRATCH_R11, frame) else {
                return fail("VaCopy: &dst not in int reg / spill");
            };
            emit_mov_mem_r(code, dst_p, 0, scratch);
            true
        }
        I::Alloca => {
            // alloca(n): move rsp down by `n` rounded up to 16 bytes
            // and return the new rsp. The 16-byte rounding keeps rsp
            // aligned for the call sites that follow; the frame's
            // spill slots and locals stay reachable through rbp
            // (`Frame::dynamic_sp`). The storage is reclaimed by the
            // epilogue's `lea rsp, [rbp - frame_bytes]`, or earlier by
            // an `AllocaRestore` closing a VLA scope (C99 6.2.4p2).
            if !frame.dynamic_sp {
                return fail("Alloca: AllocaInit didn't run for this function");
            }
            if args.len() != 1 {
                return fail("Alloca: expected 1 arg");
            }
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("Alloca: dst not int reg / spill");
            };
            let size_place = place_of(alloc, args[0]);
            // rd_phys receives the result (rd for a register dst, r10
            // for a spill dst); the rounded size rides r11. Both
            // scratches sit outside the allocator banks, and rd is
            // never r11, so size and result stay distinct.
            let rd_phys = if matches!(dst, Place::Spill(_)) {
                SCRATCH_R10
            } else {
                rd
            };
            let size_reg = SCRATCH_R11;
            let Some(n) = materialize_int(code, size_place, size_reg, frame) else {
                return fail("Alloca: size not int reg / spill / fp");
            };
            if n.0 != size_reg.0 {
                emit_mov_rr(code, size_reg, n);
            }
            super::encode::emit_ri(code, Mnem::Add, 8, size_reg, 15);
            super::encode::emit_ri(code, Mnem::And, 8, size_reg, -16);
            // rd_phys = rsp - rounded_size, the final rsp value.
            emit_mov_rr(code, rd_phys, Reg::RSP);
            super::encode::emit_rr(code, Mnem::Sub, 8, rd_phys, size_reg);
            // Walk rsp down page by page, touching each, before
            // committing the final value: the same guard-region rule the
            // prologue's `emit_stack_alloc` follows, over a size known
            // only at run time. The size is 16-aligned, so the amount the
            // settling `mov` covers past the last probe is at most
            // MAX_UNPROBED_STACK_STEP and needs no probe of its own.
            super::encode::emit_shift_ri(code, Mnem::Shr, 8, size_reg, 12);
            super::encode::emit_rr(code, Mnem::Test, 8, size_reg, size_reg);
            super::encode::emit_jcc_rel32(code, Cc::E, 0);
            let skip_at = code.len() - 4;
            let loop_start = code.len();
            emit_sub_rsp_imm32(code, STACK_PROBE_PAGE);
            emit_stack_probe(code);
            super::encode::emit_ri(code, Mnem::Sub, 8, size_reg, 1);
            super::encode::emit_jcc_rel32(code, Cc::Ne, 0);
            let back_at = code.len() - 4;
            let back = (loop_start as i64 - code.len() as i64) as i32;
            code[back_at..back_at + 4].copy_from_slice(&back.to_le_bytes());
            let skip = (code.len() as i64 - (skip_at + 4) as i64) as i32;
            code[skip_at..skip_at + 4].copy_from_slice(&skip.to_le_bytes());
            emit_mov_rr(code, Reg::RSP, rd_phys);
            spill_dst_to_slot(code, dst, rd_phys, frame);
            true
        }
        I::AllocaSave => {
            // Snapshot rsp for a VLA block (C99 6.2.4p2).
            if !frame.dynamic_sp {
                return fail("AllocaSave: AllocaInit didn't run for this function");
            }
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("AllocaSave: dst not int reg / spill");
            };
            let rd_phys = if matches!(dst, Place::Spill(_)) {
                SCRATCH_R10
            } else {
                rd
            };
            emit_mov_rr(code, rd_phys, Reg::RSP);
            spill_dst_to_slot(code, dst, rd_phys, frame);
            true
        }
        I::AllocaRestore => {
            // Restore the saved rsp on VLA block exit, reclaiming the
            // block's VLA storage (per iteration for a loop body).
            if !frame.dynamic_sp {
                return fail("AllocaRestore: AllocaInit didn't run for this function");
            }
            if args.len() != 1 {
                return fail("AllocaRestore: expected 1 arg");
            }
            let v_place = place_of(alloc, args[0]);
            let Some(v) = materialize_int(code, v_place, SCRATCH_R10, frame) else {
                return fail("AllocaRestore: arg not int reg / spill / fp");
            };
            emit_mov_rr(code, Reg::RSP, v);
            true
        }
        I::SetjmpAArch64 | I::LongjmpAArch64 => {
            fail("intrinsic: AArch64 setjmp / longjmp on non-AArch64 target")
        }
        // fma / fmaf lower to Inst::Fma at the call site, so they never
        // reach the Inst::Intrinsic dispatch.
        I::Fma | I::Fmaf => fail("intrinsic: fma / fmaf lower to Inst::Fma, not Inst::Intrinsic"),
        I::Trap => {
            // `ud2` (0F 0B) raises #UD (illegal instruction). Execution
            // does not continue past it.
            code.push(0x0F);
            code.push(0x0B);
            true
        }
        I::CpuRelax => {
            // `pause` (F3 90), the x86-64 spin-loop hint.
            code.push(0xF3);
            code.push(0x90);
            true
        }
        I::AtomicThreadFence => {
            // `mfence` (0F AE F0), a full barrier (C11 7.17.4 seq_cst).
            // No operand, no result.
            code.push(0x0F);
            code.push(0xAE);
            code.push(0xF0);
            true
        }
        I::X87StoreControlWord
        | I::X87LoadControlWord
        | I::X86FxSave
        | I::X86FxRestore
        | I::X86Sgdt
        | I::X86Sidt
        | I::X86Sldt
        | I::X86Str
        | I::X86Lgdt
        | I::X86Lidt
        | I::X86Lldt
        | I::X86Clflush => {
            // Single-memory-operand x87 / system forms. The one argument
            // is the operand address; force it into r10 so the ModRM byte
            // needs no SIB / displacement (r10 = rm 010 under REX.B). The
            // opcode bytes and ModRM.reg field select the instruction:
            //   fnstcw/fldcw = D9 /7,/5 ; fxsave/fxrstor = 0F AE /0,/1 ;
            //   sgdt/sidt = 0F 01 /0,/1 ; lgdt/lidt = 0F 01 /2,/3 ;
            //   sldt/str  = 0F 00 /0,/1 ; lldt = 0F 00 /2 ; clflush = 0F AE /7.
            if args.len() != 1 {
                return fail("single-memory-operand intrinsic expects 1 arg");
            }
            let Some(place) = alloc.places.get(args[0] as usize).copied() else {
                return fail("single-memory-operand intrinsic: arg place missing");
            };
            let Some(addr) = materialize_int(code, place, SCRATCH_R10, frame) else {
                return fail("single-memory-operand intrinsic: arg not an int register");
            };
            if addr.0 != SCRATCH_R10.0 {
                super::encode::emit_mov_rr(code, SCRATCH_R10, addr);
            }
            let (opc, reg_field): (&[u8], u8) = match intrinsic {
                I::X87StoreControlWord => (&[0xD9], 7),
                I::X87LoadControlWord => (&[0xD9], 5),
                I::X86FxSave => (&[0x0F, 0xAE], 0),
                I::X86FxRestore => (&[0x0F, 0xAE], 1),
                I::X86Sgdt => (&[0x0F, 0x01], 0),
                I::X86Sidt => (&[0x0F, 0x01], 1),
                I::X86Lgdt => (&[0x0F, 0x01], 2),
                I::X86Lidt => (&[0x0F, 0x01], 3),
                I::X86Sldt => (&[0x0F, 0x00], 0),
                I::X86Str => (&[0x0F, 0x00], 1),
                I::X86Lldt => (&[0x0F, 0x00], 2),
                _ => (&[0x0F, 0xAE], 7), // clflush
            };
            code.push(0x41); // REX.B for r10
            code.extend_from_slice(opc);
            code.push((reg_field << 3) | 0x02); // mod=00, reg=field, rm=r10
            true
        }
        I::Divq128 => {
            // Unsigned 128/64 division (`udiv_qrnnd`). The dividend is
            // rdx:rax = n1:n0, the divisor is `d`; `div` leaves the
            // quotient in rax and the remainder in rdx. args:
            // [q_addr, rem_addr, n0, n1, d].
            const RAX: Reg = Reg(0);
            const RDX: Reg = Reg(2);
            const R10: Reg = Reg(10);
            const R11: Reg = Reg(11);
            if args.len() != 5 {
                return fail("divq: wrong operand count");
            }
            // `div` clobbers rax and rdx.
            super::encode::emit_push_r(code, RAX);
            super::encode::emit_push_r(code, RDX);
            // Push the output addresses (quotient then remainder, so the
            // remainder address is popped first below); the shift tracks
            // the pushes emitted so far.
            if materialize_at(code, 0, R10, 2).is_none() {
                return fail("divq: quotient output not an address");
            }
            super::encode::emit_push_r(code, R10);
            if materialize_at(code, 1, R10, 3).is_none() {
                return fail("divq: remainder output not an address");
            }
            super::encode::emit_push_r(code, R10);
            // Divisor -> r10, dividend high -> r11, then load rax/rdx last
            // so an input the allocator placed in rax/rdx is read first.
            if materialize_at(code, 4, R10, 4).is_none() {
                return fail("divq: divisor operand missing");
            }
            if materialize_at(code, 3, R11, 4).is_none() {
                return fail("divq: dividend-high operand missing");
            }
            if materialize_at(code, 2, RAX, 4).is_none() {
                return fail("divq: dividend-low operand missing");
            }
            super::encode::emit_mov_rr(code, RDX, R11); // rdx = n1
            // div r10  (REX.W + REX.B, F7 /6 -> unsigned divide).
            code.push(0x49);
            code.push(0xF7);
            code.push(0xF2);
            // Store quotient (rax) and remainder (rdx) to the popped
            // addresses (remainder is on top of the stack).
            super::encode::emit_pop_r(code, R11);
            super::encode::emit_mov_mem_r(code, R11, 0, RDX);
            super::encode::emit_pop_r(code, R11);
            super::encode::emit_mov_mem_r(code, R11, 0, RAX);
            super::encode::emit_pop_r(code, RDX);
            super::encode::emit_pop_r(code, RAX);
            true
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
                return fail("unary FP intrinsic: expected 1 arg");
            }
            emit_fp_unary(code, dst, v, args[0], intrinsic, alloc, frame)
        }
        I::FrameAddress => {
            // __builtin_frame_address(0): the current frame pointer (rbp).
            // A level above 0 reaches here as this plus a load chain.
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("FrameAddress: dst not int reg / spill");
            };
            emit_mov_rr(code, rd, Reg::RBP);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        I::StackPointer => {
            // A `register T v asm("rsp")` read: the current stack pointer.
            let Some(rd) = int_or_spill_dst(dst) else {
                bail_msg("StackPointer: dst not int reg / spill");
                return false;
            };
            emit_mov_rr(code, rd, Reg::RSP);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        I::ReturnAddress => {
            // __builtin_return_address(0): the return address the call
            // pushed, at [rbp + 8] above the saved rbp. The parser admits
            // level 0 only, so there is no operand.
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("ReturnAddress: dst not int reg / spill");
            };
            emit_mov_r_mem(code, rd, Reg::RBP, 8);
            spill_dst_to_slot(code, dst, rd, frame);
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
            fail("intrinsic: bit builtin reached codegen")
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
            fail("intrinsic: atomic op reached codegen")
        }
        I::AArch64ReadCacheType
        | I::AArch64DcCvau
        | I::AArch64IcIvau
        | I::AArch64DsbIsh
        | I::AArch64Isb => {
            // AArch64 cache maintenance and barriers; the source gates them
            // on `__aarch64__`, so x86-64 never reaches them.
            fail("aarch64 cache / barrier intrinsic is aarch64-only")
        }
        I::Atomic128CmpXchg
        | I::Atomic128Xchg
        | I::Atomic128FetchAnd
        | I::Atomic128FetchOr
        | I::Atomic128Load
        | I::Atomic128Store
        | I::Atomic128LoadEx
        | I::Atomic128StoreEx
        | I::Atomic128StoreInsert => {
            // The 128-bit atomic ldaxp/stlxp and ldp/stp, ldxp/stxp shapes
            // are aarch64-only; the source selects them via the aarch64
            // host-include path, so x86-64 (which has native `cmpxchg16b`)
            // never reaches them.
            fail("128-bit atomic asm shape is aarch64-only")
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
        return fail("ImmData: dst not int reg / spill");
    };
    let instr_offset = code.len();
    data_fixups.push(DataFixup {
        instr_offset,
        data_offset: offset as u64,
        part: AddrPart::Whole,
    });
    // `lea rd, [rip + 0]` placeholder; the writer patches the
    // disp32 once the data segment's runtime address is known.
    super::encode::emit_lea_r_rip32(code, rd, 0);
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
        return fail("ImmCode: dst not int reg / spill");
    };
    let instr_offset = code.len();
    pending_func_fixups.push((instr_offset, target_ent_pc));
    super::encode::emit_lea_r_rip32(code, rd, 0);
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// `Inst::ImmExtCode` -- `lea rd, [rip+disp32]` taking the
/// address of a dynamically-imported function. The disp32 resolves
/// to the import's shared stub (the same `jmp [GOT]` a call to the
/// import reaches), so `&strcmp` yields the stub address. Records an
/// `is_addr` PLT-call fixup at the `lea`'s instruction offset; the
/// disp32 sits three bytes in (REX + opcode + modrm).
fn emit_imm_ext_code(
    code: &mut Vec<u8>,
    dst: Place,
    binding_idx: i64,
    plt_call_fixups: &mut Vec<PltCallFixup>,
    imports: &super::ResolvedImports,
    frame: Frame,
) -> bool {
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("ImmExtCode: dst not int reg / spill");
    };
    let Some(import_index) = imports.index_of_binding(binding_idx) else {
        return fail("ImmExtCode: binding index has no resolved import");
    };
    plt_call_fixups.push(PltCallFixup {
        instr_offset: code.len(),
        import_index,
        is_tail: false,
        is_addr: true,
    });
    super::encode::emit_lea_r_rip32(code, rd, 0);
    spill_dst_to_slot(code, dst, rd, frame);
    true
}

/// One load / store pair of `width` bytes (8, 4, 2 or 1) moving
/// `[src + disp]` to `[dst + disp]` through `temp`.
fn emit_copy_unit(code: &mut Vec<u8>, width: u32, temp: Reg, src: Reg, dst: Reg, disp: i32) {
    emit_load_unit(code, width, temp, src, disp);
    emit_store_unit(code, width, dst, disp, temp);
}

/// Store the low `width` bytes (8, 4, 2 or 1) of `src` to
/// `[base + disp]`.
fn emit_store_unit(code: &mut Vec<u8>, width: u32, base: Reg, disp: i32, src: Reg) {
    match width {
        8 => emit_mov_mem_r(code, base, disp, src),
        4 => super::encode::emit_mov_mem32_r(code, base, disp, src),
        2 => super::encode::emit_mov_mem16_r(code, base, disp, src),
        _ => super::encode::emit_mov_mem8_r(code, base, disp, src),
    }
}

/// Zero-extending load of `width` bytes (8, 4, 2 or 1) from
/// `[base + disp]` into `dst`.
fn emit_load_unit(code: &mut Vec<u8>, width: u32, dst: Reg, base: Reg, disp: i32) {
    match width {
        8 => emit_mov_r_mem(code, dst, base, disp),
        4 => super::encode::emit_mov_r32_mem(code, dst, base, disp),
        2 => super::encode::emit_movzx_r_mem16(code, dst, base, disp),
        _ => super::encode::emit_movzx_r_mem8(code, dst, base, disp),
    }
}

/// Load `width` bytes at `[base + disp]` into the integer register
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
    disp: i32,
    width: u32,
    align: u32,
    strict_align: bool,
    tmp: Reg,
) {
    let off = disp.max(0) as u32;
    for (i, (o, w)) in super::super::access_pieces(off, width, align, strict_align).enumerate() {
        let at = disp + (o - off) as i32;
        if i == 0 {
            emit_load_unit(code, w, dst, base, at);
            continue;
        }
        debug_assert!(dst.0 != base.0 && tmp.0 != base.0 && tmp.0 != dst.0);
        emit_load_unit(code, w, tmp, base, at);
        emit_shift_ri(code, Mnem::Shl, 8, tmp, ((o - off) * 8) as u8);
        emit_rr(code, Mnem::Or, 8, dst, tmp);
    }
}

/// As [`emit_agg_load_int`] with an SSE register destination: the
/// eightbyte composes in `tmp` and moves across with `movq`. The
/// composition's second register is borrowed from the stack, the
/// marshal having no third free scratch; nothing between the push and
/// the pop addresses `rsp`. `base` and `tmp` are the marshal's
/// reserved scratches or argument registers, never `rax`.
fn emit_agg_load_sse(
    code: &mut Vec<u8>,
    dst: Reg,
    base: Reg,
    disp: i32,
    align: u32,
    strict_align: bool,
    tmp: Reg,
) {
    if super::super::access_unit(disp.max(0) as u32, 8, align, strict_align) == 8 {
        emit_movsd_xmm_mem(code, dst, base, disp);
        return;
    }
    debug_assert!(base.0 != Reg::RAX.0 && tmp.0 != Reg::RAX.0);
    emit_push_r(code, Reg::RAX);
    emit_agg_load_int(code, tmp, base, disp, 8, align, strict_align, Reg::RAX);
    super::encode::emit_movq_xmm_r(code, dst, tmp);
    emit_pop_r(code, Reg::RAX);
}

/// Alignment a scalar access must respect, or `None` when it may keep
/// its natural width: an access carries a bound only where the walker
/// proved one, and only `-mstrict-align` acts on it.
fn narrow_bound(align: u8, abi: super::Abi) -> Option<u32> {
    (abi.strict_align && align != 0).then_some(align as u32)
}

/// Register a narrowed scalar access borrows for its piece temp. Each
/// candidate is in the allocator's caller-saved bank, so it is pushed
/// and popped across the sequence; nothing in between addresses `rsp`.
/// Mirrors the reservation `emit_mcpy` makes.
fn narrow_borrow(avoid: &[u8]) -> Reg {
    for cand in [Reg::RAX, Reg::RCX, Reg::RDX, Reg::RSI, Reg::RDI] {
        if !avoid.contains(&cand.0) {
            return cand;
        }
    }
    unreachable!("narrow access: no free borrow register")
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

/// Compose `width` bytes at `[base + disp]`, whose address is proven
/// only `align`-aligned, into SCRATCH_R11 and return it. The caller
/// must not have `base` in r11.
fn emit_narrow_compose(
    code: &mut Vec<u8>,
    base: Reg,
    disp: i32,
    width: u32,
    align: u32,
    avoid: &[u8],
) -> Reg {
    let acc = SCRATCH_R11;
    let mut blocked = alloc::vec![base.0, acc.0];
    blocked.extend_from_slice(avoid);
    let tmp = narrow_borrow(&blocked);
    emit_push_r(code, tmp);
    emit_agg_load_int(code, acc, base, disp, width, align, true, tmp);
    emit_pop_r(code, tmp);
    acc
}

/// Lower an integer load bounded by `align` into `rd`, sign-extending
/// the composed value when the kind is signed.
fn emit_narrow_load(code: &mut Vec<u8>, rd: Reg, base: Reg, disp: i32, kind: LoadKind, align: u32) {
    let (width, signed) = int_load_shape(kind);
    let acc = emit_narrow_compose(code, base, disp, width, align, &[rd.0]);
    match (signed, width) {
        (true, 4) => super::encode::emit_movsxd_r_r(code, rd, acc),
        (true, 2) => super::encode::emit_movsx_r_r16(code, rd, acc),
        (true, 1) => super::encode::emit_movsx_r_r8(code, rd, acc),
        _ if rd.0 != acc.0 => emit_mov_rr(code, rd, acc),
        _ => {}
    }
}

/// Store companion to [`emit_narrow_load`]: write the low `width`
/// bytes of `rs` to `[base + disp]` in `align`-wide pieces.
fn emit_narrow_store(code: &mut Vec<u8>, rs: Reg, base: Reg, disp: i32, width: u32, align: u32) {
    let tmp = narrow_borrow(&[base.0, rs.0]);
    emit_push_r(code, tmp);
    let off = disp.max(0) as u32;
    for (i, (o, w)) in super::super::access_pieces(off, width, align, true).enumerate() {
        let at = disp + (o - off) as i32;
        let src = if i == 0 {
            rs
        } else {
            emit_mov_rr(code, tmp, rs);
            emit_shift_ri(code, Mnem::Shr, 8, tmp, ((o - off) * 8) as u8);
            tmp
        };
        emit_store_unit(code, w, base, at, src);
    }
    emit_pop_r(code, tmp);
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
) -> bool {
    if size < 0 {
        return fail("Mcpy: negative size");
    }
    let dst_in = place_of(alloc, dst_val);
    let src_in = place_of(alloc, src_val);
    // Materialise both bases into reserved scratches. SCRATCH_R10 and
    // SCRATCH_R11 sit outside both allocator pools, so loading a base
    // into either cannot clobber a live SSA value. rcx must not be used
    // here: it is in the LinuxX64 `caller_gprs` pool, so under raised
    // register pressure the allocator parks SSA values there (e.g. a
    // `context` pointer threaded into a later call argument), and a
    // materialise into rcx would overwrite that value.
    let Some(dst_r) = materialize_int(code, dst_in, SCRATCH_R10, frame) else {
        return fail("Mcpy: dst base not int reg / spill");
    };
    let src_scratch = if dst_r.0 == SCRATCH_R10.0 {
        SCRATCH_R11
    } else {
        SCRATCH_R10
    };
    let Some(src_r) = materialize_int(code, src_in, src_scratch, frame) else {
        return fail("Mcpy: src base not int reg / spill");
    };
    // Pick a per-iteration temp distinct from both bases, then save /
    // restore it across the copy. rax, rcx and rdx are in the
    // allocator's caller_gprs pool, so the prologue may have parked a
    // live value in the chosen one; a push/pop pair around the loop
    // preserves it. (r10 / r11 are the bases' reserved scratch and are
    // not candidates here.)
    let temp = if dst_r.0 != Reg::RAX.0 && src_r.0 != Reg::RAX.0 {
        Reg::RAX
    } else if dst_r.0 != Reg::RCX.0 && src_r.0 != Reg::RCX.0 {
        Reg::RCX
    } else {
        // rax and rcx are taken by the bases (one of which may sit in
        // r10 / r11); fall back to rdx, also in the caller pool.
        Reg::RDX
    };
    emit_push_r(code, temp);
    let bytes = size as u32;
    let unit = super::super::access_chunk(align, strict_align, 8);
    let words = bytes / unit;
    for w in 0..words {
        // After push, [base + off] still resolves correctly
        // because the bases are register-typed (not sp-relative).
        let off = (w * unit) as i32;
        emit_copy_unit(code, unit, temp, src_r, dst_r, off);
    }
    let tail_start = words * unit;
    for i in 0..(bytes - tail_start) {
        let off = (tail_start + i) as i32;
        super::encode::emit_movzx_r_mem8(code, temp, src_r, off);
        super::encode::emit_mov_mem8_r(code, dst_r, off, temp);
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

/// Write the result `src` of an atomic op into the inst's `dst`
/// `Place`. Runs after the borrowed registers are restored so the
/// spill slot's rsp offset is the unshifted one.
fn write_atomic_result(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    super::ssa::emit_common::write_atomic_result(
        &super::ssa::emit_common::X64Backend,
        code,
        dst,
        src.0,
        frame,
    );
}

/// Load the low `width` bytes of `[base]` into `dst`, zero-extended. A
/// width-sized access is required so the atomic object's footprint is
/// not over-read past its end (a 1/2/4-byte `_Atomic` may sit at a page
/// boundary) and so the prior value carries no high-byte residue.
fn emit_atomic_load(code: &mut Vec<u8>, dst: Reg, base: Reg, width: u8) {
    match width {
        1 => super::encode::emit_movzx_r_mem8(code, dst, base, 0),
        2 => super::encode::emit_movzx_r_mem16(code, dst, base, 0),
        4 => super::encode::emit_mov_r32_mem(code, dst, base, 0),
        _ => emit_mov_r_mem(code, dst, base, 0),
    }
}

/// Store the low `width` bytes of `src` to `[base]`; the companion to
/// [`emit_atomic_load`] for the compare-exchange expected-operand writeback.
fn emit_atomic_store(code: &mut Vec<u8>, base: Reg, src: Reg, width: u8) {
    match width {
        1 => super::encode::emit_mov_mem_r8(code, base, 0, src),
        2 => super::encode::emit_mov_mem_r16(code, base, 0, src),
        4 => super::encode::emit_mov_mem_r32(code, base, 0, src),
        _ => emit_mov_mem_r(code, base, 0, src),
    }
}

/// Force an operand's value into a designated scratch register. The
/// operand may already sit in its allocator register; `materialize`
/// returns that register, and we copy it into `scratch` so the
/// caller can clobber the source register afterwards. `sp_shift`
/// accounts for the borrowed registers already pushed.
fn operand_into(
    code: &mut Vec<u8>,
    value: super::super::ir::ValueId,
    scratch: Reg,
    frame: Frame,
    sp_shift: u32,
    alloc: &Allocation,
) -> Option<Reg> {
    let place = place_of(alloc, value);
    let r = materialize_int_shifted(code, place, scratch, frame, sp_shift)?;
    if r.0 != scratch.0 {
        emit_mov_rr(code, scratch, r);
    }
    Some(scratch)
}

/// C11 7.17.7.2-7.17.7.5 atomic read-modify-write. Lowers to a genuine
/// atomic instruction (Intel SDM Vol.2): `XCHG` for exchange, `LOCK
/// XADD` for add / sub (negating the operand for sub), and a `LOCK
/// CMPXCHG` retry loop for the bitwise operators (x86 has no
/// fetch-and-return-old form for AND / OR / XOR). The defined value is
/// the object's prior contents. The address rides SCRATCH_R11 and the
/// operand SCRATCH_R10, both outside the allocator's register banks;
/// RAX and a loop temp are borrowed via push / pop so a value the
/// allocator parked there survives.
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
) -> bool {
    use super::super::ir::AtomicRmwOp as Op;
    let a = SCRATCH_R11;
    let val = SCRATCH_R10;
    match op {
        Op::Xchg => {
            // No RAX involved: XCHG with a memory operand is implicitly
            // locked. Operands ride the reserved scratches; rsp stable.
            if operand_into(code, addr, a, frame, 0, alloc).is_none()
                || operand_into(code, value, val, frame, 0, alloc).is_none()
            {
                return fail("AtomicRmw: operand not int reg / spill");
            }
            emit_xchg_mem_r(code, a, 0, val, width);
            write_atomic_result(code, dst, val, frame);
            true
        }
        Op::Add | Op::Sub => {
            emit_push_r(code, Reg::RAX);
            if operand_into(code, addr, a, frame, 8, alloc).is_none()
                || operand_into(code, value, val, frame, 8, alloc).is_none()
            {
                return fail("AtomicRmw: operand not int reg / spill");
            }
            emit_mov_rr(code, Reg::RAX, val);
            if matches!(op, Op::Sub) {
                emit_unary_r(code, Mnem::Neg, 8, Reg::RAX);
            }
            emit_lock_xadd_mem_r(code, a, 0, Reg::RAX, width);
            // RAX now holds the prior contents; stash it before the pop.
            emit_mov_rr(code, val, Reg::RAX);
            emit_pop_r(code, Reg::RAX);
            write_atomic_result(code, dst, val, frame);
            true
        }
        Op::And | Op::Or | Op::Xor => {
            // CMPXCHG retry: load the current value into RAX, compute the
            // new value in a temp, and conditionally publish it; repeat
            // until the store succeeds (ZF set by CMPXCHG).
            let temp = Reg::RCX;
            emit_push_r(code, Reg::RAX);
            emit_push_r(code, temp);
            if operand_into(code, addr, a, frame, 16, alloc).is_none()
                || operand_into(code, value, val, frame, 16, alloc).is_none()
            {
                return fail("AtomicRmw: operand not int reg / spill");
            }
            emit_atomic_load(code, Reg::RAX, a, width);
            let loop_start = code.len();
            emit_mov_rr(code, temp, Reg::RAX);
            match op {
                Op::And => emit_rr(code, Mnem::And, 8, temp, val),
                Op::Or => emit_rr(code, Mnem::Or, 8, temp, val),
                Op::Xor => emit_rr(code, Mnem::Xor, 8, temp, val),
                _ => unreachable!(),
            }
            emit_lock_cmpxchg_mem_r(code, a, 0, temp, width);
            // Branch back when the store lost the race (ZF == 0). The
            // rel8 field is measured from the byte after the 2-byte Jcc.
            let rel = (loop_start as i64) - (code.len() as i64 + 2);
            emit_jcc_rel8(code, Cc::Ne, rel as i8);
            emit_mov_rr(code, val, Reg::RAX);
            emit_pop_r(code, temp);
            emit_pop_r(code, Reg::RAX);
            write_atomic_result(code, dst, val, frame);
            true
        }
    }
}

/// C11 7.17.7.4 atomic compare-and-exchange. Lowers to `LOCK CMPXCHG`
/// (Intel SDM Vol.2): RAX is loaded with `*expected`; on a match the
/// store publishes `desired` and the result is 1, otherwise the
/// current contents are written back into `*expected` and the result
/// is 0. The success flag is read from the CMPXCHG ZF (a `mov` does
/// not disturb the flags, so the post-branch SETcc is correct).
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
) -> bool {
    let a = SCRATCH_R11;
    let des = SCRATCH_R10;
    let exp = Reg::RCX;
    emit_push_r(code, Reg::RAX);
    emit_push_r(code, exp);
    // Materialise addr / desired before clobbering RCX with the
    // expected pointer (their Places may name RCX).
    if operand_into(code, addr, a, frame, 16, alloc).is_none()
        || operand_into(code, desired, des, frame, 16, alloc).is_none()
        || operand_into(code, expected_addr, exp, frame, 16, alloc).is_none()
    {
        return fail("AtomicCas: operand not int reg / spill");
    }
    emit_atomic_load(code, Reg::RAX, exp, width);
    emit_lock_cmpxchg_mem_r(code, a, 0, des, width);
    // On failure (ZF == 0) write the observed value back to *expected.
    // Build the conditional body separately to size the forward Jcc.
    let mut fail_path = Vec::new();
    emit_atomic_store(&mut fail_path, exp, Reg::RAX, width);
    emit_jcc_rel8(code, Cc::E, fail_path.len() as i8);
    code.extend_from_slice(&fail_path);
    // Result = ZF from the CMPXCHG. Reuse `a` (addr no longer needed).
    emit_setcc_r8(code, Cc::E, a);
    emit_movzx_r_r8(code, a, a);
    emit_pop_r(code, exp);
    emit_pop_r(code, Reg::RAX);
    write_atomic_result(code, dst, a, frame);
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
///   * The function takes no `LocalAddr`, whether to a user local
///     (negative `off`) or a c5 cdecl param cell (`off >= 2`): such an
///     address could have been passed to an earlier callee, and the
///     param cells are overwritten by the tail-callee's own prologue,
///     so tearing down the frame before the jmp would make it dangle.
///
/// Callee-saved register use is allowed: the marshalled arguments ride
/// the caller-saved arg-register window, which is disjoint from
/// `alloc.gpr_used` (only callee-saved regs land there), so the
/// epilogue's per-reg restores cannot clobber them (see
/// `emit_tail_call`).
fn detect_tail_call<'a>(
    func: &'a FunctionSsa,
    block: &super::super::ir::Block,
    abi: super::Abi,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    ret_tags: &alloc::collections::BTreeMap<usize, i64>,
    target: Target,
) -> Option<(usize, usize, &'a [u32])> {
    let Terminator::Return(v) = block.terminator else {
        return None;
    };
    if v == super::super::ir::NO_VALUE {
        return None;
    }
    // The returned value must be this block's last instruction. `v + 1 ==
    // end` alone also holds for an empty block whose range starts right
    // after another block's trailing call: that call is emitted with its own
    // block, so converting here would call the callee and then jump into it
    // again with whatever the intervening code left in the argument
    // registers.
    if v < block.inst_range.start || v + 1 != block.inst_range.end {
        return None;
    }
    let (target_pc, args, arg_aggs) = match &func.insts[v as usize] {
        Inst::Call {
            target_pc,
            args,
            arg_aggs,
            ..
        } => (*target_pc, args.as_slice(), arg_aggs.as_slice()),
        _ => return None,
    };
    if args.len() > abi.int_arg_regs.len() {
        return None;
    }
    // A by-value aggregate argument is marshalled into one or two
    // argument registers loaded from its source address (System V AMD64
    // 3.2.3); the tail-call path plans with the scalar `plan_call_args`,
    // which would instead pass the address as a single pointer. Fall
    // back to the regular call-and-return path, which honours the
    // aggregate placement.
    if arg_aggs.iter().any(Option::is_some) {
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
    // The callee's epilogue extends a sub-word integer return per its
    // own declared type, and the jmp skips this function's return
    // staging, so the two extension recipes must agree (an `int`
    // callee leaves a sign-extended accumulator that an `unsigned`
    // caller's contract does not allow). An unknown callee -- a
    // cross-unit placeholder pc -- has no recorded contract; keep the
    // regular call-then-return path.
    let &callee_tag = ret_tags.get(&target_pc)?;
    if super::return_extension(callee_tag, target)
        != super::return_extension(func.ret_type_tag, target)
    {
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
    // An alloca / VLA frame keeps its runtime allocations live until
    // the function returns; a tail jmp would tear them down under the
    // callee (same reason `LocalAddr` disqualifies above).
    if super::ssa::emit_common::uses_dynamic_alloca(func) {
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
    fp_arg_mask: u32,
) -> bool {
    debug_assert!(
        !frame.dynamic_sp,
        "detect_tail_call rejects dynamic-sp frames"
    );
    // Marshal arguments into their ABI-prescribed registers. The
    // caller-saved arg-reg window is disjoint from `alloc.gpr_used`
    // (only callee-saved regs land there), so the epilogue's
    // restores below cannot clobber the marshalled values.
    let mut plan = super::plan_call_args(args.len(), args.len(), fp_arg_mask, abi);
    // `detect_tail_call` rejects arg counts above `int_arg_regs.len()`,
    // so no `Stack(offset)` placements ever reach here (FP args ride
    // the independent FP bank and never overflow with <= 6 total args).
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
    // marshal_args adds plan.scratch_bytes to every spill-slot rsp
    // offset because regular call sites do `sub rsp, scratch_bytes`
    // ahead of the marshal to set up the Win64 shadow-space window.
    // The tail-call path doesn't allocate that window (the callee
    // inherits the slot from our caller's frame), so rsp has not
    // moved -- any spill load must use the natural slot offset.
    // Clear scratch_bytes to suppress the marshal's sp_shift add.
    plan.scratch_bytes = 0;
    if !marshal_args(code, &plan, args, alloc, frame, abi, "TailCall") {
        return false;
    }
    // Mirror emit_return's epilogue, omitting the return-value
    // staging (the callee's own `ret` carries the value back). The
    // marshalled args ride caller-saved arg registers, disjoint from the
    // callee-saved GPRs and the non-volatile xmm scratch restored here.
    restore_callee_saved(code, alloc, frame);
    if !is_full_leaf(func, frame, alloc, abi) {
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
        kind: super::encode::BranchKind::Jmp,
    });
    super::encode::emit_jmp_rel32(code, 0);
    true
}

fn emit_return(
    code: &mut Vec<u8>,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
    func: &FunctionSsa,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) {
    // Staging through rcx is needed only when the return value
    // itself lives in a callee-saved register the epilogue is about
    // to restore (e.g. rbx, r12): the restore would overwrite the
    // source before it reaches rax. rcx is caller-saved and never in
    // `gpr_used`, so it survives the restore. In every other case --
    // the value already in rax, in a caller-saved register, or in a
    // spill slot the restore does not touch -- the epilogue restores
    // first, then places the value into rax directly (`mov rax, src`,
    // or nothing when src already lives in rax). FP returns ride xmm0
    // directly;
    // xmm0 is outside the GPR restore loop, but the integer
    // mirror into rax happens after the restore so the bit
    // pattern is available to int-shaped callers.
    let return_place = if value != super::super::ir::NO_VALUE {
        place_of(alloc, value)
    } else {
        Place::None
    };
    // Host-ABI aggregate return (System V AMD64 3.2.3): `value` is the
    // struct's address. A <= 16-byte integer aggregate returns its
    // eightbytes in rax:rdx (x86_64 has no x8 indirect-result path --
    // the > 16-byte case keeps the out-pointer convention, so `ret_agg`
    // is only ever set here for the register case). Stage the address
    // through rcx (caller-saved, untouched by the callee-saved restore)
    // before the restore, then load the eightbytes after it.
    if let Some(ai) = func.ret_agg {
        let desc = &func.agg_descs[ai as usize];
        let eb_classes = match super::abi_classify::classify_aggregate(
            desc.size,
            desc.align,
            &desc.fields,
            abi,
            true,
        ) {
            super::abi_classify::AggClass::Regs(c) => c,
            _ => alloc::vec::Vec::new(),
        };
        match return_place {
            Place::IntReg(r) => {
                if r != Reg::RCX.0 {
                    emit_mov_rr(code, Reg::RCX, Reg(r));
                }
            }
            Place::Spill(slot) => {
                let (sb, sp_off) = spill_slot_addr(frame, slot);
                super::encode::emit_mov_r_mem(code, Reg::RCX, sb, sp_off);
            }
            _ => {}
        }
        restore_dynamic_sp(code, frame);
        // Restore callee-saved GPRs and saved non-volatile xmm scratch
        // (the prologue places xmm at the bottom, GPRs above by
        // saved_fpr_bytes). rcx already holds the struct address and is
        // caller-saved, so the restore does not disturb it; the return
        // eightbytes load into the volatile rax/rdx/xmm0/xmm1 below.
        restore_callee_saved(code, alloc, frame);
        // Place each eightbyte in its bank: System V returns SSE eightbytes
        // in xmm0/xmm1 and INTEGER eightbytes in rax/rdx, each in order.
        let int_ret = [Reg::RAX, Reg::RDX];
        let mut int_i = 0usize;
        let mut sse_i = 0u8;
        for (k, class) in eb_classes.iter().enumerate() {
            let off = (k as i32) * 8;
            if matches!(class, super::abi_classify::RegClass::Sse) {
                emit_agg_load_sse(
                    code,
                    Reg(Reg::XMM0.0 + sse_i),
                    Reg::RCX,
                    off,
                    desc.align,
                    abi.strict_align,
                    SCRATCH_R10,
                );
                sse_i += 1;
            } else {
                emit_agg_load_int(
                    code,
                    int_ret[int_i],
                    Reg::RCX,
                    off,
                    8,
                    desc.align,
                    abi.strict_align,
                    SCRATCH_R10,
                );
                int_i += 1;
            }
        }
        emit_epilogue_ret(code, func, frame, alloc, abi, extern_sites);
        return;
    }
    // A floating-point scalar return rides xmm0 (C99 6.2.5p10). The
    // declared return type is authoritative: a bare FP constant
    // materializes as an integer immediate in a GPR, and any value whose
    // producing instruction is integer-classed lands in a GPR, yet an
    // `fp_return` caller reads xmm0. `materialize_fp` reinterprets the
    // GPR / spill bit pattern into an xmm via `movq` / `movsd`.
    let return_is_fp = func.ret_is_fp
        || matches!(return_place, Place::FpReg(_))
        || (value != super::super::ir::NO_VALUE
            && (value as usize) < func.insts.len()
            && super::ssa::reg_alloc::produces_fp_result(&func.insts[value as usize]));
    let needs_staging = matches!(return_place, Place::IntReg(r) if alloc.gpr_used.contains(&r));
    // An integer return value sitting in a callee-saved register goes
    // straight to rax BEFORE the restore loop: rax is caller-saved (never
    // in gpr_used), so the restore cannot clobber it and no post-restore
    // move is needed -- one `mov` instead of staging through rcx and
    // copying back. FP returns keep the rcx staging below so the xmm0 path
    // and the int-shaped-caller mirror are undisturbed.
    let staged_rax = needs_staging && !return_is_fp;
    if staged_rax
        && let Place::IntReg(r) = return_place
        && r != Reg::RAX.0
    {
        emit_mov_rr(code, Reg::RAX, Reg(r));
    }
    let staged_int = if needs_staging && !staged_rax {
        match return_place {
            Place::IntReg(r) if r != Reg::RCX.0 => {
                emit_mov_rr(code, Reg::RCX, Reg(r));
                true
            }
            Place::IntReg(_) => true,
            Place::Spill(slot) => {
                let (sb, sp_off) = spill_slot_addr(frame, slot);
                super::encode::emit_mov_r_mem(code, Reg::RCX, sb, sp_off);
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
    // Restore callee-saved GPRs and saved non-volatile xmm scratch
    // (mirror of the prologue's saves: xmm at the bottom, GPRs above).
    restore_dynamic_sp(code, frame);
    restore_callee_saved(code, alloc, frame);
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
                let (sb, sp_off) = spill_slot_addr(frame, slot);
                super::encode::emit_mov_r_mem(code, Reg::RAX, sb, sp_off);
            }
            _ => {}
        }
    }
    // A floating-point return value is delivered in xmm0 only (SysV
    // AMD64 / Win64: scalar floating returns in xmm0). The receiving
    // call site is FP-classed (`Inst::Call::fp_return`) and reads
    // xmm0, so no rax mirror is emitted.
    emit_epilogue_ret(code, func, frame, alloc, abi, extern_sites);
}

/// Frame teardown + `ret` (callee-saved restores already ran): drop
/// the frame, pop rbp, and drop the prologue's c5 cdecl parameter
/// cells, parking the return address in r11 across the drop.
/// `frame.param_spill_bytes` is the single source of truth both the
/// prologue and this epilogue read, so the two sides agree across
/// every prologue branch (variadic, host-stack overflow,
/// ParamRef-elided, n_params == 0). A full leaf emitted no save and
/// no frame, so only the `ret` is needed.
fn emit_epilogue_ret(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    frame: Frame,
    alloc: &Allocation,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) {
    if !is_full_leaf(func, frame, alloc, abi) {
        if frame.frame_bytes > 0 {
            emit_add_rsp_imm32(code, frame.frame_bytes);
        }
        emit_pop_r(code, Reg::RBP);
        if frame.param_spill_bytes > 0 {
            emit_pop_r(code, Reg::R11);
            emit_add_rsp_imm32(code, frame.param_spill_bytes);
            emit_push_r(code, Reg::R11);
        }
    }
    emit_hardened_ret(code, abi, extern_sites);
}

/// Branch to a symbol this unit does not define: `E8`/`E9 rel32` with a
/// zero displacement plus the by-name call site the writer turns into a
/// relocation against an undefined symbol.
fn emit_extern_branch(
    code: &mut Vec<u8>,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    symbol: &str,
    is_call: bool,
) {
    extern_sites.push(super::UserExternCallSite {
        instr_offset: code.len(),
        symbol_name: symbol.into(),
        is_tail: !is_call,
    });
    if is_call {
        super::encode::emit_call_rel32(code, 0);
    } else {
        super::encode::emit_jmp_rel32(code, 0);
    }
}

/// Function return. `-mfunction-return=thunk-extern` replaces `ret` with
/// a jump to the external return thunk, which returns itself; the
/// straight-line-speculation trap then has no `ret` to guard.
fn emit_hardened_ret(
    code: &mut Vec<u8>,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) {
    if abi.hardening.function_return_thunk {
        emit_extern_branch(
            code,
            extern_sites,
            super::encode::RETURN_THUNK_SYMBOL,
            false,
        );
        return;
    }
    emit_ret(code);
    if abi.hardening.sls_return {
        super::encode::emit_int3(code);
    }
}

/// `mov %reg, (%rsp)`: overwrite the return address the retpoline's
/// `call` pushed with the real branch target, so its `ret` transfers
/// there with the return predictor pinned to the capture loop.
fn emit_mov_r_to_rsp_slot(code: &mut Vec<u8>, target: Reg) {
    code.push(if target.0 >= 8 { 0x4C } else { 0x48 });
    code.push(0x89);
    code.push(0x04 | ((target.0 & 7) << 3));
    code.push(0x24);
}

/// The retpoline capture: `pause; lfence; jmp .-7`, then the slot
/// overwrite and `ret`. Entered by a `call` whose displacement lands
/// on the `mov`; the pushed return address keeps speculation in the
/// loop. Mirrors gcc's `-mindirect-branch=thunk-inline` body.
fn emit_retpoline_capture(code: &mut Vec<u8>, target: Reg) {
    code.extend_from_slice(&[0xF3, 0x90]); // pause
    code.extend_from_slice(&[0x0F, 0xAE, 0xE8]); // lfence
    code.extend_from_slice(&[0xEB, 0xF9]); // jmp back over both
    emit_mov_r_to_rsp_slot(code, target);
    code.push(0xC3); // ret
}

/// Indirect call through `target`. `-mindirect-branch=thunk-extern`
/// replaces `call *%reg` with a direct call to the register's thunk;
/// `thunk-inline` embeds the retpoline (gcc's shape: hop over the
/// 17-byte thunk body, then call into it, so the continuation follows
/// the site). A call has an architectural successor either way, so
/// `-mharden-sls=` places no trap here.
fn emit_hardened_call_r(
    code: &mut Vec<u8>,
    target: Reg,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) {
    use crate::c5::codegen::IndirectBranch;
    match abi.hardening.indirect_branch {
        IndirectBranch::ThunkExtern => {
            let symbol = super::encode::indirect_thunk_symbol(target);
            emit_extern_branch(code, extern_sites, symbol, true);
        }
        IndirectBranch::ThunkInline => {
            code.extend_from_slice(&[0xEB, 0x11]); // jmp over the thunk body
            code.extend_from_slice(&[0xE8, 0x07, 0x00, 0x00, 0x00]); // call the capture
            emit_retpoline_capture(code, target);
            // call back into the thunk head; the pushed address is the
            // continuation after this site.
            code.extend_from_slice(&[0xE8, 0xEA, 0xFF, 0xFF, 0xFF]);
        }
        IndirectBranch::Keep => super::encode::emit_call_r(code, target),
    }
}

/// Indirect jump through `target` (computed goto, switch-table
/// dispatch), routed through the register's thunk under
/// `-mindirect-branch=thunk-extern` and embedded as the retpoline
/// sequence under `thunk-inline`; `-mharden-sls=indirect-jmp` traps
/// after the transfer in every form.
fn emit_hardened_jmp_r(
    code: &mut Vec<u8>,
    target: Reg,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) {
    use crate::c5::codegen::IndirectBranch;
    match abi.hardening.indirect_branch {
        IndirectBranch::ThunkExtern => {
            let symbol = super::encode::indirect_thunk_symbol(target);
            emit_extern_branch(code, extern_sites, symbol, false);
        }
        IndirectBranch::ThunkInline => {
            code.extend_from_slice(&[0xE8, 0x07, 0x00, 0x00, 0x00]); // call the capture
            emit_retpoline_capture(code, target);
        }
        IndirectBranch::Keep => super::encode::emit_jmp_r(code, target),
    }
    if abi.hardening.sls_indirect_jmp {
        super::encode::emit_int3(code);
    }
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
        assert_eq!(asm_scratch_bytes(&asm_func("/* note */ ;")), 0);
        assert!(asm_scratch_bytes(&asm_func("nop")) > 0);
    }
}

#[cfg(test)]
mod scratch_picker_tests {
    use super::*;

    #[test]
    fn pick_returns_some_when_no_operands() {
        // rd = rdi (outside the pool) and no operands: the helper
        // returns the first preference (rax) per the
        // CALLER_SAVED_INT_SCRATCHES ordering [0, 1, 2, 8, 9].
        assert_eq!(pick_caller_saved_scratch(Reg(7), &[]), Some(Reg(0)));
    }

    #[test]
    fn pick_skips_rd() {
        // rd = rax forces the helper past the first preference;
        // the next entry (rcx) wins.
        assert_eq!(pick_caller_saved_scratch(Reg(0), &[]), Some(Reg(1)));
    }

    #[test]
    fn pick_skips_operand_regs() {
        // rd = rax, operands hold rcx (1) -> rdx (2) wins.
        assert_eq!(pick_caller_saved_scratch(Reg(0), &[Reg(1)]), Some(Reg(2)));
    }

    #[test]
    fn pick_returns_none_when_pool_exhausted() {
        // The candidate pool is CALLER_SAVED_INT_SCRATCHES = [0, 1, 2,
        // 8, 9]. Excluding all five via rd + 4 operands forces the
        // fallthrough. The helper must return None so callers bail
        // rather than fall through to a callee-saved or reserved
        // scratch register.
        let rd = Reg(0);
        let operands = [Reg(1), Reg(2), Reg(8), Reg(9)];
        assert_eq!(pick_caller_saved_scratch(rd, &operands), None);
    }

    #[test]
    fn pick_returns_none_when_every_candidate_in_operands() {
        // rd is outside the pool entirely (rdi = 7); every entry of
        // CALLER_SAVED_INT_SCRATCHES is in the operand list. Helper
        // must return None.
        let rd = Reg(7);
        let operands = [Reg(0), Reg(1), Reg(2), Reg(8), Reg(9)];
        assert_eq!(pick_caller_saved_scratch(rd, &operands), None);
    }
}

#[cfg(test)]
mod relax_branches_tests {
    use super::*;

    // jmp form: long_size 5; jcc form: long_size 6. Short form is 2
    // bytes; displacement is measured from the byte after the 2-byte
    // short instruction to the target offset.

    #[test]
    fn near_forward_branch_shortens() {
        // Single jmp at offset 0 to a block 100 bytes ahead: short rel
        // = 100 - 2 = 98, within i8.
        let short = relax_branches(&[(0, 5, 1, false)], &[0, 100]);
        assert_eq!(short, vec![true]);
    }

    #[test]
    fn far_forward_branch_stays_long() {
        // Target 200 bytes ahead: short rel = 198, out of i8 range.
        let short = relax_branches(&[(0, 5, 1, false)], &[0, 200]);
        assert_eq!(short, vec![false]);
    }

    #[test]
    fn backward_branch_shortens() {
        // jmp at offset 50 back to offset 0: short rel = 0 - 52 = -52.
        let short = relax_branches(&[(50, 5, 0, false)], &[0, 50]);
        assert_eq!(short, vec![true]);
    }

    #[test]
    fn forward_boundary_127_shortens_128_does_not() {
        // Short instr ends at offset 2; target 129 -> rel 127 (fits),
        // target 130 -> rel 128 (does not).
        assert_eq!(relax_branches(&[(0, 5, 1, false)], &[0, 129]), vec![true]);
        assert_eq!(relax_branches(&[(0, 5, 1, false)], &[0, 130]), vec![false]);
    }

    #[test]
    fn cascade_inner_shortening_brings_outer_into_range() {
        // branch0 (offset 0) targets block 2 at 132; branch1 (offset 5)
        // targets block 1 at 10 and shortens first (rel 3), removing 3
        // bytes before branch0's target. branch0's short rel then
        // becomes 132 - 3 - 2 = 127 -> fits. A single all-long pass
        // (rel 130) would have missed branch0.
        let short = relax_branches(&[(0, 5, 2, false), (5, 5, 1, false)], &[0, 10, 132]);
        assert_eq!(short, vec![true, true]);
        // One more byte of distance defeats the cascade for branch0.
        let short = relax_branches(&[(0, 5, 2, false), (5, 5, 1, false)], &[0, 10, 133]);
        assert_eq!(short, vec![false, true]);
    }

    #[test]
    fn pinned_branch_keeps_the_long_form() {
        // An inline-asm template branch is emitted before relaxation runs, so
        // it stays long however close its target is.
        let short = relax_branches(&[(0, 5, 1, true)], &[0, 10]);
        assert_eq!(short, vec![false]);
        // Its bytes still count for the branches around it.
        let short = relax_branches(&[(0, 5, 1, true), (5, 5, 2, false)], &[0, 10, 20]);
        assert_eq!(short, vec![false, true]);
    }

    #[test]
    fn jcc_long_size_six_removes_four_bytes() {
        // A shortened jcc removes 4 bytes (6 -> 2). Two jccs whose
        // combined 8-byte saving brings a third into range.
        // block layout: b0@0, b1@4, b2@8, b3@140.
        // branch0@0 -> b3(140): all-long rel 138; after the two inner
        // jccs shorten (save 8), rel = 140 - 8 - 2 = 130 -> still out.
        let short = relax_branches(
            &[(0, 6, 3, false), (8, 6, 1, false), (16, 6, 2, false)],
            &[0, 4, 8, 140],
        );
        assert!(short[1]);
        assert!(short[2]);
        assert!(!short[0]);
        // Pull the target in by 3 so the saving is enough: 134 - 8 - 2 = 124.
        let short = relax_branches(
            &[(0, 6, 3, false), (8, 6, 1, false), (16, 6, 2, false)],
            &[0, 4, 8, 134],
        );
        assert!(short[0]);
    }
}

#[cfg(test)]
mod code_mode_tests {
    use alloc::vec::Vec;

    /// Bytes a file-scope asm stream assembles to, in section order.
    fn assemble(text: &str) -> Vec<u8> {
        assemble_relocs(text).0
    }

    /// One relocation as `(offset, width, signed, symbol, addend)`.
    type Reloc = (u32, u8, bool, alloc::string::String, i64);

    /// Bytes plus the relocations left after the sections materialize --
    /// what the object writer receives, so a reference the layout resolves
    /// is folded away here as GNU as folds it. Offsets are within the
    /// concatenated sections, in section order.
    fn assemble_relocs(text: &str) -> (Vec<u8>, Vec<Reloc>) {
        use super::super::ssa::emit_common::{
            AsmComments, AsmSectionSink, AsmSectionTarget, materialize_file_asm,
            prepare_file_asm_text,
        };
        // The driver prepares the template (comment stripping, GNU as macro
        // and equate expansion) before the section parse reads it.
        let text = prepare_file_asm_text(text, AsmComments::X86).expect("prepares");
        let mut sink = AsmSectionSink::default();
        materialize_file_asm(
            &[text],
            false,
            AsmComments::X86,
            &|blocks| super::encode_x86_file_asm_section_code(blocks, crate::c5::ElfClass::Elf64),
            &mut sink,
        )
        .expect("assembles");
        let (mut out, mut rs) = (Vec::new(), Vec::new());
        for s in sink.iter() {
            for r in &s.relocs {
                let name = match &r.target {
                    AsmSectionTarget::Symbol(n) => n.clone(),
                    t => alloc::format!("{t:?}"),
                };
                rs.push((
                    r.offset + out.len() as u32,
                    r.width,
                    r.signed,
                    name,
                    r.addend,
                ));
            }
            out.extend_from_slice(&s.bytes);
        }
        (out, rs)
    }

    /// The diagnostic a stream the assembler rejects produces, from encoding
    /// or from the layout the sections materialize against.
    fn assemble_err(text: &str) -> alloc::string::String {
        use super::super::ssa::emit_common::{
            AsmComments, AsmSectionSink, materialize_file_asm, prepare_file_asm_text,
        };
        let text = prepare_file_asm_text(text, AsmComments::X86).expect("prepares");
        let mut sink = AsmSectionSink::default();
        materialize_file_asm(
            &[text],
            false,
            AsmComments::X86,
            &|blocks| super::encode_x86_file_asm_section_code(blocks, crate::c5::ElfClass::Elf64),
            &mut sink,
        )
        .expect_err("rejected")
    }

    /// A label difference is an absolute value in an immediate and in a
    /// memory displacement. GNU as fixes the field when the instruction is
    /// assembled, so a backward difference takes the narrow field and a
    /// forward one keeps the wide one. Bytes from GNU as 2.46.1.
    #[test]
    fn file_scope_x86_label_difference_operand_matches_gnu_as() {
        let (bytes, relocs) = assemble_relocs(
            ".pushsection .t,\"ax\"\n\
             1:\n\
             nop\n\
             2:\n\
             subl $(2b - 1b), %ebp\n\
             subl $(4f - 3f), %ebp\n\
             movl (2b - 1b)(%rax), %ebx\n\
             movl (4f - 3f)(%rax), %ecx\n\
             3:\n\
             nop\n\
             4:\n\
             nop\n\
             .popsection\n",
        );
        assert_eq!(
            bytes,
            alloc::vec![
                0x90, // nop
                0x83, 0xed, 0x01, // subl $1, %ebp        imm8, backward
                0x81, 0xed, 0x01, 0x00, 0x00, 0x00, // subl $1, %ebp  imm32, forward
                0x8b, 0x58, 0x01, // movl 1(%rax), %ebx   disp8, backward
                0x8b, 0x88, 0x01, 0x00, 0x00, 0x00, // movl 1(%rax), %ecx  disp32, forward
                0x90, 0x90,
            ]
        );
        assert!(
            relocs.is_empty(),
            "a folded difference relocates: {relocs:?}"
        );
    }

    /// A branch through a `.set` alias takes the location of the name the
    /// chain ends at and the binding of the name written: a local alias of a
    /// global resolves in place, a global or weak one keeps its relocation at
    /// the long form's width. A data field keeps the name written, which is
    /// what the kernel's `SYM_FUNC_ALIAS` + `EXPORT_SYMBOL` shape reads. Bytes
    /// from GNU as 2.46.1.
    #[test]
    fn file_scope_x86_branch_binds_as_the_alias_name_does() {
        let (bytes, relocs) = assemble_relocs(
            ".pushsection .t,\"ax\"\n\
             .globl gtgt\n\
             gtgt:\n\
             ret\n\
             .set la, gtgt\n\
             call la\n\
             jmp la\n\
             .globl ga\n\
             .set ga, gtgt\n\
             call ga\n\
             .weak wa\n\
             .set wa, gtgt\n\
             jmp wa\n\
             call gtgt\n\
             .popsection\n\
             .pushsection .d,\"a\"\n\
             .quad la\n\
             .popsection\n",
        );
        assert_eq!(
            bytes[..23],
            [
                0xc3, // ret
                0xe8, 0xfa, 0xff, 0xff, 0xff, // call la    local alias, in place
                0xeb, 0xf8, // jmp la     local alias, short in place
                0xe8, 0x00, 0x00, 0x00, 0x00, // call ga    global alias, relocated
                0xe9, 0x00, 0x00, 0x00, 0x00, // jmp wa     weak alias, long + relocated
                0xe8, 0x00, 0x00, 0x00, 0x00, // call gtgt
            ]
        );
        let sites: alloc::vec::Vec<(u32, &str, i64)> =
            relocs.iter().map(|r| (r.0, r.3.as_str(), r.4)).collect();
        assert_eq!(
            sites,
            [
                (9, "gtgt", -4),
                (14, "gtgt", -4),
                (19, "gtgt", -4),
                (23, "la", 0),
            ],
            "an instruction field names the chain end, a data field the name written"
        );
    }

    /// The two rules a `.set` alias answers to must agree: the binding the
    /// symbol table gives the name decides whether the link may rebind a
    /// reference to it, and a reference the link may rebind cannot reduce to a
    /// location of this unit. So where the chain ends at a name the link does
    /// not bind, a rebindable alias keeps its own relocation rather than the
    /// chain end, and a local one resolves in place. Relocations from GNU as
    /// 2.46.1 for the same source.
    #[test]
    fn a_rebindable_alias_of_a_local_target_keeps_its_relocation() {
        let (_, relocs) = assemble_relocs(
            ".pushsection .t,\"ax\"\n\
             base:\n\
             ret\n\
             t:\n\
             ret\n\
             .set la, t\n\
             call la\n\
             .globl ga\n\
             .set ga, t\n\
             call ga\n\
             .weak wa\n\
             .set wa, t\n\
             call wa\n\
             .popsection\n",
        );
        let sites: alloc::vec::Vec<(&str, i64)> =
            relocs.iter().map(|r| (r.3.as_str(), r.4)).collect();
        assert_eq!(
            sites,
            [("ga", -4), ("wa", -4)],
            "a local alias resolves in place; a rebindable one names itself"
        );
    }

    /// `.org` reads its target against the final layout, so operator order
    /// does not decide whether the target reduces. GNU as 2.46.1 accepts
    /// every spelling with the same padding.
    #[test]
    fn file_scope_x86_org_target_folds_regardless_of_association() {
        for expr in [". + 662b-661b", ". + (662b-661b)", ". + 662b - 661b"] {
            let bytes = assemble(&alloc::format!(
                ".pushsection .t,\"ax\"\n\
                 661:\n\
                 nop\n\
                 nop\n\
                 662:\n\
                 .org {expr}\n\
                 ret\n\
                 .popsection\n"
            ));
            assert_eq!(bytes, alloc::vec![0x90, 0x90, 0x00, 0x00, 0xc3], "{expr}");
        }
    }

    /// `crc32` encodes `r32, r/m8|r/m16|r/m32` and `r64, r/m8|r/m64`: REX.W is
    /// the accumulator width, a register source names the source width, and the
    /// size suffix supplies it only for a memory source. Bytes measured with
    /// GNU as 2.46.1.
    #[test]
    fn crc32_operand_widths_match_gnu_as() {
        for (src, want) in [
            ("crc32 %al, %edi\n", &[0xf2, 0x0f, 0x38, 0xf0, 0xf8][..]),
            (
                "crc32 %al, %rdi\n",
                &[0xf2, 0x48, 0x0f, 0x38, 0xf0, 0xf8][..],
            ),
            (
                "crc32 %ax, %edi\n",
                &[0x66, 0xf2, 0x0f, 0x38, 0xf1, 0xf8][..],
            ),
            ("crc32 %eax, %edi\n", &[0xf2, 0x0f, 0x38, 0xf1, 0xf8][..]),
            // The 3-way crc32c combine step: a 64-bit register source with a
            // 64-bit accumulator, which the unsuffixed spelling names.
            (
                "crc32 %rax, %rdi\n",
                &[0xf2, 0x48, 0x0f, 0x38, 0xf1, 0xf8][..],
            ),
            (
                "crc32q %rax, %rdi\n",
                &[0xf2, 0x48, 0x0f, 0x38, 0xf1, 0xf8][..],
            ),
            (
                "crc32 %r15, %r8\n",
                &[0xf2, 0x4d, 0x0f, 0x38, 0xf1, 0xc7][..],
            ),
            (
                "crc32 %r15b, %r8d\n",
                &[0xf2, 0x45, 0x0f, 0x38, 0xf0, 0xc7][..],
            ),
            // spl/bpl/sil/dil as the byte source take a bare REX.
            (
                "crc32 %sil, %edi\n",
                &[0xf2, 0x40, 0x0f, 0x38, 0xf0, 0xfe][..],
            ),
            // A memory source takes its width from the suffix, or from the
            // accumulator when unsuffixed.
            ("crc32b (%rsi), %edi\n", &[0xf2, 0x0f, 0x38, 0xf0, 0x3e][..]),
            (
                "crc32b (%rsi), %rdi\n",
                &[0xf2, 0x48, 0x0f, 0x38, 0xf0, 0x3e][..],
            ),
            (
                "crc32w (%rsi), %edi\n",
                &[0x66, 0xf2, 0x0f, 0x38, 0xf1, 0x3e][..],
            ),
            ("crc32 (%rsi), %edi\n", &[0xf2, 0x0f, 0x38, 0xf1, 0x3e][..]),
            (
                "crc32 (%rsi), %rdi\n",
                &[0xf2, 0x48, 0x0f, 0x38, 0xf1, 0x3e][..],
            ),
            (
                "crc32q (%rsi,%rcx,2), %r9\n",
                &[0xf2, 0x4c, 0x0f, 0x38, 0xf1, 0x0c, 0x4e][..],
            ),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
        // Pairs the encoding has no room for, and a suffix contradicting the
        // source register: GNU as rejects each.
        for src in [
            "crc32 %rax, %edi\n",
            "crc32 %eax, %rdi\n",
            "crc32 %ax, %rdi\n",
            "crc32l %eax, %rdi\n",
            "crc32q (%rsi), %edi\n",
            "crc32w (%rsi), %rdi\n",
            "crc32 %al, %di\n",
            "crc32 %al, %dil\n",
            "crc32 (%rsi), %di\n",
            "crc32b %eax, %edi\n",
            "crc32l %al, %edi\n",
        ] {
            assert!(assemble_err(src).contains("crc32"), "{src}");
        }
    }

    /// `.code16` / `.code32` / `.code64` select the encoding mode of the
    /// instructions that follow, and the state carries across a section switch
    /// as it does in the assembler's input stream. Bytes measured with GNU as
    /// 2.46.1 for the same source.
    #[test]
    fn code_directives_select_the_encoding_mode() {
        assert_eq!(
            assemble(".code16\nmovl %eax, %ebx\nmov %ax, %bx\n"),
            [0x66, 0x89, 0xc3, 0x89, 0xc3]
        );
        assert_eq!(
            assemble(".code32\nmovl %eax, %ebx\nmov %ax, %bx\n"),
            [0x89, 0xc3, 0x66, 0x89, 0xc3]
        );
        assert_eq!(
            assemble("movl %eax, %ebx\nmov %ax, %bx\n"),
            [0x89, 0xc3, 0x66, 0x89, 0xc3]
        );
        // The mode switches mid-stream and carries into the next section.
        assert_eq!(
            assemble(".code16\npushw %si\n.code64\npush %rsi\n.code32\npush %esi\n"),
            [0x56, 0x56, 0x56]
        );
        assert_eq!(
            assemble(".code16\n.section \"a\",\"ax\"\nmovl %eax, %ebx\n"),
            [0x66, 0x89, 0xc3]
        );
    }

    /// GNU as orders the prefixes segment, address size, operand size, then
    /// repeat / lock, whatever the mode.
    #[test]
    fn prefix_order_matches_gnu_as() {
        assert_eq!(assemble(".code16\nrep movsl\n"), [0x66, 0xf3, 0xa5]);
        assert_eq!(assemble(".code16\nrep movsw\n"), [0xf3, 0xa5]);
        assert_eq!(assemble(".code32\nrep movsw\n"), [0x66, 0xf3, 0xa5]);
        assert_eq!(assemble("rep movsw\n"), [0x66, 0xf3, 0xa5]);
        assert_eq!(assemble("rep movsq\n"), [0xf3, 0x48, 0xa5]);
        assert_eq!(
            assemble(".code16\nlock addl $1, (%bx)\n"),
            [0x66, 0xf0, 0x83, 0x07, 0x01]
        );
        assert_eq!(
            assemble("lock addw $1, (%rax)\n"),
            [0x66, 0xf0, 0x83, 0x00, 0x01]
        );
    }

    /// A near branch's displacement follows the operand size: 16-bit in a
    /// `.code16` stub unless the AT&T suffix names the other width.
    #[test]
    fn branch_displacement_width_follows_the_mode() {
        assert_eq!(assemble(".code16\ncall f\n"), [0xe8, 0, 0]);
        assert_eq!(assemble(".code16\ncalll f\n"), [0x66, 0xe8, 0, 0, 0, 0]);
        assert_eq!(assemble(".code16\njmp f\n"), [0xe9, 0, 0]);
        assert_eq!(assemble(".code16\njz f\n"), [0x0f, 0x84, 0, 0]);
        assert_eq!(assemble(".code32\ncall f\n"), [0xe8, 0, 0, 0, 0]);
        assert_eq!(assemble("call f\n"), [0xe8, 0, 0, 0, 0]);
    }

    /// The direct far branch `ljmp` / `lcall $seg, $off` is `ptr16:16` or
    /// `ptr16:32` (EA / 9A) with the offset first and the selector after it.
    /// The offset width is the mode default unless the AT&T suffix names the
    /// other one, which the 0x66 prefix then selects. Bytes measured with GNU
    /// as 2.46.1 for the same source.
    #[test]
    fn direct_far_branch_matches_gnu_as() {
        for (src, bytes) in [
            (
                ".code16\nljmp $0x1234, $0x5678\n",
                &[0xea, 0x78, 0x56, 0x34, 0x12][..],
            ),
            (
                ".code16\nljmpw $0x1234, $0x5678\n",
                &[0xea, 0x78, 0x56, 0x34, 0x12][..],
            ),
            (
                ".code16\nljmpl $0x1234, $0x12345678\n",
                &[0x66, 0xea, 0x78, 0x56, 0x34, 0x12, 0x34, 0x12][..],
            ),
            (
                ".code16\nlcall $0x1234, $0x5678\n",
                &[0x9a, 0x78, 0x56, 0x34, 0x12][..],
            ),
            (
                ".code16\nlcalll $0x1234, $0x12345678\n",
                &[0x66, 0x9a, 0x78, 0x56, 0x34, 0x12, 0x34, 0x12][..],
            ),
            (
                ".code32\nljmp $0x1234, $0x12345678\n",
                &[0xea, 0x78, 0x56, 0x34, 0x12, 0x34, 0x12][..],
            ),
            (
                ".code32\nljmpw $0x1234, $0x5678\n",
                &[0x66, 0xea, 0x78, 0x56, 0x34, 0x12][..],
            ),
            (
                ".code32\nljmpl $0x1234, $0x12345678\n",
                &[0xea, 0x78, 0x56, 0x34, 0x12, 0x34, 0x12][..],
            ),
            (
                ".code32\nlcall $0x1234, $0x12345678\n",
                &[0x9a, 0x78, 0x56, 0x34, 0x12, 0x34, 0x12][..],
            ),
            (
                ".code32\nlcallw $0x1234, $0x5678\n",
                &[0x66, 0x9a, 0x78, 0x56, 0x34, 0x12][..],
            ),
            // The offset fits the field signed or unsigned; the selector is
            // truncated to 16 bits.
            (
                ".code16\nljmpw $0xf000, $-1\n",
                &[0xea, 0xff, 0xff, 0x00, 0xf0][..],
            ),
            (
                ".code16\nljmpw $0x12345, $0x1234\n",
                &[0xea, 0x34, 0x12, 0x45, 0x23][..],
            ),
        ] {
            assert_eq!(assemble(src), bytes, "{src}");
        }
        // 64-bit mode has no direct far branch, as GNU as reports.
        for src in [
            "ljmp $1, $2\n",
            "ljmpl $1, $2\n",
            "lcall $1, $2\n",
            ".code64\nljmpw $1, $2\n",
        ] {
            assert!(assemble_err(src).contains("64-bit-mode"), "{src}");
        }
        // An offset wider than the field it would take has no encoding.
        assert!(
            assemble_err(".code16\nljmpw $0x1234, $0x12345\n").contains("does not fit"),
            "16-bit offset range"
        );
    }

    /// The indirect far branch's operand-size prefix follows the mode the
    /// same way: the AT&T suffix names the offset width, and 0x66 appears
    /// only where it differs from the mode default. Bytes measured with GNU
    /// as 2.46.1 for the same source. The operands stay at the mode's default
    /// address size; the bespoke encoder does not yet model the other one.
    /// TODO 16-bit addressing and the 0x67 prefix in the bespoke encoder.
    #[test]
    fn indirect_far_branch_operand_size_matches_gnu_as() {
        for (src, bytes) in [
            (".code32\nljmp *(%eax)\n", &[0xff, 0x28][..]),
            (".code32\nljmpw *(%eax)\n", &[0x66, 0xff, 0x28][..]),
            (".code32\nljmpl *(%eax)\n", &[0xff, 0x28][..]),
            (".code32\nlcall *(%eax)\n", &[0xff, 0x18][..]),
            (".code32\nlcallw *(%eax)\n", &[0x66, 0xff, 0x18][..]),
            ("ljmp *(%rax)\n", &[0xff, 0x28][..]),
            ("ljmpw *(%rax)\n", &[0x66, 0xff, 0x28][..]),
            ("ljmpl *(%rax)\n", &[0xff, 0x28][..]),
            ("lcall *(%rax)\n", &[0xff, 0x18][..]),
        ] {
            assert_eq!(assemble(src), bytes, "{src}");
        }
    }

    /// A near `jmp` / `call` through an absolute address: AT&T's `*` marks
    /// the operand as the memory holding the target, so a bare address after
    /// it is a displacement-only memory reference rather than the branch
    /// target itself. Long mode addresses it with a base-less SIB. Bytes
    /// measured with GNU as 2.46.1 and llvm-mc 21 for the same source:
    /// `jmp *0x1234` is `ff 24 25 34 12 00 00`, `call *0x1234`
    /// `ff 14 25 34 12 00 00`, and `jmp *sym` the same with a signed 32-bit
    /// relocation in the displacement.
    #[test]
    fn near_indirect_branch_through_an_absolute_address_matches_gnu_as() {
        for (src, bytes) in [
            ("jmp *0x1234\n", &[0xff, 0x24, 0x25, 0x34, 0x12, 0, 0][..]),
            ("call *0x1234\n", &[0xff, 0x14, 0x25, 0x34, 0x12, 0, 0][..]),
        ] {
            assert_eq!(assemble(src), bytes, "{src}");
        }
        // Without the marker the same name is the branch target itself.
        let (bytes, relocs) = assemble_relocs("jmp sym\n");
        assert_eq!(bytes, [0xe9, 0, 0, 0, 0]);
        assert_eq!(
            relocs,
            [(1, 4, false, alloc::string::String::from("sym"), -4)]
        );
        let (bytes, relocs) = assemble_relocs("jmp *sym\ncall *sym\n");
        assert_eq!(
            bytes,
            [0xff, 0x24, 0x25, 0, 0, 0, 0, 0xff, 0x14, 0x25, 0, 0, 0, 0]
        );
        assert_eq!(
            relocs,
            [
                (3, 4, true, alloc::string::String::from("sym"), 0),
                (10, 4, true, alloc::string::String::from("sym"), 0),
            ]
        );
    }

    /// A symbol in a direct far branch's offset relocates in that field,
    /// which the trailing selector keeps off the end of the encoding; a
    /// symbol in the selector relocates in its own 16-bit field. Bytes and
    /// relocations measured with GNU as 2.46.1 for the same source.
    #[test]
    fn far_branch_symbol_immediate_matches_gnu_as() {
        for (src, bytes, reloc) in [
            // ea <16 sym> 08 00
            (
                ".code16\nljmpw $8, $s\n",
                &[0xea, 0, 0, 0x08, 0][..],
                (1u32, 2u8, 0i64),
            ),
            // 66 ea <32 sym> 08 00
            (
                ".code16\nljmpl $8, $s\n",
                &[0x66, 0xea, 0, 0, 0, 0, 0x08, 0][..],
                (2, 4, 0),
            ),
            (
                ".code32\nljmpl $8, $s\n",
                &[0xea, 0, 0, 0, 0, 0x08, 0][..],
                (1, 4, 0),
            ),
            (
                ".code32\nljmpw $8, $s\n",
                &[0x66, 0xea, 0, 0, 0x08, 0][..],
                (2, 2, 0),
            ),
            (
                ".code32\nlcalll $8, $s\n",
                &[0x9a, 0, 0, 0, 0, 0x08, 0][..],
                (1, 4, 0),
            ),
            (
                ".code32\nljmpl $8, $s+4\n",
                &[0xea, 0, 0, 0, 0, 0x08, 0][..],
                (1, 4, 4),
            ),
            // A symbol selector takes the trailing 16-bit field instead.
            (
                ".code32\nljmpl $s, $0x1000\n",
                &[0xea, 0x00, 0x10, 0, 0, 0, 0][..],
                (5, 2, 0),
            ),
        ] {
            let (got, relocs) = assemble_relocs(src);
            assert_eq!(got, bytes, "{src}");
            let (off, width, addend) = reloc;
            assert_eq!(
                relocs,
                [(off, width, false, alloc::string::String::from("s"), addend)],
                "{src}"
            );
        }
    }

    /// A `$symbol` immediate relocates in whatever field the instruction's
    /// operand size gives it, not only `push`'s imm32. The field is
    /// sign-extended (`R_X86_64_32S`, `signed`) exactly when the form's
    /// immediate slot is the signed imm32 class. Bytes and relocations
    /// measured with GNU as 2.46.1 for the same source.
    #[test]
    fn symbol_immediate_field_matches_gnu_as() {
        for (src, bytes, reloc) in [
            // 48 c7 c0 <32S sym>
            (
                "movq $s, %rax\n",
                &[0x48, 0xc7, 0xc0, 0, 0, 0, 0][..],
                (3u32, 4u8, true, 0i64),
            ),
            // b8 <32 sym>: a 32-bit operand takes the zero-extended field.
            ("movl $s, %eax\n", &[0xb8, 0, 0, 0, 0][..], (1, 4, false, 0)),
            (
                "subq $s, %rsp\n",
                &[0x48, 0x81, 0xec, 0, 0, 0, 0][..],
                (3, 4, true, 0),
            ),
            (
                "addq $s+8, %rax\n",
                &[0x48, 0x05, 0, 0, 0, 0][..],
                (2, 4, true, 8),
            ),
            ("cmpl $s, %eax\n", &[0x3d, 0, 0, 0, 0][..], (1, 4, false, 0)),
            ("pushq $s\n", &[0x68, 0, 0, 0, 0][..], (1, 4, true, 0)),
            ("movb $s, %al\n", &[0xb0, 0][..], (1, 1, false, 0)),
            ("movw $s, %dx\n", &[0x66, 0xba, 0, 0][..], (2, 2, false, 0)),
            (
                "movabsq $s, %rcx\n",
                &[0x48, 0xb9, 0, 0, 0, 0, 0, 0, 0, 0][..],
                (2, 8, false, 0),
            ),
        ] {
            let (got, relocs) = assemble_relocs(src);
            assert_eq!(got, bytes, "{src}");
            let (off, width, signed, addend) = reloc;
            assert_eq!(
                relocs,
                [(off, width, signed, alloc::string::String::from("s"), addend)],
                "{src}"
            );
        }
    }

    /// The legacy high-byte registers are a distinct operand class: their
    /// ModRM field values 4..8 name `spl`/`bpl`/`sil`/`dil` under a REX
    /// prefix, so no encoding carrying one can reach them. Bytes measured
    /// with GNU as 2.46.1.
    #[test]
    fn high_byte_registers_match_gnu_as() {
        for (src, want) in [
            ("xchg %al, %ah\n", &[0x86u8, 0xc4][..]),
            ("xchg %ah, %al\n", &[0x86, 0xe0]),
            ("xchg %ah, %bh\n", &[0x86, 0xe7]),
            ("xchg %ah, %dl\n", &[0x86, 0xe2]),
            ("mov %ah, %bl\n", &[0x88, 0xe3]),
            ("mov %bl, %ah\n", &[0x88, 0xdc]),
            ("movb %ch, (%rax)\n", &[0x88, 0x28]),
            ("movb (%rax), %dh\n", &[0x8a, 0x30]),
            ("addb %bh, %ah\n", &[0x00, 0xfc]),
            ("cmpb $1, %ah\n", &[0x80, 0xfc, 0x01]),
            ("incb %ah\n", &[0xfe, 0xc4]),
            ("shrb $4, %ah\n", &[0xc0, 0xec, 0x04]),
            ("movzbl %ah, %ecx\n", &[0x0f, 0xb6, 0xcc]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
        // A REX prefix and a high-byte register cannot appear together, so
        // no form of these encodes.
        for src in ["xchg %ah, %r8b\n", "mov %ah, %sil\n", "movzbq %ah, %rcx\n"] {
            let e = assemble_err(src);
            assert!(e.contains("rh4:1"), "{src}: {e}");
        }
    }

    /// Undefined-opcode and descriptor-table forms the kernel entry code
    /// writes. `lsl` / `lar` take no REX.W: GNU as encodes a 64-bit
    /// destination as the 32-bit form. `ud2a` / `ud2b` are its spellings of
    /// `ud2` / `ud1`, and both `ud0` and `ud1` have an operandless form.
    #[test]
    fn undefined_opcode_and_descriptor_forms_match_gnu_as() {
        for (src, want) in [
            ("ud1 (%edx), %rdi\n", &[0x67u8, 0x48, 0x0f, 0xb9, 0x3a][..]),
            ("ud1 (%rdx), %rdi\n", &[0x48, 0x0f, 0xb9, 0x3a]),
            ("ud1 %eax, %ecx\n", &[0x0f, 0xb9, 0xc8]),
            ("ud1 %ax, %cx\n", &[0x66, 0x0f, 0xb9, 0xc8]),
            ("ud1\n", &[0x0f, 0xb9]),
            ("ud0\n", &[0x0f, 0xff]),
            ("ud0 %rax, %rcx\n", &[0x48, 0x0f, 0xff, 0xc8]),
            ("ud2\n", &[0x0f, 0x0b]),
            ("ud2a\n", &[0x0f, 0x0b]),
            ("ud2b\n", &[0x0f, 0xb9]),
            ("lsl %rax, %rax\n", &[0x0f, 0x03, 0xc0]),
            ("lsl %ax, %ax\n", &[0x66, 0x0f, 0x03, 0xc0]),
            ("lsl %r12, %r13\n", &[0x45, 0x0f, 0x03, 0xec]),
            ("lsl (%rbx), %rax\n", &[0x0f, 0x03, 0x03]),
            ("lar %rax, %rax\n", &[0x0f, 0x02, 0xc0]),
            ("verw %rax\n", &[0x0f, 0x00, 0xe8]),
            ("verw (%rax)\n", &[0x0f, 0x00, 0x28]),
            ("verw 8(%rbx)\n", &[0x0f, 0x00, 0x6b, 0x08]),
            ("verr (%rax)\n", &[0x0f, 0x00, 0x20]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// The descriptor-table and machine-status ops against memory. The
    /// operand names a 16-bit field, so the memory forms carry no
    /// operand-size prefix whatever width the source wrote; a 32-bit register
    /// destination is the 16-bit encoding without the 0x66.
    #[test]
    fn descriptor_table_memory_forms_match_gnu_as() {
        for (src, want) in [
            ("sldt (%rax)\n", &[0x0fu8, 0x00, 0x00][..]),
            ("sldt (%r12)\n", &[0x41, 0x0f, 0x00, 0x04, 0x24]),
            ("sldt 8(%rbx)\n", &[0x0f, 0x00, 0x43, 0x08]),
            ("sldt %ax\n", &[0x66, 0x0f, 0x00, 0xc0]),
            ("sldt %eax\n", &[0x0f, 0x00, 0xc0]),
            ("str (%rax)\n", &[0x0f, 0x00, 0x08]),
            ("str %ax\n", &[0x66, 0x0f, 0x00, 0xc8]),
            ("lldt (%rax)\n", &[0x0f, 0x00, 0x10]),
            ("lldt (%r13)\n", &[0x41, 0x0f, 0x00, 0x55, 0x00]),
            ("lldt %ax\n", &[0x0f, 0x00, 0xd0]),
            ("ltr (%rax)\n", &[0x0f, 0x00, 0x18]),
            ("ltr %ax\n", &[0x0f, 0x00, 0xd8]),
            ("smsw (%rax)\n", &[0x0f, 0x01, 0x20]),
            ("smsw %ax\n", &[0x66, 0x0f, 0x01, 0xe0]),
            ("smsw %eax\n", &[0x0f, 0x01, 0xe0]),
            ("lmsw (%rax)\n", &[0x0f, 0x01, 0x30]),
            ("lmsw %ax\n", &[0x0f, 0x01, 0xf0]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// Packed integer absolute value, VEX and legacy. VEX.L follows the
    /// destination; the source may be a register or memory.
    #[test]
    fn packed_absolute_value_matches_gnu_as() {
        for (src, want) in [
            (
                "vpabsb %xmm13, %xmm13\n",
                &[0xc4u8, 0x42, 0x79, 0x1c, 0xed][..],
            ),
            ("vpabsb %ymm13, %ymm13\n", &[0xc4, 0x42, 0x7d, 0x1c, 0xed]),
            ("vpabsb %xmm0, %xmm15\n", &[0xc4, 0x62, 0x79, 0x1c, 0xf8]),
            ("vpabsw %xmm1, %xmm2\n", &[0xc4, 0xe2, 0x79, 0x1d, 0xd1]),
            ("vpabsd %xmm1, %xmm2\n", &[0xc4, 0xe2, 0x79, 0x1e, 0xd1]),
            ("vpabsd %ymm1, %ymm2\n", &[0xc4, 0xe2, 0x7d, 0x1e, 0xd1]),
            ("vpabsb (%rax), %xmm1\n", &[0xc4, 0xe2, 0x79, 0x1c, 0x08]),
            (
                "vpabsd (%r12), %ymm9\n",
                &[0xc4, 0x42, 0x7d, 0x1e, 0x0c, 0x24],
            ),
            (
                "pabsb %xmm13, %xmm13\n",
                &[0x66, 0x45, 0x0f, 0x38, 0x1c, 0xed],
            ),
            ("pabsw %xmm1, %xmm2\n", &[0x66, 0x0f, 0x38, 0x1d, 0xd1]),
            ("pabsd %xmm1, %xmm2\n", &[0x66, 0x0f, 0x38, 0x1e, 0xd1]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// Packed shifts by a variable count. The count is `xmm/m128` at every
    /// destination width, so it takes ModRM.rm and VEX.L follows the
    /// destination and source; a ymm count has no encoding.
    #[test]
    fn variable_count_packed_shifts_match_gnu_as() {
        for (src, want) in [
            (
                "vpslld %xmm11, %xmm8, %xmm15\n",
                &[0xc4u8, 0x41, 0x39, 0xf2, 0xfb][..],
            ),
            ("vpsllw %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xf1, 0xd9]),
            ("vpsllq %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xf3, 0xd9]),
            ("vpsrlw %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xd1, 0xd9]),
            ("vpsrld %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xd2, 0xd9]),
            ("vpsrlq %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xd3, 0xd9]),
            ("vpsraw %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xe1, 0xd9]),
            ("vpsrad %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xe2, 0xd9]),
            ("vpslld %xmm1, %ymm2, %ymm3\n", &[0xc5, 0xed, 0xf2, 0xd9]),
            ("vpsrld (%rax), %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xd2, 0x18]),
            ("vpsrld (%rax), %ymm2, %ymm3\n", &[0xc5, 0xed, 0xd2, 0x18]),
            ("psrld %xmm1, %xmm2\n", &[0x66, 0x0f, 0xd2, 0xd1]),
            ("psllw %xmm1, %xmm9\n", &[0x66, 0x44, 0x0f, 0xf1, 0xc9]),
            ("psrlq %xmm9, %xmm10\n", &[0x66, 0x45, 0x0f, 0xd3, 0xd1]),
            ("psrld (%rax), %xmm2\n", &[0x66, 0x0f, 0xd2, 0x10]),
            // The immediate forms keep the destination in VEX.vvvv.
            ("vpslld $5, %xmm2, %xmm3\n", &[0xc5, 0xe1, 0x72, 0xf2, 0x05]),
            ("pslld $5, %xmm2\n", &[0x66, 0x0f, 0x72, 0xf2, 0x05]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
        // A ymm count is not encodable, and the shifts without a
        // variable-count member keep requiring an immediate.
        for (src, want) in [
            ("vpslld %ymm1, %ymm2, %ymm3\n", "count is xmm"),
            ("vpslldq %xmm1, %xmm2, %xmm3\n", "immediate expected"),
            ("pslldq %xmm1, %xmm2\n", "immediate expected"),
        ] {
            let e = assemble_err(src);
            assert!(e.contains(want), "{src}: {e}");
        }
    }

    /// `vmovd` / `vmovq` between an xmm lane and a general register or
    /// memory. VEX.W selects the width of a general-register transfer; the
    /// xmm and memory forms are W-ignored and take the two-byte VEX.
    #[test]
    fn vex_lane_moves_match_gnu_as() {
        for (src, want) in [
            ("vmovd %edi, %xmm0\n", &[0xc5u8, 0xf9, 0x6e, 0xc7][..]),
            ("vmovd %xmm0, %edi\n", &[0xc5, 0xf9, 0x7e, 0xc7]),
            ("vmovd (%rax), %xmm3\n", &[0xc5, 0xf9, 0x6e, 0x18]),
            ("vmovd %xmm5, (%rcx)\n", &[0xc5, 0xf9, 0x7e, 0x29]),
            ("vmovd %xmm11, %r9d\n", &[0xc4, 0x41, 0x79, 0x7e, 0xd9]),
            ("vmovd %r10d, %xmm12\n", &[0xc4, 0x41, 0x79, 0x6e, 0xe2]),
            ("vmovq %rdi, %xmm0\n", &[0xc4, 0xe1, 0xf9, 0x6e, 0xc7]),
            ("vmovq %xmm0, %rdi\n", &[0xc4, 0xe1, 0xf9, 0x7e, 0xc7]),
            ("vmovq %xmm0, %xmm1\n", &[0xc5, 0xfa, 0x7e, 0xc8]),
            ("vmovq (%rax), %xmm0\n", &[0xc5, 0xfa, 0x7e, 0x00]),
            ("vmovq %xmm0, (%rax)\n", &[0xc5, 0xf9, 0xd6, 0x00]),
            ("vmovq %r9, %xmm10\n", &[0xc4, 0x41, 0xf9, 0x6e, 0xd1]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// A character constant is an expression leaf wherever a number is, with
    /// the C escapes plus GNU as's octal and hex forms.
    #[test]
    fn character_constants_match_gnu_as() {
        for (src, want) in [
            ("addb $('a' - '0' - 10), %al\n", &[0x04u8, 0x27][..]),
            ("movl $'A', %eax\n", &[0xb8, 0x41, 0x00, 0x00, 0x00]),
            ("movb $'\\n', %al\n", &[0xb0, 0x0a]),
            ("movb $'\\'', %al\n", &[0xb0, 0x27]),
            ("movb $'\\\\', %al\n", &[0xb0, 0x5c]),
            ("movb $'\\x41', %al\n", &[0xb0, 0x41]),
            ("movb $'\\101', %al\n", &[0xb0, 0x41]),
            (".byte 'x'\n", &[0x78]),
            (".byte 'a', 'b'\n", &[0x61, 0x62]),
            (".long 'a' + 1\n", &[0x62, 0x00, 0x00, 0x00]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// The encoding mode is assembler state over the linear input, not a
    /// property of a section: a `.code64` written in one section is still in
    /// effect when the stream returns to an earlier one. GNU as encodes the
    /// `lea` below 64-bit (`48 8d 3d`), not 32-bit.
    #[test]
    fn code_mode_carries_across_section_switches_like_gnu_as() {
        let (bytes, relocs) = assemble_relocs(
            ".code32\n.text\nnop\n.section \".head.text\",\"ax\"\n.code32\nnop\n\
             .code64\nnop\n.text\nleaq _bss(%rip), %rdi\n",
        );
        assert_eq!(
            bytes,
            [0x90, 0x48, 0x8d, 0x3d, 0, 0, 0, 0, 0x90, 0x90],
            "{bytes:x?}"
        );
        assert_eq!(
            relocs,
            [(4, 4, false, alloc::string::String::from("_bss"), -4)]
        );
    }

    /// Which same-section references keep a relocation, measured against GNU
    /// as 2.46.1. A local name resolves in place; a global or weak one keeps
    /// the relocation so the link binds the definition that wins. The relaxed
    /// jump is the one exception: `jmp` / `jcc` to a same-section target
    /// resolves unless the symbol is weak.
    #[test]
    fn same_section_binding_decides_the_relocation_like_gnu_as() {
        let defs = ".text\n.Lloc:\nret\n.globl glob\nglob:\nret\n.weak wk\nwk:\nret\n";
        let relocs_of = |body: &str| assemble_relocs(&alloc::format!("{defs}{body}")).1;
        let names = |body: &str| -> alloc::vec::Vec<alloc::string::String> {
            relocs_of(body).into_iter().map(|r| r.3).collect()
        };
        // A local target resolves in place, whatever the form.
        assert!(names("call .Lloc\n").is_empty());
        assert!(names("jmp .Lloc\n").is_empty());
        assert!(names("lea .Lloc(%rip), %rax\n").is_empty());
        // A call or an address-of naming a global or weak symbol relocates.
        assert_eq!(names("call glob\n"), ["glob"]);
        assert_eq!(names("call wk\n"), ["wk"]);
        assert_eq!(names("lea glob(%rip), %rax\n"), ["glob"]);
        // A relaxed jump binds a same-section global in place: the branch
        // relaxes and no relocation survives. A weak target keeps both the
        // long form and its relocation.
        assert!(names("jmp glob\n").is_empty());
        assert!(names("je glob\n").is_empty());
        assert_eq!(names("jmp wk\n"), ["wk"]);
        assert_eq!(names("je wk\n"), ["wk"]);
        // A difference of two symbols folds whatever the binding, as GNU as
        // folds it: `.long glob - .` deposits a constant.
        assert!(names(".long glob - .\n").is_empty());
        assert!(names(".long wk - .\n").is_empty());
    }

    /// `. = expr` moves the location counter, as `.org` does; the kernel's
    /// kexec exception-vector table places its 6-byte entries that way.
    #[test]
    fn location_counter_assignment_places_like_org() {
        assert_eq!(
            assemble("base:\n.byte 1\n. = base + 4\n.byte 2\n"),
            [1, 0, 0, 0, 2]
        );
        assert_eq!(
            assemble("base:\n.byte 1\n.set ., base + 4\n.byte 2\n"),
            [1, 0, 0, 0, 2]
        );
        // Moving backwards is rejected, as GNU as rejects it.
        assert!(
            assemble_err("base:\n.byte 1, 2, 3\n. = base + 1\n").contains("backwards"),
            "a backward move must be diagnosed"
        );
    }

    /// The count- and rcx-conditional branches take a rel8 field only. A
    /// same-section target resolves to the byte displacement with no
    /// relocation, as GNU as emits it.
    #[test]
    fn short_branches_match_gnu_as() {
        assert_eq!(
            assemble("1:\nnop\nloop 1b\n"),
            [0x90, 0xe2, 0xfd],
            "loop backward"
        );
        assert_eq!(assemble(".Lx:\nnop\nloop .Lx\n"), [0x90, 0xe2, 0xfd]);
        assert_eq!(assemble(".Lx:\nnop\njrcxz .Lx\n"), [0x90, 0xe3, 0xfd]);
        assert_eq!(assemble(".Lx:\nnop\nloope .Lx\n"), [0x90, 0xe1, 0xfd]);
        assert_eq!(assemble(".Lx:\nnop\nloopne .Lx\n"), [0x90, 0xe0, 0xfd]);
        assert_eq!(assemble(".Lx:\nnop\nloopz .Lx\n"), [0x90, 0xe1, 0xfd]);
        assert_eq!(assemble(".Lx:\nnop\nloopnz .Lx\n"), [0x90, 0xe0, 0xfd]);
    }

    /// The counter an `E3` branch name spells is the address size, so the
    /// name off the mode's default takes the `67` prefix and a width the
    /// mode cannot address is rejected.
    #[test]
    fn e3_branch_takes_the_address_size_of_its_counter() {
        assert_eq!(assemble("x: jecxz x\n"), [0x67, 0xe3, 0xfd]);
        assert_eq!(assemble(".code32\nx: jecxz x\n"), [0xe3, 0xfe]);
        assert_eq!(assemble(".code32\nx: jcxz x\n"), [0x67, 0xe3, 0xfd]);
        assert_eq!(assemble(".code16\nx: jcxz x\n"), [0xe3, 0xfe]);
        assert_eq!(assemble(".code16\nx: jecxz x\n"), [0x67, 0xe3, 0xfd]);
        assert!(assemble_err("x: jcxz x\n").contains("64-bit mode"));
        assert!(assemble_err(".code32\nx: jrcxz x\n").contains("32-bit mode"));
        assert!(assemble_err(".code16\nx: jrcxz x\n").contains("16-bit mode"));
        // No wider form exists: a target out of rel8 range is an error, not
        // a relaxation.
        assert!(
            assemble_err("x: .skip 200, 0x90\njecxz x\n").contains("out of range"),
            "an out-of-range rel8 target must be diagnosed"
        );
    }

    /// A `.code16` stub's symbol immediate takes the 16-bit field, and the
    /// constant term folds into the relocation addend.
    #[test]
    fn symbol_immediate_in_code16_matches_gnu_as() {
        let (bytes, relocs) = assemble_relocs(".code16\nmovw $_end+3, %cx\n");
        assert_eq!(bytes, [0xb9, 0, 0]);
        assert_eq!(
            relocs,
            [(1, 2, false, alloc::string::String::from("_end"), 3)]
        );
    }

    /// A `.set` / `=` assignment to a register is the GNU as register equate:
    /// every later use of the name assembles as that register. `$name` splits
    /// at the AT&T immediate sigil, so a constant equate resolves there too.
    #[test]
    fn register_and_constant_equates_resolve_in_operands() {
        assert_eq!(
            assemble(".set IN_KEY, %rdx\nmovdqu (IN_KEY), %xmm0\n"),
            [0xf3, 0x0f, 0x6f, 0x02]
        );
        assert_eq!(
            assemble("CRC = %edi\nmovd CRC, %xmm0\n"),
            [0x66, 0x0f, 0x6e, 0xc7]
        );
        // An equate whose value is another equate takes its register.
        assert_eq!(
            assemble("A = %rdx\nB = A\nmov (%r9), B\n"),
            [0x49, 0x8b, 0x11]
        );
        // `_A`/`_B`/`K` fold to 32; `$K` is the sigil plus the name.
        assert_eq!(
            assemble("_A = 8\n_B = _A + 8\nK = _B + 16\nsubq $K, %rsp\n"),
            [0x48, 0x83, 0xec, 0x20]
        );
    }

    /// The SSSE3 / SSE4.1 / AES / SHA / carry-less families sit on the 0F38 and
    /// 0F3A maps, whose escape byte and operand direction the two-operand and
    /// immediate SSE shapes now carry. The extract forms write their r/m
    /// operand, so their vector operand is the ModRM.reg one. Bytes measured
    /// with GNU as 2.46.1 for the same source.
    #[test]
    fn sse_map38_and_map3a_forms_match_gnu_as() {
        for (src, want) in [
            ("pshufb %xmm7, %xmm2\n", &[0x66, 0x0f, 0x38, 0x00, 0xd7][..]),
            (
                "pshufb 16(%rdi), %xmm10\n",
                &[0x66, 0x44, 0x0f, 0x38, 0x00, 0x57, 0x10][..],
            ),
            ("punpcklqdq %xmm2, %xmm1\n", &[0x66, 0x0f, 0x6c, 0xca][..]),
            ("punpckhqdq %xmm2, %xmm1\n", &[0x66, 0x0f, 0x6d, 0xca][..]),
            (
                "pclmulqdq $0x00, %xmm1, %xmm0\n",
                &[0x66, 0x0f, 0x3a, 0x44, 0xc1, 0x00][..],
            ),
            (
                "pclmulqdq $0x11, %xmm9, %xmm10\n",
                &[0x66, 0x45, 0x0f, 0x3a, 0x44, 0xd1, 0x11][..],
            ),
            (
                "palignr $8, %xmm1, %xmm2\n",
                &[0x66, 0x0f, 0x3a, 0x0f, 0xd1, 0x08][..],
            ),
            (
                "pinsrd $3, 16(%rdi), %xmm1\n",
                &[0x66, 0x0f, 0x3a, 0x22, 0x4f, 0x10, 0x03][..],
            ),
            (
                "pinsrq $1, %rax, %xmm5\n",
                &[0x66, 0x48, 0x0f, 0x3a, 0x22, 0xe8, 0x01][..],
            ),
            // The extract's destination is the r/m: `%eax` sits there, `%xmm1`
            // in ModRM.reg.
            (
                "pextrd $3, %xmm1, %eax\n",
                &[0x66, 0x0f, 0x3a, 0x16, 0xc8, 0x03][..],
            ),
            (
                "pextrd $2, %xmm9, 8(%rsi)\n",
                &[0x66, 0x44, 0x0f, 0x3a, 0x16, 0x4e, 0x08, 0x02][..],
            ),
            (
                "pmovzxdq %xmm1, %xmm2\n",
                &[0x66, 0x0f, 0x38, 0x35, 0xd1][..],
            ),
            ("aesenc %xmm1, %xmm0\n", &[0x66, 0x0f, 0x38, 0xdc, 0xc1][..]),
            (
                "aesenclast %xmm9, %xmm10\n",
                &[0x66, 0x45, 0x0f, 0x38, 0xdd, 0xd1][..],
            ),
            // The SHA extensions take no mandatory prefix.
            ("sha1nexte %xmm1, %xmm0\n", &[0x0f, 0x38, 0xc8, 0xc1][..]),
            ("sha256rnds2 %xmm1, %xmm0\n", &[0x0f, 0x38, 0xcb, 0xc1][..]),
            (
                "sha1rnds4 $3, %xmm1, %xmm0\n",
                &[0x0f, 0x3a, 0xcc, 0xc1, 0x03][..],
            ),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// The AVX counterparts: the 0F38 three-operand set, the packed shifts
    /// (destination in VEX.vvvv), the 0F3A lane ops, the lane extracts (whose
    /// `L` follows the wide ModRM.reg source), and the operandless upper-lane
    /// clears. Bytes measured with GNU as 2.46.1 for the same source.
    #[test]
    fn vex_map38_shift_and_lane_forms_match_gnu_as() {
        for (src, want) in [
            (
                "vpshufb %xmm13, %xmm4, %xmm4\n",
                &[0xc4, 0xc2, 0x59, 0x00, 0xe5][..],
            ),
            (
                "vpshufb %ymm13, %ymm0, %ymm0\n",
                &[0xc4, 0xc2, 0x7d, 0x00, 0xc5][..],
            ),
            (
                "vpslld $2, %xmm1, %xmm2\n",
                &[0xc5, 0xe9, 0x72, 0xf1, 0x02][..],
            ),
            (
                "vpsrld $30, %ymm1, %ymm2\n",
                &[0xc5, 0xed, 0x72, 0xd1, 0x1e][..],
            ),
            (
                "vpslldq $8, %xmm0, %xmm1\n",
                &[0xc5, 0xf1, 0x73, 0xf8, 0x08][..],
            ),
            (
                "vpsrldq $4, %xmm11, %xmm12\n",
                &[0xc4, 0xc1, 0x19, 0x73, 0xdb, 0x04][..],
            ),
            (
                "vpclmulqdq $0x01, %xmm0, %xmm1, %xmm14\n",
                &[0xc4, 0x63, 0x71, 0x44, 0xf0, 0x01][..],
            ),
            (
                "vperm2i128 $0x20, %ymm2, %ymm1, %ymm0\n",
                &[0xc4, 0xe3, 0x75, 0x46, 0xc2, 0x20][..],
            ),
            (
                "vinserti128 $1, %xmm2, %ymm1, %ymm0\n",
                &[0xc4, 0xe3, 0x75, 0x38, 0xc2, 0x01][..],
            ),
            (
                "vextracti128 $1, %ymm0, %xmm1\n",
                &[0xc4, 0xe3, 0x7d, 0x39, 0xc1, 0x01][..],
            ),
            (
                "vextracti128 $1, %ymm10, 16(%rdi)\n",
                &[0xc4, 0x63, 0x7d, 0x39, 0x57, 0x10, 0x01][..],
            ),
            ("vzeroupper\n", &[0xc5, 0xf8, 0x77][..]),
            ("vzeroall\n", &[0xc5, 0xfc, 0x77][..]),
            (
                "vaesenc %xmm1, %xmm2, %xmm3\n",
                &[0xc4, 0xe2, 0x69, 0xdc, 0xd9][..],
            ),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// A label outside a branch is an operand like any other: `Nf(%%rip)` is
    /// the label's address, `$Nf` its address as an immediate, and a bare `Nf`
    /// the absolute address the boot stubs patch through. The whole stream's
    /// bytes and relocations, measured with GNU as 2.46.1.
    #[test]
    fn label_operands_match_gnu_as() {
        let (bytes, relocs) = assemble_relocs(concat!(
            ".code16\n",
            "cmpb %al, 3f\n",
            "movb %al, 3f\n",
            "addw %bx, 3f\n",
            "3:\n",
            "int $0x10\n",
            ".code32\n",
            "addl %ebx, 2f\n",
            "2:\n",
            ".code64\n",
            "leaq 1f(%rip), %rbp\n",
            "movl 1f(%rip), %eax\n",
            "pushq $1f\n",
            "1:\n",
        ));
        #[rustfmt::skip]
        let want: &[u8] = &[
            0x38, 0x06, 0, 0,                   // cmpb %al, 3f
            0xa2, 0, 0,                         // movb %al, 3f (the moffs form)
            0x01, 0x1e, 0, 0,                   // addw %bx, 3f
            0xcd, 0x10,                         // 3: int $0x10
            0x01, 0x1d, 0, 0, 0, 0,             // addl %ebx, 2f
            // The two RIP-relative references reach a label of this section,
            // so the distance is resolved in place and no relocation is left.
            0x48, 0x8d, 0x2d, 11, 0, 0, 0,      // leaq 1f(%rip), %rbp
            0x8b, 0x05, 5, 0, 0, 0,             // movl 1f(%rip), %eax
            0x68, 0, 0, 0, 0,                   // pushq $1f
        ];
        assert_eq!(bytes, want);
        // A numeric label's relocations name the per-instance symbol the
        // materializer gives its definition.
        let at = |name: &str| alloc::string::String::from(name);
        assert_eq!(
            relocs,
            [
                // The `.code16` address fields are 16 bits wide.
                (2, 2, false, at(".Lc5_asmsec_0_3"), 0),
                (5, 2, false, at(".Lc5_asmsec_0_3"), 0),
                (9, 2, false, at(".Lc5_asmsec_0_3"), 0),
                // A 32-bit address size takes the zero-extended flavour.
                (15, 4, false, at(".Lc5_asmsec_0_2"), 0),
                (33, 4, true, at(".Lc5_asmsec_0_1"), 0),
            ]
        );
    }

    /// AT&T spells an absolute memory reference without the `$` an immediate
    /// carries, so a bare symbol is an address. Its disp32 is sign-extended
    /// into a 64-bit address (`R_X86_64_32S`) and is the whole address under a
    /// narrower address size. Bytes measured with GNU as 2.46.1.
    #[test]
    fn absolute_symbol_memory_operands_match_gnu_as() {
        for (src, bytes, reloc) in [
            (
                "lock btsl $0, tr_lock\n",
                &[0xf0, 0x0f, 0xba, 0x2c, 0x25, 0, 0, 0, 0, 0][..],
                (5u32, 4u8, true, "tr_lock", 0i64),
            ),
            (
                "movl sym, %eax\n",
                &[0x8b, 0x04, 0x25, 0, 0, 0, 0][..],
                (3, 4, true, "sym", 0),
            ),
            // The immediate trails the displacement field.
            (
                "testb $0x80, loadflags\n",
                &[0xf6, 0x04, 0x25, 0, 0, 0, 0, 0x80][..],
                (3, 4, true, "loadflags", 0),
            ),
            (
                ".code16\nlgdtl %cs:wakeup_gdt\n",
                &[0x2e, 0x66, 0x0f, 0x01, 0x16, 0, 0][..],
                (5, 2, false, "wakeup_gdt", 0),
            ),
            (
                ".code16\nmovw sym, %dx\n",
                &[0x8b, 0x16, 0, 0][..],
                (2, 2, false, "sym", 0),
            ),
        ] {
            let (got, relocs) = assemble_relocs(src);
            assert_eq!(got, bytes, "{src}");
            let (off, width, signed, name, addend) = reloc;
            assert_eq!(
                relocs,
                [(
                    off,
                    width,
                    signed,
                    alloc::string::String::from(name),
                    addend
                )],
                "{src}"
            );
        }
    }

    /// An operand's displacement or immediate is an expression over symbols,
    /// not only a symbol name: a difference of two labels of the section folds
    /// into the field, what keeps a symbol relocates against it with the rest
    /// as the addend, and the addend is not confined to the field's width.
    /// The displacement and the immediate relocate independently, so one
    /// instruction may carry both. Bytes and relocations measured with GNU as
    /// 2.46.1 for the same source.
    #[test]
    fn operand_symbol_expressions_match_gnu_as() {
        let at = |name: &str| alloc::string::String::from(name);
        // A symbol less a constant wider than the field: the addend rides the
        // relocation, so it is not truncated to the imm32 it lands in.
        assert_eq!(
            assemble_relocs("addq $(init_top_pgt - 0xffffffff80000000), %rax\n"),
            (
                alloc::vec![0x48, 0x05, 0, 0, 0, 0],
                alloc::vec![(2, 4, true, at("init_top_pgt"), 0x8000_0000)]
            )
        );
        // Two labels of one section: the difference folds and no relocation
        // is left. The field stays the wide one the encoding picked, as GNU
        // as leaves it for a difference it cannot value while encoding.
        assert_eq!(
            assemble_relocs(
                "relocate_kernel:\naddq $(identity_mapped - relocate_kernel), %r8\nnop\n\
                 identity_mapped:\nnop\n"
            ),
            (
                alloc::vec![0x49, 0x81, 0xc0, 0x08, 0, 0, 0, 0x90, 0x90],
                alloc::vec![]
            )
        );
        // A far branch's offset is such a difference (`la57toggle.S`).
        assert_eq!(
            assemble_relocs(
                ".code32\ntrampoline_32bit_src:\nljmpl $(2*8), $(.Lret - trampoline_32bit_src)\n\
                 nop\n.Lret:\nnop\n"
            ),
            (
                alloc::vec![0xea, 0x08, 0, 0, 0, 0x10, 0, 0x90, 0x90],
                alloc::vec![]
            )
        );
        // A symbol displacement and a symbol immediate in one instruction
        // (`wakeup_64.S`): x86 relocates the two fields independently.
        assert_eq!(
            assemble_relocs("movq $.Lresume_point, saved_rip(%rip)\n.Lresume_point:\nnop\n"),
            (
                alloc::vec![0x48, 0xc7, 0x05, 0, 0, 0, 0, 0, 0, 0, 0, 0x90],
                alloc::vec![
                    (3, 4, false, at("saved_rip"), -8),
                    (7, 4, true, at(".Lresume_point"), 0),
                ]
            )
        );
        // A memory displacement over a symbol less a label of this section
        // (`efi-mixed.S`): the label folds into the addend and the symbol
        // keeps the relocation.
        assert_eq!(
            assemble_relocs(".code32\n1:\nleal (efi32_boot_args - 1b)(%ecx), %ebx\n"),
            (
                alloc::vec![0x8d, 0x99, 0, 0, 0, 0],
                alloc::vec![(2, 4, false, at("efi32_boot_args"), 2)]
            )
        );
        // An expression in each of the other displacement forms.
        for (src, bytes, reloc) in [
            (
                "movq (tab + 8)(,%rcx,4), %rbx\n",
                &[0x48, 0x8b, 0x1c, 0x8d, 0, 0, 0, 0][..],
                (4u32, 4u8, true, "tab", 8i64),
            ),
            (
                "movq (tab + 8)(%rbx), %rcx\n",
                &[0x48, 0x8b, 0x8b, 0, 0, 0, 0][..],
                (3, 4, true, "tab", 8),
            ),
            (
                ".code32\nmovl (tab + 4 * 3), %eax\n",
                &[0xa1, 0, 0, 0, 0][..],
                (1, 4, false, "tab", 12),
            ),
            // The AT&T indirect marker leaves the operand form unchanged.
            (
                "jmpq *tr_start(%rip)\n",
                &[0xff, 0x25, 0, 0, 0, 0][..],
                (2, 4, false, "tr_start", -4),
            ),
            // `_ASM_RIP(x)` expands with whitespace inside the reference.
            (
                "movl x86_pred_cmd (% rip), %eax\n",
                &[0x8b, 0x05, 0, 0, 0, 0][..],
                (2, 4, false, "x86_pred_cmd", -4),
            ),
        ] {
            let (got, relocs) = assemble_relocs(src);
            assert_eq!(got, bytes, "{src}");
            let (off, width, signed, name, addend) = reloc;
            assert_eq!(relocs, [(off, width, signed, at(name), addend)], "{src}");
        }
        // An expression the layout cannot value names itself in the
        // diagnostic rather than encoding a wrong field.
        assert!(
            assemble_err("addq $(a - b), %r8\n").contains("subtracts an undefined symbol"),
            "undefined difference"
        );
    }

    /// A `.fill` count is an expression over the layout, the location counter
    /// included (`head_64.S` pads each early IDT entry to a fixed stride).
    /// Bytes measured with GNU as 2.46.1 for the same source.
    #[test]
    fn fill_count_over_location_counter_matches_gnu_as() {
        assert_eq!(
            assemble("base:\nnop\n.fill base + 4 - ., 1, 0xcc\nnop\n"),
            [0x90, 0xcc, 0xcc, 0xcc, 0x90]
        );
    }

    /// A scaled index addresses memory in the hand-written SSE / VEX shapes as
    /// it does in the catalogue: the SIB byte with REX.X / VEX.X carrying the
    /// index's high bit. Bytes measured with GNU as 2.46.1.
    #[test]
    fn scaled_index_memory_operands_match_gnu_as() {
        for (src, want) in [
            (
                "crc32q (%rsi,%rcx), %r8\n",
                &[0xf2, 0x4c, 0x0f, 0x38, 0xf1, 0x04, 0x0e][..],
            ),
            (
                "movd (%rsi,%rax,4), %xmm4\n",
                &[0x66, 0x0f, 0x6e, 0x24, 0x86][..],
            ),
            (
                "movdqu -16(%rsi,%rdx), %xmm2\n",
                &[0xf3, 0x0f, 0x6f, 0x54, 0x16, 0xf0][..],
            ),
            (
                "movdqu %xmm7, 16(%rsp,%rbx,8)\n",
                &[0xf3, 0x0f, 0x7f, 0x7c, 0xdc, 0x10][..],
            ),
            // A high index sets VEX.X, which forces the 3-byte form.
            (
                "vpaddd (%rsi,%r13,4), %ymm4, %ymm9\n",
                &[0xc4, 0x21, 0x5d, 0xfe, 0x0c, 0xae][..],
            ),
            (
                "pshufb (%r8,%r9,2), %xmm3\n",
                &[0x66, 0x43, 0x0f, 0x38, 0x00, 0x1c, 0x48][..],
            ),
            // No base register: SIB.base = 101 with a disp32.
            (
                "movd (,%rax,4), %xmm4\n",
                &[0x66, 0x0f, 0x6e, 0x24, 0x85, 0, 0, 0, 0][..],
            ),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// The BMI / BMI2 set encodes with VEX but names no vector register:
    /// VEX.W follows the operand width and VEX.L is zero. The shift-like ops
    /// hold their count in VEX.vvvv, so their AT&T sources are the other way
    /// round from `andn` and friends. Bytes measured with GNU as 2.46.1.
    #[test]
    fn vex_general_register_forms_match_gnu_as() {
        for (src, want) in [
            (
                "rorx $2, %esi, %esi\n",
                &[0xc4, 0xe3, 0x7b, 0xf0, 0xf6, 0x02][..],
            ),
            (
                "rorx $25, %edx, %r13d\n",
                &[0xc4, 0x63, 0x7b, 0xf0, 0xea, 0x19][..],
            ),
            // A quadword operand sets VEX.W.
            (
                "rorx $7, %rax, %rbx\n",
                &[0xc4, 0xe3, 0xfb, 0xf0, 0xd8, 0x07][..],
            ),
            (
                "rorx $3, 8(%rdi), %ecx\n",
                &[0xc4, 0xe3, 0x7b, 0xf0, 0x4f, 0x08, 0x03][..],
            ),
            (
                "andn %eax, %ebx, %ecx\n",
                &[0xc4, 0xe2, 0x60, 0xf2, 0xc8][..],
            ),
            (
                "andn %rax, %rbx, %rcx\n",
                &[0xc4, 0xe2, 0xe0, 0xf2, 0xc8][..],
            ),
            (
                "bzhi %eax, %ebx, %ecx\n",
                &[0xc4, 0xe2, 0x78, 0xf5, 0xcb][..],
            ),
            (
                "sarx %ecx, %eax, %edx\n",
                &[0xc4, 0xe2, 0x72, 0xf7, 0xd0][..],
            ),
            (
                "shlx %ecx, %eax, %edx\n",
                &[0xc4, 0xe2, 0x71, 0xf7, 0xd0][..],
            ),
            (
                "shrx %rcx, %rax, %rdx\n",
                &[0xc4, 0xe2, 0xf3, 0xf7, 0xd0][..],
            ),
            (
                "sarx %ecx, (%rdi,%rsi,4), %edx\n",
                &[0xc4, 0xe2, 0x72, 0xf7, 0x14, 0xb7][..],
            ),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// Bespoke-path memory forms (x87, mxcsr, cmpxchg16b, the MMX / SSE
    /// quadword moves, segment moves, crc32, and the indirect far branches)
    /// follow the address size: a 16-bit address takes the 16-bit r/m
    /// numbering and a non-default one the `67` prefix, ahead of any
    /// operand-size or mandatory prefix. Bytes measured with GNU as 2.46.1
    /// and clang for the same source.
    #[test]
    fn bespoke_memory_forms_follow_the_address_size() {
        #[rustfmt::skip]
        let cases: &[(&str, &[u8])] = &[
            (".code16\nljmp *(%bx)\n",           &[0xff, 0x2f]),
            (".code16\nljmpw *(%bx)\n",          &[0xff, 0x2f]),
            (".code16\nlcall *8(%bp,%si)\n",     &[0xff, 0x5a, 0x08]),
            (".code16\nlcalll *(%bx)\n",         &[0x66, 0xff, 0x1f]),
            (".code16\nljmpl *(%eax)\n",         &[0x67, 0x66, 0xff, 0x28]),
            (".code16\nfnstsw (%bx)\n",          &[0xdd, 0x3f]),
            (".code16\nfnstsw 2(%bx,%si)\n",     &[0xdd, 0x78, 0x02]),
            (".code16\nfnstcw -2(%bp)\n",        &[0xd9, 0x7e, 0xfe]),
            (".code16\nfldl (%si)\n",            &[0xdd, 0x04]),
            (".code16\nfstpl 6(%di)\n",          &[0xdd, 0x5d, 0x06]),
            (".code16\nfistpl -4(%bp,%di)\n",    &[0xdb, 0x5b, 0xfc]),
            (".code16\nldmxcsr (%bx,%si)\n",     &[0x0f, 0xae, 0x10]),
            (".code16\nstmxcsr (%bp)\n",         &[0x0f, 0xae, 0x5e, 0x00]),
            (".code32\nfnstsw (%bx)\n",          &[0x67, 0xdd, 0x3f]),
            (".code32\nlcall *8(%bp,%si)\n",     &[0x67, 0xff, 0x5a, 0x08]),
            (".code32\nljmp *(%bx)\n",           &[0x67, 0xff, 0x2f]),
            ("fnstsw (%eax)\n",                  &[0x67, 0xdd, 0x38]),
            ("ldmxcsr (%ebx)\n",                 &[0x67, 0x0f, 0xae, 0x13]),
            ("cmpxchg16b (%ebx)\n",              &[0x67, 0x48, 0x0f, 0xc7, 0x0b]),
            ("movq (%ebx), %mm0\n",              &[0x67, 0x0f, 0x6f, 0x03]),
            ("movq %xmm3, (%edi)\n",             &[0x67, 0x66, 0x0f, 0xd6, 0x1f]),
            ("movq (%ecx), %xmm2\n",             &[0x67, 0xf3, 0x0f, 0x7e, 0x11]),
            ("mov %ds, (%eax)\n",                &[0x67, 0x8c, 0x18]),
            ("mov (%eax), %ds\n",                &[0x67, 0x8e, 0x18]),
            ("crc32w (%ebx), %ecx\n",            &[0x67, 0x66, 0xf2, 0x0f, 0x38, 0xf1, 0x0b]),
        ];
        for (src, want) in cases {
            assert_eq!(assemble(src), *want, "{src}");
        }
        // The 16-bit r/m forms carry no scale and only bx / bp with si / di.
        assert!(assemble_err(".code16\nfnstsw (%bx,%bp)\n").contains("bx / bp with si / di"));
        assert!(assemble_err(".code16\nfnstsw (%bx,%si,2)\n").contains("no scale"));
    }

    /// `mov` between a segment register and a GPR moves 16 bits: 8C writes
    /// and zero-extends, 8E reads. REX.W is unused in both directions, and
    /// 8E's operand size is the opcode's rather than the register's, so only
    /// an 8C with a 16-bit destination takes the `66` prefix. The GDT reload
    /// in `arch/x86/kernel/relocate_kernel_64.S` writes the 64-bit pair.
    /// Bytes measured with GNU as 2.46.1 for the same source.
    #[test]
    fn segment_register_moves_take_no_rex_w() {
        #[rustfmt::skip]
        let cases: &[(&str, &[u8])] = &[
            ("mov %ds, %rax\n",      &[0x8c, 0xd8]),
            ("mov %rax, %ds\n",      &[0x8e, 0xd8]),
            ("mov %ds, %eax\n",      &[0x8c, 0xd8]),
            ("mov %eax, %ds\n",      &[0x8e, 0xd8]),
            ("mov %ds, %ax\n",       &[0x66, 0x8c, 0xd8]),
            ("mov %ax, %ds\n",       &[0x8e, 0xd8]),
            ("mov %fs, %r8\n",       &[0x41, 0x8c, 0xe0]),
            ("mov %fs, %r8d\n",      &[0x41, 0x8c, 0xe0]),
            ("mov %fs, %r8w\n",      &[0x66, 0x41, 0x8c, 0xe0]),
            ("mov %r8, %fs\n",       &[0x41, 0x8e, 0xe0]),
            ("mov %r8w, %fs\n",      &[0x41, 0x8e, 0xe0]),
            ("mov %gs, %rbx\n",      &[0x8c, 0xeb]),
            ("mov %rbx, %gs\n",      &[0x8e, 0xeb]),
            ("mov %ds, (%rax)\n",    &[0x8c, 0x18]),
            ("mov (%rax), %ds\n",    &[0x8e, 0x18]),
            ("mov %ds, (%r9)\n",     &[0x41, 0x8c, 0x19]),
        ];
        for (src, want) in cases {
            assert_eq!(assemble(src), *want, "{src}");
        }
    }

    /// An explicit size suffix on `push` / `pop` selects the stack operand
    /// size in every mode: the `66` prefix when it is not the mode default,
    /// the immediate field width, and the shortest immediate form. Long mode
    /// has no 32-bit stack operand and the other modes no 64-bit one. Bytes
    /// measured with GNU as 2.46.1 and clang for the same source.
    #[test]
    fn push_pop_suffix_selects_the_stack_operand_size() {
        #[rustfmt::skip]
        let cases: &[(&str, &[u8])] = &[
            ("pushw (%rax)\n",           &[0x66, 0xff, 0x30]),
            ("popw (%rax)\n",            &[0x66, 0x8f, 0x00]),
            (".code16\npushl $0\n",      &[0x66, 0x6a, 0x00]),
            (".code16\npushw $0\n",      &[0x6a, 0x00]),
            (".code32\npushw $0\n",      &[0x66, 0x6a, 0x00]),
            ("pushw $0\n",               &[0x66, 0x6a, 0x00]),
            ("pushq $0\n",               &[0x6a, 0x00]),
            ("pushw $-129\n",            &[0x66, 0x68, 0x7f, 0xff]),
            (".code16\npushw $0x1234\n", &[0x68, 0x34, 0x12]),
            (".code16\npush $0x1234\n",  &[0x68, 0x34, 0x12]),
            (".code16\npushl $0x12345\n", &[0x66, 0x68, 0x45, 0x23, 0x01, 0x00]),
            (".code16\npushw (%bx)\n",   &[0xff, 0x37]),
            (".code16\npushl (%bx)\n",   &[0x66, 0xff, 0x37]),
            (".code16\npopl (%bx)\n",    &[0x66, 0x8f, 0x07]),
            (".code32\npushw (%eax)\n",  &[0x66, 0xff, 0x30]),
            (".code16\npushw %ax\n",     &[0x50]),
            (".code16\npushl %eax\n",    &[0x66, 0x50]),
            (".code16\npopl %eax\n",     &[0x66, 0x58]),
            ("pushw %ax\n",              &[0x66, 0x50]),
            ("popw %ax\n",               &[0x66, 0x58]),
        ];
        for (src, want) in cases {
            assert_eq!(assemble(src), *want, "{src}");
        }
        for src in [
            "pushl $0\n",
            ".code16\npushq $0\n",
            ".code32\npushq $0\n",
            ".code16\npushq %rax\n",
        ] {
            assert!(assemble_err(src).contains("not encodable"), "{src}");
        }
    }

    /// A `push` symbol immediate's field is the spelled operand size wide,
    /// so its relocation is too.
    #[test]
    fn push_symbol_immediate_field_follows_the_operand_size() {
        let s = alloc::string::String::from("s");
        let (bytes, relocs) = assemble_relocs(".code16\npushw $s\n");
        assert_eq!(bytes, [0x68, 0, 0]);
        assert_eq!(relocs, [(1, 2, false, s.clone(), 0)]);
        let (bytes, relocs) = assemble_relocs(".code16\npushl $s\n");
        assert_eq!(bytes, [0x66, 0x68, 0, 0, 0, 0]);
        assert_eq!(relocs, [(2, 4, false, s.clone(), 0)]);
        let (bytes, relocs) = assemble_relocs("pushw $s\n");
        assert_eq!(bytes, [0x66, 0x68, 0, 0]);
        assert_eq!(relocs, [(2, 2, false, s, 0)]);
    }
}
