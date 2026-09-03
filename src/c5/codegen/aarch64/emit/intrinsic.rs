use super::*;

/// `Inst::Intrinsic` lowering, operands from the allocator's `Place`s.
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
) -> Emit {
    use crate::c5::op::Intrinsic as I;
    let Some(intrinsic) = I::from_i64(kind) else {
        return fail("intrinsic: unknown discriminant");
    };
    match intrinsic {
        // Resolved to an `Imm` before lowering; reaching here is a
        // pass-ordering bug.
        I::ConstantP => fail("Intrinsic::ConstantP must be resolved before lowering"),
        I::VaStart if aarch64_host_variadic_callee(func, abi) => {
            emit_va_start_aapcs64(code, func, abi, args, alloc, frame, scratch)
        }
        I::VaStart => emit_va_start_cursor(code, func, abi, args, alloc, frame, scratch),
        // The `__va_list` struct is the target's `va_list` whether or not the
        // current function is variadic: a non-variadic forwarder walks it too,
        // so the gate is the ABI, not `func.is_variadic`.
        I::VaArg if abi.aarch64_host_variadic() => {
            emit_va_arg_aapcs64(code, args, dst, func, alloc, frame, scratch)
        }
        I::VaArg => emit_va_arg_cursor(code, func, args, dst, alloc, frame, scratch),
        // No teardown for the cursor model. args[0] is unused.
        I::VaEnd => Ok(()),
        I::VaCopy if abi.aarch64_host_variadic() => {
            emit_va_copy_aapcs64(code, args, alloc, frame, scratch)
        }
        I::VaCopy => emit_va_copy_cursor(code, args, alloc, frame, scratch),
        I::Alloca => emit_alloca(code, args, dst, alloc, frame, scratch),
        I::AllocaSave => emit_alloca_save(code, dst, frame, scratch),
        I::AllocaRestore => emit_alloca_restore(code, args, alloc, frame, scratch),
        I::SetjmpAArch64 => emit_setjmp(code, args, dst, alloc, frame, scratch),
        I::LongjmpAArch64 => emit_longjmp(code, args, alloc, frame),
        // fma / fmaf lower to Inst::Fma at the call site, so they never
        // reach the Inst::Intrinsic dispatch.
        I::Fma | I::Fmaf => Err(Unsupported::unspecified()),
        // `brk #0` raises a breakpoint / illegal-state exception.
        I::Trap => {
            emit(code, 0xD420_0000u32);
            Ok(())
        }
        // `yield`, the AArch64 spin-loop hint.
        I::CpuRelax => {
            emit(code, 0xD503_203Fu32);
            Ok(())
        }
        // `dmb ish`, a full barrier across the inner shareable domain (C11
        // 7.17.4 seq_cst).
        I::AtomicThreadFence => {
            emit(code, 0xD503_3BBFu32);
            Ok(())
        }
        // The x86-only forms; the source gates each on the target.
        I::X87StoreControlWord | I::X87LoadControlWord => {
            fail("x87 control word intrinsic is x86-only")
        }
        I::X86FxSave | I::X86FxRestore => fail("fxsave / fxrstor intrinsic is x86-only"),
        I::X86Sgdt
        | I::X86Sidt
        | I::X86Sldt
        | I::X86Str
        | I::X86Lgdt
        | I::X86Lidt
        | I::X86Lldt
        | I::X86Clflush => fail("descriptor-table intrinsic is x86-only"),
        I::Divq128 => fail("divq intrinsic is x86-64 only"),
        // `dsb ish`: data synchronisation barrier over the inner shareable
        // domain.
        I::AArch64DsbIsh => {
            emit(code, 0xD503_3B9Fu32);
            Ok(())
        }
        // `isb`: instruction synchronisation barrier.
        I::AArch64Isb => {
            emit(code, 0xD503_3FDFu32);
            Ok(())
        }
        I::AArch64DcCvau | I::AArch64IcIvau => {
            emit_cache_op(code, intrinsic, args, alloc, frame, scratch)
        }
        I::AArch64ReadCacheType => emit_read_cache_type(code, args, alloc, frame, scratch),
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
        | I::Truncf => emit_unary_fp(code, intrinsic, args, dst, v, alloc, frame),
        // __builtin_frame_address(0); a level above 0 adds a load chain.
        I::FrameAddress => emit_frame_register(code, dst, frame, Reg(29), "FrameAddress"),
        // A `register T v asm("sp")` read; `add` reads register 31 as sp.
        I::StackPointer => emit_frame_register(code, dst, frame, Reg(31), "StackPointer"),
        I::ReturnAddress => emit_return_address(code, args, dst, alloc, frame, scratch),
        // The integer bit-count and byte-swap builtins are lowered to a
        // portable shift / mask sequence in the walker; they never reach
        // codegen as an `Inst::Intrinsic`.
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
        | I::Bswap64 => fail("intrinsic: bit builtin reached codegen"),
        // C11 atomic operations are lowered to load / store /
        // read-modify-write at the call site; they never reach codegen as
        // an `Inst::Intrinsic`.
        I::AtomicLoad
        | I::AtomicStore
        | I::AtomicExchange
        | I::AtomicFetchAdd
        | I::AtomicFetchSub
        | I::AtomicFetchAnd
        | I::AtomicFetchOr
        | I::AtomicFetchXor
        | I::AtomicCompareExchangeStrong => fail("intrinsic: atomic op reached codegen"),
    }
}

/// `alloca(n)`: move sp down by `n` rounded up to 16 bytes (AAPCS64
/// 5.2.2.1) and return the new sp. The frame's spill slots and locals stay
/// reachable through fp (`Frame::dynamic_sp`); the storage is reclaimed by
/// the epilogue's `sub sp, fp, #frame_bytes`, or earlier by an
/// `AllocaRestore` closing a VLA scope (C99 6.2.4p2).
fn emit_alloca(
    code: &mut Vec<u8>,
    args: &[u32],
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    if !frame.dynamic_sp {
        return fail("Alloca: AllocaInit didn't run for this function");
    }
    if args.len() != 1 {
        return fail("Alloca: expected 1 arg");
    }
    let Some(rd) = int_or_spill_scratch(dst, scratch) else {
        return fail("Alloca: dst not int reg / spill");
    };
    let Some(n) = materialize_int(code, place_of(alloc, args[0]), scratch.primary, frame) else {
        return Err(Unsupported::unspecified());
    };
    // x17 = (n + 15) & ~15 -- the 16-byte-aligned size.
    emit(code, enc_add_imm(scratch.secondary, n, 15));
    emit(
        code,
        super::encode::enc_and_imm_neg16(scratch.secondary, scratch.secondary),
    );
    // rd is an allocator register or x16, never x17, which holds the size.
    emit(code, enc_add_imm(rd, Reg(31), 0));
    emit(code, enc_sub_reg(rd, rd, scratch.secondary));
    // Descend a page at a time with a probe each, as `emit_stack_alloc`,
    // over a run-time size; x17 carries the page count. The size is
    // 16-aligned, so the final `mov` covers at most MAX_UNPROBED_STACK_STEP
    // past the last probe.
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
    Ok(())
}

/// Snapshot sp for a VLA block (C99 6.2.4p2).
fn emit_alloca_save(code: &mut Vec<u8>, dst: Place, frame: Frame, scratch: &ScratchPool) -> Emit {
    if !frame.dynamic_sp {
        return fail("AllocaSave: AllocaInit didn't run for this function");
    }
    let Some(rd) = int_or_spill_scratch(dst, scratch) else {
        return fail("AllocaSave: dst not int reg / spill");
    };
    emit(code, enc_add_imm(rd, Reg(31), 0));
    store_spilled_int(code, frame, dst, rd);
    Ok(())
}

/// Restore the saved sp on VLA block exit, reclaiming the block's VLA
/// storage (per iteration for a loop body).
fn emit_alloca_restore(
    code: &mut Vec<u8>,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    if !frame.dynamic_sp {
        return fail("AllocaRestore: AllocaInit didn't run for this function");
    }
    if args.len() != 1 {
        return fail("AllocaRestore: expected 1 arg");
    }
    let Some(v) = materialize_int(code, place_of(alloc, args[0]), scratch.primary, frame) else {
        return fail("AllocaRestore: arg not int reg / spill / fp");
    };
    emit(code, enc_add_imm(Reg(31), v, 0));
    Ok(())
}

/// c5 binds <setjmp.h>'s setjmp() to this intrinsic on Windows aarch64,
/// where msvcrt's longjmp routes through SEH and refuses a CRT-free
/// `jmp_buf`. The inline expansion mirrors the pool path: 25 AArch64 words
/// that save x19-x28, x29, the resume PC, sp, and d8-d15 into [env].
fn emit_setjmp(
    code: &mut Vec<u8>,
    args: &[u32],
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    if args.len() != 1 {
        return fail("Setjmp: expected 1 arg");
    }
    let Some(env_r) = materialize_int(code, place_of(alloc, args[0]), scratch.primary, frame)
    else {
        return fail("Setjmp: env not int reg / spill / fp");
    };
    // The helper reads env from x19; route it there.
    if env_r.0 != 19 {
        emit_mov_reg(code, Reg(19), env_r);
    }
    emit_setjmp_aarch64(code);
    // x19 holds 0 on the initial pass and the longjmp value on a return;
    // the helper's saved PC points past its last instruction, so the
    // longjmp `br` lands here.
    let Some(rd) = int_or_spill_scratch(dst, scratch) else {
        return fail("Setjmp: dst not int reg / spill");
    };
    if rd.0 != 19 {
        emit_mov_reg(code, rd, Reg(19));
    }
    store_spilled_int(code, frame, dst, rd);
    Ok(())
}

/// c5 binds <setjmp.h>'s longjmp() to this intrinsic on Windows aarch64.
/// args[0] = env, args[1] = val. The helper restores the saved register
/// set, materializes x19 = (val != 0) ? val : 1 per C99 7.13.2.1p2, and
/// branches to the saved PC.
fn emit_longjmp(code: &mut Vec<u8>, args: &[u32], alloc: &Allocation, frame: Frame) -> Emit {
    if args.len() != 2 {
        return fail("Longjmp: expected 2 args");
    }
    let Some(env_r) = materialize_int(code, place_of(alloc, args[0]), Reg(16), frame) else {
        return fail("Longjmp: env not int reg / spill / fp");
    };
    if env_r.0 != 16 {
        emit_mov_reg(code, Reg(16), env_r);
    }
    // Stash val in x17 before the upcoming restores clobber x19.
    let Some(val_r) = materialize_int(code, place_of(alloc, args[1]), Reg(17), frame) else {
        return fail("Longjmp: val not int reg / spill / fp");
    };
    if val_r.0 != 17 {
        emit_mov_reg(code, Reg(17), val_r);
    }
    // Restore x19-x28 + x29 from [x16 + offset].
    for (i, off) in (JB_X19_OFF..JB_X29_OFF).step_by(8).enumerate() {
        emit(code, enc_ldr_imm(Reg(19 + i as u8), Reg(16), off));
    }
    emit(code, enc_ldr_imm(Reg(29), Reg(16), JB_X29_OFF));
    // x10 is caller-saved; x18 is the Windows TEB pointer and stays
    // untouched.
    emit(code, enc_ldr_imm(Reg(10), Reg(16), JB_PC_OFF));
    emit(code, enc_ldr_imm(Reg(9), Reg(16), JB_SP_OFF));
    emit(code, enc_add_imm(Reg(31), Reg(9), 0));
    for (i, off) in (JB_D8_OFF..JB_D8_OFF + 64).step_by(8).enumerate() {
        emit(code, enc_ldr_d_imm(8 + i as u8, Reg(16), off));
    }
    // cmp val, #0 ; cinc x19, val, eq -- 0 becomes 1, anything else passes
    // through unchanged.
    emit(code, enc_subs_imm(Reg(31), Reg(17), 0));
    emit(code, enc_cinc(Reg(19), Reg(17), Cond::Eq));
    emit(code, enc_br(Reg(10)));
    Ok(())
}

/// `dc cvau, Xt` / `ic ivau, Xt`: clean the data cache / invalidate the
/// instruction cache to the point of unification for the address in Xt.
fn emit_cache_op(
    code: &mut Vec<u8>,
    intrinsic: crate::c5::op::Intrinsic,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    if args.len() != 1 {
        return fail("dc/ic cache op: expected 1 arg");
    }
    let Some(rt) = materialize_int(code, place_of(alloc, args[0]), scratch.primary, frame) else {
        return Err(Unsupported::unspecified());
    };
    let base = if matches!(intrinsic, crate::c5::op::Intrinsic::AArch64DcCvau) {
        0xD50B_7B20u32
    } else {
        0xD50B_7520u32
    };
    emit(code, base | (rt.0 as u32));
    Ok(())
}

/// `mrs Xt, ctr_el0` reads the cache type register; store it to the output
/// operand's address (arg 0).
fn emit_read_cache_type(
    code: &mut Vec<u8>,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    if args.len() != 1 {
        return fail("mrs ctr_el0: expected 1 arg");
    }
    let Some(addr) = materialize_int(code, place_of(alloc, args[0]), scratch.primary, frame) else {
        return Err(Unsupported::unspecified());
    };
    let tmp = if addr.0 == scratch.secondary.0 {
        scratch.primary
    } else {
        scratch.secondary
    };
    emit(code, 0xD53B_0020u32 | (tmp.0 as u32));
    emit(code, enc_str_imm(tmp, addr, 0));
    Ok(())
}

/// The unary floating-point builtins: one instruction in the result's
/// precision, a spilled result staged through the second FP scratch.
fn emit_unary_fp(
    code: &mut Vec<u8>,
    intrinsic: crate::c5::op::Intrinsic,
    args: &[u32],
    dst: Place,
    v: super::super::ir::ValueId,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use super::encode::{
        enc_fabs_d, enc_fabs_s, enc_frintm_d, enc_frintm_s, enc_frintp_d, enc_frintp_s,
        enc_frintz_d, enc_frintz_s, enc_fsqrt_d, enc_fsqrt_s,
    };
    use crate::c5::op::Intrinsic as I;
    if args.len() != 1 {
        return fail("unary FP intrinsic: expected 1 arg");
    }
    let is_f32 = alloc.is_f32(v);
    let Some(dn) = materialize_fp_for(
        code,
        args[0],
        place_of(alloc, args[0]),
        frame.fp_scratch[0],
        frame,
        alloc,
    ) else {
        return Err(Unsupported::unspecified());
    };
    let dd = match dst {
        Place::FpReg(r) => r,
        Place::Spill(_) => frame.fp_scratch[1],
        _ => return Err(Unsupported::unspecified()),
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
    store_spilled_fp(code, frame, dst, dd);
    Ok(())
}

/// `rd = base` for the frame pointer or the stack pointer, through the
/// scratch when the destination spilled.
fn emit_frame_register(
    code: &mut Vec<u8>,
    dst: Place,
    frame: Frame,
    base: Reg,
    what: &str,
) -> Emit {
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => Reg(16),
        _ => {
            return fail(alloc::format!("{what}: dst not int reg / spill"));
        }
    };
    emit(code, enc_add_imm(rd, base, 0));
    store_spilled_int(code, frame, dst, rd);
    Ok(())
}

/// __builtin_return_address: the return address at [fp + 8] of the
/// current frame record, or of the frame an operand walked to. Under
/// pac-ret the slot holds a signed pointer; `XPACLRI` strips x30 and no
/// other register, so the value stages there (the epilogue reloads x30,
/// since the intrinsic keeps the function off the full-leaf path). The
/// hint is unconditional, as gcc and clang emit it: a NOP without
/// FEAT_PAuth.
fn emit_return_address(
    code: &mut Vec<u8>,
    args: &[u32],
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    let rd = match dst {
        Place::IntReg(r) => Reg(r),
        Place::Spill(_) => Reg(16),
        _ => {
            return fail("ReturnAddress: dst not int reg / spill");
        }
    };
    let fp = match args {
        [] => Reg(29),
        [walked] => match materialize_int(code, place_of(alloc, *walked), scratch.primary, frame) {
            Some(r) => r,
            None => {
                return fail("ReturnAddress: frame not int reg / spill");
            }
        },
        _ => {
            return fail("ReturnAddress: expected at most 1 arg");
        }
    };
    emit(code, enc_ldr_imm(Reg(30), fp, 8));
    emit(code, super::encode::XPACLRI);
    emit_mov_reg(code, rd, Reg(30));
    store_spilled_int(code, frame, dst, rd);
    Ok(())
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
) -> Emit {
    if size < 0 {
        return fail("Mcpy: negative size");
    }
    let dst_place_in = place_of(alloc, dst_val);
    let src_place_in = place_of(alloc, src_val);
    let dst_r = match materialize_int(code, dst_place_in, scratch.primary, frame) {
        Some(r) => r,
        None => return Err(Unsupported::unspecified()),
    };
    let src_r = match materialize_int(code, src_place_in, scratch.secondary, frame) {
        Some(r) => r,
        None => return Err(Unsupported::unspecified()),
    };
    // The data temp is x10, x11 or x12, whichever aliases neither base,
    // saved and restored around the copy since the allocator may hold a
    // live value in it.
    let temp = if dst_r.0 != 10 && src_r.0 != 10 {
        Reg(10)
    } else if dst_r.0 != 11 && src_r.0 != 11 {
        Reg(11)
    } else {
        Reg(12)
    };
    let bytes = size as u32;
    emit(code, enc_str_pre(temp, Reg(31), -16));
    // The byte tail's scaled immediate reaches only 4095; `WINDOW` is
    // 8-aligned and below 4096, so every offset within a window is in reach
    // and one 12-bit `add` steps both bases between windows.
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
        // Working copies keep `dst_r` (the memcpy return value) and `src_r`
        // unchanged; two more registers, saved and restored.
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
    } else {
        store_spilled_int(code, frame, dst_place, dst_r);
    }
    Ok(())
}

/// The save area of the four borrowed working registers x9..x12.
const ATOMIC_SAVE_BYTES: u32 = 32;

/// Save x9..x12: the allocator may hold a live value in any of them.
fn atomic_save_working(code: &mut Vec<u8>) {
    emit(
        code,
        enc_stp_pre(Reg(9), Reg(10), Reg(31), -(ATOMIC_SAVE_BYTES as i32)),
    );
    emit(
        code,
        super::encode::enc_stp_off(Reg(11), Reg(12), Reg(31), 16),
    );
}

/// Restore x9..x12, after the result is in a reserved scratch.
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

/// Materialise an operand into `target`, copying it out of its
/// allocator register; `sp_shift` accounts for the save area.
fn atomic_operand_into(
    code: &mut Vec<u8>,
    value: super::super::ir::ValueId,
    target: Reg,
    frame: Frame,
    sp_shift: u32,
    alloc: &Allocation,
) -> bool {
    let place = place_of(alloc, value);
    // An operand in a borrowed register may already be overwritten; read
    // its saved copy ([sp+0]=x9 .. [sp+24]=x12).
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

/// Write an atomic op's result to `dst`, after the working registers
/// are restored so a spilled result lands at the unshifted sp offset.
fn write_atomic_result(code: &mut Vec<u8>, dst: Place, src: Reg, frame: Frame) {
    super::ssa::emit_common::write_atomic_result(
        &super::ssa::emit_common::Aarch64Backend,
        code,
        dst,
        src.0,
        frame,
    );
}

/// C11 7.17.7.2-7.17.7.5 read-modify-write: an LDAXR / STLXR retry loop
/// (ARM ARM C6.2), the acquire / release pair carrying seq_cst. The
/// prior value is the result.
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
) -> Emit {
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
        return fail("AtomicRmw: operand not int reg / spill");
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
    Ok(())
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
) -> Emit {
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
        return fail("AtomicCas: operand not int reg / spill");
    }
    // The comparand is loaded once; sub-width loads zero-extend like the
    // LDAXR result, so the 64-bit compare is exact.
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
    Ok(())
}

/// The save area of the seven borrowed working registers x9..x15.
const ATOMIC128_SAVE_BYTES: u32 = 64;

/// Save x9..x15: `[sp+0]=x9 .. [sp+48]=x15`.
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

/// Restore x9..x15, after the prior value is written back.
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
    let place = place_of(alloc, value);
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

/// 128-bit read-modify-write: an LDAXP / STLXP retry loop (ARM ARM
/// B2.9), the shape aarch64 code uses for `Int128` atomics. `args` is
/// `[ptr, &oldl, &oldh, in...]` with `(cmpl, cmph, newl, newh)` for
/// `CmpXchg` and `(newl, newh)` otherwise; the prior value is written
/// back through `&oldl` / `&oldh` and there is no register result.
fn emit_atomic128(
    code: &mut Vec<u8>,
    kind: super::super::op::Intrinsic,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    use super::super::op::Intrinsic as I;
    use super::encode::{Cond, enc_ccmp, enc_ldaxp, enc_orr_reg, enc_stlxp};
    let n_in = if matches!(kind, I::Atomic128CmpXchg) {
        4
    } else {
        2
    };
    if args.len() != 3 + n_in {
        return fail("atomic128: wrong operand count");
    }
    let ptr = Reg(9);
    let oldl = Reg(10);
    let oldh = Reg(11);
    let status = scratch.secondary; // x17
    atomic128_save_working(code);
    if !atomic128_operand_into(code, args[0], ptr, frame, alloc) {
        return fail("atomic128: ptr operand not int reg / spill");
    }
    // Inputs land in x12.. in declaration order.
    for (k, &a) in args[3..].iter().enumerate() {
        if !atomic128_operand_into(code, a, Reg(12 + k as u8), frame, alloc) {
            return fail("atomic128: input operand not int reg / spill");
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
            return fail("atomic128: unexpected kind");
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
    atomic128_writeback(code, args[1], oldl, frame, alloc, scratch.primary)?;
    atomic128_writeback(code, args[2], oldh, frame, alloc, scratch.primary)?;
    atomic128_restore_working(code);
    Ok(())
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
) -> Emit {
    if !atomic128_operand_into(code, addr_val, addr_tmp, frame, alloc) {
        return fail("atomic128: output address not int reg / spill");
    }
    emit(code, enc_str_imm(src, addr_tmp, 0));
    Ok(())
}

/// 128-bit atomic load / store without LSE2: `Load` / `Store` are plain
/// `LDP` / `STP`, `LoadEx` / `StoreEx` an `LDXP` / `STXP` retry loop (ARM
/// ARM B2.9). `args` is `[ptr, &l, &h]` for the loads (the value is
/// written back through `&l` / `&h`) and `[ptr, l, h]` for the stores;
/// no register result.
fn emit_atomic128_ldst(
    code: &mut Vec<u8>,
    kind: super::super::op::Intrinsic,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    use super::super::op::Intrinsic as I;
    use super::encode::{enc_ldxp, enc_stxp};
    if args.len() != 3 {
        return fail("atomic128 ldst: wrong operand count");
    }
    let ptr = Reg(9);
    let lo = Reg(10);
    let hi = Reg(11);
    let status = scratch.secondary; // x17
    atomic128_save_working(code);
    if !atomic128_operand_into(code, args[0], ptr, frame, alloc) {
        return fail("atomic128 ldst: ptr operand not int reg / spill");
    }
    let is_load = matches!(kind, I::Atomic128Load | I::Atomic128LoadEx);
    match kind {
        // A plain load never faults on a read-only mapping.
        I::Atomic128Load => emit(code, enc_ldp_off(lo, hi, ptr, 0)),
        // The loop stores the value it read back unchanged.
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
                return fail("atomic128 ldst: store value not int reg / spill");
            }
            emit(code, enc_stp_off(Reg(12), Reg(13), ptr, 0));
        }
        // The new value sits in x12 / x13, clear of the LDXP scratch.
        I::Atomic128StoreEx => {
            if !atomic128_operand_into(code, args[1], Reg(12), frame, alloc)
                || !atomic128_operand_into(code, args[2], Reg(13), frame, alloc)
            {
                return fail("atomic128 ldst: store value not int reg / spill");
            }
            let loop_start = code.len();
            emit(code, enc_ldxp(lo, hi, ptr));
            emit(code, enc_stxp(status, Reg(12), Reg(13), ptr));
            let back = ((loop_start as i64) - (code.len() as i64)) / 4;
            emit(code, enc_cbnz(status, back as i32));
        }
        _ => {
            return fail("atomic128 ldst: unexpected kind");
        }
    }
    // Loads publish the read value through &l / &h.
    if is_load {
        atomic128_writeback(code, args[1], lo, frame, alloc, scratch.primary)?;
        atomic128_writeback(code, args[2], hi, frame, alloc, scratch.primary)?;
    }
    atomic128_restore_working(code);
    Ok(())
}

/// 128-bit masked store-insert `*mem = (*mem & ~msk) | val` as an
/// `LDXP` / `BIC` / `ORR` / `STXP` retry loop. `args` is
/// `[ptr, vl, vh, ml, mh]`; no register result.
fn emit_atomic128_store_insert(
    code: &mut Vec<u8>,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    use super::encode::{enc_bic_reg, enc_ldxp, enc_orr_reg, enc_stxp};
    if args.len() != 5 {
        return fail("atomic128 store-insert: wrong operand count");
    }
    let ptr = Reg(9);
    let lo = Reg(10);
    let hi = Reg(11);
    let status = scratch.secondary; // x17
    let (vl, vh, ml, mh) = (Reg(12), Reg(13), Reg(14), Reg(15));
    atomic128_save_working(code);
    if !atomic128_operand_into(code, args[0], ptr, frame, alloc) {
        return fail("atomic128 store-insert: ptr operand not int reg / spill");
    }
    for (r, &a) in [vl, vh, ml, mh].iter().zip(&args[1..]) {
        if !atomic128_operand_into(code, a, *r, frame, alloc) {
            return fail("atomic128 store-insert: input operand not int reg / spill");
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
    Ok(())
}
