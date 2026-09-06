// A vector passed as a variadic argument follows the same bank as a
// fixed one on the register-save-area ABIs: System V AMD64 psABI 3.5.7
// counts the vector registers a variadic call uses in `al` and saves
// xmm0-xmm7 whole, so `va_arg` of a 16-byte vector reads one 16-byte
// slot of the FP save area; AAPCS64 Appendix B saves q0-q7 and `va_arg`
// walks the vector area at a 16-byte stride. macOS arm64 diverges and
// passes every variadic argument on the stack, where the same values
// have to come back.
//
// The paths covered:
//
//   * a 16-byte vector read back through `va_arg` within the SIMD bank,
//   * more vectors than the bank holds, so the rest come from the
//     overflow stack, which the ABIs align to the vector's own width,
//   * vectors interleaved with doubles and integers, which advance
//     their own banks,
//   * more doubles and 64-bit vectors together than the SIMD bank holds,
//     so the bank runs out on values of two different widths, and
//   * a 64-bit vector, one eightbyte rather than a whole register.
//
// Every check returns a distinct nonzero code, so the exit code is 0
// only when every path agrees.

#include <stdarg.h>

typedef unsigned char u8x16 __attribute__((vector_size(16)));
typedef unsigned char u8x8 __attribute__((vector_size(8)));

static int lane_sum(int n, ...) {
    va_list ap;
    int t = 0;
    int i;
    va_start(ap, n);
    for (i = 0; i < n; i++) {
        u8x16 v = va_arg(ap, u8x16);
        t += v[0] + v[15];
    }
    va_end(ap);
    return t;
}

static int lane_sum8(int n, ...) {
    va_list ap;
    int t = 0;
    int i;
    va_start(ap, n);
    for (i = 0; i < n; i++) {
        u8x8 v = va_arg(ap, u8x8);
        t += v[0] + v[7];
    }
    va_end(ap);
    return t;
}

// One of each class per iteration: the integer bank, the SIMD bank for
// the double, and the SIMD bank again for the vector.
static double interleaved(int n, ...) {
    va_list ap;
    double t = 0;
    int i;
    va_start(ap, n);
    for (i = 0; i < n; i++) {
        int k = va_arg(ap, int);
        double d = va_arg(ap, double);
        u8x16 v = va_arg(ap, u8x16);
        t += (double)k + d + (double)v[3];
    }
    va_end(ap);
    return t;
}

// Twelve SIMD-bank arguments: the first eight take the registers and the
// rest the overflow stack, with the two widths interleaved.
static double bank_edge(int n, ...) {
    va_list ap;
    double t = 0;
    int i;
    va_start(ap, n);
    for (i = 0; i < n; i++) {
        double d = va_arg(ap, double);
        u8x8 v = va_arg(ap, u8x8);
        t += d + (double)(v[0] + v[7]);
    }
    va_end(ap);
    return t;
}

static u8x8 ramp8(unsigned char base) {
    u8x8 v;
    int i;
    for (i = 0; i < 8; i++) v[i] = (unsigned char)(base + i);
    return v;
}

static u8x16 ramp(unsigned char base) {
    u8x16 v;
    int i;
    for (i = 0; i < 16; i++) v[i] = (unsigned char)(base + i);
    return v;
}

int main(void) {
    // Two vectors, both within the bank: (1 + 16) + (3 + 18).
    if (lane_sum(2, ramp(1), ramp(3)) != 38) return 1;

    // Ten vectors: the first eight fill the SIMD argument registers and
    // the last two come from the overflow stack. Lane 0 and lane 15 of
    // ramp(k) are k and k + 15, so each contributes 2k + 15.
    {
        int expect = 0;
        int k;
        for (k = 1; k <= 10; k++) expect += 2 * k + 15;
        if (lane_sum(10, ramp(1), ramp(2), ramp(3), ramp(4), ramp(5),
                     ramp(6), ramp(7), ramp(8), ramp(9), ramp(10)) != expect) {
            return 2;
        }
    }

    u8x8 s;
    int i;
    for (i = 0; i < 8; i++) s[i] = (unsigned char)(i + 5);
    if (lane_sum8(1, s) != 5 + 12) return 3;

    // (7 + 0.5 + 13) + (9 + 0.25 + 23) = 52.75.
    if (interleaved(2, 7, 0.5, ramp(10), 9, 0.25, ramp(20)) != 52.75) {
        return 4;
    }

    // Six doubles and six 64-bit vectors: lane 0 and lane 7 of ramp8(k)
    // are k and k + 7, so each pair contributes k/4 + 2k + 7.
    {
        double expect = 0;
        int k;
        for (k = 1; k <= 6; k++) expect += (double)k / 4.0 + (double)(2 * k + 7);
        if (bank_edge(6, 0.25, ramp8(1), 0.5, ramp8(2), 0.75, ramp8(3), 1.0,
                      ramp8(4), 1.25, ramp8(5), 1.5, ramp8(6)) != expect) {
            return 5;
        }
    }

    return 0;
}
