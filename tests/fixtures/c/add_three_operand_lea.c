// On x86_64, `a + b` landing in a register other than the lhs folds the
// staging move and the add into a single `lea [rn + rm]` (the rd == rn
// case stays a plain `add`). `volatile` keeps the operands runtime
// values. Returns 0 when every case matches, including two's-complement
// wraparound at int and long width.

int main(void) {
    volatile long a = 3, b = 4, c = 5;
    if (a + b != 7) return 1;
    if ((a + b) + (a + c) != 15) return 2;
    a = -5;
    if (a + b != -1) return 3;
    volatile int x = 2000000000, y = 2000000000;
    if (x + y != (int)(2000000000u + 2000000000u)) return 4;
    volatile long m = 0x7fffffffffffffffL;
    if (m + 1 != (long)0x8000000000000000UL) return 5;
    return 0;
}
