// Recursive Fibonacci stress for the perf table. Exercises call /
// return scheduling, the per-function prologue / epilogue, and the
// add-and-compare hot path. Runtime grows ~exponentially in N; pick
// N so wall-clock is in the 50-500 ms range on the slowest
// compiler under test.
//
// The shape is chosen for the code generator, not for the result. An
// implementation that had to produce Fibonacci numbers would iterate,
// or use fast doubling, in O(n) additions: this one makes 126 491 971
// calls for fib(38), and those calls are the measurement. It would
// also bound its domain, since fib(93) overflows the `long` this
// returns.

#include <stdio.h>
#include "bench_clock.h"

#define N 38

static long fib(int n) {
    if (n < 2) return (long)n;
    return fib(n - 1) + fib(n - 2);
}

int main(void) {
    double t0 = bench_ms();
    long r = fib(N);
    double t1 = bench_ms();

    double ms = t1 - t0;
    printf("fib(%d) = %ld in %.2f ms\n", N, r, ms);

    // Sanity-check against the known value so a miscompilation
    // surfaces as a non-zero exit rather than a wrong timing.
    if (r != 39088169L) {
        printf("WRONG: expected 39088169\n");
        return 1;
    }
    return 0;
}
