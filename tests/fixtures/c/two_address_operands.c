// Two-address operations whose right operand or implicit register meets
// the result's: a difference into the subtrahend's register at the
// wrapping edges, floating differences and quotients taken the reversed
// way, and variable shifts and rotates whose count, result or live values
// compete for the count register -- in a loop, beside a fourth parameter
// that arrives in it, and past the shift. The exit code names the first
// check that fails.

#define NOINLINE __attribute__((noinline))

NOINLINE static unsigned long rsub(unsigned long a, unsigned long b) {
    unsigned long t = a * 3;
    return b - t;
}

NOINLINE static unsigned long twice(unsigned long x) { return x * 2; }
NOINLINE static unsigned long rsub_call(unsigned long b, unsigned long (*f)(unsigned long)) {
    return b - f(b);
}

NOINLINE static double fdiv_rev(double a, double b) {
    double t = a * 3.0;
    return b / t;
}

NOINLINE static double fsub_rev(double a, double b) {
    double t = a * a;
    return b - t;
}

NOINLINE static float fsub_rev_f(float a, float b) {
    float t = a * a;
    return b - t;
}

NOINLINE static unsigned long ones(unsigned long v, int n) {
    unsigned long acc = 0;
    for (int i = 0; i < n; i++) acc += (v >> i) & 1;
    return acc;
}

// The fourth parameter arrives in rcx and is live across the shift.
NOINLINE static long past_fourth(long x, long c, long z, long k) { return (x << c) + k + z; }

// The count, the value and the result are all read after the shift.
NOINLINE static long all_live(long x, long c) {
    long s = x >> c;
    return s * 1000 + x * 10 + c;
}

// Loop-carried values around a shift by a loop-invariant count.
NOINLINE static long carried(long n, long m, long c, long k) {
    long acc = 0;
    for (long i = 0; acc < n; i += (m << c)) acc = i + k;
    return acc;
}

NOINLINE static unsigned long rotr(unsigned long x, unsigned n) {
    return (x >> (n & 63)) | (x << ((64 - n) & 63));
}

// Arguments pass through volatile objects, so no call is specialized on
// its constants.
static volatile unsigned long u[] = {2, 10, 0x2aaaaaaaaaaaaaabul, 0, 0x8000000000000000ul, 5};
static volatile double d[] = {1.0, 6.0, 0.5, 3.0, 10.0, -2.0, 0.0};
static volatile long l[] = {3, 4, 5, 7, 640, 100, 2, 1, 64, 8, 0};

int main(void) {
    if (rsub(u[0], u[1]) != 4) return 1;
    // 3 * 0x2aaaaaaaaaaaaaab wraps to 0x8000000000000001.
    if (rsub(u[2], u[3]) != 0x7ffffffffffffffful) return 2;
    // 3 * 2^63 wraps to 2^63, which negates to itself.
    if (rsub(u[4], u[5]) != 0x8000000000000005ul) return 3;
    if (rsub_call(u[5], twice) != 0xfffffffffffffffbul) return 4;
    if (rsub_call(u[4], twice) != 0x8000000000000000ul) return 5;

    if (fdiv_rev(d[0], d[1]) != 2.0 || fdiv_rev(d[2], d[3]) != 2.0) return 6;
    if (fsub_rev(d[3], d[4]) != 1.0 || fsub_rev(d[5], d[6]) != -4.0) return 7;
    if (fsub_rev_f((float)d[3], (float)d[4]) != 1.0f) return 8;

    if (ones(0xf0f0f0f0f0f0f0f0ul, (int)l[8]) != 32 || ones(0xfful, (int)l[1]) != 4) return 9;
    if (ones(0, (int)l[8]) != 0) return 9;
    if (past_fourth(l[0], l[1], l[2], l[3]) != 60) return 10;
    if (all_live(l[4], l[0]) != 86403) return 11;
    if (carried(l[5], l[6], l[0], l[7]) != 113) return 12;
    if (rotr(0x0123456789abcdeful, (unsigned)l[9]) != 0xef0123456789abcdul) return 13;
    if (rotr(1, (unsigned)l[10]) != 1 || rotr(1, (unsigned)l[7]) != 0x8000000000000000ul) return 14;
    return 0;
}
