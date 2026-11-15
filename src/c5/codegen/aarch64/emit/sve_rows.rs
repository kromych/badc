//! The SVE rows of the SIMD tables ([`crate::c5::aarch64_sve`]) on values in
//! Z and P registers: each row's instruction over its lanes, a governing
//! predicate in p0-p6 or reloaded into p7, a spilled vector reloaded into the
//! FP scratch, and a result bound for a slot computed in the scratch.

use super::super::ssa::sve_alloc::{PRED_HOLD, PRED_STAGE, PredPlace};
use super::table::{self, Opnd};
use super::*;
use crate::c5::simd::{self, Form, SvePred, SveShape};

/// The operands of one row: the allocation and the scratch it reloads into.
struct Operands<'a> {
    alloc: &'a Allocation,
    frame: Frame,
    scratch: &'a ScratchPool,
}

impl Operands<'_> {
    /// The Z register of vector `v`, a spilled one reloaded into FP scratch `k`.
    fn z(&self, code: &mut Vec<u8>, v: u32, k: usize) -> Emit<u8> {
        match place_of(self.alloc, v) {
            Place::FpReg(r) => Ok(r),
            Place::Spill(s) => {
                let t = self.frame.fp_scratch[k];
                super::sve::z_slot(code, self.frame, true, t, s, Reg(16));
                Ok(t)
            }
            _ => fail("SVE row: vector operand not fp reg / spill"),
        }
    }

    /// The register a governing predicate `v` is read in: its own, of
    /// p0-p6, else p7, which a reload or a move fills.
    fn governing(&self, code: &mut Vec<u8>, v: u32) -> Emit<u8> {
        match self.alloc.sve.pred_place(v) {
            Some(PredPlace::Reg(r)) if r < 8 => Ok(r),
            Some(p) => {
                super::sve::pred_move(code, self.frame, p, PredPlace::Reg(PRED_STAGE));
                Ok(PRED_STAGE)
            }
            None => fail("SVE row: governing predicate has no place"),
        }
    }

    /// The P register predicate result `v` is computed in, and the slot it
    /// goes to after.
    fn pred_dst(&self, v: u32) -> Emit<(u8, Option<u32>)> {
        match self.alloc.sve.pred_place(v) {
            Some(PredPlace::Reg(r)) => Ok((r, None)),
            Some(PredPlace::Slot(j)) => Ok((PRED_HOLD, Some(j))),
            None => fail("SVE row: predicate result has no place"),
        }
    }

    fn pred_done(&self, code: &mut Vec<u8>, (p, slot): (u8, Option<u32>)) {
        if let Some(j) = slot {
            super::sve::pred_move(code, self.frame, PredPlace::Reg(p), PredPlace::Slot(j));
        }
    }

    /// The Z register vector result `dst` is computed in: its own, or the
    /// first FP scratch for a slot.
    fn z_dst(&self, dst: Place) -> Emit<u8> {
        match dst {
            Place::FpReg(r) => Ok(r),
            Place::Spill(_) => Ok(self.frame.fp_scratch[0]),
            _ => fail("SVE row: vector result not fp reg / spill"),
        }
    }

    fn z_done(&self, code: &mut Vec<u8>, dst: Place, r: u8) {
        if let Place::Spill(s) = dst {
            super::sve::z_slot(code, self.frame, false, r, s, Reg(16));
        }
    }

    /// The general register of integer `v`, reloaded into `into` when spilled.
    fn x(&self, code: &mut CodeBuf, v: u32, into: Reg) -> Emit<Reg> {
        match materialize_int(code, place_of(self.alloc, v), into, self.frame) {
            Some(r) => Ok(r),
            None => fail("SVE row: integer operand not int reg / spill"),
        }
    }
}

fn z(num: u8, size: u8) -> Opnd {
    Opnd::ZReg {
        num,
        size: Some(size),
    }
}

fn word(code: &mut Vec<u8>, mnem: &str, ops: &[Opnd]) -> Emit {
    match table::encode(mnem, ops) {
        Ok(w) => {
            emit(code, w);
            Ok(())
        }
        Err(e) => fail(alloc::format!("SVE row `{mnem}`: {e}")),
    }
}

/// `Inst::SimdVal` of an SVE row, defining `v` in `dst`.
pub(super) fn emit_row(
    code: &mut CodeBuf,
    (op, imm): (u32, Option<u8>),
    args: &[u32],
    (v, dst): (u32, Place),
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    let row = simd::get(op);
    let Form::Sve(form) = row.form else {
        return fail("SVE row: not an SVE form");
    };
    if args.len() < row.form.arity() {
        return fail(alloc::format!("{}: operands missing", row.name));
    }
    let o = Operands {
        alloc,
        frame,
        scratch,
    };
    let size = row.int_width.trailing_zeros() as u8;
    let pattern = Opnd::SvePattern(imm.unwrap_or(31));
    match form.shape {
        SveShape::Binary(mode) => binary(code, row.mnem, mode, size, args, dst, &o),
        SveShape::Compare => {
            let pg = o.governing(code, args[0])?;
            let (a, b) = (o.z(code, args[1], 0)?, o.z(code, args[2], 1)?);
            let pd = o.pred_dst(v)?;
            let pgz = Opnd::PRegQ {
                num: pg,
                merge: false,
            };
            let p = Opnd::PReg {
                num: pd.0,
                size: Some(size),
            };
            word(code, row.mnem, &[p, pgz, z(a, size), z(b, size)])?;
            o.pred_done(code, pd);
            Ok(())
        }
        SveShape::PTrue => {
            let pd = o.pred_dst(v)?;
            let p = Opnd::PReg {
                num: pd.0,
                size: Some(size),
            };
            word(code, "ptrue", &[p, pattern])?;
            o.pred_done(code, pd);
            Ok(())
        }
        SveShape::While { bits, .. } => {
            let a = o.x(code, args[0], scratch.primary)?;
            let b = o.x(code, args[1], scratch.secondary)?;
            let pd = o.pred_dst(v)?;
            let r = |num: Reg| Opnd::Reg {
                num: num.0,
                is64: bits == 64,
                sp: false,
            };
            let p = Opnd::PReg {
                num: pd.0,
                size: Some(size),
            };
            word(code, row.mnem, &[p, r(a), r(b)])?;
            o.pred_done(code, pd);
            Ok(())
        }
        SveShape::Count => {
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("SVE count: dst not int reg / spill");
            };
            let r = Opnd::Reg {
                num: rd.0,
                is64: true,
                sp: false,
            };
            word(code, row.mnem, &[r, pattern])?;
            store_spilled_int(code, frame, dst, rd);
            Ok(())
        }
        SveShape::Reduce => {
            let pg = o.governing(code, args[0])?;
            let a = o.z(code, args[1], 0)?;
            let p = Opnd::PReg {
                num: pg,
                size: None,
            };
            let float = form.elems == simd::SveElems::Float;
            let vd = match dst {
                Place::FpReg(r) if float => r,
                _ => frame.fp_scratch[1],
            };
            let is_d = !float || size == 3;
            word(
                code,
                row.mnem,
                &[Opnd::VReg { num: vd, is_d }, p, z(a, size)],
            )?;
            if float {
                store_spilled_fp(code, frame, dst, vd);
                return Ok(());
            }
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("SVE sum: dst not int reg / spill");
            };
            emit(code, enc_fmov_d_to_x(rd, vd));
            store_spilled_int(code, frame, dst, rd);
            Ok(())
        }
        SveShape::Dup => {
            let d = o.z_dst(dst)?;
            if form.elems == simd::SveElems::Float {
                let Some(s) =
                    materialize_fp(code, place_of(alloc, args[0]), frame.fp_scratch[1], frame)
                else {
                    return fail("SVE dup: scalar not fp reg / spill");
                };
                let e = Opnd::ZElem {
                    num: s,
                    size,
                    index: 0,
                };
                word(code, "dup", &[z(d, size), e])?;
            } else {
                let x = o.x(code, args[0], scratch.primary)?;
                let r = Opnd::Reg {
                    num: x.0,
                    is64: size == 3,
                    sp: false,
                };
                word(code, "dup", &[z(d, size), r])?;
            }
            o.z_done(code, dst, d);
            Ok(())
        }
        SveShape::Load | SveShape::Store => fail("SVE row: a load or store is an intrinsic"),
    }
}

/// Whether the row's operation has an unpredicated form in SVE.
fn unpredicated(mnem: &str) -> bool {
    matches!(mnem, "add" | "sub" | "fadd" | "fsub" | "fmul")
}

/// A binary row: the unpredicated form where the inactive lanes may be
/// anything and one exists, else the destructive form on the first
/// operand's copy, `movprfx` zeroing the inactive lanes of a `_z` one.
/// A destination holding the second operand computes in a scratch.
fn binary(
    code: &mut CodeBuf,
    mnem: &str,
    mode: SvePred,
    size: u8,
    args: &[u32],
    dst: Place,
    o: &Operands,
) -> Emit {
    let (a, b) = (o.z(code, args[1], 0)?, o.z(code, args[2], 1)?);
    let d = o.z_dst(dst)?;
    if mode == SvePred::Any && unpredicated(mnem) {
        word(code, mnem, &[z(d, size), z(a, size), z(b, size)])?;
        o.z_done(code, dst, d);
        return Ok(());
    }
    let pg = o.governing(code, args[0])?;
    let fs = o.frame.fp_scratch;
    let t = match d {
        _ if d != b || d == a => d,
        _ if a == fs[0] => fs[1],
        _ => fs[0],
    };
    if mode == SvePred::Zero {
        let pgz = Opnd::PRegQ {
            num: pg,
            merge: false,
        };
        word(code, "movprfx", &[z(t, size), pgz, z(a, size)])?;
    } else if t != a {
        let whole = |num| Opnd::ZReg { num, size: None };
        word(code, "movprfx", &[whole(t), whole(a)])?;
    }
    let pgm = Opnd::PRegQ {
        num: pg,
        merge: true,
    };
    word(code, mnem, &[z(t, size), pgm, z(t, size), z(b, size)])?;
    if t != d {
        emit(code, super::sve::enc_mov_z(d, t));
    }
    o.z_done(code, dst, d);
    Ok(())
}

/// A governed load (`ld1b` .. `ld1d`) or store of a vector at `args[1]`.
pub(super) fn emit_governed_access(
    code: &mut CodeBuf,
    intrinsic: crate::c5::op::Intrinsic,
    (args, dst): (&[u32], Place),
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
) -> Emit {
    let Some((lane, store)) = intrinsic.sve_lanes() else {
        return fail("SVE access: not a governed one");
    };
    if args.len() < 2 + usize::from(store) {
        return fail("SVE access: operands missing");
    }
    let o = Operands {
        alloc,
        frame,
        scratch,
    };
    let size = lane.trailing_zeros() as u8;
    let suffix = ["b", "h", "w", "d"][usize::from(size)];
    let base = o.x(code, args[1], scratch.secondary)?;
    let mem = Opnd::Mem {
        base: base.0,
        off: 0,
        pre: false,
    };
    let list = |first| Opnd::ZList {
        first,
        count: 1,
        size,
    };
    if store {
        let v = o.z(code, args[2], 0)?;
        let pg = o.governing(code, args[0])?;
        let p = Opnd::PReg {
            num: pg,
            size: None,
        };
        return word(code, &alloc::format!("st1{suffix}"), &[list(v), p, mem]);
    }
    let pg = o.governing(code, args[0])?;
    let d = o.z_dst(dst)?;
    let pgz = Opnd::PRegQ {
        num: pg,
        merge: false,
    };
    word(code, &alloc::format!("ld1{suffix}"), &[list(d), pgz, mem])?;
    o.z_done(code, dst, d);
    Ok(())
}
