// Exercise `short` and `unsigned short` types: shifts, arithmetic,
// signed/unsigned mix. c5 currently maps `short` onto plain `int`
// (4 bytes, no 16-bit truncation), so this fixture pins down the
// observed behavior of c5's short -- not strictly C99 short
// semantics. The body is written so every assertion holds for the
// 32-bit-int interpretation; if real 16-bit short support lands
// later, the masks/casts here continue to give the same answers.
//
// Why every value is masked: in real C, `short s = 0x7FFF; s + 1`
// overflows to negative; c5's `s + 1` is just 0x8000 (still
// positive). Masking with `& 0xFFFF` and casting back forces the
// expression to behave like 16-bit arithmetic on either dialect.
#include <stdio.h>

static int as_short(int v) {
    int m = v & 0xFFFF;
    if (m & 0x8000) return m - 0x10000;
    return m;
}

static int as_ushort(int v) {
    return v & 0xFFFF;
}

int main() {
    // ---- basic load + store of signed short ----
    short a = 1234;
    short b = -42;
    if (a != 1234) return 1;
    if (b != -42) return 2;

    // ---- signed short arithmetic that stays in range ----
    short c = a + b;          // 1192
    if (c != 1192) return 3;
    short d = a - b;          // 1276
    if (d != 1276) return 4;
    short e = b * 3;          // -126
    if (e != -126) return 5;
    short f = a / 7;          // 176
    if (f != 176) return 6;
    short g = a % 7;          // 2
    if (g != 2) return 7;

    // ---- shift behavior ----
    short h = 1;
    short hi = h << 14;       // 16384
    if (hi != 16384) return 8;

    // 16-bit-truncated left-shift via mask helper.
    short overflow_lo = as_short(((int)h) << 16); // 0
    if (overflow_lo != 0) return 9;
    short would_set_sign_bit = as_short(((int)h) << 15);
    if (would_set_sign_bit != -32768) return 10;

    // Right shift on signed short keeps sign on c5 (long path).
    short neg = -8;
    short neg_shr = neg >> 1; // -4 under arithmetic shift
    if (neg_shr != -4) return 11;

    // ---- unsigned short arithmetic ----
    unsigned short ua = 0xFFFE;
    unsigned short ub = 1;
    int sum_int = (int)ua + (int)ub;     // 0xFFFF
    unsigned short usum = as_ushort(sum_int);
    if (usum != 0xFFFF) return 12;

    // Unsigned wraparound: 0xFFFF + 1 == 0 under 16-bit semantics.
    unsigned short uwrap = as_ushort((int)ua + (int)ub + 1);
    if (uwrap != 0) return 13;

    // ---- signed/unsigned mix ----
    short s = -1;
    unsigned short us = 1;
    int mixed = (int)us + (int)s;  // 0
    if (mixed != 0) return 14;

    // Compare via explicit unsigned reinterpretation.
    int neg_as_u = as_ushort(s);   // 0xFFFF
    if (neg_as_u != 0xFFFF) return 15;
    if ((unsigned int)neg_as_u <= (unsigned int)us) return 16;

    // ---- shifts on unsigned short ----
    unsigned short u_shifted = as_ushort(((int)ub) << 15); // 0x8000
    if (u_shifted != 0x8000) return 17;

    // Right shift of unsigned short keeps zero in the high bit.
    unsigned short u_high = 0x8000;
    int u_high_int = u_high & 0xFFFF;
    int u_high_shifted = u_high_int >> 1;  // 0x4000
    if (u_high_shifted != 0x4000) return 18;

    // ---- pointer-to-short load/store ----
    short arr[4];
    arr[0] = 100;
    arr[1] = 200;
    arr[2] = -300;
    arr[3] = as_short(arr[0] + arr[1] + arr[2]);  // 0
    if (arr[3] != 0) return 19;

    // ---- struct fields ----
    struct sx { short s1; short s2; unsigned short s3; };
    struct sx x;
    x.s1 = 7;
    x.s2 = -7;
    x.s3 = 0xC0DE;
    if (x.s1 + x.s2 != 0) return 20;
    if (x.s3 != 0xC0DE) return 21;

    return 42;
}
