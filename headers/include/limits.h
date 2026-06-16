// limits.h -- compile-time limits for integer types.
//
// `<stdint.h>` exposes fixed-width values (`INT32_MAX`,
// `INT64_MAX`, ...). This header gives the platform-named limits
// (`INT_MAX`, `LONG_MAX`, ...) which depend on the data model:
//
//   * `int` is 4 bytes on every supported target.
//   * `long` is 8 bytes on LP64 (Linux / macOS), 4 bytes on
//     LLP64 (Windows). The LONG_* values branch on
//     `__BADC_WINDOWS__` accordingly.
//   * `long long` is 8 bytes everywhere.
//
// Programs that want a target-independent 64-bit limit should
// reach for `INT64_MAX` (in stdint.h) or `LLONG_MAX`.
#pragma once

#define CHAR_BIT      8
#define MB_LEN_MAX    1

#define SCHAR_MIN   (-128)
#define SCHAR_MAX     127
#define UCHAR_MAX     255
#define CHAR_MIN  SCHAR_MIN
#define CHAR_MAX  SCHAR_MAX

#define SHRT_MIN   (-32768)
#define SHRT_MAX     32767
#define USHRT_MAX    65535

#define INT_MIN    (-2147483647-1)
#define INT_MAX     2147483647
#define UINT_MAX    4294967295

#ifdef __BADC_WINDOWS__
// LLP64: long is 32 bits, same range as int.
#define LONG_MIN  INT_MIN
#define LONG_MAX  INT_MAX
#define ULONG_MAX UINT_MAX
#else
// LP64: long is 64 bits.
#define LONG_MIN   (-9223372036854775807-1)
#define LONG_MAX     9223372036854775807
#define ULONG_MAX   18446744073709551615
#endif

// long long is 8 bytes on every target.
#define LLONG_MIN  (-9223372036854775807-1)
#define LLONG_MAX    9223372036854775807
#define ULLONG_MAX  18446744073709551615

#define PATH_MAX    4096
#define NAME_MAX    255
#define IOV_MAX     1024
#define HOST_NAME_MAX 255
#define LOGIN_NAME_MAX 256

// `ssize_t` is 64-bit on every supported target (see <sys/types.h>), so
// its maximum is the signed 64-bit limit.
#define SSIZE_MAX   9223372036854775807
