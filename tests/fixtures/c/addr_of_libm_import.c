// Taking the address of a library math function that c5 does NOT lower to a
// hardware instruction (sin, cos, pow) -- a genuine dynamic import resolved
// at link time, unlike fabs/sqrt/floor/ceil/trunc which fold to instructions.
// The address must be a valid pointer to the library function so a call
// through the pointer, or through a dispatch table, computes the same result
// (C99 6.5.2.2). Asserted by return code.
//
// Run under the native and JIT paths only. The SSA interpreter resolves
// library calls by name and does not call a library function through a
// pointer taken from its address.

#include <math.h>

int main(void) {
    double (*ps)(double) = sin;
    double (*pc)(double) = cos;
    double (*pp)(double, double) = pow;

    if (ps(0.0) != 0.0) return 1;
    if (pc(0.0) != 1.0) return 2;
    if (pp(2.0, 10.0) != 1024.0) return 3;

    // Address in a dispatch table.
    double (*tbl[2])(double) = { sin, cos };
    if (tbl[0](0.0) != 0.0) return 4;
    if (tbl[1](0.0) != 1.0) return 5;

    // A direct call must produce the same value.
    if (cos(0.0) != 1.0) return 6;

    return 0;
}
