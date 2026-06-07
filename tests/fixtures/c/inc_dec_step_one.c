// A unit step compiles to inc / dec on x86-64 rather than an immediate
// add / sub. The result register is identical; only the carry flag
// differs, and no consumer reads it. These cases cover a step of one in
// both directions, a step under a comparison, and unsigned wraparound,
// where the carry the immediate form would set is irrelevant.

static int plus_one(int x) { return x + 1; }
static int minus_one(int x) { return x - 1; }
// `long long` is 64-bit on LP64 and LLP64 alike; plain `long` is 32-bit
// on Windows, where the wide literal below would not fit.
static long long plus_one_l(long long x) { return x + 1; }
static long long minus_neg_one(long long x) { return x - (-1); }

static int count_up(int n) {
    int c = 0;
    for (int i = 0; i < n; i++) {
        c = c + 1;
    }
    return c;
}

static unsigned wrap(unsigned x) {
    return x + 1; // 0xffffffff + 1 wraps to 0
}

int main(void) {
    if (plus_one(41) != 42) return 1;
    if (minus_one(43) != 42) return 2;
    if (plus_one_l(9999999999LL) != 10000000000LL) return 3;
    if (minus_neg_one(41) != 42) return 4;
    if (count_up(42) != 42) return 5;
    if (wrap(0xffffffffu) != 0u) return 6;
    if (wrap(41u) != 42u) return 7;
    return 0;
}
