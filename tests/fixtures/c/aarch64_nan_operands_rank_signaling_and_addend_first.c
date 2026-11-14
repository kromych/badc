/* An AArch64 operation with NaN operands returns the first signaling NaN,
 * quieted, before the first quiet one (the Arm ARM's FPProcessNaNs); a
 * fused multiply-add ranks its addend first, and a quiet NaN addend to
 * infinity times zero gives the default NaN. The exit code has a bit per
 * failing group; elsewhere than AArch64 the unit is empty. */
#if defined(__aarch64__)
#include <math.h>
#include <stdint.h>
#include <string.h>

static double u2d(uint64_t u) {
    double d;
    memcpy(&d, &u, 8);
    return d;
}
static uint64_t d2u(double d) {
    uint64_t u;
    memcpy(&u, &d, 8);
    return u;
}
static float u2f(uint32_t u) {
    float f;
    memcpy(&f, &u, 4);
    return f;
}
static uint32_t f2u(float f) {
    uint32_t u;
    memcpy(&u, &f, 4);
    return u;
}

int main(void) {
    int fails = 0;
    volatile double q1 = u2d(0x7ff8000000000001ull), s2 = u2d(0x7ff0000000000002ull);
    volatile double q3 = u2d(0x7ff8000000000003ull), one = 1.0, zero = 0.0;
    volatile double inf = INFINITY;
    if (d2u(q1 + s2) != 0x7ff8000000000002ull || d2u(q1 * s2) != 0x7ff8000000000002ull)
        fails |= 1;
    if (d2u(q1 - q3) != 0x7ff8000000000001ull || d2u(q3 / q1) != 0x7ff8000000000003ull)
        fails |= 1;
    volatile float fq = u2f(0x7fc00001u), fs = u2f(0xff800002u);
    if (f2u(fq + fs) != 0xffc00002u || f2u(fs * fq) != 0xffc00002u)
        fails |= 2;
    if (d2u(fma(q1, one, q3)) != 0x7ff8000000000003ull || d2u(fma(q1, s2, q3)) != 0x7ff8000000000002ull)
        fails |= 4;
    if (d2u(fma(one, q1, s2)) != 0x7ff8000000000002ull || d2u(fma(q1, q3, one)) != 0x7ff8000000000001ull)
        fails |= 4;
    if (d2u(fma(inf, zero, q3)) != 0x7ff8000000000000ull || d2u(fma(zero, inf, q1)) != 0x7ff8000000000000ull)
        fails |= 8;
    return fails;
}
#else
int main(void) {
    return 0;
}
#endif
