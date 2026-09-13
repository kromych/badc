// A floating-point parameter that follows enough integer parameters to
// exhaust the integer argument-register bank. System V (six integer
// registers) and AAPCS64 (eight) count each class separately, so the
// trailing `double` takes the first FP register while the integer
// parameters past the bank go to the stack. Win64 places by position,
// which puts the trailing double on the stack. Either way the double
// value must reach the callee, which stays out of line to keep the call.

__attribute__((noinline)) static double tail_double(int a, int b, int c, int d, int e, int f, int g,
                          int h, int i, double x) {
    return (double)(a + b + c + d + e + f + g + h + i) + x;
}

int main(void) {
    // 1+2+...+9 = 45; 45 + 0.5 = 45.5.
    double r = tail_double(1, 2, 3, 4, 5, 6, 7, 8, 9, 0.5);
    if (r != 45.5) return 1;
    // A second call with a fractional sum the overflow slot must carry.
    double s = tail_double(10, 20, 30, 40, 50, 60, 70, 80, 90, 0.25);
    if (s != 450.25) return 2;
    return 0;
}
