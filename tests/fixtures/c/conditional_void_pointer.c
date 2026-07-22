/* C99 6.5.15p6 for a conditional whose arms are both pointers, in the
 * order the standard gives: a null pointer constant arm takes the other
 * arm's type; otherwise a `void *` arm against a pointer to an object
 * type yields `void *`.
 *
 * The null-pointer-constant test is a value test, not a structural one:
 * `(void *)0` is one, `(void *)(x * 0)` for an object `x` is not, and
 * the two are spelled alike. The compile-time-constant detection idiom
 * below is built entirely on that distinction -- it reports whether its
 * operand is a constant expression by asking which arm's type won.
 *
 * A struct with no named member has size 0 (gcc / clang C extension),
 * which the `sizeof(struct { int:-!!(e); })` assertion idiom needs. */

#define is_constexpr(x) \
    (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))

#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int : (-!!(e)); })))

#define MASK_INPUT_CHECK(h, l) \
    (BUILD_BUG_ON_ZERO(__builtin_choose_expr(is_constexpr((l) > (h)), (l) > (h), 0)))
#define __MASK(h, l) \
    (((~0ULL) - (1ULL << (l)) + 1) & (~0ULL >> (64 - 1 - (h))))
#define MASK(h, l) (MASK_INPUT_CHECK(h, l) + __MASK(h, l))

struct obj {
    int a;
    int b;
};

static int g;

/* Runtime arguments: the check must fold to 0 without demanding that
 * `(l) > (h)` be a constant expression. */
static unsigned long long mask_dyn(int h, int l) {
    return MASK(h, l);
}

int main(void) {
    /* Both arms pointers, neither a null pointer constant: `void *`
     * wins, in either arm order. */
    if (sizeof(*(8 ? ((void *)((long)(g) * 0l)) : (int *)8)) != 1)
        return 1;
    if (sizeof(*(8 ? (int *)8 : ((void *)((long)(g) * 0l)))) != 1)
        return 2;
    if (sizeof(*(g ? (void *)&g : (struct obj *)&g)) != 1)
        return 3;

    /* A null pointer constant arm takes the other arm's type, however
     * it is spelled. */
    if (sizeof(*(8 ? (void *)0 : (int *)8)) != sizeof(int))
        return 4;
    if (sizeof(*(8 ? (void *)((long)0 * 0l) : (int *)8)) != sizeof(int))
        return 5;
    if (sizeof(*(g ? (void *)0 : (struct obj *)&g)) != sizeof(struct obj))
        return 6;
    /* A plain integer 0 arm likewise keeps the pointer arm's type. */
    if (sizeof(*(g ? (struct obj *)&g : 0)) != sizeof(struct obj))
        return 7;

    /* A struct with no named member is zero-sized. */
    if (sizeof(struct {}) != 0)
        return 8;
    if (sizeof(struct { int : 0; }) != 0)
        return 9;
    if (BUILD_BUG_ON_ZERO(0) != 0)
        return 10;

    /* The constant-expression detector: 1 for constants, 0 otherwise. */
    if (is_constexpr(1 > 2) != 1)
        return 11;
    if (is_constexpr(5) != 1)
        return 12;
    if (is_constexpr(g) != 0)
        return 13;
    if (is_constexpr(mask_dyn(3, 1) > 2) != 0)
        return 14;

    /* Constant and runtime argument forms agree on the value. */
    if (MASK(39, 21) != 0xffffe00000ULL)
        return 15;
    if (mask_dyn(39, 21) != 0xffffe00000ULL)
        return 16;
    if (mask_dyn(7, 0) != 0xffULL)
        return 17;

    return 0;
}
