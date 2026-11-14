//! SVE values in registers: whole Z and P transfers, the predicate moves of
//! a phi edge, and the VL-scaled region holding their slots. The region lies
//! below the static frame, reserved with `addvl`: the predicate slots, eight
//! to a vector length, then the vector slots, each at `[base, #-k, mul vl]`
//! from the static frame's bottom (`fp - frame_bytes`, or x19).

use super::super::ssa::sve_alloc::{PRED_HOLD, PRED_STAGE, PredPlace};
use super::*;

/// `ldr` / `str` of a whole Z (`vector`) or P register at
/// `[n, #imm, mul vl]`.
pub(super) fn enc_sve_mem(load: bool, vector: bool, t: u8, n: Reg, imm: i32) -> u32 {
    let base = match (load, vector) {
        (true, true) => 0x8580_4000,
        (false, true) => 0xE580_4000,
        (true, false) => 0x8580_0000,
        (false, false) => 0xE580_0000,
    };
    let imm = (imm as u32) & 0x1FF;
    base | (imm >> 3) << 16 | (imm & 7) << 10 | u32::from(n.0) << 5 | u32::from(t)
}

/// `mov zd.d, zn.d`, the unpredicated ORR of `zn` with itself.
pub(super) fn enc_mov_z(d: u8, n: u8) -> u32 {
    0x0460_3000 | u32::from(n) << 16 | u32::from(n) << 5 | u32::from(d)
}

/// `mov pd.b, pn.b`, the ORR of `pn` with itself under `pn`.
pub(super) fn enc_mov_p(d: u8, n: u8) -> u32 {
    let n = u32::from(n);
    0x2580_4000 | n << 16 | n << 10 | n << 5 | u32::from(d)
}

/// `addvl xd|sp, xn|sp, #imm`.
fn enc_addvl(d: Reg, n: Reg, imm: i32) -> u32 {
    0x0420_5000 | u32::from(n.0) << 16 | ((imm as u32) & 0x3F) << 5 | u32::from(d.0)
}

/// Reserve the VL-scaled region in steps of at most 3840 bytes (15 vector
/// lengths of 2048 bits), each probed when the region can pass the margin.
pub(super) fn emit_vl_region(code: &mut Vec<u8>, frame: Frame) {
    let mut left = frame.sve_region_vls();
    let probe = left * MAX_VL_BYTES > MAX_UNPROBED_STACK_STEP;
    while left > 0 {
        let step = left.min(MAX_UNPROBED_STACK_STEP / MAX_VL_BYTES);
        emit(code, enc_addvl(Reg::SP, Reg::SP, -(step as i32)));
        if probe {
            emit_stack_probe(code);
        }
        left -= step;
    }
}

const MAX_VL_BYTES: u32 = 256;

/// The region's base: x19 where it holds it, else `t`.
fn region_base(code: &mut Vec<u8>, frame: Frame, t: Reg) -> Reg {
    if frame.local_base {
        return Reg(19);
    }
    emit_fp_minus_off(code, t, frame.frame_bytes);
    t
}

/// Load or store Z register `z` at vector slot `slot`; `t` takes the base.
pub(super) fn z_slot(code: &mut Vec<u8>, frame: Frame, load: bool, z: u8, slot: u32, t: Reg) {
    let lengths = frame.sve_p_slots.div_ceil(8) + slot + 1;
    let (base, imm) = slot_base(code, frame, t, true, lengths);
    emit(code, enc_sve_mem(load, true, z, base, imm));
}

/// [`z_slot`] for P register `p` and predicate slot `slot`.
pub(super) fn p_slot(code: &mut Vec<u8>, frame: Frame, load: bool, p: u8, slot: u32, t: Reg) {
    let (base, imm) = slot_base(code, frame, t, false, slot + 1);
    emit(code, enc_sve_mem(load, false, p, base, imm));
}

/// The base and offset of the slot `lengths` vector (or predicate) lengths
/// below the region's base: past the 9-bit offset's reach, `t` steps down
/// 32 lengths at a time with `addvl` (`addpl`).
fn slot_base(code: &mut Vec<u8>, frame: Frame, t: Reg, vector: bool, lengths: u32) -> (Reg, i32) {
    let mut base = region_base(code, frame, t);
    let mut left = lengths;
    while left > 256 {
        let step = (left - 256).min(32);
        // ADDPL differs from ADDVL in bit 22.
        let pl = if vector { 0 } else { 0x0040_0000 };
        emit(code, enc_addvl(t, base, -(step as i32)) | pl);
        (base, left) = (t, left - step);
    }
    (base, -(left as i32))
}

/// An SVE vector's copy between FP-file places; x16 takes the base.
pub(super) fn emit_z_copy(code: &mut Vec<u8>, src: Place, dst: Place, frame: Frame) -> Emit {
    match (src, dst) {
        (Place::FpReg(s), Place::FpReg(d)) => emit(code, enc_mov_z(d, s)),
        (Place::FpReg(s), Place::Spill(k)) => z_slot(code, frame, false, s, k, Reg(16)),
        (Place::Spill(k), Place::FpReg(d)) => z_slot(code, frame, true, d, k, Reg(16)),
        (Place::Spill(j), Place::Spill(k)) => {
            let z = frame.fp_scratch[0];
            z_slot(code, frame, true, z, j, Reg(16));
            z_slot(code, frame, false, z, k, Reg(16));
        }
        _ => return fail("SVE vector copy: place not of the FP file"),
    }
    Ok(())
}

/// An SVE load or store at `args[0]`. A spilled vector passes through the
/// FP scratch register's Z view, a spilled predicate through p15.
pub(super) fn emit_sve_access(
    code: &mut CodeBuf,
    intrinsic: crate::c5::op::Intrinsic,
    (args, v, dst): (&[u32], u32, Place),
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    use crate::c5::op::Intrinsic as I;
    let Some(&addr) = args.first() else {
        return fail("SVE access: no address");
    };
    let Some(a) = materialize_int(code, place_of(alloc, addr), scratch.primary, frame) else {
        return fail("SVE access: address not int reg / spill");
    };
    let t = scratch.secondary;
    let z = frame.fp_scratch[0];
    let pred = |w: u32| alloc.sve.pred_place(w);
    match (intrinsic, args.get(1).copied()) {
        (I::SveLoadZ, None) => {
            let r = match dst {
                Place::FpReg(r) => r,
                Place::Spill(_) => z,
                _ => return fail("SveLoadZ: dst not fp reg / spill"),
            };
            emit(code, enc_sve_mem(true, true, r, a, 0));
            if let Place::Spill(k) = dst {
                z_slot(code, frame, false, r, k, t);
            }
        }
        (I::SveStoreZ, Some(value)) => {
            let r = match place_of(alloc, value) {
                Place::FpReg(r) => r,
                Place::Spill(k) => {
                    z_slot(code, frame, true, z, k, t);
                    z
                }
                _ => return fail("SveStoreZ: value not fp reg / spill"),
            };
            emit(code, enc_sve_mem(false, true, r, a, 0));
        }
        (I::SveLoadP, None) => {
            let p = match pred(v) {
                Some(PredPlace::Reg(r)) => r,
                Some(PredPlace::Slot(_)) => PRED_STAGE,
                None => return fail("SveLoadP: no predicate place"),
            };
            emit(code, enc_sve_mem(true, false, p, a, 0));
            if let Some(PredPlace::Slot(j)) = pred(v) {
                p_slot(code, frame, false, p, j, t);
            }
        }
        (I::SveStoreP, Some(value)) => {
            let p = match pred(value) {
                Some(PredPlace::Reg(r)) => r,
                Some(PredPlace::Slot(j)) => {
                    p_slot(code, frame, true, PRED_STAGE, j, t);
                    PRED_STAGE
                }
                None => return fail("SveStoreP: value has no predicate place"),
            };
            emit(code, enc_sve_mem(false, false, p, a, 0));
        }
        _ => return fail("SVE access: operands"),
    }
    Ok(())
}

/// Sequentialize a phi edge's parallel predicate moves: a move whose target
/// no other move reads goes first; a cycle parks one source in p14.
pub(super) fn schedule_pred_moves(
    code: &mut Vec<u8>,
    frame: Frame,
    moves: &mut Vec<(PredPlace, PredPlace)>,
) {
    moves.retain(|(s, t)| s != t);
    while !moves.is_empty() {
        let mut progress = false;
        let mut i = 0;
        while i < moves.len() {
            let (s, t) = moves[i];
            if moves.iter().any(|&(o, _)| o == t) {
                i += 1;
                continue;
            }
            pred_move(code, frame, s, t);
            moves.swap_remove(i);
            progress = true;
        }
        if !progress {
            let (cyc, hold) = (moves[0].0, PredPlace::Reg(PRED_HOLD));
            pred_move(code, frame, cyc, hold);
            for m in moves.iter_mut().filter(|m| m.0 == cyc) {
                m.0 = hold;
            }
        }
    }
}

fn pred_move(code: &mut Vec<u8>, frame: Frame, src: PredPlace, dst: PredPlace) {
    let t = Reg(16);
    match (src, dst) {
        (PredPlace::Reg(s), PredPlace::Reg(d)) => emit(code, enc_mov_p(d, s)),
        (PredPlace::Reg(s), PredPlace::Slot(j)) => p_slot(code, frame, false, s, j, t),
        (PredPlace::Slot(j), PredPlace::Reg(d)) => p_slot(code, frame, true, d, j, t),
        (PredPlace::Slot(i), PredPlace::Slot(j)) => {
            p_slot(code, frame, true, PRED_STAGE, i, t);
            p_slot(code, frame, false, PRED_STAGE, j, t);
        }
    }
}
