/* <arm_neon.h> vrecpe and vrsqrte, bit for bit against the Arm ARM's
 * FPRecipEstimate / FPRSqrtEstimate (8-bit tables, FPCR.AH clear), and the
 * steps vrecps (2 - a * b) and vrsqrts ((3 - a * b) / 2), each rounded once,
 * on every float vector. The exit code has a bit per failing group;
 * elsewhere than AArch64 the unit is empty. */
// snapshot-budget: exempt
#if defined(__aarch64__)
#include <arm_neon.h>
#include <math.h>
#include <stdint.h>
#include <string.h>

static int fails;
#define FAIL_IF(bit, c)                                                   \
    do {                                                                  \
        if (c)                                                            \
            fails |= (bit);                                               \
    } while (0)

static int recip_estimate(int a) {
    a = a * 2 + 1;
    int b = (1 << 19) / a;
    return (b + 1) / 2;
}

static int rsqrt_estimate(int a) {
    if (a < 256) {
        a = a * 2 + 1;
    } else {
        a = (a >> 1) << 1;
        a = (a + 1) * 2;
    }
    long long b = 512;
    while (a * (b + 1) * (b + 1) < (1LL << 28))
        b++;
    return (int)((b + 1) / 2);
}

/* The estimates of a normal positive operand of n = 32 or 64 bits, given
 * as its biased exponent and its fraction widened to 52 bits. */
static uint64_t recpe_bits(int n, int exp, uint64_t frac) {
    int scaled = (int)(256 | (frac >> 44));
    int rexp = (n == 32 ? 253 : 2045) - exp;
    uint64_t f = (uint64_t)(recip_estimate(scaled) & 0xFF) << 44;
    return n == 32 ? (uint64_t)rexp << 23 | f >> 29 : (uint64_t)rexp << 52 | f;
}
static uint64_t rsqrte_bits(int n, int exp, uint64_t frac) {
    int scaled = exp & 1 ? (int)(128 | (frac >> 45)) : (int)(256 | (frac >> 44));
    int rexp = ((n == 32 ? 380 : 3068) - exp) / 2;
    uint64_t f = (uint64_t)(rsqrt_estimate(scaled) & 0xFF) << 44;
    return n == 32 ? (uint64_t)rexp << 23 | f >> 29 : (uint64_t)rexp << 52 | f;
}

static uint32_t f2u(float f) {
    uint32_t u;
    memcpy(&u, &f, 4);
    return u;
}
static float u2f(uint32_t u) {
    float f;
    memcpy(&f, &u, 4);
    return f;
}
static uint64_t d2u(double d) {
    uint64_t u;
    memcpy(&u, &d, 8);
    return u;
}
static double u2d(uint64_t u) {
    double d;
    memcpy(&d, &u, 8);
    return d;
}

int main(void) {
    /* Every table entry at an even and an odd exponent. */
    for (int m = 0; m < 256; m += 2) {
        for (int e = 0; e < 2; e++) {
            int exp32 = 120 + e, exp64 = 1010 + e;
            float32_t fin[4];
            float64_t din[2];
            for (int i = 0; i < 4; i++)
                fin[i] = u2f((uint32_t)exp32 << 23 | (uint32_t)((m + i % 2) << 15 | (i * 0x1357)));
            for (int i = 0; i < 2; i++)
                din[i] = u2d((uint64_t)exp64 << 52 | (uint64_t)(m + i) << 44 | 0x123456789ull * (i + 1));
            float32x4_t q = vld1q_f32(fin);
            float32x2_t d = vld1_f32(fin + 2);
            float64x2_t dq = vld1q_f64(din);
            float64x1_t dd = vld1_f64(din + 1);
            float32x4_t rq = vrecpeq_f32(q), sq = vrsqrteq_f32(q);
            float32x2_t rd = vrecpe_f32(d), sd = vrsqrte_f32(d);
            float64x2_t rdq = vrecpeq_f64(dq), sdq = vrsqrteq_f64(dq);
            float64x1_t rdd = vrecpe_f64(dd), sdd = vrsqrte_f64(dd);
            for (int i = 0; i < 4; i++) {
                uint64_t fr = (uint64_t)(f2u(fin[i]) & 0x7FFFFF) << 29;
                FAIL_IF(1, f2u(rq[i]) != recpe_bits(32, exp32, fr));
                FAIL_IF(2, f2u(sq[i]) != rsqrte_bits(32, exp32, fr));
            }
            for (int i = 0; i < 2; i++) {
                uint64_t fr = (uint64_t)(f2u(fin[2 + i]) & 0x7FFFFF) << 29;
                FAIL_IF(1, f2u(rd[i]) != recpe_bits(32, exp32, fr));
                FAIL_IF(2, f2u(sd[i]) != rsqrte_bits(32, exp32, fr));
                uint64_t dfr = d2u(din[i]) & 0xFFFFFFFFFFFFFull;
                FAIL_IF(1, d2u(rdq[i]) != recpe_bits(64, exp64, dfr));
                FAIL_IF(2, d2u(sdq[i]) != rsqrte_bits(64, exp64, dfr));
            }
            uint64_t dfr = d2u(din[1]) & 0xFFFFFFFFFFFFFull;
            FAIL_IF(1, d2u(rdd[0]) != recpe_bits(64, exp64, dfr));
            FAIL_IF(2, d2u(sdd[0]) != rsqrte_bits(64, exp64, dfr));
        }
    }

    /* The sign carries through vrecpe; zeros and infinities swap. */
    float32x4_t sp = {0.0f, -0.0f, INFINITY, -INFINITY};
    float32x4_t r = vrecpeq_f32(sp), s = vrsqrteq_f32(sp);
    FAIL_IF(1, f2u(r[0]) != 0x7F800000u || f2u(r[1]) != 0xFF800000u);
    FAIL_IF(1, f2u(r[2]) != 0 || f2u(r[3]) != 0x80000000u);
    FAIL_IF(1, f2u(vrecpe_f32((float32x2_t){-3.0f, 3.0f})[0]) != (f2u(vrecpe_f32((float32x2_t){-3.0f, 3.0f})[1]) | 0x80000000u));
    FAIL_IF(2, f2u(s[0]) != 0x7F800000u || f2u(s[1]) != 0xFF800000u || f2u(s[2]) != 0);
    FAIL_IF(2, !isnan(s[3]) || !isnan(vrsqrteq_f64((float64x2_t){-4.0, 4.0})[0]));

    /* The steps, rounded once (lanes 1 and 3 differ from a separate
     * multiply and add), and their infinity-times-zero results. */
    static const float a32[4] = {0.75f, 0x1.001p+0f, -1.5f, 0x1.001p+0f};
    static const float b32[4] = {1.25f, 0x1.001p+0f, 7.0f, 0x1.003p+0f};
    float32x4_t a = vld1q_f32(a32), b = vld1q_f32(b32);
    float32x4_t ps = vrecpsq_f32(a, b), qs = vrsqrtsq_f32(a, b);
    float32x2_t ps2 = vrecps_f32(vget_low_f32(a), vget_low_f32(b));
    float32x2_t qs2 = vrsqrts_f32(vget_high_f32(a), vget_high_f32(b));
    for (int i = 0; i < 4; i++) {
        FAIL_IF(4, ps[i] != fmaf(-a32[i], b32[i], 2.0f));
        FAIL_IF(8, qs[i] != fmaf(-a32[i], b32[i], 3.0f) * 0.5f);
    }
    for (int i = 0; i < 2; i++) {
        FAIL_IF(4, ps2[i] != fmaf(-a32[i], b32[i], 2.0f));
        FAIL_IF(8, qs2[i] != fmaf(-a32[2 + i], b32[2 + i], 3.0f) * 0.5f);
    }
    float64x2_t x = {0x1.0000002p+0, -2.5}, y = {0x1.0000004p+0, 0.125};
    float64x2_t pd = vrecpsq_f64(x, y), qd = vrsqrtsq_f64(x, y);
    for (int i = 0; i < 2; i++) {
        FAIL_IF(4, pd[i] != fma(-x[i], y[i], 2.0));
        FAIL_IF(8, qd[i] != fma(-x[i], y[i], 3.0) * 0.5);
    }
    float64x1_t x1 = {0x1.0000002p+0}, y1 = {0x1.0000004p+0};
    FAIL_IF(4, vrecps_f64(x1, y1)[0] != fma(-x1[0], y1[0], 2.0));
    FAIL_IF(8, vrsqrts_f64(x1, y1)[0] != fma(-x1[0], y1[0], 3.0) * 0.5);
    float32x4_t inf = vdupq_n_f32(INFINITY), zero = vdupq_n_f32(0.0f);
    FAIL_IF(4, vrecpsq_f32(inf, zero)[1] != 2.0f || vrecpsq_f32(zero, inf)[2] != 2.0f);
    FAIL_IF(8, vrsqrtsq_f32(inf, zero)[1] != 1.5f || vrsqrtsq_f32(zero, inf)[3] != 1.5f);
    FAIL_IF(4, vrecps_f64((float64x1_t){INFINITY}, (float64x1_t){0.0})[0] != 2.0);
    FAIL_IF(8, vrsqrts_f64((float64x1_t){0.0}, (float64x1_t){INFINITY})[0] != 1.5);

    /* Two Newton-Raphson steps reach 1/x and 1/sqrt(x) within a few ulp. */
    float32x4_t v = {3.0f, 0.1f, 7.25f, 1234.5f};
    float32x4_t e = vrecpeq_f32(v);
    e = vmulq_f32(e, vrecpsq_f32(v, e));
    e = vmulq_f32(e, vrecpsq_f32(v, e));
    float32x4_t t = vrsqrteq_f32(v);
    t = vmulq_f32(t, vrsqrtsq_f32(vmulq_f32(v, t), t));
    t = vmulq_f32(t, vrsqrtsq_f32(vmulq_f32(v, t), t));
    for (int i = 0; i < 4; i++) {
        FAIL_IF(16, fabsf(e[i] * v[i] - 1.0f) > 4e-7f);
        FAIL_IF(16, fabsf(t[i] * t[i] * v[i] - 1.0f) > 8e-7f);
    }
    return fails;
}
#else
int main(void) {
    return 0;
}
#endif
