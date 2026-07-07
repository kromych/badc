// C99 6.4.4.2p4: an unsuffixed floating constant has type double,
// `f`/`F` float, `l`/`L` long double (which c5 represents as
// double). p5: the value is converted to the constant's type at
// the literal, so an `f`-suffixed constant carries single-precision
// rounding into any wider context.

#include <stdarg.h>

static double vsum(int n, ...) {
    va_list ap;
    va_start(ap, n);
    double s = 0;
    int i;
    for (i = 0; i < n; i++) {
        s += va_arg(ap, double);
    }
    va_end(ap);
    return s;
}

int main(void) {
    // Constant types observed through sizeof (6.5.3.4).
    if (sizeof(1.0f) != 4) return 1;
    if (sizeof(1.0F) != 4) return 2;
    if (sizeof(1.0) != 8) return 3;
    if (sizeof(1.0l) != 8) return 4;
    if (sizeof(1.0L) != 8) return 5;
    if (sizeof(.5f) != 4) return 6;
    if (sizeof(1e2f) != 4) return 7;
    if (sizeof(0x1p0f) != 4) return 8;

    // 16777217 is the first integer with no f32 representation: the
    // f-suffixed constant rounds to 16777216 at the literal, while
    // the double constant holds it exactly.
    if (16777217.0f != 16777216.0f) return 9;
    if (16777217.0 == 16777216.0) return 10;

    // The f32 rounding survives widening (6.3.1.5): (double)0.1f is
    // the exact value of the f32 nearest 0.1, not the double nearest.
    if (0.1f == 0.1) return 11;
    if (0.1f != 0.10000000149011611938476562500) return 12;
    if (-0.1f != -0.10000000149011611938476562500) return 13;

    // Default argument promotion (6.5.2.2p6): an f-suffixed literal
    // argument reaches the variadic callee as its exact double
    // widening.
    if (vsum(2, 1.5f, 0.25f) != 1.75) return 14;
    if (vsum(1, 0.1f) != 0.10000000149011611938476562500) return 16;

    // A hex floating constant (6.4.4.2) takes the suffix too.
    if (0x1.000002p24f != 16777218.0f) return 15;

    return 0;
}
