// C99 7.12.6.11 logb, 7.12.8.3 lgamma, 7.12.10.3 remquo and 7.12.11.4
// nexttoward in their double, float and long double forms, called and
// through their addresses. TODO: a nexttoward direction between 1.0 and its
// double successor needs long double values kept in their own format.
#include <float.h>
#include <math.h>

int main(void) {
    double (*logb_p)(double) = logb;
    float (*lgammaf_p)(float) = lgammaf;
    long double (*remquol_p)(long double, long double, int *) = remquol;
    double (*nexttoward_p)(double, long double) = nexttoward;
    int q = 0;

    if (logb(8.0) != 3.0 || logb(0.375) != -2.0) return 1;
    if (logbf(8.0f) != 3.0f || logbl(8.0L) != 3.0L) return 2;
    if (fabs(lgamma(4.0) - log(6.0)) > 1e-12) return 3;
    if (fabsf(lgammaf(4.0f) - logf(6.0f)) > 1e-5f) return 4;
    if (fabsl(lgammal(4.0L) - logl(6.0L)) > 1e-12L) return 5;
    if (remquo(7.0, 2.0, &q) != -1.0 || q % 8 != 4) return 6;
    if (remquof(-7.0f, 2.0f, &q) != 1.0f || q % 8 != -4) return 7;
    if (remquol(7.0L, 2.0L, &q) != -1.0L || q % 8 != 4) return 8;
    if (nexttoward(1.0, 2.0L) != 1.0 + DBL_EPSILON) return 9;
    if (nexttoward(1.0, 0.0L) != 1.0 - DBL_EPSILON / 2) return 10;
    if (nexttowardf(1.0f, 2.0L) != 1.0f + FLT_EPSILON) return 11;
    if (nexttowardf(1.0f, -2.0L) != 1.0f - FLT_EPSILON / 2) return 12;
    if (nexttowardl(1.0L, 2.0L) < 1.0L || nexttowardl(2.0L, 2.0L) != 2.0L) return 13;
    if (logb_p(16.0) != 4.0 || fabsf(lgammaf_p(3.0f) - logf(2.0f)) > 1e-5f) return 14;
    if (remquol_p(9.0L, 4.0L, &q) != 1.0L || q % 8 != 2) return 15;
    if (nexttoward_p(4.0, 8.0L) != 4.0 + 4 * DBL_EPSILON) return 16;
    return 0;
}
