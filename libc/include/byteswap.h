// byteswap.h -- glibc byte-reversal macros. Not POSIX, but a program
// including this header wants the glibc spelling, and no platform
// library is involved, so it is provided on every target.
//
// glibc's `__bswap_N` are inline functions taking `uintN_t`; badc's
// `__builtin_bswapN` converts its argument and types its result the
// same way, so these macros carry glibc's semantics unchanged.

#pragma once

#define __bswap_16(x) __builtin_bswap16(x)
#define __bswap_32(x) __builtin_bswap32(x)
#define __bswap_64(x) __builtin_bswap64(x)

#define bswap_16(x) __bswap_16(x)
#define bswap_32(x) __bswap_32(x)
#define bswap_64(x) __bswap_64(x)
