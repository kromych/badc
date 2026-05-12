/* Regression: C99 6.7.6 pointer-to-array abstract declarator
 * inside a cast: `(T (*)[N]) expr`. c5's cast handler counts
 * `*` markers inside the inner parens for the fn-ptr shape;
 * the trailing `[N]` (or `(args)`) suffix is now consumed too
 * so the cast parses cleanly. The resulting type collapses to
 * `T *` at c5's tag granularity -- pointer arithmetic on the
 * cast result still strides by `sizeof(T)`, not `N *
 * sizeof(T)`, but the cast itself is no longer a syntax error.
 *
 * The full pointer-to-array semantics (where `p[i]` strides
 * by `N * sizeof(T)`) requires multi-dimensional shape
 * tracking on the symbol -- a separate gap.
 */

#include <stdio.h>

int main(void) {
    short buf[24];
    int i;
    for (i = 0; i < 24; i++) buf[i] = (short)(i * 3);

    /* The cast expression parses; the result, used as `short *`,
     * indexes element-by-element. */
    short *p = (short *)(short (*)[8]) buf;
    if (p != buf) return 1;
    if (p[6] != (short)18) return 2;

    /* Empty-bracket form `(*)[ ]` also parses (rare but legal). */
    short *q = (short *)(short (*)[]) buf;
    if (q != buf) return 3;

    /* Multi-dim abstract declarator: `(*)[N][M]`. */
    short *r = (short *)(short (*)[4][2]) buf;
    if (r != buf) return 4;

    return 0;
}
