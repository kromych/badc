// C99 6.3.1.8 + 6.3.1.5: when a `float` operand meets a `double`
// operand, the float is converted to double and the operation is
// performed in double precision. Explicit casts widen / narrow at the
// genuine precision-change points. This fixture proves the conversions
// still happen with the single-precision arithmetic path in place.

// `float + double` is a double operation. 0.1f (an f32 value) added to
// the double 0.2 must be computed in double, not f32.
static int float_plus_double_is_double(void) {
    float f = 0.1f;
    double d = 0.2;
    double sum = f + d;
    // The double 0.1f is 0.100000001490116119384765625; added to 0.2
    // the double result is 0.300000001490116. Distinct from 0.3.
    double diff = sum - 0.30000000149011612;
    if (diff < 0) diff = -diff;
    if (diff > 1e-15) return 1;
    return 0;
}

// `(double)f` widens; the widened value carries the float's exact
// (limited) precision, NOT the precision of the original decimal text.
static int widen_preserves_float_value(void) {
    float f = 0.1f;
    double d = (double)f;
    // d is exactly the double 0.1f = 0.100000001490116119...
    double diff = d - 0.10000000149011612;
    if (diff < 0) diff = -diff;
    if (diff > 1e-17) return 2;
    return 0;
}

// `(float)d` narrows a double to single precision, dropping bits.
static int narrow_drops_precision(void) {
    double d = 0.123456789012345;
    float f = (float)d;
    // f is the f32-rounded value 0.12345679 (~0.123456791043282).
    float ref = 0.12345679f;
    float diff = f - ref;
    if (diff < 0) diff = -diff;
    if (diff > 1e-8f) return 3;
    // A round-trip back to double must not recover the original double.
    double back = (double)f;
    double dd = back - d;
    if (dd < 0) dd = -dd;
    if (dd < 1e-9) return 4; // too close => narrowing didn't drop bits
    return 0;
}

// Assigning a double expression to a float object narrows it.
static int assign_double_to_float_narrows(void) {
    double d = 1.0 / 3.0;     // double 1/3
    float f = d;              // narrowed to f32 1/3
    float ref = 0.333333343f;
    float diff = f - ref;
    if (diff < 0) diff = -diff;
    if (diff > 1e-7f) return 5;
    return 0;
}

int main(void) {
    int r;
    if ((r = float_plus_double_is_double()) != 0) return r;
    if ((r = widen_preserves_float_value()) != 0) return r;
    if ((r = narrow_drops_precision()) != 0) return r;
    if ((r = assign_double_to_float_narrows()) != 0) return r;
    return 0;
}
