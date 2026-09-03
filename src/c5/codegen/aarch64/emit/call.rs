use super::*;

/// AAPCS64 `va_start` (Appendix B). args[0] = the `__va_list` pointer (the
/// array-form `va_list` decayed to `&ap[0]`); args[1] = &last (unused --
/// the named-argument counts come from the prototype). Initialise the
/// 32-byte struct:
///   __stack  (+0)  = first incoming stack argument
///   __gr_top (+8)  = high edge of the general save area
///   __vr_top (+16) = high edge of the vector save area
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
    // The struct pointer must survive the field writes; keep it in
    // scratch.primary so the secondary is free to stage each value.
    let ap = if ap_r.0 != scratch.primary.0 {
        emit_mov_reg(code, scratch.primary, ap_r);
        scratch.primary
    } else {
        ap_r
    };
    // __stack (+0) = fp + 16 + 192 + named-stack-overflow: incoming stack
    // arguments begin just above the register save area at [fp + 208], and
    // the named parameters that overflowed the argument registers occupy
    // the low slots there.
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
    // __gr_offs (+24) = -(8 - named_int) * 8. A named integer parameter
    // past the eight argument registers overflows to the stack, which this
    // offset does not cover (the same assumption `local_slot_off` makes).
    let gr_offs = -((8u32.saturating_sub(named_int) * 8) as i64);
    load_imm64(code, scratch.secondary, gr_offs as u64);
    emit(code, enc_str32_imm(scratch.secondary, ap, 24));
    // __vr_offs (+28) = -(8 - named_fp) * 16, or 0 when the prologue skipped
    // the vector save area: zero reads as exhausted, so `va_arg` walks the
    // general area then the overflow stack.
    let vr_offs = if abi.no_fp_varargs {
        0
    } else {
        -((8u32.saturating_sub(named_fp) * 16) as i64)
    };
    load_imm64(code, scratch.secondary, vr_offs as u64);
    emit(code, enc_str32_imm(scratch.secondary, ap, 28));
    true
}

/// `__builtin_va_start(&ap, &last)` for the cursor `va_list` models: set
/// `*ap` to the address of the first variadic argument, computed from the
/// frame since `&last` cannot locate a tail that is not adjacent to the
/// named arguments.
///
/// * Windows on ARM64 (Microsoft ARM64 calling convention): the prologue
///   spilled x0..x7 into the 64-byte gr-save area at `[fp + 16 .. fp + 80)`,
///   one 8-byte slot per argument position; the first variadic argument is
///   slot `n_params`. The area's top edge meets the incoming stack overflow,
///   so the single cursor `va_arg` advances by 8 walks the register-saved
///   variadic arguments then the stack arguments with no gap.
/// * macOS arm64: the named arguments arrive in argument registers (spilled
///   to c5 cdecl cells by the prologue) and the variadic arguments sit on
///   the incoming stack above the named arguments' stack overflow. The
///   incoming-stack region begins at `fp + param_spill_bytes + 16`; the
///   named arguments that overflowed the registers occupy its low
///   `n_stack * 8` bytes (AAPCS64 8-byte stack stride).
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
        // The c5 cdecl cell region keeps fp 16-aligned (each cell is 16
        // bytes, the fp/lr save is 16 bytes); a non-16-aligned `off` would
        // mean the frame accounting and the incoming-stack region disagree.
        debug_assert_eq!(
            (frame.param_spill_bytes + 16) % 16,
            0,
            "va_start: c5 cdecl cell region must keep fp 16-aligned"
        );
        emit_fp_plus_off(code, scratch.secondary, off);
        emit(code, enc_str_imm(scratch.secondary, ap_r, 0));
        return true;
    }
    // Linux aarch64 takes the `aarch64_host_variadic_callee` arm; no other
    // aarch64 variadic callee shape reaches here.
    bail_msg("VaStart: variadic callee not matched by a host-ABI branch");
    false
}

/// `__builtin_va_arg(&ap)` for the cursor `va_list` models (macOS arm64
/// and Windows arm64, which both lay variadic arguments at 8-byte stride):
/// returns `*ap` (the address of the current slot) and advances `*ap` by
/// the argument's eightbyte span. The stride is a property of the
/// `va_list` layout the target builds, not of the current function, so a
/// non-variadic forwarder (libc's `vsnprintf` taking a `va_list`) walks the
/// same stride the variadic caller produced. args[0] = &ap, args[1] = the
/// packed `(kind << 16) | size` descriptor; a scalar occupies one
/// eightbyte, a by-value aggregate `ceil(size/8)` consecutive ones.
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
    // The result is loaded into a work register, the cursor is advanced,
    // then the result is delivered to the destination. The work register
    // and the advance temporary must each differ from the cursor address
    // `ap_r` so the writeback stores to the right slot.
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
        // Both scratch registers hold the cursor and the staged result
        // (cursor and destination both spilled). x19 is reserved by the
        // prologue for any function with an intrinsic, so it serves as a
        // third scratch here.
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
    // Transfer register distinct from both pointer registers. x9 / x10 /
    // x11 are AAPCS64 caller-saved temporaries outside the allocator's
    // reach here; save and restore the chosen one so a live value it may
    // hold is preserved across the copy.
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

/// External library call: arg marshalling identical to
/// `emit_call`, but the branch target is a PLT trampoline rather
/// than a c5 function. The trampoline gets a `PltCallFixup`
/// recorded; the writer's post-pass patches the BL displacement
/// once trampolines are laid out at the tail of the code blob.
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
    // single 128-bit Q register. The c5 compute path carries the
    // value as binary64, so a `long double` libc return needs a
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
        .find(|&r| !arg_source_regs.contains(&r) && !abi.fixed_regs.has_gpr(r))
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

    /// Aggregates passed on the caller's stack (AAPCS64 5.4.2): copy the
    /// source bytes to [sp + off] before the register-argument marshal. The
    /// source address is read from a value register that the register
    /// marshal can overwrite, so it must be consumed while still live;
    /// x16/x17 are scratch and hold no argument value at this point.
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
            // The outgoing stack slot is 8-aligned (AAPCS64 5.4.2); the
            // source is the caller's object, so its own alignment bounds
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

    /// FP arguments before the integer ones: an FP value can sit in an
    /// integer register as a raw bit pattern (`Inst::Imm` with the f64 bit
    /// pattern), which the integer marshal may overwrite. A value already in
    /// a d-register may sit in another FP argument's target d-register, so
    /// the d-to-d moves form a parallel copy, scheduled first so every
    /// d-register source is consumed before any Spill / IntReg source
    /// materialises into its target; the second FP scratch breaks cycles
    /// and lies outside the allocator's d-register pool.
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

    /// AAPCS64 6.8.2 HFA arguments: each member passes in its own FP
    /// register, loaded from the source aggregate's address. Runs after the
    /// scalar-FP moves (so any d-register source they read is consumed) and
    /// before the integer marshal (so the source address, still in an
    /// integer register, is not yet overwritten). Members are memory loads,
    /// so they join no FP move cycle; the base goes through scratch.primary,
    /// reused per aggregate. Integer-class `StructRegs` (regs[0] is a GPR)
    /// are left to the eightbyte path.
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

    /// Integer-register placements plus aggregate base addresses are one
    /// parallel register move. A scalar `IntReg` arg moves src->target; a
    /// `StructRegs` arg positions its base address into its own first
    /// eightbyte register `regs[0]`, from which the eightbytes load (the
    /// base register is overwritten by its own eightbyte last). Routing the
    /// base through that per-aggregate register -- never a shared scratch
    /// -- keeps one aggregate's load from clobbering another aggregate's
    /// still-pending base. `schedule_int_reg_moves` breaks cycles via
    /// scratch.primary. Sources not register-resident (spill / computed /
    /// FP) then materialise straight into their target.
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

/// Place every call argument into its AAPCS64 target slot in an order that
/// survives source / target overlaps: with the allocator's caller-saved
/// bank covering x0..x15, an argument's value can sit in another argument's
/// target register, so each register bank is a parallel copy -- leaves
/// (targets that are no pending source) drain first and the residual
/// cycles break through one scratch-mediated copy. The passes run stack
/// slots, stack aggregates, FP registers, HFA members, integer registers,
/// then the aggregate eightbytes.
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
