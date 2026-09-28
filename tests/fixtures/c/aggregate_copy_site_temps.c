/* An aggregate copy (C99 6.5.16.1p3, an exact overlap allowed) at each
   size the lowering distinguishes: whole pairs, a lone word, a tail that
   narrows to a byte, and copies past the inline bound that run as a loop.
   The copies run with values live across them, with a base read after
   the copy, with the copy's own value read, over an exact self-overlap
   and under enough pressure to spill both bases. Every destination is
   checked byte by byte against its source. */

typedef struct { long v; long tag; } Value;
struct b8 { long a; };
struct b12 { int a, b, c; };
struct b13 { char x[13]; };
struct b24 { long a, b, c; };
struct b31 { char x[31]; };
struct b40 { long a[5]; };
struct b520 { char x[520]; };
struct b524 { char x[524]; };
struct b1000 { char x[1000]; };
struct b4104 { char x[4104]; };

static void fill(void *p, unsigned long n, unsigned seed) {
    unsigned char *b = p;
    unsigned long i;
    for (i = 0; i < n; i++) {
        seed = seed * 1103515245u + 12345u;
        b[i] = (unsigned char)(seed >> 16);
    }
}

static int same(const void *a, const void *b, unsigned long n) {
    const unsigned char *x = a;
    const unsigned char *y = b;
    unsigned long i;
    for (i = 0; i < n; i++) {
        if (x[i] != y[i]) {
            return 0;
        }
    }
    return 1;
}

static void push_value(Value **psp, const Value *src) {
    Value *sp = *psp;
    *sp = *src;
    *psp = sp + 1;
}

/* The source is read after the copy, so its base stays live across it. */
static long copy_then_read(struct b24 *d, const struct b24 *s) {
    *d = *s;
    return s->a + s->c;
}

/* Six values live across the copy occupy the bank the copy draws on. */
static long copy_under_load(struct b40 *d, const struct b40 *s, long a, long b, long c, long e) {
    long f = a * 3;
    long g = b ^ c;
    *d = *s;
    return a + b + c + e + f + g + d->a[4];
}

/* The copy's value is its destination. */
static int copy_value_read(char *d, const char *s) {
    char *r = __builtin_memcpy(d, s, 40);
    return r == d;
}

static void self_copy(Value *p) {
    *p = *p;
}

/* Both bases are pointers computed from many live values, so under
   register pressure they spill. */
static long copy_spilled_bases(struct b31 *d0, const struct b31 *s0, long k0, long k1,
                               long k2, long k3, long k4, long k5, long k6, long k7) {
    struct b31 *d = d0 + (k0 & 1);
    const struct b31 *s = s0 + (k1 & 1);
    long m0 = k0 + k1, m1 = k2 + k3, m2 = k4 + k5, m3 = k6 + k7;
    long m4 = m0 * m1, m5 = m2 * m3, m6 = m0 ^ m2, m7 = m1 ^ m3;
    *d = *s;
    return m0 + m1 + m2 + m3 + m4 + m5 + m6 + m7 + d->x[30];
}

static struct b520 g520a, g520b;
static struct b524 g524a, g524b;
static struct b1000 g1000a, g1000b;
static struct b4104 g4104a, g4104b;

/* A copy past the inline bound, its destination read afterwards. */
static int loop_copy_then_read(struct b1000 *d, const struct b1000 *s) {
    *d = *s;
    return d->x[999] == s->x[999];
}

int main(void) {
    Value stack[4], src = {7, 11}, *sp = stack;
    struct b8 a8, b8v;
    struct b12 a12, b12v;
    struct b13 a13, b13v;
    struct b24 a24, b24v;
    struct b31 a31[2], b31v[2];
    struct b40 a40, b40v;
    char raw40[40], out40[40];

    push_value(&sp, &src);
    if (sp != stack + 1 || stack[0].v != 7 || stack[0].tag != 11) {
        return 1;
    }
    fill(&a8, sizeof a8, 1);
    b8v = a8;
    if (!same(&a8, &b8v, sizeof a8)) {
        return 2;
    }
    fill(&a12, sizeof a12, 2);
    b12v = a12;
    if (!same(&a12, &b12v, sizeof a12)) {
        return 3;
    }
    fill(&a13, sizeof a13, 3);
    b13v = a13;
    if (!same(&a13, &b13v, sizeof a13)) {
        return 4;
    }
    fill(&a24, sizeof a24, 4);
    if (copy_then_read(&b24v, &a24) != a24.a + a24.c || !same(&a24, &b24v, sizeof a24)) {
        return 5;
    }
    fill(&a40, sizeof a40, 5);
    if (copy_under_load(&b40v, &a40, 1, 2, 3, 4) != 1 + 2 + 3 + 4 + 3 + 1 + a40.a[4]
        || !same(&a40, &b40v, sizeof a40)) {
        return 6;
    }
    fill(raw40, sizeof raw40, 6);
    if (!copy_value_read(out40, raw40) || !same(raw40, out40, sizeof raw40)) {
        return 7;
    }
    fill(&src, sizeof src, 7);
    stack[2] = src;
    self_copy(&src);
    if (!same(&src, &stack[2], sizeof src)) {
        return 8;
    }
    fill(a31, sizeof a31, 8);
    if (copy_spilled_bases(b31v, a31, 1, 1, 2, 3, 4, 5, 6, 7)
            != 2 + 5 + 9 + 13 + 10 + 117 + 11 + 8 + a31[1].x[30]
        || !same(&a31[1], &b31v[1], sizeof a31[1])) {
        return 9;
    }
    fill(&g520a, sizeof g520a, 9);
    g520b = g520a;
    if (!same(&g520a, &g520b, sizeof g520a)) {
        return 10;
    }
    fill(&g524a, sizeof g524a, 10);
    g524b = g524a;
    if (!same(&g524a, &g524b, sizeof g524a)) {
        return 11;
    }
    fill(&g1000a, sizeof g1000a, 11);
    if (!loop_copy_then_read(&g1000b, &g1000a) || !same(&g1000a, &g1000b, sizeof g1000a)) {
        return 12;
    }
    fill(&g4104a, sizeof g4104a, 12);
    g4104b = g4104a;
    if (!same(&g4104a, &g4104b, sizeof g4104a)) {
        return 13;
    }
    return 0;
}
