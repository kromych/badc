// Unnamed members whose type specifier carries a tag: the extension
// gcc spells `-fms-extensions` and MSVC accepts by default. C11
// 6.7.2.1p13 promotes the members of an unnamed struct/union with no
// tag; this generalises the same promotion to a tagged type used with
// no declarator, so the members of the named type are reachable through
// the enclosing aggregate. Layout, brace initialization and designated
// initialization follow the untagged case exactly.
//
// Each check returns a unique non-zero id so the FIRST mismatch points
// to its scenario.

#include <stddef.h>

struct head {
    const char *name;
    int refcnt;
};

// A tagged struct type as an unnamed member: `name` and `refcnt` become
// members of `filename`, and `iname` follows the promoted block.
struct filename {
    struct head;
    char iname[8];
};

union inner_u {
    int iu;
    long lu;
};

// A tagged union type as an unnamed member: its members overlap at the
// member's own offset, and the field after it follows the union.
struct with_union {
    union inner_u;
    int after;
};

// A tag DEFINED in place with no declarator is the same construct: the
// definition names the tag and the member stays unnamed.
struct defined_inline {
    struct nested_def { int nx; int ny; };
    int z;
};

// A tagged unnamed member inside an untagged union: the two promotion
// rules compose, and both arms start at the union's offset.
struct pair {
    void *l;
    void *r;
};

struct composed {
    unsigned int inum;
    union {
        struct pair;
        long rcu;
    };
};

// The promoted members carry their own qualifiers and array bounds, and
// a promoted bitfield keeps its width.
struct bits {
    unsigned a : 3;
    unsigned b : 5;
};

struct with_bits {
    struct bits;
    unsigned tail;
};

static struct filename g_init = { { "q", 11 }, "xy" };
static struct filename g_desig = { .refcnt = 22, .iname = "zw" };

static int streq(const char *a, const char *b) {
    while (*a && *a == *b) { a++; b++; }
    return *a == *b;
}

int main(void) {
    // ---- promoted layout ----
    if (sizeof(struct filename) != 24) return 1;
    if (offsetof(struct filename, name) != 0) return 2;
    if (offsetof(struct filename, refcnt) != 8) return 3;
    if (offsetof(struct filename, iname) != 16) return 4;

    struct filename f;
    f.name = "n";
    f.refcnt = 3;
    f.iname[0] = 'a';
    f.iname[1] = 0;
    if (!streq(f.name, "n")) return 5;
    if (f.refcnt != 3) return 6;
    if (!streq(f.iname, "a")) return 7;

    // ---- unnamed member of a union type ----
    if (sizeof(struct with_union) != 16) return 10;
    if (offsetof(struct with_union, iu) != 0) return 11;
    if (offsetof(struct with_union, lu) != 0) return 12;
    if (offsetof(struct with_union, after) != 8) return 13;

    struct with_union w;
    w.lu = 0;
    w.iu = 7;
    w.after = 9;
    if (w.iu != 7) return 14;
    if (w.after != 9) return 15;

    // ---- tag defined in place ----
    if (offsetof(struct defined_inline, nx) != 0) return 20;
    if (offsetof(struct defined_inline, ny) != 4) return 21;
    if (offsetof(struct defined_inline, z) != 8) return 22;

    struct defined_inline d;
    d.nx = 1; d.ny = 2; d.z = 3;
    if (d.nx != 1 || d.ny != 2 || d.z != 3) return 23;

    // The tag the member defined is usable as an ordinary type.
    struct nested_def nd;
    nd.nx = 4; nd.ny = 5;
    if (nd.nx + nd.ny != 9) return 24;

    // ---- tagged member inside an untagged union ----
    if (offsetof(struct composed, inum) != 0) return 30;
    if (offsetof(struct composed, l) != 8) return 31;
    if (offsetof(struct composed, r) != 16) return 32;
    if (offsetof(struct composed, rcu) != 8) return 33;

    struct composed c;
    c.inum = 5;
    c.l = (void *)0x10;
    c.r = (void *)0x20;
    if (c.inum != 5) return 34;
    if (c.l != (void *)0x10) return 35;
    if (c.r != (void *)0x20) return 36;
    c.rcu = 0x77;
    if (c.l != (void *)0x77) return 37;

    // ---- promoted bitfields ----
    struct with_bits bf;
    bf.a = 5;
    bf.b = 21;
    bf.tail = 0x1234;
    if (bf.a != 5) return 40;
    if (bf.b != 21) return 41;
    if (bf.tail != 0x1234u) return 42;

    // ---- initialization ----
    // The unnamed member takes one brace level, exactly as an untagged
    // one does; a designator names a promoted member directly.
    if (!streq(g_init.name, "q")) return 50;
    if (g_init.refcnt != 11) return 51;
    if (!streq(g_init.iname, "xy")) return 52;
    if (g_desig.refcnt != 22) return 53;
    if (!streq(g_desig.iname, "zw")) return 54;
    if (g_desig.name != NULL) return 55;

    struct filename l_init = { { "r", 13 }, "ab" };
    struct filename l_desig = { .refcnt = 24, .iname = "cd" };
    if (!streq(l_init.name, "r")) return 56;
    if (l_init.refcnt != 13) return 57;
    if (!streq(l_init.iname, "ab")) return 58;
    if (l_desig.refcnt != 24) return 59;
    if (!streq(l_desig.iname, "cd")) return 60;

    return 0;
}
