/* <arm_neon.h> vqtbl2 to vqtbl4 and vqtbx2 to vqtbx4 on both widths and every
 * byte type, and the 64-bit-table vtbl1 to vtbl4 and vtbx1 to vtbx4, over
 * seeded tables with indices in and past them: the result bits hash to
 * what AArch64 hardware gives. Elsewhere the unit is empty. */
#if defined(__aarch64__)
#define EXPECTED 0x2d530e23f1b8535bull
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
static uint8x16_t u8v(void) { uint8x16_t v; for (int i = 0; i < 16; i++) v[i] = (uint8_t)rnd(); return v; }
static uint8x16_t idxv(void) { uint8x16_t v; for (int i = 0; i < 16; i++) { uint64_t r = rnd(); v[i] = (r & 3) == 0 ? (uint8_t)(r >> 8) : (uint8_t)((r >> 8) % 70); } return v; }
int main(void) {
    int n = 1000;
    for (int it = 0; it < n; it++) {
        uint8x16x4_t t = {{u8v(), u8v(), u8v(), u8v()}}; uint8x16_t i = idxv(), d = u8v();
        uint8x16x2_t t2 = {{t.val[0], t.val[1]}}; uint8x16x3_t t3 = {{t.val[0], t.val[1], t.val[2]}};
        uint8x16_t a1 = vqtbl2q_u8(t2, i), a2 = vqtbl3q_u8(t3, i), a3 = vqtbl4q_u8(t, i);
        uint8x16_t a4 = vqtbx2q_u8(d, t2, i), a5 = vqtbx3q_u8(d, t3, i), a6 = vqtbx4q_u8(d, t, i);
        uint8x8_t il = vget_low_u8(i), dl = vget_low_u8(d);
        uint8x8_t b1 = vqtbl2_u8(t2, il), b2 = vqtbl4_u8(t, il), b3 = vqtbx3_u8(dl, t3, il);
        int8x16x2_t s2 = {{vreinterpretq_s8_u8(t.val[0]), vreinterpretq_s8_u8(t.val[3])}};
        int8x16_t b4 = vqtbx2q_s8(vreinterpretq_s8_u8(d), s2, i);
        uint8x8x4_t e = {{vget_low_u8(t.val[0]), vget_high_u8(t.val[1]), vget_low_u8(t.val[2]), vget_high_u8(t.val[3])}};
        uint8x8x2_t e2 = {{e.val[0], e.val[1]}}; uint8x8x3_t e3 = {{e.val[0], e.val[1], e.val[2]}};
        uint8x8_t c1 = vtbl1_u8(e.val[0], il), c2 = vtbl2_u8(e2, il), c3 = vtbl3_u8(e3, il), c4 = vtbl4_u8(e, il);
        uint8x8_t c5 = vtbx1_u8(dl, e.val[1], il), c6 = vtbx2_u8(dl, e2, il), c7 = vtbx3_u8(dl, e3, il), c8 = vtbx4_u8(dl, e, il);
        int8x8_t c9 = vtbx3_s8(vreinterpret_s8_u8(dl), (int8x8x3_t){{vreinterpret_s8_u8(e.val[0]), vreinterpret_s8_u8(e.val[1]), vreinterpret_s8_u8(e.val[2])}}, vreinterpret_s8_u8(il));
        poly8x8_t c10 = vtbl2_p8((poly8x8x2_t){{vreinterpret_p8_u8(e.val[2]), vreinterpret_p8_u8(e.val[3])}}, il);
        MIX(a1); MIX(a2); MIX(a3); MIX(a4); MIX(a5); MIX(a6); MIX(b1); MIX(b2); MIX(b3); MIX(b4);
        MIX(c1); MIX(c2); MIX(c3); MIX(c4); MIX(c5); MIX(c6); MIX(c7); MIX(c8); MIX(c9); MIX(c10);
    }
    return h == EXPECTED ? 0 : 1;
}
#else
int main(void) {
    return 0;
}
#endif
