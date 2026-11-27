/* Floating comparisons against a constant on either side, as a branch and
   as a value, in both precisions, over ordinary values, signed zeros,
   infinities and NaN (C17 6.5.8, 6.5.9, F.3): every relational operator is
   false with a NaN operand, `!=` true. The exit code names the first
   mismatch. */

#include <math.h>

#define NOINLINE __attribute__((noinline))

#define ONE(T, K, name, expr) NOINLINE int T##_##name(T x) { return expr; }
#define BR(T, K, name, expr) NOINLINE int T##_b##name(T x) { if (expr) return 1; return 0; }
#define CMPS(T, K)                                                                       \
    ONE(T, K, lt, x < K) ONE(T, K, le, x <= K) ONE(T, K, gt, x > K) ONE(T, K, ge, x >= K)  \
    ONE(T, K, eq, x == K) ONE(T, K, ne, x != K) ONE(T, K, klt, K < x) ONE(T, K, kle, K <= x) \
    ONE(T, K, kgt, K > x) ONE(T, K, kge, K >= x) BR(T, K, lt, x < K) BR(T, K, le, x <= K)   \
    BR(T, K, gt, x > K) BR(T, K, ge, x >= K) BR(T, K, eq, x == K) BR(T, K, ne, x != K)     \
    BR(T, K, klt, K < x) BR(T, K, kle, K <= x) BR(T, K, kgt, K > x) BR(T, K, kge, K >= x)   \
    static int T##_all(T x) {                                                            \
        int v = T##_lt(x) | T##_le(x) << 1 | T##_gt(x) << 2 | T##_ge(x) << 3 |             \
                T##_eq(x) << 4 | T##_ne(x) << 5 | T##_kgt(x) << 6 | T##_kge(x) << 7 |     \
                T##_klt(x) << 8 | T##_kle(x) << 9;                                         \
        int b = T##_blt(x) | T##_ble(x) << 1 | T##_bgt(x) << 2 | T##_bge(x) << 3 |         \
                T##_beq(x) << 4 | T##_bne(x) << 5 | T##_bkgt(x) << 6 | T##_bkge(x) << 7 |  \
                T##_bklt(x) << 8 | T##_bkle(x) << 9;                                       \
        return v == b ? v : -1;                                                          \
    }

CMPS(double, 4.0)
CMPS(float, 4.0f)

/* The expected bits, from the operands' order alone: `K > x` is `x < K`. */
static int expect(int lt, int eq, int unordered) {
    int gt = !lt && !eq && !unordered;
    int le = lt || eq, ge = gt || eq;
    return lt | le << 1 | gt << 2 | ge << 3 | eq << 4 | !eq << 5 | lt << 6 | le << 7 | gt << 8 |
           ge << 9;
}

NOINLINE int escapes(double cr, double ci) {
    double re = 0, im = 0;
    for (int k = 0; k < 64; k++) {
        double t = re * re - im * im + cr;
        im = 2.0 * re * im + ci;
        re = t;
        if (re * re + im * im > 4.0)
            return k;
    }
    return -1;
}

int main(void) {
    volatile double nan = NAN;
    /* Each value with whether it is below, equal to, or unordered with 4. */
    const struct { double x; int lt, eq, nan; } cs[] = {
        {-INFINITY, 1, 0, 0}, {-5.0, 1, 0, 0}, {-0.0, 1, 0, 0}, {0.0, 1, 0, 0},
        {3.999999, 1, 0, 0}, {4.0, 0, 1, 0}, {4.000001, 0, 0, 0}, {1e300, 0, 0, 0},
        {INFINITY, 0, 0, 0}, {0, 0, 0, 1},
    };
    for (unsigned i = 0; i < sizeof cs / sizeof cs[0]; i++) {
        double x = cs[i].nan ? nan : cs[i].x;
        int want = expect(cs[i].lt, cs[i].eq, cs[i].nan);
        if (double_all(x) != want)
            return 1 + (int)i;
        if (cs[i].x != 1e300 && float_all((float)x) != want)
            return 20 + (int)i;
    }
    if (escapes(1.0, 1.0) != 1 || escapes(0.0, 0.0) != -1)
        return 40;
    return 0;
}
