// C99 6.7.8p18: each element of a brace-enclosed array initializer
// may itself be a brace-enclosed initializer. For a local struct
// array `T xs[N] = { {...}, {...} };` every element's brace list
// has to fan out into per-field stores (constant fold to the data
// segment + Mcpy, or runtime per-field stores for any non-constant
// element).
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

struct chunk { const void *data; long len; };

static long sum_lens(const struct chunk *xs, int n) {
    long s = 0;
    int i;
    for (i = 0; i < n; i++) s += xs[i].len;
    return s;
}

int main(void) {
    // Compile-time-constant elements: stage in data + Mcpy.
    struct chunk a[3] = {
        { "abc", 3 },
        { "wxyz", 4 },
        { "world", 5 },
    };
    if (sum_lens(a, 3) != 12) return 1;
    if (a[0].len != 3)        return 2;
    if (a[2].len != 5)        return 3;

    // Non-constant elements (the address of locals can't fold at
    // compile time): per-element runtime stores. C99 6.7.8p13
    // explicitly permits this for auto-storage arrays.
    char b1[16], b2[32], b3[8];
    struct chunk b[3] = {
        { b1, sizeof b1 },
        { b2, sizeof b2 },
        { b3, sizeof b3 },
    };
    if (sum_lens(b, 3) != 16 + 32 + 8) return 4;
    if (b[0].data != b1)               return 5;
    if (b[1].data != b2)               return 6;
    if (b[2].data != b3)               return 7;
    if (b[2].len  != 8)                return 8;

    return 0;
}
