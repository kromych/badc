/* SSE intrinsics. This build carries the vector types, the shuffle selector
** and the MXCSR access; the SSE1 packed-single operations are not provided.
** As in gcc and clang, the MMX types come from <mmintrin.h> and, in a hosted
** unit, _mm_malloc and _mm_free from <mm_malloc.h>. */
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

static inline unsigned int _mm_getcsr(void) {
    unsigned int __csr;
    __asm__ __volatile__("stmxcsr %0" : "=m"(__csr));
    return __csr;
}

static inline void _mm_setcsr(unsigned int __csr) {
    __asm__ __volatile__("ldmxcsr %0" : : "m"(__csr));
}
