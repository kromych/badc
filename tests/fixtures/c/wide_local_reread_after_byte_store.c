/* A 16-byte local -- a long double where it is 16 bytes, a NEON vector on
 * AArch64 -- read whole, one byte of its upper half rewritten through a
 * character pointer, then read whole again. The character access aliases
 * the object (C99 6.5p7), so the second read sees the write. The byte is
 * the one holding the sign and the exponent's high bits, so the value
 * changes. Returns 0. */
#include <float.h>
#include <string.h>
#if defined(__aarch64__)
#include <arm_neon.h>
#endif

static void *volatile sink;

__attribute__((noinline)) static void keep(void *p) { sink = p; }

#if LDBL_MANT_DIG == 113
#define TOP 15
#elif LDBL_MANT_DIG == 64
#define TOP 9
#else
#define TOP 7
#endif

static volatile long double seed = 1.5L;

__attribute__((noinline)) static int long_double_reread(void) {
    long double x = seed;
    keep(&x);
    unsigned char *p = (unsigned char *)&x;
    long double first = x;
    p[TOP] ^= 0x01;
    long double second = x;
    long double want = first;
    unsigned char *w = (unsigned char *)&want;
    w[TOP] ^= 0x01;
    return second != first && second == want ? 0 : 1;
}

#if defined(__aarch64__)
static volatile unsigned char lane = 1;
static uint8x16_t out;

__attribute__((noinline)) static int vector_reread(void) {
    uint8x16_t v = vdupq_n_u8(lane);
    keep(&v);
    unsigned char *p = (unsigned char *)&v;
    uint8x16_t first = v;
    p[9] = 0x60;
    uint8x16_t second = v;
    out = veorq_u8(vshlq_n_u8(first, 1), second);
    unsigned char got[16];
    vst1q_u8(got, out);
    return got[9] == (2 ^ 0x60) && got[3] == (2 ^ 1) ? 0 : 2;
}
#else
static int vector_reread(void) { return 0; }
#endif

int main(void) {
    int r = long_double_reread();
    return r ? r : vector_reread();
}
