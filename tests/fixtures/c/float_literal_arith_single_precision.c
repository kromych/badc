// C99 6.3.1.8: `float op float-constant` stays in single precision --
// an `f`-suffixed literal has type float (6.4.4.2p4), so no widen /
// narrow hop brackets the operation. Runtime checks pin the values;
// the SSA snapshot pins the single-precision ops.

static float step(float x) {
    return x - 1.0f;
}

static float blend(float x, float y) {
    return x * 0.5f + y * 0.25f;
}

int main(void) {
    if (step(2.5f) != 1.5f) return 1;
    if (blend(3.0f, 8.0f) != 3.5f) return 2;

    // Accumulation where f32 and f64 intermediates diverge: ten
    // additions of 0.1f in f32 land at 1.0000001f, not 1.0f.
    float sum = 0.0f;
    for (int i = 0; i < 10; i++) {
        sum = sum + 0.1f;
    }
    if (sum == 1.0f) return 3;
    if (sum != 1.0000001f) return 4;

    return 0;
}
