/* _mm_malloc and _mm_free: a block at a power-of-two alignment and its
** release. As in gcc and clang, posix_memalign provides it where the C
** library has it and _aligned_malloc on Windows, whose blocks _aligned_free
** releases; an alignment below a pointer's is raised to it. An alignment
** that is not a power of two yields a null pointer. */
#pragma once

#include <stdlib.h>
#ifdef _WIN32
#include <malloc.h>
#endif

static inline void *_mm_malloc(size_t __size, size_t __align) {
    if (__align & (__align - 1))
        return 0;
    if (__align < sizeof(void *))
        __align = sizeof(void *);
#ifdef _WIN32
    return _aligned_malloc(__size, __align);
#else
    void *__p;
    return posix_memalign(&__p, __align, __size) ? 0 : __p;
#endif
}

static inline void _mm_free(void *__p) {
#ifdef _WIN32
    _aligned_free(__p);
#else
    free(__p);
#endif
}
