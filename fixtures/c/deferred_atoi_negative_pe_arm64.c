// DEFERRED (#48): atoi("-17") returns the wrong value on PE/
// AArch64 when libc_basic.c runs through wine on Linux aarch64
// -- exit 21 (line `if (atoi("-17") != -17) return 21;`).
//
// This isolated fixture *does* exit 0 today on the same wine
// arm64 host -- the bug needs the surrounding libc call sequence
// from libc_basic.c (strlen, strcmp, strncpy, sprintf, isspace,
// isdigit, isalpha, ...) to put x0's high half into the right
// state for the bug to surface.
//
// Suspected mechanism: msvcrt's `atoi` returns an `int` (4 bytes)
// in the low half of x0 per Windows ARM64 ABI; wine's arm64
// thunk doesn't always sign-extend the int return into the full
// x0 before handing back to the c5-emitted code. The c5 caller
// reads x0 as i64 directly (no MOVSXD / SXTW on the libc-call
// return path), so the negative value can be read as a large
// positive (0x00000000_FFFFFFEF rather than 0xFFFFFFFF_FFFFFFEF).
// The fix is either to narrow the int-typed libc return through
// SXTW on the c5-frame entry side, or to rely on wine's thunk.
//
// Keeping this fixture as a structural marker -- if it ever
// starts FAILING in isolation we'll know the trigger has
// broadened. The active failing case is `libc_basic.c` in
// NATIVE_PE_ARM64_FIXTURES.
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
