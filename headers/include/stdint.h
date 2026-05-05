// stdint.h -- fixed-width integer types and constant macros.
//
// c5 collapses every integer to a 64-bit signed word, so all the
// fixed-width integer typedefs alias plain `int`. The constant
// macros (`INT8_C(c)`, `UINT64_C(c)`, ...) are identity wrappers;
// the suffix is stripped because c5's lexer ignores integer
// literal suffixes anyway.
#ifndef _C5_STDINT_H
#define _C5_STDINT_H

typedef int int8_t;
typedef int int16_t;
typedef int int32_t;
typedef int int64_t;
typedef int intptr_t;
typedef int intmax_t;

typedef int uint8_t;
typedef int uint16_t;
typedef int uint32_t;
typedef int uint64_t;
typedef int uintptr_t;
typedef int uintmax_t;

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
