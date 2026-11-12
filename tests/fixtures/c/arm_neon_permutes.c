/* <arm_neon.h> lane permutes -- vzip1/2, vuzp1/2, vtrn1/2 and the pairs
 * returning both halves -- on every element type and vector width they
 * are defined for: each result checked against the permutation computed
 * lane by lane in C. The exit code has a bit per failing type; elsewhere
 * than AArch64 the unit is empty. */
#if defined(__aarch64__)
#include <arm_neon.h>
#include <string.h>

static const unsigned char A[16] = {0x80, 0x7f, 0xff, 0x01, 0x00, 0x55, 0xaa, 0x12,
                                    0x34, 0xfe, 0x81, 0x7e, 0x02, 0xfd, 0x40, 0xc0};

/* The six permutes of n-lane vectors V of T, suffix q for the 16-byte
 * forms: lane i of zip1 alternates the low halves' lanes, uzp1 takes the
 * even lanes of the concatenation, trn1 the even lanes of each operand in
 * turn; the second forms take the high halves or the odd lanes. */
#define CHECK(q, sfx, T, V, n)                                            \
    static int check_##sfx##q(void) {                                     \
        T x[n], y[n];                                                     \
        for (int i = 0; i < n; i++) {                                     \
            x[i] = (T)(A[i] * 3 + 1);                                     \
            y[i] = (T)(A[15 - i] * 5 + 2);                                \
        }                                                                 \
        V a, b;                                                           \
        memcpy(&a, x, sizeof a);                                          \
        memcpy(&b, y, sizeof b);                                          \
        V r[6] = {vzip1##q##_##sfx(a, b), vzip2##q##_##sfx(a, b),         \
                  vuzp1##q##_##sfx(a, b), vuzp2##q##_##sfx(a, b),         \
                  vtrn1##q##_##sfx(a, b), vtrn2##q##_##sfx(a, b)};        \
        for (int i = 0; i < n; i++) {                                     \
            int h = i / 2, odd = i % 2, k = 2 * i;                        \
            T want[6] = {odd ? y[h] : x[h],                               \
                         odd ? y[n / 2 + h] : x[n / 2 + h],               \
                         k < n ? x[k] : y[k - n],                         \
                         k + 1 < n ? x[k + 1] : y[k + 1 - n],             \
                         odd ? y[i - 1] : x[i],                           \
                         odd ? y[i] : x[i + 1]};                          \
            for (int j = 0; j < 6; j++)                                   \
                if (r[j][i] != want[j]) return 1;                         \
        }                                                                 \
        return 0;                                                         \
    }
CHECK(, s8, int8_t, int8x8_t, 8)
CHECK(q, s8, int8_t, int8x16_t, 16)
CHECK(, u8, uint8_t, uint8x8_t, 8)
CHECK(q, u8, uint8_t, uint8x16_t, 16)
CHECK(, s16, int16_t, int16x4_t, 4)
CHECK(q, s16, int16_t, int16x8_t, 8)
CHECK(, u16, uint16_t, uint16x4_t, 4)
CHECK(q, u16, uint16_t, uint16x8_t, 8)
CHECK(, s32, int32_t, int32x2_t, 2)
CHECK(q, u32, uint32_t, uint32x4_t, 4)
CHECK(, f32, float32_t, float32x2_t, 2)
CHECK(q, f32, float32_t, float32x4_t, 4)
CHECK(q, s64, int64_t, int64x2_t, 2)
CHECK(q, f64, float64_t, float64x2_t, 2)

/* The pairs return the first and second forms. */
static int check_pairs(void) {
    int16x4_t a = {1, 2, 3, 4}, b = {5, 6, 7, 8};
    int16x4x2_t z = vzip_s16(a, b), u = vuzp_s16(a, b), t = vtrn_s16(a, b);
    int16x4_t want[6] = {vzip1_s16(a, b), vzip2_s16(a, b), vuzp1_s16(a, b),
                         vuzp2_s16(a, b), vtrn1_s16(a, b), vtrn2_s16(a, b)};
    int16x4_t got[6] = {z.val[0], z.val[1], u.val[0], u.val[1], t.val[0], t.val[1]};
    for (int j = 0; j < 6; j++)
        for (int i = 0; i < 4; i++)
            if (got[j][i] != want[j][i]) return 1;
    return 0;
}

int main(void) {
    return check_s8() | check_s8q() << 1 | check_u8() << 2 | check_u8q() << 3 | check_s16() << 4
         | check_s16q() << 5 | check_u16() << 6 | check_u16q() << 7 | check_s32() << 8
         | check_u32q() << 9 | check_f32() << 10 | check_f32q() << 11 | check_s64q() << 12
         | check_f64q() << 13 | check_pairs() << 14;
}
#else
int main(void) { return 0; }
#endif
