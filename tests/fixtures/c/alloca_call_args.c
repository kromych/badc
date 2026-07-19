/* Calls made after a large alloca: outgoing arguments -- including the
   host-stack overflow beyond the argument-register window -- are staged
   at the moved stack pointer, and the callee reads storage the caller
   carved at runtime. Returns 42. */
#include <alloca.h>

static long sum10(long a, long b, long c, long d, long e, long f, long g, long h, long i, long j) {
    return a + b + c + d + e + f + g + h + i + j;
}

static long fill(char *p, long n, long seed) {
    for (long k = 0; k < n; k += 4096) {
        p[k] = (char)seed;
    }
    p[n - 1] = (char)(seed + 1);
    return p[0] + p[n - 1];
}

int main(void) {
    long n = 1L << 20;
    char *p = (char *)alloca(n);
    long r1 = fill(p, n, 7);
    long r2 = sum10(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
    if (r1 != 15) {
        return 1;
    }
    if (r2 != 55) {
        return 2;
    }
    return 42;
}
