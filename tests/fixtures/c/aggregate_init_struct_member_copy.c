// C99 6.7.8p13: a struct/union member of an automatic aggregate may be
// initialized by a single expression of compatible struct type. When that
// expression is not a constant (a by-value parameter, a pointer
// dereference, or an array subscript), the member must receive a copy of
// the source's bytes, not a scalar store of the source's address. The
// shape that surfaced this was `struct ctx c = { p, 0, 0, argv[0] };`
// where the trailing member is a 16-byte struct read from argv[0]: the
// member was getting the address of argv[0] plus a zero rather than the
// struct value.

struct Pair { long u; long tag; };

struct LeadThenStruct { void *p; int a; int b; struct Pair m; };
struct StructFirst { struct Pair m; int a; };
struct OnlyStruct { struct Pair m; };

static long via_subscript(struct Pair *argv) {
    struct LeadThenStruct c = { (void *)0, 0, 0, argv[0] };
    return c.m.tag;
}
static long via_deref(struct Pair *p) {
    struct LeadThenStruct c = { (void *)0, 0, 0, *p };
    return c.m.tag;
}
static long via_value(struct Pair m) {
    struct LeadThenStruct c = { (void *)0, 0, 0, m };
    return c.m.tag;
}
static long struct_first(struct Pair *p) {
    struct StructFirst c = { p[0], 7 };
    return c.m.tag + c.a;
}
static long only_struct(struct Pair m) {
    struct OnlyStruct c = { m };
    return c.m.u + c.m.tag;
}

int main(void) {
    struct Pair v;
    v.u = 100;
    v.tag = 3;

    if (via_subscript(&v) != 3) return 1;
    if (via_deref(&v) != 3) return 2;
    if (via_value(v) != 3) return 3;
    if (struct_first(&v) != 10) return 4; // tag 3 + 7
    if (only_struct(v) != 103) return 5;  // u 100 + tag 3

    // The member copy must be by value: mutating the source afterwards
    // must not change the already-initialized member.
    struct Pair w;
    w.u = 1;
    w.tag = 9;
    struct OnlyStruct c = { w };
    w.tag = 0;
    if (c.m.tag != 9) return 6;

    return 0;
}
