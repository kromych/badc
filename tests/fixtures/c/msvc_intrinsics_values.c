// MSVC's scalar intrinsics through <intrin.h>, with the values MSVC
// documents: the bit scans, counts and rotates, the bit tests, the
// multiply-high and 128-bit shift forms, the Interlocked family and the
// volatile accesses. `__assume` and `__noop` evaluate nothing. Each
// group sets its bit on a mismatch; off the PE targets the unit checks
// nothing.

#ifdef _WIN32
#include <intrin.h>

static int scans_counts_rotates(void) {
    int r = 0;
    unsigned long idx = 99;
    if (!_BitScanForward(&idx, 0x50) || idx != 4) r |= 1;
    if (!_BitScanReverse(&idx, 0x50) || idx != 6) r |= 1;
    idx = 77;
    if (_BitScanForward(&idx, 0) || _BitScanReverse64(&idx, 0) || idx != 77) r |= 2;
    if (!_BitScanForward64(&idx, 1ULL << 40) || idx != 40) r |= 2;
    if (!_BitScanReverse64(&idx, ~0ULL) || idx != 63) r |= 2;
    if (_rotl(0x80000001u, 1) != 3 || _rotr(1, 33) != 0x80000000u || _rotl(5, 0) != 5) r |= 4;
    if (_rotl8(0x81, 9) != 0x03 || _rotr16(1, 1) != 0x8000) r |= 4;
    if (_rotl64(1ULL << 63, 65) != 1 || _lrotl(1, 31) != 0x80000000ul) r |= 4;
    if (__popcnt16(0xffff) != 16 || __popcnt(0xF0F0) != 8 || __popcnt64(~0ULL) != 64) r |= 8;
#if defined(__x86_64__)
    if (__lzcnt(1) != 31 || __lzcnt(0) != 32 || __lzcnt16(1) != 15 || __lzcnt64(0) != 64) r |= 16;
    if (_mm_popcnt_u32(0xF0u) != 4 || _mm_popcnt_u64(~0ULL) != 64) r |= 16;
#else
    if (_CountLeadingZeros(1) != 31 || _CountLeadingZeros64(0) != 64) r |= 16;
    if (_CountTrailingZeros(0x80) != 7 || _CountTrailingZeros64(0) != 64) r |= 16;
    if (_CountLeadingOnes(0xF0000000ul) != 4 || _CountLeadingOnes64(~0ULL) != 64) r |= 16;
    if (_CountLeadingSigns(-1) != 31 || _CountLeadingSigns64(1) != 62) r |= 16;
    if (_CountOneBits(0xF0F0ul) != 8 || _CountOneBits64(3) != 2) r |= 16;
#endif
    return r;
}

static int bit_tests_multiplies(void) {
    int r = 0;
    long bits[2] = {0, 0};
    if (_bittestandset(bits, 35) || !_bittest(bits, 35) || bits[1] != 8) r |= 32;
    if (!_bittestandcomplement(bits, 35) || bits[1] != 0) r |= 32;
    if (_interlockedbittestandset(bits, 0) || !_interlockedbittestandreset(bits, 0) || bits[0])
        r |= 32;
    long long wide = 0;
    if (_bittestandset64(&wide, 63) || !_bittest64(&wide, 63) || !_bittestandreset64(&wide, 63))
        r |= 64;
    if (wide || _interlockedbittestandset64(&wide, 40) || wide != 1LL << 40) r |= 64;
    if (__umulh(1ULL << 63, 4) != 2 || __mulh(-4, 1LL << 62) != -1) r |= 128;
#if defined(__x86_64__)
    unsigned long long hi;
    long long shi;
    if (_umul128(~0ULL, 2, &hi) != ~0ULL - 1 || hi != 1) r |= 128;
    if (_mul128(-1, 1, &shi) != -1 || shi != -1) r |= 128;
    if (__shiftleft128(1ULL << 63, 1, 1) != 3 || __shiftleft128(5, 7, 64) != 7) r |= 128;
    if (__shiftright128(1, 1, 1) != 1ULL << 63 || __shiftright128(5, 7, 0) != 5) r |= 128;
#endif
    return r;
}

static int interlocked(void) {
    int r = 0;
    long v = 5;
    if (_InterlockedIncrement(&v) != 6 || _InterlockedDecrement(&v) != 5) r |= 256;
    if (_InterlockedExchangeAdd(&v, 10) != 5 || _InterlockedExchange(&v, 3) != 15) r |= 256;
    if (_InterlockedCompareExchange(&v, 9, 4) != 3 || _InterlockedCompareExchange(&v, 9, 3) != 3)
        r |= 256;
    if (_InterlockedOr(&v, 6) != 9 || _InterlockedAnd(&v, 12) != 15 || _InterlockedXor(&v, 5) != 12)
        r |= 256;
    char c = -1;
    short s = 0x7fff;
    long long q = 0;
    if (_InterlockedExchangeAdd8(&c, 1) != -1 || _InterlockedCompareExchange8(&c, 5, 0) != 0)
        r |= 512;
    if (c != 5 || _InterlockedIncrement16(&s) != -32768 || _InterlockedOr16(&s, 1) != -32768)
        r |= 512;
    if (_InterlockedDecrement64(&q) != -1 || _InterlockedExchange64(&q, 1LL << 40) != -1) r |= 512;
    if (_InterlockedAnd64(&q, ~0LL) != 1LL << 40) r |= 512;
    void *p = 0;
    if (_InterlockedCompareExchangePointer(&p, &v, 0) != 0 || p != &v) r |= 1024;
    if (_InterlockedExchangePointer(&p, &q) != &v || p != &q) r |= 1024;
    _Alignas(16) long long pair[2] = {1, 2};
    long long cmp[2] = {1, 2};
    if (!_InterlockedCompareExchange128(pair, 20, 10, cmp) || pair[0] != 10 || pair[1] != 20)
        r |= 2048;
    if (_InterlockedCompareExchange128(pair, 0, 0, cmp) || cmp[0] != 10 || cmp[1] != 20)
        r |= 2048;
#if defined(__aarch64__)
    if (_InterlockedAdd(&v, 1) != 10 || _InterlockedAdd64_nf(&q, 1) != (1LL << 40) + 1) r |= 4096;
    if (_InterlockedIncrement_acq(&v) != 11 || _InterlockedExchange_rel(&v, 0) != 11) r |= 4096;
    unsigned long long w = 7;
    unsigned char b8 = 1;
    __stlr64(&w, __ldar64(&w) + 1);
    __stlr8(&b8, 200);
    if (w != 8 || __ldar8(&b8) != 200) r |= 4096;
#else
    if (_InterlockedOr_np(&v, 0) != 9) r |= 4096;
#endif
    return r;
}

static int accesses(void) {
    int r = 0;
    int i32 = 0;
    char i8 = 0;
    __iso_volatile_store32(&i32, -7);
    __iso_volatile_store8(&i8, -3);
    if (__iso_volatile_load32(&i32) != -7 || __iso_volatile_load8(&i8) != -3) r |= 8192;
    int n = 0;
    __assume(n++ == 0);
    if (__noop(n++, 1) != 0 || n != 0) r |= 16384;
    return r;
}

int main(void) {
    return scans_counts_rotates() | bit_tests_multiplies() | interlocked() | accesses();
}
#else
int main(void) { return 0; }
#endif
