/* fabs clears and unary minus flips the sign bit of a double and of a
   float and change no other bit (C17 7.12.7.2, 6.5.3.3, F.3), for zeros,
   infinities and NaNs of either sign, in straight-line code and in a loop.
   The exit code names the first mismatch. */

#include <math.h>
#include <stdint.h>
#include <string.h>

#define NOINLINE __attribute__((noinline))

static uint64_t bits(double d) {
    uint64_t u;
    memcpy(&u, &d, sizeof u);
    return u;
}

static uint32_t bitsf(float f) {
    uint32_t u;
    memcpy(&u, &f, sizeof u);
    return u;
}

static double of(uint64_t u) {
    double d;
    memcpy(&d, &u, sizeof d);
    return d;
}

static float off(uint32_t u) {
    float f;
    memcpy(&f, &u, sizeof f);
    return f;
}

NOINLINE double absd(double x) { return fabs(x); }
NOINLINE double negd(double x) { return -x; }
NOINLINE double nabsd(double x) { return -fabs(x); }
NOINLINE float absf(float x) { return fabsf(x); }
NOINLINE float negf(float x) { return -x; }

NOINLINE double sum_abs(const double *a, int n) {
    double s = 0;
    for (int i = 0; i < n; i++)
        s += fabs(a[i]) - -a[i];
    return s;
}

int main(void) {
    static const uint64_t d[] = {
        0, 0x8000000000000000u, 0x3ff0000000000000u, 0xbff0000000000000u,
        0x7ff0000000000000u, 0xfff0000000000000u, 0x7ff8000000000001u, 0xfff8000000000001u,
        0x0000000000000001u, 0x800fffffffffffffu,
    };
    static const uint32_t f[] = {
        0, 0x80000000u, 0x3f800000u, 0xbf800000u, 0x7f800000u, 0xff800000u, 0x7fc00001u, 0xffc00001u,
    };
    const uint64_t sign = 0x8000000000000000u;
    for (unsigned i = 0; i < sizeof d / sizeof d[0]; i++) {
        if (bits(absd(of(d[i]))) != (d[i] & ~sign))
            return 1;
        if (bits(negd(of(d[i]))) != (d[i] ^ sign))
            return 2;
        if (bits(nabsd(of(d[i]))) != (d[i] | sign))
            return 3;
    }
    for (unsigned i = 0; i < sizeof f / sizeof f[0]; i++) {
        if (bitsf(absf(off(f[i]))) != (f[i] & 0x7fffffffu))
            return 4;
        if (bitsf(negf(off(f[i]))) != (f[i] ^ 0x80000000u))
            return 5;
    }
    double a[64];
    for (int i = 0; i < 64; i++)
        a[i] = (i & 1 ? -0.5 : 0.25) * i;
    double want = 0;
    for (int i = 0; i < 64; i++)
        want += (i & 1 ? 0.5 * i : 0.25 * i) + (i & 1 ? -0.5 : 0.25) * i;
    if (sum_abs(a, 64) != want)
        return 6;
    return 0;
}
