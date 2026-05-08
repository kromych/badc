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
#ifndef _C5_STDINT_H
#define _C5_STDINT_H

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

#define INT8_C(c)   c
#define INT16_C(c)  c
#define INT32_C(c)  c
#define INT64_C(c)  c
#define INTMAX_C(c) c

#define UINT8_C(c)   c
#define UINT16_C(c)  c
#define UINT32_C(c)  c
#define UINT64_C(c)  c
#define UINTMAX_C(c) c

#define INT8_MIN  (-128)
#define INT16_MIN (-32768)
#define INT32_MIN (-2147483648)
#define INT64_MIN (-9223372036854775808)

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

#endif
