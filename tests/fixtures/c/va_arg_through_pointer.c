// Regression: va_arg on a va_list reached through a pointer.
//
// A function may forward its va_list by address (`va_list *`) and the
// callee reads arguments with `va_arg(*pva, T)`. The macro expands the
// first operand to the va_list's address; relying on array-to-pointer
// decay of `*pva` instead read the list's first eightbyte (the gp/fp
// offsets) as the address, so va_arg returned garbage. CPython's
// Py_BuildValue passes the va_list this way through do_mkvalue.

#include <stdarg.h>

static const char *got_s;
static int got_n;
static double got_d;

static void inner(va_list *pva) {
    got_s = va_arg(*pva, const char *);
    got_n = va_arg(*pva, int);
    got_d = va_arg(*pva, double);
}

static void outer(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    inner(&ap);
    va_end(ap);
}

int main(void) {
    outer("x", "hello", 42, 1.5);
    if (got_n != 42) {
        return 1;
    }
    if (got_d != 1.5) {
        return 2;
    }
    // Dereference the forwarded pointer -- a bad va_arg result is a
    // wild pointer that faults here.
    if (got_s[0] != 'h' || got_s[4] != 'o') {
        return 3;
    }
    return 0;
}
