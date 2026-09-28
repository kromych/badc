// C99 7.12's `long double` functions return what the double ones do for
// arguments and results binary64 holds, whether the target binds them to
// libm's `l` entry points or to the double ones, called directly or
// through a pointer. HUGE_VALL is a positive infinity of type `long
// double`. The exit code names the first check that fails.

#include <math.h>

#define KIND(e) _Generic((e), double: 2, long double: 3, default: 0)

int main(void)
{
    volatile long double two = 2.0L, half = 0.5L, neg = -2.5L;
    int e;
    long double ip;
    if (sqrtl(two * 8) != 4.0L) return 1;
    if (fabsl(neg) != 2.5L) return 2;
    if (ldexpl(half, 4) != 8.0L) return 3;
    if (frexpl(two * 3, &e) != 0.75L || e != 3) return 4;
    if (modfl(neg, &ip) != -0.5L || ip != -2.0L) return 5;
    if (powl(two, 10) != 1024.0L) return 6;
    if (floorl(neg) != -3.0L || ceill(neg) != -2.0L || truncl(neg) != -2.0L) return 7;
    if (roundl(neg) != -3.0L || lroundl(neg) != -3 || llroundl(half) != 1) return 8;
    if (rintl(neg) != -2.0L || lrintl(neg) != -2 || llrintl(two) != 2) return 9;
    if (nearbyintl(half) != 0.0L) return 10;
    if (fmodl(two * 5, 3) != 1.0L || remainderl(two * 5, 3) != 1.0L) return 11;
    if (hypotl(3, 4) != 5.0L) return 12;
    if (fminl(two, half) != 0.5L || fmaxl(two, half) != 2.0L) return 13;
    if (ilogbl(two * 4) != 3) return 14;
    if (cbrtl(two * 4) != 2.0L) return 15;
    if (expl(0) != 1.0L || logl(1) != 0.0L || log2l(two * 4) != 3.0L || exp2l(3) != 8.0L) return 16;
    if (log10l(100) != 2.0L) return 17;
    if (sinl(0) != 0.0L || cosl(0) != 1.0L || atan2l(0, 1) != 0.0L) return 18;
    if (nextafterl(two, two) != 2.0L) return 19;
    if (copysignl(two, neg) != -2.0L || fdiml(two, half) != 1.5L) return 20;
    if (scalbnl(half, 3) != 4.0L || scalblnl(half, 2) != 2.0L) return 21;
    if (fmal(two, two, half) != 4.5L) return 22;
    if (!(HUGE_VALL > 1e308) || KIND(HUGE_VALL) != 3 || sizeof(HUGE_VALL) != sizeof(long double))
        return 23;
    long double (*f)(long double) = fabsl;
    if (f(neg) != 2.5L) return 24;
    if (KIND(sinl(half)) != 3 || KIND(ilogbl(half)) != 0) return 25;
    return 0;
}
