// AAPCS64 returns `long double` (IEEE binary128) in v0 as a
// single 128-bit Q register. c5 stores `long double` in an
// 8-byte FP64 slot, so libc's `strtold` would otherwise have its
// result truncated to v0's low 64 bits -- for power-of-two
// values like 2^32 the mantissa is zero and the low 64 bits are
// also zero, hiding the real exponent in v0's high half.
//
// The header carries `long double strtold(...);` so the
// prototype's `returns_long_double` flag is set on the binding,
// and the aarch64 codegen emits a `__trunctfdf2` follow-up to
// convert v0 (binary128) into d0 (FP64). Calling strtold here
// asserts the truncation actually fires: each of the parsed
// values would land at 0.0 without it.
//
// Returns 0 on success; distinct nonzero codes flag each failure
// mode for diagnostics.

#include <stdio.h>
#include <stdlib.h>

int main(void) {
    // Strict integer powers of two are exact in both binary64 and
    // binary128, so the post-truncation FP64 value must be the
    // mathematical value.
    long double v32 = strtold("4294967296", (char **)0);
    long double v64 = strtold("18446744073709551616", (char **)0);
    if ((double)v32 != 4294967296.0)             return 1;
    if ((double)v64 != 18446744073709551616.0)   return 2;

    // Negative values exercise the sign-bit propagation through
    // the truncation helper.
    long double vn = strtold("-1024.0", (char **)0);
    if ((double)vn != -1024.0) return 3;

    // Round-trip through a printf format that bottoms out on
    // FP64 (`%g` reads through `double`); without the truncation
    // both lines would print "0".
    char buf[32];
    int n = sprintf(buf, "%.0f", (double)v32);
    if (n <= 0) return 4;
    if (buf[0] != '4') return 5;

    return 0;
}
