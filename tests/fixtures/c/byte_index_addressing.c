// One-byte accesses addressed as base + index, and the reuse of an
// element already read or written: signed and unsigned elements at the
// values where their extensions differ, negative indices through a
// pointer into the middle of an array, and every kind of write that can
// reach the element between two reads of it. The exit code names the
// first check that fails.

#define NOINLINE __attribute__((noinline))

// An index the compiler cannot know: constant arguments would otherwise
// turn each subscript into a fixed displacement.
static volatile int zero;
#define RT(k) ((k) + zero)

struct blk {
    unsigned char b[8];
};

NOINLINE static int get_s(const signed char *p, int i) { return p[i]; }
NOINLINE static int get_u(const unsigned char *p, int i) { return p[i]; }
NOINLINE static int get_long(const signed char *p, long i) { return p[i]; }
NOINLINE static int get_unsigned(const unsigned char *p, unsigned i) { return p[i]; }
NOINLINE static int get_reversed(const unsigned char *p, int i) { return i[p]; }
NOINLINE static void put(signed char *p, int i, int v) { p[i] = (signed char)v; }

// The second read is the first one's value.
NOINLINE static int twice_s(const signed char *p, int i) { return p[i] * 1000 + p[i]; }

// The reads after the stores take the stored value at the element's width.
NOINLINE static int stored_s(signed char *p, int i, int v) {
    p[i] = (signed char)v;
    return p[i];
}
NOINLINE static int stored_u(unsigned char *p, int i, int v) {
    p[i] = (unsigned char)v;
    return p[i];
}

// `*q` names `a[i]`.
NOINLINE static int across_pointer(signed char *a, int i, signed char *q) {
    int x = a[i];
    *q = 7;
    return x * 100 + a[i];
}

// `b[j]` names `a[i]` through another base and another index.
NOINLINE static int across_index(unsigned char *a, int i, unsigned char *b, int j) {
    int x = a[i];
    b[j] = 9;
    return x * 100 + a[i];
}

// Same base, an index of another value id holding the same number.
NOINLINE static int across_equal_index(unsigned char *a, int i, int j) {
    int x = a[i];
    a[j] = 11;
    return x * 100 + a[i];
}

NOINLINE static void bump(unsigned char *a, int i) { a[i]++; }

NOINLINE static int across_call(unsigned char *a, int i) {
    int x = a[i];
    bump(a, i);
    return x * 100 + a[i];
}

NOINLINE static int across_copy(struct blk *d, const struct blk *s, int i) {
    int x = d->b[i];
    *d = *s;
    return x * 100 + d->b[i];
}

NOINLINE static int across_volatile(unsigned char *a, int i, volatile unsigned char *v) {
    int x = a[i];
    *v = 3;
    return x * 100 + a[i];
}

// A word store over the element.
NOINLINE static int across_word(unsigned char *a, int i, int *w) {
    int x = a[i];
    *w = 0x05050505;
    return x * 100 + a[i];
}

NOINLINE static long count_zero(const char *p, int n) {
    long c = 0;
    for (int i = 0; i < n; i++) {
        if (!p[i]) c++;
    }
    return c;
}

NOINLINE static void mark(char *p, int i, int n) {
    for (int j = i * i; j < n; j += i) p[j] = 1;
}

int main(void) {
    static signed char sc[16];
    static unsigned char uc[16];
    static char flags[64];

    for (int k = 0; k < 16; k++) {
        sc[k] = (signed char)(k * 17 - 128);
        uc[k] = (unsigned char)(k * 17 + 120);
    }
    // -128, -1 and 127 sit at 0, 15 (k * 17 - 128 = 127) and the rewritten 8.
    sc[8] = -1;
    if (get_s(sc, RT(0)) != -128 || get_s(sc, RT(8)) != -1 || get_s(sc, RT(15)) != 127) return 1;
    if (get_u(uc, RT(0)) != 120 || get_u(uc, RT(8)) != 0 || get_u(uc, RT(7)) != 239) return 2;

    if (get_s(sc + 8, RT(-8)) != -128 || get_s(sc + 8, RT(0)) != -1 || get_s(sc + 8, RT(7)) != 127) return 3;
    if (get_u(uc + 8, RT(-1)) != 239 || get_u(uc + 16, RT(-16)) != 120) return 4;
    if (get_long(sc + 8, RT(-8L)) != -128 || get_long(sc, RT(15L)) != 127) return 5;
    if (get_unsigned(uc, (unsigned)RT(7)) != 239 || get_reversed(uc + 8, RT(-1)) != 239) return 6;

    put(sc + 8, RT(-3), -77);
    if (sc[5] != -77 || get_s(sc, RT(5)) != -77) return 7;
    if (twice_s(sc, RT(5)) != -77 * 1000 - 77) return 8;

    if (stored_s(sc, RT(2), 200) != -56 || sc[2] != -56) return 9;
    if (stored_u(uc, RT(2), 300) != 44 || uc[2] != 44) return 10;
    if (stored_s(sc + 8, RT(-6), -129) != 127 || sc[2] != 127) return 11;

    sc[4] = 50;
    if (across_pointer(sc, RT(4), sc + 4) != 50 * 100 + 7) return 12;
    sc[4] = 50;
    if (across_pointer(sc + 8, RT(-4), sc + 4) != 50 * 100 + 7) return 13;
    uc[6] = 60;
    if (across_index(uc, RT(6), uc + 9, RT(-3)) != 60 * 100 + 9) return 14;
    uc[6] = 60;
    if (across_index(uc, RT(6), uc, RT(5)) != 60 * 100 + 60) return 15;
    uc[6] = 60;
    if (across_equal_index(uc, RT(6), RT(6)) != 60 * 100 + 11) return 16;
    uc[6] = 60;
    if (across_equal_index(uc, RT(6), RT(7)) != 60 * 100 + 60) return 17;
    uc[6] = 255;
    if (across_call(uc, RT(6)) != 255 * 100 + 0) return 18;

    struct blk d = {{1, 2, 3, 4, 5, 6, 7, 8}};
    struct blk s = {{11, 12, 13, 14, 15, 16, 17, 18}};
    if (across_copy(&d, &s, RT(3)) != 4 * 100 + 14) return 19;

    uc[6] = 60;
    if (across_volatile(uc, RT(6), uc + 6) != 60 * 100 + 3) return 20;
    int word = 0;
    unsigned char *wb = (unsigned char *)&word;
    wb[1] = 60;
    if (across_word(wb, RT(1), &word) != 60 * 100 + 5) return 21;

    flags[0] = 1;
    flags[1] = 1;
    for (int i = 2; i * i < 64; i++)
        if (!flags[i]) mark(flags, i, RT(64));
    if (count_zero(flags, RT(64)) != 18 || count_zero(flags, RT(0)) != 0) return 22;
    return 0;
}
