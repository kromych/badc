/* RAID-6 P / Q syndromes of a stripe, computed by an eight-lane NEON chain
 * in the statement order of the kernel's lib/raid6/neon.uc, checked against
 * the scalar GF(2^8) reference, then folded into a checksum through inline
 * asm operands of each kind that binds to a register: a vector, a double, a
 * constant, and a link-time address with and without an offset. Exits 0, or
 * the number of the first failed check. The NEON path runs on AArch64; the
 * scalar reference alone runs elsewhere. */

#if defined(__aarch64__)
#include <arm_neon.h>
#endif

#define DISKS 7 /* five data disks, P and Q */
#define BYTES 512

static unsigned char stripe[DISKS][BYTES];
static unsigned char ref_p[BYTES], ref_q[BYTES];
static const unsigned char salt[32] = {
    0x5a, 0x0f, 0xc3, 0x96, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb,
    0xcc, 0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54,
    0x32, 0x10,
};

static unsigned char gf_double(unsigned char x) {
    return (unsigned char)((x << 1) ^ ((x & 0x80) ? 0x1d : 0));
}

static void scalar_syndrome(void) {
    for (int b = 0; b < BYTES; b++) {
        unsigned char p = 0, q = 0;
        for (int z = DISKS - 3; z >= 0; z--) {
            q = (unsigned char)(gf_double(q) ^ stripe[z][b]);
            p ^= stripe[z][b];
        }
        ref_p[b] = p;
        ref_q[b] = q;
    }
}

static unsigned long long fnv(const unsigned char *b, int n, unsigned long long h) {
    for (int i = 0; i < n; i++)
        h = (h ^ b[i]) * 0x100000001b3ULL;
    return h;
}

#if defined(__aarch64__)
#define LANES(X) X(0) X(1) X(2) X(3) X(4) X(5) X(6) X(7)
#define START(n) uint8x16_t wp##n = vld1q_u8(&dptr[z0][d + n * 16]), wq##n = wp##n;
#define LOAD(n) wd##n = vld1q_u8(&dptr[z][d + n * 16]);
#define XOR_P(n) wp##n = veorq_u8(wp##n, wd##n);
#define MASK(n) w2##n = (uint8x16_t)vshrq_n_s8((int8x16_t)wq##n, 7);
#define SHIFT(n) w1##n = vshlq_n_u8(wq##n, 1);
#define REDUCE(n) w2##n = vandq_u8(w2##n, x1d);
#define XOR_1(n) w1##n = veorq_u8(w1##n, w2##n);
#define XOR_Q(n) wq##n = veorq_u8(w1##n, wd##n);
#define STORE_P(n) vst1q_u8(&p[d + n * 16], wp##n);
#define STORE_Q(n) vst1q_u8(&q[d + n * 16], wq##n);
#define TEMPS(n) uint8x16_t wd##n, w1##n, w2##n;

/* Sixteen loop-carried vectors and three temporaries per lane: past the
 * SIMD register file, so values spill and reload around the operands. */
static void neon8_gen_syndrome(int disks, unsigned long bytes, unsigned char **dptr) {
    int z0 = disks - 3;
    unsigned char *p = dptr[z0 + 1], *q = dptr[z0 + 2];
    const uint8x16_t x1d = vdupq_n_u8(0x1d);
    for (unsigned long d = 0; d < bytes; d += 8 * 16) {
        LANES(START)
        for (int z = z0 - 1; z >= 0; z--) {
            LANES(TEMPS)
            LANES(LOAD)
            LANES(XOR_P)
            LANES(MASK)
            LANES(SHIFT)
            LANES(REDUCE)
            LANES(XOR_1)
            LANES(XOR_Q)
        }
        LANES(STORE_P)
        LANES(STORE_Q)
    }
}

/* A 16-byte window of the link-time array `salt` at `off`, through an
 * address operand the statement forms itself. */
static uint8x16_t salt_at0(void) {
    uint8x16_t v;
    __asm__("ldr %q0, [%1]" : "=w"(v) : "r"(salt));
    return v;
}

static uint8x16_t salt_at16(void) {
    uint8x16_t v;
    __asm__("ldr %q0, [%1]" : "=w"(v) : "r"(&salt[16]));
    return v;
}

/* The bits of a double through a `w` input and an `r` output. */
static unsigned long long double_bits(double x) {
    unsigned long long bits;
    __asm__("fmov %x0, %d1" : "=r"(bits) : "w"(x));
    return bits;
}

/* A constant `r` input. */
static unsigned long long plus_constant(unsigned long long x) {
    unsigned long long r;
    __asm__("add %0, %1, %2" : "=r"(r) : "r"(x), "r"(0x1234567ULL));
    return r;
}
#endif

int main(void) {
    unsigned char *dptr[DISKS];
    for (int z = 0; z < DISKS; z++) {
        for (int b = 0; b < BYTES; b++)
            stripe[z][b] = (unsigned char)(z * 67 + b * 13 + (b >> 3) * 7 + 1);
        dptr[z] = stripe[z];
    }
    scalar_syndrome();
    unsigned long long want = fnv(ref_q, BYTES, fnv(ref_p, BYTES, 0xcbf29ce484222325ULL));
#if defined(__aarch64__)
    neon8_gen_syndrome(DISKS, BYTES, dptr);
    for (int b = 0; b < BYTES; b++) {
        if (stripe[DISKS - 2][b] != ref_p[b])
            return 1;
        if (stripe[DISKS - 1][b] != ref_q[b])
            return 2;
    }
    unsigned long long got =
        fnv(stripe[DISKS - 1], BYTES, fnv(stripe[DISKS - 2], BYTES, 0xcbf29ce484222325ULL));
    if (got != want)
        return 3;
    unsigned char s[32];
    vst1q_u8(s, salt_at0());
    vst1q_u8(s + 16, salt_at16());
    for (int i = 0; i < 32; i++)
        if (s[i] != salt[i])
            return 4;
    double x = (double)(want & 0xffff) + 0.5;
    union {
        double d;
        unsigned long long u;
    } pun = {x};
    if (double_bits(x) != pun.u)
        return 5;
    if (plus_constant(want) != want + 0x1234567ULL)
        return 6;
#endif
    return want == 0 ? 7 : 0;
}
