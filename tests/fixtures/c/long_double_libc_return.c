// Locks SysV x86_64 ABI section 3.2.3: `long double` is returned
// in x87 `st(0)`, distinct from XMM0 (which carries `float` /
// `double`) and from RAX. c5 stores long double in an 8-byte
// f64 slot, so the libc-call lowering must spill st(0) and load
// the truncated bit pattern back into the c5 accumulator. The
// pre-fix path read XMM0 and got -0.0 for every call.
//
// The fixture covers two host-libc bindings that return long
// double on SysV x86_64: `strtold` (decimal-string parse) and
// `ldexpl` (scaled FP build). Each is exercised with a known
// power of two so the IEEE 754 double bit pattern is exact and
// fits in 8 bytes without rounding ambiguity. Returns 0 on
// success; each clause returns a distinct nonzero code.
//
// On macOS aarch64 and Linux aarch64, long double has the same
// register convention as double (v0 / d0), so the libc-return
// path through XMM-equivalent registers stays correct without
// the x87 dance. The fixture's expectations only depend on the
// numeric values, which match on every supported lane.

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
