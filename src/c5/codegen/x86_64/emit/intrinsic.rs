use super::*;

/// `Inst::X86Simd`: load the 128-bit operands into the FP scratches, run
/// the instruction the table row names, and write the result through the
/// destination address. The operands are memory-resident and only 8-byte
/// aligned, so every transfer is an unaligned `movdqu`.
pub(super) fn emit_x86_simd(
    code: &mut Vec<u8>,
    op: u32,
    imm: Option<u8>,
    args: &[super::super::ir::ValueId],
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use super::asm::{Concrete, XMM_BASE};
    use crate::c5::ir::AsmRegSize;
    use crate::c5::x86_simd::{self, Form};
    let dst_x: u8 = frame.fp_scratch[1];
    let src_x: u8 = frame.fp_scratch[0];
    let row = x86_simd::get(op);
    // An operand's value (an address for the 128-bit and pointer operands),
    // in its own register or loaded into `scratch`.
    let operand = |code: &mut Vec<u8>, i: usize, scratch: Reg| -> Option<Reg> {
        let place = alloc.places.get(args[i] as usize).copied()?;
        materialize_int(code, place, scratch, frame)
    };
    let xmm = |n: u8| Concrete::Reg {
        reg: XMM_BASE + n,
        size: AsmRegSize::Quad,
    };
    let gpr = |r: Reg, size: AsmRegSize| Concrete::Reg { reg: r.0, size };
    let at = |r: Reg, size: AsmRegSize| Concrete::Mem {
        base: r.0,
        index: None,
        scale: 1,
        disp: 0,
        size,
    };
    // The x86 assembler's own tables encode every form; a name it does
    // not special-case resolves in the generated catalogue.
    let insn = |code: &mut Vec<u8>, mnem: &'static str, ops: &[Concrete]| -> Emit {
        let m = super::asm::mnemonic_by_name(mnem).unwrap_or(super::asm::Mnemonic::Table(mnem));
        if let Err(e) = super::asm::encode(code, 8, m, None, ops) {
            return fail(alloc::format!("x86 simd: {e}"));
        }
        Ok(())
    };
    // 128-bit transfers between an address in `addr` and xmm `n`.
    let load128 = |code: &mut Vec<u8>, n: u8, addr: Reg| -> Emit {
        insn(code, "movdqu", &[at(addr, AsmRegSize::Quad), xmm(n)])
    };
    let store128 = |code: &mut Vec<u8>, addr: Reg, n: u8| -> Emit {
        insn(code, "movdqu", &[xmm(n), at(addr, AsmRegSize::Quad)])
    };
    let int_size = |w: u8| match w {
        1 => AsmRegSize::Byte,
        2 => AsmRegSize::Word,
        8 => AsmRegSize::Quad,
        _ => AsmRegSize::Long,
    };
    // Operand count: the destination address plus the sources, less the
    // immediate the node carries. A store writes through its pointer
    // operand, so it has no destination of its own.
    let need = if row.form == Form::Store {
        2
    } else {
        row.form.arity() + 1
            - usize::from(row.form.takes_imm())
            - usize::from(row.form == Form::Shift && imm.is_some())
    };
    if args.len() != need {
        return fail("x86 simd: wrong operand count");
    }
    let imm8 = Concrete::Imm(imm.unwrap_or(0) as i64);
    match row.form {
        Form::Vv | Form::VvI => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            load128(code, dst_x, a)?;
            let Some(b) = operand(code, 2, SCRATCH_R10) else {
                return fail("x86 simd: operand 2 has no place");
            };
            load128(code, src_x, b)?;
            if row.form == Form::Vv {
                insn(code, row.mnem, &[xmm(src_x), xmm(dst_x)])
            } else {
                insn(code, row.mnem, &[imm8, xmm(src_x), xmm(dst_x)])
            }?;
        }
        Form::V | Form::VI => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            load128(code, src_x, a)?;
            if row.form == Form::V {
                insn(code, row.mnem, &[xmm(src_x), xmm(dst_x)])
            } else {
                insn(code, row.mnem, &[imm8, xmm(src_x), xmm(dst_x)])
            }?;
        }
        Form::Shift => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            load128(code, dst_x, a)?;
            match imm {
                Some(_) => insn(code, row.mnem, &[imm8, xmm(dst_x)]),
                None => {
                    let Some(c) = operand(code, 2, SCRATCH_R10) else {
                        return fail("x86 simd: shift count has no place");
                    };
                    super::encode::emit_movq_xmm_r(code, Reg(src_x), c);
                    insn(code, row.mnem, &[xmm(src_x), xmm(dst_x)])
                }
            }?;
        }
        Form::Load => {
            let Some(p) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: pointer operand has no place");
            };
            load128(code, dst_x, p)?;
        }
        Form::Store => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: source operand has no place");
            };
            load128(code, dst_x, a)?;
            let Some(p) = operand(code, 0, SCRATCH_R10) else {
                return fail("x86 simd: pointer operand has no place");
            };
            return store128(code, p, dst_x);
        }
        Form::Extract => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            load128(code, src_x, a)?;
            // `pextrw` zero-extends into the 32-bit register; `pextrd`
            // writes all 32 bits. Both leave a zero-extended `int`.
            insn(
                code,
                row.mnem,
                &[imm8, xmm(src_x), gpr(SCRATCH_R11, AsmRegSize::Long)],
            )?;
            let Some(d) = operand(code, 0, SCRATCH_R10) else {
                return fail("x86 simd: destination has no place");
            };
            return insn(
                code,
                "mov",
                &[gpr(SCRATCH_R11, AsmRegSize::Long), at(d, AsmRegSize::Long)],
            );
        }
        Form::Insert => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            load128(code, dst_x, a)?;
            let Some(x) = operand(code, 2, SCRATCH_R10) else {
                return fail("x86 simd: value operand has no place");
            };
            // Every `pinsr` narrower than a quadword reads a 32-bit
            // register and uses the low lanes of it.
            let size = int_size(row.int_width.max(4));
            insn(code, row.mnem, &[imm8, gpr(x, size), xmm(dst_x)])?;
        }
        Form::MoveMask => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            load128(code, src_x, a)?;
            insn(
                code,
                row.mnem,
                &[xmm(src_x), gpr(SCRATCH_R11, AsmRegSize::Long)],
            )?;
            let Some(d) = operand(code, 0, SCRATCH_R10) else {
                return fail("x86 simd: destination has no place");
            };
            return insn(
                code,
                "mov",
                &[gpr(SCRATCH_R11, AsmRegSize::Long), at(d, AsmRegSize::Long)],
            );
        }
        Form::RdRand => {
            let size = int_size(row.int_width);
            let Some(p) = operand(code, 1, SCRATCH_R11) else {
                return fail("x86 simd: pointer operand has no place");
            };
            // `rdrand` sets the carry flag when the value is valid; the
            // stores in between leave the flags alone.
            insn(code, "rdrand", &[gpr(SCRATCH_R10, size)])?;
            insn(code, "mov", &[gpr(SCRATCH_R10, size), at(p, size)])?;
            insn(code, "setc", &[gpr(SCRATCH_R10, AsmRegSize::Byte)])?;
            insn(
                code,
                "movzx",
                &[
                    gpr(SCRATCH_R10, AsmRegSize::Byte),
                    gpr(SCRATCH_R10, AsmRegSize::Long),
                ],
            )?;
            let Some(d) = operand(code, 0, SCRATCH_R11) else {
                return fail("x86 simd: destination has no place");
            };
            return insn(
                code,
                "mov",
                &[gpr(SCRATCH_R10, AsmRegSize::Long), at(d, AsmRegSize::Long)],
            );
        }
    }
    let Some(d) = operand(code, 0, SCRATCH_R10) else {
        return fail("x86 simd: destination has no place");
    };
    if row.form.returns_vector() {
        store128(code, d, dst_x)
    } else {
        Ok(())
    }
}

/// Byte stride between adjacent variadic arguments in the cursor `va_list`
/// of Win64, the only x86_64 target on the cursor forms (System V uses the
/// register save area).
const VA_CURSOR_STRIDE: i32 = 8;

pub(super) fn emit_intrinsic(
    code: &mut Vec<u8>,
    kind: i64,
    args: &[u32],
    dst: Place,
    v: super::super::ir::ValueId,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
) -> Emit {
    use crate::c5::op::Intrinsic as I;
    let Some(intrinsic) = I::from_i64(kind) else {
        return fail("intrinsic: unknown discriminant");
    };
    match intrinsic {
        // Resolved to an `Imm` before lowering, by the SSA folds under
        // `-O` and by the walker otherwise.
        I::ConstantP => fail("Intrinsic::ConstantP must be resolved before lowering"),
        I::VaStart if sysv_variadic_callee(func, abi) => {
            emit_va_start_sysv(code, args, func, alloc, frame, abi)
        }
        // The System V `va_list` is a `__va_list_tag` struct on this
        // target, so `va_arg` / `va_copy` walk it whether or not the current
        // function is itself variadic: a non-variadic forwarder receives a
        // forwarded `va_list` and reads it the same way.
        I::VaArg if abi.sysv_host_variadic() => {
            emit_va_arg_sysv(code, args, dst, func, alloc, frame)
        }
        I::VaCopy if abi.sysv_host_variadic() => emit_va_copy_sysv(code, args, alloc, frame),
        I::VaStart => emit_va_start_cursor(code, args, func, alloc, frame),
        I::VaArg => emit_va_arg_cursor(code, args, dst, func, alloc, frame),
        // No teardown for the cursor model.
        I::VaEnd => Ok(()),
        I::VaCopy => emit_va_copy_cursor(code, args, alloc, frame),
        I::Alloca => emit_alloca(code, args, dst, alloc, frame),
        I::AllocaSave => emit_alloca_save(code, dst, frame),
        I::AllocaRestore => emit_alloca_restore(code, args, alloc, frame),
        I::SetjmpAArch64 | I::LongjmpAArch64 => {
            fail("intrinsic: AArch64 setjmp / longjmp on non-AArch64 target")
        }
        // fma / fmaf lower to Inst::Fma at the call site.
        I::Fma | I::Fmaf => fail("intrinsic: fma / fmaf lower to Inst::Fma, not Inst::Intrinsic"),
        // `ud2`: #UD, execution does not continue past it.
        I::Trap => {
            code.extend_from_slice(&[0x0F, 0x0B]);
            Ok(())
        }
        // `pause`, the spin-loop hint.
        I::CpuRelax => {
            code.extend_from_slice(&[0xF3, 0x90]);
            Ok(())
        }
        // `mfence`, a full barrier: the seq_cst thread fence (C11
        // 7.17.4.1).
        I::AtomicThreadFence => {
            code.extend_from_slice(&[0x0F, 0xAE, 0xF0]);
            Ok(())
        }
        // Every load is an acquire and every store a release (Intel SDM
        // Vol.3 8.2.3), so the weaker thread fences and the signal fence
        // need no instruction; the intrinsic is the compiler barrier.
        I::AtomicAcquireFence | I::AtomicReleaseFence | I::AtomicSignalFence => Ok(()),
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
        | I::X86Clflush => emit_mem_operand_insn(code, intrinsic, args, alloc, frame),
        I::Divq128 => emit_divq128(code, args, alloc, frame),
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
        // `__builtin_frame_address(0)`: the frame pointer. A level above 0
        // reaches here as this plus a load chain.
        I::FrameAddress => emit_reg_read(
            code,
            dst,
            frame,
            Reg::RBP,
            "FrameAddress: dst not int reg / spill",
        ),
        // A `register T v asm("rsp")` read.
        I::StackPointer => emit_reg_read(
            code,
            dst,
            frame,
            Reg::RSP,
            "StackPointer: dst not int reg / spill",
        ),
        I::ReturnAddress => emit_return_address(code, args, dst, alloc, frame),
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
            // Lowered to `Inst::BitCount` / `Inst::Bswap` in the walker.
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
            // Lowered to load / store / read-modify-write at the call site.
            fail("intrinsic: atomic op reached codegen")
        }
        I::AArch64ReadCacheType
        | I::AArch64DcCvau
        | I::AArch64IcIvau
        | I::AArch64DsbIsh
        | I::AArch64Isb => fail("aarch64 cache / barrier intrinsic is aarch64-only"),
        I::Atomic128CmpXchg
        | I::Atomic128Xchg
        | I::Atomic128FetchAnd
        | I::Atomic128FetchOr
        | I::Atomic128Load
        | I::Atomic128Store
        | I::Atomic128LoadEx
        | I::Atomic128StoreEx
        | I::Atomic128StoreInsert => fail("128-bit atomic asm shape is aarch64-only"),
    }
}

/// Whether the lowering of `intrinsic` needs the frame record: it reads
/// rbp, or moves rsp. The rest are register and memory instructions that
/// run on the caller's frame. No lowering calls a helper. The match names
/// every intrinsic, so a new one states its answer.
pub(super) fn intrinsic_keeps_frame(intrinsic: crate::c5::op::Intrinsic, abi: super::Abi) -> bool {
    use crate::c5::op::Intrinsic as I;
    match intrinsic {
        // rbp-relative: the variadic areas, the frame address, the return
        // slot above the saved rbp. A read of rsp observes the same frame,
        // below its record.
        I::VaStart | I::FrameAddress | I::ReturnAddress | I::StackPointer => true,
        // rsp moves for the rest of the function.
        I::Alloca | I::AllocaSave | I::AllocaRestore => true,
        // A pool register is borrowed around a push / pop.
        I::VaCopy => abi.sysv_host_variadic(),
        I::Divq128 => true,
        I::VaArg
        | I::VaEnd
        | I::Trap
        | I::CpuRelax
        | I::AtomicThreadFence
        | I::AtomicAcquireFence
        | I::AtomicReleaseFence
        | I::AtomicSignalFence
        | I::X87StoreControlWord
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
        | I::X86Clflush
        | I::Sqrt
        | I::Sqrtf
        | I::Fabs
        | I::Fabsf
        | I::Floor
        | I::Floorf
        | I::Ceil
        | I::Ceilf
        | I::Trunc
        | I::Truncf => false,
        // No lowering on this target; `emit_intrinsic` refuses them.
        I::ConstantP
        | I::SetjmpAArch64
        | I::LongjmpAArch64
        | I::Fma
        | I::Fmaf
        | I::Clz
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
        | I::Bswap64
        | I::AtomicLoad
        | I::AtomicStore
        | I::AtomicExchange
        | I::AtomicFetchAdd
        | I::AtomicFetchSub
        | I::AtomicFetchAnd
        | I::AtomicFetchOr
        | I::AtomicFetchXor
        | I::AtomicCompareExchangeStrong
        | I::AArch64ReadCacheType
        | I::AArch64DcCvau
        | I::AArch64IcIvau
        | I::AArch64DsbIsh
        | I::AArch64Isb
        | I::Atomic128CmpXchg
        | I::Atomic128Xchg
        | I::Atomic128FetchAnd
        | I::Atomic128FetchOr
        | I::Atomic128Load
        | I::Atomic128Store
        | I::Atomic128LoadEx
        | I::Atomic128StoreEx
        | I::Atomic128StoreInsert => true,
    }
}

/// The place of `args[i]`, for an intrinsic whose operands are addresses
/// or values the allocator placed.
fn arg_place(alloc: &Allocation, args: &[u32], i: usize, what: &'static str) -> Emit<Place> {
    match alloc.places.get(args[i] as usize).copied() {
        Some(p) => Ok(p),
        None => fail(what),
    }
}

/// System V AMD64 `va_start` (ABI 3.5.7): `args[0]` is the `__va_list_tag`
/// pointer (`args[1]`, `&last`, is unused; the named counts come from the
/// prototype). gp_offset = named_int * 8, fp_offset = 48 + named_fp * 16,
/// overflow_arg_area = the first incoming stack argument, reg_save_area =
/// the prologue-spilled area.
fn emit_va_start_sysv(
    code: &mut Vec<u8>,
    args: &[u32],
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
) -> Emit {
    if args.len() != 2 {
        return fail("VaStart: expected 2 args");
    }
    let plan = super::ssa::emit_common::param_plan(func, abi, func.n_params);
    // The offsets saturate at the bank size, so a full bank sends `va_arg`
    // straight to the overflow area; with the XMM area unpopulated
    // (`-mno-sse`) the FP bank reads as exhausted.
    let gp_offset = plan.next_gpr.min(6) as u32 * 8;
    let fp_offset = if abi.no_fp_regs {
        SYSV_REG_SAVE_BYTES
    } else {
        SYSV_GP_SAVE_BYTES + plan.next_fpr.min(8) as u32 * 16
    };
    let ap_place = arg_place(alloc, args, 0, "VaStart: &ap value id out of range")?;
    let Some(ap) = materialize_int(code, ap_place, SCRATCH_R11, frame) else {
        return fail("VaStart: &ap not in int reg / spill");
    };
    super::encode::emit_mov_mem32_imm32(code, ap, 0, gp_offset as i32);
    super::encode::emit_mov_mem32_imm32(code, ap, 4, fp_offset as i32);
    // overflow_arg_area: incoming stack arguments sit above the return
    // address at [rbp + 16]; the named parameters that overflowed the
    // argument registers occupy the low slots there.
    let named_stack_bytes = plan.stack_bytes.next_multiple_of(8) as i32;
    emit_lea_r_mem(code, SCRATCH_R10, Reg::RBP, 16 + named_stack_bytes);
    emit_mov_mem_r(code, ap, 8, SCRATCH_R10);
    emit_lea_r_mem(code, SCRATCH_R10, Reg::RBP, frame.va_reg_save_off);
    emit_mov_mem_r(code, ap, 16, SCRATCH_R10);
    Ok(())
}

/// System V `va_copy`: the 24-byte `__va_list_tag` copy (ABI 3.5.7),
/// `args[0]` = &dst, `args[1]` = &src. The pointers ride r10 / r11; the
/// copied word borrows a pool register around a push / pop pair, the spill
/// loads running before the push.
fn emit_va_copy_sysv(code: &mut Vec<u8>, args: &[u32], alloc: &Allocation, frame: Frame) -> Emit {
    if args.len() != 2 {
        return fail("VaCopy: expected 2 args");
    }
    let src_place = arg_place(alloc, args, 1, "VaCopy: &src value id out of range")?;
    let Some(src_p) = materialize_int(code, src_place, SCRATCH_R11, frame) else {
        return fail("VaCopy: &src not in int reg / spill");
    };
    let dst_place = arg_place(alloc, args, 0, "VaCopy: &dst value id out of range")?;
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
    for off in [0i32, 8, 16] {
        emit_mov_r_mem(code, temp, src_p, off);
        emit_mov_mem_r(code, dst_p, off, temp);
    }
    emit_pop_r(code, temp);
    Ok(())
}

/// Win64 `va_start(&ap, &last)`: `*ap` = the home slot past the named parameters,
/// one slot each; `&last` of an aggregate is its body copy, so it goes unused.
fn emit_va_start_cursor(
    code: &mut Vec<u8>,
    args: &[u32],
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    if args.len() != 2 {
        return fail("VaStart: expected 2 args");
    }
    let ap_place = arg_place(alloc, args, 0, "VaStart: &ap value id out of range")?;
    let Some(ap) = materialize_int(code, ap_place, SCRATCH_R11, frame) else {
        return fail("VaStart: &ap not in int reg / spill");
    };
    let first = 16 + VA_CURSOR_STRIDE * func.n_params as i32;
    emit_lea_r_mem(code, SCRATCH_R10, Reg::RBP, first);
    emit_mov_mem_r(code, ap, 0, SCRATCH_R10);
    Ok(())
}

/// Win64 `va_arg`: returns `*ap`, or the address it holds for a type passed by
/// reference (`args[1]` describes the type), and advances it by the stride. The cursor,
/// the loaded value and the advance occupy distinct registers so the
/// writeback goes through the cursor: the cursor moves to r11 when it
/// would alias the work register, the advance takes r10.
fn emit_va_arg_cursor(
    code: &mut Vec<u8>,
    args: &[u32],
    dst: Place,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    if args.is_empty() {
        return fail("VaArg: expected at least the ap argument");
    }
    let ap_place = arg_place(alloc, args, 0, "VaArg: &ap value id out of range")?;
    let ap = match ap_place {
        Place::IntReg(r) => {
            let work_aliases = matches!(dst, Place::IntReg(d) if d == r);
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
    // The destination register when distinct from the cursor, else r10.
    let work = match dst {
        Place::IntReg(d) if Reg(d).0 != ap.0 => Reg(d),
        _ => SCRATCH_R10,
    };
    emit_mov_r_mem(code, work, ap, 0);
    if let Some(Inst::Imm(d)) = args.get(1).and_then(|a| func.insts.get(*a as usize))
        && crate::c5::op::VaArgDesc::unpack(*d).by_ref
    {
        super::encode::emit_mi(code, Mnem::Add, 8, ap, 0, VA_CURSOR_STRIDE);
        emit_mov_r_mem(code, work, work, 0);
        spill_dst_to_slot(code, dst, work, frame);
        return Ok(());
    }
    let advance = SCRATCH_R10;
    if advance.0 == work.0 {
        // Destination spilled: store the result before reusing r10 for
        // the advance.
        spill_dst_to_slot(code, dst, work, frame);
        emit_lea_r_mem(code, advance, work, VA_CURSOR_STRIDE);
        emit_mov_mem_r(code, ap, 0, advance);
    } else {
        emit_lea_r_mem(code, advance, work, VA_CURSOR_STRIDE);
        emit_mov_mem_r(code, ap, 0, advance);
        spill_dst_to_slot(code, dst, work, frame);
    }
    Ok(())
}

/// Win64 `va_copy(&dst, &src)`: `*dst = *src`. The source value loads into
/// r10 before the destination pointer materializes, so r11 serves both
/// pointers in turn.
fn emit_va_copy_cursor(code: &mut Vec<u8>, args: &[u32], alloc: &Allocation, frame: Frame) -> Emit {
    if args.len() != 2 {
        return fail("VaCopy: expected 2 args");
    }
    let dst_place = arg_place(alloc, args, 0, "VaCopy: &dst value id out of range")?;
    let src_place = arg_place(alloc, args, 1, "VaCopy: &src value id out of range")?;
    let Some(src_p) = materialize_int(code, src_place, SCRATCH_R11, frame) else {
        return fail("VaCopy: &src not in int reg / spill");
    };
    let scratch = SCRATCH_R10;
    emit_mov_r_mem(code, scratch, src_p, 0);
    let Some(dst_p) = materialize_int(code, dst_place, SCRATCH_R11, frame) else {
        return fail("VaCopy: &dst not in int reg / spill");
    };
    emit_mov_mem_r(code, dst_p, 0, scratch);
    Ok(())
}

/// `alloca(n)`: rsp moves down by `n` rounded up to 16 and is returned; the
/// frame stays reachable through rbp (`Frame::dynamic_sp`) and the storage
/// is reclaimed by the epilogue or an `AllocaRestore` (C99 6.2.4p2). rsp
/// walks down page by page as in `emit_stack_alloc`, the size being a
/// run-time value.
fn emit_alloca(
    code: &mut Vec<u8>,
    args: &[u32],
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
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
    // rd_phys receives the result (r10 for a spill dst); the rounded size
    // rides r11. Both scratches sit outside the allocator banks, and rd is
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
    emit_mov_rr(code, rd_phys, Reg::RSP);
    super::encode::emit_rr(code, Mnem::Sub, 8, rd_phys, size_reg);
    // The size is 16-aligned, so the amount the settling `mov` covers past
    // the last probe is at most MAX_UNPROBED_STACK_STEP.
    super::encode::emit_shift_ri(code, Mnem::Shr, 8, size_reg, 12);
    super::encode::emit_rr(code, Mnem::Test, 8, size_reg, size_reg);
    super::encode::emit_jcc_rel32(code, Cc::E, 0);
    let skip_at = code.len() - 4;
    let loop_start = code.len();
    emit_sub_rsp(code, STACK_PROBE_PAGE);
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
    Ok(())
}

/// Snapshot rsp for a VLA block (C99 6.2.4p2).
fn emit_alloca_save(code: &mut Vec<u8>, dst: Place, frame: Frame) -> Emit {
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
    Ok(())
}

/// Restore the saved rsp on VLA block exit, reclaiming the block's storage
/// (per iteration for a loop body).
fn emit_alloca_restore(code: &mut Vec<u8>, args: &[u32], alloc: &Allocation, frame: Frame) -> Emit {
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
    Ok(())
}

/// The single-memory-operand x87 / system forms: the operand address is
/// forced into r10 so the ModRM byte needs no SIB or displacement (rm 010
/// under REX.B). Opcode and ModRM.reg per form:
///   fnstcw/fldcw = D9 /7,/5 ; fxsave/fxrstor = 0F AE /0,/1 ;
///   sgdt/sidt = 0F 01 /0,/1 ; lgdt/lidt = 0F 01 /2,/3 ;
///   sldt/str  = 0F 00 /0,/1 ; lldt = 0F 00 /2 ; clflush = 0F AE /7.
fn emit_mem_operand_insn(
    code: &mut Vec<u8>,
    intrinsic: crate::c5::op::Intrinsic,
    args: &[u32],
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use crate::c5::op::Intrinsic as I;
    if args.len() != 1 {
        return fail("single-memory-operand intrinsic expects 1 arg");
    }
    let place = arg_place(
        alloc,
        args,
        0,
        "single-memory-operand intrinsic: arg place missing",
    )?;
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
    Ok(())
}

/// Unsigned 128/64 division (`udiv_qrnnd`): `div` reads rdx:rax = n1:n0
/// and leaves the quotient in rax and the remainder in rdx. args:
/// `[q_addr, rem_addr, n0, n1, d]`. rax / rdx are preserved and the output
/// addresses pushed (remainder popped first); each operand is read through
/// the rsp shift the pushes produced.
fn emit_divq128(code: &mut Vec<u8>, args: &[u32], alloc: &Allocation, frame: Frame) -> Emit {
    const RAX: Reg = Reg(0);
    const RDX: Reg = Reg(2);
    const R10: Reg = Reg(10);
    const R11: Reg = Reg(11);
    if args.len() != 5 {
        return fail("divq: wrong operand count");
    }
    // Force args[idx] into `scratch`; `pushed` counts the 8-byte pushes
    // emitted so far.
    let materialize_at =
        |code: &mut Vec<u8>, idx: usize, scratch: Reg, pushed: u32| -> Option<Reg> {
            let place = alloc.places.get(args[idx] as usize).copied()?;
            let r = materialize_int_shifted(code, place, scratch, frame, 8 * pushed)?;
            if r.0 != scratch.0 {
                super::encode::emit_mov_rr(code, scratch, r);
            }
            Some(scratch)
        };
    super::encode::emit_push_r(code, RAX);
    super::encode::emit_push_r(code, RDX);
    if materialize_at(code, 0, R10, 2).is_none() {
        return fail("divq: quotient output not an address");
    }
    super::encode::emit_push_r(code, R10);
    if materialize_at(code, 1, R10, 3).is_none() {
        return fail("divq: remainder output not an address");
    }
    super::encode::emit_push_r(code, R10);
    // Divisor -> r10, dividend high -> r11, then rax last so an input the
    // allocator placed in rax / rdx is read first.
    if materialize_at(code, 4, R10, 4).is_none() {
        return fail("divq: divisor operand missing");
    }
    if materialize_at(code, 3, R11, 4).is_none() {
        return fail("divq: dividend-high operand missing");
    }
    if materialize_at(code, 2, RAX, 4).is_none() {
        return fail("divq: dividend-low operand missing");
    }
    super::encode::emit_mov_rr(code, RDX, R11);
    // div r10 (REX.W + REX.B, F7 /6).
    code.extend_from_slice(&[0x49, 0xF7, 0xF2]);
    super::encode::emit_pop_r(code, R11);
    super::encode::emit_mov_mem_r(code, R11, 0, RDX);
    super::encode::emit_pop_r(code, R11);
    super::encode::emit_mov_mem_r(code, R11, 0, RAX);
    super::encode::emit_pop_r(code, RDX);
    super::encode::emit_pop_r(code, RAX);
    Ok(())
}

/// The value of `src` (rbp or rsp) into the destination.
fn emit_reg_read(
    code: &mut Vec<u8>,
    dst: Place,
    frame: Frame,
    src: Reg,
    no_dst: &'static str,
) -> Emit {
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail(no_dst);
    };
    emit_mov_rr(code, rd, src);
    spill_dst_to_slot(code, dst, rd, frame);
    Ok(())
}

/// `__builtin_return_address`: the return address a frame record holds at
/// [fp + 8], above the saved rbp. Without an operand the record is the
/// current frame's; with one, the frame address a level above 0 walked to.
fn emit_return_address(
    code: &mut Vec<u8>,
    args: &[u32],
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("ReturnAddress: dst not int reg / spill");
    };
    let fp = match args {
        [] => Reg::RBP,
        [walked] => {
            let Some(r) = int_operand_into_rd(code, place_of(alloc, *walked), rd, frame) else {
                return fail("ReturnAddress: frame not int reg / spill");
            };
            r
        }
        _ => return fail("ReturnAddress: expected at most 1 arg"),
    };
    emit_mov_r_mem(code, rd, fp, 8);
    spill_dst_to_slot(code, dst, rd, frame);
    Ok(())
}

/// Zero `size` bytes at `dst_val`: a `movups` per 16 bytes from `xmm` zeroed once, else an
/// immediate store per unit; past `MAX_MEM_FILL_ACCESSES` stores, a loop of r10 up to r11.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_mzero(
    code: &mut Vec<u8>,
    dst_val: u32,
    size: i64,
    align: u32,
    xmm: Option<u8>,
    strict_align: bool,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use super::encode::{emit_mi, emit_movups_mem_xmm};
    if size < 0 {
        return fail("Mzero: negative size");
    }
    let Some(base) = materialize_int(code, place_of(alloc, dst_val), SCRATCH_R10, frame) else {
        return fail("Mzero: dst base not int reg / spill");
    };
    let unit = super::super::access_chunk(align, strict_align, 8);
    let total = size as u64;
    let xmm = xmm.filter(|_| unit == 8 && total >= 16).map(Reg);
    let widest = if xmm.is_some() { 16 } else { unit };
    let width = |left: u32| {
        let mut w = widest;
        while w > left {
            w /= 2;
        }
        w
    };
    let store = |code: &mut Vec<u8>, w: u32, base: Reg, off: i32| match xmm {
        Some(x) if w == 16 => emit_movups_mem_xmm(code, base, off, x),
        _ => emit_mi(code, Mnem::Mov, w as u8, base, off, 0),
    };
    if let Some(x) = xmm {
        emit_xorps(code, x, x);
    }
    let stores = total / u64::from(widest) + u64::from((total % u64::from(widest)).count_ones());
    if stores <= crate::c5::ast::MAX_MEM_FILL_ACCESSES as u64 {
        let total = total as u32;
        let mut off = 0u32;
        while off < total {
            let w = width(total - off);
            store(code, w, base, off as i32);
            off += w;
        }
        return Ok(());
    }
    let (cursor, end) = (SCRATCH_R10, SCRATCH_R11);
    if base.0 != cursor.0 {
        emit_mov_rr(code, cursor, base);
    }
    let step = if unit >= 8 { 16 } else { unit };
    let tail = (total % u64::from(step)) as u32;
    let bytes = total - u64::from(tail);
    match i32::try_from(bytes) {
        Ok(disp) => emit_lea_r_mem(code, end, cursor, disp),
        Err(_) => {
            emit_mov_r_imm64(code, end, bytes as i64);
            emit_rr(code, Mnem::Add, 8, end, cursor);
        }
    }
    let top = code.len();
    if xmm.is_none() && step == 16 {
        store(code, 8, cursor, 0);
        store(code, 8, cursor, 8);
    } else {
        store(code, step, cursor, 0);
    }
    emit_ri(code, Mnem::Add, 8, cursor, step as i32);
    emit_rr(code, Mnem::Cmp, 8, cursor, end);
    let back = top as i64 - (code.len() as i64 + 2);
    debug_assert!(back >= -128, "Mzero: loop body of {} bytes", -back);
    emit_jcc_rel8(code, Cc::B, back as i8);
    let mut off = 0u32;
    while off < tail {
        let w = width(tail - off);
        store(code, w, cursor, off as i32);
        off += w;
    }
    Ok(())
}

/// The registers a copy takes its temporaries among, in order: the writer's
/// scratch, which holds no value, then rax and the argument registers of the
/// function's own convention, its volatile bank.
fn copy_temps(abi: super::Abi) -> Vec<u8> {
    [SCRATCH_R10.0, SCRATCH_R11.0, Reg::RAX.0]
        .into_iter()
        .chain(abi.int_arg_regs.iter().copied())
        .collect()
}

/// Copy `size` bytes from `src_val` to `dst_val` through registers free at
/// the site ([`SiteRegs`]): a `movups` per 16 bytes through `xmm` where the
/// alignment allows, else one unit per access, the tail through halving
/// widths. Up to `MAX_MEM_FILL_ACCESSES` accesses are written in place; a
/// larger copy loops cursors over the whole units and copies the tail past
/// them. A base whose register holds nothing after the copy, or a spill's
/// reload, serves as its own cursor.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_mcpy(
    code: &mut Vec<u8>,
    v: super::super::ir::ValueId,
    dst_place: Place,
    dst_val: u32,
    src_val: u32,
    size: i64,
    align: u32,
    xmm: Option<u8>,
    strict_align: bool,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
) -> Emit {
    let Ok(bytes) = u32::try_from(size) else {
        return fail("Mcpy: size outside 32 bits");
    };
    let dst_in = place_of(alloc, dst_val);
    let src_in = place_of(alloc, src_val);
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
    let unit = super::super::access_chunk(align, strict_align, 8);
    let xmm = xmm.filter(|_| unit == 8 && bytes >= 16).map(Reg);
    let widest = if xmm.is_some() { 16 } else { unit };
    let candidates = copy_temps(abi);
    let taken = [dst_r.0, src_r.0];
    let mut regs = SiteRegs::new(alloc, v, &candidates, &taken, frame.fixed_regs);
    let width = |left: u32| {
        let mut w = widest;
        while w > left {
            w /= 2;
        }
        w
    };
    let access = |code: &mut Vec<u8>, w: u32, temp: Option<Reg>, s: Reg, d: Reg, off: i32| match (
        w, xmm, temp,
    ) {
        (16, Some(x), _) => {
            emit_movups_xmm_mem(code, x, s, off);
            emit_movups_mem_xmm(code, d, off, x);
        }
        (_, _, Some(t)) => emit_copy_unit(code, w, t, s, d, off),
        _ => unreachable!("ICE: Mcpy: a unit access without its temporary"),
    };
    let inline = super::ssa::emit_common::transfer_accesses(bytes, widest)
        <= crate::c5::ast::MAX_MEM_FILL_ACCESSES as u32;
    // The units below 16 bytes go through a general register.
    let needs_temp = xmm.is_none() || bytes % 16 != 0;
    let temp = if needs_temp {
        let Some(t) = regs.take(code) else {
            return fail("Mcpy: no register for the copy");
        };
        Some(t)
    } else {
        None
    };
    // The copy's value is the destination; a cursor run over a spilled one
    // reloads it.
    let mut reload = false;
    if inline {
        let mut off = 0u32;
        while off < bytes {
            let w = width(bytes - off);
            access(code, w, temp, src_r, dst_r, off as i32);
            off += w;
        }
    } else {
        let step = widest;
        let looped = bytes - bytes % step;
        let dead = |place: Place, r: Reg| {
            matches!(place, Place::Spill(_))
                || (!alloc.holds_live_across(v, r.0) && !frame.fixed_regs.has_gpr(r.0))
        };
        let cursor = |code: &mut Vec<u8>, regs: &mut SiteRegs, base: Reg| {
            let c = regs.take(code)?;
            emit_mov_rr(code, c, base);
            Some(c)
        };
        let s = if src_r.0 != dst_r.0 && dead(src_in, src_r) {
            src_r
        } else {
            let Some(s) = cursor(code, &mut regs, src_r) else {
                return fail("Mcpy: no register for the copy");
            };
            s
        };
        let d = if dead(dst_in, dst_r)
            && (dst_place == Place::None || matches!(dst_in, Place::Spill(_)))
        {
            dst_r
        } else {
            let Some(d) = cursor(code, &mut regs, dst_r) else {
                return fail("Mcpy: no register for the copy");
            };
            d
        };
        let Some(e) = regs.take(code) else {
            return fail("Mcpy: no register for the copy");
        };
        match i32::try_from(looped) {
            Ok(disp) => emit_lea_r_mem(code, e, s, disp),
            Err(_) => {
                emit_mov_r_imm64(code, e, i64::from(looped));
                emit_rr(code, Mnem::Add, 8, e, s);
            }
        }
        let top = code.len();
        access(code, step, temp, s, d, 0);
        emit_ri(code, Mnem::Add, 8, s, step as i32);
        emit_ri(code, Mnem::Add, 8, d, step as i32);
        emit_rr(code, Mnem::Cmp, 8, s, e);
        let back = top as i64 - (code.len() as i64 + 2);
        debug_assert!(back >= -128, "Mcpy: loop body of {} bytes", -back);
        emit_jcc_rel8(code, Cc::Ne, back as i8);
        let mut off = 0u32;
        while off < bytes - looped {
            let w = width(bytes - looped - off);
            access(code, w, temp, s, d, off as i32);
            off += w;
        }
        reload = d.0 == dst_r.0 && dst_place != Place::None;
    }
    regs.restore(code);
    let result = if reload {
        materialize_int(code, dst_in, SCRATCH_R10, frame).unwrap_or(dst_r)
    } else {
        dst_r
    };
    match dst_place {
        Place::IntReg(r) if r != result.0 => emit_mov_rr(code, Reg(r), result),
        Place::Spill(_) => spill_dst_to_slot(code, dst_place, result, frame),
        _ => {}
    }
    Ok(())
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
fn emit_mov_r_mem_width(code: &mut Vec<u8>, dst: Reg, base: Reg, width: u8) {
    match width {
        1 => super::encode::emit_movzx_r_mem8(code, dst, base, 0),
        2 => super::encode::emit_movzx_r_mem16(code, dst, base, 0),
        4 => super::encode::emit_mov_r32_mem(code, dst, base, 0),
        _ => emit_mov_r_mem(code, dst, base, 0),
    }
}

/// Store the low `width` bytes of `src` to `[base]`; the companion to
/// [`emit_atomic_load`] for the compare-exchange expected-operand writeback.
fn emit_mov_mem_r_width(code: &mut Vec<u8>, base: Reg, src: Reg, width: u8) {
    match width {
        1 => super::encode::emit_mov_mem_r8(code, base, 0, src),
        2 => super::encode::emit_mov_mem_r16(code, base, 0, src),
        4 => super::encode::emit_mov_mem_r32(code, base, 0, src),
        _ => emit_mov_mem_r(code, base, 0, src),
    }
}

/// An operand's value in `scratch`, copied from its own register when it
/// has one so the caller may clobber that register; `sp_shift` counts the
/// borrowed registers already pushed.
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

/// C11 7.17.7.2 load of `width` bytes, zero-extended: a plain `mov`
/// for every order. A load is an acquire (Intel SDM Vol.3 8.2.3), and
/// against the `xchg` seq_cst store it is the seq_cst load. The address
/// rides its own register or r11; the result lands in `dst`'s register
/// or r10.
pub(super) fn emit_atomic_load(
    code: &mut Vec<u8>,
    dst: Place,
    addr: super::super::ir::ValueId,
    width: u8,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    let Some(a) = materialize_int(code, place_of(alloc, addr), SCRATCH_R11, frame) else {
        return fail("AtomicLoad: address not int reg / spill");
    };
    let rd = int_or_spill_dst(dst).unwrap_or(SCRATCH_R10);
    emit_mov_r_mem_width(code, rd, a, width);
    spill_dst_to_slot(code, dst, rd, frame);
    Ok(())
}

/// C11 7.17.7.1 store of the low `width` bytes of `value`: `xchg` for
/// seq_cst, whose implicit lock orders it before every later load
/// (Intel SDM Vol.3 8.2.3.9); a plain `mov`, already a release, for
/// the rest. The address rides its own register or r11, the value r10.
pub(super) fn emit_atomic_store(
    code: &mut Vec<u8>,
    addr: super::super::ir::ValueId,
    value: super::super::ir::ValueId,
    width: u8,
    order: super::super::ir::MemOrder,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    let Some(a) = materialize_int(code, place_of(alloc, addr), SCRATCH_R11, frame) else {
        return fail("AtomicStore: address not int reg / spill");
    };
    if order == super::super::ir::MemOrder::SeqCst {
        // XCHG writes the prior contents back into its register
        // operand, so the value is copied out of its own register.
        let Some(v) = operand_into(code, value, SCRATCH_R10, frame, 0, alloc) else {
            return fail("AtomicStore: value not int reg / spill");
        };
        emit_xchg_mem_r(code, a, 0, v, width);
    } else {
        let Some(v) = materialize_int(code, place_of(alloc, value), SCRATCH_R10, frame) else {
            return fail("AtomicStore: value not int reg / spill");
        };
        emit_mov_mem_r_width(code, a, v, width);
    }
    Ok(())
}

/// An operand in rax, which a `CMPXCHG` takes as its accumulator, moved
/// to `scratch`; any other register stays.
fn off_rax(code: &mut Vec<u8>, r: Reg, scratch: Reg) -> Reg {
    if r == Reg::RAX {
        emit_mov_rr(code, scratch, r);
        scratch
    } else {
        r
    }
}

/// Write the atomic result `r` to `dst` and pop what `regs` pushed, the
/// last first. A result in a pushed register leaves through r10, which
/// the consumed operands no longer need.
fn finish_atomic(code: &mut Vec<u8>, regs: &[&SiteRegs], dst: Place, r: Reg, frame: Frame) {
    let r = if regs.iter().any(|s| s.borrowed(r)) {
        emit_mov_rr(code, SCRATCH_R10, r);
        SCRATCH_R10
    } else {
        r
    };
    for s in regs.iter().rev() {
        s.restore(code);
    }
    write_atomic_result(code, dst, r, frame);
}

/// C11 7.17.7.2-7.17.7.5 read-modify-write (Intel SDM Vol.2): `XCHG` for
/// exchange and `LOCK XADD` for addition and subtraction, the operand
/// negated, both leaving the prior contents in their register; for the
/// bitwise operators a `LOCK AND` / `OR` / `XOR` when the prior contents
/// are unread, else a `LOCK CMPXCHG` retry on rax. A locked instruction
/// is a full barrier, so every order lowers alike (the x86 mapping of
/// C11 atomics). The address rides its own register or r11.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_atomic_rmw(
    code: &mut Vec<u8>,
    v: super::super::ir::ValueId,
    dst: Place,
    op: super::super::ir::AtomicRmwOp,
    addr: super::super::ir::ValueId,
    value: super::super::ir::ValueId,
    width: u8,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
) -> Emit {
    use super::super::ir::AtomicRmwOp as Op;
    let Some(a) = materialize_int(code, place_of(alloc, addr), SCRATCH_R11, frame) else {
        return fail("AtomicRmw: address not int reg / spill");
    };
    let mnem = match op {
        Op::Xchg | Op::Add | Op::Sub => {
            // The exchanged register: the result's own, unless the
            // address rides it.
            let t = match dst {
                Place::IntReg(r) if r != a.0 => Reg(r),
                _ => SCRATCH_R10,
            };
            let Some(x) = materialize_int(code, place_of(alloc, value), t, frame) else {
                return fail("AtomicRmw: operand not int reg / spill");
            };
            emit_mov_rr(code, t, x);
            if op == Op::Sub {
                emit_unary_r(code, Mnem::Neg, 8, t);
            }
            if op == Op::Xchg {
                emit_xchg_mem_r(code, a, 0, t, width);
            } else {
                emit_lock_xadd_mem_r(code, a, 0, t, width);
            }
            write_atomic_result(code, dst, t, frame);
            return Ok(());
        }
        Op::And => Mnem::And,
        Op::Or => Mnem::Or,
        Op::Xor => Mnem::Xor,
    };
    let Some(x) = materialize_int(code, place_of(alloc, value), SCRATCH_R10, frame) else {
        return fail("AtomicRmw: operand not int reg / spill");
    };
    if dst == Place::None {
        super::encode::emit_lock_alu_mem_r(code, mnem, a, 0, x, width);
        return Ok(());
    }
    let a = off_rax(code, a, SCRATCH_R11);
    let x = off_rax(code, x, SCRATCH_R10);
    let fixed = frame.fixed_regs;
    let mut acc = SiteRegs::new(alloc, v, &[Reg::RAX.0], &[a.0, x.0], fixed);
    if acc.take(code) != Some(Reg::RAX) {
        return fail("AtomicRmw: rax is reserved");
    }
    let mut taken = alloc::vec![a.0, x.0, Reg::RAX.0];
    if let Place::IntReg(r) = dst {
        taken.push(r);
    }
    let mut temps = SiteRegs::new(alloc, v, &copy_temps(abi), &taken, fixed);
    let Some(t) = temps.take(code) else {
        return fail("AtomicRmw: no register for the retry");
    };
    emit_mov_r_mem_width(code, Reg::RAX, a, width);
    let retry = code.len();
    emit_mov_rr(code, t, Reg::RAX);
    emit_rr(code, mnem, 8, t, x);
    emit_lock_cmpxchg_mem_r(code, a, 0, t, width);
    // Back while the object changed under the retry (ZF clear); the rel8
    // counts from the byte past the 2-byte Jcc.
    let rel = (retry as i64) - (code.len() as i64 + 2);
    emit_jcc_rel8(code, Cc::Ne, rel as i8);
    finish_atomic(code, &[&acc, &temps], dst, Reg::RAX, frame);
    Ok(())
}

/// C11 7.17.7.4 compare-and-exchange as `LOCK CMPXCHG` (Intel SDM Vol.2),
/// a full barrier whatever the order: rax takes the comparand
/// zero-extended from `width` bytes and leaves with the prior contents,
/// which a match leaves equal to it. The address rides its own register
/// or r11, `desired` its own or r10.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_atomic_cas(
    code: &mut Vec<u8>,
    v: super::super::ir::ValueId,
    dst: Place,
    addr: super::super::ir::ValueId,
    expected: super::super::ir::ValueId,
    desired: super::super::ir::ValueId,
    width: u8,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    let a = materialize_int(code, place_of(alloc, addr), SCRATCH_R11, frame);
    let d = materialize_int(code, place_of(alloc, desired), SCRATCH_R10, frame);
    let (Some(a), Some(d)) = (a, d) else {
        return fail("AtomicCas: operand not int reg / spill");
    };
    let a = off_rax(code, a, SCRATCH_R11);
    let d = off_rax(code, d, SCRATCH_R10);
    let mut acc = SiteRegs::new(alloc, v, &[Reg::RAX.0], &[a.0, d.0], frame.fixed_regs);
    if acc.take(code) != Some(Reg::RAX) {
        return fail("AtomicCas: rax is reserved");
    }
    let e_place = place_of(alloc, expected);
    let Some(e) = materialize_int_shifted(code, e_place, Reg::RAX, frame, acc.saved_bytes()) else {
        return fail("AtomicCas: comparand not int reg / spill");
    };
    match width {
        1 => emit_movzx_r_r8(code, Reg::RAX, e),
        2 => super::encode::emit_movzx_r_r16(code, Reg::RAX, e),
        4 => super::encode::emit_mov_r32_r32(code, Reg::RAX, e),
        _ => emit_mov_rr(code, Reg::RAX, e),
    }
    emit_lock_cmpxchg_mem_r(code, a, 0, d, width);
    finish_atomic(code, &[&acc], dst, Reg::RAX, frame);
    Ok(())
}
