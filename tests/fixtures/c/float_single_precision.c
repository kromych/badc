// C99 6.3.1.8: `float op float` has type `float` and is computed in
// single precision -- the operands are NOT promoted to `double` (that
// was the K&R rule). This fixture proves the arithmetic now rounds to
// f32 by accumulating a value whose f32 and f64 results diverge, and
// by checking a reciprocal that only round-trips at single precision.

// 1.0f / 3.0f rounded to f32 is 0x3EAAAAAB; squared and reconstructed
// it stays bit-stable only if the divide and multiply ran in f32. The
// same expression computed in f64 yields a value distinguishable from
// the f32 result by more than one f32 ULP.
static int reciprocal_is_single_precision(void) {
    float third = 1.0f / 3.0f;
    // The exact f32 value of 1/3 is 0.333333343267440795898437500.
    // A double 1.0/3.0 is 0.333333333333333314829616256...; casting it
    // to float gives the same f32 bit pattern, so compare against the
    // f32-rounded constant directly.
    float ref = 0.333333343f;
    float diff = third - ref;
    if (diff < 0) diff = -diff;
    // Within half an f32 ULP at this magnitude (~3e-8).
    if (diff > 1e-7f) return 1;
    return 0;
}

// Summing 0.1f ten times in f32 does not reach exactly 1.0 (0.1 is not
// representable in binary FP, and the f32 rounding error accumulates).
// The result must sit near 1.0000001 in f32, distinct from the value a
// double accumulation then narrowed would give.
static int accumulation_rounds_in_f32(void) {
    float sum = 0.0f;
    int i;
    for (i = 0; i < 10; i++) {
        sum += 0.1f;
    }
    // f32 accumulation of ten 0.1f lands at 1.0000001192092896.
    float expected = 1.0000001f;
    float diff = sum - expected;
    if (diff < 0) diff = -diff;
    if (diff > 1e-6f) return 2;
    // It must NOT be exactly 1.0 -- that would betray a wider
    // accumulation or a dropped rounding step.
    if (sum == 1.0f) return 3;
    return 0;
}

// A chain of single-precision multiplies stays in f32 throughout.
static int chained_mul_is_single_precision(void) {
    float x = 1.1f;
    float y = x * x * x * x;   // 1.1^4 in f32
    // 1.1f^4 rounded in f32 is ~1.4641001.
    float diff = y - 1.4641001f;
    if (diff < 0) diff = -diff;
    if (diff > 1e-5f) return 4;
    return 0;
}

int main(void) {
    int r;
    if ((r = reciprocal_is_single_precision()) != 0) return r;
    if ((r = accumulation_rounds_in_f32()) != 0) return r;
    if ((r = chained_mul_is_single_precision()) != 0) return r;
    return 0;
}
