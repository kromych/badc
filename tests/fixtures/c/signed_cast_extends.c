// Casts to a signed integer type narrower than 8 bytes must
// truncate-and-sign-extend per C99 6.3.1.3, even when the
// source operand is the same width but unsigned. Sqlite's
// `ONE_BYTE_INT(x) ((i8)(x)[0])` macro depends on this:
// `x` is `unsigned char[]`, so `(x)[0]` is an unsigned char
// value 0..255, and `(i8)` has to flip values >= 0x80 to
// negative.
//
// Pre-fix, c5 only emitted the shift-pair when the cast was
// genuinely narrowing (target_size < source_size), which
// missed the `unsigned char -> signed char` and
// `unsigned short -> signed short` shapes.
#include <stdio.h>

int main() {
    // (signed char) of unsigned char value with high bit set.
    unsigned char ub = 0xFF;
    int r1 = (signed char)ub;
    if (r1 != -1) return 1;

    unsigned char ub2 = 0x80;
    int r2 = (signed char)ub2;
    if (r2 != -128) return 2;

    unsigned char ub3 = 0x7F;
    int r3 = (signed char)ub3;
    if (r3 != 127) return 3;

    // (signed char) of an unsigned int that fits in 8 bits.
    unsigned int ui = 0xFFu;
    int r4 = (signed char)ui;
    if (r4 != -1) return 4;

    // (signed char) of an unsigned int that overflows 8 bits:
    // truncates to low 8 bits then sign-extends.
    unsigned int ui2 = 0x12345678u;
    int r5 = (signed char)ui2;
    if (r5 != 0x78) return 5;

    unsigned int ui3 = 0x1234ABFFu;
    int r6 = (signed char)ui3;
    if (r6 != -1) return 6;

    // (short) of unsigned short with high bit set.
    unsigned short us = 0xFFFFu;
    int r7 = (short)us;
    if (r7 != -1) return 7;

    unsigned short us2 = 0x8000u;
    int r8 = (short)us2;
    if (r8 != -32768) return 8;

    // (short) of unsigned int wider than 16 bits.
    unsigned int ui4 = 0x12345678u;
    int r9 = (short)ui4;
    if (r9 != 0x5678) return 9;

    unsigned int ui5 = 0x1234FFFFu;
    int r10 = (short)ui5;
    if (r10 != -1) return 10;

    // (signed char) of signed char already correctly extended:
    // the shift-pair would still be a no-op effect, so the value
    // round-trips.
    signed char sc = -42;
    int r11 = (signed char)sc;
    if (r11 != -42) return 11;

    // ONE_BYTE_INT shape: `(i8)(arr[0])` where arr is
    // unsigned char[].
    unsigned char arr[3];
    arr[0] = 0xFF;
    arr[1] = 0x42;
    arr[2] = 0x10;
    int one = (signed char)(arr)[0];
    if (one != -1) return 12;

    int two = 256 * (signed char)(arr[0]) | arr[1];
    if (two != (-256 | 0x42)) return 13;

    printf("OK\n");
    return 0;
}
