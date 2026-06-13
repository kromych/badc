// Sieve of Eratosthenes stress for the perf table. Exercises a dense
// byte-array write/read loop with a multiplicative inner stride, the
// add-by-step inner cursor, and an integer accumulator over a large
// working set. Pick N so wall-clock is in the 50-500 ms range on the
// slowest compiler under test.

#include <stdio.h>
#include <time.h>

#define N 30000000

static char composite[N];

int main(void) {
    struct timespec t0, t1;
    clock_gettime(CLOCK_MONOTONIC, &t0);

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

    clock_gettime(CLOCK_MONOTONIC, &t1);
    long secs = t1.tv_sec - t0.tv_sec;
    long nsecs = t1.tv_nsec - t0.tv_nsec;
    double ms = (double)secs * 1000.0 + (double)nsecs / 1000000.0;
    printf("sieve(%d) = %ld in %.2f ms\n", N, count, ms);

    // Sanity-check against the known prime count so a miscompilation
    // surfaces as a non-zero exit rather than a wrong timing.
    if (count != 1857859L) {
        printf("WRONG: expected 1857859\n");
        return 1;
    }
    return 0;
}
