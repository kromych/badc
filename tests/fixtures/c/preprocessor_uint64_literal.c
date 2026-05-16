// C99 6.10.1p4: preprocessor expressions evaluate in
// (u)intmax_t. A literal at or near 2^64 - 1 ("18446744073709551615"
// -- the canonical `ULONG_MAX` / `UINT64_MAX` value on LP64
// hosts) must parse without erroring, and shift operations on
// it must follow unsigned (logical) semantics so library
// idioms like `((ULONG_MAX >> 31) >> 31) == 3` (a 64-bit-host
// probe pattern common in cryptographic library headers)
// evaluate correctly.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

#include <limits.h>
#include <stdint.h>

// `unsigned long` is 32 bits on Windows (LLP64) and 64 bits on
// the POSIX targets (LP64). The ULONG_MAX shift probe yields
// a distinct result per layout: 3 for the 64-bit case
// (0xFFFFFFFFFFFFFFFF >> 31 = 0x1FFFFFFFF; >> 31 = 3), 0 for
// the 32-bit case (0xFFFFFFFF >> 31 = 1; >> 31 = 0). Both
// branches still exercise the bare-literal parse and the
// logical right shift on a stored bit pattern.
#ifdef __BADC_WINDOWS__
#if ((ULONG_MAX >> 31) >> 31) != 0
#error "expected ((ULONG_MAX >> 31) >> 31) == 0 on an LLP64 host"
#endif
#else
#if ((ULONG_MAX >> 31) >> 31) != 3
#error "expected ((ULONG_MAX >> 31) >> 31) == 3 on an LP64 host"
#endif
#endif

#if ((UINT64_MAX >> 31) >> 31) != 3
#error "expected ((UINT64_MAX >> 31) >> 31) == 3"
#endif

#if (18446744073709551615 >> 32) != 4294967295
#error "expected (2^64-1) >> 32 == 2^32-1"
#endif

#if 18446744073709551615 == 0
#error "2^64-1 must be truthy in a #if"
#endif

int main(void) {
    return 0;
}
