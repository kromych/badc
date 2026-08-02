/* Designated initializer for a named aggregate member inside an anonymous
   union/struct (C11 6.7.2.1). `.iov = { ... }` initializes the member's own
   type, distinct from a positional brace on the anonymous region which
   selects a group member. A common scatter-gather struct uses this shape. */

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

/* A volatile pointer keeps the object in memory, so the initializer's
   stores are emitted and read back rather than forwarded to the checks. */
static void *opaque(void *p) { void *volatile q = p; return q; }

static int check_union_runtime(int tag, void *p, unsigned long n) {
    struct sg_union s = { .tag = tag, .iov = { .iov_base = p, .iov_len = n } };
    struct sg_union *r = opaque(&s);
    return (r->tag == tag && r->iov.iov_base == p && r->iov.iov_len == n) ? 0 : 1;
}

int main(void) {
    int x = 0;

    /* Runtime element values through the runtime store path. `volatile`
       keeps them out of the folder so the stores are really emitted. */
    volatile int tag = 7;
    volatile unsigned long n = 16;
    int *volatile xp = &x;
    if (check_union_runtime(tag, xp, n)) return 1;

    /* Constant element values through the constant-staging path. */
    struct sg_union cu = { .tag = 3, .iov = { .iov_base = &x, .iov_len = 8 } };
    struct sg_union *rcu = opaque(&cu);
    if (rcu->tag != 3 || rcu->iov.iov_base != &x || rcu->iov.iov_len != 8) return 2;

    /* Designated member of an anonymous struct, plus a sibling. */
    struct sg_struct cs = { .tag = 5, .io = { .iov_base = &x, .iov_len = 4 }, .y = 9 };
    struct sg_struct *rcs = opaque(&cs);
    if (rcs->tag != 5 || rcs->io.iov_base != &x || rcs->io.iov_len != 4 || rcs->y != 9) return 3;

    /* Positional brace on the anonymous union region still selects a group
       member (must keep working alongside the designated form). */
    struct sg_union pu = { .tag = 1, { .other = 42 } };
    struct sg_union *rpu = opaque(&pu);
    if (rpu->tag != 1 || rpu->other != 42) return 4;

    return 0;
}
