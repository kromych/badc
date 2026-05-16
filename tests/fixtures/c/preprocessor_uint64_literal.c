// C99 6.10.1p4: preprocessor expressions evaluate in
// (u)intmax_t. A literal at or near 2^64 - 1 ("18446744073709551615"
// -- the canonical `ULONG_MAX` / `UINT64_MAX` value on LP64
// hosts) must parse without erroring, and shift operations on
// it must follow unsigned (logical) semantics so library
// idioms like `((ULONG_MAX >> 31) >> 31) == 3` (BearSSL's
// 64-bit host probe in inner.h) evaluate correctly.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

#include <limits.h>
#include <stdint.h>

#if ((ULONG_MAX >> 31) >> 31) != 3
#error "expected ((ULONG_MAX >> 31) >> 31) == 3 on an LP64 host"
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
