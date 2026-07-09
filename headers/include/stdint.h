// stdint.h -- fixed-width integer types and constant macros.
//
// c5 now exposes real per-width integer storage (M31 split out
// signed char / short / int / long / long long), so the
// fixed-width typedefs alias the underlying type with the
// matching byte width on every supported target:
//
//   * `int8_t`  / `uint8_t`  -> 1 byte (signed / unsigned char)
//   * `int16_t` / `uint16_t` -> 2 bytes (short / unsigned short)
//   * `int32_t` / `uint32_t` -> 4 bytes (int / unsigned int)
//   * `int64_t` / `uint64_t` -> 8 bytes (long long / unsigned long long)
//
// `intptr_t` and `intmax_t` are 8 bytes on every supported
// target -- pointer-wide on LP64 (Linux / macOS) and LLP64
// (Windows) alike. We use `long long` rather than `long` so the
// width is independent of the LP64-vs-LLP64 split (`long` is 4
// bytes on Windows).
//
// The constant macros (`INT8_C(c)` ... `UINTMAX_C(c)`) are
// identity wrappers; c5's lexer ignores integer-literal
// suffixes, and the receiving slot's typedef pins the width.
#pragma once

typedef signed char         int8_t;
typedef short               int16_t;
typedef int                 int32_t;
typedef long long           int64_t;
typedef long long           intptr_t;
typedef long long           intmax_t;

typedef unsigned char       uint8_t;
typedef unsigned short      uint16_t;
typedef unsigned int        uint32_t;
typedef unsigned long long  uint64_t;
typedef unsigned long long  uintptr_t;
typedef unsigned long long  uintmax_t;

// Minimum-width (7.18.1.2) and fastest minimum-width (7.18.1.3) types.
// Both alias the exact-width type of the requested size, matching the
// macOS choice and satisfying the "at least N bits" requirement.
typedef int8_t              int_least8_t;
typedef int16_t             int_least16_t;
typedef int32_t             int_least32_t;
typedef int64_t             int_least64_t;
typedef uint8_t             uint_least8_t;
typedef uint16_t            uint_least16_t;
typedef uint32_t            uint_least32_t;
typedef uint64_t            uint_least64_t;

typedef int8_t              int_fast8_t;
typedef int16_t             int_fast16_t;
typedef int32_t             int_fast32_t;
typedef int64_t             int_fast64_t;
typedef uint8_t             uint_fast8_t;
typedef uint16_t            uint_fast16_t;
typedef uint32_t            uint_fast32_t;
typedef uint64_t            uint_fast64_t;

// C99 7.18.4.1: `INTN_C`/`UINTN_C` expand to an integer constant of type
// `int_leastN_t`/`uint_leastN_t`. The width suffix is required so the value
// carries the wide type -- without it `UINT64_C(1) << 35` would evaluate in
// `int` and lose bits above 31. `LL`/`ULL` are used for the 64-bit and max
// forms because `long` is 32 bits under LLP64 (Windows); `long long` is at
// least 64 bits on every target. The 8/16-bit forms promote to `int`, so a
// bare token is conforming for those.
#define INT8_C(c)   c
#define INT16_C(c)  c
#define INT32_C(c)  c
#define INT64_C(c)  c##LL
#define INTMAX_C(c) c##LL

#define UINT8_C(c)   c
#define UINT16_C(c)  c
#define UINT32_C(c)  c##U
#define UINT64_C(c)  c##ULL
#define UINTMAX_C(c) c##ULL

#define INT8_MIN  (-128)
#define INT16_MIN (-32768)
/* C99 7.18.2: written as `-MAX-1` so the positive operand of unary minus
   stays in range for the macro's exact-width signed type (matching the
   limits.h idiom). `2147483648` exceeds INT_MAX and `9223372036854775808`
   is unrepresentable in any signed type. */
#define INT32_MIN (-2147483647-1)
#define INT64_MIN (-9223372036854775807LL-1)

#define INT8_MAX  127
#define INT16_MAX 32767
#define INT32_MAX 2147483647
#define INT64_MAX 9223372036854775807

#define UINT8_MAX  255
#define UINT16_MAX 65535
#define UINT32_MAX 4294967295
#define UINT64_MAX 18446744073709551615

#define SIZE_MAX     UINT64_MAX
#define INTPTR_MIN   INT64_MIN
#define INTPTR_MAX   INT64_MAX
#define UINTPTR_MAX  UINT64_MAX
#define INTMAX_MIN   INT64_MIN
#define INTMAX_MAX   INT64_MAX
#define UINTMAX_MAX  UINT64_MAX

#define PTRDIFF_MIN  INT64_MIN
#define PTRDIFF_MAX  INT64_MAX

// Limits of the minimum-width and fastest minimum-width types
// (7.18.2.2 / 7.18.2.3); each aliases its exact-width limit.
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
#define INT_FAST16_MIN   INT16_MIN
#define INT_FAST32_MIN   INT32_MIN
#define INT_FAST64_MIN   INT64_MIN
#define INT_FAST8_MAX    INT8_MAX
#define INT_FAST16_MAX   INT16_MAX
#define INT_FAST32_MAX   INT32_MAX
#define INT_FAST64_MAX   INT64_MAX
#define UINT_FAST8_MAX   UINT8_MAX
#define UINT_FAST16_MAX  UINT16_MAX
#define UINT_FAST32_MAX  UINT32_MAX
#define UINT_FAST64_MAX  UINT64_MAX
