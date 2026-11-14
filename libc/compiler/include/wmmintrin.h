/* AES-NI and carry-less multiply intrinsics. */
#pragma once
#ifndef __BADC_INTRIN
/* An intrinsic is inlined at every optimization level, as a call to it would
 * pass and copy its vectors around one instruction. */
#define __BADC_INTRIN static __inline__ __attribute__((__always_inline__))
#endif

#if !defined(__x86_64__) && !defined(__i386__)
#error "wmmintrin.h is only available when targeting x86"
#endif

#include <emmintrin.h>

__BADC_INTRIN __m128i _mm_aesenc_si128(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_aesenc128((__v2di)__X, (__v2di)__Y);
}

__BADC_INTRIN __m128i _mm_aesenclast_si128(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_aesenclast128((__v2di)__X, (__v2di)__Y);
}

__BADC_INTRIN __m128i _mm_aesdec_si128(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_aesdec128((__v2di)__X, (__v2di)__Y);
}

__BADC_INTRIN __m128i _mm_aesdeclast_si128(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_aesdeclast128((__v2di)__X, (__v2di)__Y);
}

__BADC_INTRIN __m128i _mm_aesimc_si128(__m128i __X) {
    return (__m128i)__builtin_ia32_aesimc128((__v2di)__X);
}

#define _mm_aeskeygenassist_si128(X, C) \
    ((__m128i)__builtin_ia32_aeskeygenassist128((__v2di)(__m128i)(X), (int)(C)))
#define _mm_clmulepi64_si128(X, Y, I) \
    ((__m128i)__builtin_ia32_pclmulqdq128((__v2di)(__m128i)(X), (__v2di)(__m128i)(Y), (int)(I)))
