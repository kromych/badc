// C99 6.5.2.5: a block-scope `static` struct initialized by a compound
// literal naming its own type -- `static T s = (T){ ... };` -- drops the
// redundant cast and fills the object from the brace list, matching the
// file-scope allocator. A qspinlock-style static initializer written
// inside a function relies on this. Returns 0 on success.

struct inner {
    int a;
    int b;
};
struct outer {
    struct inner in;
    int tag;
};

static int get_tag(void) {
    static struct outer o = (struct outer){ { .a = 7, .b = 9 }, 42 };
    return o.tag + o.in.a;
}

int main(void) {
    static struct outer o = (struct outer){ .in = { 3, 4 }, .tag = 5 };
    if (o.in.a != 3) return 1;
    if (o.in.b != 4) return 2;
    if (o.tag != 5) return 3;
    if (get_tag() != 49) return 4;

    // Anonymous-union members with nested designators, the shape a
    // spinlock static initializer expands to inside a function.
    typedef struct {
        int counter;
    } atom_t;
    typedef struct {
        union {
            atom_t val;
            struct {
                unsigned char l, p;
            };
        };
    } arch_t;
    typedef struct {
        arch_t raw;
    } raw_t;
    typedef struct {
        union {
            raw_t rl;
        };
    } lock_t;
    static lock_t gl = (lock_t){ { .rl = { .raw = { { .val = { 0 } } } } } };
    if (gl.rl.raw.val.counter != 0) return 5;
    return 0;
}
