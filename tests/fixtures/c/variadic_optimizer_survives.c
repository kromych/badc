// C99 6.5.2.2: a call to a user-defined variadic function must
// deliver every fixed and variadic argument intact. The c5
// `va_start(ap, last)` macro expands to a `Lea LAST; Psh; Imm 2;
// Psh; Imm 8; Mul; Add; Si` sequence; the bytecode optimizer's
// immediate-arith fusion rewrites `Psh; Imm 8; Mul` into a single
// `MulI 8`. If the codegen detects variadicness by matching that
// byte pattern, the optimizer's fusion blinds it and the call
// path collapses to the non-variadic host-ABI marshalling -- the
// callee's prologue spills only the fixed register args and the
// variadic tail in x1..x7 / rsi..r9 is lost.
//
// The fixture defines a variadic forwarder and asserts that two
// variadic ints round-trip through it. Failure shows up as a
// non-zero return code: 1 means the first variadic arg got
// clobbered, 2 means the second.

#include <stdarg.h>

int check_two(const char *fmt, ...) {
    va_list ap;
    int a;
    int b;
    va_start(ap, fmt);
    a = va_arg(ap, int);
    b = va_arg(ap, int);
    va_end(ap);
    if (a != 42) return 1;
    if (b != 7)  return 2;
    return 0;
}

int main(void) {
    return check_two("ignored", 42, 7);
}
