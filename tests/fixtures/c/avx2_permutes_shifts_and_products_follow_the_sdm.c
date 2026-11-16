// The AVX2 permutes, unpacks, shifts, products and lane transfers of
// <immintrin.h>: each one's results over random operands, mixed with the
// edge values, are hashed and compared with the hash the AVX2 instruction
// itself gives, recorded from a gcc -mavx2 build of this unit on an AVX2
// machine (-DPRINT prints the table). The exit code is the row of the
// first mismatch; elsewhere than x86-64 the unit is empty.
// snapshot-budget: exempt

#ifdef __x86_64__
#include <immintrin.h>
#include <stdio.h>
#include <string.h>

typedef unsigned long long u64;

static u64 seed = 0x9E3779B97F4A7C15ULL;

// Random bytes, about a quarter of them replaced by 00, 7F, 80 or FF.
static void rnd(unsigned char *b, int n) {
    static const unsigned char edge[4] = {0x00, 0x7F, 0x80, 0xFF};
    for (int k = 0; k < n; k++) {
        seed ^= seed >> 12;
        seed ^= seed << 25;
        seed ^= seed >> 27;
        u64 r = seed * 0x2545F4914F6CDD1DULL;
        b[k] = (r >> 60) < 4 ? edge[(r >> 58) & 3] : (unsigned char)(r >> 24);
    }
}

static u64 fnv(u64 h, const void *p, int n) {
    const unsigned char *b = p;
    for (int k = 0; k < n; k++)
        h = (h ^ b[k]) * 0x100000001B3ULL;
    return h;
}

#define ROWS 21
static u64 h[ROWS];

#define MIX(row, v)                                     \
    do {                                                \
        __m256i v_ = (v);                               \
        h[row] = fnv(h[row], &v_, (int)sizeof v_);      \
    } while (0)
#define MIXI(row, v)                                    \
    do {                                                \
        long long v_ = (v);                             \
        h[row] = fnv(h[row], &v_, (int)sizeof v_);      \
    } while (0)

static void round_of(void) {
    unsigned char ab[32], bb[32], cb[16], db[16];
    rnd(ab, 32);
    rnd(bb, 32);
    rnd(cb, 16);
    rnd(db, 16);
    __m256i a = _mm256_loadu_si256((const __m256i_u *)ab);
    __m256i b = _mm256_loadu_si256((const __m256i_u *)bb);
    __m128i c, d;
    memcpy(&c, cb, 16);
    memcpy(&d, db, 16);
    int s;
    long long q;
    memcpy(&s, bb, 4);
    memcpy(&q, bb + 8, 8);

    MIX(0, _mm256_broadcastsi128_si256(c));
    MIX(0, _mm256_set_m128i(c, d));
    MIX(0, _mm256_zextsi128_si256(c));
    MIX(1, _mm256_cmpgt_epi32(a, b));
    MIX(1, _mm256_cmpgt_epi64(a, b));
    MIXI(2, _mm256_extract_epi8(a, 0));
    MIXI(2, _mm256_extract_epi8(a, 17));
    MIXI(2, _mm256_extract_epi8(a, 31));
    MIXI(2, _mm256_extract_epi32(a, 2));
    MIXI(2, _mm256_extract_epi32(a, 7));
    MIXI(2, _mm256_extract_epi64(a, 1));
    MIXI(2, _mm256_extract_epi64(a, 3));
    MIX(3, _mm256_insert_epi8(a, s, 5));
    MIX(3, _mm256_insert_epi8(a, s, 30));
    MIX(3, _mm256_insert_epi32(a, s, 6));
    MIX(3, _mm256_insert_epi64(a, q, 2));
    MIX(4, _mm256_madd_epi16(a, b));
    MIX(5, _mm256_maddubs_epi16(a, b));
    MIX(6, _mm256_mul_epu32(a, b));
    MIX(6, _mm256_mullo_epi32(a, b));
    MIX(7, _mm256_permute2x128_si256(a, b, 0x00));
    MIX(7, _mm256_permute2x128_si256(a, b, 0x31));
    MIX(7, _mm256_permute2x128_si256(a, b, 0x12));
    MIX(7, _mm256_permute2x128_si256(a, b, 0x83));
    MIX(7, _mm256_permute2x128_si256(a, b, 0x28));
    MIX(8, _mm256_permute4x64_epi64(a, 0x1B));
    MIX(8, _mm256_permute4x64_epi64(a, 0xD8));
    MIX(9, _mm256_permutevar8x32_epi32(a, b));
    MIX(10, _mm256_sad_epu8(a, b));
    MIX(11, _mm256_shuffle_epi8(a, b));
    MIX(12, _mm256_slli_epi32(a, 0));
    MIX(12, _mm256_slli_epi32(a, 7));
    MIX(12, _mm256_slli_epi32(a, 31));
    MIX(12, _mm256_slli_epi32(a, 32));
    MIX(13, _mm256_slli_epi64(a, 13));
    MIX(13, _mm256_slli_epi64(a, 63));
    MIX(13, _mm256_slli_epi64(a, 64));
    MIX(14, _mm256_srli_epi32(a, 5));
    MIX(14, _mm256_srli_epi32(a, 32));
    MIX(14, _mm256_srli_epi64(a, 33));
    MIX(14, _mm256_srli_epi64(a, 64));
    MIX(15, _mm256_slli_si256(a, 0));
    MIX(15, _mm256_slli_si256(a, 3));
    MIX(15, _mm256_slli_si256(a, 15));
    MIX(15, _mm256_slli_si256(a, 16));
    MIX(16, _mm256_srli_si256(a, 1));
    MIX(16, _mm256_srli_si256(a, 9));
    MIX(16, _mm256_srli_si256(a, 16));
    MIX(17, _mm256_subs_epu16(a, b));
    MIX(18, _mm256_unpacklo_epi32(a, b));
    MIX(18, _mm256_unpackhi_epi32(a, b));
    MIX(19, _mm256_unpacklo_epi64(a, b));
    MIX(19, _mm256_unpackhi_epi64(a, b));
    MIX(20, _mm256_set_epi32(s, 1, -2, 3, 0x7FFFFFFF, (int)0x80000000, 6, ab[3]));
    MIX(20, _mm256_setr_epi32(s, 1, -2, 3, 0x7FFFFFFF, (int)0x80000000, 6, ab[3]));
    MIX(20, _mm256_set_epi64x(q, -1, 2, s));
    MIX(20, _mm256_set_epi8(ab[0], 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
                            18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, (char)0x80));
    MIX(20, _mm256_setr_epi8(ab[0], 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
                             18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, (char)0x80));
}

static const u64 want[ROWS] = {
    0xCD915CE89E1D3B7FULL,
    0x742CB736BA199761ULL,
    0x5AADFA1710CAB92DULL,
    0x14CFE0CD09B92107ULL,
    0x798B93C5F925B8CAULL,
    0xF2F0AC294F95C15AULL,
    0x12044FFB3E77F205ULL,
    0x5DFDD334BF854B75ULL,
    0x9D47890835233BA5ULL,
    0x84C913F63BCAB749ULL,
    0x7D82014783DA3D71ULL,
    0x00B3B432FE754C83ULL,
    0x7836BE9A9966D14DULL,
    0xA87C00D6547EC9C4ULL,
    0xB65C55738D277426ULL,
    0x278F5F61B75D4F76ULL,
    0x3521836632EE1C16ULL,
    0xE63EA22A3EB9BCAAULL,
    0x9DFC3F2152C3A299ULL,
    0xD7DF76E9AD1D1375ULL,
    0x504980CB5868FD15ULL,
};

int main(void) {
    for (int r = 0; r < ROWS; r++)
        h[r] = 0xCBF29CE484222325ULL;
    for (int k = 0; k < 400; k++)
        round_of();
#ifdef PRINT
    for (int r = 0; r < ROWS; r++)
        printf("    0x%016llXULL,\n", h[r]);
    return 0;
#else
    for (int r = 0; r < ROWS; r++)
        if (h[r] != want[r])
            return r + 1;
    return 0;
#endif
}
#else
int main(void) {
    return 0;
}
#endif
