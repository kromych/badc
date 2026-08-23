/* SSE2 intrinsics. Each operation below lowers to the instruction the
** SDM documents for it. The operations this build does not carry are
** absent rather than emulated, so a unit that needs one fails at the
** undeclared name. The forms whose last operand the instruction encodes
** as an immediate are macros, as gcc's are without -O: a function
** parameter is not an integer constant expression. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "emmintrin.h is only available when targeting x86"
#endif

#include <xmmintrin.h>

typedef long long __m128i __attribute__((__vector_size__(16)));
typedef double __m128d __attribute__((__vector_size__(16)));
typedef long long __v2di __attribute__((__vector_size__(16)));
typedef int __v4si __attribute__((__vector_size__(16)));
typedef short __v8hi __attribute__((__vector_size__(16)));
typedef char __v16qi __attribute__((__vector_size__(16)));
typedef double __v2df __attribute__((__vector_size__(16)));

static inline __m128i _mm_setzero_si128(void) {
    return (__m128i)(__v4si){0, 0, 0, 0};
}

static inline __m128i _mm_set_epi32(int __q3, int __q2, int __q1, int __q0) {
    return (__m128i)(__v4si){__q0, __q1, __q2, __q3};
}

static inline __m128i _mm_set_epi64x(long long __q1, long long __q0) {
    return (__m128i)(__v2di){__q0, __q1};
}

static inline __m128i _mm_set_epi8(char __b15, char __b14, char __b13, char __b12, char __b11,
                                   char __b10, char __b09, char __b08, char __b07, char __b06,
                                   char __b05, char __b04, char __b03, char __b02, char __b01,
                                   char __b00) {
    return (__m128i)(__v16qi){__b00, __b01, __b02, __b03, __b04, __b05, __b06, __b07,
                              __b08, __b09, __b10, __b11, __b12, __b13, __b14, __b15};
}

static inline __m128i _mm_castpd_si128(__m128d __A) {
    return (__m128i)__A;
}

static inline __m128d _mm_castsi128_pd(__m128i __A) {
    return (__m128d)__A;
}

static inline __m128i _mm_loadu_si128(__m128i const *__P) {
    return (__m128i)__builtin_ia32_loaddqu((char const *)__P);
}

static inline void _mm_storeu_si128(__m128i *__P, __m128i __B) {
    __builtin_ia32_storedqu((char *)__P, (__m128i)__B);
}

static inline __m128i _mm_add_epi32(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_paddd128((__v4si)__A, (__v4si)__B);
}

static inline __m128i _mm_add_epi64(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_paddq128((__v2di)__A, (__v2di)__B);
}

static inline __m128i _mm_sub_epi64(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_psubq128((__v2di)__A, (__v2di)__B);
}

static inline __m128i _mm_and_si128(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pand128((__v2di)__A, (__v2di)__B);
}

static inline __m128i _mm_or_si128(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_por128((__v2di)__A, (__v2di)__B);
}

static inline __m128i _mm_xor_si128(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pxor128((__v2di)__A, (__v2di)__B);
}

static inline __m128i _mm_unpacklo_epi64(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_punpcklqdq128((__v2di)__A, (__v2di)__B);
}

/* A constant count takes the immediate form of the shift, a runtime
** one the register form; both are the documented instruction. */
#define _mm_slli_epi16(A, B) \
    ((__m128i)__builtin_ia32_psllwi128((__v8hi)(__m128i)(A), (int)(B)))
#define _mm_slli_epi32(A, B) \
    ((__m128i)__builtin_ia32_pslldi128((__v4si)(__m128i)(A), (int)(B)))
#define _mm_slli_epi64(A, B) \
    ((__m128i)__builtin_ia32_psllqi128((__v2di)(__m128i)(A), (int)(B)))
#define _mm_srli_epi16(A, B) \
    ((__m128i)__builtin_ia32_psrlwi128((__v8hi)(__m128i)(A), (int)(B)))
#define _mm_srli_epi32(A, B) \
    ((__m128i)__builtin_ia32_psrldi128((__v4si)(__m128i)(A), (int)(B)))
#define _mm_srli_epi64(A, B) \
    ((__m128i)__builtin_ia32_psrlqi128((__v2di)(__m128i)(A), (int)(B)))
#define _mm_slli_si128(A, N) \
    ((__m128i)__builtin_ia32_pslldqi128((__v2di)(__m128i)(A), (int)(N) * 8))
#define _mm_shuffle_epi32(A, N) \
    ((__m128i)__builtin_ia32_pshufd((__v4si)(__m128i)(A), (int)(N)))
#define _mm_shufflehi_epi16(A, N) \
    ((__m128i)__builtin_ia32_pshufhw((__v8hi)(__m128i)(A), (int)(N)))
#define _mm_shufflelo_epi16(A, N) \
    ((__m128i)__builtin_ia32_pshuflw((__v8hi)(__m128i)(A), (int)(N)))
#define _mm_shuffle_pd(A, B, N) \
    ((__m128d)__builtin_ia32_shufpd((__v2df)(__m128d)(A), (__v2df)(__m128d)(B), (int)(N)))
#define _mm_extract_epi16(A, N) \
    ((int)__builtin_ia32_vec_ext_v8hi((__v8hi)(__m128i)(A), (int)(N)))
