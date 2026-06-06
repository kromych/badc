// C99 6.2.5p10 + the host ABI (System V AMD64 3.2.3 / AAPCS64 6.4.1):
// a floating-point scalar argument is passed in a floating-point
// argument register, and a floating-point scalar result is returned
// in the floating-point return register. This fixture proves a
// `double` argument round-trips across a c5-internal direct call and
// that the integer and FP argument-register banks are independent: an
// integer parameter interleaved with FP parameters keeps its own bank.

static double f(double a, double b) {
    return a * b + a;
}

// Interleaved int / FP parameter list. `n` and `m` ride the integer
// bank (x0 / rdi, then the next integer register); `x` and `y` ride
// the FP bank (d0 / xmm0, d1 / xmm1). A miscompile that assigned
// registers by absolute parameter index would cross the banks.
static double g(int n, double x, int m, double y) {
    return x * (double)n + y * (double)m;
}

int main(void) {
    // f(2.0, 3.0) = 2*3 + 2 = 8.0
    double r = f(2.0, 3.0);
    if (r != 8.0) return 1;

    // g(3, 1.5, 4, 2.5) = 1.5*3 + 2.5*4 = 4.5 + 10.0 = 14.5
    double s = g(3, 1.5, 4, 2.5);
    if (s != 14.5) return 2;

    // A value carried in from a variable (not a constant) to prove the
    // argument is not specially constant-folded into an integer slot.
    double t = 6.25;
    double u = f(t, 4.0);   // 6.25*4 + 6.25 = 31.25
    if (u != 31.25) return 3;

    return 0;
}
