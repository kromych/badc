// C23 6.7.2.5: `typeof` of a row of a multi-dimensional array names the
// row's own array type, inner bounds included -- `typeof(t[1])` over
// `int t[2][3][4]` is `int[3][4]` -- so an object declared with it has
// the row's size and subscripts as the row does. Each check exits with
// its own code; success returns 0.

int main(void) {
    int t[2][3][4];
    int u[2][3];
    struct {
        int m[2][2][5];
    } s;
    __typeof__(t[1]) x;
    __typeof__(u[1]) y;
    __typeof__(t[1][2]) z;
    __typeof__(s.m[1]) w;
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 4; j++) x[i][j] = 10 * i + j;
    if (sizeof x != 3 * 4 * sizeof(int) || sizeof x[0] != 4 * sizeof(int)) return 1;
    if (sizeof y != 3 * sizeof(int)) return 2;
    if (sizeof z != 4 * sizeof(int)) return 3;
    if (sizeof w != 2 * 5 * sizeof(int) || sizeof w[1] != 5 * sizeof(int)) return 4;
    if (x[2][3] != 23 || x[1][0] != 10) return 5;
    if (&x[1][0] - &x[0][0] != 4) return 6;
    if (!__builtin_types_compatible_p(__typeof__(t[1]), int[3][4])) return 7;
    if (!__builtin_types_compatible_p(__typeof__(s.m[0]), int[2][5])) return 8;
    return 0;
}
