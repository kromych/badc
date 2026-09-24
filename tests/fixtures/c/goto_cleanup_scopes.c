// A jump out of the scope of `__attribute__((cleanup(fn)))` variables runs
// `fn(&var)` for each once, innermost scope first and latest declaration
// first, whether by `goto`, computed `goto`, `break`, `continue` or
// `return`; a backward `goto` past a declaration runs its cleanup too. The
// kernel's `guard()`, `scoped_guard()` and `__free()` below follow
// include/linux/cleanup.h. Exits 0, or the number of the first failed check.

#include <stdlib.h>

static char trace[64];
static int n;
static void rec(char c) {
    trace[n++] = c;
    trace[n] = 0;
}
static void c_a(int *p) {
    (void)p;
    rec('a');
}
static void c_b(int *p) {
    (void)p;
    rec('b');
}
static void c_c(int *p) {
    (void)p;
    rec('c');
}
static void c_d(int *p) {
    (void)p;
    rec('d');
}
static void c_val(int *p) {
    rec((char)*p);
}
#define CL(f) __attribute__((cleanup(f)))

static int checks, failed;
static void expect_true(int ok) {
    checks++;
    if (!ok && !failed)
        failed = checks;
}
static void expect(const char *want) {
    int i = 0;
    while (trace[i] && trace[i] == want[i])
        i++;
    expect_true(trace[i] == want[i]);
    n = 0;
    trace[0] = 0;
}

// The issue's shapes: a guard held across each kind of exit.
static int held, released;
static void unlock(int **p) {
    (void)p;
    held = 0;
    released++;
}
#define GUARD int *guard_var __attribute__((cleanup(unlock))) = (held = 1, &held)

static int by_goto(int x) {
    {
        GUARD;
        if (x)
            goto out;
        held = held;
    }
out:
    return held;
}

static int by_break(void) {
    for (int i = 0; i < 3; i++) {
        GUARD;
        if (i == 1)
            break;
    }
    return held;
}

static int by_continue(void) {
    int k = 0;
    for (int i = 0; i < 3; i++) {
        GUARD;
        k++;
        if (i < 2)
            continue;
    }
    return held + (k != 3);
}

static int by_return_inner(int *seen) {
    {
        GUARD;
        *seen = held;
        return 5;
    }
}

// Two objects in each of two nested scopes, left by each kind of exit.
static int exits(int how) {
    for (int i = 0; i < 2; i++) {
        int a CL(c_a) = 0;
        int b CL(c_b) = 0;
        {
            int c CL(c_c) = 0;
            int d CL(c_d) = 0;
            (void)a, (void)b, (void)c, (void)d;
            if (how == 0)
                goto out;
            if (how == 1)
                break;
            if (how == 2 && i == 0)
                continue;
            if (how == 3)
                return 1;
        }
        rec('.');
    }
out:
    rec('|');
    return 0;
}

// A goto leaves only the declarations it has passed.
static void nested(int x) {
    {
        int a CL(c_a) = 0;
        int b CL(c_b) = 0;
        {
            int c CL(c_c) = 0;
            if (x)
                goto out;
            int d CL(c_d) = 0;
            (void)a, (void)b, (void)c, (void)d;
        }
    }
out:
    rec('|');
}

// A shadowing declaration: each cleanup receives its own object.
static void shadow(void) {
    int s CL(c_val) = 'x';
    {
        int s CL(c_val) = 'y';
        (void)s;
        goto out;
    }
out:
    (void)s;
    rec('|');
}

// A backward goto past a declaration in the same scope runs its cleanup.
static void backward(void) {
    int k = 0;
    {
    again:;
        int a CL(c_a) = 0;
        (void)a;
        if (k++ < 2)
            goto again;
    }
    rec('|');
}

// A goto out of a switch case block, and one staying inside a scope.
static void from_case(int s) {
    switch (s) {
    case 0: {
        int a CL(c_a) = 0;
        (void)a;
        goto out;
    }
    case 1: {
        int b CL(c_b) = 0;
        (void)b;
        goto next;
    next:
        rec('-');
        break;
    }
    }
out:
    rec('|');
}

// A computed goto runs what a goto to its target would; every label whose
// address is taken here is outside both scopes.
static void computed(int x) {
    void *t = x ? &&out : &&out2;
    {
        int a CL(c_a) = 0;
        {
            int b CL(c_b) = 0;
            (void)a, (void)b;
            goto *t;
        }
    }
out:
    rec('|');
    return;
out2:
    rec('!');
}

// Computed gotos among the labels of their own scope leave nothing.
static void dispatch(void) {
    int a CL(c_a) = 0;
    static const unsigned char prog[] = {1, 1, 0};
    void *ops[] = {&&op_end, &&op_x};
    int pc = 0;
    (void)a;
    goto *ops[prog[pc]];
op_x:
    rec('x');
    goto *ops[prog[++pc]];
op_end:
    rec('|');
}

// include/linux/cleanup.h, as the kernel spells it.
#define __cleanup(func) __attribute__((__cleanup__(func)))
#define __PASTE2(a, b) a##b
#define __PASTE(a, b) __PASTE2(a, b)
#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)

#define DEFINE_FREE(_name, _type, _free)                                                 \
    static inline void __free_##_name(void *p) {                                         \
        _type _T = *(_type *)p;                                                          \
        _free;                                                                           \
    }
#define __free(_name) __cleanup(__free_##_name)
#define __get_and_null(p, nullvalue)                                                     \
    ({                                                                                   \
        __auto_type __ptr = &(p);                                                        \
        __auto_type __val = *__ptr;                                                      \
        *__ptr = nullvalue;                                                              \
        __val;                                                                           \
    })
#define no_free_ptr(p) ((typeof(p))__get_and_null(p, NULL))

#define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)                          \
    typedef _type class_##_name##_t;                                                     \
    static inline void class_##_name##_destructor(_type *p) {                            \
        _type _T = *p;                                                                   \
        _exit;                                                                           \
    }                                                                                    \
    static inline _type class_##_name##_constructor(_init_args) {                        \
        _type t = _init;                                                                 \
        return t;                                                                        \
    }
#define CLASS(_name, var)                                                                \
    class_##_name##_t var __cleanup(class_##_name##_destructor) =                         \
        class_##_name##_constructor
#define DEFINE_GUARD(_name, _type, _lock, _unlock)                                       \
    DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T);        \
    static const int class_##_name##_is_conditional = 0;                                 \
    static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T) {                \
        return (void *)*_T;                                                              \
    }
#define guard(_name) CLASS(_name, __UNIQUE_ID(guard))
#define __guard_ptr(_name) class_##_name##_lock_ptr
#define __is_cond_ptr(_name) class_##_name##_is_conditional
#define __scoped_guard(_name, _label, args...)                                           \
    for (CLASS(_name, scope)(args); __guard_ptr(_name)(&scope) || !__is_cond_ptr(_name);  \
         ({ goto _label; }))                                                             \
        if (0) {                                                                         \
        _label:                                                                          \
            break;                                                                       \
        } else
#define scoped_guard(_name, args...) __scoped_guard(_name, __UNIQUE_ID(label), args)

struct mutex {
    int locked, acquisitions;
};
static void mutex_lock(struct mutex *m) {
    if (m->locked)
        abort(); // taken while held: the lock was leaked
    m->locked = 1;
    m->acquisitions++;
}
static void mutex_unlock(struct mutex *m) {
    if (!m->locked)
        abort(); // released twice
    m->locked = 0;
}
DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))

static int frees;
DEFINE_FREE(kfree, char *, if (_T) { free(_T); frees++; })

static struct mutex m;

// A goto out of a scoped_guard block, of a guard() scope and of a __free
// scope; each releases what it holds.
static int guarded(int which) {
    int r = 0;
    scoped_guard(mutex, &m) {
        if (which == 0)
            goto out;
        r = 1;
    }
    {
        guard(mutex)(&m);
        char *p __free(kfree) = malloc(16);
        if (which == 1)
            goto out;
        char *q __free(kfree) = malloc(16);
        if (which == 2)
            goto out;
        r = 2;
        (void)p, (void)q;
    }
    {
        char *keep __free(kfree) = malloc(8);
        char *mine = no_free_ptr(keep);
        free(mine);
        if (which == 3)
            goto out;
    }
    r = 3;
out:
    return r + m.locked * 100;
}

int main(void) {
    int seen = 0;
    released = 0;
    expect_true(by_goto(1) == 0 && released == 1);
    released = 0;
    expect_true(by_break() == 0 && released == 2);
    released = 0;
    expect_true(by_continue() == 0 && released == 3);
    released = 0;
    expect_true(by_return_inner(&seen) == 5 && seen == 1 && held == 0 && released == 1);
    exits(0);
    expect("dcba|");
    exits(1);
    expect("dcba|");
    exits(2);
    expect("dcbadc.ba|");
    expect_true(exits(3) == 1);
    expect("dcba");
    exits(4);
    expect("dc.badc.ba|");
    nested(1);
    expect("cba|");
    nested(0);
    expect("dcba|");
    shadow();
    expect("y|x");
    backward();
    expect("aaa|");
    from_case(0);
    expect("a|");
    from_case(1);
    expect("-b|");
    computed(1);
    expect("ba|");
    computed(0);
    expect("ba!");
    dispatch();
    expect("xx|a");
    static const int want[] = {0, 1, 1, 2, 3}, want_frees[] = {0, 1, 2, 2, 2};
    for (int which = 0; which < 5; which++) {
        frees = 0;
        expect_true(guarded(which) == want[which] && frees == want_frees[which]);
    }
    expect_true(m.acquisitions == 1 + 2 * 4);
    return failed;
}
