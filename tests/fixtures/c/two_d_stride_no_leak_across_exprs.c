// Regression: `pending_index_stride` (the 2D-array row-stride
// hint c5 sets at an array decay to make `arr[i][j]` index by
// the right stride) must not leak across expressions.
//
// When a 2D array decays in a context that doesn't immediately
// take a subscript -- e.g. it's passed as a function argument
// per C99 6.3.2.1p3 array-to-pointer conversion -- the decay
// sets the stride but no `[i]` postfix consumes it. Without
// clearing the hint at the end of the expression, the next
// array assignment in a fresh expression takes the 2D-stride
// branch in the Brak handler, keeps the type pointer-shaped,
// and emits no scalar load -- the trailing `=` then has no
// load to rewrite-to-Psh and rejects with "bad lvalue in
// assignment".
//
// Fix: clear `pending_index_stride` at the end of every `expr()`
// call so the hint stays scoped to the single id-load -> Brak
// pairing that's allowed to consume it.

#include <stdio.h>

static int sum_one(const unsigned short t[256][2]) {
    return (int)t[0][0];
}

int main(void) {
    unsigned short table[256][2];
    table[0][0] = 7;
    table[0][1] = 11;

    /* Decay 1: pass the 2D table as a function argument. The
     * decay sets pending_index_stride; the function call must
     * not let the stride leak past its `)`. */
    int s = sum_one(table);
    if (s != 7) return 1;

    /* Decay 2 (immediately after): a regular 1D float array
     * assignment. Before the fix, the stale stride from the
     * earlier `table` decay made this fail. */
    float subU[64];
    int pos;
    for (pos = 0; pos < 64; pos++) {
        subU[pos] = (float)pos * 0.25f;
    }
    if (subU[8] != 2.0f) return 2;

    /* Decay 3: pass `table` again, then do another assignment to
     * confirm repeated leak-and-clear cycles don't accumulate. */
    s = sum_one(table);
    subU[0] = 99.0f;
    if (subU[0] != 99.0f) return 3;

    return 0;
}
