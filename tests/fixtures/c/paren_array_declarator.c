// C99 6.7.5p6: a parenthesized declarator declares what the declarator in
// it does, so bounds after `(x)` are `x`'s own -- `int (x)[3]` is
// `int x[3]` -- for an object, a member, a parameter and a typedef, after
// an array typedef base, and after a group that has bounds of its own:
// `int (y[2])[3]` is `int y[2][3]`. Each check exits with its own code;
// success returns 0.

typedef int R4[4];
typedef int (P3)[3];

int (g)[3] = {1, 2, 3};
int (e[])[2] = {{1, 2}, {3, 4}, {5, 6}};
R4 (t)[2];
R4 (u[2])[3];

struct S {
    int (m)[3];
    int (n[2])[2];
    int k;
};

static int row_sum(int (p)[2][3], int i) {
    return p[i][0] + p[i][1] + p[i][2];
}

int main(void) {
    int (x)[2][3] = {{1, 2, 3}, {4, 5, 6}};
    int (y[2])[3] = {{7, 8, 9}, {10, 11, 12}};
    struct S s = {{1, 2, 3}, {{4, 5}, {6, 7}}, 8};
    if (sizeof g != 3 * sizeof(int) || g[2] != 3) return 1;
    if (sizeof e != 6 * sizeof(int) || e[2][1] != 6) return 2;
    if (sizeof t != 2 * 4 * sizeof(int) || sizeof t[1] != 4 * sizeof(int)) return 3;
    if (sizeof u != 2 * 3 * 4 * sizeof(int) || sizeof u[1] != 3 * 4 * sizeof(int)) return 4;
    if (sizeof u[1][2] != 4 * sizeof(int)) return 5;
    u[1][2][3] = 42;
    if (*(&u[0][0][0] + 2 * 3 * 4 - 1) != 42) return 6;
    if (sizeof x != 6 * sizeof(int) || x[1][2] != 6) return 7;
    if (sizeof y != 6 * sizeof(int) || y[1][0] != 10) return 8;
    if (sizeof s != 8 * sizeof(int) || s.m[2] != 3 || s.n[1][1] != 7 || s.k != 8) return 9;
    if (row_sum(x, 1) != 15 || row_sum(y, 0) != 24) return 10;
    if (sizeof(P3) != 3 * sizeof(int) || sizeof(P3[2]) != 6 * sizeof(int)) return 11;
    return 0;
}
