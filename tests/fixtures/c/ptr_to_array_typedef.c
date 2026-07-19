// A typedef of pointer-to-array keeps the array layer of the pointee
// (C99 6.7.7p3): dereferencing decays to the row address (6.3.2.1p3)
// instead of loading an element, and a store through a pointer to such
// a pointer reaches the caller's object. Covers the direct declarator,
// the typedef alias, the pointer-to-pointer store (previously elided
// silently with a spurious unused-parameter warning), subscripts,
// sizeof, and a multi-dim array typedef. Exits 42 on success.

typedef long arr[4];
typedef arr *arrp;
typedef long jb[8];
typedef long grid[3][4];

static int direct(arr *p) { return (int)(*p)[2]; }

// Previously "error: pointer type expected": the alias dropped the
// array layer, so `*p` loaded a long instead of decaying.
static int viatd(arrp p) { return (int)(*p)[2]; }

// Previously no store was emitted: the deref was treated as the
// row-decay no-op and the assignment rewrote the parameter's own load.
static void prologue(jb **out) {
    static jb b;
    b[3] = 2;
    *out = &b;
}

static long gridsum(grid *g) { return (*g)[1][2] + g[0][2][3]; }

int main(void) {
    arr a;
    jb *p = 0;
    grid gg;
    int i, j;
    a[2] = 15;
    for (i = 0; i < 3; i++)
        for (j = 0; j < 4; j++)
            gg[i][j] = (long)(i * 4 + j);
    prologue(&p);
    if (!p) return 1;
    if (sizeof(*p) != 8 * sizeof(long)) return 2;
    if (sizeof(arrp) != sizeof(long *)) return 3;
    if ((*p)[3] != 2 || p[0][3] != 2) return 4;
    // 15 + 15 + 2 + (6 + 11) - 7 == 42
    return direct(&a) + viatd(&a) + (int)(*p)[3] + (int)gridsum(&gg) - 7;
}
