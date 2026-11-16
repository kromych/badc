/* SSSE3 intrinsics. Each operation on __m128i lowers to its instruction;
** the operations on __m64 are written lane by lane over the vector
** extension as the SDM defines each instruction. As in gcc and clang, the
** SSE3 ones come from <pmmintrin.h>. */
#pragma once
#ifndef __BADC_INTRIN
/* An intrinsic is inlined at every optimization level, as a call to it would
 * pass and copy its vectors around one instruction. */
#define __BADC_INTRIN static __inline__ __attribute__((__always_inline__))
#endif

#if !defined(__x86_64__) && !defined(__i386__)
#error "tmmintrin.h is only available when targeting x86"
#endif

#include <pmmintrin.h>

__BADC_INTRIN __m128i _mm_shuffle_epi8(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_pshufb128((__v16qi)__X, (__v16qi)__Y);
}

__BADC_INTRIN __m128i _mm_maddubs_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_pmaddubsw128((__v16qi)__X, (__v16qi)__Y);
}

__BADC_INTRIN __m128i _mm_abs_epi8(__m128i __X) {
    return (__m128i)__builtin_ia32_pabsb128((__v16qi)__X);
}

__BADC_INTRIN __m128i _mm_abs_epi16(__m128i __X) {
    return (__m128i)__builtin_ia32_pabsw128((__v8hi)__X);
}

__BADC_INTRIN __m128i _mm_abs_epi32(__m128i __X) {
    return (__m128i)__builtin_ia32_pabsd128((__v4si)__X);
}

__BADC_INTRIN __m128i _mm_sign_epi8(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_psignb128((__v16qi)__X, (__v16qi)__Y);
}

__BADC_INTRIN __m128i _mm_sign_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_psignw128((__v8hi)__X, (__v8hi)__Y);
}

__BADC_INTRIN __m128i _mm_sign_epi32(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_psignd128((__v4si)__X, (__v4si)__Y);
}

__BADC_INTRIN __m128i _mm_hadd_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_phaddw128((__v8hi)__X, (__v8hi)__Y);
}

__BADC_INTRIN __m128i _mm_hadd_epi32(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_phaddd128((__v4si)__X, (__v4si)__Y);
}

__BADC_INTRIN __m128i _mm_hadds_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_phaddsw128((__v8hi)__X, (__v8hi)__Y);
}

__BADC_INTRIN __m128i _mm_hsub_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_phsubw128((__v8hi)__X, (__v8hi)__Y);
}

__BADC_INTRIN __m128i _mm_hsub_epi32(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_phsubd128((__v4si)__X, (__v4si)__Y);
}

__BADC_INTRIN __m128i _mm_hsubs_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_phsubsw128((__v8hi)__X, (__v8hi)__Y);
}

__BADC_INTRIN __m128i _mm_mulhrs_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_pmulhrsw128((__v8hi)__X, (__v8hi)__Y);
}

/* PALIGNR's builtin counts bits, as gcc's does. */
#define _mm_alignr_epi8(X, Y, N) \
    ((__m128i)__builtin_ia32_palignr128((__v2di)(__m128i)(X), (__v2di)(__m128i)(Y), (int)(N) * 8))

/* The __m64 forms: the 128-bit instruction on the operand in the low half,
** or on the first operand's lanes followed by the second's where the lanes
** of the two meet (the pairwise forms, PSHUFB's selection, PALIGNR's
** shift). */
#define __BADC_M64_1(name, form)                                                   \
    __BADC_INTRIN __m64 name(__m64 __X) {                                          \
        return _mm_movepi64_pi64(form(_mm_movpi64_epi64(__X)));                    \
    }
#define __BADC_M64_2(name, form)                                                   \
    __BADC_INTRIN __m64 name(__m64 __X, __m64 __Y) {                               \
        return _mm_movepi64_pi64(form(_mm_movpi64_epi64(__X), _mm_movpi64_epi64(__Y))); \
    }
#define __BADC_M64_PAIRWISE(name, form)                                            \
    __BADC_INTRIN __m64 name(__m64 __X, __m64 __Y) {                               \
        __m128i __p = (__m128i)__BADC_M64_PAIR(__X, __Y);                         \
        return _mm_movepi64_pi64(form(__p, __p));                                  \
    }
__BADC_M64_1(_mm_abs_pi8, _mm_abs_epi8)
__BADC_M64_1(_mm_abs_pi16, _mm_abs_epi16)
__BADC_M64_1(_mm_abs_pi32, _mm_abs_epi32)
__BADC_M64_2(_mm_sign_pi8, _mm_sign_epi8)
__BADC_M64_2(_mm_sign_pi16, _mm_sign_epi16)
__BADC_M64_2(_mm_sign_pi32, _mm_sign_epi32)
__BADC_M64_2(_mm_maddubs_pi16, _mm_maddubs_epi16)
__BADC_M64_2(_mm_mulhrs_pi16, _mm_mulhrs_epi16)
__BADC_M64_PAIRWISE(_mm_hadd_pi16, _mm_hadd_epi16)
__BADC_M64_PAIRWISE(_mm_hadd_pi32, _mm_hadd_epi32)
__BADC_M64_PAIRWISE(_mm_hadds_pi16, _mm_hadds_epi16)
__BADC_M64_PAIRWISE(_mm_hsub_pi16, _mm_hsub_epi16)
__BADC_M64_PAIRWISE(_mm_hsub_pi32, _mm_hsub_epi32)
__BADC_M64_PAIRWISE(_mm_hsubs_pi16, _mm_hsubs_epi16)
#undef __BADC_M64_1
#undef __BADC_M64_2
#undef __BADC_M64_PAIRWISE

/* PSHUFB on __m64 selects by the low three bits of a selector byte, so the
** 128-bit form takes the selectors with bits 6:3 cleared. */
__BADC_INTRIN __m64 _mm_shuffle_pi8(__m64 __X, __m64 __Y) {
    __m128i __s = _mm_and_si128(_mm_movpi64_epi64(__Y), _mm_set1_epi8((char)0x87));
    return _mm_movepi64_pi64(_mm_shuffle_epi8(_mm_movpi64_epi64(__X), __s));
}

/* PALIGNR on __m64: eight bytes from byte N of the second operand followed
** by the first, zero past the sixteenth. */
#define _mm_alignr_pi8(X, Y, N)                                                    \
    _mm_movepi64_pi64(_mm_srli_si128((__m128i)__BADC_M64_PAIR((Y), (X)), (N)))
