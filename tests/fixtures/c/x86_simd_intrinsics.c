/* x86 SIMD intrinsics: every operation the bundled headers carry,
** checked against values computed without them. The AES case is the
** FIPS-197 appendix C.1 known answer run through the AES-NI key
** expansion and cipher. Returns 0 on success, the case number
** otherwise. */
#include <x86intrin.h>

static int same(__m128i a, const unsigned char *want) {
    unsigned char got[16];
    int i;
    _mm_storeu_si128((__m128i *)got, a);
    for (i = 0; i < 16; i++) {
        if (got[i] != want[i]) {
            return 0;
        }
    }
    return 1;
}

static __m128i load(const unsigned char *p) {
    return _mm_loadu_si128((const __m128i *)p);
}

static __m128i key_step(__m128i k, __m128i assist) {
    __m128i t = _mm_shuffle_epi32(assist, 0xff);
    __m128i s = _mm_slli_si128(k, 4);
    k = _mm_xor_si128(k, s);
    s = _mm_slli_si128(s, 4);
    k = _mm_xor_si128(k, s);
    s = _mm_slli_si128(s, 4);
    k = _mm_xor_si128(k, s);
    return _mm_xor_si128(k, t);
}

static int aes128_known_answer(void) {
    static const unsigned char key[16] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
                                          0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f};
    static const unsigned char pt[16] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
                                         0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff};
    static const unsigned char ct[16] = {0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x04, 0x30,
                                         0xd8, 0xcd, 0xb7, 0x80, 0x70, 0xb4, 0xc5, 0x5a};
    __m128i ks[11];
    __m128i m;
    int i;
    ks[0] = load(key);
    ks[1] = key_step(ks[0], _mm_aeskeygenassist_si128(ks[0], 0x01));
    ks[2] = key_step(ks[1], _mm_aeskeygenassist_si128(ks[1], 0x02));
    ks[3] = key_step(ks[2], _mm_aeskeygenassist_si128(ks[2], 0x04));
    ks[4] = key_step(ks[3], _mm_aeskeygenassist_si128(ks[3], 0x08));
    ks[5] = key_step(ks[4], _mm_aeskeygenassist_si128(ks[4], 0x10));
    ks[6] = key_step(ks[5], _mm_aeskeygenassist_si128(ks[5], 0x20));
    ks[7] = key_step(ks[6], _mm_aeskeygenassist_si128(ks[6], 0x40));
    ks[8] = key_step(ks[7], _mm_aeskeygenassist_si128(ks[7], 0x80));
    ks[9] = key_step(ks[8], _mm_aeskeygenassist_si128(ks[8], 0x1b));
    ks[10] = key_step(ks[9], _mm_aeskeygenassist_si128(ks[9], 0x36));
    m = _mm_xor_si128(load(pt), ks[0]);
    for (i = 1; i < 10; i++) {
        m = _mm_aesenc_si128(m, ks[i]);
    }
    m = _mm_aesenclast_si128(m, ks[10]);
    if (!same(m, ct)) {
        return 0;
    }
    m = _mm_xor_si128(load(ct), ks[10]);
    for (i = 9; i > 0; i--) {
        m = _mm_aesdec_si128(m, _mm_aesimc_si128(ks[i]));
    }
    m = _mm_aesdeclast_si128(m, ks[0]);
    return same(m, pt);
}

int main(void) {
    unsigned char buf[16];
    unsigned int lanes[4];
    __m128i a, b, r;
    int i;

    /* Lane arithmetic and logic against a scalar reference. */
    a = _mm_set_epi32(4, 3, 2, 1);
    b = _mm_set_epi32(400, 300, 200, 100);
    _mm_storeu_si128((__m128i *)lanes, _mm_add_epi32(a, b));
    if (lanes[0] != 101 || lanes[1] != 202 || lanes[2] != 303 || lanes[3] != 404) {
        return 1;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_xor_si128(a, b));
    if (lanes[0] != (1u ^ 100u) || lanes[3] != (4u ^ 400u)) {
        return 2;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_or_si128(a, b));
    if (lanes[1] != (2u | 200u)) {
        return 3;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_and_si128(a, b));
    if (lanes[2] != (3u & 300u)) {
        return 4;
    }

    /* A doubleword add must not carry between lanes; a quadword one
    ** must carry within its own lane. */
    a = _mm_set_epi32(0, 0xffffffff, 0, 0xffffffff);
    b = _mm_set_epi32(0, 0, 0, 1);
    _mm_storeu_si128((__m128i *)lanes, _mm_add_epi32(a, b));
    if (lanes[0] != 0 || lanes[1] != 0) {
        return 5;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_add_epi64(a, b));
    if (lanes[0] != 0 || lanes[1] != 1) {
        return 6;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_sub_epi64(_mm_add_epi64(a, b), b));
    if (lanes[0] != 0xffffffff || lanes[1] != 0) {
        return 7;
    }

    /* Shifts, by a constant and by a value the compiler cannot fold. */
    a = _mm_set_epi32(0x11223344, 0x55667788, 0x99aabbcc, 0xddeeff00);
    _mm_storeu_si128((__m128i *)lanes, _mm_slli_epi32(a, 4));
    if (lanes[3] != 0x12233440u) {
        return 8;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_srli_epi32(a, 4));
    if (lanes[3] != 0x01122334u) {
        return 9;
    }
    i = 8;
    _mm_storeu_si128((__m128i *)lanes, _mm_srli_epi32(a, i));
    if (lanes[3] != 0x00112233u) {
        return 10;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_srli_epi32(a, 32));
    if (lanes[0] != 0 || lanes[3] != 0) {
        return 11;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_slli_epi64(a, 8));
    if (lanes[0] != 0xeeff0000u || lanes[1] != 0xaabbccddu) {
        return 12;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_srli_epi64(a, 8));
    if (lanes[0] != 0xccddeeffu || lanes[1] != 0x0099aabbu) {
        return 13;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_slli_si128(a, 4));
    if (lanes[0] != 0 || lanes[1] != 0xddeeff00u) {
        return 14;
    }

    /* Word shifts and the word shuffles, checked byte-wise. */
    a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
    _mm_storeu_si128((__m128i *)buf, _mm_slli_epi16(a, 8));
    if (buf[0] != 0 || buf[1] != 0 || buf[2] != 0 || buf[3] != 2) {
        return 15;
    }
    _mm_storeu_si128((__m128i *)buf, _mm_srli_epi16(a, 8));
    if (buf[0] != 1 || buf[1] != 0 || buf[2] != 3) {
        return 16;
    }
    _mm_storeu_si128((__m128i *)buf, _mm_shufflelo_epi16(a, 0x1b));
    if (buf[0] != 6 || buf[1] != 7 || buf[6] != 0 || buf[7] != 1 || buf[8] != 8) {
        return 17;
    }
    _mm_storeu_si128((__m128i *)buf, _mm_shufflehi_epi16(a, 0x1b));
    if (buf[0] != 0 || buf[8] != 14 || buf[9] != 15 || buf[14] != 8 || buf[15] != 9) {
        return 18;
    }

    /* Doubleword and byte shuffles. */
    a = _mm_set_epi32(3, 2, 1, 0);
    _mm_storeu_si128((__m128i *)lanes, _mm_shuffle_epi32(a, 0x93));
    if (lanes[0] != 3 || lanes[1] != 0 || lanes[2] != 1 || lanes[3] != 2) {
        return 19;
    }
    a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
    b = _mm_set_epi8((char)0x80, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
    _mm_storeu_si128((__m128i *)buf, _mm_shuffle_epi8(a, b));
    if (buf[0] != 15 || buf[14] != 1 || buf[15] != 0) {
        return 20;
    }

    /* Quadword interleave and compare. */
    a = _mm_set_epi32(9, 9, 1, 1);
    b = _mm_set_epi32(8, 8, 2, 2);
    _mm_storeu_si128((__m128i *)lanes, _mm_unpacklo_epi64(a, b));
    if (lanes[0] != 1 || lanes[1] != 1 || lanes[2] != 2 || lanes[3] != 2) {
        return 21;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_cmpeq_epi64(a, a));
    if (lanes[0] != 0xffffffffu || lanes[3] != 0xffffffffu) {
        return 22;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_cmpeq_epi64(a, b));
    if (lanes[0] != 0 || lanes[3] != 0) {
        return 23;
    }

    /* Element access. */
    a = _mm_set_epi32(0x77778888, 0x55556666, 0x33334444, 0x11112222);
    if (_mm_extract_epi16(a, 0) != 0x2222 || _mm_extract_epi16(a, 7) != 0x7777) {
        return 24;
    }
    if (_mm_extract_epi32(a, 2) != 0x55556666) {
        return 25;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_insert_epi32(a, 0x0a0b0c0d, 1));
    if (lanes[1] != 0x0a0b0c0du || lanes[0] != 0x11112222u) {
        return 26;
    }

    /* Carry-less multiply: (x + 1)^2 = x^2 + 1 over GF(2). */
    a = _mm_set_epi64x(0, 3);
    b = _mm_set_epi64x(3, 0);
    _mm_storeu_si128((__m128i *)lanes, _mm_clmulepi64_si128(a, a, 0x00));
    if (lanes[0] != 5 || lanes[1] != 0) {
        return 27;
    }
    _mm_storeu_si128((__m128i *)lanes, _mm_clmulepi64_si128(a, b, 0x10));
    if (lanes[0] != 5) {
        return 28;
    }

    /* The double-precision select and the reinterpreting casts. */
    a = _mm_set_epi32(4, 3, 2, 1);
    b = _mm_set_epi32(8, 7, 6, 5);
    r = _mm_castpd_si128(_mm_shuffle_pd(_mm_castsi128_pd(a), _mm_castsi128_pd(b), 1));
    _mm_storeu_si128((__m128i *)lanes, r);
    if (lanes[0] != 3 || lanes[1] != 4 || lanes[2] != 5 || lanes[3] != 6) {
        return 29;
    }

    /* Zero, and a round trip through memory. */
    _mm_storeu_si128((__m128i *)lanes, _mm_setzero_si128());
    if (lanes[0] != 0 || lanes[1] != 0 || lanes[2] != 0 || lanes[3] != 0) {
        return 30;
    }
    for (i = 0; i < 16; i++) {
        buf[i] = (unsigned char)(i * 7 + 1);
    }
    a = load(buf);
    for (i = 0; i < 16; i++) {
        buf[i] = 0;
    }
    _mm_storeu_si128((__m128i *)buf, a);
    for (i = 0; i < 16; i++) {
        if (buf[i] != (unsigned char)(i * 7 + 1)) {
            return 31;
        }
    }

    if (!aes128_known_answer()) {
        return 32;
    }
    return 0;
}
