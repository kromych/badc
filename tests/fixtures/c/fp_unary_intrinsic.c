// Math functions that map to one FP instruction lower to it rather than
// a library call (C99 7.12.7.5 / 7.12.7.2 / 7.12.9): sqrt / fabs / floor
// / ceil / trunc, in both precisions. They need no math library, so they
// run on every target including the interpreter and Windows.
#include <math.h>

int main(void) {
    // sqrt / fabs (FSQRT / FABS; SQRTSS / sign-mask AND).
    if (sqrtf(4.0f) != 2.0f) return 1;
    if (sqrtf(0.25f) != 0.5f) return 2;
    if (sqrt(9.0) != 3.0) return 3;
    if (fabsf(-3.5f) != 3.5f) return 4;
    if (fabs(-3.5) != 3.5) return 5;

    double d = sqrtf(16.0f); // single-precision result widened to double
    if (d != 4.0) return 6;

    // floor / ceil / trunc (FRINTM / FRINTP / FRINTZ; ROUNDSD/ROUNDSS).
    if (floor(2.7) != 2.0 || floorf(-2.3f) != -3.0f) return 7;
    if (ceil(2.3) != 3.0 || ceilf(-2.7f) != -2.0f) return 8;
    if (trunc(-2.7) != -2.0 || truncf(2.9f) != 2.0f) return 9;

    // Nesting and a non-constant argument through a register.
    float x = 2.0f;
    if (sqrtf(fabsf(-16.0f)) != 4.0f) return 10;
    if (floorf(sqrtf(x * x) + 0.9f) != 2.0f) return 11;
    return 0;
}
