// A chained multi-dimensional array designator `[i][j] = value` (C99
// 6.7.8p6) selects one scalar of a multi-dimensional array. Each subscript
// scales by the product of the dimensions below it. Single `[i] = { row }`
// designators, positional entries, and the zero seed for untouched
// positions must all still hold.

enum { A, B, C, N };

static int t[N][4] = {
    [A][1] = 11,
    [C][3] = 33,
    [B] = { 5, 6 },
};

static int u[2][3] = { [0][2] = 9, [1][0] = 7 };

int main(void) {
    if (t[A][1] != 11 || t[C][3] != 33) return 1;
    if (t[B][0] != 5 || t[B][1] != 6 || t[B][2] != 0) return 2;
    if (t[A][0] != 0 || t[C][0] != 0) return 3;   /* untouched stays zero */
    if (u[0][2] != 9 || u[1][0] != 7) return 4;
    if (u[0][0] != 0 || u[1][2] != 0) return 5;
    return 0;
}
