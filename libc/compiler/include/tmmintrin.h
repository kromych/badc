/* SSSE3 intrinsics. Each operation on __m128i lowers to its instruction;
** the operations on __m64 are written lane by lane over the vector
** extension as the SDM defines each instruction. As in gcc and clang, the
** SSE3 ones come from <pmmintrin.h>. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "tmmintrin.h is only available when targeting x86"
#endif

#include <pmmintrin.h>

static inline __m128i _mm_shuffle_epi8(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_pshufb128((__v16qi)__X, (__v16qi)__Y);
}

static inline __m128i _mm_maddubs_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_pmaddubsw128((__v16qi)__X, (__v16qi)__Y);
}

static inline __m128i _mm_abs_epi8(__m128i __X) {
    return (__m128i)__builtin_ia32_pabsb128((__v16qi)__X);
}

static inline __m128i _mm_abs_epi16(__m128i __X) {
    return (__m128i)__builtin_ia32_pabsw128((__v8hi)__X);
}

static inline __m128i _mm_abs_epi32(__m128i __X) {
    return (__m128i)__builtin_ia32_pabsd128((__v4si)__X);
}

static inline __m128i _mm_sign_epi8(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_psignb128((__v16qi)__X, (__v16qi)__Y);
}

static inline __m128i _mm_sign_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_psignw128((__v8hi)__X, (__v8hi)__Y);
}

static inline __m128i _mm_sign_epi32(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_psignd128((__v4si)__X, (__v4si)__Y);
}

static inline __m128i _mm_hadd_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_phaddw128((__v8hi)__X, (__v8hi)__Y);
}

static inline __m128i _mm_hadd_epi32(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_phaddd128((__v4si)__X, (__v4si)__Y);
}

static inline __m128i _mm_hadds_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_phaddsw128((__v8hi)__X, (__v8hi)__Y);
}

static inline __m128i _mm_hsub_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_phsubw128((__v8hi)__X, (__v8hi)__Y);
}

static inline __m128i _mm_hsub_epi32(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_phsubd128((__v4si)__X, (__v4si)__Y);
}

static inline __m128i _mm_hsubs_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_phsubsw128((__v8hi)__X, (__v8hi)__Y);
}

static inline __m128i _mm_mulhrs_epi16(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_pmulhrsw128((__v8hi)__X, (__v8hi)__Y);
}

/* PALIGNR's builtin counts bits, as gcc's does. */
#define _mm_alignr_epi8(X, Y, N) \
    ((__m128i)__builtin_ia32_palignr128((__v2di)(__m128i)(X), (__v2di)(__m128i)(Y), (int)(N) * 8))

/* PABS*: the magnitude as an unsigned lane, so the most negative value is
** its own. */
static inline __m64 _mm_abs_pi8(__m64 __X) {
    __v8qs __x = (__v8qs)__X;
    __v8qu __r;
    for (int __i = 0; __i < 8; __i++)
        __r[__i] = (unsigned char)(__x[__i] < 0 ? -__x[__i] : __x[__i]);
    return (__m64)__r;
}

static inline __m64 _mm_abs_pi16(__m64 __X) {
    __v4hi __x = (__v4hi)__X;
    __v4hu __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = (unsigned short)(__x[__i] < 0 ? -__x[__i] : __x[__i]);
    return (__m64)__r;
}

static inline __m64 _mm_abs_pi32(__m64 __X) {
    __v2si __x = (__v2si)__X;
    __v2su __r;
    for (int __i = 0; __i < 2; __i++)
        __r[__i] = __x[__i] < 0 ? 0u - (unsigned)__x[__i] : (unsigned)__x[__i];
    return (__m64)__r;
}

/* PHADD*, PHSUB*: the sums or differences of adjacent lanes, the first
** operand's pairs in the low half; wrapping, or saturating in the S forms. */
static inline __m64 _mm_hadd_pi16(__m64 __X, __m64 __Y) {
    __v4hu __x = (__v4hu)__X, __y = (__v4hu)__Y;
    return (__m64)(__v4hu){(unsigned short)(__x[0] + __x[1]), (unsigned short)(__x[2] + __x[3]),
                           (unsigned short)(__y[0] + __y[1]), (unsigned short)(__y[2] + __y[3])};
}

static inline __m64 _mm_hadd_pi32(__m64 __X, __m64 __Y) {
    __v2su __x = (__v2su)__X, __y = (__v2su)__Y;
    return (__m64)(__v2su){__x[0] + __x[1], __y[0] + __y[1]};
}

static inline __m64 _mm_hadds_pi16(__m64 __X, __m64 __Y) {
    __v4hi __x = (__v4hi)__X, __y = (__v4hi)__Y;
    return (__m64)(__v4hi){(short)__mm_sat_signed(__x[0] + __x[1], 16),
                           (short)__mm_sat_signed(__x[2] + __x[3], 16),
                           (short)__mm_sat_signed(__y[0] + __y[1], 16),
                           (short)__mm_sat_signed(__y[2] + __y[3], 16)};
}

static inline __m64 _mm_hsub_pi16(__m64 __X, __m64 __Y) {
    __v4hu __x = (__v4hu)__X, __y = (__v4hu)__Y;
    return (__m64)(__v4hu){(unsigned short)(__x[0] - __x[1]), (unsigned short)(__x[2] - __x[3]),
                           (unsigned short)(__y[0] - __y[1]), (unsigned short)(__y[2] - __y[3])};
}

static inline __m64 _mm_hsub_pi32(__m64 __X, __m64 __Y) {
    __v2su __x = (__v2su)__X, __y = (__v2su)__Y;
    return (__m64)(__v2su){__x[0] - __x[1], __y[0] - __y[1]};
}

static inline __m64 _mm_hsubs_pi16(__m64 __X, __m64 __Y) {
    __v4hi __x = (__v4hi)__X, __y = (__v4hi)__Y;
    return (__m64)(__v4hi){(short)__mm_sat_signed(__x[0] - __x[1], 16),
                           (short)__mm_sat_signed(__x[2] - __x[3], 16),
                           (short)__mm_sat_signed(__y[0] - __y[1], 16),
                           (short)__mm_sat_signed(__y[2] - __y[3], 16)};
}

/* PMADDUBSW: unsigned bytes of the first operand by signed bytes of the
** second, adjacent products summed with signed saturation. */
static inline __m64 _mm_maddubs_pi16(__m64 __X, __m64 __Y) {
    __v8qu __x = (__v8qu)__X;
    __v8qs __y = (__v8qs)__Y;
    __v4hi __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = (short)__mm_sat_signed(
            __x[2 * __i] * __y[2 * __i] + __x[2 * __i + 1] * __y[2 * __i + 1], 16);
    return (__m64)__r;
}

/* PMULHRSW: the product's bits 30:15, rounded at bit 14. */
static inline __m64 _mm_mulhrs_pi16(__m64 __X, __m64 __Y) {
    __v4hi __x = (__v4hi)__X, __y = (__v4hi)__Y;
    __v4hu __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = (unsigned short)((((__x[__i] * __y[__i]) >> 14) + 1) >> 1);
    return (__m64)__r;
}

/* PSHUFB: a byte of the first operand selected by the low three bits of
** the selector byte, or zero where its top bit is set. */
static inline __m64 _mm_shuffle_pi8(__m64 __X, __m64 __Y) {
    __v8qi __x = (__v8qi)__X, __r;
    __v8qu __y = (__v8qu)__Y;
    for (int __i = 0; __i < 8; __i++)
        __r[__i] = __y[__i] & 0x80 ? 0 : __x[__y[__i] & 7];
    return (__m64)__r;
}

/* PSIGN*: the lane negated where the second operand's is negative, zero
** where it is zero; the negation wraps. */
static inline __m64 _mm_sign_pi8(__m64 __X, __m64 __Y) {
    __v8qs __x = (__v8qs)__X, __y = (__v8qs)__Y;
    __v8qu __r;
    for (int __i = 0; __i < 8; __i++)
        __r[__i] = (unsigned char)(__y[__i] < 0 ? -__x[__i] : __y[__i] ? __x[__i] : 0);
    return (__m64)__r;
}

static inline __m64 _mm_sign_pi16(__m64 __X, __m64 __Y) {
    __v4hi __x = (__v4hi)__X, __y = (__v4hi)__Y;
    __v4hu __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = (unsigned short)(__y[__i] < 0 ? -__x[__i] : __y[__i] ? __x[__i] : 0);
    return (__m64)__r;
}

static inline __m64 _mm_sign_pi32(__m64 __X, __m64 __Y) {
    __v2si __x = (__v2si)__X, __y = (__v2si)__Y;
    __v2su __r;
    for (int __i = 0; __i < 2; __i++)
        __r[__i] = __y[__i] < 0 ? 0u - (unsigned)__x[__i] : __y[__i] ? (unsigned)__x[__i] : 0u;
    return (__m64)__r;
}

/* PALIGNR: eight bytes from byte __N of the second operand followed by the
** first, zero past the sixteenth. */
static inline __m64 _mm_alignr_pi8(__m64 __X, __m64 __Y, int __N) {
    __v8qu __x = (__v8qu)__X, __y = (__v8qu)__Y, __r;
    for (int __i = 0; __i < 8; __i++) {
        unsigned __k = (unsigned)__N + __i;
        __r[__i] = __k < 8 ? __y[__k] : __k < 16 ? __x[__k - 8] : 0;
    }
    return (__m64)__r;
}
