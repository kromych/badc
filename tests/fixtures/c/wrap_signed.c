// snapshot-flags: -fwrapv
// Under -fwrapv signed arithmetic wraps at its width, so -O keeps every
// renormalization a wrapped result needs: each counter or sum below leaves
// `int`, and the expected values are the wrapped results in 64-bit
// arithmetic. Without the flag each check overflows, which C99 6.5p5
// leaves undefined. The exit code names the first check that fails.

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

// A sum that wraps to zero is zero: the 32-bit test of it must not become
// a test of the whole register.
NOINLINE static int sum_nonzero(int a, int b) {
    if ((a + b) != 0) return 1;
    return 0;
}

// A pre-increment, a compound step and a negation that wrap in the
// register a full-width reader then reads.
NOINLINE static long pre_inc(int i) { return ++i; }
NOINLINE static long step_by(int i, int k) { i += k; return i; }
NOINLINE static long neg(int i) { return -i; }

int main(void) {
    volatile int vmax = MAX, vmin = MIN;
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

    // c=1: i=MAX-1; c=2: s=MAX-1, i wraps to MIN; c=3: i=MIN+1;
    // c=4: s+=MIN+1, i=MIN+3; c=5 breaks.
    if (two_back_edges(vmax - 2, vmax, 5, &last) != -1L) return 8;
    if (last != MIN + 3) return 9;

    if (other_guard(vmax, 0) != (long)MIN) return 10;
    if (guard_then_join(vmax) != (long)MIN) return 11;

    if (sum_nonzero(vmin, vmin) != 0) return 12;
    if (sum_nonzero(vmax, 1) != 1) return 13;

    if (pre_inc(vmax) != (long)MIN) return 14;
    if (step_by(vmax, 2) != (long)MIN + 1) return 15;
    if (neg(vmin) != (long)MIN) return 16;
    return 0;
}
