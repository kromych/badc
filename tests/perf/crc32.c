// CRC-32 (the reflected 0xEDB88320 polynomial of zlib and Ethernet) over a
// 64 KiB buffer, 32768 times on x86-64 and 4096 elsewhere. On x86-64 the
// buffer folds 64 bytes at a time with PCLMULQDQ into four 128-bit
// remainders, which fold into one, then to 64 bits and to the CRC by a
// Barrett reduction, as in Intel's "Fast CRC
// Computation for Generic Polynomials Using PCLMULQDQ" and zlib-ng's
// crc32_pclmulqdq; the bytes past the last 16-byte block take the table.
// Elsewhere the table loop runs. Both are checked against each other and
// the CRC catalogue's check value of "123456789"; self-times via
// bench_clock.h.
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include "bench_clock.h"

#define BUF_BYTES (64 * 1024)

static uint32_t table[256];

static void make_table(void) {
    for (uint32_t i = 0; i < 256; i++) {
        uint32_t c = i;
        for (int k = 0; k < 8; k++) c = c & 1 ? 0xEDB88320u ^ (c >> 1) : c >> 1;
        table[i] = c;
    }
}

static uint32_t crc32_ref(uint32_t crc, const uint8_t *p, size_t len) {
    uint32_t c = ~crc;
    while (len--) c = table[(c ^ *p++) & 0xff] ^ (c >> 8);
    return ~c;
}

#if defined(__x86_64__) || defined(_M_X64)
#include <immintrin.h>
#if defined(__GNUC__)
#define PCLMUL __attribute__((target("pclmul,sse4.1")))
#else
#define PCLMUL
#endif

// x^(4*128+32) and x^(4*128-32) mod P, then the one-block pair, the 64-bit
// fold constant, and P with its Barrett quotient, each bit-reflected.
static const uint64_t k1k2[2] = {0x0154442bd4, 0x01c6e41596};
static const uint64_t k3k4[2] = {0x01751997d0, 0x00ccaa009e};
static const uint64_t k5k0[2] = {0x0163cd6124, 0x0000000000};
static const uint64_t poly[2] = {0x01db710641, 0x01f7011641};

// The fold over `len` bytes, at least 64 and a multiple of 16, of the
// inverted running CRC `c`; returns the inverted CRC after them.
PCLMUL static uint32_t fold(uint32_t c, const uint8_t *p, size_t len) {
    __m128i x1 = _mm_loadu_si128((const __m128i *)p);
    __m128i x2 = _mm_loadu_si128((const __m128i *)(p + 16));
    __m128i x3 = _mm_loadu_si128((const __m128i *)(p + 32));
    __m128i x4 = _mm_loadu_si128((const __m128i *)(p + 48));
    x1 = _mm_xor_si128(x1, _mm_cvtsi32_si128((int)c));
    __m128i k = _mm_loadu_si128((const __m128i *)k1k2);
    for (p += 64, len -= 64; len >= 64; p += 64, len -= 64) {
        __m128i x5 = _mm_clmulepi64_si128(x1, k, 0x00);
        __m128i x6 = _mm_clmulepi64_si128(x2, k, 0x00);
        __m128i x7 = _mm_clmulepi64_si128(x3, k, 0x00);
        __m128i x8 = _mm_clmulepi64_si128(x4, k, 0x00);
        x1 = _mm_clmulepi64_si128(x1, k, 0x11);
        x2 = _mm_clmulepi64_si128(x2, k, 0x11);
        x3 = _mm_clmulepi64_si128(x3, k, 0x11);
        x4 = _mm_clmulepi64_si128(x4, k, 0x11);
        x1 = _mm_xor_si128(_mm_xor_si128(x1, x5), _mm_loadu_si128((const __m128i *)p));
        x2 = _mm_xor_si128(_mm_xor_si128(x2, x6), _mm_loadu_si128((const __m128i *)(p + 16)));
        x3 = _mm_xor_si128(_mm_xor_si128(x3, x7), _mm_loadu_si128((const __m128i *)(p + 32)));
        x4 = _mm_xor_si128(_mm_xor_si128(x4, x8), _mm_loadu_si128((const __m128i *)(p + 48)));
    }
    k = _mm_loadu_si128((const __m128i *)k3k4);
#define FOLD(next)                                                                                 \
    do {                                                                                           \
        __m128i lo = _mm_clmulepi64_si128(x1, k, 0x00);                                            \
        x1 = _mm_xor_si128(_mm_xor_si128(_mm_clmulepi64_si128(x1, k, 0x11), next), lo);            \
    } while (0)
    FOLD(x2);
    FOLD(x3);
    FOLD(x4);
    for (; len >= 16; p += 16, len -= 16) FOLD(_mm_loadu_si128((const __m128i *)p));
#undef FOLD
    const __m128i low32 = _mm_setr_epi32(-1, 0, -1, 0);
    x2 = _mm_clmulepi64_si128(x1, k, 0x10);
    x1 = _mm_xor_si128(_mm_srli_si128(x1, 8), x2);
    k = _mm_loadl_epi64((const __m128i *)k5k0);
    x2 = _mm_srli_si128(x1, 4);
    x1 = _mm_xor_si128(_mm_clmulepi64_si128(_mm_and_si128(x1, low32), k, 0x00), x2);
    k = _mm_loadu_si128((const __m128i *)poly);
    x2 = _mm_and_si128(_mm_clmulepi64_si128(_mm_and_si128(x1, low32), k, 0x10), low32);
    x1 = _mm_xor_si128(x1, _mm_clmulepi64_si128(x2, k, 0x00));
    return (uint32_t)_mm_extract_epi32(x1, 1);
}

static uint32_t crc32_pclmul(uint32_t crc, const uint8_t *p, size_t len) {
    if (len >= 64) {
        size_t n = len & ~(size_t)15;
        crc = ~fold(~crc, p, n);
        p += n, len -= n;
    }
    return crc32_ref(crc, p, len);
}
#define CRC32 crc32_pclmul
#define REPS 32768
#else
#define CRC32 crc32_ref
#define REPS 4096
#endif

static uint8_t buf[BUF_BYTES];

int main(void) {
    make_table();
    const uint8_t *check = (const uint8_t *)"123456789";
    if (crc32_ref(0, check, 9) != 0xCBF43926u || CRC32(0, check, 9) != 0xCBF43926u) {
        printf("crc32: the \"123456789\" check value differs\n");
        return 1;
    }
    for (size_t i = 0; i < BUF_BYTES; i++) buf[i] = (uint8_t)(i * 131 + (i >> 9));
    for (size_t len = 0; len < 300; len += 7)
        if (CRC32(0x1234, buf + 5, len) != crc32_ref(0x1234, buf + 5, len)) {
            printf("crc32: the folded and table CRCs differ at %zu bytes\n", len);
            return 1;
        }
    if (CRC32(0, buf, BUF_BYTES) != crc32_ref(0, buf, BUF_BYTES)) {
        printf("crc32: the folded and table CRCs differ\n");
        return 1;
    }

    // Each CRC feeds the next input, so no iteration can be dropped.
    uint32_t crc = 0;
    double t0 = bench_ms();
    for (int r = 0; r < REPS; r++) {
        crc = CRC32(crc, buf, BUF_BYTES);
        buf[r & (BUF_BYTES - 1)] ^= (uint8_t)crc;
    }
    double t1 = bench_ms();
    printf("crc32 %d x %d KiB crc=%08x in %.2f ms\n", REPS, BUF_BYTES / 1024, crc, t1 - t0);
    return 0;
}
