// Variadic c5 functions use the host variadic ABI on every target. On
// AAPCS64 (Linux aarch64) that means the named and variadic arguments
// arrive in the integer / FP argument-register banks (x0..x7 / d0..d7)
// then the incoming stack, the callee spills both banks into a general /
// vector register save area (AAPCS64 Appendix B), and `va_arg` walks the
// general area, the vector area, then the overflow stack. This fixture
// exercises each path:
//
//   * integer va_arg within the register bank and across the stack
//     overflow (more than eight integer arguments),
//   * floating-point va_arg within the vector bank and across the stack
//     overflow (more than eight double arguments),
//   * an interleaved int / double sequence (independent banks), and
//   * va_copy walking the same list twice.
//
// Each check returns nonzero on mismatch so the runtime exit code is 0
// only when every path agrees; the System V x86_64 and macOS / Windows
// aarch64 host paths must produce the same answers.
#include <stdarg.h>

static int isum(int n, ...) {
    va_list ap;
    int t = 0, i;
    va_start(ap, n);
    for (i = 0; i < n; i++) t += va_arg(ap, int);
    va_end(ap);
    return t;
}

static double dsum(int n, ...) {
    va_list ap;
    double t = 0;
    int i;
    va_start(ap, n);
    for (i = 0; i < n; i++) t += va_arg(ap, double);
    va_end(ap);
    return t;
}

static double mixed(int n, ...) {
    va_list ap;
    double t = 0;
    int i;
    va_start(ap, n);
    for (i = 0; i < n; i++) {
        if (i & 1) t += va_arg(ap, double);
        else       t += (double)va_arg(ap, int);
    }
    va_end(ap);
    return t;
}

static int icopy(int n, ...) {
    va_list ap, aq;
    int t = 0, i;
    va_start(ap, n);
    va_copy(aq, ap);
    for (i = 0; i < n; i++) t += va_arg(ap, int);
    for (i = 0; i < n; i++) t += va_arg(aq, int);
    va_end(aq);
    va_end(ap);
    return t;
}

// A variadic callee whose named parameters overflow the integer argument
// registers: ten named ints fill the six System V (rdi..r9) / eight AAPCS64
// (x0..x7) integer argument registers and spill the rest onto the incoming
// stack. The callee reads both the register-passed and the stack-overflow
// named parameters, and `va_start` must point the overflow area past the
// named stack parameters so `va_arg` reads the first variadic argument
// rather than re-reading a named one.
static int named_overflow(int a, int b, int c, int d, int e,
                          int f, int g, int h, int i, int j, ...) {
    va_list ap;
    int s = a + b + c + d + e + f + g + h + i + j;
    va_start(ap, j);
    s += va_arg(ap, int);
    s += va_arg(ap, int);
    s += va_arg(ap, int);
    va_end(ap);
    return s;
}

int main(void) {
    int rc = 0;
    if (isum(5, 1, 2, 3, 4, 5) != 15) rc |= 1;
    if (isum(12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12) != 78) rc |= 2;
    if (dsum(4, 1.5, 2.5, 3.0, 4.0) != 11.0) rc |= 4;
    if (dsum(10, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0) != 55.0) rc |= 8;
    if (mixed(4, 10, 1.5, 20, 2.5) != 34.0) rc |= 16;
    if (icopy(5, 2, 4, 6, 8, 10) != 60) rc |= 32;
    // named sum 1..10 = 55, variadic 100+200+300 = 600.
    if (named_overflow(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 100, 200, 300) != 655) rc |= 64;
    return rc;
}
