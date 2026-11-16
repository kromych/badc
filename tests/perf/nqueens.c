// N-queens solution counting for the perf table: every placement of n
// queens on an n x n board with no two sharing a column or a diagonal, for
// n = 1..MAX_N, found by backtracking one row at a time. The columns and
// the two diagonal directions taken so far are bitmasks; the diagonals
// shift by one bit per row, the free squares of a row are the complement
// of their union, and each is taken in turn by isolating the lowest set
// bit with x & -x. Exercises recursion with live values across the call,
// shifts, and-not, and negation on unsigned registers, and a loop whose
// trip count is the number of set bits.
//
// Every count is checked against the number of solutions for its n.

#include <stdio.h>
#include "bench_clock.h"

#define MAX_N 14

static const long solutions[MAX_N + 1] = {
    1, 1, 0, 0, 2, 10, 4, 40, 92, 352, 724, 2680, 14200, 73712, 365596,
};

static long place(unsigned cols, unsigned left, unsigned right, unsigned full) {
    if (cols == full) {
        return 1;
    }
    long count = 0;
    unsigned free_squares = full & ~(cols | left | right);
    while (free_squares != 0) {
        unsigned bit = free_squares & -free_squares;
        free_squares ^= bit;
        count += place(cols | bit, (left | bit) << 1, (right | bit) >> 1, full);
    }
    return count;
}

int main(void) {
    long counts[MAX_N + 1];
    long total = 0;

    double t0 = bench_ms();
    for (int n = 1; n <= MAX_N; n++) {
        counts[n] = place(0, 0, 0, (1u << n) - 1);
        total += counts[n];
    }
    double t1 = bench_ms();

    printf("nqueens 1..%d total=%ld in %.2f ms\n", MAX_N, total, t1 - t0);

    for (int n = 1; n <= MAX_N; n++) {
        if (counts[n] != solutions[n]) {
            printf("WRONG: %ld solutions for n = %d, expected %ld\n", counts[n], n, solutions[n]);
            return 1;
        }
    }
    return 0;
}
