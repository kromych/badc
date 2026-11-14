//! The AArch64 Advanced SIMD intrinsic surface: one table row per
//! `__builtin_neon_<mnemonic>_<arrangement>` builtin the bundled
//! `<arm_neon.h>` calls. A row names the instruction and its arrangement;
//! the operand shape, result type and value semantics are the shared
//! vocabulary of [`super::simd`]. An instruction that does not depend on
//! the lanes' signedness has one row per arrangement, and the header casts
//! between the vector types of one width, which reinterprets the bits.

use super::simd::{AcrossOp, Cvt, FOp, Form, LongOp, NarrowKind, PermOp, Ret, Sem, Sha1F, SimdOp};

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
    ($s:ident, $w:expr, [$op:ident]) => {
        Sem::$s(FOp::$op, $w)
    };
    ($s:ident, $w:expr, ()) => {
        Sem::$s($w)
    };
    ($s:ident, $w:expr, ($($x:expr),+)) => {
        Sem::$s($w, $($x),+)
    };
}

/// A row's name stem and mnemonic: one literal names both, a pair
/// `("stem" "mnemonic")` a row whose name differs from its instruction's.
macro_rules! stem {
    ($m:literal) => {
        $m
    };
    (($n:literal $m:literal)) => {
        $n
    };
}
macro_rules! mnem {
    ($m:literal) => {
        $m
    };
    (($n:literal $m:literal)) => {
        $m
    };
}

/// One row: the arrangement fixes the name suffix, the result type, the
/// vector width and the lane width.
macro_rules! arr {
    ($m:tt, $f:ident, $s:ident, $a:tt, b8) => {
        row(
            concat!("__builtin_neon_", stem!($m), "_8b"),
            mnem!($m),
            Form::$f,
            Ret::V8qi,
            sem!($s, 1, $a),
            8,
        )
    };
    ($m:tt, $f:ident, $s:ident, $a:tt, b16) => {
        row(
            concat!("__builtin_neon_", stem!($m), "_16b"),
            mnem!($m),
            Form::$f,
            Ret::V16qi,
            sem!($s, 1, $a),
            16,
        )
    };
    ($m:tt, $f:ident, $s:ident, $a:tt, h4) => {
        row(
            concat!("__builtin_neon_", stem!($m), "_4h"),
            mnem!($m),
            Form::$f,
            Ret::V4hi,
            sem!($s, 2, $a),
            8,
        )
    };
    ($m:tt, $f:ident, $s:ident, $a:tt, h8) => {
        row(
            concat!("__builtin_neon_", stem!($m), "_8h"),
            mnem!($m),
            Form::$f,
            Ret::V8hi,
            sem!($s, 2, $a),
            16,
        )
    };
    ($m:tt, $f:ident, $s:ident, $a:tt, s2) => {
        row(
            concat!("__builtin_neon_", stem!($m), "_2s"),
            mnem!($m),
            Form::$f,
            Ret::V2si,
            sem!($s, 4, $a),
            8,
        )
    };
    ($m:tt, $f:ident, $s:ident, $a:tt, s4) => {
        row(
            concat!("__builtin_neon_", stem!($m), "_4s"),
            mnem!($m),
            Form::$f,
            Ret::V4si,
            sem!($s, 4, $a),
            16,
        )
    };
    ($m:tt, $f:ident, $s:ident, $a:tt, d1) => {
        row(
            concat!("__builtin_neon_", stem!($m), "_d"),
            mnem!($m),
            Form::$f,
            Ret::V1di,
            sem!($s, 8, $a),
            8,
        )
    };
    ($m:tt, $f:ident, $s:ident, $a:tt, f2s) => {
        row(
            concat!("__builtin_neon_", stem!($m), "_2s"),
            mnem!($m),
            Form::$f,
            Ret::V2sf,
            sem!($s, 4, $a),
            8,
        )
    };
    ($m:tt, $f:ident, $s:ident, $a:tt, f4s) => {
        row(
            concat!("__builtin_neon_", stem!($m), "_4s"),
            mnem!($m),
            Form::$f,
            Ret::V4sf,
            sem!($s, 4, $a),
            16,
        )
    };
    ($m:tt, $f:ident, $s:ident, $a:tt, fd) => {
        row(
            concat!("__builtin_neon_", stem!($m), "_d"),
            mnem!($m),
            Form::$f,
            Ret::V1df,
            sem!($s, 8, $a),
            8,
        )
    };
    ($m:tt, $f:ident, $s:ident, $a:tt, f2d) => {
        row(
            concat!("__builtin_neon_", stem!($m), "_2d"),
            mnem!($m),
            Form::$f,
            Ret::V2df,
            sem!($s, 8, $a),
            16,
        )
    };
    ($m:tt, $f:ident, $s:ident, $a:tt, d2) => {
        row(
            concat!("__builtin_neon_", stem!($m), "_2d"),
            mnem!($m),
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
    ($($m:tt $f:ident $s:ident $a:tt : $($w:ident)*;)*) => {
        &[$($(arr!($m, $f, $s, $a, $w)),*),*]
    };
}

/// Every AArch64 SIMD builtin badc provides.
#[rustfmt::skip]
pub(crate) const OPS: &[SimdOp] = table! {
    "add" Vv Add (): b8 b16 h4 h8 s2 s4 d1 d2;
    "sub" Vv Sub (): b8 b16 h4 h8 s2 s4 d1 d2;
    "mul" Vv MulLo (): b8 b16 h4 h8 s2 s4;
    "pmul" Vv PolyMul (): b8 b16;
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
    "srshr" Shift ShrRound (true): b8 b16 h4 h8 s2 s4 d1 d2;
    "urshr" Shift ShrRound (false): b8 b16 h4 h8 s2 s4 d1 d2;
    "ssra" VvI ShrAcc (true, false): b8 b16 h4 h8 s2 s4 d1 d2;
    "usra" VvI ShrAcc (false, false): b8 b16 h4 h8 s2 s4 d1 d2;
    "srsra" VvI ShrAcc (true, true): b8 b16 h4 h8 s2 s4 d1 d2;
    "ursra" VvI ShrAcc (false, true): b8 b16 h4 h8 s2 s4 d1 d2;
    "sli" VvI ShiftInsert (true): b8 b16 h4 h8 s2 s4 d1 d2;
    "sri" VvI ShiftInsert (false): b8 b16 h4 h8 s2 s4 d1 d2;
    "fadd" Vv Float [Add]: f2s f4s fd f2d;
    "fsub" Vv Float [Sub]: f2s f4s fd f2d;
    "fmul" Vv Float [Mul]: f2s f4s fd f2d;
    "fdiv" Vv Float [Div]: f2s f4s fd f2d;
    "fmax" Vv Float [MaxNan]: f2s f4s fd f2d;
    "fmin" Vv Float [MinNan]: f2s f4s fd f2d;
    "fsqrt" V Float [Sqrt]: f2s f4s fd f2d;
    "fabs" V FAbs (): f2s f4s fd f2d;
    "fneg" V FNeg (): f2s f4s fd f2d;
    "fabd" Vv Float [AbsDiff]: f2s f4s fd f2d;
    "fmaxnm" Vv Float [MaxNum]: f2s f4s fd f2d;
    "fminnm" Vv Float [MinNum]: f2s f4s fd f2d;
    "fmulx" Vv Float [MulX]: f2s f4s fd f2d;
    "faddp" Vv FloatPair [Add]: f2s f4s f2d;
    "fmaxp" Vv FloatPair [MaxNan]: f2s f4s f2d;
    "fminp" Vv FloatPair [MinNan]: f2s f4s f2d;
    "fmaxnmp" Vv FloatPair [MaxNum]: f2s f4s f2d;
    "fminnmp" Vv FloatPair [MinNum]: f2s f4s f2d;
    "fmaxv" V FloatAcross [MaxNan]: f4s;
    "fminv" V FloatAcross [MinNan]: f4s;
    "fmaxnmv" V FloatAcross [MaxNum]: f4s;
    "fminnmv" V FloatAcross [MinNum]: f4s;
    "fcmeq" Vv FloatRel (0): f2s f4s f2d;
    "fcmge" Vv FloatRel (13): f2s f4s f2d;
    "fcmgt" Vv FloatRel (14): f2s f4s f2d;
    "fmla" Vvv FloatFma (false): f2s f4s f2d;
    "fmls" Vvv FloatFma (true): f2s f4s f2d;
    "frecpe" V Estimate (false): f2s f4s fd f2d;
    "frsqrte" V Estimate (true): f2s f4s fd f2d;
    "frecps" Vv Step (false): f2s f4s fd f2d;
    "frsqrts" Vv Step (true): f2s f4s fd f2d;
    "urecpe" V FractionEstimate (false): s2 s4;
    "sqshlu" Shift ShlSatU (): b8 b16 h4 h8 s2 s4 d1 d2;
    "ursqrte" V FractionEstimate (true): s2 s4;
    ("cmeqz" "cmeq") V CmpEq (): b8 b16 h4 h8 s2 s4 d1 d2;
    ("cmgez" "cmge") V CmpGe (): b8 b16 h4 h8 s2 s4 d1 d2;
    ("cmgtz" "cmgt") V CmpGt (): b8 b16 h4 h8 s2 s4 d1 d2;
    ("cmlez" "cmle") V CmpLe (): b8 b16 h4 h8 s2 s4 d1 d2;
    ("cmltz" "cmlt") V CmpLt (): b8 b16 h4 h8 s2 s4 d1 d2;
    ("fcmeqz" "fcmeq") V FloatRel (0): f2s f4s fd f2d;
    ("fcmgez" "fcmge") V FloatRel (13): f2s f4s fd f2d;
    ("fcmgtz" "fcmgt") V FloatRel (14): f2s f4s fd f2d;
    ("fcmlez" "fcmle") V FloatRel (2): f2s f4s fd f2d;
    ("fcmltz" "fcmlt") V FloatRel (1): f2s f4s fd f2d;
};

/// A lengthening shift by the immediate, named by its source arrangement.
const fn shll(
    name: &'static str,
    mnem: &'static str,
    ret: Ret,
    w: u8,
    sg: bool,
    high: bool,
) -> SimdOp {
    let bytes = if high { 16 } else { 8 };
    row(
        name,
        mnem,
        Form::Shift,
        ret,
        Sem::Extend(w, 2 * w, sg, high),
        bytes,
    )
}

/// A pairwise long sum into the accumulator, named by its source
/// arrangement.
const fn adalp(
    name: &'static str,
    mnem: &'static str,
    ret: Ret,
    w: u8,
    sg: bool,
    bytes: u8,
) -> SimdOp {
    row(name, mnem, Form::Vv, ret, Sem::PairAddLongAcc(w, sg), bytes)
}

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
    row(
        name,
        mnem,
        Form::V,
        ret,
        Sem::Extend(w, 2 * w, signed, false),
        8,
    )
}

/// A lengthening move of the high half, named by its 16-byte source.
const fn extend2(name: &'static str, mnem: &'static str, ret: Ret, w: u8, signed: bool) -> SimdOp {
    row(
        name,
        mnem,
        Form::V,
        ret,
        Sem::Extend(w, 2 * w, signed, true),
        16,
    )
}

/// A reduction across the lanes of a `bytes`-byte source of `w`-byte lanes.
const fn across(
    name: &'static str,
    mnem: &'static str,
    ret: Ret,
    op: AcrossOp,
    w: u8,
    signed: bool,
    bytes: u8,
) -> SimdOp {
    row(
        name,
        mnem,
        Form::V,
        ret,
        Sem::Across(op, w, signed, bytes),
        bytes,
    )
}

/// The reductions of a family over the 8b, 16b, 4h, 8h and 4s sources; a
/// long one's result is twice as wide.
macro_rules! reductions {
    ($m:literal, $op:ident, $sg:expr, $r8:ident, $r16:ident, $r32:ident) => {
        [
            across(
                concat!("__builtin_neon_", $m, "_8b"),
                $m,
                Ret::$r8,
                AcrossOp::$op,
                1,
                $sg,
                8,
            ),
            across(
                concat!("__builtin_neon_", $m, "_16b"),
                $m,
                Ret::$r8,
                AcrossOp::$op,
                1,
                $sg,
                16,
            ),
            across(
                concat!("__builtin_neon_", $m, "_4h"),
                $m,
                Ret::$r16,
                AcrossOp::$op,
                2,
                $sg,
                8,
            ),
            across(
                concat!("__builtin_neon_", $m, "_8h"),
                $m,
                Ret::$r16,
                AcrossOp::$op,
                2,
                $sg,
                16,
            ),
            across(
                concat!("__builtin_neon_", $m, "_4s"),
                $m,
                Ret::$r32,
                AcrossOp::$op,
                4,
                $sg,
                16,
            ),
        ]
    };
}

#[rustfmt::skip]
const ACROSS: &[[SimdOp; 5]] = &[
    reductions!("addv", Add, false, V16qi, V8hi, V4si),
    reductions!("smaxv", Max, true, V16qi, V8hi, V4si),
    reductions!("umaxv", Max, false, V16qi, V8hi, V4si),
    reductions!("sminv", Min, true, V16qi, V8hi, V4si),
    reductions!("uminv", Min, false, V16qi, V8hi, V4si),
    reductions!("saddlv", AddLong, true, V8hi, V4si, V2di),
    reductions!("uaddlv", AddLong, false, V8hi, V4si, V2di),
];

/// A pairwise long sum or a lane reversal, one source.
const fn unary(name: &'static str, mnem: &'static str, ret: Ret, sem: Sem, bytes: u8) -> SimdOp {
    row(name, mnem, Form::V, ret, sem, bytes)
}

/// The rows of a shift by an immediate whose register-count form takes the
/// instruction's name: `__builtin_neon_<m>_n_<arrangement>`.
macro_rules! shift_n {
    ($m:literal, $s:ident, $sg:expr) => {
        [
            row(
                concat!("__builtin_neon_", $m, "_n_8b"),
                $m,
                Form::Shift,
                Ret::V8qi,
                Sem::$s(1, $sg),
                8,
            ),
            row(
                concat!("__builtin_neon_", $m, "_n_16b"),
                $m,
                Form::Shift,
                Ret::V16qi,
                Sem::$s(1, $sg),
                16,
            ),
            row(
                concat!("__builtin_neon_", $m, "_n_4h"),
                $m,
                Form::Shift,
                Ret::V4hi,
                Sem::$s(2, $sg),
                8,
            ),
            row(
                concat!("__builtin_neon_", $m, "_n_8h"),
                $m,
                Form::Shift,
                Ret::V8hi,
                Sem::$s(2, $sg),
                16,
            ),
            row(
                concat!("__builtin_neon_", $m, "_n_2s"),
                $m,
                Form::Shift,
                Ret::V2si,
                Sem::$s(4, $sg),
                8,
            ),
            row(
                concat!("__builtin_neon_", $m, "_n_4s"),
                $m,
                Form::Shift,
                Ret::V4si,
                Sem::$s(4, $sg),
                16,
            ),
            row(
                concat!("__builtin_neon_", $m, "_n_d"),
                $m,
                Form::Shift,
                Ret::V1di,
                Sem::$s(8, $sg),
                8,
            ),
            row(
                concat!("__builtin_neon_", $m, "_n_2d"),
                $m,
                Form::Shift,
                Ret::V2di,
                Sem::$s(8, $sg),
                16,
            ),
        ]
    };
}

#[rustfmt::skip]
const SHIFT_N: &[[SimdOp; 8]] = &[
    shift_n!("sqshl", ShlSat, true),
    shift_n!("uqshl", ShlSat, false),
];

/// A narrowing shift right by the immediate, named by its wide source.
const fn shrn(
    name: &'static str,
    mnem: &'static str,
    ret: Ret,
    w: u8,
    round: bool,
    kind: NarrowKind,
) -> SimdOp {
    row(
        name,
        mnem,
        Form::Shift,
        ret,
        Sem::ShrNarrow(w, round, kind),
        16,
    )
}

/// `dup` from lane `imm` of a `src`-byte vector into every lane of `ret`.
const fn dupl(name: &'static str, ret: Ret, w: u8, src: u8) -> SimdOp {
    row(name, "dup", Form::VI, ret, Sem::DupLane(w), src)
}

#[rustfmt::skip]
const NARROW: &[SimdOp] = &[
    shrn("__builtin_neon_shrn_8h", "shrn", Ret::V8qi, 2, false, NarrowKind::Trunc),
    shrn("__builtin_neon_shrn_4s", "shrn", Ret::V4hi, 4, false, NarrowKind::Trunc),
    shrn("__builtin_neon_shrn_2d", "shrn", Ret::V2si, 8, false, NarrowKind::Trunc),
    shrn("__builtin_neon_rshrn_8h", "rshrn", Ret::V8qi, 2, true, NarrowKind::Trunc),
    shrn("__builtin_neon_rshrn_4s", "rshrn", Ret::V4hi, 4, true, NarrowKind::Trunc),
    shrn("__builtin_neon_rshrn_2d", "rshrn", Ret::V2si, 8, true, NarrowKind::Trunc),
    shrn("__builtin_neon_sqshrn_8h", "sqshrn", Ret::V8qi, 2, false, NarrowKind::SatSigned),
    shrn("__builtin_neon_sqshrn_4s", "sqshrn", Ret::V4hi, 4, false, NarrowKind::SatSigned),
    shrn("__builtin_neon_sqshrn_2d", "sqshrn", Ret::V2si, 8, false, NarrowKind::SatSigned),
    shrn("__builtin_neon_sqrshrn_8h", "sqrshrn", Ret::V8qi, 2, true, NarrowKind::SatSigned),
    shrn("__builtin_neon_sqrshrn_4s", "sqrshrn", Ret::V4hi, 4, true, NarrowKind::SatSigned),
    shrn("__builtin_neon_sqrshrn_2d", "sqrshrn", Ret::V2si, 8, true, NarrowKind::SatSigned),
    shrn("__builtin_neon_uqshrn_8h", "uqshrn", Ret::V8qi, 2, false, NarrowKind::SatUns),
    shrn("__builtin_neon_uqshrn_4s", "uqshrn", Ret::V4hi, 4, false, NarrowKind::SatUns),
    shrn("__builtin_neon_uqshrn_2d", "uqshrn", Ret::V2si, 8, false, NarrowKind::SatUns),
    shrn("__builtin_neon_uqrshrn_8h", "uqrshrn", Ret::V8qi, 2, true, NarrowKind::SatUns),
    shrn("__builtin_neon_uqrshrn_4s", "uqrshrn", Ret::V4hi, 4, true, NarrowKind::SatUns),
    shrn("__builtin_neon_uqrshrn_2d", "uqrshrn", Ret::V2si, 8, true, NarrowKind::SatUns),
    shrn("__builtin_neon_sqshrun_8h", "sqshrun", Ret::V8qi, 2, false, NarrowKind::SatSignedToUns),
    shrn("__builtin_neon_sqshrun_4s", "sqshrun", Ret::V4hi, 4, false, NarrowKind::SatSignedToUns),
    shrn("__builtin_neon_sqshrun_2d", "sqshrun", Ret::V2si, 8, false, NarrowKind::SatSignedToUns),
    shrn("__builtin_neon_sqrshrun_8h", "sqrshrun", Ret::V8qi, 2, true, NarrowKind::SatSignedToUns),
    shrn("__builtin_neon_sqrshrun_4s", "sqrshrun", Ret::V4hi, 4, true, NarrowKind::SatSignedToUns),
    shrn("__builtin_neon_sqrshrun_2d", "sqrshrun", Ret::V2si, 8, true, NarrowKind::SatSignedToUns),
    row("__builtin_neon_tbl_8b", "tbl", Form::Vv, Ret::V8qi, Sem::Tbl(8), 8),
    row("__builtin_neon_tbl_16b", "tbl", Form::Vv, Ret::V16qi, Sem::Tbl(16), 16),
    row("__builtin_neon_tbx_8b", "tbx", Form::Vvv, Ret::V8qi, Sem::Tbx(8), 8),
    row("__builtin_neon_tbx_16b", "tbx", Form::Vvv, Ret::V16qi, Sem::Tbx(16), 16),
    dupl("__builtin_neon_dup_8b_d", Ret::V8qi, 1, 8),
    dupl("__builtin_neon_dup_8b_q", Ret::V8qi, 1, 16),
    dupl("__builtin_neon_dup_16b_d", Ret::V16qi, 1, 8),
    dupl("__builtin_neon_dup_16b_q", Ret::V16qi, 1, 16),
    dupl("__builtin_neon_dup_4h_d", Ret::V4hi, 2, 8),
    dupl("__builtin_neon_dup_4h_q", Ret::V4hi, 2, 16),
    dupl("__builtin_neon_dup_8h_d", Ret::V8hi, 2, 8),
    dupl("__builtin_neon_dup_8h_q", Ret::V8hi, 2, 16),
    dupl("__builtin_neon_dup_2s_d", Ret::V2si, 4, 8),
    dupl("__builtin_neon_dup_2s_q", Ret::V2si, 4, 16),
    dupl("__builtin_neon_dup_4s_d", Ret::V4si, 4, 8),
    dupl("__builtin_neon_dup_4s_q", Ret::V4si, 4, 16),
    dupl("__builtin_neon_dup_2d_d", Ret::V2di, 8, 8),
    dupl("__builtin_neon_dup_2d_q", Ret::V2di, 8, 16),
    row("__builtin_neon_ext_8b", "ext", Form::VvI, Ret::V8qi, Sem::Ext(8), 8),
    row("__builtin_neon_ext_16b", "ext", Form::VvI, Ret::V16qi, Sem::Ext(16), 16),
    row("__builtin_neon_fcvtl_2s", "fcvtl", Form::V, Ret::V2df, Sem::Convert(Cvt::SingleToDouble), 8),
    long!("pmull", Vv, Long, (PolyMul, false), "8b", V8hi, 1, 8, false),
    long!("pmull2", Vv, Long, (PolyMul, false), "16b", V8hi, 1, 16, true),
    long!("pmull", Vv, Long, (PolyMul, false), "1d", V2di, 8, 8, false),
    long!("pmull2", Vv, Long, (PolyMul, false), "2d", V2di, 8, 16, true),
    row("__builtin_neon_sha1c_4s", "sha1c", Form::Vvv, Ret::V4si, Sem::Sha1Hash(Sha1F::Choose), 16),
    row("__builtin_neon_sha1p_4s", "sha1p", Form::Vvv, Ret::V4si, Sem::Sha1Hash(Sha1F::Parity), 16),
    row("__builtin_neon_sha1m_4s", "sha1m", Form::Vvv, Ret::V4si, Sem::Sha1Hash(Sha1F::Majority), 16),
    row("__builtin_neon_sha1su0_4s", "sha1su0", Form::Vvv, Ret::V4si, Sem::Sha1Su0, 16),
    row("__builtin_neon_sha1su1_4s", "sha1su1", Form::Vv, Ret::V4si, Sem::Sha1Su1, 16),
    row("__builtin_neon_sha512h_2d", "sha512h", Form::Vvv, Ret::V2di, Sem::Sha512Hash(true), 16),
    row("__builtin_neon_sha512h2_2d", "sha512h2", Form::Vvv, Ret::V2di, Sem::Sha512Hash(false), 16),
    row("__builtin_neon_sha512su0_2d", "sha512su0", Form::Vv, Ret::V2di, Sem::Sha512Su0, 16),
    row("__builtin_neon_sha512su1_2d", "sha512su1", Form::Vvv, Ret::V2di, Sem::Sha512Su1, 16),
    row("__builtin_neon_sha256h_4s", "sha256h", Form::Vvv, Ret::V4si, Sem::Sha256Hash(true), 16),
    row("__builtin_neon_sha256h2_4s", "sha256h2", Form::Vvv, Ret::V4si, Sem::Sha256Hash(false), 16),
    row("__builtin_neon_sha256su0_4s", "sha256su0", Form::Vv, Ret::V4si, Sem::Sha256Su0, 16),
    row("__builtin_neon_sha256su1_4s", "sha256su1", Form::Vvv, Ret::V4si, Sem::Sha256Su1, 16),
    row("__builtin_neon_eor3_16b", "eor3", Form::Vvv, Ret::V16qi, Sem::Eor3, 16),
    row("__builtin_neon_bcax_16b", "bcax", Form::Vvv, Ret::V16qi, Sem::Bcax, 16),
    row("__builtin_neon_rax1_2d", "rax1", Form::Vv, Ret::V2di, Sem::Rax1, 16),
    row("__builtin_neon_xar_2d", "xar", Form::VvI, Ret::V2di, Sem::Xar, 16),
    row("__builtin_neon_aese_16b", "aese", Form::Vv, Ret::V16qi, Sem::AesRound(false), 16),
    row("__builtin_neon_aesd_16b", "aesd", Form::Vv, Ret::V16qi, Sem::AesRound(true), 16),
    row("__builtin_neon_aesmc_16b", "aesmc", Form::V, Ret::V16qi, Sem::AesMix, 16),
    row("__builtin_neon_aesimc_16b", "aesimc", Form::V, Ret::V16qi, Sem::AesImc, 16),
    row("__builtin_neon_fcvtl2_4s", "fcvtl2", Form::V, Ret::V2df, Sem::Convert(Cvt::SingleToDoubleHigh), 16),
    row("__builtin_neon_scvtf_2s", "scvtf", Form::V, Ret::V2sf, Sem::Convert(Cvt::IntToSingle), 8),
    row("__builtin_neon_scvtf_4s", "scvtf", Form::V, Ret::V4sf, Sem::Convert(Cvt::IntToSingle), 16),
    row("__builtin_neon_ucvtf_2s", "ucvtf", Form::V, Ret::V2sf, Sem::Convert(Cvt::UIntToSingle), 8),
    row("__builtin_neon_ucvtf_4s", "ucvtf", Form::V, Ret::V4sf, Sem::Convert(Cvt::UIntToSingle), 16),
    row("__builtin_neon_scvtf_2d", "scvtf", Form::V, Ret::V2df, Sem::Convert(Cvt::Int64ToDouble { signed: true }), 16),
    row("__builtin_neon_ucvtf_2d", "ucvtf", Form::V, Ret::V2df, Sem::Convert(Cvt::Int64ToDouble { signed: false }), 16),
    row("__builtin_neon_fcvtzs_2s", "fcvtzs", Form::V, Ret::V2si, Sem::Convert(Cvt::ToIntSat { w: 4, signed: true }), 8),
    row("__builtin_neon_fcvtzs_4s", "fcvtzs", Form::V, Ret::V4si, Sem::Convert(Cvt::ToIntSat { w: 4, signed: true }), 16),
    row("__builtin_neon_fcvtzu_2s", "fcvtzu", Form::V, Ret::V2si, Sem::Convert(Cvt::ToIntSat { w: 4, signed: false }), 8),
    row("__builtin_neon_fcvtzu_4s", "fcvtzu", Form::V, Ret::V4si, Sem::Convert(Cvt::ToIntSat { w: 4, signed: false }), 16),
    row("__builtin_neon_fcvtzs_2d", "fcvtzs", Form::V, Ret::V2di, Sem::Convert(Cvt::ToIntSat { w: 8, signed: true }), 16),
    row("__builtin_neon_fcvtzu_2d", "fcvtzu", Form::V, Ret::V2di, Sem::Convert(Cvt::ToIntSat { w: 8, signed: false }), 16),
    row("__builtin_neon_fcvtn_2d", "fcvtn", Form::V, Ret::V2sf, Sem::Convert(Cvt::DoubleToSingle), 16),
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
    extend2("__builtin_neon_sxtl2_16b", "sxtl2", Ret::V8hi, 1, true),
    extend2("__builtin_neon_sxtl2_8h", "sxtl2", Ret::V4si, 2, true),
    extend2("__builtin_neon_sxtl2_4s", "sxtl2", Ret::V2di, 4, true),
    extend2("__builtin_neon_uxtl2_16b", "uxtl2", Ret::V8hi, 1, false),
    extend2("__builtin_neon_uxtl2_8h", "uxtl2", Ret::V4si, 2, false),
    extend2("__builtin_neon_uxtl2_4s", "uxtl2", Ret::V2di, 4, false),
    unary("__builtin_neon_saddlp_8b", "saddlp", Ret::V4hi, Sem::PairAddLong(1, true), 8),
    unary("__builtin_neon_saddlp_16b", "saddlp", Ret::V8hi, Sem::PairAddLong(1, true), 16),
    unary("__builtin_neon_saddlp_4h", "saddlp", Ret::V2si, Sem::PairAddLong(2, true), 8),
    unary("__builtin_neon_saddlp_8h", "saddlp", Ret::V4si, Sem::PairAddLong(2, true), 16),
    unary("__builtin_neon_saddlp_2s", "saddlp", Ret::V1di, Sem::PairAddLong(4, true), 8),
    unary("__builtin_neon_saddlp_4s", "saddlp", Ret::V2di, Sem::PairAddLong(4, true), 16),
    unary("__builtin_neon_uaddlp_8b", "uaddlp", Ret::V4hi, Sem::PairAddLong(1, false), 8),
    unary("__builtin_neon_uaddlp_16b", "uaddlp", Ret::V8hi, Sem::PairAddLong(1, false), 16),
    unary("__builtin_neon_uaddlp_4h", "uaddlp", Ret::V2si, Sem::PairAddLong(2, false), 8),
    unary("__builtin_neon_uaddlp_8h", "uaddlp", Ret::V4si, Sem::PairAddLong(2, false), 16),
    unary("__builtin_neon_uaddlp_2s", "uaddlp", Ret::V1di, Sem::PairAddLong(4, false), 8),
    unary("__builtin_neon_uaddlp_4s", "uaddlp", Ret::V2di, Sem::PairAddLong(4, false), 16),
    shll("__builtin_neon_sshll_8b", "sshll", Ret::V8hi, 1, true, false),
    shll("__builtin_neon_sshll_4h", "sshll", Ret::V4si, 2, true, false),
    shll("__builtin_neon_sshll_2s", "sshll", Ret::V2di, 4, true, false),
    shll("__builtin_neon_ushll_8b", "ushll", Ret::V8hi, 1, false, false),
    shll("__builtin_neon_ushll_4h", "ushll", Ret::V4si, 2, false, false),
    shll("__builtin_neon_ushll_2s", "ushll", Ret::V2di, 4, false, false),
    shll("__builtin_neon_sshll2_16b", "sshll2", Ret::V8hi, 1, true, true),
    shll("__builtin_neon_sshll2_8h", "sshll2", Ret::V4si, 2, true, true),
    shll("__builtin_neon_sshll2_4s", "sshll2", Ret::V2di, 4, true, true),
    shll("__builtin_neon_ushll2_16b", "ushll2", Ret::V8hi, 1, false, true),
    shll("__builtin_neon_ushll2_8h", "ushll2", Ret::V4si, 2, false, true),
    shll("__builtin_neon_ushll2_4s", "ushll2", Ret::V2di, 4, false, true),
    shll("__builtin_neon_shll_8b", "shll", Ret::V8hi, 1, false, false),
    shll("__builtin_neon_shll_4h", "shll", Ret::V4si, 2, false, false),
    shll("__builtin_neon_shll_2s", "shll", Ret::V2di, 4, false, false),
    shll("__builtin_neon_shll2_16b", "shll2", Ret::V8hi, 1, false, true),
    shll("__builtin_neon_shll2_8h", "shll2", Ret::V4si, 2, false, true),
    shll("__builtin_neon_shll2_4s", "shll2", Ret::V2di, 4, false, true),
    adalp("__builtin_neon_sadalp_8b", "sadalp", Ret::V4hi, 1, true, 8),
    adalp("__builtin_neon_sadalp_16b", "sadalp", Ret::V8hi, 1, true, 16),
    adalp("__builtin_neon_sadalp_4h", "sadalp", Ret::V2si, 2, true, 8),
    adalp("__builtin_neon_sadalp_8h", "sadalp", Ret::V4si, 2, true, 16),
    adalp("__builtin_neon_sadalp_2s", "sadalp", Ret::V1di, 4, true, 8),
    adalp("__builtin_neon_sadalp_4s", "sadalp", Ret::V2di, 4, true, 16),
    adalp("__builtin_neon_uadalp_8b", "uadalp", Ret::V4hi, 1, false, 8),
    adalp("__builtin_neon_uadalp_16b", "uadalp", Ret::V8hi, 1, false, 16),
    adalp("__builtin_neon_uadalp_4h", "uadalp", Ret::V2si, 2, false, 8),
    adalp("__builtin_neon_uadalp_8h", "uadalp", Ret::V4si, 2, false, 16),
    adalp("__builtin_neon_uadalp_2s", "uadalp", Ret::V1di, 4, false, 8),
    adalp("__builtin_neon_uadalp_4s", "uadalp", Ret::V2di, 4, false, 16),
    unary("__builtin_neon_rev16_8b", "rev16", Ret::V8qi, Sem::Rev(1, 2), 8),
    unary("__builtin_neon_rev16_16b", "rev16", Ret::V16qi, Sem::Rev(1, 2), 16),
    unary("__builtin_neon_rev32_8b", "rev32", Ret::V8qi, Sem::Rev(1, 4), 8),
    unary("__builtin_neon_rev32_16b", "rev32", Ret::V16qi, Sem::Rev(1, 4), 16),
    unary("__builtin_neon_rev32_4h", "rev32", Ret::V4hi, Sem::Rev(2, 4), 8),
    unary("__builtin_neon_rev32_8h", "rev32", Ret::V8hi, Sem::Rev(2, 4), 16),
    unary("__builtin_neon_rev64_8b", "rev64", Ret::V8qi, Sem::Rev(1, 8), 8),
    unary("__builtin_neon_rev64_16b", "rev64", Ret::V16qi, Sem::Rev(1, 8), 16),
    unary("__builtin_neon_rev64_4h", "rev64", Ret::V4hi, Sem::Rev(2, 8), 8),
    unary("__builtin_neon_rev64_8h", "rev64", Ret::V8hi, Sem::Rev(2, 8), 16),
    unary("__builtin_neon_rev64_2s", "rev64", Ret::V2si, Sem::Rev(4, 8), 8),
    unary("__builtin_neon_rev64_4s", "rev64", Ret::V4si, Sem::Rev(4, 8), 16),
];

/// A permutation's row over `bytes`-byte vectors of `ret`'s `w`-byte lanes.
const fn perm(
    name: &'static str,
    mnem: &'static str,
    ret: Ret,
    op: PermOp,
    second: bool,
    w: u8,
    bytes: u8,
) -> SimdOp {
    row(
        name,
        mnem,
        Form::Vv,
        ret,
        Sem::Perm(op, w, second, bytes),
        bytes,
    )
}

/// The rows of a permutation, one per arrangement with two lanes or more.
macro_rules! perms {
    ($m:literal, $op:ident, $second:expr) => {
        [
            perm(
                concat!("__builtin_neon_", $m, "_8b"),
                $m,
                Ret::V8qi,
                PermOp::$op,
                $second,
                1,
                8,
            ),
            perm(
                concat!("__builtin_neon_", $m, "_16b"),
                $m,
                Ret::V16qi,
                PermOp::$op,
                $second,
                1,
                16,
            ),
            perm(
                concat!("__builtin_neon_", $m, "_4h"),
                $m,
                Ret::V4hi,
                PermOp::$op,
                $second,
                2,
                8,
            ),
            perm(
                concat!("__builtin_neon_", $m, "_8h"),
                $m,
                Ret::V8hi,
                PermOp::$op,
                $second,
                2,
                16,
            ),
            perm(
                concat!("__builtin_neon_", $m, "_2s"),
                $m,
                Ret::V2si,
                PermOp::$op,
                $second,
                4,
                8,
            ),
            perm(
                concat!("__builtin_neon_", $m, "_4s"),
                $m,
                Ret::V4si,
                PermOp::$op,
                $second,
                4,
                16,
            ),
            perm(
                concat!("__builtin_neon_", $m, "_2d"),
                $m,
                Ret::V2di,
                PermOp::$op,
                $second,
                8,
                16,
            ),
        ]
    };
}

#[rustfmt::skip]
const PERMS: &[[SimdOp; 7]] = &[
    perms!("zip1", Zip, false),
    perms!("zip2", Zip, true),
    perms!("uzp1", Uzp, false),
    perms!("uzp2", Uzp, true),
    perms!("trn1", Trn, false),
    perms!("trn2", Trn, true),
];

/// The row at index `i` of the rows [`OPS`], then the widening, the
/// narrowing and other single, the reduction, the permutation and the
/// immediate-shift ones, numbered in that order.
pub(crate) fn get(i: usize) -> &'static SimdOp {
    let long = LONG.len() * 3;
    let narrow = long + NARROW.len();
    let across = narrow + ACROSS.len() * 5;
    let perms = across + PERMS.len() * 7;
    if i < OPS.len() {
        &OPS[i]
    } else if i < OPS.len() + long {
        let k = i - OPS.len();
        &LONG[k / 3][k % 3]
    } else if i < OPS.len() + narrow {
        &NARROW[i - OPS.len() - long]
    } else if i < OPS.len() + across {
        let k = i - OPS.len() - narrow;
        &ACROSS[k / 5][k % 5]
    } else if i < OPS.len() + perms {
        let k = i - OPS.len() - across;
        &PERMS[k / 7][k % 7]
    } else {
        let k = i - OPS.len() - perms;
        &SHIFT_N[k / 8][k % 8]
    }
}

/// Every AArch64 row, in [`get`]'s numbering.
pub(crate) fn rows() -> impl Iterator<Item = &'static SimdOp> {
    OPS.iter()
        .chain(LONG.iter().flatten())
        .chain(NARROW)
        .chain(ACROSS.iter().flatten())
        .chain(PERMS.iter().flatten())
        .chain(SHIFT_N.iter().flatten())
}

/// The table index of `name`, or `None` when it is not an AArch64 SIMD
/// builtin.
pub(crate) fn lookup(name: &str) -> Option<u32> {
    rows().position(|o| o.name == name).map(|i| i as u32)
}
