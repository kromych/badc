// C99 7.12.3: isnan / isinf / isfinite classify a floating value by its
// IEEE-754 fields, with no math-library call. Asserted by return code.

#include <math.h>

int main(void) {
    double zero = 0.0;
    double nan = zero / zero;     // NaN
    double inf = 1.0 / zero;      // +inf
    double ninf = -1.0 / zero;    // -inf

    if (!isnan(nan)) return 1;
    if (isnan(1.5)) return 2;
    if (isnan(inf)) return 3;

    if (!isinf(inf)) return 4;
    if (!isinf(ninf)) return 5;
    if (isinf(1.5)) return 6;
    if (isinf(nan)) return 7;

    if (!isfinite(1.5)) return 8;
    if (!isfinite(0.0)) return 9;
    if (isfinite(inf)) return 10;
    if (isfinite(nan)) return 11;

    // fpclassify / signbit remain consistent.
    if (fpclassify(nan) != FP_NAN) return 12;
    if (fpclassify(inf) != FP_INFINITE) return 13;
    if (fpclassify(1.5) != FP_NORMAL) return 14;
    if (!signbit(ninf)) return 15;
    if (signbit(1.5)) return 16;

    return 0;
}
