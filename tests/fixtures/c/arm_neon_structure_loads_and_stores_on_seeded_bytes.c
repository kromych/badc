/* <arm_neon.h> vld1_x, vst1_x, vld2 to vld4 and vst2 to vst4 with their _dup
 * and _lane forms, on every element type at both widths, over seeded
 * bytes: the loaded vectors and the stored bytes hash to what AArch64
 * hardware gives. Elsewhere the unit is empty. */
#if defined(__aarch64__)
#define EXPECTED 0x175c4a8669746be0ull
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
static unsigned char src[512], dst[512];
int main(void) {
    int n = 100;
    for (int it = 0; it < n; it++) {
        for (int i = 0; i < 512; i++) src[i] = (unsigned char)rnd();
        memset(dst, 0, sizeof dst);
        { const int8_t *p = (const int8_t *)src; int8_t *o = (int8_t *)dst;
          int8x8x2_t a = vld2_s8(p); int8x8x2_t b = vld1_s8_x2(p + 1); int8x8x2_t c = vld2_dup_s8(p + 3);
          int8x8x2_t d = vld2_lane_s8(p + 5, a, 7);
          vst2_s8(o, d); vst1_s8_x2(o + 16, c); vst2_lane_s8(o + 32, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int8_t *p = (const int8_t *)src; int8_t *o = (int8_t *)dst;
          int8x8x3_t a = vld3_s8(p); int8x8x3_t b = vld1_s8_x3(p + 1); int8x8x3_t c = vld3_dup_s8(p + 3);
          int8x8x3_t d = vld3_lane_s8(p + 5, a, 7);
          vst3_s8(o, d); vst1_s8_x3(o + 24, c); vst3_lane_s8(o + 48, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int8_t *p = (const int8_t *)src; int8_t *o = (int8_t *)dst;
          int8x8x4_t a = vld4_s8(p); int8x8x4_t b = vld1_s8_x4(p + 1); int8x8x4_t c = vld4_dup_s8(p + 3);
          int8x8x4_t d = vld4_lane_s8(p + 5, a, 7);
          vst4_s8(o, d); vst1_s8_x4(o + 32, c); vst4_lane_s8(o + 64, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int8_t *p = (const int8_t *)src; int8_t *o = (int8_t *)dst;
          int8x16x2_t a = vld2q_s8(p); int8x16x2_t b = vld1q_s8_x2(p + 1); int8x16x2_t c = vld2q_dup_s8(p + 3);
          int8x16x2_t d = vld2q_lane_s8(p + 5, a, 15);
          vst2q_s8(o, d); vst1q_s8_x2(o + 32, c); vst2q_lane_s8(o + 64, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int8_t *p = (const int8_t *)src; int8_t *o = (int8_t *)dst;
          int8x16x3_t a = vld3q_s8(p); int8x16x3_t b = vld1q_s8_x3(p + 1); int8x16x3_t c = vld3q_dup_s8(p + 3);
          int8x16x3_t d = vld3q_lane_s8(p + 5, a, 15);
          vst3q_s8(o, d); vst1q_s8_x3(o + 48, c); vst3q_lane_s8(o + 96, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int8_t *p = (const int8_t *)src; int8_t *o = (int8_t *)dst;
          int8x16x4_t a = vld4q_s8(p); int8x16x4_t b = vld1q_s8_x4(p + 1); int8x16x4_t c = vld4q_dup_s8(p + 3);
          int8x16x4_t d = vld4q_lane_s8(p + 5, a, 15);
          vst4q_s8(o, d); vst1q_s8_x4(o + 64, c); vst4q_lane_s8(o + 128, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint8_t *p = (const uint8_t *)src; uint8_t *o = (uint8_t *)dst;
          uint8x8x2_t a = vld2_u8(p); uint8x8x2_t b = vld1_u8_x2(p + 1); uint8x8x2_t c = vld2_dup_u8(p + 3);
          uint8x8x2_t d = vld2_lane_u8(p + 5, a, 7);
          vst2_u8(o, d); vst1_u8_x2(o + 16, c); vst2_lane_u8(o + 32, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint8_t *p = (const uint8_t *)src; uint8_t *o = (uint8_t *)dst;
          uint8x8x3_t a = vld3_u8(p); uint8x8x3_t b = vld1_u8_x3(p + 1); uint8x8x3_t c = vld3_dup_u8(p + 3);
          uint8x8x3_t d = vld3_lane_u8(p + 5, a, 7);
          vst3_u8(o, d); vst1_u8_x3(o + 24, c); vst3_lane_u8(o + 48, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint8_t *p = (const uint8_t *)src; uint8_t *o = (uint8_t *)dst;
          uint8x8x4_t a = vld4_u8(p); uint8x8x4_t b = vld1_u8_x4(p + 1); uint8x8x4_t c = vld4_dup_u8(p + 3);
          uint8x8x4_t d = vld4_lane_u8(p + 5, a, 7);
          vst4_u8(o, d); vst1_u8_x4(o + 32, c); vst4_lane_u8(o + 64, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint8_t *p = (const uint8_t *)src; uint8_t *o = (uint8_t *)dst;
          uint8x16x2_t a = vld2q_u8(p); uint8x16x2_t b = vld1q_u8_x2(p + 1); uint8x16x2_t c = vld2q_dup_u8(p + 3);
          uint8x16x2_t d = vld2q_lane_u8(p + 5, a, 15);
          vst2q_u8(o, d); vst1q_u8_x2(o + 32, c); vst2q_lane_u8(o + 64, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint8_t *p = (const uint8_t *)src; uint8_t *o = (uint8_t *)dst;
          uint8x16x3_t a = vld3q_u8(p); uint8x16x3_t b = vld1q_u8_x3(p + 1); uint8x16x3_t c = vld3q_dup_u8(p + 3);
          uint8x16x3_t d = vld3q_lane_u8(p + 5, a, 15);
          vst3q_u8(o, d); vst1q_u8_x3(o + 48, c); vst3q_lane_u8(o + 96, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint8_t *p = (const uint8_t *)src; uint8_t *o = (uint8_t *)dst;
          uint8x16x4_t a = vld4q_u8(p); uint8x16x4_t b = vld1q_u8_x4(p + 1); uint8x16x4_t c = vld4q_dup_u8(p + 3);
          uint8x16x4_t d = vld4q_lane_u8(p + 5, a, 15);
          vst4q_u8(o, d); vst1q_u8_x4(o + 64, c); vst4q_lane_u8(o + 128, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly8_t *p = (const poly8_t *)src; poly8_t *o = (poly8_t *)dst;
          poly8x8x2_t a = vld2_p8(p); poly8x8x2_t b = vld1_p8_x2(p + 1); poly8x8x2_t c = vld2_dup_p8(p + 3);
          poly8x8x2_t d = vld2_lane_p8(p + 5, a, 7);
          vst2_p8(o, d); vst1_p8_x2(o + 16, c); vst2_lane_p8(o + 32, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly8_t *p = (const poly8_t *)src; poly8_t *o = (poly8_t *)dst;
          poly8x8x3_t a = vld3_p8(p); poly8x8x3_t b = vld1_p8_x3(p + 1); poly8x8x3_t c = vld3_dup_p8(p + 3);
          poly8x8x3_t d = vld3_lane_p8(p + 5, a, 7);
          vst3_p8(o, d); vst1_p8_x3(o + 24, c); vst3_lane_p8(o + 48, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly8_t *p = (const poly8_t *)src; poly8_t *o = (poly8_t *)dst;
          poly8x8x4_t a = vld4_p8(p); poly8x8x4_t b = vld1_p8_x4(p + 1); poly8x8x4_t c = vld4_dup_p8(p + 3);
          poly8x8x4_t d = vld4_lane_p8(p + 5, a, 7);
          vst4_p8(o, d); vst1_p8_x4(o + 32, c); vst4_lane_p8(o + 64, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly8_t *p = (const poly8_t *)src; poly8_t *o = (poly8_t *)dst;
          poly8x16x2_t a = vld2q_p8(p); poly8x16x2_t b = vld1q_p8_x2(p + 1); poly8x16x2_t c = vld2q_dup_p8(p + 3);
          poly8x16x2_t d = vld2q_lane_p8(p + 5, a, 15);
          vst2q_p8(o, d); vst1q_p8_x2(o + 32, c); vst2q_lane_p8(o + 64, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly8_t *p = (const poly8_t *)src; poly8_t *o = (poly8_t *)dst;
          poly8x16x3_t a = vld3q_p8(p); poly8x16x3_t b = vld1q_p8_x3(p + 1); poly8x16x3_t c = vld3q_dup_p8(p + 3);
          poly8x16x3_t d = vld3q_lane_p8(p + 5, a, 15);
          vst3q_p8(o, d); vst1q_p8_x3(o + 48, c); vst3q_lane_p8(o + 96, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly8_t *p = (const poly8_t *)src; poly8_t *o = (poly8_t *)dst;
          poly8x16x4_t a = vld4q_p8(p); poly8x16x4_t b = vld1q_p8_x4(p + 1); poly8x16x4_t c = vld4q_dup_p8(p + 3);
          poly8x16x4_t d = vld4q_lane_p8(p + 5, a, 15);
          vst4q_p8(o, d); vst1q_p8_x4(o + 64, c); vst4q_lane_p8(o + 128, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int16_t *p = (const int16_t *)src; int16_t *o = (int16_t *)dst;
          int16x4x2_t a = vld2_s16(p); int16x4x2_t b = vld1_s16_x2(p + 1); int16x4x2_t c = vld2_dup_s16(p + 3);
          int16x4x2_t d = vld2_lane_s16(p + 5, a, 3);
          vst2_s16(o, d); vst1_s16_x2(o + 8, c); vst2_lane_s16(o + 16, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int16_t *p = (const int16_t *)src; int16_t *o = (int16_t *)dst;
          int16x4x3_t a = vld3_s16(p); int16x4x3_t b = vld1_s16_x3(p + 1); int16x4x3_t c = vld3_dup_s16(p + 3);
          int16x4x3_t d = vld3_lane_s16(p + 5, a, 3);
          vst3_s16(o, d); vst1_s16_x3(o + 12, c); vst3_lane_s16(o + 24, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int16_t *p = (const int16_t *)src; int16_t *o = (int16_t *)dst;
          int16x4x4_t a = vld4_s16(p); int16x4x4_t b = vld1_s16_x4(p + 1); int16x4x4_t c = vld4_dup_s16(p + 3);
          int16x4x4_t d = vld4_lane_s16(p + 5, a, 3);
          vst4_s16(o, d); vst1_s16_x4(o + 16, c); vst4_lane_s16(o + 32, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int16_t *p = (const int16_t *)src; int16_t *o = (int16_t *)dst;
          int16x8x2_t a = vld2q_s16(p); int16x8x2_t b = vld1q_s16_x2(p + 1); int16x8x2_t c = vld2q_dup_s16(p + 3);
          int16x8x2_t d = vld2q_lane_s16(p + 5, a, 7);
          vst2q_s16(o, d); vst1q_s16_x2(o + 16, c); vst2q_lane_s16(o + 32, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int16_t *p = (const int16_t *)src; int16_t *o = (int16_t *)dst;
          int16x8x3_t a = vld3q_s16(p); int16x8x3_t b = vld1q_s16_x3(p + 1); int16x8x3_t c = vld3q_dup_s16(p + 3);
          int16x8x3_t d = vld3q_lane_s16(p + 5, a, 7);
          vst3q_s16(o, d); vst1q_s16_x3(o + 24, c); vst3q_lane_s16(o + 48, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int16_t *p = (const int16_t *)src; int16_t *o = (int16_t *)dst;
          int16x8x4_t a = vld4q_s16(p); int16x8x4_t b = vld1q_s16_x4(p + 1); int16x8x4_t c = vld4q_dup_s16(p + 3);
          int16x8x4_t d = vld4q_lane_s16(p + 5, a, 7);
          vst4q_s16(o, d); vst1q_s16_x4(o + 32, c); vst4q_lane_s16(o + 64, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint16_t *p = (const uint16_t *)src; uint16_t *o = (uint16_t *)dst;
          uint16x4x2_t a = vld2_u16(p); uint16x4x2_t b = vld1_u16_x2(p + 1); uint16x4x2_t c = vld2_dup_u16(p + 3);
          uint16x4x2_t d = vld2_lane_u16(p + 5, a, 3);
          vst2_u16(o, d); vst1_u16_x2(o + 8, c); vst2_lane_u16(o + 16, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint16_t *p = (const uint16_t *)src; uint16_t *o = (uint16_t *)dst;
          uint16x4x3_t a = vld3_u16(p); uint16x4x3_t b = vld1_u16_x3(p + 1); uint16x4x3_t c = vld3_dup_u16(p + 3);
          uint16x4x3_t d = vld3_lane_u16(p + 5, a, 3);
          vst3_u16(o, d); vst1_u16_x3(o + 12, c); vst3_lane_u16(o + 24, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint16_t *p = (const uint16_t *)src; uint16_t *o = (uint16_t *)dst;
          uint16x4x4_t a = vld4_u16(p); uint16x4x4_t b = vld1_u16_x4(p + 1); uint16x4x4_t c = vld4_dup_u16(p + 3);
          uint16x4x4_t d = vld4_lane_u16(p + 5, a, 3);
          vst4_u16(o, d); vst1_u16_x4(o + 16, c); vst4_lane_u16(o + 32, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint16_t *p = (const uint16_t *)src; uint16_t *o = (uint16_t *)dst;
          uint16x8x2_t a = vld2q_u16(p); uint16x8x2_t b = vld1q_u16_x2(p + 1); uint16x8x2_t c = vld2q_dup_u16(p + 3);
          uint16x8x2_t d = vld2q_lane_u16(p + 5, a, 7);
          vst2q_u16(o, d); vst1q_u16_x2(o + 16, c); vst2q_lane_u16(o + 32, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint16_t *p = (const uint16_t *)src; uint16_t *o = (uint16_t *)dst;
          uint16x8x3_t a = vld3q_u16(p); uint16x8x3_t b = vld1q_u16_x3(p + 1); uint16x8x3_t c = vld3q_dup_u16(p + 3);
          uint16x8x3_t d = vld3q_lane_u16(p + 5, a, 7);
          vst3q_u16(o, d); vst1q_u16_x3(o + 24, c); vst3q_lane_u16(o + 48, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint16_t *p = (const uint16_t *)src; uint16_t *o = (uint16_t *)dst;
          uint16x8x4_t a = vld4q_u16(p); uint16x8x4_t b = vld1q_u16_x4(p + 1); uint16x8x4_t c = vld4q_dup_u16(p + 3);
          uint16x8x4_t d = vld4q_lane_u16(p + 5, a, 7);
          vst4q_u16(o, d); vst1q_u16_x4(o + 32, c); vst4q_lane_u16(o + 64, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly16_t *p = (const poly16_t *)src; poly16_t *o = (poly16_t *)dst;
          poly16x4x2_t a = vld2_p16(p); poly16x4x2_t b = vld1_p16_x2(p + 1); poly16x4x2_t c = vld2_dup_p16(p + 3);
          poly16x4x2_t d = vld2_lane_p16(p + 5, a, 3);
          vst2_p16(o, d); vst1_p16_x2(o + 8, c); vst2_lane_p16(o + 16, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly16_t *p = (const poly16_t *)src; poly16_t *o = (poly16_t *)dst;
          poly16x4x3_t a = vld3_p16(p); poly16x4x3_t b = vld1_p16_x3(p + 1); poly16x4x3_t c = vld3_dup_p16(p + 3);
          poly16x4x3_t d = vld3_lane_p16(p + 5, a, 3);
          vst3_p16(o, d); vst1_p16_x3(o + 12, c); vst3_lane_p16(o + 24, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly16_t *p = (const poly16_t *)src; poly16_t *o = (poly16_t *)dst;
          poly16x4x4_t a = vld4_p16(p); poly16x4x4_t b = vld1_p16_x4(p + 1); poly16x4x4_t c = vld4_dup_p16(p + 3);
          poly16x4x4_t d = vld4_lane_p16(p + 5, a, 3);
          vst4_p16(o, d); vst1_p16_x4(o + 16, c); vst4_lane_p16(o + 32, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly16_t *p = (const poly16_t *)src; poly16_t *o = (poly16_t *)dst;
          poly16x8x2_t a = vld2q_p16(p); poly16x8x2_t b = vld1q_p16_x2(p + 1); poly16x8x2_t c = vld2q_dup_p16(p + 3);
          poly16x8x2_t d = vld2q_lane_p16(p + 5, a, 7);
          vst2q_p16(o, d); vst1q_p16_x2(o + 16, c); vst2q_lane_p16(o + 32, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly16_t *p = (const poly16_t *)src; poly16_t *o = (poly16_t *)dst;
          poly16x8x3_t a = vld3q_p16(p); poly16x8x3_t b = vld1q_p16_x3(p + 1); poly16x8x3_t c = vld3q_dup_p16(p + 3);
          poly16x8x3_t d = vld3q_lane_p16(p + 5, a, 7);
          vst3q_p16(o, d); vst1q_p16_x3(o + 24, c); vst3q_lane_p16(o + 48, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly16_t *p = (const poly16_t *)src; poly16_t *o = (poly16_t *)dst;
          poly16x8x4_t a = vld4q_p16(p); poly16x8x4_t b = vld1q_p16_x4(p + 1); poly16x8x4_t c = vld4q_dup_p16(p + 3);
          poly16x8x4_t d = vld4q_lane_p16(p + 5, a, 7);
          vst4q_p16(o, d); vst1q_p16_x4(o + 32, c); vst4q_lane_p16(o + 64, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int32_t *p = (const int32_t *)src; int32_t *o = (int32_t *)dst;
          int32x2x2_t a = vld2_s32(p); int32x2x2_t b = vld1_s32_x2(p + 1); int32x2x2_t c = vld2_dup_s32(p + 3);
          int32x2x2_t d = vld2_lane_s32(p + 5, a, 1);
          vst2_s32(o, d); vst1_s32_x2(o + 4, c); vst2_lane_s32(o + 8, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int32_t *p = (const int32_t *)src; int32_t *o = (int32_t *)dst;
          int32x2x3_t a = vld3_s32(p); int32x2x3_t b = vld1_s32_x3(p + 1); int32x2x3_t c = vld3_dup_s32(p + 3);
          int32x2x3_t d = vld3_lane_s32(p + 5, a, 1);
          vst3_s32(o, d); vst1_s32_x3(o + 6, c); vst3_lane_s32(o + 12, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int32_t *p = (const int32_t *)src; int32_t *o = (int32_t *)dst;
          int32x2x4_t a = vld4_s32(p); int32x2x4_t b = vld1_s32_x4(p + 1); int32x2x4_t c = vld4_dup_s32(p + 3);
          int32x2x4_t d = vld4_lane_s32(p + 5, a, 1);
          vst4_s32(o, d); vst1_s32_x4(o + 8, c); vst4_lane_s32(o + 16, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int32_t *p = (const int32_t *)src; int32_t *o = (int32_t *)dst;
          int32x4x2_t a = vld2q_s32(p); int32x4x2_t b = vld1q_s32_x2(p + 1); int32x4x2_t c = vld2q_dup_s32(p + 3);
          int32x4x2_t d = vld2q_lane_s32(p + 5, a, 3);
          vst2q_s32(o, d); vst1q_s32_x2(o + 8, c); vst2q_lane_s32(o + 16, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int32_t *p = (const int32_t *)src; int32_t *o = (int32_t *)dst;
          int32x4x3_t a = vld3q_s32(p); int32x4x3_t b = vld1q_s32_x3(p + 1); int32x4x3_t c = vld3q_dup_s32(p + 3);
          int32x4x3_t d = vld3q_lane_s32(p + 5, a, 3);
          vst3q_s32(o, d); vst1q_s32_x3(o + 12, c); vst3q_lane_s32(o + 24, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int32_t *p = (const int32_t *)src; int32_t *o = (int32_t *)dst;
          int32x4x4_t a = vld4q_s32(p); int32x4x4_t b = vld1q_s32_x4(p + 1); int32x4x4_t c = vld4q_dup_s32(p + 3);
          int32x4x4_t d = vld4q_lane_s32(p + 5, a, 3);
          vst4q_s32(o, d); vst1q_s32_x4(o + 16, c); vst4q_lane_s32(o + 32, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint32_t *p = (const uint32_t *)src; uint32_t *o = (uint32_t *)dst;
          uint32x2x2_t a = vld2_u32(p); uint32x2x2_t b = vld1_u32_x2(p + 1); uint32x2x2_t c = vld2_dup_u32(p + 3);
          uint32x2x2_t d = vld2_lane_u32(p + 5, a, 1);
          vst2_u32(o, d); vst1_u32_x2(o + 4, c); vst2_lane_u32(o + 8, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint32_t *p = (const uint32_t *)src; uint32_t *o = (uint32_t *)dst;
          uint32x2x3_t a = vld3_u32(p); uint32x2x3_t b = vld1_u32_x3(p + 1); uint32x2x3_t c = vld3_dup_u32(p + 3);
          uint32x2x3_t d = vld3_lane_u32(p + 5, a, 1);
          vst3_u32(o, d); vst1_u32_x3(o + 6, c); vst3_lane_u32(o + 12, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint32_t *p = (const uint32_t *)src; uint32_t *o = (uint32_t *)dst;
          uint32x2x4_t a = vld4_u32(p); uint32x2x4_t b = vld1_u32_x4(p + 1); uint32x2x4_t c = vld4_dup_u32(p + 3);
          uint32x2x4_t d = vld4_lane_u32(p + 5, a, 1);
          vst4_u32(o, d); vst1_u32_x4(o + 8, c); vst4_lane_u32(o + 16, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint32_t *p = (const uint32_t *)src; uint32_t *o = (uint32_t *)dst;
          uint32x4x2_t a = vld2q_u32(p); uint32x4x2_t b = vld1q_u32_x2(p + 1); uint32x4x2_t c = vld2q_dup_u32(p + 3);
          uint32x4x2_t d = vld2q_lane_u32(p + 5, a, 3);
          vst2q_u32(o, d); vst1q_u32_x2(o + 8, c); vst2q_lane_u32(o + 16, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint32_t *p = (const uint32_t *)src; uint32_t *o = (uint32_t *)dst;
          uint32x4x3_t a = vld3q_u32(p); uint32x4x3_t b = vld1q_u32_x3(p + 1); uint32x4x3_t c = vld3q_dup_u32(p + 3);
          uint32x4x3_t d = vld3q_lane_u32(p + 5, a, 3);
          vst3q_u32(o, d); vst1q_u32_x3(o + 12, c); vst3q_lane_u32(o + 24, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint32_t *p = (const uint32_t *)src; uint32_t *o = (uint32_t *)dst;
          uint32x4x4_t a = vld4q_u32(p); uint32x4x4_t b = vld1q_u32_x4(p + 1); uint32x4x4_t c = vld4q_dup_u32(p + 3);
          uint32x4x4_t d = vld4q_lane_u32(p + 5, a, 3);
          vst4q_u32(o, d); vst1q_u32_x4(o + 16, c); vst4q_lane_u32(o + 32, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const float32_t *p = (const float32_t *)src; float32_t *o = (float32_t *)dst;
          float32x2x2_t a = vld2_f32(p); float32x2x2_t b = vld1_f32_x2(p + 1); float32x2x2_t c = vld2_dup_f32(p + 3);
          float32x2x2_t d = vld2_lane_f32(p + 5, a, 1);
          vst2_f32(o, d); vst1_f32_x2(o + 4, c); vst2_lane_f32(o + 8, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const float32_t *p = (const float32_t *)src; float32_t *o = (float32_t *)dst;
          float32x2x3_t a = vld3_f32(p); float32x2x3_t b = vld1_f32_x3(p + 1); float32x2x3_t c = vld3_dup_f32(p + 3);
          float32x2x3_t d = vld3_lane_f32(p + 5, a, 1);
          vst3_f32(o, d); vst1_f32_x3(o + 6, c); vst3_lane_f32(o + 12, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const float32_t *p = (const float32_t *)src; float32_t *o = (float32_t *)dst;
          float32x2x4_t a = vld4_f32(p); float32x2x4_t b = vld1_f32_x4(p + 1); float32x2x4_t c = vld4_dup_f32(p + 3);
          float32x2x4_t d = vld4_lane_f32(p + 5, a, 1);
          vst4_f32(o, d); vst1_f32_x4(o + 8, c); vst4_lane_f32(o + 16, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const float32_t *p = (const float32_t *)src; float32_t *o = (float32_t *)dst;
          float32x4x2_t a = vld2q_f32(p); float32x4x2_t b = vld1q_f32_x2(p + 1); float32x4x2_t c = vld2q_dup_f32(p + 3);
          float32x4x2_t d = vld2q_lane_f32(p + 5, a, 3);
          vst2q_f32(o, d); vst1q_f32_x2(o + 8, c); vst2q_lane_f32(o + 16, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const float32_t *p = (const float32_t *)src; float32_t *o = (float32_t *)dst;
          float32x4x3_t a = vld3q_f32(p); float32x4x3_t b = vld1q_f32_x3(p + 1); float32x4x3_t c = vld3q_dup_f32(p + 3);
          float32x4x3_t d = vld3q_lane_f32(p + 5, a, 3);
          vst3q_f32(o, d); vst1q_f32_x3(o + 12, c); vst3q_lane_f32(o + 24, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const float32_t *p = (const float32_t *)src; float32_t *o = (float32_t *)dst;
          float32x4x4_t a = vld4q_f32(p); float32x4x4_t b = vld1q_f32_x4(p + 1); float32x4x4_t c = vld4q_dup_f32(p + 3);
          float32x4x4_t d = vld4q_lane_f32(p + 5, a, 3);
          vst4q_f32(o, d); vst1q_f32_x4(o + 16, c); vst4q_lane_f32(o + 32, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int64_t *p = (const int64_t *)src; int64_t *o = (int64_t *)dst;
          int64x1x2_t a = vld2_s64(p); int64x1x2_t b = vld1_s64_x2(p + 1); int64x1x2_t c = vld2_dup_s64(p + 3);
          int64x1x2_t d = vld2_lane_s64(p + 5, a, 0);
          vst2_s64(o, d); vst1_s64_x2(o + 2, c); vst2_lane_s64(o + 4, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int64_t *p = (const int64_t *)src; int64_t *o = (int64_t *)dst;
          int64x1x3_t a = vld3_s64(p); int64x1x3_t b = vld1_s64_x3(p + 1); int64x1x3_t c = vld3_dup_s64(p + 3);
          int64x1x3_t d = vld3_lane_s64(p + 5, a, 0);
          vst3_s64(o, d); vst1_s64_x3(o + 3, c); vst3_lane_s64(o + 6, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int64_t *p = (const int64_t *)src; int64_t *o = (int64_t *)dst;
          int64x1x4_t a = vld4_s64(p); int64x1x4_t b = vld1_s64_x4(p + 1); int64x1x4_t c = vld4_dup_s64(p + 3);
          int64x1x4_t d = vld4_lane_s64(p + 5, a, 0);
          vst4_s64(o, d); vst1_s64_x4(o + 4, c); vst4_lane_s64(o + 8, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int64_t *p = (const int64_t *)src; int64_t *o = (int64_t *)dst;
          int64x2x2_t a = vld2q_s64(p); int64x2x2_t b = vld1q_s64_x2(p + 1); int64x2x2_t c = vld2q_dup_s64(p + 3);
          int64x2x2_t d = vld2q_lane_s64(p + 5, a, 1);
          vst2q_s64(o, d); vst1q_s64_x2(o + 4, c); vst2q_lane_s64(o + 8, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int64_t *p = (const int64_t *)src; int64_t *o = (int64_t *)dst;
          int64x2x3_t a = vld3q_s64(p); int64x2x3_t b = vld1q_s64_x3(p + 1); int64x2x3_t c = vld3q_dup_s64(p + 3);
          int64x2x3_t d = vld3q_lane_s64(p + 5, a, 1);
          vst3q_s64(o, d); vst1q_s64_x3(o + 6, c); vst3q_lane_s64(o + 12, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const int64_t *p = (const int64_t *)src; int64_t *o = (int64_t *)dst;
          int64x2x4_t a = vld4q_s64(p); int64x2x4_t b = vld1q_s64_x4(p + 1); int64x2x4_t c = vld4q_dup_s64(p + 3);
          int64x2x4_t d = vld4q_lane_s64(p + 5, a, 1);
          vst4q_s64(o, d); vst1q_s64_x4(o + 8, c); vst4q_lane_s64(o + 16, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint64_t *p = (const uint64_t *)src; uint64_t *o = (uint64_t *)dst;
          uint64x1x2_t a = vld2_u64(p); uint64x1x2_t b = vld1_u64_x2(p + 1); uint64x1x2_t c = vld2_dup_u64(p + 3);
          uint64x1x2_t d = vld2_lane_u64(p + 5, a, 0);
          vst2_u64(o, d); vst1_u64_x2(o + 2, c); vst2_lane_u64(o + 4, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint64_t *p = (const uint64_t *)src; uint64_t *o = (uint64_t *)dst;
          uint64x1x3_t a = vld3_u64(p); uint64x1x3_t b = vld1_u64_x3(p + 1); uint64x1x3_t c = vld3_dup_u64(p + 3);
          uint64x1x3_t d = vld3_lane_u64(p + 5, a, 0);
          vst3_u64(o, d); vst1_u64_x3(o + 3, c); vst3_lane_u64(o + 6, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint64_t *p = (const uint64_t *)src; uint64_t *o = (uint64_t *)dst;
          uint64x1x4_t a = vld4_u64(p); uint64x1x4_t b = vld1_u64_x4(p + 1); uint64x1x4_t c = vld4_dup_u64(p + 3);
          uint64x1x4_t d = vld4_lane_u64(p + 5, a, 0);
          vst4_u64(o, d); vst1_u64_x4(o + 4, c); vst4_lane_u64(o + 8, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint64_t *p = (const uint64_t *)src; uint64_t *o = (uint64_t *)dst;
          uint64x2x2_t a = vld2q_u64(p); uint64x2x2_t b = vld1q_u64_x2(p + 1); uint64x2x2_t c = vld2q_dup_u64(p + 3);
          uint64x2x2_t d = vld2q_lane_u64(p + 5, a, 1);
          vst2q_u64(o, d); vst1q_u64_x2(o + 4, c); vst2q_lane_u64(o + 8, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint64_t *p = (const uint64_t *)src; uint64_t *o = (uint64_t *)dst;
          uint64x2x3_t a = vld3q_u64(p); uint64x2x3_t b = vld1q_u64_x3(p + 1); uint64x2x3_t c = vld3q_dup_u64(p + 3);
          uint64x2x3_t d = vld3q_lane_u64(p + 5, a, 1);
          vst3q_u64(o, d); vst1q_u64_x3(o + 6, c); vst3q_lane_u64(o + 12, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const uint64_t *p = (const uint64_t *)src; uint64_t *o = (uint64_t *)dst;
          uint64x2x4_t a = vld4q_u64(p); uint64x2x4_t b = vld1q_u64_x4(p + 1); uint64x2x4_t c = vld4q_dup_u64(p + 3);
          uint64x2x4_t d = vld4q_lane_u64(p + 5, a, 1);
          vst4q_u64(o, d); vst1q_u64_x4(o + 8, c); vst4q_lane_u64(o + 16, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly64_t *p = (const poly64_t *)src; poly64_t *o = (poly64_t *)dst;
          poly64x1x2_t a = vld2_p64(p); poly64x1x2_t b = vld1_p64_x2(p + 1); poly64x1x2_t c = vld2_dup_p64(p + 3);
          poly64x1x2_t d = vld2_lane_p64(p + 5, a, 0);
          vst2_p64(o, d); vst1_p64_x2(o + 2, c); vst2_lane_p64(o + 4, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly64_t *p = (const poly64_t *)src; poly64_t *o = (poly64_t *)dst;
          poly64x1x3_t a = vld3_p64(p); poly64x1x3_t b = vld1_p64_x3(p + 1); poly64x1x3_t c = vld3_dup_p64(p + 3);
          poly64x1x3_t d = vld3_lane_p64(p + 5, a, 0);
          vst3_p64(o, d); vst1_p64_x3(o + 3, c); vst3_lane_p64(o + 6, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly64_t *p = (const poly64_t *)src; poly64_t *o = (poly64_t *)dst;
          poly64x1x4_t a = vld4_p64(p); poly64x1x4_t b = vld1_p64_x4(p + 1); poly64x1x4_t c = vld4_dup_p64(p + 3);
          poly64x1x4_t d = vld4_lane_p64(p + 5, a, 0);
          vst4_p64(o, d); vst1_p64_x4(o + 4, c); vst4_lane_p64(o + 8, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly64_t *p = (const poly64_t *)src; poly64_t *o = (poly64_t *)dst;
          poly64x2x2_t a = vld2q_p64(p); poly64x2x2_t b = vld1q_p64_x2(p + 1); poly64x2x2_t c = vld2q_dup_p64(p + 3);
          poly64x2x2_t d = vld2q_lane_p64(p + 5, a, 1);
          vst2q_p64(o, d); vst1q_p64_x2(o + 4, c); vst2q_lane_p64(o + 8, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly64_t *p = (const poly64_t *)src; poly64_t *o = (poly64_t *)dst;
          poly64x2x3_t a = vld3q_p64(p); poly64x2x3_t b = vld1q_p64_x3(p + 1); poly64x2x3_t c = vld3q_dup_p64(p + 3);
          poly64x2x3_t d = vld3q_lane_p64(p + 5, a, 1);
          vst3q_p64(o, d); vst1q_p64_x3(o + 6, c); vst3q_lane_p64(o + 12, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const poly64_t *p = (const poly64_t *)src; poly64_t *o = (poly64_t *)dst;
          poly64x2x4_t a = vld4q_p64(p); poly64x2x4_t b = vld1q_p64_x4(p + 1); poly64x2x4_t c = vld4q_dup_p64(p + 3);
          poly64x2x4_t d = vld4q_lane_p64(p + 5, a, 1);
          vst4q_p64(o, d); vst1q_p64_x4(o + 8, c); vst4q_lane_p64(o + 16, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const float64_t *p = (const float64_t *)src; float64_t *o = (float64_t *)dst;
          float64x1x2_t a = vld2_f64(p); float64x1x2_t b = vld1_f64_x2(p + 1); float64x1x2_t c = vld2_dup_f64(p + 3);
          float64x1x2_t d = vld2_lane_f64(p + 5, a, 0);
          vst2_f64(o, d); vst1_f64_x2(o + 2, c); vst2_lane_f64(o + 4, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const float64_t *p = (const float64_t *)src; float64_t *o = (float64_t *)dst;
          float64x1x3_t a = vld3_f64(p); float64x1x3_t b = vld1_f64_x3(p + 1); float64x1x3_t c = vld3_dup_f64(p + 3);
          float64x1x3_t d = vld3_lane_f64(p + 5, a, 0);
          vst3_f64(o, d); vst1_f64_x3(o + 3, c); vst3_lane_f64(o + 6, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const float64_t *p = (const float64_t *)src; float64_t *o = (float64_t *)dst;
          float64x1x4_t a = vld4_f64(p); float64x1x4_t b = vld1_f64_x4(p + 1); float64x1x4_t c = vld4_dup_f64(p + 3);
          float64x1x4_t d = vld4_lane_f64(p + 5, a, 0);
          vst4_f64(o, d); vst1_f64_x4(o + 4, c); vst4_lane_f64(o + 8, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const float64_t *p = (const float64_t *)src; float64_t *o = (float64_t *)dst;
          float64x2x2_t a = vld2q_f64(p); float64x2x2_t b = vld1q_f64_x2(p + 1); float64x2x2_t c = vld2q_dup_f64(p + 3);
          float64x2x2_t d = vld2q_lane_f64(p + 5, a, 1);
          vst2q_f64(o, d); vst1q_f64_x2(o + 4, c); vst2q_lane_f64(o + 8, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const float64_t *p = (const float64_t *)src; float64_t *o = (float64_t *)dst;
          float64x2x3_t a = vld3q_f64(p); float64x2x3_t b = vld1q_f64_x3(p + 1); float64x2x3_t c = vld3q_dup_f64(p + 3);
          float64x2x3_t d = vld3q_lane_f64(p + 5, a, 1);
          vst3q_f64(o, d); vst1q_f64_x3(o + 6, c); vst3q_lane_f64(o + 12, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
        { const float64_t *p = (const float64_t *)src; float64_t *o = (float64_t *)dst;
          float64x2x4_t a = vld4q_f64(p); float64x2x4_t b = vld1q_f64_x4(p + 1); float64x2x4_t c = vld4q_dup_f64(p + 3);
          float64x2x4_t d = vld4q_lane_f64(p + 5, a, 1);
          vst4q_f64(o, d); vst1q_f64_x4(o + 8, c); vst4q_lane_f64(o + 16, b, 0);
          mix(dst, sizeof dst); MIX(a); MIX(b); }
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
