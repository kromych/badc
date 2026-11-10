/* Umbrella over the x86 intrinsic family this build carries. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "immintrin.h is only available when targeting x86"
#endif

#include <smmintrin.h>
#include <wmmintrin.h>

/* The 256-bit types and the integer operations of AVX and AVX2. x86-64
** code assumes x86-64-v3, so an operation AVX2 has an instruction for is
** gcc's builtin of it, the VEX instruction on ymm registers, and the rest
** are written over the vector extension as the SDM defines them or as the
** SSE instruction on each 128-bit half. */
#pragma push_macro("__attribute__")
#undef __attribute__
typedef long long __m256i __attribute__((__vector_size__(32)));
typedef long long __v4di __attribute__((__vector_size__(32)));
typedef int __v8si __attribute__((__vector_size__(32)));
typedef short __v16hi __attribute__((__vector_size__(32)));
typedef char __v32qi __attribute__((__vector_size__(32)));
typedef signed char __v32qs __attribute__((__vector_size__(32)));
typedef unsigned char __v32qu __attribute__((__vector_size__(32)));
typedef unsigned short __v16hu __attribute__((__vector_size__(32)));
typedef unsigned int __v8su __attribute__((__vector_size__(32)));
typedef unsigned long long __v4du __attribute__((__vector_size__(32)));
typedef long long __m256i_u __attribute__((__vector_size__(32), __may_alias__, __aligned__(1)));
typedef float __m256 __attribute__((__vector_size__(32)));
typedef double __m256d __attribute__((__vector_size__(32)));
typedef float __v8sf __attribute__((__vector_size__(32)));
typedef double __v4df __attribute__((__vector_size__(32)));
typedef float __m256_u __attribute__((__vector_size__(32), __may_alias__, __aligned__(1)));
typedef double __m256d_u __attribute__((__vector_size__(32), __may_alias__, __aligned__(1)));
typedef unsigned int __v4su __attribute__((__vector_size__(16)));
#pragma pop_macro("__attribute__")

static inline __m256i _mm256_loadu_si256(__m256i_u const *__P) {
    return (__m256i)__builtin_ia32_loaddqu256((char const *)__P);
}

static inline __m256i _mm256_load_si256(__m256i const *__P) {
    return _mm256_loadu_si256((__m256i_u const *)__P);
}

static inline void _mm256_storeu_si256(__m256i_u *__P, __m256i __A) {
    __builtin_ia32_storedqu256((char *)__P, __A);
}

static inline void _mm256_store_si256(__m256i *__P, __m256i __A) {
    _mm256_storeu_si256((__m256i_u *)__P, __A);
}

static inline __m256i _mm256_setzero_si256(void) {
    return (__m256i){0, 0, 0, 0};
}

static inline __m256i _mm256_set1_epi8(char __A) {
    __v32qi __r;
    for (int __i = 0; __i < 32; __i++)
        __r[__i] = __A;
    return (__m256i)__r;
}

static inline __m256i _mm256_set1_epi16(short __A) {
    __v16hi __r;
    for (int __i = 0; __i < 16; __i++)
        __r[__i] = __A;
    return (__m256i)__r;
}

static inline __m256i _mm256_set1_epi32(int __A) {
    __v8si __r;
    for (int __i = 0; __i < 8; __i++)
        __r[__i] = __A;
    return (__m256i)__r;
}

static inline __m256i _mm256_set1_epi64x(long long __A) {
    return (__m256i){__A, __A, __A, __A};
}

/* VPBROADCASTB/W/D/Q: the low lane of a 128-bit operand in every lane. */
static inline __m256i _mm256_broadcastb_epi8(__m128i __X) {
    return _mm256_set1_epi8(((__v16qi)__X)[0]);
}

static inline __m256i _mm256_broadcastw_epi16(__m128i __X) {
    return _mm256_set1_epi16(((__v8hi)__X)[0]);
}

static inline __m256i _mm256_broadcastd_epi32(__m128i __X) {
    return _mm256_set1_epi32(((__v4si)__X)[0]);
}

static inline __m256i _mm256_broadcastq_epi64(__m128i __X) {
    return _mm256_set1_epi64x(((__v2di)__X)[0]);
}

static inline __m128i _mm256_castsi256_si128(__m256i __A) {
    return (__m128i){__A[0], __A[1]};
}

/* The upper half is undefined in the SDM; this gives zero. */
static inline __m256i _mm256_castsi128_si256(__m128i __A) {
    return (__m256i){__A[0], __A[1], 0, 0};
}

static inline __m128i _mm256_extracti128_si256(__m256i __A, const int __N) {
    return __N & 1 ? (__m128i){__A[2], __A[3]} : (__m128i){__A[0], __A[1]};
}

static inline __m256i _mm256_inserti128_si256(__m256i __A, __m128i __B, const int __N) {
    __A[2 * (__N & 1)] = __B[0];
    __A[2 * (__N & 1) + 1] = __B[1];
    return __A;
}

static inline __m256i _mm256_and_si256(__m256i __A, __m256i __B) {
    return __A & __B;
}

static inline __m256i _mm256_andnot_si256(__m256i __A, __m256i __B) {
    return (__m256i)__builtin_ia32_andnotsi256(__A, __B);
}

static inline __m256i _mm256_or_si256(__m256i __A, __m256i __B) {
    return __A | __B;
}

static inline __m256i _mm256_xor_si256(__m256i __A, __m256i __B) {
    return __A ^ __B;
}

/* VPTEST's ZF: whether the AND of the operands is zero. */
static inline int _mm256_testz_si256(__m256i __A, __m256i __B) {
    __m256i __r = __A & __B;
    return (__r[0] | __r[1] | __r[2] | __r[3]) == 0;
}

/* Lane-wise add and subtract wrap, as on the unsigned lanes they are
** computed on. */
static inline __m256i _mm256_add_epi8(__m256i __A, __m256i __B) {
    return (__m256i)((__v32qu)__A + (__v32qu)__B);
}

static inline __m256i _mm256_add_epi16(__m256i __A, __m256i __B) {
    return (__m256i)((__v16hu)__A + (__v16hu)__B);
}

static inline __m256i _mm256_add_epi32(__m256i __A, __m256i __B) {
    return (__m256i)((__v8su)__A + (__v8su)__B);
}

static inline __m256i _mm256_add_epi64(__m256i __A, __m256i __B) {
    return (__m256i)((__v4du)__A + (__v4du)__B);
}

static inline __m256i _mm256_sub_epi8(__m256i __A, __m256i __B) {
    return (__m256i)((__v32qu)__A - (__v32qu)__B);
}

static inline __m256i _mm256_sub_epi16(__m256i __A, __m256i __B) {
    return (__m256i)((__v16hu)__A - (__v16hu)__B);
}

static inline __m256i _mm256_sub_epi32(__m256i __A, __m256i __B) {
    return (__m256i)((__v8su)__A - (__v8su)__B);
}

static inline __m256i _mm256_sub_epi64(__m256i __A, __m256i __B) {
    return (__m256i)((__v4du)__A - (__v4du)__B);
}

/* VPCMPEQB/W/D/Q: all ones in a lane where the operands are equal. */
static inline __m256i _mm256_cmpeq_epi8(__m256i __A, __m256i __B) {
    return (__m256i)__builtin_ia32_pcmpeqb256(__A, __B);
}

static inline __m256i _mm256_cmpeq_epi16(__m256i __A, __m256i __B) {
    return (__m256i)__builtin_ia32_pcmpeqw256(__A, __B);
}

static inline __m256i _mm256_cmpeq_epi32(__m256i __A, __m256i __B) {
    return (__m256i)__builtin_ia32_pcmpeqd256(__A, __B);
}

static inline __m256i _mm256_cmpeq_epi64(__m256i __A, __m256i __B) {
    return (__m256i)__builtin_ia32_pcmpeqq256(__A, __B);
}

static inline __m256i _mm256_set_epi64x(long long __D, long long __C, long long __B,
                                        long long __A) {
    return (__m256i){__A, __B, __C, __D};
}

static inline __m256i _mm256_set_epi32(int __H, int __G, int __F, int __E, int __D, int __C,
                                       int __B, int __A) {
    return (__m256i)(__v8si){__A, __B, __C, __D, __E, __F, __G, __H};
}

static inline __m256i _mm256_setr_epi32(int __A, int __B, int __C, int __D, int __E, int __F,
                                        int __G, int __H) {
    return (__m256i)(__v8si){__A, __B, __C, __D, __E, __F, __G, __H};
}

static inline __m256i _mm256_setr_epi8(char __b0, char __b1, char __b2, char __b3, char __b4,
                                       char __b5, char __b6, char __b7, char __b8, char __b9,
                                       char __b10, char __b11, char __b12, char __b13,
                                       char __b14, char __b15, char __b16, char __b17,
                                       char __b18, char __b19, char __b20, char __b21,
                                       char __b22, char __b23, char __b24, char __b25,
                                       char __b26, char __b27, char __b28, char __b29,
                                       char __b30, char __b31) {
    return (__m256i)(__v32qi){__b0,  __b1,  __b2,  __b3,  __b4,  __b5,  __b6,  __b7,
                              __b8,  __b9,  __b10, __b11, __b12, __b13, __b14, __b15,
                              __b16, __b17, __b18, __b19, __b20, __b21, __b22, __b23,
                              __b24, __b25, __b26, __b27, __b28, __b29, __b30, __b31};
}

static inline __m256i _mm256_set_epi8(char __b31, char __b30, char __b29, char __b28,
                                      char __b27, char __b26, char __b25, char __b24,
                                      char __b23, char __b22, char __b21, char __b20,
                                      char __b19, char __b18, char __b17, char __b16,
                                      char __b15, char __b14, char __b13, char __b12,
                                      char __b11, char __b10, char __b9, char __b8, char __b7,
                                      char __b6, char __b5, char __b4, char __b3, char __b2,
                                      char __b1, char __b0) {
    return _mm256_setr_epi8(__b0, __b1, __b2, __b3, __b4, __b5, __b6, __b7, __b8, __b9, __b10,
                            __b11, __b12, __b13, __b14, __b15, __b16, __b17, __b18, __b19,
                            __b20, __b21, __b22, __b23, __b24, __b25, __b26, __b27, __b28,
                            __b29, __b30, __b31);
}

static inline __m256i _mm256_set_m128i(__m128i __H, __m128i __L) {
    return (__m256i){__L[0], __L[1], __H[0], __H[1]};
}

static inline __m256i _mm256_zextsi128_si256(__m128i __A) {
    return (__m256i){__A[0], __A[1], 0, 0};
}

static inline __m256i _mm256_broadcastsi128_si256(__m128i __A) {
    return (__m256i){__A[0], __A[1], __A[0], __A[1]};
}

static inline __m256i _mm256_cmpgt_epi32(__m256i __A, __m256i __B) {
    return (__m256i)__builtin_ia32_pcmpgtd256(__A, __B);
}

static inline __m256i _mm256_cmpgt_epi64(__m256i __A, __m256i __B) {
    return (__m256i)__builtin_ia32_pcmpgtq256(__A, __B);
}

/* An extract zero-extends its byte, as gcc's and clang's do. */
static inline int _mm256_extract_epi8(__m256i __A, const int __N) {
    return ((__v32qu)__A)[__N & 31];
}

static inline int _mm256_extract_epi32(__m256i __A, const int __N) {
    return ((__v8si)__A)[__N & 7];
}

static inline __m256i _mm256_insert_epi8(__m256i __A, int __I, const int __N) {
    __v32qi __r = (__v32qi)__A;
    __r[__N & 31] = (char)__I;
    return (__m256i)__r;
}

static inline __m256i _mm256_insert_epi32(__m256i __A, int __I, const int __N) {
    __v8si __r = (__v8si)__A;
    __r[__N & 7] = __I;
    return (__m256i)__r;
}

#ifdef __x86_64__
static inline long long _mm256_extract_epi64(__m256i __A, const int __N) {
    return __A[__N & 3];
}

static inline __m256i _mm256_insert_epi64(__m256i __A, long long __I, const int __N) {
    __A[__N & 3] = __I;
    return __A;
}
#endif

static inline __m256i _mm256_mullo_epi32(__m256i __A, __m256i __B) {
    return (__m256i)((__v8su)__A * (__v8su)__B);
}

/* VPMULUDQ: the low doubleword of each quadword, multiplied unsigned. */
static inline __m256i _mm256_mul_epu32(__m256i __A, __m256i __B) {
    return (__m256i)__builtin_ia32_pmuludq256(__A, __B);
}

/* The shifts by a count: one past the lane width clears the lane, or fills
** it with the sign. */
#define _mm256_slli_epi16(A, N) ((__m256i)__builtin_ia32_psllwi256((__m256i)(A), (int)(N)))
#define _mm256_slli_epi32(A, N) ((__m256i)__builtin_ia32_pslldi256((__m256i)(A), (int)(N)))
#define _mm256_slli_epi64(A, N) ((__m256i)__builtin_ia32_psllqi256((__m256i)(A), (int)(N)))
#define _mm256_srli_epi16(A, N) ((__m256i)__builtin_ia32_psrlwi256((__m256i)(A), (int)(N)))
#define _mm256_srli_epi32(A, N) ((__m256i)__builtin_ia32_psrldi256((__m256i)(A), (int)(N)))
#define _mm256_srli_epi64(A, N) ((__m256i)__builtin_ia32_psrlqi256((__m256i)(A), (int)(N)))
#define _mm256_srai_epi16(A, N) ((__m256i)__builtin_ia32_psrawi256((__m256i)(A), (int)(N)))
#define _mm256_srai_epi32(A, N) ((__m256i)__builtin_ia32_psradi256((__m256i)(A), (int)(N)))

/* The forms of an imm8 are macros, which keep it a literal. VPBLENDD gives
** each half four of its bits, and VPCLMULQDQ, an extension beyond
** x86-64-v3, is PCLMULQDQ on each half; each operand is evaluated once. */
#define __BADC_AVX2_IMM1(op, A, N)                                                \
    __extension__({                                                               \
        __m256i __badc_a = (A);                                                   \
        __badc_join_si(op(__badc_lo_si(__badc_a), N), op(__badc_hi_si(__badc_a), N)); \
    })
#define __BADC_AVX2_IMM2(op, A, B, N)                                             \
    __extension__({                                                               \
        __m256i __badc_a = (A), __badc_b = (B);                                   \
        __badc_join_si(op(__badc_lo_si(__badc_a), __badc_lo_si(__badc_b), N),     \
                       op(__badc_hi_si(__badc_a), __badc_hi_si(__badc_b), N));    \
    })
#define _mm256_slli_si256(A, N)                                                   \
    ((__m256i)__builtin_ia32_pslldqi256((__m256i)(A), (int)(N) * 8))
#define _mm256_srli_si256(A, N)                                                   \
    ((__m256i)__builtin_ia32_psrldqi256((__m256i)(A), (int)(N) * 8))
#define _mm256_shuffle_epi32(A, M) ((__m256i)__builtin_ia32_pshufd256((__m256i)(A), (int)(M)))
#define _mm256_shufflehi_epi16(A, M)                                              \
    ((__m256i)__builtin_ia32_pshufhw256((__m256i)(A), (int)(M)))
#define _mm256_shufflelo_epi16(A, M)                                              \
    ((__m256i)__builtin_ia32_pshuflw256((__m256i)(A), (int)(M)))
#define _mm256_alignr_epi8(A, B, N)                                               \
    ((__m256i)__builtin_ia32_palignr256((__m256i)(A), (__m256i)(B), (int)(N) * 8))
#define _mm256_blend_epi16(A, B, M)                                               \
    ((__m256i)__builtin_ia32_pblendw256((__m256i)(A), (__m256i)(B), (int)(M)))
#define __badc_blend_epi32(X, Y, M)                                               \
    _mm_castps_si128(_mm_blend_ps(_mm_castsi128_ps(X), _mm_castsi128_ps(Y), (M) & 15))
#define _mm_blend_epi32(A, B, M) __badc_blend_epi32(A, B, M)
#define _mm256_blend_epi32(A, B, M)                                               \
    __extension__({                                                               \
        __m256i __badc_a = (A), __badc_b = (B);                                   \
        __badc_join_si(__badc_blend_epi32(__badc_lo_si(__badc_a), __badc_lo_si(__badc_b), M), \
                       __badc_blend_epi32(__badc_hi_si(__badc_a), __badc_hi_si(__badc_b), (M) >> 4)); \
    })

static inline __m256i _mm256_permutevar8x32_epi32(__m256i __A, __m256i __I) {
    return (__m256i)__builtin_ia32_permvarsi256(__A, __I);
}

#define _mm256_permute4x64_epi64(A, M) ((__m256i)__builtin_ia32_permdi256((__m256i)(A), (int)(M)))
#define _mm256_permute2x128_si256(A, B, M)                                        \
    ((__m256i)__builtin_ia32_permti256((__m256i)(A), (__m256i)(B), (int)(M)))

/* The rest of AVX2's integer operations, and AVX's on __m256i. Each one an
** SSE instruction applies to a 128-bit half applies to the two halves, so
** it lowers to that instruction twice; the ones with an immediate operand,
** the cross-half ones, the variable shifts, the masked transfers and the
** gathers are written lane by lane. */

static inline __m128i __badc_lo_si(__m256i __A) {
    return (__m128i){__A[0], __A[1]};
}

static inline __m128i __badc_hi_si(__m256i __A) {
    return (__m128i){__A[2], __A[3]};
}

static inline __m256i __badc_join_si(__m128i __L, __m128i __H) {
    return (__m256i){__L[0], __L[1], __H[0], __H[1]};
}

#define __BADC_AVX2_BINARY(name, row)                                             \
    static inline __m256i _mm256_##name(__m256i __A, __m256i __B) {               \
        return (__m256i)__builtin_ia32_##row(__A, __B);                           \
    }
__BADC_AVX2_BINARY(adds_epi8, paddsb256)
__BADC_AVX2_BINARY(adds_epi16, paddsw256)
__BADC_AVX2_BINARY(adds_epu8, paddusb256)
__BADC_AVX2_BINARY(adds_epu16, paddusw256)
__BADC_AVX2_BINARY(subs_epi8, psubsb256)
__BADC_AVX2_BINARY(subs_epi16, psubsw256)
__BADC_AVX2_BINARY(subs_epu8, psubusb256)
__BADC_AVX2_BINARY(subs_epu16, psubusw256)
__BADC_AVX2_BINARY(avg_epu8, pavgb256)
__BADC_AVX2_BINARY(avg_epu16, pavgw256)
__BADC_AVX2_BINARY(min_epi8, pminsb256)
__BADC_AVX2_BINARY(min_epi16, pminsw256)
__BADC_AVX2_BINARY(min_epi32, pminsd256)
__BADC_AVX2_BINARY(min_epu8, pminub256)
__BADC_AVX2_BINARY(min_epu16, pminuw256)
__BADC_AVX2_BINARY(min_epu32, pminud256)
__BADC_AVX2_BINARY(max_epi8, pmaxsb256)
__BADC_AVX2_BINARY(max_epi16, pmaxsw256)
__BADC_AVX2_BINARY(max_epi32, pmaxsd256)
__BADC_AVX2_BINARY(max_epu8, pmaxub256)
__BADC_AVX2_BINARY(max_epu16, pmaxuw256)
__BADC_AVX2_BINARY(max_epu32, pmaxud256)
__BADC_AVX2_BINARY(mulhi_epi16, pmulhw256)
__BADC_AVX2_BINARY(mulhi_epu16, pmulhuw256)
__BADC_AVX2_BINARY(mulhrs_epi16, pmulhrsw256)
__BADC_AVX2_BINARY(mullo_epi16, pmullw256)
__BADC_AVX2_BINARY(mul_epi32, pmuldq256)
__BADC_AVX2_BINARY(sign_epi8, psignb256)
__BADC_AVX2_BINARY(sign_epi16, psignw256)
__BADC_AVX2_BINARY(sign_epi32, psignd256)
__BADC_AVX2_BINARY(hadd_epi16, phaddw256)
__BADC_AVX2_BINARY(hadd_epi32, phaddd256)
__BADC_AVX2_BINARY(hadds_epi16, phaddsw256)
__BADC_AVX2_BINARY(hsub_epi16, phsubw256)
__BADC_AVX2_BINARY(hsub_epi32, phsubd256)
__BADC_AVX2_BINARY(hsubs_epi16, phsubsw256)
__BADC_AVX2_BINARY(cmpgt_epi8, pcmpgtb256)
__BADC_AVX2_BINARY(cmpgt_epi16, pcmpgtw256)
__BADC_AVX2_BINARY(packs_epi16, packsswb256)
__BADC_AVX2_BINARY(packs_epi32, packssdw256)
__BADC_AVX2_BINARY(packus_epi16, packuswb256)
__BADC_AVX2_BINARY(packus_epi32, packusdw256)
__BADC_AVX2_BINARY(unpacklo_epi8, punpcklbw256)
__BADC_AVX2_BINARY(unpacklo_epi16, punpcklwd256)
__BADC_AVX2_BINARY(unpacklo_epi32, punpckldq256)
__BADC_AVX2_BINARY(unpacklo_epi64, punpcklqdq256)
__BADC_AVX2_BINARY(unpackhi_epi8, punpckhbw256)
__BADC_AVX2_BINARY(unpackhi_epi16, punpckhwd256)
__BADC_AVX2_BINARY(unpackhi_epi32, punpckhdq256)
__BADC_AVX2_BINARY(unpackhi_epi64, punpckhqdq256)
__BADC_AVX2_BINARY(madd_epi16, pmaddwd256)
__BADC_AVX2_BINARY(maddubs_epi16, pmaddubsw256)
__BADC_AVX2_BINARY(sad_epu8, psadbw256)
__BADC_AVX2_BINARY(shuffle_epi8, pshufb256)
#undef __BADC_AVX2_BINARY

/* VAES and VPCLMULQDQ: the AES-NI and PCLMULQDQ instruction on each 128-bit
** lane, the immediate's qword selectors within each lane. */
#define __BADC_LANES(name, op)                                                    \
    static inline __m256i name(__m256i __A, __m256i __B) {                         \
        return __badc_join_si(op(__badc_lo_si(__A), __badc_lo_si(__B)),            \
                              op(__badc_hi_si(__A), __badc_hi_si(__B)));           \
    }
__BADC_LANES(_mm256_aesenc_epi128, _mm_aesenc_si128)
__BADC_LANES(_mm256_aesenclast_epi128, _mm_aesenclast_si128)
__BADC_LANES(_mm256_aesdec_epi128, _mm_aesdec_si128)
__BADC_LANES(_mm256_aesdeclast_epi128, _mm_aesdeclast_si128)
#undef __BADC_LANES
#define _mm256_clmulepi64_epi128(A, B, I) __BADC_AVX2_IMM2(_mm_clmulepi64_si128, A, B, I)

static inline int _mm256_movemask_epi8(__m256i __A) {
    return __builtin_ia32_pmovmskb256(__A);
}

static inline __m256i _mm256_abs_epi8(__m256i __A) {
    return (__m256i)__builtin_ia32_pabsb256(__A);
}

static inline __m256i _mm256_abs_epi16(__m256i __A) {
    return (__m256i)__builtin_ia32_pabsw256(__A);
}

static inline __m256i _mm256_abs_epi32(__m256i __A) {
    return (__m256i)__builtin_ia32_pabsd256(__A);
}

/* The shifts by a vector's low quadword, per half. */
#define __BADC_AVX2_SHIFT(name, count)                                            \
    static inline __m256i _mm256_##name(__m256i __A, count __C) {                 \
        return __badc_join_si(_mm_##name(__badc_lo_si(__A), __C), _mm_##name(__badc_hi_si(__A), __C)); \
    }
__BADC_AVX2_SHIFT(sll_epi16, __m128i)
__BADC_AVX2_SHIFT(sll_epi32, __m128i)
__BADC_AVX2_SHIFT(sll_epi64, __m128i)
__BADC_AVX2_SHIFT(srl_epi16, __m128i)
__BADC_AVX2_SHIFT(srl_epi32, __m128i)
__BADC_AVX2_SHIFT(srl_epi64, __m128i)
__BADC_AVX2_SHIFT(sra_epi16, __m128i)
__BADC_AVX2_SHIFT(sra_epi32, __m128i)
#undef __BADC_AVX2_SHIFT

#define _mm256_bslli_epi128 _mm256_slli_si256
#define _mm256_bsrli_epi128 _mm256_srli_si256

/* VPSLLV / VPSRLV / VPSRAV: each lane shifted by the unsigned count in the
** same lane of the second operand; a count past the lane width clears it,
** or fills it with the sign. */
#define __BADC_SHIFTV(name, ty, vec, lane, n, bits, op)                           \
    static inline ty name(ty __A, ty __C) {                                       \
        vec __a = (vec)__A, __c = (vec)__C;                                       \
        for (int __i = 0; __i < n; __i++)                                         \
            __a[__i] = op;                                                        \
        return (ty)__a;                                                           \
    }
#define __BADC_SLL(u, bits) ((u)__c[__i] >= bits ? 0 : (u)__a[__i] << (u)__c[__i])
#define __BADC_SRL(u, bits) ((u)__c[__i] >= bits ? 0 : (u)__a[__i] >> (u)__c[__i])
#define __BADC_SRA(u, bits) (__a[__i] >> ((u)__c[__i] >= bits ? bits - 1 : (u)__c[__i]))
__BADC_SHIFTV(_mm_sllv_epi32, __m128i, __v4si, int, 4, 32, __BADC_SLL(unsigned, 32))
__BADC_SHIFTV(_mm_srlv_epi32, __m128i, __v4si, int, 4, 32, __BADC_SRL(unsigned, 32))
__BADC_SHIFTV(_mm_srav_epi32, __m128i, __v4si, int, 4, 32, __BADC_SRA(unsigned, 32))
__BADC_SHIFTV(_mm_sllv_epi64, __m128i, __v2di, long long, 2, 64, __BADC_SLL(unsigned long long, 64))
__BADC_SHIFTV(_mm_srlv_epi64, __m128i, __v2di, long long, 2, 64, __BADC_SRL(unsigned long long, 64))
__BADC_SHIFTV(_mm256_sllv_epi32, __m256i, __v8si, int, 8, 32, __BADC_SLL(unsigned, 32))
__BADC_SHIFTV(_mm256_srlv_epi32, __m256i, __v8si, int, 8, 32, __BADC_SRL(unsigned, 32))
__BADC_SHIFTV(_mm256_srav_epi32, __m256i, __v8si, int, 8, 32, __BADC_SRA(unsigned, 32))
__BADC_SHIFTV(_mm256_sllv_epi64, __m256i, __v4di, long long, 4, 64, __BADC_SLL(unsigned long long, 64))
__BADC_SHIFTV(_mm256_srlv_epi64, __m256i, __v4di, long long, 4, 64, __BADC_SRL(unsigned long long, 64))
#undef __BADC_SHIFTV
#undef __BADC_SLL
#undef __BADC_SRL
#undef __BADC_SRA

static inline __m256i _mm256_blendv_epi8(__m256i __A, __m256i __B, __m256i __M) {
    return __badc_join_si(_mm_blendv_epi8(__badc_lo_si(__A), __badc_lo_si(__B), __badc_lo_si(__M)),
                          _mm_blendv_epi8(__badc_hi_si(__A), __badc_hi_si(__B), __badc_hi_si(__M)));
}

/* VMPSADBW: the low lane by imm8[2:0], the high one by imm8[5:3]. */
static inline __m256i _mm256_mpsadbw_epu8(__m256i __A, __m256i __B, const int __M) {
    return __badc_join_si(_mm_mpsadbw_epu8(__badc_lo_si(__A), __badc_lo_si(__B), __M),
                          _mm_mpsadbw_epu8(__badc_hi_si(__A), __badc_hi_si(__B), __M >> 3));
}

/* VPMOVSX / VPMOVZX: the low lanes of the 128-bit operand, widened, the
** upper half of the result from the lanes after the lower half's. */
#define __BADC_AVX2_EXTEND(name, bytes)                                           \
    static inline __m256i _mm256_##name(__m128i __A) {                            \
        return __badc_join_si(_mm_##name(__A), _mm_##name(_mm_srli_si128(__A, bytes))); \
    }
__BADC_AVX2_EXTEND(cvtepi8_epi16, 8)
__BADC_AVX2_EXTEND(cvtepi8_epi32, 4)
__BADC_AVX2_EXTEND(cvtepi8_epi64, 2)
__BADC_AVX2_EXTEND(cvtepi16_epi32, 8)
__BADC_AVX2_EXTEND(cvtepi16_epi64, 4)
__BADC_AVX2_EXTEND(cvtepi32_epi64, 8)
__BADC_AVX2_EXTEND(cvtepu8_epi16, 8)
__BADC_AVX2_EXTEND(cvtepu8_epi32, 4)
__BADC_AVX2_EXTEND(cvtepu8_epi64, 2)
__BADC_AVX2_EXTEND(cvtepu16_epi32, 8)
__BADC_AVX2_EXTEND(cvtepu16_epi64, 4)
__BADC_AVX2_EXTEND(cvtepu32_epi64, 8)
#undef __BADC_AVX2_EXTEND

/* VPBROADCASTB/W/D/Q into a 128-bit result. */
static inline __m128i _mm_broadcastb_epi8(__m128i __X) {
    return _mm_set1_epi8(((__v16qi)__X)[0]);
}

static inline __m128i _mm_broadcastw_epi16(__m128i __X) {
    return _mm_set1_epi16(((__v8hi)__X)[0]);
}

static inline __m128i _mm_broadcastd_epi32(__m128i __X) {
    return _mm_set1_epi32(((__v4si)__X)[0]);
}

static inline __m128i _mm_broadcastq_epi64(__m128i __X) {
    return _mm_set1_epi64x(((__v2di)__X)[0]);
}

#define _mm_broadcastsi128_si256 _mm256_broadcastsi128_si256

static inline __m256i _mm256_set_epi16(short __q15, short __q14, short __q13, short __q12,
                                       short __q11, short __q10, short __q09, short __q08,
                                       short __q07, short __q06, short __q05, short __q04,
                                       short __q03, short __q02, short __q01, short __q00) {
    return (__m256i)(__v16hi){__q00, __q01, __q02, __q03, __q04, __q05, __q06, __q07,
                              __q08, __q09, __q10, __q11, __q12, __q13, __q14, __q15};
}

static inline __m256i _mm256_setr_epi16(short __q00, short __q01, short __q02, short __q03,
                                        short __q04, short __q05, short __q06, short __q07,
                                        short __q08, short __q09, short __q10, short __q11,
                                        short __q12, short __q13, short __q14, short __q15) {
    return (__m256i)(__v16hi){__q00, __q01, __q02, __q03, __q04, __q05, __q06, __q07,
                              __q08, __q09, __q10, __q11, __q12, __q13, __q14, __q15};
}

static inline __m256i _mm256_setr_epi64x(long long __A, long long __B, long long __C,
                                         long long __D) {
    return (__m256i){__A, __B, __C, __D};
}

static inline __m256i _mm256_setr_m128i(__m128i __L, __m128i __H) {
    return __badc_join_si(__L, __H);
}

/* An extract zero-extends its word, as VPEXTRW does. */
static inline int _mm256_extract_epi16(__m256i __A, const int __N) {
    return ((__v16hu)__A)[__N & 15];
}

static inline __m256i _mm256_insert_epi16(__m256i __A, int __I, const int __N) {
    __v16hi __r = (__v16hi)__A;
    __r[__N & 15] = (short)__I;
    return (__m256i)__r;
}

static inline int _mm256_cvtsi256_si32(__m256i __A) {
    return ((__v8si)__A)[0];
}

/* The non-temporal transfers are ordinary ones, VLDDQU the unaligned load. */
static inline void _mm256_stream_si256(__m256i *__P, __m256i __A) {
    _mm256_storeu_si256((__m256i_u *)__P, __A);
}

static inline __m256i _mm256_stream_load_si256(void const *__P) {
    return _mm256_loadu_si256((__m256i_u const *)__P);
}

static inline __m256i _mm256_lddqu_si256(__m256i const *__P) {
    return _mm256_loadu_si256((__m256i_u const *)__P);
}

static inline __m256i _mm256_loadu2_m128i(__m128i_u const *__H, __m128i_u const *__L) {
    return __badc_join_si(_mm_loadu_si128((__m128i const *)__L),
                          _mm_loadu_si128((__m128i const *)__H));
}

static inline void _mm256_storeu2_m128i(__m128i_u *__H, __m128i_u *__L, __m256i __A) {
    _mm_storeu_si128((__m128i *)__L, __badc_lo_si(__A));
    _mm_storeu_si128((__m128i *)__H, __badc_hi_si(__A));
}

/* VPTEST's CF: whether the AND of the first operand's complement with the
** second is zero. */
static inline int _mm256_testc_si256(__m256i __A, __m256i __B) {
    __m256i __r = ~__A & __B;
    return (__r[0] | __r[1] | __r[2] | __r[3]) == 0;
}

static inline int _mm256_testnzc_si256(__m256i __A, __m256i __B) {
    return !_mm256_testz_si256(__A, __B) && !_mm256_testc_si256(__A, __B);
}

static inline __m256i _mm256_undefined_si256(void) {
    return _mm256_setzero_si256();
}

/* VPMASKMOVD / VPMASKMOVQ and VMASKMOVPS / VMASKMOVPD: a lane loaded or
** stored where the mask lane's sign bit is set; a load gives zero in the
** others, and no other lane's memory is accessed. */
#define __BADC_MASKMOV(load, store, ty, mty, ety, lty, lane, n)                   \
    static inline ty load(ety const *__P, mty __M) {                              \
        lty __m = (lty)__M, __r;                                                  \
        for (int __i = 0; __i < n; __i++) {                                       \
            lane __x = 0;                                                         \
            if (__m[__i] < 0)                                                     \
                __builtin_memcpy(&__x, __P + __i, sizeof __x);                    \
            __r[__i] = __x;                                                       \
        }                                                                         \
        return (ty)__r;                                                           \
    }                                                                             \
    static inline void store(ety *__P, mty __M, ty __A) {                         \
        lty __m = (lty)__M, __a = (lty)__A;                                       \
        for (int __i = 0; __i < n; __i++)                                         \
            if (__m[__i] < 0) {                                                   \
                lane __x = __a[__i];                                              \
                __builtin_memcpy(__P + __i, &__x, sizeof __x);                    \
            }                                                                     \
    }
__BADC_MASKMOV(_mm_maskload_epi32, _mm_maskstore_epi32, __m128i, __m128i, int, __v4si, int, 4)
__BADC_MASKMOV(_mm256_maskload_epi32, _mm256_maskstore_epi32, __m256i, __m256i, int, __v8si, int, 8)
__BADC_MASKMOV(_mm_maskload_epi64, _mm_maskstore_epi64, __m128i, __m128i, long long, __v2di,
               long long, 2)
__BADC_MASKMOV(_mm256_maskload_epi64, _mm256_maskstore_epi64, __m256i, __m256i, long long, __v4di,
               long long, 4)

/* VPGATHER / VGATHER: lane k loaded from the base plus the index lane k,
** sign-extended, times the scale; the masked forms load where the mask
** lane's sign bit is set and take the source lane elsewhere. Result lanes
** past the gathered ones are zero. */
#define __BADC_GATHER(pre, kind, ty, lty, lane, ety, ity, ilty, n)                \
    static inline ty pre##_mask_##kind(ty __S, ety const *__B, ity __I, ty __M, const int __K) { \
        lty __s = (lty)__S, __m = (lty)__M, __r = {0};                            \
        ilty __i = (ilty)__I;                                                     \
        for (int __k = 0; __k < n; __k++) {                                       \
            lane __x = __s[__k];                                                  \
            if (__m[__k] < 0)                                                     \
                __builtin_memcpy(&__x, (char const *)__B + (long long)__i[__k] * __K, sizeof __x); \
            __r[__k] = __x;                                                       \
        }                                                                         \
        return (ty)__r;                                                           \
    }                                                                             \
    static inline ty pre##_##kind(ety const *__B, ity __I, const int __K) {       \
        lty __ones = {0};                                                         \
        for (int __k = 0; __k < n; __k++)                                         \
            __ones[__k] = -1;                                                     \
        return pre##_mask_##kind((ty)(lty){0}, __B, __I, (ty)__ones, __K);        \
    }
__BADC_GATHER(_mm, i32gather_epi32, __m128i, __v4si, int, int, __m128i, __v4si, 4)
__BADC_GATHER(_mm256, i32gather_epi32, __m256i, __v8si, int, int, __m256i, __v8si, 8)
__BADC_GATHER(_mm, i32gather_epi64, __m128i, __v2di, long long, long long, __m128i, __v4si, 2)
__BADC_GATHER(_mm256, i32gather_epi64, __m256i, __v4di, long long, long long, __m128i, __v4si, 4)
__BADC_GATHER(_mm, i64gather_epi32, __m128i, __v4si, int, int, __m128i, __v2di, 2)
__BADC_GATHER(_mm256, i64gather_epi32, __m128i, __v4si, int, int, __m256i, __v4di, 4)
__BADC_GATHER(_mm, i64gather_epi64, __m128i, __v2di, long long, long long, __m128i, __v2di, 2)
__BADC_GATHER(_mm256, i64gather_epi64, __m256i, __v4di, long long, long long, __m256i, __v4di, 4)
__BADC_GATHER(_mm, i32gather_ps, __m128, __v4si, int, float, __m128i, __v4si, 4)
__BADC_GATHER(_mm256, i32gather_ps, __m256, __v8si, int, float, __m256i, __v8si, 8)
__BADC_GATHER(_mm, i32gather_pd, __m128d, __v2di, long long, double, __m128i, __v4si, 2)
__BADC_GATHER(_mm256, i32gather_pd, __m256d, __v4di, long long, double, __m128i, __v4si, 4)
__BADC_GATHER(_mm, i64gather_ps, __m128, __v4si, int, float, __m128i, __v2di, 2)
__BADC_GATHER(_mm256, i64gather_ps, __m128, __v4si, int, float, __m256i, __v4di, 4)
__BADC_GATHER(_mm, i64gather_pd, __m128d, __v2di, long long, double, __m128i, __v2di, 2)
__BADC_GATHER(_mm256, i64gather_pd, __m256d, __v4di, long long, double, __m256i, __v4di, 4)
#undef __BADC_GATHER

/* AVX's floating-point operations. Each one an SSE instruction applies to
** a 128-bit half applies to the two halves, so it lowers to that SSE
** instruction twice; the compares by AVX's 32 predicates and the FMA forms
** are written lane by lane, a predicate that signals raising invalid for a
** NaN operand. The transfers and lane moves work on the integer view of the
** lanes, which keeps every bit. No VEX instruction is emitted. */

static inline __m128 __badc_lo_ps(__m256 __A) {
    __v8si __a = (__v8si)__A;
    return (__m128)(__v4si){__a[0], __a[1], __a[2], __a[3]};
}

static inline __m128 __badc_hi_ps(__m256 __A) {
    __v8si __a = (__v8si)__A;
    return (__m128)(__v4si){__a[4], __a[5], __a[6], __a[7]};
}

static inline __m256 __badc_join_ps(__m128 __L, __m128 __H) {
    __v4si __l = (__v4si)__L, __h = (__v4si)__H;
    return (__m256)(__v8si){__l[0], __l[1], __l[2], __l[3], __h[0], __h[1], __h[2], __h[3]};
}

static inline __m128d __badc_lo_pd(__m256d __A) {
    __v4di __a = (__v4di)__A;
    return (__m128d)(__v2di){__a[0], __a[1]};
}

static inline __m128d __badc_hi_pd(__m256d __A) {
    __v4di __a = (__v4di)__A;
    return (__m128d)(__v2di){__a[2], __a[3]};
}

static inline __m256d __badc_join_pd(__m128d __L, __m128d __H) {
    __v2di __l = (__v2di)__L, __h = (__v2di)__H;
    return (__m256d)(__v4di){__l[0], __l[1], __h[0], __h[1]};
}

#define __BADC_AVX_BINARY(name)                                                         \
    static inline __m256 _mm256_##name##_ps(__m256 __A, __m256 __B) {                  \
        return __badc_join_ps(_mm_##name##_ps(__badc_lo_ps(__A), __badc_lo_ps(__B)),   \
                              _mm_##name##_ps(__badc_hi_ps(__A), __badc_hi_ps(__B)));  \
    }                                                                                 \
    static inline __m256d _mm256_##name##_pd(__m256d __A, __m256d __B) {               \
        return __badc_join_pd(_mm_##name##_pd(__badc_lo_pd(__A), __badc_lo_pd(__B)),   \
                              _mm_##name##_pd(__badc_hi_pd(__A), __badc_hi_pd(__B)));  \
    }
__BADC_AVX_BINARY(add)
__BADC_AVX_BINARY(sub)
__BADC_AVX_BINARY(mul)
__BADC_AVX_BINARY(div)
__BADC_AVX_BINARY(min)
__BADC_AVX_BINARY(max)
__BADC_AVX_BINARY(and)
__BADC_AVX_BINARY(andnot)
__BADC_AVX_BINARY(or)
__BADC_AVX_BINARY(xor)
__BADC_AVX_BINARY(addsub)
__BADC_AVX_BINARY(hadd)
__BADC_AVX_BINARY(hsub)
__BADC_AVX_BINARY(unpacklo)
__BADC_AVX_BINARY(unpackhi)
#undef __BADC_AVX_BINARY

static inline __m256 _mm256_sqrt_ps(__m256 __A) {
    return __badc_join_ps(_mm_sqrt_ps(__badc_lo_ps(__A)), _mm_sqrt_ps(__badc_hi_ps(__A)));
}

static inline __m256d _mm256_sqrt_pd(__m256d __A) {
    return __badc_join_pd(_mm_sqrt_pd(__badc_lo_pd(__A)), _mm_sqrt_pd(__badc_hi_pd(__A)));
}

static inline __m256 _mm256_rcp_ps(__m256 __A) {
    return __badc_join_ps(_mm_rcp_ps(__badc_lo_ps(__A)), _mm_rcp_ps(__badc_hi_ps(__A)));
}

static inline __m256 _mm256_rsqrt_ps(__m256 __A) {
    return __badc_join_ps(_mm_rsqrt_ps(__badc_lo_ps(__A)), _mm_rsqrt_ps(__badc_hi_ps(__A)));
}

static inline __m256 _mm256_movehdup_ps(__m256 __A) {
    return __badc_join_ps(_mm_movehdup_ps(__badc_lo_ps(__A)), _mm_movehdup_ps(__badc_hi_ps(__A)));
}

static inline __m256 _mm256_moveldup_ps(__m256 __A) {
    return __badc_join_ps(_mm_moveldup_ps(__badc_lo_ps(__A)), _mm_moveldup_ps(__badc_hi_ps(__A)));
}

static inline __m256d _mm256_movedup_pd(__m256d __A) {
    return __badc_join_pd(_mm_movedup_pd(__badc_lo_pd(__A)), _mm_movedup_pd(__badc_hi_pd(__A)));
}

static inline __m256 _mm256_setzero_ps(void) {
    return (__m256){0, 0, 0, 0, 0, 0, 0, 0};
}

static inline __m256d _mm256_setzero_pd(void) {
    return (__m256d){0, 0, 0, 0};
}

static inline __m256 _mm256_set_ps(float __H, float __G, float __F, float __E, float __D,
                                   float __C, float __B, float __A) {
    return (__m256){__A, __B, __C, __D, __E, __F, __G, __H};
}

static inline __m256 _mm256_setr_ps(float __A, float __B, float __C, float __D, float __E,
                                    float __F, float __G, float __H) {
    return (__m256){__A, __B, __C, __D, __E, __F, __G, __H};
}

static inline __m256 _mm256_set1_ps(float __A) {
    return (__m256){__A, __A, __A, __A, __A, __A, __A, __A};
}

static inline __m256d _mm256_set_pd(double __D, double __C, double __B, double __A) {
    return (__m256d){__A, __B, __C, __D};
}

static inline __m256d _mm256_setr_pd(double __A, double __B, double __C, double __D) {
    return (__m256d){__A, __B, __C, __D};
}

static inline __m256d _mm256_set1_pd(double __A) {
    return (__m256d){__A, __A, __A, __A};
}

static inline __m256 _mm256_set_m128(__m128 __H, __m128 __L) {
    return __badc_join_ps(__L, __H);
}

static inline __m256d _mm256_set_m128d(__m128d __H, __m128d __L) {
    return __badc_join_pd(__L, __H);
}

static inline __m256 _mm256_setr_m128(__m128 __L, __m128 __H) {
    return __badc_join_ps(__L, __H);
}

static inline __m256d _mm256_setr_m128d(__m128d __L, __m128d __H) {
    return __badc_join_pd(__L, __H);
}

static inline __m256 _mm256_load_ps(float const *__P) {
    return *(__m256 const *)__P;
}

static inline __m256 _mm256_loadu_ps(float const *__P) {
    return *(__m256_u const *)__P;
}

static inline __m256d _mm256_load_pd(double const *__P) {
    return *(__m256d const *)__P;
}

static inline __m256d _mm256_loadu_pd(double const *__P) {
    return *(__m256d_u const *)__P;
}

static inline void _mm256_store_ps(float *__P, __m256 __A) {
    *(__m256 *)__P = __A;
}

static inline void _mm256_storeu_ps(float *__P, __m256 __A) {
    *(__m256_u *)__P = __A;
}

static inline void _mm256_store_pd(double *__P, __m256d __A) {
    *(__m256d *)__P = __A;
}

static inline void _mm256_storeu_pd(double *__P, __m256d __A) {
    *(__m256d_u *)__P = __A;
}

static inline __m256 _mm256_broadcast_ss(float const *__P) {
    int __x = *(int const *)__P;
    return (__m256)(__v8si){__x, __x, __x, __x, __x, __x, __x, __x};
}

static inline __m128 _mm_broadcast_ss(float const *__P) {
    return _mm_load1_ps(__P);
}

static inline __m256d _mm256_broadcast_sd(double const *__P) {
    long long __x = *(long long const *)__P;
    return (__m256d)(__v4di){__x, __x, __x, __x};
}

static inline __m256 _mm256_broadcast_ps(__m128 const *__P) {
    return __badc_join_ps(_mm_loadu_ps((float const *)__P), _mm_loadu_ps((float const *)__P));
}

static inline __m256d _mm256_broadcast_pd(__m128d const *__P) {
    return __badc_join_pd(_mm_loadu_pd((double const *)__P), _mm_loadu_pd((double const *)__P));
}

static inline __m256d _mm256_castps_pd(__m256 __A) {
    return (__m256d)__A;
}

static inline __m256 _mm256_castpd_ps(__m256d __A) {
    return (__m256)__A;
}

static inline __m256i _mm256_castps_si256(__m256 __A) {
    return (__m256i)__A;
}

static inline __m256 _mm256_castsi256_ps(__m256i __A) {
    return (__m256)__A;
}

static inline __m256i _mm256_castpd_si256(__m256d __A) {
    return (__m256i)__A;
}

static inline __m256d _mm256_castsi256_pd(__m256i __A) {
    return (__m256d)__A;
}

static inline __m128 _mm256_castps256_ps128(__m256 __A) {
    return __badc_lo_ps(__A);
}

static inline __m128d _mm256_castpd256_pd128(__m256d __A) {
    return __badc_lo_pd(__A);
}

/* The upper half is undefined in the SDM; this gives zero. */
static inline __m256 _mm256_castps128_ps256(__m128 __A) {
    return __badc_join_ps(__A, _mm_setzero_ps());
}

static inline __m256d _mm256_castpd128_pd256(__m128d __A) {
    return __badc_join_pd(__A, _mm_setzero_pd());
}

static inline __m256 _mm256_zextps128_ps256(__m128 __A) {
    return __badc_join_ps(__A, _mm_setzero_ps());
}

static inline __m256d _mm256_zextpd128_pd256(__m128d __A) {
    return __badc_join_pd(__A, _mm_setzero_pd());
}

static inline __m128 _mm256_extractf128_ps(__m256 __A, const int __N) {
    return __N & 1 ? __badc_hi_ps(__A) : __badc_lo_ps(__A);
}

static inline __m128d _mm256_extractf128_pd(__m256d __A, const int __N) {
    return __N & 1 ? __badc_hi_pd(__A) : __badc_lo_pd(__A);
}

static inline __m128i _mm256_extractf128_si256(__m256i __A, const int __N) {
    return _mm256_extracti128_si256(__A, __N);
}

static inline __m256 _mm256_insertf128_ps(__m256 __A, __m128 __B, const int __N) {
    return __N & 1 ? __badc_join_ps(__badc_lo_ps(__A), __B) : __badc_join_ps(__B, __badc_hi_ps(__A));
}

static inline __m256d _mm256_insertf128_pd(__m256d __A, __m128d __B, const int __N) {
    return __N & 1 ? __badc_join_pd(__badc_lo_pd(__A), __B) : __badc_join_pd(__B, __badc_hi_pd(__A));
}

static inline __m256i _mm256_insertf128_si256(__m256i __A, __m128i __B, const int __N) {
    return _mm256_inserti128_si256(__A, __B, __N);
}

#define _mm256_permute2f128_ps(A, B, M)                                           \
    ((__m256)_mm256_permute2x128_si256((__m256i)(A), (__m256i)(B), M))
#define _mm256_permute2f128_pd(A, B, M)                                           \
    ((__m256d)_mm256_permute2x128_si256((__m256i)(A), (__m256i)(B), M))
#define _mm256_permute2f128_si256(A, B, M) _mm256_permute2x128_si256(A, B, M)

/* VPERMILPS / VSHUFPS select within each 128-bit lane by the same imm8. */
static inline __m256 _mm256_permute_ps(__m256 __A, const int __M) {
    return __badc_join_ps(_mm_shuffle_ps(__badc_lo_ps(__A), __badc_lo_ps(__A), __M),
                          _mm_shuffle_ps(__badc_hi_ps(__A), __badc_hi_ps(__A), __M));
}

static inline __m128 _mm_permute_ps(__m128 __A, const int __M) {
    return _mm_shuffle_ps(__A, __A, __M);
}

static inline __m256 _mm256_shuffle_ps(__m256 __A, __m256 __B, const int __M) {
    return __badc_join_ps(_mm_shuffle_ps(__badc_lo_ps(__A), __badc_lo_ps(__B), __M),
                          _mm_shuffle_ps(__badc_hi_ps(__A), __badc_hi_ps(__B), __M));
}

/* VPERMILPD / VSHUFPD take a bit per lane, two bits per 128-bit lane. */
static inline __m256d _mm256_permute_pd(__m256d __A, const int __M) {
    __v4di __a = (__v4di)__A;
    return (__m256d)(__v4di){__a[__M & 1], __a[(__M >> 1) & 1], __a[2 + ((__M >> 2) & 1)],
                             __a[2 + ((__M >> 3) & 1)]};
}

static inline __m128d _mm_permute_pd(__m128d __A, const int __M) {
    __v2di __a = (__v2di)__A;
    return (__m128d)(__v2di){__a[__M & 1], __a[(__M >> 1) & 1]};
}

static inline __m256d _mm256_shuffle_pd(__m256d __A, __m256d __B, const int __M) {
    __v4di __a = (__v4di)__A, __b = (__v4di)__B;
    return (__m256d)(__v4di){__a[__M & 1], __b[(__M >> 1) & 1], __a[2 + ((__M >> 2) & 1)],
                             __b[2 + ((__M >> 3) & 1)]};
}

static inline __m256 _mm256_blend_ps(__m256 __A, __m256 __B, const int __M) {
    __v8si __a = (__v8si)__A, __b = (__v8si)__B;
    for (int __i = 0; __i < 8; __i++)
        if (__M >> __i & 1)
            __a[__i] = __b[__i];
    return (__m256)__a;
}

static inline __m256d _mm256_blend_pd(__m256d __A, __m256d __B, const int __M) {
    __v4di __a = (__v4di)__A, __b = (__v4di)__B;
    for (int __i = 0; __i < 4; __i++)
        if (__M >> __i & 1)
            __a[__i] = __b[__i];
    return (__m256d)__a;
}

/* BLENDVPS / BLENDVPD take a lane of the second operand where the mask
** lane's sign bit is set. */
static inline __m256 _mm256_blendv_ps(__m256 __A, __m256 __B, __m256 __M) {
    __v8si __a = (__v8si)__A, __b = (__v8si)__B, __m = (__v8si)__M;
    for (int __i = 0; __i < 8; __i++)
        if (__m[__i] < 0)
            __a[__i] = __b[__i];
    return (__m256)__a;
}

static inline __m256d _mm256_blendv_pd(__m256d __A, __m256d __B, __m256d __M) {
    __v4di __a = (__v4di)__A, __b = (__v4di)__B, __m = (__v4di)__M;
    for (int __i = 0; __i < 4; __i++)
        if (__m[__i] < 0)
            __a[__i] = __b[__i];
    return (__m256d)__a;
}

static inline int _mm256_movemask_ps(__m256 __A) {
    return _mm_movemask_ps(__badc_lo_ps(__A)) | _mm_movemask_ps(__badc_hi_ps(__A)) << 4;
}

static inline int _mm256_movemask_pd(__m256d __A) {
    return _mm_movemask_pd(__badc_lo_pd(__A)) | _mm_movemask_pd(__badc_hi_pd(__A)) << 2;
}

/* AVX's compare predicates: bits 0-3 the relation, among which those with
** bit 0 or 1 set, but not both, signal, and bit 4 swaps quiet and signaling.
** A signaling one raises invalid for any NaN operand, a quiet one only for a
** signaling NaN. */
static inline int __badc_cmp_holds(double __a, double __b, int __p) {
    int __unord = __builtin_isunordered(__a, __b);
    int __lt = __builtin_isless(__a, __b), __eq = __a == __b;
    if (((__p & 3) == 1 || (__p & 3) == 2) ^ (__p >> 4 & 1)) {
        volatile int __signal = __a < __b;
        (void)__signal;
    }
    switch (__p & 15) {
    case 0: return __eq;
    case 1: return __lt;
    case 2: return __lt || __eq;
    case 3: return __unord;
    case 4: return !__eq;
    case 5: return !__lt;
    case 6: return !(__lt || __eq);
    case 7: return !__unord;
    case 8: return __eq || __unord;
    case 9: return __lt || __unord;
    case 10: return __lt || __eq || __unord;
    case 11: return 0;
    case 12: return !__eq && !__unord;
    case 13: return !__lt && !__unord;
    case 14: return !__lt && !__eq && !__unord;
    default: return 1;
    }
}

static inline __m256 _mm256_cmp_ps(__m256 __A, __m256 __B, const int __P) {
    __v8si __r;
    for (int __i = 0; __i < 8; __i++)
        __r[__i] = -__badc_cmp_holds(__A[__i], __B[__i], __P);
    return (__m256)__r;
}

static inline __m256d _mm256_cmp_pd(__m256d __A, __m256d __B, const int __P) {
    __v4di __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = -(long long)__badc_cmp_holds(__A[__i], __B[__i], __P);
    return (__m256d)__r;
}

static inline __m128 _mm_cmp_ps(__m128 __A, __m128 __B, const int __P) {
    __v4si __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = -__badc_cmp_holds(__A[__i], __B[__i], __P);
    return (__m128)__r;
}

static inline __m128d _mm_cmp_pd(__m128d __A, __m128d __B, const int __P) {
    __v2di __r;
    for (int __i = 0; __i < 2; __i++)
        __r[__i] = -(long long)__badc_cmp_holds(__A[__i], __B[__i], __P);
    return (__m128d)__r;
}

static inline __m128 _mm_cmp_ss(__m128 __A, __m128 __B, const int __P) {
    __v4si __r = (__v4si)__A;
    __r[0] = -__badc_cmp_holds(__A[0], __B[0], __P);
    return (__m128)__r;
}

static inline __m128d _mm_cmp_sd(__m128d __A, __m128d __B, const int __P) {
    __v2di __r = (__v2di)__A;
    __r[0] = -(long long)__badc_cmp_holds(__A[0], __B[0], __P);
    return (__m128d)__r;
}

#define _CMP_EQ_OQ 0x00
#define _CMP_LT_OS 0x01
#define _CMP_LE_OS 0x02
#define _CMP_UNORD_Q 0x03
#define _CMP_NEQ_UQ 0x04
#define _CMP_NLT_US 0x05
#define _CMP_NLE_US 0x06
#define _CMP_ORD_Q 0x07
#define _CMP_EQ_UQ 0x08
#define _CMP_NGE_US 0x09
#define _CMP_NGT_US 0x0a
#define _CMP_FALSE_OQ 0x0b
#define _CMP_NEQ_OQ 0x0c
#define _CMP_GE_OS 0x0d
#define _CMP_GT_OS 0x0e
#define _CMP_TRUE_UQ 0x0f
#define _CMP_EQ_OS 0x10
#define _CMP_LT_OQ 0x11
#define _CMP_LE_OQ 0x12
#define _CMP_UNORD_S 0x13
#define _CMP_NEQ_US 0x14
#define _CMP_NLT_UQ 0x15
#define _CMP_NLE_UQ 0x16
#define _CMP_ORD_S 0x17
#define _CMP_EQ_US 0x18
#define _CMP_NGE_UQ 0x19
#define _CMP_NGT_UQ 0x1a
#define _CMP_FALSE_OS 0x1b
#define _CMP_NEQ_OS 0x1c
#define _CMP_GE_OQ 0x1d
#define _CMP_GT_OQ 0x1e
#define _CMP_TRUE_US 0x1f

static inline __m256 _mm256_cvtepi32_ps(__m256i __A) {
    return __badc_join_ps(_mm_cvtepi32_ps(_mm256_castsi256_si128(__A)),
                          _mm_cvtepi32_ps(_mm256_extracti128_si256(__A, 1)));
}

static inline __m256i _mm256_cvtps_epi32(__m256 __A) {
    return _mm256_set_m128i(_mm_cvtps_epi32(__badc_hi_ps(__A)), _mm_cvtps_epi32(__badc_lo_ps(__A)));
}

static inline __m256i _mm256_cvttps_epi32(__m256 __A) {
    return _mm256_set_m128i(_mm_cvttps_epi32(__badc_hi_ps(__A)),
                            _mm_cvttps_epi32(__badc_lo_ps(__A)));
}

/* AVX-512F with VL: the unsigned doubleword conversions. */
static inline __m128 _mm_cvtepu32_ps(__m128i __A) {
    return __builtin_ia32_cvtudq2ps128((__v4si)__A);
}

static inline __m128i _mm_cvtps_epu32(__m128 __A) {
    return (__m128i)__builtin_ia32_cvtps2udq128(__A);
}

static inline __m128i _mm_cvttps_epu32(__m128 __A) {
    return (__m128i)__builtin_ia32_cvttps2udq128(__A);
}

static inline __m256 _mm256_cvtepu32_ps(__m256i __A) {
    return __badc_join_ps(_mm_cvtepu32_ps(_mm256_castsi256_si128(__A)),
                          _mm_cvtepu32_ps(_mm256_extracti128_si256(__A, 1)));
}

static inline __m256i _mm256_cvtps_epu32(__m256 __A) {
    return _mm256_set_m128i(_mm_cvtps_epu32(__badc_hi_ps(__A)), _mm_cvtps_epu32(__badc_lo_ps(__A)));
}

static inline __m256i _mm256_cvttps_epu32(__m256 __A) {
    return _mm256_set_m128i(_mm_cvttps_epu32(__badc_hi_ps(__A)),
                            _mm_cvttps_epu32(__badc_lo_ps(__A)));
}

static inline __m256d _mm256_cvtps_pd(__m128 __A) {
    return __badc_join_pd(_mm_cvtps_pd(__A), _mm_cvtps_pd(_mm_movehl_ps(__A, __A)));
}

static inline __m128 _mm256_cvtpd_ps(__m256d __A) {
    return _mm_movelh_ps(_mm_cvtpd_ps(__badc_lo_pd(__A)), _mm_cvtpd_ps(__badc_hi_pd(__A)));
}

static inline __m256d _mm256_cvtepi32_pd(__m128i __A) {
    return __badc_join_pd(_mm_cvtepi32_pd(__A), _mm_cvtepi32_pd(_mm_shuffle_epi32(__A, 0x0E)));
}

static inline __m128i _mm256_cvtpd_epi32(__m256d __A) {
    return _mm_unpacklo_epi64(_mm_cvtpd_epi32(__badc_lo_pd(__A)), _mm_cvtpd_epi32(__badc_hi_pd(__A)));
}

static inline __m128i _mm256_cvttpd_epi32(__m256d __A) {
    return _mm_unpacklo_epi64(_mm_cvttpd_epi32(__badc_lo_pd(__A)),
                              _mm_cvttpd_epi32(__badc_hi_pd(__A)));
}

static inline float _mm256_cvtss_f32(__m256 __A) {
    return __A[0];
}

static inline double _mm256_cvtsd_f64(__m256d __A) {
    return __A[0];
}

__BADC_MASKMOV(_mm_maskload_ps, _mm_maskstore_ps, __m128, __m128i, float, __v4si, int, 4)
__BADC_MASKMOV(_mm256_maskload_ps, _mm256_maskstore_ps, __m256, __m256i, float, __v8si, int, 8)
__BADC_MASKMOV(_mm_maskload_pd, _mm_maskstore_pd, __m128d, __m128i, double, __v2di, long long, 2)
__BADC_MASKMOV(_mm256_maskload_pd, _mm256_maskstore_pd, __m256d, __m256i, double, __v4di,
               long long, 4)
#undef __BADC_MASKMOV

/* VBROADCASTSS / VBROADCASTSD from a register. */
static inline __m128 _mm_broadcastss_ps(__m128 __X) {
    return (__m128)_mm_set1_epi32(((__v4si)__X)[0]);
}

static inline __m256 _mm256_broadcastss_ps(__m128 __X) {
    return (__m256)_mm256_set1_epi32(((__v4si)__X)[0]);
}

static inline __m128d _mm_broadcastsd_pd(__m128d __X) {
    return (__m128d)_mm_set1_epi64x(((__v2di)__X)[0]);
}

static inline __m256d _mm256_broadcastsd_pd(__m128d __X) {
    return (__m256d)_mm256_set1_epi64x(((__v2di)__X)[0]);
}

/* VPERMILPS / VPERMILPD by a vector: each lane picks within its 128-bit
** lane, PS by the selector's low two bits, PD by its bit 1. VPERMPD and
** VPERMPS pick across the whole register. */
static inline __m128 _mm_permutevar_ps(__m128 __A, __m128i __C) {
    __v4si __a = (__v4si)__A, __c = (__v4si)__C, __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = __a[__c[__i] & 3];
    return (__m128)__r;
}

static inline __m256 _mm256_permutevar_ps(__m256 __A, __m256i __C) {
    __v8si __a = (__v8si)__A, __c = (__v8si)__C, __r;
    for (int __i = 0; __i < 8; __i++)
        __r[__i] = __a[(__i & 4) | (__c[__i] & 3)];
    return (__m256)__r;
}

static inline __m128d _mm_permutevar_pd(__m128d __A, __m128i __C) {
    __v2di __a = (__v2di)__A, __c = (__v2di)__C, __r;
    for (int __i = 0; __i < 2; __i++)
        __r[__i] = __a[__c[__i] >> 1 & 1];
    return (__m128d)__r;
}

static inline __m256d _mm256_permutevar_pd(__m256d __A, __m256i __C) {
    __v4di __a = (__v4di)__A, __c = (__v4di)__C, __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = __a[(__i & 2) | (__c[__i] >> 1 & 1)];
    return (__m256d)__r;
}

#define _mm256_permute4x64_pd(A, M) ((__m256d)_mm256_permute4x64_epi64((__m256i)(A), M))

static inline __m256 _mm256_permutevar8x32_ps(__m256 __A, __m256i __I) {
    return (__m256)_mm256_permutevar8x32_epi32((__m256i)__A, __I);
}

/* VTESTPS / VTESTPD: PTEST's flags over the lanes' sign bits alone. */
#define __BADC_VTEST(name, ty, lty, n, lane)                                      \
    static inline int name(ty __A, ty __B) {                                      \
        lty __a = (lty)__A, __b = (lty)__B;                                       \
        int __f = 1;                                                              \
        for (int __i = 0; __i < n; __i++)                                         \
            __f &= (lane) >= 0;                                                   \
        return __f;                                                               \
    }
__BADC_VTEST(_mm_testz_ps, __m128, __v4si, 4, __a[__i] & __b[__i])
__BADC_VTEST(_mm_testc_ps, __m128, __v4si, 4, ~__a[__i] & __b[__i])
__BADC_VTEST(_mm256_testz_ps, __m256, __v8si, 8, __a[__i] & __b[__i])
__BADC_VTEST(_mm256_testc_ps, __m256, __v8si, 8, ~__a[__i] & __b[__i])
__BADC_VTEST(_mm_testz_pd, __m128d, __v2di, 2, __a[__i] & __b[__i])
__BADC_VTEST(_mm_testc_pd, __m128d, __v2di, 2, ~__a[__i] & __b[__i])
__BADC_VTEST(_mm256_testz_pd, __m256d, __v4di, 4, __a[__i] & __b[__i])
__BADC_VTEST(_mm256_testc_pd, __m256d, __v4di, 4, ~__a[__i] & __b[__i])
#undef __BADC_VTEST

static inline int _mm_testnzc_ps(__m128 __A, __m128 __B) {
    return !_mm_testz_ps(__A, __B) && !_mm_testc_ps(__A, __B);
}

static inline int _mm256_testnzc_ps(__m256 __A, __m256 __B) {
    return !_mm256_testz_ps(__A, __B) && !_mm256_testc_ps(__A, __B);
}

static inline int _mm_testnzc_pd(__m128d __A, __m128d __B) {
    return !_mm_testz_pd(__A, __B) && !_mm_testc_pd(__A, __B);
}

static inline int _mm256_testnzc_pd(__m256d __A, __m256d __B) {
    return !_mm256_testz_pd(__A, __B) && !_mm256_testc_pd(__A, __B);
}

/* ROUNDPS / ROUNDPD and DPPS on each 128-bit half. */
static inline __m256 _mm256_round_ps(__m256 __A, const int __M) {
    return __badc_join_ps(_mm_round_ps(__badc_lo_ps(__A), __M), _mm_round_ps(__badc_hi_ps(__A), __M));
}

static inline __m256d _mm256_round_pd(__m256d __A, const int __M) {
    return __badc_join_pd(_mm_round_pd(__badc_lo_pd(__A), __M), _mm_round_pd(__badc_hi_pd(__A), __M));
}

#define _mm256_floor_ps(V) _mm256_round_ps((V), _MM_FROUND_FLOOR)
#define _mm256_floor_pd(V) _mm256_round_pd((V), _MM_FROUND_FLOOR)
#define _mm256_ceil_ps(V) _mm256_round_ps((V), _MM_FROUND_CEIL)
#define _mm256_ceil_pd(V) _mm256_round_pd((V), _MM_FROUND_CEIL)

static inline __m256 _mm256_dp_ps(__m256 __A, __m256 __B, const int __M) {
    return __badc_join_ps(_mm_dp_ps(__badc_lo_ps(__A), __badc_lo_ps(__B), __M),
                          _mm_dp_ps(__badc_hi_ps(__A), __badc_hi_ps(__B), __M));
}

static inline void _mm256_stream_ps(float *__P, __m256 __A) {
    _mm256_storeu_ps(__P, __A);
}

static inline void _mm256_stream_pd(double *__P, __m256d __A) {
    _mm256_storeu_pd(__P, __A);
}

static inline __m256 _mm256_loadu2_m128(float const *__H, float const *__L) {
    return __badc_join_ps(_mm_loadu_ps(__L), _mm_loadu_ps(__H));
}

static inline __m256d _mm256_loadu2_m128d(double const *__H, double const *__L) {
    return __badc_join_pd(_mm_loadu_pd(__L), _mm_loadu_pd(__H));
}

static inline void _mm256_storeu2_m128(float *__H, float *__L, __m256 __A) {
    _mm_storeu_ps(__L, __badc_lo_ps(__A));
    _mm_storeu_ps(__H, __badc_hi_ps(__A));
}

static inline void _mm256_storeu2_m128d(double *__H, double *__L, __m256d __A) {
    _mm_storeu_pd(__L, __badc_lo_pd(__A));
    _mm_storeu_pd(__H, __badc_hi_pd(__A));
}

/* The SDM leaves the lanes undefined; these give zero. */
static inline __m256 _mm256_undefined_ps(void) {
    return _mm256_setzero_ps();
}

static inline __m256d _mm256_undefined_pd(void) {
    return _mm256_setzero_pd();
}

/* VZEROUPPER / VZEROALL: no VEX instruction is emitted, so no upper state
** is left to clear. */
static inline void _mm256_zeroupper(void) {
}

static inline void _mm256_zeroall(void) {
}

/* FMA3: each lane rounds once, as fma does; the subtracting and negating
** forms negate an operand, and the scalar forms keep the first operand's
** upper lanes. */
#define __BADC_FMA(name, ty, n, fma, x, y, z)                                  \
    static inline ty name(ty __A, ty __B, ty __C) {                           \
        ty __r;                                                               \
        for (int __i = 0; __i < n; __i++)                                     \
            __r[__i] = fma(x __A[__i], __B[__i], y __C[__i]);                 \
        return __r;                                                           \
    }
#define __BADC_FMA_ALL(op, x, y)                                               \
    __BADC_FMA(_mm_##op##_ps, __m128, 4, __builtin_fmaf, x, y, )               \
    __BADC_FMA(_mm_##op##_pd, __m128d, 2, __builtin_fma, x, y, )               \
    __BADC_FMA(_mm256_##op##_ps, __m256, 8, __builtin_fmaf, x, y, )            \
    __BADC_FMA(_mm256_##op##_pd, __m256d, 4, __builtin_fma, x, y, )            \
    static inline __m128 _mm_##op##_ss(__m128 __A, __m128 __B, __m128 __C) {  \
        __A[0] = __builtin_fmaf(x __A[0], __B[0], y __C[0]);                  \
        return __A;                                                           \
    }                                                                         \
    static inline __m128d _mm_##op##_sd(__m128d __A, __m128d __B, __m128d __C) { \
        __A[0] = __builtin_fma(x __A[0], __B[0], y __C[0]);                   \
        return __A;                                                           \
    }
__BADC_FMA_ALL(fmadd, +, +)
__BADC_FMA_ALL(fmsub, +, -)
__BADC_FMA_ALL(fnmadd, -, +)
__BADC_FMA_ALL(fnmsub, -, -)
#undef __BADC_FMA_ALL
#undef __BADC_FMA

/* FMADDSUB subtracts on the even lanes and adds on the odd; FMSUBADD the
** reverse. */
#define __BADC_FMA_ALT(name, ty, n, fma, even)                                 \
    static inline ty name(ty __A, ty __B, ty __C) {                           \
        ty __r;                                                               \
        for (int __i = 0; __i < n; __i++)                                     \
            __r[__i] = fma(__A[__i], __B[__i], (__i & 1) == even ? __C[__i] : -__C[__i]); \
        return __r;                                                           \
    }
__BADC_FMA_ALT(_mm_fmaddsub_ps, __m128, 4, __builtin_fmaf, 1)
__BADC_FMA_ALT(_mm_fmaddsub_pd, __m128d, 2, __builtin_fma, 1)
__BADC_FMA_ALT(_mm256_fmaddsub_ps, __m256, 8, __builtin_fmaf, 1)
__BADC_FMA_ALT(_mm256_fmaddsub_pd, __m256d, 4, __builtin_fma, 1)
__BADC_FMA_ALT(_mm_fmsubadd_ps, __m128, 4, __builtin_fmaf, 0)
__BADC_FMA_ALT(_mm_fmsubadd_pd, __m128d, 2, __builtin_fma, 0)
__BADC_FMA_ALT(_mm256_fmsubadd_ps, __m256, 8, __builtin_fmaf, 0)
__BADC_FMA_ALT(_mm256_fmsubadd_pd, __m256d, 4, __builtin_fma, 0)
#undef __BADC_FMA_ALT

static inline int _rdrand16_step(unsigned short *__P) {
    return __builtin_ia32_rdrand16_step(__P);
}

static inline int _rdrand32_step(unsigned int *__P) {
    return __builtin_ia32_rdrand32_step(__P);
}

#ifdef __x86_64__
static inline int _rdrand64_step(unsigned long long *__P) {
    return __builtin_ia32_rdrand64_step(__P);
}
#endif

static inline int _rdseed16_step(unsigned short *__P) {
    return __builtin_ia32_rdseed16_step(__P);
}

static inline int _rdseed32_step(unsigned int *__P) {
    return __builtin_ia32_rdseed32_step(__P);
}

#ifdef __x86_64__
static inline int _rdseed64_step(unsigned long long *__P) {
    return __builtin_ia32_rdseed64_step(__P);
}
#endif

/* XCR[__A], as gcc's <immintrin.h> carries it through <xsaveintrin.h>. */
static inline long long _xgetbv(unsigned int __A) {
    return __builtin_ia32_xgetbv(__A);
}

/* XCR0's index, as MSVC's <immintrin.h> names it. */
#define _XCR_XFEATURE_ENABLED_MASK 0

/* F16C, from the operation the SDM gives VCVTPS2PH and VCVTPH2PS: equal to
** the instructions' results and MXCSR exception flags on every operand and
** rounding control, so they run on any processor and under the
** interpreter. Exceptions are taken as masked. */
#define __BADC_MXCSR_IE 0x01u
#define __BADC_MXCSR_DE 0x02u
#define __BADC_MXCSR_OE 0x08u
#define __BADC_MXCSR_UE 0x10u
#define __BADC_MXCSR_PE 0x20u

/* Whether rounding `__m` with the dropped bits `__r`, `__s` of them, under
** rounding control `__rc` increments it. */
static inline unsigned __badc_rounds_up(unsigned __m, unsigned __r, int __s, unsigned __rc,
                                        unsigned __sign) {
    unsigned long long __half = __s < 64 ? 1ull << (__s - 1) : ~0ull;
    if (!__r)
        return 0;
    switch (__rc & 3) {
    case 0: return __r > __half || (__r == __half && (__m & 1));
    case 1: return __sign != 0;
    case 2: return __sign == 0;
    default: return 0;
    }
}

/* Binary32 `__x` to binary16 under rounding control `__rc` (MXCSR.RC's
** encoding), as VCVTPS2PH converts it: MXCSR.DAZ zeroes a denormal operand,
** FTZ does not apply, and tininess is detected after rounding. Or's the
** exception flags it raises into `*__flags`. */
static inline unsigned short __badc_f32_to_f16(unsigned __x, unsigned __rc, unsigned __csr,
                                               unsigned *__flags) {
    unsigned __sign = __x >> 16 & 0x8000u, __exp = __x >> 23 & 0xffu, __man = __x & 0x7fffffu;
    if (__exp == 0xffu) {
        if (!__man)
            return (unsigned short)(__sign | 0x7c00u);
        if (!(__man & 0x400000u))
            *__flags |= __BADC_MXCSR_IE;
        return (unsigned short)(__sign | 0x7e00u | __man >> 13);
    }
    if (!__exp) {
        if (!__man || (__csr & 0x40u))
            return (unsigned short)__sign;
        *__flags |= __BADC_MXCSR_DE;
    }
    unsigned __sig = __exp ? __man | 0x800000u : __man;
    int __e = __exp ? (int)__exp - 150 : -149, __ue = __e + 31 - __builtin_clz(__sig);
    int __s = (__ue >= -14 ? __ue - 10 : -24) - __e;
    unsigned __m = __s < 32 ? __sig >> __s : 0;
    unsigned __r = __s < 32 ? __sig & ((1u << __s) - 1) : __sig;
    __m += __badc_rounds_up(__m, __r, __s, __rc, __sign);
    unsigned __bits = __ue >= -14 ? (unsigned)((__ue + 15) << 10) + __m - 1024u : __m;
    if (__bits >= 0x7c00u) {
        *__flags |= __BADC_MXCSR_OE | __BADC_MXCSR_PE;
        unsigned __rd = __rc & 3;
        int __inf = __rd == 0 || (__rd == 1 && __sign) || (__rd == 2 && !__sign);
        return (unsigned short)(__sign | (__inf ? 0x7c00u : 0x7bffu));
    }
    if (__r) {
        /* Below 2^-14 once rounded to 11 bits with the exponent unbounded. */
        unsigned __m11 = __sig >> 13;
        int __tiny = __ue < -15 ||
                     (__ue == -15 &&
                      __m11 + __badc_rounds_up(__m11, __sig & 0x1fffu, 13, __rc, __sign) < 2048);
        *__flags |= __BADC_MXCSR_PE | (__tiny ? __BADC_MXCSR_UE : 0);
    }
    return (unsigned short)(__sign | __bits);
}

/* Binary16 `__h` to binary32, exact and raising no exception, as VCVTPH2PS
** converts it: a signaling NaN is quieted, a denormal kept. */
static inline unsigned __badc_f16_to_f32(unsigned __h, unsigned __csr, unsigned *__flags) {
    unsigned __sign = (__h & 0x8000u) << 16, __exp = __h >> 10 & 0x1fu, __man = __h & 0x3ffu;
    (void)__csr, (void)__flags;
    if (__exp == 0x1fu) {
        return __sign | 0x7f800000u | (__man ? 0x400000u | __man << 13 : 0);
    }
    if (!__exp) {
        if (!__man)
            return __sign;
        int __top = 31 - __builtin_clz(__man);
        return __sign | (unsigned)(__top + 103) << 23 | (__man << (23 - __top) & 0x7fffffu);
    }
    return __sign | (__exp + 112) << 23 | __man << 13;
}

static inline unsigned __badc_f32_bits(float __f) {
    union { float __f; unsigned __u; } __v = {__f};
    return __v.__u;
}

static inline float __badc_bits_f32(unsigned __u) {
    union { unsigned __u; float __f; } __v = {__u};
    return __v.__f;
}

/* Converts `__n` lanes of `__a` under the immediate `__imm`: its bits 1:0
** select the rounding, unless bit 2 defers to MXCSR.RC. */
static inline void __badc_cvtps_ph(const float *__a, unsigned short *__dst, int __n, int __imm) {
    unsigned __csr = _mm_getcsr(), __flags = 0;
    unsigned __rc = (__imm & 4) ? __csr >> 13 & 3 : (unsigned)__imm & 3;
    for (int __i = 0; __i < __n; __i++)
        __dst[__i] = __badc_f32_to_f16(__badc_f32_bits(__a[__i]), __rc, __csr, &__flags);
    if (__flags)
        _mm_setcsr(__csr | __flags);
}

static inline float _cvtsh_ss(unsigned short __h) {
    unsigned __flags = 0;
    return __badc_bits_f32(__badc_f16_to_f32(__h, 0, &__flags));
}

static inline unsigned short _cvtss_sh(float __f, int __imm) {
    unsigned short __h;
    __badc_cvtps_ph(&__f, &__h, 1, __imm);
    return __h;
}

static inline __m128 _mm_cvtph_ps(__m128i __A) {
    __v8hi __h = (__v8hi)__A;
    __m128 __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = _cvtsh_ss((unsigned short)__h[__i]);
    return __r;
}

static inline __m256 _mm256_cvtph_ps(__m128i __A) {
    __v8hi __h = (__v8hi)__A;
    __m256 __r;
    for (int __i = 0; __i < 8; __i++)
        __r[__i] = _cvtsh_ss((unsigned short)__h[__i]);
    return __r;
}

static inline __m128i _mm_cvtps_ph(__m128 __A, int __imm) {
    float __a[4] = {__A[0], __A[1], __A[2], __A[3]};
    unsigned short __h[8] = {0};
    __badc_cvtps_ph(__a, __h, 4, __imm);
    __m128i __r;
    __builtin_memcpy(&__r, __h, sizeof __r);
    return __r;
}

static inline __m128i _mm256_cvtps_ph(__m256 __A, int __imm) {
    float __a[8];
    __builtin_memcpy(__a, &__A, sizeof __a);
    unsigned short __h[8];
    __badc_cvtps_ph(__a, __h, 8, __imm);
    __m128i __r;
    __builtin_memcpy(&__r, __h, sizeof __r);
    return __r;
}

/* The SHA extensions, from the operation the SDM gives each instruction;
** element 0 holds bits 31:0. */
static inline unsigned __badc_rol32(unsigned __x, int __n) {
    return __x << __n | __x >> (32 - __n);
}

static inline unsigned __badc_ror32(unsigned __x, int __n) {
    return __x >> __n | __x << (32 - __n);
}

static inline __m128i _mm_sha1nexte_epu32(__m128i __A, __m128i __B) {
    __v4su __b = (__v4su)__B;
    __b[3] += __badc_rol32(((__v4su)__A)[3], 30);
    return (__m128i)__b;
}

static inline __m128i _mm_sha1msg1_epu32(__m128i __A, __m128i __B) {
    __v4su __a = (__v4su)__A, __b = (__v4su)__B;
    return (__m128i)(__v4su){__b[2] ^ __a[0], __b[3] ^ __a[1], __a[0] ^ __a[2], __a[1] ^ __a[3]};
}

static inline __m128i _mm_sha1msg2_epu32(__m128i __A, __m128i __B) {
    __v4su __a = (__v4su)__A, __b = (__v4su)__B;
    unsigned __w16 = __badc_rol32(__a[3] ^ __b[2], 1), __w17 = __badc_rol32(__a[2] ^ __b[1], 1);
    unsigned __w18 = __badc_rol32(__a[1] ^ __b[0], 1), __w19 = __badc_rol32(__a[0] ^ __w16, 1);
    return (__m128i)(__v4su){__w19, __w18, __w17, __w16};
}

static inline __m128i _mm_sha1rnds4_epu32(__m128i __A, __m128i __B, int __F) {
    static const unsigned __k[4] = {0x5A827999, 0x6ED9EBA1, 0x8F1BBCDC, 0xCA62C1D6};
    __v4su __a = (__v4su)__A, __b = (__v4su)__B;
    unsigned __w[4] = {__b[3], __b[2], __b[1], __b[0]};
    unsigned __ra = __a[3], __rb = __a[2], __rc = __a[1], __rd = __a[0], __re = 0;
    for (int __i = 0; __i < 4; __i++) {
        unsigned __f;
        switch (__F & 3) {
        case 0: __f = (__rb & __rc) ^ (~__rb & __rd); break;
        case 2: __f = (__rb & __rc) ^ (__rb & __rd) ^ (__rc & __rd); break;
        default: __f = __rb ^ __rc ^ __rd; break;
        }
        unsigned __t = __f + __badc_rol32(__ra, 5) + __w[__i] + __re + __k[__F & 3];
        __re = __rd, __rd = __rc, __rc = __badc_rol32(__rb, 30), __rb = __ra, __ra = __t;
    }
    return (__m128i)(__v4su){__rd, __rc, __rb, __ra};
}

static inline __m128i _mm_sha256rnds2_epu32(__m128i __A, __m128i __B, __m128i __K) {
    __v4su __a = (__v4su)__A, __b = (__v4su)__B, __k = (__v4su)__K;
    unsigned __ra = __b[3], __rb = __b[2], __rc = __a[3], __rd = __a[2];
    unsigned __re = __b[1], __rf = __b[0], __rg = __a[1], __rh = __a[0];
    for (int __i = 0; __i < 2; __i++) {
        unsigned __s1 = __badc_ror32(__re, 6) ^ __badc_ror32(__re, 11) ^ __badc_ror32(__re, 25);
        unsigned __s0 = __badc_ror32(__ra, 2) ^ __badc_ror32(__ra, 13) ^ __badc_ror32(__ra, 22);
        unsigned __t = ((__re & __rf) ^ (~__re & __rg)) + __s1 + __k[__i] + __rh;
        unsigned __maj = (__ra & __rb) ^ (__ra & __rc) ^ (__rb & __rc);
        __rh = __rg, __rg = __rf, __rf = __re, __re = __t + __rd;
        __rd = __rc, __rc = __rb, __rb = __ra, __ra = __t + __maj + __s0;
    }
    return (__m128i)(__v4su){__rf, __re, __rb, __ra};
}

static inline unsigned __badc_sha256_s0(unsigned __w) {
    return __badc_ror32(__w, 7) ^ __badc_ror32(__w, 18) ^ (__w >> 3);
}

static inline unsigned __badc_sha256_s1(unsigned __w) {
    return __badc_ror32(__w, 17) ^ __badc_ror32(__w, 19) ^ (__w >> 10);
}

static inline __m128i _mm_sha256msg1_epu32(__m128i __A, __m128i __B) {
    __v4su __a = (__v4su)__A;
    unsigned __w4 = ((__v4su)__B)[0];
    return (__m128i)(__v4su){__a[0] + __badc_sha256_s0(__a[1]), __a[1] + __badc_sha256_s0(__a[2]),
                                   __a[2] + __badc_sha256_s0(__a[3]), __a[3] + __badc_sha256_s0(__w4)};
}

static inline __m128i _mm_sha256msg2_epu32(__m128i __A, __m128i __B) {
    __v4su __a = (__v4su)__A, __b = (__v4su)__B;
    unsigned __w16 = __a[0] + __badc_sha256_s1(__b[2]), __w17 = __a[1] + __badc_sha256_s1(__b[3]);
    unsigned __w18 = __a[2] + __badc_sha256_s1(__w16), __w19 = __a[3] + __badc_sha256_s1(__w17);
    return (__m128i)(__v4su){__w16, __w17, __w18, __w19};
}

/* BMI1's TZCNT, which gcc's <immintrin.h> carries through <bmiintrin.h>:
** the operand width for a zero operand. */
static inline unsigned int _tzcnt_u32(unsigned int __X) {
    return __X ? (unsigned int)__builtin_ctz(__X) : 32;
}

#ifdef __x86_64__
static inline unsigned long long _tzcnt_u64(unsigned long long __X) {
    return __X ? (unsigned long long)__builtin_ctzll(__X) : 64;
}
#endif

/* POPCNT, which gcc's <immintrin.h> carries through <popcntintrin.h>. */
static inline int _mm_popcnt_u32(unsigned int __X) {
    return __builtin_popcount(__X);
}

#ifdef __x86_64__
static inline long long _mm_popcnt_u64(unsigned long long __X) {
    return __builtin_popcountll(__X);
}
#endif

/* BMI1, BMI2, LZCNT and ADX, which gcc's <immintrin.h> carries through
** <bmiintrin.h>, <bmi2intrin.h>, <lzcntintrin.h> and <adxintrin.h>: the
** instructions' results, computed on any processor. */
static inline unsigned int _lzcnt_u32(unsigned int __X) {
    return __X ? (unsigned int)__builtin_clz(__X) : 32;
}
static inline unsigned short __tzcnt_u16(unsigned short __X) {
    return __X ? (unsigned short)__builtin_ctz(__X) : 16;
}
static inline unsigned short _tzcnt_u16(unsigned short __X) { return __tzcnt_u16(__X); }
static inline unsigned int __tzcnt_u32(unsigned int __X) { return _tzcnt_u32(__X); }
static inline unsigned int _andn_u32(unsigned int __X, unsigned int __Y) {
    return ~__X & __Y;
}
static inline unsigned int __bextr_u32(unsigned int __X, unsigned int __C) {
    unsigned int __s = __C & 0xff, __n = __C >> 8 & 0xff;
    unsigned int __v = __s < 32 ? __X >> __s : 0;
    return __n < 32 ? __v & ((1u << __n) - 1) : __v;
}
static inline unsigned int _bextr_u32(unsigned int __X, unsigned int __S, unsigned int __N) {
    return __bextr_u32(__X, (__S & 0xff) | (__N & 0xff) << 8);
}
static inline unsigned int _blsi_u32(unsigned int __X) { return __X & -__X; }
static inline unsigned int _blsmsk_u32(unsigned int __X) { return __X ^ (__X - 1); }
static inline unsigned int _blsr_u32(unsigned int __X) { return __X & (__X - 1); }
static inline unsigned int __andn_u32(unsigned int __X, unsigned int __Y) { return ~__X & __Y; }
static inline unsigned int __blsi_u32(unsigned int __X) { return _blsi_u32(__X); }
static inline unsigned int __blsmsk_u32(unsigned int __X) { return _blsmsk_u32(__X); }
static inline unsigned int __blsr_u32(unsigned int __X) { return _blsr_u32(__X); }
static inline unsigned int _bzhi_u32(unsigned int __X, unsigned int __Y) {
    unsigned int __n = __Y & 0xff;
    return __n < 32 ? __X & ((1u << __n) - 1) : __X;
}
static inline unsigned int _pdep_u32(unsigned int __X, unsigned int __M) {
    unsigned int __r = 0;
    for (unsigned int __b = 1; __M; __b <<= 1, __M &= __M - 1)
        if (__X & __b)
            __r |= __M & -__M;
    return __r;
}
static inline unsigned int _pext_u32(unsigned int __X, unsigned int __M) {
    unsigned int __r = 0;
    for (unsigned int __b = 1; __M; __b <<= 1, __M &= __M - 1)
        if (__X & __M & -__M)
            __r |= __b;
    return __r;
}
static inline unsigned int _mulx_u32(unsigned int __X, unsigned int __Y, unsigned int *__P) {
    unsigned long long __r = (unsigned long long)__X * __Y;
    *__P = (unsigned int)(__r >> 32);
    return (unsigned int)__r;
}
static inline unsigned char _addcarry_u32(unsigned char __C, unsigned int __X, unsigned int __Y,
                                          unsigned int *__P) {
    unsigned long long __r = (unsigned long long)__X + __Y + (__C != 0);
    *__P = (unsigned int)__r;
    return (unsigned char)(__r >> 32);
}
static inline unsigned char _addcarryx_u32(unsigned char __C, unsigned int __X, unsigned int __Y,
                                           unsigned int *__P) {
    return _addcarry_u32(__C, __X, __Y, __P);
}
static inline unsigned char _subborrow_u32(unsigned char __C, unsigned int __X, unsigned int __Y,
                                           unsigned int *__P) {
    unsigned long long __r = (unsigned long long)__X - __Y - (__C != 0);
    *__P = (unsigned int)__r;
    return (unsigned char)(__r >> 63);
}

#ifdef __x86_64__
static inline unsigned long long _lzcnt_u64(unsigned long long __X) {
    return __X ? (unsigned long long)__builtin_clzll(__X) : 64;
}
static inline unsigned long long _andn_u64(unsigned long long __X, unsigned long long __Y) {
    return ~__X & __Y;
}
static inline unsigned long long __bextr_u64(unsigned long long __X, unsigned long long __C) {
    unsigned int __s = __C & 0xff, __n = __C >> 8 & 0xff;
    unsigned long long __v = __s < 64 ? __X >> __s : 0;
    return __n < 64 ? __v & ((1ull << __n) - 1) : __v;
}
static inline unsigned long long _bextr_u64(unsigned long long __X, unsigned int __S,
                                            unsigned int __N) {
    return __bextr_u64(__X, (__S & 0xff) | (__N & 0xff) << 8);
}
static inline unsigned long long _blsi_u64(unsigned long long __X) { return __X & -__X; }
static inline unsigned long long _blsmsk_u64(unsigned long long __X) { return __X ^ (__X - 1); }
static inline unsigned long long _blsr_u64(unsigned long long __X) { return __X & (__X - 1); }
static inline unsigned long long __andn_u64(unsigned long long __X, unsigned long long __Y) {
    return ~__X & __Y;
}
static inline unsigned long long __blsi_u64(unsigned long long __X) { return _blsi_u64(__X); }
static inline unsigned long long __blsmsk_u64(unsigned long long __X) { return _blsmsk_u64(__X); }
static inline unsigned long long __blsr_u64(unsigned long long __X) { return _blsr_u64(__X); }
static inline unsigned long long __tzcnt_u64(unsigned long long __X) { return _tzcnt_u64(__X); }
static inline unsigned long long _bzhi_u64(unsigned long long __X, unsigned int __Y) {
    unsigned int __n = __Y & 0xff;
    return __n < 64 ? __X & ((1ull << __n) - 1) : __X;
}
static inline unsigned long long _pdep_u64(unsigned long long __X, unsigned long long __M) {
    unsigned long long __r = 0;
    for (unsigned long long __b = 1; __M; __b <<= 1, __M &= __M - 1)
        if (__X & __b)
            __r |= __M & -__M;
    return __r;
}
static inline unsigned long long _pext_u64(unsigned long long __X, unsigned long long __M) {
    unsigned long long __r = 0;
    for (unsigned long long __b = 1; __M; __b <<= 1, __M &= __M - 1)
        if (__X & __M & -__M)
            __r |= __b;
    return __r;
}
static inline unsigned long long _mulx_u64(unsigned long long __X, unsigned long long __Y,
                                           unsigned long long *__P) {
    unsigned __int128 __r = (unsigned __int128)__X * __Y;
    *__P = (unsigned long long)(__r >> 64);
    return (unsigned long long)__r;
}
static inline unsigned char _addcarry_u64(unsigned char __C, unsigned long long __X,
                                          unsigned long long __Y, unsigned long long *__P) {
    unsigned __int128 __r = (unsigned __int128)__X + __Y + (__C != 0);
    *__P = (unsigned long long)__r;
    return (unsigned char)(__r >> 64);
}
static inline unsigned char _addcarryx_u64(unsigned char __C, unsigned long long __X,
                                           unsigned long long __Y, unsigned long long *__P) {
    return _addcarry_u64(__C, __X, __Y, __P);
}
static inline unsigned char _subborrow_u64(unsigned char __C, unsigned long long __X,
                                           unsigned long long __Y, unsigned long long *__P) {
    unsigned __int128 __r = (unsigned __int128)__X - __Y - (__C != 0);
    *__P = (unsigned long long)__r;
    return (unsigned char)(__r >> 127);
}
#endif

#ifdef _WIN32
/* MSVC's BMI2 shifts and rotate, the count masked to the operand width. */
static inline unsigned int _rorx_u32(unsigned int __X, const unsigned int __N) {
    unsigned int __n = __N & 31;
    return __n ? __X >> __n | __X << (32 - __n) : __X;
}
static inline unsigned long long _rorx_u64(unsigned long long __X, const unsigned int __N) {
    unsigned int __n = __N & 63;
    return __n ? __X >> __n | __X << (64 - __n) : __X;
}
static inline int _sarx_i32(int __X, unsigned int __N) { return __X >> (__N & 31); }
static inline long long _sarx_i64(long long __X, unsigned int __N) { return __X >> (__N & 63); }
static inline unsigned int _shlx_u32(unsigned int __X, unsigned int __N) { return __X << (__N & 31); }
static inline unsigned long long _shlx_u64(unsigned long long __X, unsigned int __N) {
    return __X << (__N & 63);
}
static inline unsigned int _shrx_u32(unsigned int __X, unsigned int __N) { return __X >> (__N & 31); }
static inline unsigned long long _shrx_u64(unsigned long long __X, unsigned int __N) {
    return __X >> (__N & 63);
}
#else
/* gcc's spellings of LZCNT, which MSVC's are the compiler's own. */
static inline unsigned short __lzcnt16(unsigned short __X) {
    return __X ? (unsigned short)(__builtin_clz(__X) - 16) : 16;
}
static inline unsigned int __lzcnt32(unsigned int __X) { return _lzcnt_u32(__X); }
#ifdef __x86_64__
static inline unsigned long long __lzcnt64(unsigned long long __X) { return _lzcnt_u64(__X); }
#endif
#endif

/* CLFLUSHOPT and CLWB write a cache line back; FXSAVE / FXRSTOR and XSAVE /
** XRSTOR save and restore the processor state, XSAVE's in the components
** the mask's EDX:EAX selects. */
static inline void _mm_clflushopt(void const *__P) {
    __asm__ __volatile__("clflushopt (%0)" : : "r"(__P) : "memory");
}
static inline void _mm_clwb(void const *__P) {
    __asm__ __volatile__("clwb (%0)" : : "r"(__P) : "memory");
}
struct __badc_fxarea { char __b[512]; };
static inline void _fxsave(void *__P) {
    __asm__ __volatile__("fxsave %0" : "=m"(*(struct __badc_fxarea *)__P));
}
static inline void _fxrstor(void *__P) {
    __asm__ __volatile__("fxrstor %0" : : "m"(*(struct __badc_fxarea *)__P));
}
static inline void _xsave(void *__P, long long __M) {
    __asm__ __volatile__("xsave (%0)"
                         : : "r"(__P), "a"((unsigned int)__M), "d"((unsigned int)(__M >> 32))
                         : "memory");
}
static inline void _xrstor(void *__P, long long __M) {
    __asm__ __volatile__("xrstor (%0)"
                         : : "r"(__P), "a"((unsigned int)__M), "d"((unsigned int)(__M >> 32))
                         : "memory");
}
#ifdef __x86_64__
static inline void _fxsave64(void *__P) {
    __asm__ __volatile__("fxsave64 (%0)" : : "r"(__P) : "memory");
}
static inline void _fxrstor64(void *__P) {
    __asm__ __volatile__("fxrstor64 (%0)" : : "r"(__P) : "memory");
}
static inline void _xsave64(void *__P, long long __M) {
    __asm__ __volatile__("xsave64 (%0)"
                         : : "r"(__P), "a"((unsigned int)__M), "d"((unsigned int)(__M >> 32))
                         : "memory");
}
static inline void _xrstor64(void *__P, long long __M) {
    __asm__ __volatile__("xrstor64 (%0)"
                         : : "r"(__P), "a"((unsigned int)__M), "d"((unsigned int)(__M >> 32))
                         : "memory");
}
#endif
#ifndef _WIN32
/* gcc's spellings of what MSVC's <intrin.h> names as the compiler's own. */
static inline void _xsetbv(unsigned int __A, unsigned long long __V) {
    __asm__ __volatile__("xsetbv" : : "c"(__A), "a"((unsigned int)__V), "d"((unsigned int)(__V >> 32)));
}
static inline void _m_prefetchw(void *__P) {
    __asm__ __volatile__("prefetchw (%0)" : : "r"(__P));
}
#endif

/* AVX-512: the 512-bit types and the integer operations of AVX512F, BW, DQ,
** CD and VNNI with VPCLMULQDQ, and the masked transfers of AVX512VL. An
** operation AVX-512 has an instruction for is gcc's builtin of it, the EVEX
** instruction on zmm registers; a mask is an integer the lowering moves
** into an opmask register; the rest are written over the vector extension.
** The forms of an imm8 are macros. */
#pragma push_macro("__attribute__")
#undef __attribute__
typedef long long __m512i __attribute__((__vector_size__(64), __aligned__(64)));
typedef long long __m512i_u __attribute__((__vector_size__(64), __may_alias__, __aligned__(1)));
typedef float __m512 __attribute__((__vector_size__(64), __aligned__(64)));
typedef double __m512d __attribute__((__vector_size__(64), __aligned__(64)));
typedef long long __v8di __attribute__((__vector_size__(64)));
typedef unsigned long long __v8du __attribute__((__vector_size__(64)));
typedef int __v16si __attribute__((__vector_size__(64)));
typedef unsigned int __v16su __attribute__((__vector_size__(64)));
typedef short __v32hi __attribute__((__vector_size__(64)));
typedef unsigned short __v32hu __attribute__((__vector_size__(64)));
typedef char __v64qi __attribute__((__vector_size__(64)));
typedef signed char __v64qs __attribute__((__vector_size__(64)));
typedef unsigned char __v64qu __attribute__((__vector_size__(64)));
typedef float __v16sf __attribute__((__vector_size__(64)));
typedef double __v8df __attribute__((__vector_size__(64)));
#pragma pop_macro("__attribute__")
typedef unsigned char __mmask8;
typedef unsigned short __mmask16;
typedef unsigned int __mmask32;
typedef unsigned long long __mmask64;

static inline __m512i _mm512_loadu_si512(void const *__P) {
    return (__m512i)__builtin_ia32_loaddqu512((char const *)__P);
}
static inline __m512i _mm512_load_si512(void const *__P) { return _mm512_loadu_si512(__P); }
static inline void _mm512_storeu_si512(void *__P, __m512i __A) {
    __builtin_ia32_storedqu512((char *)__P, __A);
}
static inline void _mm512_store_si512(void *__P, __m512i __A) { _mm512_storeu_si512(__P, __A); }
#define _mm512_loadu_epi8 _mm512_loadu_si512
#define _mm512_loadu_epi16 _mm512_loadu_si512
#define _mm512_loadu_epi32 _mm512_loadu_si512
#define _mm512_loadu_epi64 _mm512_loadu_si512
#define _mm512_storeu_epi8 _mm512_storeu_si512
#define _mm512_storeu_epi16 _mm512_storeu_si512
#define _mm512_storeu_epi32 _mm512_storeu_si512
#define _mm512_storeu_epi64 _mm512_storeu_si512

static inline __m512i _mm512_setzero_si512(void) { return (__m512i){0, 0, 0, 0, 0, 0, 0, 0}; }
#define _mm512_setzero_epi32 _mm512_setzero_si512
static inline __m512i _mm512_set1_epi64(long long __A) {
    return (__m512i){__A, __A, __A, __A, __A, __A, __A, __A};
}
static inline __m512i _mm512_set1_epi32(int __A) {
    unsigned long long __q = (unsigned)__A * 0x100000001ull;
    return _mm512_set1_epi64((long long)__q);
}
static inline __m512i _mm512_set1_epi16(short __A) {
    return _mm512_set1_epi64((long long)((unsigned short)__A * 0x0001000100010001ull));
}
static inline __m512i _mm512_set1_epi8(char __A) {
    return _mm512_set1_epi64((long long)((unsigned char)__A * 0x0101010101010101ull));
}
static inline __m512i _mm512_set_epi64(long long __H, long long __G, long long __F, long long __E,
                                       long long __D, long long __C, long long __B, long long __A) {
    return (__m512i){__A, __B, __C, __D, __E, __F, __G, __H};
}
static inline __m512i _mm512_setr_epi64(long long __A, long long __B, long long __C, long long __D,
                                        long long __E, long long __F, long long __G, long long __H) {
    return (__m512i){__A, __B, __C, __D, __E, __F, __G, __H};
}
static inline __m512i _mm512_set_epi32(int __P, int __O, int __N, int __M, int __L, int __K, int __J,
                                       int __I, int __H, int __G, int __F, int __E, int __D, int __C,
                                       int __B, int __A) {
    return (__m512i)(__v16si){__A, __B, __C, __D, __E, __F, __G, __H,
                              __I, __J, __K, __L, __M, __N, __O, __P};
}
static inline __m512i _mm512_setr_epi32(int __A, int __B, int __C, int __D, int __E, int __F, int __G,
                                        int __H, int __I, int __J, int __K, int __L, int __M, int __N,
                                        int __O, int __P) {
    return (__m512i)(__v16si){__A, __B, __C, __D, __E, __F, __G, __H,
                              __I, __J, __K, __L, __M, __N, __O, __P};
}
#define _mm512_set4_epi64(D, C, B, A) _mm512_set_epi64(D, C, B, A, D, C, B, A)
#define _mm512_set4_epi32(D, C, B, A)                                             \
    _mm512_set_epi32(D, C, B, A, D, C, B, A, D, C, B, A, D, C, B, A)

/* The casts reinterpret; the widening ones leave the upper lanes zero, as
** the zero-extending ones define. */
static inline __m256i _mm512_castsi512_si256(__m512i __A) {
    return (__m256i){__A[0], __A[1], __A[2], __A[3]};
}
static inline __m128i _mm512_castsi512_si128(__m512i __A) { return (__m128i){__A[0], __A[1]}; }
static inline __m512i _mm512_zextsi256_si512(__m256i __A) {
    return (__m512i){__A[0], __A[1], __A[2], __A[3], 0, 0, 0, 0};
}
static inline __m512i _mm512_zextsi128_si512(__m128i __A) {
    return (__m512i){__A[0], __A[1], 0, 0, 0, 0, 0, 0};
}
#define _mm512_castsi256_si512 _mm512_zextsi256_si512
#define _mm512_castsi128_si512 _mm512_zextsi128_si512
static inline __m512 _mm512_castsi512_ps(__m512i __A) { return (__m512)__A; }
static inline __m512d _mm512_castsi512_pd(__m512i __A) { return (__m512d)__A; }
static inline __m512i _mm512_castps_si512(__m512 __A) { return (__m512i)__A; }
static inline __m512i _mm512_castpd_si512(__m512d __A) { return (__m512i)__A; }
static inline __m512 _mm512_castpd_ps(__m512d __A) { return (__m512)__A; }
static inline __m512d _mm512_castps_pd(__m512 __A) { return (__m512d)__A; }

static inline __m256i _mm512_extracti64x4_epi64(__m512i __A, const int __N) {
    int __h = 4 * (__N & 1);
    return (__m256i){__A[__h], __A[__h + 1], __A[__h + 2], __A[__h + 3]};
}
static inline __m128i _mm512_extracti32x4_epi32(__m512i __A, const int __N) {
    int __h = 2 * (__N & 3);
    return (__m128i){__A[__h], __A[__h + 1]};
}
#define _mm512_extracti64x2_epi64 _mm512_extracti32x4_epi32
static inline __m512i _mm512_inserti64x4(__m512i __A, __m256i __B, const int __N) {
    int __h = 4 * (__N & 1);
    for (int __i = 0; __i < 4; __i++)
        __A[__h + __i] = __B[__i];
    return __A;
}
static inline __m512i _mm512_inserti32x4(__m512i __A, __m128i __B, const int __N) {
    int __h = 2 * (__N & 3);
    __A[__h] = __B[0];
    __A[__h + 1] = __B[1];
    return __A;
}
#define _mm512_inserti64x2 _mm512_inserti32x4
static inline __m512i _mm512_broadcast_i32x4(__m128i __A) {
    return (__m512i){__A[0], __A[1], __A[0], __A[1], __A[0], __A[1], __A[0], __A[1]};
}
static inline __m512i _mm512_broadcast_i64x4(__m256i __A) {
    return (__m512i){__A[0], __A[1], __A[2], __A[3], __A[0], __A[1], __A[2], __A[3]};
}
#define _mm512_broadcast_i64x2 _mm512_broadcast_i32x4
static inline __m512i _mm512_broadcastd_epi32(__m128i __A) {
    return _mm512_set1_epi32(((__v4si)__A)[0]);
}
static inline __m512i _mm512_broadcastq_epi64(__m128i __A) { return _mm512_set1_epi64(__A[0]); }
static inline __m512i _mm512_broadcastb_epi8(__m128i __A) {
    return _mm512_set1_epi8(((__v16qi)__A)[0]);
}
static inline __m512i _mm512_broadcastw_epi16(__m128i __A) {
    return _mm512_set1_epi16(((__v8hi)__A)[0]);
}

/* The element-wise integer arithmetic and the bitwise operations are the
** vector extension's operators. */
#define __BADC_512_OP(name, vec, op)                                              \
    static inline __m512i _mm512_##name(__m512i __A, __m512i __B) {               \
        return (__m512i)((vec)__A op (vec)__B);                                   \
    }
__BADC_512_OP(add_epi8, __v64qu, +)
__BADC_512_OP(add_epi16, __v32hu, +)
__BADC_512_OP(add_epi32, __v16su, +)
__BADC_512_OP(add_epi64, __v8du, +)
__BADC_512_OP(sub_epi8, __v64qu, -)
__BADC_512_OP(sub_epi16, __v32hu, -)
__BADC_512_OP(sub_epi32, __v16su, -)
__BADC_512_OP(sub_epi64, __v8du, -)
__BADC_512_OP(and_si512, __v8du, &)
__BADC_512_OP(or_si512, __v8du, |)
__BADC_512_OP(xor_si512, __v8du, ^)
#undef __BADC_512_OP
#define _mm512_and_epi32 _mm512_and_si512
#define _mm512_and_epi64 _mm512_and_si512
#define _mm512_or_epi32 _mm512_or_si512
#define _mm512_or_epi64 _mm512_or_si512
#define _mm512_xor_epi32 _mm512_xor_si512
#define _mm512_xor_epi64 _mm512_xor_si512

#define __BADC_512_ROW(name, row)                                                 \
    static inline __m512i _mm512_##name(__m512i __A, __m512i __B) {               \
        return (__m512i)__builtin_ia32_##row(__A, __B);                           \
    }
__BADC_512_ROW(andnot_si512, andnotsi512)
__BADC_512_ROW(mullo_epi16, pmullw512)
__BADC_512_ROW(mullo_epi32, pmulld512)
__BADC_512_ROW(mul_epu32, pmuludq512)
__BADC_512_ROW(mul_epi32, pmuldq512)
__BADC_512_ROW(mulhi_epi16, pmulhw512)
__BADC_512_ROW(mulhi_epu16, pmulhuw512)
__BADC_512_ROW(mulhrs_epi16, pmulhrsw512)
__BADC_512_ROW(madd_epi16, pmaddwd512)
__BADC_512_ROW(maddubs_epi16, pmaddubsw512)
__BADC_512_ROW(sad_epu8, psadbw512)
__BADC_512_ROW(adds_epi8, paddsb512)
__BADC_512_ROW(adds_epi16, paddsw512)
__BADC_512_ROW(adds_epu8, paddusb512)
__BADC_512_ROW(adds_epu16, paddusw512)
__BADC_512_ROW(subs_epi8, psubsb512)
__BADC_512_ROW(subs_epi16, psubsw512)
__BADC_512_ROW(subs_epu8, psubusb512)
__BADC_512_ROW(subs_epu16, psubusw512)
__BADC_512_ROW(avg_epu8, pavgb512)
__BADC_512_ROW(avg_epu16, pavgw512)
__BADC_512_ROW(min_epi8, pminsb512)
__BADC_512_ROW(min_epi16, pminsw512)
__BADC_512_ROW(min_epi32, pminsd512)
__BADC_512_ROW(min_epu8, pminub512)
__BADC_512_ROW(min_epu16, pminuw512)
__BADC_512_ROW(min_epu32, pminud512)
__BADC_512_ROW(max_epi8, pmaxsb512)
__BADC_512_ROW(max_epi16, pmaxsw512)
__BADC_512_ROW(max_epi32, pmaxsd512)
__BADC_512_ROW(max_epu8, pmaxub512)
__BADC_512_ROW(max_epu16, pmaxuw512)
__BADC_512_ROW(max_epu32, pmaxud512)
__BADC_512_ROW(packs_epi16, packsswb512)
__BADC_512_ROW(packs_epi32, packssdw512)
__BADC_512_ROW(packus_epi16, packuswb512)
__BADC_512_ROW(packus_epi32, packusdw512)
__BADC_512_ROW(unpacklo_epi8, punpcklbw512)
__BADC_512_ROW(unpacklo_epi16, punpcklwd512)
__BADC_512_ROW(unpacklo_epi32, punpckldq512)
__BADC_512_ROW(unpacklo_epi64, punpcklqdq512)
__BADC_512_ROW(unpackhi_epi8, punpckhbw512)
__BADC_512_ROW(unpackhi_epi16, punpckhwd512)
__BADC_512_ROW(unpackhi_epi32, punpckhdq512)
__BADC_512_ROW(unpackhi_epi64, punpckhqdq512)
__BADC_512_ROW(shuffle_epi8, pshufb512)
#undef __BADC_512_ROW
#define _mm512_andnot_epi32 _mm512_andnot_si512
#define _mm512_andnot_epi64 _mm512_andnot_si512

static inline __m512i _mm512_abs_epi8(__m512i __A) { return (__m512i)__builtin_ia32_pabsb512(__A); }
static inline __m512i _mm512_abs_epi16(__m512i __A) { return (__m512i)__builtin_ia32_pabsw512(__A); }
static inline __m512i _mm512_abs_epi32(__m512i __A) { return (__m512i)__builtin_ia32_pabsd512(__A); }

#define _mm512_slli_epi16(A, N) ((__m512i)__builtin_ia32_psllwi512((__m512i)(A), (int)(N)))
#define _mm512_slli_epi32(A, N) ((__m512i)__builtin_ia32_pslldi512((__m512i)(A), (int)(N)))
#define _mm512_slli_epi64(A, N) ((__m512i)__builtin_ia32_psllqi512((__m512i)(A), (int)(N)))
#define _mm512_srli_epi16(A, N) ((__m512i)__builtin_ia32_psrlwi512((__m512i)(A), (int)(N)))
#define _mm512_srli_epi32(A, N) ((__m512i)__builtin_ia32_psrldi512((__m512i)(A), (int)(N)))
#define _mm512_srli_epi64(A, N) ((__m512i)__builtin_ia32_psrlqi512((__m512i)(A), (int)(N)))
#define _mm512_srai_epi16(A, N) ((__m512i)__builtin_ia32_psrawi512((__m512i)(A), (int)(N)))
#define _mm512_srai_epi32(A, N) ((__m512i)__builtin_ia32_psradi512((__m512i)(A), (int)(N)))
#define _mm512_bslli_epi128(A, N)                                                 \
    ((__m512i)__builtin_ia32_pslldqi512((__m512i)(A), (int)(N) * 8))
#define _mm512_bsrli_epi128(A, N)                                                 \
    ((__m512i)__builtin_ia32_psrldqi512((__m512i)(A), (int)(N) * 8))
#define _mm512_shuffle_epi32(A, M) ((__m512i)__builtin_ia32_pshufd512((__m512i)(A), (int)(M)))
#define _mm512_shufflehi_epi16(A, M)                                              \
    ((__m512i)__builtin_ia32_pshufhw512((__m512i)(A), (int)(M)))
#define _mm512_shufflelo_epi16(A, M)                                              \
    ((__m512i)__builtin_ia32_pshuflw512((__m512i)(A), (int)(M)))
#define _mm512_alignr_epi8(A, B, N)                                               \
    ((__m512i)__builtin_ia32_palignr512((__m512i)(A), (__m512i)(B), (int)(N) * 8))
#define _mm512_permutex_epi64(A, M) ((__m512i)__builtin_ia32_permdi512((__m512i)(A), (int)(M)))
#define _mm512_shuffle_i64x2(A, B, M)                                             \
    ((__m512i)__builtin_ia32_shuf_i64x2((__m512i)(A), (__m512i)(B), (int)(M)))
#define _mm512_shuffle_i32x4 _mm512_shuffle_i64x2
#define _mm512_clmulepi64_epi128(A, B, I)                                         \
    ((__m512i)__builtin_ia32_pclmulqdq512((__m512i)(A), (__m512i)(B), (int)(I)))
#define _mm512_ternarylogic_epi64(A, B, C, I)                                     \
    ((__m512i)__builtin_ia32_pternlogq512((__m512i)(A), (__m512i)(B), (__m512i)(C), (int)(I)))
#define _mm512_ternarylogic_epi32 _mm512_ternarylogic_epi64
static inline __m512i _mm512_permutexvar_epi32(__m512i __I, __m512i __A) {
    return (__m512i)__builtin_ia32_permvarsi512(__A, __I);
}
#define _mm512_permutexvar_epi64(I, A)                                            \
    _mm512_permutexvar_epi32(_mm512_add_epi32(_mm512_slli_epi32(                 \
        _mm512_shuffle_epi32((__m512i)(I), 0xA0), 1), _mm512_set1_epi64(1LL << 32)), A)

/* AVX512-VNNI: each doubleword of the accumulator plus four byte or two
** word products. */
#define __BADC_512_DOT(name, row)                                                 \
    static inline __m512i _mm512_##name(__m512i __S, __m512i __A, __m512i __B) {  \
        return (__m512i)__builtin_ia32_##row(__S, __A, __B);                      \
    }
__BADC_512_DOT(dpbusd_epi32, vpdpbusd512)
__BADC_512_DOT(dpbusds_epi32, vpdpbusds512)
__BADC_512_DOT(dpwssd_epi32, vpdpwssd512)
__BADC_512_DOT(dpwssds_epi32, vpdpwssds512)
#undef __BADC_512_DOT

/* The compares into a mask by predicate (0 eq, 1 lt, 2 le, 4 ne, 5 nlt,
** 6 nle), signed and unsigned, and their named forms. */
#define _mm512_cmp_epi8_mask(A, B, P) ((__mmask64)__builtin_ia32_cmpb512_mask((__m512i)(A), (__m512i)(B), (int)(P)))
#define _mm512_cmp_epu8_mask(A, B, P) ((__mmask64)__builtin_ia32_ucmpb512_mask((__m512i)(A), (__m512i)(B), (int)(P)))
#define _mm512_cmp_epi16_mask(A, B, P) ((__mmask32)__builtin_ia32_cmpw512_mask((__m512i)(A), (__m512i)(B), (int)(P)))
#define _mm512_cmp_epu16_mask(A, B, P) ((__mmask32)__builtin_ia32_ucmpw512_mask((__m512i)(A), (__m512i)(B), (int)(P)))
#define _mm512_cmp_epi32_mask(A, B, P) ((__mmask16)__builtin_ia32_cmpd512_mask((__m512i)(A), (__m512i)(B), (int)(P)))
#define _mm512_cmp_epu32_mask(A, B, P) ((__mmask16)__builtin_ia32_ucmpd512_mask((__m512i)(A), (__m512i)(B), (int)(P)))
#define _mm512_cmp_epi64_mask(A, B, P) ((__mmask8)__builtin_ia32_cmpq512_mask((__m512i)(A), (__m512i)(B), (int)(P)))
#define _mm512_cmp_epu64_mask(A, B, P) ((__mmask8)__builtin_ia32_ucmpq512_mask((__m512i)(A), (__m512i)(B), (int)(P)))
#define __BADC_512_CMPS(t, mt)                                                    \
    static inline mt _mm512_cmpeq_##t##_mask(__m512i __A, __m512i __B) { return _mm512_cmp_##t##_mask(__A, __B, 0); } \
    static inline mt _mm512_cmplt_##t##_mask(__m512i __A, __m512i __B) { return _mm512_cmp_##t##_mask(__A, __B, 1); } \
    static inline mt _mm512_cmple_##t##_mask(__m512i __A, __m512i __B) { return _mm512_cmp_##t##_mask(__A, __B, 2); } \
    static inline mt _mm512_cmpneq_##t##_mask(__m512i __A, __m512i __B) { return _mm512_cmp_##t##_mask(__A, __B, 4); } \
    static inline mt _mm512_cmpge_##t##_mask(__m512i __A, __m512i __B) { return _mm512_cmp_##t##_mask(__A, __B, 5); } \
    static inline mt _mm512_cmpgt_##t##_mask(__m512i __A, __m512i __B) { return _mm512_cmp_##t##_mask(__A, __B, 6); }
__BADC_512_CMPS(epi8, __mmask64)
__BADC_512_CMPS(epu8, __mmask64)
__BADC_512_CMPS(epi16, __mmask32)
__BADC_512_CMPS(epu16, __mmask32)
__BADC_512_CMPS(epi32, __mmask16)
__BADC_512_CMPS(epu32, __mmask16)
__BADC_512_CMPS(epi64, __mmask8)
__BADC_512_CMPS(epu64, __mmask8)
#undef __BADC_512_CMPS
static inline __mmask64 _mm512_test_epi8_mask(__m512i __A, __m512i __B) {
    return _mm512_cmpneq_epi8_mask(_mm512_and_si512(__A, __B), _mm512_setzero_si512());
}
static inline __mmask64 _mm512_testn_epi8_mask(__m512i __A, __m512i __B) {
    return _mm512_cmpeq_epi8_mask(_mm512_and_si512(__A, __B), _mm512_setzero_si512());
}
static inline __mmask16 _mm512_test_epi32_mask(__m512i __A, __m512i __B) {
    return _mm512_cmpneq_epi32_mask(_mm512_and_si512(__A, __B), _mm512_setzero_si512());
}
static inline __mmask64 _mm512_movepi8_mask(__m512i __A) {
    return (__mmask64)__builtin_ia32_pmovmskb512(__A);
}

/* The blends and the masked forms of an operation: the lanes a mask selects
** from the operation, the others from the source or zero. */
#define __BADC_512_BLEND(t, mt, row)                                              \
    static inline __m512i _mm512_mask_mov_##t(__m512i __S, mt __K, __m512i __A) { \
        return (__m512i)__builtin_ia32_##row(__S, __K, __A);                      \
    }                                                                             \
    static inline __m512i _mm512_maskz_mov_##t(mt __K, __m512i __A) {             \
        return _mm512_mask_mov_##t(_mm512_setzero_si512(), __K, __A);             \
    }                                                                             \
    static inline __m512i _mm512_mask_blend_##t(mt __K, __m512i __A, __m512i __B) { \
        return _mm512_mask_mov_##t(__A, __K, __B);                                \
    }
__BADC_512_BLEND(epi8, __mmask64, blendmb_512)
__BADC_512_BLEND(epi16, __mmask32, blendmw_512)
__BADC_512_BLEND(epi32, __mmask16, blendmd_512)
__BADC_512_BLEND(epi64, __mmask8, blendmq_512)
#undef __BADC_512_BLEND
#define __BADC_512_MASKED(name, t, mt)                                            \
    static inline __m512i _mm512_mask_##name(__m512i __S, mt __K, __m512i __A, __m512i __B) { \
        return _mm512_mask_mov_##t(__S, __K, _mm512_##name(__A, __B));            \
    }                                                                             \
    static inline __m512i _mm512_maskz_##name(mt __K, __m512i __A, __m512i __B) { \
        return _mm512_maskz_mov_##t(__K, _mm512_##name(__A, __B));                \
    }
__BADC_512_MASKED(add_epi8, epi8, __mmask64)
__BADC_512_MASKED(add_epi16, epi16, __mmask32)
__BADC_512_MASKED(add_epi32, epi32, __mmask16)
__BADC_512_MASKED(add_epi64, epi64, __mmask8)
__BADC_512_MASKED(sub_epi8, epi8, __mmask64)
__BADC_512_MASKED(sub_epi16, epi16, __mmask32)
__BADC_512_MASKED(sub_epi32, epi32, __mmask16)
__BADC_512_MASKED(sub_epi64, epi64, __mmask8)
__BADC_512_MASKED(and_epi32, epi32, __mmask16)
__BADC_512_MASKED(or_epi32, epi32, __mmask16)
__BADC_512_MASKED(xor_epi32, epi32, __mmask16)
__BADC_512_MASKED(min_epu8, epi8, __mmask64)
__BADC_512_MASKED(max_epu8, epi8, __mmask64)
#undef __BADC_512_MASKED

/* The masked transfers (AVX512BW / AVX512F, AVX512VL at 256 and 128 bits):
** only the lanes a mask selects are read or written. */
#define __BADC_MASKED_IO(pre, vt, t, mt, sfx, bits)                               \
    static inline vt pre##_maskz_loadu_##t(mt __K, void const *__P) {             \
        return (vt)__builtin_ia32_loaddqu##sfx##bits##_mask(__K, (char const *)__P); \
    }                                                                             \
    static inline void pre##_mask_storeu_##t(void *__P, mt __K, vt __A) {         \
        __builtin_ia32_storedqu##sfx##bits##_mask((char *)__P, __K, __A);         \
    }
__BADC_MASKED_IO(_mm512, __m512i, epi8, __mmask64, qi, 512)
__BADC_MASKED_IO(_mm512, __m512i, epi16, __mmask32, hi, 512)
__BADC_MASKED_IO(_mm512, __m512i, epi32, __mmask16, si, 512)
__BADC_MASKED_IO(_mm512, __m512i, epi64, __mmask8, di, 512)
__BADC_MASKED_IO(_mm256, __m256i, epi8, __mmask32, qi, 256)
__BADC_MASKED_IO(_mm256, __m256i, epi16, __mmask16, hi, 256)
__BADC_MASKED_IO(_mm256, __m256i, epi32, __mmask8, si, 256)
__BADC_MASKED_IO(_mm256, __m256i, epi64, __mmask8, di, 256)
__BADC_MASKED_IO(_mm, __m128i, epi8, __mmask16, qi, 128)
__BADC_MASKED_IO(_mm, __m128i, epi16, __mmask8, hi, 128)
__BADC_MASKED_IO(_mm, __m128i, epi32, __mmask8, si, 128)
__BADC_MASKED_IO(_mm, __m128i, epi64, __mmask8, di, 128)
#undef __BADC_MASKED_IO
static inline __m512i _mm512_mask_loadu_epi8(__m512i __S, __mmask64 __K, void const *__P) {
    return _mm512_mask_mov_epi8(__S, __K, _mm512_maskz_loadu_epi8(__K, __P));
}
static inline __m512i _mm512_mask_loadu_epi32(__m512i __S, __mmask16 __K, void const *__P) {
    return _mm512_mask_mov_epi32(__S, __K, _mm512_maskz_loadu_epi32(__K, __P));
}

/* The reductions and AVX512CD's counts, element by element. */
static inline int _mm512_reduce_add_epi32(__m512i __A) {
    __v16su __a = (__v16su)__A;
    unsigned __s = 0;
    for (int __i = 0; __i < 16; __i++)
        __s += __a[__i];
    return (int)__s;
}
static inline long long _mm512_reduce_add_epi64(__m512i __A) {
    unsigned long long __s = 0;
    for (int __i = 0; __i < 8; __i++)
        __s += (unsigned long long)__A[__i];
    return (long long)__s;
}
static inline int _mm512_reduce_or_epi32(__m512i __A) {
    __v16si __a = (__v16si)__A;
    int __s = 0;
    for (int __i = 0; __i < 16; __i++)
        __s |= __a[__i];
    return __s;
}
static inline __m512i _mm512_lzcnt_epi32(__m512i __A) {
    __v16su __a = (__v16su)__A;
    for (int __i = 0; __i < 16; __i++)
        __a[__i] = __a[__i] ? (unsigned)__builtin_clz(__a[__i]) : 32;
    return (__m512i)__a;
}
static inline __m512i _mm512_lzcnt_epi64(__m512i __A) {
    __v8du __a = (__v8du)__A;
    for (int __i = 0; __i < 8; __i++)
        __a[__i] = __a[__i] ? (unsigned long long)__builtin_clzll(__a[__i]) : 64;
    return (__m512i)__a;
}

/* The opmask operations on integers. */
static inline __mmask64 _kand_mask64(__mmask64 __A, __mmask64 __B) { return __A & __B; }
static inline __mmask64 _kor_mask64(__mmask64 __A, __mmask64 __B) { return __A | __B; }
static inline __mmask64 _knot_mask64(__mmask64 __A) { return ~__A; }
static inline __mmask16 _mm512_kand(__mmask16 __A, __mmask16 __B) { return __A & __B; }
static inline __mmask16 _mm512_kor(__mmask16 __A, __mmask16 __B) { return __A | __B; }
static inline __mmask16 _mm512_knot(__mmask16 __A) { return (__mmask16)~__A; }
static inline unsigned long long _cvtmask64_u64(__mmask64 __A) { return __A; }
static inline __mmask64 _cvtu64_mask64(unsigned long long __A) { return __A; }
static inline unsigned int _cvtmask32_u32(__mmask32 __A) { return __A; }
static inline __mmask32 _cvtu32_mask32(unsigned int __A) { return __A; }
static inline int _mm512_kortestz(__mmask16 __A, __mmask16 __B) { return (__A | __B) == 0; }
static inline unsigned char _kortestz_mask64_u8(__mmask64 __A, __mmask64 __B) {
    return (__A | __B) == 0;
}

/* AVX512F floating point: the vector extension's operators, and the
** fused forms and roots element by element. */
static inline __m512 _mm512_setzero_ps(void) { return (__m512)_mm512_setzero_si512(); }
static inline __m512d _mm512_setzero_pd(void) { return (__m512d)_mm512_setzero_si512(); }
static inline __m512 _mm512_set1_ps(float __A) {
    return (__m512){__A, __A, __A, __A, __A, __A, __A, __A, __A, __A, __A, __A, __A, __A, __A, __A};
}
static inline __m512d _mm512_set1_pd(double __A) {
    return (__m512d){__A, __A, __A, __A, __A, __A, __A, __A};
}
static inline __m512 _mm512_loadu_ps(void const *__P) { return (__m512)_mm512_loadu_si512(__P); }
static inline __m512d _mm512_loadu_pd(void const *__P) { return (__m512d)_mm512_loadu_si512(__P); }
static inline void _mm512_storeu_ps(void *__P, __m512 __A) { _mm512_storeu_si512(__P, (__m512i)__A); }
static inline void _mm512_storeu_pd(void *__P, __m512d __A) { _mm512_storeu_si512(__P, (__m512i)__A); }
#define __BADC_512_FOP(name, op)                                                  \
    static inline __m512 _mm512_##name##_ps(__m512 __A, __m512 __B) { return __A op __B; } \
    static inline __m512d _mm512_##name##_pd(__m512d __A, __m512d __B) { return __A op __B; }
__BADC_512_FOP(add, +)
__BADC_512_FOP(sub, -)
__BADC_512_FOP(mul, *)
__BADC_512_FOP(div, /)
#undef __BADC_512_FOP
static inline __m512 _mm512_fmadd_ps(__m512 __A, __m512 __B, __m512 __C) {
    for (int __i = 0; __i < 16; __i++)
        __A[__i] = __builtin_fmaf(__A[__i], __B[__i], __C[__i]);
    return __A;
}
static inline __m512d _mm512_fmadd_pd(__m512d __A, __m512d __B, __m512d __C) {
    for (int __i = 0; __i < 8; __i++)
        __A[__i] = __builtin_fma(__A[__i], __B[__i], __C[__i]);
    return __A;
}
static inline float _mm512_reduce_add_ps(__m512 __A) {
    float __s = 0;
    for (int __i = 0; __i < 16; __i++)
        __s += __A[__i];
    return __s;
}
static inline double _mm512_reduce_add_pd(__m512d __A) {
    double __s = 0;
    for (int __i = 0; __i < 8; __i++)
        __s += __A[__i];
    return __s;
}
