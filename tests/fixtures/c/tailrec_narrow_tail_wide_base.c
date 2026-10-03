// An accumulator tail whose sum is narrowed by a cast while the base
// return is a full-width value. Turning the recursion into a loop narrows
// every return as the tail's is narrowed, which would change the base
// value 2^40 to (int)2^40 = 0; the narrowing has to leave every base
// return as it is for the loop to be the same function. Returns 0 when
// every result matches.

__attribute__((noinline)) static long long wide_base(long long n) {
    if (!n)
        return 1LL << 40;
    return (int)(wide_base(n - 1) + 1);
}

int main(void) {
    if (wide_base(0) != (1LL << 40))
        return 1;
    if (wide_base(1) != 1)
        return 2;
    if (wide_base(3) != 3)
        return 3;
    return 0;
}
