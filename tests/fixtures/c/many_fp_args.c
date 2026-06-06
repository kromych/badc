// The host ABI provides eight floating-point argument registers
// (xmm0..xmm7 / d0..d7). A ninth floating-point argument overflows to
// the host stack (System V AMD64 3.2.3 / AAPCS64 6.4.1). This fixture
// passes ten `double` arguments so the ninth and tenth spill, proving
// the overflow restripe and the callee's host-stack read still work.

static double sum10(
    double a, double b, double c, double d, double e,
    double f, double g, double h, double i, double j) {
    return a + b + c + d + e + f + g + h + i + j;
}

int main(void) {
    // 1.0 + 2.0 + ... + 10.0 = 55.0
    double r = sum10(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0);
    if (r != 55.0) return 1;

    // Weighted so the overflow slots (i, j) carry distinct values that
    // would be lost if the stack restripe dropped them.
    double s = sum10(0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 100.0, 200.0);
    if (s != 304.0) return 2;

    return 0;
}
