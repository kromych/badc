// Parameters of variably modified type (C99 6.7.5.2, 6.7.5.3p7): a
// pointer to a variable-length array, and an array parameter whose first
// inner bound is variable, which adjusts to such a pointer. The bounds are
// evaluated on entry to the function (6.9.1p10), so `sizeof *p`, the
// stride of `p + 1` and `m[i][j]` follow the arguments. A prototype
// without the definition takes the same shapes. Returns 0 when every size
// and element matches.

int rows(int n, char (*p)[n]);
int sum(int n, int m[][n]);

int rows(int n, char (*p)[n]) {
    return (int)sizeof *p == n && (char *)(p + 1) - (char *)p == n;
}

int sum(int n, int m[][n]) {
    int s = 0;
    for (int i = 0; i < 2; i++)
        for (int j = 0; j < n; j++)
            s += m[i][j];
    return s + (int)sizeof m[0] / (int)sizeof(int) * 1000;
}

static int square(int n, long m[n][n], const int (*q)[n][2]) {
    long t = 0;
    for (int i = 0; i < n; i++)
        t += m[i][i];
    return (int)t + (int)(sizeof **q / sizeof(int)) * 100 + (int)(sizeof *q / sizeof **q) * 10000;
}

int main(void) {
    char a[3][5];
    int g[2][3] = {{1, 2, 3}, {4, 5, 6}};
    long sq[3][3] = {{1, 0, 0}, {0, 2, 0}, {0, 0, 3}};
    const int q[4][3][2] = {{{0}}};
    int bad = 0;
    bad |= !rows(5, a) << 0;
    bad |= !rows(5, &a[1]) << 1;
    bad |= (sum(3, g) != 3021) << 2;
    bad |= (square(3, sq, q) != 30206) << 3;
    return bad;
}
