// A load of a file-scope `const` scalar folds to its initializer: C99
// 6.7.3p5 makes modifying an object defined with a const-qualified type
// undefined, so the initializer's bytes are the object's value for the
// whole execution. A guard on such a flag therefore resolves and the
// build-time-assert call is unreachable. Linking is the assertion.
//
// The qualifier must reach the object, not just a pointee: in
// `const char *t[2]` the elements are writable, so `t[0]`'s load must
// not fold. That case is checked by value below.

#define FAIL_IF(cond, tag)                                                                         \
    do {                                                                                           \
        extern void compiletime_assert_##tag(void);                                                \
        if (!(!(cond)))                                                                            \
            compiletime_assert_##tag();                                                            \
    } while (0)

static const _Bool guard_intr_is_conditional = 1;
static const _Bool guard_is_conditional = 0;
static const int guard_intr_depth = 3;
static const unsigned char guard_intr_kind = 200;
static const long guard_intr_mask = -4;

static int scoped_cond_guard(void) {
    FAIL_IF(!guard_intr_is_conditional, 424);
    FAIL_IF(guard_is_conditional, 386);
    FAIL_IF(guard_intr_depth != 3, 425);
    FAIL_IF(guard_intr_kind != 200, 426);
    FAIL_IF(guard_intr_mask >= 0, 427);
    return guard_intr_depth;
}

// Static storage duration reached from a block, in the function's own
// scope and in a nested one: the same object model, so the same fold.
static int block_scope_guard(void) {
    static const _Bool outer_is_conditional = 1;
    static const int outer_depth = 5;
    {
        static const _Bool inner_is_conditional = 1;
        FAIL_IF(!inner_is_conditional, 428);
    }
    FAIL_IF(!outer_is_conditional, 429);
    FAIL_IF(outer_depth != 5, 430);
    return outer_depth;
}

// A strong definition elsewhere replaces a weak one at link time, so the
// initializer here is not necessarily the object's value and the load
// stays. The SSA snapshot is the lock: within one program nothing
// overrides it, so the value is 11 either way.
__attribute__((weak)) const int weak_depth = 11;

static int weak_guard(void) { return weak_depth; }

// `const` reaches `char`, so the array elements are writable objects and
// keep their loads.
static const char *names[2] = {(const char *)1, (const char *)2};

static void rename_first(void) { names[0] = (const char *)99; }

static long first_name(void) { return (long)names[0]; }

int main(void) {
    if (scoped_cond_guard() != 3)
        return 1;
    if (block_scope_guard() != 5)
        return 2;
    if (weak_guard() != 11)
        return 3;
    if (first_name() != 1)
        return 4;
    rename_first();
    if (first_name() != 99)
        return 5;
    return 0;
}
