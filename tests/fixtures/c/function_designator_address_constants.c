// Address constants a function designator builds through `*` and `&` (C99
// 6.6p9), a cast to a function pointer type or a `const` object's function
// pointer add GNU arithmetic's byte offset. The exit status is the failing check.
#include <stdint.h>

static int fn(void) { return 1; }
static long g(void) { return 2; }

static int (*fa)(void) = *fn;
static int (*fb)(void) = &*fn;
static int (*fc)(void) = **fn;
static int (*fd)(void) = *&fn;
static int (*fe)(void) = *(int (*)(void))fn;

struct row {
    char *deref, *addr_deref, *cast_deref, *addr, *deref_sum, *cast_int, *cast_long;
};
#define ROW(k)                                                                 \
    {                                                                          \
        (char *)(*fn + k), (char *)(&*fn + k), (char *)(*(int (*)(void))fn + k), \
        (char *)(&fn + k), (char *)(*fn - 1 + (k + 1)),                          \
        (char *)((int (*)(void))fn + k), (char *)((long (*)(void))g + k)         \
    }
static struct row rows[] = { ROW(1), ROW(3), ROW(8), ROW(40), ROW(200) };
static const long off[] = { 1, 3, 8, 40, 200 };

static void *s3 = &*fn + 3;
static void *z8 = (int (*)(void))0 + 8;
static char *ip = (char *)(&((int *)fn)[1] + 1);
static int (*const cfp)(void) = fn;
static const struct {
    long (*f)(void);
} cs = { g };
static char *r1 = (char *)(cfp + 1);
static char *r40 = (char *)(cs.f + 40);
enum {
    STRIDE = (char *)(&fn + 1) - (char *)&fn,
    CAST_INT = (char *)((int (*)(void))fn + 1) - (char *)fn,
    CAST_LONG = (char *)((long (*)(void))g + 1) - (char *)g,
};

#define D(p, f) ((long)((uintptr_t)(p) - (uintptr_t)(f)))

int main(void) {
    if (fa() + fb() + fc() + fd() + fe() != 5)
        return 1;
    for (int i = 0; i < 5; i++) {
        struct row *r = &rows[i];
        long k = off[i];
        if (D(r->deref, fn) != k || D(r->addr_deref, fn) != k || D(r->cast_deref, fn) != k)
            return 2 + i;
        if (D(r->addr, fn) != k || D(r->deref_sum, fn) != k || D(r->cast_int, fn) != k ||
            D(r->cast_long, g) != k)
            return 7 + i;
    }
    if (D(s3, fn) != 3 || (uintptr_t)z8 != 8)
        return 12;
    if (STRIDE != 1 || CAST_INT != 1 || CAST_LONG != 1)
        return 13;
    if (D(ip, fn) != 2 * (long)sizeof(int))
        return 14;
    if (D(r1, fn) != 1 || D(r40, g) != 40)
        return 15;
    return 0;
}
