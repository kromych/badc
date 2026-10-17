/* GNU C arithmetic on a function's address counts bytes, whatever the
 * function returns: `&g + 1`, `&g - 2`, `g + 3` and `3 + g`, in an
 * initializer and at run time, with the integer on either side of a cast
 * address or a library function's. Returns 0. */
#include <stdint.h>
#include <string.h>

static long first(void) { return 0; }
static long g(void) { return 1; }
static long after(void);

static void *a1 = &g + 1;
static void *a2 = &g - 2;
static void *a3 = &g + 3;
static long (*a4)(void) = &g + 1;
static void *n1 = &after - 2;
static void *f3 = g + 3;
static void *f3r = 3 + g;
static char *m4 = -4 + (char *)g;
static char *p6 = ((char *)g) + 6;
static void *s0 = strlen + 0;
static void *s4 = strlen + 4;

static long after(void) { return 2; }

#define D(p, f) ((long)((uintptr_t)(p) - (uintptr_t)(f)))

int main(void) {
    void *rt = &g + 1;
    if (D(a1, g) != 1 || D(a2, g) != -2 || D(a3, g) != 3 || D(a4, g) != 1 || D(rt, g) != 1) {
        return 1;
    }
    if (D(n1, after) != -2 || D(f3, g) != 3 || D(f3r, g) != 3) {
        return 2;
    }
    if (D(m4, g) != -4 || D(p6, g) != 6 || D(s4, s0) != 4) {
        return 3;
    }
    return first() + g() + after() == 3 ? 0 : 4;
}
