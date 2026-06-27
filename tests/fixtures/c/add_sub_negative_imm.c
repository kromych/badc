// Add / Sub by a small negative immediate uses the other form's direct
// 12-bit encoding on AArch64 (x + (-k) == x - k) instead of
// materialising the sign-extended constant into a scratch register.
// `volatile` keeps the operands runtime values. Returns 0 on success.

int main(void) {
    volatile int x = 10;
    volatile long y = 1000;
    if (x + (-5) != 5) return 1;
    if (x + (-10) != 0) return 2;
    if (x - (-7) != 17) return 3;
    if (y + (-100) != 900) return 4;
    if (y - (-100) != 1100) return 5;
    // 12-bit boundary (4095 fits, 4096 does not).
    if (x + (-4095) != 10 - 4095) return 6;
    if (x + (-4096) != 10 - 4096) return 7;
    // Decrement loop: the counter update lowers through the same path.
    int s = 0;
    for (volatile int j = 5; j > 0; j--) s += j;
    if (s != 15) return 8;
    return 0;
}
