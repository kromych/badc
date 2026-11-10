// SSE intrinsics on more live vectors than there are xmm registers, so
// some are spilled across the loop, checked lane by lane against the same
// arithmetic in scalar C. Covers the two-operand, immediate, shift by a
// register count, insert, extract, move-mask and scalar-merge forms. Returns
// 0 when every check passes; each failure returns a distinct code.

#if defined(__x86_64__) || defined(_M_X64)
#include <emmintrin.h>
#include <smmintrin.h>

#define N 20

static unsigned lane(__m128i v, int i) {
    unsigned out[4];
    _mm_storeu_si128((__m128i *)out, v);
    return out[i];
}

int main(void) {
    __m128i v[N];
    unsigned s[N][4];
    for (int k = 0; k < N; k++) {
        for (int i = 0; i < 4; i++) s[k][i] = 0x9E3779B9u * (unsigned)(k * 4 + i + 1);
        v[k] = _mm_loadu_si128((const __m128i *)s[k]);
    }
    __m128i a0 = v[0], a1 = v[1], a2 = v[2], a3 = v[3], a4 = v[4], a5 = v[5], a6 = v[6],
            a7 = v[7], a8 = v[8], a9 = v[9], a10 = v[10], a11 = v[11], a12 = v[12],
            a13 = v[13], a14 = v[14], a15 = v[15], a16 = v[16], a17 = v[17], a18 = v[18],
            a19 = v[19];
    int count = 3;
    for (int r = 0; r < 4; r++) {
        a0 = _mm_add_epi32(a0, a19);
        a1 = _mm_xor_si128(a1, a0);
        a2 = _mm_sub_epi32(a2, a1);
        a3 = _mm_or_si128(_mm_slli_epi32(a3, 7), _mm_srli_epi32(a2, 25));
        a4 = _mm_and_si128(a4, a3);
        a5 = _mm_add_epi32(a4, a5);
        a6 = _mm_sll_epi32(a6, _mm_cvtsi32_si128(count));
        a7 = _mm_shuffle_epi32(a7, 0x1b);
        a8 = _mm_mullo_epi32(a8, a7);
        a9 = _mm_insert_epi32(a9, _mm_extract_epi32(a8, 2), 1);
        a10 = _mm_max_epu32(a10, a9);
        a11 = _mm_min_epi32(a11, a10);
        a12 = _mm_unpacklo_epi32(a12, a11);
        a13 = _mm_add_epi32(a13, a12);
        a14 = _mm_xor_si128(a13, a14);
        a15 = _mm_cmpeq_epi32(a15, a15);
        a16 = _mm_sub_epi32(a16, a14);
        a17 = _mm_add_epi32(a17, a16);
        a18 = _mm_xor_si128(a18, a17);
        a19 = _mm_add_epi32(a19, a18);
    }
    unsigned e[N][4];
    for (int k = 0; k < N; k++)
        for (int i = 0; i < 4; i++) e[k][i] = s[k][i];
    for (int r = 0; r < 4; r++) {
        unsigned t[4];
        for (int i = 0; i < 4; i++) e[0][i] += e[19][i];
        for (int i = 0; i < 4; i++) e[1][i] ^= e[0][i];
        for (int i = 0; i < 4; i++) e[2][i] -= e[1][i];
        for (int i = 0; i < 4; i++) e[3][i] = (e[3][i] << 7) | (e[2][i] >> 25);
        for (int i = 0; i < 4; i++) e[4][i] &= e[3][i];
        for (int i = 0; i < 4; i++) e[5][i] = e[4][i] + e[5][i];
        for (int i = 0; i < 4; i++) e[6][i] <<= count;
        for (int i = 0; i < 4; i++) t[i] = e[7][3 - i];
        for (int i = 0; i < 4; i++) e[7][i] = t[i];
        for (int i = 0; i < 4; i++) e[8][i] *= e[7][i];
        e[9][1] = e[8][2];
        for (int i = 0; i < 4; i++) e[10][i] = e[10][i] > e[9][i] ? e[10][i] : e[9][i];
        for (int i = 0; i < 4; i++)
            e[11][i] = (int)e[11][i] < (int)e[10][i] ? e[11][i] : e[10][i];
        t[0] = e[12][0], t[1] = e[11][0], t[2] = e[12][1], t[3] = e[11][1];
        for (int i = 0; i < 4; i++) e[12][i] = t[i];
        for (int i = 0; i < 4; i++) e[13][i] += e[12][i];
        for (int i = 0; i < 4; i++) e[14][i] ^= e[13][i];
        for (int i = 0; i < 4; i++) e[15][i] = 0xFFFFFFFFu;
        for (int i = 0; i < 4; i++) e[16][i] -= e[14][i];
        for (int i = 0; i < 4; i++) e[17][i] += e[16][i];
        for (int i = 0; i < 4; i++) e[18][i] ^= e[17][i];
        for (int i = 0; i < 4; i++) e[19][i] += e[18][i];
    }
    __m128i out[N] = {a0, a1, a2, a3, a4, a5, a6, a7, a8, a9,
                      a10, a11, a12, a13, a14, a15, a16, a17, a18, a19};
    for (int k = 0; k < N; k++)
        for (int i = 0; i < 4; i++)
            if (lane(out[k], i) != e[k][i]) return 1 + k;
    // Move mask and a scalar form that keeps the upper lanes.
    if (_mm_movemask_epi8(_mm_cmpeq_epi32(a15, _mm_set1_epi32(-1))) != 0xFFFF) return 30;
    __m128 f = _mm_set_ps(4.0f, 3.0f, 2.0f, 16.0f);
    __m128 g = _mm_sqrt_ss(f);
    float fo[4];
    _mm_storeu_ps(fo, g);
    if (fo[0] != 4.0f || fo[1] != 2.0f || fo[3] != 4.0f) return 31;
    return 0;
}
#else
int main(void) { return 0; }
#endif
