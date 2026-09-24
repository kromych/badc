// Unsigned 32-bit arithmetic wraps (C99 6.2.5p9), and -O removes a
// renormalization only where its upper half is unread or where the value's
// range shows it is the identity. Each function below puts a counter or a
// sum at the edge where one of those two arguments stops holding; the
// expected values are the wrapped results in 64-bit arithmetic, and the
// exit code names the first check that fails. The signed values here stay
// inside `int`; wrap_signed.c runs the ones that leave it, under -fwrapv.

#define NOINLINE __attribute__((noinline))

#define MAX 2147483647
#define MIN (-MAX - 1)

// A decreasing counter under `i >= 0` stays inside `int`: -1 ends it.
NOINLINE static long count_down(const int *a, int from) {
    long s = 0;
    for (int i = from; i >= 0; i--) s += a[i];
    return s;
}

// The guard on `i` ends at the join; `i + 1` after it is unguarded.
NOINLINE static long guard_then_join(int i) {
    long s = 0;
    if (i < 100) s = 1;
    s += (long)(i + 1);
    return s;
}

// Under the guard `i + 1` is inside `int`.
NOINLINE static long guarded(int i) {
    long s = 0;
    if (i < 100) s += (long)(i + 1);
    return s;
}

// An unsigned counter wraps at 2^32.
NOINLINE static unsigned long uwrap(unsigned start) {
    unsigned long s = 0;
    for (unsigned i = start; i != 2; i++) s += i;
    return s;
}

// The unsigned sum wraps to 1; each reader below sees bits 32..63.
NOINLINE static unsigned long as_ulong(unsigned a, unsigned b) { return a + b; }
NOINLINE static unsigned shr4(unsigned a, unsigned b) { return (a + b) >> 4; }
NOINLINE static unsigned div3(unsigned a, unsigned b) { return (a + b) / 3u; }
NOINLINE static unsigned divv(unsigned a, unsigned b, unsigned d) { return (a + b) / d; }
NOINLINE static unsigned modv(unsigned a, unsigned b, unsigned d) { return (a + b) % d; }
NOINLINE static int less64(unsigned a, unsigned b, long c) { return (long)(a + b) < c; }
NOINLINE static void store8(unsigned a, unsigned b, unsigned long *p) { *p = a + b; }
NOINLINE static unsigned long pass(unsigned long x) { return x; }
NOINLINE static unsigned long as_arg(unsigned a, unsigned b) { return pass(a + b); }
NOINLINE static long index_of(const long *t, unsigned a, unsigned b) { return t[a + b]; }
NOINLINE static double as_double(unsigned a, unsigned b) { return (double)(a + b); }

// A sum that wraps to zero is zero: the 32-bit test of it must not become
// a test of the whole register.
NOINLINE static int usum_nonzero(unsigned a, unsigned b) {
    if (a + b) return 1;
    return 0;
}
NOINLINE static int diff_zero(int a, int b) { return (a - b) == 0 ? 7 : 9; }

int main(void) {
    volatile int vmax = MAX, vmin = MIN;
    volatile unsigned umax = 0xffffffffu, uhalf = 0x80000000u;

    static const int a[4] = {1, 20, 300, 4000};
    if (count_down(a, 3) != 4321) return 8;
    if (count_down(a, -1) != 0) return 9;

    if (guard_then_join(5) != 7) return 14;
    if (guarded(99) != 100 || guarded(vmin) != (long)MIN + 1 || guarded(vmax) != 0) return 15;

    // 0xfffffffe, 0xffffffff, 0, 1.
    if (uwrap(umax - 1) != 0x1fffffffeUL) return 16;

    if (as_ulong(umax, 2) != 1UL) return 17;
    if (shr4(umax, 2) != 0) return 18;
    if (div3(umax, 2) != 0) return 19;
    if (divv(umax, 2, 3) != 0) return 20;
    if (modv(umax, 8, 5) != 2) return 21;
    if (less64(umax, 2, 2) != 1) return 22;
    unsigned long cell = ~0UL;
    store8(umax, 2, &cell);
    if (cell != 1UL) return 23;
    if (as_arg(umax, 2) != 1UL) return 24;
    static const long t[2] = {11, 22};
    if (index_of(t, umax, 2) != 22) return 25;
    if (as_double(umax, 2) != 1.0) return 26;

    if (usum_nonzero(uhalf, uhalf) != 0) return 29;
    if (usum_nonzero(uhalf, 1) != 1) return 30;
    if (diff_zero(vmin, vmin) != 7 || diff_zero(vmin, 0) != 9) return 31;
    return 0;
}
