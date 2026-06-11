// Taking the address of a math function that c5 lowers to a hardware
// instruction for a direct call (sqrt, fabs, floor, ceil, trunc). A
// direct call still uses the instruction; the function's address is a
// valid pointer to the library function, so calling through the
// pointer computes the same result. Asserted by return code.
//
// Run under the native and JIT paths. The SSA interpreter resolves
// library calls by name and does not call a library function through a
// pointer taken from its address (the same limitation applies to any
// imported function), so this fixture is not run there.

#include <math.h>

int main(void) {
    double (*pf)(double) = fabs;
    double (*ps)(double) = sqrt;
    double (*pfl)(double) = floor;
    double (*pc)(double) = ceil;
    double (*pt)(double) = trunc;

    if (pf(-3.5) != 3.5) return 1;
    if (ps(16.0) != 4.0) return 2;
    if (pfl(2.7) != 2.0) return 3;
    if (pc(2.1) != 3.0) return 4;
    if (pt(2.9) != 2.0) return 5;

    // Address in a dispatch table.
    double (*tbl[3])(double) = { fabs, sqrt, floor };
    if (tbl[0](-9.0) != 9.0) return 6;
    if (tbl[1](81.0) != 9.0) return 7;
    if (tbl[2](5.9) != 5.0) return 8;

    // A direct call must still fold to the instruction and produce the
    // same value.
    if (fabs(-7.0) != 7.0) return 9;
    if (sqrt(49.0) != 7.0) return 10;

    return 0;
}
