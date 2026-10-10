/* A dynamic frame (alloca) whose scalar locals lie past the fp
   unscaled reach: the base register captured after the prologue
   addresses them with one scaled-offset instruction per access, where
   the fp form would build the address first. Returns 0 when the
   values round-trip. */
#include <alloca.h>

static long use(void *p, long n) {
    (void)p;
    return n * 2;
}

int main(void) {
    volatile char pad[4096];
    pad[0] = 1;
    volatile long v = 0, w = 1, d = 2;
    char *q = (char *)__builtin_alloca(64);
    q[0] = 3;
    v += use((void *)pad, w + d);
    w += v;
    d += w;
    if (pad[0] != 1) return 1;
    if (q[0] != 3) return 2;
    return (int)(v + w + d - 22);
}
