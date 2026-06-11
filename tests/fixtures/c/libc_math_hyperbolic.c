// C99 7.12.5.1-3: inverse hyperbolic functions. Each inverts the
// corresponding sinh / cosh / tanh, so composing them round-trips.
#include <math.h>

static int approx(double a, double b) {
    double d = a - b;
    if (d < 0) d = -d;
    return d < 1e-9;
}

int main(void) {
    if (!approx(asinh(0.0), 0.0)) return 1;
    if (!approx(acosh(1.0), 0.0)) return 2;
    if (!approx(atanh(0.0), 0.0)) return 3;
    if (!approx(sinh(asinh(2.0)), 2.0)) return 4;
    if (!approx(cosh(acosh(3.0)), 3.0)) return 5;
    if (!approx(tanh(atanh(0.5)), 0.5)) return 6;
    if (!approx((double) asinhf(0.0f), 0.0)) return 7;
    if (!approx((double) atanhf(0.0f), 0.0)) return 8;
    return 0;
}
