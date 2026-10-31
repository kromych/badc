// C99 6.7.5.2p4: an array whose element type is variable-length is a
// variable-length array itself -- `int a[n][m]`, `int b[3][m]`, an array of a
// variably modified typedef and a typedef of one -- each indexed through the
// element's runtime size and sized by `sizeof` at run time.
static int sum(int n, int m, int (*p)[m]) {
    int s = 0;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            s += p[i][j];
    return s;
}

static volatile int three = 3;

int main(void) {
    int n = three, m = three + 1, k = three - 1;
    int a[n][m];
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            a[i][j] = i * 10 + j;
    int b[3][m];
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < m; j++)
            b[i][j] = 2 * a[i][j];
    long c[n][m][k];
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            for (int l = 0; l < k; l++)
                c[i][j][l] = i * 100 + j * 10 + l;
    typedef int U[m];
    U d[n];
    U e[2];
    typedef U W[3];
    W w;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < m; j++)
            d[i][j] = -a[i][j];
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < m; j++)
            w[i][j] = a[i][j] + 1;
    e[1][m - 1] = 77;
    int (*q)[m] = a;
    q++;
    if (sizeof a != (unsigned long)n * m * sizeof(int) || sizeof a[0] != m * sizeof(int)) return 1;
    if (sizeof b != 3 * m * sizeof(int) || sizeof b[1] != m * sizeof(int)) return 2;
    if (sizeof c != (unsigned long)n * m * k * sizeof(long) || sizeof c[0][0] != k * sizeof(long)) return 3;
    if (sizeof d != (unsigned long)n * m * sizeof(int) || sizeof e != 2 * m * sizeof(int)) return 4;
    if (sizeof w != 3 * m * sizeof(int) || sizeof w[0] != m * sizeof(int)) return 5;
    if (a[2][3] != 23 || b[2][1] != 42 || c[2][3][1] != 231 || q[1][2] != 22) return 6;
    if (d[1][1] != -11 || e[1][m - 1] != 77 || w[2][3] != 24) return 7;
    if (&a[1][2] - &a[0][0] != m + 2 || &c[1][0][0] - &c[0][0][0] != m * k) return 8;
    if (sum(n, m, a) != 138 || sum(3, m, b) != 276) return 9;
    // A pointer to such an array, and type names of them.
    int (*r)[n][m] = &a;
    if (sizeof *r != sizeof a || (*r)[2][3] != 23 || (int (*)[m][k])c != (void *)c) return 10;
    if (sizeof(int[3][m]) != 3 * m * sizeof(int) || sizeof(long[n][m][k]) != sizeof c) return 11;
    return 0;
}
