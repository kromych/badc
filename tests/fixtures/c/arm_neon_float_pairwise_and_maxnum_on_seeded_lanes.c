/* <arm_neon.h> vabd, vmaxnm, vminnm and vmulx on the float vectors and
 * scalars, the pairwise vpadd, vpmax, vpmin, vpmaxnm and vpminnm with their
 * scalar forms, and the across-lane vaddv, vmaxv, vminv, vmaxnmv and
 * vminnmv, over seeded lanes with zeros, infinities, quiet and signaling
 * NaNs and subnormals: the result bits hash to what AArch64 hardware
 * gives. Elsewhere the unit is empty. */
#if defined(__aarch64__)
#define EXPECTED 0x017f2f0db5bc4c21ull
#include <arm_neon.h>
#include <stdint.h>
#include <string.h>
static uint64_t st = 0x9e3779b97f4a7c15ull;
static uint64_t rnd(void) {
    st ^= st << 13; st ^= st >> 7; st ^= st << 17;
    return st;
}
/* Special values mixed into the random lanes. */
static const uint32_t SP32[] = {0, 0x80000000u, 0x7f800000u, 0xff800000u, 0x7fc00001u, 0x7f800002u,
    0xff800003u, 0x00000001u, 0x001fffffu, 0x00200000u, 0x00400000u, 0x00800000u, 0x7f7fffffu,
    0x3f800000u, 0xbf800000u, 0x40000000u, 0x40400000u, 0x3f000000u, 0x80000001u, 0x803fffffu,
    0x4f000000u, 0xcf000000u, 0x5f000000u, 0x4f800000u};
static const uint64_t SP64[] = {0, 0x8000000000000000ull, 0x7ff0000000000000ull, 0xfff0000000000000ull,
    0x7ff8000000000001ull, 0x7ff0000000000002ull, 0xfff0000000000003ull, 1, 0x0003ffffffffffffull,
    0x0004000000000000ull, 0x0008000000000000ull, 0x0010000000000000ull, 0x7fefffffffffffffull,
    0x3ff0000000000000ull, 0xbff0000000000000ull, 0x4000000000000000ull, 0x4008000000000000ull,
    0x43e0000000000000ull, 0xc3e0000000000000ull, 0x43f0000000000000ull, 0x41e0000000000000ull};
static uint32_t r32(void) {
    uint64_t x = rnd();
    if ((x & 7) == 0) return SP32[(x >> 8) % (sizeof SP32 / 4)];
    if ((x & 7) == 1) return (uint32_t)(x >> 32) & 0x80ffffffu; /* small exponents */
    if ((x & 7) == 2) return 0x3f000000u + ((uint32_t)(x >> 20) & 0x01ffffffu); /* near one */
    return (uint32_t)(x >> 16);
}
static uint64_t r64(void) {
    uint64_t x = rnd();
    if ((x & 7) == 0) return SP64[(x >> 8) % (sizeof SP64 / 8)];
    if ((x & 7) == 1) return rnd() & 0x800fffffffffffffull;
    if ((x & 7) == 2) return 0x3fe0000000000000ull + (rnd() >> 11);
    return rnd();
}
static uint64_t h = 1469598103934665603ull;
static void mix(const void *p, size_t n) {
    const unsigned char *b = p;
    for (size_t i = 0; i < n; i++) { h ^= b[i]; h *= 1099511628211ull; }
}
#define MIX(v) mix(&(v), sizeof (v))
static float32x4_t f4(void) { uint32_t u[4]; for (int i = 0; i < 4; i++) u[i] = r32(); float32x4_t v; memcpy(&v, u, 16); return v; }
static float32x2_t f2(void) { uint32_t u[2]; for (int i = 0; i < 2; i++) u[i] = r32(); float32x2_t v; memcpy(&v, u, 8); return v; }
static float64x2_t d2(void) { uint64_t u[2]; for (int i = 0; i < 2; i++) u[i] = r64(); float64x2_t v; memcpy(&v, u, 16); return v; }
static float64x1_t d1(void) { uint64_t u = r64(); float64x1_t v; memcpy(&v, &u, 8); return v; }
static uint32x4_t u4(void) { uint32x4_t v; for (int i = 0; i < 4; i++) v[i] = (uint32_t)rnd(); return v; }
static uint32x2_t u2(void) { uint32x2_t v; for (int i = 0; i < 2; i++) v[i] = (uint32_t)rnd(); return v; }
int main(void) {
    int n = 1000;
    for (int i = 0; i < n; i++) {
        float32x4_t a = f4(), b = f4();
        float32x2_t c = f2(), d = f2();
        float64x2_t e = d2(), f = d2();
        float64x1_t g = d1(), k = d1();
        float32x4_t r1 = vabdq_f32(a, b), r2 = vmaxnmq_f32(a, b), r3 = vminnmq_f32(a, b), r4 = vmulxq_f32(a, b);
        float32x2_t s1 = vabd_f32(c, d), s2 = vmaxnm_f32(c, d), s3 = vminnm_f32(c, d), s4 = vmulx_f32(c, d);
        float64x2_t t1 = vabdq_f64(e, f), t2 = vmaxnmq_f64(e, f), t3 = vminnmq_f64(e, f), t4 = vmulxq_f64(e, f);
        float64x1_t q1 = vabd_f64(g, k), q2 = vmaxnm_f64(g, k), q3 = vminnm_f64(g, k), q4 = vmulx_f64(g, k);
        float32x4_t p1 = vpaddq_f32(a, b), p2 = vpmaxq_f32(a, b), p3 = vpminq_f32(a, b), p4 = vpmaxnmq_f32(a, b), p5 = vpminnmq_f32(a, b);
        float32x2_t o1 = vpadd_f32(c, d), o2 = vpmax_f32(c, d), o3 = vpmin_f32(c, d), o4 = vpmaxnm_f32(c, d), o5 = vpminnm_f32(c, d);
        float64x2_t m1 = vpaddq_f64(e, f), m2 = vpmaxq_f64(e, f), m3 = vpminq_f64(e, f), m4 = vpmaxnmq_f64(e, f), m5 = vpminnmq_f64(e, f);
        float32_t v1 = vmaxvq_f32(a), v2 = vminvq_f32(a), v3 = vmaxnmvq_f32(a), v4 = vminnmvq_f32(a), v5 = vaddvq_f32(a);
        float32_t w1 = vmaxv_f32(c), w2 = vminv_f32(c), w3 = vmaxnmv_f32(c), w4 = vminnmv_f32(c), w5 = vaddv_f32(c);
        float64_t x1 = vmaxvq_f64(e), x2 = vminvq_f64(e), x3 = vmaxnmvq_f64(e), x4 = vminnmvq_f64(e), x5 = vaddvq_f64(e);
        float32_t y1 = vpadds_f32(c), y2 = vpmaxs_f32(c), y3 = vpminnms_f32(c), y4 = vabds_f32(a[0], b[0]), y5 = vmulxs_f32(a[1], b[1]);
        float64_t z1 = vpaddd_f64(e), z2 = vpmaxqd_f64(e), z3 = vpminnmqd_f64(f), z4 = vabdd_f64(e[0], f[0]), z5 = vmulxd_f64(e[1], f[1]);
        MIX(r1); MIX(r2); MIX(r3); MIX(r4); MIX(s1); MIX(s2); MIX(s3); MIX(s4);
        MIX(t1); MIX(t2); MIX(t3); MIX(t4); MIX(q1); MIX(q2); MIX(q3); MIX(q4);
        MIX(p1); MIX(p2); MIX(p3); MIX(p4); MIX(p5); MIX(o1); MIX(o2); MIX(o3); MIX(o4); MIX(o5);
        MIX(m1); MIX(m2); MIX(m3); MIX(m4); MIX(m5); MIX(v1); MIX(v2); MIX(v3); MIX(v4); MIX(v5);
        MIX(w1); MIX(w2); MIX(w3); MIX(w4); MIX(w5); MIX(x1); MIX(x2); MIX(x3); MIX(x4); MIX(x5);
        MIX(y1); MIX(y2); MIX(y3); MIX(y4); MIX(y5); MIX(z1); MIX(z2); MIX(z3); MIX(z4); MIX(z5);
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
