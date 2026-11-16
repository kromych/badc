/* <arm_neon.h> vrecpe, vrsqrte, vrecps and vrsqrts on every float vector and
 * scalar, and the u32 estimates, over seeded lanes with zeros, infinities,
 * quiet and signaling NaNs, subnormals and the overflow bounds: the result
 * bits hash to what AArch64 hardware gives. Elsewhere the unit is empty. */
#if defined(__aarch64__)
#define EXPECTED 0x6ebc18ffd123414cull
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
    int n = 2000;
    for (int i = 0; i < n; i++) {
        float32x4_t a = f4(), b = f4();
        float32x2_t c = f2(), d = f2();
        float64x2_t e = d2(), f = d2();
        float64x1_t g = d1(), k = d1();
        float32x4_t r1 = vrecpeq_f32(a), r2 = vrsqrteq_f32(a), r3 = vrecpsq_f32(a, b), r4 = vrsqrtsq_f32(a, b);
        float32x2_t s1 = vrecpe_f32(c), s2 = vrsqrte_f32(c), s3 = vrecps_f32(c, d), s4 = vrsqrts_f32(c, d);
        float64x2_t t1 = vrecpeq_f64(e), t2 = vrsqrteq_f64(e), t3 = vrecpsq_f64(e, f), t4 = vrsqrtsq_f64(e, f);
        float64x1_t q1 = vrecpe_f64(g), q2 = vrsqrte_f64(g), q3 = vrecps_f64(g, k), q4 = vrsqrts_f64(g, k);
        uint32x4_t w1 = vrecpeq_u32(u4()), w2 = vrsqrteq_u32(u4());
        uint32x2_t w3 = vrecpe_u32(u2()), w4 = vrsqrte_u32(u2());
        float32_t x1 = vrecpes_f32(a[0]), x2 = vrsqrtss_f32(a[1], b[1]);
        float64_t x3 = vrsqrted_f64(e[0]), x4 = vrecpsd_f64(e[1], f[1]);
        MIX(r1); MIX(r2); MIX(r3); MIX(r4); MIX(s1); MIX(s2); MIX(s3); MIX(s4);
        MIX(t1); MIX(t2); MIX(t3); MIX(t4); MIX(q1); MIX(q2); MIX(q3); MIX(q4);
        MIX(w1); MIX(w2); MIX(w3); MIX(w4); MIX(x1); MIX(x2); MIX(x3); MIX(x4);
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
