/* <mm_malloc.h> defines _mm_malloc and _mm_free under names a C library
 * header may already have made macros of, as the UCRT's <malloc.h> maps
 * them onto _aligned_malloc and _aligned_free. The macros keep their
 * meaning at a call, the header's functions stay reachable by the
 * parenthesized name, and neither definition takes the macro's target as
 * its own name. A target whose toolchain ships no <mm_malloc.h> (gcc's
 * aarch64 Linux) has nothing to check and returns 42. */
#include <stddef.h>

#if __has_include(<mm_malloc.h>)

static int routed;

static void *route_alloc(size_t size, size_t align) {
    routed++;
    (void)size;
    (void)align;
    return (void *)0;
}

static void route_free(void *p) {
    (void)p;
    routed++;
}

#define _mm_malloc(a, b) route_alloc(a, b)
#define _mm_free(a) route_free(a)
#include <mm_malloc.h>

int main(void) {
    if (_mm_malloc(64, 16) != 0)
        return 1;
    _mm_free((void *)0);
    if (routed != 2)
        return 2;
    void *p = (_mm_malloc)(64, 32);
    if (p == 0 || ((size_t)p & 31) != 0)
        return 3;
    (_mm_free)(p);
    if (routed != 2)
        return 4;
    return 42;
}
#else
int main(void) {
    return 42;
}
#endif
