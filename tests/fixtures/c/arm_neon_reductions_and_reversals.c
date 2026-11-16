/* <arm_neon.h> reductions across lanes, pairwise long sums and lane
 * reversals, on every element type the reductions are defined for: each
 * result checked against the operation computed lane by lane in C. The
 * exit code has a bit per failing group; elsewhere than AArch64 the unit
 * is empty. */
#if defined(__aarch64__)
#include <arm_neon.h>
#include <string.h>

static const unsigned char A[16] = {0x80, 0x7f, 0xff, 0x01, 0x00, 0x55, 0xaa, 0x12,
                                    0x34, 0xfe, 0x81, 0x7e, 0x02, 0xfd, 0x40, 0xc0};

/* Sum, maximum and minimum of n lanes of type T read from A. */
#define REDUCE(T, n, sum, max, min)                                       \
    do {                                                                  \
        T x[n];                                                           \
        memcpy(x, A, sizeof x);                                           \
        sum = 0;                                                          \
        max = min = x[0];                                                 \
        for (int i = 0; i < n; i++) {                                     \
            sum += x[i];                                                  \
            max = x[i] > max ? x[i] : max;                                \
            min = x[i] < min ? x[i] : min;                                \
        }                                                                 \
    } while (0)

/* The intrinsics of one element type: vaddv truncates the sum to the
 * element, vaddlv keeps it in the wider type W. */
#define CHECK(sfx, T, W, D, Q, nd, nq)                                    \
    static int check_##sfx(void) {                                        \
        D d;                                                              \
        Q q;                                                              \
        memcpy(&d, A, sizeof d);                                          \
        memcpy(&q, A, sizeof q);                                          \
        long long s, mx, mn;                                              \
        REDUCE(T, nd, s, mx, mn);                                         \
        if (vaddv_##sfx(d) != (T)s || vmaxv_##sfx(d) != (T)mx || vminv_##sfx(d) != (T)mn) \
            return 1;                                                     \
        if (vaddlv_##sfx(d) != (W)s) return 1;                            \
        REDUCE(T, nq, s, mx, mn);                                         \
        if (vaddvq_##sfx(q) != (T)s || vmaxvq_##sfx(q) != (T)mx || vminvq_##sfx(q) != (T)mn) \
            return 1;                                                     \
        if (vaddlvq_##sfx(q) != (W)s) return 1;                           \
        return 0;                                                         \
    }
CHECK(s8, int8_t, int16_t, int8x8_t, int8x16_t, 8, 16)
CHECK(u8, uint8_t, uint16_t, uint8x8_t, uint8x16_t, 8, 16)
CHECK(s16, int16_t, int32_t, int16x4_t, int16x8_t, 4, 8)
CHECK(u16, uint16_t, uint32_t, uint16x4_t, uint16x8_t, 4, 8)
CHECK(s32, int32_t, int64_t, int32x2_t, int32x4_t, 2, 4)
CHECK(u32, uint32_t, uint64_t, uint32x2_t, uint32x4_t, 2, 4)

static int check_64(void) {
    int64_t x[2];
    uint64_t y[2];
    memcpy(x, A, 16);
    memcpy(y, A, 16);
    int64x2_t s;
    uint64x2_t u;
    memcpy(&s, A, 16);
    memcpy(&u, A, 16);
    return vaddvq_s64(s) != (int64_t)((uint64_t)x[0] + (uint64_t)x[1]) || vaddvq_u64(u) != y[0] + y[1];
}

/* Pairwise long sums: each lane of the result the sum of two adjacent
 * source lanes, in the wider type. */
static int check_pairs(void) {
    int8_t a[8];
    uint16_t b[8];
    int32_t c[2];
    uint32_t e[4];
    memcpy(a, A, 8); memcpy(b, A, 16); memcpy(c, A, 8); memcpy(e, A, 16);
    int8x8_t va; uint16x8_t vb; int32x2_t vc; uint32x4_t ve;
    memcpy(&va, A, 8); memcpy(&vb, A, 16); memcpy(&vc, A, 8); memcpy(&ve, A, 16);
    int16x4_t ra = vpaddl_s8(va);
    uint32x4_t rb = vpaddlq_u16(vb);
    int64x1_t rc = vpaddl_s32(vc);
    uint64x2_t re = vpaddlq_u32(ve);
    for (int i = 0; i < 4; i++)
        if (ra[i] != a[2 * i] + a[2 * i + 1] || rb[i] != (uint32_t)b[2 * i] + b[2 * i + 1]) return 1;
    if (rc[0] != (int64_t)c[0] + c[1]) return 1;
    for (int i = 0; i < 2; i++)
        if (re[i] != (uint64_t)e[2 * i] + e[2 * i + 1]) return 1;
    return 0;
}

/* Reversals: lane i of each group of g lanes is the group's lane g-1-i. */
static int check_rev(void) {
    int8x16_t q;
    int16x4_t h;
    int32x4_t s;
    memcpy(&q, A, 16); memcpy(&h, A, 8); memcpy(&s, A, 16);
    int8x16_t r16 = vrev16q_s8(q), r32 = vrev32q_s8(q), r64 = vrev64q_s8(q);
    int16x4_t rh = vrev32_s16(h);
    int32x4_t rs = vrev64q_s32(s);
    for (int i = 0; i < 16; i++)
        if (r16[i] != q[i ^ 1] || r32[i] != q[i ^ 3] || r64[i] != q[i ^ 7]) return 1;
    for (int i = 0; i < 4; i++)
        if (rh[i] != h[i ^ 1] || rs[i] != s[i ^ 1]) return 1;
    return 0;
}

int main(void) {
    return check_s8() | check_u8() << 1 | check_s16() << 2 | check_u16() << 3 | check_s32() << 4
         | check_u32() << 5 | check_64() << 6 | check_pairs() << 7 | check_rev() << 8;
}
#else
int main(void) { return 0; }
#endif
