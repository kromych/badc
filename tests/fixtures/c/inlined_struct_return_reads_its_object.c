// An inlined function returning a struct from two `return` statements
// hands its caller the address of the object each one names; the caller's
// copy reads the object that return wrote, on a straight path and around a
// loop. Returns 0 when every result matches.

typedef struct {
    unsigned long bits;
} Ref;

static inline Ref take(unsigned long *p) {
    if (*p & 1) {
        Ref r = {(unsigned long)p | 1};
        return r;
    }
    ++*p;
    Ref r = {(unsigned long)p};
    return r;
}

__attribute__((noinline)) static unsigned long pair(unsigned long *p, unsigned long *q) {
    Ref a = take(p);
    Ref b = take(q);
    return a.bits ^ b.bits;
}

__attribute__((noinline)) static unsigned long walk(unsigned long *v, int n) {
    unsigned long s = 0;
    for (int i = 0; i < n; i++) {
        Ref r = take(&v[i]);
        s += r.bits - (unsigned long)&v[i];
    }
    return s;
}

int main(void) {
    unsigned long v[4] = {1, 2, 3, 4};
    if (pair(&v[0], &v[1]) != (((unsigned long)&v[0] | 1) ^ (unsigned long)&v[1]))
        return 1;
    if (v[0] != 1 || v[1] != 3)
        return 2;
    if (walk(v, 4) != 1 + 1 + 1 + 0)
        return 3;
    if (v[0] != 1 || v[1] != 3 || v[2] != 3 || v[3] != 5)
        return 4;
    return 0;
}
