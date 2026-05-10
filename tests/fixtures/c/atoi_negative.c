// PE/AArch64 atoi("-17") sign-extension regression marker.
//
// AAPCS64 leaves the upper 32 bits of X0 unspecified for sub-word
// returns; Win64 (msvcrt) makes the same allowance for `int`-typed
// returns in EAX. c5's accumulator is 64-bit, so a downstream
// `acc != -17` compare against a sign-extended literal needs the
// libc return to be sign-extended into the full register first.
//
// `emit_extend_x19_for_return` (aarch64) / its x86_64 counterpart
// emit the appropriate `sxtw` / `movsxd` after every libc call
// based on the binding's return type tag. Linux glibc happens to
// leave the upper bits zeroed and masked the bug for years;
// msvcrt and the wine arm64 thunk don't.
#include <stdio.h>
#include <stdlib.h>

int main() {
    int positive = atoi("42");
    if (positive != 42) return 1;

    int negative = atoi("-17");
    if (negative != -17) return 2;

    int zero = atoi("0");
    if (zero != 0) return 3;

    return 0;
}
