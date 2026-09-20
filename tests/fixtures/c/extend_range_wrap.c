// Signed and unsigned 32-bit arithmetic wraps (the front end renormalizes
// every result to its width), and -O removes a renormalization only where
// its upper half is unread or where the value's range shows it is the
// identity. Each function below puts a counter or a sum at the edge where
// one of those two arguments stops holding; the expected values are the
// wrapped results in 64-bit arithmetic, and the exit code names the first
// check that fails.

#define NOINLINE __attribute__((noinline))

#define MAX 2147483647
#define MIN (-MAX - 1)

// `i > 0` bounds `i` from below only: the increment leaves `int` at MAX
// and the loop ends on the wrapped value.
NOINLINE static long wrap_up(int start, int *trips) {
    long s = 0;
    int n = 0;
    for (int i = start; i > 0; i++) {
        s += i;
        n++;
    }
    *trips = n;
    return s;
}

// `i <= n` with n == MAX never bounds `i + 1` inside `int`.
NOINLINE static long le_max(int start, int n, int limit) {
    long s = 0;
    int c = 0;
    for (int i = start; i <= n; i++) {
        s += i;
        if (++c == limit) break;
    }
    return s;
}

// A disequality is no ordering: the counter passes through the wrap.
NOINLINE static long ne_bound(int start, int n) {
    long s = 0;
    for (int i = start; i != n; i++) s += i;
    return s;
}

// A step that is not a constant can carry `i < n` past MAX.
NOINLINE static long step_var(int start, int n, int k, int limit) {
    long s = 0;
    int c = 0;
    for (int i = start; i < n; i += k) {
        s += i;
        if (++c == limit) break;
    }
    return s;
}

// A decreasing counter under `i < 0` wraps from MIN to MAX.
NOINLINE static long wrap_down(int start, int *trips) {
    long s = 0;
    int n = 0;
    for (int i = start; i < 0; i--) {
        s += i;
        n++;
    }
    *trips = n;
    return s;
}

// A decreasing counter under `i >= 0` stays inside `int`: -1 ends it.
NOINLINE static long count_down(const int *a, int from) {
    long s = 0;
    for (int i = from; i >= 0; i--) s += a[i];
    return s;
}

// Two back edges: the increment by one is under the guard, the
// increment by two leaves `int` from MAX - 1.
NOINLINE static long two_back_edges(int start, int n, int limit, int *last) {
    long s = 0;
    int c = 0;
    int i = start;
    while (i < n) {
        if (++c == limit) break;
        if (c & 1) {
            i += 1;
            continue;
        }
        s += i;
        i += 2;
    }
    *last = i;
    return s;
}

// The guard is on `j`; it says nothing about `i + 1`.
NOINLINE static long other_guard(int i, int j) {
    long s = 0;
    if (j < 100) s += (long)(i + 1);
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
NOINLINE static int sum_nonzero(int a, int b) {
    if ((a + b) != 0) return 1;
    return 0;
}
NOINLINE static int usum_nonzero(unsigned a, unsigned b) {
    if (a + b) return 1;
    return 0;
}
NOINLINE static int diff_zero(int a, int b) { return (a - b) == 0 ? 7 : 9; }

int main(void) {
    volatile int vmax = MAX, vmin = MIN;
    volatile unsigned umax = 0xffffffffu, uhalf = 0x80000000u;
    int trips = 0, last = 0;

    // MAX-2, MAX-1, MAX, then MIN ends the loop.
    if (wrap_up(vmax - 2, &trips) != 3L * MAX - 3) return 1;
    if (trips != 3) return 2;

    // MAX-1, MAX, MIN, MIN+1.
    if (le_max(vmax - 1, vmax, 4) != -2L) return 3;
    if (ne_bound(vmax - 1, vmin + 2) != -2L) return 4;

    // MAX-5, MAX-1, MIN+2.
    if (step_var(vmax - 5, vmax, 4, 3) != (long)MAX - 5) return 5;

    // MIN+1, MIN, then MAX ends the loop.
    if (wrap_down(vmin + 1, &trips) != 2L * MIN + 1) return 6;
    if (trips != 2) return 7;

    static const int a[4] = {1, 20, 300, 4000};
    if (count_down(a, 3) != 4321) return 8;
    if (count_down(a, -1) != 0) return 9;

    // c=1: i=MAX-1; c=2: s=MAX-1, i wraps to MIN; c=3: i=MIN+1;
    // c=4: s+=MIN+1, i=MIN+3; c=5 breaks.
    if (two_back_edges(vmax - 2, vmax, 5, &last) != -1L) return 10;
    if (last != MIN + 3) return 11;

    if (other_guard(vmax, 0) != (long)MIN) return 12;
    if (guard_then_join(vmax) != (long)MIN) return 13;
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

    if (sum_nonzero(vmin, vmin) != 0) return 27;
    if (sum_nonzero(vmax, 1) != 1) return 28;
    if (usum_nonzero(uhalf, uhalf) != 0) return 29;
    if (usum_nonzero(uhalf, 1) != 1) return 30;
    if (diff_zero(vmin, vmin) != 7 || diff_zero(vmin, 0) != 9) return 31;
    return 0;
}
