/* SSE3 intrinsics: the operations of gcc's <pmmintrin.h>, with MONITOR and
** MWAIT, which gcc takes from <mwaitintrin.h>. The floating operations are
** written lane by lane over the vector extension, each an IEEE operation at
** the lane's precision as the instruction performs it. */
#pragma once
#ifndef __BADC_INTRIN
/* An intrinsic is inlined at every optimization level, as a call to it would
 * pass and copy its vectors around one instruction. */
#define __BADC_INTRIN static __inline__ __attribute__((__always_inline__))
#endif

#if !defined(__x86_64__) && !defined(__i386__)
#error "pmmintrin.h is only available when targeting x86"
#endif

#include <emmintrin.h>

/* The MXCSR denormals-are-zero bit. */
#define _MM_DENORMALS_ZERO_MASK 0x0040
#define _MM_DENORMALS_ZERO_ON 0x0040
#define _MM_DENORMALS_ZERO_OFF 0x0000
#define _MM_SET_DENORMALS_ZERO_MODE(mode)                                                     \
    _mm_setcsr((_mm_getcsr() & ~_MM_DENORMALS_ZERO_MASK) | (mode))
#define _MM_GET_DENORMALS_ZERO_MODE() (_mm_getcsr() & _MM_DENORMALS_ZERO_MASK)

__BADC_INTRIN __m128 _mm_addsub_ps(__m128 __X, __m128 __Y) {
    return (__m128){__X[0] - __Y[0], __X[1] + __Y[1], __X[2] - __Y[2], __X[3] + __Y[3]};
}

__BADC_INTRIN __m128 _mm_hadd_ps(__m128 __X, __m128 __Y) {
    return (__m128){__X[0] + __X[1], __X[2] + __X[3], __Y[0] + __Y[1], __Y[2] + __Y[3]};
}

__BADC_INTRIN __m128 _mm_hsub_ps(__m128 __X, __m128 __Y) {
    return (__m128){__X[0] - __X[1], __X[2] - __X[3], __Y[0] - __Y[1], __Y[2] - __Y[3]};
}

__BADC_INTRIN __m128 _mm_movehdup_ps(__m128 __X) {
    return (__m128){__X[1], __X[1], __X[3], __X[3]};
}

__BADC_INTRIN __m128 _mm_moveldup_ps(__m128 __X) {
    return (__m128){__X[0], __X[0], __X[2], __X[2]};
}

__BADC_INTRIN __m128d _mm_addsub_pd(__m128d __X, __m128d __Y) {
    return (__m128d){__X[0] - __Y[0], __X[1] + __Y[1]};
}

__BADC_INTRIN __m128d _mm_hadd_pd(__m128d __X, __m128d __Y) {
    return (__m128d){__X[0] + __X[1], __Y[0] + __Y[1]};
}

__BADC_INTRIN __m128d _mm_hsub_pd(__m128d __X, __m128d __Y) {
    return (__m128d){__X[0] - __X[1], __Y[0] - __Y[1]};
}

__BADC_INTRIN __m128d _mm_loaddup_pd(double const *__P) {
    return (__m128d){*__P, *__P};
}

__BADC_INTRIN __m128d _mm_movedup_pd(__m128d __X) {
    return (__m128d){__X[0], __X[0]};
}

__BADC_INTRIN __m128i _mm_lddqu_si128(__m128i const *__P) {
    return (__m128i)__builtin_ia32_loaddqu((char const *)__P);
}

/* MONITOR takes the address in rax, the extensions in ecx and the hints
** in edx; MWAIT the hints in eax and the extensions in ecx. */
__BADC_INTRIN void _mm_monitor(void const *__P, unsigned int __E, unsigned int __H) {
    __asm__ __volatile__("monitor" : : "a"(__P), "c"(__E), "d"(__H));
}

__BADC_INTRIN void _mm_mwait(unsigned int __E, unsigned int __H) {
    __asm__ __volatile__("mwait" : : "c"(__E), "a"(__H));
}
