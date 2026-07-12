// float.h -- characteristics of floating types (C99 5.2.4.2.2 / 7.7).
//
// Values match IEEE 754 binary32 / binary64 / extended-precision
// binary80, the formats every supported host uses for `float` /
// `double` / `long double`. `long double` is 80-bit extended on
// x86_64-elf and 64-bit double on aarch64 / Windows; the macros
// here track the wider extended-precision case, which is a
// conservative upper bound that callers can rely on regardless of
// the running ABI.

#pragma once

#define FLT_RADIX       2
#define FLT_ROUNDS      1   // round-to-nearest

#define FLT_MANT_DIG    24
#define FLT_DIG         6
#define FLT_MIN_EXP     (-125)
#define FLT_MIN_10_EXP  (-37)
#define FLT_MAX_EXP     128
#define FLT_MAX_10_EXP  38
#define FLT_EPSILON     1.19209290e-07F
#define FLT_MIN         1.17549435e-38F
#define FLT_MAX         3.40282347e+38F
#define FLT_TRUE_MIN    1.40129846e-45F
#define FLT_HAS_SUBNORM 1
#define FLT_DECIMAL_DIG 9

#define DBL_MANT_DIG    53
#define DBL_DIG         15
#define DBL_MIN_EXP     (-1021)
#define DBL_MIN_10_EXP  (-307)
#define DBL_MAX_EXP     1024
#define DBL_MAX_10_EXP  308
#define DBL_EPSILON     2.2204460492503131e-16
#define DBL_MIN         2.2250738585072014e-308
#define DBL_MAX         1.7976931348623157e+308
#define DBL_TRUE_MIN    4.9406564584124654e-324
#define DBL_HAS_SUBNORM 1
#define DBL_DECIMAL_DIG 17

// c5 stores `long double` as an 8-byte IEEE binary64 on every target
// (see std-conformance.md), so its characteristics equal `double`'s.
// Advertising the System V x86_64 80-bit row here would let a program
// load LDBL_MAX (1.18e4932, unrepresentable in binary64 -> +inf) or
// iterate to LDBL_EPSILON (1e-19, below the real binary64 epsilon).
#define LDBL_MANT_DIG    DBL_MANT_DIG
#define LDBL_DIG         DBL_DIG
#define LDBL_MIN_EXP     DBL_MIN_EXP
#define LDBL_MIN_10_EXP  DBL_MIN_10_EXP
#define LDBL_MAX_EXP     DBL_MAX_EXP
#define LDBL_MAX_10_EXP  DBL_MAX_10_EXP
#define LDBL_EPSILON     DBL_EPSILON
#define LDBL_MIN         DBL_MIN
#define LDBL_MAX         DBL_MAX
#define LDBL_TRUE_MIN    DBL_TRUE_MIN
#define LDBL_HAS_SUBNORM DBL_HAS_SUBNORM
#define LDBL_DECIMAL_DIG DBL_DECIMAL_DIG

// C99 5.2.4.2.2: evaluation method used for float expressions.
//   0 = evaluate at operand type
//   1 = evaluate at double
//   2 = evaluate at long double
#define FLT_EVAL_METHOD 0
