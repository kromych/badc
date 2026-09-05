use super::*;

/// Per-function stack-frame layout. Every region is an explicit byte
/// count so the prologue and epilogue read the same values.
#[derive(Debug, Clone, Copy)]
pub(crate) struct Frame {
    /// Total frame the prologue allocates: locals + parameter cells +
    /// allocator spills + saved callee-saved registers.
    pub frame_bytes: u32,
    /// Byte distance from the frame base down to the allocator spill region.
    pub alloc_spill_base: u32,
    /// Bytes of the parameter cell region between the locals and the
    /// allocator spills: one 16-byte cell per register-carried parameter
    /// once some register parameter's home store survives, 0 otherwise.
    pub param_cells_bytes: u32,
    /// fp-relative offset of the lowest parameter cell; 0 when the region
    /// is empty.
    pub param_cells_off: i64,
    /// Some parameter is read from memory -- a cell or the incoming stack --
    /// through fp, so the function keeps a frame.
    pub param_home_needed: bool,
    /// Bytes a host-ABI variadic callee reserves above the frame record for
    /// its register save area, 0 otherwise.
    pub va_save_bytes: u32,
    /// Bytes reserved directly below the frame base for the stack-protector
    /// canary, 0 when unprotected; counted in `frame_bytes` and in
    /// `alloc_spill_base`.
    pub canary_bytes: u32,
    /// Whether the function clobbers (and therefore saves) x19.
    pub uses_x19: bool,
    /// Registers `-ffixed-` keeps out of every scratch pick.
    pub fixed_regs: super::FixedRegs,
    /// The FP scratch d-registers, outside the allocator's banks; see
    /// `RegBanks::fp_scratch`.
    pub fp_scratch: [u8; super::ssa::reg_alloc::FP_SCRATCH_COUNT],
    /// The ABI the function was lowered against; the home map reads its
    /// argument-register banks.
    pub abi: super::Abi,
    /// The body moves sp at runtime (`alloca`, C99 6.7.6.2 VLA) or the
    /// prologue realigns sp: spill slots are addressed through fp and the
    /// epilogue re-establishes sp from fp.
    pub dynamic_sp: bool,
    /// Alignment the prologue forces on sp for automatic objects aligned
    /// above 16 (C11 6.7.5), or 0. The realigned region sits below the static
    /// frame; the objects live at `[sp + region_off]`.
    pub realign_align: u32,
    /// Byte size of the realigned region, a multiple of 16.
    pub realign_region_bytes: u32,
    /// fp-relative offset (negative) of the over-aligned region when its
    /// alignment is exactly 16, or 0: fp and every region above it are
    /// 16-byte multiples, so no sp move is needed. The objects live at
    /// `[fp + align_region_off + region_off]`.
    pub align_region_off: i64,
    /// fp-relative offset (negative) of the inline-asm scratch region
    /// (operand captures and register saves), or 0. Frame storage rather
    /// than an sp carve: an `asm goto` label reached by a run-time-patched
    /// branch bypasses every teardown path, so sp must already be balanced
    /// there. Slot `off` lives at `[sp + frame_bytes + asm_scratch_off + off]`,
    /// fp-based when `dynamic_sp`.
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
    // The canary joins the top of the locals region; every fp-relative
    // offset shifts by it.
    let canary_bytes =
        super::ssa::emit_common::canary_bytes(func, declared_locals_bytes, abi.stack_protect);
    let locals_bytes = declared_locals_bytes + canary_bytes;
    let saved_fpr_bytes = super::ssa::emit_common::slots16(alloc.fp_used.len() as u32);
    // x19 gets a slot only when the function clobbers it (TLS, indirect
    // calls, intrinsics, a spilled modulo); `function_clobbers_scratch` is
    // the shared decision.
    let uses_x19 =
        !super::ssa::reg_alloc::function_clobbers_scratch(func, target, alloc.spill_count)
            .is_empty();
    let x19_save_bytes = if uses_x19 { 16u32 } else { 0 };
    // A region aligned exactly 16 joins the static frame between the spill
    // region and the saved registers; above 16 the prologue realigns sp. A
    // region with no surviving local access needs no bytes, as the locals
    // region itself (`compute_frame_base`).
    let region_bytes = func.realign_region_bytes.max(0) as u32;
    let static_region_bytes = if func.frame_align == 16 && declared_locals_bytes > 0 {
        region_bytes
    } else {
        0
    };
    // Inline-asm scratch below the spill region, sized for the largest
    // statement. A naked function has no frame and keeps the sp carve.
    let asm_bytes = if func.is_naked {
        0
    } else {
        asm_scratch_bytes(func, abi.fixed_regs)
    };
    // The parameter cells sit below the locals, whose offsets they leave
    // alone; every region below them shifts by their size.
    let param_cells_bytes = param_cells_bytes(func, alloc, abi);
    let upper_bytes = locals_bytes + param_cells_bytes;
    let frame_bytes = upper_bytes
        + alloc_spill_bytes
        + saved_gpr_bytes
        + saved_fpr_bytes
        + x19_save_bytes
        + asm_bytes
        + static_region_bytes;
    // A host variadic callee reserves its register save area above the
    // saved fp/lr, where its top edge meets the caller's stack arguments:
    // the Windows cursor `va_list` walks the two as one region. Windows on
    // ARM64 saves x0..x7 at an 8-byte stride, AAPCS64 both banks into 192
    // bytes read through `local_slot_off`.
    let va_save_bytes = if win_arm64_variadic_callee(func, abi) {
        WIN_ARM64_GR_SAVE_BYTES
    } else if aarch64_host_variadic_callee(func, abi) {
        AARCH64_VA_SAVE_BYTES
    } else {
        0
    };
    Frame {
        frame_bytes,
        alloc_spill_base: upper_bytes,
        canary_bytes,
        uses_x19,
        fixed_regs: abi.fixed_regs,
        fp_scratch: alloc.fp_scratch,
        param_cells_bytes,
        param_cells_off: if param_cells_bytes > 0 {
            -(upper_bytes as i64)
        } else {
            0
        },
        param_home_needed: param_home_needed(func, alloc, abi),
        va_save_bytes,
        abi,
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
            -((upper_bytes + alloc_spill_bytes + asm_bytes + static_region_bytes) as i64)
        } else {
            0
        },
        asm_scratch_off: if asm_bytes > 0 {
            -((upper_bytes + alloc_spill_bytes + asm_bytes) as i64)
        } else {
            0
        },
    }
}

/// Frame scratch bytes of the function's largest inline-asm statement: 8
/// per operand capture and 8 per saved GP / FP register, from the same
/// `asm_save_masks` the emitter saves by.
pub(super) fn asm_scratch_bytes(func: &FunctionSsa, fixed: super::FixedRegs) -> u32 {
    let mut max = 0u32;
    for inst in &func.insts {
        let Inst::InlineAsm { asm, args } = inst else {
            continue;
        };
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

/// The GP / FP register masks a statement saves around its template: the
/// clobber list (minus x16 / x17 and bit 31) plus every operand register.
/// `w` operands are a double or a 16-byte vector. A `-ffixed-` register
/// holds nothing of the compiler's and is never saved, as under gcc.
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

/// The Windows-on-ARM64 integer register save area: x0..x7 at an 8-byte
/// stride above the saved fp/lr, whose top edge meets the incoming stack.
pub(super) const WIN_ARM64_GR_SAVE_BYTES: u32 = 64;

/// A variadic callee under the Microsoft ARM64 convention: named and
/// variadic arguments alike ride x0..x7 then the stack. Among the
/// aarch64 targets only Windows sets `variadic_int_only`.
pub(super) fn win_arm64_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
    debug_assert!(
        !abi.variadic_int_only || matches!(abi.arch, super::Arch::Aarch64 | super::Arch::X86_64),
        "variadic_int_only is a Windows (aarch64 or x86_64) property"
    );
    func.is_variadic && abi.variadic_int_only && matches!(abi.arch, super::Arch::Aarch64)
}

/// The AAPCS64 register save area (Appendix B): x0..x7 at 8 bytes each,
/// then q0..q7 at 16 bytes each, 192 bytes above the saved fp/lr.
pub(super) const AARCH64_GR_SAVE_BYTES: u32 = 8 * 8;

const AARCH64_VR_SAVE_BYTES: u32 = 8 * 16;

pub(super) const AARCH64_VA_SAVE_BYTES: u32 = AARCH64_GR_SAVE_BYTES + AARCH64_VR_SAVE_BYTES;

/// A variadic callee under plain AAPCS64 (Linux): both argument-register
/// banks then the stack. macOS sets `variadic_on_stack` and Windows
/// `variadic_int_only`; this is the remaining target.
pub(super) fn aarch64_host_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
    func.is_variadic
        && matches!(abi.arch, super::Arch::Aarch64)
        && !abi.variadic_on_stack
        && !abi.variadic_int_only
}

/// Whether the callee spills its named parameters into c5 cdecl cells
/// through the per-parameter prologue path: every non-variadic callee,
/// and the macOS variadic ABI, whose named arguments arrive in registers.
/// The Windows and Linux variadic callees read theirs from their register
/// save areas.
pub(super) fn spills_named_params_on_entry(func: &FunctionSsa, abi: super::Abi) -> bool {
    !func.is_variadic || abi.variadic_on_stack
}

/// Incoming placement per declared parameter, from `plan_call_args`;
/// empty for a callee outside the cell-spill path. The int and FP
/// argument-register banks are independent (AAPCS64 6.4.1).
pub(super) fn param_placements(
    func: &FunctionSsa,
    abi: super::Abi,
) -> alloc::vec::Vec<super::ArgPlacement> {
    if !spills_named_params_on_entry(func, abi) || func.n_params == 0 {
        return alloc::vec::Vec::new();
    }
    super::ssa::emit_common::param_placements_common(func, abi)
}

/// `(n_reg, n_stack)`: how many declared parameters land in argument
/// registers and how many overflow to the host stack.
pub(super) fn param_reg_stack_split(func: &FunctionSsa, abi: super::Abi) -> (usize, usize) {
    let placements = param_placements(func, abi);
    let n_reg = placements.iter().filter(|p| register_carried(p)).count();
    (n_reg, placements.len() - n_reg)
}

/// fp-relative offset of the memory the body reads parameter `i` from.
/// A register-carried parameter takes a 16-byte cell inside the frame at
/// [`Frame::param_cells_off`], the cells in placement order; a
/// stack-passed one is read where the caller left it, at `[fp + 16 + off]`
/// (AAPCS64 6.4.2). A host variadic callee's named parameter comes from
/// its register save area instead.
pub(super) fn param_home_off(i: usize, func: &FunctionSsa, frame: Frame) -> i64 {
    use super::ArgPlacement as P;
    let abi = frame.abi;
    if let Some(off) = va_named_home_off(i, func, abi) {
        return off;
    }
    let placements = param_placements(func, abi);
    let Some(&p) = placements.get(i) else {
        unreachable!("ICE: parameter {i} has no placement");
    };
    match p {
        P::Stack(off) | P::StructByRefStack(off) | P::StructStack { off, .. } => 16 + off as i64,
        _ => {
            let cell = placements[..i]
                .iter()
                .filter(|q| register_carried(q))
                .count() as i64;
            frame.param_cells_off + 16 * cell
        }
    }
}

/// A placement that arrives in a register rather than on the incoming
/// stack.
fn register_carried(p: &super::ArgPlacement) -> bool {
    !matches!(
        p,
        super::ArgPlacement::Stack(_)
            | super::ArgPlacement::StructByRefStack(_)
            | super::ArgPlacement::StructStack { .. }
    )
}

/// The register save area slot a host variadic callee reads named
/// parameter `i` from, or `None` for a callee that homes its parameters
/// itself. The area sits above the saved fp/lr: Windows on ARM64 keeps
/// x0..x7 at an 8-byte stride, AAPCS64 (Appendix B) the general bank at
/// `[fp + 16]` and the vector bank at `[fp + 80]`, with a named
/// parameter past the registers on the incoming stack above the area.
fn va_named_home_off(i: usize, func: &FunctionSsa, abi: super::Abi) -> Option<i64> {
    if win_arm64_variadic_callee(func, abi) {
        return Some(16 + (i as i64) * 8);
    }
    if !aarch64_host_variadic_callee(func, abi) {
        return None;
    }
    let plan = super::plan_param_regs(func.n_params, func.param_fp_mask, abi);
    let rank = |pred: fn(&super::ArgPlacement) -> bool| {
        plan.placements[..i].iter().filter(|q| pred(q)).count() as i64
    };
    Some(match plan.placements.get(i) {
        Some(super::ArgPlacement::Stack(soff)) => 16 + AARCH64_VA_SAVE_BYTES as i64 + *soff as i64,
        Some(super::ArgPlacement::FpReg(_)) => {
            16 + AARCH64_GR_SAVE_BYTES as i64
                + rank(|q| matches!(q, super::ArgPlacement::FpReg(_))) * 16
        }
        _ => 16 + rank(|q| matches!(q, super::ArgPlacement::IntReg(_))) * 8,
    })
}

/// `mask[i]`: parameter `i` is a register-passed scalar read only through
/// a surviving `Inst::ParamRef`, so the memory home the prologue would
/// fill is unobserved and the store is dead (C99 6.2.4p2). Empty for a
/// callee that reads its named parameters from a register save area.
pub(super) fn param_elidable_mask(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> alloc::vec::Vec<bool> {
    let placements = param_placements(func, abi);
    if placements.is_empty() {
        return alloc::vec::Vec::new();
    }
    let (seeded, addr_taken, needed) = super::ssa::emit_common::scan_param_slot_usage(func, alloc);
    placements
        .iter()
        .enumerate()
        .map(|(i, p)| {
            let slot = (i as i64) + 2;
            matches!(
                p,
                super::ArgPlacement::IntReg(_) | super::ArgPlacement::FpReg(_)
            ) && seeded.contains(&(i as u32))
                && !addr_taken.contains(&slot)
                && !needed.contains(&slot)
        })
        .collect()
}

/// Bytes of the parameter cell region: one cell per register-carried
/// parameter, reserved once some register scalar's home store survives so
/// the cells keep their offsets, and nothing when every one of them is
/// elidable.
fn param_cells_bytes(func: &FunctionSsa, alloc: &Allocation, abi: super::Abi) -> u32 {
    let placements = param_placements(func, abi);
    let elidable = param_elidable_mask(func, alloc, abi);
    let any_needed = placements.iter().enumerate().any(|(i, p)| {
        matches!(
            p,
            super::ArgPlacement::IntReg(_) | super::ArgPlacement::FpReg(_)
        ) && !elidable[i]
    });
    if !any_needed {
        return 0;
    }
    16 * placements.iter().filter(|p| register_carried(p)).count() as u32
}

/// Whether any parameter is read from memory: a register scalar whose home
/// store survives, or one that arrives on the incoming stack. A
/// register-passed aggregate lives in its body local.
fn param_home_needed(func: &FunctionSsa, alloc: &Allocation, abi: super::Abi) -> bool {
    let placements = param_placements(func, abi);
    let elidable = param_elidable_mask(func, alloc, abi);
    placements.iter().enumerate().any(|(i, p)| match p {
        super::ArgPlacement::IntReg(_) | super::ArgPlacement::FpReg(_) => !elidable[i],
        super::ArgPlacement::StructRegs { .. } | super::ArgPlacement::StructByRefReg(_) => false,
        _ => true,
    })
}

/// A function with no call, no frame, no parameter read from memory and no
/// callee-saved register skips the frame record and returns off the
/// caller's lr.
pub(super) fn is_full_leaf(func: &FunctionSsa, frame: Frame, alloc: &Allocation) -> bool {
    if frame.frame_bytes != 0
        || frame.va_save_bytes != 0
        || frame.param_home_needed
        || frame.uses_x19
    {
        return false;
    }
    // Realigning sp needs fp to restore it on exit.
    if frame.realign_align != 0 {
        return false;
    }
    if !alloc.gpr_used.is_empty() || !alloc.fp_used.is_empty() {
        return false;
    }
    super::ssa::emit_common::function_makes_no_calls(func)
}

/// Whether the function signs its return address under
/// `-mbranch-protection=pac-ret`: `paciasp` before the first sp move and
/// `autiasp` after the last sp restore, the window in which sp -- the
/// modifier -- holds its entry value. A full leaf stores no return
/// address and a `TailExt` forwarder runs no epilogue, so neither signs.
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

/// The emitter's scratch registers: x16 (IP0) and x17 (IP1), which
/// AAPCS64 reserves for intra-procedure use, outside the allocator's
/// banks.
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
