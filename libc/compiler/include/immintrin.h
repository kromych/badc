/* Umbrella over the x86 intrinsic family this build carries. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "immintrin.h is only available when targeting x86"
#endif

#include <smmintrin.h>
#include <wmmintrin.h>

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
