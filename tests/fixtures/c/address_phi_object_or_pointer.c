/* A load through an address chosen between a frame object and memory
 * elsewhere: a conditional of struct type with an lvalue arm, a pointer
 * local set to a local or to a parameter, the same around a loop, a null
 * pointer the guarded path never reads, and a pointer local carried
 * around a loop that only an unused read takes. `seed` is volatile, so no
 * input is a translation-time constant. */

volatile long seed = 6;

typedef struct {
    unsigned long bits;
} Ref;

static inline Ref borrow(void *p) {
    Ref r = {(unsigned long)p | 1};
    return r;
}

__attribute__((noinline)) unsigned long pick_mem(const Ref *v, int i, int c) {
    Ref r = c ? borrow((void *)8) : v[i];
    return r.bits;
}

__attribute__((noinline)) unsigned long pick_ptr(Ref *v, int c, unsigned long x) {
    Ref a = {x};
    Ref *p = c ? &a : v;
    return p->bits + 1;
}

__attribute__((noinline)) long pick_scalar(long *v, int c, long x) {
    long a = x * 2;
    long *p = c ? &a : v;
    return *p;
}

__attribute__((noinline)) long sum_some(const long *v, int n) {
    long s = 0;
    for (int i = 0; i < n; i++) {
        long d = i * 10;
        const long *p = (i & 1) ? &d : &v[i];
        s += *p;
    }
    return s;
}

/* q is read only where flag is set; with q null and flag clear the load
 * reads the local. */
__attribute__((noinline)) long guarded(const long *q, int flag) {
    long d = seed;
    const long *p = q;
    if (!flag)
        p = &d;
    return *p;
}

/* The read's value is unused and the pointer is read nowhere else, so the
 * pointer's phi at the loop head reads only the phi of the arms; the read
 * through the pointer arm keeps reading the pointer, not the value. */
int keep = 1;
signed char steps;
long target = 3;

__attribute__((noinline)) int unused_read_in_a_loop(void) {
    long *c = &target;
    long d = seed;
    for (; steps <= 1; steps++) {
        if (keep)
            ;
        else
            c = &d;
        *c;
    }
    return steps;
}

int main(void) {
    Ref v[3] = {{10}, {20}, {30}};
    long w[4] = {1, 2, 3, 4};
    if (pick_mem(v, 2, 1) != 9 || pick_mem(v, 2, 0) != 30)
        return 1;
    if (pick_ptr(v, 1, (unsigned long)seed) != 7 || pick_ptr(v, 0, 0) != 11)
        return 2;
    if (pick_scalar(w, 1, seed) != 12 || pick_scalar(w, 0, seed) != 1)
        return 3;
    if (sum_some(w, 4) != 1 + 10 + 3 + 30)
        return 4;
    if (guarded(0, 0) != seed || guarded(w, 1) != 1)
        return 5;
    if (unused_read_in_a_loop() != 2)
        return 6;
    return 0;
}
