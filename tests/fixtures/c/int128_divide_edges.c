/* 128-bit division and remainder at the edges of each path the division
   takes: a 64-bit dividend and divisor; a divisor within 64 bits with the
   dividend's high word below it, one below it, equal to it and above it;
   a divisor above 2^64 at each leading-zero count; divisor 1, divisors
   with the top bit set and UINT128_MAX; and the signed forms, INT128_MIN
   included wherever the quotient is defined (C99 6.5.5p6). Every result
   is checked against a restoring division that takes one quotient bit
   per step, a sample also against known values. The exit code names the
   first failing group. */

typedef unsigned long long u64;
typedef unsigned __int128 u128;
typedef __int128 s128;

#define U128(hi, lo) (((u128)(hi) << 64) | (u64)(lo))
#define UMAX (~(u128)0)
#define SMIN ((s128)((u128)1 << 127))
#define SMAX ((s128)(UMAX >> 1))

/* Called, so the divisor is no constant the division folds. */
__attribute__((noinline)) static u128 udiv(u128 n, u128 d) { return n / d; }
__attribute__((noinline)) static u128 umod(u128 n, u128 d) { return n % d; }
__attribute__((noinline)) static s128 sdiv(s128 n, s128 d) { return n / d; }
__attribute__((noinline)) static s128 smod(s128 n, s128 d) { return n % d; }

static u128 reference(u128 n, u128 d, u128 *rem) {
    u128 q = 0, r = 0;
    int i;
    for (i = 127; i >= 0; i--) {
        int carry = (int)(r >> 127);
        r = r << 1 | (n >> i & 1);
        if (carry || r >= d) {
            r -= d;
            q |= (u128)1 << i;
        }
    }
    *rem = r;
    return q;
}

static int unsigned_ok(u128 n, u128 d) {
    u128 r, q = reference(n, d, &r);
    return udiv(n, d) == q && umod(n, d) == r;
}

/* Truncation toward zero, the remainder taking the dividend's sign. */
static int signed_ok(s128 n, s128 d) {
    u128 r, q = reference(n < 0 ? -(u128)n : (u128)n, d < 0 ? -(u128)d : (u128)d, &r);
    if (n == SMIN && d == -1)
        return 1;
    return (u128)sdiv(n, d) == ((n < 0) != (d < 0) ? -q : q) && (u128)smod(n, d) == (n < 0 ? -r : r);
}

static u64 seed = 0x9e3779b97f4a7c15ULL;

static u64 next(void) {
    seed = seed * 6364136223846793005ULL + 1442695040888963407ULL;
    return seed ^ (seed >> 29);
}

int main(void) {
    /* Divisors at the 32-bit digit boundaries of the long division. */
    static const u64 narrow[] = {1, 2, 3, 7, 10, 1000000007, 0xffffffffULL, 0x100000000ULL,
                                 0x100000001ULL, 0x1ffffffffULL, 0x123456789abcdefULL,
                                 0x7fffffffffffffffULL, 0x8000000000000000ULL,
                                 0x8000000000000001ULL, 0x800000007fffffffULL,
                                 0x80000000ffffffffULL, 0xffffffff00000000ULL,
                                 0xfffffffffffffffeULL, 0xffffffffffffffffULL};
    int i, k;

    /* Known values: UMAX / 10, and the largest quotient a 64-bit divisor
       leaves within 64 bits. */
    if (udiv(UMAX, 10) != U128(0x1999999999999999ULL, 0x9999999999999999ULL) || umod(UMAX, 10) != 5)
        return 1;
    if (udiv(U128(0xfffffffffffffffeULL, ~0ULL), ~0ULL) != ~0ULL ||
        umod(U128(0xfffffffffffffffeULL, ~0ULL), ~0ULL) != 0xfffffffffffffffeULL)
        return 2;
    if (udiv(U128(5, 7), U128(1, 0)) != 5 || umod(U128(5, 7), U128(1, 0)) != 7)
        return 3;
    if (udiv(UMAX, UMAX) != 1 || umod(UMAX, UMAX) != 0 || udiv(UMAX - 1, UMAX) != 0)
        return 4;
    if (udiv(U128(0x123, 0x456), 1) != U128(0x123, 0x456) || umod(U128(0x123, 0x456), 1) != 0)
        return 5;

    /* A divisor within 64 bits, the dividend's high word below it, one
       below it, equal to it and above it. */
    for (i = 0; i < (int)(sizeof narrow / sizeof narrow[0]); i++) {
        u64 d = narrow[i];
        if (!unsigned_ok(U128(d - 1, ~0ULL), d) || !unsigned_ok(U128(d - 1, 0), d))
            return 6;
        if (!unsigned_ok(U128(d / 2, 12345), d) || !unsigned_ok(U128(d, 1), d))
            return 7;
        if (!unsigned_ok(U128(~0ULL, ~0ULL), d) || !unsigned_ok(12345, d))
            return 8;
    }

    /* A divisor above 2^64 at each leading-zero count of its high word,
       with a dividend below, at and above it. */
    for (k = 0; k < 64; k++) {
        u128 d = ((u128)1 << (64 + k)) | U128(0, 0x9abcdef012345678ULL);
        u128 dmax = ((u128)1 << (64 + k)) | (((u128)1 << (64 + k)) - 1);
        if (!unsigned_ok(d - 1, d) || !unsigned_ok(d, d) || !unsigned_ok(UMAX, d))
            return 9;
        if (!unsigned_ok(UMAX, dmax) || !unsigned_ok(UMAX - dmax, dmax) || !unsigned_ok(dmax + 1, dmax))
            return 10;
    }
    if (!unsigned_ok(UMAX, (u128)1 << 127) || !unsigned_ok(UMAX, U128(0x8000000000000000ULL, 1)))
        return 11;

    /* Signed: truncation toward zero, the remainder taking the dividend's
       sign; INT128_MIN / -1 is undefined and left out. */
    if (sdiv(SMIN, 1) != SMIN || smod(SMIN, 1) != 0 || sdiv(SMIN, SMIN) != 1)
        return 12;
    if (sdiv(SMIN, 2) != -((s128)1 << 126) || sdiv(SMIN, -2) != ((s128)1 << 126))
        return 13;
    if (sdiv(SMIN, SMAX) != -1 || smod(SMIN, SMAX) != -1 || sdiv(SMAX, SMIN) != 0 ||
        smod(SMAX, SMIN) != SMAX)
        return 14;
    if (sdiv(-7, 2) != -3 || smod(-7, 2) != -1 || sdiv(7, -2) != -3 || smod(7, -2) != 1)
        return 15;
    if (!signed_ok(SMIN, 3) || !signed_ok(SMIN, -3) || !signed_ok(SMAX, -1) || !signed_ok(SMIN + 1, -1))
        return 16;
    if (!signed_ok(SMIN, (s128)1 << 100) || !signed_ok(SMIN, -((s128)1 << 64) - 1))
        return 17;

    /* Constant divisors, which leave the division only the paths their
       width selects. */
    for (i = 0; i < 200; i++) {
        u128 n = U128(next(), next()), r;
        if (n / 10 != reference(n, 10, &r) || n % 10 != r)
            return 18;
        if (n / 1000000007 != reference(n, 1000000007, &r) || n % 1000000007 != r)
            return 19;
        if (n / U128(3, 5) != reference(n, U128(3, 5), &r) || n % U128(3, 5) != r)
            return 20;
        if (n / ~0ULL != reference(n, ~0ULL, &r) || n % ~0ULL != r)
            return 21;
    }

    /* A sweep over divisor widths, the dividend's high word left at every
       relation to them. */
    for (i = 0; i < 1000; i++) {
        u128 n = U128(next(), next());
        u128 d = U128(next(), next()) >> (next() % 128);
        if (d == 0)
            d = 1;
        if (!unsigned_ok(n, d) || !unsigned_ok(n >> (next() % 128), d))
            return 22;
        if (!unsigned_ok(U128((u64)d - 1, next()), (u64)d | 1))
            return 23;
        if (!signed_ok((s128)n, (s128)d) || !signed_ok(-(s128)(n >> 1), (s128)d))
            return 24;
        if (!signed_ok((s128)(n >> 1), -(s128)(d >> 1) - 1))
            return 25;
    }
    return 0;
}
