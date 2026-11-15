//! The SVE rows of the SIMD tables ([`crate::c5::aarch64_sve`]) on values in
//! Z and P registers: each row's instruction over its lanes, a governing
//! predicate of a 3-bit field in p0-p6 or reloaded into p7, the predicate
//! operands of a 4-bit field reloaded into p7, p15 and p14 in turn, a
//! spilled vector reloaded into the FP scratch, and a result bound for a
//! slot computed in the scratch, or p14.

use super::super::ssa::sve_alloc::{PRED_HOLD, PRED_OPERAND, PRED_STAGE, PredPlace};
use super::table::{self, Opnd};
use super::*;
use crate::c5::simd::{self, Form, SvePred, SveShape, SveTest};

/// The P registers predicate operands 0, 1 and 2 of a row reload into.
const PRED_STAGES: [u8; 3] = [PRED_STAGE, PRED_OPERAND, PRED_HOLD];

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

    /// The register predicate operand `k`, `v`, is read in from a 4-bit
    /// field: its own, else its stage, which a reload fills.
    fn pred(&self, code: &mut Vec<u8>, v: u32, k: usize) -> Emit<u8> {
        match self.alloc.sve.pred_place(v) {
            Some(PredPlace::Reg(r)) => Ok(r),
            Some(p) => {
                super::sve::pred_move(code, self.frame, p, PredPlace::Reg(PRED_STAGES[k]));
                Ok(PRED_STAGES[k])
            }
            None => fail("SVE row: predicate operand has no place"),
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
        SveShape::Binary(mode) => binary(code, row, mode, size, args, dst, &o),
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
        SveShape::Select => {
            let pg = o.pred(code, args[0], 0)?;
            let (a, b) = (o.z(code, args[1], 0)?, o.z(code, args[2], 1)?);
            let d = o.z_dst(dst)?;
            let p = Opnd::PReg {
                num: pg,
                size: None,
            };
            word(code, "sel", &[z(d, size), p, z(a, size), z(b, size)])?;
            o.z_done(code, dst, d);
            Ok(())
        }
        SveShape::PredSelect | SveShape::PredLogic | SveShape::PredNot => {
            let mut ps = [0u8; 3];
            for (k, &a) in args.iter().enumerate().take(row.form.arity()) {
                ps[k] = o.pred(code, a, k)?;
            }
            let pd = o.pred_dst(v)?;
            let b = |num| Opnd::PReg { num, size: Some(0) };
            let pg = if form.shape == SveShape::PredSelect {
                Opnd::PReg {
                    num: ps[0],
                    size: None,
                }
            } else {
                Opnd::PRegQ {
                    num: ps[0],
                    merge: false,
                }
            };
            let ops = [b(pd.0), pg, b(ps[1]), b(ps[2])];
            let n = if form.shape == SveShape::PredNot {
                3
            } else {
                4
            };
            word(code, row.mnem, &ops[..n])?;
            o.pred_done(code, pd);
            Ok(())
        }
        SveShape::Test(test) => {
            let pg = o.pred(code, args[0], 0)?;
            let p = o.pred(code, args[1], 1)?;
            let pg = Opnd::PReg {
                num: pg,
                size: None,
            };
            let p = Opnd::PReg {
                num: p,
                size: Some(0),
            };
            word(code, "ptest", &[pg, p])?;
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("SVE test: dst not int reg / spill");
            };
            // PTEST sets N for the first bit, clears Z for any and C for
            // the last.
            let cond = match test {
                SveTest::Any => Cond::Ne,
                SveTest::First => Cond::Mi,
                SveTest::Last => Cond::Lo,
            };
            emit(code, enc_cset(rd, cond));
            store_spilled_int(code, frame, dst, rd);
            Ok(())
        }
        SveShape::Load | SveShape::Store => fail("SVE row: a load or store is an intrinsic"),
    }
}

/// Whether a row of `func` reloads its second predicate operand into
/// [`PRED_OPERAND`].
pub(super) fn reloads_second_predicate(func: &FunctionSsa, alloc: &Allocation) -> bool {
    let slot = |v: &u32| matches!(alloc.sve.pred_place(*v), Some(PredPlace::Slot(_)));
    func.insts.iter().any(|i| match i {
        Inst::SimdVal { op, args, .. } => {
            matches!(simd::get(*op).form, Form::Sve(f) if f.shape.on_predicates())
                && args.get(1).is_some_and(slot)
        }
        _ => false,
    })
}

/// The FP scratch registers the rows of `func` write while every vector is
/// in a register: a destructive form's scratch ([`destructive`]) and an
/// integer sum's D register.
pub(super) fn scratch_writes(func: &FunctionSsa, alloc: &Allocation) -> [bool; 2] {
    let fp = |v: u32| match place_of(alloc, v) {
        Place::FpReg(r) => Some(r),
        _ => None,
    };
    let mut w = [false; 2];
    for (v, inst) in func.insts.iter().enumerate() {
        let Inst::SimdVal { op, args, .. } = inst else {
            continue;
        };
        let row = simd::get(*op);
        let Form::Sve(f) = row.form else {
            continue;
        };
        match (f.shape, args.as_slice()) {
            (SveShape::Binary(mode), &[_, a, b]) => {
                let (Some(d), Some(a), Some(b)) = (fp(v as u32), fp(a), fp(b)) else {
                    continue;
                };
                let size = row.int_width.trailing_zeros() as u8;
                let plain = mode == SvePred::Any && unpredicated(row.mnem, size).is_some();
                w[0] |= !plain && destructive(row, mode, (d, a, b)) == Destructive::Scratch;
            }
            (SveShape::Reduce, _) => w[1] |= f.elems != simd::SveElems::Float,
            _ => {}
        }
    }
    w
}

/// The lane size of the row's unpredicated form, where SVE has one: a
/// bitwise operation's is the doubleword.
fn unpredicated(mnem: &str, size: u8) -> Option<u8> {
    match mnem {
        "add" | "sub" | "fadd" | "fsub" | "fmul" => Some(size),
        "and" | "orr" | "eor" => Some(3),
        _ => None,
    }
}

/// How a destructive row computes `a op b` into `d`, which holds `b`
/// where the plan is not the plain one. MOVPRFX has the next instruction
/// read its destination as the destructive operand alone (Arm ARM,
/// MOVPRFX), and the merging form keeps `a` in the inactive lanes.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Destructive {
    /// In `d` from `a`, from `b` where `swap` (an operation that commutes).
    InPlace { swap: bool },
    /// In `d` from `b` by the reversed instruction (`subr`, `fsubr`).
    Reversed,
    /// In a scratch from `a`, then moved to `d`.
    Scratch,
}

/// The plan of a destructive row whose operands and destination are in
/// registers `a`, `b` and `d`.
fn destructive(row: &simd::SimdOp, mode: SvePred, (d, a, b): (u8, u8, u8)) -> Destructive {
    if d != b || d == a && mode != SvePred::Zero {
        Destructive::InPlace { swap: false }
    } else if mode == SvePred::Merge || d == a {
        Destructive::Scratch
    } else if row.sem.commutes() {
        Destructive::InPlace { swap: true }
    } else if reversed(row.mnem).is_some() {
        Destructive::Reversed
    } else {
        Destructive::Scratch
    }
}

/// The instruction computing `b op a` with `a` the destructive operand.
fn reversed(mnem: &str) -> Option<&'static str> {
    match mnem {
        "sub" => Some("subr"),
        "fsub" => Some("fsubr"),
        _ => None,
    }
}

/// A binary row: the unpredicated form where the inactive lanes may be
/// anything and one exists, else the destructive form on a copy of the
/// first operand ([`destructive`]), `movprfx` zeroing the inactive lanes
/// of a `_z` one.
fn binary(
    code: &mut CodeBuf,
    row: &simd::SimdOp,
    mode: SvePred,
    size: u8,
    args: &[u32],
    dst: Place,
    o: &Operands,
) -> Emit {
    let (a, b) = (o.z(code, args[1], 0)?, o.z(code, args[2], 1)?);
    let d = o.z_dst(dst)?;
    if let Some(s) = unpredicated(row.mnem, size).filter(|_| mode == SvePred::Any) {
        word(code, row.mnem, &[z(d, s), z(a, s), z(b, s)])?;
        o.z_done(code, dst, d);
        return Ok(());
    }
    let pg = o.governing(code, args[0])?;
    let fs = o.frame.fp_scratch;
    let (t, x, y, mnem) = match destructive(row, mode, (d, a, b)) {
        Destructive::InPlace { swap: false } => (d, a, b, row.mnem),
        Destructive::InPlace { swap: true } => (d, b, a, row.mnem),
        Destructive::Reversed => (d, b, a, reversed(row.mnem).unwrap_or(row.mnem)),
        Destructive::Scratch => (if a == fs[0] { fs[1] } else { fs[0] }, a, b, row.mnem),
    };
    if mode == SvePred::Zero {
        let pgz = Opnd::PRegQ {
            num: pg,
            merge: false,
        };
        word(code, "movprfx", &[z(t, size), pgz, z(x, size)])?;
    } else if t != x {
        let whole = |num| Opnd::ZReg { num, size: None };
        word(code, "movprfx", &[whole(t), whole(x)])?;
    }
    let pgm = Opnd::PRegQ {
        num: pg,
        merge: true,
    };
    word(code, mnem, &[z(t, size), pgm, z(t, size), z(y, size)])?;
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
