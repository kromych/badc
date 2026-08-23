/* SSSE3 intrinsics. This build carries the byte shuffle. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "tmmintrin.h is only available when targeting x86"
#endif

#include <emmintrin.h>

static inline __m128i _mm_shuffle_epi8(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_pshufb128((__v16qi)__X, (__v16qi)__Y);
}
