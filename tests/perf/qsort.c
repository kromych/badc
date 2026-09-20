// Quicksort stress for the perf table. Exercises the swap in the
// partition loop, the two scanning cursors and the recursion that
// carries them. Pick N so wall-clock is in the 50-500 ms range on the
// slowest compiler under test.
//
// The shape is chosen for the code generator, not for sorting. This
// partition takes the middle element as its pivot, which an input
// built against it drives to O(n^2) comparisons, and it recurses on
// both sides, so its stack depth follows the recursion rather than
// O(log n). An implementation meant for use would take the median of
// three or the ninther as its pivot, fall back to heapsort past a
// depth of about 2*log2(n), cut over to insertion sort on short
// ranges, recurse on the smaller side and loop on the larger, and sort
// through a comparison function rather than a fixed `int` order. It
// would also take the midpoint as `lo + (hi - lo) / 2`: `(lo + hi) / 2`
// is wrong once the sum passes INT_MAX, which the 2 000 000 elements
// here stay well inside.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define N 2000000

static void qs(int *a, int lo, int hi) {
    if (lo >= hi) return;
    int pivot = a[(lo + hi) / 2];
    int i = lo, j = hi;
    while (i <= j) {
        while (a[i] < pivot) i++;
        while (a[j] > pivot) j--;
        if (i <= j) {
            int t = a[i];
            a[i] = a[j];
            a[j] = t;
            i++;
            j--;
        }
    }
    qs(a, lo, j);
    qs(a, i, hi);
}

int main(void) {
    int *a = (int*)malloc(N * sizeof(int));
    if (!a) return 1;
    unsigned int seed = 12345;
    int i;
    for (i = 0; i < N; i++) {
        seed = seed * 1103515245 + 12345;
        a[i] = (int)(seed & 0x7fffffff);
    }

    struct timespec t0, t1;
    clock_gettime(CLOCK_MONOTONIC, &t0);
    qs(a, 0, N - 1);
    clock_gettime(CLOCK_MONOTONIC, &t1);

    long secs = t1.tv_sec - t0.tv_sec;
    long nsecs = t1.tv_nsec - t0.tv_nsec;
    double ms = (double)secs * 1000.0 + (double)nsecs / 1000000.0;
    printf("sorted N=%d in %.2f ms; first=%d last=%d\n", N, ms, a[0], a[N-1]);

    // Sanity check.
    for (i = 1; i < N; i++) {
        if (a[i] < a[i-1]) { printf("UNSORTED at %d\n", i); free(a); return 1; }
    }
    free(a);
    return 0;
}
