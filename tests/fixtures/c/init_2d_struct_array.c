/* A 2D array of structs with an unspecified outer dimension
   (`struct T xs[][M] = { { {...}, ... }, ... }`) infers the outer size
   from the number of rows; each row is M fully-braced struct elements.
   The deferred struct-array initializer filled one struct per top-level
   brace, ignoring the inner dimension, so a row was misread as a single
   struct ("scalar initializer wrapped in { ... }"). OpenSSL's provider
   capability tables use this form (`static const OSSL_PARAM x[][11]`).
   File-scope and static-local declarations now descend the rows.

   Known remaining limitation: an *automatic* (non-static) local of this
   shape still goes through the runtime-store path and is unsupported;
   edk2 / OpenSSL only use the file-scope static form. */

struct Param {
    const char   *key;
    int           type;
    void         *data;
    unsigned long size;
    unsigned long ret;
};

/* File-scope, OpenSSL-shaped (strings + pointers + ints), 2 rows of 2. */
static const struct Param table[][2] = {
    { { "a", 1, 0, 2, 3 }, { "b", 4, 0, 5, 6 } },
    { { "c", 1, 0, 2, 3 }, { "d", 4, 0, 5, 6 } },
};

/* Inner dimension 3. */
static const struct Param wide[][3] = {
    { { "x", 1, 0, 0, 0 }, { "y", 2, 0, 0, 0 }, { "z", 3, 0, 0, 0 } },
};

/* Regression: 1D struct array and fixed-size 2D still work. */
static const struct Param one_d[2] = { { "p", 7, 0, 0, 0 }, { "q", 8, 0, 0, 0 } };
static const struct Param fixed[2][2] = {
    { { "e", 1, 0, 0, 0 }, { "f", 2, 0, 0, 0 } },
    { { "g", 3, 0, 0, 0 }, { "h", 4, 0, 0, 0 } },
};

static int seq(void) {
    /* Static-local of the same 2D shape. */
    static const struct Param local[][2] = {
        { { "m", 9, 0, 0, 0 }, { "n", 10, 0, 0, 0 } },
    };
    return local[0][1].type; /* 10 */
}

int main(void) {
    if (table[0][0].key[0] != 'a' || table[0][1].type != 4)
        return 1;
    if (table[1][0].key[0] != 'c' || table[1][1].ret != 6)
        return 2;
    if (wide[0][2].key[0] != 'z' || wide[0][2].type != 3)
        return 3;
    if (one_d[1].type != 8)
        return 4;
    if (fixed[1][0].key[0] != 'g' || fixed[1][1].type != 4)
        return 5;
    if (seq() != 10)
        return 6;
    return 0;
}
