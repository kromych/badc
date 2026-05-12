// Regression: floating-point arithmetic in a static / global
// array initializer.
//
// C99 6.6 defines arithmetic constant expressions over
// floating-point operands; `*`, `/`, `+`, `-` and parens are
// all allowed alongside literals and named constants. c5 used
// to route every element through the integer constant evaluator
// (`parse_const_expr_*`), which has no float-arithmetic path
// and rejected the `*` between literals as "constant integer
// expected".
//
// Fix: when an initializer element starts with a float literal
// followed by `+` / `-` / `*` / `/`, fold the whole expression
// in `f64` precision and store the resulting bit pattern. Mixed
// integer-and-float operands work too -- per C99 6.3.1.8 usual
// arithmetic conversions, the integer side is promoted to
// `double` before the operation.

#include <stdio.h>

static const float aasf[3] = {
    1.0f * 2.0f,            /* 2.0 */
    -3.0f + 0.5f,           /* -2.5 */
    (1.0f + 2.0f) * 4.0f    /* 12.0 */
};

static const double dasf[2] = {
    1.387039845 * 2.828427125,   /* ~3.9230... */
    -0.5 - 0.25                   /* -0.75 */
};

int main(void) {
    if (aasf[0] != 2.0f) return 1;
    if (aasf[1] != -2.5f) return 2;
    if (aasf[2] != 12.0f) return 3;
    if (dasf[0] < 3.92 || dasf[0] > 3.93) return 4;
    if (dasf[1] != -0.75) return 5;
    return 0;
}
