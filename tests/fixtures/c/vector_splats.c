// GNU vectors whose every lane is one run-time value, of every element type
// at 8, 16, 32 and 64 bytes: each lane holds the value converted to the
// element type, a lane read of one is that value, and one used as an
// operand acts lane by lane. Each result is checked against the lanes
// through memory. Returns 0 when every check passes; each failure returns
// a distinct code.

#include <string.h>

typedef signed char v8c __attribute__((vector_size(8)));
typedef short v4s __attribute__((vector_size(8)));
typedef int v2i __attribute__((vector_size(8)));
typedef float v2f __attribute__((vector_size(8)));
typedef signed char v16c __attribute__((vector_size(16)));
typedef unsigned short v8us __attribute__((vector_size(16)));
typedef int v4i __attribute__((vector_size(16)));
typedef long long v2l __attribute__((vector_size(16)));
typedef float v4f __attribute__((vector_size(16)));
typedef double v2d __attribute__((vector_size(16)));
typedef unsigned char v32uc __attribute__((vector_size(32)));
typedef int v8i __attribute__((vector_size(32)));
typedef float v8f __attribute__((vector_size(32)));
typedef double v4d __attribute__((vector_size(32)));
typedef int v16i __attribute__((vector_size(64)));
typedef long long v8l __attribute__((vector_size(64)));

__attribute__((noinline)) v8c s8c(int x) { signed char c = (signed char)x; return (v8c){c, c, c, c, c, c, c, c}; }
__attribute__((noinline)) v4s s4s(int x) { short h = (short)x; return (v4s){h, h, h, h}; }
__attribute__((noinline)) v2i s2i(long long x) { int w = (int)x; return (v2i){w, w}; }
__attribute__((noinline)) v2f s2f(float x) { return (v2f){x, x}; }
__attribute__((noinline)) v16c s16c(int x) {
    signed char c = (signed char)x;
    return (v16c){c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c};
}
__attribute__((noinline)) v8us s8us(int x) {
    unsigned short h = (unsigned short)x;
    return (v8us){h, h, h, h, h, h, h, h};
}
__attribute__((noinline)) v4i s4i(long long x) { int w = (int)x; return (v4i){w, w, w, w}; }
__attribute__((noinline)) v2l s2l(long long x) { return (v2l){x, x}; }
__attribute__((noinline)) v4f s4f(float x) { return (v4f){x, x, x, x}; }
__attribute__((noinline)) v2d s2d(double x) { return (v2d){x, x}; }
__attribute__((noinline)) v32uc s32uc(int x) {
    unsigned char c = (unsigned char)x;
    return (v32uc){c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c,
                   c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c};
}
__attribute__((noinline)) v8i s8i(int x) { return (v8i){x, x, x, x, x, x, x, x}; }
__attribute__((noinline)) v8f s8f(float x) { return (v8f){x, x, x, x, x, x, x, x}; }
__attribute__((noinline)) v4d s4d(double x) { return (v4d){x, x, x, x}; }
__attribute__((noinline)) v16i s16i(int x) {
    return (v16i){x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x};
}
__attribute__((noinline)) v8l s8l(long long x) { return (v8l){x, x, x, x, x, x, x, x}; }

/* A splat as an operand, and a lane read of one. */
__attribute__((noinline)) v4i add_k(v4i v, int k) { return v + (v4i){k, k, k, k}; }
__attribute__((noinline)) int lane_of(int x, int i) {
    v4i v = (v4i){x, x, x, x};
    return v[i & 3] + v[2];
}
__attribute__((noinline)) double dlane_of(double x) {
    v2d v = (v2d){x, x};
    return v[1];
}

#define CHECK_LANES(T, E, v, want, code)                                       \
    do {                                                                       \
        E lanes[sizeof(T) / sizeof(E)];                                        \
        memcpy(lanes, &(v), sizeof lanes);                                     \
        for (unsigned i = 0; i < sizeof lanes / sizeof lanes[0]; i++)          \
            if (lanes[i] != (E)(want))                                         \
                return code;                                                   \
    } while (0)

int main(void) {
    volatile int seed = 0x12345681;
    volatile long long wide = 0x7fedcba987654321LL;
    volatile float f = -2.75f;
    volatile double d = 1.0e300;
    int x = seed;
    long long l = wide;

    v8c a = s8c(x);
    CHECK_LANES(v8c, signed char, a, (signed char)x, 1);
    v4s b = s4s(x);
    CHECK_LANES(v4s, short, b, (short)x, 2);
    v2i c = s2i(l);
    CHECK_LANES(v2i, int, c, (int)l, 3);
    v2f e = s2f(f);
    CHECK_LANES(v2f, float, e, f, 4);
    v16c g = s16c(x);
    CHECK_LANES(v16c, signed char, g, (signed char)x, 5);
    v8us h = s8us(x);
    CHECK_LANES(v8us, unsigned short, h, (unsigned short)x, 6);
    v4i k = s4i(l);
    CHECK_LANES(v4i, int, k, (int)l, 7);
    v2l m = s2l(l);
    CHECK_LANES(v2l, long long, m, l, 8);
    v4f n = s4f(f);
    CHECK_LANES(v4f, float, n, f, 9);
    v2d p = s2d(d);
    CHECK_LANES(v2d, double, p, d, 10);
    v32uc q = s32uc(x);
    CHECK_LANES(v32uc, unsigned char, q, (unsigned char)x, 11);
    v8i r = s8i(x);
    CHECK_LANES(v8i, int, r, x, 12);
    v8f s = s8f(f);
    CHECK_LANES(v8f, float, s, f, 13);
    v4d t = s4d(d);
    CHECK_LANES(v4d, double, t, d, 14);
    v16i u = s16i(x);
    CHECK_LANES(v16i, int, u, x, 15);
    v8l w = s8l(l);
    CHECK_LANES(v8l, long long, w, l, 16);

    /* An 8-byte vector as a whole: both lanes, nothing past them. */
    long long bits;
    memcpy(&bits, &c, sizeof bits);
    if (bits != (long long)(((unsigned long long)(unsigned)(int)l << 32) | (unsigned)(int)l))
        return 17;

    v4i base = {1, -2, 3, -4};
    v4i sum = add_k(base, x);
    for (int i = 0; i < 4; i++)
        if (sum[i] != base[i] + x)
            return 18;
    if (lane_of(x, 5) != 2 * x)
        return 19;
    if (dlane_of(d) != d)
        return 20;
    return 0;
}
