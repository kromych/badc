// Accumulator recursion whose result is narrower than a register becomes a
// loop as the 64-bit forms do. The recursive value is re-extended where the
// sum uses it and the sum re-narrowed on return, and two's-complement add
// and multiply carry nothing downward, so only the low bits matter (C99
// 6.2.5p9 for the unsigned wrap). `long` is 64-bit on LP64 and 32-bit on
// LLP64, so the one source covers both data models. Returns 0 when every
// result matches.

__attribute__((noinline)) static int fib_int(int n) {
    if (n < 2)
        return n;
    return fib_int(n - 1) + fib_int(n - 2);
}

__attribute__((noinline)) static unsigned golden_sum(unsigned n) {
    if (n == 0)
        return 0;
    return 0x9E3779B9u + golden_sum(n - 1);
}

__attribute__((noinline)) static long down_long(long n) {
    if (n == 0)
        return 100;
    return down_long(n - 1) - 3;
}

__attribute__((noinline)) static short times3_short(short n) {
    if (n == 0)
        return 1;
    return (short)(times3_short((short)(n - 1)) * 3);
}

int main(void) {
    unsigned want_sum = 0;
    short want_pow = 1;
    int i;
    for (i = 0; i < 100; i++)
        want_sum += 0x9E3779B9u;
    for (i = 0; i < 12; i++)
        want_pow = (short)(want_pow * 3);
    if (fib_int(24) != 46368)
        return 1;
    if (golden_sum(100) != want_sum)
        return 2;
    if (down_long(10) != 70)
        return 3;
    if (times3_short(12) != want_pow)
        return 4;
    return 0;
}
