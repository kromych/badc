/* Runtime (non-constant) initializer path for anonymous aggregate members.
   Before the initializer engine was unified the runtime struct walker had
   no anonymous-struct handling and ignored a flexible member's grouping;
   the constant path did. Values come from parameters so the initializer is
   not all compile-time constant and the runtime store path is taken. */

struct with_anon_struct {
    int a;
    struct {
        void *p;
        unsigned long n;
    };
    int b;
};

struct with_anon_union {
    int tag;
    union {
        void *ptr;
        long word;
    };
};

struct nested {
    int a;
    struct with_anon_struct inner;
};

/* A volatile pointer keeps the object in memory, so the initializer's
   stores are emitted and read back rather than forwarded to the checks. */
static void *opaque(void *p) { void *volatile q = p; return q; }

static int check_anon_struct(void *p, unsigned long n) {
    /* positional brace on the flattened anon-struct region */
    struct with_anon_struct s1 = { .a = 1, { p, n }, .b = 7 };
    /* flattened members named directly as designators */
    struct with_anon_struct s2 = { .a = 2, .p = p, .n = n, .b = 8 };
    struct with_anon_struct *r1 = opaque(&s1);
    struct with_anon_struct *r2 = opaque(&s2);
    if (r1->a != 1 || r1->p != p || r1->n != n || r1->b != 7) return 1;
    if (r2->a != 2 || r2->p != p || r2->n != n || r2->b != 8) return 2;
    return 0;
}

static int check_anon_union(void *p) {
    struct with_anon_union u = { .tag = 3, .ptr = p };
    struct with_anon_union *r = opaque(&u);
    return (r->tag == 3 && r->ptr == p) ? 0 : 3;
}

static int check_nested(void *p, unsigned long n) {
    struct nested nn = { .a = 9, .inner = { .a = 4, { p, n }, .b = 5 } };
    struct nested *r = opaque(&nn);
    return (r->a == 9 && r->inner.a == 4 && r->inner.p == p
            && r->inner.n == n && r->inner.b == 5) ? 0 : 4;
}

int main(void) {
    int x = 0;
    int r;
    /* `volatile` keeps the element values runtime values, so the runtime
       store path is really emitted rather than folded to the checks. */
    int *volatile xp = &x;
    volatile unsigned long n = 16;
    int *p = xp;
    if ((r = check_anon_struct(p, n))) return r;
    if ((r = check_anon_union(p))) return r;
    n = 24;
    if ((r = check_nested(p, n))) return r;
    return 0;
}
