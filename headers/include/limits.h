// limits.h -- compile-time limits for integer types.
//
// c5 collapses every integer to a 64-bit signed word, so the
// "real" limits are all 64-bit. We expose the conventional
// 32-bit values for INT_MAX / INT_MIN / UINT_MAX so portable
// programs that test against `INT_MAX` for overflow guards see
// the value they expect; programs that need a true 64-bit
// limit reach for `<stdint.h>` (`INT64_MAX` etc.).
#ifndef _C5_LIMITS_H
#define _C5_LIMITS_H

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

#define LONG_MIN   (-9223372036854775807-1)
#define LONG_MAX     9223372036854775807
#define ULONG_MAX   18446744073709551615

#define LLONG_MIN  LONG_MIN
#define LLONG_MAX  LONG_MAX
#define ULLONG_MAX ULONG_MAX

#define PATH_MAX    4096
#define NAME_MAX    255
#define IOV_MAX     1024
#define HOST_NAME_MAX 255
#define LOGIN_NAME_MAX 256

#endif
