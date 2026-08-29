/* -fstrict-flex-arrays=N selects which trailing array members
 * __builtin_object_size treats as unbounded through a pointer. The exit
 * code sets one bit per member the closest-subobject form (type 1)
 * bounds: 1 for `[]`, 2 for `[0]`, 4 for `[1]`, 8 for `[4]`, 16 for a
 * `[4]` that is not the last member. gcc 16 at -O2 gives 16 at level 0,
 * 24 at level 1, 28 at level 2 and 30 at level 3. A bounded member
 * answers its byte count, the minimum form (type 3) agrees, and the
 * whole-object forms (types 0 and 2) are unknown through a pointer; a
 * failure of one of those exits 100 upward. */
typedef unsigned long long usize;

struct flex { int n; char buf[]; };
struct zero { int n; char buf[0]; };
struct one { int n; char buf[1]; };
struct four { int n; char buf[4]; };
struct mid { int n; char buf[4]; int tail; };

static struct flex flex_s;
static struct zero zero_s;
static struct one one_s;
static struct four four_s;
static struct mid mid_s;

#define MEMBER(bit, expr, bytes)                                            \
    do {                                                                    \
        usize max = __builtin_object_size(expr, 1);                         \
        usize min = __builtin_object_size(expr, 3);                         \
        if (__builtin_object_size(expr, 0) != (usize)-1)                    \
            return 100 + (bit);                                             \
        if (__builtin_object_size(expr, 2) != 0)                            \
            return 110 + (bit);                                             \
        if (max == (usize)-1) {                                             \
            if (min != 0)                                                   \
                return 120 + (bit);                                         \
        } else {                                                            \
            if (max != (bytes) || min != (bytes))                           \
                return 130 + (bit);                                         \
            code |= 1 << (bit);                                             \
        }                                                                   \
    } while (0)

int main(void) {
    struct flex *fp = &flex_s;
    struct zero *zp = &zero_s;
    struct one *op = &one_s;
    struct four *pp = &four_s;
    struct mid *mp = &mid_s;
    int code = 0;
    MEMBER(0, fp->buf, 0);
    MEMBER(1, zp->buf, 0);
    MEMBER(2, op->buf, 1);
    MEMBER(3, pp->buf, 4);
    MEMBER(4, mp->buf, 4);
    return code;
}
