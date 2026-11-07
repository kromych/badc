// C99 7.20.1: the integer conversions in each base, clamped to the type
// with ERANGE, the end pointer, and the floating ones -- decimal and
// hexadecimal subjects rounded in the current direction to the type,
// infinities, NaNs, ERANGE on overflow and underflow. `long` is the
// target's; the `errno` a missing subject leaves and atoi's out-of-range
// value are the C library's.

#include <errno.h>
#include <fenv.h>
#include <stdio.h>
#include <stdlib.h>

int main(void) {
    char *e;
    const char *s = "  -0x1fz", *t = " +x";
    long v = strtol(s, &e, 0);
    printf("%ld %d|", v, (int)(e - s));
    errno = 0;
    v = strtol(t, &e, 10);
    printf("%ld %d %d|", v, (int)(e - t), errno);
    errno = 0;
    printf("%ld %d|", strtol("077", 0, 0), errno);
    errno = 0;
    v = strtol("99999999999", 0, 10);
    printf("%ld %d|", v, errno);
    errno = 0;
    unsigned long u = strtoul("-1", 0, 10);
    printf("%lu %d|", u, errno);
    errno = 0;
    printf("%lld %d|", strtoll("-9223372036854775809", 0, 10), errno);
    errno = 0;
    printf("%llu %d\n", strtoull("zz", 0, 36), errno);
    printf("%d %d|%ld %lld|", atoi(" 42x"), atoi("4294967297"), atol("-7"), atoll("123456789012"));
    errno = 0;
    v = strtol("1", &e, 37);
    printf("%ld %d\n", v, errno);
    double d = strtod("1e-5", &e);
    printf("%g %a|", d, d);
    printf("%a %a|", strtod("0x1.8p1", 0), strtod("4.9406564584124654e-324", 0));
    printf("%.10f %a|", strtof("0.1", 0), strtof("1e-45", 0));
    long double ld = strtold("3.14159265358979323846", 0);
    printf("%Lg %.4Lf\n", ld, strtold("-2.5e-3", 0));
    errno = 0;
    d = strtod("1e400", 0);
    printf("%f %d|", d, errno);
    errno = 0;
    d = strtod("1e-400", 0);
    printf("%g %d|", d, errno);
    errno = 0;
    d = strtod("0x1p-1074", 0);
    printf("%a %d|", d, errno);
    printf("%f %f %f|", strtod("-INFINITY", 0), atof("nan"), strtod("  .5", 0));
    fesetround(FE_UPWARD);
    d = strtod("0.1", 0);
    fesetround(FE_TONEAREST);
    printf("%a|", d);
    s = "1e+";
    d = strtod(s, &e);
    printf("%g %d\n", d, (int)(e - s));
    return 0;
}
