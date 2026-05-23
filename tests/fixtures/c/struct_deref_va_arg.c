// C99 6.5.3.2p4 + the c5 address-as-value rule: `*p` where `p`
// has type `struct T *` produces an rvalue whose representation
// is the struct's address. The surrounding struct-typed
// assignment / Mcpy / Member chain consumes that address; a
// trailing load would interpret the first 8 bytes of the
// struct as a pointer and read from a wrong location.
//
// Exercises the pattern through a variadic argument so the
// walker's `Expr::Unary { op: Deref, .. }` arm sees a
// struct-pointer child whose value comes from `va_arg` rather
// than from an immediately addressable local.

#include <stdio.h>
#include <stdarg.h>

struct M {
    int a;
    int b;
    int c;
    int d;
};

struct M g;

static void set_m(int dummy, ...) {
    va_list ap;
    va_start(ap, dummy);
    g = *va_arg(ap, struct M *);
    va_end(ap);
}

int main(void) {
    static const struct M defaults = { 11, 22, 33, 44 };
    set_m(0, &defaults);
    if (g.a != 11) return 1;
    if (g.b != 22) return 2;
    if (g.c != 33) return 3;
    if (g.d != 44) return 4;
    return 0;
}
