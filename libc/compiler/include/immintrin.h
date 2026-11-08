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
