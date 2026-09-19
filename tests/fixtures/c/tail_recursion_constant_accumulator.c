// A self tail call under an accumulator whose other operand is a constant
// becomes a loop: `1 + f(x)`, `f(x) - k` and `f(x) * 2` (a shift once
// folded). The unsigned cases wrap (C99 6.2.5p9) past the accumulator's
// 64-bit range on every data model. Returns 0 when every result matches.

__attribute__((noinline)) static long depth(const unsigned char *pc) {
    if (*pc) return 1 + depth(pc + 1);
    return 0;
}

__attribute__((noinline)) static long down(long n) {
    if (n) return down(n - 1) - 3;
    return 100;
}

__attribute__((noinline)) static long twice(long n) {
    if (n) return twice(n - 1) * 2;
    return 1;
}

__attribute__((noinline)) static unsigned long long wrap(unsigned long long n) {
    if (n) return wrap(n - 1) - 7;
    return 5;
}

__attribute__((noinline)) static unsigned long long times8(unsigned long long n) {
    if (n) return times8(n - 1) << 3;
    return 3;
}

int main(void) {
    if (depth((const unsigned char *)"abcdefg") != 7) return 1;
    if (down(10) != 70) return 2;
    if (twice(20) != 1048576) return 3;
    if (wrap(10) != 5ull - 70ull) return 4;
    if (times8(21) != 0x8000000000000000ull) return 5;
    if (times8(0) != 3) return 6;
    return 0;
}
