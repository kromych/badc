/* Returns from frames whose stack pointer moves at run time -- a VLA, an
   over-aligned automatic object (C11 6.7.5), far locals beside an alloca --
   with and without callee-saved registers of their own to restore, on
   every return path. The caller keeps eight values live across each call.
   Returns 0 when the values and the results survive. */

static volatile long seed = 6;

__attribute__((noinline)) static void touch(volatile char *p, long v) { p[0] = (char)v; }

/* Nothing to restore; two returns. */
__attribute__((noinline)) static long vla_plain(long n) {
    char a[n];
    if (n > 9) {
        touch(a, 1);
        return 1;
    }
    touch(a, 2);
    return 2;
}

/* Over-aligned, nothing to restore. */
__attribute__((noinline)) static long realigned_plain(void) {
    _Alignas(64) char b[64];
    touch(b, 3);
    return ((unsigned long)(void *)b & 63u) == 0 ? 3 : 100;
}

/* Values live across the calls: registers to restore, two returns. */
__attribute__((noinline)) static long vla_saves(long n) {
    char a[n];
    long x = n * 3, y = n * 5;
    touch(a, 4);
    if (n == 7) return x + a[0];
    touch(a, 5);
    return x * y + a[0];
}

/* Over-aligned, with registers to restore. */
__attribute__((noinline)) static long realigned_saves(long n) {
    _Alignas(64) char b[64];
    long x = n * 7, y = n * 11;
    touch(b, 6);
    return x + y + b[0] + (((unsigned long)(void *)b & 63u) == 0 ? 0 : 1000);
}

/* Far locals beside an alloca, ten values across the calls. */
__attribute__((noinline)) static long far_alloca(long n) {
    volatile char pad[4096];
    char *q = (char *)__builtin_alloca(n);
    long a0 = n * 3, a1 = n * 5, a2 = n * 7, a3 = n * 11, a4 = n * 13, a5 = n * 17, a6 = n * 19,
         a7 = n * 23, a8 = n * 29, a9 = n * 31;
    pad[0] = 1;
    touch(q, 7);
    if (n == 5) return a0 + a1 + a2 + a3 + a4 + pad[0] + q[0];
    touch(pad, 1);
    return a0 * a1 + a2 * a3 + a4 * a5 + a6 * a7 + a8 * a9 + pad[0] + q[0];
}

/* A frame small enough to fold its saves into the frame allocation, with
   locals past the frame pointer's unscaled reach beside an alloca. */
__attribute__((noinline)) static long folded_far(long n) {
    volatile char pad[300];
    char *q = (char *)__builtin_alloca(n);
    long x = n * 3, y = n * 5;
    pad[0] = 1;
    pad[1] = 2;
    touch(q, 7);
    touch(pad, 9);
    if (n == 4) return x + pad[0] + pad[1] + q[0];
    touch(pad + 1, 3);
    return x * y + pad[0] + pad[1] + q[0];
}

static volatile long k[8] = {101, 103, 107, 109, 113, 127, 131, 137};

int main(void) {
    long n = seed;
    long c0 = n * k[0], c1 = n * k[1], c2 = n * k[2], c3 = n * k[3], c4 = n * k[4],
         c5 = n * k[5], c6 = n * k[6], c7 = n * k[7];
    long r = vla_plain(n);
    r += vla_plain(n + 5);
    r += realigned_plain();
    r += vla_saves(n + 1);
    r += vla_saves(n);
    r += realigned_saves(n);
    r += far_alloca(n - 1);
    r += far_alloca(n);
    r += folded_far(n - 1);
    r += folded_far(n - 2);
    if (c0 != n * k[0] || c1 != n * k[1] || c2 != n * k[2] || c3 != n * k[3]) return 1;
    if (c4 != n * k[4] || c5 != n * k[5] || c6 != n * k[6] || c7 != n * k[7]) return 2;
    /* 2 + 1 + 3 + 25 + 545 + 114 + 203 + 59372 + 394 + 30 */
    return r == 60689 ? 0 : 3;
}
