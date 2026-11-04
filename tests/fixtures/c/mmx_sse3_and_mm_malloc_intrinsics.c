// <mmintrin.h>, <pmmintrin.h> and <mm_malloc.h>: each MMX and SSE3
// operation against the result the SDM defines for its instruction, the
// MXCSR denormals-are-zero bit set and read back, and _mm_malloc's
// alignment where the target serves the header. The values agree with gcc
// 16 on x86-64.

#if defined(__x86_64__) || (defined(__has_include) && __has_include(<mm_malloc.h>))
#include <mm_malloc.h>
#define HAVE_MM_MALLOC 1
#endif

#ifdef __x86_64__
#include <pmmintrin.h>

#define Q(m) ((unsigned long long)_mm_cvtm64_si64(m))

static int mmx(void) {
    if (_mm_cvtsi64_si32(_mm_set_pi16(4, 3, 2, 1)) != 0x00020001)
        return 1;
    if (Q(_mm_set_pi32(7, 5)) != 0x0000000700000005ULL)
        return 2;
    if (Q(_mm_setr_pi8(1, 2, 3, 4, 5, 6, 7, 8)) != 0x0807060504030201ULL)
        return 3;
    if (Q(_mm_packs_pi16(_mm_setr_pi16(300, -300, 5, -5), _mm_setr_pi16(127, -128, 32767, -32768))) !=
        0x807F807FFB05807FULL)
        return 4;
    if (Q(_mm_packs_pu16(_mm_setr_pi16(300, -300, 5, 255), _mm_setr_pi16(256, 0, 128, -1))) !=
        0x008000FFFF0500FFULL)
        return 5;
    if (Q(_mm_packs_pi32(_mm_setr_pi32(70000, -70000), _mm_setr_pi32(1, -1))) !=
        0xFFFF000180007FFFULL)
        return 6;
    __m64 lo8 = _mm_setr_pi8(1, 2, 3, 4, 5, 6, 7, 8), hi8 = _mm_setr_pi8(11, 12, 13, 14, 15, 16, 17, 18);
    if (Q(_mm_unpacklo_pi8(lo8, hi8)) != 0x0E040D030C020B01ULL ||
        Q(_mm_unpackhi_pi8(lo8, hi8)) != 0x1208110710060F05ULL)
        return 7;
    if (Q(_mm_unpackhi_pi16(_mm_setr_pi16(1, 2, 3, 4), _mm_setr_pi16(5, 6, 7, 8))) !=
        0x0008000400070003ULL)
        return 8;
    if (Q(_mm_unpacklo_pi32(_mm_set_pi32(2, 1), _mm_set_pi32(4, 3))) != 0x0000000300000001ULL ||
        Q(_mm_unpackhi_pi32(_mm_set_pi32(2, 1), _mm_set_pi32(4, 3))) != 0x0000000400000002ULL)
        return 9;
    if (Q(_mm_add_pi8(_mm_set1_pi8(100), _mm_set1_pi8(100))) != 0xC8C8C8C8C8C8C8C8ULL ||
        Q(_mm_adds_pi8(_mm_set1_pi8(100), _mm_set1_pi8(100))) != 0x7F7F7F7F7F7F7F7FULL ||
        Q(_mm_adds_pu8(_mm_set1_pi8((char)200), _mm_set1_pi8(100))) != 0xFFFFFFFFFFFFFFFFULL)
        return 10;
    if (Q(_mm_subs_pu16(_mm_set1_pi16(5), _mm_set1_pi16(7))) != 0 ||
        Q(_mm_subs_pi16(_mm_set1_pi16(-32000), _mm_set1_pi16(1000))) != 0x8000800080008000ULL ||
        Q(_mm_adds_pu16(_mm_set1_pi16(-1), _mm_set1_pi16(1))) != 0xFFFFFFFFFFFFFFFFULL ||
        Q(_mm_subs_pi8(_mm_set1_pi8(-100), _mm_set1_pi8(100))) != 0x8080808080808080ULL)
        return 11;
    if (Q(_mm_madd_pi16(_mm_setr_pi16(1, 2, 3, 4), _mm_setr_pi16(5, 6, 7, 8))) !=
            0x0000003500000011ULL ||
        Q(_mm_madd_pi16(_mm_set1_pi16(-32768), _mm_set1_pi16(-32768))) != 0x8000000080000000ULL)
        return 12;
    if (Q(_mm_mulhi_pi16(_mm_set1_pi16(-2), _mm_set1_pi16(16384))) != 0xFFFFFFFFFFFFFFFFULL ||
        Q(_mm_mullo_pi16(_mm_set1_pi16(300), _mm_set1_pi16(300))) != 0x5F905F905F905F90ULL)
        return 13;
    if (Q(_mm_slli_pi16(_mm_set1_pi16(1), 15)) != 0x8000800080008000ULL ||
        Q(_mm_slli_pi16(_mm_set1_pi16(1), 16)) != 0 ||
        Q(_mm_srai_pi16(_mm_set1_pi16(-32768), 20)) != 0xFFFFFFFFFFFFFFFFULL ||
        Q(_mm_srli_pi32(_mm_set1_pi32(-1), 28)) != 0x0000000F0000000FULL)
        return 14;
    if (Q(_mm_sll_si64(_mm_cvtsi64_m64(1), _mm_cvtsi64_m64(63))) != 0x8000000000000000ULL ||
        Q(_mm_sll_si64(_mm_cvtsi64_m64(1), _mm_cvtsi64_m64(64))) != 0 ||
        Q(_mm_srl_si64(_mm_cvtsi64_m64(-1), _mm_cvtsi64_m64(4))) != 0x0FFFFFFFFFFFFFFFULL ||
        Q(_mm_sra_pi32(_mm_set1_pi32(-8), _mm_cvtsi64_m64(1))) != 0xFFFFFFFCFFFFFFFCULL)
        return 15;
    __m64 x = _mm_cvtsi64_m64((long long)0xF0F0F0F0F0F0F0F0ULL);
    __m64 y = _mm_cvtsi64_m64((long long)0xFF00FF00FF00FF00ULL);
    if (Q(_mm_and_si64(x, y)) != 0xF000F000F000F000ULL ||
        Q(_mm_andnot_si64(x, y)) != 0x0F000F000F000F00ULL ||
        Q(_mm_or_si64(x, y)) != 0xFFF0FFF0FFF0FFF0ULL || Q(_mm_xor_si64(x, y)) != 0x0FF00FF00FF00FF0ULL)
        return 16;
    if (Q(_mm_cmpeq_pi16(_mm_setr_pi16(1, 2, 3, 4), _mm_setr_pi16(1, 0, 3, 0))) !=
            0x0000FFFF0000FFFFULL ||
        Q(_mm_cmpgt_pi32(_mm_set_pi32(-1, 5), _mm_set_pi32(0, 4))) != 0x00000000FFFFFFFFULL ||
        Q(_mm_cmpgt_pi8(_mm_set1_pi8(-1), _mm_setzero_si64())) != 0)
        return 17;
    if (Q(_mm_add_si64(_mm_cvtsi64_m64(-1), _mm_cvtsi64_m64(2))) != 1 ||
        Q(_m_paddw(_mm_setr_pi16(1, 2, 3, 4), _mm_set1_pi16(1))) != 0x0005000400030002ULL)
        return 18;
    _mm_empty();
    return 0;
}

static int sse3(void) {
    __m128 a = {1, 2, 3, 4}, b = {5, 6, 7, 8}, h = {0.5f, 0.5f, 0.5f, 0.5f};
    __m128 r = _mm_hadd_ps(a, b);
    if (r[0] != 3 || r[1] != 7 || r[2] != 11 || r[3] != 15)
        return 21;
    r = _mm_hsub_ps(a, b);
    if (r[0] != -1 || r[1] != -1 || r[2] != -1 || r[3] != -1)
        return 22;
    r = _mm_addsub_ps(a, h);
    if (r[0] != 0.5f || r[1] != 2.5f || r[2] != 2.5f || r[3] != 4.5f)
        return 23;
    r = _mm_movehdup_ps(a);
    __m128 l = _mm_moveldup_ps(a);
    if (r[0] != 2 || r[3] != 4 || l[1] != 1 || l[2] != 3)
        return 24;
    __m128d d = _mm_addsub_pd((__m128d){1.5, 2.5}, (__m128d){0.5, 0.25});
    if (d[0] != 1.0 || d[1] != 2.75)
        return 25;
    d = _mm_hadd_pd((__m128d){1, 2}, (__m128d){3, 4});
    __m128d s = _mm_hsub_pd((__m128d){1, 2}, (__m128d){3, 5});
    if (d[0] != 3 || d[1] != 7 || s[0] != -1 || s[1] != -2)
        return 26;
    double one = 6.25;
    d = _mm_loaddup_pd(&one);
    s = _mm_movedup_pd((__m128d){7, 8});
    if (d[0] != 6.25 || d[1] != 6.25 || s[0] != 7 || s[1] != 7)
        return 27;
    unsigned char bytes[17];
    for (int i = 0; i < 17; i++)
        bytes[i] = (unsigned char)i;
    __m128i u = _mm_lddqu_si128((__m128i const *)(bytes + 1));
    if (_mm_cvtsi128_si32(u) != 0x04030201)
        return 28;
    unsigned int csr = _mm_getcsr();
    _MM_SET_DENORMALS_ZERO_MODE(_MM_DENORMALS_ZERO_ON);
    int daz = _MM_GET_DENORMALS_ZERO_MODE() == _MM_DENORMALS_ZERO_ON;
    _mm_setcsr(csr);
    if (!daz || _mm_getcsr() != csr)
        return 29;
    return 0;
}

// Compiled, not run: MWAIT need not be enabled outside ring 0.
void (*volatile keep_wait)(void const *);
static void wait_on(void const *p) {
    _mm_monitor(p, 0, 0);
    _mm_mwait(0, 0);
}
#endif

#ifdef HAVE_MM_MALLOC
static int allocator(void) {
    unsigned char *p = _mm_malloc(100, 64);
    if (!p || ((unsigned long long)p & 63))
        return 41;
    for (int i = 0; i < 100; i++)
        p[i] = (unsigned char)i;
    _mm_free(p);
    void *q = _mm_malloc(16, 1);
    if (!q || ((unsigned long long)q & (sizeof(void *) - 1)))
        return 42;
    _mm_free(q);
    return _mm_malloc(16, 24) ? 43 : 0;
}
#endif

int main(void) {
    int r = 0;
#ifdef __x86_64__
    keep_wait = wait_on;
    if ((r = mmx()) || (r = sse3()))
        return r;
#endif
#ifdef HAVE_MM_MALLOC
    r = allocator();
#endif
    return r;
}
