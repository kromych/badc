// Regression for the aarch64 `Op::Mcpy` lowering. The previous
// shape used `ldur` / `stur` (the unscaled 9-bit signed-offset
// load / store), which can only express byte offsets in the range
// [-256, 255]. For struct sizes larger than ~256 bytes, every
// per-word `ldur Xt, [base, #(N*8)]` with N*8 >= 256 silently
// wrapped through the 9-bit mask -- the encoder's debug_assert
// caught it in dev builds but release builds masked the offset
// to its low 9 bits and copied from / stored to the wrong byte
// of the struct.
//
// Concrete repro: a large internal struct (~1.9 KB) copied
// by value via `*f = p;`. The wrap silently zeroed every
// field past offset 256, including a sentinel field expected
// to be -1 after setup; a later read then took the wrong
// branch and produced no output.
//
// The fix swaps `ldur/stur` for the scaled-12-bit `ldr/str`
// pair (byte offset range [0, 32760] when 8-byte aligned).
// This fixture exercises a 400+ byte struct copy and verifies
// every field round-trips.

#include <stdio.h>
#include <string.h>

struct big {
    int a, b, c, d;
    int row1[40];
    int marker_low;     /* offset 4*4 + 40*4 = 176 (within 9-bit) */
    int row2[40];
    int marker_mid;     /* offset 4 + 4 + 176 + 4 + 40*4 = 344 (>= 256) */
    int row3[40];
    int marker_high;    /* offset 348 + 4 + 40*4 = 512 */
    int e, f, g, h;
};

int main(void) {
    struct big p;
    struct big f;
    int i;

    /* Fill p with deterministic values. */
    p.a = 100; p.b = 200; p.c = 300; p.d = 400;
    p.marker_low = -1;
    p.marker_mid = -2;
    p.marker_high = -3;
    p.e = 500; p.f = 600; p.g = 700; p.h = 800;
    for (i = 0; i < 40; i++) {
        p.row1[i] = 1000 + i;
        p.row2[i] = 2000 + i;
        p.row3[i] = 3000 + i;
    }

    /* Pre-fill f with junk so a partial copy is visible. */
    memset(&f, 0x7e, sizeof(f));

    /* The struct copy under test. */
    f = p;

    /* Every field must round-trip. */
    if (f.a != 100 || f.b != 200 || f.c != 300 || f.d != 400) return 1;
    if (f.e != 500 || f.f != 600 || f.g != 700 || f.h != 800) return 2;
    if (f.marker_low != -1) return 3;
    if (f.marker_mid != -2) return 4;        /* the >= 256 byte */
    if (f.marker_high != -3) return 5;       /* the deep tail */
    for (i = 0; i < 40; i++) {
        if (f.row1[i] != 1000 + i) return 10 + i;
        if (f.row2[i] != 2000 + i) return 60 + i;
        if (f.row3[i] != 3000 + i) return 110 + i;
    }

    printf("large struct copy OK\n");
    return 0;
}
