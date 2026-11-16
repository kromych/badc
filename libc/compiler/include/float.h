// float.h -- characteristics of floating types (C99 5.2.4.2.2 / 7.7).
//
// Every name derives from the compiler's `__FLT_*` / `__DBL_*` /
// `__LDBL_*` predefines, so the header and the predefines cannot
// disagree. `float` is IEEE binary32, `double` IEEE binary64, and the
// LDBL row describes the target ABI's `long double` storage format
// (x87 80-bit on System V x86-64, binary128 on AArch64 Linux, binary64
// elsewhere). Arithmetic on the type is carried out at binary64
// precision (doc/std-conformance.md), so a constant past binary64's
// range (LDBL_MAX on the wide targets) evaluates to +inf.

#pragma once

#define FLT_RADIX       __FLT_RADIX__
#define FLT_ROUNDS      1   // round-to-nearest
#define DECIMAL_DIG     __DECIMAL_DIG__

#define FLT_MANT_DIG    __FLT_MANT_DIG__
#define FLT_DIG         __FLT_DIG__
#define FLT_MIN_EXP     __FLT_MIN_EXP__
#define FLT_MIN_10_EXP  __FLT_MIN_10_EXP__
#define FLT_MAX_EXP     __FLT_MAX_EXP__
#define FLT_MAX_10_EXP  __FLT_MAX_10_EXP__
#define FLT_EPSILON     __FLT_EPSILON__
#define FLT_MIN         __FLT_MIN__
#define FLT_MAX         __FLT_MAX__
#define FLT_TRUE_MIN    __FLT_DENORM_MIN__
#define FLT_HAS_SUBNORM __FLT_HAS_DENORM__
#define FLT_DECIMAL_DIG __FLT_DECIMAL_DIG__

#define DBL_MANT_DIG    __DBL_MANT_DIG__
#define DBL_DIG         __DBL_DIG__
#define DBL_MIN_EXP     __DBL_MIN_EXP__
#define DBL_MIN_10_EXP  __DBL_MIN_10_EXP__
#define DBL_MAX_EXP     __DBL_MAX_EXP__
#define DBL_MAX_10_EXP  __DBL_MAX_10_EXP__
#define DBL_EPSILON     __DBL_EPSILON__
#define DBL_MIN         __DBL_MIN__
#define DBL_MAX         __DBL_MAX__
#define DBL_TRUE_MIN    __DBL_DENORM_MIN__
#define DBL_HAS_SUBNORM __DBL_HAS_DENORM__
#define DBL_DECIMAL_DIG __DBL_DECIMAL_DIG__

#define LDBL_MANT_DIG    __LDBL_MANT_DIG__
#define LDBL_DIG         __LDBL_DIG__
#define LDBL_MIN_EXP     __LDBL_MIN_EXP__
#define LDBL_MIN_10_EXP  __LDBL_MIN_10_EXP__
#define LDBL_MAX_EXP     __LDBL_MAX_EXP__
#define LDBL_MAX_10_EXP  __LDBL_MAX_10_EXP__
#define LDBL_EPSILON     __LDBL_EPSILON__
#define LDBL_MIN         __LDBL_MIN__
#define LDBL_MAX         __LDBL_MAX__
#define LDBL_TRUE_MIN    __LDBL_DENORM_MIN__
#define LDBL_HAS_SUBNORM __LDBL_HAS_DENORM__
#define LDBL_DECIMAL_DIG __LDBL_DECIMAL_DIG__

// C99 5.2.4.2.2: evaluation method used for float expressions.
//   0 = evaluate at operand type
//   1 = evaluate at double
//   2 = evaluate at long double
#define FLT_EVAL_METHOD 0
