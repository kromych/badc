// malloc.h -- pre-POSIX compatibility header for `alloca` and the
// `malloc` / `free` family. Windows headers historically expose
// `alloca` from `<malloc.h>` rather than the POSIX `<alloca.h>`,
// so source that targets msvcrt reaches here for the declaration.
// The c5 entry route is identical -- pulling in `<alloca.h>`
// registers the `alloca` / `__builtin_alloca` intrinsics. The
// `malloc` / `free` family lives in `<stdlib.h>` and is exposed
// transitively for source that depends on the historical
// grouping.

#pragma once

#include <alloca.h>
#include <stdlib.h>

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_aligned_free,            "_aligned_free")
#pragma binding(msvcrt::_aligned_malloc,          "_aligned_malloc")
#pragma binding(msvcrt::_aligned_offset_malloc,   "_aligned_offset_malloc")
#pragma binding(msvcrt::_aligned_realloc,         "_aligned_realloc")
#pragma binding(msvcrt::_aligned_offset_realloc,  "_aligned_offset_realloc")
#pragma binding(msvcrt::_expand,                  "_expand")
#pragma binding(msvcrt::_msize,                   "_msize")
#pragma binding(msvcrt::_heapchk,                 "_heapchk")
#pragma binding(msvcrt::_heapmin,                 "_heapmin")
#pragma binding(msvcrt::_resetstkoflw,            "_resetstkoflw")
#define _HEAP_MAXREQ 0xFFFFFFFFFFFFFFE0
void _aligned_free(void *memory);
void *_aligned_malloc(size_t size, size_t alignment);
void *_aligned_offset_malloc(size_t size, size_t alignment, size_t offset);
void *_aligned_realloc(void *memory, size_t size, size_t alignment);
void *_aligned_offset_realloc(void *memory, size_t size, size_t alignment, size_t offset);
void *_expand(void *memory, size_t size);
size_t _msize(void *memory);
int _heapchk(void);
int _heapmin(void);
int _resetstkoflw(void);
#define _alloca(x) __builtin_alloca((x))

#define _ALLOCA_S_THRESHOLD    1024
#define _ALLOCA_S_STACK_MARKER 0xCCCC
#define _ALLOCA_S_HEAP_MARKER  0xDDDD
#define _ALLOCA_S_MARKER_SIZE  16
static inline void *_MarkAllocaS(void *ptr, unsigned int marker) {
    if (ptr) {
        *(unsigned int *)ptr = marker;
        ptr = (char *)ptr + _ALLOCA_S_MARKER_SIZE;
    }
    return ptr;
}
#define _malloca(size)                                                              \
    ((((size) + _ALLOCA_S_MARKER_SIZE) <= _ALLOCA_S_THRESHOLD)                      \
         ? _MarkAllocaS(_alloca((size) + _ALLOCA_S_MARKER_SIZE), _ALLOCA_S_STACK_MARKER) \
         : _MarkAllocaS(malloc((size) + _ALLOCA_S_MARKER_SIZE), _ALLOCA_S_HEAP_MARKER))
static inline void _freea(void *memory) {
    if (memory) {
        memory = (char *)memory - _ALLOCA_S_MARKER_SIZE;
        if (*(unsigned int *)memory == _ALLOCA_S_HEAP_MARKER)
            free(memory);
    }
}
#endif

// Linux allocation introspection: `malloc_usable_size` returns the number
// of usable bytes in an allocation. macOS spells it `malloc_size` in
// <malloc/malloc.h>; Windows spells it `_msize`. Programs that account
// their own heap usage (e.g. a language runtime) reach for it here.
#ifdef __linux__
#pragma binding(libc::malloc_usable_size, "malloc_usable_size")
size_t malloc_usable_size(void *ptr);
// `malloc_trim` releases free heap memory at the top of the arena back to the
// OS (glibc extension); returns nonzero if any memory was released.
#pragma binding(libc::malloc_trim, "malloc_trim")
int malloc_trim(size_t pad);
#endif
