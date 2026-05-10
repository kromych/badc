// stdint.h must alias each fixed-width typedef to a real type
// of the matching byte width. Pre-fix the bundled stdint.h had
// `typedef int` for every alias (left over from the era when
// every c5 integer was 64 bits); with M31's split-out signed
// char / short / int / long / long long that's wrong, and code
// using `int64_t` / `intptr_t` / etc. silently truncated.
#include <stdio.h>
#include <stdint.h>

int main() {
    if (sizeof(int8_t)   != 1) return 1;
    if (sizeof(int16_t)  != 2) return 2;
    if (sizeof(int32_t)  != 4) return 3;
    if (sizeof(int64_t)  != 8) return 4;
    if (sizeof(intptr_t) != 8) return 5;
    if (sizeof(intmax_t) != 8) return 6;

    if (sizeof(uint8_t)   != 1) return 11;
    if (sizeof(uint16_t)  != 2) return 12;
    if (sizeof(uint32_t)  != 4) return 13;
    if (sizeof(uint64_t)  != 8) return 14;
    if (sizeof(uintptr_t) != 8) return 15;
    if (sizeof(uintmax_t) != 8) return 16;

    // 64-bit values round-trip through int64_t / uint64_t
    // storage: pre-fix these would silently lose the high half.
    int64_t big = 0x1122334455667788;
    if (big != 0x1122334455667788) return 21;

    uint64_t ubig = 0xFEDCBA9876543210u;
    if (ubig != 0xFEDCBA9876543210u) return 22;

    // intptr_t round-trip a real pointer through the integer
    // form. Since pointers are 8 bytes everywhere, intptr_t
    // must also be 8 bytes for this to work.
    int x = 42;
    int *p = &x;
    intptr_t pi = (intptr_t)p;
    int *back = (int *)pi;
    if (*back != 42) return 23;

    // 16-bit signed value round-trip with sign extension on
    // load. -1 stored as int16_t reads back as -1, not 65535.
    int16_t neg = -1;
    int widened = neg;
    if (widened != -1) return 24;

    // 8-bit signed sign-extension via the cast path landed
    // separately (signed_cast_extends.c); int8_t storage is
    // only valid if signed-char loads sign-extend, which is
    // already covered by short_types.c. This fixture just
    // pins the byte widths.

    printf("OK\n");
    return 0;
}
