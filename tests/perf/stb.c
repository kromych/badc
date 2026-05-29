// In-memory procedural-generation workload for the perf harness: a
// Perlin noise field sampled across a grid, repeated over several
// frames. The hot path is single-precision floating point (multiplies,
// adds, the gradient dot products and smoothstep interpolation) with
// integer lattice indexing, so the wall-clock reflects the FP codegen
// path rather than the integer one the other fixtures exercise. Self-
// times via clock_gettime and prints "in N ms".
//
// stb_perlin is a single header; defining the implementation macro and
// including it makes the fixture one translation unit. The harness puts
// demos/stb on the include search path.
#include <stdint.h>
#include <stdio.h>
#include <time.h>

#define STB_PERLIN_IMPLEMENTATION
#include "stb_perlin.h"

#define DIM 96
#define FRAMES 300

int main(void) {
    struct timespec t0, t1;
    clock_gettime(CLOCK_MONOTONIC, &t0);
    // Truncate each sample to a fixed-point integer before summing so
    // the checksum is stable against the small result differences an
    // optimizing compiler's FP reassociation can introduce.
    int64_t checksum = 0;
    for (int f = 0; f < FRAMES; f++) {
        float z = (float)f * 0.05f;
        for (int y = 0; y < DIM; y++) {
            for (int x = 0; x < DIM; x++) {
                float n = stb_perlin_noise3((float)x * 0.10f,
                                            (float)y * 0.10f, z, 0, 0, 0);
                checksum += (int64_t)(n * 256.0f);
            }
        }
    }
    clock_gettime(CLOCK_MONOTONIC, &t1);

    long secs = t1.tv_sec - t0.tv_sec;
    long nsecs = t1.tv_nsec - t0.tv_nsec;
    double ms = (double)secs * 1000.0 + (double)nsecs / 1000000.0;
    long long samples = (long long)FRAMES * DIM * DIM;
    printf("perlin %lldx checksum=%lld in %.2f ms\n", samples,
           (long long)checksum, ms);
    return 0;
}
