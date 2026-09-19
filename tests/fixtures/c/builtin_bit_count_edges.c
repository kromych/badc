// __builtin_clz / ctz / popcount / clrsb / ffs / parity at both widths, and
// the `l` forms, over run-time operands: 0, 1, every power of two, the runs
// of ones below and above each, the sign bit, all-ones and mixed patterns,
// against bit-by-bit reference counts. clz / ctz of 0 are the operand width.
// A 32-bit form reads the low word of a wider value, and each result is an
// `int` that widens by value.
//
// Returns 0 on success, otherwise the number of the failing check.

static volatile unsigned long long cell;

// The operand passes through a volatile object, so no count folds.
static unsigned long long opaque(unsigned long long v) {
    cell = v;
    return cell;
}

static int ref_clz(unsigned long long x, int w) {
    int n = 0;
    while (n < w && !((x >> (w - 1 - n)) & 1))
        n++;
    return n;
}

static int ref_ctz(unsigned long long x, int w) {
    int n = 0;
    while (n < w && !((x >> n) & 1))
        n++;
    return n;
}

static int ref_popcount(unsigned long long x, int w) {
    int n = 0;
    for (int i = 0; i < w; i++)
        n += (int)((x >> i) & 1);
    return n;
}

static int ref_clrsb(unsigned long long x, int w) {
    int sign = (int)((x >> (w - 1)) & 1);
    int n = 0;
    while (n < w - 1 && (int)((x >> (w - 2 - n)) & 1) == sign)
        n++;
    return n;
}

static int ref_ffs(unsigned long long x, int w) {
    int c = ref_ctz(x, w);
    return c == w ? 0 : c + 1;
}

static int check32(unsigned long long v) {
    unsigned u = (unsigned)opaque(v);
    int s = (int)opaque(v);
    unsigned long long low = v & 0xffffffffull;
    if (__builtin_clz(u) != ref_clz(low, 32))
        return 1;
    if (__builtin_ctz(u) != ref_ctz(low, 32))
        return 2;
    if (__builtin_popcount(u) != ref_popcount(low, 32))
        return 3;
    if (__builtin_clrsb(s) != ref_clrsb(low, 32))
        return 4;
    if (__builtin_ffs(s) != ref_ffs(low, 32))
        return 5;
    if (__builtin_parity(u) != (ref_popcount(low, 32) & 1))
        return 6;
    // The truncation to the operand width happens in the conversion, not in
    // a mask the count keeps: the high word of `opaque(v)` is ignored.
    if (__builtin_clz(opaque(v)) != ref_clz(low, 32))
        return 7;
    if (__builtin_ctz(opaque(v)) != ref_ctz(low, 32))
        return 8;
    if (__builtin_popcount(opaque(v)) != ref_popcount(low, 32))
        return 9;
    // An `int` result widens by value.
    long long d = __builtin_clz(u) - 33LL;
    if (d != ref_clz(low, 32) - 33LL)
        return 10;
    // A mask inside the operand width belongs to the value counted.
    if (__builtin_popcount(u & 0xffffu) != ref_popcount(low & 0xffff, 32))
        return 25;
    if (__builtin_clz(u & 0xffffu) != ref_clz(low & 0xffff, 32))
        return 26;
    // Three counts of one value with nothing between them: each keeps its
    // own operator.
    long long trio = (long long)__builtin_clz(u) * 1000000 +
                     (long long)__builtin_ctz(u) * 1000 + __builtin_popcount(u);
    if (trio != (long long)ref_clz(low, 32) * 1000000 +
                    (long long)ref_ctz(low, 32) * 1000 + ref_popcount(low, 32))
        return 29;
    return 0;
}

static int check64(unsigned long long v) {
    unsigned long long u = opaque(v);
    long long s = (long long)opaque(v);
    if (__builtin_clzll(u) != ref_clz(v, 64))
        return 11;
    if (__builtin_ctzll(u) != ref_ctz(v, 64))
        return 12;
    if (__builtin_popcountll(u) != ref_popcount(v, 64))
        return 13;
    if (__builtin_clrsbll(s) != ref_clrsb(v, 64))
        return 14;
    if (__builtin_ffsll(s) != ref_ffs(v, 64))
        return 15;
    if (__builtin_parityll(u) != (ref_popcount(v, 64) & 1))
        return 16;
    long long d = __builtin_ctzll(u) - 65LL;
    if (d != ref_ctz(v, 64) - 65LL)
        return 17;
    if (__builtin_popcountll(u & 0xffffffffull) != ref_popcount(v & 0xffffffffull, 64))
        return 27;
    if (__builtin_clzll(u | 0x100000000ull) != ref_clz(v | 0x100000000ull, 64))
        return 28;
    long long trio = (long long)__builtin_clzll(u) * 1000000 +
                     (long long)__builtin_ctzll(u) * 1000 + __builtin_popcountll(u);
    if (trio != (long long)ref_clz(v, 64) * 1000000 +
                    (long long)ref_ctz(v, 64) * 1000 + ref_popcount(v, 64))
        return 30;
    return 0;
}

// The `l` forms take the target's `long`: 64 bits under LP64, 32 under LLP64.
static int check_long(unsigned long long v) {
    int w = (int)(8 * sizeof(long));
    unsigned long long mask = w == 64 ? ~0ull : 0xffffffffull;
    unsigned long u = (unsigned long)opaque(v);
    long s = (long)opaque(v);
    if (__builtin_clzl(u) != ref_clz(v & mask, w))
        return 18;
    if (__builtin_ctzl(u) != ref_ctz(v & mask, w))
        return 19;
    if (__builtin_popcountl(u) != ref_popcount(v & mask, w))
        return 20;
    if (__builtin_clrsbl(s) != ref_clrsb(v & mask, w))
        return 21;
    if (__builtin_ffsl(s) != ref_ffs(v & mask, w))
        return 22;
    if (__builtin_parityl(u) != (ref_popcount(v & mask, w) & 1))
        return 23;
    return 0;
}

static int check(unsigned long long v) {
    int r = check32(v);
    if (r == 0)
        r = check64(v);
    if (r == 0)
        r = check_long(v);
    return r;
}

static const unsigned long long patterns[] = {
    0x00ff00ffull,
    0xdeadbeefull,
    0x7fffffffull,
    0xffffffff00000000ull,
    0x00000001ffffffffull,
    0x0123456789abcdefull,
    0xf0f0f0f0f0f0f0f0ull,
    0x5555555555555555ull,
    0xaaaaaaaaaaaaaaaaull,
    0x7fffffffffffffffull,
};

int main(void) {
    int r = check(0);
    if (r == 0)
        r = check(~0ull);
    for (int k = 0; r == 0 && k < 64; k++) {
        unsigned long long bit = 1ull << k;
        r = check(bit);
        if (r == 0)
            r = check(bit - 1);
        if (r == 0)
            r = check(0 - bit);
        if (r == 0)
            r = check(bit | 0x8000000000000000ull);
    }
    for (unsigned i = 0; r == 0 && i < sizeof patterns / sizeof patterns[0]; i++)
        r = check(patterns[i]);
    if (r != 0)
        return r;
    // A count inside a loop, its operand and running total in registers.
    unsigned long long total = 0;
    for (int k = 0; k < 64; k++)
        total += (unsigned long long)__builtin_popcountll(opaque(~0ull >> k));
    if (total != 64 * 65 / 2)
        return 24;
    return 0;
}
