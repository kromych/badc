//! The AArch64 rows of the SIMD tables ([`crate::c5::aarch64_simd`]): the
//! walker's form, which reads its vector operands through their addresses
//! and writes the result through the destination's, and the form
//! `simd_values` makes of it, whose operands are values in v registers. A
//! row's instruction is encoded by the assembler's table over the row's
//! arrangement.

use super::*;
use crate::c5::ir::ValueId;
use crate::c5::simd::{self, Form, SimdOp};

/// The instruction a row names over v registers `regs`, destination first.
fn encode(row: &SimdOp, regs: &[u8]) -> Result<u32, alloc::string::String> {
    use super::table::{self, Opnd};
    let size = row.ret.lane_bytes().trailing_zeros() as u8;
    let q = row.bytes == 16;
    // One 64-bit lane is the scalar form on the D view.
    let scalar = size == 3 && !q;
    let ops: Vec<Opnd> = regs
        .iter()
        .map(|&num| match scalar {
            true => Opnd::VReg { num, is_d: true },
            false => Opnd::VecReg { num, size, q },
        })
        .collect();
    table::encode(row.mnem, &ops)
}

/// `Inst::Simd`: the operands loaded from their addresses into the FP
/// scratches, the instruction, and the result stored through the
/// destination address.
pub(super) fn emit_a64_simd(
    code: &mut Vec<u8>,
    op: u32,
    args: &[ValueId],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    let row = simd::get(op);
    if row.form != Form::Vv || args.len() != 3 {
        return fail(alloc::format!(
            "{}: no AArch64 lowering of its form",
            row.name
        ));
    }
    let (vd, vm) = (frame.fp_scratch[0], frame.fp_scratch[1]);
    let transfer = |code: &mut Vec<u8>, addr: ValueId, v: u8, load: bool| -> Emit {
        let Some(rn) = materialize_int(code, place_of(alloc, addr), scratch.primary, frame) else {
            return fail(alloc::format!(
                "{}: operand address not int reg / spill",
                row.name
            ));
        };
        emit(
            code,
            match (row.bytes, load) {
                (16, true) => enc_ldr_q_imm(v, rn, 0),
                (16, false) => enc_str_q_imm(v, rn, 0),
                (_, true) => enc_ldr_d_imm(v, rn, 0),
                (_, false) => enc_str_d_imm(v, rn, 0),
            },
        );
        Ok(())
    };
    transfer(code, args[1], vd, true)?;
    transfer(code, args[2], vm, true)?;
    match encode(row, &[vd, vd, vm]) {
        Ok(word) => emit(code, word),
        Err(e) => return fail(alloc::format!("{}: {e}", row.name)),
    }
    transfer(code, args[0], vd, false)
}

/// `Inst::SimdVal`: the instruction on the operands' v registers, the
/// result defined in the destination's.
pub(super) fn emit_a64_simd_val(
    code: &mut Vec<u8>,
    op: u32,
    args: &[ValueId],
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    let row = simd::get(op);
    if row.form != Form::Vv || args.len() != 2 {
        return fail(alloc::format!(
            "{}: no AArch64 lowering of its form",
            row.name
        ));
    }
    let Some(vd) = fp_or_spill_dst(dst, frame) else {
        return fail(alloc::format!("{}: dst not fp reg / spill", row.name));
    };
    let mut regs = [vd, 0, 0];
    for (k, &a) in args.iter().enumerate() {
        let tmp = frame.fp_scratch[k];
        let reg = if row.bytes == 16 {
            materialize_v128(code, place_of(alloc, a), tmp, frame, scratch.primary)
        } else {
            materialize_fp(code, place_of(alloc, a), tmp, frame)
        };
        let Some(reg) = reg else {
            return fail(alloc::format!("{}: operand not fp reg / spill", row.name));
        };
        regs[k + 1] = reg;
    }
    match encode(row, &regs) {
        Ok(word) => emit(code, word),
        Err(e) => return fail(alloc::format!("{}: {e}", row.name)),
    }
    if row.bytes == 16 {
        propagate_v128(code, frame, dst, vd, scratch.primary);
    } else {
        store_spilled_fp(code, frame, dst, vd);
    }
    Ok(())
}
