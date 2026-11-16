// A vector written lane by lane keeps every lane its stores do not write,
// and a read between two lane stores sees the vector as it stood; one whose
// stores write every lane holds just those values. A brace initializer
// that names every member stores them, and one that leaves a member out
// zeroes it (C17 6.7.9p21), a pointer member covering the pointer's bytes
// alone, whatever it points to. Returns 0 when every check passes; each failure
// returns a distinct code.

typedef int i4 __attribute__((vector_size(16)));
typedef unsigned char u8x16 __attribute__((vector_size(16)));

struct P {
    int a, b;
};
struct Q {
    int a, b, c;
};

__attribute__((noinline)) i4 partial(i4 v, int a) {
    v[1] = a;
    v[3] = a;
    return v;
}

__attribute__((noinline)) i4 read_between(i4 v, int a, int *seen) {
    v[0] = a;
    *seen = v[2];
    v[1] = a;
    v[2] = a;
    v[3] = a;
    return v;
}

__attribute__((noinline)) i4 full(int a, int b, int c, int d) {
    i4 v;
    v[0] = a;
    v[1] = b;
    v[2] = c;
    v[3] = d;
    return v;
}

__attribute__((noinline)) u8x16 bytes(const unsigned char *p) {
    u8x16 r;
    for (int i = 0; i < 16; i++)
        r[i] = p[i];
    return r;
}

struct Big {
    long a[32];
};
struct Ctx {
    struct Big *p;
    long x[4];
};

__attribute__((noinline)) void dirty(void) {
    volatile long junk[64];
    for (int i = 0; i < 64; i++)
        junk[i] = -1;
}

__attribute__((noinline)) long pointer_member(struct Big *b) {
    struct Ctx c = {.p = b};
    return c.x[0] | c.x[1] | c.x[2] | c.x[3];
}

__attribute__((noinline)) void put2(struct P *o, int a, int b) { *o = (struct P){a, b}; }
__attribute__((noinline)) void put3(struct Q *o, int a) { *o = (struct Q){a}; }

int main(void) {
    volatile int k = 7;
    i4 base = {10, 20, 30, 40};
    i4 p = partial(base, k);
    if (p[0] != 10 || p[1] != 7 || p[2] != 30 || p[3] != 7)
        return 1;
    int seen = 0;
    i4 r = read_between(base, k, &seen);
    if (seen != 30 || r[0] != 7 || r[1] != 7 || r[2] != 7 || r[3] != 7)
        return 2;
    i4 f = full(k, k + 1, k + 2, k + 3);
    if (f[0] != 7 || f[1] != 8 || f[2] != 9 || f[3] != 10)
        return 3;
    unsigned char src[16];
    for (int i = 0; i < 16; i++)
        src[i] = (unsigned char)(i * 13 + k);
    u8x16 b = bytes(src);
    for (int i = 0; i < 16; i++)
        if (b[i] != src[i])
            return 4;
    struct P pp = {1, 1};
    put2(&pp, k, -k);
    if (pp.a != 7 || pp.b != -7)
        return 5;
    struct Q q = {1, 2, 3};
    put3(&q, k);
    if (q.a != 7 || q.b != 0 || q.c != 0)
        return 6;
    static struct Big big;
    dirty();
    if (pointer_member(&big) != 0)
        return 7;
    return 0;
}
