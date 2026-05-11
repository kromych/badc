/* `sizeof(p[k])` where `p` has type `T (*)[N1][N2]...[Nn]` is a
 * pure compile-time question -- C99 6.5.3.4 plus the array-decay
 * rule say each subscript peels one outer dim. The c5 codegen used
 * to drop the inner shape on the floor after one Brak step, so
 * `sizeof(p[0])` returned `sizeof(pointer) = 8` instead of
 * `N * sizeof(T)`, and the pointer arithmetic that c5 emitted for
 * `p[i]` used the wrong stride for any 2-byte scalar or for any
 * multi-dim shape. _Static_assert lets the check fire at compile
 * time so a regression breaks the build rather than the run.
 *
 * The cases below cover:
 *   - scalar element sizes 1, 2, 4, 8 (and the multi-Ptr encoding
 *     that ride along with each),
 *   - 1D, 2D, 3D array shapes off the pointer,
 *   - struct-field and bare-local declarations,
 *   - subscripting all the way down to the scalar element,
 *   - true arrays alongside the pointer-to-array, so the bare
 *     array path's sizeof still passes.
 */

typedef unsigned long size_t;

struct S {
    char  (*pa1_c)[8];           /* 1D, 1-byte elem  */
    short (*pa1_s)[8];           /* 1D, 2-byte elem  */
    int   (*pa1_i)[8];           /* 1D, 4-byte elem  */
    long  (*pa1_l)[8];           /* 1D, 8-byte elem  */
    int   (*pa2)[3][5];          /* 2D, scalar = 60  */
    char  (*pa3)[2][3][4];       /* 3D, scalar = 24  */
    int    arr2d[3][5];          /* declared array, untouched path */
};

/* === Field path: T (*)[N] === */
_Static_assert(sizeof(((struct S *)0)->pa1_c[0]) == 8,
               "1D pointer-to-array<char[8]>: sizeof(p[0]) == 8");
_Static_assert(sizeof(((struct S *)0)->pa1_s[0]) == 16,
               "1D pointer-to-array<short[8]>: sizeof(p[0]) == 16");
_Static_assert(sizeof(((struct S *)0)->pa1_i[0]) == 32,
               "1D pointer-to-array<int[8]>: sizeof(p[0]) == 32");
_Static_assert(sizeof(((struct S *)0)->pa1_l[0]) == 64,
               "1D pointer-to-array<long[8]>: sizeof(p[0]) == 64");

/* The next level down is the scalar element -- once for each. */
_Static_assert(sizeof(((struct S *)0)->pa1_c[0][0]) == 1, "char elem");
_Static_assert(sizeof(((struct S *)0)->pa1_s[0][0]) == 2, "short elem");
_Static_assert(sizeof(((struct S *)0)->pa1_i[0][0]) == 4, "int elem");
_Static_assert(sizeof(((struct S *)0)->pa1_l[0][0]) == 8, "long elem");

/* === Field path: T (*)[A][B] === */
_Static_assert(sizeof(((struct S *)0)->pa2[0])    == 60, "int (*)[3][5]: p[0] is int[3][5]");
_Static_assert(sizeof(((struct S *)0)->pa2[0][0]) == 20, "int (*)[3][5]: p[0][0] is int[5]");
_Static_assert(sizeof(((struct S *)0)->pa2[0][0][0]) == 4, "int (*)[3][5]: scalar is int");

/* === Field path: T (*)[A][B][C] === */
_Static_assert(sizeof(((struct S *)0)->pa3[0])       == 24, "char (*)[2][3][4]: p[0] is char[2][3][4]");
_Static_assert(sizeof(((struct S *)0)->pa3[0][0])    == 12, "char (*)[2][3][4]: p[0][0] is char[3][4]");
_Static_assert(sizeof(((struct S *)0)->pa3[0][0][0]) ==  4, "char (*)[2][3][4]: p[0][0][0] is char[4]");
_Static_assert(sizeof(((struct S *)0)->pa3[0][0][0][0]) == 1, "char (*)[2][3][4]: scalar is char");

/* === Declared multi-dim array still works (no regression). === */
_Static_assert(sizeof(((struct S *)0)->arr2d)       == 60, "int[3][5] full size");
_Static_assert(sizeof(((struct S *)0)->arr2d[0])    == 20, "int[3][5]: arr[0] is int[5]");
_Static_assert(sizeof(((struct S *)0)->arr2d[0][0]) ==  4, "int[3][5]: scalar is int");

/* === Local variable path: T (*p)[N] (not a struct field) === */
static void check_local(void) {
    short (*p)[8];
    int   (*p2)[3][5];
    (void)p;
    (void)p2;
    _Static_assert(sizeof(p[0])    == 16, "local short (*)[8]: p[0]");
    _Static_assert(sizeof(p[0][0]) ==  2, "local short (*)[8]: scalar");
    _Static_assert(sizeof(p2[0])       == 60, "local int (*)[3][5]: p[0]");
    _Static_assert(sizeof(p2[0][0])    == 20, "local int (*)[3][5]: p[0][0]");
    _Static_assert(sizeof(p2[0][0][0]) ==  4, "local int (*)[3][5]: scalar");
}

/* === Runtime side: confirm the pointer arithmetic also strides
 * correctly. The sizeof bug was an undercount; before the fix,
 * the codegen had a parallel overstride bug for multi-dim shapes
 * because the same elem_size feeds both `sizeof(p[0])` and the
 * Op::Mul scale baked into `p[i]`. Walk every element through
 * subscript writes and confirm round-trip. === */

int main(void) {
    struct S s;
    static char  buf_c[8];
    static short buf_s[8];
    static int   buf_i[8];
    static long  buf_l[8];
    static int   buf2[3][5];
    static char  buf3[2][3][4];
    int i, j, k;

    s.pa1_c = (char  (*)[8])         buf_c;
    s.pa1_s = (short (*)[8])         buf_s;
    s.pa1_i = (int   (*)[8])         buf_i;
    s.pa1_l = (long  (*)[8])         buf_l;
    s.pa2   = (int   (*)[3][5])      buf2;
    s.pa3   = (char  (*)[2][3][4])   buf3;

    /* Pointer-arithmetic stride for one subscript == sizeof(row). */
    if ((char *)&s.pa1_c[1] - (char *)&s.pa1_c[0] != 8)  return 11;
    if ((char *)&s.pa1_s[1] - (char *)&s.pa1_s[0] != 16) return 12;
    if ((char *)&s.pa1_i[1] - (char *)&s.pa1_i[0] != 32) return 13;
    if ((char *)&s.pa1_l[1] - (char *)&s.pa1_l[0] != 64) return 14;
    if ((char *)&s.pa2[1]   - (char *)&s.pa2[0]   != 60) return 15;
    if ((char *)&s.pa2[0][1]- (char *)&s.pa2[0][0]!= 20) return 16;
    if ((char *)&s.pa3[1]      - (char *)&s.pa3[0]      != 24) return 17;
    if ((char *)&s.pa3[0][1]   - (char *)&s.pa3[0][0]   != 12) return 18;
    if ((char *)&s.pa3[0][0][1]- (char *)&s.pa3[0][0][0]!= 4)  return 19;

    /* Write-then-read every cell to confirm subscript chains
     * land at the same address for stores and loads. */
    for (i = 0; i < 8; i++) {
        s.pa1_s[0][i] = (short)(1000 + i);
    }
    for (i = 0; i < 8; i++) {
        if (s.pa1_s[0][i] != (short)(1000 + i)) return 20 + i;
    }
    for (i = 0; i < 3; i++)
        for (j = 0; j < 5; j++)
            s.pa2[0][i][j] = i * 100 + j;
    for (i = 0; i < 3; i++)
        for (j = 0; j < 5; j++)
            if (s.pa2[0][i][j] != i * 100 + j) return 30 + i * 5 + j;
    for (i = 0; i < 2; i++)
        for (j = 0; j < 3; j++)
            for (k = 0; k < 4; k++)
                s.pa3[0][i][j][k] = (char)(i * 12 + j * 4 + k);
    for (i = 0; i < 2; i++)
        for (j = 0; j < 3; j++)
            for (k = 0; k < 4; k++)
                if (s.pa3[0][i][j][k] != (char)(i * 12 + j * 4 + k))
                    return 50 + i * 12 + j * 4 + k;

    return 0;
}
