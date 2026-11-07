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
