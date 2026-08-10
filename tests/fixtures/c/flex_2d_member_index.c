// A flexible array member may be multi-dimensional (`T v[][M]`, C99
// 6.7.2.1p16 applied to an array-of-array element type): only the
// outermost dimension is deferred, so `p->v[i][j]` scales `i` by the
// inner row size and `p->v[i]` decays to a row pointer. Values,
// strides, and `sizeof` of a row match GCC/clang.

struct table2 {
    int entries;
    unsigned char rows[][6];
};

struct table3 {
    short n;
    short grid[][2][3];
};

int main(void) {
    unsigned char buf[4 + 6 * 4];
    struct table2 *t = (struct table2 *) buf;
    int i, j;

    for (i = 0; i < (int) sizeof(buf); i++)
        buf[i] = 0;
    t->entries = 4;
    for (i = 0; i < 4; i++)
        for (j = 0; j < 6; j++)
            t->rows[i][j] = (unsigned char) (i * 16 + j);
    if (t->rows[2][5] != 0x25 || t->rows[3][0] != 0x30) return 1;

    // Row decay: `t->rows[i]` is a pointer to the row's first element.
    unsigned char *row2 = t->rows[2];
    if (row2[1] != 0x21) return 2;
    row2[1] = 0xAB;
    if (t->rows[2][1] != 0xAB) return 3;

    // Address-of an element and inter-row distance.
    if (&t->rows[3][0] - &t->rows[0][0] != 18) return 4;
    if ((unsigned char *) &t->rows[t->entries][0] - buf != 28) return 5;

    // A row keeps its array type under sizeof.
    if (sizeof(t->rows[0]) != 6) return 6;

    // Post-increment in the subscript, as in a fill loop.
    i = 0;
    t->rows[i++][4] = 0x77;
    if (i != 1 || t->rows[0][4] != 0x77) return 7;

    // Three-dimensional flexible member: two deferred-free inner dims.
    short tbuf[2 + 2 * 3 * 2];
    struct table3 *g = (struct table3 *) tbuf;
    for (i = 0; i < (int) (sizeof(tbuf) / sizeof(tbuf[0])); i++)
        tbuf[i] = 0;
    g->grid[1][1][2] = 77;
    if (g->grid[1][1][2] != 77) return 8;
    if ((short *) &g->grid[1][1][2] - (short *) g->grid != 11) return 9;

    return 0;
}
