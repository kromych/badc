// C99 7.12.3: the classification macros take any real floating type and
// classify the value in its own type, and 7.12.3.5 isnormal is one of
// them. FLT_MIN / 2 is subnormal as a float though normal as a double, and
// the argument is evaluated once.
#include <float.h>
#include <math.h>

int main(void) {
    volatile float fsub = FLT_MIN / 2, fmin = FLT_MIN, fnan = NAN, fneg0 = -0.0f;
    volatile double dsub = DBL_MIN / 2, one = 1.0;
    volatile long double lone = 1.0L, lzero = 0.0L, linf = INFINITY;
    int evaluated = 0;

    if (!isnormal(one) || isnormal(0.0) || isnormal(dsub) || isnormal(INFINITY) || isnormal(NAN))
        return 1;
    if (!isnormal(1.0f) || !isnormal(fmin) || isnormal(fsub)) return 2;
    if (fpclassify(fsub) != FP_SUBNORMAL || fpclassify((double)fsub) != FP_NORMAL) return 3;
    if (fpclassify(dsub) != FP_SUBNORMAL || fpclassify(fneg0) != FP_ZERO) return 4;
    if (!isnan(fnan) || isinf(fnan) || isfinite(fnan) || !isfinite(fsub)) return 5;
    if (!signbit(fneg0) || signbit(fmin) || !signbit(-fsub) || !signbit(-1.0)) return 6;
    if (!isnormal(lone) || fpclassify(lzero) != FP_ZERO || !isinf(linf) || signbit(lone))
        return 7;
    if (!isnan((evaluated++, fnan)) || evaluated != 1) return 8;
    if (!isunordered(fnan, 1.0f) || isunordered(one, 2.0)) return 9;
    return 0;
}
