/* A `_Thread_local` initializer reading a `const` slot that holds a function's
 * address gets that function, and a `_Thread_local` slot holds a function's
 * address less more than the function's text offset. Returns 0. */
#include <stdint.h>

typedef long (*fn)(void);

static long first(void) { return 0; }
static long fb(void);
static void *const cp = (void *)fb;
static long fb(void) { return 2; }
static _Thread_local void *tq = cp;
static _Thread_local char *tneg = (char *)fb - 100000;

int main(void) {
    if (first() != 0 || tq != (void *)fb || ((fn)tq)() != 2) {
        return 1;
    }
    return (uintptr_t)fb - (uintptr_t)tneg == 100000 ? 0 : 2;
}
