// C99 6.3.1.4: an integer converts to a floating type in one rounding,
// and a floating value truncates to an integer in one conversion. The
// `float` cases convert directly to / from single precision (`scvtf s`
// / `cvtsi2ss`, `fcvtzs w` / `cvttss2si`) rather than routing through a
// `double` intermediate. Runtime checks pin the values; the SSA
// snapshot pins the absence of the double-then-narrow hop.

// Keep the arguments opaque so the operations are not constant-folded
// at the call site.
static float i2f(int n) { return (float)n; }
static int f2i(float f) { return (int)f; }
static float chain(int n) { return (float)(int)((float)n * 2.0f); }

int main(void) {
    if (i2f(-5) != -5.0f) return 1;
    if (i2f(1000000) != 1000000.0f) return 2;
    if (f2i(3.9f) != 3) return 3;
    if (f2i(-2.5f) != -2) return 4;
    if (chain(7) != 14.0f) return 5;

    // Single-rounding is observable at 2^24 + 1: the value sits exactly
    // between two representable singles and rounds to even (2^24).
    // A double intermediate would round the same here, but the direct
    // path must not regress it.
    if (i2f(16777217) != 16777216.0f) return 6;
    // 2^24 + 3 rounds up to 2^24 + 4 (ties to even).
    if (i2f(16777219) != 16777220.0f) return 7;

    // Widest signed source: the largest i64 converts to 0x1p63 in f32.
    long long big = 0x7FFFFFFFFFFFFFFFLL;  // long is 32-bit on LLP64; need 64-bit width
    if (i2f((int)0) != 0.0f) return 8;
    float wide = (float)big;
    if (wide != 9223372036854775808.0f) return 9;

    // Truncation toward zero of a single-precision value.
    float frac = 2.75f;
    if ((int)frac != 2) return 10;
    if ((int)(-frac) != -2) return 11;

    return 0;
}
