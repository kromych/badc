/* <arm_acle.h> and the SHA-1 / SHA-256 intrinsics of <arm_neon.h>: CRC-32
 * and CRC-32C over a buffer against a bitwise model, the data-processing
 * intrinsics against their definitions, and the SHA-1 and SHA-256 digests
 * of "abc" through the hash and schedule updates against FIPS 180's.
 * Returns 42 when every check passes; elsewhere than AArch64 only the
 * models run. */

#include <stdint.h>
#include <string.h>

static uint32_t crc_model(uint32_t c, const unsigned char *p, int n, uint32_t poly) {
    for (int i = 0; i < n; i++) {
        c ^= p[i];
        for (int k = 0; k < 8; k++) c = c >> 1 ^ (poly & -(c & 1));
    }
    return c;
}

#if defined(__aarch64__)
#include <arm_acle.h>
#include <arm_neon.h>

static uint32_t crc_acle(uint32_t c, const unsigned char *p, int n, int castagnoli) {
    for (; n >= 8; n -= 8, p += 8) {
        uint64_t q;
        memcpy(&q, p, 8);
        c = castagnoli ? __crc32cd(c, q) : __crc32d(c, q);
    }
    if (n >= 4) {
        uint32_t w;
        memcpy(&w, p, 4);
        c = castagnoli ? __crc32cw(c, w) : __crc32w(c, w);
        p += 4, n -= 4;
    }
    if (n >= 2) {
        uint16_t h;
        memcpy(&h, p, 2);
        c = castagnoli ? __crc32ch(c, h) : __crc32h(c, h);
        p += 2, n -= 2;
    }
    if (n) c = castagnoli ? __crc32cb(c, *p) : __crc32b(c, *p);
    return c;
}

/* The one padded block of "abc", as big-endian words. */
static void abc_block(uint32_t w[16]) {
    memset(w, 0, 64);
    w[0] = 0x61626380u;
    w[15] = 24;
}

static int sha1_abc(void) {
    static const uint32_t want[5] = {0xa9993e36, 0x4706816a, 0xba3e2571, 0x7850c26c, 0x9cd0d89d};
    static const uint32_t k[4] = {0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6};
    uint32_t w[16], s[5] = {0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476, 0xc3d2e1f0};
    abc_block(w);
    uint32x4_t m[20], abcd = vld1q_u32(s);
    uint32_t e = s[4];
    for (int g = 0; g < 20; g++) {
        m[g] = g < 4 ? vld1q_u32(w + 4 * g)
                     : vsha1su1q_u32(vsha1su0q_u32(m[g - 4], m[g - 3], m[g - 2]), m[g - 1]);
        uint32x4_t wk = vaddq_u32(m[g], vdupq_n_u32(k[g / 5]));
        uint32_t next = vsha1h_u32(vgetq_lane_u32(abcd, 0));
        abcd = g < 5 ? vsha1cq_u32(abcd, e, wk) : g >= 10 && g < 15 ? vsha1mq_u32(abcd, e, wk)
                                                                     : vsha1pq_u32(abcd, e, wk);
        e = next;
    }
    uint32_t out[5];
    vst1q_u32(out, vaddq_u32(abcd, vld1q_u32(s)));
    out[4] = e + s[4];
    return memcmp(out, want, sizeof want) == 0;
}

static int sha256_abc(void) {
    static const uint32_t want[8] = {0xba7816bf, 0x8f01cfea, 0x414140de, 0x5dae2223,
                                     0xb00361a3, 0x96177a9c, 0xb410ff61, 0xf20015ad};
    static const uint32_t k[64] = {
        0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4,
        0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe,
        0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f,
        0x4a7484aa, 0x5cb0a9dc, 0x76f988da, 0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
        0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc,
        0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b,
        0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070, 0x19a4c116,
        0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
        0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7,
        0xc67178f2};
    uint32_t w[16], s[8] = {0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
                            0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19};
    abc_block(w);
    uint32x4_t m[16], abcd = vld1q_u32(s), efgh = vld1q_u32(s + 4);
    for (int g = 0; g < 16; g++) {
        m[g] = g < 4 ? vld1q_u32(w + 4 * g)
                     : vsha256su1q_u32(vsha256su0q_u32(m[g - 4], m[g - 3]), m[g - 2], m[g - 1]);
        uint32x4_t wk = vaddq_u32(m[g], vld1q_u32(k + 4 * g)), prev = abcd;
        abcd = vsha256hq_u32(abcd, efgh, wk);
        efgh = vsha256h2q_u32(efgh, prev, wk);
    }
    uint32_t out[8];
    vst1q_u32(out, vaddq_u32(abcd, vld1q_u32(s)));
    vst1q_u32(out + 4, vaddq_u32(efgh, vld1q_u32(s + 4)));
    return memcmp(out, want, sizeof want) == 0;
}
#endif

int main(void) {
    unsigned char buf[61];
    for (int i = 0; i < 61; i++) buf[i] = (unsigned char)(i * 37 + 11);
    if (crc_model(~0u, (const unsigned char *)"123456789", 9, 0xEDB88320u) != ~0xCBF43926u) return 1;
    if (crc_model(~0u, (const unsigned char *)"123456789", 9, 0x82F63B78u) != ~0xE3069283u) return 2;
#if defined(__aarch64__)
    for (int n = 0; n <= 61; n += 5) {
        if (crc_acle(~0u, buf, n, 0) != crc_model(~0u, buf, n, 0xEDB88320u)) return 3;
        if (crc_acle(~0u, buf, n, 1) != crc_model(~0u, buf, n, 0x82F63B78u)) return 4;
    }
    if (__clz(0) != 32 || __clzll(1) != 63 || __cls(0x00ffffffu) != 7 || __clsll(~0ull) != 63) return 5;
    if (__rev(0x11223344u) != 0x44332211u || __rev16ll(0x1122334455667788ull) != 0x2211443366558877ull)
        return 6;
    if (__revsh((int16_t)0x80ff) != (int16_t)0xff80 || __rbit(6) != 0x60000000u) return 7;
    if (__ror(0x80000001u, 33) != 0xc0000000u || __rorll(3, 0) != 3) return 8;
    if (!sha1_abc()) return 9;
    if (!sha256_abc()) return 10;
    __dmb(11);
    __isb(15);
    __yield();
#endif
    return 42;
}
