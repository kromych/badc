// Divisions and remainders over operands that hold 32-bit values. An int
// one may take the 32-bit instruction form; a long long one of int values
// may not, its INT_MIN / -1 being 2^31 (C99 6.5.5p6) and only the
// conversion back to int implementation-defined (6.3.1.3p3). An unsigned
// division of truncated wider values reads the operands' low words only.
// A remainder lies within its divisor, a constant one after inlining too.
#include <limits.h>

#define NOINLINE __attribute__((noinline))
typedef long long ll;
typedef unsigned long long ull;

NOINLINE static int wide_quot(int a, int b) { return (int)((ll)a / (ll)b); }
NOINLINE static int wide_rem(int a, int b) { return (int)((ll)a % (ll)b); }
NOINLINE static ll wide_quot_ll(int a, int b) { return (ll)a / b; }
NOINLINE static int compound_wide(int a, int b) {
    a /= (ll)b;
    return a;
}

// A quotient of truncations, read at 64 bits and divided again.
NOINLINE static ull low_words(ull x, ull y) {
    unsigned a = (unsigned)(x >> 31);
    unsigned b = (unsigned)((y & 7) + 0x100000000ull);
    ull q = a / b;
    return q / 3 + (q > 1);
}

static inline int imod(int n, int d) { return n % d; }
static inline unsigned umod(unsigned n, unsigned d) { return n % d; }

NOINLINE static int rem_bounded(int n) {
    int r = imod(n, 8);
    return r > 7 || r < -7 ? 1000 : r;
}
NOINLINE static unsigned urem_bounded(unsigned n) {
    unsigned r = umod(n, 10);
    return r > 9 ? 1000 : r;
}

// An int quotient and remainder of one pair, read at either width.
NOINLINE static ll pair(int a, int b) {
    int q = a / b, r = a % b;
    ll wide = q;
    return wide * 1000 + r + (q * b + r == a);
}

// The unsigned 64-bit division of a sign-extended int and the unsigned
// 32-bit division of the same int differ for a negative one.
NOINLINE static ull two_widths(int p, int q, unsigned u) {
    int x = p + q;
    ull a = (ull)(ll)x / u;
    unsigned b = (unsigned)x / u;
    return a ^ ((ull)b << 1);
}

static volatile int vi[] = {INT_MIN, -1, 13, -5, 7};
static volatile ull vx[] = {0xffffffffull << 31, 1};

int main(void) {
    int min = vi[0], m1 = vi[1];
    if (wide_quot(min, m1) != INT_MIN) return 1;
    if (wide_rem(min, m1) != 0) return 2;
    if (wide_quot_ll(min, m1) != 2147483648LL) return 3;
    if (compound_wide(min, m1) != INT_MIN) return 4;
    if (low_words(vx[0], vx[1]) != 0x55555555ull + 1) return 5;
    if (rem_bounded(min) != 0 || rem_bounded(-13) != -5 || rem_bounded(13) != 5) return 6;
    if (urem_bounded(0xfffffffful) != 5) return 7;
    if (pair(vi[2], vi[3]) != -2000 + 3 + 1 || pair(min, vi[4]) != -306783378LL * 1000 - 2 + 1)
        return 8;
    if (two_widths(vi[3] * 2, vi[2] - 10, 3) !=
        ((ull)-7LL / 3 ^ ((ull)(4294967289u / 3) << 1)))
        return 9;
    return 0;
}
