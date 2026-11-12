/* <arm_neon.h> shifts by an immediate the shift-only rows did not cover:
 * the saturating left shifts (vqshl_n), the rounding right shifts
 * (vrshr_n) and the right shifts that narrow (vshrn_n, vrshrn_n), at the
 * ends of their count ranges and on lanes that saturate or round up: each
 * result checked against the operation computed lane by lane in C. The
 * exit code has a bit per failing group; elsewhere than AArch64 the unit
 * is empty. */
#if defined(__aarch64__)
#include <arm_neon.h>
#include <string.h>
static const unsigned char A[16] = {0x80, 0x7f, 0xff, 0x01, 0x00, 0x55, 0xaa, 0x12, 0x34, 0xfe, 0x81, 0x7e, 0x02, 0xfd, 0x40, 0xc0};
static long long sat(long long x, long long lo, long long hi) { return x < lo ? lo : x > hi ? hi : x; }
int main(void) {
    int bad = 0;
    int8_t s8[16]; uint8_t u8[16]; int16_t s16[8]; uint16_t u16[8]; uint32_t u32[4]; int64_t s64[2];
    memcpy(s8, A, 16); memcpy(u8, A, 16); memcpy(s16, A, 16); memcpy(u16, A, 16); memcpy(u32, A, 16); memcpy(s64, A, 16);
    int8x16_t vs8; uint8x16_t vu8; int16x8_t vs16; uint16x8_t vu16; uint32x4_t vu32; int64x2_t vs64;
    memcpy(&vs8, A, 16); memcpy(&vu8, A, 16); memcpy(&vs16, A, 16); memcpy(&vu16, A, 16); memcpy(&vu32, A, 16); memcpy(&vs64, A, 16);
    int8x16_t a = vqshlq_n_s8(vs8, 3); uint8x16_t b = vqshlq_n_u8(vu8, 2);
    int8x16_t c = vrshrq_n_s8(vs8, 3); uint16x8_t d = vrshrq_n_u16(vu16, 16);
    for (int i = 0; i < 16; i++) {
        bad |= a[i] != (int8_t)sat((long long)s8[i] * 8, -128, 127);
        bad |= (b[i] != (uint8_t)sat((long long)u8[i] * 4, 0, 255)) << 1;
        bad |= (c[i] != (int8_t)((s8[i] + 4) >> 3)) << 2;
        if (i < 8) bad |= (d[i] != (uint16_t)(((uint32_t)u16[i] + 0x8000) >> 16)) << 3;
    }
    int8x8_t e = vshrn_n_s16(vs16, 3); uint16x4_t f = vrshrn_n_u32(vu32, 16);
    for (int i = 0; i < 8; i++) bad |= (e[i] != (int8_t)(s16[i] >> 3)) << 4;
    for (int i = 0; i < 4; i++) bad |= (f[i] != (uint16_t)(((uint64_t)u32[i] + 0x8000) >> 16)) << 5;
    int64x2_t g = vqshlq_n_s64(vs64, 1);
    for (int i = 0; i < 2; i++) bad |= (g[i] != (s64[i] > 0x3fffffffffffffffLL ? 0x7fffffffffffffffLL : s64[i] < -0x4000000000000000LL ? (long long)0x8000000000000000ULL : s64[i] * 2)) << 6;
    return bad;
}
#else
int main(void) { return 0; }
#endif
