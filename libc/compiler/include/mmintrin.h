/* MMX intrinsics: gcc's __m64 and the operations of its <mmintrin.h>, with
** the _m_ spellings. Each is written over the 8-byte vector extension, lane
** by lane as the SDM defines the instruction, or, where SSE2 has the
** instruction for the low half of an xmm register, as gcc's builtin of it,
** so no MMX register is used; _mm_empty still executes EMMS. Shift counts
** past the lane width give the instruction's result: zero, or the sign for
** an arithmetic shift. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "mmintrin.h is only available when targeting x86"
#endif

/* A unit may define `__attribute__` away, as code written for compilers
** without it does; the declarations below need it. */
#pragma push_macro("__attribute__")
#undef __attribute__

typedef int __m64 __attribute__((__vector_size__(8), __may_alias__));
/* The unaligned form of the vector type an unaligned access dereferences. */
typedef int __m64_u __attribute__((__vector_size__(8), __may_alias__, __aligned__(1)));
typedef int __v2si __attribute__((__vector_size__(8)));
typedef short __v4hi __attribute__((__vector_size__(8)));
typedef char __v8qi __attribute__((__vector_size__(8)));
typedef long long __v1di __attribute__((__vector_size__(8)));
typedef float __v2sf __attribute__((__vector_size__(8)));
/* The lane views the arithmetic takes, as clang names them. */
typedef unsigned int __v2su __attribute__((__vector_size__(8)));
typedef unsigned short __v4hu __attribute__((__vector_size__(8)));
typedef signed char __v8qs __attribute__((__vector_size__(8)));
typedef unsigned char __v8qu __attribute__((__vector_size__(8)));

static inline void _mm_empty(void) {
    __asm__ __volatile__("emms");
}

static inline __m64 _mm_setzero_si64(void) {
    return (__m64)0LL;
}

/* Conversions between the 64-bit vector and an integer. */

static inline __m64 _mm_cvtsi32_si64(int __i) {
    return (__m64)(__v2si){__i, 0};
}

static inline int _mm_cvtsi64_si32(__m64 __m) {
    return ((__v2si)__m)[0];
}

static inline __m64 _mm_cvtsi64_m64(long long __i) {
    return (__m64)__i;
}

static inline long long _mm_cvtm64_si64(__m64 __m) {
    return (long long)__m;
}

#define _mm_cvtsi64x_si64 _mm_cvtsi64_m64
#define _mm_set_pi64x _mm_cvtsi64_m64
#define _mm_cvtsi64_si64x _mm_cvtm64_si64

/* Composition, the highest lane first in _mm_set_*, lane zero first in
** _mm_setr_*. */

static inline __m64 _mm_set_pi32(int __i1, int __i0) {
    return (__m64)(__v2si){__i0, __i1};
}

static inline __m64 _mm_set_pi16(short __w3, short __w2, short __w1, short __w0) {
    return (__m64)(__v4hi){__w0, __w1, __w2, __w3};
}

static inline __m64 _mm_set_pi8(char __b7, char __b6, char __b5, char __b4, char __b3, char __b2,
                                char __b1, char __b0) {
    return (__m64)(__v8qi){__b0, __b1, __b2, __b3, __b4, __b5, __b6, __b7};
}

static inline __m64 _mm_setr_pi32(int __i0, int __i1) {
    return (__m64)(__v2si){__i0, __i1};
}

static inline __m64 _mm_setr_pi16(short __w0, short __w1, short __w2, short __w3) {
    return (__m64)(__v4hi){__w0, __w1, __w2, __w3};
}

static inline __m64 _mm_setr_pi8(char __b0, char __b1, char __b2, char __b3, char __b4,
                                 char __b5, char __b6, char __b7) {
    return (__m64)(__v8qi){__b0, __b1, __b2, __b3, __b4, __b5, __b6, __b7};
}

static inline __m64 _mm_set1_pi32(int __i) {
    return (__m64)(__v2si){__i, __i};
}

static inline __m64 _mm_set1_pi16(short __w) {
    return (__m64)(__v4hi){__w, __w, __w, __w};
}

static inline __m64 _mm_set1_pi8(char __b) {
    return (__m64)(__v8qi){__b, __b, __b, __b, __b, __b, __b, __b};
}

/* Saturation to a signed or unsigned lane of `__bits`. */
static inline int __mm_sat_signed(int __v, int __bits) {
    int __hi = (1 << (__bits - 1)) - 1;
    return __v > __hi ? __hi : __v < -__hi - 1 ? -__hi - 1 : __v;
}

static inline int __mm_sat_unsigned(int __v, int __bits) {
    int __hi = (1 << __bits) - 1;
    return __v > __hi ? __hi : __v < 0 ? 0 : __v;
}

/* PACKSSWB, PACKSSDW, PACKUSWB: the first operand's lanes, then the
** second's, each saturated to half the width. */

static inline __m64 _mm_packs_pi16(__m64 __m1, __m64 __m2) {
    __v4hi __a = (__v4hi)__m1, __b = (__v4hi)__m2;
    __v8qs __r;
    for (int __i = 0; __i < 4; __i++) {
        __r[__i] = (signed char)__mm_sat_signed(__a[__i], 8);
        __r[__i + 4] = (signed char)__mm_sat_signed(__b[__i], 8);
    }
    return (__m64)__r;
}

static inline __m64 _mm_packs_pi32(__m64 __m1, __m64 __m2) {
    __v2si __a = (__v2si)__m1, __b = (__v2si)__m2;
    __v4hi __r;
    for (int __i = 0; __i < 2; __i++) {
        __r[__i] = (short)__mm_sat_signed(__a[__i], 16);
        __r[__i + 2] = (short)__mm_sat_signed(__b[__i], 16);
    }
    return (__m64)__r;
}

static inline __m64 _mm_packs_pu16(__m64 __m1, __m64 __m2) {
    __v4hi __a = (__v4hi)__m1, __b = (__v4hi)__m2;
    __v8qu __r;
    for (int __i = 0; __i < 4; __i++) {
        __r[__i] = (unsigned char)__mm_sat_unsigned(__a[__i], 8);
        __r[__i + 4] = (unsigned char)__mm_sat_unsigned(__b[__i], 8);
    }
    return (__m64)__r;
}

/* PUNPCKH*, PUNPCKL*: the lanes of the high or the low half of each
** operand, interleaved, the first operand's first. */

static inline __m64 _mm_unpackhi_pi8(__m64 __m1, __m64 __m2) {
    __v8qi __a = (__v8qi)__m1, __b = (__v8qi)__m2;
    return (__m64)(__v8qi){__a[4], __b[4], __a[5], __b[5], __a[6], __b[6], __a[7], __b[7]};
}

static inline __m64 _mm_unpackhi_pi16(__m64 __m1, __m64 __m2) {
    __v4hi __a = (__v4hi)__m1, __b = (__v4hi)__m2;
    return (__m64)(__v4hi){__a[2], __b[2], __a[3], __b[3]};
}

static inline __m64 _mm_unpackhi_pi32(__m64 __m1, __m64 __m2) {
    return (__m64)(__v2si){((__v2si)__m1)[1], ((__v2si)__m2)[1]};
}

static inline __m64 _mm_unpacklo_pi8(__m64 __m1, __m64 __m2) {
    __v8qi __a = (__v8qi)__m1, __b = (__v8qi)__m2;
    return (__m64)(__v8qi){__a[0], __b[0], __a[1], __b[1], __a[2], __b[2], __a[3], __b[3]};
}

static inline __m64 _mm_unpacklo_pi16(__m64 __m1, __m64 __m2) {
    __v4hi __a = (__v4hi)__m1, __b = (__v4hi)__m2;
    return (__m64)(__v4hi){__a[0], __b[0], __a[1], __b[1]};
}

static inline __m64 _mm_unpacklo_pi32(__m64 __m1, __m64 __m2) {
    return (__m64)(__v2si){((__v2si)__m1)[0], ((__v2si)__m2)[0]};
}

/* Wrapping arithmetic, on unsigned lanes so it is defined. */

static inline __m64 _mm_add_pi8(__m64 __m1, __m64 __m2) {
    return (__m64)((__v8qu)__m1 + (__v8qu)__m2);
}

static inline __m64 _mm_add_pi16(__m64 __m1, __m64 __m2) {
    return (__m64)((__v4hu)__m1 + (__v4hu)__m2);
}

static inline __m64 _mm_add_pi32(__m64 __m1, __m64 __m2) {
    return (__m64)((__v2su)__m1 + (__v2su)__m2);
}

static inline __m64 _mm_add_si64(__m64 __m1, __m64 __m2) {
    return (__m64)((unsigned long long)__m1 + (unsigned long long)__m2);
}

static inline __m64 _mm_sub_pi8(__m64 __m1, __m64 __m2) {
    return (__m64)((__v8qu)__m1 - (__v8qu)__m2);
}

static inline __m64 _mm_sub_pi16(__m64 __m1, __m64 __m2) {
    return (__m64)((__v4hu)__m1 - (__v4hu)__m2);
}

static inline __m64 _mm_sub_pi32(__m64 __m1, __m64 __m2) {
    return (__m64)((__v2su)__m1 - (__v2su)__m2);
}

static inline __m64 _mm_sub_si64(__m64 __m1, __m64 __m2) {
    return (__m64)((unsigned long long)__m1 - (unsigned long long)__m2);
}

/* Saturating arithmetic: PADDS*, PADDUS*, PSUBS*, PSUBUS*. */

static inline __m64 _mm_adds_pi8(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_paddsb((__v8qi)__m1, (__v8qi)__m2);
}

static inline __m64 _mm_adds_pi16(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_paddsw((__v4hi)__m1, (__v4hi)__m2);
}

static inline __m64 _mm_adds_pu8(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_paddusb((__v8qi)__m1, (__v8qi)__m2);
}

static inline __m64 _mm_adds_pu16(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_paddusw((__v4hi)__m1, (__v4hi)__m2);
}

static inline __m64 _mm_subs_pi8(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_psubsb((__v8qi)__m1, (__v8qi)__m2);
}

static inline __m64 _mm_subs_pi16(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_psubsw((__v4hi)__m1, (__v4hi)__m2);
}

static inline __m64 _mm_subs_pu8(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_psubusb((__v8qi)__m1, (__v8qi)__m2);
}

static inline __m64 _mm_subs_pu16(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_psubusw((__v4hi)__m1, (__v4hi)__m2);
}

/* PMADDWD, PMULHW, PMULLW. The pair sum wraps where all four words are
** -32768, as the instruction does. */

static inline __m64 _mm_madd_pi16(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_pmaddwd((__v4hi)__m1, (__v4hi)__m2);
}

static inline __m64 _mm_mulhi_pi16(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_pmulhw((__v4hi)__m1, (__v4hi)__m2);
}

static inline __m64 _mm_mullo_pi16(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_pmullw((__v4hi)__m1, (__v4hi)__m2);
}

/* Shifts. The register forms take the whole 64-bit count, the immediate
** forms an unsigned one. */

static inline __m64 _mm_sll_pi16(__m64 __m, __m64 __count) {
    unsigned long long __c = (unsigned long long)__count;
    return __c > 15 ? _mm_setzero_si64() : (__m64)((__v4hu)__m << (int)__c);
}

static inline __m64 _mm_sll_pi32(__m64 __m, __m64 __count) {
    unsigned long long __c = (unsigned long long)__count;
    return __c > 31 ? _mm_setzero_si64() : (__m64)((__v2su)__m << (int)__c);
}

static inline __m64 _mm_sll_si64(__m64 __m, __m64 __count) {
    unsigned long long __c = (unsigned long long)__count;
    return __c > 63 ? _mm_setzero_si64() : (__m64)((unsigned long long)__m << __c);
}

static inline __m64 _mm_srl_pi16(__m64 __m, __m64 __count) {
    unsigned long long __c = (unsigned long long)__count;
    return __c > 15 ? _mm_setzero_si64() : (__m64)((__v4hu)__m >> (int)__c);
}

static inline __m64 _mm_srl_pi32(__m64 __m, __m64 __count) {
    unsigned long long __c = (unsigned long long)__count;
    return __c > 31 ? _mm_setzero_si64() : (__m64)((__v2su)__m >> (int)__c);
}

static inline __m64 _mm_srl_si64(__m64 __m, __m64 __count) {
    unsigned long long __c = (unsigned long long)__count;
    return __c > 63 ? _mm_setzero_si64() : (__m64)((unsigned long long)__m >> __c);
}

static inline __m64 _mm_sra_pi16(__m64 __m, __m64 __count) {
    unsigned long long __c = (unsigned long long)__count;
    return (__m64)((__v4hi)__m >> (int)(__c > 15 ? 15 : __c));
}

static inline __m64 _mm_sra_pi32(__m64 __m, __m64 __count) {
    unsigned long long __c = (unsigned long long)__count;
    return (__m64)((__v2si)__m >> (int)(__c > 31 ? 31 : __c));
}

static inline __m64 _mm_slli_pi16(__m64 __m, int __count) {
    return _mm_sll_pi16(__m, (__m64)(unsigned long long)(unsigned)__count);
}

static inline __m64 _mm_slli_pi32(__m64 __m, int __count) {
    return _mm_sll_pi32(__m, (__m64)(unsigned long long)(unsigned)__count);
}

static inline __m64 _mm_slli_si64(__m64 __m, int __count) {
    return _mm_sll_si64(__m, (__m64)(unsigned long long)(unsigned)__count);
}

static inline __m64 _mm_srli_pi16(__m64 __m, int __count) {
    return _mm_srl_pi16(__m, (__m64)(unsigned long long)(unsigned)__count);
}

static inline __m64 _mm_srli_pi32(__m64 __m, int __count) {
    return _mm_srl_pi32(__m, (__m64)(unsigned long long)(unsigned)__count);
}

static inline __m64 _mm_srli_si64(__m64 __m, int __count) {
    return _mm_srl_si64(__m, (__m64)(unsigned long long)(unsigned)__count);
}

static inline __m64 _mm_srai_pi16(__m64 __m, int __count) {
    return _mm_sra_pi16(__m, (__m64)(unsigned long long)(unsigned)__count);
}

static inline __m64 _mm_srai_pi32(__m64 __m, int __count) {
    return _mm_sra_pi32(__m, (__m64)(unsigned long long)(unsigned)__count);
}

/* Bitwise logic. */

static inline __m64 _mm_and_si64(__m64 __m1, __m64 __m2) {
    return (__m64)((__v2su)__m1 & (__v2su)__m2);
}

static inline __m64 _mm_andnot_si64(__m64 __m1, __m64 __m2) {
    return (__m64)(~(__v2su)__m1 & (__v2su)__m2);
}

static inline __m64 _mm_or_si64(__m64 __m1, __m64 __m2) {
    return (__m64)((__v2su)__m1 | (__v2su)__m2);
}

static inline __m64 _mm_xor_si64(__m64 __m1, __m64 __m2) {
    return (__m64)((__v2su)__m1 ^ (__v2su)__m2);
}

/* PCMPEQ*, PCMPGT*: all ones in a lane where the comparison of the signed
** lanes holds. */

static inline __m64 _mm_cmpeq_pi8(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_pcmpeqb((__v8qi)__m1, (__v8qi)__m2);
}

static inline __m64 _mm_cmpeq_pi16(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_pcmpeqw((__v4hi)__m1, (__v4hi)__m2);
}

static inline __m64 _mm_cmpeq_pi32(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_pcmpeqd((__v2si)__m1, (__v2si)__m2);
}

static inline __m64 _mm_cmpgt_pi8(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_pcmpgtb((__v8qi)__m1, (__v8qi)__m2);
}

static inline __m64 _mm_cmpgt_pi16(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_pcmpgtw((__v4hi)__m1, (__v4hi)__m2);
}

static inline __m64 _mm_cmpgt_pi32(__m64 __m1, __m64 __m2) {
    return (__m64)__builtin_ia32_pcmpgtd((__v2si)__m1, (__v2si)__m2);
}

/* The instruction-named spellings. */
#define _m_empty _mm_empty
#define _m_from_int _mm_cvtsi32_si64
#define _m_from_int64 _mm_cvtsi64_m64
#define _m_to_int _mm_cvtsi64_si32
#define _m_to_int64 _mm_cvtm64_si64
#define _m_packsswb _mm_packs_pi16
#define _m_packssdw _mm_packs_pi32
#define _m_packuswb _mm_packs_pu16
#define _m_punpckhbw _mm_unpackhi_pi8
#define _m_punpckhwd _mm_unpackhi_pi16
#define _m_punpckhdq _mm_unpackhi_pi32
#define _m_punpcklbw _mm_unpacklo_pi8
#define _m_punpcklwd _mm_unpacklo_pi16
#define _m_punpckldq _mm_unpacklo_pi32
#define _m_paddb _mm_add_pi8
#define _m_paddw _mm_add_pi16
#define _m_paddd _mm_add_pi32
#define _m_paddsb _mm_adds_pi8
#define _m_paddsw _mm_adds_pi16
#define _m_paddusb _mm_adds_pu8
#define _m_paddusw _mm_adds_pu16
#define _m_psubb _mm_sub_pi8
#define _m_psubw _mm_sub_pi16
#define _m_psubd _mm_sub_pi32
#define _m_psubsb _mm_subs_pi8
#define _m_psubsw _mm_subs_pi16
#define _m_psubusb _mm_subs_pu8
#define _m_psubusw _mm_subs_pu16
#define _m_pmaddwd _mm_madd_pi16
#define _m_pmulhw _mm_mulhi_pi16
#define _m_pmullw _mm_mullo_pi16
#define _m_psllw _mm_sll_pi16
#define _m_psllwi _mm_slli_pi16
#define _m_pslld _mm_sll_pi32
#define _m_pslldi _mm_slli_pi32
#define _m_psllq _mm_sll_si64
#define _m_psllqi _mm_slli_si64
#define _m_psraw _mm_sra_pi16
#define _m_psrawi _mm_srai_pi16
#define _m_psrad _mm_sra_pi32
#define _m_psradi _mm_srai_pi32
#define _m_psrlw _mm_srl_pi16
#define _m_psrlwi _mm_srli_pi16
#define _m_psrld _mm_srl_pi32
#define _m_psrldi _mm_srli_pi32
#define _m_psrlq _mm_srl_si64
#define _m_psrlqi _mm_srli_si64
#define _m_pand _mm_and_si64
#define _m_pandn _mm_andnot_si64
#define _m_por _mm_or_si64
#define _m_pxor _mm_xor_si64
#define _m_pcmpeqb _mm_cmpeq_pi8
#define _m_pcmpeqw _mm_cmpeq_pi16
#define _m_pcmpeqd _mm_cmpeq_pi32
#define _m_pcmpgtb _mm_cmpgt_pi8
#define _m_pcmpgtw _mm_cmpgt_pi16
#define _m_pcmpgtd _mm_cmpgt_pi32

#pragma pop_macro("__attribute__")
