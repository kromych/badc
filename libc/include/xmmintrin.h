/* SSE intrinsics. This build carries the vector types and the shuffle
** selector; the SSE1 packed-single operations are not provided. */
#pragma once

#if !defined(__x86_64__) && !defined(__i386__)
#error "xmmintrin.h is only available when targeting x86"
#endif

typedef float __m128 __attribute__((__vector_size__(16)));
typedef float __v4sf __attribute__((__vector_size__(16)));

#define _MM_SHUFFLE(w, x, y, z) (((w) << 6) | ((x) << 4) | ((y) << 2) | (z))

static inline void _mm_pause(void) {
    __asm__ __volatile__("pause");
}
