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
/// an immediate: a shift count, or `ext`'s byte position.
fn sources(row: &SimdOp) -> Option<(usize, bool)> {
    match row.form {
        Form::V => Some((1, false)),
        Form::Vv => Some((2, false)),
        Form::Vvv => Some((3, false)),
        Form::Shift => Some((1, true)),
        Form::VvI => Some((2, true)),
        Form::VvvI if row.base_sem() != row.sem => Some((3, true)),
        Form::VI => Some((1, true)),
        _ => None,
    }
}

/// Whether the instruction computes in the register of the row's first
/// source: the three-operand forms but the four-register `eor3` and
/// `bcax`, the accumulating and inserting shifts by an immediate, the AES
/// rounds, the two-operand schedule updates and the pairwise accumulations.
fn accumulates(row: &SimdOp) -> bool {
    use simd::Sem;
    match row.sem {
        Sem::Eor3 | Sem::Bcax => false,
        Sem::ShrAcc(..)
        | Sem::ShiftInsert(..)
        | Sem::AesRound(_)
        | Sem::Sha256Su0
        | Sem::Sha1Su1
        | Sem::Sha512Su0
        | Sem::PairAddLongAcc(..)
        | Sem::SatAccMixed(..) => true,
        _ => matches!(row.form, Form::Vvv | Form::VvvI),
    }
}

/// The instruction a row names over v registers `regs`, destination first,
/// each in its operand's arrangement, with a shift's count. An
/// accumulating form names its accumulator once, as the destination. A
/// by-element row names its last register's lane `imm`, or without one
/// is the vector form over that register, which holds the lane in every
/// lane.
fn encode(row: &SimdOp, regs: &[u8], imm: Option<u8>) -> Result<u32, alloc::string::String> {
    use super::table::{self, Opnd};
    // A table lookup names its table as a one-register list.
    if let crate::c5::simd::Sem::Tbl(bytes) | crate::c5::simd::Sem::Tbx(bytes) = row.sem {
        let (rd, rt, rm) = match regs {
            [rd, rt, rm] => (*rd, *rt, *rm),
            _ => return Err(alloc::format!("{}: three registers expected", row.name)),
        };
        let index = |num| Opnd::VecReg {
            num,
            size: 0,
            q: bytes == 16,
        };
        let table = Opnd::VecList {
            first: rt,
            count: 1,
            size: 0,
            q: true,
        };
        return table::encode(row.mnem, &[index(rd), table, index(rm)]);
    }
    // A 64-bit polynomial product names its 128-bit lane `.1q` and its
    // sources' 64-bit lanes as vectors, the `2` form the upper ones.
    if let (
        crate::c5::simd::Sem::Long(crate::c5::simd::LongOp::PolyMul, 8, _, high),
        [rd, rn, rm],
    ) = (row.sem, regs)
    {
        let v = |num, size, q| Opnd::VecReg { num, size, q };
        return table::encode(
            row.mnem,
            &[v(*rd, 4, true), v(*rn, 3, high), v(*rm, 3, high)],
        );
    }
    // The SHA-1 hash names its state as a q register and `e` as an s one.
    if let (crate::c5::simd::Sem::Sha1Hash(_), [rd, rn, rm]) = (row.sem, regs) {
        let w = Opnd::VecReg {
            num: *rm,
            size: 2,
            q: true,
        };
        let e = Opnd::VReg {
            num: *rn,
            is_d: false,
        };
        return table::encode(row.mnem, &[Opnd::QReg(*rd), e, w]);
    }
    // The SHA-256 and SHA-512 hashes name their state halves as q registers.
    if let (
        crate::c5::simd::Sem::Sha256Hash(_) | crate::c5::simd::Sem::Sha512Hash(_),
        [rd, rn, rm],
    ) = (row.sem, regs)
    {
        let w = Opnd::VecReg {
            num: *rm,
            size: row.ret.lane_bytes().trailing_zeros() as u8,
            q: true,
        };
        return table::encode(row.mnem, &[Opnd::QReg(*rd), Opnd::QReg(*rn), w]);
    }
    // `dup` names its source lane in the operand: `vN.T[index]`.
    if let (crate::c5::simd::Sem::DupLane(w), [rd, rn], Some(index)) = (row.sem, regs, imm) {
        let (lane, bytes) = row.arrangement(0);
        let ops = [
            Opnd::VecReg {
                num: *rd,
                size: lane.trailing_zeros() as u8,
                q: bytes == 16,
            },
            Opnd::VecElem {
                num: *rn,
                size: w.trailing_zeros() as u8,
                index,
            },
        ];
        return table::encode(row.mnem, &ops);
    }
    let skip = usize::from(accumulates(row));
    let mut ops: Vec<Opnd> = regs
        .iter()
        .enumerate()
        .map(|(k, &num)| {
            let (lane, bytes) = row.arrangement(if k == 0 { 0 } else { k + skip });
            let size = lane.trailing_zeros() as u8;
            // One lane is the scalar view of its width: the scalar form
            // over a 64-bit lane, or a reduction's destination; a pairwise
            // long sum into one 64-bit lane is the vector form `.1d`.
            if row.scalar_only() {
                return Opnd::VReg {
                    num,
                    is_d: size == 3,
                };
            }
            let pairwise = matches!(
                row.sem,
                crate::c5::simd::Sem::PairAddLong(..) | crate::c5::simd::Sem::PairAddLongAcc(..)
            );
            match (size, bytes) {
                (3, 8) if !pairwise => Opnd::VReg { num, is_d: true },
                (0 | 1, b) if b == lane => Opnd::VScalar { num, size },
                (2, 4) => Opnd::VReg { num, is_d: false },
                _ => Opnd::VecReg {
                    num,
                    size,
                    q: bytes == 16,
                },
            }
        })
        .collect();
    if let crate::c5::simd::Sem::ByElement(_, w) = row.sem {
        let (Some(&Opnd::VecReg { num, .. } | &Opnd::VReg { num, .. }), Some(data)) =
            (ops.last(), ops.len().checked_sub(2).map(|k| ops[k]))
        else {
            return Err(alloc::format!("{}: two vector sources expected", row.name));
        };
        let last = ops.len() - 1;
        ops[last] = match (imm, data) {
            (Some(index), _) => Opnd::VecElem {
                num,
                size: w.trailing_zeros() as u8,
                index,
            },
            (None, Opnd::VecReg { size, q, .. }) => Opnd::VecReg { num, size, q },
            (None, Opnd::VReg { is_d, .. }) => Opnd::VReg { num, is_d },
            (None, _) => return Err(alloc::format!("{}: no vector form", row.name)),
        };
        return table::encode(row.mnem, &ops);
    }
    ops.extend(imm.map(|n| Opnd::Imm(i64::from(n))));
    if row.compares_with_zero() {
        ops.push(Opnd::Imm(0));
    }
    table::encode(row.mnem, &ops)
}

/// A halfword element's register is four bits wide: one from v16 up has
/// its lane broadcast into `scratch`, and the by-element row then takes
/// its vector form over it (`encode` without an index). Returns the
/// register and index to encode.
fn halfword_element(
    code: &mut Vec<u8>,
    row: &SimdOp,
    reg: u8,
    imm: Option<u8>,
    scratch: u8,
) -> Result<(u8, Option<u8>), alloc::string::String> {
    use super::table::{self, Opnd};
    match (row.sem, imm) {
        (simd::Sem::ByElement(_, 2), Some(index)) if reg > 15 => {
            let ops = [
                Opnd::VecReg {
                    num: scratch,
                    size: 1,
                    q: true,
                },
                Opnd::VecElem {
                    num: reg,
                    size: 1,
                    index,
                },
            ];
            emit(code, table::encode("dup", &ops)?);
            Ok((scratch, None))
        }
        _ => Ok((reg, imm)),
    }
}

/// A shift's count: the constant the parser folded. The instructions take
/// no register count.
fn count(row: &SimdOp, imm: Option<u8>, shift: bool) -> Result<Option<u8>, alloc::string::String> {
    match (shift, imm) {
        (false, _) => Ok(None),
        (true, Some(n)) => Ok(Some(n)),
        (true, None) => Err(alloc::format!(
            "{}: the immediate must be a constant",
            row.name
        )),
    }
}

/// `Inst::Simd`: the operands loaded from their addresses into the FP
/// scratches, the instruction on the first, which holds an accumulator,
/// and the result stored through the destination address.
pub(super) fn emit_a64_simd(
    code: &mut CodeBuf,
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
    let transfer = |code: &mut CodeBuf, addr: ValueId, v: u8, (bytes, load): (u8, bool)| -> Emit {
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
    let mut regs = [0u8; 3];
    regs[..n].copy_from_slice(&frame.fp_scratch[..n]);
    for (k, &v) in regs[..n].iter().enumerate() {
        transfer(code, args[k + 1], v, (row.arg_bytes(k), true))?;
    }
    let imm = match halfword_element(code, row, regs[n - 1], imm, regs[n - 1]) {
        Ok((_, imm)) => imm,
        Err(e) => return fail(alloc::format!("{}: {e}", row.name)),
    };
    // An accumulating form writes its first source; the others write a
    // destination of their own, the first scratch.
    let mut ops = alloc::vec![frame.fp_scratch[0]];
    ops.extend(if accumulates(row) {
        &regs[1..n]
    } else {
        &regs[..n]
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
    code: &mut CodeBuf,
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
    let imm = match halfword_element(code, row, regs[n - 1], imm, frame.fp_scratch[n - 1]) {
        Ok((reg, imm)) => {
            regs[n - 1] = reg;
            imm
        }
        Err(e) => return fail(alloc::format!("{}: {e}", row.name)),
    };
    let mut ops = alloc::vec![vd];
    let mut acc = vd;
    if accumulates(row) {
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
