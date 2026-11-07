// The 256-bit integer operations of <immintrin.h>, each checked against
// the result the SDM defines for its AVX or AVX2 instruction: a model over
// the lanes of the operands, on random lanes mixed with the edge values.
// The search loop is the one the UCRT's <wchar.h> runs for wmemchr, whose
// tail takes the unaligned low-lane transfers of <emmintrin.h>. The exit
// code is the line of the first mismatch; elsewhere than x86-64 the unit is
// empty. The checks call a helper per lane and keep their state across the
// calls.
// snapshot-budget: exempt

#ifdef __x86_64__
#include <immintrin.h>
#include <string.h>

typedef unsigned long long u64;

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

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

// Lane `i` of width `w` bytes, as an unsigned value.
static u64 lane(const unsigned char *b, int w, int i) {
    u64 v = 0;
    for (int k = 0; k < w; k++)
        v |= (u64)b[w * i + k] << (8 * k);
    return v;
}

static u64 mask(int w) {
    return w == 8 ? ~0ULL : (1ULL << (8 * w)) - 1;
}

static int check_lanes(const unsigned char *a, const unsigned char *b) {
    __m256i x = _mm256_loadu_si256((const __m256i_u *)a);
    __m256i y = _mm256_loadu_si256((const __m256i_u *)b);
    __m256i r[12] = {
        _mm256_add_epi8(x, y),   _mm256_add_epi16(x, y),  _mm256_add_epi32(x, y),
        _mm256_add_epi64(x, y),  _mm256_sub_epi8(x, y),   _mm256_sub_epi16(x, y),
        _mm256_sub_epi32(x, y),  _mm256_sub_epi64(x, y),  _mm256_cmpeq_epi8(x, y),
        _mm256_cmpeq_epi16(x, y), _mm256_cmpeq_epi32(x, y), _mm256_cmpeq_epi64(x, y),
    };
    for (int op = 0; op < 12; op++) {
        int w = 1 << (op & 3);
        unsigned char got[32];
        _mm256_storeu_si256((__m256i_u *)got, r[op]);
        for (int i = 0; i < 32 / w; i++) {
            u64 l = lane(a, w, i), m = lane(b, w, i);
            u64 want = op < 4 ? l + m : op < 8 ? l - m : l == m ? ~0ULL : 0;
            if (lane(got, w, i) != (want & mask(w)))
                return 1;
        }
    }
    __m256i logic[4] = {_mm256_and_si256(x, y), _mm256_andnot_si256(x, y),
                        _mm256_or_si256(x, y), _mm256_xor_si256(x, y)};
    for (int op = 0; op < 4; op++) {
        unsigned char got[32];
        _mm256_storeu_si256((__m256i_u *)got, logic[op]);
        for (int k = 0; k < 32; k++) {
            unsigned char want = op == 0   ? a[k] & b[k]
                                 : op == 1 ? (unsigned char)~a[k] & b[k]
                                 : op == 2 ? a[k] | b[k]
                                           : a[k] ^ b[k];
            if (got[k] != want)
                return 1;
        }
    }
    unsigned bits = 0;
    for (int k = 0; k < 32; k++)
        bits |= (unsigned)(a[k] >> 7) << k;
    if ((unsigned)_mm256_movemask_epi8(x) != bits)
        return 1;
    int zero = 1;
    for (int k = 0; k < 32; k++)
        zero &= (a[k] & b[k]) == 0;
    return _mm256_testz_si256(x, y) != zero;
}

static int check_moves(const unsigned char *a) {
    __m128i lo = _mm_loadu_si128((const __m128i *)a);
    __m128i hi = _mm_loadu_si128((const __m128i *)(a + 16));
    unsigned char got[32];
    __m256i b[4] = {_mm256_broadcastb_epi8(lo), _mm256_broadcastw_epi16(lo),
                    _mm256_broadcastd_epi32(lo), _mm256_broadcastq_epi64(lo)};
    for (int op = 0; op < 4; op++) {
        int w = 1 << op;
        _mm256_storeu_si256((__m256i_u *)got, b[op]);
        for (int i = 0; i < 32 / w; i++)
            if (lane(got, w, i) != lane(a, w, 0))
                return 1;
    }
    __m256i v = _mm256_inserti128_si256(_mm256_castsi128_si256(lo), hi, 1);
    _mm256_storeu_si256((__m256i_u *)got, v);
    if (memcmp(got, a, 32) != 0)
        return 1;
    __m128i back[2] = {_mm256_extracti128_si256(v, 0), _mm256_extracti128_si256(v, 1)};
    if (memcmp(&back[0], a, 16) != 0 || memcmp(&back[1], a + 16, 16) != 0)
        return 1;
    _mm256_storeu_si256((__m256i_u *)got, _mm256_setzero_si256());
    for (int k = 0; k < 32; k++)
        if (got[k] != 0)
            return 1;
    _mm256_storeu_si256((__m256i_u *)got, _mm256_set1_epi32(-2));
    return lane(got, 4, 7) != 0xFFFFFFFEu || lane(got, 4, 0) != 0xFFFFFFFEu;
}

// The low-lane loads zero the rest of the vector; the stores write the
// lane's bytes alone, at any alignment.
static int check_low_lane(const unsigned char *a) {
    unsigned char got[24];
    __m128i v[3] = {_mm_loadu_si64(a + 1), _mm_loadu_si32(a + 3), _mm_loadu_si16(a + 5)};
    for (int op = 0; op < 3; op++) {
        int n = 8 >> op;
        _mm_storeu_si128((__m128i *)got, v[op]);
        if (memcmp(got, a + 1 + 2 * op, n) != 0)
            return 1;
        for (int k = n; k < 16; k++)
            if (got[k] != 0)
                return 1;
    }
    memset(got, 0xAA, sizeof got);
    _mm_storeu_si64(got + 1, v[0]);
    _mm_storeu_si32(got + 11, v[1]);
    _mm_storeu_si16(got + 17, v[2]);
    return memcmp(got + 1, a + 1, 8) != 0 || got[0] != 0xAA || got[9] != 0xAA ||
           memcmp(got + 11, a + 3, 4) != 0 || got[15] != 0xAA ||
           memcmp(got + 17, a + 5, 2) != 0 || got[19] != 0xAA;
}

// <wchar.h>'s wmemchr over 16 units at a time.
static const unsigned short *find16(const unsigned short *s, unsigned short c, size_t n) {
    __m256i v2 = _mm256_broadcastw_epi16(_mm_cvtsi32_si128(c));
    size_t count = 0;
    for (; count + 16 <= n; count += 16) {
        __m256i v1 = _mm256_loadu_si256((const __m256i_u *)(s + count));
        unsigned m = (unsigned)_mm256_movemask_epi8(_mm256_cmpeq_epi16(v1, v2));
        if (m != 0)
            return s + count + (__builtin_ctz(m) >> 1);
    }
    for (; count < n; count++)
        if (s[count] == c)
            return s + count;
    return 0;
}

int main(void) {
    unsigned char a[32], b[32];
    for (int round = 0; round < 200; round++) {
        rnd(a, 32);
        rnd(b, 32);
        if (round & 1)
            memcpy(b + 8, a + 8, 8);
        CHECK(!check_lanes(a, b));
        CHECK(!check_moves(a));
        CHECK(!check_low_lane(a));
    }
    unsigned short text[40];
    for (int k = 0; k < 40; k++)
        text[k] = (unsigned short)(0x100 + k);
    CHECK(find16(text, 0x100 + 21, 40) == text + 21);
    CHECK(find16(text, 0x100 + 39, 40) == text + 39);
    CHECK(find16(text, 0x21, 40) == 0);
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif
