/* <arm_neon.h> vqdmulh, vqrdmulh, vqdmull, vqdmlal, vqdmlsl and the FEAT_RDM
 * vqrdmlah and vqrdmlsh, with their _high and scalar forms, over seeded
 * lanes with the extreme values that saturate: the result bits hash to
 * what AArch64 hardware gives. Elsewhere the unit is empty. */
#if defined(__aarch64__)
#define EXPECTED 0xf4e1dce20cdc20e8ull
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
static int16x8_t i16(void) { int16x8_t v; for (int i = 0; i < 8; i++) { uint64_t r = rnd(); v[i] = (r & 7) == 0 ? (int16_t)0x8000 : (r & 7) == 1 ? 0x7fff : (int16_t)(r >> 8); } return v; }
static int32x4_t i32(void) { int32x4_t v; for (int i = 0; i < 4; i++) { uint64_t r = rnd(); v[i] = (r & 7) == 0 ? (int32_t)0x80000000u : (r & 7) == 1 ? 0x7fffffff : (int32_t)(r >> 16); } return v; }
static int64x2_t i64(void) { int64x2_t v; for (int i = 0; i < 2; i++) { uint64_t r = rnd(); v[i] = (r & 7) == 0 ? (int64_t)0x8000000000000000ull : (r & 7) == 1 ? 0x7fffffffffffffffll : (int64_t)rnd(); } return v; }
int main(void) {
    int n = 1000;
    for (int i = 0; i < n; i++) {
        int16x8_t a = i16(), b = i16(), c = i16(); int32x4_t x = i32(), y = i32(), z = i32(); int64x2_t w = i64();
        int16x4_t al = vget_low_s16(a), bl = vget_low_s16(b), cl = vget_low_s16(c);
        int32x2_t xl = vget_low_s32(x), yl = vget_low_s32(y), zl = vget_low_s32(z);
        int16x8_t r1 = vqdmulhq_s16(a, b), r2 = vqrdmulhq_s16(a, b), r3 = vqrdmlahq_s16(c, a, b), r4 = vqrdmlshq_s16(c, a, b);
        int16x4_t r5 = vqdmulh_s16(al, bl), r6 = vqrdmulh_s16(al, bl), r7 = vqrdmlah_s16(cl, al, bl), r8 = vqrdmlsh_s16(cl, al, bl);
        int32x4_t s1 = vqdmulhq_s32(x, y), s2 = vqrdmulhq_s32(x, y), s3 = vqrdmlahq_s32(z, x, y), s4 = vqrdmlshq_s32(z, x, y);
        int32x2_t s5 = vqdmulh_s32(xl, yl), s6 = vqrdmulh_s32(xl, yl), s7 = vqrdmlah_s32(zl, xl, yl), s8 = vqrdmlsh_s32(zl, xl, yl);
        int32x4_t t1 = vqdmull_s16(al, bl), t2 = vqdmull_high_s16(a, b), t3 = vqdmlal_s16(x, al, bl), t4 = vqdmlsl_high_s16(x, a, b);
        int64x2_t t5 = vqdmull_s32(xl, yl), t6 = vqdmull_high_s32(x, y), t7 = vqdmlal_high_s32(w, x, y), t8 = vqdmlsl_s32(w, xl, yl);
        int16_t u1 = vqdmulhh_s16(a[0], b[0]), u2 = vqrdmlahh_s16(c[1], a[1], b[1]);
        int32_t u3 = vqrdmulhs_s32(x[0], y[0]), u4 = vqdmullh_s16(a[2], b[2]), u5 = vqdmlslh_s16(x[1], a[3], b[3]);
        int64_t u6 = vqdmulls_s32(x[2], y[2]), u7 = vqdmlals_s32(w[0], x[3], y[3]);
        MIX(r1); MIX(r2); MIX(r3); MIX(r4); MIX(r5); MIX(r6); MIX(r7); MIX(r8);
        MIX(s1); MIX(s2); MIX(s3); MIX(s4); MIX(s5); MIX(s6); MIX(s7); MIX(s8);
        MIX(t1); MIX(t2); MIX(t3); MIX(t4); MIX(t5); MIX(t6); MIX(t7); MIX(t8);
        MIX(u1); MIX(u2); MIX(u3); MIX(u4); MIX(u5); MIX(u6); MIX(u7);
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
