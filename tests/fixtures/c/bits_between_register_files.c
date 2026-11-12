// An object written as a double and read as a 64-bit integer, or the
// reverse, reads the same 64 bits (C17 6.5.2.3p3 and footnote 97): a union
// member, a pointer cast, a memcpy between two objects, and a structure of
// two 8-byte vectors copied out.
// Each result is checked against the bytes through a volatile object.
// Returns 0 when every check passes; each failure returns a distinct code.

#include <string.h>

typedef signed char c8 __attribute__((vector_size(8)));
typedef struct {
    c8 v[2];
} c8x2;
typedef union {
    double d;
    unsigned long long u;
} pun;

static inline __attribute__((always_inline)) c8x2 mk(c8 a, c8 b) {
    return (c8x2){{a + b, a - b}};
}
__attribute__((noinline)) void pair(c8x2 *o, const c8 *a, const c8 *b) { *o = mk(*a, *b); }

__attribute__((noinline)) double flip(double d) {
    pun x;
    x.d = d;
    x.u ^= 1ull << 63;
    return x.d;
}
__attribute__((noinline)) unsigned long long bits(double d) {
    pun x;
    x.d = d;
    return x.u;
}
__attribute__((noinline)) double from(unsigned long long u) {
    pun x;
    x.u = u;
    return x.d;
}
__attribute__((noinline)) void store_from(double *o, unsigned long long u) {
    pun x;
    x.u = u;
    *o = x.d;
}
__attribute__((noinline)) void store_bits(unsigned long long *o, double d) {
    pun x;
    x.d = d;
    *o = x.u;
}
__attribute__((noinline)) unsigned long long cast_bits(double d) {
    double t = d;
    return *(unsigned long long *)&t;
}
__attribute__((noinline)) double mix(const double *p, int n) {
    pun x;
    x.d = 1.0;
    for (int i = 0; i < n; i++) {
        x.u ^= (unsigned long long)i << 40;
        x.d += p[i];
    }
    return x.d;
}

__attribute__((noinline)) unsigned long long copy_bits(double d) {
    unsigned long long u;
    memcpy(&u, &d, sizeof u);
    return u;
}
__attribute__((noinline)) double copy_from(unsigned long long u) {
    double d;
    memcpy(&d, &u, sizeof d);
    return d;
}
__attribute__((noinline)) unsigned copy_float_bits(float f) {
    unsigned u;
    memcpy(&u, &f, sizeof u);
    return u;
}

static unsigned long long ref_bits(double d) {
    volatile double v = d;
    unsigned long long u;
    memcpy(&u, (const void *)&v, sizeof u);
    return u;
}
static double ref_from(unsigned long long u) {
    volatile unsigned long long v = u;
    double d;
    memcpy(&d, (const void *)&v, sizeof d);
    return d;
}

int main(void) {
    volatile double seed = -1234.5625;
    double s = seed;
    c8 a = {1, 2, 3, 4, 5, 6, 7, 8}, b = {10, 20, 30, 40, 50, 60, 70, 80};
    c8x2 r;
    pair(&r, &a, &b);
    for (int i = 0; i < 8; i++) {
        if (r.v[0][i] != (signed char)(a[i] + b[i]))
            return 1;
        if (r.v[1][i] != (signed char)(a[i] - b[i]))
            return 2;
    }
    if (flip(s) != -s || flip(-0.0) != 0.0 || ref_bits(flip(0.0)) != 1ull << 63)
        return 3;
    if (bits(s) != ref_bits(s))
        return 4;
    if (ref_bits(from(0xc000000000000001ull)) != 0xc000000000000001ull)
        return 5;
    double o;
    store_from(&o, 0x7ff8000000000123ull);
    if (ref_bits(o) != 0x7ff8000000000123ull)
        return 6;
    unsigned long long u;
    store_bits(&u, s);
    if (u != ref_bits(s))
        return 7;
    if (cast_bits(s) != ref_bits(s))
        return 8;
    double p[5] = {0.5, -1.25, 3.0, 1e10, -7.75};
    pun want = {.d = 1.0};
    for (int i = 0; i < 5; i++) {
        want.u = ref_bits(ref_from(want.u ^ ((unsigned long long)i << 40)));
        want.d = ref_from(ref_bits(want.d + p[i]));
    }
    if (ref_bits(mix(p, 5)) != ref_bits(want.d))
        return 9;
    if (copy_bits(s) != ref_bits(s))
        return 10;
    if (ref_bits(copy_from(0x8000000000000001ull)) != 0x8000000000000001ull)
        return 11;
    if (copy_float_bits(-1.5f) != 0xbfc00000u)
        return 12;
    return 0;
}
