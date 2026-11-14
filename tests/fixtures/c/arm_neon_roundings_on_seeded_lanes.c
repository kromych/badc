/* <arm_neon.h> vrnd, vrndn, vrnda, vrndm, vrndp, vrndx, vrndi and the
 * bounded vrnd32z, vrnd32x, vrnd64z and vrnd64x on every float vector, over
 * seeded lanes with NaNs, infinities, out-of-range and fractional values,
 * in two rounding directions, with the flags each raises: the result bits
 * hash to what AArch64 hardware gives. Elsewhere the unit is empty. */
#if defined(__aarch64__)
#define EXPECTED 0x110ca2148a038f04ull
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
#include <fenv.h>
#define R(op) do { \
    float32x4_t r1 = op##q_f32(a); float32x2_t r2 = op##_f32(c); \
    float64x2_t r3 = op##q_f64(e); float64x1_t r4 = op##_f64(g); \
    MIX(r1); MIX(r2); MIX(r3); MIX(r4); } while (0)
int main(void) {
    int n = 1000;
    for (int i = 0; i < n; i++) {
        float32x4_t a = f4(); float32x2_t c = f2(); float64x2_t e = d2(); float64x1_t g = d1();
        /* Scale some lanes into the range where rounding matters. */
        if (i & 1) { a = vmulq_f32(a, (float32x4_t){0x1p-100f, 0x1p-100f, 0x1p-100f, 0x1p-100f}); e = vmulq_f64(e, (float64x2_t){0x1p-1000, 0x1p-1000}); }
        feclearexcept(FE_ALL_EXCEPT);
        R(vrnd); R(vrndn); R(vrndm); R(vrndp); R(vrnda); R(vrndi); R(vrndx);
        R(vrnd32x); R(vrnd32z); R(vrnd64x); R(vrnd64z);
        float32_t s = vrndns_f32(a[0]); MIX(s);
        int fl = fetestexcept(FE_ALL_EXCEPT); MIX(fl);
        if (i % 4 == 2) {
            fesetround(i % 8 == 2 ? FE_UPWARD : FE_TOWARDZERO);
            R(vrndi); R(vrndx); R(vrnd32x); R(vrnd64x);
            fesetround(FE_TONEAREST);
        }
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
