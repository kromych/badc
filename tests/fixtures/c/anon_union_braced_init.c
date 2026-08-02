/* C11 6.7.2.1: a member of an anonymous union/struct, whose members are
   flattened into the enclosing struct, may be initialized by a brace-enclosed
   sub-initializer -- `{ .member = v }` (designated) or `{ v }` (positional) --
   in both a compound literal and a plain declaration, with constant and
   runtime element values. */

struct S {
    int tag;
    union {
        int *a;
        long b;
    };
};

int g = 42;

// A volatile pointer keeps the object in memory, so the initializer's
// stores are emitted and read back rather than forwarded to the checks.
static void *opaque(void *p) { void *volatile q = p; return q; }

static int runtime_elem(int tag, int *p) {
    struct S s = (struct S){ .tag = tag, { .a = p } };
    struct S *r = opaque(&s);
    return (r->tag == tag && r->a == p) ? 0 : 1;
}

int main(void) {
    /* `volatile` keeps the element values runtime values, so the runtime
       store path is really emitted. */
    volatile int tag = 7;
    int *volatile gp = &g;
    if (runtime_elem(tag, gp)) return 1;

    struct S c1 = (struct S){ .tag = 1, { .a = &g } };
    struct S *r1 = opaque(&c1);
    if (r1->tag != 1 || r1->a != &g || *r1->a != 42) return 2;

    struct S c2 = { .tag = 3, { .b = 99 } };
    struct S *r2 = opaque(&c2);
    if (r2->tag != 3 || r2->b != 99) return 3;

    struct S c3 = (struct S){ .tag = 5, { &g } };
    struct S *r3 = opaque(&c3);
    if (r3->tag != 5 || r3->a != &g) return 4;

    return 0;
}
