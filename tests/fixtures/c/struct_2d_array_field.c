// 2D array fields inside a struct -- `T xs[N][M]` reachable via
// `s.xs[i][j]` / `p->xs[i][j]`. Mirrors the `inner_array_size`
// shadow tracking the symbol table already does for local 2D
// arrays. compression / SQL / FFT libraries all use this shape for huff
// tables, parsing tables, twiddle factors. c5 used to stop at
// "pointer type expected" because StructField didn't carry the
// inner dimension; the row stride couldn't be recovered, so
// `[i]` decayed straight to a scalar element instead of staying
// at pointer for the next `[j]`.
#include <stdlib.h>

struct Tab {
    int counts[3][4];
};

int main(void) {
    struct Tab t;
    int i;
    int j;
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 4; j++) {
            t.counts[i][j] = i * 10 + j;
        }
    }
    // Pointer access path -- exercises Arrow (`->`) too.
    struct Tab *p = &t;
    int sum = 0;
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 4; j++) {
            sum += p->counts[i][j];
        }
    }
    // sum = sum_{i,j}(10i+j) = 12 * (10 * (0+1+2)/3) + 3*6
    //                        = 120 + 18 = ... compute directly.
    // i=0: 0,1,2,3 -> 6
    // i=1: 10,11,12,13 -> 46
    // i=2: 20,21,22,23 -> 86
    // total = 138
    return sum - 111; // 27
}
