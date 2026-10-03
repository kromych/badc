// Sieve of Eratosthenes stress for the perf table. Exercises a dense
// byte-array write/read loop with a multiplicative inner stride, the
// add-by-step inner cursor, and an integer accumulator over a large
// working set. Pick N so wall-clock is in the 50-500 ms range on the
// slowest compiler under test.
//
// The shape is chosen for the code generator, not for the memory it
// uses. An implementation meant for use would take the bound and the
// storage from its caller rather than fixing a 30 MB array of `char`
// in .bss, and hold a bit per odd number -- 1.9 MB here, a sixteenth
// of what this writes. The byte array and the dense loops over it are
// what make the store, the strided address and the accumulator
// measurable.

#include <stdio.h>
#include "bench_clock.h"

#define N 30000000

static char composite[N];

int main(void) {
    double t0 = bench_ms();

    for (int i = 2; (long)i * i < N; i++) {
        if (!composite[i]) {
            for (int j = i * i; j < N; j += i) {
                composite[j] = 1;
            }
        }
    }
    long count = 0;
    for (int i = 2; i < N; i++) {
        if (!composite[i]) {
            count++;
        }
    }

    double t1 = bench_ms();
    double ms = t1 - t0;
    printf("sieve(%d) = %ld in %.2f ms\n", N, count, ms);

    // Sanity-check against the known prime count so a miscompilation
    // surfaces as a non-zero exit rather than a wrong timing.
    if (count != 1857859L) {
        printf("WRONG: expected 1857859\n");
        return 1;
    }
    return 0;
}
