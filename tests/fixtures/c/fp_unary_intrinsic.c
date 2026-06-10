// C99 7.12.7.5 / 7.12.7.2: sqrtf and fabsf lower to a single hardware
// instruction (FSQRT / FABS on AArch64, SQRTSS / sign-mask AND on
// x86-64) rather than a library call, so they need no math library and
// run on every target, including the interpreter and Windows. The result
// is single precision; a float result widened to double exercises the
// FP path.
#include <math.h>

int main(void) {
    if (sqrtf(4.0f) != 2.0f) return 1;
    if (sqrtf(9.0f) != 3.0f) return 2;
    if (sqrtf(0.25f) != 0.5f) return 3;
    if (fabsf(-3.5f) != 3.5f) return 4;
    if (fabsf(3.5f) != 3.5f) return 5;
    if (fabsf(0.0f) != 0.0f) return 6;

    double d = sqrtf(16.0f); // single-precision result widened to double
    if (d != 4.0) return 7;

    // Combine results and feed one into the other.
    float r = sqrtf(fabsf(-16.0f));
    if (r != 4.0f) return 8;

    // A non-constant argument so the value flows through a register.
    float x = 2.0f;
    if (sqrtf(x * x) != 2.0f) return 9;
    return 0;
}
