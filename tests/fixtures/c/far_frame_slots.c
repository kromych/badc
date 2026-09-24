// Automatic objects laid out past a large aggregate, more than 4 KiB below
// the frame pointer, and in a frame past the 32 KiB an 8-byte access
// reaches from sp. Scalars of every width are stored, reloaded and passed
// by address; a call with stack arguments returns an aggregate through a
// far result temp, and another returns one in registers into a far temp;
// one function also calls alloca, so sp moves in its body. Exits 0 when
// every check holds, a distinct code per failure.
#include <stddef.h>

struct row { long long a, b, c, d, e, f, g, h; };
struct block { struct row r0, r1, r2, r3, r4, r5, r6, r7; };
struct page { struct block b0, b1, b2, b3, b4, b5, b6, b7; };
struct book { struct page p0, p1, p2, p3, p4, p5, p6, p7; };
struct five { long long v0, v1, v2, v3, v4; };
struct two { long long lo, hi; };

static volatile int input = 7;

__attribute__((noinline)) static void fill(void *p, size_t n, int s) {
    unsigned char *b = p;
    for (size_t i = 0; i < n; i++)
        b[i] = (unsigned char)(s + i);
}

__attribute__((noinline)) static void bump(long long *p) { *p += 11; }

__attribute__((noinline)) static struct five make(long long a, long long b, long long c,
                                                   long long d, long long e, long long f,
                                                   long long g, long long h, long long i,
                                                   long long j) {
    struct five r = {a + b, c + d, e + f, g + h, i + j};
    return r;
}

__attribute__((noinline)) static struct two pair(long long x) {
    struct two r = {x, x * 3};
    return r;
}

static long long row_sum(const struct row *r) {
    return r->a + r->b + r->c + r->d + r->e + r->f + r->g + r->h;
}

/* Scalars 4 KiB below fp in a frame whose sp does not move. */
__attribute__((noinline)) static int fixed(int s) {
    struct page pg;
    volatile signed char c = (signed char)(s - 100);
    volatile short h = (short)(s * -300);
    volatile int i = s * 100000;
    volatile long long l = (long long)s * 0x100000001LL;
    volatile float f = (float)s * 0.5f;
    volatile double d = (double)s * 0.25;
    volatile long double e = (long double)s * 1.5;
    long long taken = s;
    fill(&pg, sizeof pg, s);
    bump(&taken);
    c += 1;
    h -= 2;
    i ^= 0x55;
    l += row_sum(&pg.b3.r5);
    f += 1.0f;
    d *= 3.0;
    e -= 0.5;
    if (c != (signed char)(s - 99))
        return 1;
    if (h != (short)(s * -300 - 2))
        return 2;
    if (i != ((s * 100000) ^ 0x55))
        return 3;
    unsigned char *b = (unsigned char *)&pg.b3.r5;
    long long want = 0;
    for (int k = 0; k < 8; k++) {
        long long word = 0;
        for (int j = 7; j >= 0; j--)
            word = (word << 8) | b[k * 8 + j];
        want += word;
    }
    if (l != (long long)s * 0x100000001LL + want)
        return 4;
    if (f != (float)s * 0.5f + 1.0f)
        return 5;
    if (d != (double)s * 0.75)
        return 6;
    if (taken != s + 11)
        return 7;
    if (e != (long double)s * 1.5 - 0.5)
        return 8;
    return 0;
}

/* The same objects with alloca moving sp. */
__attribute__((noinline)) static int moving(int s) {
    struct page pg;
    volatile int i = s * 3;
    volatile long long l = (long long)s << 40;
    volatile double d = (double)s / 4.0;
    long long taken = s * 2;
    unsigned char *dyn = __builtin_alloca((size_t)s * 16);
    fill(dyn, (size_t)s * 16, s);
    fill(&pg, sizeof pg, s + 1);
    bump(&taken);
    i += dyn[3];
    l -= pg.b7.r7.h;
    d += 2.0;
    if (i != s * 3 + (unsigned char)(s + 3))
        return 11;
    if (l != ((long long)s << 40) - pg.b7.r7.h)
        return 12;
    if (d != (double)s / 4.0 + 2.0)
        return 13;
    if (taken != s * 2 + 11)
        return 14;
    return 0;
}

/* Scalars between an array, which sits nearest fp, and a 16-aligned
   object below the spills: 32 KiB from fp and from sp alike. */
__attribute__((noinline)) static int wide(int s) {
    unsigned char head[33000];
    volatile long long l = s;
    volatile int i = -s;
    volatile float f = (float)s;
    volatile long double e = (long double)s / 8;
    struct book bk;
    _Alignas(16) unsigned char low[40000];
    fill(head, sizeof head, s);
    fill(low, sizeof low, s + 1);
    fill(&bk, sizeof bk, s + 2);
    l *= head[32999];
    i -= low[12345];
    f *= 2.0f;
    e += 1;
    if (l != (long long)s * (unsigned char)(s + 32999))
        return 21;
    if (i != -s - (unsigned char)(s + 1 + 12345))
        return 22;
    if (f != (float)s * 2.0f)
        return 23;
    if (e != (long double)s / 8 + 1)
        return 24;
    unsigned char *q = (unsigned char *)&bk.p6.b2.r1.d;
    if (q[0] != (unsigned char)(s + 2 + (q - (unsigned char *)&bk)))
        return 25;
    return 0;
}

/* A result temp past the page, through x8 while the stack arguments
   hold sp down, and one filled from x0 / x1. */
__attribute__((noinline)) static int results(int s) {
    struct page pg;
    fill(&pg, sizeof pg, s);
    long long base = s;
    struct five r = make(base, base + 1, base + 2, base + 3, base + 4, base + 5, base + 6,
                         base + 7, base + 8, base + 9);
    struct two p = pair(base + pg.b0.r0.a);
    if (r.v0 != 2 * base + 1 || r.v1 != 2 * base + 5 || r.v2 != 2 * base + 9 ||
        r.v3 != 2 * base + 13 || r.v4 != 2 * base + 17)
        return 31;
    if (p.lo != base + pg.b0.r0.a || p.hi != 3 * (base + pg.b0.r0.a))
        return 32;
    return 0;
}

int main(void) {
    int s = input;
    int rc = fixed(s);
    if (rc)
        return rc;
    rc = moving(s);
    if (rc)
        return rc;
    rc = wide(s);
    if (rc)
        return rc;
    return results(s);
}
