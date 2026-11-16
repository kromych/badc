// The SSE2 saturating lane arithmetic, PSADBW, SSSE3's PMADDUBSW, the
// packed-single bitwise operations and the cast family, each checked
// against the result the SDM defines for its instruction: a model over the
// bytes of the operands, on random lanes mixed with the edge values.
// _mm_prefetch issues a hint and changes no data; it is a function of
// MSVC's signature. The exit code is the line of the first mismatch;
// elsewhere than x86-64 the unit is empty. The checks call a helper per
// lane and keep their state across the calls.
// snapshot-budget: exempt

#ifdef __x86_64__
#ifdef _WIN32
// <winnt.h>, included first, defines MSVC's hint values, which the
// intrinsic header defines again.
#define _MM_HINT_T0 1
#define _MM_HINT_NTA 0
#endif
#include <string.h>
#include <tmmintrin.h>

// <winnt.h> declares the hint function again, with MSVC's signature.
void _mm_prefetch(char const *a, int sel);

typedef unsigned long long u64;

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

static u64 seed = 0x9E3779B97F4A7C15ULL;

// Random bytes, about a quarter of them replaced by 00, 7F, 80 or FF.
static void rnd(unsigned char b[16]) {
    static const unsigned char edge[4] = {0x00, 0x7F, 0x80, 0xFF};
    for (int k = 0; k < 16; k++) {
        seed ^= seed >> 12;
        seed ^= seed << 25;
        seed ^= seed >> 27;
        u64 r = seed * 0x2545F4914F6CDD1DULL;
        b[k] = (r >> 60) < 4 ? edge[(r >> 58) & 3] : (unsigned char)(r >> 24);
    }
}

static long clampl(long x, long lo, long hi) {
    return x < lo ? lo : x > hi ? hi : x;
}

// Lane `i` of width `w` bytes, signed or not.
static long lane(const unsigned char *b, int w, int i, int is_signed) {
    if (w == 1)
        return is_signed ? (signed char)b[i] : b[i];
    unsigned v = b[2 * i] | b[2 * i + 1] << 8;
    return is_signed ? (short)v : (long)v;
}

static int check_saturating(const unsigned char *a, const unsigned char *b) {
    __m128i x, y;
    memcpy(&x, a, 16);
    memcpy(&y, b, 16);
    __m128i r[8] = {
        _mm_adds_epi8(x, y), _mm_adds_epi16(x, y), _mm_adds_epu8(x, y), _mm_adds_epu16(x, y),
        _mm_subs_epi8(x, y), _mm_subs_epi16(x, y), _mm_subs_epu8(x, y), _mm_subs_epu16(x, y),
    };
    for (int op = 0; op < 8; op++) {
        int w = op & 1 ? 2 : 1, is_signed = !(op & 2), sub = op >= 4;
        long lo = is_signed ? -(1L << (8 * w - 1)) : 0;
        long hi = is_signed ? (1L << (8 * w - 1)) - 1 : (1L << 8 * w) - 1;
        unsigned char got[16];
        memcpy(got, &r[op], 16);
        for (int i = 0; i < 16 / w; i++) {
            long l = lane(a, w, i, is_signed), m = lane(b, w, i, is_signed);
            long want = clampl(sub ? l - m : l + m, lo, hi);
            if (lane(got, w, i, is_signed) != want)
                return 1;
        }
    }
    return 0;
}

static int check_sad_madd(const unsigned char *a, const unsigned char *b) {
    __m128i x, y;
    memcpy(&x, a, 16);
    memcpy(&y, b, 16);
    unsigned char sad[16], madd[16];
    __m128i s = _mm_sad_epu8(x, y), m = _mm_maddubs_epi16(x, y);
    memcpy(sad, &s, 16);
    memcpy(madd, &m, 16);
    for (int q = 0; q < 2; q++) {
        u64 want = 0, got;
        for (int k = 0; k < 8; k++)
            want += a[8 * q + k] > b[8 * q + k] ? a[8 * q + k] - b[8 * q + k]
                                                : b[8 * q + k] - a[8 * q + k];
        memcpy(&got, sad + 8 * q, 8);
        if (got != want)
            return 1;
    }
    for (int i = 0; i < 8; i++) {
        long want = clampl((long)a[2 * i] * (signed char)b[2 * i] +
                               (long)a[2 * i + 1] * (signed char)b[2 * i + 1],
                           -32768, 32767);
        if (lane(madd, 2, i, 1) != want)
            return 1;
    }
    return 0;
}

static int check_ps_logic(const unsigned char *a, const unsigned char *b) {
    __m128 x = _mm_castsi128_ps(_mm_loadu_si128((const __m128i *)a));
    __m128 y = _mm_castsi128_ps(_mm_loadu_si128((const __m128i *)b));
    __m128 r[4] = {_mm_and_ps(x, y), _mm_andnot_ps(x, y), _mm_or_ps(x, y), _mm_xor_ps(x, y)};
    for (int op = 0; op < 4; op++) {
        unsigned char got[16];
        _mm_storeu_si128((__m128i *)got, _mm_castps_si128(r[op]));
        for (int k = 0; k < 16; k++) {
            unsigned char want = op == 0   ? a[k] & b[k]
                                 : op == 1 ? (unsigned char)~a[k] & b[k]
                                 : op == 2 ? a[k] | b[k]
                                           : a[k] ^ b[k];
            if (got[k] != want)
                return 1;
        }
    }
    __m128d d = _mm_castps_pd(x);
    unsigned char back[16];
    _mm_storeu_si128((__m128i *)back, _mm_castps_si128(_mm_castpd_ps(d)));
    return memcmp(back, a, 16) != 0;
}

int main(void) {
    unsigned char a[16], b[16];
    for (int round = 0; round < 200; round++) {
        rnd(a);
        rnd(b);
        _mm_prefetch((const char *)a, _MM_HINT_T0);
        _mm_prefetch((const char *)b, _MM_HINT_NTA);
        CHECK(!check_saturating(a, b));
        CHECK(!check_sad_madd(a, b));
        CHECK(!check_ps_logic(a, b));
    }
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif
