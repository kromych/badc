// A unit step compiles to inc / dec on x86-64 rather than an immediate
// add / sub. The result register is identical; only the carry flag
// differs, and no consumer reads it. These cases cover a step of one in
// both directions, a step under a comparison, and unsigned wraparound,
// where the carry the immediate form would set is irrelevant.

static int plus_one(int x) { return x + 1; }
static int minus_one(int x) { return x - 1; }
static long plus_one_l(long x) { return x + 1; }
static long minus_neg_one(long x) { return x - (-1); }

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
    if (plus_one_l(9999999999L) != 10000000000L) return 3;
    if (minus_neg_one(41) != 42) return 4;
    if (count_up(42) != 42) return 5;
    if (wrap(0xffffffffu) != 0u) return 6;
    if (wrap(41u) != 42u) return 7;
    return 0;
}
