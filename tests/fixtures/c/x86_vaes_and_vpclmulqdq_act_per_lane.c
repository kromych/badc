// VAES and VPCLMULQDQ (<immintrin.h>): each 256-bit form applies the
// AES-NI or PCLMULQDQ instruction to each 128-bit lane, the immediate's
// qword selectors within each lane. Exits 0 when both lanes match the
// 128-bit form on their halves; off x86-64 the unit checks nothing.

#if defined(__x86_64__)
#include <immintrin.h>

static int same(__m128i x, __m128i y) {
    return _mm_movemask_epi8(_mm_cmpeq_epi8(x, y)) == 0xffff;
}

static int lanes(__m256i r, __m128i lo, __m128i hi) {
    return same(_mm256_extracti128_si256(r, 0), lo) && same(_mm256_extracti128_si256(r, 1), hi);
}

int main(void) {
    __m128i s0 = _mm_set_epi64x(0x7b5b546573745665, 0x63746f725d53475d);
    __m128i s1 = _mm_set_epi64x(0x0123456789abcdef, 0x0f1e2d3c4b5a6978);
    __m128i k0 = _mm_set_epi64x(0x4869285368617929, 0x5b477565726f6e5d);
    __m128i k1 = _mm_set_epi64x(0x1122334455667788, 0x99aabbccddeeff00);
    __m256i s = _mm256_set_m128i(s1, s0), k = _mm256_set_m128i(k1, k0);
    if (!lanes(_mm256_aesenc_epi128(s, k), _mm_aesenc_si128(s0, k0), _mm_aesenc_si128(s1, k1)))
        return 1;
    if (!lanes(_mm256_aesenclast_epi128(s, k), _mm_aesenclast_si128(s0, k0),
               _mm_aesenclast_si128(s1, k1)))
        return 2;
    if (!lanes(_mm256_aesdec_epi128(s, k), _mm_aesdec_si128(s0, k0), _mm_aesdec_si128(s1, k1)))
        return 3;
    if (!lanes(_mm256_aesdeclast_epi128(s, k), _mm_aesdeclast_si128(s0, k0),
               _mm_aesdeclast_si128(s1, k1)))
        return 4;
    if (!lanes(_mm256_clmulepi64_epi128(s, k, 0x00), _mm_clmulepi64_si128(s0, k0, 0x00),
               _mm_clmulepi64_si128(s1, k1, 0x00)))
        return 5;
    if (!lanes(_mm256_clmulepi64_epi128(s, k, 0x11), _mm_clmulepi64_si128(s0, k0, 0x11),
               _mm_clmulepi64_si128(s1, k1, 0x11)))
        return 6;
    // The AES-NI white paper's AESENC example.
    __m128i want = _mm_set_epi64x((long long)0xa8311c2f9fdba3c5, (long long)0x8b104b58ded7e595);
    return same(_mm256_extracti128_si256(_mm256_aesenc_epi128(s, k), 0), want) ? 0 : 7;
}
#else
int main(void) { return 0; }
#endif
