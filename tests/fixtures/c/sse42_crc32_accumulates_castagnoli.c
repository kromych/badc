// SSE4.2's CRC32 through <nmmintrin.h>: _mm_crc32_u8, _u16, _u32 and _u64
// accumulate the CRC-32C (Castagnoli) of their operand's bytes. Over
// "123456789", from all ones and inverted at the end, each width gives the
// check value 0xE3069283; over random words each agrees with a bitwise
// reference. The exit code is the line of the first mismatch; elsewhere than
// x86-64 the unit is empty.

#ifdef __x86_64__
#include <nmmintrin.h>
#include <string.h>

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

static unsigned reference(unsigned crc, unsigned long long v, int bytes) {
    for (int k = 0; k < bytes; k++) {
        crc ^= (unsigned char)(v >> (8 * k));
        for (int i = 0; i < 8; i++)
            crc = (crc >> 1) ^ (0x82F63B78u & -(crc & 1));
    }
    return crc;
}

int main(void) {
    static const char s[] = "123456789";
    unsigned c8 = ~0u, c16 = ~0u, c32 = ~0u;
    unsigned long long c64 = ~0u;
    unsigned short h[4];
    unsigned w[2];
    unsigned long long q;
    memcpy(h, s, 8);
    memcpy(w, s, 8);
    memcpy(&q, s, 8);
    for (int i = 0; i < 9; i++)
        c8 = _mm_crc32_u8(c8, (unsigned char)s[i]);
    for (int i = 0; i < 4; i++)
        c16 = _mm_crc32_u16(c16, h[i]);
    for (int i = 0; i < 2; i++)
        c32 = _mm_crc32_u32(c32, w[i]);
    c64 = _mm_crc32_u64(c64, q);
    c16 = _mm_crc32_u8(c16, (unsigned char)s[8]);
    c32 = _mm_crc32_u8(c32, (unsigned char)s[8]);
    c64 = _mm_crc32_u8((unsigned)c64, (unsigned char)s[8]);
    CHECK(~c8 == 0xE3069283u && ~c16 == 0xE3069283u && ~c32 == 0xE3069283u);
    CHECK((unsigned)~c64 == 0xE3069283u);
    unsigned long long seed = 0x9E3779B97F4A7C15ULL;
    unsigned acc = 0;
    for (int k = 0; k < 200; k++) {
        seed = seed * 6364136223846793005ULL + 1442695040888963407ULL;
        CHECK(_mm_crc32_u64(acc, seed) == reference(acc, seed, 8));
        CHECK(_mm_crc32_u32(acc, (unsigned)seed) == reference(acc, seed, 4));
        CHECK(_mm_crc32_u16(acc, (unsigned short)seed) == reference(acc, seed, 2));
        CHECK(_mm_crc32_u8(acc, (unsigned char)seed) == reference(acc, seed, 1));
        acc = (unsigned)(seed >> 32);
    }
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif
