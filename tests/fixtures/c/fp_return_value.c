// C99 6.2.5p10: a function returning a floating-point scalar delivers
// the result in the floating-point return register (xmm0 / d0; s0 for
// `float`). This fixture exercises both a `double`- and a `float`-
// returning internal callee and uses the result in further arithmetic
// so the return value must be FP-classed, not delivered through the
// integer return register.

static double make_double(int n) {
    return (double)n + 0.5;
}

static float make_float(int n) {
    return (float)n / 4.0f;
}

int main(void) {
    // make_double(7) = 7.5; (7.5 + make_double(2)) = 7.5 + 2.5 = 10.0
    double d = make_double(7) + make_double(2);
    if (d != 10.0) return 1;

    // make_float(3) = 0.75f; make_float(5) = 1.25f; sum = 2.0f
    float f = make_float(3) + make_float(5);
    if (f != 2.0f) return 2;

    // Mix the two return paths in one expression.
    double m = make_double(1) * 2.0 + (double)make_float(6);
    // make_double(1) = 1.5; *2 = 3.0; make_float(6) = 1.5; total = 4.5
    if (m != 4.5) return 3;

    return 0;
}
