// C99 6.5.16.2: compound assignment is the same arithmetic
// step as the binary operator, so `E1 OP= E2` follows the
// usual-arithmetic-conversions rule. When the lvalue is FP and
// the rvalue is an integer literal, c5 must lift the int side
// to FP -- otherwise `phase *= -1` (FP lvalue, int rvalue)
// hands `Op::Fmul` the 64-bit signed `-1` bit pattern and
// produces NaN.
//
// Surfaced compiling a libm-heavy library through -O, where `phase *= -1;` flips the
// inverse-FFT twiddle factor sign. clang/gcc already do this
// promotion via the regular usual-arith path; c5 used to skip
// it for compound-assign even though the binary `*` did the
// lift.
#include <stdio.h>

int main(void) {
    double a = 1.5;
    a *= -1;       // expect a == -1.5 (was NaN before)
    if (a != -1.5) return 1;
    a *= 2;        // expect -3.0
    if (a != -3.0) return 1;
    a += 1;        // expect -2.0
    if (a != -2.0) return 1;
    a -= 1;        // expect -3.0
    if (a != -3.0) return 1;
    a /= 3;        // expect -1.0
    if (a != -1.0) return 1;
    return 17;
}
