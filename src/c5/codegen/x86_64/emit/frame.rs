use super::*;

/// Per-function stack-frame layout. Every region is an explicit byte
/// count, 16-aligned at each boundary, so the prologue and the epilogue
/// read the same values.
#[derive(Debug, Clone, Copy)]
pub(crate) struct Frame {
    /// Total frame the prologue allocates: locals + parameter cells +
    /// allocator spills + saved callee-saved registers + any register-save
    /// area.
    pub frame_bytes: u32,
    /// Byte distance from the frame base down to the allocator spill region.
    pub alloc_spill_base: u32,
    /// Bytes of the parameter cell region between the locals and the
    /// allocator spills: one 16-byte cell per register-carried parameter of
    /// a System V callee that reads a register parameter from memory, 0
    /// otherwise (`param_home_off`).
    pub param_cells_bytes: u32,
    /// rbp-relative offset of the lowest parameter cell; 0 when the region
    /// is empty.
    pub param_cells_off: i32,
    /// Some parameter is read from memory -- a cell, the Win64 home area or
    /// the incoming stack -- through rbp, so the function keeps a frame.
    pub param_home_needed: bool,
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
    /// A statement whose template writes rbp addresses it through rsp
    /// instead, at `[rsp + frame_bytes + asm_scratch_off]`.
    pub asm_scratch_off: i32,
    /// rsp does not keep its prologue value across the body: it moves at
    /// run time (`alloca` / C99 6.7.6.2 VLA), the prologue realigns it for an
    /// automatic object aligned above 16, or an inline asm statement may leave
    /// it moved (`AsmBlock::may_move_sp`), as a stack switch does. Spill slots
    /// are addressed through rbp and the epilogue re-establishes rsp from rbp
    /// before tearing the frame down.
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
    /// The body makes a call or holds an intrinsic whose lowering needs the
    /// frame record (`body_keeps_frame_record`).
    pub keeps_record: bool,
    /// Registers `-ffixed-` keeps out of every scratch pick.
    pub fixed_regs: super::FixedRegs,
    /// The FP scratch xmm registers, outside the allocator's banks; see
    /// `RegBanks::fp_scratch`.
    pub fp_scratch: [u8; super::ssa::reg_alloc::FP_SCRATCH_COUNT],
    /// The regions `frame_bytes` sums.
    pub parts: super::ssa::emit_common::FrameStack,
}

pub(crate) fn compute_frame(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
    target: Target,
) -> Frame {
    let base = super::ssa::emit_common::compute_frame_base(func, alloc);
    let (declared_locals_bytes, alloc_spill_bytes, saved_gpr_bytes) =
        (base.locals, base.spills, base.saved_gprs);
    // The canary region joins the top of the locals region, so every offset
    // measured down from rbp shifts by it and no other region formula changes.
    let canary_bytes = super::ssa::emit_common::canary_bytes(func, &base, abi.stack_protect);
    let locals_bytes = declared_locals_bytes + canary_bytes;
    // The parameter cells sit below the locals, whose offsets they leave
    // alone; every region below them shifts by their size.
    let param_cells_bytes = param_cells_bytes(func, alloc, abi);
    let upper_bytes = locals_bytes + param_cells_bytes;
    // A System V variadic callee's register save area (ABI 3.5.7) takes the
    // lowest bytes of the frame; the rbp-relative regions above it keep
    // their offsets.
    let va_save_bytes = if sysv_variadic_callee(func, abi) {
        SYSV_REG_SAVE_BYTES
    } else {
        0
    };
    let va_reg_save_off = if va_save_bytes > 0 {
        -((upper_bytes + alloc_spill_bytes + va_save_bytes) as i32)
    } else {
        0
    };
    // Win64: the saved non-volatile xmm scratch, 16 bytes each, above the
    // saved GPRs, which the prologue pushes at the frame bottom.
    let saved_fpr_bytes = alloc.fp_used.len() as u32 * 16;
    // The inline-asm scratch region, sized for the largest statement. A
    // naked function has no frame and stages nothing.
    let asm_bytes = if func.is_naked {
        0
    } else {
        asm_scratch_bytes(func, alloc, abi.fixed_regs, target)
    };
    let asm_scratch_off = if asm_bytes > 0 {
        -((upper_bytes + alloc_spill_bytes + va_save_bytes + asm_bytes) as i32)
    } else {
        0
    };
    // A region aligned to exactly 16 joins the static frame, whose regions
    // above it are all 16-byte multiples; above 16 the prologue realigns rsp
    // instead.
    let region_bytes = func.realign_region_bytes.max(0) as u32;
    let static_region_bytes = base.static_region;
    let frame_bytes = upper_bytes
        + alloc_spill_bytes
        + saved_gpr_bytes
        + va_save_bytes
        + saved_fpr_bytes
        + asm_bytes
        + static_region_bytes;
    // An automatic object aligned above 16 lives in a realigned region below
    // the static frame, addressed through rsp; the frame is then dynamic-sp
    // (C11 6.7.5).
    let realign_align = if func.frame_align > 16 {
        func.frame_align as u32
    } else {
        0
    };
    let mut frame = Frame {
        frame_bytes,
        alloc_spill_base: upper_bytes,
        canary_bytes,
        keeps_record: super::ssa::emit_common::body_keeps_frame_record(func, target, |i| {
            intrinsic_keeps_frame(i, abi)
        }),
        fixed_regs: abi.fixed_regs,
        fp_scratch: alloc.fp_scratch,
        parts: super::ssa::emit_common::FrameStack {
            record: 0,
            locals: declared_locals_bytes,
            param_cells: param_cells_bytes,
            spills: alloc_spill_bytes,
            saved_regs: saved_gpr_bytes + saved_fpr_bytes,
            va_save: va_save_bytes,
            asm_scratch: asm_bytes,
            canary: canary_bytes,
            aligned: static_region_bytes,
        },
        param_cells_bytes,
        param_cells_off: if param_cells_bytes > 0 {
            -(upper_bytes as i32)
        } else {
            0
        },
        param_home_needed: param_home_needed(func, alloc, abi),
        va_reg_save_off,
        saved_fpr_bytes,
        asm_scratch_off,
        dynamic_sp: super::ssa::emit_common::uses_dynamic_alloca(func) || realign_align > 0,
        realign_align,
        realign_region_bytes: if realign_align > 0 { region_bytes } else { 0 },
        align_region_off: if static_region_bytes > 0 {
            -((upper_bytes + alloc_spill_bytes + va_save_bytes + asm_bytes + static_region_bytes)
                as i64)
        } else {
            0
        },
    };
    // A full leaf has nothing to address and no rbp to restore rsp from.
    frame.dynamic_sp |= func.has_sp_moving_asm() && !is_full_leaf(func, frame, alloc, abi);
    frame
}

/// Bytes of frame scratch one inline-asm statement needs: 16 per saved
/// xmm, 8 per saved GP register. `None` when the statement stages nothing
/// or its operands do not assign.
fn asm_stmt_bytes(
    func: &FunctionSsa,
    alloc: &Allocation,
    fixed: super::FixedRegs,
    target: Target,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
) -> Option<u32> {
    if crate::c5::asm::asm_statement_is_noop(asm, crate::c5::asm::AsmComments::X86)
        || asm_binds_directly(func, asm, args, fixed, target)
    {
        return None;
    }
    let op_reg = asm_operand_regs(func, asm, args, fixed).ok()?;
    let preserve = alloc.asm_preserve;
    let (used, fp_used, _) = asm_save_masks_and_stage(asm, &op_reg, fixed, preserve).ok()?;
    Some(fp_used.count_ones() * 16 + used.count_ones() * 8)
}

/// The constant value of operand `i`, if its argument folds to one.
pub(super) fn asm_operand_const_at(func: &FunctionSsa, args: &[u32], i: usize) -> Option<i64> {
    args.get(i)
        .and_then(|&a| crate::c5::asm::asm_operand_const(func, a))
}

/// Statements share the scratch region -- each one's slots are dead at
/// its own end -- unless a template names the stack pointer. Such a
/// block can be resumed by a jump from outside the control-flow graph,
/// after a later statement has reused the region, so its store-back
/// would read that statement's value as the output address. Every
/// statement then owns a slice of its own.
fn asm_regions_are_private(func: &FunctionSsa) -> bool {
    func.has_sp_asm()
}

/// Bytes of frame scratch the function's inline asm needs: the largest
/// statement, or the sum where the statements do not share
/// ([`asm_regions_are_private`]).
pub(super) fn asm_scratch_bytes(
    func: &FunctionSsa,
    alloc: &Allocation,
    fixed: super::FixedRegs,
    target: Target,
) -> u32 {
    let private = asm_regions_are_private(func);
    let mut bytes = 0u32;
    for inst in &func.insts {
        let Inst::InlineAsm { asm, args } = inst else {
            continue;
        };
        let Some(n) = asm_stmt_bytes(func, alloc, fixed, target, asm, args) else {
            continue;
        };
        bytes = if private { bytes + n } else { bytes.max(n) };
    }
    super::ssa::emit_common::align16(bytes)
}

/// Byte offset of one statement's slice from the region base: zero while
/// the statements share it, else the sum of the slices ahead of it.
pub(super) fn asm_region_offset(
    func: &FunctionSsa,
    alloc: &Allocation,
    fixed: super::FixedRegs,
    target: Target,
    site: usize,
) -> u32 {
    if !asm_regions_are_private(func) {
        return 0;
    }
    let mut off = 0u32;
    for inst in func.insts.iter().take(site) {
        let Inst::InlineAsm { asm, args } = inst else {
            continue;
        };
        off += asm_stmt_bytes(func, alloc, fixed, target, asm, args).unwrap_or(0);
    }
    off
}

/// The operand register assignment one statement's lowering makes; the
/// frame sizing, the allocator's clobber view and the emit all read it.
pub(super) fn asm_operand_regs(
    func: &FunctionSsa,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    fixed: super::FixedRegs,
) -> Result<alloc::vec::Vec<Option<u8>>, alloc::string::String> {
    use super::super::ir::{AsmConstraint, AsmSeg};
    super::asm::assign_operand_regs(
        &asm.operands,
        asm.clobber_regs | fixed.gpr,
        asm.clobber_fp_regs | fixed.fpr,
        &|i| asm_operand_const_at(func, args, i),
        &|i| {
            matches!(asm.operands[i].constraint, AsmConstraint::Mem)
                && matches!(asm.operands[i].seg, AsmSeg::None)
                && args.get(i).is_some_and(|&a| {
                    matches!(
                        crate::c5::asm::asm_operand_static(func, a),
                        Some(crate::c5::asm::StaticOperand::Addr { .. })
                    )
                })
        },
    )
}

/// The GP / FP register masks an inline-asm statement saves around its
/// body, and the register its captures, loads and store-backs stage
/// through. The masks are the registers the statement writes -- the
/// clobber list, the operand registers and the stage -- that `preserve`
/// names as holding something across the block. The stage may not alias
/// an operand register (a `register T v asm("reg")` binding can pin one
/// to any GPR), so it is picked per statement: r10 / r11, else a
/// clobbered non-operand register, else a free allocator-visible
/// register added to the save mask. A `-ffixed-` register is neither
/// staged through nor saved.
pub(super) fn asm_save_masks_and_stage(
    asm: &super::super::ir::AsmBlock,
    op_reg: &[Option<u8>],
    fixed: super::FixedRegs,
    preserve: (u32, u32),
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
    // `preserve` names the registers that hold something across the
    // block (`Allocation::asm_preserve`); the rest hold nothing the body
    // could destroy and lose their save / restore pair.
    used &= preserve.0;
    fp_used &= preserve.1;
    Ok((used & !fixed.gpr, fp_used & !fixed.fpr, Reg(stage)))
}

/// The GP / FP registers one inline-asm site's lowering writes: the
/// clobber list, and the operand and staging registers or, when the
/// operands bind directly, the scratch. A value live across the site must
/// not sit in one. `(0, 0)` when the statement emits nothing or its
/// operands do not assign, where the site writes nothing the allocator can see.
pub(crate) fn asm_site_write_masks(
    func: &FunctionSsa,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    fixed: super::FixedRegs,
    target: Target,
) -> (u32, u32) {
    if crate::c5::asm::asm_statement_is_noop(asm, crate::c5::asm::AsmComments::X86) {
        return (0, 0);
    }
    if let Some(shape) = bound_shape(func, asm, args, fixed, target) {
        return (
            (asm.clobber_regs | shape.gp_scratch_mask(asm, fixed)) & !fixed.gpr,
            asm.clobber_fp_regs & !fixed.fpr,
        );
    }
    let Ok(op_reg) = asm_operand_regs(func, asm, args, fixed) else {
        return (0, 0);
    };
    match asm_save_masks_and_stage(asm, &op_reg, fixed, (u32::MAX, u32::MAX)) {
        Ok((used, fp_used, _)) => (used, fp_used),
        Err(_) => (0, 0),
    }
}

/// A bound statement's operand scratch: r10 and r11, outside the banks,
/// then registers volatile under both x86-64 conventions.
const BOUND_SCRATCH: [u8; 7] = [10, 11, 9, 8, 2, 1, 0];

/// The register operands of a statement whose operands bind directly.
pub(super) struct BoundShape {
    gp_in: usize,
    fp_in: usize,
    gp_out: usize,
    fp_out: usize,
    /// The read-write value output, `Some(true)` for an `x` one.
    rw: Option<bool>,
}

impl BoundShape {
    /// One scratch for the read-write output (its own or a displaced
    /// input's), then one per input or `=` output, which may share.
    pub(super) fn gp_need(&self) -> usize {
        usize::from(self.rw == Some(false)) + self.gp_in.max(self.gp_out)
    }

    pub(super) fn fp_need(&self) -> usize {
        usize::from(self.rw == Some(true)) + self.fp_in.max(self.fp_out)
    }

    fn gp_scratch_mask(&self, asm: &super::super::ir::AsmBlock, fixed: super::FixedRegs) -> u32 {
        bound_gp_scratch(asm, fixed, self.gp_need())
            .iter()
            .fold(0u32, |m, &r| m | 1 << r)
    }
}

/// The shape of a statement whose register operands bind to their values'
/// registers, as an instruction's do, or `None`: each operand is an
/// immediate, an `r` or `x` input value, or a value output, one of them at
/// most read-write, none `&` or segment-qualified; the clobbers spare rsp
/// and rbp; and the scratch outside them can hold every operand that has
/// no register.
pub(super) fn bound_shape(
    func: &FunctionSsa,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    fixed: super::FixedRegs,
    target: Target,
) -> Option<BoundShape> {
    use super::super::ir::{AsmConstraint as C, AsmSeg};
    const RESERVED: u32 = (1 << 4) | (1 << 5);
    if func.is_naked || func.has_sp_asm() || asm.clobber_regs & RESERVED != 0 {
        return None;
    }
    let mut shape = BoundShape {
        gp_in: 0,
        fp_in: 0,
        gp_out: 0,
        fp_out: 0,
        rw: None,
    };
    for (i, op) in asm.operands.iter().enumerate() {
        if op.seg != AsmSeg::None {
            return None;
        }
        if op.is_output {
            if !op.value || op.early_clobber || (op.is_rw && shape.rw.is_some()) {
                return None;
            }
            let fp = match op.constraint {
                C::Reg if op.width <= 8 => false,
                C::Fp if op.width == 16 => true,
                _ => return None,
            };
            if op.is_rw {
                shape.rw = Some(fp);
            } else if fp {
                shape.fp_out += 1;
            } else {
                shape.gp_out += 1;
            }
            continue;
        }
        match op.constraint {
            C::Imm => {}
            C::RegOrImm { reg: None, imm }
                if asm_operand_const_at(func, args, i)
                    .is_some_and(|v| crate::Compiler::x86_imm_alternative_accepts(imm, v)) => {}
            C::Reg | C::RegOrImm { reg: None, .. } if op.width <= 8 => shape.gp_in += 1,
            C::Fp if op.value && op.width == 16 && !op.static_arg => shape.fp_in += 1,
            _ => return None,
        }
    }
    let gp = bound_gp_scratch(asm, fixed, shape.gp_need()).len();
    let fp = bound_fp_scratch(asm, fixed, target).len();
    (gp >= shape.gp_need() && fp >= shape.fp_need()).then_some(shape)
}

/// The first `need` of [`BOUND_SCRATCH`] the statement neither clobbers
/// nor `fixed` names.
pub(super) fn bound_gp_scratch(
    asm: &super::super::ir::AsmBlock,
    fixed: super::FixedRegs,
    need: usize,
) -> alloc::vec::Vec<u8> {
    BOUND_SCRATCH
        .iter()
        .copied()
        .filter(|&r| asm.clobber_regs & (1 << r) == 0 && !fixed.has_gpr(r))
        .take(need)
        .collect()
}

/// The FP scratch outside the clobber list: the two reload registers, which
/// a function with vector work saves where they are callee-saved.
pub(super) fn bound_fp_scratch(
    asm: &super::super::ir::AsmBlock,
    fixed: super::FixedRegs,
    target: Target,
) -> alloc::vec::Vec<u8> {
    super::ssa::reg_alloc::RegBanks::new(target, fixed).fp_scratch[..2]
        .iter()
        .copied()
        .filter(|&r| {
            r != super::ssa::reg_alloc::NO_FP_SCRATCH && asm.clobber_fp_regs & (1 << r) == 0
        })
        .collect()
}

/// Whether [`bound_shape`] binds the statement's operands.
pub(crate) fn asm_binds_directly(
    func: &FunctionSsa,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    fixed: super::FixedRegs,
    target: Target,
) -> bool {
    bound_shape(func, asm, args, fixed, target).is_some()
}

/// A bound statement's operand values with the GP and FP registers each
/// avoids: an input the clobbers and the scratch; an output, written once
/// the inputs are read, the clobbers, and the scratch too when its input
/// moves in ahead of the loads; that input, read by the move, the scratch.
pub(crate) fn asm_site_bound_values(
    func: &FunctionSsa,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    site: u32,
    fixed: super::FixedRegs,
    target: Target,
) -> alloc::vec::Vec<(u32, u32, u32)> {
    use super::super::ir::AsmConstraint as C;
    let mut out = alloc::vec::Vec::new();
    if crate::c5::asm::asm_statement_is_noop(asm, crate::c5::asm::AsmComments::X86) {
        return out;
    }
    let Some(shape) = bound_shape(func, asm, args, fixed, target) else {
        return out;
    };
    let scratch = shape.gp_scratch_mask(asm, fixed) & !fixed.gpr;
    let (gpr, fpr) = (
        asm.clobber_regs & !fixed.gpr,
        asm.clobber_fp_regs & !fixed.fpr,
    );
    for (op, &a) in asm.operands.iter().zip(args) {
        if !op.is_output && !op.static_arg && !matches!(op.constraint, C::Imm) {
            out.push((a, gpr | scratch, fpr));
        } else if op.is_output && op.is_rw {
            out.push((a, scratch, 0));
        }
    }
    for (i, v) in func.asm_output_values(site) {
        if v == super::super::ir::NO_VALUE {
            continue;
        }
        let rw = asm.operands[i].is_rw;
        out.push((v, gpr | if rw { scratch } else { 0 }, fpr));
    }
    out
}

/// `reg_alloc::asm_operand_hints` over a staged statement's registers.
pub(crate) fn asm_staged_hints(
    func: &FunctionSsa,
    asm: &super::super::ir::AsmBlock,
    args: &[u32],
    site: u32,
    fixed: super::FixedRegs,
    target: Target,
) -> alloc::vec::Vec<(u32, u8)> {
    if crate::c5::asm::asm_statement_is_noop(asm, crate::c5::asm::AsmComments::X86)
        || asm_binds_directly(func, asm, args, fixed, target)
    {
        return alloc::vec::Vec::new();
    }
    let Ok(op_reg) = asm_operand_regs(func, asm, args, fixed) else {
        return alloc::vec::Vec::new();
    };
    super::super::ssa::reg_alloc::asm_operand_hints(func, asm, args, site, &op_reg)
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

/// What the prologue reserves below the return address: the pushed rbp,
/// the frame's regions, and the realigned region with the slack its `and`
/// may descend by. What `-Wframe-larger-than=` measures.
pub(super) fn frame_stack(
    func: &FunctionSsa,
    frame: Frame,
    alloc: &Allocation,
    abi: super::Abi,
) -> super::ssa::emit_common::FrameStack {
    if func.is_naked || is_full_leaf(func, frame, alloc, abi) {
        return Default::default();
    }
    let mut parts = frame.parts;
    parts.record = 8;
    if frame.realign_align > 0 {
        parts.aligned = parts
            .aligned
            .saturating_add(frame.realign_region_bytes)
            .saturating_add(frame.realign_align - 1);
    }
    parts
}

/// A function that needs no frame at all: nothing to reserve, no parameter
/// read from memory, no callee-saved register, no call; the return address
/// stays at the top of the stack and `ret` returns directly.
pub(super) fn is_full_leaf(
    func: &FunctionSsa,
    frame: Frame,
    alloc: &Allocation,
    abi: super::Abi,
) -> bool {
    if frame.frame_bytes != 0 || frame.param_home_needed || abi.mcount_frame {
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
    !frame.keeps_record
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

/// [`param_placements`] for the home map, a variadic callee included: its
/// named parameters arrive as its callers place them.
pub(super) fn param_home_placements(
    func: &FunctionSsa,
    abi: super::Abi,
) -> alloc::vec::Vec<super::ArgPlacement> {
    if func.is_variadic {
        super::ssa::emit_common::param_placements_common(func, abi)
    } else {
        param_placements(func, abi)
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

/// The caller reserved a home slot per argument register above the return
/// address (Win64); each register's slot is the one at its position.
fn home_area_callee(abi: super::Abi) -> bool {
    abi.shadow_space > 0
}

/// Position of integer argument register `r` in the ABI's order.
fn int_arg_position(r: u8, abi: super::Abi) -> i64 {
    abi.int_arg_regs
        .iter()
        .position(|&a| a == r)
        .unwrap_or_else(|| unreachable!("ICE: {r} is no argument register")) as i64
}

/// rbp-relative offset of the memory the body reads parameter `i` from.
/// A register-carried parameter of a System V callee has a 16-byte cell
/// in the frame (`Frame::param_cells_off`), the cells in placement order;
/// a System V variadic callee reads it from the register save area
/// instead (ABI 3.5.7) and a Win64 callee from its register's home slot.
/// A stack-passed parameter is read where the caller left it, at
/// `[rbp + 16 + off]`, on every ABI.
pub(super) fn param_home_off(i: usize, func: &FunctionSsa, frame: Frame, abi: super::Abi) -> i64 {
    use super::ArgPlacement as P;
    let placements = param_home_placements(func, abi);
    let Some(&p) = placements.get(i) else {
        unreachable!("ICE: parameter {i} has no placement");
    };
    let before = |pred: fn(&P) -> bool| placements[..i].iter().filter(|q| pred(q)).count() as i64;
    match p {
        P::Stack(off) | P::StructByRefStack(off) | P::StructStack { off, .. } => 16 + off as i64,
        P::IntReg(r) | P::StructByRefReg(r) if sysv_variadic_callee(func, abi) => {
            frame.va_reg_save_off as i64 + int_arg_position(r, abi) * 8
        }
        P::FpReg(x) if sysv_variadic_callee(func, abi) => {
            frame.va_reg_save_off as i64 + SYSV_GP_SAVE_BYTES as i64 + x as i64 * 16
        }
        P::IntReg(r) | P::StructByRefReg(r) if home_area_callee(abi) => {
            16 + 8 * int_arg_position(r, abi)
        }
        P::FpReg(x) if home_area_callee(abi) => 16 + 8 * x as i64,
        P::StructRegs { regs, .. } if home_area_callee(abi) => {
            16 + 8 * int_arg_position(regs[0].reg, abi)
        }
        _ => frame.param_cells_off as i64 + 16 * before(register_carried),
    }
}

/// Bytes of the parameter cell region: a cell per register-carried
/// parameter once a System V callee reads any register parameter from
/// memory. A Win64 callee homes its register parameters in the caller's
/// home area and a variadic callee in its register save area.
fn param_cells_bytes(func: &FunctionSsa, alloc: &Allocation, abi: super::Abi) -> u32 {
    if func.is_variadic || home_area_callee(abi) {
        return 0;
    }
    let placements = param_placements(func, abi);
    let elidable = param_elidable_mask(func, alloc, abi);
    let any_needed = placements.iter().enumerate().any(|(i, p)| {
        matches!(
            p,
            super::ArgPlacement::IntReg(_) | super::ArgPlacement::FpReg(_)
        ) && !elidable.get(i).copied().unwrap_or(false)
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
        super::ArgPlacement::IntReg(_) | super::ArgPlacement::FpReg(_) => {
            !elidable.get(i).copied().unwrap_or(false)
        }
        super::ArgPlacement::StructRegs { .. } => false,
        _ => true,
    })
}

/// `mask[i]`: parameter `i` is a register-passed scalar read only through
/// a surviving `Inst::ParamRef`, so the memory home the prologue would
/// fill is unobserved and no cell is reserved for it (C99 6.2.4p2). Empty
/// for a variadic or zero-parameter callee.
pub(super) fn param_elidable_mask(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> alloc::vec::Vec<bool> {
    param_home_masks(func, alloc, abi).0
}

/// `mask[i]`: the prologue's store of parameter `i` into its home has no
/// reader -- the home is unobserved, or the body writes the same cell at
/// the declared width before any read of it. The second case leaves the
/// cell observed, so `param_cells_bytes` and `param_home_needed` keep
/// reading [`param_elidable_mask`].
pub(super) fn param_home_store_dead(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> alloc::vec::Vec<bool> {
    param_home_masks(func, alloc, abi).1
}

/// [`param_elidable_mask`] and [`param_home_store_dead`] from one scan of
/// the body. A parameter whose argument register a per-inst `ParamRef`
/// clobbers reads its home, so neither mask takes it however the cell is
/// used; see `compute_param_from_home`.
fn param_home_masks(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> (alloc::vec::Vec<bool>, alloc::vec::Vec<bool>) {
    let placements = param_placements(func, abi);
    if placements.is_empty() {
        return (alloc::vec::Vec::new(), alloc::vec::Vec::new());
    }
    let (seeded, addr_taken, needed) = super::ssa::emit_common::scan_param_slot_usage(func, alloc);
    let clobbered = param_home_clobber_set(func, alloc, abi);
    let written_first =
        super::ssa::emit_common::param_cell_written_first(func, alloc, placements.len());
    let mut elidable = alloc::vec![false; placements.len()];
    let mut store_dead = alloc::vec![false; placements.len()];
    for (i, p) in placements.iter().enumerate() {
        let scalar = matches!(
            p,
            super::ArgPlacement::IntReg(_) | super::ArgPlacement::FpReg(_)
        ) && !clobbered.get(i).copied().unwrap_or(false);
        if !scalar {
            continue;
        }
        let slot = (i as i64) + 2;
        elidable[i] =
            seeded.contains(&(i as u32)) && !addr_taken.contains(&slot) && !needed.contains(&slot);
        store_dead[i] = elidable[i] || written_first[i];
    }
    (elidable, store_dead)
}

/// The register parameters the per-inst `Inst::ParamRef` path lowers
/// after an earlier `ParamRef`'s write clobbered their incoming argument
/// register. The entry parallel copy places the integer reads opening the
/// entry block (`emit_common::entry_read_run`) at once when their homes
/// are pairwise distinct; every other read is placed at its position, and
/// the marked parameters among them read their prologue-stored home. The mask depends only on `alloc.places` and the
/// `ParamRef` order, so the elidability scan and the prologue consult it
/// without a fixpoint.
fn param_home_clobber_set(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> alloc::vec::Vec<bool> {
    let plan = param_placements(func, abi);
    let mut mask = alloc::vec![false; plan.len()];
    if plan.is_empty() {
        return mask;
    }
    // A live parameter read: a `ParamRef`, which has a home, or a
    // `ParamPart`, which reads its register in the same order and has none.
    let live_read = |vid: usize| -> Option<(Option<usize>, LoadKind)> {
        let inst = &func.insts[vid];
        let (home, kind) = match inst {
            Inst::ParamRef { idx, kind } => (Some(*idx as usize), *kind),
            Inst::ParamPart { kind, .. } => (None, *kind),
            _ => return None,
        };
        if super::ssa::emit_common::is_dead_pure(inst, vid as super::super::ir::ValueId, alloc) {
            return None;
        }
        Some((home, kind))
    };
    let incoming = |vid: usize| super::ssa::reg_alloc::incoming_reg(&plan, &func.insts[vid]);
    // FP parameters always take the per-inst path, so the same hazard
    // applies within the FP bank.
    let mut written_fp: alloc::collections::BTreeSet<u8> = alloc::collections::BTreeSet::new();
    for vid in 0..func.insts.len() {
        let Some((home, kind)) = live_read(vid) else {
            continue;
        };
        if !matches!(kind, LoadKind::F32 | LoadKind::F64) {
            continue;
        }
        let Some((true, arg_reg)) = incoming(vid) else {
            continue;
        };
        if written_fp.contains(&arg_reg)
            && let Some(i) = home
        {
            mask[i] = true;
        }
        if let Some(Place::FpReg(r)) = alloc.places.get(vid).copied() {
            written_fp.insert(r);
        }
    }
    // The entry parallel copy's eligibility and `homes_distinct` gate,
    // mirrored.
    let mut batch: alloc::vec::Vec<usize> = alloc::vec::Vec::new();
    let mut batch_homes: alloc::vec::Vec<Place> = alloc::vec::Vec::new();
    for vid in super::ssa::emit_common::entry_read_run(func, &alloc.use_counts) {
        if live_read(vid).is_none() || !matches!(incoming(vid), Some((false, _))) {
            continue;
        }
        let dst = alloc.places.get(vid).copied().unwrap_or(Place::None);
        if matches!(dst, Place::IntReg(_) | Place::Spill(_)) {
            batch.push(vid);
            batch_homes.push(dst);
        }
    }
    let homes_distinct = (0..batch_homes.len()).all(|a| {
        ((a + 1)..batch_homes.len()).all(|b| !place_same_loc(batch_homes[a], batch_homes[b]))
    });
    if !homes_distinct {
        batch.clear();
        batch_homes.clear();
    }
    // Per-inst path: a later parameter whose argument register was
    // already written, by the copy or by an earlier read's placement, is
    // clobbered before it can be read. Only integer registers take part;
    // an FP parameter's incoming xmm register is disjoint from
    // `int_arg_regs`.
    let mut written: alloc::collections::BTreeSet<u8> = batch_homes
        .iter()
        .filter_map(|&h| match h {
            Place::IntReg(r) => Some(r),
            _ => None,
        })
        .collect();
    for vid in 0..func.insts.len() {
        if batch.contains(&vid) {
            continue;
        }
        let Some((home, _)) = live_read(vid) else {
            continue;
        };
        let Some((false, arg_reg)) = incoming(vid) else {
            continue;
        };
        if written.contains(&arg_reg)
            && let Some(i) = home
        {
            mask[i] = true;
        }
        if let Some(Place::IntReg(r)) = alloc.places.get(vid).copied() {
            written.insert(r);
        }
    }
    mask
}

/// `mask[idx]`: the per-inst `Inst::ParamRef` of register parameter `idx`
/// reads its prologue-stored home instead of the incoming argument
/// register, because an earlier `ParamRef`'s destination overwrote it. The
/// set is `param_home_clobber_set`; each member is forced non-elidable, so
/// its home exists.
pub(super) fn compute_param_from_home(
    func: &FunctionSsa,
    alloc: &Allocation,
    abi: super::Abi,
) -> alloc::vec::Vec<bool> {
    param_home_clobber_set(func, alloc, abi)
}
