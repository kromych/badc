// Regression: indexing a 2D-array parameter (`T name[N][M]`).
// C99 6.7.5.3p7 decays the outer dimension to a pointer, leaving
// `name` with type `T (*)[M]`. The inner dimension is what
// makes `name[i][j]` reach the right element: the first index
// has to scale by `M * sizeof(T)` (a row stride), not
// `sizeof(T)`. c5 used to wipe the 2D-stride hint on the
// parameter symbol (binding the param also cleared the
// `array_size` field but the `pending_index_stride` setup was
// gated only on the "real array variable" path, missing the
// param-load branch), so the inner `[j]` saw a scalar
// element and rejected with "pointer type expected."
//
// Fix: in the identifier-load path, when a parameter symbol
// has `inner_array_size > 0` and the loaded value is a
// pointer, seed `pending_index_stride = inner * pointee_size`
// so the next Brak handler keeps the type pointer-shaped.

#include <stdio.h>

static int sum_short_row(const unsigned short t[256][2], int idx) {
    return (int)t[idx][0] + (int)t[idx][1];
}

static int sum_int_row(int t[10][3], int idx) {
    return t[idx][0] + t[idx][1] + t[idx][2];
}

static int sum_char_row(char t[8][4], int idx) {
    return (int)t[idx][0] + (int)t[idx][1] + (int)t[idx][2] + (int)t[idx][3];
}

int main(void) {
    unsigned short st[256][2];
    int i;
    for (i = 0; i < 256; i++) { st[i][0] = 0; st[i][1] = 0; }
    st[5][0] = 0x1234;
    st[5][1] = 0x0010;
    if (sum_short_row(st, 5) != 0x1234 + 0x0010) return 1;

    int it[10][3];
    int j;
    for (i = 0; i < 10; i++)
        for (j = 0; j < 3; j++)
            it[i][j] = i * 100 + j;
    /* row 7: {700, 701, 702} = 2103 */
    if (sum_int_row(it, 7) != 2103) return 2;

    char ct[8][4];
    for (i = 0; i < 8; i++)
        for (j = 0; j < 4; j++)
            ct[i][j] = (char)('A' + i + j);
    /* row 3: {'D', 'E', 'F', 'G'} = 68+69+70+71 = 278 */
    if (sum_char_row(ct, 3) != 278) return 3;

    return 0;
}
