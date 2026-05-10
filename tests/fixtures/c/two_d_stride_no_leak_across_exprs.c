// Regression: `pending_index_stride` (the 2D-array row-stride
// hint c5 sets at an array decay to make `arr[i][j]` index by
// the right stride) must not leak across expressions.
//
// stb_image_write.h's `stbi_write_jpg_core` passes the 2D
// Huffman tables as function arguments
//   stbiw__jpg_processDU(..., YDC_HT, YAC_HT)
// where the decay sets the stride but no `[i]` postfix consumes
// it; later that same function does `subU[pos] = (U[j+0] + ...) *
// 0.25f` and the stale stride steered the Brak handler into
// the 2D-stride branch, which keeps `ty` pointer-shaped and
// emits no load. The trailing `=` then has no scalar load to
// rewrite-to-Psh and rejects with "bad lvalue in assignment".
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
