// A variable-length array has an array type whose size is taken at run
// time (C99 6.7.5.2): `&v` points to that array (6.5.3.2p3), `*&v` is the
// array again and decays, `sizeof` of it is the run-time size (6.5.3.4p2),
// and arithmetic on the pointer steps by it (6.5.6p8), including through an
// object declared with the pointer's `typeof`. An inner dimension may be
// constant, spelled in the declarator or through an array typedef. Returns
// 0 when every check passes; each failure returns a distinct code.

#include <stddef.h>

typedef int row3[3];

static int one_dim(int n) {
    int v[n];
    for (int i = 0; i < n; i++) v[i] = i * 10;
    if (sizeof(*&v) != n * sizeof(int) || sizeof(&v) != sizeof(int *)) return 1;
    if ((&v)[0][1] != 10 || (*&v)[2] != 20) return 2;
    if ((char *)(&v + 1) - (char *)&v != (ptrdiff_t)sizeof v) return 3;
    if (&v + 1 - &v != 1 || (char *)(1 + &v) != (char *)(&v + 1)) return 4;
    __typeof__(&v) p = &v;
    if ((*p)[3] != 30 || p[0][3] != 30 || sizeof(*p) != sizeof v) return 5;
    p++;
    if ((char *)p - (char *)v != (ptrdiff_t)sizeof v) return 6;
    --p;
    if (p != &v) return 7;
    p += 2;
    p -= 2;
    if (p != &v || sizeof(p[1]) != sizeof v) return 8;
    if (*p + 1 != &v[1] || (*p)[n - 1] != (n - 1) * 10) return 9;
    return 0;
}

static int two_dim(int n) {
    int v[n][3];
    row3 t[n];
    for (int i = 0; i < n; i++)
        for (int j = 0; j < 3; j++) {
            v[i][j] = i * 3 + j;
            t[i][j] = 100 + i * 3 + j;
        }
    if (sizeof v != n * 3 * sizeof(int) || sizeof t != sizeof v) return 11;
    if ((&v)[0][1][2] != 5 || (&t)[0][1][2] != 105) return 12;
    if (sizeof(v[0]) != 3 * sizeof(int) || sizeof(*&v) != sizeof v) return 13;
    if ((char *)&v[1][2] - (char *)v != 5 * (ptrdiff_t)sizeof(int)) return 14;
    int (*r)[3] = v;
    if (r[1][2] != 5 || r[n - 1][0] != (n - 1) * 3) return 15;
    if (sizeof(*v) != sizeof(row3) || (char *)(v + 1) - (char *)v != sizeof(row3)) return 16;
    __typeof__(&t) q = &t;
    if ((*q)[n - 1][2] != 100 + (n - 1) * 3 + 2 || sizeof(*q) != sizeof t) return 17;
    // A `*` takes the typedef's array first: pointers to rows, not rows.
    row3 *pr[n];
    for (int i = 0; i < n; i++) pr[i] = &t[i];
    if (sizeof pr != n * sizeof(int *) || (*pr[n - 1])[2] != 100 + (n - 1) * 3 + 2) return 18;
    return 0;
}

int main(int argc, char **argv) {
    (void)argv;
    int r = one_dim(argc + 4);
    if (r) return r;
    return two_dim(argc + 2);
}
