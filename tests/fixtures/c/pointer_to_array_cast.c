/* C99 6.7.6 pointer-to-array abstract declarator inside a cast:
 * `(T (*)[N]) expr`. The cast builds the same aggregate-backed type as
 * the named declarator `T (*p)[N]`, so the pointee keeps its size: a
 * dereference yields an N-element row, `sizeof` reports the row, and
 * pointer arithmetic strides by `N * sizeof(T)`.
 *
 * Regression: the abstract declarator parsed and discarded `[N]`,
 * collapsing the type to `T *`, and the unary `*` on the cast result
 * was swallowed by the function-pointer decay branch -- a cast leaves
 * the fn-ptr chain depth at 0, which that branch read as a decayed
 * function pointer.
 */

#include <stdio.h>

int main(void) {
    short buf[24];
    int i;
    for (i = 0; i < 24; i++) buf[i] = (short)(i * 3);

    /* Cast to `short (*)[8]`: the row is 8 shorts = 16 bytes. */
    if (sizeof(*(short (*)[8]) buf) != 16) return 1;
    if (sizeof(*(short (*)[4]) buf) != 8) return 2;
    if (sizeof(*(int (*)[8]) buf) != 32) return 3;
    /* The declarator itself is a pointer. */
    if (sizeof(short (*)[8]) != sizeof(void *)) return 4;

    /* Pointer arithmetic strides by the whole row. */
    short (*pa)[8] = (short (*)[8]) buf;
    if ((char *)(pa + 1) - (char *)pa != 16) return 5;
    if (pa[1][2] != (short)30) return 6;
    if ((void *)*pa != (void *)buf) return 7;

    /* The row lvalue decays to the element pointer (C99 6.3.2.1p3). */
    short *p = (short *)(short (*)[8]) buf;
    if (p != buf) return 8;
    if (p[6] != (short)18) return 9;

    /* Empty-bracket form `(*)[ ]` contributes no dimension. */
    short *q = (short *)(short (*)[]) buf;
    if (q != buf) return 10;

    /* Multi-dim abstract declarator: `(*)[N][M]` is an N*M row. */
    if (sizeof(*(short (*)[4][2]) buf) != 16) return 11;
    short *r = (short *)(short (*)[4][2]) buf;
    if (r != buf) return 12;

    return 0;
}
