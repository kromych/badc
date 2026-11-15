//! The AArch64 SVE intrinsic surface: the rows of the `__builtin_sve_*`
//! builtins the bundled `<arm_sve.h>` calls. A builtin names a family of
//! rows, one per lane width and element kind, and the first operand of a
//! typed family is the SVE type that selects the row and types the result.
//! The shapes and semantics are the shared vocabulary of [`super::simd`].

use super::simd::{
    AcrossOp, FOp, Form, Ret, Sem, SimdOp, SveElems, SveForm, SvePred, SveShape, SveTest,
};

const fn row(
    name: &'static str,
    mnem: &'static str,
    shape: SveShape,
    elems: SveElems,
    sem: Sem,
    lane: u8,
) -> SimdOp {
    SimdOp {
        name,
        mnem,
        form: Form::Sve(SveForm { shape, elems }),
        ret: Ret::Void,
        sem,
        int_width: lane,
        bytes: 0,
    }
}

const fn fadd(w: u8) -> Sem {
    Sem::Float(FOp::Add, w, false)
}
const fn fsub(w: u8) -> Sem {
    Sem::Float(FOp::Sub, w, false)
}
const fn fmul(w: u8) -> Sem {
    Sem::Float(FOp::Mul, w, false)
}
/// The floating relations, numbered as [`Sem::FloatCmp`]'s predicates.
const fn fcmeq(w: u8) -> Sem {
    Sem::FloatRel(w, 0)
}
const fn fcmne(w: u8) -> Sem {
    Sem::FloatRel(w, 4)
}
const fn fcmge(w: u8) -> Sem {
    Sem::FloatRel(w, 13)
}
const fn fcmgt(w: u8) -> Sem {
    Sem::FloatRel(w, 14)
}
const fn move_(_: u8) -> Sem {
    Sem::Move
}
const fn and(_: u8) -> Sem {
    Sem::And
}
const fn orr(_: u8) -> Sem {
    Sem::Or
}
const fn eor(_: u8) -> Sem {
    Sem::Xor
}
const fn bic(_: u8) -> Sem {
    Sem::BitClear
}
const fn orn(_: u8) -> Sem {
    Sem::OrNot
}
const fn nand(_: u8) -> Sem {
    Sem::Nand
}
const fn nor(_: u8) -> Sem {
    Sem::Nor
}
const fn saddv(w: u8) -> Sem {
    Sem::Across(AcrossOp::Add, w, true, 0)
}
const fn uaddv(w: u8) -> Sem {
    Sem::Across(AcrossOp::Add, w, false, 0)
}
const fn faddv(w: u8) -> Sem {
    Sem::FloatAcross(FOp::Add, w)
}

use SveElems::{Any, Float, Int, Signed, Unsigned};
use SvePred::{Any as X, Merge as M, Zero as Z};

/// One row per lane width each family lists.
macro_rules! rows {
    ($($name:literal $mnem:literal $shape:expr, $elems:ident, $sem:path: $($w:literal)*;)*) => {
        &[$($(row(concat!("__builtin_sve_", $name), $mnem, $shape, $elems, $sem($w), $w)),*),*]
    };
}

/// Every SVE builtin row badc provides.
#[rustfmt::skip]
pub(crate) const OPS: &[SimdOp] = rows! {
    "add_m" "add" SveShape::Binary(M), Int, Sem::Add: 1 2 4 8;
    "add_m" "fadd" SveShape::Binary(M), Float, fadd: 4 8;
    "add_z" "add" SveShape::Binary(Z), Int, Sem::Add: 1 2 4 8;
    "add_z" "fadd" SveShape::Binary(Z), Float, fadd: 4 8;
    "add_x" "add" SveShape::Binary(X), Int, Sem::Add: 1 2 4 8;
    "add_x" "fadd" SveShape::Binary(X), Float, fadd: 4 8;
    "sub_m" "sub" SveShape::Binary(M), Int, Sem::Sub: 1 2 4 8;
    "sub_m" "fsub" SveShape::Binary(M), Float, fsub: 4 8;
    "sub_z" "sub" SveShape::Binary(Z), Int, Sem::Sub: 1 2 4 8;
    "sub_z" "fsub" SveShape::Binary(Z), Float, fsub: 4 8;
    "sub_x" "sub" SveShape::Binary(X), Int, Sem::Sub: 1 2 4 8;
    "sub_x" "fsub" SveShape::Binary(X), Float, fsub: 4 8;
    "mul_m" "mul" SveShape::Binary(M), Int, Sem::MulLo: 1 2 4 8;
    "mul_m" "fmul" SveShape::Binary(M), Float, fmul: 4 8;
    "mul_z" "mul" SveShape::Binary(Z), Int, Sem::MulLo: 1 2 4 8;
    "mul_z" "fmul" SveShape::Binary(Z), Float, fmul: 4 8;
    "mul_x" "mul" SveShape::Binary(X), Int, Sem::MulLo: 1 2 4 8;
    "mul_x" "fmul" SveShape::Binary(X), Float, fmul: 4 8;
    "and_m" "and" SveShape::Binary(M), Int, and: 1 2 4 8;
    "and_z" "and" SveShape::Binary(Z), Int, and: 1 2 4 8;
    "and_z" "and" SveShape::PredLogic, Any, and: 1;
    "and_x" "and" SveShape::Binary(X), Int, and: 1 2 4 8;
    "orr_m" "orr" SveShape::Binary(M), Int, orr: 1 2 4 8;
    "orr_z" "orr" SveShape::Binary(Z), Int, orr: 1 2 4 8;
    "orr_z" "orr" SveShape::PredLogic, Any, orr: 1;
    "orr_x" "orr" SveShape::Binary(X), Int, orr: 1 2 4 8;
    "eor_m" "eor" SveShape::Binary(M), Int, eor: 1 2 4 8;
    "eor_z" "eor" SveShape::Binary(Z), Int, eor: 1 2 4 8;
    "eor_z" "eor" SveShape::PredLogic, Any, eor: 1;
    "eor_x" "eor" SveShape::Binary(X), Int, eor: 1 2 4 8;
    "bic_z" "bic" SveShape::PredLogic, Any, bic: 1;
    "orn_z" "orn" SveShape::PredLogic, Any, orn: 1;
    "nand_z" "nand" SveShape::PredLogic, Any, nand: 1;
    "nor_z" "nor" SveShape::PredLogic, Any, nor: 1;
    "not_z" "not" SveShape::PredNot, Any, eor: 1;
    "sel" "sel" SveShape::Select, Any, move_: 1 2 4 8;
    "sel" "sel" SveShape::PredSelect, Any, move_: 1;
    "ptest_any" "ptest" SveShape::Test(SveTest::Any), Any, move_: 1;
    "ptest_first" "ptest" SveShape::Test(SveTest::First), Any, move_: 1;
    "ptest_last" "ptest" SveShape::Test(SveTest::Last), Any, move_: 1;
    "cmpeq" "cmpeq" SveShape::Compare, Int, Sem::CmpEq: 1 2 4 8;
    "cmpeq" "fcmeq" SveShape::Compare, Float, fcmeq: 4 8;
    "cmpne" "cmpne" SveShape::Compare, Int, Sem::CmpNe: 1 2 4 8;
    "cmpne" "fcmne" SveShape::Compare, Float, fcmne: 4 8;
    "cmpgt" "cmpgt" SveShape::Compare, Signed, Sem::CmpGt: 1 2 4 8;
    "cmpgt" "cmphi" SveShape::Compare, Unsigned, Sem::CmpHi: 1 2 4 8;
    "cmpgt" "fcmgt" SveShape::Compare, Float, fcmgt: 4 8;
    "cmpge" "cmpge" SveShape::Compare, Signed, Sem::CmpGe: 1 2 4 8;
    "cmpge" "cmphs" SveShape::Compare, Unsigned, Sem::CmpHs: 1 2 4 8;
    "cmpge" "fcmge" SveShape::Compare, Float, fcmge: 4 8;
    "ptrue_b8" "ptrue" SveShape::PTrue, Any, move_: 1;
    "ptrue_b16" "ptrue" SveShape::PTrue, Any, move_: 2;
    "ptrue_b32" "ptrue" SveShape::PTrue, Any, move_: 4;
    "ptrue_b64" "ptrue" SveShape::PTrue, Any, move_: 8;
    "cntb" "cntb" SveShape::Count, Any, move_: 1;
    "cnth" "cnth" SveShape::Count, Any, move_: 2;
    "cntw" "cntw" SveShape::Count, Any, move_: 4;
    "cntd" "cntd" SveShape::Count, Any, move_: 8;
    "whilelt_b8" "whilelt" SveShape::While { signed: true, bits: 32 }, Any, move_: 1;
    "whilelt_b8" "whilelt" SveShape::While { signed: true, bits: 64 }, Any, move_: 1;
    "whilelt_b8" "whilelo" SveShape::While { signed: false, bits: 32 }, Any, move_: 1;
    "whilelt_b8" "whilelo" SveShape::While { signed: false, bits: 64 }, Any, move_: 1;
    "whilelt_b16" "whilelt" SveShape::While { signed: true, bits: 32 }, Any, move_: 2;
    "whilelt_b16" "whilelt" SveShape::While { signed: true, bits: 64 }, Any, move_: 2;
    "whilelt_b16" "whilelo" SveShape::While { signed: false, bits: 32 }, Any, move_: 2;
    "whilelt_b16" "whilelo" SveShape::While { signed: false, bits: 64 }, Any, move_: 2;
    "whilelt_b32" "whilelt" SveShape::While { signed: true, bits: 32 }, Any, move_: 4;
    "whilelt_b32" "whilelt" SveShape::While { signed: true, bits: 64 }, Any, move_: 4;
    "whilelt_b32" "whilelo" SveShape::While { signed: false, bits: 32 }, Any, move_: 4;
    "whilelt_b32" "whilelo" SveShape::While { signed: false, bits: 64 }, Any, move_: 4;
    "whilelt_b64" "whilelt" SveShape::While { signed: true, bits: 32 }, Any, move_: 8;
    "whilelt_b64" "whilelt" SveShape::While { signed: true, bits: 64 }, Any, move_: 8;
    "whilelt_b64" "whilelo" SveShape::While { signed: false, bits: 32 }, Any, move_: 8;
    "whilelt_b64" "whilelo" SveShape::While { signed: false, bits: 64 }, Any, move_: 8;
    "ld1" "ld1b" SveShape::Load, Any, move_: 1;
    "ld1" "ld1h" SveShape::Load, Any, move_: 2;
    "ld1" "ld1w" SveShape::Load, Any, move_: 4;
    "ld1" "ld1d" SveShape::Load, Any, move_: 8;
    "st1" "st1b" SveShape::Store, Any, move_: 1;
    "st1" "st1h" SveShape::Store, Any, move_: 2;
    "st1" "st1w" SveShape::Store, Any, move_: 4;
    "st1" "st1d" SveShape::Store, Any, move_: 8;
    "addv" "saddv" SveShape::Reduce, Signed, saddv: 1 2 4;
    "addv" "uaddv" SveShape::Reduce, Signed, uaddv: 8;
    "addv" "uaddv" SveShape::Reduce, Unsigned, uaddv: 1 2 4 8;
    "addv" "faddv" SveShape::Reduce, Float, faddv: 4 8;
    "dup" "dup" SveShape::Dup, Int, move_: 1 2 4 8;
    "dup" "dup" SveShape::Dup, Float, move_: 4 8;
};

pub(crate) fn get(i: usize) -> &'static SimdOp {
    &OPS[i]
}

/// The table index of the first row of builtin `name`, or `None` when it
/// is not an SVE builtin.
pub(crate) fn lookup(name: &str) -> Option<u32> {
    OPS.iter().position(|o| o.name == name).map(|i| i as u32)
}

/// The row of builtin `name` over lanes of `lane` bytes of element `kind`
/// whose shape `fits`: the index, or `None` where the family has none.
pub(crate) fn select(
    name: &str,
    lane: u8,
    kind: crate::c5::compiler::SveElem,
    fits: impl Fn(SveShape) -> bool,
) -> Option<u32> {
    use crate::c5::compiler::SveElem as E;
    OPS.iter()
        .position(|o| {
            let Form::Sve(f) = o.form else { return false };
            let takes = matches!(
                (f.elems, kind),
                (Any, _)
                    | (Int, E::Signed | E::Unsigned)
                    | (Signed, E::Signed)
                    | (Unsigned, E::Unsigned)
                    | (Float, E::Float)
            );
            o.name == name && o.int_width == lane && takes && fits(f.shape)
        })
        .map(|i| i as u32)
}
