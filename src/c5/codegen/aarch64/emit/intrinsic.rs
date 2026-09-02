use super::*;

/// `Inst::Intrinsic` lowering. Each variant matches the pool
/// path's shape in [`super::encode::lower_op`] but pulls its
/// operands from the allocator's `Place`s rather than off the c5
/// stack / accumulator.
pub(super) fn emit_intrinsic(
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
            store_spilled_int(code, frame, dst, rd);
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
            store_spilled_int(code, frame, dst, rd);
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
            store_spilled_int(code, frame, dst, rd);
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
            let dn = match materialize_fp_for(
                code,
                args[0],
                src_place,
                frame.fp_scratch[0],
                frame,
                alloc,
            ) {
                Some(r) => r,
                None => return false,
            };
            let dd = match dst {
                Place::FpReg(r) => r,
                Place::Spill(_) => frame.fp_scratch[1],
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
            store_spilled_int(code, frame, dst, rd);
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
            store_spilled_int(code, frame, dst, rd);
            true
        }
        I::ReturnAddress => {
            // __builtin_return_address: the return address a frame record
            // holds at [fp + 8], where the AAPCS64 prologue saved x30.
            // Without an operand the record is the current frame's; with
            // one, the frame address a level above 0 walked to.
            let rd = match dst {
                Place::IntReg(r) => Reg(r),
                Place::Spill(_) => Reg(16),
                _ => {
                    bail_msg("ReturnAddress: dst not int reg / spill");
                    return false;
                }
            };
            let fp = match args {
                [] => Reg(29),
                [walked] => {
                    let place = alloc
                        .places
                        .get(*walked as usize)
                        .copied()
                        .unwrap_or(Place::None);
                    match materialize_int(code, place, scratch.primary, frame) {
                        Some(r) => r,
                        None => {
                            bail_msg("ReturnAddress: frame not int reg / spill");
                            return false;
                        }
                    }
                }
                _ => {
                    bail_msg("ReturnAddress: expected at most 1 arg");
                    return false;
                }
            };
            // Under pac-ret the slot holds a signed pointer, which matches
            // no symbol range. `XPACLRI` strips x30 and no other register,
            // so the value is staged there; the epilogue reloads x30 from
            // the current frame's slot. Holding the intrinsic keeps the
            // function off the full-leaf path, so that record always
            // exists. Unconditional, as gcc and clang emit it: the hint is
            // a NOP without FEAT_PAuth and an unsigned pointer survives it.
            emit(code, enc_ldr_imm(Reg(30), fp, 8));
            emit(code, super::encode::XPACLRI);
            emit_mov_reg(code, rd, Reg(30));
            store_spilled_int(code, frame, dst, rd);
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

#[allow(clippy::too_many_arguments)]
pub(super) fn emit_mcpy(
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
pub(super) fn emit_atomic_rmw(
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
pub(super) fn emit_atomic_cas(
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
