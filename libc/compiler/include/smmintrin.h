/* SSE4.1 intrinsics, and SSE4.2's as gcc's <smmintrin.h> carries them.
** The integer minimums and maximums, PMULLD, PMULDQ, PACKUSDW, the sign
** and zero extensions, the immediate blends, the element accesses and
** PCMPGTQ lower to their instructions; CRC32 is inline asm. The rest are
** written lane by lane over the vector extension as the SDM defines each
** instruction: the variable blends, whose instructions read xmm0; PTEST
** and the string compares, whose results are flags; ROUNDPS and its kin,
** DPPS, DPPD, INSERTPS, EXTRACTPS, PHMINPOSUW and MPSADBW. */
#pragma once
#ifndef __BADC_INTRIN
/* An intrinsic is inlined at every optimization level, as a call to it would
 * pass and copy its vectors around one instruction. */
#define __BADC_INTRIN static __inline__ __attribute__((__always_inline__))
#endif

#if !defined(__x86_64__) && !defined(__i386__)
#error "smmintrin.h is only available when targeting x86"
#endif

#include <tmmintrin.h>

#define _MM_FROUND_TO_NEAREST_INT 0x00
#define _MM_FROUND_TO_NEG_INF 0x01
#define _MM_FROUND_TO_POS_INF 0x02
#define _MM_FROUND_TO_ZERO 0x03
#define _MM_FROUND_CUR_DIRECTION 0x04
#define _MM_FROUND_RAISE_EXC 0x00
#define _MM_FROUND_NO_EXC 0x08
#define _MM_FROUND_NINT (_MM_FROUND_TO_NEAREST_INT | _MM_FROUND_RAISE_EXC)
#define _MM_FROUND_FLOOR (_MM_FROUND_TO_NEG_INF | _MM_FROUND_RAISE_EXC)
#define _MM_FROUND_CEIL (_MM_FROUND_TO_POS_INF | _MM_FROUND_RAISE_EXC)
#define _MM_FROUND_TRUNC (_MM_FROUND_TO_ZERO | _MM_FROUND_RAISE_EXC)
#define _MM_FROUND_RINT (_MM_FROUND_CUR_DIRECTION | _MM_FROUND_RAISE_EXC)
#define _MM_FROUND_NEARBYINT (_MM_FROUND_CUR_DIRECTION | _MM_FROUND_NO_EXC)

__BADC_INTRIN __m128i _mm_cmpeq_epi64(__m128i __X, __m128i __Y) {
    return (__m128i)__builtin_ia32_pcmpeqq((__v2di)__X, (__v2di)__Y);
}

#define _mm_extract_epi32(X, N) \
    ((int)__builtin_ia32_vec_ext_v4si((__v4si)(__m128i)(X), (int)(N)))
#define _mm_insert_epi32(X, I, N) \
    ((__m128i)__builtin_ia32_vec_set_v4si((__v4si)(__m128i)(X), (int)(I), (int)(N)))
/* PEXTRB zero-extends its byte. */
#define _mm_extract_epi8(X, N) \
    ((int)__builtin_ia32_vec_ext_v16qi((__v16qi)(__m128i)(X), (int)(N)))
#define _mm_insert_epi8(X, I, N) \
    ((__m128i)__builtin_ia32_vec_set_v16qi((__v16qi)(__m128i)(X), (int)(I), (int)(N)))
#ifdef __x86_64__
#define _mm_extract_epi64(X, N) \
    ((long long)__builtin_ia32_vec_ext_v2di((__v2di)(__m128i)(X), (int)(N)))
#define _mm_insert_epi64(X, I, N) \
    ((__m128i)__builtin_ia32_vec_set_v2di((__v2di)(__m128i)(X), (long long)(I), (int)(N)))
#endif

/* EXTRACTPS: the lane's bits as an int. */
#define _mm_extract_ps(X, N) (((__v4si)(__m128)(X))[(N) & 3])

/* INSERTPS: lane imm8[7:6] of the second operand into lane imm8[5:4] of
** the first, then the lanes imm8[3:0] names zeroed. */
static inline __m128 _mm_insert_ps(__m128 __X, __m128 __Y, const int __N) {
    __v4si __x = (__v4si)__X, __y = (__v4si)__Y;
    __x[(__N >> 4) & 3] = __y[(__N >> 6) & 3];
    for (int __i = 0; __i < 4; __i++)
        if (__N >> __i & 1)
            __x[__i] = 0;
    return (__m128)__x;
}

#define __BADC_BINARY(name, builtin, cast)                                      \
    __BADC_INTRIN __m128i _mm_##name(__m128i __X, __m128i __Y) {               \
        return (__m128i)__builtin_ia32_##builtin((cast)__X, (cast)__Y);       \
    }
__BADC_BINARY(min_epi8, pminsb128, __v16qi)
__BADC_BINARY(max_epi8, pmaxsb128, __v16qi)
__BADC_BINARY(min_epu16, pminuw128, __v8hi)
__BADC_BINARY(max_epu16, pmaxuw128, __v8hi)
__BADC_BINARY(min_epi32, pminsd128, __v4si)
__BADC_BINARY(max_epi32, pmaxsd128, __v4si)
__BADC_BINARY(min_epu32, pminud128, __v4si)
__BADC_BINARY(max_epu32, pmaxud128, __v4si)
__BADC_BINARY(mullo_epi32, pmulld128, __v4si)
__BADC_BINARY(packus_epi32, packusdw128, __v4si)
__BADC_BINARY(mul_epi32, pmuldq128, __v4si)
__BADC_BINARY(cmpgt_epi64, pcmpgtq, __v2di)
#undef __BADC_BINARY

/* PMOVSX / PMOVZX: the low lanes of the operand, sign- or zero-extended. */
#define __BADC_EXTEND(name, builtin, cast)                                      \
    __BADC_INTRIN __m128i _mm_##name(__m128i __X) {                            \
        return (__m128i)__builtin_ia32_##builtin((cast)__X);                  \
    }
__BADC_EXTEND(cvtepi8_epi16, pmovsxbw128, __v16qi)
__BADC_EXTEND(cvtepi8_epi32, pmovsxbd128, __v16qi)
__BADC_EXTEND(cvtepi8_epi64, pmovsxbq128, __v16qi)
__BADC_EXTEND(cvtepi16_epi32, pmovsxwd128, __v8hi)
__BADC_EXTEND(cvtepi16_epi64, pmovsxwq128, __v8hi)
__BADC_EXTEND(cvtepi32_epi64, pmovsxdq128, __v4si)
__BADC_EXTEND(cvtepu8_epi16, pmovzxbw128, __v16qi)
__BADC_EXTEND(cvtepu8_epi32, pmovzxbd128, __v16qi)
__BADC_EXTEND(cvtepu8_epi64, pmovzxbq128, __v16qi)
__BADC_EXTEND(cvtepu16_epi32, pmovzxwd128, __v8hi)
__BADC_EXTEND(cvtepu16_epi64, pmovzxwq128, __v8hi)
__BADC_EXTEND(cvtepu32_epi64, pmovzxdq128, __v4si)
#undef __BADC_EXTEND

/* The immediate blends take lane i of the second operand where imm8 bit i
** is set. */
#define _mm_blend_epi16(X, Y, M) \
    ((__m128i)__builtin_ia32_pblendw128((__v8hi)(__m128i)(X), (__v8hi)(__m128i)(Y), (int)(M)))
#define _mm_blend_ps(X, Y, M) \
    ((__m128)__builtin_ia32_blendps((__v4sf)(__m128)(X), (__v4sf)(__m128)(Y), (int)(M)))
#define _mm_blend_pd(X, Y, M) \
    ((__m128d)__builtin_ia32_blendpd((__v2df)(__m128d)(X), (__v2df)(__m128d)(Y), (int)(M)))

/* PBLENDVB, BLENDVPS, BLENDVPD: lane of the second operand where the mask
** lane's sign bit is set. */
static inline __m128i _mm_blendv_epi8(__m128i __X, __m128i __Y, __m128i __M) {
    __v16qi __x = (__v16qi)__X, __y = (__v16qi)__Y, __m = (__v16qi)__M;
    for (int __i = 0; __i < 16; __i++)
        if (__m[__i] & 0x80)
            __x[__i] = __y[__i];
    return (__m128i)__x;
}

static inline __m128 _mm_blendv_ps(__m128 __X, __m128 __Y, __m128 __M) {
    __v4si __x = (__v4si)__X, __y = (__v4si)__Y, __m = (__v4si)__M;
    for (int __i = 0; __i < 4; __i++)
        if (__m[__i] < 0)
            __x[__i] = __y[__i];
    return (__m128)__x;
}

static inline __m128d _mm_blendv_pd(__m128d __X, __m128d __Y, __m128d __M) {
    __v2di __x = (__v2di)__X, __y = (__v2di)__Y, __m = (__v2di)__M;
    for (int __i = 0; __i < 2; __i++)
        if (__m[__i] < 0)
            __x[__i] = __y[__i];
    return (__m128d)__x;
}

/* PTEST: ZF when the AND of the operands is zero, CF when the AND of the
** first's complement with the second is. */
static inline int _mm_testz_si128(__m128i __M, __m128i __V) {
    __v2di __r = (__v2di)__M & (__v2di)__V;
    return (__r[0] | __r[1]) == 0;
}

static inline int _mm_testc_si128(__m128i __M, __m128i __V) {
    __v2di __r = ~(__v2di)__M & (__v2di)__V;
    return (__r[0] | __r[1]) == 0;
}

__BADC_INTRIN int _mm_testnzc_si128(__m128i __M, __m128i __V) {
    return !_mm_testz_si128(__M, __V) && !_mm_testc_si128(__M, __V);
}

#define _mm_test_all_zeros(M, V) _mm_testz_si128((M), (V))
#define _mm_test_all_ones(V) _mm_testc_si128((V), _mm_cmpeq_epi32((V), (V)))
#define _mm_test_mix_ones_zeros(M, V) _mm_testnzc_si128((M), (V))

/* MOVNTDQA: an ordinary load. */
__BADC_INTRIN __m128i _mm_stream_load_si128(void const *__P) {
    return _mm_loadu_si128((__m128i const *)__P);
}

/* ROUNDPS and its kin on one lane's bits, of `__mant` fraction bits and
** exponent bias `__bias`: the integral value in the direction imm8[1:0]
** names, or MXCSR.RC's when imm8[2] is set, keeping the sign of a zero; the
** precision exception for an inexact result unless imm8[3] is set. A NaN
** lane is quieted by the caller. */
static inline unsigned long long __badc_round(unsigned long long __x, int __mant, int __bias,
                                              int __m) {
    unsigned long long __sign = 1ULL << (__mant + (__bias == 127 ? 8 : 11));
    unsigned long long __mag = __x & ~__sign, __one, __r;
    int __e = (int)(__mag >> __mant) - __bias, __neg = (__x & __sign) != 0, __up;
    int __mode = __m & 4 ? (int)(_mm_getcsr() >> 13) & 3 : __m & 3;
    if (__e >= __mant)
        return __x;
    if (__e < 0) {
        if (__mag == 0)
            return __x;
        __one = (unsigned long long)__bias << __mant;
        __r = 0;
        __up = __mode == 0 ? __mag > (unsigned long long)(__bias - 1) << __mant : 0;
    } else {
        __one = 1ULL << (__mant - __e);
        unsigned long long __f = __mag & (__one - 1);
        if (__f == 0)
            return __x;
        __r = __mag - __f;
        __up = __mode == 0 ? __f > __one >> 1 || (__f == __one >> 1 && (__mag & __one)) : 0;
    }
    if (__mode == 1 || __mode == 2)
        __up = __neg == (__mode == 1);
    if (!(__m & 8)) {
        volatile double __t = 1.0;
        __t += 0x1p-60;
    }
    return (__up ? __r + __one : __r) | (__x & __sign);
}

static inline float __badc_round_f(float __x, int __m) {
    if (__x != __x)
        return __x + __x;
    __v4si __b = (__v4si)(__m128){__x, 0, 0, 0};
    __b[0] = (int)__badc_round((unsigned)__b[0], 23, 127, __m);
    return ((__m128)__b)[0];
}

static inline double __badc_round_d(double __x, int __m) {
    if (__x != __x)
        return __x + __x;
    __v2di __b = (__v2di)(__m128d){__x, 0};
    __b[0] = (long long)__badc_round((unsigned long long)__b[0], 52, 1023, __m);
    return ((__m128d)__b)[0];
}

static inline __m128 _mm_round_ps(__m128 __V, const int __M) {
    for (int __i = 0; __i < 4; __i++)
        __V[__i] = __badc_round_f(__V[__i], __M);
    return __V;
}

static inline __m128d _mm_round_pd(__m128d __V, const int __M) {
    for (int __i = 0; __i < 2; __i++)
        __V[__i] = __badc_round_d(__V[__i], __M);
    return __V;
}

static inline __m128 _mm_round_ss(__m128 __D, __m128 __V, const int __M) {
    __D[0] = __badc_round_f(__V[0], __M);
    return __D;
}

static inline __m128d _mm_round_sd(__m128d __D, __m128d __V, const int __M) {
    __D[0] = __badc_round_d(__V[0], __M);
    return __D;
}

#define _mm_floor_ps(V) _mm_round_ps((V), _MM_FROUND_FLOOR)
#define _mm_floor_pd(V) _mm_round_pd((V), _MM_FROUND_FLOOR)
#define _mm_floor_ss(D, V) _mm_round_ss((D), (V), _MM_FROUND_FLOOR)
#define _mm_floor_sd(D, V) _mm_round_sd((D), (V), _MM_FROUND_FLOOR)
#define _mm_ceil_ps(V) _mm_round_ps((V), _MM_FROUND_CEIL)
#define _mm_ceil_pd(V) _mm_round_pd((V), _MM_FROUND_CEIL)
#define _mm_ceil_ss(D, V) _mm_round_ss((D), (V), _MM_FROUND_CEIL)
#define _mm_ceil_sd(D, V) _mm_round_sd((D), (V), _MM_FROUND_CEIL)

/* DPPS / DPPD: the products imm8[7:4] selects, the others +0.0, summed in
** pairs and the pair sums added; the sum goes to the lanes imm8[3:0]
** selects, +0.0 to the others. */
static inline __m128 _mm_dp_ps(__m128 __X, __m128 __Y, const int __M) {
    float __p[4];
    for (int __i = 0; __i < 4; __i++)
        __p[__i] = __M >> (4 + __i) & 1 ? __X[__i] * __Y[__i] : 0.0f;
    float __s = (__p[0] + __p[1]) + (__p[2] + __p[3]);
    for (int __i = 0; __i < 4; __i++)
        __X[__i] = __M >> __i & 1 ? __s : 0.0f;
    return __X;
}

static inline __m128d _mm_dp_pd(__m128d __X, __m128d __Y, const int __M) {
    double __p0 = __M & 0x10 ? __X[0] * __Y[0] : 0.0;
    double __p1 = __M & 0x20 ? __X[1] * __Y[1] : 0.0;
    double __s = __p0 + __p1;
    return (__m128d){__M & 1 ? __s : 0.0, __M & 2 ? __s : 0.0};
}

/* PHMINPOSUW: the least unsigned word in word 0 and the index of its first
** occurrence in bits 18:16, the rest zero. */
static inline __m128i _mm_minpos_epu16(__m128i __X) {
    __v8hi __x = (__v8hi)__X;
    int __k = 0;
    for (int __i = 1; __i < 8; __i++)
        if ((unsigned short)__x[__i] < (unsigned short)__x[__k])
            __k = __i;
    return (__m128i)(__v8hi){__x[__k], (short)__k, 0, 0, 0, 0, 0, 0};
}

/* MPSADBW: eight sums of absolute differences between the four bytes of
** the second operand at 4 * imm8[1:0] and the eight four-byte windows of
** the first starting at 4 * imm8[2]. */
static inline __m128i _mm_mpsadbw_epu8(__m128i __X, __m128i __Y, const int __M) {
    __v16qi __x = (__v16qi)__X, __y = (__v16qi)__Y;
    int __xo = (__M >> 2 & 1) * 4, __yo = (__M & 3) * 4;
    __v8hi __r;
    for (int __i = 0; __i < 8; __i++) {
        int __s = 0;
        for (int __k = 0; __k < 4; __k++) {
            int __d = (unsigned char)__x[__xo + __i + __k] - (unsigned char)__y[__yo + __k];
            __s += __d < 0 ? -__d : __d;
        }
        __r[__i] = (short)__s;
    }
    return (__m128i)__r;
}

/* SSE4.2's string compares (SDM 4.1). Imm8[1:0] picks unsigned or signed
** bytes or words, imm8[3:2] the aggregation, imm8[5:4] the polarity and
** imm8[6] the index or mask form. A string's length is the explicit one,
** its magnitude saturated to the element count, or the index of its first
** null element. */
#define _SIDD_UBYTE_OPS 0x00
#define _SIDD_UWORD_OPS 0x01
#define _SIDD_SBYTE_OPS 0x02
#define _SIDD_SWORD_OPS 0x03
#define _SIDD_CMP_EQUAL_ANY 0x00
#define _SIDD_CMP_RANGES 0x04
#define _SIDD_CMP_EQUAL_EACH 0x08
#define _SIDD_CMP_EQUAL_ORDERED 0x0c
#define _SIDD_POSITIVE_POLARITY 0x00
#define _SIDD_NEGATIVE_POLARITY 0x10
#define _SIDD_MASKED_POSITIVE_POLARITY 0x20
#define _SIDD_MASKED_NEGATIVE_POLARITY 0x30
#define _SIDD_LEAST_SIGNIFICANT 0x00
#define _SIDD_MOST_SIGNIFICANT 0x40
#define _SIDD_BIT_MASK 0x00
#define _SIDD_UNIT_MASK 0x40

__BADC_INTRIN int __badc_str_count(int __m) {
    return __m & 1 ? 8 : 16;
}

static inline int __badc_str_elem(__m128i __V, int __i, int __m) {
    switch (__m & 3) {
    case 0: return (unsigned char)((__v16qi)__V)[__i];
    case 1: return (unsigned short)((__v8hi)__V)[__i];
    case 2: return (signed char)((__v16qi)__V)[__i];
    default: return ((__v8hi)__V)[__i];
    }
}

static inline int __badc_str_elen(int __l, int __m) {
    long long __a = __l < 0 ? -(long long)__l : __l;
    return __a > __badc_str_count(__m) ? __badc_str_count(__m) : (int)__a;
}

static inline int __badc_str_ilen(__m128i __V, int __m) {
    int __i = 0;
    while (__i < __badc_str_count(__m) && __badc_str_elem(__V, __i, __m) != 0)
        __i++;
    return __i;
}

/* IntRes2: bit i for element i of the second operand. An element past a
** string's length is invalid and forces each comparison as the SDM's table
** 4-7 gives. */
static inline int __badc_str_res(__m128i __A, int __la, __m128i __B, int __lb, int __m) {
    int __n = __badc_str_count(__m), __r = 0;
    for (int __i = 0; __i < __n; __i++) {
        int __b = __i < __lb ? __badc_str_elem(__B, __i, __m) : 0, __bit = 0;
        switch (__m >> 2 & 3) {
        case 0:
            for (int __j = 0; __j < __la && __i < __lb; __j++)
                __bit |= __badc_str_elem(__A, __j, __m) == __b;
            break;
        case 1:
            for (int __j = 0; __j + 1 < __la && __i < __lb; __j += 2)
                __bit |= __badc_str_elem(__A, __j, __m) <= __b &&
                         __b <= __badc_str_elem(__A, __j + 1, __m);
            break;
        case 2:
            __bit = __i < __la && __i < __lb ? __badc_str_elem(__A, __i, __m) == __b
                                             : __i >= __la && __i >= __lb;
            break;
        default:
            __bit = 1;
            for (int __j = 0; __j < __n - __i && __j < __la && __bit; __j++)
                __bit = __i + __j < __lb &&
                        __badc_str_elem(__A, __j, __m) == __badc_str_elem(__B, __i + __j, __m);
        }
        __r |= __bit << __i;
    }
    if ((__m >> 4 & 3) == 1)
        __r ^= (1 << __n) - 1;
    else if ((__m >> 4 & 3) == 3)
        __r ^= (1 << __lb) - 1;
    return __r;
}

static inline int __badc_str_index(int __r, int __m) {
    int __n = __badc_str_count(__m), __k;
    if (!__r)
        return __n;
    if (__m & 0x40)
        for (__k = __n - 1; !(__r >> __k & 1); __k--)
            ;
    else
        for (__k = 0; !(__r >> __k & 1); __k++)
            ;
    return __k;
}

static inline __m128i __badc_str_mask(int __r, int __m) {
    if (!(__m & 0x40))
        return _mm_cvtsi32_si128(__r);
    __v16qi __b;
    __v8hi __w;
    for (int __i = 0; __i < 16; __i++)
        __b[__i] = __r >> __i & 1 ? -1 : 0;
    for (int __i = 0; __i < 8; __i++)
        __w[__i] = __r >> __i & 1 ? -1 : 0;
    return __m & 1 ? (__m128i)__w : (__m128i)__b;
}

/* The flags: CF, IntRes2 nonzero; ZF and SF, the second and first strings
** shorter than the element count; OF, IntRes2 bit 0. */
#define __BADC_STR(name, result)                                                               \
    static inline int _mm_cmpistr##name(__m128i __A, __m128i __B, const int __M) {           \
        int __la = __badc_str_ilen(__A, __M), __lb = __badc_str_ilen(__B, __M);              \
        int __r = __badc_str_res(__A, __la, __B, __lb, __M), __n = __badc_str_count(__M);    \
        (void)__n;                                                                           \
        return result;                                                                       \
    }                                                                                        \
    static inline int _mm_cmpestr##name(__m128i __A, int __LA, __m128i __B, int __LB,         \
                                        const int __M) {                                     \
        int __la = __badc_str_elen(__LA, __M), __lb = __badc_str_elen(__LB, __M);            \
        int __r = __badc_str_res(__A, __la, __B, __lb, __M), __n = __badc_str_count(__M);    \
        (void)__n;                                                                           \
        return result;                                                                       \
    }
__BADC_STR(i, __badc_str_index(__r, __M))
__BADC_STR(a, __r == 0 && __lb == __n)
__BADC_STR(c, __r != 0)
__BADC_STR(o, __r & 1)
__BADC_STR(s, __la < __n)
__BADC_STR(z, __lb < __n)
#undef __BADC_STR

static inline __m128i _mm_cmpistrm(__m128i __A, __m128i __B, const int __M) {
    int __la = __badc_str_ilen(__A, __M), __lb = __badc_str_ilen(__B, __M);
    return __badc_str_mask(__badc_str_res(__A, __la, __B, __lb, __M), __M);
}

static inline __m128i _mm_cmpestrm(__m128i __A, int __LA, __m128i __B, int __LB, const int __M) {
    int __la = __badc_str_elen(__LA, __M), __lb = __badc_str_elen(__LB, __M);
    return __badc_str_mask(__badc_str_res(__A, __la, __B, __lb, __M), __M);
}

/* CRC32: the CRC-32C (Castagnoli) of the operand's bytes, accumulated. */
static inline unsigned int _mm_crc32_u8(unsigned int __C, unsigned char __V) {
    __asm__("crc32b %1, %0" : "+r"(__C) : "r"(__V));
    return __C;
}

static inline unsigned int _mm_crc32_u16(unsigned int __C, unsigned short __V) {
    __asm__("crc32w %1, %0" : "+r"(__C) : "r"(__V));
    return __C;
}

static inline unsigned int _mm_crc32_u32(unsigned int __C, unsigned int __V) {
    __asm__("crc32l %1, %0" : "+r"(__C) : "r"(__V));
    return __C;
}

#ifdef __x86_64__
static inline unsigned long long _mm_crc32_u64(unsigned long long __C, unsigned long long __V) {
    __asm__("crc32q %1, %0" : "+r"(__C) : "r"(__V));
    return __C;
}
#endif
