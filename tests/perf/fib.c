// Recursive Fibonacci stress for the perf table. Exercises call /
// return scheduling, the per-function prologue / epilogue, and the
// add-and-compare hot path. Runtime grows ~exponentially in N; pick
// N so wall-clock is in the 50-500 ms range on the slowest
// compiler under test.

#include <stdio.h>
#include <time.h>

#define N 38

static long fib(int n) {
    if (n < 2) return (long)n;
    return fib(n - 1) + fib(n - 2);
}

int main(void) {
    struct timespec t0, t1;
    clock_gettime(CLOCK_MONOTONIC, &t0);
    long r = fib(N);
    clock_gettime(CLOCK_MONOTONIC, &t1);

    long secs = t1.tv_sec - t0.tv_sec;
    long nsecs = t1.tv_nsec - t0.tv_nsec;
    double ms = (double)secs * 1000.0 + (double)nsecs / 1000000.0;
    printf("fib(%d) = %ld in %.2f ms\n", N, r, ms);

    // Sanity-check against the known value so a miscompilation
    // surfaces as a non-zero exit rather than a wrong timing.
    if (r != 39088169L) {
        printf("WRONG: expected 39088169\n");
        return 1;
    }
    return 0;
}
