// A `long double` a libc function returns reaches the caller: System V
// x86-64 returns it in x87 `st(0)` and AAPCS64 in `v0` as binary128,
// neither where a `double` returns. Read as a `double`, every call gave
// -0.0 on x86-64.
//
// `strtold` is the platform's; `ldexpl` is the header's long-double form
// over `ldexp`. Each is exercised with a power of two, so the double
// value is exact. Returns 0 on success; each clause returns a distinct
// nonzero code.

#include <stdlib.h>
#include <math.h>

int main(void) {
    // 2^96 -- chosen so the value overflows IEEE 754 single but
    // fits in double with an exact mantissa (zero) and a clean
    // exponent. The double bit pattern is 0x45F0000000000000.
    double a = (double)strtold("79228162514264337593543950336.0", (char **)0);
    if (a != 79228162514264337593543950336.0) return 11;

    // 2^64 -- same shape, smaller exponent. Bit pattern
    // 0x43F0000000000000.
    double b = (double)strtold("18446744073709551616.0", (char **)0);
    if (b != 18446744073709551616.0) return 12;

    // ldexpl builds 1.0 * 2^N at long-double precision; the
    // double cast must yield the same IEEE 754 bit pattern as
    // a literal. Pre-fix path returned -0.0 here too.
    double c = (double)ldexpl((long double)1.0, 53);
    if (c != 9007199254740992.0) return 13;

    return 0;
}
