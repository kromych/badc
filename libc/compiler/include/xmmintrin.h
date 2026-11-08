/* SSE intrinsics. The arithmetic, comparisons and conversions lower to their
** SDM instructions; the transfers and lane moves are written over the
** vector extension, on the integer view of the lanes, so they keep every
** bit. As in gcc and clang, the MMX types come from <mmintrin.h> and, in a
** hosted unit, _mm_malloc and _mm_free from <mm_malloc.h>. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "xmmintrin.h is only available when targeting x86"
#endif

/* A unit may define `__attribute__` away, as code written for compilers
** without it does; the declarations below need it. */
#pragma push_macro("__attribute__")
#undef __attribute__

#include <mmintrin.h>
#if __STDC_HOSTED__
#include <mm_malloc.h>
#endif

typedef float __m128 __attribute__((__vector_size__(16)));
typedef float __v4sf __attribute__((__vector_size__(16)));
/* The unaligned form of the vector type an unaligned access dereferences. */
typedef float __m128_u __attribute__((__vector_size__(16), __may_alias__, __aligned__(1)));
typedef int __v4si __attribute__((__vector_size__(16)));

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

/* PREFETCHh hints. On the Windows targets they take MSVC's values, which
** <winnt.h> defines again; elsewhere gcc's, bit 2 selecting a prefetch for
** writing and bits 0-1 the locality. _mm_prefetch is a function of MSVC's
** signature, which <winnt.h> declares again. */
#ifdef _WIN32
#define _MM_HINT_NTA 0
#define _MM_HINT_T0 1
#define _MM_HINT_T1 2
#define _MM_HINT_T2 3
#define _MM_HINT_ENTA 4
#else
#define _MM_HINT_ET0 7
#define _MM_HINT_ET1 6
#define _MM_HINT_T0 3
#define _MM_HINT_T1 2
#define _MM_HINT_T2 1
#define _MM_HINT_NTA 0
#endif

static inline void _mm_prefetch(char const *__P, int __I) {
    switch (__I) {
    case _MM_HINT_T0: __builtin_prefetch(__P, 0, 3); break;
    case _MM_HINT_T1: __builtin_prefetch(__P, 0, 2); break;
    case _MM_HINT_T2: __builtin_prefetch(__P, 0, 1); break;
#ifdef _WIN32
    case _MM_HINT_ENTA: __builtin_prefetch(__P, 1, 0); break;
#else
    case _MM_HINT_ET0: __builtin_prefetch(__P, 1, 3); break;
    case _MM_HINT_ET1: __builtin_prefetch(__P, 1, 2); break;
#endif
    default: __builtin_prefetch(__P, 0, 0); break;
    }
}

static inline __m128 _mm_and_ps(__m128 __A, __m128 __B) {
    return (__m128)__builtin_ia32_andps((__v4sf)__A, (__v4sf)__B);
}

static inline __m128 _mm_andnot_ps(__m128 __A, __m128 __B) {
    return (__m128)__builtin_ia32_andnps((__v4sf)__A, (__v4sf)__B);
}

static inline __m128 _mm_or_ps(__m128 __A, __m128 __B) {
    return (__m128)__builtin_ia32_orps((__v4sf)__A, (__v4sf)__B);
}

static inline __m128 _mm_xor_ps(__m128 __A, __m128 __B) {
    return (__m128)__builtin_ia32_xorps((__v4sf)__A, (__v4sf)__B);
}

static inline __m128 _mm_setzero_ps(void) {
    return (__m128){0, 0, 0, 0};
}

static inline __m128 _mm_set_ps(float __D, float __C, float __B, float __A) {
    return (__m128){__A, __B, __C, __D};
}

static inline __m128 _mm_setr_ps(float __A, float __B, float __C, float __D) {
    return (__m128){__A, __B, __C, __D};
}

static inline __m128 _mm_set1_ps(float __A) {
    return (__m128){__A, __A, __A, __A};
}
#define _mm_set_ps1 _mm_set1_ps

static inline __m128 _mm_set_ss(float __A) {
    return (__m128){__A, 0, 0, 0};
}

static inline __m128 _mm_load_ps(float const *__P) {
    return *(__m128 const *)__P;
}

static inline __m128 _mm_loadu_ps(float const *__P) {
    return *(__m128_u const *)__P;
}

static inline __m128 _mm_load_ss(float const *__P) {
    return (__m128)(__v4si){*(int const *)__P, 0, 0, 0};
}

static inline __m128 _mm_load1_ps(float const *__P) {
    int __x = *(int const *)__P;
    return (__m128)(__v4si){__x, __x, __x, __x};
}
#define _mm_load_ps1 _mm_load1_ps

static inline __m128 _mm_loadr_ps(float const *__P) {
    __v4si __v = (__v4si)_mm_load_ps(__P);
    return (__m128)(__v4si){__v[3], __v[2], __v[1], __v[0]};
}

static inline void _mm_store_ps(float *__P, __m128 __A) {
    *(__m128 *)__P = __A;
}

static inline void _mm_storeu_ps(float *__P, __m128 __A) {
    *(__m128_u *)__P = __A;
}

static inline void _mm_store_ss(float *__P, __m128 __A) {
    *(int *)__P = ((__v4si)__A)[0];
}

static inline void _mm_store1_ps(float *__P, __m128 __A) {
    int __x = ((__v4si)__A)[0];
    _mm_store_ps(__P, (__m128)(__v4si){__x, __x, __x, __x});
}
#define _mm_store_ps1 _mm_store1_ps

static inline void _mm_storer_ps(float *__P, __m128 __A) {
    __v4si __v = (__v4si)__A;
    _mm_store_ps(__P, (__m128)(__v4si){__v[3], __v[2], __v[1], __v[0]});
}

static inline void _mm_stream_ps(float *__P, __m128 __A) {
    _mm_store_ps(__P, __A);
}

static inline float _mm_cvtss_f32(__m128 __A) {
    return __A[0];
}

static inline __m128 _mm_move_ss(__m128 __A, __m128 __B) {
    __v4si __a = (__v4si)__A;
    __a[0] = ((__v4si)__B)[0];
    return (__m128)__a;
}

static inline __m128 _mm_shuffle_ps(__m128 __A, __m128 __B, const int __M) {
    __v4si __a = (__v4si)__A, __b = (__v4si)__B;
    return (__m128)(__v4si){__a[__M & 3], __a[(__M >> 2) & 3], __b[(__M >> 4) & 3],
                            __b[(__M >> 6) & 3]};
}

static inline __m128 _mm_unpacklo_ps(__m128 __A, __m128 __B) {
    __v4si __a = (__v4si)__A, __b = (__v4si)__B;
    return (__m128)(__v4si){__a[0], __b[0], __a[1], __b[1]};
}

static inline __m128 _mm_unpackhi_ps(__m128 __A, __m128 __B) {
    __v4si __a = (__v4si)__A, __b = (__v4si)__B;
    return (__m128)(__v4si){__a[2], __b[2], __a[3], __b[3]};
}

static inline __m128 _mm_movehl_ps(__m128 __A, __m128 __B) {
    __v4si __a = (__v4si)__A, __b = (__v4si)__B;
    return (__m128)(__v4si){__b[2], __b[3], __a[2], __a[3]};
}

static inline __m128 _mm_movelh_ps(__m128 __A, __m128 __B) {
    __v4si __a = (__v4si)__A, __b = (__v4si)__B;
    return (__m128)(__v4si){__a[0], __a[1], __b[0], __b[1]};
}

static inline int _mm_movemask_ps(__m128 __A) {
    __v4si __a = (__v4si)__A;
    return (__a[0] < 0) | (__a[1] < 0) << 1 | (__a[2] < 0) << 2 | (__a[3] < 0) << 3;
}

static inline __m128 _mm_add_ps(__m128 __A, __m128 __B) {
    return __builtin_ia32_addps(__A, __B);
}

static inline __m128 _mm_sub_ps(__m128 __A, __m128 __B) {
    return __builtin_ia32_subps(__A, __B);
}

static inline __m128 _mm_mul_ps(__m128 __A, __m128 __B) {
    return __builtin_ia32_mulps(__A, __B);
}

static inline __m128 _mm_div_ps(__m128 __A, __m128 __B) {
    return __builtin_ia32_divps(__A, __B);
}

static inline __m128 _mm_min_ps(__m128 __A, __m128 __B) {
    return __builtin_ia32_minps(__A, __B);
}

static inline __m128 _mm_max_ps(__m128 __A, __m128 __B) {
    return __builtin_ia32_maxps(__A, __B);
}

static inline __m128 _mm_sqrt_ps(__m128 __A) {
    return __builtin_ia32_sqrtps(__A);
}

static inline __m128 _mm_add_ss(__m128 __A, __m128 __B) {
    return __builtin_ia32_addss(__A, __B);
}

static inline __m128 _mm_sub_ss(__m128 __A, __m128 __B) {
    return __builtin_ia32_subss(__A, __B);
}

static inline __m128 _mm_mul_ss(__m128 __A, __m128 __B) {
    return __builtin_ia32_mulss(__A, __B);
}

static inline __m128 _mm_div_ss(__m128 __A, __m128 __B) {
    return __builtin_ia32_divss(__A, __B);
}

static inline __m128 _mm_min_ss(__m128 __A, __m128 __B) {
    return __builtin_ia32_minss(__A, __B);
}

static inline __m128 _mm_max_ss(__m128 __A, __m128 __B) {
    return __builtin_ia32_maxss(__A, __B);
}

static inline __m128 _mm_sqrt_ss(__m128 __A) {
    return __builtin_ia32_sqrtss(__A);
}

/* RCPPS and RSQRTPS approximate within a relative 1.5 * 2^-12, which CPUs
** meet with different values; the exact quotient meets it on every one. */
static inline __m128 _mm_rcp_ps(__m128 __A) {
    return _mm_div_ps(_mm_set1_ps(1.0f), __A);
}

static inline __m128 _mm_rcp_ss(__m128 __A) {
    return _mm_move_ss(__A, _mm_div_ss(_mm_set_ss(1.0f), __A));
}

static inline __m128 _mm_rsqrt_ps(__m128 __A) {
    return _mm_div_ps(_mm_set1_ps(1.0f), _mm_sqrt_ps(__A));
}

static inline __m128 _mm_rsqrt_ss(__m128 __A) {
    return _mm_move_ss(__A, _mm_div_ss(_mm_set_ss(1.0f), _mm_sqrt_ss(__A)));
}

/* CMPPS / CMPSS by predicate; the greater-than forms swap the operands, a
** scalar one keeping the first operand's upper lanes. */
#define __BADC_CMP_PS(name, pred)                                    \
    static inline __m128 _mm_##name##_ps(__m128 __A, __m128 __B) {   \
        return __builtin_ia32_cmpps(__A, __B, pred);                \
    }                                                               \
    static inline __m128 _mm_##name##_ss(__m128 __A, __m128 __B) {   \
        return __builtin_ia32_cmpss(__A, __B, pred);                \
    }
#define __BADC_CMP_PS_SWAPPED(name, pred)                                    \
    static inline __m128 _mm_##name##_ps(__m128 __A, __m128 __B) {           \
        return __builtin_ia32_cmpps(__B, __A, pred);                        \
    }                                                                       \
    static inline __m128 _mm_##name##_ss(__m128 __A, __m128 __B) {           \
        return _mm_move_ss(__A, __builtin_ia32_cmpss(__B, __A, pred));      \
    }
__BADC_CMP_PS(cmpeq, 0)
__BADC_CMP_PS(cmplt, 1)
__BADC_CMP_PS(cmple, 2)
__BADC_CMP_PS(cmpunord, 3)
__BADC_CMP_PS(cmpneq, 4)
__BADC_CMP_PS(cmpnlt, 5)
__BADC_CMP_PS(cmpnle, 6)
__BADC_CMP_PS(cmpord, 7)
__BADC_CMP_PS_SWAPPED(cmpgt, 1)
__BADC_CMP_PS_SWAPPED(cmpge, 2)
__BADC_CMP_PS_SWAPPED(cmpngt, 5)
__BADC_CMP_PS_SWAPPED(cmpnge, 6)
#undef __BADC_CMP_PS
#undef __BADC_CMP_PS_SWAPPED

/* COMISS signals invalid for a quiet NaN and UCOMISS only for a signaling
** one, as C's relational and equality operators do; an unordered pair
** compares unequal. */
static inline int _mm_comieq_ss(__m128 __A, __m128 __B) {
    return __A[0] <= __B[0] && __A[0] >= __B[0];
}

static inline int _mm_comilt_ss(__m128 __A, __m128 __B) {
    return __A[0] < __B[0];
}

static inline int _mm_comile_ss(__m128 __A, __m128 __B) {
    return __A[0] <= __B[0];
}

static inline int _mm_comigt_ss(__m128 __A, __m128 __B) {
    return __A[0] > __B[0];
}

static inline int _mm_comige_ss(__m128 __A, __m128 __B) {
    return __A[0] >= __B[0];
}

static inline int _mm_comineq_ss(__m128 __A, __m128 __B) {
    return !(__A[0] <= __B[0] && __A[0] >= __B[0]);
}

static inline int _mm_ucomieq_ss(__m128 __A, __m128 __B) {
    return __A[0] == __B[0];
}

static inline int _mm_ucomilt_ss(__m128 __A, __m128 __B) {
    return __builtin_isless(__A[0], __B[0]);
}

static inline int _mm_ucomile_ss(__m128 __A, __m128 __B) {
    return __builtin_islessequal(__A[0], __B[0]);
}

static inline int _mm_ucomigt_ss(__m128 __A, __m128 __B) {
    return __builtin_isgreater(__A[0], __B[0]);
}

static inline int _mm_ucomige_ss(__m128 __A, __m128 __B) {
    return __builtin_isgreaterequal(__A[0], __B[0]);
}

static inline int _mm_ucomineq_ss(__m128 __A, __m128 __B) {
    return __A[0] != __B[0];
}

/* The SSE operations on __m64, written lane by lane over the vector
** extension as the SDM defines each instruction. A float converts to an
** integer through CVTPS2DQ, which rounds by MXCSR, or CVTTPS2DQ: 0x80000000
** for a NaN or a value out of range. The two-lane forms convert their two
** lanes twice over, raising what CVTPS2PI raises. */

static inline __m64 _mm_cvtps_pi32(__m128 __A) {
    __v4si __r = __builtin_ia32_cvtps2dq(_mm_movelh_ps(__A, __A));
    return (__m64)(__v2si){__r[0], __r[1]};
}

static inline __m64 _mm_cvttps_pi32(__m128 __A) {
    __v4si __r = __builtin_ia32_cvttps2dq(_mm_movelh_ps(__A, __A));
    return (__m64)(__v2si){__r[0], __r[1]};
}

static inline int _mm_cvtss_si32(__m128 __A) {
    return __builtin_ia32_cvtss2si(__A);
}
#define _mm_cvt_ss2si _mm_cvtss_si32

static inline int _mm_cvttss_si32(__m128 __A) {
    return __builtin_ia32_cvttss2si(__A);
}
#define _mm_cvtt_ss2si _mm_cvttss_si32

static inline __m128 _mm_cvtsi32_ss(__m128 __A, int __B) {
    __A[0] = (float)__B;
    return __A;
}
#define _mm_cvt_si2ss _mm_cvtsi32_ss

#ifdef __x86_64__
static inline long long _mm_cvtss_si64(__m128 __A) {
    return __builtin_ia32_cvtss2si64(__A);
}

static inline long long _mm_cvttss_si64(__m128 __A) {
    return __builtin_ia32_cvttss2si64(__A);
}

static inline __m128 _mm_cvtsi64_ss(__m128 __A, long long __B) {
    __A[0] = (float)__B;
    return __A;
}
#endif

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
    __v4si __c = __builtin_ia32_cvtps2dq(__A);
    __v4hi __r;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = (short)__mm_sat_signed(__c[__i], 16);
    return (__m64)__r;
}

static inline __m64 _mm_cvtps_pi8(__m128 __A) {
    __v4si __c = __builtin_ia32_cvtps2dq(__A);
    __v8qs __r = (__v8qs)0LL;
    for (int __i = 0; __i < 4; __i++)
        __r[__i] = (signed char)__mm_sat_signed(__c[__i], 8);
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

#pragma pop_macro("__attribute__")
