//! The AArch64 Advanced SIMD intrinsic surface: one table row per
//! `__builtin_neon_<mnemonic>_<arrangement>` builtin the bundled
//! `<arm_neon.h>` calls. A row names the instruction and its arrangement;
//! the operand shape, result type and value semantics are the shared
//! vocabulary of [`super::simd`]. An instruction that does not depend on
//! the lanes' signedness has one row per arrangement, and the header casts
//! between the vector types of one width, which reinterprets the bits.

use super::simd::{FOp, Form, LongOp, NarrowKind, Ret, Sem, SimdOp};

/// The row of `mnem` over `bytes`-byte vectors of `ret`'s lanes.
const fn row(
    name: &'static str,
    mnem: &'static str,
    form: Form,
    ret: Ret,
    sem: Sem,
    bytes: u8,
) -> SimdOp {
    SimdOp {
        name,
        mnem,
        form,
        ret,
        sem,
        int_width: 0,
        bytes,
    }
}

/// `Sem::$s` over lanes of `$w` bytes, with the variant's other fields.
macro_rules! sem {
    ($s:ident, $w:expr, -) => {
        Sem::$s
    };
    (Float, $w:expr, [$op:ident]) => {
        Sem::Float(FOp::$op, $w, false)
    };
    ($s:ident, $w:expr, ()) => {
        Sem::$s($w)
    };
    ($s:ident, $w:expr, ($($x:expr),+)) => {
        Sem::$s($w, $($x),+)
    };
}

/// One row: the arrangement fixes the name suffix, the result type, the
/// vector width and the lane width.
macro_rules! arr {
    ($m:literal, $f:ident, $s:ident, $a:tt, b8) => {
        row(
            concat!("__builtin_neon_", $m, "_8b"),
            $m,
            Form::$f,
            Ret::V8qi,
            sem!($s, 1, $a),
            8,
        )
    };
    ($m:literal, $f:ident, $s:ident, $a:tt, b16) => {
        row(
            concat!("__builtin_neon_", $m, "_16b"),
            $m,
            Form::$f,
            Ret::V16qi,
            sem!($s, 1, $a),
            16,
        )
    };
    ($m:literal, $f:ident, $s:ident, $a:tt, h4) => {
        row(
            concat!("__builtin_neon_", $m, "_4h"),
            $m,
            Form::$f,
            Ret::V4hi,
            sem!($s, 2, $a),
            8,
        )
    };
    ($m:literal, $f:ident, $s:ident, $a:tt, h8) => {
        row(
            concat!("__builtin_neon_", $m, "_8h"),
            $m,
            Form::$f,
            Ret::V8hi,
            sem!($s, 2, $a),
            16,
        )
    };
    ($m:literal, $f:ident, $s:ident, $a:tt, s2) => {
        row(
            concat!("__builtin_neon_", $m, "_2s"),
            $m,
            Form::$f,
            Ret::V2si,
            sem!($s, 4, $a),
            8,
        )
    };
    ($m:literal, $f:ident, $s:ident, $a:tt, s4) => {
        row(
            concat!("__builtin_neon_", $m, "_4s"),
            $m,
            Form::$f,
            Ret::V4si,
            sem!($s, 4, $a),
            16,
        )
    };
    ($m:literal, $f:ident, $s:ident, $a:tt, d1) => {
        row(
            concat!("__builtin_neon_", $m, "_d"),
            $m,
            Form::$f,
            Ret::V1di,
            sem!($s, 8, $a),
            8,
        )
    };
    ($m:literal, $f:ident, $s:ident, $a:tt, f2s) => {
        row(
            concat!("__builtin_neon_", $m, "_2s"),
            $m,
            Form::$f,
            Ret::V2sf,
            sem!($s, 4, $a),
            8,
        )
    };
    ($m:literal, $f:ident, $s:ident, $a:tt, f4s) => {
        row(
            concat!("__builtin_neon_", $m, "_4s"),
            $m,
            Form::$f,
            Ret::V4sf,
            sem!($s, 4, $a),
            16,
        )
    };
    ($m:literal, $f:ident, $s:ident, $a:tt, fd) => {
        row(
            concat!("__builtin_neon_", $m, "_d"),
            $m,
            Form::$f,
            Ret::V1df,
            sem!($s, 8, $a),
            8,
        )
    };
    ($m:literal, $f:ident, $s:ident, $a:tt, f2d) => {
        row(
            concat!("__builtin_neon_", $m, "_2d"),
            $m,
            Form::$f,
            Ret::V2df,
            sem!($s, 8, $a),
            16,
        )
    };
    ($m:literal, $f:ident, $s:ident, $a:tt, d2) => {
        row(
            concat!("__builtin_neon_", $m, "_2d"),
            $m,
            Form::$f,
            Ret::V2di,
            sem!($s, 8, $a),
            16,
        )
    };
}

/// A widening row, named by its narrow arrangement: `Sem::$s` of `LongOp::$op`
/// over source lanes of `$w` bytes, signed when `$sg`, from the high half
/// when `$h`, into `$ret`.
macro_rules! long {
    ($m:literal, $f:ident, $s:ident, ($op:ident, $sg:expr), $arr:literal, $ret:ident, $w:expr, $b:expr, $h:expr) => {
        row(
            concat!("__builtin_neon_", $m, "_", $arr),
            $m,
            Form::$f,
            Ret::$ret,
            Sem::$s(LongOp::$op, $w, $sg, $h),
            $b,
        )
    };
}

/// The widening and narrowing rows of a family, over each source width:
/// `low` reads the low halves, `high` (the `2` instruction) the high ones,
/// and `narrow` names the wide source.
macro_rules! widening {
    ($($m:literal $f:ident $s:ident $a:tt : $part:ident;)*) => {
        &[$(widening!(@ $part, $m, $f, $s, $a)),*]
    };
    (@ low, $m:literal, $f:ident, $s:ident, $a:tt) => {
        [long!($m, $f, $s, $a, "8b", V8hi, 1, 8, false),
         long!($m, $f, $s, $a, "4h", V4si, 2, 8, false),
         long!($m, $f, $s, $a, "2s", V2di, 4, 8, false)]
    };
    (@ high, $m:literal, $f:ident, $s:ident, $a:tt) => {
        [long!($m, $f, $s, $a, "16b", V8hi, 1, 16, true),
         long!($m, $f, $s, $a, "8h", V4si, 2, 16, true),
         long!($m, $f, $s, $a, "4s", V2di, 4, 16, true)]
    };
}

/// The rows of each family, one per arrangement it lists: `d1` is the
/// scalar form over one 64-bit lane in a D register, and `f2s` .. `f2d`
/// the floating arrangements, `fd` the scalar double. `-` marks a
/// semantics without a lane width, `()` one with only the width, `[op]` a
/// floating operation.
macro_rules! table {
    ($($m:literal $f:ident $s:ident $a:tt : $($w:ident)*;)*) => {
        &[$($(arr!($m, $f, $s, $a, $w)),*),*]
    };
}

/// Every AArch64 SIMD builtin badc provides.
#[rustfmt::skip]
pub(crate) const OPS: &[SimdOp] = table! {
    "add" Vv Add (): b8 b16 h4 h8 s2 s4 d1 d2;
    "sub" Vv Sub (): b8 b16 h4 h8 s2 s4 d1 d2;
    "mul" Vv MulLo (): b8 b16 h4 h8 s2 s4;
    "sqadd" Vv AddSat (true): b8 b16 h4 h8 s2 s4 d1 d2;
    "uqadd" Vv AddSat (false): b8 b16 h4 h8 s2 s4 d1 d2;
    "sqsub" Vv SubSat (true): b8 b16 h4 h8 s2 s4 d1 d2;
    "uqsub" Vv SubSat (false): b8 b16 h4 h8 s2 s4 d1 d2;
    "shadd" Vv HalvingAdd (true, false): b8 b16 h4 h8 s2 s4;
    "uhadd" Vv HalvingAdd (false, false): b8 b16 h4 h8 s2 s4;
    "srhadd" Vv HalvingAdd (true, true): b8 b16 h4 h8 s2 s4;
    "urhadd" Vv HalvingAdd (false, true): b8 b16 h4 h8 s2 s4;
    "shsub" Vv HalvingSub (true): b8 b16 h4 h8 s2 s4;
    "uhsub" Vv HalvingSub (false): b8 b16 h4 h8 s2 s4;
    "sabd" Vv AbsDiff (true): b8 b16 h4 h8 s2 s4;
    "uabd" Vv AbsDiff (false): b8 b16 h4 h8 s2 s4;
    "smax" Vv Max (true): b8 b16 h4 h8 s2 s4;
    "umax" Vv Max (false): b8 b16 h4 h8 s2 s4;
    "smin" Vv Min (true): b8 b16 h4 h8 s2 s4;
    "umin" Vv Min (false): b8 b16 h4 h8 s2 s4;
    "addp" Vv HAdd (false): b8 b16 h4 h8 s2 s4 d2;
    "smaxp" Vv PairMax (true): b8 b16 h4 h8 s2 s4;
    "umaxp" Vv PairMax (false): b8 b16 h4 h8 s2 s4;
    "sminp" Vv PairMin (true): b8 b16 h4 h8 s2 s4;
    "uminp" Vv PairMin (false): b8 b16 h4 h8 s2 s4;
    "and" Vv And -: b8 b16;
    "orr" Vv Or -: b8 b16;
    "eor" Vv Xor -: b8 b16;
    "bic" Vv BitClear -: b8 b16;
    "orn" Vv OrNot -: b8 b16;
    "cmeq" Vv CmpEq (): b8 b16 h4 h8 s2 s4 d1 d2;
    "cmgt" Vv CmpGt (): b8 b16 h4 h8 s2 s4 d1 d2;
    "cmge" Vv CmpGe (): b8 b16 h4 h8 s2 s4 d1 d2;
    "cmhi" Vv CmpHi (): b8 b16 h4 h8 s2 s4 d1 d2;
    "cmhs" Vv CmpHs (): b8 b16 h4 h8 s2 s4 d1 d2;
    "cmtst" Vv CmpTst (): b8 b16 h4 h8 s2 s4 d1 d2;
    "neg" V Neg (): b8 b16 h4 h8 s2 s4 d1 d2;
    "abs" V Abs (): b8 b16 h4 h8 s2 s4 d1 d2;
    "sqneg" V NegSat (): b8 b16 h4 h8 s2 s4 d1 d2;
    "sqabs" V AbsSat (): b8 b16 h4 h8 s2 s4 d1 d2;
    "clz" V Clz (): b8 b16 h4 h8 s2 s4;
    "cls" V Cls (): b8 b16 h4 h8 s2 s4;
    "cnt" V PopCnt -: b8 b16;
    "mvn" V Not -: b8 b16;
    "mla" Vvv MulAcc (): b8 b16 h4 h8 s2 s4;
    "mls" Vvv MulSub (): b8 b16 h4 h8 s2 s4;
    "saba" Vvv AbsDiffAcc (true): b8 b16 h4 h8 s2 s4;
    "uaba" Vvv AbsDiffAcc (false): b8 b16 h4 h8 s2 s4;
    "bsl" Vvv BitSelect -: b8 b16;
    "shl" Shift Shl (): b8 b16 h4 h8 s2 s4 d1 d2;
    "sshl" Vv ShlReg (true, false, false): b8 b16 h4 h8 s2 s4 d1 d2;
    "ushl" Vv ShlReg (false, false, false): b8 b16 h4 h8 s2 s4 d1 d2;
    "srshl" Vv ShlReg (true, true, false): b8 b16 h4 h8 s2 s4 d1 d2;
    "urshl" Vv ShlReg (false, true, false): b8 b16 h4 h8 s2 s4 d1 d2;
    "sqshl" Vv ShlReg (true, false, true): b8 b16 h4 h8 s2 s4 d1 d2;
    "uqshl" Vv ShlReg (false, false, true): b8 b16 h4 h8 s2 s4 d1 d2;
    "sshr" Shift Sar (): b8 b16 h4 h8 s2 s4 d1 d2;
    "ushr" Shift Shr (): b8 b16 h4 h8 s2 s4 d1 d2;
    "fadd" Vv Float [Add]: f2s f4s fd f2d;
    "fsub" Vv Float [Sub]: f2s f4s fd f2d;
    "fmul" Vv Float [Mul]: f2s f4s fd f2d;
    "fdiv" Vv Float [Div]: f2s f4s fd f2d;
    "fmax" Vv Float [MaxNan]: f2s f4s fd f2d;
    "fmin" Vv Float [MinNan]: f2s f4s fd f2d;
    "fsqrt" V Float [Sqrt]: f2s f4s fd f2d;
    "fabs" V FAbs (): f2s f4s fd f2d;
    "fneg" V FNeg (): f2s f4s fd f2d;
    "fcmeq" Vv FloatRel (0): f2s f4s f2d;
    "fcmge" Vv FloatRel (13): f2s f4s f2d;
    "fcmgt" Vv FloatRel (14): f2s f4s f2d;
    "fmla" Vvv FloatFma (false): f2s f4s f2d;
    "fmls" Vvv FloatFma (true): f2s f4s f2d;
};

/// The widening forms, three source widths each.
#[rustfmt::skip]
const LONG: &[[SimdOp; 3]] = widening! {
    "saddl" Vv Long (Add, true): low;
    "uaddl" Vv Long (Add, false): low;
    "ssubl" Vv Long (Sub, true): low;
    "usubl" Vv Long (Sub, false): low;
    "smull" Vv Long (Mul, true): low;
    "umull" Vv Long (Mul, false): low;
    "saddl2" Vv Long (Add, true): high;
    "uaddl2" Vv Long (Add, false): high;
    "ssubl2" Vv Long (Sub, true): high;
    "usubl2" Vv Long (Sub, false): high;
    "smull2" Vv Long (Mul, true): high;
    "umull2" Vv Long (Mul, false): high;
    "saddw" Vv Wide (Add, true): low;
    "uaddw" Vv Wide (Add, false): low;
    "ssubw" Vv Wide (Sub, true): low;
    "usubw" Vv Wide (Sub, false): low;
    "saddw2" Vv Wide (Add, true): high;
    "uaddw2" Vv Wide (Add, false): high;
    "ssubw2" Vv Wide (Sub, true): high;
    "usubw2" Vv Wide (Sub, false): high;
    "smlal" Vvv LongAcc (Mul, true): low;
    "umlal" Vvv LongAcc (Mul, false): low;
    "smlsl" Vvv LongAcc (MulSub, true): low;
    "umlsl" Vvv LongAcc (MulSub, false): low;
    "sabdl" Vv Long (AbsDiff, true): low;
    "uabdl" Vv Long (AbsDiff, false): low;
    "sabdl2" Vv Long (AbsDiff, true): high;
    "uabdl2" Vv Long (AbsDiff, false): high;
    "sabal" Vvv LongAcc (AbsDiff, true): low;
    "uabal" Vvv LongAcc (AbsDiff, false): low;
    "sabal2" Vvv LongAcc (AbsDiff, true): high;
    "uabal2" Vvv LongAcc (AbsDiff, false): high;
    "smlal2" Vvv LongAcc (Mul, true): high;
    "umlal2" Vvv LongAcc (Mul, false): high;
    "smlsl2" Vvv LongAcc (MulSub, true): high;
    "umlsl2" Vvv LongAcc (MulSub, false): high;
};

/// A narrowing row, named by its wide source arrangement.
const fn narrow(
    name: &'static str,
    mnem: &'static str,
    ret: Ret,
    w: u8,
    kind: NarrowKind,
) -> SimdOp {
    row(name, mnem, Form::V, ret, Sem::Narrow(w, kind), 16)
}

/// A lengthening move, named by its narrow source arrangement.
const fn extend(name: &'static str, mnem: &'static str, ret: Ret, w: u8, signed: bool) -> SimdOp {
    row(name, mnem, Form::V, ret, Sem::Extend(w, 2 * w, signed), 8)
}

#[rustfmt::skip]
const NARROW: &[SimdOp] = &[
    narrow("__builtin_neon_xtn_8h", "xtn", Ret::V8qi, 2, NarrowKind::Trunc),
    narrow("__builtin_neon_xtn_4s", "xtn", Ret::V4hi, 4, NarrowKind::Trunc),
    narrow("__builtin_neon_xtn_2d", "xtn", Ret::V2si, 8, NarrowKind::Trunc),
    narrow("__builtin_neon_sqxtn_8h", "sqxtn", Ret::V8qi, 2, NarrowKind::SatSigned),
    narrow("__builtin_neon_sqxtn_4s", "sqxtn", Ret::V4hi, 4, NarrowKind::SatSigned),
    narrow("__builtin_neon_sqxtn_2d", "sqxtn", Ret::V2si, 8, NarrowKind::SatSigned),
    narrow("__builtin_neon_uqxtn_8h", "uqxtn", Ret::V8qi, 2, NarrowKind::SatUns),
    narrow("__builtin_neon_uqxtn_4s", "uqxtn", Ret::V4hi, 4, NarrowKind::SatUns),
    narrow("__builtin_neon_uqxtn_2d", "uqxtn", Ret::V2si, 8, NarrowKind::SatUns),
    narrow("__builtin_neon_sqxtun_8h", "sqxtun", Ret::V8qi, 2, NarrowKind::SatSignedToUns),
    narrow("__builtin_neon_sqxtun_4s", "sqxtun", Ret::V4hi, 4, NarrowKind::SatSignedToUns),
    narrow("__builtin_neon_sqxtun_2d", "sqxtun", Ret::V2si, 8, NarrowKind::SatSignedToUns),
    extend("__builtin_neon_sxtl_8b", "sxtl", Ret::V8hi, 1, true),
    extend("__builtin_neon_sxtl_4h", "sxtl", Ret::V4si, 2, true),
    extend("__builtin_neon_sxtl_2s", "sxtl", Ret::V2di, 4, true),
    extend("__builtin_neon_uxtl_8b", "uxtl", Ret::V8hi, 1, false),
    extend("__builtin_neon_uxtl_4h", "uxtl", Ret::V4si, 2, false),
    extend("__builtin_neon_uxtl_2s", "uxtl", Ret::V2di, 4, false),
];

/// The row at index `i` of the rows [`OPS`], then the widening and the
/// narrowing ones, numbered in that order.
pub(crate) fn get(i: usize) -> &'static SimdOp {
    let long = LONG.len() * 3;
    if i < OPS.len() {
        &OPS[i]
    } else if i < OPS.len() + long {
        let k = i - OPS.len();
        &LONG[k / 3][k % 3]
    } else {
        &NARROW[i - OPS.len() - long]
    }
}

/// Every AArch64 row, in [`get`]'s numbering.
pub(crate) fn rows() -> impl Iterator<Item = &'static SimdOp> {
    OPS.iter().chain(LONG.iter().flatten()).chain(NARROW)
}

/// The table index of `name`, or `None` when it is not an AArch64 SIMD
/// builtin.
pub(crate) fn lookup(name: &str) -> Option<u32> {
    rows().position(|o| o.name == name).map(|i| i as u32)
}
