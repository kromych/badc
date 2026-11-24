/* A byte reversal written with shifts, masks, ors and sums, in each
   width and order, against one computed a byte at a time through memory;
   and shapes close to one that are not a reversal. The exit code names
   the first mismatching shape. */

#include <stdint.h>

#define NOINLINE __attribute__((noinline))

static uint64_t reverse(uint64_t x, int w) {
    unsigned char b[8];
    uint64_t r = 0;
    for (int i = 0; i < w; i++)
        b[i] = (unsigned char)(x >> (8 * i));
    for (int i = 0; i < w; i++)
        r = r << 8 | b[i];
    return r;
}

NOINLINE uint64_t staged64(uint64_t x) {
    x = (x << 32) | (x >> 32);
    x = ((x & 0x0000ffff0000ffffULL) << 16) | ((x & 0xffff0000ffff0000ULL) >> 16);
    x = ((x & 0x00ff00ff00ff00ffULL) << 8) | ((x & 0xff00ff00ff00ff00ULL) >> 8);
    return x;
}

NOINLINE uint64_t terms64(uint64_t x) {
    return (x >> 56) | ((x >> 40) & 0xff00) | ((x >> 24) & 0xff0000) | ((x >> 8) & 0xff000000) |
           ((x & 0xff000000) << 8) | ((x & 0xff0000) << 24) | ((x & 0xff00) << 40) | (x << 56);
}

NOINLINE uint32_t masks32(uint32_t x) {
    return ((x & 0xff) << 24) | ((x & 0xff00) << 8) | ((x >> 8) & 0xff00) | (x >> 24);
}

NOINLINE uint32_t shifts32(uint32_t x) {
    return (x << 24) | ((x << 8) & 0xff0000) | ((x >> 8) & 0xff00) | (x >> 24);
}

NOINLINE uint32_t signed32(uint32_t x) {
    return (uint32_t)(((int32_t)x >> 24) & 0xff) | ((x >> 8) & 0xff00) | ((x & 0xff00) << 8) | (x << 24);
}

NOINLINE uint16_t pair16(uint16_t x) { return (uint16_t)((x << 8) | (x >> 8)); }

NOINLINE uint16_t sum16(uint16_t x) { return (uint16_t)(((x & 0xff) << 8) + (x >> 8)); }

NOINLINE uint32_t halves32(uint32_t x) {
    return ((x & 0x00ff00ff) << 8) | ((x & 0xff00ff00) >> 8);
}

NOINLINE uint64_t rotate64(uint64_t x) { return (x >> 8) | (x << 56); }

NOINLINE int64_t widened32(uint32_t x) {
    return (int32_t)(((x & 0xff) << 24) | ((x & 0xff00) << 8) | ((x >> 8) & 0xff00) | (x >> 24));
}

int main(void) {
    uint64_t x = 0x0123456789abcdefULL;
    for (int i = 0; i < 4096; i++) {
        uint32_t w = (uint32_t)x;
        uint16_t h = (uint16_t)x;
        if (staged64(x) != reverse(x, 8))
            return 1;
        if (terms64(x) != reverse(x, 8))
            return 2;
        if (masks32(w) != reverse(w, 4))
            return 3;
        if (shifts32(w) != reverse(w, 4))
            return 4;
        if (signed32(w) != reverse(w, 4))
            return 5;
        if (pair16(h) != reverse(h, 2))
            return 6;
        if (sum16(h) != reverse(h, 2))
            return 7;
        if (halves32(w) != (((w & 0xff) << 8) | ((w >> 8) & 0xff) | ((w >> 16 & 0xff) << 24) | (w >> 24) << 16))
            return 8;
        if (rotate64(x) != (x >> 8 | (x & 0xff) << 56))
            return 9;
        if (widened32(w) != (int64_t)(int32_t)reverse(w, 4))
            return 10;
        x = x * 6364136223846793005ULL + 1442695040888963407ULL;
        x ^= x >> 29;
    }
    return 0;
}
