/* The 32- and 64-bit lane NEON intrinsics and the structure loads, each
 * checked against the result the Arm ARM defines for its instruction: a
 * model over the lanes, on fixed patterns. The exit code is the line of the
 * first mismatch; elsewhere than AArch64 the unit is empty. */
#ifdef __aarch64__
#include <arm_neon.h>
#include <string.h>

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

int main(void) {
    uint8_t bytes[64];
    for (int k = 0; k < 64; k++)
        bytes[k] = (uint8_t)(k * 37 + 11);

    uint8_t out8[8];
    vst1_u8(out8, vld1_u8(bytes + 3));
    CHECK(memcmp(out8, bytes + 3, 8) == 0);

    uint32x2_t d = vdup_n_u32(0x89ABCDEFu);
    CHECK(d[0] == 0x89ABCDEFu && d[1] == 0x89ABCDEFu);
    uint64x2_t q = vdupq_n_u64(0x0123456789ABCDEFull);
    CHECK(q[0] == 0x0123456789ABCDEFull && q[1] == q[0]);

    uint64x2_t s = vaddq_u64(q, (uint64x2_t){~0ull, 1});
    CHECK(s[0] == 0x0123456789ABCDEEull && s[1] == 0x0123456789ABCDF0ull);

    uint32x4_t a = {0xFFFFFFFFu, 3, 0x10000u, 7};
    uint32x4_t b = {2, 0x80000000u, 0x10000u, 9};
    uint32x4_t m = vmulq_u32(a, b);
    CHECK(m[0] == 0xFFFFFFFEu && m[1] == 0x80000000u && m[2] == 0 && m[3] == 63);

    uint32x2_t lo = vget_low_u32(a), hi = vget_high_u32(a);
    CHECK(lo[0] == a[0] && lo[1] == a[1] && hi[0] == a[2] && hi[1] == a[3]);

    uint64x2_t acc = {5, 6};
    uint64x2_t w = vmlal_u32(acc, lo, vget_low_u32(b));
    CHECK(w[0] == 5 + 0xFFFFFFFFull * 2 && w[1] == 6 + 3ull * 0x80000000u);
    uint64x2_t wh = vmlal_high_u32(acc, a, b);
    CHECK(wh[0] == 5 + 0x100000000ull && wh[1] == 6 + 63);

    uint64x2_t wide = {0x1122334455667788ull, 0x99AABBCCDDEEFF00ull};
    uint32x2_t n = vmovn_u64(wide);
    CHECK(n[0] == 0x55667788u && n[1] == 0xDDEEFF00u);
    uint32x2_t sn = vshrn_n_u64(wide, 32);
    CHECK(sn[0] == 0x11223344u && sn[1] == 0x99AABBCCu);
    uint64x2_t sr = vshrq_n_u64(wide, 60);
    CHECK(sr[0] == 1 && sr[1] == 9);

    uint8x8_t x = {0x0F, 0xF0, 0x33, 0xCC, 0x55, 0xAA, 0x00, 0xFF};
    uint8x8_t y = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08};
    uint8x8_t sli = vsli_n_u8(x, y, 4);
    for (int i = 0; i < 8; i++)
        CHECK(sli[i] == (uint8_t)((y[i] << 4) | (x[i] & 0x0F)));
    uint8x16_t xq = vld1q_u8(bytes), yq = vld1q_u8(bytes + 16);
    uint8x16_t sri = vsriq_n_u8(xq, yq, 3);
    for (int i = 0; i < 16; i++)
        CHECK(sri[i] == (uint8_t)((yq[i] >> 3) | (xq[i] & 0xE0)));

    uint32x4x2_t uz = vuzpq_u32(a, b);
    CHECK(uz.val[0][0] == a[0] && uz.val[0][1] == a[2] && uz.val[0][2] == b[0] &&
          uz.val[0][3] == b[2]);
    CHECK(uz.val[1][0] == a[1] && uz.val[1][1] == a[3] && uz.val[1][2] == b[1] &&
          uz.val[1][3] == b[3]);

    uint16_t halves[16];
    memcpy(halves, bytes, sizeof halves);
    uint16x8x2_t two = vld2q_u16(halves);
    for (int i = 0; i < 8; i++)
        CHECK(two.val[0][i] == halves[2 * i] && two.val[1][i] == halves[2 * i + 1]);
    uint8x16x4_t four = vld4q_u8(bytes);
    for (int i = 0; i < 16; i++)
        for (int k = 0; k < 4; k++)
            CHECK(four.val[k][i] == bytes[4 * i + k]);

    uint64x2_t r64 = vreinterpretq_u64_u32(a);
    CHECK(r64[0] == (0x3ull << 32 | 0xFFFFFFFFu));
    uint32x4_t r32 = vreinterpretq_u32_u64(r64);
    CHECK(r32[1] == 3);
    uint8x16_t r8 = vreinterpretq_u8_u16(two.val[0]);
    CHECK(r8[0] == bytes[0] && r8[1] == bytes[1] && r8[2] == bytes[4]);
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif
