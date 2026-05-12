// Regression: negative float literals in global / static array
// initializers. C99 6.6 admits a unary `-` on a numeric literal
// inside a constant expression; the float case has to flip the
// IEEE-754 sign bit on the f64 bit pattern rather than negate
// an integer value. c5 used to route a leading `-` through the
// parse_constant_int fallback, which then errored because the
// next token was a FloatNum, not a Num/Id.

#include <stdio.h>

static double const probe[3] = { 1.5, -2.5, -3.25e+10 };

int main(void) {
    /* Spot-check via direct compares against the same constants
     * spelled inline. If the parser lost the sign during the
     * initializer pass, `probe[1]` would still hold +2.5 and the
     * compare would trip. */
    if (probe[0] != 1.5) return 1;
    if (probe[1] != -2.5) return 2;
    if (probe[2] != -3.25e+10) return 3;
    /* Sum exercises FP add through the bytecode lane too; the
     * expected value is 1.5 + (-2.5) + (-3.25e+10) = -3.25e+10 - 1.0. */
    double sum = probe[0] + probe[1] + probe[2];
    if (sum > -3.25e+10 + 0.5 || sum < -3.25e+10 - 1.5) return 4;
    return 0;
}
