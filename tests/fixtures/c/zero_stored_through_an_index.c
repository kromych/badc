/* A constant zero stored at every width, through an index scaled by the
 * element, through a pointer, into fields and into a frame array. Each
 * store takes the zero from its own encoding, a store immediate or the
 * zero register, and no register holds it: a call ahead of each store
 * leaves another value in the registers a stale zero would come from. */

struct mix {
    double d;
    float f;
    long l;
    int i;
    short h;
    char c;
};

__attribute__((noinline)) void index_double(double *a, long i) { a[i] = 0.0; }
__attribute__((noinline)) void index_float(float *a, long i) { a[i] = 0.0f; }
__attribute__((noinline)) void index_long(long *a, long i) { a[i] = 0; }
__attribute__((noinline)) void index_int(int *a, long i) { a[i] = 0; }
__attribute__((noinline)) void through_double(double *a) { *a = 0.0; }
__attribute__((noinline)) void through_float(float *a) { *a = 0.0f; }

__attribute__((noinline)) void fields(struct mix *m) {
    m->d = 0.0;
    m->f = 0.0f;
    m->l = 0;
    m->i = 0;
    m->h = 0;
    m->c = 0;
}

__attribute__((noinline)) double frame_array(long i) {
    volatile double v[4] = {1, 2, 3, 4};
    v[i] = 0.0;
    return v[i];
}

/* Leaves its arguments in the argument registers. */
__attribute__((noinline)) long spread(long a, long b, long c) { return a + b + c; }

int main(void) {
    double d[4] = {1, 2, 3, 4};
    float f[4] = {1, 2, 3, 4};
    long l[4] = {1, 2, 3, 4};
    int n[4] = {1, 2, 3, 4};
    struct mix m = {1, 1, 1, 1, 1, 1};
    spread(1, 2, 0x4045000000000000L);
    index_double(d, 2);
    if (d[2] != 0.0)
        return 1;
    spread(1, 2, 0x42280000L);
    index_float(f, 1);
    if (f[1] != 0.0f)
        return 2;
    spread(1, 2, 77);
    index_long(l, 3);
    if (l[3] != 0)
        return 3;
    spread(1, 2, 77);
    index_int(n, 0);
    if (n[0] != 0)
        return 4;
    spread(0x4045000000000000L, 2, 3);
    through_double(&d[0]);
    if (d[0] != 0.0)
        return 5;
    spread(0x42280000L, 2, 3);
    through_float(&f[0]);
    if (f[0] != 0.0f)
        return 6;
    spread(0x4045000000000000L, 2, 77);
    fields(&m);
    if (m.d != 0.0 || m.f != 0.0f || m.l || m.i || m.h || m.c)
        return 7;
    spread(1, 0x4045000000000000L, 3);
    if (frame_array(1) != 0.0)
        return 8;
    return 0;
}
