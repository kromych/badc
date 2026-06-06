// C99 6.2.5p10 / 6.3.1.8: a `float` argument is passed at single
// precision in a floating-point argument register (s0 / xmm0). This
// fixture proves a `float` argument and a `float` return value carry
// the correct single-precision values across a c5-internal call. The
// chosen values are exactly representable in f32, so the result is
// bit-stable and the fixture exits 0 on a correct single-precision
// path (matching the native compiler under the fixture-parity
// harness).

static float scale(float a, float b) {
    return a * b;
}

static float add3(float a, float b, float c) {
    return a + b + c;
}

int main(void) {
    // 1.5f * 0.25f = 0.375f, exactly representable in f32.
    float r = scale(1.5f, 0.25f);
    if (r != 0.375f) return 1;

    // A negative operand and a power-of-two operand: -2.5f * 4.0f = -10.0f.
    float s = scale(-2.5f, 4.0f);
    if (s != -10.0f) return 2;

    // Three single-precision args summed; 0.5 + 0.25 + 0.125 = 0.875f.
    float t = add3(0.5f, 0.25f, 0.125f);
    if (t != 0.875f) return 3;

    // Carry a computed (non-constant) float into the call to defeat any
    // constant-folding into an integer slot.
    float u = 1.0f / 8.0f;       // 0.125f, exact
    float v = scale(u, 16.0f);   // 0.125 * 16 = 2.0f
    if (v != 2.0f) return 4;

    return 0;
}
