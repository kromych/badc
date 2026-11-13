// Stores a later store to the same bytes overwrites: with no read between,
// only the last one's bytes are observable; with a read between -- through
// another pointer to the same object, by a called function, through a
// volatile lvalue -- the read sees the earlier store; a later store to part
// of the bytes leaves the rest (C17 6.5.2.3p3 for the union). Returns 0 when
// every check passes; each failure returns a distinct code.

typedef union {
    long long ll;
    unsigned u[2];
} U;

typedef struct {
    int tag;
    long long bits;
} S;

static int seen;

__attribute__((noinline)) void observe(const int *p) { seen = *p; }

__attribute__((noinline)) int alias_read(int *p, int *q) {
    *p = 1;
    int t = *q;
    *p = 2;
    return t;
}

__attribute__((noinline)) void through_call(int *p) {
    *p = 3;
    observe(p);
    *p = 4;
}

__attribute__((noinline)) int via_volatile(int *p) {
    *p = 5;
    int t = *(volatile int *)p;
    *p = 6;
    return t;
}

__attribute__((noinline)) void partial(U *u) {
    u->ll = -1;
    u->u[1] = 0;
}

__attribute__((noinline)) void overwrite(int *p, int a) {
    *p = a;
    *p = a + 1;
    *p = a + 2;
}

__attribute__((noinline)) void fields(S *s, long long m) {
    s->bits &= m;
    s->bits |= 0x100;
    s->bits ^= 5;
    s->tag = 1;
    s->tag += 2;
}

int main(void) {
    int x = 0;
    if (alias_read(&x, &x) != 1 || x != 2) return 1;
    through_call(&x);
    if (seen != 3 || x != 4) return 2;
    if (via_volatile(&x) != 5 || x != 6) return 3;
    U u;
    partial(&u);
    if (u.u[0] != 0xffffffffu || u.u[1] != 0) return 4;
    overwrite(&x, 40);
    if (x != 42) return 5;
    S s = {0, 0xf0f0};
    fields(&s, 0xff00);
    if (s.bits != ((0xf000 | 0x100) ^ 5) || s.tag != 3) return 6;
    return 0;
}
