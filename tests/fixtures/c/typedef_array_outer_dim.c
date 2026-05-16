// C99 6.7.7p3: when the base type of a declarator is a typedef
// whose alias is an array, the typedef's dimensions extend the
// declarator's. `typedef i64 gf[16]; gf q[4];` declares `q` as
// `i64[4][16]`, not as `i64[4]`.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

typedef long long i64;
typedef i64 gf[16];

static i64 fill_and_sum(gf q[4]) {
    int i, j;
    i64 s = 0;
    for (i = 0; i < 4; i++) {
        for (j = 0; j < 16; j++) {
            q[i][j] = (i64)(i * 16 + j);
            s += q[i][j];
        }
    }
    return s;
}

int main(void) {
    gf q[4];

    // sizeof: outer 4 * inner 16 * sizeof(i64) = 4 * 16 * 8 = 512.
    if ((int)sizeof(q) != 4 * 16 * 8) return 1;

    i64 expected = 0;
    int k;
    for (k = 0; k < 4 * 16; k++) expected += (i64)k;
    if (fill_and_sum(q) != expected) return 2;

    if (q[0][0]  != 0)  return 3;
    if (q[3][15] != 63) return 4;
    if (q[1][7]  != 23) return 5;

    return 0;
}
