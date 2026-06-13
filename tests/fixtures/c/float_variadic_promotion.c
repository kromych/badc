// C99 6.5.2.2p6-7: a `float` argument to a variadic function (or any
// function with no prototype in scope) undergoes the default argument
// promotion to `double`. Without the promotion the raw 4-byte float
// reaches a slot the callee reads as an 8-byte double, yielding
// garbage. The variadic callee here reads each argument with
// `va_arg(ap, double)`; a float variable, a float cast, and a float
// mixed with an integer must all arrive as the right double value.
#include <stdarg.h>

static int approx(double a, double b) {
    double d = a - b;
    if (d < 0) d = -d;
    return d < 0.001;
}

static double vsum(int n, ...) {
    va_list ap;
    va_start(ap, n);
    double s = 0;
    int i;
    for (i = 0; i < n; i++) s += va_arg(ap, double);
    va_end(ap);
    return s;
}

int main(void) {
    float a = 69.12f;
    float b = 1.5f;
    if (!approx(vsum(1, a), 69.12)) return 1;
    if (!approx(vsum(1, (float)2.5), 2.5)) return 2;
    if (!approx(vsum(2, a, b), 70.62)) return 3;
    // Mixed with an integer argument (read as double) ahead of the floats.
    if (!approx(vsum(3, (double)10, a, b), 80.62)) return 4;
    return 0;
}
