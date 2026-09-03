use super::*;

/// AAPCS64 `va_start` (Appendix B): initialise the 32-byte `__va_list`
/// at args[0] (args[1], `&last`, is unused; the named counts come from
/// the prototype):
///   __stack   (+0)  = first incoming stack argument
///   __gr_top  (+8)  = high edge of the general save area
///   __vr_top  (+16) = high edge of the vector save area
///   __gr_offs (+24) = -(8 - named_int) * 8   (counts up to 0)
///   __vr_offs (+28) = -(8 - named_fp) * 16
pub(super) fn emit_va_start_aapcs64(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    abi: super::Abi,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
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
    let Some(ap_r) = materialize_int(code, place_of(alloc, args[0]), scratch.primary, frame) else {
        return false;
    };
    // The struct pointer stays in scratch.primary across the field writes.
    let ap = if ap_r.0 != scratch.primary.0 {
        emit_mov_reg(code, scratch.primary, ap_r);
        scratch.primary
    } else {
        ap_r
    };
    // __stack: the incoming stack arguments begin above the save area at
    // [fp + 208], past the named parameters that overflowed the registers.
    let named_stack_bytes: u32 = super::plan_param_regs(n, func.param_fp_mask, abi)
        .placements
        .iter()
        .filter(|q| matches!(q, super::ArgPlacement::Stack(_)))
        .count() as u32
        * 8;
    emit_fp_plus_off(
        code,
        scratch.secondary,
        16 + AARCH64_VA_SAVE_BYTES + named_stack_bytes,
    );
    emit(code, enc_str_imm(scratch.secondary, ap, 0));
    // __gr_top (+8) = fp + 16 + 64 (high edge of the general area).
    emit_fp_plus_off(code, scratch.secondary, 16 + AARCH64_GR_SAVE_BYTES);
    emit(code, enc_str_imm(scratch.secondary, ap, 8));
    // __vr_top (+16) = fp + 16 + 192 (high edge of the vector area).
    emit_fp_plus_off(code, scratch.secondary, 16 + AARCH64_VA_SAVE_BYTES);
    emit(code, enc_str_imm(scratch.secondary, ap, 16));
    // __gr_offs; a named parameter past the eight registers is on the
    // stack, outside this offset (as `local_slot_off` assumes).
    let gr_offs = -((8u32.saturating_sub(named_int) * 8) as i64);
    load_imm64(code, scratch.secondary, gr_offs as u64);
    emit(code, enc_str32_imm(scratch.secondary, ap, 24));
    // __vr_offs, or 0 when the prologue skipped the vector area: exhausted.
    let vr_offs = if abi.no_fp_varargs {
        0
    } else {
        -((8u32.saturating_sub(named_fp) * 16) as i64)
    };
    load_imm64(code, scratch.secondary, vr_offs as u64);
    emit(code, enc_str32_imm(scratch.secondary, ap, 28));
    true
}

/// `__builtin_va_start(&ap, &last)` for the cursor models: `*ap` = the
/// address of the first variadic argument, computed from the frame.
/// Windows on ARM64: slot `n_params` of the gr-save area at `[fp + 16 ..)`,
/// whose top edge meets the incoming stack. macOS arm64: the incoming
/// stack above the c5 cells at `fp + param_spill_bytes + 16`, past the
/// named arguments that overflowed the registers (`n_stack * 8`).
pub(super) fn emit_va_start_cursor(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    abi: super::Abi,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    if args.len() != 2 {
        bail_msg("VaStart: expected 2 args");
        return false;
    }
    let Some(ap_r) = materialize_int(code, place_of(alloc, args[0]), scratch.primary, frame) else {
        return false;
    };
    if win_arm64_variadic_callee(func, abi) {
        debug_assert!(
            func.n_params <= abi.int_arg_regs.len(),
            "win-arm64 variadic callee assumes named params fit the int arg bank"
        );
        let off = 16 + (func.n_params as u32) * 8;
        emit_fp_plus_off(code, scratch.secondary, off);
        emit(code, enc_str_imm(scratch.secondary, ap_r, 0));
        return true;
    }
    if func.is_variadic && abi.variadic_on_stack {
        let (_, n_stack) = param_reg_stack_split(func, abi);
        let named_overflow_bytes = (n_stack as u32) * 8;
        let off = frame.param_spill_bytes + 16 + named_overflow_bytes;
        debug_assert_eq!(
            (frame.param_spill_bytes + 16) % 16,
            0,
            "va_start: c5 cdecl cell region must keep fp 16-aligned"
        );
        emit_fp_plus_off(code, scratch.secondary, off);
        emit(code, enc_str_imm(scratch.secondary, ap_r, 0));
        return true;
    }
    bail_msg("VaStart: variadic callee not matched by a host-ABI branch");
    false
}

/// `__builtin_va_arg(&ap)` for the cursor models (macOS and Windows
/// arm64, 8-byte stride): return `*ap` and advance it by the argument's
/// eightbyte span. The stride is the target's `va_list` layout, not the
/// current function's, so a non-variadic forwarder walks the same
/// stride. args[1] is the packed `(kind << 16) | size` descriptor.
pub(super) fn emit_va_arg_cursor(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    args: &[u32],
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    if args.is_empty() {
        bail_msg("VaArg: expected at least the ap argument");
        return false;
    }
    let va_stride: u32 = match args.get(1).and_then(|a| func.insts.get(*a as usize)) {
        Some(super::super::ir::Inst::Imm(d)) => (((*d & 0xffff) as u32 + 7) & !7).max(8),
        _ => 8,
    };
    let Some(ap_r) = materialize_int(code, place_of(alloc, args[0]), scratch.primary, frame) else {
        return false;
    };
    // The work register and the advance temporary must both differ from
    // the cursor address `ap_r`.
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
        // x19 is reserved by the prologue for a function with an intrinsic.
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

/// AAPCS64 `va_copy`: a 32-byte `__va_list` struct copy (Appendix B),
/// three pointers plus two offsets. args[0] = &dst struct, args[1] = &src
/// struct.
pub(super) fn emit_va_copy_aapcs64(
    code: &mut Vec<u8>,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    if args.len() != 2 {
        bail_msg("VaCopy: expected 2 args");
        return false;
    }
    let Some(dst_r) = materialize_int(code, place_of(alloc, args[0]), scratch.primary, frame)
    else {
        return false;
    };
    let Some(src_r) = materialize_int(code, place_of(alloc, args[1]), scratch.secondary, frame)
    else {
        return false;
    };
    // A caller-saved transfer register distinct from both pointers, saved
    // and restored around the copy.
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

/// `__builtin_va_copy(&dst, &src)` for the cursor models: `*dst = *src`.
pub(super) fn emit_va_copy_cursor(
    code: &mut Vec<u8>,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> bool {
    if args.len() != 2 {
        bail_msg("VaCopy: expected 2 args");
        return false;
    }
    let Some(dst_r) = materialize_int(code, place_of(alloc, args[0]), scratch.primary, frame)
    else {
        return false;
    };
    let Some(src_r) = materialize_int(code, place_of(alloc, args[1]), scratch.secondary, frame)
    else {
        return false;
    };
    emit(code, enc_ldr_imm(scratch.secondary, src_r, 0));
    emit(code, enc_str_imm(scratch.secondary, dst_r, 0));
    true
}

/// AAPCS64 `va_arg` (Appendix B) over the `__va_list` struct: a general
/// argument from the general save area while `__gr_offs < 0`, a
/// floating-point one from the vector area while `__vr_offs < 0`, else
/// the overflow stack. Returns the slot's address; the macro
/// dereferences it. x17 holds the struct pointer, x16 the offset then
/// the address, and a borrowed x9 / x10 (saved around the sequence) the
/// area top.
pub(super) fn emit_va_arg_aapcs64(
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
    // The integer bank: __gr_offs (+24), __gr_top (+8), 8-byte stride; the
    // FP bank: __vr_offs (+28), __vr_top (+16), 16-byte stride. The
    // overflow stack uses 8 for both. TODO: an HFA rides the vector area
    // one 16-byte slot per member (B.5) and needs composition into a
    // temporary; the descriptor classes every aggregate as
    // general-register.
    let (off_field, top_field, reg_step): (u32, u32, u32) =
        if is_fp { (28, 16, 16) } else { (24, 8, 8) };
    // An integer-class aggregate spans `ceil(size/8)` eightbytes.
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
    // offs >= 0: the bank is exhausted, take the stack path.
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
    // B.5: a composite whose span crosses the area's high edge (offs + span
    // > 0) was passed on the stack; the written-back offset keeps later
    // reads exhausted.
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
    // The borrowed register is restored before a spilled result's
    // sp-relative store.
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

/// The operands every call form carries: the argument values, which of
/// them are floating-point, the by-value aggregate tags, and the aggregate
/// result temp when the callee returns one.
#[derive(Clone, Copy)]
pub(super) struct CallOperands<'a> {
    pub(super) args: &'a [u32],
    pub(super) fp_arg_mask: u32,
    pub(super) arg_aggs: &'a [Option<u32>],
    pub(super) ret_agg: Option<u32>,
    pub(super) ret_slot_off: i64,
}

/// An external library call: the same marshalling as `emit_call` with a
/// `PltCallFixup` at the `bl`, patched once the trampolines are laid out.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_call_ext(
    code: &mut Vec<u8>,
    dst: Place,
    fcx: &FnCtx,
    ops: CallOperands,
    binding_idx: i64,
    plt_call_fixups: &mut Vec<PltCallFixup>,
) -> bool {
    let FnCtx {
        func,
        alloc,
        frame,
        scratch,
        abi,
        target,
        imports,
        ..
    } = *fcx;
    let agg_descs = &func.agg_descs;
    let CallOperands {
        args,
        fp_arg_mask,
        arg_aggs,
        ret_agg,
        ret_slot_off,
    } = ops;
    let import_index = match imports.index_of_binding(binding_idx) {
        Some(i) => i,
        None => return false,
    };
    let imp = &imports.imports[import_index];
    // A variadic import gives the planner its fixed count so the tail
    // follows the host's variadic placement; `fp_arg_mask` comes from the
    // argument types.
    let fixed = if imp.is_variadic {
        imp.fixed_args.min(args.len())
    } else {
        args.len()
    };
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
    // The patcher rewrites only imm26, so the placeholder must be `bl`.
    emit(code, enc_bl(0));
    // AAPCS64 returns `long double` (binary128) in v0; the c5 compute path
    // carries binary64, so a LinuxAarch64 import returning one is followed
    // by a `bl __trunctfdf2` (binary128 in v0 to double in d0), an import
    // the codegen pre-includes. macOS and Windows alias `long double` to
    // `double`.
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
        // A float / double result is FP-classed and already in d0 / s0; an f32
        // stays the single in s0, the form the F32 stores and casts consume.
        move_call_result(code, dst, frame, true);
        return true;
    }
    // `long double` is not FP-classed and bridges through x0 like an
    // integer; sub-word integer returns take the pool path's extension.
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

/// The sub-word sign / zero extension of a call result in x0;
/// `ReturnExt::None` is a no-op.
fn emit_extend_x0_for_return(code: &mut Vec<u8>, ext: super::ReturnExt) {
    use super::ReturnExt;
    // sxtb / sxth / sxtw x0, w0; uxtb / uxth / mov w0, w0.
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

/// A direct call to a c5 function at `target_pc`: marshal through the
/// host ABI, `bl` a placeholder with a `Fixup::Bl` for the outer fixup
/// pass, and bridge the result to `dst`.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_call(
    code: &mut Vec<u8>,
    dst: Place,
    fcx: &FnCtx,
    ops: CallOperands,
    target_pc: usize,
    fixed_args: usize,
    fixups: &mut Vec<Fixup>,
    callee_is_variadic: bool,
    fp_return: bool,
) -> bool {
    let FnCtx {
        func,
        alloc,
        frame,
        scratch,
        abi,
        ..
    } = *fcx;
    let agg_descs = &func.agg_descs;
    let CallOperands {
        args,
        fp_arg_mask,
        arg_aggs,
        ret_agg,
        ret_slot_off,
    } = ops;
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    // A variadic callee is marshalled through `plan_call_args` like a libc
    // variadic call: macOS puts every variadic argument on the stack at an
    // 8-byte stride, Windows in x0..x7 then the stack (an FP variadic
    // argument as its bit pattern, already widened to double), Linux in
    // both banks then the stack. `fp_arg_mask` comes from the argument
    // types, since a floating-point constant rides an integer register as
    // its bit pattern.
    let fixed = if callee_is_variadic {
        if !(abi.variadic_on_stack || abi.variadic_int_only || abi.aarch64_host_variadic()) {
            bail_msg("Call: variadic callee not matched by a host-ABI branch");
            return false;
        }
        fixed_args
    } else {
        args.len()
    };
    let plan = super::plan_call_args_aggs(args.len(), fixed, fp_arg_mask, abi, &aggs, false);
    emit_stack_alloc(code, plan.scratch_bytes, None);
    if !marshal_args(
        code, &plan, args, alloc, scratch, frame, arg_aggs, agg_descs, abi,
    ) {
        return false;
    }
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
    true
}

/// Point x8 at the caller's result temp before a call returning an
/// aggregate larger than 16 bytes (AAPCS64 6.9), after `marshal_args`
/// has set the argument registers.
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

/// Bridge a scalar call result to `dst`: an integer-classed result from
/// x0 (AAPCS64 6.4.1), a floating-point one from d0 (6.4.2; an f32 is
/// its s0 half), copied or reinterpreted into the destination's
/// register file.
fn move_call_result(code: &mut Vec<u8>, dst: Place, frame: Frame, fp_return: bool) {
    if fp_return {
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
            // A non-FP call the allocator FP-classed: reinterpret x0 into d.
            emit(code, enc_fmov_x_to_d(r, Reg(0)));
        }
        Place::Spill(slot) => {
            let sp_off = spill_off(frame, slot);
            emit_spill_str_x_auto(code, frame, Reg(0), sp_off);
        }
        Place::None => {}
    }
}

/// A call through a function pointer: the target is captured in a
/// caller-saved scratch the marshal does not touch (or a reserved stack
/// cell when none is free), then `blr`.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_call_indirect(
    code: &mut Vec<u8>,
    dst: Place,
    fcx: &FnCtx,
    ops: CallOperands,
    target: u32,
    callee_variadic: bool,
    fixed_args: usize,
    fp_return: bool,
) -> bool {
    let FnCtx {
        func,
        alloc,
        frame,
        scratch,
        abi,
        ..
    } = *fcx;
    let agg_descs = &func.agg_descs;
    let CallOperands {
        args,
        fp_arg_mask,
        arg_aggs,
        ret_agg,
        ret_slot_off,
    } = ops;
    let aggs = build_arg_aggs(arg_aggs, agg_descs, abi);
    let target_place = place_of(alloc, target);
    // The allocator's caller-saved pool includes x9..x15, so an argument
    // source may sit in one; the target must avoid those while the marshal
    // reads them.
    let mut arg_source_regs: alloc::vec::Vec<u8> = alloc::vec::Vec::with_capacity(args.len());
    for &a in args {
        if let Some(Place::IntReg(r)) = alloc.places.get(a as usize) {
            arg_source_regs.push(*r);
        }
    }
    const TARGET_SCRATCH_CANDIDATES: &[u8] = &[9, 10, 11, 12, 13, 14, 15];
    let free_target_reg = TARGET_SCRATCH_CANDIDATES
        .iter()
        .copied()
        .find(|&r| !arg_source_regs.contains(&r) && !abi.fixed_regs.has_gpr(r))
        .map(Reg);
    // The same placement `emit_call` uses for a direct call; a non-variadic
    // call plans every argument as fixed, which also serves a prototype the
    // walker could not recover.
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

/// The argument values of one call, for the marshalling passes.
struct CallArgs<'a> {
    plan: &'a super::CallPlan,
    args: &'a [u32],
    alloc: &'a Allocation,
    scratch: &'a ScratchPool,
    frame: Frame,
    arg_aggs: &'a [Option<u32>],
    agg_descs: &'a [super::super::ir::AggDesc],
    abi: super::Abi,
}

impl CallArgs<'_> {
    fn arg_place(&self, i: usize) -> Place {
        place_of(self.alloc, self.args[i])
    }

    /// Argument `i`'s value in an integer register, reloaded into `into`
    /// when spilled, with the outgoing-argument area's sp shift applied.
    fn arg_int(&self, code: &mut Vec<u8>, i: usize, into: Reg) -> Option<Reg> {
        materialize_int_shifted(
            code,
            self.arg_place(i),
            into,
            self.frame,
            self.plan.scratch_bytes,
        )
    }

    /// Stack slots first: each source is read into a scratch and stored to
    /// the host-stack overflow region, preserving any source register that
    /// a later pass touches.
    fn marshal_stack_args(&self, code: &mut Vec<u8>) -> bool {
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            let super::ArgPlacement::Stack(off) = placement else {
                continue;
            };
            let ap = self.arg_place(i);
            if let Place::FpReg(_) = ap {
                let Some(dn) =
                    materialize_fp_shifted(code, ap, 0u8, self.frame, self.plan.scratch_bytes)
                else {
                    return false;
                };
                emit(code, enc_str_d_imm(dn, Reg(31), off));
            } else {
                let Some(src) = self.arg_int(code, i, self.scratch.primary) else {
                    return false;
                };
                emit(code, enc_str_imm(src, Reg(31), off));
            }
        }
        true
    }

    /// Aggregates passed on the caller's stack (AAPCS64 5.4.2), copied to
    /// [sp + off] before the register marshal overwrites the value register
    /// that holds the source address; x16 / x17 hold no argument here.
    fn marshal_struct_stack_args(&self, code: &mut Vec<u8>) -> bool {
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            let super::ArgPlacement::StructStack { off, size, align } = placement else {
                continue;
            };
            let Some(src) = self.arg_int(code, i, self.scratch.primary) else {
                return false;
            };
            if src.0 != self.scratch.primary.0 {
                emit_mov_reg(code, self.scratch.primary, src);
            }
            // The slot is 8-aligned (5.4.2); the source object's alignment bounds
            // the unit.
            let unit = super::super::access_chunk(align, self.abi.strict_align, 8);
            let mut copied = 0u32;
            while copied + unit <= size {
                emit_copy_unit(
                    code,
                    unit,
                    self.scratch.secondary,
                    self.scratch.primary,
                    copied,
                    Reg(31),
                    off + copied,
                );
                copied += unit;
            }
            while copied < size {
                emit(
                    code,
                    enc_ldrb_imm(self.scratch.secondary, self.scratch.primary, copied),
                );
                emit(
                    code,
                    enc_strb_imm(self.scratch.secondary, Reg(31), off + copied),
                );
                copied += 1;
            }
        }
        true
    }

    /// FP arguments before the integer ones, since an FP value can sit in an
    /// integer register as a bit pattern the integer marshal overwrites. The
    /// d-to-d moves are a parallel copy scheduled first, with the second FP
    /// scratch breaking cycles; spilled and integer sources then
    /// materialise into their targets.
    fn marshal_fp_args(&self, code: &mut Vec<u8>) -> bool {
        let mut fp_moves: Vec<(u8, u8)> = Vec::new();
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            if let super::ArgPlacement::FpReg(r) = placement
                && let Place::FpReg(s) = self.arg_place(i)
                && s != r
            {
                fp_moves.push((s, r));
            }
        }
        schedule_dreg_moves(code, &mut fp_moves, self.frame.fp_scratch[1]);
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            let super::ArgPlacement::FpReg(r) = placement else {
                continue;
            };
            let ap = self.arg_place(i);
            // Register-to-register moves were scheduled above.
            if let Place::FpReg(_) = ap {
                continue;
            }
            let Some(src) =
                materialize_fp_shifted(code, ap, r, self.frame, self.plan.scratch_bytes)
            else {
                return false;
            };
            if src != r {
                emit(code, super::encode::enc_fmov_d_d(r, src));
            }
        }
        true
    }

    /// AAPCS64 6.8.2 HFA arguments: each member loads into its own FP
    /// register from the aggregate's address, after the scalar FP moves
    /// consumed their d-register sources and before the integer marshal
    /// overwrites the base register. Integer-class `StructRegs` take the
    /// eightbyte path.
    fn marshal_hfa_args(&self, code: &mut Vec<u8>) -> bool {
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            let super::ArgPlacement::StructRegs { regs, n, align } = placement else {
                continue;
            };
            if n == 0 || !regs[0].is_fp {
                continue;
            }
            let members = self.arg_aggs.get(i).copied().flatten().and_then(|idx| {
                super::abi_classify::hfa_member_layout(&self.agg_descs[idx as usize].fields)
            });
            let Some(base) = self.arg_int(code, i, self.scratch.primary) else {
                return false;
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
                    self.abi.strict_align,
                    self.scratch.secondary,
                );
            }
        }
        true
    }

    /// Integer placements and aggregate base addresses form one parallel
    /// register move: a `StructRegs` base goes into its own first eightbyte
    /// register `regs[0]` (overwritten by its own eightbyte last), never a
    /// shared scratch, so one aggregate's loads cannot clobber another's
    /// pending base. Non-register sources then materialise into their
    /// targets.
    fn marshal_int_args(&self, code: &mut Vec<u8>) -> bool {
        let mut int_moves: Vec<(u8, u8)> = Vec::new();
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            let dst = match placement {
                super::ArgPlacement::IntReg(r) => r,
                // HFA aggregates (regs[0] is an FP register) loaded already.
                super::ArgPlacement::StructRegs { regs, n, .. } if n > 0 && !regs[0].is_fp => {
                    regs[0].reg
                }
                _ => continue,
            };
            if let Place::IntReg(s) = self.arg_place(i)
                && s != dst
            {
                int_moves.push((s, dst));
            }
        }
        schedule_int_reg_moves(code, &mut int_moves, self.scratch.primary);
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            let super::ArgPlacement::IntReg(r) = placement else {
                continue;
            };
            let ap = self.arg_place(i);
            match ap {
                Place::IntReg(_) => {}
                Place::FpReg(dn) => {
                    emit(code, enc_fmov_d_to_x(Reg(r), dn));
                }
                Place::Spill(_) | Place::None => {
                    let Some(src) = self.arg_int(code, i, Reg(r)) else {
                        return false;
                    };
                    if src.0 != r {
                        emit_mov_reg(code, Reg(r), src);
                    }
                }
            }
        }
        for (i, &placement) in self.plan.placements.iter().enumerate() {
            let super::ArgPlacement::StructRegs { regs, n, .. } = placement else {
                continue;
            };
            if n == 0 || regs[0].is_fp || matches!(self.arg_place(i), Place::IntReg(_)) {
                continue;
            }
            let dst = regs[0].reg;
            let Some(src) = self.arg_int(code, i, Reg(dst)) else {
                return false;
            };
            if src.0 != dst {
                emit_mov_reg(code, Reg(dst), src);
            }
        }
        true
    }

    /// Load each integer-class aggregate's eightbytes from the base now in
    /// `regs[0]`. The high eightbytes load first; `regs[0]` (the base) is
    /// read last, overwritten by its own eightbyte -- a composed one
    /// accumulates in scratch first.
    fn load_struct_eightbytes(&self, code: &mut Vec<u8>) -> bool {
        let strict = self.abi.strict_align;
        for &placement in self.plan.placements.iter() {
            match placement {
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
                            strict,
                            self.scratch.primary,
                        );
                    }
                    if super::super::access_unit(0, 8, align, strict) == 8 {
                        emit(code, enc_ldr_imm(Reg(base), Reg(base), 0));
                    } else {
                        emit_agg_load_int(
                            code,
                            self.scratch.primary,
                            Reg(base),
                            0,
                            8,
                            align,
                            strict,
                            self.scratch.secondary,
                        );
                        emit_mov_reg(code, Reg(base), self.scratch.primary);
                    }
                }
                // Not produced for AAPCS64: >16-byte aggregates keep the
                // address-passing convention (untagged scalar pointer).
                super::ArgPlacement::StructByRefReg(_)
                | super::ArgPlacement::StructByRefStack(_) => {
                    bail_msg("aarch64 marshal: by-reference aggregate arg not yet emitted");
                    return false;
                }
                _ => {}
            }
        }
        true
    }
}

/// Place every call argument into its AAPCS64 slot in an order that
/// survives source / target overlaps: each register bank is a parallel
/// copy whose residual cycles break through one scratch-mediated move.
/// Passes: stack slots, stack aggregates, FP registers, HFA members,
/// integer registers, aggregate eightbytes.
#[allow(clippy::too_many_arguments)]
pub(super) fn marshal_args(
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
    let call = CallArgs {
        plan,
        args,
        alloc,
        scratch,
        frame,
        arg_aggs,
        agg_descs,
        abi,
    };
    call.marshal_stack_args(code)
        && call.marshal_struct_stack_args(code)
        && call.marshal_fp_args(code)
        && call.marshal_hfa_args(code)
        && call.marshal_int_args(code)
        && call.load_struct_eightbytes(code)
}
