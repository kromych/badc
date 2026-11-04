// C99 6.7.5.2p4 and 6.9.1p10: a parameter may point to an array with more
// than one variable bound, each evaluated on entry; a prototype leaves the
// sizes unspecified, and an argument of any compatible shape converts.
int pointer(int n, int m, int (*p)[n][m]);
int rows(int n, int m, int a[][n][m], int k);
int mixed(int m, int (*p)[3][m]);
int unnamed(int, int, int [][*][*]);

int pointer(int n, int m, int (*p)[n][m]) {
    int s = 0;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            s += (*p)[i][j];
    return sizeof *p == n * m * sizeof(int) && sizeof (*p)[0] == m * sizeof(int) ? s : -1;
}

int rows(int n, int m, int a[][n][m], int k) {
    if (sizeof a[0] != n * m * sizeof(int) || sizeof a[0][0] != m * sizeof(int)) return -1;
    return a[k][n - 1][m - 1] + (int)(&a[1][0][0] - &a[0][0][0]);
}

int mixed(int m, int (*p)[3][m]) {
    return sizeof *p == 3 * m * sizeof(int) ? p[1][2][m - 1] : -1;
}

int unnamed(int n, int m, int a[][n][m]) {
    return sizeof a[0] == n * m * sizeof(int) ? a[0][n - 1][m - 1] : -1;
}

int main(void) {
    int a[3][4], b[2][3][4], c[2][3][5];
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 4; j++)
            a[i][j] = i * 10 + j;
    for (int k = 0; k < 2; k++)
        for (int i = 0; i < 3; i++)
            for (int j = 0; j < 4; j++)
                b[k][i][j] = k * 100 + i * 10 + j;
    for (int k = 0; k < 2; k++)
        for (int i = 0; i < 3; i++)
            for (int j = 0; j < 5; j++)
                c[k][i][j] = k * 100 + i * 10 + j;
    if (pointer(3, 4, &a) != 138) return 1;
    if (rows(3, 4, b, 1) != 123 + 12) return 2;
    if (mixed(5, c) != 124) return 3;
    if (unnamed(3, 4, b) != 23) return 4;
    return 0;
}
