//! The AArch64 Advanced SIMD intrinsic surface: one table row per
//! `__builtin_neon_<mnemonic>_<arrangement>` builtin the bundled
//! `<arm_neon.h>` calls. A row names the instruction and its arrangement;
//! the operand shape, result type and value semantics are the shared
//! vocabulary of [`super::simd`]. An instruction that does not depend on
//! the lanes' signedness has one row per arrangement, and the header casts
//! between the vector types of one width, which reinterprets the bits.

use super::simd::{Form, Ret, Sem, SimdOp};

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

/// The rows of each family, one per arrangement it lists: `d1` is the
/// scalar form over one 64-bit lane in a D register. `-` marks a semantics
/// without a lane width, `()` one with only the width.
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
    "sshr" Shift Sar (): b8 b16 h4 h8 s2 s4 d1 d2;
    "ushr" Shift Shr (): b8 b16 h4 h8 s2 s4 d1 d2;
};

/// The table index of `name`, or `None` when it is not an AArch64 SIMD
/// builtin.
pub(crate) fn lookup(name: &str) -> Option<u32> {
    OPS.iter().position(|o| o.name == name).map(|i| i as u32)
}
