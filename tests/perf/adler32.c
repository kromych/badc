// Adler-32 (RFC 1950) over a 64 KiB buffer, 32768 times on x86-64 and 4096
// elsewhere. On x86-64 each 32-byte block is one AVX2 step, as in zlib-ng's
// adler32_avx2: vpsadbw sums the bytes into the first sum, and vpmaddubsw /
// vpmaddwd weigh them by their distance from the block's end for the second,
// which also takes 32 times the first sum before the block. The sums reduce
// modulo 65521 every 5536 bytes, below zlib's NMAX. Elsewhere the portable
// loop runs.
// Both are checked against each other and Wikipedia's "Wikipedia" value;
// self-times via bench_clock.h.
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include "bench_clock.h"

#define BUF_BYTES (64 * 1024)
#define BASE 65521u
#define NMAX 5536

static uint32_t adler32_ref(uint32_t adler, const uint8_t *p, size_t len) {
    uint32_t a = adler & 0xffff, b = adler >> 16;
    while (len > 0) {
        size_t n = len < NMAX ? len : NMAX;
        len -= n;
        while (n--) {
            a += *p++;
            b += a;
        }
        a %= BASE;
        b %= BASE;
    }
    return a | b << 16;
}

#if defined(__x86_64__) || defined(_M_X64)
#include <immintrin.h>
#if defined(__GNUC__)
#define AVX2 __attribute__((target("avx2")))
#else
#define AVX2
#endif

AVX2 static uint32_t hsum(__m256i v) {
    __m128i s = _mm_add_epi32(_mm256_castsi256_si128(v), _mm256_extracti128_si256(v, 1));
    s = _mm_add_epi32(s, _mm_unpackhi_epi64(s, s));
    s = _mm_add_epi32(s, _mm_shuffle_epi32(s, _MM_SHUFFLE(2, 3, 0, 1)));
    return (uint32_t)_mm_cvtsi128_si32(s);
}

AVX2 static uint32_t adler32_avx2(uint32_t adler, const uint8_t *p, size_t len) {
    const __m256i weights =
        _mm256_setr_epi8(32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14,
                         13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
    const __m256i ones = _mm256_set1_epi16(1);
    const __m256i zero = _mm256_setzero_si256();
    uint32_t a = adler & 0xffff, b = adler >> 16;
    while (len >= 32) {
        size_t n = (len < NMAX ? len : NMAX) & ~(size_t)31;
        len -= n;
        __m256i va = _mm256_zextsi128_si256(_mm_cvtsi32_si128((int)a));
        __m256i vb = _mm256_zextsi128_si256(_mm_cvtsi32_si128((int)b));
        __m256i vprev = zero;
        for (; n > 0; n -= 32, p += 32) {
            __m256i bytes = _mm256_loadu_si256((const __m256i *)p);
            vprev = _mm256_add_epi32(vprev, va);
            va = _mm256_add_epi32(va, _mm256_sad_epu8(bytes, zero));
            vb = _mm256_add_epi32(vb, _mm256_madd_epi16(_mm256_maddubs_epi16(bytes, weights), ones));
        }
        vb = _mm256_add_epi32(vb, _mm256_slli_epi32(vprev, 5));
        a = hsum(va) % BASE;
        b = hsum(vb) % BASE;
    }
    return adler32_ref(a | b << 16, p, len);
}
#define ADLER32 adler32_avx2
#define REPS 32768
#else
#define ADLER32 adler32_ref
#define REPS 4096
#endif

static uint8_t buf[BUF_BYTES];

int main(void) {
    const uint8_t *w = (const uint8_t *)"Wikipedia";
    if (adler32_ref(1, w, 9) != 0x11e60398 || ADLER32(1, w, 9) != 0x11e60398) {
        printf("adler32: the \"Wikipedia\" value differs\n");
        return 1;
    }
    for (size_t i = 0; i < BUF_BYTES; i++) buf[i] = (uint8_t)(i * 131 + (i >> 9));
    for (size_t len = 0; len < 200; len += 7)
        if (ADLER32(1, buf + 3, len) != adler32_ref(1, buf + 3, len)) {
            printf("adler32: the vector and portable sums differ at %zu bytes\n", len);
            return 1;
        }
    if (ADLER32(1, buf, BUF_BYTES) != adler32_ref(1, buf, BUF_BYTES)) {
        printf("adler32: the vector and portable sums differ\n");
        return 1;
    }

    // Each sum feeds the next input, so no iteration can be dropped.
    uint32_t sum = 1;
    double t0 = bench_ms();
    for (int r = 0; r < REPS; r++) {
        sum = ADLER32(sum, buf, BUF_BYTES);
        buf[r & (BUF_BYTES - 1)] ^= (uint8_t)sum;
    }
    double t1 = bench_ms();
    printf("adler32 %d x %d KiB sum=%08x in %.2f ms\n", REPS, BUF_BYTES / 1024, sum, t1 - t0);
    return 0;
}
