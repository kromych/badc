use super::*;

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
    /// Bytes reserved directly below the frame base for the stack-protector
    /// canary, 0 when the function is unprotected. Counted in `frame_bytes`
    /// and in `alloc_spill_base`; every local slot sits below the region, so
    /// the canary is between the locals and the saved return address.
    pub canary_bytes: u32,
    /// rbp-relative byte offset (negative) of the over-aligned region when the
    /// region alignment is exactly 16, or 0 when none. rbp and every frame
    /// region above it are 16-byte multiples, so the region base is 16-aligned
    /// with no rsp move; its bytes are counted in `frame_bytes` and the
    /// objects live at `[rbp + align_region_off + region_off]`.
    pub align_region_off: i64,
    /// Registers `-ffixed-` keeps out of every scratch pick.
    pub fixed_regs: super::FixedRegs,
    /// The FP scratch xmm registers, outside the allocator's banks; see
    /// `RegBanks::fp_scratch`.
    pub fp_scratch: [u8; super::ssa::reg_alloc::FP_SCRATCH_COUNT],
}

pub(crate) fn compute_frame(func: &FunctionSsa, alloc: &Allocation, abi: super::Abi) -> Frame {
    let (declared_locals_bytes, alloc_spill_bytes, saved_gpr_bytes) =
        super::ssa::emit_common::compute_frame_base(func, alloc);
    // The canary region joins the top of the locals region, so every offset
    // measured down from rbp shifts by it and no other region formula changes.
    let canary_bytes =
        super::ssa::emit_common::canary_bytes(func, declared_locals_bytes, abi.stack_protect);
    let locals_bytes = declared_locals_bytes + canary_bytes;
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
    let asm_bytes = asm_scratch_bytes(func, abi.fixed_regs);
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
    let static_region_bytes = if func.frame_align == 16 && declared_locals_bytes > 0 {
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
        canary_bytes,
        fixed_regs: abi.fixed_regs,
        fp_scratch: alloc.fp_scratch,
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
pub(super) fn asm_scratch_bytes(func: &FunctionSsa, fixed: super::FixedRegs) -> u32 {
    let mut max = 0u32;
    for inst in &func.insts {
        let Inst::InlineAsm { asm, args } = inst else {
            continue;
        };
        // A no-op statement emits no staging (`emit_inline_asm`), so it
        // needs no scratch.
        if crate::c5::asm::asm_statement_is_noop(asm, crate::c5::asm::AsmComments::X86) {
            continue;
        }
        let Ok(op_reg) = super::asm::assign_operand_regs(
            &asm.operands,
            asm.clobber_regs | fixed.gpr,
            asm.clobber_fp_regs | fixed.fpr,
            &|i| {
                args.get(i)
                    .and_then(|&a| crate::c5::asm::asm_operand_const(func, a))
            },
        ) else {
            continue;
        };
        let Ok((used, fp_used, _)) = asm_save_masks_and_stage(asm, &op_reg, fixed) else {
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
/// the frame region always covers the emitted save list. A `-ffixed-`
/// register holds nothing of the compiler's, so it is neither the stage
/// nor saved: a write the template makes to it stays, as under gcc.
pub(super) fn asm_save_masks_and_stage(
    asm: &super::super::ir::AsmBlock,
    op_reg: &[Option<u8>],
    fixed: super::FixedRegs,
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
    let free = |r: u8| operand_gp & (1 << r) == 0 && !fixed.has_gpr(r);
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
    Ok((used & !fixed.gpr, fp_used & !fixed.fpr, Reg(stage)))
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
pub(super) fn win64_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
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
pub(super) const SYSV_GP_SAVE_BYTES: u32 = 6 * 8;
const SYSV_FP_SAVE_BYTES: u32 = 8 * 16;
pub(super) const SYSV_REG_SAVE_BYTES: u32 = SYSV_GP_SAVE_BYTES + SYSV_FP_SAVE_BYTES;

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
pub(super) fn sysv_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
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
pub(super) fn pick_caller_saved_scratch(
    rd: Reg,
    operand_regs: &[Reg],
    fixed: super::FixedRegs,
) -> Option<Reg> {
    for cand in CALLER_SAVED_INT_SCRATCHES {
        if *cand == rd.0 || fixed.has_gpr(*cand) {
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
    fixed: super::FixedRegs,
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
    pick_caller_saved_scratch(rd, &live, fixed)
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
pub(super) fn is_full_leaf(
    func: &FunctionSsa,
    frame: Frame,
    alloc: &Allocation,
    abi: super::Abi,
) -> bool {
    if frame.frame_bytes != 0 || frame.param_spill_bytes != 0 || abi.mcount_frame {
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
pub(super) fn param_placements(
    func: &FunctionSsa,
    abi: super::Abi,
) -> alloc::vec::Vec<super::ArgPlacement> {
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

pub(super) fn param_elidable_mask(
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
pub(super) fn compute_param_from_home(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> alloc::vec::Vec<bool> {
    param_home_clobber_set(func, alloc, abi)
}
