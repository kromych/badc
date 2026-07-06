// A non-variadic indirect call marshals its scalar arguments per the
// host ABI, and each argument is converted to the pointee prototype's
// parameter type (C99 6.5.2.2p7). Narrow (char/short) parameters must
// observe the same converted values through the fn-pointer boundary
// as through a direct call.

static int take(signed char c, short s, int i) {
    return (int)c * 100000 + (int)s * 10 + i;
}

typedef int (*fn3)(signed char, short, int);

volatile int big = 0x12345;

int main(void) {
    fn3 p = take;
    int v = big; /* 74565: char 0x45 = 69, short 0x2345 = 9029 */
    int direct = take(v, v, v);
    int indirect = p(v, v, v);
    if (direct != indirect) return 1;
    if (indirect != 69 * 100000 + 9029 * 10 + 74565) return 2;
    return 0;
}
