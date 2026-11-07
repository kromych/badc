/* SSE4.1 intrinsics. This build carries the quadword compare and the
** doubleword element accesses. */
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
