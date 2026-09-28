/* The C99 single-precision functions and vsscanf the bundled headers once
 * declared for no target or one (C99 7.12, 7.19.6.14), each called
 * through its binding at an argument whose result is exact.
 */
#include <math.h>
#include <stdarg.h>
#include <stdio.h>

static int scan(const char *src, const char *fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    int n = vsscanf(src, fmt, ap);
    va_end(ap);
    return n;
}

int main(void)
{
    volatile float zero = 0.0f, eight = 8.0f, three = 3.0f;
    if (sinhf(zero) != 0.0f || coshf(zero) != 1.0f || tanhf(zero) != 0.0f) return 1;
    if (log2f(eight) != 3.0f || exp2f(three) != 8.0f) return 2;
    int e = 0;
    if (frexpf(eight, &e) != 0.5f || e != 4) return 3;
    if (ldexpf(0.75f, 3) != 6.0f) return 4;
    float ip = 0.0f;
    if (modff(2.5f, &ip) != 0.5f || ip != 2.0f) return 5;
    if (lroundf(2.5f) != 3 || llroundf(-2.5f) != -3) return 6;
    if (lrintf(three) != 3 || llrintf(-three) != -3) return 7;
    int a = 0, b = 0;
    if (scan("12 34", "%d %d", &a, &b) != 2 || a != 12 || b != 34) return 8;
    return 0;
}
