// C99 6.7.7p3: a typedef name designates a type. When the typedef
// alias is an array, every declarator in the same declaration
// inherits the array dimension -- not just the first one in a
// comma-separated list.
//
// Surface shape from tweetnacl.c:
//
//     typedef long long i64;
//     typedef i64 gf[16];
//     static const gf gf0, gf1 = { 1 };
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code so a regression points at the
// offending pattern.

typedef long long i64;
typedef i64 gf[16];

static const gf gf0;
static const gf gf1 = { 1 };
static const gf gf2 = { 0, 0, 7 };

// Comma-list of declarators where each carries explicit
// brackets. Both `m4` and `n4` must compose to gf[4] (i64[4][16]),
// not collapse to gf[4]=i64[4].
static gf m4[4];
static gf n4[4];

// Struct field of a typedef-array type, followed by another
// field. The carrier must be cleared between field groups so
// the scalar `code` field does not inherit the typedef-array
// dimension and turn into `int[16]`.
typedef long sjlj_buf[64];
struct sjlj_holder {
    sjlj_buf env;
    int      code;
};

int main(void) {
    // gf0 is zero-initialized per C99 6.7.8p10: static-storage
    // arrays with no explicit init have every element set to
    // the type's zero value.
    if (gf0[0]  != 0) return 1;
    if (gf0[15] != 0) return 2;

    // gf1 = { 1 } -- first element set, rest zero.
    if (gf1[0]  != 1) return 3;
    if (gf1[1]  != 0) return 4;
    if (gf1[15] != 0) return 5;

    // gf2 = { 0, 0, 7 } -- third element set, rest zero.
    if (gf2[0]  != 0) return 6;
    if (gf2[2]  != 7) return 7;
    if (gf2[15] != 0) return 8;

    // Comma-list of bracketed declarators: both m4 and n4 are
    // i64[4][16]. sizeof must reflect the composed shape and
    // 2D indexing must reach every position.
    if ((int)sizeof(m4) != 4 * 16 * 8) return 9;
    if ((int)sizeof(n4) != 4 * 16 * 8) return 10;
    m4[2][7] = 42;
    n4[3][15] = -1;
    if (m4[2][7]  !=  42) return 11;
    if (n4[3][15] !=  -1) return 12;
    if (m4[0][0]  !=   0) return 13;
    if (n4[0][0]  !=   0) return 14;

    // Struct with typedef-array head field + scalar tail.
    // The carrier must not leak from the array field into the
    // scalar field's group.
    struct sjlj_holder h;
    h.code = 99;
    if (h.code != 99) return 15;
    if ((int)sizeof(h) < 64 * (int)sizeof(long) + (int)sizeof(int)) return 16;

    return 0;
}
