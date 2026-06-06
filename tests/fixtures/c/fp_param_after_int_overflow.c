// A floating-point parameter that follows enough integer parameters to
// exhaust the integer argument-register bank. On System V (six integer
// registers) and AAPCS64 (eight) the trailing `double` would otherwise
// take a free FP register while an earlier integer parameter already
// overflowed to the stack -- an interleaved register/stack placement
// the c5 cdecl contiguous-prefix cell layout cannot represent. The
// compiler falls the function back to the all-integer ABI on both the
// caller and the callee. Win64's position-indexed ABI places the
// trailing double on the stack directly. Either way the double value
// must reach the callee.

static double tail_double(int a, int b, int c, int d, int e, int f, int g,
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
