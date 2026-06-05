// C99 6.5.16.1: simple assignment of a function-call result to a struct-field
// lvalue must write the rvalue to the field, not the field's own address.
// Surfaced as a SIGABRT in lua-O on Linux x86_64 (new_varkind ->
// luaM_growvector -> luaM_growaux_): the SSA allocator placed both the
// call return value and the spilled lvalue address in r11 with overlapping
// live ranges, so the post-call store-back emitted `mov %r11,(%r11)`.

#include <stdio.h>

struct Inner {
    void *p;
    int n;
    int size;
};

struct Outer {
    int pad;
    struct Inner a;
    struct Inner b;
};

static struct Outer g;

static void *grow(void *p, int *psize, int nelems, int size_elems,
                  int limit, const char *what) {
    (void)p; (void)nelems; (void)size_elems; (void)limit; (void)what;
    *psize = 4;
    return (void *)0x1234abcdL;
}

static int wrap(struct Outer *o, const char *what) {
    void *before_a = o->a.p;
    void *before_b = o->b.p;
    o->a.p = grow(o->a.p, &o->a.size, o->a.n + 1, sizeof(struct Inner),
                  32767, what);
    o->b.p = grow(o->b.p, &o->b.size, o->b.n + 1, sizeof(struct Inner),
                  32767, what);
    if (before_a == o->a.p) return 1;
    if (before_b == o->b.p) return 2;
    if ((long)o->a.p != 0x1234abcdL) return 3;
    if ((long)o->b.p != 0x1234abcdL) return 4;
    if (o->a.size != 4) return 5;
    if (o->b.size != 4) return 6;
    return 0;
}

int main(void) {
    int rc = wrap(&g, "test");
    if (rc != 0) {
        printf("FAIL: rc=%d g.a.p=%p g.b.p=%p g.a.size=%d g.b.size=%d\n",
               rc, g.a.p, g.b.p, g.a.size, g.b.size);
        return 1;
    }
    printf("OK\n");
    return 0;
}
