use super::*;

/// Per-function stack-frame layout. Every region is an explicit byte
/// count, 16-aligned at each boundary, so the prologue and the epilogue
/// read the same values.
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
    // A System V variadic callee's register save area (ABI 3.5.7) takes the
    // lowest bytes of the frame; the rbp-relative regions above it keep
    // their offsets.
    let va_save_bytes = if sysv_variadic_callee(func, abi) {
        SYSV_REG_SAVE_BYTES
    } else {
        0
    };
    let va_reg_save_off = if va_save_bytes > 0 {
        -((locals_bytes + alloc_spill_bytes + va_save_bytes) as i32)
    } else {
        0
    };
    // Win64: the saved non-volatile xmm scratch, 16 bytes each, below the
    // saved GPRs.
    let saved_fpr_bytes = alloc.fp_used.len() as u32 * 16;
    // The inline-asm scratch region, sized for the largest statement.
    let asm_bytes = asm_scratch_bytes(func, abi.fixed_regs);
    let asm_scratch_off = if asm_bytes > 0 {
        -((locals_bytes + alloc_spill_bytes + va_save_bytes + asm_bytes) as i32)
    } else {
        0
    };
    // A region aligned to exactly 16 joins the static frame, whose regions
    // above it are all 16-byte multiples; above 16 the prologue realigns rsp
    // instead. A region with no emitted access needs no bytes, as
    // `compute_frame_base` decides for the locals.
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
    // A Win64 variadic callee reads its named parameters and walks the
    // variadic tail across one contiguous 8-byte-per-argument region (the
    // home area, then the incoming stack), so its cell stride is 8.
    let param_cell_stride = if win64_variadic_callee(func, abi) {
        8
    } else {
        16
    };
    // An automatic object aligned above 16 lives in a realigned region below
    // the static frame, addressed through rsp; the frame is then dynamic-sp
    // (C11 6.7.5).
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
        // A no-op statement stages nothing.
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
/// body, and the register its captures, loads and store-backs stage
/// through. The stage may not alias an operand register (a
/// `register T v asm("reg")` binding can pin one to any GPR), so it is
/// picked per statement: r10 / r11, else a clobbered non-operand register,
/// else a free allocator-visible register added to the save mask. A
/// `-ffixed-` register is neither staged through nor saved.
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

/// A variadic callee under the Win64 host variadic ABI, the only x86_64
/// `Abi` with `position_indexed_args`: the named arguments arrive in
/// registers and the variadic tail on the incoming stack at 8-byte stride.
pub(super) fn win64_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
    debug_assert!(
        !abi.position_indexed_args || matches!(abi.arch, super::Arch::X86_64),
        "position_indexed_args is a Win64 x86_64 property"
    );
    func.is_variadic && abi.position_indexed_args
}

/// The System V AMD64 register save area (ABI 3.5.7): rdi rsi rdx rcx r8 r9
/// at `[base .. 48]`, then xmm0..xmm7 at `[base + 48 .. 176]`.
pub(super) const SYSV_GP_SAVE_BYTES: u32 = 6 * 8;
const SYSV_FP_SAVE_BYTES: u32 = 8 * 16;
pub(super) const SYSV_REG_SAVE_BYTES: u32 = SYSV_GP_SAVE_BYTES + SYSV_FP_SAVE_BYTES;

/// A variadic callee under the System V AMD64 host variadic ABI (Linux
/// x86_64): the standard register banks then the stack, the register save
/// area (ABI 3.5.7) spilled by the prologue, and `al` carrying the XMM
/// argument count.
pub(super) fn sysv_variadic_callee(func: &FunctionSsa, abi: super::Abi) -> bool {
    func.is_variadic
        && matches!(abi.arch, super::Arch::X86_64)
        && abi.shadow_space == 0
        && !abi.position_indexed_args
        && abi.variadic_zero_xmm_count
}

/// Registers caller-saved on both System V AMD64 and Win64 (rsi and rdi
/// are callee-saved on Win64), less the reserved r10 / r11: the pool for an
/// additional scratch, rax first as it is rarely an argument.
const CALLER_SAVED_INT_SCRATCHES: &[u8] = &[0, 1, 2, 8, 9];

/// A caller-saved GPR that is neither `rd` nor in `operand_regs`; `None`
/// when the pool is exhausted, so the caller bails rather than take a
/// callee-saved register.
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

/// `pick_caller_saved_scratch` avoiding also every register holding an SSA
/// value live across instruction `pc` (`x < pc < last_use[x]`).
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

/// A function that needs no frame at all: nothing to reserve, no parameter
/// spill, no callee-saved register, no call; the return address stays at
/// the top of the stack and `ret` returns directly.
pub(super) fn is_full_leaf(
    func: &FunctionSsa,
    frame: Frame,
    alloc: &Allocation,
    abi: super::Abi,
) -> bool {
    if frame.frame_bytes != 0 || frame.param_spill_bytes != 0 || abi.mcount_frame {
        return false;
    }
    // Realigning rsp needs the frame pointer to restore it.
    if frame.realign_align != 0 {
        return false;
    }
    // A host variadic callee needs rbp and a frame for the home area or the
    // register save area.
    if win64_variadic_callee(func, abi) {
        return false;
    }
    if sysv_variadic_callee(func, abi) {
        return false;
    }
    if !alloc.gpr_used.is_empty() {
        return false;
    }
    if !alloc.fp_used.is_empty() {
        return false;
    }
    super::ssa::emit_common::function_makes_no_calls(func)
}

/// Each declared parameter's incoming placement from `plan_call_args`;
/// empty for a variadic or zero-parameter callee.
pub(super) fn param_placements(
    func: &FunctionSsa,
    abi: super::Abi,
) -> alloc::vec::Vec<super::ArgPlacement> {
    if func.is_variadic || func.n_params == 0 {
        return alloc::vec::Vec::new();
    }
    super::ssa::emit_common::param_placements_common(func, abi)
}

/// How many declared parameters land in registers and how many overflow to
/// the host stack. The prologue fills each cell from its own placement, so
/// the two need not form a contiguous prefix and suffix.
fn param_reg_stack_split(func: &FunctionSsa, abi: super::Abi) -> (usize, usize) {
    let placements = param_placements(func, abi);
    let n_reg = placements
        .iter()
        .filter(|p| !matches!(p, super::ArgPlacement::Stack(_)))
        .count();
    (n_reg, placements.len() - n_reg)
}

/// `(elidable, n_reg, n_stack)`: `elidable[i]` holds when parameter `i` is
/// read only through a surviving `Inst::ParamRef`, so the c5 cdecl cell the
/// prologue would fill at `[rbp + 16*(i+1)]` is unobserved. Empty for a
/// variadic or zero-parameter callee; a stack-passed parameter is never
/// elidable.
pub(super) fn param_elidable_mask(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> (alloc::vec::Vec<bool>, usize, usize) {
    if func.is_variadic || func.n_params == 0 {
        return (alloc::vec::Vec::new(), 0, 0);
    }
    // Independent int / FP banks (System V AMD64 3.2.3): the register count
    // comes from the plan, not from `int_arg_regs.len()`.
    let (n_reg, n_stack) = param_reg_stack_split(func, abi);
    let (seeded, addr_taken, needed) = super::ssa::emit_common::scan_param_slot_usage(func, alloc);
    // A parameter whose argument register a per-inst `ParamRef` clobbers
    // keeps its home cell, mem2reg promotion notwithstanding; see
    // `compute_param_from_home`.
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

/// The register parameters the per-inst `Inst::ParamRef` path lowers
/// after an earlier `ParamRef`'s write clobbered their incoming argument
/// register. The entry parallel copy places every register parameter at
/// once when their homes are pairwise distinct, so the mask is empty then;
/// otherwise the marked parameters read their prologue-spilled c5 cdecl
/// home cell. The mask depends only on `alloc.places` and the `ParamRef`
/// order, so the elidability scan and the prologue consult it without a
/// fixpoint.
fn param_home_clobber_set(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> alloc::vec::Vec<bool> {
    if func.is_variadic || func.n_params == 0 {
        return alloc::vec::Vec::new();
    }
    // Integer and FP parameters arrive in separate banks; each bank is
    // tracked on its own.
    let param_plan = param_placements(func, abi);
    let n_reg = param_plan
        .iter()
        .filter(|p| !matches!(p, super::ArgPlacement::Stack(_)))
        .count();
    let mut mask = alloc::vec![false; n_reg];
    if n_reg == 0 {
        return mask;
    }
    // FP parameters always take the per-inst path, so the same hazard applies
    // within the FP bank.
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
    // The entry parallel copy's eligibility and `homes_distinct` gate,
    // mirrored.
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

/// Bytes the prologue reserves for c5 cdecl parameter cells and host-stack
/// overflow, from the branch structure the prologue uses: nothing for a
/// variadic callee (the caller pushes the cells), `n_reg * 16` or 0 when
/// every register parameter's cell is elidable, else `n_params * 16`.
fn prologue_param_spill_bytes(func: &FunctionSsa, alloc: &Allocation, abi: super::Abi) -> u32 {
    let (elidable, n_reg, n_stack) = param_elidable_mask(func, alloc, abi);
    // The register stripe stays allocated while any parameter needs its cell,
    // so the cdecl offsets stay stable; each elidable store is skipped at
    // emit time.
    let any_reg_needed = elidable.iter().any(|e| !e);
    let reg_bytes = if any_reg_needed || n_stack > 0 {
        (n_reg as u32) * 16
    } else {
        0
    };
    let overflow_bytes = (n_stack as u32) * 16;
    reg_bytes + overflow_bytes
}

/// `mask[idx]`: the per-inst `Inst::ParamRef` of register parameter `idx`
/// reads its prologue-spilled home cell instead of the incoming argument
/// register, because an earlier `ParamRef`'s destination overwrote it. The
/// set is `param_home_clobber_set`; each member is forced non-elidable, so
/// its home cell exists.
pub(super) fn compute_param_from_home(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> alloc::vec::Vec<bool> {
    param_home_clobber_set(func, alloc, abi)
}
