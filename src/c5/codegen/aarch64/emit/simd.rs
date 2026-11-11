//! The AArch64 rows of the SIMD tables ([`crate::c5::aarch64_simd`]): the
//! walker's form, which reads its vector operands through their addresses
//! and writes the result through the destination's, and the form
//! `simd_values` makes of it, whose operands are values in v registers. A
//! row's instruction is encoded by the assembler's table over the row's
//! arrangement; a shift's constant count is its immediate, and an
//! accumulating form computes in the register that holds its accumulator.

use super::*;
use crate::c5::ir::ValueId;
use crate::c5::simd::{self, Form, SimdOp};

/// The vector operands a row's form reads, and whether its last operand is
/// a shift count.
fn sources(row: &SimdOp) -> Option<(usize, bool)> {
    match row.form {
        Form::V => Some((1, false)),
        Form::Vv => Some((2, false)),
        Form::Vvv => Some((3, false)),
        Form::Shift => Some((1, true)),
        _ => None,
    }
}

/// The instruction a row names over v registers `regs`, destination first,
/// each in its operand's arrangement, with a shift's count. An
/// accumulating form names its accumulator once, as the destination.
fn encode(row: &SimdOp, regs: &[u8], imm: Option<u8>) -> Result<u32, alloc::string::String> {
    use super::table::{self, Opnd};
    let skip = usize::from(row.form == Form::Vvv);
    let mut ops: Vec<Opnd> = regs
        .iter()
        .enumerate()
        .map(|(k, &num)| {
            let (lane, bytes) = row.arrangement(if k == 0 { 0 } else { k + skip });
            let size = lane.trailing_zeros() as u8;
            // One 64-bit lane is the scalar form on the D view.
            match (size, bytes) {
                (3, 8) => Opnd::VReg { num, is_d: true },
                _ => Opnd::VecReg {
                    num,
                    size,
                    q: bytes == 16,
                },
            }
        })
        .collect();
    ops.extend(imm.map(|n| Opnd::Imm(i64::from(n))));
    table::encode(row.mnem, &ops)
}

/// A shift's count: the constant the parser folded. The instructions take
/// no register count.
fn count(row: &SimdOp, imm: Option<u8>, shift: bool) -> Result<Option<u8>, alloc::string::String> {
    match (shift, imm) {
        (false, _) => Ok(None),
        (true, Some(n)) => Ok(Some(n)),
        (true, None) => Err(alloc::format!("{}: the count must be a constant", row.name)),
    }
}

/// `Inst::Simd`: the operands loaded from their addresses into the FP
/// scratches, the instruction on the first, which holds an accumulator,
/// and the result stored through the destination address.
pub(super) fn emit_a64_simd(
    code: &mut Vec<u8>,
    (op, imm): (u32, Option<u8>),
    args: &[ValueId],
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    let row = simd::get(op);
    let Some((n, shift)) = sources(row) else {
        return fail(alloc::format!(
            "{}: no AArch64 lowering of its form",
            row.name
        ));
    };
    let imm = match count(row, imm, shift) {
        Ok(imm) => imm,
        Err(e) => return fail(e),
    };
    if args.len() < n + 1 {
        return fail(alloc::format!("{}: expects {n} operands", row.name));
    }
    let transfer = |code: &mut Vec<u8>, addr: ValueId, v: u8, (bytes, load): (u8, bool)| -> Emit {
        let Some(rn) = materialize_int(code, place_of(alloc, addr), scratch.primary, frame) else {
            return fail(alloc::format!(
                "{}: operand address not int reg / spill",
                row.name
            ));
        };
        emit(
            code,
            match (bytes, load) {
                (16, true) => enc_ldr_q_imm(v, rn, 0),
                (16, false) => enc_str_q_imm(v, rn, 0),
                (_, true) => enc_ldr_d_imm(v, rn, 0),
                (_, false) => enc_str_d_imm(v, rn, 0),
            },
        );
        Ok(())
    };
    let regs = &frame.fp_scratch[..n];
    for (k, &v) in regs.iter().enumerate() {
        transfer(code, args[k + 1], v, (row.arg_bytes(k), true))?;
    }
    // An accumulating form writes its first source; the others write a
    // destination of their own, the first scratch.
    let mut ops = alloc::vec![frame.fp_scratch[0]];
    ops.extend(if row.form == Form::Vvv {
        &regs[1..]
    } else {
        regs
    });
    match encode(row, &ops, imm) {
        Ok(word) => emit(code, word),
        Err(e) => return fail(alloc::format!("{}: {e}", row.name)),
    }
    transfer(code, args[0], frame.fp_scratch[0], (row.ret_bytes(), false))
}

/// `Inst::SimdVal`: the instruction on the operands' v registers, the
/// result defined in the destination's. An accumulating form copies its
/// accumulator into the destination first, or computes in the first
/// scratch when the destination holds one of its other operands.
pub(super) fn emit_a64_simd_val(
    code: &mut Vec<u8>,
    (op, imm): (u32, Option<u8>),
    args: &[ValueId],
    dst: Place,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    let row = simd::get(op);
    let Some((n, shift)) = sources(row) else {
        return fail(alloc::format!(
            "{}: no AArch64 lowering of its form",
            row.name
        ));
    };
    let imm = match count(row, imm, shift) {
        Ok(imm) => imm,
        Err(e) => return fail(e),
    };
    if args.len() < n {
        return fail(alloc::format!("{}: expects {n} operands", row.name));
    }
    let Some(vd) = fp_or_spill_dst(dst, frame) else {
        return fail(alloc::format!("{}: dst not fp reg / spill", row.name));
    };
    let mut regs = [0u8; 3];
    for k in 0..n {
        let tmp = frame.fp_scratch[k];
        let reg = if row.arg_bytes(k) == 16 {
            materialize_v128(code, place_of(alloc, args[k]), tmp, frame, scratch.primary)
        } else {
            materialize_fp(code, place_of(alloc, args[k]), tmp, frame)
        };
        let Some(reg) = reg else {
            return fail(alloc::format!("{}: operand not fp reg / spill", row.name));
        };
        regs[k] = reg;
    }
    let mut ops = alloc::vec![vd];
    let mut acc = vd;
    if row.form == Form::Vvv {
        if regs[1..n].contains(&vd) {
            acc = frame.fp_scratch[0];
            ops[0] = acc;
        }
        if regs[0] != acc {
            emit(code, enc_mov_v16b(acc, regs[0]));
        }
        ops.extend(&regs[1..n]);
    } else {
        ops.extend(&regs[..n]);
    }
    match encode(row, &ops, imm) {
        Ok(word) => emit(code, word),
        Err(e) => return fail(alloc::format!("{}: {e}", row.name)),
    }
    if acc != vd {
        emit(code, enc_mov_v16b(vd, acc));
    }
    if row.ret_bytes() == 16 {
        propagate_v128(code, frame, dst, vd, scratch.primary);
    } else {
        store_spilled_fp(code, frame, dst, vd);
    }
    Ok(())
}
