// A `long double` value reaches a callee unchanged through each way a
// parameter arrives: an FP argument register, the stack past the FP
// registers, the bundled `fabsl`, and `va_arg`. The exit code names the
// first check that fails.

#include <math.h>
#include <stdarg.h>

#define NOINLINE __attribute__((noinline))

NOINLINE static double ident(long double v) { return (double)v; }

NOINLINE static long double twice(long double v) { return v + v; }

// Eight doubles take the FP argument registers; `x` goes past them.
NOINLINE static double ninth(double d0, double d1, double d2, double d3, double d4, double d5,
                             double d6, double d7, long double x)
{
    return (double)x + d0 + d1 + d2 + d3 + d4 + d5 + d6 + d7;
}

// A `long double` between integer and double parameters.
NOINLINE static double mixed(int a, long double x, double d, long double y)
{
    return a + (double)x + d + (double)y;
}

// The address of the parameter reads back the value it holds.
NOINLINE static double through_address(long double v)
{
    long double *p = &v;
    return (double)*p;
}

NOINLINE static double vsum(int n, ...)
{
    va_list ap;
    va_start(ap, n);
    double s = 0;
    for (int i = 0; i < n; i++)
        s += (double)va_arg(ap, long double);
    va_end(ap);
    return s;
}

// A variadic `long double` among doubles and integers.
NOINLINE static double vmixed(int n, ...)
{
    va_list ap;
    va_start(ap, n);
    double d = va_arg(ap, double);
    long double x = va_arg(ap, long double);
    int i = va_arg(ap, int);
    long double y = va_arg(ap, long double);
    va_end(ap);
    return d + (double)x + i + (double)y + n;
}

int main(void)
{
    volatile long double three = 3.0L, neg = -2.5L;
    if (ident(three) != 3.0) return 1;
    if ((double)twice(three) != 6.0) return 2;
    if (ninth(1, 2, 3, 4, 5, 6, 7, 8, 0.5L) != 36.5) return 3;
    if (mixed(1, 2.0L, 3.0, 4.0L) != 10.0) return 4;
    if (through_address(three) != 3.0) return 5;
    if ((double)fabsl(neg) != 2.5) return 6;
    if (vsum(3, (long double)1.0, (long double)2.5, (long double)4.0) != 7.5) return 7;
    if (vmixed(1, 0.5, (long double)2.0, 3, (long double)4.0) != 10.5) return 8;
    // Past the FP argument registers the variadic values go on the stack.
    if (vsum(10, (long double)1, (long double)2, (long double)3, (long double)4,
             (long double)5, (long double)6, (long double)7, (long double)8,
             (long double)9, (long double)10) != 55.0)
        return 9;
    return 0;
}
