use super::*;

/// `Inst::Simd`: load the 128-bit operands into the FP scratches, run
/// the instruction the table row names, and write the result through the
/// destination address. The operands are memory-resident and only 8-byte
/// aligned, so every transfer is an unaligned `movdqu`.
pub(super) fn emit_x86_simd(
    code: &mut CodeBuf,
    op: u32,
    imm: Option<u8>,
    args: &[super::super::ir::ValueId],
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use super::asm::{Concrete, XMM_BASE};
    use crate::c5::ir::AsmRegSize;
    use crate::c5::simd;
    use crate::c5::simd::Form;
    if wide_lowering(simd::get(op)) {
        return emit_x86_simd_wide(code, op, imm, args, alloc, frame);
    }
    let dst_x: u8 = frame.fp_scratch[1];
    let src_x: u8 = frame.fp_scratch[0];
    let row = simd::get(op);
    // An operand's value (an address for the 128-bit and pointer operands),
    // in its own register or loaded into `scratch`.
    let operand = |code: &mut CodeBuf, i: usize, scratch: Reg| -> Option<Reg> {
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
    // not special-case resolves in the generated catalog.
    let insn = |code: &mut Vec<u8>, mnem: &'static str, ops: &[Concrete]| -> Emit {
        let m = super::asm::mnemonic_by_name(mnem).unwrap_or(super::asm::Mnemonic::Table(mnem));
        if let Err(e) = super::asm::encode(code, 8, m, None, ops) {
            return fail(alloc::format!("x86 simd: {e}"));
        }
        Ok(())
    };
    // Vector transfers between an address in `addr` and xmm `n`: 128 bits,
    // or the low 64 of an MMX form, the upper half zeroed on a load.
    let load128 = |code: &mut Vec<u8>, n: u8, addr: Reg| -> Emit {
        if row.bytes == 8 {
            emit_movsd_xmm_mem(code, Reg(n), addr, 0);
            return Ok(());
        }
        insn(code, "movdqu", &[at(addr, AsmRegSize::Quad), xmm(n)])
    };
    let store128 = |code: &mut Vec<u8>, addr: Reg, n: u8| -> Emit {
        if row.bytes == 8 {
            emit_movsd_mem_xmm(code, addr, 0, Reg(n));
            return Ok(());
        }
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
        Form::Vvv
        | Form::VvvI
        | Form::CmpMask
        | Form::MaskBlend
        | Form::MaskLoad
        | Form::MaskStore
        | Form::Narrow
        | Form::Widen
        | Form::Zext => {
            return fail("x86 simd: a wide form outside the wide lowering");
        }
        Form::Vv | Form::VvI => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            load128(code, dst_x, a)?;
            let Some(b) = operand(code, 2, SCRATCH_R10) else {
                return fail("x86 simd: operand 2 has no place");
            };
            load128(code, src_x, b)?;
            let mut ops = alloc::vec![xmm(src_x), xmm(dst_x)];
            if row.form == Form::VvI {
                ops.insert(0, imm8);
            }
            // A VEX-only row (`psllvd`), or a compare by one of the
            // predicates past 7 only AVX encodes, takes the VEX form, which
            // writes over its first source.
            let avx_predicate = matches!(row.sem, simd::Sem::FloatCmp(..)) && imm.unwrap_or(0) > 7;
            let mut probe = CodeBuf::default();
            if !avx_predicate && insn(&mut probe, row.mnem, &ops).is_ok() {
                code.extend_from_slice(&probe);
            } else if let Some(m) = super::asm::vex_mnemonic(row.mnem) {
                ops.push(xmm(dst_x));
                if let Err(e) = super::asm::encode(code, 8, m, None, &ops) {
                    return fail(alloc::format!("x86 simd: {e}"));
                }
            } else {
                insn(code, row.mnem, &ops)?;
            }
        }
        Form::V | Form::VI => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            load128(code, src_x, a)?;
            // A scalar form keeps the operand's other lanes.
            if matches!(row.sem, simd::Sem::Float(_, _, true)) {
                load128(code, dst_x, a)?;
            }
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
        Form::ToInt => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            load128(code, src_x, a)?;
            let size = match row.int_width {
                8 => AsmRegSize::Quad,
                _ => AsmRegSize::Long,
            };
            insn(code, row.mnem, &[xmm(src_x), gpr(SCRATCH_R11, size)])?;
            let Some(d) = operand(code, 0, SCRATCH_R10) else {
                return fail("x86 simd: destination has no place");
            };
            return insn(code, "mov", &[gpr(SCRATCH_R11, size), at(d, size)]);
        }
        Form::Extract => {
            let Some(a) = operand(code, 1, SCRATCH_R10) else {
                return fail("x86 simd: operand 1 has no place");
            };
            load128(code, src_x, a)?;
            // `pextrb` and `pextrw` zero-extend into the 32-bit register;
            // `pextrd` writes all 32 bits and `pextrq` all 64.
            let size = int_size(row.int_width.max(4));
            insn(code, row.mnem, &[imm8, xmm(src_x), gpr(SCRATCH_R11, size)])?;
            let Some(d) = operand(code, 0, SCRATCH_R10) else {
                return fail("x86 simd: destination has no place");
            };
            return insn(code, "mov", &[gpr(SCRATCH_R11, size), at(d, size)]);
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

/// Whether `row` is emitted by the VEX and EVEX lowering: a 32- or 64-byte
/// form, an opmask one, or a three-source one, which has no SSE encoding.
fn wide_lowering(row: &crate::c5::x86_simd::SimdOp) -> bool {
    use crate::c5::simd::Form;
    row.bytes >= 32 || row.form.is_opmask() || matches!(row.form, Form::Vvv | Form::VvvI)
}

/// `dst = a op b` for the two-operand SSE instruction `mnem`, with its
/// immediate if any: `a` copied into the register the result is formed in,
/// the result's own unless that holds `b`, then a scratch it is copied
/// from. A commutative `op` whose result takes `b`'s register reads `a`
/// into it instead. A spilled operand loads into an FP scratch. Without
/// `wide` the operands and result are the low 64 bits of their registers,
/// spilled as 8 bytes.
#[allow(clippy::too_many_arguments)]
pub(super) fn sse_binary(
    code: &mut CodeBuf,
    mnem: &'static str,
    imm: Option<u8>,
    commutes: bool,
    wide: bool,
    dst: Place,
    (a, b): (Place, Place),
    frame: Frame,
) -> Emit {
    let load = |code: &mut CodeBuf, p: Place, scratch: Reg| {
        if wide {
            materialize_v128(code, p, scratch, frame)
        } else {
            materialize_fp(code, p, scratch, frame)
        }
    };
    use super::asm::{Concrete, XMM_BASE};
    use crate::c5::ir::AsmRegSize;
    let (src_x, dst_x) = (frame.fp_scratch[0], frame.fp_scratch[1]);
    let xmm = |n: u8| Concrete::Reg {
        reg: XMM_BASE + n,
        size: AsmRegSize::Quad,
    };
    let run = |code: &mut Vec<u8>, x: u8, w: u8| -> Emit {
        let m = super::asm::mnemonic_by_name(mnem).unwrap_or(super::asm::Mnemonic::Table(mnem));
        let ops: &[Concrete] = match imm {
            Some(i) => &[Concrete::Imm(i64::from(i)), xmm(x), xmm(w)],
            None => &[xmm(x), xmm(w)],
        };
        if let Err(e) = super::asm::encode(code, 8, m, None, ops) {
            return fail(alloc::format!("x86 simd: {e}"));
        }
        Ok(())
    };
    let source = |code: &mut CodeBuf, p: Place| -> Emit<u8> {
        match load(code, p, Reg(src_x)) {
            Some(Reg(r)) => Ok(r),
            None => fail("x86 simd: a source has no place"),
        }
    };
    if let Place::FpReg(w) = dst
        && commutes
        && dst == b
        && dst != a
    {
        let x = source(code, a)?;
        return run(code, x, w);
    }
    let x = source(code, b)?;
    let w = match dst {
        Place::FpReg(r) if r != x => r,
        _ => dst_x,
    };
    match a {
        Place::FpReg(r) if r == w => {}
        Place::FpReg(r) => emit_movapd_xmm_xmm(code, Reg(w), Reg(r)),
        p => {
            if load(code, p, Reg(w)).is_none_or(|r| r.0 != w) {
                return fail("x86 simd: a source has no place");
            }
        }
    }
    run(code, x, w)?;
    if wide {
        mirror_v128_dst(code, dst, Reg(w), frame);
    } else {
        match dst {
            Place::FpReg(r) if r != w => emit_movapd_xmm_xmm(code, Reg(r), Reg(w)),
            _ => fp_spill_dst_to_slot(code, dst, Reg(w), frame),
        }
    }
    Ok(())
}

/// `Inst::VecBinop`: the SSE instruction for the element-wise operation, an
/// 8-byte vector in the low half of the xmm register.
pub(super) fn emit_vec_binop(
    code: &mut CodeBuf,
    (op, lane, bytes): (super::super::ir::BinOp, super::super::ir::VecLane, u8),
    (lhs, rhs): (super::super::ir::ValueId, super::super::ir::ValueId),
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use super::super::ir::{BinOp, VecLane};
    // The VEX / EVEX spelling; EVEX names the bitwise operations by
    // element width.
    let vmnem = match (op, lane) {
        (BinOp::Add, VecLane::I8) => "vpaddb",
        (BinOp::Add, VecLane::I16) => "vpaddw",
        (BinOp::Add, VecLane::I32) => "vpaddd",
        (BinOp::Add, VecLane::I64) => "vpaddq",
        (BinOp::Sub, VecLane::I8) => "vpsubb",
        (BinOp::Sub, VecLane::I16) => "vpsubw",
        (BinOp::Sub, VecLane::I32) => "vpsubd",
        (BinOp::Sub, VecLane::I64) => "vpsubq",
        (BinOp::Mul, VecLane::I16) => "vpmullw",
        (BinOp::And, _) if bytes == 64 => "vpandq",
        (BinOp::Or, _) if bytes == 64 => "vporq",
        (BinOp::Xor, _) if bytes == 64 => "vpxorq",
        (BinOp::And, _) => "vpand",
        (BinOp::Or, _) => "vpor",
        (BinOp::Xor, _) => "vpxor",
        (BinOp::Fadd, VecLane::F32) => "vaddps",
        (BinOp::Fadd, VecLane::F64) => "vaddpd",
        (BinOp::Fsub, VecLane::F32) => "vsubps",
        (BinOp::Fsub, VecLane::F64) => "vsubpd",
        (BinOp::Fmul, VecLane::F32) => "vmulps",
        (BinOp::Fmul, VecLane::F64) => "vmulpd",
        (BinOp::Fdiv, VecLane::F32) => "vdivps",
        (BinOp::Fdiv, VecLane::F64) => "vdivpd",
        _ => {
            return fail(alloc::format!(
                "VecBinop: no instruction for {op:?} on {lane:?}"
            ));
        }
    };
    let place = |v: super::super::ir::ValueId| place_of(alloc, v);
    let w = VecWidth::of_bytes(bytes);
    if w >= VecWidth::V256 {
        return wide_binary(code, vmnem, None, w, dst, (place(lhs), place(rhs)), frame);
    }
    let encode = |code: &mut Vec<u8>, ops: &[super::asm::Concrete]| encode_wide(code, vmnem, ops);
    vex_binary(
        code,
        &encode,
        None,
        bytes == 16,
        dst,
        (place(lhs), place(rhs)),
        frame,
    )
}

/// A VEX three-operand form over xmm registers, `dst = a op b`, which
/// `encode` writes for its operands (an immediate first when `imm`), for a
/// 16-byte vector (`wide`) or an 8-byte one in the low half: no source is
/// copied into the destination first. A spilled source is loaded into an
/// FP scratch, and a spilled result is formed in one and stored.
pub(super) fn vex_binary(
    code: &mut CodeBuf,
    encode: &dyn Fn(&mut Vec<u8>, &[super::asm::Concrete]) -> Emit,
    imm: Option<u8>,
    wide: bool,
    dst: Place,
    (a, b): (Place, Place),
    frame: Frame,
) -> Emit {
    let (sa, sb) = (Reg(frame.fp_scratch[0]), Reg(frame.fp_scratch[1]));
    let load = |code: &mut CodeBuf, p: Place, scratch: Reg| match wide {
        true => materialize_v128(code, p, scratch, frame),
        false => materialize_fp(code, p, scratch, frame),
    };
    let (Some(ra), Some(rb)) = (load(code, a, sa), load(code, b, sb)) else {
        return fail("x86 simd: a source has no place");
    };
    let rd = match dst {
        Place::FpReg(r) => Reg(r),
        _ => sa,
    };
    let regs = [wide_reg(16, rb.0), wide_reg(16, ra.0), wide_reg(16, rd.0)];
    match imm {
        Some(i) => {
            let [b, a, d] = regs;
            encode(code, &[super::asm::Concrete::Imm(i64::from(i)), b, a, d])?
        }
        None => encode(code, &regs)?,
    }
    match wide {
        true => mirror_v128_dst(code, dst, rd, frame),
        false => fp_spill_dst_to_slot(code, dst, rd, frame),
    }
    Ok(())
}

/// The VEX or EVEX three-operand form `mnem` over 256- or 512-bit
/// registers, `dst = a op b`: a spilled source is loaded into an FP
/// scratch, and a spilled result is formed in one and stored.
pub(super) fn wide_binary(
    code: &mut CodeBuf,
    mnem: &'static str,
    imm: Option<u8>,
    w: VecWidth,
    dst: Place,
    (a, b): (Place, Place),
    frame: Frame,
) -> Emit {
    use super::asm::{Concrete, YMM_BASE, ZMM_BASE};
    let (sa, sb) = (Reg(frame.fp_scratch[0]), Reg(frame.fp_scratch[1]));
    let (Some(ra), Some(rb)) = (
        materialize_wide(code, w, a, sa, frame),
        materialize_wide(code, w, b, sb, frame),
    ) else {
        return fail("wide vector: a source has no place");
    };
    let rd = match dst {
        Place::FpReg(r) => Reg(r),
        _ => sa,
    };
    let base = if w == VecWidth::V512 {
        ZMM_BASE
    } else {
        YMM_BASE
    };
    let reg = |r: Reg| Concrete::Reg {
        reg: base + r.0,
        size: crate::c5::ir::AsmRegSize::Quad,
    };
    let mut ops = alloc::vec::Vec::with_capacity(4);
    if let Some(i) = imm {
        ops.push(Concrete::Imm(i64::from(i)));
    }
    ops.extend([reg(rb), reg(ra), reg(rd)]);
    encode_wide(code, mnem, &ops)?;
    mirror_wide_dst(code, w, dst, rd, frame);
    Ok(())
}

/// `Inst::SimdVal`: the instruction on the operands' registers, a
/// spilled operand loaded into an FP scratch. A vector result is formed in
/// its own register unless that holds the second source, then in a scratch
/// it is copied from; an integer result goes to its register or through
/// r11 to its spill slot.
pub(super) fn emit_x86_simd_val(
    code: &mut CodeBuf,
    op: u32,
    imm: Option<u8>,
    args: &[super::super::ir::ValueId],
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use super::asm::{Concrete, XMM_BASE};
    use crate::c5::ir::AsmRegSize;
    use crate::c5::simd;
    use crate::c5::simd::Form;
    let row = simd::get(op);
    if wide_lowering(row) {
        return emit_x86_simd_val_wide(code, op, imm, args, dst, alloc, frame);
    }
    let (src_x, dst_x) = (frame.fp_scratch[0], frame.fp_scratch[1]);
    let xmm = |n: u8| Concrete::Reg {
        reg: XMM_BASE + n,
        size: AsmRegSize::Quad,
    };
    let gpr = |r: Reg, size: AsmRegSize| Concrete::Reg { reg: r.0, size };
    let insn = |code: &mut Vec<u8>, mnem: &'static str, ops: &[Concrete]| -> Emit {
        let m = super::asm::mnemonic_by_name(mnem).unwrap_or(super::asm::Mnemonic::Table(mnem));
        if let Err(e) = super::asm::encode(code, 8, m, None, ops) {
            return fail(alloc::format!("x86 simd: {e}"));
        }
        Ok(())
    };
    let place = |i: usize| {
        alloc
            .places
            .get(args[i] as usize)
            .copied()
            .unwrap_or(Place::None)
    };
    let vector = |code: &mut CodeBuf, i: usize, scratch: u8| -> Emit<u8> {
        match materialize_v128(code, place(i), Reg(scratch), frame) {
            Some(r) => Ok(r.0),
            None => fail(alloc::format!("x86 simd: operand {i} has no place")),
        }
    };
    // The register the result is formed in: its own, unless that is
    // `avoid`, a source still to be read.
    let work = |avoid: Option<u8>| match dst {
        Place::FpReg(r) if Some(r) != avoid => r,
        _ => dst_x,
    };
    // Copy operand `i` into `w`.
    let into = |code: &mut CodeBuf, i: usize, w: u8| -> Emit {
        match place(i) {
            Place::FpReg(r) if r == w => {}
            Place::FpReg(r) => emit_movapd_xmm_xmm(code, Reg(w), Reg(r)),
            p => {
                if materialize_v128(code, p, Reg(w), frame).is_none_or(|r| r.0 != w) {
                    return fail(alloc::format!("x86 simd: operand {i} has no place"));
                }
            }
        }
        Ok(())
    };
    let imm8 = Concrete::Imm(imm.unwrap_or(0) as i64);
    let int_size = |w: u8| match w {
        1 => AsmRegSize::Byte,
        2 => AsmRegSize::Word,
        8 => AsmRegSize::Quad,
        _ => AsmRegSize::Long,
    };
    // An integer result: formed in its register, or in r11 and spilled.
    let int_result = |code: &mut Vec<u8>, form: &dyn Fn(&mut Vec<u8>, Reg) -> Emit| match dst {
        Place::IntReg(r) => form(code, Reg(r)),
        Place::Spill(slot) => {
            form(code, SCRATCH_R11)?;
            let (sb, off) = spill_slot_addr(frame, slot);
            emit_mov_mem_r(code, sb, off, SCRATCH_R11);
            Ok(())
        }
        _ => fail("x86 simd: integer result not int reg / spill"),
    };
    let w = match row.form {
        Form::Vvv
        | Form::VvvI
        | Form::CmpMask
        | Form::MaskBlend
        | Form::MaskLoad
        | Form::MaskStore
        | Form::Narrow
        | Form::Widen
        | Form::Zext => {
            return fail("x86 simd: a wide form outside the wide lowering");
        }
        Form::Vv | Form::VvI => {
            let commutes = row.form == Form::Vv && row.sem.commutes();
            let imm = (row.form == Form::VvI).then(|| imm.unwrap_or(0));
            // The VEX three-operand form where the instruction has one, which
            // copies no source into the destination.
            if let Some(m) = super::asm::vex_mnemonic(row.mnem) {
                let encode = |code: &mut Vec<u8>, ops: &[Concrete]| {
                    super::asm::encode(code, 8, m, None, ops)
                        .or_else(|e| fail(alloc::format!("x86 simd: {e}")))
                };
                let mut probe = CodeBuf::default();
                let pair = (place(0), place(1));
                if vex_binary(&mut probe, &encode, imm, row.bytes == 16, dst, pair, frame).is_ok() {
                    code.extend_from_slice(&probe);
                    return Ok(());
                }
            }
            return sse_binary(
                code,
                row.mnem,
                imm,
                commutes,
                row.bytes == 16,
                dst,
                (place(0), place(1)),
                frame,
            );
        }
        Form::V | Form::VI => {
            let a = vector(code, 0, src_x)?;
            let w = work(None);
            // A scalar form keeps the operand's other lanes.
            if matches!(row.sem, simd::Sem::Float(_, _, true)) {
                into(code, 0, w)?;
            }
            if row.form == Form::V {
                insn(code, row.mnem, &[xmm(a), xmm(w)])?;
            } else {
                insn(code, row.mnem, &[imm8, xmm(a), xmm(w)])?;
            }
            w
        }
        Form::Shift => {
            let w = work(None);
            into(code, 0, w)?;
            match imm {
                Some(_) => insn(code, row.mnem, &[imm8, xmm(w)])?,
                None => {
                    let Some(c) = materialize_int(code, place(1), SCRATCH_R10, frame) else {
                        return fail("x86 simd: shift count has no place");
                    };
                    super::encode::emit_movq_xmm_r(code, Reg(src_x), c);
                    insn(code, row.mnem, &[xmm(src_x), xmm(w)])?;
                }
            }
            w
        }
        Form::Insert => {
            let w = work(None);
            into(code, 0, w)?;
            let Some(x) = materialize_int(code, place(1), SCRATCH_R10, frame) else {
                return fail("x86 simd: value operand has no place");
            };
            // Every `pinsr` narrower than a quadword reads a 32-bit
            // register and uses the low lanes of it.
            let size = int_size(row.int_width.max(4));
            insn(code, row.mnem, &[imm8, gpr(x, size), xmm(w)])?;
            w
        }
        Form::ToInt | Form::Extract | Form::MoveMask => {
            let a = vector(code, 0, src_x)?;
            let size = match row.form {
                Form::ToInt if row.int_width == 8 => AsmRegSize::Quad,
                // `pextrb` and `pextrw` zero-extend into the 32-bit register.
                Form::Extract => int_size(row.int_width.max(4)),
                _ => AsmRegSize::Long,
            };
            return int_result(code, &|code: &mut Vec<u8>, r: Reg| match row.form {
                Form::Extract => insn(code, row.mnem, &[imm8, xmm(a), gpr(r, size)]),
                _ => insn(code, row.mnem, &[xmm(a), gpr(r, size)]),
            });
        }
        Form::Load | Form::Store | Form::RdRand => {
            return fail("x86 simd: a memory form has no value form");
        }
    };
    mirror_v128_dst(code, dst, Reg(w), frame);
    Ok(())
}

/// Byte stride between adjacent variadic arguments in the cursor `va_list`
/// of Win64, the only x86_64 target on the cursor forms (System V uses the
/// register save area).
const VA_CURSOR_STRIDE: i32 = 8;

pub(super) fn emit_intrinsic(
    code: &mut CodeBuf,
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
        I::ConstantP | I::ObjectSize | I::SubobjectBound | I::BuiltinArg => {
            fail("a deferred builtin must be resolved before lowering")
        }
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
        // rbp less the FrameOffset the unwind record states.
        I::FuncletFrame | I::EstablisherFrame => {
            let Some(rd) = int_or_spill_dst(dst) else {
                return fail("EstablisherFrame: dst not int reg / spill");
            };
            emit_lea_r_mem(code, rd, Reg::RBP, -(frame.saves_top as i32));
            spill_dst_to_slot(code, dst, rd, frame);
            Ok(())
        }
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
        I::PlatformRegister => fail("the platform register is aarch64-only"),
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
        I::VaStart
        | I::FrameAddress
        | I::ReturnAddress
        | I::StackPointer
        | I::FuncletFrame
        | I::EstablisherFrame => true,
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
        | I::ObjectSize
        | I::SubobjectBound
        | I::BuiltinArg
        | I::PlatformRegister
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
    code: &mut CodeBuf,
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
fn emit_va_copy_sysv(code: &mut CodeBuf, args: &[u32], alloc: &Allocation, frame: Frame) -> Emit {
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
    code: &mut CodeBuf,
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
    code: &mut CodeBuf,
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
fn emit_va_copy_cursor(code: &mut CodeBuf, args: &[u32], alloc: &Allocation, frame: Frame) -> Emit {
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
    code: &mut CodeBuf,
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
fn emit_alloca_save(code: &mut CodeBuf, dst: Place, frame: Frame) -> Emit {
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
fn emit_alloca_restore(code: &mut CodeBuf, args: &[u32], alloc: &Allocation, frame: Frame) -> Emit {
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
    code: &mut CodeBuf,
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
fn emit_divq128(code: &mut CodeBuf, args: &[u32], alloc: &Allocation, frame: Frame) -> Emit {
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
        |code: &mut CodeBuf, idx: usize, scratch: Reg, pushed: u32| -> Option<Reg> {
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
    code: &mut CodeBuf,
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
    code: &mut CodeBuf,
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
    code: &mut CodeBuf,
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
    // A body holding 256-bit values fills 32-byte units, VEX-encoded, as
    // its copies move them.
    let vex = frame.wide_regs;
    let widest = match xmm {
        Some(_) if vex && total >= 32 => 32,
        Some(_) => 16,
        None => unit,
    };
    let width = |left: u32| {
        let mut w = widest;
        while w > left {
            w /= 2;
        }
        w
    };
    let store = |code: &mut CodeBuf, w: u32, base: Reg, off: i32| match xmm {
        Some(x) if w == 32 => super::encode::emit_vmovups_mem_ymm(code, base, off, x),
        Some(x) if w == 16 && vex => super::encode::emit_vmovups_mem_xmm(code, base, off, x),
        Some(x) if w == 16 => emit_movups_mem_xmm(code, base, off, x),
        _ => emit_mi(code, Mnem::Mov, w as u8, base, off, 0),
    };
    match xmm {
        Some(x) if vex => super::encode::emit_vxorps_ymm(code, x),
        Some(x) => emit_xorps(code, x, x),
        None => {}
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
    code: &mut CodeBuf,
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
    // A body holding 256-bit values runs with AVX: its copies move 32-byte
    // units and take the VEX encodings, as a legacy SSE access between
    // 256-bit ones carries their upper halves.
    let vex = frame.wide_regs;
    let widest = match xmm {
        Some(_) if vex && bytes >= 32 => 32,
        Some(_) => 16,
        None => unit,
    };
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
        (32, Some(x), _) => {
            super::encode::emit_vmovups_ymm_mem(code, x, s, off);
            super::encode::emit_vmovups_mem_ymm(code, d, off, x);
        }
        (16, Some(x), _) if vex => {
            super::encode::emit_vmovups_xmm_mem(code, x, s, off);
            super::encode::emit_vmovups_mem_xmm(code, d, off, x);
        }
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
        let cursor = |code: &mut CodeBuf, regs: &mut SiteRegs, base: Reg| {
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
    code: &mut CodeBuf,
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
    code: &mut CodeBuf,
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
    code: &mut CodeBuf,
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

/// C11 7.17.7.2-7.17.7.5 read-modify-write (Intel SDM Vol.2): when the
/// prior contents are unread, one `LOCK ADD` / `SUB` / `AND` / `OR` /
/// `XOR`, its operand an immediate where `Allocation::imm_store` says so;
/// else `XCHG` for exchange and `LOCK XADD` for addition and subtraction,
/// the operand negated, both leaving the prior contents in their
/// register, and for the bitwise operators a `LOCK CMPXCHG` retry on rax. A locked instruction
/// is a full barrier, so every order lowers alike (the x86 mapping of
/// C11 atomics). The address rides its own register or r11.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_atomic_rmw(
    code: &mut CodeBuf,
    v: super::super::ir::ValueId,
    dst: Place,
    (op, addr, value, width): (
        super::super::ir::AtomicRmwOp,
        super::super::ir::ValueId,
        super::super::ir::ValueId,
        u8,
    ),
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
) -> Emit {
    use super::super::ir::AtomicRmwOp as Op;
    let Some(a) = materialize_int(code, place_of(alloc, addr), SCRATCH_R11, frame) else {
        return fail("AtomicRmw: address not int reg / spill");
    };
    // Prior contents nothing reads: one locked operation on the object.
    if dst == Place::None && op != Op::Xchg {
        let mnem = match op {
            Op::Add => Mnem::Add,
            Op::Sub => Mnem::Sub,
            Op::And => Mnem::And,
            Op::Or => Mnem::Or,
            _ => Mnem::Xor,
        };
        if alloc.imm_store.get(v as usize).copied().unwrap_or(false) {
            let Some(imm) =
                crate::c5::codegen::ssa::reg_alloc::atomic_immediate(func, value, width)
            else {
                return fail("AtomicRmw: operand not an immediate");
            };
            super::encode::emit_lock_alu_mem_imm(code, mnem, a, 0, imm, width);
            return Ok(());
        }
        let Some(x) = materialize_int(code, place_of(alloc, value), SCRATCH_R10, frame) else {
            return fail("AtomicRmw: operand not int reg / spill");
        };
        super::encode::emit_lock_alu_mem_r(code, mnem, a, 0, x, width);
        return Ok(());
    }
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

/// C11 7.17.7.4 on 16 bytes as `LOCK CMPXCHG16B` (Intel SDM Vol.2), a full
/// barrier whatever the order: rcx:rbx takes the replacement and rdx:rax
/// the comparand from their objects, and a mismatch writes rdx:rax, the
/// prior contents, over the comparand's object. The object rides r11; the
/// replacement's and then the comparand's address ride r10, the latter
/// kept on the stack meanwhile. rbx, which the caller may hold, is saved
/// around it, as are rax, rcx and rdx where a value lives in them. The
/// value is whether it matched.
pub(super) fn emit_atomic_cas16(
    code: &mut CodeBuf,
    v: super::super::ir::ValueId,
    dst: Place,
    addr: super::super::ir::ValueId,
    expected: super::super::ir::ValueId,
    desired: super::super::ir::ValueId,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use super::encode::emit_lock_cmpxchg16b_mem;
    let operand = |code: &mut CodeBuf, value, r: Reg, shift: u32| -> Emit {
        let Some(x) = materialize_int_shifted(code, place_of(alloc, value), r, frame, shift) else {
            return fail("AtomicCas16: operand not int reg / spill");
        };
        if x != r {
            emit_mov_rr(code, r, x);
        }
        Ok(())
    };
    operand(code, expected, SCRATCH_R10, 0)?;
    emit_push_r(code, SCRATCH_R10);
    operand(code, desired, SCRATCH_R10, 8)?;
    operand(code, addr, SCRATCH_R11, 8)?;
    emit_push_r(code, Reg::RBX);
    let mut acc = SiteRegs::new(
        alloc,
        v,
        &[Reg::RAX.0, Reg::RCX.0, Reg::RDX.0],
        &[SCRATCH_R10.0, SCRATCH_R11.0],
        frame.fixed_regs,
    );
    for _ in 0..3 {
        if acc.take(code).is_none() {
            return fail("AtomicCas16: rax, rcx or rdx is reserved");
        }
    }
    emit_mov_r_mem(code, Reg::RBX, SCRATCH_R10, 0);
    emit_mov_r_mem(code, Reg::RCX, SCRATCH_R10, 8);
    let parked = acc.saved_bytes() as i32 + 8;
    emit_mov_r_mem(code, SCRATCH_R10, Reg::RSP, parked);
    emit_mov_r_mem(code, Reg::RAX, SCRATCH_R10, 0);
    emit_mov_r_mem(code, Reg::RDX, SCRATCH_R10, 8);
    emit_lock_cmpxchg16b_mem(code, SCRATCH_R11, 0);
    // A match skips the write-back; the stores keep ZF.
    let skip = code.len();
    emit_jcc_rel8(code, Cc::E, 0);
    emit_mov_mem_r(code, SCRATCH_R10, 0, Reg::RAX);
    emit_mov_mem_r(code, SCRATCH_R10, 8, Reg::RDX);
    code[skip + 1] = (code.len() - skip - 2) as u8;
    super::encode::emit_setcc_r8(code, Cc::E, Reg::RCX);
    emit_movzx_r_r8(code, SCRATCH_R10, Reg::RCX);
    acc.restore(code);
    emit_pop_r(code, Reg::RBX);
    emit_pop_r(code, SCRATCH_R11);
    write_atomic_result(code, dst, SCRATCH_R10, frame);
    Ok(())
}

/// C11 7.17.7.4 compare-and-exchange as `LOCK CMPXCHG` (Intel SDM Vol.2),
/// a full barrier whatever the order: rax takes the comparand
/// zero-extended from `width` bytes and leaves with the prior contents,
/// which a match leaves equal to it. The address rides its own register
/// or r11, `desired` its own or r10.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_atomic_cas(
    code: &mut CodeBuf,
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

/// A vector register of a form of `bytes`: xmm, ymm or zmm `n`.
fn wide_reg(bytes: u8, n: u8) -> super::asm::Concrete {
    use super::asm::{Concrete, XMM_BASE, YMM_BASE, ZMM_BASE};
    let base = match bytes {
        64 => ZMM_BASE,
        32 => YMM_BASE,
        _ => XMM_BASE,
    };
    Concrete::Reg {
        reg: base + n,
        size: crate::c5::ir::AsmRegSize::Quad,
    }
}

/// Opmask k1, which the opmask forms read and write; the allocator assigns
/// no opmask register.
fn k1() -> super::asm::Concrete {
    super::asm::Concrete::Reg {
        reg: super::asm::MASK_BASE + 1,
        size: crate::c5::ir::AsmRegSize::Quad,
    }
}

/// `kmovq` between k1 and general register `r`, into k1 when `into_k`.
fn kmov(code: &mut Vec<u8>, r: Reg, into_k: bool) -> Emit {
    let gpr = super::asm::Concrete::Reg {
        reg: r.0,
        size: crate::c5::ir::AsmRegSize::Quad,
    };
    let ops = if into_k { [gpr, k1()] } else { [k1(), gpr] };
    encode_wide(code, "kmovq", &ops)
}

/// [`encode_wide`] under write mask k1, zeroing the unselected lanes when
/// `zeroing`.
fn encode_masked(
    code: &mut Vec<u8>,
    mnem: &'static str,
    ops: &[super::asm::Concrete],
    zeroing: bool,
) -> Emit {
    let lead_imm = matches!(ops.first(), Some(super::asm::Concrete::Imm(_)));
    let Some(mut f) = super::evex::op(mnem, lead_imm) else {
        return fail(alloc::format!("x86 simd: `{mnem}` has no EVEX form"));
    };
    (f.mask, f.zeroing) = (1, zeroing);
    super::asm::encode(code, 8, super::asm::Mnemonic::Evex(f), None, ops)
        .or_else(|e| fail(alloc::format!("x86 simd: {e}")))
}

fn mem_at(base: Reg) -> super::asm::Concrete {
    super::asm::Concrete::Mem {
        base: base.0,
        index: None,
        scale: 1,
        disp: 0,
        size: crate::c5::ir::AsmRegSize::Quad,
    }
}

/// A source of a wide form: a register, or a vector in memory, which the
/// instruction's last source may read in place.
#[derive(Clone, Copy)]
enum WideSrc {
    Reg(u8),
    Mem(Reg, i32),
}

/// The operands of a wide form in AT&T order for its VEX or EVEX
/// instruction: `[imm8,] src2, src1, dst`, `a` the first source; `vpermd`
/// reads its indices from VEX.vvvv, its second operand, and a one-source
/// form names no `b`.
fn wide_operands(
    row: &crate::c5::x86_simd::SimdOp,
    imm: Option<u8>,
    a: u8,
    b: Option<WideSrc>,
    d: u8,
) -> alloc::vec::Vec<super::asm::Concrete> {
    use super::asm::Concrete;
    use crate::c5::simd::{Form, Sem};
    let reg = |n: u8| wide_reg(row.bytes, n);
    let src = |s: WideSrc| match s {
        WideSrc::Reg(n) => reg(n),
        WideSrc::Mem(base, disp) => Concrete::Mem {
            base: base.0,
            index: None,
            scale: 1,
            disp,
            size: crate::c5::ir::AsmRegSize::Quad,
        },
    };
    let mut ops = alloc::vec::Vec::with_capacity(4);
    if matches!(row.form, Form::VvI | Form::VI | Form::VvvI) {
        ops.push(Concrete::Imm(i64::from(imm.unwrap_or(0))));
    }
    match (b, row.sem) {
        (Some(b), Sem::PermVar32) => ops.extend([reg(a), src(b)]),
        (Some(b), _) => ops.extend([src(b), reg(a)]),
        (None, _) => ops.push(reg(a)),
    }
    ops.push(reg(d));
    ops
}

/// Encode a wide form; one naming a zmm register takes its EVEX row, as the
/// assembler settles it for the same operands.
pub(super) fn encode_wide(
    code: &mut Vec<u8>,
    mnem: &'static str,
    ops: &[super::asm::Concrete],
) -> Emit {
    use super::asm::{Concrete, Mnemonic};
    let zmm = ops
        .iter()
        .any(|o| matches!(*o, Concrete::Reg { reg, .. } if super::evex::reg_needs_evex(reg)));
    let m = if zmm {
        let lead_imm = matches!(ops.first(), Some(Concrete::Imm(_)));
        match super::evex::op(mnem, lead_imm) {
            Some(f) => Mnemonic::Evex(f),
            None => return fail(alloc::format!("x86 simd: `{mnem}` has no EVEX form")),
        }
    } else {
        super::asm::mnemonic_by_name(mnem).unwrap_or(Mnemonic::Table(mnem))
    };
    super::asm::encode(code, 8, m, None, ops).or_else(|e| fail(alloc::format!("x86 simd: {e}")))
}

/// A shift of wide register `a` into `d` by an immediate, or by the count
/// operand moved into the low quadword of xmm `scratch`.
fn wide_shift(
    code: &mut Vec<u8>,
    row: &crate::c5::x86_simd::SimdOp,
    imm: Option<u8>,
    count: Option<Reg>,
    (a, d, scratch): (u8, u8, u8),
) -> Emit {
    use super::asm::{Concrete, XMM_BASE};
    // EVEX shifts a zmm register by a variable count per lane: the count,
    // capped at 255 so its low 16 bits stand for it as the whole does,
    // broadcast to every quadword.
    if let (None, Some(c), 64) = (imm, count, row.bytes) {
        let var = match row.mnem {
            "vpsllw" => "vpsllvw",
            "vpslld" => "vpsllvd",
            "vpsllq" => "vpsllvq",
            "vpsrlw" => "vpsrlvw",
            "vpsrld" => "vpsrlvd",
            "vpsrlq" => "vpsrlvq",
            "vpsraw" => "vpsravw",
            "vpsrad" => "vpsravd",
            m => return fail(alloc::format!("x86 simd: `{m}` has no variable zmm form")),
        };
        let q = |r: Reg| Concrete::Reg {
            reg: r.0,
            size: crate::c5::ir::AsmRegSize::Quad,
        };
        if c.0 != SCRATCH_R10.0 {
            emit_mov_rr(code, SCRATCH_R10, c);
        }
        encode_wide(code, "mov", &[Concrete::Imm(255), q(SCRATCH_R11)])?;
        encode_wide(code, "cmp", &[q(SCRATCH_R11), q(SCRATCH_R10)])?;
        encode_wide(code, "cmova", &[q(SCRATCH_R11), q(SCRATCH_R10)])?;
        encode_wide(
            code,
            "vpbroadcastq",
            &[q(SCRATCH_R10), wide_reg(64, scratch)],
        )?;
        let ops = [wide_reg(64, scratch), wide_reg(64, a), wide_reg(64, d)];
        return encode_wide(code, var, &ops);
    }
    let by = match (imm, count) {
        (Some(i), _) => Concrete::Imm(i64::from(i)),
        (None, Some(c)) => {
            emit_vmovq_xmm_r(code, Reg(scratch), c);
            Concrete::Reg {
                reg: XMM_BASE + scratch,
                size: crate::c5::ir::AsmRegSize::Quad,
            }
        }
        (None, None) => return fail("x86 simd: shift count has no place"),
    };
    encode_wide(
        code,
        row.mnem,
        &[by, wide_reg(row.bytes, a), wide_reg(row.bytes, d)],
    )
}

/// The sign bits of the bytes of wide register `a` into general register
/// `r`: `vpmovmskb` of a ymm register, or `vpmovb2m` into k1 and `kmovq`
/// of a zmm one, which has no `vpmovmskb`.
fn wide_movemask(code: &mut Vec<u8>, row: &crate::c5::x86_simd::SimdOp, a: u8, r: Reg) -> Emit {
    use super::asm::Concrete;
    use crate::c5::ir::AsmRegSize;
    let gpr = |size| Concrete::Reg { reg: r.0, size };
    if row.bytes == 64 {
        let k1 = Concrete::Reg {
            reg: super::asm::MASK_BASE + 1,
            size: AsmRegSize::Quad,
        };
        encode_wide(code, "vpmovb2m", &[wide_reg(64, a), k1])?;
        return encode_wide(code, "kmovq", &[k1, gpr(AsmRegSize::Quad)]);
    }
    encode_wide(
        code,
        row.mnem,
        &[wide_reg(row.bytes, a), gpr(AsmRegSize::Long)],
    )
}

/// [`emit_x86_simd`] for a 32- or 64-byte form: the operands load into the
/// FP scratch registers through their addresses, a three-source form's last
/// one read in place, and the result stores through the destination's.
fn emit_x86_simd_wide(
    code: &mut CodeBuf,
    op: u32,
    imm: Option<u8>,
    args: &[super::super::ir::ValueId],
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use crate::c5::simd;
    use crate::c5::simd::Form;
    let row = simd::get(op);
    let w = VecWidth::of_bytes(row.bytes);
    let (src_x, dst_x) = (frame.fp_scratch[0], frame.fp_scratch[1]);
    let operand = |code: &mut CodeBuf, i: usize, scratch: Reg| -> Emit<Reg> {
        let place = args
            .get(i)
            .and_then(|&a| alloc.places.get(a as usize).copied());
        match place.and_then(|p| materialize_int(code, p, scratch, frame)) {
            Some(r) => Ok(r),
            None => fail(alloc::format!("x86 simd: operand {i} has no place")),
        }
    };
    let load = |code: &mut CodeBuf, i: usize, n: u8| -> Emit {
        let a = operand(code, i, SCRATCH_R10)?;
        emit_wide_load(code, w, Reg(n), a, 0);
        Ok(())
    };
    match row.form {
        Form::Vv | Form::VvI => {
            load(code, 1, dst_x)?;
            load(code, 2, src_x)?;
            let ops = wide_operands(row, imm, dst_x, Some(WideSrc::Reg(src_x)), dst_x);
            encode_wide(code, row.mnem, &ops)?;
        }
        Form::Vvv if matches!(row.sem, simd::Sem::BlendVar(_)) => {
            // The is4 blend reads the mask from a register and the second
            // source from memory.
            load(code, 1, dst_x)?;
            load(code, 3, src_x)?;
            let b = operand(code, 2, SCRATCH_R11)?;
            let r = |n| wide_reg(row.bytes, n);
            encode_wide(code, row.mnem, &[r(src_x), mem_at(b), r(dst_x), r(dst_x)])?;
        }
        Form::Vvv | Form::VvvI => {
            load(code, 1, dst_x)?;
            load(code, 2, src_x)?;
            let c = operand(code, 3, SCRATCH_R11)?;
            let ops = wide_operands(row, imm, src_x, Some(WideSrc::Mem(c, 0)), dst_x);
            encode_wide(code, row.mnem, &ops)?;
        }
        Form::V | Form::VI => {
            load(code, 1, src_x)?;
            encode_wide(code, row.mnem, &wide_operands(row, imm, src_x, None, dst_x))?;
        }
        Form::Shift => {
            load(code, 1, dst_x)?;
            let count = match imm {
                Some(_) => None,
                None => Some(operand(code, 2, SCRATCH_R10)?),
            };
            wide_shift(code, row, imm, count, (dst_x, dst_x, src_x))?;
        }
        Form::Narrow => {
            load(code, 1, src_x)?;
            narrow(code, row, imm, src_x, dst_x)?;
            let d = operand(code, 0, SCRATCH_R10)?;
            return encode_wide(
                code,
                "vmovdqu",
                &[wide_reg(row.int_width, dst_x), mem_at(d)],
            );
        }
        Form::Widen => {
            load(code, 1, dst_x)?;
            let p = operand(code, 2, SCRATCH_R10)?;
            encode_wide(
                code,
                "vmovdqu",
                &[mem_at(p), wide_reg(row.int_width, src_x)],
            )?;
            let ops = [
                super::asm::Concrete::Imm(i64::from(imm.unwrap_or(0))),
                wide_reg(row.int_width, src_x),
                wide_reg(row.bytes, dst_x),
                wide_reg(row.bytes, dst_x),
            ];
            encode_wide(code, row.mnem, &ops)?;
        }
        // A VEX load clears the bits above the part.
        Form::Zext => {
            let p = operand(code, 1, SCRATCH_R10)?;
            encode_wide(
                code,
                "vmovdqu",
                &[mem_at(p), wide_reg(row.int_width, dst_x)],
            )?;
        }
        Form::Load => load(code, 1, dst_x)?,
        Form::Store => {
            load(code, 1, dst_x)?;
            let p = operand(code, 0, SCRATCH_R10)?;
            emit_wide_store(code, w, p, 0, Reg(dst_x));
            return Ok(());
        }
        Form::MoveMask => {
            load(code, 1, src_x)?;
            wide_movemask(code, row, src_x, SCRATCH_R11)?;
            let d = operand(code, 0, SCRATCH_R10)?;
            emit_mov_mem_r(code, d, 0, SCRATCH_R11);
            return Ok(());
        }
        Form::CmpMask => {
            load(code, 1, dst_x)?;
            load(code, 2, src_x)?;
            let ops = [
                super::asm::Concrete::Imm(i64::from(imm.unwrap_or(0))),
                wide_reg(row.bytes, src_x),
                wide_reg(row.bytes, dst_x),
                k1(),
            ];
            encode_wide(code, row.mnem, &ops)?;
            kmov(code, SCRATCH_R11, false)?;
            let d = operand(code, 0, SCRATCH_R10)?;
            emit_mov_mem_r(code, d, 0, SCRATCH_R11);
            return Ok(());
        }
        Form::MaskBlend => {
            load(code, 1, dst_x)?;
            load(code, 3, src_x)?;
            let m = operand(code, 2, SCRATCH_R11)?;
            kmov(code, m, true)?;
            let r = |n| wide_reg(row.bytes, n);
            encode_masked(code, row.mnem, &[r(src_x), r(dst_x), r(dst_x)], false)?;
        }
        Form::MaskLoad => {
            let m = operand(code, 1, SCRATCH_R11)?;
            kmov(code, m, true)?;
            let p = operand(code, 2, SCRATCH_R10)?;
            encode_masked(
                code,
                row.mnem,
                &[mem_at(p), wide_reg(row.bytes, dst_x)],
                true,
            )?;
        }
        Form::MaskStore => {
            load(code, 2, dst_x)?;
            let m = operand(code, 1, SCRATCH_R11)?;
            kmov(code, m, true)?;
            let p = operand(code, 0, SCRATCH_R10)?;
            return encode_masked(
                code,
                row.mnem,
                &[wide_reg(row.bytes, dst_x), mem_at(p)],
                false,
            );
        }
        _ => return fail(alloc::format!("x86 simd: {} has no wide form", row.name)),
    }
    let d = operand(code, 0, SCRATCH_R10)?;
    emit_wide_store(code, w, d, 0, Reg(dst_x));
    Ok(())
}

/// Part `imm` of wide register `src` into xmm `dst`: the row's instruction,
/// or a `vmovdqa` of the low part, which needs no lane crossing.
fn narrow(
    code: &mut Vec<u8>,
    row: &crate::c5::x86_simd::SimdOp,
    imm: Option<u8>,
    src: u8,
    dst: u8,
) -> Emit {
    let k = imm.unwrap_or(0) % (row.bytes / row.int_width);
    if k != 0 {
        let ops = [
            super::asm::Concrete::Imm(i64::from(k)),
            wide_reg(row.bytes, src),
            wide_reg(row.int_width, dst),
        ];
        encode_wide(code, row.mnem, &ops)
    } else if src != dst {
        encode_wide(code, "vmovdqa", &[wide_reg(16, src), wide_reg(16, dst)])
    } else {
        Ok(())
    }
}

/// [`emit_x86_simd_val`] for a 32- or 64-byte form: the instruction on the
/// operands' registers, a spilled one loaded into an FP scratch (the last
/// source of a three-source form read from its spill slot), and the result
/// formed in its register or in a scratch it is stored from.
fn emit_x86_simd_val_wide(
    code: &mut CodeBuf,
    op: u32,
    imm: Option<u8>,
    args: &[super::super::ir::ValueId],
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use crate::c5::simd;
    use crate::c5::simd::Form;
    let row = simd::get(op);
    let w = VecWidth::of_bytes(row.bytes);
    let (sa, sb) = (frame.fp_scratch[0], frame.fp_scratch[1]);
    let place = |i: usize| {
        args.get(i)
            .and_then(|&a| alloc.places.get(a as usize).copied())
    };
    let vector = |code: &mut CodeBuf, i: usize, scratch: u8| -> Emit<u8> {
        match place(i).and_then(|p| materialize_wide(code, w, p, Reg(scratch), frame)) {
            Some(r) => Ok(r.0),
            None => fail(alloc::format!("x86 simd: operand {i} has no place")),
        }
    };
    let rd = match dst {
        Place::FpReg(r) => r,
        _ => sa,
    };
    match row.form {
        Form::Vv | Form::VvI => {
            let a = vector(code, 0, sa)?;
            let b = vector(code, 1, sb)?;
            encode_wide(
                code,
                row.mnem,
                &wide_operands(row, imm, a, Some(WideSrc::Reg(b)), rd),
            )?;
        }
        Form::Vvv if matches!(row.sem, simd::Sem::BlendVar(_)) => {
            // The is4 blend writes any register: the first source and the
            // mask in registers, the second in one or its spill slot.
            let a = vector(code, 0, sa)?;
            let m = vector(code, 2, sb)?;
            let b = match place(1) {
                Some(Place::FpReg(r)) => WideSrc::Reg(r),
                Some(Place::Spill(slot)) => {
                    let (base, off) = wide_spill_addr(frame, w, slot);
                    WideSrc::Mem(base, off)
                }
                _ => return fail("x86 simd: operand 1 has no place"),
            };
            let r = |n| wide_reg(row.bytes, n);
            let b = match b {
                WideSrc::Reg(n) => r(n),
                WideSrc::Mem(base, disp) => super::asm::Concrete::Mem {
                    base: base.0,
                    index: None,
                    scale: 1,
                    disp,
                    size: crate::c5::ir::AsmRegSize::Quad,
                },
            };
            encode_wide(code, row.mnem, &[r(m), b, r(a), r(rd)])?;
        }
        Form::Vvv | Form::VvvI => {
            // The accumulator is copied into the register the result forms
            // in; that is a scratch when the destination holds a source.
            let a = vector(code, 1, sb)?;
            let c = match place(2) {
                Some(Place::FpReg(r)) => WideSrc::Reg(r),
                Some(Place::Spill(slot)) => {
                    let (base, off) = wide_spill_addr(frame, w, slot);
                    WideSrc::Mem(base, off)
                }
                _ => return fail("x86 simd: operand 2 has no place"),
            };
            let reads = |r: u8| a == r || matches!(c, WideSrc::Reg(x) if x == r);
            let work = if reads(rd) && place(0) != Some(Place::FpReg(rd)) {
                sa
            } else {
                rd
            };
            let acc = vector(code, 0, work)?;
            if acc != work {
                emit_wide_mov(code, w, Reg(work), Reg(acc));
            }
            encode_wide(code, row.mnem, &wide_operands(row, imm, a, Some(c), work))?;
            mirror_wide_dst(code, w, dst, Reg(work), frame);
            return Ok(());
        }
        Form::V | Form::VI => {
            let a = vector(code, 0, sa)?;
            encode_wide(code, row.mnem, &wide_operands(row, imm, a, None, rd))?;
        }
        Form::Shift => {
            let a = vector(code, 0, sa)?;
            let count = match imm {
                Some(_) => None,
                None => match place(1).and_then(|p| materialize_int(code, p, SCRATCH_R10, frame)) {
                    Some(c) => Some(c),
                    None => return fail("x86 simd: shift count has no place"),
                },
            };
            wide_shift(code, row, imm, count, (a, rd, sb))?;
        }
        Form::CmpMask => {
            let a = vector(code, 0, sa)?;
            let b = vector(code, 1, sb)?;
            let ops = [
                super::asm::Concrete::Imm(i64::from(imm.unwrap_or(0))),
                wide_reg(row.bytes, b),
                wide_reg(row.bytes, a),
                k1(),
            ];
            encode_wide(code, row.mnem, &ops)?;
            return match dst {
                Place::IntReg(r) => kmov(code, Reg(r), false),
                Place::Spill(slot) => {
                    kmov(code, SCRATCH_R11, false)?;
                    let (sbase, off) = spill_slot_addr(frame, slot);
                    emit_mov_mem_r(code, sbase, off, SCRATCH_R11);
                    Ok(())
                }
                _ => fail("x86 simd: integer result not int reg / spill"),
            };
        }
        Form::MaskBlend => {
            let src = vector(code, 0, sa)?;
            let a = vector(code, 2, sb)?;
            let Some(m) = place(1).and_then(|p| materialize_int(code, p, SCRATCH_R11, frame))
            else {
                return fail("x86 simd: mask has no place");
            };
            kmov(code, m, true)?;
            let r = |n| wide_reg(row.bytes, n);
            encode_masked(code, row.mnem, &[r(a), r(src), r(rd)], false)?;
        }
        Form::Narrow => {
            // A part of a spilled vector loads from its slot.
            if let Some(Place::Spill(slot)) = place(0) {
                let k = imm.unwrap_or(0) % (row.bytes / row.int_width);
                let (base, disp) = wide_spill_addr(frame, w, slot);
                let at = super::asm::Concrete::Mem {
                    base: base.0,
                    index: None,
                    scale: 1,
                    disp: disp + i32::from(k) * i32::from(row.int_width),
                    size: crate::c5::ir::AsmRegSize::Quad,
                };
                encode_wide(code, "vmovdqu", &[at, wide_reg(row.int_width, rd)])?;
            } else {
                let a = vector(code, 0, sa)?;
                narrow(code, row, imm, a, rd)?;
            }
            mirror_v128_dst(code, dst, Reg(rd), frame);
            return Ok(());
        }
        Form::Widen | Form::Zext => {
            let i = usize::from(row.form == Form::Widen);
            let Some(b) = place(i).and_then(|p| materialize_v128(code, p, Reg(sb), frame)) else {
                return fail(alloc::format!("x86 simd: operand {i} has no place"));
            };
            if row.form == Form::Widen {
                let a = vector(code, 0, sa)?;
                let ops = [
                    super::asm::Concrete::Imm(i64::from(imm.unwrap_or(0))),
                    wide_reg(16, b.0),
                    wide_reg(row.bytes, a),
                    wide_reg(row.bytes, rd),
                ];
                encode_wide(code, row.mnem, &ops)?;
            } else {
                // A VEX move clears the bits above the part.
                encode_wide(code, row.mnem, &[wide_reg(16, b.0), wide_reg(16, rd)])?;
            }
        }
        Form::MoveMask => {
            let a = vector(code, 0, sa)?;
            return match dst {
                Place::IntReg(r) => wide_movemask(code, row, a, Reg(r)),
                Place::Spill(slot) => {
                    wide_movemask(code, row, a, SCRATCH_R11)?;
                    let (sbase, off) = spill_slot_addr(frame, slot);
                    emit_mov_mem_r(code, sbase, off, SCRATCH_R11);
                    Ok(())
                }
                _ => fail("x86 simd: integer result not int reg / spill"),
            };
        }
        _ => {
            return fail(alloc::format!(
                "x86 simd: {} has no wide value form",
                row.name
            ));
        }
    }
    mirror_wide_dst(code, w, dst, Reg(rd), frame);
    Ok(())
}

/// The 128-bit part of wide register `v` holding byte `off`, extracted into
/// xmm `scratch` (`vextracti128` / `vextracti32x4`), or `v` itself for a
/// vector of 16 bytes or fewer; with the lane's offset within it.
fn lane_part(code: &mut Vec<u8>, bytes: u8, v: u8, off: u8, scratch: u8) -> Emit<(u8, u8)> {
    if bytes <= 16 {
        return Ok((v, off));
    }
    let mnem = if bytes == 64 {
        "vextracti32x4"
    } else {
        "vextracti128"
    };
    let ops = [
        super::asm::Concrete::Imm(i64::from(off / 16)),
        wide_reg(bytes, v),
        wide_reg(16, scratch),
    ];
    encode_wide(code, mnem, &ops)?;
    Ok((scratch, off % 16))
}

/// `Inst::VecExtract`: the lane at byte `off` of a vector into an integer
/// register, extended as `kind` reads it, or into an FP one, the lane moved
/// into the low element.
pub(super) fn emit_vec_extract(
    code: &mut CodeBuf,
    (vec, off, kind, bytes): (super::super::ir::ValueId, u8, LoadKind, u8),
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use super::asm::Concrete;
    use crate::c5::ir::AsmRegSize;
    let (sa, sb) = (frame.fp_scratch[0], frame.fp_scratch[1]);
    let w = VecWidth::of_bytes(bytes);
    // A 128-bit part of a spilled wide vector loads from its slot.
    if let (LoadKind::V128, Place::Spill(slot), true) = (kind, place_of(alloc, vec), bytes > 16) {
        let Some(dd) = fp_or_spill_dst(dst, frame) else {
            return fail("VecExtract: dst not fp reg / spill");
        };
        let (base, disp) = wide_spill_addr(frame, w, slot);
        let at = Concrete::Mem {
            base: base.0,
            index: None,
            scale: 1,
            disp: disp + i32::from(off & !15),
            size: AsmRegSize::Quad,
        };
        encode_wide(code, "vmovdqu", &[at, wide_reg(16, dd.0)])?;
        mirror_v128_dst(code, dst, dd, frame);
        return Ok(());
    }
    // An 8-byte vector is the low quad of its xmm register.
    let src = match (w, bytes) {
        (_, 8) => materialize_fp(code, place_of(alloc, vec), Reg(sa), frame),
        (VecWidth::V128, _) => materialize_v128(code, place_of(alloc, vec), Reg(sa), frame),
        _ => materialize_wide(code, w, place_of(alloc, vec), Reg(sa), frame),
    };
    let Some(src) = src else {
        return fail("VecExtract: vector has no place");
    };
    if kind == LoadKind::V128 {
        let Some(dd) = fp_or_spill_dst(dst, frame) else {
            return fail("VecExtract: dst not fp reg / spill");
        };
        // The low part is the register's xmm view.
        let x = if off < 16 {
            src.0
        } else {
            lane_part(code, bytes, src.0, off, dd.0)?.0
        };
        if x != dd.0 {
            encode_wide(code, "vmovdqa", &[wide_reg(16, x), wide_reg(16, dd.0)])?;
        }
        mirror_v128_dst(code, dst, dd, frame);
        return Ok(());
    }
    // A read of the low part reads the register's xmm view.
    let (x, loff) = if off < 16 {
        (src.0, off)
    } else {
        lane_part(code, bytes, src.0, off, sb)?
    };
    let imm = |k: u8| Concrete::Imm(i64::from(k));
    if matches!(kind, LoadKind::F32 | LoadKind::F64) {
        let Some(dd) = fp_or_spill_dst(dst, frame) else {
            return fail("VecExtract: dst not fp reg / spill");
        };
        // A scalar reads only its low bits: the low lane in place is it.
        if loff == 0 && x == dd.0 && matches!(dst, Place::FpReg(_)) {
            return Ok(());
        }
        let ops = match kind {
            LoadKind::F64 => [imm(loff / 8), wide_reg(16, x), wide_reg(16, dd.0)],
            _ => [imm(loff / 4), wide_reg(16, x), wide_reg(16, dd.0)],
        };
        encode_wide(
            code,
            if kind == LoadKind::F64 {
                "vpermilpd"
            } else {
                "vpermilps"
            },
            &ops,
        )?;
        mirror_fp_dst(code, dst, dd, frame);
        return Ok(());
    }
    let Some(rd) = int_or_spill_dst(dst) else {
        return fail("VecExtract: dst not int reg / spill");
    };
    let gpr = |size| Concrete::Reg { reg: rd.0, size };
    let (mnem, k, size) = match kind {
        LoadKind::I64 => ("vpextrq", loff / 8, AsmRegSize::Quad),
        LoadKind::I32 | LoadKind::U32 => ("vpextrd", loff / 4, AsmRegSize::Long),
        LoadKind::I16 | LoadKind::U16 => ("vpextrw", loff / 2, AsmRegSize::Long),
        _ => ("vpextrb", loff, AsmRegSize::Long),
    };
    // The low quadword or doubleword is a move, the doubleword zero-extended.
    if loff == 0 && matches!(size, AsmRegSize::Quad) || loff == 0 && mnem == "vpextrd" {
        let mov = if mnem == "vpextrq" { "vmovq" } else { "vmovd" };
        encode_wide(code, mov, &[wide_reg(16, x), gpr(size)])?;
    } else {
        encode_wide(code, mnem, &[imm(k), wide_reg(16, x), gpr(size)])?;
    }
    if matches!(kind, LoadKind::I32 | LoadKind::I16 | LoadKind::I8) {
        emit_sign_extend(code, rd, rd, kind);
    }
    spill_dst_to_slot(code, dst, rd, frame);
    Ok(())
}

/// `Inst::VecConst`: `vpxor` for zero and `vpcmpeqd` for all ones, which
/// read no register; another lane is built in a general register and
/// broadcast. An 8-byte vector's upper half is cleared by `vmovq`.
pub(super) fn emit_vec_const(
    code: &mut CodeBuf,
    (imm, kind, bytes): (i64, StoreKind, u8),
    dst: Place,
    frame: Frame,
) -> Emit {
    use super::asm::Concrete;
    use crate::c5::ir::AsmRegSize;
    let rd = match dst {
        Place::FpReg(r) => r,
        _ => frame.fp_scratch[0],
    };
    let full = bytes.max(16);
    let (bits, mnem) = match kind {
        StoreKind::I64 => (64, "vpbroadcastq"),
        StoreKind::I32 => (32, "vpbroadcastd"),
        StoreKind::I16 => (16, "vpbroadcastw"),
        StoreKind::I8 => (8, "vpbroadcastb"),
        _ => return fail("VecConst: not an integer lane kind"),
    };
    let mask = u64::MAX >> (64 - bits);
    let lane = imm as u64 & mask;
    let r = wide_reg(16, rd);
    if lane == 0 {
        encode_wide(code, "vpxor", &[r, r, r])?;
    } else if lane == mask {
        let w = wide_reg(full, rd);
        encode_wide(code, "vpcmpeqd", &[w, w, w])?;
    } else if bytes == 8 && bits == 64 {
        // One lane fills the vector: `vmovq` clears the bits above it.
        super::encode::emit_mov_r_imm64(code, SCRATCH_R11, lane as i64);
        let g = Concrete::Reg {
            reg: SCRATCH_R11.0,
            size: AsmRegSize::Quad,
        };
        encode_wide(code, "vmovq", &[g, r])?;
        super::mem::mirror_fp_dst(code, dst, Reg(rd), frame);
        return Ok(());
    } else {
        super::encode::emit_mov_r_imm64(code, SCRATCH_R11, lane as i64);
        let (mov, size) = if bits == 64 {
            ("vmovq", AsmRegSize::Quad)
        } else {
            ("vmovd", AsmRegSize::Long)
        };
        let g = Concrete::Reg {
            reg: SCRATCH_R11.0,
            size,
        };
        encode_wide(code, mov, &[g, r])?;
        encode_wide(code, mnem, &[r, wide_reg(full, rd)])?;
    }
    if bytes == 8 {
        encode_wide(code, "vmovq", &[r, r])?;
        super::mem::mirror_fp_dst(code, dst, Reg(rd), frame);
    } else if bytes > 16 {
        mirror_wide_dst(code, VecWidth::of_bytes(bytes), dst, Reg(rd), frame);
    } else {
        mirror_v128_dst(code, dst, Reg(rd), frame);
    }
    Ok(())
}

/// `Inst::VecSplat`: `vpbroadcast*` of a general register moved in by
/// `vmovd` / `vmovq`, `vbroadcastss` of a float, `vmovddup` or
/// `vbroadcastsd` of a double; an 8-byte vector's upper half cleared by
/// `vmovq`.
pub(super) fn emit_vec_splat(
    code: &mut CodeBuf,
    (value, kind, bytes): (super::super::ir::ValueId, StoreKind, u8),
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use super::asm::Concrete;
    use crate::c5::ir::AsmRegSize;
    let rd = match dst {
        Place::FpReg(r) => r,
        _ => frame.fp_scratch[0],
    };
    let full = bytes.max(16);
    match kind {
        StoreKind::F32 | StoreKind::F64 => {
            let place = place_of(alloc, value);
            let Some(f) = materialize_fp(code, place, Reg(frame.fp_scratch[1]), frame) else {
                return fail("VecSplat: value has no place");
            };
            let mnem = match (kind, full) {
                (StoreKind::F32, _) => "vbroadcastss",
                (_, 16) => "vmovddup",
                _ => "vbroadcastsd",
            };
            encode_wide(code, mnem, &[wide_reg(16, f.0), wide_reg(full, rd)])?;
        }
        _ => {
            let Some(gpr) = materialize_int(code, place_of(alloc, value), SCRATCH_R11, frame)
            else {
                return fail("VecSplat: value has no place");
            };
            let (mov, size, mnem) = match kind {
                StoreKind::I64 => ("vmovq", AsmRegSize::Quad, "vpbroadcastq"),
                StoreKind::I32 => ("vmovd", AsmRegSize::Long, "vpbroadcastd"),
                StoreKind::I16 => ("vmovd", AsmRegSize::Long, "vpbroadcastw"),
                StoreKind::I8 => ("vmovd", AsmRegSize::Long, "vpbroadcastb"),
                _ => return fail("VecSplat: not a lane kind"),
            };
            let r = Concrete::Reg { reg: gpr.0, size };
            encode_wide(code, mov, &[r, wide_reg(16, rd)])?;
            encode_wide(code, mnem, &[wide_reg(16, rd), wide_reg(full, rd)])?;
        }
    }
    if bytes == 8 {
        encode_wide(code, "vmovq", &[wide_reg(16, rd), wide_reg(16, rd)])?;
        super::mem::mirror_fp_dst(code, dst, Reg(rd), frame);
    } else if bytes > 16 {
        mirror_wide_dst(code, VecWidth::of_bytes(bytes), dst, Reg(rd), frame);
    } else {
        mirror_v128_dst(code, dst, Reg(rd), frame);
    }
    Ok(())
}

/// `Inst::VecInsert`: the vector with the lane at byte `off` replaced by
/// `vpinsr*` from a general register (a float's bits moved to r11 by
/// `vmovq` / `vmovd`); a wide vector's 128-bit part is extracted, updated and
/// inserted back, as a VEX.128 write clears the bits above it.
pub(super) fn emit_vec_insert(
    code: &mut CodeBuf,
    (vec, value, off, kind, bytes): (
        super::super::ir::ValueId,
        super::super::ir::ValueId,
        u8,
        StoreKind,
        u8,
    ),
    blank: Option<bool>,
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use super::asm::Concrete;
    let (sa, sb) = (frame.fp_scratch[0], frame.fp_scratch[1]);
    let w = VecWidth::of_bytes(bytes);
    let mirror = |code: &mut CodeBuf, rd: u8| {
        if bytes > 16 {
            mirror_wide_dst(code, w, dst, Reg(rd), frame);
        } else if bytes == 8 {
            super::mem::mirror_fp_dst(code, dst, Reg(rd), frame);
        } else {
            mirror_v128_dst(code, dst, Reg(rd), frame);
        }
    };
    if kind == StoreKind::V128 {
        let Some(p) = materialize_v128(code, place_of(alloc, value), Reg(sb), frame) else {
            return fail("VecInsert: value has no place");
        };
        let rd = match dst {
            Place::FpReg(r) => r,
            _ => sa,
        };
        // The low part over a zero or undefined vector: a VEX move clears
        // the bits above it, which an undefined one leaves as they are.
        if blank.is_some() && off == 0 {
            if blank == Some(false) || p.0 != rd {
                encode_wide(code, "vmovdqa", &[wide_reg(16, p.0), wide_reg(16, rd)])?;
            }
            mirror(code, rd);
            return Ok(());
        }
        let base = match place_of(alloc, vec) {
            Place::None => rd,
            b => match materialize_wide(code, w, b, Reg(sa), frame) {
                Some(r) => r.0,
                None => return fail("VecInsert: vector has no place"),
            },
        };
        let mnem = if bytes == 64 {
            "vinserti32x4"
        } else {
            "vinserti128"
        };
        let ops = [
            Concrete::Imm(i64::from(off / 16)),
            wide_reg(16, p.0),
            wide_reg(bytes, base),
            wide_reg(bytes, rd),
        ];
        encode_wide(code, mnem, &ops)?;
        mirror(code, rd);
        return Ok(());
    }
    // Doubles in registers: the low one of each paired by `vunpcklpd`, and
    // a low one over a vector of no value is its own register.
    if kind == StoreKind::F64
        && bytes == 16
        && let Place::FpReg(v) = place_of(alloc, value)
    {
        let rd = match dst {
            Place::FpReg(r) => r,
            _ => sa,
        };
        match (off, blank, place_of(alloc, vec)) {
            (0, Some(true), _) if rd == v => {}
            (0, Some(_), _) => encode_wide(code, "vmovq", &[wide_reg(16, v), wide_reg(16, rd)])?,
            (8, _, Place::FpReg(n)) => encode_wide(
                code,
                "vunpcklpd",
                &[wide_reg(16, v), wide_reg(16, n), wide_reg(16, rd)],
            )?,
            _ => {
                return emit_vec_insert_gpr(
                    code,
                    (vec, value, off, kind, bytes),
                    blank,
                    dst,
                    alloc,
                    frame,
                );
            }
        }
        mirror(code, rd);
        return Ok(());
    }
    emit_vec_insert_gpr(
        code,
        (vec, value, off, kind, bytes),
        blank,
        dst,
        alloc,
        frame,
    )
}

/// [`emit_vec_insert`] of a scalar lane through a general register.
fn emit_vec_insert_gpr(
    code: &mut CodeBuf,
    (vec, value, off, kind, bytes): (
        super::super::ir::ValueId,
        super::super::ir::ValueId,
        u8,
        StoreKind,
        u8,
    ),
    blank: Option<bool>,
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
) -> Emit {
    use super::asm::Concrete;
    use crate::c5::ir::AsmRegSize;
    let (sa, sb) = (frame.fp_scratch[0], frame.fp_scratch[1]);
    let w = VecWidth::of_bytes(bytes);
    let q = |r: Reg, size| Concrete::Reg { reg: r.0, size };
    let mirror = |code: &mut CodeBuf, rd: u8| {
        if bytes > 16 {
            mirror_wide_dst(code, w, dst, Reg(rd), frame);
        } else if bytes == 8 {
            super::mem::mirror_fp_dst(code, dst, Reg(rd), frame);
        } else {
            mirror_v128_dst(code, dst, Reg(rd), frame);
        }
    };
    // The value into a general register first, as the result may take a
    // float value's register.
    let gpr = match kind {
        StoreKind::F32 | StoreKind::F64 => {
            let Some(f) = materialize_fp(code, place_of(alloc, value), Reg(sb), frame) else {
                return fail("VecInsert: value has no place");
            };
            let (mnem, size) = if kind == StoreKind::F64 {
                ("vmovq", AsmRegSize::Quad)
            } else {
                ("vmovd", AsmRegSize::Long)
            };
            encode_wide(code, mnem, &[wide_reg(16, f.0), q(SCRATCH_R11, size)])?;
            SCRATCH_R11
        }
        _ => match materialize_int(code, place_of(alloc, value), SCRATCH_R11, frame) {
            Some(r) => r,
            None => return fail("VecInsert: value has no place"),
        },
    };
    let rd = match dst {
        Place::FpReg(r) => r,
        _ => sa,
    };
    let (mnem, esize, size) = match kind {
        StoreKind::I64 | StoreKind::F64 => ("vpinsrq", 8, AsmRegSize::Quad),
        StoreKind::I32 | StoreKind::F32 => ("vpinsrd", 4, AsmRegSize::Long),
        StoreKind::I16 => ("vpinsrw", 2, AsmRegSize::Long),
        _ => ("vpinsrb", 1, AsmRegSize::Long),
    };
    // The low lane over a zero or undefined vector: `vmovq` / `vmovd` clear
    // the bits above it.
    if blank.is_some() && off == 0 && esize >= 4 {
        let mov = if esize == 8 { "vmovq" } else { "vmovd" };
        encode_wide(code, mov, &[q(gpr, size), wide_reg(16, rd)])?;
        mirror(code, rd);
        return Ok(());
    }
    // The base vector into the register the result forms in; an undefined
    // one leaves it as it is.
    let base = place_of(alloc, vec);
    if blank != Some(true) && !matches!(base, Place::None) {
        let got = match (w, bytes) {
            (_, 8) => materialize_fp(code, base, Reg(rd), frame),
            (VecWidth::V128, _) => materialize_v128(code, base, Reg(rd), frame),
            _ => materialize_wide(code, w, base, Reg(rd), frame),
        };
        match got {
            Some(r) if r.0 == rd => {}
            Some(r) if w == VecWidth::V128 || bytes == 8 => emit_movapd_xmm_xmm(code, Reg(rd), r),
            Some(r) => emit_wide_mov(code, w, Reg(rd), r),
            None => return fail("VecInsert: vector has no place"),
        }
    }
    let (part, loff) = lane_part(code, bytes, rd, off, sb)?;
    let ops = [
        Concrete::Imm(i64::from(loff / esize)),
        q(gpr, size),
        wide_reg(16, part),
        wide_reg(16, part),
    ];
    encode_wide(code, mnem, &ops)?;
    if bytes > 16 {
        let mnem = if bytes == 64 {
            "vinserti32x4"
        } else {
            "vinserti128"
        };
        let ops = [
            Concrete::Imm(i64::from(off / 16)),
            wide_reg(16, part),
            wide_reg(bytes, rd),
            wide_reg(bytes, rd),
        ];
        encode_wide(code, mnem, &ops)?;
    }
    mirror(code, rd);
    Ok(())
}
