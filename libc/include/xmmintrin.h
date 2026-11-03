/* SSE intrinsics. This build carries the vector types, the shuffle selector,
** the MXCSR access and the operations on __m64; the SSE1 packed-single
** operations are not provided. As in gcc and clang, the MMX types come from
** <mmintrin.h> and, in a hosted unit, _mm_malloc and _mm_free from
** <mm_malloc.h>. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "xmmintrin.h is only available when targeting x86"
#endif

#include <mmintrin.h>
#if __STDC_HOSTED__
#include <mm_malloc.h>
#endif

typedef float __m128 __attribute__((__vector_size__(16)));
typedef float __v4sf __attribute__((__vector_size__(16)));
/* The unaligned form of the vector type an unaligned access dereferences. */
typedef float __m128_u __attribute__((__vector_size__(16), __may_alias__, __aligned__(1)));

#define _MM_SHUFFLE(w, x, y, z) (((w) << 6) | ((x) << 4) | ((y) << 2) | (z))

static inline void _mm_pause(void) {
    __asm__ __volatile__("pause");
}

static inline void _mm_sfence(void) {
    __builtin_ia32_sfence();
}

static inline unsigned int _mm_getcsr(void) {
    unsigned int __csr;
    __asm__ __volatile__("stmxcsr %0" : "=m"(__csr));
    return __csr;
}

static inline void _mm_setcsr(unsigned int __csr) {
    __asm__ __volatile__("ldmxcsr %0" : : "m"(__csr));
}

/* The SSE operations on __m64, written lane by lane over the vector
** extension as the SDM defines each instruction. A float converts to an
** integer through CVTSS2SI, which rounds by MXCSR, or CVTTSS2SI; both give
** 0x80000000 for a NaN or a value out of range. */

static inline int __mm_cvtss2si(float __f) {
    int __r;
    __asm__("cvtss2si %1, %0" : "=r"(__r) : "x"(__f));
    return __r;
}

static inline int __mm_cvttss2si(float __f) {
    int __r;
    __asm__("cvttss2si %1, %0" : "=r"(__r) : "x"(__f));
    return __r;
}

static inline __m64 _mm_cvtps_pi32(__m128 __A) {
    return (__m64)(__v2si){__mm_cvtss2si(__A[0]), __mm_cvtss2si(__A[1])};
}

static inline __m64 _mm_cvttps_pi32(__m128 __A) {
    return (__m64)(__v2si){__mm_cvttss2si(__A[0]), __mm_cvttss2si(__A[1])};
}

static inline __m128 _mm_cvtpi32_ps(__m128 __A, __m64 __B) {
    __v2si __b = (__v2si)__B;
    return (__m128){(float)__b[0], (float)__b[1], __A[2], __A[3]};
}

static inline __m128 _mm_cvtpi16_ps(__m64 __A) {
    __v4hi __a = (__v4hi)__A;
    return (__m128){__a[0], __a[1], __a[2], __a[3]};
}

static inline __m128 _mm_cvtpu16_ps(__m64 __A) {
    __v4hu __a = (__v4hu)__A;
    return (__m128){__a[0], __a[1], __a[2], __a[3]};
}

static inline __m128 _mm_cvtpi8_ps(__m64 __A) {
    __v8qs __a = (__v8qs)__A;
    return (__m128){__a[0], __a[1], __a[2], __a[3]};
}

static inline __m128 _mm_cvtpu8_ps(__m64 __A) {
    __v8qu __a = (__v8qu)__A;
    return (__m128){__a[0], __a[1], __a[2], __a[3]};
}

static inline __m128 _mm_cvtpi32x2_ps(__m64 __A, __m64 __B) {
    __v2si __a = (__v2si)__A, __b = (__v2si)__B;
    return (__m128){(float)__a[0], (float)__a[1], (float)__b[0], (float)__b[1]};
}

/* CVTPS2PI on each half, then PACKSSDW, and for the bytes PACKSSWB with
** zero: the lanes saturate. */
static inline __m64 _mm_cvtps_pi16(__m128 __A) {
    __v4hi __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = (short)__mm_sat_signed(__mm_cvtss2si(__A[__i]), 16);
    return (__m64)__r;
}

static inline __m64 _mm_cvtps_pi8(__m128 __A) {
    __v8qs __r = (__v8qs)0LL;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = (signed char)__mm_sat_signed(__mm_cvtss2si(__A[__i]), 8);
    return (__m64)__r;
}

static inline __m128 _mm_loadh_pi(__m128 __A, __m64 const *__P) {
    __v2sf __p = (__v2sf)(*(__m64_u const *)__P);
    return (__m128){__A[0], __A[1], __p[0], __p[1]};
}

static inline __m128 _mm_loadl_pi(__m128 __A, __m64 const *__P) {
    __v2sf __p = (__v2sf)(*(__m64_u const *)__P);
    return (__m128){__p[0], __p[1], __A[2], __A[3]};
}

static inline void _mm_storeh_pi(__m64 *__P, __m128 __A) {
    *(__m64_u *)__P = (__m64)(__v2sf){__A[2], __A[3]};
}

static inline void _mm_storel_pi(__m64 *__P, __m128 __A) {
    *(__m64_u *)__P = (__m64)(__v2sf){__A[0], __A[1]};
}

/* PEXTRW zero-extends the word; PEXTRW, PINSRW and PSHUFW take their
** selector modulo the lane count. */
static inline int _mm_extract_pi16(__m64 __A, int __N) {
    return (unsigned short)((__v4hi)__A)[__N & 3];
}

static inline __m64 _mm_insert_pi16(__m64 __A, int __D, int __N) {
    __v4hi __a = (__v4hi)__A;
    __a[__N & 3] = (short)__D;
    return (__m64)__a;
}

static inline __m64 _mm_shuffle_pi16(__m64 __A, int __N) {
    __v4hi __a = (__v4hi)__A, __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = __a[(__N >> (2 * __i)) & 3];
    return (__m64)__r;
}

static inline __m64 _mm_max_pi16(__m64 __A, __m64 __B) {
    __v4hi __a = (__v4hi)__A, __b = (__v4hi)__B, __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = __a[__i] > __b[__i] ? __a[__i] : __b[__i];
    return (__m64)__r;
}

static inline __m64 _mm_max_pu8(__m64 __A, __m64 __B) {
    __v8qu __a = (__v8qu)__A, __b = (__v8qu)__B, __r;
    for (int __i = 0; __i < 8; __i++)
        __r[__i] = __a[__i] > __b[__i] ? __a[__i] : __b[__i];
    return (__m64)__r;
}

static inline __m64 _mm_min_pi16(__m64 __A, __m64 __B) {
    __v4hi __a = (__v4hi)__A, __b = (__v4hi)__B, __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = __a[__i] < __b[__i] ? __a[__i] : __b[__i];
    return (__m64)__r;
}

static inline __m64 _mm_min_pu8(__m64 __A, __m64 __B) {
    __v8qu __a = (__v8qu)__A, __b = (__v8qu)__B, __r;
    for (int __i = 0; __i < 8; __i++)
        __r[__i] = __a[__i] < __b[__i] ? __a[__i] : __b[__i];
    return (__m64)__r;
}

static inline int _mm_movemask_pi8(__m64 __A) {
    __v8qu __a = (__v8qu)__A;
    int __r = 0;
    for (int __i = 0; __i < 8; __i++)
        __r |= (__a[__i] >> 7) << __i;
    return __r;
}

static inline __m64 _mm_mulhi_pu16(__m64 __A, __m64 __B) {
    __v4hu __a = (__v4hu)__A, __b = (__v4hu)__B, __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = (unsigned short)(((unsigned)__a[__i] * __b[__i]) >> 16);
    return (__m64)__r;
}

/* MASKMOVQ writes the bytes whose selector byte has its top bit set and
** no others. */
static inline void _mm_maskmove_si64(__m64 __A, __m64 __N, char *__P) {
    __v8qi __a = (__v8qi)__A;
    __v8qu __n = (__v8qu)__N;
    for (int __i = 0; __i < 8; __i++)
        if (__n[__i] & 0x80)
            __P[__i] = __a[__i];
}

static inline __m64 _mm_avg_pu8(__m64 __A, __m64 __B) {
    __v8qu __a = (__v8qu)__A, __b = (__v8qu)__B, __r;
    for (int __i = 0; __i < 8; __i++)
        __r[__i] = (unsigned char)((__a[__i] + __b[__i] + 1) >> 1);
    return (__m64)__r;
}

static inline __m64 _mm_avg_pu16(__m64 __A, __m64 __B) {
    __v4hu __a = (__v4hu)__A, __b = (__v4hu)__B, __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = (unsigned short)(((unsigned)__a[__i] + __b[__i] + 1) >> 1);
    return (__m64)__r;
}

/* PSADBW: the sum of the absolute byte differences in the low word, the
** other words zero. */
static inline __m64 _mm_sad_pu8(__m64 __A, __m64 __B) {
    __v8qu __a = (__v8qu)__A, __b = (__v8qu)__B;
    unsigned long long __s = 0;
    for (int __i = 0; __i < 8; __i++)
        __s += __a[__i] > __b[__i] ? __a[__i] - __b[__i] : __b[__i] - __a[__i];
    return (__m64)__s;
}

/* The non-temporal store, through a general register as on x86-64. */
static inline void _mm_stream_pi(__m64 *__P, __m64 __A) {
    __asm__("movnti %1, %0" : "=m"(*(long long *)__P) : "r"((long long)__A));
}

#define _mm_cvt_ps2pi _mm_cvtps_pi32
#define _mm_cvtt_ps2pi _mm_cvttps_pi32
#define _mm_cvt_pi2ps _mm_cvtpi32_ps
#define _m_pextrw _mm_extract_pi16
#define _m_pinsrw _mm_insert_pi16
#define _m_pshufw _mm_shuffle_pi16
#define _m_pmaxsw _mm_max_pi16
#define _m_pmaxub _mm_max_pu8
#define _m_pminsw _mm_min_pi16
#define _m_pminub _mm_min_pu8
#define _m_pmovmskb _mm_movemask_pi8
#define _m_pmulhuw _mm_mulhi_pu16
#define _m_maskmovq _mm_maskmove_si64
#define _m_pavgb _mm_avg_pu8
#define _m_pavgw _mm_avg_pu16
#define _m_psadbw _mm_sad_pu8
