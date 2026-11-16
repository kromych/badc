/* <arm_neon.h> widening and narrowing operations on every element type
 * they are defined for: the long sum, difference, product and absolute
 * difference of two narrow vectors and their _high forms, the wide sum and
 * difference, the long multiply- and absolute-difference-accumulates, the
 * lengthening move, and the truncating and saturating narrowings, each
 * lane checked against the operation computed on the wide type, modulo its
 * width. The exit code has a bit per failing element type; elsewhere than
 * AArch64 the unit is empty. */
#if defined(__aarch64__)
#include <arm_neon.h>
#include <string.h>

static const unsigned char A[16] = {0x80, 0x7f, 0xff, 0x01, 0x00, 0x55, 0xaa, 0x12,
                                    0x34, 0xfe, 0x81, 0x7e, 0x02, 0xfd, 0x40, 0xc0};
static const unsigned char B[16] = {0x7f, 0x80, 0x01, 0xff, 0x00, 0xaa, 0x55, 0x21,
                                    0x43, 0x02, 0x7f, 0x81, 0xfe, 0x03, 0xc0, 0x40};
static const unsigned char C[16] = {0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
                                    0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x00};

/* |x - y| of two narrow lanes, as the wide type. */
static uint16_t abd_s8(int16_t x, int16_t y) { return x > y ? (uint16_t)x - (uint16_t)y : (uint16_t)y - (uint16_t)x; }

static int check_s8(void) {
    int8_t a[8], b[8], aq[16], bq[16];
    int16_t w[8], c[8];
    memcpy(a, A, 8); memcpy(b, B, 8); memcpy(aq, A, 16); memcpy(bq, B, 16);
    memcpy(w, C, 16); memcpy(c, B, 16);
    int8x8_t va, vb;
    int8x16_t vaq, vbq;
    int16x8_t vw, vc, r[19];
    memcpy(&va, a, 8); memcpy(&vb, b, 8); memcpy(&vaq, aq, 16); memcpy(&vbq, bq, 16);
    memcpy(&vw, w, 16); memcpy(&vc, c, 16);
    r[0] = vaddl_s8(va, vb); r[1] = vaddl_high_s8(vaq, vbq);
    r[2] = vsubl_s8(va, vb); r[3] = vsubl_high_s8(vaq, vbq);
    r[4] = vmull_s8(va, vb); r[5] = vmull_high_s8(vaq, vbq);
    r[6] = vabdl_s8(va, vb); r[7] = vabdl_high_s8(vaq, vbq);
    r[8] = vaddw_s8(vw, va); r[9] = vaddw_high_s8(vw, vbq);
    r[10] = vsubw_s8(vw, va); r[11] = vsubw_high_s8(vw, vbq);
    r[12] = vmlal_s8(vc, va, vb); r[13] = vmlal_high_s8(vc, vaq, vbq);
    r[14] = vmlsl_s8(vc, va, vb); r[15] = vmlsl_high_s8(vc, vaq, vbq);
    r[16] = vabal_s8(vc, va, vb); r[17] = vabal_high_s8(vc, vaq, vbq);
    r[18] = vmovl_s8(va);
    for (int i = 0; i < 8; i++) {
        uint16_t x = (uint16_t)(int16_t)a[i], y = (uint16_t)(int16_t)b[i];
        uint16_t hx = (uint16_t)(int16_t)aq[i + 8], hy = (uint16_t)(int16_t)bq[i + 8];
        uint16_t cw = (uint16_t)c[i], ww = (uint16_t)w[i];
        uint16_t e[19] = {
            x + y, hx + hy, x - y, hx - hy, x * y, hx * hy,
            abd_s8(a[i], b[i]), abd_s8(aq[i + 8], bq[i + 8]),
            ww + x, ww + hy, ww - x, ww - hy,
            cw + x * y, cw + hx * hy, cw - x * y, cw - hx * hy,
            cw + abd_s8(a[i], b[i]), cw + abd_s8(aq[i + 8], bq[i + 8]),
            x,
        };
        for (int k = 0; k < 19; k++) {
            uint16_t got;
            memcpy(&got, (char *)&r[k] + i * sizeof got, sizeof got);
            if (got != (uint16_t)e[k]) return 1;
        }
    }
    int8x8_t n0 = vmovn_s16(vw), n1 = vqmovn_s16(vw);
    int8_t g0[8], g1[8];
    memcpy(g0, &n0, 8); memcpy(g1, &n1, 8);
    for (int i = 0; i < 8; i++) {
        int16_t v = w[i];
        int8_t sat = v < (int16_t)-128LL ? (int8_t)-128LL : v > (int16_t)127LL ? (int8_t)127LL : (int8_t)v;
        if (g0[i] != (int8_t)((uint16_t)v) || g1[i] != sat) return 1;
    }
    uint8x8_t n2 = vqmovun_s16(vw);
    uint8_t g2[8];
    memcpy(g2, &n2, 8);
    for (int i = 0; i < 8; i++) {
        int16_t v = w[i];
        uint8_t sat = v < 0 ? 0 : v > (int16_t)255LL ? (uint8_t)255ULL : (uint8_t)v;
        if (g2[i] != sat) return 1;
    }
    return 0;
}

/* |x - y| of two narrow lanes, as the wide type. */
static uint16_t abd_u8(uint16_t x, uint16_t y) { return x > y ? (uint16_t)x - (uint16_t)y : (uint16_t)y - (uint16_t)x; }

static int check_u8(void) {
    uint8_t a[8], b[8], aq[16], bq[16];
    uint16_t w[8], c[8];
    memcpy(a, A, 8); memcpy(b, B, 8); memcpy(aq, A, 16); memcpy(bq, B, 16);
    memcpy(w, C, 16); memcpy(c, B, 16);
    uint8x8_t va, vb;
    uint8x16_t vaq, vbq;
    uint16x8_t vw, vc, r[19];
    memcpy(&va, a, 8); memcpy(&vb, b, 8); memcpy(&vaq, aq, 16); memcpy(&vbq, bq, 16);
    memcpy(&vw, w, 16); memcpy(&vc, c, 16);
    r[0] = vaddl_u8(va, vb); r[1] = vaddl_high_u8(vaq, vbq);
    r[2] = vsubl_u8(va, vb); r[3] = vsubl_high_u8(vaq, vbq);
    r[4] = vmull_u8(va, vb); r[5] = vmull_high_u8(vaq, vbq);
    r[6] = vabdl_u8(va, vb); r[7] = vabdl_high_u8(vaq, vbq);
    r[8] = vaddw_u8(vw, va); r[9] = vaddw_high_u8(vw, vbq);
    r[10] = vsubw_u8(vw, va); r[11] = vsubw_high_u8(vw, vbq);
    r[12] = vmlal_u8(vc, va, vb); r[13] = vmlal_high_u8(vc, vaq, vbq);
    r[14] = vmlsl_u8(vc, va, vb); r[15] = vmlsl_high_u8(vc, vaq, vbq);
    r[16] = vabal_u8(vc, va, vb); r[17] = vabal_high_u8(vc, vaq, vbq);
    r[18] = vmovl_u8(va);
    for (int i = 0; i < 8; i++) {
        uint16_t x = (uint16_t)(uint16_t)a[i], y = (uint16_t)(uint16_t)b[i];
        uint16_t hx = (uint16_t)(uint16_t)aq[i + 8], hy = (uint16_t)(uint16_t)bq[i + 8];
        uint16_t cw = (uint16_t)c[i], ww = (uint16_t)w[i];
        uint16_t e[19] = {
            x + y, hx + hy, x - y, hx - hy, x * y, hx * hy,
            abd_u8(a[i], b[i]), abd_u8(aq[i + 8], bq[i + 8]),
            ww + x, ww + hy, ww - x, ww - hy,
            cw + x * y, cw + hx * hy, cw - x * y, cw - hx * hy,
            cw + abd_u8(a[i], b[i]), cw + abd_u8(aq[i + 8], bq[i + 8]),
            x,
        };
        for (int k = 0; k < 19; k++) {
            uint16_t got;
            memcpy(&got, (char *)&r[k] + i * sizeof got, sizeof got);
            if (got != (uint16_t)e[k]) return 1;
        }
    }
    uint8x8_t n0 = vmovn_u16(vw), n1 = vqmovn_u16(vw);
    uint8_t g0[8], g1[8];
    memcpy(g0, &n0, 8); memcpy(g1, &n1, 8);
    for (int i = 0; i < 8; i++) {
        uint16_t v = w[i];
        uint8_t sat = v < (uint16_t)0 ? (uint8_t)0 : v > (uint16_t)255ULL ? (uint8_t)255ULL : (uint8_t)v;
        if (g0[i] != (uint8_t)((uint16_t)v) || g1[i] != sat) return 1;
    }
    return 0;
}

/* |x - y| of two narrow lanes, as the wide type. */
static uint32_t abd_s16(int32_t x, int32_t y) { return x > y ? (uint32_t)x - (uint32_t)y : (uint32_t)y - (uint32_t)x; }

static int check_s16(void) {
    int16_t a[4], b[4], aq[8], bq[8];
    int32_t w[4], c[4];
    memcpy(a, A, 8); memcpy(b, B, 8); memcpy(aq, A, 16); memcpy(bq, B, 16);
    memcpy(w, C, 16); memcpy(c, B, 16);
    int16x4_t va, vb;
    int16x8_t vaq, vbq;
    int32x4_t vw, vc, r[19];
    memcpy(&va, a, 8); memcpy(&vb, b, 8); memcpy(&vaq, aq, 16); memcpy(&vbq, bq, 16);
    memcpy(&vw, w, 16); memcpy(&vc, c, 16);
    r[0] = vaddl_s16(va, vb); r[1] = vaddl_high_s16(vaq, vbq);
    r[2] = vsubl_s16(va, vb); r[3] = vsubl_high_s16(vaq, vbq);
    r[4] = vmull_s16(va, vb); r[5] = vmull_high_s16(vaq, vbq);
    r[6] = vabdl_s16(va, vb); r[7] = vabdl_high_s16(vaq, vbq);
    r[8] = vaddw_s16(vw, va); r[9] = vaddw_high_s16(vw, vbq);
    r[10] = vsubw_s16(vw, va); r[11] = vsubw_high_s16(vw, vbq);
    r[12] = vmlal_s16(vc, va, vb); r[13] = vmlal_high_s16(vc, vaq, vbq);
    r[14] = vmlsl_s16(vc, va, vb); r[15] = vmlsl_high_s16(vc, vaq, vbq);
    r[16] = vabal_s16(vc, va, vb); r[17] = vabal_high_s16(vc, vaq, vbq);
    r[18] = vmovl_s16(va);
    for (int i = 0; i < 4; i++) {
        uint32_t x = (uint32_t)(int32_t)a[i], y = (uint32_t)(int32_t)b[i];
        uint32_t hx = (uint32_t)(int32_t)aq[i + 4], hy = (uint32_t)(int32_t)bq[i + 4];
        uint32_t cw = (uint32_t)c[i], ww = (uint32_t)w[i];
        uint32_t e[19] = {
            x + y, hx + hy, x - y, hx - hy, x * y, hx * hy,
            abd_s16(a[i], b[i]), abd_s16(aq[i + 4], bq[i + 4]),
            ww + x, ww + hy, ww - x, ww - hy,
            cw + x * y, cw + hx * hy, cw - x * y, cw - hx * hy,
            cw + abd_s16(a[i], b[i]), cw + abd_s16(aq[i + 4], bq[i + 4]),
            x,
        };
        for (int k = 0; k < 19; k++) {
            uint32_t got;
            memcpy(&got, (char *)&r[k] + i * sizeof got, sizeof got);
            if (got != (uint32_t)e[k]) return 1;
        }
    }
    int16x4_t n0 = vmovn_s32(vw), n1 = vqmovn_s32(vw);
    int16_t g0[4], g1[4];
    memcpy(g0, &n0, 8); memcpy(g1, &n1, 8);
    for (int i = 0; i < 4; i++) {
        int32_t v = w[i];
        int16_t sat = v < (int32_t)-32768LL ? (int16_t)-32768LL : v > (int32_t)32767LL ? (int16_t)32767LL : (int16_t)v;
        if (g0[i] != (int16_t)((uint32_t)v) || g1[i] != sat) return 1;
    }
    uint16x4_t n2 = vqmovun_s32(vw);
    uint16_t g2[4];
    memcpy(g2, &n2, 8);
    for (int i = 0; i < 4; i++) {
        int32_t v = w[i];
        uint16_t sat = v < 0 ? 0 : v > (int32_t)65535LL ? (uint16_t)65535ULL : (uint16_t)v;
        if (g2[i] != sat) return 1;
    }
    return 0;
}

/* |x - y| of two narrow lanes, as the wide type. */
static uint32_t abd_u16(uint32_t x, uint32_t y) { return x > y ? (uint32_t)x - (uint32_t)y : (uint32_t)y - (uint32_t)x; }

static int check_u16(void) {
    uint16_t a[4], b[4], aq[8], bq[8];
    uint32_t w[4], c[4];
    memcpy(a, A, 8); memcpy(b, B, 8); memcpy(aq, A, 16); memcpy(bq, B, 16);
    memcpy(w, C, 16); memcpy(c, B, 16);
    uint16x4_t va, vb;
    uint16x8_t vaq, vbq;
    uint32x4_t vw, vc, r[19];
    memcpy(&va, a, 8); memcpy(&vb, b, 8); memcpy(&vaq, aq, 16); memcpy(&vbq, bq, 16);
    memcpy(&vw, w, 16); memcpy(&vc, c, 16);
    r[0] = vaddl_u16(va, vb); r[1] = vaddl_high_u16(vaq, vbq);
    r[2] = vsubl_u16(va, vb); r[3] = vsubl_high_u16(vaq, vbq);
    r[4] = vmull_u16(va, vb); r[5] = vmull_high_u16(vaq, vbq);
    r[6] = vabdl_u16(va, vb); r[7] = vabdl_high_u16(vaq, vbq);
    r[8] = vaddw_u16(vw, va); r[9] = vaddw_high_u16(vw, vbq);
    r[10] = vsubw_u16(vw, va); r[11] = vsubw_high_u16(vw, vbq);
    r[12] = vmlal_u16(vc, va, vb); r[13] = vmlal_high_u16(vc, vaq, vbq);
    r[14] = vmlsl_u16(vc, va, vb); r[15] = vmlsl_high_u16(vc, vaq, vbq);
    r[16] = vabal_u16(vc, va, vb); r[17] = vabal_high_u16(vc, vaq, vbq);
    r[18] = vmovl_u16(va);
    for (int i = 0; i < 4; i++) {
        uint32_t x = (uint32_t)(uint32_t)a[i], y = (uint32_t)(uint32_t)b[i];
        uint32_t hx = (uint32_t)(uint32_t)aq[i + 4], hy = (uint32_t)(uint32_t)bq[i + 4];
        uint32_t cw = (uint32_t)c[i], ww = (uint32_t)w[i];
        uint32_t e[19] = {
            x + y, hx + hy, x - y, hx - hy, x * y, hx * hy,
            abd_u16(a[i], b[i]), abd_u16(aq[i + 4], bq[i + 4]),
            ww + x, ww + hy, ww - x, ww - hy,
            cw + x * y, cw + hx * hy, cw - x * y, cw - hx * hy,
            cw + abd_u16(a[i], b[i]), cw + abd_u16(aq[i + 4], bq[i + 4]),
            x,
        };
        for (int k = 0; k < 19; k++) {
            uint32_t got;
            memcpy(&got, (char *)&r[k] + i * sizeof got, sizeof got);
            if (got != (uint32_t)e[k]) return 1;
        }
    }
    uint16x4_t n0 = vmovn_u32(vw), n1 = vqmovn_u32(vw);
    uint16_t g0[4], g1[4];
    memcpy(g0, &n0, 8); memcpy(g1, &n1, 8);
    for (int i = 0; i < 4; i++) {
        uint32_t v = w[i];
        uint16_t sat = v < (uint32_t)0 ? (uint16_t)0 : v > (uint32_t)65535ULL ? (uint16_t)65535ULL : (uint16_t)v;
        if (g0[i] != (uint16_t)((uint32_t)v) || g1[i] != sat) return 1;
    }
    return 0;
}

/* |x - y| of two narrow lanes, as the wide type. */
static uint64_t abd_s32(int64_t x, int64_t y) { return x > y ? (uint64_t)x - (uint64_t)y : (uint64_t)y - (uint64_t)x; }

static int check_s32(void) {
    int32_t a[2], b[2], aq[4], bq[4];
    int64_t w[2], c[2];
    memcpy(a, A, 8); memcpy(b, B, 8); memcpy(aq, A, 16); memcpy(bq, B, 16);
    memcpy(w, C, 16); memcpy(c, B, 16);
    int32x2_t va, vb;
    int32x4_t vaq, vbq;
    int64x2_t vw, vc, r[19];
    memcpy(&va, a, 8); memcpy(&vb, b, 8); memcpy(&vaq, aq, 16); memcpy(&vbq, bq, 16);
    memcpy(&vw, w, 16); memcpy(&vc, c, 16);
    r[0] = vaddl_s32(va, vb); r[1] = vaddl_high_s32(vaq, vbq);
    r[2] = vsubl_s32(va, vb); r[3] = vsubl_high_s32(vaq, vbq);
    r[4] = vmull_s32(va, vb); r[5] = vmull_high_s32(vaq, vbq);
    r[6] = vabdl_s32(va, vb); r[7] = vabdl_high_s32(vaq, vbq);
    r[8] = vaddw_s32(vw, va); r[9] = vaddw_high_s32(vw, vbq);
    r[10] = vsubw_s32(vw, va); r[11] = vsubw_high_s32(vw, vbq);
    r[12] = vmlal_s32(vc, va, vb); r[13] = vmlal_high_s32(vc, vaq, vbq);
    r[14] = vmlsl_s32(vc, va, vb); r[15] = vmlsl_high_s32(vc, vaq, vbq);
    r[16] = vabal_s32(vc, va, vb); r[17] = vabal_high_s32(vc, vaq, vbq);
    r[18] = vmovl_s32(va);
    for (int i = 0; i < 2; i++) {
        uint64_t x = (uint64_t)(int64_t)a[i], y = (uint64_t)(int64_t)b[i];
        uint64_t hx = (uint64_t)(int64_t)aq[i + 2], hy = (uint64_t)(int64_t)bq[i + 2];
        uint64_t cw = (uint64_t)c[i], ww = (uint64_t)w[i];
        uint64_t e[19] = {
            x + y, hx + hy, x - y, hx - hy, x * y, hx * hy,
            abd_s32(a[i], b[i]), abd_s32(aq[i + 2], bq[i + 2]),
            ww + x, ww + hy, ww - x, ww - hy,
            cw + x * y, cw + hx * hy, cw - x * y, cw - hx * hy,
            cw + abd_s32(a[i], b[i]), cw + abd_s32(aq[i + 2], bq[i + 2]),
            x,
        };
        for (int k = 0; k < 19; k++) {
            uint64_t got;
            memcpy(&got, (char *)&r[k] + i * sizeof got, sizeof got);
            if (got != (uint64_t)e[k]) return 1;
        }
    }
    int32x2_t n0 = vmovn_s64(vw), n1 = vqmovn_s64(vw);
    int32_t g0[2], g1[2];
    memcpy(g0, &n0, 8); memcpy(g1, &n1, 8);
    for (int i = 0; i < 2; i++) {
        int64_t v = w[i];
        int32_t sat = v < (int64_t)-2147483648LL ? (int32_t)-2147483648LL : v > (int64_t)2147483647LL ? (int32_t)2147483647LL : (int32_t)v;
        if (g0[i] != (int32_t)((uint64_t)v) || g1[i] != sat) return 1;
    }
    uint32x2_t n2 = vqmovun_s64(vw);
    uint32_t g2[2];
    memcpy(g2, &n2, 8);
    for (int i = 0; i < 2; i++) {
        int64_t v = w[i];
        uint32_t sat = v < 0 ? 0 : v > (int64_t)4294967295LL ? (uint32_t)4294967295ULL : (uint32_t)v;
        if (g2[i] != sat) return 1;
    }
    return 0;
}

/* |x - y| of two narrow lanes, as the wide type. */
static uint64_t abd_u32(uint64_t x, uint64_t y) { return x > y ? (uint64_t)x - (uint64_t)y : (uint64_t)y - (uint64_t)x; }

static int check_u32(void) {
    uint32_t a[2], b[2], aq[4], bq[4];
    uint64_t w[2], c[2];
    memcpy(a, A, 8); memcpy(b, B, 8); memcpy(aq, A, 16); memcpy(bq, B, 16);
    memcpy(w, C, 16); memcpy(c, B, 16);
    uint32x2_t va, vb;
    uint32x4_t vaq, vbq;
    uint64x2_t vw, vc, r[19];
    memcpy(&va, a, 8); memcpy(&vb, b, 8); memcpy(&vaq, aq, 16); memcpy(&vbq, bq, 16);
    memcpy(&vw, w, 16); memcpy(&vc, c, 16);
    r[0] = vaddl_u32(va, vb); r[1] = vaddl_high_u32(vaq, vbq);
    r[2] = vsubl_u32(va, vb); r[3] = vsubl_high_u32(vaq, vbq);
    r[4] = vmull_u32(va, vb); r[5] = vmull_high_u32(vaq, vbq);
    r[6] = vabdl_u32(va, vb); r[7] = vabdl_high_u32(vaq, vbq);
    r[8] = vaddw_u32(vw, va); r[9] = vaddw_high_u32(vw, vbq);
    r[10] = vsubw_u32(vw, va); r[11] = vsubw_high_u32(vw, vbq);
    r[12] = vmlal_u32(vc, va, vb); r[13] = vmlal_high_u32(vc, vaq, vbq);
    r[14] = vmlsl_u32(vc, va, vb); r[15] = vmlsl_high_u32(vc, vaq, vbq);
    r[16] = vabal_u32(vc, va, vb); r[17] = vabal_high_u32(vc, vaq, vbq);
    r[18] = vmovl_u32(va);
    for (int i = 0; i < 2; i++) {
        uint64_t x = (uint64_t)(uint64_t)a[i], y = (uint64_t)(uint64_t)b[i];
        uint64_t hx = (uint64_t)(uint64_t)aq[i + 2], hy = (uint64_t)(uint64_t)bq[i + 2];
        uint64_t cw = (uint64_t)c[i], ww = (uint64_t)w[i];
        uint64_t e[19] = {
            x + y, hx + hy, x - y, hx - hy, x * y, hx * hy,
            abd_u32(a[i], b[i]), abd_u32(aq[i + 2], bq[i + 2]),
            ww + x, ww + hy, ww - x, ww - hy,
            cw + x * y, cw + hx * hy, cw - x * y, cw - hx * hy,
            cw + abd_u32(a[i], b[i]), cw + abd_u32(aq[i + 2], bq[i + 2]),
            x,
        };
        for (int k = 0; k < 19; k++) {
            uint64_t got;
            memcpy(&got, (char *)&r[k] + i * sizeof got, sizeof got);
            if (got != (uint64_t)e[k]) return 1;
        }
    }
    uint32x2_t n0 = vmovn_u64(vw), n1 = vqmovn_u64(vw);
    uint32_t g0[2], g1[2];
    memcpy(g0, &n0, 8); memcpy(g1, &n1, 8);
    for (int i = 0; i < 2; i++) {
        uint64_t v = w[i];
        uint32_t sat = v < (uint64_t)0 ? (uint32_t)0 : v > (uint64_t)4294967295ULL ? (uint32_t)4294967295ULL : (uint32_t)v;
        if (g0[i] != (uint32_t)((uint64_t)v) || g1[i] != sat) return 1;
    }
    return 0;
}

int main(void) {
    return check_s8() | check_u8() << 1 | check_s16() << 2 | check_u16() << 3
         | check_s32() << 4 | check_u32() << 5;
}
#else
int main(void) { return 0; }
#endif
