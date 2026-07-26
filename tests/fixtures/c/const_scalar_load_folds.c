// A load of a file-scope `const` scalar folds to its initializer: C99
// 6.7.3p5 makes modifying an object defined with a const-qualified type
// undefined, so the initializer's bytes are the object's value for the
// whole execution. A guard on such a flag therefore resolves and the
// build-time-assert call is unreachable. Linking is the assertion.
//
// The qualifier must reach the object, not just a pointee: in
// `const char *t[2]` the elements are writable, so `t[0]`'s load must
// not fold. That case is checked by value below.

#define BUILD_BUG_ON(cond, tag)                                                                    \
    do {                                                                                           \
        extern void compiletime_assert_##tag(void);                                                \
        if (!(!(cond)))                                                                            \
            compiletime_assert_##tag();                                                            \
    } while (0)

static const _Bool class_mutex_intr_is_conditional = 1;
static const _Bool class_mutex_is_conditional = 0;
static const int class_mutex_intr_depth = 3;
static const unsigned char class_mutex_intr_kind = 200;
static const long class_mutex_intr_mask = -4;

static int scoped_cond_guard(void) {
    BUILD_BUG_ON(!class_mutex_intr_is_conditional, 424);
    BUILD_BUG_ON(class_mutex_is_conditional, 386);
    BUILD_BUG_ON(class_mutex_intr_depth != 3, 425);
    BUILD_BUG_ON(class_mutex_intr_kind != 200, 426);
    BUILD_BUG_ON(class_mutex_intr_mask >= 0, 427);
    return class_mutex_intr_depth;
}

// `const` reaches `char`, so the array elements are writable objects and
// keep their loads.
static const char *names[2] = {(const char *)1, (const char *)2};

static void rename_first(void) { names[0] = (const char *)99; }

static long first_name(void) { return (long)names[0]; }

int main(void) {
    if (scoped_cond_guard() != 3)
        return 1;
    if (first_name() != 1)
        return 2;
    rename_first();
    if (first_name() != 99)
        return 3;
    return 0;
}
