// C99 6.3.2.1p3: an array used as a value points to its first element,
// which for `int two[2][3]` is the row `int[3]`, so the value has type
// `int (*)[3]`; a parameter declared as the array, named or not, in a
// prototype or an old-style definition, is adjusted to the same type
// (6.7.5.3p7). The type reaches `typeof`, `__auto_type`, `_Generic`, the
// comma and conditional operators, pointer arithmetic and calls. Each
// check exits with its own code; success returns 0.

#define IS_ROW(e) _Generic((e), int (*)[3]: 1, default: 0)

typedef int mat23[2][3];

static int two[2][3] = {{1, 2, 3}, {4, 5, 6}};
static int three[2][3][4];
static const int ctwo[2][3] = {{7, 8, 9}, {10, 11, 12}};

struct holder {
    int m[2][3];
};

static int at(int a[][3], int i, int j) { return IS_ROW(a) ? a[i][j] : -1; }
static int at3(int a[2][3][4], int i, int j, int k) { return a[i][j][k]; }
static int rows(int (*r)[3]) { return r[1][0]; }
static int typed(mat23 m) { return IS_ROW(m) ? m[1][2] : -1; }
static int unnamed(int [][3], int);
static int unnamed(int (*a)[3], int i) { return a[i][1]; }
static int old_style(a, m) int a[][3]; mat23 m; { return IS_ROW(a) + IS_ROW(m) + a[1][2] + m[0][0]; }

static int one(void) { return 1; }
static int zwei(void) { return 2; }
static int (*fns[2][2])(void) = {{one, zwei}, {zwei, one}};
static int call(int (*f[][2])(void), int i, int j) { return f[i][j](); }

int main(int argc, char **argv) {
    int local[2][3] = {{7, 8, 9}, {10, 11, 12}};
    struct holder h = {{{1, 2, 3}, {4, 5, 6}}};
    int (*pm)[2][3] = &two;
    (void)argv;
    if (!IS_ROW(two) || !IS_ROW(local) || !IS_ROW(h.m) || !IS_ROW(*pm)) return 1;
    if (!IS_ROW(two + 1) || !IS_ROW(1 + two) || !IS_ROW((0, two))) return 2;
    if (!IS_ROW(argc ? two : local) || !IS_ROW(argc ? two : 0)) return 3;
    if (_Generic(three, int (*)[3][4]: 0, default: 1)) return 4;
    if (_Generic(three[1], int (*)[4]: 0, default: 1)) return 5;
    if (_Generic(ctwo, const int (*)[3]: 0, default: 1)) return 6;
    __typeof__(two + 0) q = two + 1;
    __auto_type r = local;
    if (q[0][2] != 6 || r[1][0] != 10) return 7;
    if (sizeof *q != 3 * sizeof(int) || sizeof *r != 3 * sizeof(int)) return 8;
    if (at(two, 1, 2) != 6 || at(local, 0, 1) != 8 || at(h.m, 1, 1) != 5) return 9;
    three[1][2][3] = 42;
    if (at3(three, 1, 2, 3) != 42 || *(*(*(three + 1) + 2) + 3) != 42) return 10;
    if (rows(two) != 4 || rows(local + 0) != 10 || typed(local) != 12) return 11;
    if (unnamed(two, 1) != 5 || unnamed(*pm, 0) != 2) return 12;
    if ((two + 1)[0][2] != 6 || *(*(two + 1) + 2) != 6 || (1 + two)[0][1] != 5) return 13;
    if (&two[1] - two != 1 || (two + 2) - two != 2 || &three[1] - three != 1) return 14;
    int (*rp)[3] = local;
    rp++;
    if (rp[0][0] != 10 || rp - local != 1 || *rp != local[1]) return 15;
    if (fns[1][0]() != 2 || (*fns)[1]() != 2 || (**fns)() != 1) return 16;
    if (call(fns, 1, 0) != 2 || call(fns, 1, 1) != 1) return 22;
    if (old_style(two, local) != 15) return 23;
    if (sizeof(two + 0) != sizeof(int (*)[3]) || sizeof *(two + 0) != 3 * sizeof(int)) return 17;
    if (sizeof two / sizeof two[0] != 2 || sizeof three / sizeof three[0] != 2) return 18;
    if (!__builtin_types_compatible_p(__typeof__(two), int[2][3])) return 19;
    if (__builtin_types_compatible_p(__typeof__(two), __typeof__(&two[0]))) return 20;
    if (!__builtin_types_compatible_p(__typeof__(&two[0]), __typeof__(two + 0))) return 21;
    return 0;
}
