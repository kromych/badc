// Locks C99 6.5.2.2: an argument-list call through a function
// pointer must deliver every argument -- both fixed and variadic
// -- to the callee. The c5 codegen previously routed every
// address-taken function through a host-ABI -> c5-ABI shuffling
// thunk that allocated room for the fixed parameter count only,
// so a variadic callee read garbage from its declared variadic
// slots when invoked through a fn-pointer. Direct (non-pointer)
// calls were unaffected.
//
// The fixture passes a distinct integer per variadic slot so it
// runs through the c5 VM without any libc shim. Each failure
// path returns a distinct nonzero code. Two invocation shapes
// are covered: a bare function pointer and a function returned
// by the second operand of a comma operator (the upstream
// `tcc_error_noabort` / `TCC_SET_STATE` macro shape).

#include <stdarg.h>

static int sum_three(int mark, ...) {
    va_list ap;
    va_start(ap, mark);
    int a = va_arg(ap, int);
    int b = va_arg(ap, int);
    int c = va_arg(ap, int);
    va_end(ap);
    return mark * 1000 + a * 100 + b * 10 + c;
}

typedef int (*sum_t)(int, ...);

static int side_effect(void) { return 0; }

#define call_via_comma (side_effect(), sum_three)

int main(void) {
    if (sum_three(9, 1, 2, 3) != 9123) return 11;

    sum_t fp = sum_three;
    if (fp(9, 1, 2, 3) != 9123) return 12;

    if (call_via_comma(9, 1, 2, 3) != 9123) return 13;

    return 0;
}
