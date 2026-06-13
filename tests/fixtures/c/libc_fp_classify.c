// C99 7.12.3.1 fpclassify, 7.12.3.6 signbit, 7.12.11.1 copysign (and
// copysignf). Implemented inline by inspecting the IEEE-754 binary64
// fields, so they have no math-library dependency and run on every
// backend including the interpreter.
#include <math.h>

int main(void) {
    if (copysign(3.0, -1.0) != -3.0) return 1;
    if (copysign(-3.0, 1.0) != 3.0) return 2;
    if (copysignf(2.0f, -5.0f) != -2.0f) return 3;
    if (!signbit(-1.0)) return 4;
    if (signbit(1.0)) return 5;
    if (!signbit(-0.0)) return 6;
    if (fpclassify(0.0) != FP_ZERO) return 7;
    if (fpclassify(1.0) != FP_NORMAL) return 8;
    if (fpclassify(INFINITY) != FP_INFINITE) return 9;
    if (fpclassify(NAN) != FP_NAN) return 10;
    if (fpclassify(1e-310) != FP_SUBNORMAL) return 11;
    return 0;
}
