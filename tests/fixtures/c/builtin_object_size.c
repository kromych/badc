/* GCC `__builtin_object_size(ptr, type)`: a size_t constant. Bit 0 of
 * `type` selects the closest surrounding subobject over the whole
 * enclosing object, bit 1 the minimum estimate over the maximum; where
 * the size is not known the maximum forms (0 and 1) answer (size_t)-1
 * and the minimum forms (2 and 3) 0. The pointer operand is
 * unevaluated.
 *
 * The whole object is the declared object the designator chain started
 * at, less the offset reached in it, and is unknown through a pointer.
 * The closest surrounding subobject is the innermost member the chain
 * selected, or the object itself where it selected none: an array
 * element narrows to the array indexed, not to the element. A member
 * with no declared bound has no extent of its own and answers the
 * object holding it; a `[0]` member is a complete zero-length array and
 * answers 0. Through a pointer a trailing member may extend past its
 * bound (-fstrict-flex-arrays), and so may a member whose type ends in
 * a flexible array member. Every expected value is gcc 16's at -O2. */
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
struct rows_tail { int n; char buf[2][4]; int tail; };
union scalar_or_array { int a; char b[8]; };
struct holds_union { int n; union scalar_or_array u; int tail; };
/* A trailing array with space after it: the union's other member makes
 * the object larger than the member's own struct, so the bytes from the
 * member to the end of the object are not zero. This is the shape the
 * kernel's fortified writes take. Repeated for each bound, which the
 * subobject forms tell apart. */
#define TRAILING(name, bound)                                               \
    struct name {                                                           \
        int id;                                                             \
        union {                                                             \
            struct { int len; unsigned char payload bound; } lz;            \
            unsigned char buf[136];                                         \
        };                                                                  \
    };
TRAILING(fam_union, [])
TRAILING(zero_union, [0])
TRAILING(one_union, [1])
TRAILING(four_union, [4])

static struct flex flex_s;
static struct zero zero_s;
static struct one one_s;
static struct four four_s;
static struct mid mid_s;
static struct outer outer_s;
static struct anon_union anon_union_s;
static struct anon_struct anon_struct_s;
static struct rows rows_s;
static struct rows_tail rows_tail_s;
static union scalar_or_array union_s;
static struct holds_union holds_union_s;
static struct fam_union fam_union_s;
static struct zero_union zero_union_s;
static struct one_union one_union_s;
static struct four_union four_union_s;
static struct four four_arr[3];
static int scalar_s;

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
    /* The whole object is unknown through a pointer, and every member
     * still narrows to its own extent. */
    CHECK4(&pp->n, -1, 4, 0, 4, 21)
    CHECK4(&mp->tail, -1, 4, 0, 4, 22)
    CHECK4(&mp->buf[1], -1, 3, 0, 3, 23)
    CHECK4(&xp->f, -1, 8, 0, 8, 24)
    CHECK4(&xp->f.n, -1, 4, 0, 4, 25)
    CHECK4(&up->x, -1, 4, 0, 4, 26)
    CHECK4(&fp->n, -1, 4, 0, 4, 27)
    /* The pointer object itself is a declared object. */
    CHECK4(&pp, 8, 8, 8, 8, 28)
    return 0;
}

static int through_pointer_unions(union scalar_or_array *pu,
                                  struct holds_union *wp,
                                  struct rows_tail *rp) {
    CHECK4(&pu->a, -1, 4, 0, 4, 40)
    /* The union's trailing array is the last member of what the pointer
     * reaches, so it may extend past its bound. */
    CHECK4(pu->b, -1, -1, 0, 0, 41)
    /* A member follows the union, so it may not. */
    CHECK4(&wp->u, -1, 8, 0, 8, 42)
    CHECK4(&wp->u.a, -1, 4, 0, 4, 43)
    CHECK4(wp->u.b, -1, 8, 0, 8, 44)
    CHECK4(&wp->u.b[3], -1, 5, 0, 5, 45)
    CHECK4(&wp->tail, -1, 4, 0, 4, 46)
    CHECK4(rp->buf, -1, 8, 0, 8, 47)
    CHECK4(rp->buf[1], -1, 4, 0, 4, 48)
    CHECK4(&rp->buf[1][2], -1, 2, 0, 2, 49)
    return 0;
}

static int through_pointer_trailing(struct fam_union *fp,
                                    struct zero_union *zp,
                                    struct one_union *op,
                                    struct four_union *qp) {
    /* A member whose type ends in a flexible array member has no extent
     * to narrow to when the object may extend past it; `[0]`, `[1]` and
     * `[4]` are complete types that `sizeof` covers. */
    CHECK4(&fp->lz, -1, -1, 0, 0, 60)
    CHECK4(&fp->lz.len, -1, 4, 0, 4, 61)
    CHECK4(fp->lz.payload, -1, -1, 0, 0, 62)
    CHECK4(&zp->lz, -1, 4, 0, 4, 63)
    CHECK4(zp->lz.payload, -1, 0, 0, 0, 64)
    CHECK4(&op->lz, -1, 8, 0, 8, 65)
    CHECK4(op->lz.payload, -1, 1, 0, 1, 66)
    CHECK4(&qp->lz, -1, 8, 0, 8, 67)
    CHECK4(qp->lz.payload, -1, 4, 0, 4, 68)
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
    return 0;
}

static int declared_members(void) {
    /* The whole object is the declared one; the subobject is the member
     * the chain selected. */
    CHECK4(&scalar_s, 4, 4, 4, 4, 70)
    CHECK4(&four_s, 8, 8, 8, 8, 71)
    CHECK4(&four_s.n, 8, 4, 8, 4, 72)
    CHECK4(&four_s.buf, 4, 4, 4, 4, 73)
    CHECK4(&mid_s.n, 12, 4, 12, 4, 74)
    CHECK4(&mid_s.tail, 4, 4, 4, 4, 75)
    CHECK4(&outer_s, 12, 12, 12, 12, 76)
    CHECK4(&outer_s.f, 8, 8, 8, 8, 77)
    CHECK4(&outer_s.f.n, 8, 4, 8, 4, 78)
    CHECK4(&anon_union_s.x, 4, 4, 4, 4, 79)
    CHECK4(&anon_struct_s.m, 8, 4, 8, 4, 80)
    /* An array element narrows to the array indexed, not to the
     * element: the offset moves inside the same subobject. */
    CHECK4(&buf[3], 13, 13, 13, 13, 81)
    CHECK4(&four_s.buf[1], 3, 3, 3, 3, 82)
    CHECK4(&mid_s.buf[1], 7, 3, 7, 3, 83)
    CHECK4(&outer_s.f.buf[1], 3, 3, 3, 3, 84)
    /* One past the end, and past that, leave no room. */
    CHECK4(&buf[16], 0, 0, 0, 0, 85)
    CHECK4(&buf[20], 0, 0, 0, 0, 86)
    return 0;
}

static int declared_unions(void) {
    CHECK4(&union_s, 8, 8, 8, 8, 90)
    CHECK4(&union_s.a, 8, 4, 8, 4, 91)
    CHECK4(union_s.b, 8, 8, 8, 8, 92)
    CHECK4(&union_s.b[2], 6, 6, 6, 6, 93)
    CHECK4(&holds_union_s, 16, 16, 16, 16, 94)
    CHECK4(&holds_union_s.u, 12, 8, 12, 8, 95)
    CHECK4(&holds_union_s.u.a, 12, 4, 12, 4, 96)
    CHECK4(holds_union_s.u.b, 12, 8, 12, 8, 97)
    CHECK4(&holds_union_s.u.b[3], 9, 5, 9, 5, 98)
    CHECK4(&holds_union_s.tail, 4, 4, 4, 4, 99)
    return 0;
}

static int declared_arrays(void) {
    CHECK4(four_arr, 24, 24, 24, 24, 100)
    /* No member step, so the whole array is also the closest
     * surrounding subobject. */
    CHECK4(&four_arr[1], 16, 16, 16, 16, 101)
    CHECK4(&four_arr[1].n, 16, 4, 16, 4, 102)
    CHECK4(&four_arr[1].buf[2], 10, 2, 10, 2, 103)
    /* A row of a multi-dimensional array is the array the innermost
     * subscript indexes. */
    CHECK4(rows_tail_s.buf, 12, 8, 12, 8, 104)
    CHECK4(rows_tail_s.buf[1], 8, 4, 8, 4, 105)
    CHECK4(&rows_tail_s.buf[1][2], 6, 2, 6, 2, 106)
    CHECK4(&rows_tail_s.tail, 4, 4, 4, 4, 107)
    return 0;
}

static int declared_trailing(void) {
    /* A member with no declared bound answers the bytes left in the
     * object holding it, for the subobject forms as well: its nominal 0
     * would report that no byte may be written there. A `[0]` member is
     * a complete zero-length array whose own extent is 0. */
    CHECK4(fam_union_s.lz.payload, 132, 132, 132, 132, 110)
    CHECK4(zero_union_s.lz.payload, 132, 0, 132, 0, 111)
    CHECK4(one_union_s.lz.payload, 132, 1, 132, 1, 112)
    CHECK4(four_union_s.lz.payload, 132, 4, 132, 4, 113)
    CHECK4(fam_union_s.buf, 136, 136, 136, 136, 114)
    /* `sizeof` covers the struct holding the member, so the member
     * before it narrows to its own extent. */
    CHECK4(&fam_union_s.id, 140, 4, 140, 4, 115)
    CHECK4(&fam_union_s.lz, 136, 4, 136, 4, 116)
    CHECK4(&fam_union_s.lz.len, 136, 4, 136, 4, 117)
    CHECK4(&one_union_s.lz, 136, 8, 136, 8, 118)
    CHECK4(&flex_s.n, 4, 4, 4, 4, 119)
    CHECK4(&flex_s.buf[0], 0, 0, 0, 0, 120)
    return 0;
}

static int displaced(void) {
    /* A cast does not change the object, and a constant displacement
     * moves the offset in it (C99 6.5.6p8). */
    CHECK4((int *)&four_s.n, 8, 4, 8, 4, 130)
    CHECK4((char *)&four_s.buf[1], 3, 3, 3, 3, 131)
    CHECK4((char *)&four_s + 2, 6, 6, 6, 6, 132)
    CHECK4(buf + 3, 13, 13, 13, 13, 133)
    CHECK4(buf + 2 + 3, 11, 11, 11, 11, 134)
    CHECK4(four_s.buf + 1, 3, 3, 3, 3, 135)
    /* gcc answers 6 for the minimum form here -- above its own maximum
     * form's 2, which is the exact size. The exact size is both. */
    CHECK4((char *)&mid_s.buf[3] - 1, 6, 2, 6, 2, 136)
    /* Out of the object either way. */
    CHECK4(buf - 1, 0, 0, 0, 0, 137)
    CHECK4(buf + 17, 0, 0, 0, 0, 138)
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

    /* A string literal is a declared array of its own bytes. */
    if (__builtin_object_size("hello", 1) != 6)
        return 140;

    int r = through_pointer(&flex_s, &zero_s, &one_s, &four_s, &mid_s,
                            &outer_s, &anon_union_s, &anon_struct_s, &rows_s);
    if (r)
        return r;
    r = through_pointer_unions(&union_s, &holds_union_s, &rows_tail_s);
    if (r)
        return r;
    r = through_pointer_trailing(&fam_union_s, &zero_union_s, &one_union_s,
                                 &four_union_s);
    if (r)
        return r;
    r = declared();
    if (r)
        return r;
    r = declared_members();
    if (r)
        return r;
    r = declared_unions();
    if (r)
        return r;
    r = declared_arrays();
    if (r)
        return r;
    r = declared_trailing();
    if (r)
        return r;
    return displaced();
}
