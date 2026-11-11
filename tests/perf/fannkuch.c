// Pancake flipping over every permutation of 0..n-1 for the perf table.
// For each permutation, while the first element k is not 0, the first k+1
// elements are reversed; the fixture reports the most flips any
// permutation takes and a checksum adding the flip counts of the
// even-numbered permutations and subtracting those of the odd-numbered
// ones. The permutations come in the order of a mixed-radix counter: each
// step rotates the first r+1 elements left by one, where r is the lowest
// digit that has not wrapped, and the checksum depends on that order.
// Exercises short counted loops over a small int array, the reversal's two
// converging indices, and data-dependent branches.
//
// The results are checked against the values for n = 7 (228, 16) and
// n = 10 (73196, 38).

#include <stdio.h>
#include "bench_clock.h"

#define N 10
#define MAXN 16

static int fannkuch(int n, int *max_flips) {
    int perm[MAXN], perm1[MAXN], count[MAXN];
    for (int i = 0; i < n; i++) {
        perm1[i] = i;
    }
    int checksum = 0, most = 0, r = n;
    long index = 0;
    for (;;) {
        for (; r != 1; r--) {
            count[r - 1] = r;
        }
        for (int i = 0; i < n; i++) {
            perm[i] = perm1[i];
        }
        int flips = 0;
        for (int k = perm[0]; k != 0; k = perm[0]) {
            for (int lo = 0, hi = k; lo < hi; lo++, hi--) {
                int t = perm[lo];
                perm[lo] = perm[hi];
                perm[hi] = t;
            }
            flips++;
        }
        if (flips > most) {
            most = flips;
        }
        checksum += index % 2 == 0 ? flips : -flips;

        for (;;) {
            if (r == n) {
                *max_flips = most;
                return checksum;
            }
            int first = perm1[0];
            for (int i = 0; i < r; i++) {
                perm1[i] = perm1[i + 1];
            }
            perm1[r] = first;
            if (--count[r] > 0) {
                break;
            }
            r++;
        }
        index++;
    }
}

int main(void) {
    int small_flips;
    int small = fannkuch(7, &small_flips);

    double t0 = bench_ms();
    int max_flips;
    int checksum = fannkuch(N, &max_flips);
    double t1 = bench_ms();

    printf("fannkuch(%d) checksum=%d max_flips=%d in %.2f ms\n", N, checksum, max_flips, t1 - t0);

    if (small != 228 || small_flips != 16 || checksum != 73196 || max_flips != 38) {
        printf("WRONG: expected 228 and 16 for 7, 73196 and 38 for 10\n");
        return 1;
    }
    return 0;
}
