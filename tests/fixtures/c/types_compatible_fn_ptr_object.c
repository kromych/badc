// __builtin_types_compatible_p over typeof of a function-pointer
// object -- a local or global variable, a struct member reached through
// a (const) pointer, or an array element. The object's parse recovers
// the pointee prototype the flat type tag cannot spell, so comparing it
// with the same type written as a cast or as a bare type name decides 1
// at translation time; a differing parameter list, arity, variadic-ness,
// or indirection depth decides 0. The guarded calls to never-defined
// helpers must not survive to the link (the compile-time-assert shape).

struct ctx;

struct ops {
    void *(*lookup)(struct ctx *c, void *key);
    long (*update)(struct ctx *c, void *key, void *val, unsigned long long flags);
    void (*bare)(void);
    int (*vfmt)(const char *fmt, ...);
    int (**chain)(int);
};

static void *(*g_lookup)(struct ctx *c, void *key);

extern void absent_member_cast(void);
extern void absent_local_cast(void);
extern void absent_local_name(void);
extern void absent_global_cast(void);
extern void absent_element_cast(void);
extern void absent_zero_param(void);

int main(void) {
    const struct ops *ops = 0;
    void *(*fp)(struct ctx *c, void *key);
    long (*tab[2])(struct ctx *c, void *key);
    void **not_a_fn_ptr;
    int i = 1;

    // The compile-time-assert expansion: a dead guarded call to an
    // undefined helper, pruned only when the comparison decides 1.
    if (!__builtin_types_compatible_p(
            typeof(ops->lookup), typeof((void *(*)(struct ctx *c, void *key))((void *)0))))
        absent_member_cast();
    if (!__builtin_types_compatible_p(
            typeof(fp), typeof((void *(*)(struct ctx *, void *))0)))
        absent_local_cast();
    if (!__builtin_types_compatible_p(typeof(fp), void *(*)(struct ctx *, void *)))
        absent_local_name();
    if (!__builtin_types_compatible_p(
            typeof(g_lookup), typeof((void *(*)(struct ctx *, void *))0)))
        absent_global_cast();
    if (!__builtin_types_compatible_p(
            typeof(tab[i]), typeof((long (*)(struct ctx *, void *))0)))
        absent_element_cast();
    if (!__builtin_types_compatible_p(typeof(ops->bare), typeof((void (*)(void))0)))
        absent_zero_param();

    // Value positions: matching prototypes decide 1.
    if (__builtin_types_compatible_p(
            typeof(ops->update),
            typeof((long (*)(struct ctx *, void *, void *, unsigned long long))0)) != 1)
        return 1;
    if (__builtin_types_compatible_p(
            typeof(ops->vfmt), typeof((int (*)(const char *, ...))0)) != 1)
        return 2;
    if (__builtin_types_compatible_p(typeof(ops->chain), typeof((int (**)(int))0)) != 1)
        return 3;

    // Differing parameter type, arity, variadic-ness, or depth decide 0.
    if (__builtin_types_compatible_p(
            typeof(ops->lookup), typeof((void *(*)(struct ctx *, long))0)) != 0)
        return 4;
    if (__builtin_types_compatible_p(
            typeof(ops->lookup), typeof((void *(*)(struct ctx *))0)) != 0)
        return 5;
    if (__builtin_types_compatible_p(
            typeof(ops->vfmt), typeof((int (*)(const char *))0)) != 0)
        return 6;
    if (__builtin_types_compatible_p(typeof(ops->chain), typeof((int *(*)(int))0)) != 0)
        return 7;
    // A data pointer sharing the function pointer's flat shape is not a
    // function type.
    if (__builtin_types_compatible_p(
            typeof(not_a_fn_ptr), typeof((void *(*)(void))0)) != 0)
        return 8;

    (void)fp;
    (void)not_a_fn_ptr;
    return 0;
}
