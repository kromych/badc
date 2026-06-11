// C99 7.12.8: tgamma (gamma function, tgamma(n+1) = n!), erf / erfc
// (error function and its complement, erf(x) + erfc(x) == 1).
#include <math.h>

static int approx(double a, double b) {
    double d = a - b;
    if (d < 0) d = -d;
    return d < 1e-6;
}

int main(void) {
    if (!approx(tgamma(5.0), 24.0)) return 1;
    if (!approx(tgamma(1.0), 1.0)) return 2;
    if (!approx(erf(0.0), 0.0)) return 3;
    if (!approx(erfc(0.0), 1.0)) return 4;
    if (!approx(erf(1.0) + erfc(1.0), 1.0)) return 5;
    if (!approx((double) tgammaf(5.0f), 24.0)) return 6;
    if (!approx((double) erff(0.0f), 0.0)) return 7;
    return 0;
}
