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
) -> bool {
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
    let insn = |code: &mut Vec<u8>, mnem: &'static str, ops: &[Concrete]| -> bool {
        let m = super::asm::mnemonic_by_name(mnem).unwrap_or(super::asm::Mnemonic::Table(mnem));
        if let Err(e) = super::asm::encode(code, 8, m, None, ops) {
            bail_msg(&alloc::format!("x86 simd: {e}"));
            return false;
        }
        true
    };
    // 128-bit transfers between an address in `addr` and xmm `n`.
    let load128 = |code: &mut Vec<u8>, n: u8, addr: Reg| -> bool {
        insn(code, "movdqu", &[at(addr, AsmRegSize::Quad), xmm(n)])
    };
    let store128 = |code: &mut Vec<u8>, addr: Reg, n: u8| -> bool {
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
            if !load128(code, dst_x, a) {
                return false;
            }
            let Some(b) = operand(code, 2, SCRATCH_R10) else {
                return fail("x86 simd: operand 2 has no place");
            };
            if !load128(code, src_x, b) {
                return false;
            }
            let ok = if row.form == Form::Vv {
                insn(code, row.mnem, &[xmm(src_x), xmm(dst_x)])
            } else {
                insn(code, row.mnem, &[imm8, xmm(src_x), xmm(dst_x)])
            };
            if !ok {
                return false;
            }
        }
        Form::V | Form::VI => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            if !load128(code, src_x, a) {
                return false;
            }
            let ok = if row.form == Form::V {
                insn(code, row.mnem, &[xmm(src_x), xmm(dst_x)])
            } else {
                insn(code, row.mnem, &[imm8, xmm(src_x), xmm(dst_x)])
            };
            if !ok {
                return false;
            }
        }
        Form::Shift => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            if !load128(code, dst_x, a) {
                return false;
            }
            let ok = match imm {
                Some(_) => insn(code, row.mnem, &[imm8, xmm(dst_x)]),
                None => {
                    let Some(c) = operand(code, 2, SCRATCH_R10) else {
                        return fail("x86 simd: shift count has no place");
                    };
                    super::encode::emit_movq_xmm_r(code, Reg(src_x), c);
                    insn(code, row.mnem, &[xmm(src_x), xmm(dst_x)])
                }
            };
            if !ok {
                return false;
            }
        }
        Form::Load => {
            let Some(p) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: pointer operand has no place");
            };
            if !load128(code, dst_x, p) {
                return false;
            }
        }
        Form::Store => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: source operand has no place");
            };
            if !load128(code, dst_x, a) {
                return false;
            }
            let Some(p) = operand(code, 0, SCRATCH_R10) else {
                return fail("x86 simd: pointer operand has no place");
            };
            return store128(code, p, dst_x);
        }
        Form::Extract => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            if !load128(code, src_x, a) {
                return false;
            }
            // `pextrw` zero-extends into the 32-bit register; `pextrd`
            // writes all 32 bits. Both leave a zero-extended `int`.
            if !insn(
                code,
                row.mnem,
                &[imm8, xmm(src_x), gpr(SCRATCH_R11, AsmRegSize::Long)],
            ) {
                return false;
            }
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
            if !load128(code, dst_x, a) {
                return false;
            }
            let Some(x) = operand(code, 2, SCRATCH_R10) else {
                return fail("x86 simd: value operand has no place");
            };
            // Every `pinsr` narrower than a quadword reads a 32-bit
            // register and uses the low lanes of it.
            let size = int_size(row.int_width.max(4));
            if !insn(code, row.mnem, &[imm8, gpr(x, size), xmm(dst_x)]) {
                return false;
            }
        }
        Form::MoveMask => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            if !load128(code, src_x, a) {
                return false;
            }
            if !insn(
                code,
                row.mnem,
                &[xmm(src_x), gpr(SCRATCH_R11, AsmRegSize::Long)],
            ) {
                return false;
            }
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
            if !insn(code, "rdrand", &[gpr(SCRATCH_R10, size)])
                || !insn(code, "mov", &[gpr(SCRATCH_R10, size), at(p, size)])
                || !insn(code, "setc", &[gpr(SCRATCH_R10, AsmRegSize::Byte)])
                || !insn(
                    code,
                    "movzx",
                    &[
                        gpr(SCRATCH_R10, AsmRegSize::Byte),
                        gpr(SCRATCH_R10, AsmRegSize::Long),
                    ],
                )
            {
                return false;
            }
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
        true
    }
}

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
) -> bool {
    use crate::c5::op::Intrinsic as I;
    // Byte stride between adjacent variadic arguments in the cursor
    // va_list. System V AMD64 routes its variadic intrinsics through the
    // register-save-area arms below (gated on `sysv_host_variadic`), so
    // the only x86_64 target reaching the cursor arms is Win64 (Microsoft
    // x64 calling convention), which packs the variadic tail at 8-byte
    // stride in the home area + incoming stack.
    let va_stride: i32 = 8;
    let Some(intrinsic) = I::from_i64(kind) else {
        return fail("intrinsic: unknown discriminant");
    };
    // Force args[idx]'s value into `scratch`; the register-tied arms
    // below stage operands into fixed registers around a clobber
    // window. `pushed` is the number of 8-byte pushes the arm has
    // emitted so far: rsp has moved by that much since the allocator
    // laid out its rsp-relative spill slots, so a spilled place must be
    // read through the shifted form.
    let materialize_at =
        |code: &mut Vec<u8>, idx: usize, scratch: Reg, pushed: u32| -> Option<Reg> {
            let place = alloc.places.get(args[idx] as usize).copied()?;
            let r = materialize_int_shifted(code, place, scratch, frame, 8 * pushed)?;
            if r.0 != scratch.0 {
                super::encode::emit_mov_rr(code, scratch, r);
            }
            Some(scratch)
        };
    match intrinsic {
        // Resolved to an `Imm` before lowering, by the SSA folds under
        // `-O` and by the walker otherwise; reaching here is a pass-
        // ordering bug.
        I::ConstantP => fail("Intrinsic::ConstantP must be resolved before lowering"),
        I::VaStart if sysv_variadic_callee(func, abi) => {
            // System V AMD64 `va_start` (ABI 3.5.7). args[0] = the
            // `__va_list_tag` pointer (the array-form `va_list` decayed
            // to `&ap[0]`), args[1] = &last (unused -- the named-argument
            // counts come from the prototype, not the last named
            // argument's address). Initialise the struct:
            //   gp_offset        = num_named_int * 8
            //   fp_offset        = 48 + num_named_fp * 16
            //   overflow_arg_area = first incoming stack argument
            //   reg_save_area     = base of the prologue-spilled area
            if args.len() != 2 {
                return fail("VaStart: expected 2 args");
            }
            // Named integer / FP argument counts from the prototype:
            // `param_fp_mask` bit i set means named parameter i is
            // floating-point. The gp area skips the named integer
            // arguments (each 8 bytes); the fp area starts at offset 48
            // and skips the named FP arguments (each 16 bytes).
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
            // gp_offset / fp_offset index the next argument register the
            // save area holds; they saturate at the bank size (six GP, eight
            // FP) so a callee whose named parameters fill or overflow a bank
            // sends `va_arg` straight to the overflow area.
            let gp_offset = named_int.min(6) * 8;
            // With the XMM save area unpopulated (`-mno-sse`), report the
            // FP bank exhausted so `va_arg` walks gp then overflow only.
            let fp_offset = if abi.no_fp_varargs {
                SYSV_REG_SAVE_BYTES
            } else {
                SYSV_GP_SAVE_BYTES + named_fp.min(8) * 16
            };
            let Some(ap_place) = alloc.places.get(args[0] as usize).copied() else {
                return fail("VaStart: &ap value id out of range");
            };
            let Some(ap) = materialize_int(code, ap_place, SCRATCH_R11, frame) else {
                return fail("VaStart: &ap not in int reg / spill");
            };
            // gp_offset (u32) at [ap + 0], fp_offset (u32) at [ap + 4].
            super::encode::emit_mov_mem32_imm32(code, ap, 0, gp_offset as i32);
            super::encode::emit_mov_mem32_imm32(code, ap, 4, fp_offset as i32);
            // overflow_arg_area (ptr) at [ap + 8] = first variadic stack
            // argument. Incoming stack arguments sit just above the return
            // address at [rbp + 16]; the named parameters that overflowed
            // the argument registers occupy the low slots there, so the
            // variadic tail begins past them.
            let named_stack_bytes: i32 = super::plan_param_regs(n, func.param_fp_mask, abi)
                .placements
                .iter()
                .filter(|q| matches!(q, super::ArgPlacement::Stack(_)))
                .count() as i32
                * 8;
            emit_lea_r_mem(code, SCRATCH_R10, Reg::RBP, 16 + named_stack_bytes);
            emit_mov_mem_r(code, ap, 8, SCRATCH_R10);
            // reg_save_area (ptr) at [ap + 16] = base of the spilled gp
            // area.
            emit_lea_r_mem(code, SCRATCH_R10, Reg::RBP, frame.va_reg_save_off);
            emit_mov_mem_r(code, ap, 16, SCRATCH_R10);
            true
        }
        // The System V `va_list` is a `__va_list_tag` struct on this
        // target, so `va_arg` walks the gp/fp save areas regardless of
        // whether the current function is itself variadic: a non-
        // variadic forwarder (the `c5_v*printf` shims) receives a
        // forwarded `va_list` and must read it the same way. Gate on the
        // target ABI, not `func.is_variadic`.
        I::VaArg if abi.sysv_host_variadic() => {
            emit_va_arg_sysv(code, args, dst, func, alloc, frame)
        }
        I::VaCopy if abi.sysv_host_variadic() => {
            // System V `va_copy` is a 24-byte `__va_list_tag` struct copy
            // (ABI 3.5.7). args[0] = &dst struct, args[1] = &src struct.
            if args.len() != 2 {
                return fail("VaCopy: expected 2 args");
            }
            let Some(src_place) = alloc.places.get(args[1] as usize).copied() else {
                return fail("VaCopy: &src value id out of range");
            };
            let Some(src_p) = materialize_int(code, src_place, SCRATCH_R11, frame) else {
                return fail("VaCopy: &src not in int reg / spill");
            };
            let Some(dst_place) = alloc.places.get(args[0] as usize).copied() else {
                return fail("VaCopy: &dst value id out of range");
            };
            // Both pointers ride the reserved r10 / r11 scratches (rcx
            // is in the allocator's caller pool and may hold a live
            // value across the intrinsic). The copied word borrows a
            // pool register around a push/pop pair, mirroring
            // emit_mcpy; the spill loads above run before the push so
            // rsp-relative offsets stay valid.
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
            // Copy the three 8-byte `__va_list_tag` words (ABI 3.5.7):
            // gp_offset + fp_offset packed in the first, then
            // overflow_arg_area and reg_save_area.
            for off in [0i32, 8, 16] {
                emit_mov_r_mem(code, temp, src_p, off);
                emit_mov_mem_r(code, dst_p, off, temp);
            }
            emit_pop_r(code, temp);
            true
        }
        I::VaStart => {
            // __builtin_va_start(&ap, &last). args[0] = &ap,
            // args[1] = &last. *ap = &last + va_stride, the address of
            // the first variadic slot one stride past the last named
            // parameter. System V routes its `va_start` through the
            // register-save-area arm above, so only the Win64 host
            // variadic ABI reaches here: it lays named and variadic
            // arguments at 8-byte stride (named register arguments
            // spilled by the prologue into the home area, the variadic
            // tail on the incoming stack). va_start runs only in the
            // variadic function itself, whose named parameters already
            // use `va_stride` (`Frame::param_cell_stride`), so
            // `&last + va_stride` lands on the first variadic argument.
            if args.len() != 2 {
                return fail("VaStart: expected 2 args");
            }
            // Both pointer operands can land in spill slots under
            // register pressure, so materialize each into a reserved
            // scratch. r10 / r11 sit outside both allocator banks, so
            // they never alias an allocator-chosen `ap` / `last`. The
            // `last + va_stride` advance reuses the `last` register, so
            // the peak register need is two.
            let Some(ap_place) = alloc.places.get(args[0] as usize).copied() else {
                return fail("VaStart: &ap value id out of range");
            };
            let Some(last_place) = alloc.places.get(args[1] as usize).copied() else {
                return fail("VaStart: &last value id out of range");
            };
            let Some(ap) = materialize_int(code, ap_place, SCRATCH_R11, frame) else {
                return fail("VaStart: &ap not in int reg / spill");
            };
            let Some(last) = materialize_int(code, last_place, SCRATCH_R10, frame) else {
                return fail("VaStart: &last not in int reg / spill");
            };
            // advance = last + va_stride ; mov [ap], advance. When
            // `last` is an allocator register it may still be live after
            // VaStart, so the advance lands in r10 rather than
            // clobbering it; when `last` was spilled it already sits in
            // the throwaway r10 copy, which is reused. r10 is outside
            // both pools, so it never aliases `ap` or the
            // allocator-chosen `last`.
            let advance = SCRATCH_R10;
            emit_lea_r_mem(code, advance, last, va_stride);
            emit_mov_mem_r(code, ap, 0, advance);
            true
        }
        I::VaArg => {
            // Returns *ap, advances *ap by va_stride. args[0] = &ap.
            // args[1] (when present) is the packed type descriptor; the
            // Win64 / cursor single-region walk ignores the kind, so only
            // args[0] is read.
            if args.is_empty() {
                return fail("VaArg: expected at least the ap argument");
            }
            // The cursor address `ap`, the loaded result, and the
            // advance temporary must each occupy a distinct register so
            // the writeback stores through the cursor rather than through
            // the just-loaded value. Both the `&ap` operand and the
            // result can land in spill slots under register pressure, and
            // the allocator may even pick the same physical register for
            // the result and `&ap`. r10 / r11 sit outside both allocator
            // banks, so they never alias an allocator-chosen place; the
            // cursor is held in r11 (forced there whenever it would
            // otherwise alias the work register), the value is loaded
            // into a work register, the advance into r10, and the value
            // is then delivered to the destination.
            let Some(ap_place) = alloc.places.get(args[0] as usize).copied() else {
                return fail("VaArg: &ap value id out of range");
            };
            // Cursor address. A spilled `&ap` loads into r11; a register
            // operand is moved into r11 when it would alias the work
            // register so the load can't clobber it.
            let ap = match ap_place {
                Place::IntReg(r) => {
                    let work_aliases = match dst {
                        Place::IntReg(d) => d == r,
                        _ => false,
                    };
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
            // Work register holding the loaded result: the destination
            // register when distinct from the cursor, otherwise r10. The
            // cursor was forced to r11 above whenever the destination
            // register aliased it, so `work` here never equals `ap`.
            let work = match dst {
                Place::IntReg(d) if Reg(d).0 != ap.0 => Reg(d),
                _ => SCRATCH_R10,
            };
            // work = *ap (old cursor) ; r10 = work + va_stride ; *ap =
            // r10. r10 is the advance temporary; it differs from `ap`
            // (r11 or an allocator reg) and from `work` (only r10 when
            // the dst is spilled, in which case `work` is dead after the
            // store back).
            emit_mov_r_mem(code, work, ap, 0);
            let advance = SCRATCH_R10;
            if advance.0 == work.0 {
                // Destination spilled: store the result before reusing
                // r10 for the advance.
                spill_dst_to_slot(code, dst, work, frame);
                emit_lea_r_mem(code, advance, work, va_stride);
                emit_mov_mem_r(code, ap, 0, advance);
            } else {
                emit_lea_r_mem(code, advance, work, va_stride);
                emit_mov_mem_r(code, ap, 0, advance);
                spill_dst_to_slot(code, dst, work, frame);
            }
            true
        }
        I::VaEnd => {
            // No teardown for the cursor model.
            true
        }
        I::VaCopy => {
            // __builtin_va_copy(&dst, &src). *dst = *src.
            if args.len() != 2 {
                return fail("VaCopy: expected 2 args");
            }
            // Both pointer operands can land in spill slots under
            // register pressure. Load the source value into r10 before
            // materializing the destination pointer, so r11 can hold the
            // source pointer and then be reused for the destination
            // pointer -- the peak register need is two. r10 / r11 sit
            // outside both allocator banks, so they never alias an
            // allocator-chosen place.
            let Some(dst_place) = alloc.places.get(args[0] as usize).copied() else {
                return fail("VaCopy: &dst value id out of range");
            };
            let Some(src_place) = alloc.places.get(args[1] as usize).copied() else {
                return fail("VaCopy: &src value id out of range");
            };
            let Some(src_p) = materialize_int(code, src_place, SCRATCH_R11, frame) else {
                return fail("VaCopy: &src not in int reg / spill");
            };
            let scratch = SCRATCH_R10;
            emit_mov_r_mem(code, scratch, src_p, 0);
            let Some(dst_p) = materialize_int(code, dst_place, SCRATCH_R11, frame) else {
                return fail("VaCopy: &dst not in int reg / spill");
            };
            emit_mov_mem_r(code, dst_p, 0, scratch);
            true
        }
        I::Alloca => {
            // alloca(n): move rsp down by `n` rounded up to 16 bytes
            // and return the new rsp. The 16-byte rounding keeps rsp
            // aligned for the call sites that follow; the frame's
            // spill slots and locals stay reachable through rbp
            // (`Frame::dynamic_sp`). The storage is reclaimed by the
            // epilogue's `lea rsp, [rbp - frame_bytes]`, or earlier by
            // an `AllocaRestore` closing a VLA scope (C99 6.2.4p2).
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
            // rd_phys receives the result (rd for a register dst, r10
            // for a spill dst); the rounded size rides r11. Both
            // scratches sit outside the allocator banks, and rd is
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
            // rd_phys = rsp - rounded_size, the final rsp value.
            emit_mov_rr(code, rd_phys, Reg::RSP);
            super::encode::emit_rr(code, Mnem::Sub, 8, rd_phys, size_reg);
            // Walk rsp down page by page, touching each, before
            // committing the final value: the same guard-region rule the
            // prologue's `emit_stack_alloc` follows, over a size known
            // only at run time. The size is 16-aligned, so the amount the
            // settling `mov` covers past the last probe is at most
            // MAX_UNPROBED_STACK_STEP and needs no probe of its own.
            super::encode::emit_shift_ri(code, Mnem::Shr, 8, size_reg, 12);
            super::encode::emit_rr(code, Mnem::Test, 8, size_reg, size_reg);
            super::encode::emit_jcc_rel32(code, Cc::E, 0);
            let skip_at = code.len() - 4;
            let loop_start = code.len();
            emit_sub_rsp_imm32(code, STACK_PROBE_PAGE);
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
            true
        }
        I::AllocaSave => {
            // Snapshot rsp for a VLA block (C99 6.2.4p2).
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
            true
        }
        I::AllocaRestore => {
            // Restore the saved rsp on VLA block exit, reclaiming the
            // block's VLA storage (per iteration for a loop body).
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
            true
        }
        I::SetjmpAArch64 | I::LongjmpAArch64 => {
            fail("intrinsic: AArch64 setjmp / longjmp on non-AArch64 target")
        }
        // fma / fmaf lower to Inst::Fma at the call site, so they never
        // reach the Inst::Intrinsic dispatch.
        I::Fma | I::Fmaf => fail("intrinsic: fma / fmaf lower to Inst::Fma, not Inst::Intrinsic"),
        I::Trap => {
            // `ud2` (0F 0B) raises #UD (illegal instruction). Execution
            // does not continue past it.
            code.push(0x0F);
            code.push(0x0B);
            true
        }
        I::CpuRelax => {
            // `pause` (F3 90), the x86-64 spin-loop hint.
            code.push(0xF3);
            code.push(0x90);
            true
        }
        I::AtomicThreadFence => {
            // `mfence` (0F AE F0), a full barrier (C11 7.17.4 seq_cst).
            // No operand, no result.
            code.push(0x0F);
            code.push(0xAE);
            code.push(0xF0);
            true
        }
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
        | I::X86Clflush => {
            // Single-memory-operand x87 / system forms. The one argument
            // is the operand address; force it into r10 so the ModRM byte
            // needs no SIB / displacement (r10 = rm 010 under REX.B). The
            // opcode bytes and ModRM.reg field select the instruction:
            //   fnstcw/fldcw = D9 /7,/5 ; fxsave/fxrstor = 0F AE /0,/1 ;
            //   sgdt/sidt = 0F 01 /0,/1 ; lgdt/lidt = 0F 01 /2,/3 ;
            //   sldt/str  = 0F 00 /0,/1 ; lldt = 0F 00 /2 ; clflush = 0F AE /7.
            if args.len() != 1 {
                return fail("single-memory-operand intrinsic expects 1 arg");
            }
            let Some(place) = alloc.places.get(args[0] as usize).copied() else {
                return fail("single-memory-operand intrinsic: arg place missing");
            };
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
            true
        }
        I::Divq128 => {
            // Unsigned 128/64 division (`udiv_qrnnd`). The dividend is
            // rdx:rax = n1:n0, the divisor is `d`; `div` leaves the
            // quotient in rax and the remainder in rdx. args:
            // [q_addr, rem_addr, n0, n1, d].
            const RAX: Reg = Reg(0);
            const RDX: Reg = Reg(2);
            const R10: Reg = Reg(10);
            const R11: Reg = Reg(11);
            if args.len() != 5 {
                return fail("divq: wrong operand count");
            }
            // `div` clobbers rax and rdx.
            super::encode::emit_push_r(code, RAX);
            super::encode::emit_push_r(code, RDX);
            // Push the output addresses (quotient then remainder, so the
            // remainder address is popped first below); the shift tracks
            // the pushes emitted so far.
            if materialize_at(code, 0, R10, 2).is_none() {
                return fail("divq: quotient output not an address");
            }
            super::encode::emit_push_r(code, R10);
            if materialize_at(code, 1, R10, 3).is_none() {
                return fail("divq: remainder output not an address");
            }
            super::encode::emit_push_r(code, R10);
            // Divisor -> r10, dividend high -> r11, then load rax/rdx last
            // so an input the allocator placed in rax/rdx is read first.
            if materialize_at(code, 4, R10, 4).is_none() {
                return fail("divq: divisor operand missing");
            }
            if materialize_at(code, 3, R11, 4).is_none() {
                return fail("divq: dividend-high operand missing");
            }
            if materialize_at(code, 2, RAX, 4).is_none() {
                return fail("divq: dividend-low operand missing");
            }
            super::encode::emit_mov_rr(code, RDX, R11); // rdx = n1
            // div r10  (REX.W + REX.B, F7 /6 -> unsigned divide).
            code.push(0x49);
            code.push(0xF7);
            code.push(0xF2);
            // Store quotient (rax) and remainder (rdx) to the popped
            // addresses (remainder is on top of the stack).
            super::encode::emit_pop_r(code, R11);
            super::encode::emit_mov_mem_r(code, R11, 0, RDX);
            super::encode::emit_pop_r(code, R11);
            super::encode::emit_mov_mem_r(code, R11, 0, RAX);
            super::encode::emit_pop_r(code, RDX);
            super::encode::emit_pop_r(code, RAX);
            true
        }
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
        I::FrameAddress => {
            // __builtin_frame_address(0): the current frame pointer (rbp).
            // A level above 0 reaches here as this plus a load chain.
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("FrameAddress: dst not int reg / spill");
            };
            emit_mov_rr(code, rd, Reg::RBP);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        I::StackPointer => {
            // A `register T v asm("rsp")` read: the current stack pointer.
            let Some(rd) = int_or_spill_dst(dst) else {
                bail_msg("StackPointer: dst not int reg / spill");
                return false;
            };
            emit_mov_rr(code, rd, Reg::RSP);
            spill_dst_to_slot(code, dst, rd, frame);
            true
        }
        I::ReturnAddress => {
            // __builtin_return_address: the return address a frame record
            // holds at [fp + 8], above the saved rbp. Without an operand
            // the record is the current frame's; with one, the frame
            // address a level above 0 walked to.
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("ReturnAddress: dst not int reg / spill");
            };
            let fp = match args {
                [] => Reg::RBP,
                [walked] => {
                    let Some(r) = int_operand_into_rd(code, place_of(alloc, *walked), rd, frame)
                    else {
                        return fail("ReturnAddress: frame not int reg / spill");
                    };
                    r
                }
                _ => return fail("ReturnAddress: expected at most 1 arg"),
            };
            emit_mov_r_mem(code, rd, fp, 8);
            spill_dst_to_slot(code, dst, rd, frame);
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
            // C11 atomic operations are lowered to load / store /
            // read-modify-write at the call site; they never reach
            // codegen as an `Inst::Intrinsic`.
            fail("intrinsic: atomic op reached codegen")
        }
        I::AArch64ReadCacheType
        | I::AArch64DcCvau
        | I::AArch64IcIvau
        | I::AArch64DsbIsh
        | I::AArch64Isb => {
            // AArch64 cache maintenance and barriers; the source gates them
            // on `__aarch64__`, so x86-64 never reaches them.
            fail("aarch64 cache / barrier intrinsic is aarch64-only")
        }
        I::Atomic128CmpXchg
        | I::Atomic128Xchg
        | I::Atomic128FetchAnd
        | I::Atomic128FetchOr
        | I::Atomic128Load
        | I::Atomic128Store
        | I::Atomic128LoadEx
        | I::Atomic128StoreEx
        | I::Atomic128StoreInsert => {
            // The 128-bit atomic ldaxp/stlxp and ldp/stp, ldxp/stxp shapes
            // are aarch64-only; the source selects them via the aarch64
            // host-include path, so x86-64 (which has native `cmpxchg16b`)
            // never reaches them.
            fail("128-bit atomic asm shape is aarch64-only")
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
) -> bool {
    if size < 0 {
        return fail("Mcpy: negative size");
    }
    let dst_in = place_of(alloc, dst_val);
    let src_in = place_of(alloc, src_val);
    // Materialise both bases into reserved scratches. SCRATCH_R10 and
    // SCRATCH_R11 sit outside both allocator pools, so loading a base
    // into either cannot clobber a live SSA value. rcx must not be used
    // here: it is in the LinuxX64 `caller_gprs` pool, so under raised
    // register pressure the allocator parks SSA values there (e.g. a
    // `context` pointer threaded into a later call argument), and a
    // materialise into rcx would overwrite that value.
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
    // Pick a per-iteration temp distinct from both bases, then save /
    // restore it across the copy. rax, rcx and rdx are in the
    // allocator's caller_gprs pool, so the prologue may have parked a
    // live value in the chosen one; a push/pop pair around the loop
    // preserves it. (r10 / r11 are the bases' reserved scratch and are
    // not candidates here.)
    let temp = if dst_r.0 != Reg::RAX.0 && src_r.0 != Reg::RAX.0 {
        Reg::RAX
    } else if dst_r.0 != Reg::RCX.0 && src_r.0 != Reg::RCX.0 {
        Reg::RCX
    } else {
        // rax and rcx are taken by the bases (one of which may sit in
        // r10 / r11); fall back to rdx, also in the caller pool.
        Reg::RDX
    };
    emit_push_r(code, temp);
    let bytes = size as u32;
    let unit = super::super::access_chunk(align, strict_align, 8);
    let words = bytes / unit;
    for w in 0..words {
        // After push, [base + off] still resolves correctly
        // because the bases are register-typed (not sp-relative).
        let off = (w * unit) as i32;
        emit_copy_unit(code, unit, temp, src_r, dst_r, off);
    }
    let tail_start = words * unit;
    for i in 0..(bytes - tail_start) {
        let off = (tail_start + i) as i32;
        super::encode::emit_movzx_r_mem8(code, temp, src_r, off);
        super::encode::emit_mov_mem8_r(code, dst_r, off, temp);
    }
    emit_pop_r(code, temp);
    // memcpy returns dst; propagate into the inst's dst.
    match dst_place {
        Place::IntReg(r) if r != dst_r.0 => emit_mov_rr(code, Reg(r), dst_r),
        Place::Spill(_) => spill_dst_to_slot(code, dst_place, dst_r, frame),
        _ => {}
    }
    true
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
fn emit_atomic_load(code: &mut Vec<u8>, dst: Reg, base: Reg, width: u8) {
    match width {
        1 => super::encode::emit_movzx_r_mem8(code, dst, base, 0),
        2 => super::encode::emit_movzx_r_mem16(code, dst, base, 0),
        4 => super::encode::emit_mov_r32_mem(code, dst, base, 0),
        _ => emit_mov_r_mem(code, dst, base, 0),
    }
}

/// Store the low `width` bytes of `src` to `[base]`; the companion to
/// [`emit_atomic_load`] for the compare-exchange expected-operand writeback.
fn emit_atomic_store(code: &mut Vec<u8>, base: Reg, src: Reg, width: u8) {
    match width {
        1 => super::encode::emit_mov_mem_r8(code, base, 0, src),
        2 => super::encode::emit_mov_mem_r16(code, base, 0, src),
        4 => super::encode::emit_mov_mem_r32(code, base, 0, src),
        _ => emit_mov_mem_r(code, base, 0, src),
    }
}

/// Force an operand's value into a designated scratch register. The
/// operand may already sit in its allocator register; `materialize`
/// returns that register, and we copy it into `scratch` so the
/// caller can clobber the source register afterwards. `sp_shift`
/// accounts for the borrowed registers already pushed.
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

/// C11 7.17.7.2-7.17.7.5 atomic read-modify-write. Lowers to a genuine
/// atomic instruction (Intel SDM Vol.2): `XCHG` for exchange, `LOCK
/// XADD` for add / sub (negating the operand for sub), and a `LOCK
/// CMPXCHG` retry loop for the bitwise operators (x86 has no
/// fetch-and-return-old form for AND / OR / XOR). The defined value is
/// the object's prior contents. The address rides SCRATCH_R11 and the
/// operand SCRATCH_R10, both outside the allocator's register banks;
/// RAX and a loop temp are borrowed via push / pop so a value the
/// allocator parked there survives.
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
) -> bool {
    use super::super::ir::AtomicRmwOp as Op;
    let a = SCRATCH_R11;
    let val = SCRATCH_R10;
    match op {
        Op::Xchg => {
            // No RAX involved: XCHG with a memory operand is implicitly
            // locked. Operands ride the reserved scratches; rsp stable.
            if operand_into(code, addr, a, frame, 0, alloc).is_none()
                || operand_into(code, value, val, frame, 0, alloc).is_none()
            {
                return fail("AtomicRmw: operand not int reg / spill");
            }
            emit_xchg_mem_r(code, a, 0, val, width);
            write_atomic_result(code, dst, val, frame);
            true
        }
        Op::Add | Op::Sub => {
            emit_push_r(code, Reg::RAX);
            if operand_into(code, addr, a, frame, 8, alloc).is_none()
                || operand_into(code, value, val, frame, 8, alloc).is_none()
            {
                return fail("AtomicRmw: operand not int reg / spill");
            }
            emit_mov_rr(code, Reg::RAX, val);
            if matches!(op, Op::Sub) {
                emit_unary_r(code, Mnem::Neg, 8, Reg::RAX);
            }
            emit_lock_xadd_mem_r(code, a, 0, Reg::RAX, width);
            // RAX now holds the prior contents; stash it before the pop.
            emit_mov_rr(code, val, Reg::RAX);
            emit_pop_r(code, Reg::RAX);
            write_atomic_result(code, dst, val, frame);
            true
        }
        Op::And | Op::Or | Op::Xor => {
            // CMPXCHG retry: load the current value into RAX, compute the
            // new value in a temp, and conditionally publish it; repeat
            // until the store succeeds (ZF set by CMPXCHG).
            let temp = Reg::RCX;
            emit_push_r(code, Reg::RAX);
            emit_push_r(code, temp);
            if operand_into(code, addr, a, frame, 16, alloc).is_none()
                || operand_into(code, value, val, frame, 16, alloc).is_none()
            {
                return fail("AtomicRmw: operand not int reg / spill");
            }
            emit_atomic_load(code, Reg::RAX, a, width);
            let loop_start = code.len();
            emit_mov_rr(code, temp, Reg::RAX);
            match op {
                Op::And => emit_rr(code, Mnem::And, 8, temp, val),
                Op::Or => emit_rr(code, Mnem::Or, 8, temp, val),
                Op::Xor => emit_rr(code, Mnem::Xor, 8, temp, val),
                _ => unreachable!(),
            }
            emit_lock_cmpxchg_mem_r(code, a, 0, temp, width);
            // Branch back when the store lost the race (ZF == 0). The
            // rel8 field is measured from the byte after the 2-byte Jcc.
            let rel = (loop_start as i64) - (code.len() as i64 + 2);
            emit_jcc_rel8(code, Cc::Ne, rel as i8);
            emit_mov_rr(code, val, Reg::RAX);
            emit_pop_r(code, temp);
            emit_pop_r(code, Reg::RAX);
            write_atomic_result(code, dst, val, frame);
            true
        }
    }
}

/// C11 7.17.7.4 atomic compare-and-exchange. Lowers to `LOCK CMPXCHG`
/// (Intel SDM Vol.2): RAX is loaded with `*expected`; on a match the
/// store publishes `desired` and the result is 1, otherwise the
/// current contents are written back into `*expected` and the result
/// is 0. The success flag is read from the CMPXCHG ZF (a `mov` does
/// not disturb the flags, so the post-branch SETcc is correct).
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
) -> bool {
    let a = SCRATCH_R11;
    let des = SCRATCH_R10;
    let exp = Reg::RCX;
    emit_push_r(code, Reg::RAX);
    emit_push_r(code, exp);
    // Materialise addr / desired before clobbering RCX with the
    // expected pointer (their Places may name RCX).
    if operand_into(code, addr, a, frame, 16, alloc).is_none()
        || operand_into(code, desired, des, frame, 16, alloc).is_none()
        || operand_into(code, expected_addr, exp, frame, 16, alloc).is_none()
    {
        return fail("AtomicCas: operand not int reg / spill");
    }
    emit_atomic_load(code, Reg::RAX, exp, width);
    emit_lock_cmpxchg_mem_r(code, a, 0, des, width);
    // On failure (ZF == 0) write the observed value back to *expected.
    // Build the conditional body separately to size the forward Jcc.
    let mut fail_path = Vec::new();
    emit_atomic_store(&mut fail_path, exp, Reg::RAX, width);
    emit_jcc_rel8(code, Cc::E, fail_path.len() as i8);
    code.extend_from_slice(&fail_path);
    // Result = ZF from the CMPXCHG. Reuse `a` (addr no longer needed).
    emit_setcc_r8(code, Cc::E, a);
    emit_movzx_r_r8(code, a, a);
    emit_pop_r(code, exp);
    emit_pop_r(code, Reg::RAX);
    write_atomic_result(code, dst, a, frame);
    true
}
