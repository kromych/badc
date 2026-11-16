/* <arm_neon.h> the lane-indexed vmul, vmla, vmls, vfma, vfms, vmulx, vmull,
 * vmlal, vmlsl and doubling multiplies from 64- and 128-bit vectors at
 * several lanes, and the _n forms that take a scalar, over seeded lanes:
 * the result bits hash to what AArch64 hardware gives. The float lanes
 * hold no NaN, whose sign a fused negated product leaves to the compiler.
 * Elsewhere the unit is empty. */
#if defined(__aarch64__)
#define EXPECTED 0xfb39553e12f917a8ull
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
static int16x8_t i16(void) { int16x8_t v; for (int i = 0; i < 8; i++) { uint64_t r = rnd(); v[i] = (r & 7) == 0 ? (int16_t)0x8000 : (int16_t)(r >> 8); } return v; }
static int32x4_t i32(void) { int32x4_t v; for (int i = 0; i < 4; i++) { uint64_t r = rnd(); v[i] = (r & 7) == 0 ? (int32_t)0x80000000u : (int32_t)(r >> 16); } return v; }
/* Float lanes without NaNs: which NaN a fused negated product returns
 * depends on how a compiler negates it, which C leaves open. */
static float32x4_t f4n(void) { float32x4_t v = f4(); for (int i = 0; i < 4; i++) if (v[i] != v[i]) v[i] = 1.5f; return v; }
static float64x2_t d2n(void) { float64x2_t v = d2(); for (int i = 0; i < 2; i++) if (v[i] != v[i]) v[i] = -2.5; return v; }
static int64x2_t i64(void) { int64x2_t v; for (int i = 0; i < 2; i++) v[i] = (int64_t)rnd(); return v; }
#define L(N) do { \
    int16x4_t a1 = vmul_lane_s16(al, bl, (N) % 4); int16x8_t a2 = vmulq_laneq_s16(a, b, (N) % 8); \
    uint32x4_t a3 = vmulq_lane_u32(xu, vget_low_u32(yu), (N) % 2); int32x2_t a4 = vmul_laneq_s32(xl, y, (N) % 4); \
    float32x4_t a5 = vmulq_laneq_f32(f, g, (N) % 4); float32x2_t a6 = vmul_lane_f32(fl, gl, (N) % 2); \
    float64x2_t a7 = vmulq_laneq_f64(d, e, (N) % 2); float64x1_t a8 = vmul_laneq_f64(dl, e, (N) % 2); \
    int16x8_t b1 = vmlaq_lane_s16(c, a, bl, (N) % 4); uint16x4_t b2 = vmls_laneq_u16(vreinterpret_u16_s16(cl), vreinterpret_u16_s16(al), vreinterpretq_u16_s16(b), (N) % 8); \
    int32x4_t b3 = vmlsq_laneq_s32(z, x, y, (N) % 4); float32x4_t b4 = vfmaq_laneq_f32(h, f, g, (N) % 4); \
    float32x2_t b5 = vfms_lane_f32(hl, fl, gl, (N) % 2); float64x2_t b6 = vfmsq_laneq_f64(k, d, e, (N) % 2); \
    float64x1_t b7 = vfma_laneq_f64(kl, dl, e, (N) % 2); float32x4_t b8 = vmulxq_lane_f32(f, gl, (N) % 2); \
    float32x4_t b9 = vmlaq_laneq_f32(h, f, g, (N) % 4); float32x2_t b10 = vmls_lane_f32(hl, fl, gl, (N) % 2); \
    int32x4_t c1 = vmull_lane_s16(al, bl, (N) % 4); int32x4_t c2 = vmull_high_laneq_s16(a, b, (N) % 8); \
    uint64x2_t c3 = vmull_laneq_u32(vget_low_u32(xu), yu, (N) % 4); int64x2_t c4 = vmlal_high_lane_s32(w, x, yl, (N) % 2); \
    int32x4_t c5 = vmlsl_laneq_s16(x, al, b, (N) % 8); uint32x4_t c6 = vmlal_high_laneq_u16(xu, vreinterpretq_u16_s16(a), vreinterpretq_u16_s16(b), (N) % 8); \
    int16x8_t d1 = vqdmulhq_laneq_s16(a, b, (N) % 8); int32x2_t d2 = vqrdmulh_lane_s32(xl, yl, (N) % 2); \
    int16x4_t d3 = vqrdmlah_laneq_s16(cl, al, b, (N) % 8); int32x4_t d4 = vqrdmlshq_lane_s32(z, x, yl, (N) % 2); \
    int32x4_t d5 = vqdmull_lane_s16(al, bl, (N) % 4); int64x2_t d6 = vqdmull_high_laneq_s32(x, y, (N) % 4); \
    int32x4_t d7 = vqdmlal_laneq_s16(x, al, b, (N) % 8); int64x2_t d8 = vqdmlsl_high_lane_s32(w, x, yl, (N) % 2); \
    MIX(a1); MIX(a2); MIX(a3); MIX(a4); MIX(a5); MIX(a6); MIX(a7); MIX(a8); \
    MIX(b1); MIX(b2); MIX(b3); MIX(b4); MIX(b5); MIX(b6); MIX(b7); MIX(b8); MIX(b9); MIX(b10); \
    MIX(c1); MIX(c2); MIX(c3); MIX(c4); MIX(c5); MIX(c6); \
    MIX(d1); MIX(d2); MIX(d3); MIX(d4); MIX(d5); MIX(d6); MIX(d7); MIX(d8); } while (0)
int main(void) {
    int n = 300;
    for (int i = 0; i < n; i++) {
        int16x8_t a = i16(), b = i16(), c = i16(); int32x4_t x = i32(), y = i32(), z = i32(); int64x2_t w = i64();
        uint32x4_t xu = vreinterpretq_u32_s32(x), yu = vreinterpretq_u32_s32(y);
        int16x4_t al = vget_low_s16(a), bl = vget_low_s16(b), cl = vget_low_s16(c);
        int32x2_t xl = vget_low_s32(x), yl = vget_low_s32(y);
        float32x4_t f = f4n(), g = f4n(), h = f4n(); float32x2_t fl = vget_low_f32(f), gl = vget_high_f32(g), hl = vget_low_f32(h);
        float64x2_t d = d2n(), e = d2n(), k = d2n(); float64x1_t dl = vget_low_f64(d), kl = vget_high_f64(k);
        L(0); L(1); L(2); L(3); L(5); L(7);
        int16x8_t n1 = vmulq_n_s16(a, b[3]); uint32x2_t n2 = vmul_n_u32(vget_low_u32(xu), yu[1]);
        float32x4_t n3 = vmulq_n_f32(f, g[2]); float64x1_t n4 = vmul_n_f64(dl, e[1]);
        int32x4_t n5 = vmlaq_n_s32(z, x, y[0]); uint16x4_t n6 = vmls_n_u16(vreinterpret_u16_s16(cl), vreinterpret_u16_s16(al), (uint16_t)b[5]);
        int32x4_t n7 = vmull_n_s16(al, b[1]); uint64x2_t n8 = vmull_high_n_u32(xu, yu[3]);
        int64x2_t n9 = vmlal_n_s32(w, xl, y[2]); int32x4_t n10 = vmlsl_high_n_s16(x, a, b[6]);
        int16x8_t n11 = vqdmulhq_n_s16(a, b[0]); int32x2_t n12 = vqrdmulh_n_s32(xl, y[3]);
        int32x4_t n13 = vqdmull_n_s16(al, b[2]); int64x2_t n14 = vqdmlal_high_n_s32(w, x, y[1]);
        float32x4_t n15 = vfmaq_n_f32(h, f, g[1]); float64x2_t n16 = vfmsq_n_f64(k, d, e[0]);
        float32x2_t n17 = vmla_n_f32(hl, fl, g[3]); float32x4_t n18 = vmlsq_n_f32(h, f, g[0]);
        MIX(n1); MIX(n2); MIX(n3); MIX(n4); MIX(n5); MIX(n6); MIX(n7); MIX(n8); MIX(n9);
        MIX(n10); MIX(n11); MIX(n12); MIX(n13); MIX(n14); MIX(n15); MIX(n16); MIX(n17); MIX(n18);
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
