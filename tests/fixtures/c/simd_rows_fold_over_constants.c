// An integer SIMD intrinsic over constant vectors gives at compile time the
// value the instruction gives at run time: each result over constants, and
// lanes read of it, are compared with the same intrinsic over the same
// lanes read through volatile objects. Returns 0 when every pair agrees,
// else the failing check's number (plus 100 for a lane).

#include <string.h>

static int same(const void *a, const void *b) {
    return memcmp(a, b, 16) == 0;
}

#if defined(__x86_64__)
#include <immintrin.h>

static volatile int va = 0x12345678, vb = -0x7654321;

int main(void) {
    __m128i a = _mm_setr_epi32(0x12345678, -0x7654321, 0x7fff8000, -1);
    __m128i b = _mm_setr_epi16(1, -2, 3, 0x7fff, -0x8000, 6, -7, 8);
    __m128i ra = _mm_setr_epi32(va, vb, 0x7fff8000, -1);
    __m128i rb = _mm_setr_epi16((short)(va - 0x12345677), -2, 3, 0x7fff, -0x8000, 6, -7, 8);
#define LANE(v, k) _mm_extract_epi16((v), (k))
#define CHECK(n, expr_c, expr_r)                                                    \
    {                                                                             \
        __m128i c = expr_c, r = expr_r;                                           \
        if (!same(&c, &r))                                                        \
            return n;                                                             \
        if (LANE(expr_c, 0) != LANE(r, 0) || LANE(expr_c, 3) != LANE(r, 3) ||     \
            LANE(expr_c, 4) != LANE(r, 4) || LANE(expr_c, 7) != LANE(r, 7))        \
            return 100 + n;                                                       \
    }
    CHECK(1, _mm_add_epi16(a, b), _mm_add_epi16(ra, rb))
    CHECK(2, _mm_packs_epi32(a, b), _mm_packs_epi32(ra, rb))
    CHECK(3, _mm_packus_epi16(a, b), _mm_packus_epi16(ra, rb))
    CHECK(4, _mm_mulhi_epi16(a, b), _mm_mulhi_epi16(ra, rb))
    CHECK(5, _mm_shuffle_epi32(a, 0x1b), _mm_shuffle_epi32(ra, 0x1b))
    CHECK(6, _mm_slli_epi32(a, 7), _mm_slli_epi32(ra, 7))
    CHECK(7, _mm_srai_epi16(b, 3), _mm_srai_epi16(rb, 3))
    CHECK(8, _mm_unpackhi_epi8(a, b), _mm_unpackhi_epi8(ra, rb))
    CHECK(9, _mm_sad_epu8(a, b), _mm_sad_epu8(ra, rb))
    CHECK(10, _mm_abs_epi16(b), _mm_abs_epi16(rb))
    CHECK(11, _mm_maddubs_epi16(a, b), _mm_maddubs_epi16(ra, rb))
    CHECK(12, _mm_cmpgt_epi32(a, b), _mm_cmpgt_epi32(ra, rb))
    CHECK(13, _mm_alignr_epi8(a, b, 5), _mm_alignr_epi8(ra, rb, 5))
    CHECK(14, _mm_minpos_epu16(b), _mm_minpos_epu16(rb))
    if (_mm_extract_epi16(_mm_packs_epi32(a, b), 3) !=
        _mm_extract_epi16(_mm_packs_epi32(ra, rb), 3))
        return 15;
    if (_mm_movemask_epi8(_mm_cmpeq_epi8(a, a)) != 0xffff)
        return 16;
    return 0;
}
#elif defined(__aarch64__)
#include <arm_neon.h>

static volatile int va = 0x12345678, vb = -0x7654321;

int main(void) {
    int32x4_t a = {0x12345678, -0x7654321, 0x7fff8000, -1};
    int16x8_t b = {1, -2, 3, 0x7fff, -0x8000, 6, -7, 8};
    int32x4_t ra = {va, vb, 0x7fff8000, -1};
    int16x8_t rb = {(short)(va - 0x12345677), -2, 3, 0x7fff, -0x8000, 6, -7, 8};
    int16x8_t a16 = vreinterpretq_s16_s32(a), ra16 = vreinterpretq_s16_s32(ra);
#define LANE(v, k) vgetq_lane_u16(vreinterpretq_u16_s32((int32x4_t)(v)), (k))
#define CHECK(n, T, expr_c, expr_r)                                                 \
    {                                                                             \
        T c = expr_c, r = expr_r;                                                 \
        if (!same(&c, &r))                                                        \
            return n;                                                             \
        if (LANE(expr_c, 0) != LANE(r, 0) || LANE(expr_c, 3) != LANE(r, 3) ||     \
            LANE(expr_c, 4) != LANE(r, 4) || LANE(expr_c, 7) != LANE(r, 7))        \
            return 100 + n;                                                       \
    }
    CHECK(1, int16x8_t, vqaddq_s16(a16, b), vqaddq_s16(ra16, rb))
    CHECK(2, int16x8_t, vqdmulhq_s16(a16, b), vqdmulhq_s16(ra16, rb))
    CHECK(3, int32x4_t, vshlq_n_s32(a, 9), vshlq_n_s32(ra, 9))
    CHECK(4, int16x8_t, vabsq_s16(b), vabsq_s16(rb))
    CHECK(5, int16x8_t, vzip1q_s16(a16, b), vzip1q_s16(ra16, rb))
    CHECK(6, int16x8_t, vrhaddq_s16(a16, b), vrhaddq_s16(ra16, rb))
    CHECK(7, uint16x8_t, vcgtq_s16(a16, b), vcgtq_s16(ra16, rb))
    CHECK(8, int16x8_t, vextq_s16(a16, b, 3), vextq_s16(ra16, rb, 3))
    if (vgetq_lane_s16(vqsubq_s16(a16, b), 5) != vgetq_lane_s16(vqsubq_s16(ra16, rb), 5))
        return 9;
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif
