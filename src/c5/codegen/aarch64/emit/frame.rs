use super::*;

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
    /// Bytes reserved directly below the frame base for the stack-protector
    /// canary, 0 when the function is unprotected. Counted in `frame_bytes`
    /// and in `alloc_spill_base`; every local slot sits below the region, so
    /// the canary is between the locals and the saved return address.
    pub canary_bytes: u32,
    /// Whether the function clobbers (and therefore saves) x19.
    pub uses_x19: bool,
    /// Registers `-ffixed-` keeps out of every scratch pick.
    pub fixed_regs: super::FixedRegs,
    /// The FP scratch d-registers, outside the allocator's banks; see
    /// `RegBanks::fp_scratch`.
    pub fp_scratch: [u8; super::ssa::reg_alloc::FP_SCRATCH_COUNT],
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

pub(crate) fn compute_frame(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
    target: Target,
) -> Frame {
    let (declared_locals_bytes, alloc_spill_bytes, saved_gpr_bytes) =
        super::ssa::emit_common::compute_frame_base(func, alloc);
    // The canary region joins the top of the locals region, so every offset
    // measured down from fp shifts by it and no other region formula changes.
    let canary_bytes =
        super::ssa::emit_common::canary_bytes(func, declared_locals_bytes, abi.stack_protect);
    let locals_bytes = declared_locals_bytes + canary_bytes;
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
    let static_region_bytes = if func.frame_align == 16 && declared_locals_bytes > 0 {
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
        asm_scratch_bytes(func, abi.fixed_regs)
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
        canary_bytes,
        uses_x19,
        fixed_regs: abi.fixed_regs,
        fp_scratch: alloc.fp_scratch,
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
pub(super) fn asm_scratch_bytes(func: &FunctionSsa, fixed: super::FixedRegs) -> u32 {
    let mut max = 0u32;
    for inst in &func.insts {
        let Inst::InlineAsm { asm, args } = inst else {
            continue;
        };
        // A no-op statement emits no staging (`emit_inline_asm_aarch64`),
        // so it needs no scratch.
        if crate::c5::asm::asm_statement_is_noop(asm, crate::c5::asm::AsmComments::A64) {
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
        let Ok((used, fp_used)) = asm_save_masks(asm, &op_reg, fixed) else {
            continue;
        };
        let n_cap = op_reg.iter().flatten().count() as u32;
        max = max.max((n_cap + used.count_ones() + fp_used.count_ones()) * 8);
    }
    (max + 15) & !15
}

/// The GP / FP register masks an inline-asm statement saves around its
/// template: the clobber list (minus the emitter's x16/x17 scratch and
/// bit 31) plus every operand register. `w` operands must be a double
/// or a 16-byte vector (the SSA model's only FP shapes). A `-ffixed-`
/// register holds nothing of the compiler's, so it is never saved: a
/// write the template makes to it stays, as under gcc.
pub(super) fn asm_save_masks(
    asm: &super::super::ir::AsmBlock,
    op_reg: &[Option<u8>],
    fixed: super::FixedRegs,
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
    Ok((used & !fixed.gpr, fp_used & !fixed.fpr))
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
pub(super) const WIN_ARM64_GR_SAVE_BYTES: u32 = 64;

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
pub(super) fn win_arm64_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
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
pub(super) const AARCH64_GR_SAVE_BYTES: u32 = 8 * 8;

const AARCH64_VR_SAVE_BYTES: u32 = 8 * 16;

pub(super) const AARCH64_VA_SAVE_BYTES: u32 = AARCH64_GR_SAVE_BYTES + AARCH64_VR_SAVE_BYTES;

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
pub(super) fn aarch64_host_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
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
pub(super) fn spills_named_params_on_entry(func: &FunctionSsa, abi: super::Abi) -> bool {
    !func.is_variadic || abi.variadic_on_stack
}

/// Per-parameter incoming-register placement from `plan_call_args`.
/// Indexed by declared parameter position. A variadic callee that reads
/// its named parameters outside the generic cell-spill path (Windows
/// arm64 and Linux aarch64) and zero-param callees yield an empty plan.
/// Independent int / FP argument-register banks (AAPCS64 6.4.1) mean an
/// FP parameter is placed in d0..d7 without shifting the integer bank.
pub(super) fn param_placements(
    func: &FunctionSsa,
    abi: super::Abi,
) -> alloc::vec::Vec<super::ArgPlacement> {
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
pub(super) fn param_reg_stack_split(func: &FunctionSsa, abi: super::Abi) -> (usize, usize) {
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
pub(super) fn params_interleaved(func: &FunctionSsa, abi: super::Abi) -> bool {
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
pub(super) fn is_full_leaf(func: &FunctionSsa, frame: Frame, alloc: &Allocation) -> bool {
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
pub(super) fn signs_return_address(
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

/// Per-function scratch register reservation. AAPCS64 calls x16
/// (IP0) and x17 (IP1) scratch; the SSA emit uses them for
/// reload / store sequences without recording them on the
/// allocator's `gpr_used` list.
pub(super) struct ScratchPool {
    pub(super) primary: Reg,
    pub(super) secondary: Reg,
}

impl ScratchPool {
    pub(super) fn new() -> Self {
        Self {
            primary: Reg(16),
            secondary: Reg(17),
        }
    }
}
