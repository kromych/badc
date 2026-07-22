// `__builtin_va_list` is a builtin type name: freestanding code
// typedefs it directly (`typedef __builtin_va_list va_list;`) with no
// header, and the __builtin_va_* operations take the GCC call shapes
// (the va_list and the rightmost fixed parameter by name;
// __builtin_va_arg yields the argument value). <stdarg.h>'s own
// `typedef __builtin_va_list va_list;` re-registers the identical
// alias, so including it afterwards must still compile.
typedef __builtin_va_list va_list;
#include <stdarg.h>

static int sum(int n, ...) {
    va_list ap;
    __builtin_va_start(ap, n);
    int s = 0;
    for (int i = 0; i < n; i++) {
        s += __builtin_va_arg(ap, int);
    }
    __builtin_va_end(ap);
    return s;
}

// __builtin_va_copy: both lists walk independently.
static int sum_twice(int n, ...) {
    va_list ap;
    va_list aq;
    __builtin_va_start(ap, n);
    __builtin_va_copy(aq, ap);
    int s = 0;
    for (int i = 0; i < n; i++) {
        s += __builtin_va_arg(ap, int);
    }
    for (int i = 0; i < n; i++) {
        s += __builtin_va_arg(aq, int);
    }
    __builtin_va_end(ap);
    __builtin_va_end(aq);
    return s;
}

// Mixed argument classes route per the target ABI (pointer / fp / int),
// and the rightmost fixed parameter may itself be a pointer.
static int mixed(const char *tag, ...) {
    va_list ap;
    __builtin_va_start(ap, tag);
    const char *s = __builtin_va_arg(ap, const char *);
    double d = __builtin_va_arg(ap, double);
    int i = __builtin_va_arg(ap, int);
    __builtin_va_end(ap);
    return tag[0] == 't' && s[0] == 'x' && d == 2.5 && i == 7;
}

// C99 7.15.3-style forwarding: a va_list parameter walks the caller's
// list (record form passes the decayed record pointer; cursor form
// advances the callee's copy).
static int vsum(int n, va_list ap) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        s += __builtin_va_arg(ap, int);
    }
    return s;
}

static int forward(int n, ...) {
    va_list ap;
    __builtin_va_start(ap, n);
    int r = vsum(n, ap);
    __builtin_va_end(ap);
    return r;
}

// The <stdarg.h> macros expand to the same builtins.
static int macro_sum(int n, ...) {
    va_list ap;
    va_start(ap, n);
    int s = 0;
    for (int i = 0; i < n; i++) {
        s += va_arg(ap, int);
    }
    va_end(ap);
    return s;
}

struct carrier {
    int tag;
    __builtin_va_list ap;
};

int main(void) {
    if (sum(3, 10, 14, 18) != 42) {
        return 1;
    }
    if (sum_twice(3, 1, 2, 4) != 14) {
        return 2;
    }
    if (!mixed("t", "x", 2.5, 7)) {
        return 3;
    }
    if (forward(4, 1, 2, 3, 4) != 10) {
        return 4;
    }
    if (macro_sum(2, 20, 22) != 42) {
        return 5;
    }
    // The builtin spelling declares objects and members directly and
    // matches <stdarg.h>'s va_list representation.
    if (sizeof(__builtin_va_list) != sizeof(va_list)) {
        return 6;
    }
    struct carrier c;
    c.tag = 3;
    if (sizeof(c.ap) != sizeof(va_list) || c.tag != 3) {
        return 7;
    }
    return 0;
}
