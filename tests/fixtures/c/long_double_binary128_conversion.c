// Conversions between an IEEE binary128 `long double` and `double`:
// narrowing rounds to nearest, ties to even (C99 6.3.1.5p2, F.3), with
// overflow to infinity, gradual underflow and a NaN kept quiet with its
// leading payload bits; widening is exact (6.3.1.5p1). The bit patterns
// cover the exponents at the edges of the double range and every rounding
// case, checked against an integer model. Targets whose `long double` is
// not binary128 exit 0. The exit code names the failing direction.

#include <float.h>
#include <stdint.h>
#include <string.h>

#define NOINLINE __attribute__((noinline))

static uint64_t state = 0x9e3779b97f4a7c15ull;

static uint64_t next(void)
{
    state ^= state << 13;
    state ^= state >> 7;
    state ^= state << 17;
    return state;
}

NOINLINE static double narrow(const long double *p) { return (double)*p; }

NOINLINE static void widen(long double *p, double d) { *p = d; }

// `m` is the significand as 1.63 fixed point, `sticky` the bits below it,
// `e` the biased binary64 exponent of its leading bit.
static uint64_t round_to_double(uint64_t sign, uint64_t m, int sticky, int e)
{
    int sh = e >= 1 ? 11 : 12 - e;
    if (e >= 0x7ff)
        return sign | 0x7ff0000000000000ull;
    if (sh > 64)
        return sign;
    uint64_t mant = sh == 64 ? 0 : m >> sh;
    uint64_t round = (m >> (sh - 1)) & 1;
    int rest = sticky || (m & ((1ull << (sh - 1)) - 1)) != 0;
    if (round && (rest || (mant & 1)))
        mant++;
    if (e < 1)
        return sign | mant;
    if (mant >> 53) {
        mant >>= 1;
        e++;
        if (e >= 0x7ff)
            return sign | 0x7ff0000000000000ull;
    }
    return sign | ((uint64_t)e << 52) | (mant & 0xfffffffffffffull);
}

static uint64_t model_narrow(uint64_t hi, uint64_t lo)
{
    uint64_t sign = hi & 0x8000000000000000ull;
    int exp = (int)((hi >> 48) & 0x7fff);
    uint64_t frac = hi & 0xffffffffffffull;
    if (exp == 0x7fff) {
        if ((frac | lo) == 0)
            return sign | 0x7ff0000000000000ull;
        return sign | 0x7ff8000000000000ull | (frac << 4) | (lo >> 60);
    }
    // A binary128 subnormal is below half the least double subnormal.
    if (exp == 0)
        return sign;
    uint64_t m = 0x8000000000000000ull | (frac << 15) | (lo >> 49);
    int sticky = (lo & ((1ull << 49) - 1)) != 0;
    return round_to_double(sign, m, sticky, exp - 16383 + 1023);
}

static void model_widen(uint64_t b, uint64_t *hi, uint64_t *lo)
{
    uint64_t sign = b & 0x8000000000000000ull;
    int e = (int)((b >> 52) & 0x7ff);
    uint64_t f = b & 0xfffffffffffffull;
    if (e == 0x7ff) {
        *hi = sign | (0x7fffull << 48) | (f >> 4) | (f ? 0x800000000000ull : 0);
        *lo = f << 60;
        return;
    }
    if (e == 0) {
        if (f == 0) {
            *hi = sign;
            *lo = 0;
            return;
        }
        e = 1;
        while (!(f >> 52)) {
            f <<= 1;
            e--;
        }
        f &= 0xfffffffffffffull;
    }
    *hi = sign | ((uint64_t)(e - 1023 + 16383) << 48) | (f >> 4);
    *lo = f << 60;
}

static int check_narrow(uint64_t hi, uint64_t lo)
{
    uint64_t w[2] = {lo, hi};
    long double v;
    memcpy(&v, w, sizeof v);
    double d = narrow(&v);
    uint64_t b;
    memcpy(&b, &d, sizeof b);
    return b == model_narrow(hi, lo);
}

static int check_widen(uint64_t b)
{
    double d;
    memcpy(&d, &b, sizeof d);
    long double v;
    widen(&v, d);
    uint64_t w[2], hi, lo;
    memcpy(w, &v, sizeof w);
    model_widen(b, &hi, &lo);
    return w[0] == lo && w[1] == hi;
}

int main(void)
{
    // The binary128 exponents around the double subnormal, normal and
    // overflow boundaries, and the special values.
    static const uint64_t exps[] = {0,      1,      0x3bcb, 0x3bcc, 0x3bcd, 0x3bff,
                                    0x3c00, 0x3c01, 0x3c0f, 0x3c10, 0x3fff, 0x43fe,
                                    0x43ff, 0x4400, 0x7ffe, 0x7fff};
    // Fractions on and around the halfway point of each rounding position.
    static const uint64_t lows[] = {0, 1, 0x0800000000000000ull, 0x0fffffffffffffffull,
                                    0x1000000000000000ull, 0x1800000000000000ull,
                                    0xf800000000000000ull, ~0ull};
    if (LDBL_MANT_DIG != 113 || sizeof(long double) != 16)
        return 0;
    for (unsigned e = 0; e < sizeof exps / sizeof exps[0]; e++)
        for (uint64_t s = 0; s < 2; s++)
            for (int k = 0; k < 48; k++) {
                uint64_t frac = k < 8 ? (k & 1 ? 0xffffffffffffull : 0) : next() >> 16;
                uint64_t lo = k < 8 ? lows[k] : next();
                uint64_t hi = (s << 63) | (exps[e] << 48) | frac;
                if (!check_narrow(hi, lo))
                    return 1;
            }
    for (int k = 0; k < 4096; k++) {
        uint64_t hi = next();
        if (!check_narrow(hi, next()))
            return 1;
    }
    static const uint64_t specials[] = {
        0, 1, 2, 0x000fffffffffffffull, 0x0008000000000000ull, 0x0010000000000000ull,
        0x3ff0000000000000ull, 0x7fefffffffffffffull, 0x7ff0000000000000ull,
        0x7ff0000000000001ull, 0x7ff4000000000000ull, 0x7ff8000000000000ull,
        0x8000000000000000ull, 0x8000000000000001ull, 0xfff0000000000000ull};
    for (unsigned i = 0; i < sizeof specials / sizeof specials[0]; i++)
        if (!check_widen(specials[i]))
            return 2;
    for (int k = 0; k < 4096; k++) {
        uint64_t b = next();
        if (!check_widen(k & 1 ? b & 0x800fffffffffffffull : b))
            return 2;
    }
    return 0;
}
