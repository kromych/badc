//! The AArch64 SVE intrinsic surface: the rows of the `__builtin_sve_*`
//! builtins the bundled `<arm_sve.h>` calls. A builtin names a family of
//! rows, one per lane width and element kind, and the first operand of a
//! typed family is the SVE type that selects the row and types the result.
//! The shapes and semantics are the shared vocabulary of [`super::simd`].

use super::simd::{
    AcrossOp, Addend, FOp, Form, PermOp, Ret, Sem, SimdOp, SveElems, SveForm, SvePred, SveShape,
    SveTest,
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
const fn fdiv(w: u8) -> Sem {
    Sem::Float(FOp::Div, w, false)
}
const fn fmin(w: u8) -> Sem {
    Sem::Float(FOp::MinNan, w, false)
}
const fn fmax(w: u8) -> Sem {
    Sem::Float(FOp::MaxNan, w, false)
}
const fn fminnm(w: u8) -> Sem {
    Sem::Float(FOp::MinNum, w, false)
}
const fn fmaxnm(w: u8) -> Sem {
    Sem::Float(FOp::MaxNum, w, false)
}
const fn sdiv(w: u8) -> Sem {
    Sem::Div(w, true)
}
const fn udiv(w: u8) -> Sem {
    Sem::Div(w, false)
}
const fn smin(w: u8) -> Sem {
    Sem::Min(w, true)
}
const fn umin(w: u8) -> Sem {
    Sem::Min(w, false)
}
const fn smax(w: u8) -> Sem {
    Sem::Max(w, true)
}
const fn umax(w: u8) -> Sem {
    Sem::Max(w, false)
}
const fn lsl(w: u8) -> Sem {
    Sem::ShlVar(w)
}
const fn lsr(w: u8) -> Sem {
    Sem::ShrVar(w)
}
const fn asr(w: u8) -> Sem {
    Sem::SarVar(w)
}
const fn zip1(w: u8) -> Sem {
    Sem::Perm(PermOp::Zip, w, false, 0)
}
const fn zip2(w: u8) -> Sem {
    Sem::Perm(PermOp::Zip, w, true, 0)
}
const fn uzp1(w: u8) -> Sem {
    Sem::Perm(PermOp::Uzp, w, false, 0)
}
const fn uzp2(w: u8) -> Sem {
    Sem::Perm(PermOp::Uzp, w, true, 0)
}
const fn trn1(w: u8) -> Sem {
    Sem::Perm(PermOp::Trn, w, false, 0)
}
const fn trn2(w: u8) -> Sem {
    Sem::Perm(PermOp::Trn, w, true, 0)
}
const fn rev(w: u8) -> Sem {
    Sem::Rev(w, 0)
}
const fn not(_: u8) -> Sem {
    Sem::Not
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
const fn smaxv(w: u8) -> Sem {
    Sem::Across(AcrossOp::Max, w, true, 0)
}
const fn umaxv(w: u8) -> Sem {
    Sem::Across(AcrossOp::Max, w, false, 0)
}
const fn sminv(w: u8) -> Sem {
    Sem::Across(AcrossOp::Min, w, true, 0)
}
const fn uminv(w: u8) -> Sem {
    Sem::Across(AcrossOp::Min, w, false, 0)
}
const fn sandv(w: u8) -> Sem {
    Sem::Across(AcrossOp::And, w, true, 0)
}
const fn uandv(w: u8) -> Sem {
    Sem::Across(AcrossOp::And, w, false, 0)
}
const fn sorv(w: u8) -> Sem {
    Sem::Across(AcrossOp::Or, w, true, 0)
}
const fn uorv(w: u8) -> Sem {
    Sem::Across(AcrossOp::Or, w, false, 0)
}
const fn seorv(w: u8) -> Sem {
    Sem::Across(AcrossOp::Xor, w, true, 0)
}
const fn ueorv(w: u8) -> Sem {
    Sem::Across(AcrossOp::Xor, w, false, 0)
}
const fn fmaxv(w: u8) -> Sem {
    Sem::FloatAcross(FOp::MaxNan, w)
}
const fn fminv(w: u8) -> Sem {
    Sem::FloatAcross(FOp::MinNan, w)
}
const fn fmaxnmv(w: u8) -> Sem {
    Sem::FloatAcross(FOp::MaxNum, w)
}
const fn fminnmv(w: u8) -> Sem {
    Sem::FloatAcross(FOp::MinNum, w)
}
const fn sabd(w: u8) -> Sem {
    Sem::AbsDiff(w, true)
}
const fn uabd(w: u8) -> Sem {
    Sem::AbsDiff(w, false)
}
const fn fabd(w: u8) -> Sem {
    Sem::Float(FOp::AbsDiff, w, false)
}
const fn smulh(w: u8) -> Sem {
    Sem::MulHi(w, true)
}
const fn umulh(w: u8) -> Sem {
    Sem::MulHi(w, false)
}
const fn fsqrt(w: u8) -> Sem {
    Sem::Float(FOp::Sqrt, w, false)
}
const fn mla(w: u8) -> Sem {
    Sem::MulAcc(w)
}
const fn mls(w: u8) -> Sem {
    Sem::MulSub(w)
}
/// The fused forms, as the first factor and the addend are negated.
const fn fmla(w: u8) -> Sem {
    Sem::FloatFma(w, false, Addend::Plus)
}
const fn fmls(w: u8) -> Sem {
    Sem::FloatFma(w, true, Addend::Plus)
}
const fn fnmla(w: u8) -> Sem {
    Sem::FloatFma(w, true, Addend::Minus)
}
const fn fnmls(w: u8) -> Sem {
    Sem::FloatFma(w, false, Addend::Minus)
}
const fn sqadd(w: u8) -> Sem {
    Sem::AddSat(w, true)
}
const fn uqadd(w: u8) -> Sem {
    Sem::AddSat(w, false)
}
const fn sqsub(w: u8) -> Sem {
    Sem::SubSat(w, true)
}
const fn uqsub(w: u8) -> Sem {
    Sem::SubSat(w, false)
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
    "bic_m" "bic" SveShape::Binary(M), Int, bic: 1 2 4 8;
    "bic_z" "bic" SveShape::Binary(Z), Int, bic: 1 2 4 8;
    "bic_z" "bic" SveShape::PredLogic, Any, bic: 1;
    "bic_x" "bic" SveShape::Binary(X), Int, bic: 1 2 4 8;
    "orn_z" "orn" SveShape::PredLogic, Any, orn: 1;
    "nand_z" "nand" SveShape::PredLogic, Any, nand: 1;
    "nor_z" "nor" SveShape::PredLogic, Any, nor: 1;
    "not_m" "not" SveShape::Unary(M), Int, not: 1 2 4 8;
    "not_z" "not" SveShape::Unary(Z), Int, not: 1 2 4 8;
    "not_z" "not" SveShape::PredNot, Any, eor: 1;
    "not_x" "not" SveShape::Unary(X), Int, not: 1 2 4 8;
    "abs_m" "abs" SveShape::Unary(M), Signed, Sem::Abs: 1 2 4 8;
    "abs_m" "fabs" SveShape::Unary(M), Float, Sem::FAbs: 4 8;
    "abs_z" "abs" SveShape::Unary(Z), Signed, Sem::Abs: 1 2 4 8;
    "abs_z" "fabs" SveShape::Unary(Z), Float, Sem::FAbs: 4 8;
    "abs_x" "abs" SveShape::Unary(X), Signed, Sem::Abs: 1 2 4 8;
    "abs_x" "fabs" SveShape::Unary(X), Float, Sem::FAbs: 4 8;
    "neg_m" "neg" SveShape::Unary(M), Signed, Sem::Neg: 1 2 4 8;
    "neg_m" "fneg" SveShape::Unary(M), Float, Sem::FNeg: 4 8;
    "neg_z" "neg" SveShape::Unary(Z), Signed, Sem::Neg: 1 2 4 8;
    "neg_z" "fneg" SveShape::Unary(Z), Float, Sem::FNeg: 4 8;
    "neg_x" "neg" SveShape::Unary(X), Signed, Sem::Neg: 1 2 4 8;
    "neg_x" "fneg" SveShape::Unary(X), Float, Sem::FNeg: 4 8;
    "div_m" "sdiv" SveShape::Binary(M), Signed, sdiv: 4 8;
    "div_m" "udiv" SveShape::Binary(M), Unsigned, udiv: 4 8;
    "div_m" "fdiv" SveShape::Binary(M), Float, fdiv: 4 8;
    "div_z" "sdiv" SveShape::Binary(Z), Signed, sdiv: 4 8;
    "div_z" "udiv" SveShape::Binary(Z), Unsigned, udiv: 4 8;
    "div_z" "fdiv" SveShape::Binary(Z), Float, fdiv: 4 8;
    "div_x" "sdiv" SveShape::Binary(X), Signed, sdiv: 4 8;
    "div_x" "udiv" SveShape::Binary(X), Unsigned, udiv: 4 8;
    "div_x" "fdiv" SveShape::Binary(X), Float, fdiv: 4 8;
    "min_m" "smin" SveShape::Binary(M), Signed, smin: 1 2 4 8;
    "min_m" "umin" SveShape::Binary(M), Unsigned, umin: 1 2 4 8;
    "min_m" "fmin" SveShape::Binary(M), Float, fmin: 4 8;
    "min_z" "smin" SveShape::Binary(Z), Signed, smin: 1 2 4 8;
    "min_z" "umin" SveShape::Binary(Z), Unsigned, umin: 1 2 4 8;
    "min_z" "fmin" SveShape::Binary(Z), Float, fmin: 4 8;
    "min_x" "smin" SveShape::Binary(X), Signed, smin: 1 2 4 8;
    "min_x" "umin" SveShape::Binary(X), Unsigned, umin: 1 2 4 8;
    "min_x" "fmin" SveShape::Binary(X), Float, fmin: 4 8;
    "max_m" "smax" SveShape::Binary(M), Signed, smax: 1 2 4 8;
    "max_m" "umax" SveShape::Binary(M), Unsigned, umax: 1 2 4 8;
    "max_m" "fmax" SveShape::Binary(M), Float, fmax: 4 8;
    "max_z" "smax" SveShape::Binary(Z), Signed, smax: 1 2 4 8;
    "max_z" "umax" SveShape::Binary(Z), Unsigned, umax: 1 2 4 8;
    "max_z" "fmax" SveShape::Binary(Z), Float, fmax: 4 8;
    "max_x" "smax" SveShape::Binary(X), Signed, smax: 1 2 4 8;
    "max_x" "umax" SveShape::Binary(X), Unsigned, umax: 1 2 4 8;
    "max_x" "fmax" SveShape::Binary(X), Float, fmax: 4 8;
    "lsl_m" "lsl" SveShape::Binary(M), Int, lsl: 1 2 4 8;
    "lsl_z" "lsl" SveShape::Binary(Z), Int, lsl: 1 2 4 8;
    "lsl_x" "lsl" SveShape::Binary(X), Int, lsl: 1 2 4 8;
    "lsr_m" "lsr" SveShape::Binary(M), Unsigned, lsr: 1 2 4 8;
    "lsr_z" "lsr" SveShape::Binary(Z), Unsigned, lsr: 1 2 4 8;
    "lsr_x" "lsr" SveShape::Binary(X), Unsigned, lsr: 1 2 4 8;
    "asr_m" "asr" SveShape::Binary(M), Signed, asr: 1 2 4 8;
    "asr_z" "asr" SveShape::Binary(Z), Signed, asr: 1 2 4 8;
    "asr_x" "asr" SveShape::Binary(X), Signed, asr: 1 2 4 8;
    "minnm_m" "fminnm" SveShape::Binary(M), Float, fminnm: 4 8;
    "minnm_z" "fminnm" SveShape::Binary(Z), Float, fminnm: 4 8;
    "minnm_x" "fminnm" SveShape::Binary(X), Float, fminnm: 4 8;
    "maxnm_m" "fmaxnm" SveShape::Binary(M), Float, fmaxnm: 4 8;
    "maxnm_z" "fmaxnm" SveShape::Binary(Z), Float, fmaxnm: 4 8;
    "maxnm_x" "fmaxnm" SveShape::Binary(X), Float, fmaxnm: 4 8;
    "abd_m" "sabd" SveShape::Binary(M), Signed, sabd: 1 2 4 8;
    "abd_m" "uabd" SveShape::Binary(M), Unsigned, uabd: 1 2 4 8;
    "abd_m" "fabd" SveShape::Binary(M), Float, fabd: 4 8;
    "abd_z" "sabd" SveShape::Binary(Z), Signed, sabd: 1 2 4 8;
    "abd_z" "uabd" SveShape::Binary(Z), Unsigned, uabd: 1 2 4 8;
    "abd_z" "fabd" SveShape::Binary(Z), Float, fabd: 4 8;
    "abd_x" "sabd" SveShape::Binary(X), Signed, sabd: 1 2 4 8;
    "abd_x" "uabd" SveShape::Binary(X), Unsigned, uabd: 1 2 4 8;
    "abd_x" "fabd" SveShape::Binary(X), Float, fabd: 4 8;
    "mulh_m" "smulh" SveShape::Binary(M), Signed, smulh: 1 2 4 8;
    "mulh_m" "umulh" SveShape::Binary(M), Unsigned, umulh: 1 2 4 8;
    "mulh_z" "smulh" SveShape::Binary(Z), Signed, smulh: 1 2 4 8;
    "mulh_z" "umulh" SveShape::Binary(Z), Unsigned, umulh: 1 2 4 8;
    "mulh_x" "smulh" SveShape::Binary(X), Signed, smulh: 1 2 4 8;
    "mulh_x" "umulh" SveShape::Binary(X), Unsigned, umulh: 1 2 4 8;
    "sqrt_m" "fsqrt" SveShape::Unary(M), Float, fsqrt: 4 8;
    "sqrt_z" "fsqrt" SveShape::Unary(Z), Float, fsqrt: 4 8;
    "sqrt_x" "fsqrt" SveShape::Unary(X), Float, fsqrt: 4 8;
    "mla_m" "mla" SveShape::Ternary(M, false), Int, mla: 1 2 4 8;
    "mla_m" "fmla" SveShape::Ternary(M, false), Float, fmla: 4 8;
    "mla_z" "mla" SveShape::Ternary(Z, false), Int, mla: 1 2 4 8;
    "mla_z" "fmla" SveShape::Ternary(Z, false), Float, fmla: 4 8;
    "mla_x" "mla" SveShape::Ternary(X, false), Int, mla: 1 2 4 8;
    "mla_x" "fmla" SveShape::Ternary(X, false), Float, fmla: 4 8;
    "mls_m" "mls" SveShape::Ternary(M, false), Int, mls: 1 2 4 8;
    "mls_m" "fmls" SveShape::Ternary(M, false), Float, fmls: 4 8;
    "mls_z" "mls" SveShape::Ternary(Z, false), Int, mls: 1 2 4 8;
    "mls_z" "fmls" SveShape::Ternary(Z, false), Float, fmls: 4 8;
    "mls_x" "mls" SveShape::Ternary(X, false), Int, mls: 1 2 4 8;
    "mls_x" "fmls" SveShape::Ternary(X, false), Float, fmls: 4 8;
    "mad_m" "mad" SveShape::Ternary(M, true), Int, mla: 1 2 4 8;
    "mad_m" "fmad" SveShape::Ternary(M, true), Float, fmla: 4 8;
    "mad_z" "mad" SveShape::Ternary(Z, true), Int, mla: 1 2 4 8;
    "mad_z" "fmad" SveShape::Ternary(Z, true), Float, fmla: 4 8;
    "mad_x" "mad" SveShape::Ternary(X, true), Int, mla: 1 2 4 8;
    "mad_x" "fmad" SveShape::Ternary(X, true), Float, fmla: 4 8;
    "msb_m" "msb" SveShape::Ternary(M, true), Int, mls: 1 2 4 8;
    "msb_m" "fmsb" SveShape::Ternary(M, true), Float, fmls: 4 8;
    "msb_z" "msb" SveShape::Ternary(Z, true), Int, mls: 1 2 4 8;
    "msb_z" "fmsb" SveShape::Ternary(Z, true), Float, fmls: 4 8;
    "msb_x" "msb" SveShape::Ternary(X, true), Int, mls: 1 2 4 8;
    "msb_x" "fmsb" SveShape::Ternary(X, true), Float, fmls: 4 8;
    "nmla_m" "fnmla" SveShape::Ternary(M, false), Float, fnmla: 4 8;
    "nmla_z" "fnmla" SveShape::Ternary(Z, false), Float, fnmla: 4 8;
    "nmla_x" "fnmla" SveShape::Ternary(X, false), Float, fnmla: 4 8;
    "nmls_m" "fnmls" SveShape::Ternary(M, false), Float, fnmls: 4 8;
    "nmls_z" "fnmls" SveShape::Ternary(Z, false), Float, fnmls: 4 8;
    "nmls_x" "fnmls" SveShape::Ternary(X, false), Float, fnmls: 4 8;
    "nmad_m" "fnmad" SveShape::Ternary(M, true), Float, fnmla: 4 8;
    "nmad_z" "fnmad" SveShape::Ternary(Z, true), Float, fnmla: 4 8;
    "nmad_x" "fnmad" SveShape::Ternary(X, true), Float, fnmla: 4 8;
    "nmsb_m" "fnmsb" SveShape::Ternary(M, true), Float, fnmls: 4 8;
    "nmsb_z" "fnmsb" SveShape::Ternary(Z, true), Float, fnmls: 4 8;
    "nmsb_x" "fnmsb" SveShape::Ternary(X, true), Float, fnmls: 4 8;
    "qadd" "sqadd" SveShape::Lanewise, Signed, sqadd: 1 2 4 8;
    "qadd" "uqadd" SveShape::Lanewise, Unsigned, uqadd: 1 2 4 8;
    "qsub" "sqsub" SveShape::Lanewise, Signed, sqsub: 1 2 4 8;
    "qsub" "uqsub" SveShape::Lanewise, Unsigned, uqsub: 1 2 4 8;
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
    "maxv" "smaxv" SveShape::Reduce, Signed, smaxv: 1 2 4 8;
    "maxv" "umaxv" SveShape::Reduce, Unsigned, umaxv: 1 2 4 8;
    "maxv" "fmaxv" SveShape::Reduce, Float, fmaxv: 4 8;
    "minv" "sminv" SveShape::Reduce, Signed, sminv: 1 2 4 8;
    "minv" "uminv" SveShape::Reduce, Unsigned, uminv: 1 2 4 8;
    "minv" "fminv" SveShape::Reduce, Float, fminv: 4 8;
    "maxnmv" "fmaxnmv" SveShape::Reduce, Float, fmaxnmv: 4 8;
    "minnmv" "fminnmv" SveShape::Reduce, Float, fminnmv: 4 8;
    "andv" "andv" SveShape::Reduce, Signed, sandv: 1 2 4 8;
    "andv" "andv" SveShape::Reduce, Unsigned, uandv: 1 2 4 8;
    "orv" "orv" SveShape::Reduce, Signed, sorv: 1 2 4 8;
    "orv" "orv" SveShape::Reduce, Unsigned, uorv: 1 2 4 8;
    "eorv" "eorv" SveShape::Reduce, Signed, seorv: 1 2 4 8;
    "eorv" "eorv" SveShape::Reduce, Unsigned, ueorv: 1 2 4 8;
    "dup" "dup" SveShape::Dup, Int, move_: 1 2 4 8;
    "dup" "dup" SveShape::Dup, Float, move_: 4 8;
    "dup_lane" "tbl" SveShape::DupLane, Any, Sem::Tbl: 1 2 4 8;
    "reinterpret" "mov" SveShape::Reinterpret, Any, move_: 1 2 4 8;
    "zip1" "zip1" SveShape::Permute, Any, zip1: 1 2 4 8;
    "zip2" "zip2" SveShape::Permute, Any, zip2: 1 2 4 8;
    "uzp1" "uzp1" SveShape::Permute, Any, uzp1: 1 2 4 8;
    "uzp2" "uzp2" SveShape::Permute, Any, uzp2: 1 2 4 8;
    "trn1" "trn1" SveShape::Permute, Any, trn1: 1 2 4 8;
    "trn2" "trn2" SveShape::Permute, Any, trn2: 1 2 4 8;
    "rev" "rev" SveShape::Reverse, Any, rev: 1 2 4 8;
    "ext" "ext" SveShape::Extract, Any, Sem::Ext: 1 2 4 8;
};

pub(crate) fn get(i: usize) -> &'static SimdOp {
    &OPS[i]
}

/// The immediate of an SVE instruction: an integer as the assembler writes
/// it, `#0.0` being the integer zero, or a floating constant's 8-bit code.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum SveImm {
    Int(i64),
    Fp(u8),
}

/// The instruction and immediate with which row `op` takes operand `k`
/// that holds `lane`, the bits of a lane, in every lane (Arm ARM, the SVE
/// immediate forms): the unpredicated integer and the predicated floating
/// arithmetic, the shifts, the compares, DUP, FDUP and DUPM of a scalar,
/// and DUP (indexed) of a lane index.
pub(crate) fn immediate(op: u32, k: usize, lane: u64) -> Option<(&'static str, SveImm)> {
    use super::codegen::aarch64::encode::{encode_logical_imm, fp_imm8};
    let row = super::simd::get(op);
    let Form::Sve(f) = row.form else {
        return None;
    };
    let bits = 8 * u32::from(row.int_width);
    let mask = u64::MAX >> (64 - bits);
    let lane = lane & mask;
    let signed = ((lane << (64 - bits)) as i64) >> (64 - bits);
    let negated = lane.wrapping_neg() & mask;
    // ADD, SUB and DUP take a byte, shifted left by 8 above byte lanes.
    let byte = |v: i64, lo: i64| {
        (lo..=lo + 255).contains(&v)
            || bits > 8 && v & 0xff == 0 && (lo..=lo + 255).contains(&(v >> 8))
    };
    let logical = |v: u64| {
        let (mut rep, mut w) = (v, bits);
        while w < 64 {
            rep |= rep << w;
            w *= 2;
        }
        encode_logical_imm(rep, true).is_some()
    };
    let int = |m: &'static str, v: i64| Some((m, SveImm::Int(v)));
    let in_simm8 = (-128..=127).contains(&signed);
    match (f.shape, k) {
        (SveShape::Binary(_), 2) if f.elems == Float => {
            let pair = match row.mnem {
                "fadd" | "fsub" => [0.5, 1.0],
                "fmul" => [0.5, 2.0],
                "fmax" | "fmin" | "fmaxnm" | "fminnm" => [0.0, 1.0],
                _ => return None,
            };
            let of = |x: f64| match bits {
                32 => u64::from((x as f32).to_bits()),
                _ => x.to_bits(),
            };
            match pair.into_iter().find(|&x| of(x) == lane)? {
                0.0 => int(row.mnem, 0),
                _ => Some((row.mnem, SveImm::Fp(fp_imm8(lane, bits == 32)?))),
            }
        }
        (SveShape::Binary(mode), 2) => match row.mnem {
            // A count of the lane's width or more shifts every bit out,
            // which LSR and ASR by the width do; a zero count is LSL #0.
            "lsl" => (lane < u64::from(bits)).then_some(("lsl", SveImm::Int(lane as i64))),
            "lsr" | "asr" if lane == 0 => int("lsl", 0),
            "lsr" | "asr" => int(row.mnem, lane.min(u64::from(bits)) as i64),
            _ if mode != SvePred::Any => None,
            "add" | "sub" if byte(lane as i64, 0) => int(row.mnem, lane as i64),
            "add" if byte(negated as i64, 0) => int("sub", negated as i64),
            "sub" if byte(negated as i64, 0) => int("add", negated as i64),
            "mul" | "smin" | "smax" if in_simm8 => int(row.mnem, signed),
            "umin" | "umax" if lane <= 0xff => int(row.mnem, lane as i64),
            "and" | "orr" | "eor" if logical(lane) => int(row.mnem, lane as i64),
            "bic" if logical(!lane & mask) => int("and", (!lane & mask) as i64),
            _ => None,
        },
        // The saturating forms add or subtract an unsigned byte: a signed
        // sum of a negative constant is the difference of its negation.
        (SveShape::Lanewise, 1) => match row.mnem {
            "uqadd" | "uqsub" if byte(lane as i64, 0) => int(row.mnem, lane as i64),
            "sqadd" | "sqsub" if byte(signed, 0) => int(row.mnem, signed),
            "sqadd" if byte(signed.wrapping_neg(), 0) => int("sqsub", signed.wrapping_neg()),
            "sqsub" if byte(signed.wrapping_neg(), 0) => int("sqadd", signed.wrapping_neg()),
            _ => None,
        },
        (SveShape::Compare, 1 | 2) => {
            // An immediate stands second: a first operand swaps the relation.
            let mnem = match (k, row.mnem) {
                (2, m) | (_, m @ ("cmpeq" | "cmpne" | "fcmeq" | "fcmne")) => m,
                (_, "cmpgt") => "cmplt",
                (_, "cmpge") => "cmple",
                (_, "cmphi") => "cmplo",
                (_, "cmphs") => "cmpls",
                (_, "fcmgt") => "fcmlt",
                (_, "fcmge") => "fcmle",
                _ => return None,
            };
            let imm = match f.elems {
                // Either zero compares as zero.
                Float => (lane & (mask >> 1) == 0).then_some(0),
                Unsigned => (lane <= 127).then_some(lane as i64),
                _ => (-16..=15).contains(&signed).then_some(signed),
            };
            Some((mnem, SveImm::Int(imm?)))
        }
        (SveShape::Dup, 0) => match (f.elems == Float)
            .then(|| fp_imm8(lane, bits == 32))
            .flatten()
        {
            Some(code) => Some(("fdup", SveImm::Fp(code))),
            None if byte(signed, -128) => int("dup", signed),
            None => logical(lane).then_some(("dupm", SveImm::Int(lane as i64))),
        },
        // DUP (indexed) reaches the lanes of 512 bits.
        (SveShape::DupLane, 1) => {
            (lane < 64 / u64::from(row.int_width)).then_some(("dup", SveImm::Int(lane as i64)))
        }
        _ => None,
    }
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
