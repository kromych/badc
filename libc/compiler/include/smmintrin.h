/* SSE4.1 intrinsics. This build carries the quadword compare and the
** doubleword element accesses; of SSE4.2, the CRC32 accumulations. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "smmintrin.h is only available when targeting x86"
#endif

#include <tmmintrin.h>

static inline __m128i _mm_cmpeq_epi64(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_pcmpeqq((__v2di)__X, (__v2di)__Y);
}

#define _mm_extract_epi32(X, N) \
    ((int)__builtin_ia32_vec_ext_v4si((__v4si)(__m128i)(X), (int)(N)))
#define _mm_insert_epi32(X, I, N) \
    ((__m128i)__builtin_ia32_vec_set_v4si((__v4si)(__m128i)(X), (int)(I), (int)(N)))

/* CRC32: the CRC-32C (Castagnoli) of the operand's bytes, accumulated. */
static inline unsigned int _mm_crc32_u8(unsigned int __C, unsigned char __V) {
    __asm__("crc32b %1, %0" : "+r"(__C) : "r"(__V));
    return __C;
}

static inline unsigned int _mm_crc32_u16(unsigned int __C, unsigned short __V) {
    __asm__("crc32w %1, %0" : "+r"(__C) : "r"(__V));
    return __C;
}

static inline unsigned int _mm_crc32_u32(unsigned int __C, unsigned int __V) {
    __asm__("crc32l %1, %0" : "+r"(__C) : "r"(__V));
    return __C;
}

#ifdef __x86_64__
static inline unsigned long long _mm_crc32_u64(unsigned long long __C, unsigned long long __V) {
    __asm__("crc32q %1, %0" : "+r"(__C) : "r"(__V));
    return __C;
}
#endif
