// C99 6.5.8p6 / 6.5.9p3 with Annex F: the relational operators and
// `==` yield 0 when either operand is NaN, `!=` yields 1. A branch
// fused into the FP compare's flags must preserve exactly that,
// including the negated forms, for double and float alike. The NaNs
// are produced at runtime (`0.0 / 0.0`) from volatile operands so no
// fold decides the branches.

static volatile double dz = 0.0, done = 1.0;
static volatile float fz = 0.0f, fone = 1.0f;

int main(void) {
    double n = dz / dz;  // NaN
    double one = done;
    float fn = fz / fz;  // NaN
    float f1 = fone;

    // NaN on the left: every ordered compare and == are false.
    if (n < one) return 1;
    if (n > one) return 2;
    if (n <= one) return 3;
    if (n >= one) return 4;
    if (n == one) return 5;
    if (n == n) return 6;
    // != is true on NaN.
    if (n != one) { } else return 7;
    if (n != n) { } else return 8;
    // NaN on the right.
    if (one < n) return 9;
    if (one > n) return 10;
    if (one <= n) return 11;
    if (one >= n) return 12;
    // Negated conditions take the branch on NaN.
    if (!(n < one)) { } else return 13;
    if (!(n >= one)) { } else return 14;
    if (!(n == one)) { } else return 15;
    if (!(n != one)) return 16;
    // Ordered operands still branch by value.
    if (one < 2.0) { } else return 17;
    if (one > 2.0) return 18;
    if (one == 1.0) { } else return 19;
    // Float precision compares.
    if (fn < f1) return 20;
    if (fn > f1) return 21;
    if (fn <= f1) return 22;
    if (fn >= f1) return 23;
    if (fn == fn) return 24;
    if (fn != fn) { } else return 25;
    if (f1 < 2.0f) { } else return 26;
    return 0;
}
