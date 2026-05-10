// Regression: floating-point arithmetic in a static / global
// array initializer.
//
// stb_image_write.h's `stbi_write_jpg_to_func` declares
//   static const float aasf[] = {
//     1.0f * 2.828427125f,
//     1.387039845f * 2.828427125f,
//     ...
//   };
// Each element is a constant-foldable float expression. c5 used
// to route every element through the integer constant evaluator
// (`parse_const_expr_*`), which has no float arithmetic path
// and rejected the `*` between literals as "constant integer
// expected (got tk=161)" (tk=161 is MulOp).
//
// Fix: when an initializer element starts with a float literal
// followed by `+` / `-` / `*` / `/`, fold the whole expression
// in `f64` precision and store the resulting bit pattern. Mixed
// integer-and-float operands work too -- the integer side is
// promoted to f64 first, matching C's usual arithmetic
// conversions for constant float expressions.

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
