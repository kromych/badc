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

// `long double` width is target-dependent. AArch64 (macOS, Linux,
// Windows) maps it to 64-bit binary64; x86_64 ELF uses 80-bit
// extended; x86_64 Windows MSVC maps it to 64-bit binary64. The
// 80-bit row matches the System V x86_64 ABI's `long double`.
#if defined(__x86_64__) && !defined(_WIN32)
#define LDBL_MANT_DIG    64
#define LDBL_DIG         18
#define LDBL_MIN_EXP     (-16381)
#define LDBL_MIN_10_EXP  (-4931)
#define LDBL_MAX_EXP     16384
#define LDBL_MAX_10_EXP  4932
#define LDBL_EPSILON     1.0842021724855044340075E-19L
#define LDBL_MIN         3.3621031431120935063E-4932L
#define LDBL_MAX         1.1897314953572317650E+4932L
#define LDBL_TRUE_MIN    3.6451995318824746025E-4951L
#define LDBL_HAS_SUBNORM 1
#define LDBL_DECIMAL_DIG 21
#else
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
#endif

// C99 5.2.4.2.2: evaluation method used for float expressions.
//   0 = evaluate at operand type
//   1 = evaluate at double
//   2 = evaluate at long double
#define FLT_EVAL_METHOD 0
