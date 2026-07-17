// libkern/OSByteOrder.h -- macOS byte-order swap macros.
//
// The host-to-big / big-to-host integer swaps used to read and write
// big-endian on-disk fields (e.g. HFS+ Finder info). The macros expand
// to constant-foldable arithmetic so they are valid in both runtime and
// constant-expression contexts. macOS targets are little-endian, so the
// big-endian conversions swap and the little-endian conversions are the
// identity.

#pragma once

#ifdef __APPLE__

#define OSSwapConstInt16(x) \
    ((unsigned short)((((unsigned short)(x) & 0xff00U) >> 8) | \
                      (((unsigned short)(x) & 0x00ffU) << 8)))

#define OSSwapConstInt32(x) \
    ((unsigned int)((((unsigned int)(x) & 0xff000000U) >> 24) | \
                    (((unsigned int)(x) & 0x00ff0000U) >>  8) | \
                    (((unsigned int)(x) & 0x0000ff00U) <<  8) | \
                    (((unsigned int)(x) & 0x000000ffU) << 24)))

#define OSSwapConstInt64(x) \
    ((unsigned long long)( \
        (((unsigned long long)(x) & 0xff00000000000000ULL) >> 56) | \
        (((unsigned long long)(x) & 0x00ff000000000000ULL) >> 40) | \
        (((unsigned long long)(x) & 0x0000ff0000000000ULL) >> 24) | \
        (((unsigned long long)(x) & 0x000000ff00000000ULL) >>  8) | \
        (((unsigned long long)(x) & 0x00000000ff000000ULL) <<  8) | \
        (((unsigned long long)(x) & 0x0000000000ff0000ULL) << 24) | \
        (((unsigned long long)(x) & 0x000000000000ff00ULL) << 40) | \
        (((unsigned long long)(x) & 0x00000000000000ffULL) << 56)))

#define OSSwapInt16(x) OSSwapConstInt16(x)
#define OSSwapInt32(x) OSSwapConstInt32(x)
#define OSSwapInt64(x) OSSwapConstInt64(x)

#define OSSwapHostToBigInt16(x) OSSwapInt16(x)
#define OSSwapHostToBigInt32(x) OSSwapInt32(x)
#define OSSwapHostToBigInt64(x) OSSwapInt64(x)
#define OSSwapBigToHostInt16(x) OSSwapInt16(x)
#define OSSwapBigToHostInt32(x) OSSwapInt32(x)
#define OSSwapBigToHostInt64(x) OSSwapInt64(x)

#define OSSwapHostToBigConstInt16(x) OSSwapConstInt16(x)
#define OSSwapHostToBigConstInt32(x) OSSwapConstInt32(x)
#define OSSwapHostToBigConstInt64(x) OSSwapConstInt64(x)

#define OSSwapHostToLittleInt16(x) ((unsigned short)(x))
#define OSSwapHostToLittleInt32(x) ((unsigned int)(x))
#define OSSwapHostToLittleInt64(x) ((unsigned long long)(x))
#define OSSwapLittleToHostInt16(x) ((unsigned short)(x))
#define OSSwapLittleToHostInt32(x) ((unsigned int)(x))
#define OSSwapLittleToHostInt64(x) ((unsigned long long)(x))

#endif /* __APPLE__ */
