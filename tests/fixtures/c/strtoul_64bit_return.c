// C99 7.20.1.4 / 7.20.1.2: strtoul/strtol/atol return unsigned long /
// long / long, which are 64-bit on LP64 targets. A libc return wider
// than the prototype's declared type is narrowed to that type, so a
// prototype declaring these `int` silently drops the high 32 bits of
// any value >= 2^32 (strtoul / atol) or 2^31 (strtol). The header
// prototypes carry the standard's return widths to avoid that.
//
// Surfaced by Tcl binary.test binary-37.12 (GetFormatSpec count
// overflow): strtoul("4294967296") returned 0 instead of 2^32, so a
// count-overflow guard never tripped.
#include <stdlib.h>

int main(void) {
    char *end;

    // 2^32: zero in the low 32 bits, so a 32-bit truncation reads 0.
    unsigned long u = strtoul("4294967296", &end, 10);
    if (u != 4294967296UL) return 1;

    // 2^32: signed parse, same low-32 trap.
    long l = strtol("4294967296", &end, 10);
    if (l != 4294967296L) return 2;

    // 5e9 > 2^32, exercises atol's long return.
    long a = atol("5000000000");
    if (a != 5000000000L) return 3;

    // unsigned long long past 2^32.
    unsigned long long ull = strtoull("9000000000", &end, 10);
    if (ull != 9000000000ULL) return 4;

    return 0;
}
