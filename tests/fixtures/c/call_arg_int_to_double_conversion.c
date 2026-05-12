// Regression for C99 6.5.2.2p7 / 6.5.16.1p2 argument conversion.
// When a function prototype declares a parameter of type
// `double`, an integer-typed actual argument must be lifted to
// the IEEE-754 representation at the call site so the FP-arg
// register receives the right bit pattern. Without the lift,
// the integer bit pattern lands in the GPR-arg register and
// libm's `pow(x, n)` reads garbage out of the FP register
// (the result was a function of leftover FP-register state).

#include <stdio.h>
#include <math.h>

int main(void) {
    /* pow's prototype is double pow(double, double). The
     * literal `2` (an int) must be converted to double 2.0
     * at the call site, not bit-cast into the FP register. */
    if (pow(2.0, 1) != 2.0) return 1;
    if (pow(2.0, 2) != 4.0) return 2;
    if (pow(2.0, 3) != 8.0) return 3;
    if (pow(2.0, 4) != 16.0) return 4;

    /* Same expectation with a variable holding the integer. */
    int dim;
    dim = 2;
    if (pow(2.0, dim) != 4.0) return 5;
    dim = 3;
    if (pow(2.0, dim) != 8.0) return 6;

    /* And with an explicit cast (which already worked before
     * the fix -- regression-only check). */
    if (pow(2.0, (double)2) != 4.0) return 7;

    printf("call-arg int-to-double OK\n");
    return 0;
}
