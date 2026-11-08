/* Umbrella over the x86 intrinsic family this build carries. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "immintrin.h is only available when targeting x86"
#endif

#include <smmintrin.h>
#include <wmmintrin.h>

/* The 256-bit integer operations of AVX and AVX2 this build carries,
** written lane by lane over the vector extension as the SDM defines each
** instruction; no VEX instruction is emitted, so a unit may call them
** behind a CPUID check as with cl, which needs no /arch option for them. */
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
#pragma pop_macro("__attribute__")

static inline __m256i _mm256_loadu_si256(__m256i_u const *__P) {
    __m256i __r;
    __builtin_memcpy(&__r, __P, sizeof __r);
    return __r;
}

static inline __m256i _mm256_load_si256(__m256i const *__P) {
    return _mm256_loadu_si256((__m256i_u const *)__P);
}

static inline void _mm256_storeu_si256(__m256i_u *__P, __m256i __A) {
    __builtin_memcpy(__P, &__A, sizeof __A);
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
    return ~__A & __B;
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

/* VPCMPEQB/W/D/Q: all ones in a lane where the operands are equal, as a
** vector comparison gives. */
static inline __m256i _mm256_cmpeq_epi8(__m256i __A, __m256i __B) {
    return (__m256i)((__v32qs)__A == (__v32qs)__B);
}

static inline __m256i _mm256_cmpeq_epi16(__m256i __A, __m256i __B) {
    return (__m256i)((__v16hi)__A == (__v16hi)__B);
}

static inline __m256i _mm256_cmpeq_epi32(__m256i __A, __m256i __B) {
    return (__m256i)((__v8si)__A == (__v8si)__B);
}

static inline __m256i _mm256_cmpeq_epi64(__m256i __A, __m256i __B) {
    return (__m256i)(__A == __B);
}

/* VPMOVMSKB: the sign bit of each byte, byte 0 in bit 0. */
static inline int _mm256_movemask_epi8(__m256i __A) {
    __v32qi __a = (__v32qi)__A;
    unsigned __r = 0;
    for (int __i = 0; __i < 32; __i++)
        __r |= (unsigned)((signed char)__a[__i] < 0) << __i;
    return (int)__r;
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
    return (__m256i)((__v8si)__A > (__v8si)__B);
}

static inline __m256i _mm256_cmpgt_epi64(__m256i __A, __m256i __B) {
    return (__m256i)(__A > __B);
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
    __v4du __a = (__v4du)__A, __b = (__v4du)__B;
    return (__m256i)((__a & 0xFFFFFFFFu) * (__b & 0xFFFFFFFFu));
}

/* VPMADDWD: adjacent signed word products summed into a doubleword, which
** wraps when both pairs are -32768 * -32768. */
static inline __m256i _mm256_madd_epi16(__m256i __A, __m256i __B) {
    __v16hi __a = (__v16hi)__A, __b = (__v16hi)__B;
    __v8si __r;
    for (int __i = 0; __i < 8; __i++)
        __r[__i] = (int)((unsigned)(__a[2 * __i] * __b[2 * __i]) +
                         (unsigned)(__a[2 * __i + 1] * __b[2 * __i + 1]));
    return (__m256i)__r;
}

/* VPMADDUBSW: unsigned bytes of the first operand times signed bytes of
** the second, adjacent products summed with signed saturation. */
static inline __m256i _mm256_maddubs_epi16(__m256i __A, __m256i __B) {
    __v32qu __a = (__v32qu)__A;
    __v32qs __b = (__v32qs)__B;
    __v16hi __r;
    for (int __i = 0; __i < 16; __i++) {
        int __s = __a[2 * __i] * __b[2 * __i] + __a[2 * __i + 1] * __b[2 * __i + 1];
        __r[__i] = (short)(__s > 32767 ? 32767 : __s < -32768 ? -32768 : __s);
    }
    return (__m256i)__r;
}

/* VPSADBW: per quadword, the sum of the absolute byte differences. */
static inline __m256i _mm256_sad_epu8(__m256i __A, __m256i __B) {
    __v32qu __a = (__v32qu)__A, __b = (__v32qu)__B;
    __m256i __r;
    for (int __q = 0; __q < 4; __q++) {
        long long __s = 0;
        for (int __i = 8 * __q; __i < 8 * __q + 8; __i++)
            __s += __a[__i] > __b[__i] ? __a[__i] - __b[__i] : __b[__i] - __a[__i];
        __r[__q] = __s;
    }
    return __r;
}

static inline __m256i _mm256_subs_epu16(__m256i __A, __m256i __B) {
    __v16hu __a = (__v16hu)__A, __b = (__v16hu)__B, __r;
    for (int __i = 0; __i < 16; __i++)
        __r[__i] = __a[__i] > __b[__i] ? __a[__i] - __b[__i] : 0;
    return (__m256i)__r;
}

/* The shifts by a count: one past the lane width clears the lane. */
static inline __m256i _mm256_slli_epi32(__m256i __A, int __N) {
    return (unsigned)__N > 31 ? (__m256i){0, 0, 0, 0} : (__m256i)((__v8su)__A << __N);
}

static inline __m256i _mm256_srli_epi32(__m256i __A, int __N) {
    return (unsigned)__N > 31 ? (__m256i){0, 0, 0, 0} : (__m256i)((__v8su)__A >> __N);
}

static inline __m256i _mm256_slli_epi64(__m256i __A, int __N) {
    return (unsigned)__N > 63 ? (__m256i){0, 0, 0, 0} : (__m256i)((__v4du)__A << __N);
}

static inline __m256i _mm256_srli_epi64(__m256i __A, int __N) {
    return (unsigned)__N > 63 ? (__m256i){0, 0, 0, 0} : (__m256i)((__v4du)__A >> __N);
}

/* VPSLLDQ / VPSRLDQ: a byte shift within each 128-bit lane. */
static inline __m256i _mm256_slli_si256(__m256i __A, const int __N) {
    __v32qu __a = (__v32qu)__A, __r;
    unsigned __n = (unsigned)__N & 0xFF;
    for (int __i = 0; __i < 32; __i++)
        __r[__i] = (unsigned)(__i & 15) >= __n ? __a[__i - __n] : 0;
    return (__m256i)__r;
}

static inline __m256i _mm256_srli_si256(__m256i __A, const int __N) {
    __v32qu __a = (__v32qu)__A, __r;
    unsigned __n = (unsigned)__N & 0xFF;
    for (int __i = 0; __i < 32; __i++)
        __r[__i] = (__i & 15) + __n < 16 ? __a[__i + __n] : 0;
    return (__m256i)__r;
}

/* VPSHUFB: each byte selects a byte of its own 128-bit lane, or zero when
** its top bit is set. */
static inline __m256i _mm256_shuffle_epi8(__m256i __A, __m256i __B) {
    __v32qu __a = (__v32qu)__A, __b = (__v32qu)__B, __r;
    for (int __i = 0; __i < 32; __i++)
        __r[__i] = __b[__i] & 0x80 ? 0 : __a[(__i & 16) | (__b[__i] & 15)];
    return (__m256i)__r;
}

static inline __m256i _mm256_permutevar8x32_epi32(__m256i __A, __m256i __I) {
    __v8si __a = (__v8si)__A, __i = (__v8si)__I, __r;
    for (int __k = 0; __k < 8; __k++)
        __r[__k] = __a[__i[__k] & 7];
    return (__m256i)__r;
}

static inline __m256i _mm256_permute4x64_epi64(__m256i __A, const int __M) {
    return (__m256i){__A[__M & 3], __A[(__M >> 2) & 3], __A[(__M >> 4) & 3],
                     __A[(__M >> 6) & 3]};
}

/* VPERM2I128: each half of the result is a half of either operand, or
** zero, as its nibble of the control selects. */
static inline __m256i _mm256_permute2x128_si256(__m256i __A, __m256i __B, const int __M) {
    __m256i __r;
    for (int __h = 0; __h < 2; __h++) {
        int __c = __M >> (4 * __h);
        __m256i __s = __c & 2 ? __B : __A;
        __r[2 * __h] = __c & 8 ? 0 : __s[2 * (__c & 1)];
        __r[2 * __h + 1] = __c & 8 ? 0 : __s[2 * (__c & 1) + 1];
    }
    return __r;
}

/* The unpacks interleave within each 128-bit lane. */
static inline __m256i _mm256_unpacklo_epi32(__m256i __A, __m256i __B) {
    __v8si __a = (__v8si)__A, __b = (__v8si)__B;
    return (__m256i)(__v8si){__a[0], __b[0], __a[1], __b[1], __a[4], __b[4], __a[5], __b[5]};
}

static inline __m256i _mm256_unpackhi_epi32(__m256i __A, __m256i __B) {
    __v8si __a = (__v8si)__A, __b = (__v8si)__B;
    return (__m256i)(__v8si){__a[2], __b[2], __a[3], __b[3], __a[6], __b[6], __a[7], __b[7]};
}

static inline __m256i _mm256_unpacklo_epi64(__m256i __A, __m256i __B) {
    return (__m256i){__A[0], __B[0], __A[2], __B[2]};
}

static inline __m256i _mm256_unpackhi_epi64(__m256i __A, __m256i __B) {
    return (__m256i){__A[1], __B[1], __A[3], __B[3]};
}

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

static inline __m256 _mm256_permute2f128_ps(__m256 __A, __m256 __B, const int __M) {
    return (__m256)_mm256_permute2x128_si256((__m256i)__A, (__m256i)__B, __M);
}

static inline __m256d _mm256_permute2f128_pd(__m256d __A, __m256d __B, const int __M) {
    return (__m256d)_mm256_permute2x128_si256((__m256i)__A, (__m256i)__B, __M);
}

static inline __m256i _mm256_permute2f128_si256(__m256i __A, __m256i __B, const int __M) {
    return _mm256_permute2x128_si256(__A, __B, __M);
}

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

static inline __m128 _mm_blend_ps(__m128 __A, __m128 __B, const int __M) {
    return _mm256_castps256_ps128(_mm256_blend_ps(_mm256_castps128_ps256(__A),
                                                  _mm256_castps128_ps256(__B), __M & 15));
}

static inline __m128d _mm_blend_pd(__m128d __A, __m128d __B, const int __M) {
    return _mm256_castpd256_pd128(_mm256_blend_pd(_mm256_castpd128_pd256(__A),
                                                  _mm256_castpd128_pd256(__B), __M & 3));
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

static inline __m128 _mm_blendv_ps(__m128 __A, __m128 __B, __m128 __M) {
    return _mm256_castps256_ps128(_mm256_blendv_ps(
        _mm256_castps128_ps256(__A), _mm256_castps128_ps256(__B), _mm256_castps128_ps256(__M)));
}

static inline __m128d _mm_blendv_pd(__m128d __A, __m128d __B, __m128d __M) {
    return _mm256_castpd256_pd128(_mm256_blendv_pd(
        _mm256_castpd128_pd256(__A), _mm256_castpd128_pd256(__B), _mm256_castpd128_pd256(__M)));
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
