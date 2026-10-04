// stdint.h -- fixed-width integer types and constant macros.
//
// The 8-, 16- and 32-bit types are `signed char`, `short` and `int`
// on every target. The 64-bit, pointer-width and greatest-width types
// are the ones the platform's own headers give, which the compiler
// predefines per target: `long` for all three under glibc on LP64;
// `long long`, `long` and `long` under Apple's headers; `long long`
// for all three on Windows.
#pragma once

typedef signed char         int8_t;
typedef short               int16_t;
typedef int                 int32_t;
typedef __INT64_TYPE__      int64_t;
typedef __INTPTR_TYPE__     intptr_t;
typedef __INTMAX_TYPE__     intmax_t;

typedef unsigned char       uint8_t;
typedef unsigned short      uint16_t;
typedef unsigned int        uint32_t;
typedef __UINT64_TYPE__     uint64_t;
typedef __UINTPTR_TYPE__    uintptr_t;
typedef __UINTMAX_TYPE__    uintmax_t;

// Minimum-width (7.18.1.2) types alias the exact-width type of their size.
// Fastest minimum-width (7.18.1.3) ones do too, but for the 16- and 32-bit
// types, which take the platform's choice predefined with the others.
typedef int8_t              int_least8_t;
typedef int16_t             int_least16_t;
typedef int32_t             int_least32_t;
typedef int64_t             int_least64_t;
typedef uint8_t             uint_least8_t;
typedef uint16_t            uint_least16_t;
typedef uint32_t            uint_least32_t;
typedef uint64_t            uint_least64_t;

typedef int8_t              int_fast8_t;
typedef __INT_FAST16_TYPE__ int_fast16_t;
typedef __INT_FAST32_TYPE__ int_fast32_t;
typedef int64_t             int_fast64_t;
typedef uint8_t             uint_fast8_t;
typedef __UINT_FAST16_TYPE__ uint_fast16_t;
typedef __UINT_FAST32_TYPE__ uint_fast32_t;
typedef uint64_t            uint_fast64_t;

// C99 7.18.4.1: `INTN_C`/`UINTN_C` expand to an integer constant of type
// `int_leastN_t`/`uint_leastN_t`, so the 64-bit and greatest-width forms take
// their type's suffix. The 8/16-bit forms promote to `int`, so a bare token
// is conforming for those.
#define __badc_int_c_join(c, suffix) c##suffix
#define __badc_int_c(c, suffix) __badc_int_c_join(c, suffix)
#define INT8_C(c)   c
#define INT16_C(c)  c
#define INT32_C(c)  c
#define INT64_C(c)  __badc_int_c(c, __INT64_C_SUFFIX__)
#define INTMAX_C(c) __badc_int_c(c, __INTMAX_C_SUFFIX__)

#define UINT8_C(c)   c
#define UINT16_C(c)  c
#define UINT32_C(c)  c##U
#define UINT64_C(c)  __badc_int_c(c, __UINT64_C_SUFFIX__)
#define UINTMAX_C(c) __badc_int_c(c, __UINTMAX_C_SUFFIX__)

#define INT8_MIN  (-128)
#define INT16_MIN (-32768)
/* C99 7.18.2: written as `-MAX-1` so the positive operand of unary minus
   stays in range for the macro's exact-width signed type (matching the
   limits.h idiom). `2147483648` exceeds INT_MAX and `9223372036854775808`
   is unrepresentable in any signed type. */
#define INT32_MIN (-2147483647-1)
#define INT64_MIN (-INT64_MAX-1)

#define INT8_MAX  127
#define INT16_MAX 32767
#define INT32_MAX 2147483647
#define INT64_MAX INT64_C(9223372036854775807)

#define UINT8_MAX  255
#define UINT16_MAX 65535
#define UINT32_MAX 4294967295U
#define UINT64_MAX UINT64_C(18446744073709551615)

#define SIZE_MAX     __SIZE_MAX__
#define INTPTR_MIN   (-INTPTR_MAX-1)
#define INTPTR_MAX   __INTPTR_MAX__
#define UINTPTR_MAX  __UINTPTR_MAX__
#define INTMAX_MIN   (-INTMAX_MAX-1)
#define INTMAX_MAX   INTMAX_C(9223372036854775807)
#define UINTMAX_MAX  UINTMAX_C(18446744073709551615)

#define PTRDIFF_MIN  (-PTRDIFF_MAX-1)
#define PTRDIFF_MAX  __PTRDIFF_MAX__

// Limits of the minimum-width and fastest minimum-width types
// (7.18.2.2 / 7.18.2.3), each its type's.
#define INT_LEAST8_MIN   INT8_MIN
#define INT_LEAST16_MIN  INT16_MIN
#define INT_LEAST32_MIN  INT32_MIN
#define INT_LEAST64_MIN  INT64_MIN
#define INT_LEAST8_MAX   INT8_MAX
#define INT_LEAST16_MAX  INT16_MAX
#define INT_LEAST32_MAX  INT32_MAX
#define INT_LEAST64_MAX  INT64_MAX
#define UINT_LEAST8_MAX  UINT8_MAX
#define UINT_LEAST16_MAX UINT16_MAX
#define UINT_LEAST32_MAX UINT32_MAX
#define UINT_LEAST64_MAX UINT64_MAX

#define INT_FAST8_MIN    INT8_MIN
#define INT_FAST16_MIN   (-INT_FAST16_MAX-1)
#define INT_FAST32_MIN   (-INT_FAST32_MAX-1)
#define INT_FAST64_MIN   INT64_MIN
#define INT_FAST8_MAX    INT8_MAX
#define INT_FAST16_MAX   __INT_FAST16_MAX__
#define INT_FAST32_MAX   __INT_FAST32_MAX__
#define INT_FAST64_MAX   INT64_MAX
#define UINT_FAST8_MAX   UINT8_MAX
#define UINT_FAST16_MAX  __UINT_FAST16_MAX__
#define UINT_FAST32_MAX  __UINT_FAST32_MAX__
#define UINT_FAST64_MAX  UINT64_MAX
