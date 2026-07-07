// C99 6.6: the conversion of an integer constant to a floating type is
// itself a constant. The builder folds `(float)K` / `(double)K` to the
// converted floating constant, so no runtime int-to-FP conversion is
// materialised. Runtime checks pin the values; the SSA snapshot pins
// the folded `Imm [f32]` / `Imm` constants (no `FpCast`, no `scvtf`).

static float use_f(float x) { return x; }
static double use_d(double x) { return x; }

int main(void) {
    // Folded float constants.
    if (use_f((float)6) != 6.0f) return 1;
    if (use_f((float)-3) != -3.0f) return 2;
    if (use_f((float)100) != 100.0f) return 3;

    // Folded double constants.
    if (use_d((double)6) != 6.0) return 4;
    if (use_d((double)-3) != -3.0) return 5;

    // A folded constant is bit-identical to the equivalent literal.
    if ((float)16777217 != 16777216.0f) return 6;
    if ((float)16777219 != 16777220.0f) return 7;

    // Unsigned-64 source folds through the unsigned conversion.
    if ((float)18000000000000000000UL != 18000000000000000000.0f) return 8;

    // A constant-heavy expression: every coefficient is an integer
    // literal cast to float, so the whole polynomial is constant-folded
    // coefficients times the one runtime input.
    float x = use_f(2.0f);
    float y = (float)3 * x * x + (float)5 * x + (float)7;
    if (y != 29.0f) return 9;

    return 0;
}
