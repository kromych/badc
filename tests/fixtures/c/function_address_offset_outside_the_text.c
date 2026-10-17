/* A function's address plus an offset that leaves the code -- below its
 * start by more than its own offset, or far past the image -- is the address
 * plus the offset. Returns 0. */
#include <stdint.h>

static long f(void) { return 1; }

static char *neg = (char *)f - 100000;
static char *neg1 = (char *)f - 1;
static char *mid = (char *)f + 0x10000000;
static char *far = (char *)f + 0x100000000000;

int main(void) {
    uintptr_t a = (uintptr_t)f;
    if (a - (uintptr_t)neg != 100000 || a - (uintptr_t)neg1 != 1) {
        return 1;
    }
    if ((uintptr_t)mid - a != 0x10000000 || (uintptr_t)far - a != 0x100000000000) {
        return 2;
    }
    return f() == 1 ? 0 : 3;
}
