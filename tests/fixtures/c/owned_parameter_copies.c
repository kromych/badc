/* An aggregate the ABI passes as the address of a copy the callee owns
 * (AAPCS64 over 16 bytes, Microsoft x64 of any size but 1, 2, 4 or 8):
 * the callee reads, writes and passes on its parameter, through its own
 * accesses and through pointers to it, and the caller's object keeps its
 * value across every call. Elsewhere the same calls pass by value. Each
 * failure returns a distinct code. */

#define NOINLINE __attribute__((noinline))

struct S { long a, b, c; };
struct C { char x[19]; };

static struct S *saved;

NOINLINE long through(struct S *p) {
    p->b += 10;
    return p->a + p->b;
}

/* Written, then reached through a pointer that writes it again. */
NOINLINE long escaped(struct S s) {
    s.a = 5;
    return through(&s) + s.b;
}

NOINLINE long read_after(struct S s) { return through(&s) + s.b; }
NOINLINE long sum(struct S s) { return s.a + s.b + s.c; }
NOINLINE long bump(struct S s) {
    s.a += 1;
    return s.a * s.b;
}

NOINLINE long loop(struct S s) {
    long t = 0;
    for (; s.a < s.b; s.a++) t += s.c;
    return t;
}

NOINLINE long forward(struct S s) { return sum(s) + escaped(s) + 1; }

NOINLINE long kept(struct S s) {
    saved = &s;
    saved->c *= 2;
    return s.c;
}

NOINLINE int chars(struct C c) {
    c.x[18] ^= 1;
    return c.x[0] + c.x[18];
}

NOINLINE int chars_escaped(struct C c) {
    char *p = c.x;
    p[3] = 'z';
    return p[3] + c.x[18] + c.x[2];
}

static int same(const struct S *s) { return s->a == 1 && s->b == 20 && s->c == 3; }

int main(void) {
    struct S o = {1, 20, 3};
    if (escaped(o) != 5 + 30 + 30 || !same(&o)) return 1;
    if (read_after(o) != 1 + 30 + 30 || !same(&o)) return 2;
    if (sum(o) != 24 || !same(&o)) return 3;
    if (bump(o) != 40 || !same(&o)) return 4;
    if (loop(o) != 19 * 3 || !same(&o)) return 5;
    if (forward(o) != 24 + 65 + 1 || !same(&o)) return 6;
    if (kept(o) != 6 || !same(&o)) return 7;
    struct C c;
    for (int i = 0; i < 19; i++) c.x[i] = (char)(i + 1);
    if (chars(c) != 1 + (19 ^ 1) || c.x[18] != 19) return 8;
    if (chars_escaped(c) != 'z' + 19 + 3 || c.x[3] != 4) return 9;
    return 0;
}
