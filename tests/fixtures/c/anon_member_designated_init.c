/* Designated initializer for a named aggregate member inside an anonymous
   union/struct (C11 6.7.2.1). `.iov = { ... }` initializes the member's own
   type, distinct from a positional brace on the anonymous region which
   selects a group member. QEMU's scatter-gather structs use this shape. */

struct iovec {
    void *iov_base;
    unsigned long iov_len;
};

/* Named struct member inside an anonymous union. */
struct sg_union {
    int tag;
    union {
        struct iovec iov;
        long other;
    };
};

/* Named struct member inside an anonymous struct. */
struct sg_struct {
    int tag;
    struct {
        struct iovec io;
        int y;
    };
};

static int check_union_runtime(int tag, void *p, unsigned long n) {
    struct sg_union s = { .tag = tag, .iov = { .iov_base = p, .iov_len = n } };
    return (s.tag == tag && s.iov.iov_base == p && s.iov.iov_len == n) ? 0 : 1;
}

int main(void) {
    int x = 0;

    /* Runtime element values through the runtime store path. */
    if (check_union_runtime(7, &x, 16)) return 1;

    /* Constant element values through the constant-staging path. */
    struct sg_union cu = { .tag = 3, .iov = { .iov_base = &x, .iov_len = 8 } };
    if (cu.tag != 3 || cu.iov.iov_base != &x || cu.iov.iov_len != 8) return 2;

    /* Designated member of an anonymous struct, plus a sibling. */
    struct sg_struct cs = { .tag = 5, .io = { .iov_base = &x, .iov_len = 4 }, .y = 9 };
    if (cs.tag != 5 || cs.io.iov_base != &x || cs.io.iov_len != 4 || cs.y != 9) return 3;

    /* Positional brace on the anonymous union region still selects a group
       member (must keep working alongside the designated form). */
    struct sg_union pu = { .tag = 1, { .other = 42 } };
    if (pu.tag != 1 || pu.other != 42) return 4;

    return 0;
}
