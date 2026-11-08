// The SHA extensions' intrinsics (<immintrin.h>), each against the result
// the instruction gives for one set of operands, as measured on a processor
// with them; element 0 first. Exits 0 when every form matches; off x86-64
// the unit checks nothing.

#if defined(__x86_64__)
#include <immintrin.h>

static __m128i v(unsigned e0, unsigned e1, unsigned e2, unsigned e3) {
    return _mm_set_epi32((int)e3, (int)e2, (int)e1, (int)e0);
}

static int is(__m128i r, unsigned e0, unsigned e1, unsigned e2, unsigned e3) {
    return _mm_movemask_epi8(_mm_cmpeq_epi32(r, v(e0, e1, e2, e3))) == 0xffff;
}

int main(void) {
    __m128i a = v(0xd3dcc5a2, 0xa70480db, 0xd665ca49, 0x0daa9b5f);
    __m128i b = v(0xc21fde95, 0x3ead5c56, 0xcd1d0205, 0xaf5a022b);
    __m128i k = v(0x20da578c, 0xafe59c32, 0x69acad68, 0x961b39b6);
    if (!is(_mm_sha1nexte_epu32(a, b), 0xc21fde95, 0x3ead5c56, 0xcd1d0205, 0x72c4a902))
        return 1;
    if (!is(_mm_sha1msg1_epu32(a, b), 0x1ec1c7a7, 0x085e82f0, 0x05b90feb, 0xaaae1b84))
        return 2;
    if (!is(_mm_sha1msg2_epu32(a, b), 0xa567ee2e, 0xca36bc9c, 0xd1912c3f, 0x816f32b5))
        return 3;
    if (!is(_mm_sha1rnds4_epu32(a, b, 0), 0x11b31b64, 0x9f258176, 0x464e48ab, 0xefff836d))
        return 4;
    if (!is(_mm_sha1rnds4_epu32(a, b, 1), 0x5d913a37, 0x2dea0e03, 0x0a4a0700, 0x1927c1b5))
        return 5;
    if (!is(_mm_sha1rnds4_epu32(a, b, 2), 0xf2c37aec, 0xedd6e375, 0x23493796, 0x2347af9e))
        return 6;
    if (!is(_mm_sha1rnds4_epu32(a, b, 3), 0xb4736fc4, 0x6112f53b, 0xa0cda80e, 0x0f2332cf))
        return 7;
    if (!is(_mm_sha256rnds2_epu32(a, b, k), 0xd2be0fd9, 0x3ab9d7d7, 0x1bf59c86, 0x712bdf61))
        return 8;
    if (!is(_mm_sha256msg1_epu32(a, b), 0x5775367d, 0xa2f6881f, 0xefdf8f80, 0xd20d5047))
        return 9;
    if (!is(_mm_sha256msg2_epu32(a, b), 0xf54dde0f, 0xe87ff5a1, 0x2b6121c1, 0x1209722c))
        return 10;
    return 0;
}
#else
int main(void) { return 0; }
#endif
