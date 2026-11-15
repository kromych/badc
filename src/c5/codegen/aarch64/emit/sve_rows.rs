//! The SVE rows of the SIMD tables ([`crate::c5::aarch64_sve`]) on values in
//! Z and P registers: each row's instruction over its lanes, a governing
//! predicate of a 3-bit field in p0-p6 or reloaded into p7, the predicate
//! operands of a 4-bit field reloaded into p7, p15 and p14 in turn, a
//! spilled vector reloaded into the FP scratch, and a result bound for a
//! slot computed in the scratch, or p14.

use super::super::ssa::sve_alloc::{
    PRED_HOLD, PRED_OPERAND, PRED_STAGE, PredPlace, encoded_operand, encoded_operands,
};
use super::table::{self, Opnd};
use super::*;
use crate::c5::aarch64_sve::SveImm;
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

fn immediate(i: SveImm) -> Opnd {
    match i {
        SveImm::Int(v) => Opnd::Imm(v),
        SveImm::Fp(code) => Opnd::FpImm(code),
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

/// `Inst::SimdVal` of an SVE row, defining `v` in `dst`; an operand a
/// constant fills, its immediate form's ([`encoded_operand`]).
pub(super) fn emit_row(
    code: &mut CodeBuf,
    func: &FunctionSsa,
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
    let encoded = encoded_operand(func, op, args);
    match form.shape {
        SveShape::Binary(mode) => match encoded {
            Some((_, mnem, i)) => {
                let float = form.elems == simd::SveElems::Float;
                binary_immediate(code, (mnem, i), (mode, float), size, args, dst, &o)
            }
            None => binary(code, row, mode, size, args, dst, &o),
        },
        SveShape::Unary(mode) => unary(code, row, mode, size, args, dst, &o),
        SveShape::Ternary(mode, acc_last) => {
            ternary(code, row.mnem, (mode, acc_last), size, args, dst, &o)
        }
        SveShape::Compare => {
            let pg = o.governing(code, args[0])?;
            let (mnem, x, y) = match encoded {
                Some((k, mnem, i)) => (mnem, o.z(code, args[3 - k], 0)?, immediate(i)),
                None => (
                    row.mnem,
                    o.z(code, args[1], 0)?,
                    z(o.z(code, args[2], 1)?, size),
                ),
            };
            let pd = o.pred_dst(v)?;
            let pgz = Opnd::PRegQ {
                num: pg,
                merge: false,
            };
            let p = Opnd::PReg {
                num: pd.0,
                size: Some(size),
            };
            word(code, mnem, &[p, pgz, z(x, size), y])?;
            o.pred_done(code, pd);
            Ok(())
        }
        SveShape::Index => {
            // Each scalar its immediate where one encodes it, else a W or,
            // for doubleword lanes, an X register.
            let enc = encoded_operands(func, op, args);
            let mut ops = alloc::vec![z(o.z_dst(dst)?, size)];
            for (k, into) in [(0, scratch.primary), (1, scratch.secondary)] {
                match enc.iter().flatten().find(|e| e.0 == k) {
                    Some(&(_, _, i)) => ops.push(immediate(i)),
                    None => {
                        let x = o.x(code, args[k], into)?;
                        ops.push(Opnd::Reg {
                            num: x.0,
                            is64: size == 3,
                            sp: false,
                        });
                    }
                }
            }
            word(code, "index", &ops)?;
            o.z_done(code, dst, o.z_dst(dst)?);
            Ok(())
        }
        SveShape::PFalse => {
            let pd = o.pred_dst(v)?;
            word(
                code,
                "pfalse",
                &[Opnd::PReg {
                    num: pd.0,
                    size: Some(0),
                }],
            )?;
            o.pred_done(code, pd);
            Ok(())
        }
        SveShape::PredPermute | SveShape::PredReverse => {
            let mut ps = alloc::vec::Vec::new();
            for (k, &a) in args.iter().enumerate().take(row.form.arity()) {
                ps.push(o.pred(code, a, k)?);
            }
            let pd = o.pred_dst(v)?;
            let ops: alloc::vec::Vec<Opnd> = core::iter::once(pd.0)
                .chain(ps)
                .map(|num| Opnd::PReg {
                    num,
                    size: Some(size),
                })
                .collect();
            word(code, row.mnem, &ops)?;
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
            // An integer sum is 64 bits wide; another reduction the lane's.
            let rsize = if simd::sve_widening_sum(op) { 3 } else { size };
            let v = match rsize {
                0 | 1 => Opnd::VScalar {
                    num: vd,
                    size: rsize,
                },
                _ => Opnd::VReg {
                    num: vd,
                    is_d: rsize == 3,
                },
            };
            word(code, row.mnem, &[v, p, z(a, size)])?;
            if float {
                store_spilled_fp(code, frame, dst, vd);
                return Ok(());
            }
            let Some(rd) = int_or_spill_scratch(dst, scratch) else {
                return fail("SVE reduction: dst not int reg / spill");
            };
            // The lane into the register as its type extends.
            let esize = 1 << rsize;
            let word = match (rsize, form.elems) {
                (3, _) => enc_fmov_d_to_x(rd, vd),
                (_, simd::SveElems::Signed) => enc_smov_gen(rd, vd, esize, 0),
                _ => enc_umov_gen(rd, vd, esize, 0),
            };
            emit(code, word);
            store_spilled_int(code, frame, dst, rd);
            Ok(())
        }
        SveShape::Dup => {
            let d = o.z_dst(dst)?;
            if let Some((_, mnem, i)) = encoded {
                word(code, mnem, &[z(d, size), immediate(i)])?;
            } else if form.elems == simd::SveElems::Float {
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
        SveShape::DupLane => {
            let a = o.z(code, args[0], 0)?;
            if let Some((_, mnem, SveImm::Int(index))) = encoded {
                let d = o.z_dst(dst)?;
                let e = Opnd::ZElem {
                    num: a,
                    size,
                    index: index as u8,
                };
                word(code, mnem, &[z(d, size), e])?;
                o.z_done(code, dst, d);
                return Ok(());
            }
            // The index in every lane of the second scratch, then TBL.
            let x = o.x(code, args[1], scratch.primary)?;
            let t = frame.fp_scratch[1];
            let r = Opnd::Reg {
                num: x.0,
                is64: size == 3,
                sp: false,
            };
            word(code, "dup", &[z(t, size), r])?;
            let d = o.z_dst(dst)?;
            word(code, "tbl", &[z(d, size), z(a, size), z(t, size)])?;
            o.z_done(code, dst, d);
            Ok(())
        }
        SveShape::Reinterpret => {
            super::sve::emit_z_copy(code, place_of(alloc, args[0]), dst, frame)
        }
        SveShape::Lanewise if encoded.is_some() => {
            let Some((_, mnem, i)) = encoded else {
                return fail("SVE row: no immediate");
            };
            let a = o.z(code, args[0], 0)?;
            let d = o.z_dst(dst)?;
            if d != a {
                let whole = |num| Opnd::ZReg { num, size: None };
                word(code, "movprfx", &[whole(d), whole(a)])?;
            }
            word(code, mnem, &[z(d, size), z(d, size), immediate(i)])?;
            o.z_done(code, dst, d);
            Ok(())
        }
        SveShape::Permute | SveShape::Reverse | SveShape::Lanewise => {
            let a = o.z(code, args[0], 0)?;
            let b = match args.get(1) {
                Some(&b) if form.shape != SveShape::Reverse => Some(o.z(code, b, 1)?),
                _ => None,
            };
            let d = o.z_dst(dst)?;
            let ops: alloc::vec::Vec<Opnd> = [Some(d), Some(a), b]
                .into_iter()
                .flatten()
                .map(|r| z(r, size))
                .collect();
            word(code, row.mnem, &ops)?;
            o.z_done(code, dst, d);
            Ok(())
        }
        SveShape::Extract => {
            // EXT counts bytes, the intrinsic lanes.
            let at = Opnd::Imm(i64::from(imm.unwrap_or(0)) << size);
            let (a, b) = (o.z(code, args[0], 0)?, o.z(code, args[1], 1)?);
            let d = o.z_dst(dst)?;
            let fs = frame.fp_scratch;
            let t = match extract_in_scratch(d, a, b) {
                true if a == fs[0] => fs[1],
                true => fs[0],
                false => d,
            };
            if t != a {
                let whole = |num| Opnd::ZReg { num, size: None };
                word(code, "movprfx", &[whole(t), whole(a)])?;
            }
            word(code, "ext", &[z(t, 0), z(t, 0), z(b, 0), at])?;
            if t != d {
                emit(code, super::sve::enc_mov_z(d, t));
            }
            o.z_done(code, dst, d);
            Ok(())
        }
        SveShape::Load | SveShape::Store => fail("SVE row: a load or store is an intrinsic"),
    }
}

/// Whether an extraction in registers computes in a scratch: its
/// destination `d` holds the second operand `b` and not the first, which
/// EXT overwrites in place after a MOVPRFX that `b` may not share.
fn extract_in_scratch(d: u8, a: u8, b: u8) -> bool {
    d == b && d != a
}

/// The P registers the rows and accesses of `func` stage predicates
/// through: p7 for a governing operand outside p0-p6, p7, p15 and p14 for
/// the first, second and third predicate operands of a 4-bit field reloaded
/// from their slots, and p14 for a predicate result bound for a slot.
pub(super) fn pred_stage_writes(func: &FunctionSsa, alloc: &Allocation) -> u16 {
    use crate::c5::op::Intrinsic as I;
    let slot = |v: u32| matches!(alloc.sve.pred_place(v), Some(PredPlace::Slot(_)));
    let staged = |v: Option<&u32>| {
        v.is_some_and(|&v| !matches!(alloc.sve.pred_place(v), Some(PredPlace::Reg(r)) if r < 8))
    };
    let mut w = 0u16;
    for (v, inst) in func.insts.iter().enumerate() {
        let (op, args) = match inst {
            Inst::SimdVal { op, args, .. } => (*op, args),
            Inst::Intrinsic { kind, args } => {
                let stage = match I::from_i64(*kind) {
                    Some(i) if i.sve_lanes().is_some() => staged(args.first()),
                    Some(I::SveLoadP) => slot(v as u32),
                    Some(I::SveStoreP) => args.get(1).is_some_and(|&a| slot(a)),
                    _ => false,
                };
                w |= u16::from(stage) << PRED_STAGE;
                continue;
            }
            _ => continue,
        };
        let row = simd::get(op);
        let Form::Sve(f) = row.form else {
            continue;
        };
        let operands = match f.shape {
            s if s.on_predicates() => row.form.arity(),
            SveShape::Select => 1,
            _ => 0,
        };
        for (k, &a) in args.iter().enumerate().take(operands) {
            w |= u16::from(slot(a)) << PRED_STAGES[k];
        }
        w |= u16::from(f.shape.governs_low() && staged(args.first())) << PRED_STAGE;
        let result = f.shape.result() == Some(crate::c5::ir::LoadKind::SvePredicate);
        w |= u16::from(result && slot(v as u32)) << PRED_HOLD;
    }
    w
}

/// The FP scratch registers the rows of `func` write while every vector is
/// in a register: a destructive form's scratch ([`destructive`]) and an
/// integer sum's D register; and a ternary row's third operand reloaded,
/// and its scratch.
pub(super) fn scratch_writes(func: &FunctionSsa, alloc: &Allocation) -> [bool; 3] {
    let fp = |v: u32| match place_of(alloc, v) {
        Place::FpReg(r) => Some(r),
        _ => None,
    };
    let mut w = [false; 3];
    for (v, inst) in func.insts.iter().enumerate() {
        let Inst::SimdVal { op, args, .. } = inst else {
            continue;
        };
        let row = simd::get(*op);
        let Form::Sve(f) = row.form else {
            continue;
        };
        // An immediate form takes no scratch.
        if encoded_operand(func, *op, args).is_some() {
            continue;
        }
        match (f.shape, args.as_slice()) {
            (SveShape::Binary(mode), &[_, a, b]) => {
                let (Some(d), Some(a), Some(b)) = (fp(v as u32), fp(a), fp(b)) else {
                    continue;
                };
                let size = row.int_width.trailing_zeros() as u8;
                let plain = mode == SvePred::Any && unpredicated(row.mnem, size).is_some();
                w[0] |= !plain && destructive(row, mode, (d, a, b)) == Destructive::Scratch;
            }
            (SveShape::Unary(mode), _) => {
                let i = (mode == SvePred::Merge).then(|| fp(args[1])).flatten();
                let (Some(d), Some(a)) = (fp(v as u32), args.last().and_then(|&a| fp(a))) else {
                    continue;
                };
                w[0] |= unary_in_scratch(mode, d, i, a);
            }
            (SveShape::Ternary(mode, acc_last), &[_, a, b, c]) => {
                // A spilled operand stands for the scratch it reloads into,
                // numbered past the registers.
                let at = |v: u32, k: u8| fp(v).unwrap_or(32 + k);
                let r = [at(a, 0), at(b, 1), at(c, 2)];
                let plan = ternary_plan((mode, acc_last, negates(row.mnem)), at(v as u32, 0), r);
                w[2] |= fp(c).is_none();
                if plan.1 {
                    let t = (32..35u8).find(|s| !r.contains(s)).unwrap_or(32);
                    w[usize::from(t - 32)] = true;
                }
            }
            (SveShape::Reduce, _) => w[1] |= f.elems != simd::SveElems::Float,
            (SveShape::DupLane, _) => w[1] = true,
            (SveShape::Extract, &[a, b]) => {
                if let (Some(d), Some(a), Some(b)) = (fp(v as u32), fp(a), fp(b)) {
                    w[0] |= extract_in_scratch(d, a, b);
                }
            }
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
        "and" | "orr" | "eor" | "bic" => Some(3),
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
        "sdiv" => Some("sdivr"),
        "udiv" => Some("udivr"),
        "fdiv" => Some("fdivr"),
        "lsl" => Some("lslr"),
        "lsr" => Some("lsrr"),
        "asr" => Some("asrr"),
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

/// A binary row whose second operand is immediate `i` of instruction
/// `mnem`: an unpredicated shift, the unpredicated destructive integer
/// form where the inactive lanes may be anything, else the predicated
/// destructive form on a copy of the first operand, zeroed outside the
/// predicate by `movprfx` for a `_z` one.
fn binary_immediate(
    code: &mut CodeBuf,
    (mnem, i): (&str, SveImm),
    (mode, float): (SvePred, bool),
    size: u8,
    args: &[u32],
    dst: Place,
    o: &Operands,
) -> Emit {
    let a = o.z(code, args[1], 0)?;
    let d = o.z_dst(dst)?;
    let whole = |num| Opnd::ZReg { num, size: None };
    let shift = matches!(mnem, "lsl" | "lsr" | "asr");
    if mode == SvePred::Any && shift {
        word(code, mnem, &[z(d, size), z(a, size), immediate(i)])?;
    } else if mode == SvePred::Any && !float {
        if d != a {
            word(code, "movprfx", &[whole(d), whole(a)])?;
        }
        word(code, mnem, &[z(d, size), z(d, size), immediate(i)])?;
    } else {
        let pg = o.governing(code, args[0])?;
        if mode == SvePred::Zero {
            let pgz = Opnd::PRegQ {
                num: pg,
                merge: false,
            };
            word(code, "movprfx", &[z(d, size), pgz, z(a, size)])?;
        } else if d != a {
            word(code, "movprfx", &[whole(d), whole(a)])?;
        }
        let pgm = Opnd::PRegQ {
            num: pg,
            merge: true,
        };
        word(code, mnem, &[z(d, size), pgm, z(d, size), immediate(i)])?;
    }
    o.z_done(code, dst, d);
    Ok(())
}

/// The accumulating instructions, whose destructive operand is the addend,
/// and the multiplying ones, whose destructive operand is a factor (Arm
/// ARM, MLA and MAD and their kin).
const FUSED: [(&str, &str); 6] = [
    ("mla", "mad"),
    ("mls", "msb"),
    ("fmla", "fmad"),
    ("fmls", "fmsb"),
    ("fnmla", "fnmad"),
    ("fnmls", "fnmsb"),
];

/// Whether a fused floating instruction negates a factor, the first one
/// (`fmls`, `fnmla`) or the destructive one (`fmsb`, `fnmad`).
fn negates(mnem: &str) -> bool {
    matches!(mnem, "fmls" | "fnmla" | "fmsb" | "fnmad")
}

/// Which operand (1 to 3) of a ternary row computes into `d` from
/// registers `r`, and whether in a scratch: the one `d` holds, else the
/// first after a copy into `d` none of the others is in, a merging form's
/// always the first, as its inactive lanes are; a zeroing form's where
/// the others are not `d`, as its MOVPRFX requires (Arm ARM, MOVPRFX).
/// The second factor of a negating floating row is never it, so the
/// negation stays on the first.
fn ternary_plan(
    (mode, acc_last, negates): (SvePred, bool, bool),
    d: u8,
    r: [u8; 3],
) -> (usize, bool) {
    let second = if acc_last { 2 } else { 3 };
    let candidates =
        (1..=3).filter(|&k| (k == 1 || mode != SvePred::Merge) && !(negates && k == second));
    let others_free = |k: usize| (1..=3).all(|j| j == k || r[j - 1] != d);
    let pick = match mode {
        SvePred::Zero => candidates.clone().find(|&k| others_free(k)),
        _ => (candidates.clone())
            .find(|&k| r[k - 1] == d)
            .or_else(|| (!r.contains(&d)).then_some(1)),
    };
    pick.map_or((1, true), |k| (k, false))
}

/// A ternary row: its operand the plan picks ([`ternary_plan`]) copied
/// into the destination where it is not there, zeroed outside the
/// predicate for a `_z` one, then the accumulating instruction where that
/// operand is the addend, else the multiplying one.
fn ternary(
    code: &mut CodeBuf,
    mnem: &str,
    (mode, acc_last): (SvePred, bool),
    size: u8,
    args: &[u32],
    dst: Place,
    o: &Operands,
) -> Emit {
    let r = [
        o.z(code, args[1], 0)?,
        o.z(code, args[2], 1)?,
        o.z(code, args[3], 2)?,
    ];
    let d = o.z_dst(dst)?;
    let pg = o.governing(code, args[0])?;
    let (k, scratch) = ternary_plan((mode, acc_last, negates(mnem)), d, r);
    let fs = o.frame.fp_scratch;
    let t = match scratch {
        true => fs.into_iter().find(|s| !r.contains(s)).unwrap_or(fs[0]),
        false => d,
    };
    let whole = |num| Opnd::ZReg { num, size: None };
    let from = r[k - 1];
    match mode {
        SvePred::Zero => {
            let pgz = Opnd::PRegQ {
                num: pg,
                merge: false,
            };
            word(code, "movprfx", &[z(t, size), pgz, z(from, size)])?;
        }
        _ if t != from => word(code, "movprfx", &[whole(t), whole(from)])?,
        _ => {}
    }
    let Some(&(acc_form, mul_form)) = FUSED.iter().find(|p| p.0 == mnem || p.1 == mnem) else {
        return fail("SVE row: not a fused multiply");
    };
    let acc = if acc_last { 3 } else { 1 };
    let factors: [usize; 2] = if acc_last { [1, 2] } else { [2, 3] };
    let (m, ops) = match factors.iter().position(|&f| f == k) {
        None => (acc_form, [r[factors[0] - 1], r[factors[1] - 1]]),
        Some(i) => (mul_form, [r[factors[1 - i] - 1], r[acc - 1]]),
    };
    let pgm = Opnd::PRegQ {
        num: pg,
        merge: true,
    };
    word(
        code,
        m,
        &[z(t, size), pgm, z(ops[0], size), z(ops[1], size)],
    )?;
    if t != d {
        emit(code, super::sve::enc_mov_z(d, t));
    }
    o.z_done(code, dst, d);
    Ok(())
}

/// Whether a unary row in registers computes in a scratch: the merging or
/// zeroing form whose destination `d` holds its operand `a` and not the
/// inactive operand `i`, as MOVPRFX has the next instruction read its
/// destination as the destructive operand alone (Arm ARM, MOVPRFX).
fn unary_in_scratch(mode: SvePred, d: u8, i: Option<u8>, a: u8) -> bool {
    mode != SvePred::Any && d == a && i != Some(d)
}

/// A unary row over its last operand: the merging form on a copy of the
/// inactive operand, the zeroing form on `movprfx` of the operand under
/// the predicate, the don't-care form in place.
fn unary(
    code: &mut CodeBuf,
    row: &simd::SimdOp,
    mode: SvePred,
    size: u8,
    args: &[u32],
    dst: Place,
    o: &Operands,
) -> Emit {
    let i = match mode {
        SvePred::Merge => Some(o.z(code, args[1], 0)?),
        _ => None,
    };
    let a = o.z(code, args[args.len() - 1], 1)?;
    let d = o.z_dst(dst)?;
    let pg = o.governing(code, args[0])?;
    let fs = o.frame.fp_scratch;
    let t = match unary_in_scratch(mode, d, i, a) {
        true if i == Some(fs[0]) => fs[1],
        true => fs[0],
        false => d,
    };
    match (mode, i) {
        (SvePred::Merge, Some(i)) if i != t => {
            let whole = |num| Opnd::ZReg { num, size: None };
            word(code, "movprfx", &[whole(t), whole(i)])?;
        }
        (SvePred::Zero, _) => {
            let pgz = Opnd::PRegQ {
                num: pg,
                merge: false,
            };
            word(code, "movprfx", &[z(t, size), pgz, z(a, size)])?;
        }
        _ => {}
    }
    let pgm = Opnd::PRegQ {
        num: pg,
        merge: true,
    };
    word(code, row.mnem, &[z(t, size), pgm, z(a, size)])?;
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
