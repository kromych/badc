// malloc_size reports a heap block's usable size, which is at least the
// requested size. It exists in macOS libSystem (<malloc/malloc.h>); the
// Linux equivalent is malloc_usable_size and Windows is _msize.

#ifndef __APPLE__
int main(void) { return 0; }
#else
#include <malloc/malloc.h>
#include <stdlib.h>

int main(void) {
    void *p = malloc(100);
    if (!p) return 1;
    size_t s = malloc_size(p);
    free(p);
    return (s >= 100) ? 0 : 2;
}
#endif
