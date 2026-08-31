/* GCC `__builtin_object_size(ptr, type)`: a size_t constant. A known
 * declared array folds to its byte count; an unknown pointer yields
 * (size_t)-1 for the maximum forms (types 0 and 1) and 0 for the
 * minimum forms (types 2 and 3). The pointer operand is unevaluated.
 *
 * Through a pointer the whole object (types 0 and 2) is unknown and an
 * array member answers its own size (types 1 and 3) unless it is
 * unbounded: a `[]` member, or under the default -fstrict-flex-arrays=0
 * any array that is the last member of the pointed-to struct, of a
 * union inside it, or a row of one. A member of a declared object is
 * bounded by the object: its own size for types 1 and 3, the bytes
 * left in the object for types 0 and 2 -- except a member with no
 * declared bound, which has no extent of its own and answers the bytes
 * left in the object for every type. Every expected value is gcc
 * 16's at -O2. */
typedef unsigned long long usize;

static char buf[16];

struct flex { int n; char buf[]; };
struct zero { int n; char buf[0]; };
struct one { int n; char buf[1]; };
struct four { int n; char buf[4]; };
struct mid { int n; char buf[4]; int tail; };
struct outer { int n; struct four f; };
struct anon_union { int n; union { char buf[4]; int x; }; };
struct anon_struct { int n; struct { int m; char buf[4]; }; };
struct rows { int n; char buf[2][4]; };
/* A flexible array member with space after it: the union's other
 * member makes the object larger than the member's own struct, so
 * the bytes from the member to the end of the object are not zero.
 * This is the shape the kernel's fortified writes take. */
struct fam_union {
    int id;
    union {
        struct { int len; unsigned char payload[]; } lz;
        unsigned char buf[136];
    };
};

static struct flex flex_s;
static struct zero zero_s;
static struct one one_s;
static struct four four_s;
static struct mid mid_s;
static struct outer outer_s;
static struct anon_union anon_union_s;
static struct anon_struct anon_struct_s;
static struct rows rows_s;
static struct fam_union fam_union_s;

#define CHECK4(expr, t0, t1, t2, t3, code)                                  \
    if (__builtin_object_size(expr, 0) != (usize)(t0)                       \
        || __builtin_object_size(expr, 1) != (usize)(t1)                    \
        || __builtin_object_size(expr, 2) != (usize)(t2)                    \
        || __builtin_object_size(expr, 3) != (usize)(t3))                   \
        return code;

static int through_pointer(struct flex *fp, struct zero *zp, struct one *op,
                           struct four *pp, struct mid *mp, struct outer *xp,
                           struct anon_union *up, struct anon_struct *sp,
                           struct rows *rp) {
    CHECK4(fp->buf, -1, -1, 0, 0, 10)
    CHECK4(zp->buf, -1, -1, 0, 0, 11)
    CHECK4(op->buf, -1, -1, 0, 0, 12)
    CHECK4(pp->buf, -1, -1, 0, 0, 13)
    CHECK4(mp->buf, -1, 4, 0, 4, 14)
    /* A struct member in between is a second struct on the way, and
     * gcc holds the array to its bound. */
    CHECK4(xp->f.buf, -1, 4, 0, 4, 15)
    CHECK4(up->buf, -1, -1, 0, 0, 16)
    CHECK4(sp->buf, -1, 4, 0, 4, 17)
    CHECK4(rp->buf, -1, -1, 0, 0, 18)
    CHECK4(rp->buf[1], -1, -1, 0, 0, 19)
    /* `(*p).buf` is `p->buf`. */
    CHECK4((*pp).buf, -1, -1, 0, 0, 20)
    return 0;
}

static int declared(void) {
    struct mid local;
    CHECK4(flex_s.buf, 0, 0, 0, 0, 30)
    CHECK4(zero_s.buf, 0, 0, 0, 0, 31)
    CHECK4(one_s.buf, 4, 1, 4, 1, 32)
    CHECK4(four_s.buf, 4, 4, 4, 4, 33)
    CHECK4(mid_s.buf, 8, 4, 8, 4, 34)
    CHECK4(outer_s.f.buf, 4, 4, 4, 4, 35)
    CHECK4(anon_union_s.buf, 4, 4, 4, 4, 36)
    CHECK4(anon_struct_s.buf, 4, 4, 4, 4, 37)
    CHECK4(rows_s.buf, 8, 8, 8, 8, 38)
    CHECK4(local.buf, 8, 4, 8, 4, 39)
    /* A member with no declared bound has no extent of its own, so
     * every form answers the bytes left in the object holding it --
     * not the member's nominal zero, which would report that no byte
     * may be written there. */
    CHECK4(fam_union_s.lz.payload, 132, 132, 132, 132, 40)
    CHECK4(fam_union_s.buf, 136, 136, 136, 136, 41)
    return 0;
}

int main(void) {
    if (__builtin_object_size(buf, 0) != 16)
        return 1;
    if (__builtin_object_size(buf, 1) != 16)
        return 2;
    if (__builtin_object_size(buf, 2) != 16)
        return 3;

    char *p = buf;
    if (__builtin_object_size(p, 0) != (usize)-1)
        return 4;
    if (__builtin_object_size(p, 1) != (usize)-1)
        return 5;
    if (__builtin_object_size(p, 2) != 0)
        return 6;
    if (__builtin_object_size(p, 3) != 0)
        return 7;

    /* Unevaluated operand: no side effect from the call. */
    int n = 0;
    usize s = __builtin_object_size((n++, p), 0);
    if (s != (usize)-1)
        return 8;
    if (n != 0)
        return 9;

    int r = through_pointer(&flex_s, &zero_s, &one_s, &four_s, &mid_s,
                            &outer_s, &anon_union_s, &anon_struct_s, &rows_s);
    if (r)
        return r;
    return declared();
}
