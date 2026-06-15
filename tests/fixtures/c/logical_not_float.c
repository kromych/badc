// Logical negation of a floating-point operand is the comparison
// `x == 0` (C99 6.5.3.3p5), which is a floating-point comparison, not an
// integer one. The negation must compare the value, not its bit pattern,
// so a small non-zero double like a denormal still negates to 0.

static int notd(double x) { return !x; }
static int notf(float x) { return !x; }

int main(void) {
    if (notd(0.0) != 1) return 1;
    if (notd(5.0) != 0) return 2;
    if (notd(-0.0) != 1) return 3;     // negative zero is zero
    if (notd(1e-300) != 0) return 4;   // tiny but non-zero

    if (notf(0.0f) != 1) return 5;
    if (notf(3.5f) != 0) return 6;

    // In a branch condition (the common `if (!x)` shape).
    double e = 2.0;
    if (!e) return 7;
    double z = 0.0;
    if (!z) {
        return 0;
    }
    return 8;
}
