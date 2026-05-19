/* C99 6.5.2.2p7: variadic arguments undergo default argument
   promotions. A float is promoted to double; printf("%g", d) reads
   the value as double. System V AMD64 ABI 3.2.3: the variadic call
   site must set `al` to the count of XMM argument registers used,
   so the callee prologue spills xmm0..xmm7 into the va-save area.
   Setting `al = 0` while still routing the double through xmm0
   leaves the saved area uninitialized, and printf's `va_arg(ap,
   double)` reads back denormal junk. */

#include <stdio.h>

static const double PI = 3.14159265358979323846;
static double g = 505.0;

int main(void) {
    /* One FP arg, one stack-resident format string: needs al=1. */
    printf("%g\n", g);
    /* Constant-folded f64; allocator may park the bit pattern in an
       int reg. */
    double v = 505.0;
    printf("%g\n", v);
    /* Two FP args: needs al=2. */
    printf("%g %g\n", PI, g);
    if (v != 505.0) return 1;
    if (g != 505.0) return 2;
    return 0;
}
