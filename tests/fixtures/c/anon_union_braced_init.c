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

static int runtime_elem(int tag, int *p) {
    struct S s = (struct S){ .tag = tag, { .a = p } };
    return (s.tag == tag && s.a == p) ? 0 : 1;
}

int main(void) {
    if (runtime_elem(7, &g)) return 1;

    struct S c1 = (struct S){ .tag = 1, { .a = &g } };
    if (c1.tag != 1 || c1.a != &g || *c1.a != 42) return 2;

    struct S c2 = { .tag = 3, { .b = 99 } };
    if (c2.tag != 3 || c2.b != 99) return 3;

    struct S c3 = (struct S){ .tag = 5, { &g } };
    if (c3.tag != 5 || c3.a != &g) return 4;

    return 0;
}
