// The 128-bit halves of the AVX vectors: extracting either half, inserting
// over either, the casts between the widths (a widened value's upper half
// zero), and the float forms built on them, each checked lane by lane
// against the same bytes through memory. Returns 0 when every check
// passes; each failure returns a distinct code. Elsewhere than x86-64 the
// unit is empty.

#ifdef __x86_64__
#include <immintrin.h>
#include <string.h>

static int same(const void *a, const void *b, size_t n) { return memcmp(a, b, n) == 0; }

__attribute__((noinline)) __m128i half(__m256i v, int hi) {
    return hi ? _mm256_extracti128_si256(v, 1) : _mm256_extracti128_si256(v, 0);
}

__attribute__((noinline)) __m256i put(__m256i v, __m128i x, int hi) {
    return hi ? _mm256_inserti128_si256(v, x, 1) : _mm256_inserti128_si256(v, x, 0);
}

__attribute__((noinline)) int sum(__m256i v) {
    __m128i s = _mm_add_epi32(_mm256_castsi256_si128(v), _mm256_extracti128_si256(v, 1));
    s = _mm_add_epi32(s, _mm_unpackhi_epi64(s, s));
    s = _mm_add_epi32(s, _mm_shuffle_epi32(s, _MM_SHUFFLE(2, 3, 0, 1)));
    return _mm_cvtsi128_si32(s);
}

int main(void) {
    int a[8], b[4], out[8];
    for (int i = 0; i < 8; i++) a[i] = i * 1000003 - 4000000;
    for (int i = 0; i < 4; i++) b[i] = -7 * i - 1;
    __m256i va = _mm256_loadu_si256((const __m256i *)a);
    __m128i vb = _mm_loadu_si128((const __m128i *)b);

    _mm_storeu_si128((__m128i *)out, half(va, 0));
    if (!same(out, a, 16)) return 1;
    _mm_storeu_si128((__m128i *)out, half(va, 1));
    if (!same(out, a + 4, 16)) return 2;
    _mm_storeu_si128((__m128i *)out, _mm256_castsi256_si128(va));
    if (!same(out, a, 16)) return 3;

    _mm256_storeu_si256((__m256i *)out, put(va, vb, 0));
    if (!same(out, b, 16) || !same(out + 4, a + 4, 16)) return 4;
    _mm256_storeu_si256((__m256i *)out, put(va, vb, 1));
    if (!same(out, a, 16) || !same(out + 4, b, 16)) return 5;

    int zero[4] = {0, 0, 0, 0};
    _mm256_storeu_si256((__m256i *)out, _mm256_zextsi128_si256(vb));
    if (!same(out, b, 16) || !same(out + 4, zero, 16)) return 6;
    _mm256_storeu_si256((__m256i *)out, _mm256_set_m128i(vb, _mm256_castsi256_si128(va)));
    if (!same(out, a, 16) || !same(out + 4, b, 16)) return 7;
    _mm256_storeu_si256((__m256i *)out, _mm256_broadcastsi128_si256(vb));
    if (!same(out, b, 16) || !same(out + 4, b, 16)) return 8;

    int total = 0;
    for (int i = 0; i < 8; i++) total += a[i];
    if (sum(va) != total) return 9;

    float f[8], g[4], fo[8];
    for (int i = 0; i < 8; i++) f[i] = 0.5f * (float)i - 1.25f;
    for (int i = 0; i < 4; i++) g[i] = 100.0f + (float)i;
    __m256 vf = _mm256_loadu_ps(f);
    _mm_storeu_ps(fo, _mm256_extractf128_ps(vf, 1));
    if (!same(fo, f + 4, 16)) return 10;
    _mm256_storeu_ps(fo, _mm256_insertf128_ps(vf, _mm_loadu_ps(g), 0));
    if (!same(fo, g, 16) || !same(fo + 4, f + 4, 16)) return 11;
    _mm256_storeu_ps(fo, _mm256_add_ps(vf, vf));
    for (int i = 0; i < 8; i++)
        if (fo[i] != f[i] + f[i]) return 12;
    _mm_storeu_ps(fo, _mm256_castps256_ps128(vf));
    if (!same(fo, f, 16)) return 13;

    double d[4] = {1.5, -2.5, 3.25, 1e300}, dout[4];
    __m256d vd = _mm256_loadu_pd(d);
    _mm_storeu_pd(dout, _mm256_extractf128_pd(vd, 1));
    if (dout[0] != 3.25 || dout[1] != 1e300) return 14;
    _mm256_storeu_pd(dout, _mm256_zextpd128_pd256(_mm256_castpd256_pd128(vd)));
    if (dout[0] != 1.5 || dout[1] != -2.5 || dout[2] != 0.0 || dout[3] != 0.0) return 15;
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif
