// Constants stored at every width and through every addressing form: a
// pointer with and without a displacement, a subscript, a frame slot, a
// volatile object, a packed member and floating objects. The values are
// the ones whose low bytes differ from the whole (256 into a byte, 0x12345
// into a short), both ends of a sign-extended 32-bit immediate and the
// first values past them, and each store must leave its neighbors intact.
// The exit code names the first check that fails.

#define NOINLINE __attribute__((noinline))

struct fields {
    unsigned char pre;
    unsigned char b;
    unsigned short h;
    unsigned w;
    unsigned long q;
    unsigned char post;
};

struct __attribute__((packed)) packed {
    unsigned char tag;
    long v;
    int w;
};

NOINLINE static void put_fields(struct fields *f) {
    f->b = 256 + 0x7f;
    f->h = 0x12345;
    f->w = 0x80000001u;
    f->q = -2147483647L - 1;
}

NOINLINE static void put_q(unsigned long *p) {
    p[0] = 0x7fffffff;
    p[1] = 0x80000000L;
    p[2] = -2147483647L - 2;
    p[3] = 0;
}

NOINLINE static void put_at(unsigned char *a, long i) { a[i] = 0xc3; }
NOINLINE static void put_at32(int *a, long i) { a[i] = -7; }

NOINLINE static void fill(short *a, int n) {
    for (int i = 0; i < n; i++) a[i] = -300;
}

NOINLINE static void put_volatile(volatile unsigned *r) {
    r[0] = 0xdeadbeefu;
    r[4] = 0;
}

NOINLINE static void put_packed(struct packed *p) {
    p->v = -3;
    p->w = 0x11223344;
}

NOINLINE static void put_float(float *f, double *d) {
    f[0] = 1.5f;
    f[1] = -0.0f;
    d[0] = 0.0;
    d[1] = -0.0;
}

NOINLINE static long both(long *p, long *q) { return *p = *q = 9; }

// A frame slot whose address escapes.
NOINLINE static void touch(long *p) { *p += 1; }
NOINLINE static long slot(void) {
    long t;
    t = -5;
    touch(&t);
    return t;
}

// The branch decides on the value read before the constant store.
NOINLINE static int read_then_clear(char *p, char *q) {
    char c = *p;
    *q = 0;
    if (c) return 1;
    return 0;
}

static unsigned bits32(float v) {
    union { float f; unsigned u; } x;
    x.f = v;
    return x.u;
}

static unsigned long bits64(double v) {
    union { double d; unsigned long u; } x;
    x.d = v;
    return x.u;
}

static int all(const unsigned char *p, int n, unsigned char v) {
    for (int i = 0; i < n; i++)
        if (p[i] != v) return 0;
    return 1;
}

int main(void) {
    struct fields f = {0xaa, 0, 0, 0, 0, 0xbb};
    put_fields(&f);
    if (f.pre != 0xaa || f.post != 0xbb) return 1;
    if (f.b != 0x7f || f.h != 0x2345 || f.w != 0x80000001u) return 2;
    if (f.q != 0xffffffff80000000ul) return 3;

    unsigned long q[5] = {1, 1, 1, 1, 0x55};
    put_q(q);
    if (q[0] != 0x7fffffff || q[1] != 0x80000000ul) return 4;
    if (q[2] != 0xffffffff7ffffffful || q[3] != 0 || q[4] != 0x55) return 5;

    unsigned char bytes[8];
    for (int i = 0; i < 8; i++) bytes[i] = 0xaa;
    volatile long idx = 3;
    put_at(bytes, idx);
    if (bytes[3] != 0xc3 || !all(bytes, 3, 0xaa) || !all(bytes + 4, 4, 0xaa)) return 6;
    int ints[4] = {1, 2, 3, 4};
    put_at32(ints + 2, -idx + 2);
    if (ints[0] != 1 || ints[1] != -7 || ints[2] != 3 || ints[3] != 4) return 7;

    short s[6] = {1, 1, 1, 1, 1, 99};
    fill(s, 5);
    for (int i = 0; i < 5; i++)
        if (s[i] != -300) return 8;
    if (s[5] != 99) return 9;

    unsigned r[6] = {1, 1, 1, 1, 1, 1};
    put_volatile(r);
    if (r[0] != 0xdeadbeefu || r[4] != 0 || r[1] != 1 || r[3] != 1 || r[5] != 1) return 10;

    struct packed pk = {0x77, 0, 0};
    put_packed(&pk);
    if (pk.tag != 0x77 || pk.v != -3 || pk.w != 0x11223344) return 11;

    float fl[3] = {9, 9, 9};
    double db[3] = {9, 9, 9};
    put_float(fl, db);
    if (bits32(fl[0]) != 0x3fc00000u || bits32(fl[1]) != 0x80000000u || fl[2] != 9) return 12;
    if (bits64(db[0]) != 0 || bits64(db[1]) != 0x8000000000000000ul || db[2] != 9) return 13;

    long a = 0, b = 0;
    if (both(&a, &b) != 9 || a != 9 || b != 9) return 14;

    if (slot() != -4) return 15;

    char cell = 5;
    if (!read_then_clear(&cell, &cell) || cell != 0) return 16;
    if (read_then_clear(&cell, &cell)) return 17;
    return 0;
}
