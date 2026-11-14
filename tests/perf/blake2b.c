// BLAKE2b-512 (RFC 7693) over a 64 KiB buffer, 3072 times. On x86-64 the
// compression function keeps the state as four rows of four 64-bit lanes
// in __m256i values, as the vectorized HACL* and libsodium kernels do: the
// G function is lane-parallel adds, xors and rotations (shuffles for the
// byte-multiple counts), and the diagonal step permutes the rows. Elsewhere
// the portable compression runs. Both are checked against the RFC's "abc"
// vector and against each other; self-times via bench_clock.h.
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "bench_clock.h"

#define BUF_BYTES (64 * 1024)
#define REPS 3072

static const uint64_t IV[8] = {
    0x6a09e667f3bcc908ULL, 0xbb67ae8584caa73bULL, 0x3c6ef372fe94f82bULL, 0xa54ff53a5f1d36f1ULL,
    0x510e527fade682d1ULL, 0x9b05688c2b3e6c1fULL, 0x1f83d9abfb41bd6bULL, 0x5be0cd19137e2179ULL,
};

static const uint8_t SIGMA[12][16] = {
    {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},
    {14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3},
    {11, 8, 12, 0, 5, 2, 15, 13, 10, 14, 3, 6, 7, 1, 9, 4},
    {7, 9, 3, 1, 13, 12, 11, 14, 2, 6, 5, 10, 4, 0, 15, 8},
    {9, 0, 5, 7, 2, 4, 10, 15, 14, 1, 11, 12, 6, 8, 3, 13},
    {2, 12, 6, 10, 0, 11, 8, 3, 4, 13, 7, 5, 15, 14, 1, 9},
    {12, 5, 1, 15, 14, 13, 4, 10, 0, 7, 6, 3, 9, 2, 8, 11},
    {13, 11, 7, 14, 12, 1, 3, 9, 5, 0, 15, 4, 8, 6, 2, 10},
    {6, 15, 14, 9, 11, 3, 0, 8, 12, 2, 13, 7, 1, 4, 10, 5},
    {10, 2, 8, 4, 7, 6, 1, 5, 15, 11, 9, 14, 3, 12, 13, 0},
    {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},
    {14, 10, 4, 8, 9, 15, 13, 6, 1, 12, 0, 2, 11, 7, 5, 3},
};

typedef void compress_fn(uint64_t h[8], const uint8_t block[128], uint64_t t, int last);

static uint64_t rotr64(uint64_t x, int n) { return (x >> n) | (x << (64 - n)); }

static void compress_ref(uint64_t h[8], const uint8_t block[128], uint64_t t, int last) {
    uint64_t m[16], v[16];
    memcpy(m, block, sizeof m);
    for (int i = 0; i < 8; i++) v[i] = h[i], v[i + 8] = IV[i];
    v[12] ^= t;
    if (last) v[14] = ~v[14];
    for (int r = 0; r < 12; r++) {
        const uint8_t *s = SIGMA[r];
#define G(a, b, c, d, x, y)                                                                        \
    v[a] += v[b] + x, v[d] = rotr64(v[d] ^ v[a], 32), v[c] += v[d], v[b] = rotr64(v[b] ^ v[c], 24), \
    v[a] += v[b] + y, v[d] = rotr64(v[d] ^ v[a], 16), v[c] += v[d], v[b] = rotr64(v[b] ^ v[c], 63)
        G(0, 4, 8, 12, m[s[0]], m[s[1]]);
        G(1, 5, 9, 13, m[s[2]], m[s[3]]);
        G(2, 6, 10, 14, m[s[4]], m[s[5]]);
        G(3, 7, 11, 15, m[s[6]], m[s[7]]);
        G(0, 5, 10, 15, m[s[8]], m[s[9]]);
        G(1, 6, 11, 12, m[s[10]], m[s[11]]);
        G(2, 7, 8, 13, m[s[12]], m[s[13]]);
        G(3, 4, 9, 14, m[s[14]], m[s[15]]);
#undef G
    }
    for (int i = 0; i < 8; i++) h[i] ^= v[i] ^ v[i + 8];
}

#if defined(__x86_64__) || defined(_M_X64)
#include <immintrin.h>
#if defined(__GNUC__)
#define AVX2 __attribute__((target("avx2")))
#else
#define AVX2
#endif

AVX2 static void compress_avx2(uint64_t h[8], const uint8_t block[128], uint64_t t, int last) {
    const __m256i r16 = _mm256_setr_epi8(2, 3, 4, 5, 6, 7, 0, 1, 10, 11, 12, 13, 14, 15, 8, 9, 2, 3, 4,
                                         5, 6, 7, 0, 1, 10, 11, 12, 13, 14, 15, 8, 9);
    const __m256i r24 = _mm256_setr_epi8(3, 4, 5, 6, 7, 0, 1, 2, 11, 12, 13, 14, 15, 8, 9, 10, 3, 4, 5,
                                         6, 7, 0, 1, 2, 11, 12, 13, 14, 15, 8, 9, 10);
    uint64_t m[16];
    memcpy(m, block, sizeof m);
    __m256i a = _mm256_loadu_si256((const __m256i *)h);
    __m256i b = _mm256_loadu_si256((const __m256i *)(h + 4));
    __m256i c = _mm256_loadu_si256((const __m256i *)IV);
    __m256i d = _mm256_xor_si256(_mm256_loadu_si256((const __m256i *)(IV + 4)),
                                 _mm256_set_epi64x(0, last ? -1 : 0, 0, (long long)t));
    const __m256i a0 = a, b0 = b;
    for (int r = 0; r < 12; r++) {
        const uint8_t *s = SIGMA[r];
#define G(x, y)                                                                                    \
    a = _mm256_add_epi64(_mm256_add_epi64(a, b), x);                                               \
    d = _mm256_shuffle_epi32(_mm256_xor_si256(d, a), _MM_SHUFFLE(2, 3, 0, 1));                     \
    c = _mm256_add_epi64(c, d);                                                                    \
    b = _mm256_shuffle_epi8(_mm256_xor_si256(b, c), r24);                                          \
    a = _mm256_add_epi64(_mm256_add_epi64(a, b), y);                                               \
    d = _mm256_shuffle_epi8(_mm256_xor_si256(d, a), r16);                                          \
    c = _mm256_add_epi64(c, d);                                                                    \
    b = _mm256_xor_si256(b, c);                                                                    \
    b = _mm256_or_si256(_mm256_srli_epi64(b, 63), _mm256_add_epi64(b, b))
        G(_mm256_set_epi64x(m[s[6]], m[s[4]], m[s[2]], m[s[0]]),
          _mm256_set_epi64x(m[s[7]], m[s[5]], m[s[3]], m[s[1]]));
        b = _mm256_permute4x64_epi64(b, _MM_SHUFFLE(0, 3, 2, 1));
        c = _mm256_permute4x64_epi64(c, _MM_SHUFFLE(1, 0, 3, 2));
        d = _mm256_permute4x64_epi64(d, _MM_SHUFFLE(2, 1, 0, 3));
        G(_mm256_set_epi64x(m[s[14]], m[s[12]], m[s[10]], m[s[8]]),
          _mm256_set_epi64x(m[s[15]], m[s[13]], m[s[11]], m[s[9]]));
        b = _mm256_permute4x64_epi64(b, _MM_SHUFFLE(2, 1, 0, 3));
        c = _mm256_permute4x64_epi64(c, _MM_SHUFFLE(1, 0, 3, 2));
        d = _mm256_permute4x64_epi64(d, _MM_SHUFFLE(0, 3, 2, 1));
#undef G
    }
    _mm256_storeu_si256((__m256i *)h, _mm256_xor_si256(a0, _mm256_xor_si256(a, c)));
    _mm256_storeu_si256((__m256i *)(h + 4), _mm256_xor_si256(b0, _mm256_xor_si256(b, d)));
}
#define COMPRESS compress_avx2
#else
#define COMPRESS compress_ref
#endif

static void blake2b(compress_fn *compress, uint8_t out[64], const uint8_t *in, size_t len) {
    uint64_t h[8];
    memcpy(h, IV, sizeof h);
    h[0] ^= 0x01010000 ^ 64;
    uint64_t t = 0;
    while (len > 128) {
        t += 128;
        compress(h, in, t, 0);
        in += 128, len -= 128;
    }
    uint8_t last[128] = {0};
    memcpy(last, in, len);
    compress(h, last, t + len, 1);
    memcpy(out, h, 64);
}

static uint8_t buf[BUF_BYTES];

int main(void) {
    static const uint8_t abc[64] = {
        0xba, 0x80, 0xa5, 0x3f, 0x98, 0x1c, 0x4d, 0x0d, 0x6a, 0x27, 0x97, 0xb6, 0x9f, 0x12, 0xf6, 0xe9,
        0x4c, 0x21, 0x2f, 0x14, 0x68, 0x5a, 0xc4, 0xb7, 0x4b, 0x12, 0xbb, 0x6f, 0xdb, 0xff, 0xa2, 0xd1,
        0x7d, 0x87, 0xc5, 0x39, 0x2a, 0xab, 0x79, 0x2d, 0xc2, 0x52, 0xd5, 0xde, 0x45, 0x33, 0xcc, 0x95,
        0x18, 0xd3, 0x8a, 0xa8, 0xdb, 0xf1, 0x92, 0x5a, 0xb9, 0x23, 0x86, 0xed, 0xd4, 0x00, 0x99, 0x23,
    };
    uint8_t ref[64], got[64];
    blake2b(compress_ref, ref, (const uint8_t *)"abc", 3);
    blake2b(COMPRESS, got, (const uint8_t *)"abc", 3);
    if (memcmp(ref, abc, 64) != 0 || memcmp(got, abc, 64) != 0) {
        printf("blake2b: the \"abc\" digest differs from RFC 7693's\n");
        return 1;
    }
    for (size_t i = 0; i < BUF_BYTES; i++) buf[i] = (uint8_t)(i * 131 + (i >> 9));
    blake2b(compress_ref, ref, buf, BUF_BYTES);
    blake2b(COMPRESS, got, buf, BUF_BYTES);
    if (memcmp(ref, got, 64) != 0) {
        printf("blake2b: the vector and portable digests differ\n");
        return 1;
    }

    // Each digest feeds the next input, so no iteration can be dropped.
    double t0 = bench_ms();
    for (int r = 0; r < REPS; r++) {
        blake2b(COMPRESS, got, buf, BUF_BYTES);
        buf[r] += (uint8_t)(got[0] | 1);
    }
    double t1 = bench_ms();
    printf("blake2b-512 %d x %d KiB first=%02x in %.2f ms\n", REPS, BUF_BYTES / 1024, got[0],
           t1 - t0);
    return 0;
}
