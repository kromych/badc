/* SSE2 intrinsics. Each operation below lowers to the instruction the
** SDM documents for it, except the aligned transfers, which take the
** unaligned move: a vector operand here is memory-resident at 8-byte
** alignment, so no aligned form is emitted. The operations this build
** does not carry are absent rather than emulated, so a unit that needs
** one fails at the undeclared name. The forms whose last operand the
** instruction encodes as an immediate are macros, as gcc's are without
** -O: a function parameter is not an integer constant expression. */
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

/* The `_u` types are what an unaligned access dereferences: the same
** width with no alignment requirement. The 8-byte one carries the
** quadword transfers, which move half a vector. */
typedef long long __m128i_u
    __attribute__((__vector_size__(16), __may_alias__, __aligned__(1)));
typedef double __m128d_u __attribute__((__vector_size__(16), __may_alias__, __aligned__(1)));
typedef long long __m64_u __attribute__((__may_alias__, __aligned__(1)));

/* Composition over the vector extension, as gcc does. `_mm_set_*` takes
** its lanes from the highest down, `_mm_setr_*` from lane zero up; the
** parameter names carry the lane number in both. */

static inline __m128i _mm_setzero_si128(void) {
    return (__m128i)(__v4si){0, 0, 0, 0};
}

static inline __m128i _mm_set_epi32(int __q3, int __q2, int __q1, int __q0) {
    return (__m128i)(__v4si){__q0, __q1, __q2, __q3};
}

static inline __m128i _mm_setr_epi32(int __q0, int __q1, int __q2, int __q3) {
    return (__m128i)(__v4si){__q0, __q1, __q2, __q3};
}

static inline __m128i _mm_set_epi64x(long long __q1, long long __q0) {
    return (__m128i)(__v2di){__q0, __q1};
}

static inline __m128i _mm_set_epi16(short __q7, short __q6, short __q5, short __q4, short __q3,
                                    short __q2, short __q1, short __q0) {
    return (__m128i)(__v8hi){__q0, __q1, __q2, __q3, __q4, __q5, __q6, __q7};
}

static inline __m128i _mm_setr_epi16(short __q0, short __q1, short __q2, short __q3, short __q4,
                                     short __q5, short __q6, short __q7) {
    return (__m128i)(__v8hi){__q0, __q1, __q2, __q3, __q4, __q5, __q6, __q7};
}

static inline __m128i _mm_set_epi8(char __b15, char __b14, char __b13, char __b12, char __b11,
                                   char __b10, char __b09, char __b08, char __b07, char __b06,
                                   char __b05, char __b04, char __b03, char __b02, char __b01,
                                   char __b00) {
    return (__m128i)(__v16qi){__b00, __b01, __b02, __b03, __b04, __b05, __b06, __b07,
                              __b08, __b09, __b10, __b11, __b12, __b13, __b14, __b15};
}

static inline __m128i _mm_setr_epi8(char __b00, char __b01, char __b02, char __b03, char __b04,
                                    char __b05, char __b06, char __b07, char __b08, char __b09,
                                    char __b10, char __b11, char __b12, char __b13, char __b14,
                                    char __b15) {
    return (__m128i)(__v16qi){__b00, __b01, __b02, __b03, __b04, __b05, __b06, __b07,
                              __b08, __b09, __b10, __b11, __b12, __b13, __b14, __b15};
}

static inline __m128i _mm_set1_epi8(char __b) {
    return (__m128i)(__v16qi){__b, __b, __b, __b, __b, __b, __b, __b,
                              __b, __b, __b, __b, __b, __b, __b, __b};
}

static inline __m128i _mm_set1_epi16(short __w) {
    return (__m128i)(__v8hi){__w, __w, __w, __w, __w, __w, __w, __w};
}

static inline __m128i _mm_set1_epi32(int __i) {
    return (__m128i)(__v4si){__i, __i, __i, __i};
}

static inline __m128i _mm_set1_epi64x(long long __q) {
    return (__m128i)(__v2di){__q, __q};
}

static inline __m128i _mm_cvtsi32_si128(int __a) {
    return (__m128i)(__v4si){__a, 0, 0, 0};
}

static inline int _mm_cvtsi128_si32(__m128i __A) {
    return ((__v4si)__A)[0];
}

#ifdef __x86_64__
static inline __m128i _mm_cvtsi64_si128(long long __a) {
    return (__m128i)(__v2di){__a, 0};
}

static inline long long _mm_cvtsi128_si64(__m128i __A) {
    return ((__v2di)__A)[0];
}
#endif

static inline __m128i _mm_castpd_si128(__m128d __A) {
    return (__m128i)__A;
}

static inline __m128d _mm_castsi128_pd(__m128i __A) {
    return (__m128d)__A;
}

/* 128-bit transfers. The quadword pair moves exactly 8 bytes, so it
** reads and writes through the 8-byte type rather than the vector. */

static inline __m128i _mm_load_si128(__m128i const *__P) {
    return (__m128i)__builtin_ia32_loaddqu((char const *)__P);
}

static inline __m128i _mm_loadu_si128(__m128i const *__P) {
    return (__m128i)__builtin_ia32_loaddqu((char const *)__P);
}

static inline void _mm_store_si128(__m128i *__P, __m128i __B) {
    __builtin_ia32_storedqu((char *)__P, (__m128i)__B);
}

static inline void _mm_storeu_si128(__m128i *__P, __m128i __B) {
    __builtin_ia32_storedqu((char *)__P, (__m128i)__B);
}

static inline __m128i _mm_loadl_epi64(__m128i const *__P) {
    return (__m128i)(__v2di){*(__m64_u const *)__P, 0};
}

static inline void _mm_storel_epi64(__m128i *__P, __m128i __B) {
    *(__m64_u *)__P = ((__v2di)__B)[0];
}

/* Packed integer arithmetic. */

static inline __m128i _mm_add_epi8(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_paddb128((__v16qi)__A, (__v16qi)__B);
}

static inline __m128i _mm_add_epi16(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_paddw128((__v8hi)__A, (__v8hi)__B);
}

static inline __m128i _mm_add_epi32(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_paddd128((__v4si)__A, (__v4si)__B);
}

static inline __m128i _mm_add_epi64(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_paddq128((__v2di)__A, (__v2di)__B);
}

static inline __m128i _mm_sub_epi8(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_psubb128((__v16qi)__A, (__v16qi)__B);
}

static inline __m128i _mm_sub_epi16(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_psubw128((__v8hi)__A, (__v8hi)__B);
}

static inline __m128i _mm_sub_epi32(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_psubd128((__v4si)__A, (__v4si)__B);
}

static inline __m128i _mm_sub_epi64(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_psubq128((__v2di)__A, (__v2di)__B);
}

static inline __m128i _mm_mullo_epi16(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pmullw128((__v8hi)__A, (__v8hi)__B);
}

static inline __m128i _mm_mulhi_epi16(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pmulhw128((__v8hi)__A, (__v8hi)__B);
}

static inline __m128i _mm_madd_epi16(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pmaddwd128((__v8hi)__A, (__v8hi)__B);
}

/* Bitwise logic and lane compares. */

static inline __m128i _mm_and_si128(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pand128((__v2di)__A, (__v2di)__B);
}

static inline __m128i _mm_andnot_si128(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pandn128((__v2di)__A, (__v2di)__B);
}

static inline __m128i _mm_or_si128(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_por128((__v2di)__A, (__v2di)__B);
}

static inline __m128i _mm_xor_si128(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pxor128((__v2di)__A, (__v2di)__B);
}

static inline __m128i _mm_cmpeq_epi8(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pcmpeqb128((__v16qi)__A, (__v16qi)__B);
}

static inline __m128i _mm_cmpeq_epi16(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pcmpeqw128((__v8hi)__A, (__v8hi)__B);
}

static inline __m128i _mm_cmpeq_epi32(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pcmpeqd128((__v4si)__A, (__v4si)__B);
}

static inline __m128i _mm_cmpgt_epi8(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pcmpgtb128((__v16qi)__A, (__v16qi)__B);
}

static inline __m128i _mm_cmpgt_epi16(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pcmpgtw128((__v8hi)__A, (__v8hi)__B);
}

static inline __m128i _mm_cmpgt_epi32(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pcmpgtd128((__v4si)__A, (__v4si)__B);
}

static inline __m128i _mm_cmplt_epi8(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pcmpgtb128((__v16qi)__B, (__v16qi)__A);
}

static inline __m128i _mm_cmplt_epi16(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pcmpgtw128((__v8hi)__B, (__v8hi)__A);
}

static inline __m128i _mm_cmplt_epi32(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_pcmpgtd128((__v4si)__B, (__v4si)__A);
}

/* Saturating packs and interleaves. */

static inline __m128i _mm_packs_epi16(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_packsswb128((__v8hi)__A, (__v8hi)__B);
}

static inline __m128i _mm_packs_epi32(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_packssdw128((__v4si)__A, (__v4si)__B);
}

static inline __m128i _mm_packus_epi16(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_packuswb128((__v8hi)__A, (__v8hi)__B);
}

static inline __m128i _mm_unpacklo_epi8(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_punpcklbw128((__v16qi)__A, (__v16qi)__B);
}

static inline __m128i _mm_unpacklo_epi16(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_punpcklwd128((__v8hi)__A, (__v8hi)__B);
}

static inline __m128i _mm_unpacklo_epi32(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_punpckldq128((__v4si)__A, (__v4si)__B);
}

static inline __m128i _mm_unpacklo_epi64(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_punpcklqdq128((__v2di)__A, (__v2di)__B);
}

static inline __m128i _mm_unpackhi_epi8(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_punpckhbw128((__v16qi)__A, (__v16qi)__B);
}

static inline __m128i _mm_unpackhi_epi16(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_punpckhwd128((__v8hi)__A, (__v8hi)__B);
}

static inline __m128i _mm_unpackhi_epi32(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_punpckhdq128((__v4si)__A, (__v4si)__B);
}

static inline __m128i _mm_unpackhi_epi64(__m128i __A, __m128i __B) {
    return (__m128i)__builtin_ia32_punpckhqdq128((__v2di)__A, (__v2di)__B);
}

static inline int _mm_movemask_epi8(__m128i __A) {
    return __builtin_ia32_pmovmskb128((__v16qi)__A);
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
#define _mm_srai_epi16(A, B) \
    ((__m128i)__builtin_ia32_psrawi128((__v8hi)(__m128i)(A), (int)(B)))
#define _mm_srai_epi32(A, B) \
    ((__m128i)__builtin_ia32_psradi128((__v4si)(__m128i)(A), (int)(B)))
/* The whole-register shifts count bytes; their builtins count bits. */
#define _mm_slli_si128(A, N) \
    ((__m128i)__builtin_ia32_pslldqi128((__v2di)(__m128i)(A), (int)(N) * 8))
#define _mm_srli_si128(A, N) \
    ((__m128i)__builtin_ia32_psrldqi128((__v2di)(__m128i)(A), (int)(N) * 8))
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
#define _mm_insert_epi16(A, D, N) \
    ((__m128i)__builtin_ia32_vec_set_v8hi((__v8hi)(__m128i)(A), (int)(D), (int)(N)))
