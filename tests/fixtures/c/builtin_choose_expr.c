/* GCC `__builtin_choose_expr(const, e1, e2)`: the chosen operand IS the
 * expression -- its exact type carries through (a `?:` rewrite would
 * apply the usual arithmetic conversions and widen a chosen `_Bool` or
 * `char`), and the unchosen operand is parsed but never evaluated. */
#include <stdio.h>

/* The qualifier-strip idiom: pick a declaration type by matching the
 * operand's type through nested chooses. The chosen arm's type must
 * survive `typeof` exactly, so the declared temp is 1 byte wide and a
 * 1-byte atomic store into it is read back at the same width. */
#define pick_decl_type(expr)                                            \
    typeof(__builtin_choose_expr(                                       \
        __builtin_types_compatible_p(typeof(expr), _Bool) ||            \
            __builtin_types_compatible_p(typeof(expr), const _Bool),    \
        (_Bool)1,                                                       \
        __builtin_choose_expr(                                          \
            __builtin_types_compatible_p(typeof(expr), signed char),    \
            (signed char)1,                                             \
            (expr) + 0)))

struct dev {
    char pad[56];
    _Bool ready;
};

static void dirty_stack(void) {
    volatile long a[16];
    for (int i = 0; i < 16; i++)
        a[i] = -1;
}

static int is_ready(struct dev *d) {
    _Bool *ptr = &d->ready;
    return ({
        pick_decl_type(*ptr) v;
        __atomic_load(ptr, &v, __ATOMIC_ACQUIRE);
        v;
    });
}

int main(void) {
    if (sizeof(__builtin_choose_expr(1, (char)0, 1.5)) != 1)
        return 1;
    if (sizeof(__builtin_choose_expr(0, (char)0, 1.5)) != sizeof(double))
        return 2;
    typeof(__builtin_choose_expr(1, (_Bool)1, (long)2)) b = 1;
    if (sizeof(b) != 1 || b != 1)
        return 3;

    /* The unchosen operand is not evaluated. */
    int n = 0;
    int v = __builtin_choose_expr(1, 7, n++);
    if (v != 7 || n != 0)
        return 4;
    int w = __builtin_choose_expr(0, n++, 9);
    if (w != 9 || n != 0)
        return 5;

    int x = __builtin_choose_expr(0, 1, __builtin_choose_expr(1, 2, 3));
    if (x != 2)
        return 6;

    struct dev d = {{0}, 0};
    dirty_stack();
    if (is_ready(&d) != 0)
        return 7;
    d.ready = 1;
    if (is_ready(&d) != 1)
        return 8;
    return 0;
}
