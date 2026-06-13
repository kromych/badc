// C99 7.12.7.1 cbrt, 7.12.6.9 log1p, 7.12.6.3 expm1, 7.12.10.2
// remainder, 7.12.9.5 lrint / llrint. log1p / expm1 are inverses, so
// composing them round-trips; lrint rounds to nearest under the
// default round-to-even mode.
#include <math.h>

static int approx(double a, double b) {
    double d = a - b;
    if (d < 0) d = -d;
    return d < 1e-9;
}

int main(void) {
    if (!approx(cbrt(27.0), 3.0)) return 1;
    if (!approx(cbrt(8.0), 2.0)) return 2;
    if (!approx(log1p(expm1(1.5)), 1.5)) return 3;
    if (remainder(5.0, 3.0) != -1.0) return 4;
    if (lrint(2.5) != 2) return 5;
    if (lrint(3.5) != 4) return 6;
    if (llrint(-2.5) != -2) return 7;
    if (!approx(cbrtf(27.0f), 3.0f)) return 8;
    if (!approx((double) remainderf(5.0f, 3.0f), -1.0)) return 9;
    return 0;
}
