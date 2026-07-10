// A block-scope array of structs may use `[N] =` designators and take its
// deferred size from the largest index (C99 6.7.8p22), the same as a
// file-scope object -- for both a `static` local (laid out in .data) and an
// automatic local (staged then copied). QEMU's tests/unit/test-qdist.c uses a
// `static const struct entry_desc desc[] = { [0] = {...}, [1] = {...} }`.
// Returns 0 on success.

struct E {
    int a;
    int b;
    int c;
};

static int use_static(void) {
    // static local: designators with a gap; size = max index + 1 = 3.
    static const struct E desc[] = {
        [0] = { 1, 900, 8 },
        [2] = { 3, 2, 1 },
    };
    if (sizeof(desc) / sizeof(desc[0]) != 3) return 1;
    if (desc[0].a != 1 || desc[0].b != 900 || desc[0].c != 8) return 2;
    if (desc[2].a != 3 || desc[2].c != 1) return 3;
    if (desc[1].a != 0 || desc[1].b != 0) return 4;   // gap zeroed
    return 0;
}

static int use_auto(int seed) {
    // automatic local: designators, backward then forward, runtime values.
    struct E d[] = {
        [2] = { seed, seed + 1, seed + 2 },
        [0] = { 10, 11, 12 },
    };
    if (sizeof(d) / sizeof(d[0]) != 3) return 10;
    if (d[0].a != 10 || d[0].c != 12) return 11;
    if (d[2].a != seed || d[2].c != seed + 2) return 12;
    if (d[1].a != 0 || d[1].c != 0) return 13;        // gap zeroed
    return 0;
}

int main(void) {
    int rc = use_static();
    if (rc) return rc;
    return use_auto(5);
}
