/* SVE arguments and results under the SVE procedure call standard: vectors
 * in z0-z7, sharing the count with the floating-point arguments, predicates
 * in p0-p3, the rest as the address of a copy the caller makes, in an
 * integer register or on the stack. Results come back in z0 and p0, through
 * direct calls and a function pointer. The exit status is the vector length
 * in 128-bit granules. */
#include <arm_sve.h>

static unsigned char src[16][256];
static unsigned char out[256];
static double seen[2];
static long seen_long;

static void fill(void) {
    for (int i = 0; i < 16; i++)
        for (int j = 0; j < 256; j++)
            src[i][j] = (unsigned char)(i * 31 + j * 7 + 1);
}

#define V(i) (*(const svint8_t *)src[i])
#define P(i) (*(const svbool_t *)src[i])

/* The vector length in bytes, as far as a vector copy reaches: a predicate
 * is an eighth of it. */
static int vl;

static int vector_length(void) {
    static unsigned char ones[256], copy[256];
    for (int j = 0; j < 256; j++)
        ones[j] = 0xff;
    *(svint8_t *)copy = *(const svint8_t *)ones;
    int n = 0;
    while (n < 256 && copy[n] == 0xff)
        n++;
    return n;
}

static int same(int i, int bytes) {
    for (int j = 0; j < bytes; j++)
        if (out[j] != src[i][j])
            return 0;
    return 1;
}

__attribute__((noinline)) svint8_t mixed(int k, double d0, svint8_t a, svbool_t p, svint8_t b,
                                         double d1, svbool_t q, svint8_t c) {
    seen[0] = d0;
    seen[1] = d1;
    if (k == 3)
        *(svbool_t *)out = p;
    else
        *(svbool_t *)out = q;
    if (k == 0)
        return a;
    if (k == 1)
        return b;
    return c;
}

__attribute__((noinline)) svint8_t nth(int k, svint8_t a0, svint8_t a1, svint8_t a2, svint8_t a3,
                                       svint8_t a4, svint8_t a5, svint8_t a6, svint8_t a7,
                                       svint8_t a8, svint8_t a9, svint8_t a10) {
    switch (k) {
    case 0: return a0;
    case 3: return a3;
    case 7: return a7;
    case 8: return a8;
    case 9: return a9;
    default: return a10;
    }
}

__attribute__((noinline)) svbool_t nthp(int k, svbool_t p0, svbool_t p1, svbool_t p2,
                                        svbool_t p3, svbool_t p4, svbool_t p5) {
    switch (k) {
    case 0: return p0;
    case 3: return p3;
    case 4: return p4;
    default: return p5;
    }
}

/* Past x0-x7 the copy's address goes on the stack. */
__attribute__((noinline)) svint8_t far(long x0, long x1, long x2, long x3, long x4, long x5,
                                       long x6, long x7, double d0, double d1, double d2,
                                       double d3, double d4, double d5, double d6, svint8_t z7,
                                       svint8_t ref, long last) {
    seen_long = x0 + x7 + last;
    seen[0] = d0 + d6;
    if (last == 1)
        return z7;
    return ref;
}

static svint8_t (*fp)(int, double, svint8_t, svbool_t, svint8_t, double, svbool_t, svint8_t) = mixed;

int main(void) {
    fill();
    vl = vector_length();
    for (int k = 0; k < 3; k++) {
        *(svint8_t *)out = mixed(k, 1.5, V(1), P(2), V(3), -2.25, P(4), V(5));
        if (!same(1 + 2 * k, vl) || seen[0] != 1.5 || seen[1] != -2.25)
            return 10 + k;
        *(svint8_t *)out = fp(k, 0.5, V(5), P(6), V(7), 4.0, P(8), V(9));
        if (!same(5 + 2 * k, vl))
            return 20 + k;
    }
    mixed(3, 0, V(0), P(11), V(0), 0, P(12), V(0));
    if (!same(11, vl / 8))
        return 30;
    mixed(4, 0, V(0), P(11), V(0), 0, P(12), V(0));
    if (!same(12, vl / 8))
        return 31;
    static const int picks[] = {0, 3, 7, 8, 9, 10};
    for (int i = 0; i < 6; i++) {
        int k = picks[i];
        *(svint8_t *)out = nth(k, V(0), V(1), V(2), V(3), V(4), V(5), V(6), V(7), V(8), V(9),
                               V(10));
        if (!same(k, vl))
            return 40 + k;
    }
    static const int ppicks[] = {0, 3, 4, 5};
    for (int i = 0; i < 4; i++) {
        int k = ppicks[i];
        *(svbool_t *)out = nthp(k, P(10), P(11), P(12), P(13), P(14), P(15));
        if (!same(10 + k, vl / 8))
            return 60 + k;
    }
    for (long last = 1; last < 3; last++) {
        *(svint8_t *)out = far(1, 2, 3, 4, 5, 6, 7, 8, 0.25, 1, 2, 3, 4, 5, 6.5, V(13), V(14),
                               last);
        if (!same(last == 1 ? 13 : 14, vl) || seen_long != 9 + last || seen[0] != 6.75)
            return 70 + (int)last;
    }
    return vl / 16;
}
