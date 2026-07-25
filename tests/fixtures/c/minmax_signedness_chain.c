/* The careful-comparison macro idiom: __builtin_choose_expr selected by
 * a conditional-operator constant-expression detector, guarded by a
 * signedness static_assert. Exercises C99 6.5.3.4p4 (sizeof types as
 * size_t, unsigned) and 6.5.15p6 (null-pointer-constant / void* arm
 * typing) together: mistyping either drives the chain to the wrong arm
 * or fires the assertion. */

#define __is_constexpr(x) \
    (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
#define __is_signed_type(type) (((type)(-1)) < ((type)1))
#define __is_signed(x) \
    __builtin_choose_expr(__is_constexpr(__is_signed_type(typeof(x))), \
        __is_signed_type(typeof(x)), 0)
#define __is_noneg_int(x) \
    (__builtin_choose_expr(__is_constexpr(x) && __is_signed(x), x, -1) >= 0)
#define __types_ok(x, y) \
    (__is_signed(x) == __is_signed(y) || \
        __is_signed((x) + 0) == __is_signed((y) + 0) || \
        __is_noneg_int(x) || __is_noneg_int(y))
#define __cmp(op, x, y) ((x) op(y) ? (x) : (y))
#define __cmp_once(op, x, y) \
    ({ \
        typeof(x) __x = (x); \
        typeof(y) __y = (y); \
        _Static_assert(__types_ok(x, y), "signedness error"); \
        __cmp(op, __x, __y); \
    })
#define min(x, y) \
    __builtin_choose_expr(__is_constexpr((x) - (y)), __cmp(<, x, y), \
        __cmp_once(<, x, y))

typedef struct {
    unsigned long long pme;
} entry_t;

struct pm {
    int pos;
};

static unsigned long f(unsigned long count, struct pm *pm) {
    /* Both operands unsigned (size_t * int converts to size_t): the
     * static_assert in the runtime arm must not fire. */
    return min(count, sizeof(entry_t) * pm->pos);
}

int main(void) {
    struct pm pm = { 3 };
    unsigned long c = 7;

    if (f(100, &pm) != 24)
        return 1;
    if (f(10, &pm) != 10)
        return 2;
    if (__is_signed(sizeof(entry_t) * pm.pos) != 0)
        return 3;
    if (!__types_ok(100ul, sizeof(entry_t) * pm.pos))
        return 4;
    /* Mixed signedness rescued by a non-negative signed constant. */
    if (!__types_ok(5, 100ul))
        return 5;
    if (min(c, 5) != 5)
        return 6;
    /* Both arms constant: the constant arm computes directly. */
    if (min(3, 5) != 3)
        return 7;
    if (__is_constexpr(pm.pos) != 0)
        return 8;
    if (__is_constexpr(sizeof(entry_t)) != 1)
        return 9;
    return 0;
}
