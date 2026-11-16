// Mandelbrot set over [-1.5, 0.5] x [-1, 1] on an N x N grid for the perf
// table: each point c iterates z <- z^2 + c from z = 0 at most ITERS times
// and belongs to the set unless |z| exceeds 2. Pixels are packed eight to
// a byte, most significant bit first and each row padded to a whole byte,
// and the bitmap is folded into an FNV-1a hash rather than written out.
// Exercises a short floating-point recurrence with a data-dependent exit,
// the shift-and-or packing of the comparison result, and the int-to-double
// conversions of the grid coordinates.
//
// The kernel's step is written one operation per statement, which C17
// 6.5p8 does not let a compiler contract into fused multiply-adds. No pixel
// of this grid is decided by the last bits of z, though: contracting or not
// leaves the bitmap unchanged. The pixel count and the hash are checked
// against their values, and a sample of rows recomputed by an unpacked loop
// written in the contractible form must match the bitmap.

#include <stdint.h>
#include <stdio.h>
#include "bench_clock.h"

#define N 2000
#define ITERS 50
#define ROW_BYTES ((N + 7) / 8)
#define SET_PIXELS 1588053L
#define HASH 0x364f690cu
#define SAMPLE_STRIDE 16

static unsigned char bitmap[N * ROW_BYTES];

static int bounded(double cr, double ci) {
    double zr = 0.0, zi = 0.0, zr2 = 0.0, zi2 = 0.0;
    for (int k = 0; k < ITERS; k++) {
        double zri = zr * zi;
        zi = zri + zri + ci;
        zr = zr2 - zi2 + cr;
        zr2 = zr * zr;
        zi2 = zi * zi;
        if (zr2 + zi2 > 4.0) {
            return 0;
        }
    }
    return 1;
}

static void render(unsigned char *out, int n) {
    int row_bytes = (n + 7) / 8;
    for (int y = 0; y < n; y++) {
        double ci = 2.0 * y / n - 1.0;
        unsigned char *row = out + (size_t)y * row_bytes;
        unsigned bits = 0;
        for (int x = 0; x < n; x++) {
            double cr = 2.0 * x / n - 1.5;
            bits = bits << 1 | (unsigned)bounded(cr, ci);
            if ((x & 7) == 7) {
                row[x >> 3] = (unsigned char)bits;
                bits = 0;
            }
        }
        if (n & 7) {
            row[n >> 3] = (unsigned char)(bits << (8 - (n & 7)));
        }
    }
}

// Escape test written as a counted loop over |z|^2 <= 4 for the sample check.
static int reference_pixel(int x, int y, int n) {
    double cr = -1.5 + 2.0 * x / n;
    double ci = -1.0 + 2.0 * y / n;
    double zr = 0.0, zi = 0.0;
    int k = 0;
    do {
        double t = zr * zr - zi * zi + cr;
        zi = 2.0 * zr * zi + ci;
        zr = t;
        k++;
    } while (k < ITERS && zr * zr + zi * zi <= 4.0);
    return zr * zr + zi * zi <= 4.0;
}

int main(void) {
    double t0 = bench_ms();
    render(bitmap, N);
    double t1 = bench_ms();

    uint32_t hash = 2166136261u;
    long pixels = 0;
    for (size_t i = 0; i < sizeof bitmap; i++) {
        hash = (hash ^ bitmap[i]) * 16777619u;
        for (unsigned b = bitmap[i]; b != 0; b &= b - 1) {
            pixels++;
        }
    }
    printf("mandelbrot %dx%d pixels=%ld hash=%08x in %.2f ms\n", N, N, pixels,
           (unsigned)hash, t1 - t0);

    long mismatches = 0;
    for (int y = 0; y < N; y += SAMPLE_STRIDE) {
        for (int x = 0; x < N; x++) {
            int bit = bitmap[(size_t)y * ROW_BYTES + (x >> 3)] >> (7 - (x & 7)) & 1;
            mismatches += bit != reference_pixel(x, y, N);
        }
    }
    if (pixels != SET_PIXELS || hash != HASH || mismatches != 0) {
        printf("WRONG: expected pixels=%ld hash=%08x, %ld sampled pixels differ\n", SET_PIXELS,
               HASH, mismatches);
        return 1;
    }
    return 0;
}
