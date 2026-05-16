// C99 6.7.5.3p7: a function parameter declared with array
// type "T[N]" is adjusted to "pointer to T". The same rule
// applies when the parameter's type is named through a
// typedef whose alias is an array.
//
//     typedef long long i64;
//     typedef i64 gf[16];
//     static void copy(gf dst, const gf src) { ... }
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

typedef long long i64;
typedef i64 gf[16];

static void copy(gf dst, const gf src) {
    int i;
    for (i = 0; i < 16; i++) dst[i] = src[i];
}

static i64 sum(const gf x) {
    int i;
    i64 s = 0;
    for (i = 0; i < 16; i++) s += x[i];
    return s;
}

int main(void) {
    gf a;
    gf b;
    int i;
    for (i = 0; i < 16; i++) a[i] = (i64)i + 1;

    copy(b, a);
    if (sum(b) != 16 * 17 / 2) return 1;
    if (b[0]   != 1)            return 2;
    if (b[15]  != 16)           return 3;

    return 0;
}
