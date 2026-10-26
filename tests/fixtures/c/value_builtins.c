// The GCC builtins whose value the call forms from its operands, with no
// header: in static initializers, constant expressions and at run time.
// `__builtin_expect` is `long (long, long)` and evaluates its second
// operand; `__builtin_nan` places a literal payload in the significand's
// low bits. Clang lacks the ASCII classifications, which are tested where
// `__has_builtin` reports them.
static int calls;

static int tick(void) {
    return ++calls;
}

static unsigned long long bits(double d) {
    union {
        double d;
        unsigned long long u;
    } v = {d};
    return v.u;
}

static unsigned bitsf(float f) {
    union {
        float f;
        unsigned u;
    } v = {f};
    return v.u;
}

static double inf = __builtin_inf();
static float inff = __builtin_huge_valf();
static double qnan = __builtin_nan("");
static double nan16 = __builtin_nan("0x10");
static float nanf7 = __builtin_nanf("7");
static long hinted = __builtin_expect(5, 1);
static int anchor;
_Static_assert(sizeof(__builtin_expect(1, 1)) == sizeof(long), "expect is long");

int main(void) {
    volatile int x = 3;
    if (__builtin_expect(x, tick()) != 3 || calls != 1)
        return 1;
    __builtin_prefetch((const void *)&x);
    __builtin_prefetch((const void *)&x, 1, 0);
    if (__builtin_assume_aligned(&anchor, 4, tick()) != (void *)&anchor || calls != 2)
        return 2;
    if (!(inf > 1e308) || !(inff > 3e38f) || hinted != 5)
        return 4;
    if (bits(qnan) != 0x7ff8000000000000ull || bits(nan16) != 0x7ff8000000000010ull)
        return 5;
    if (bitsf(nanf7) != 0x7fc00007u)
        return 6;
    if (bits(__builtin_nan("010")) != 0x7ff8000000000008ull)
        return 7;
    if (bitsf(__builtin_nanf("0x400001")) != 0x7fc00001u)
        return 8;
    if (bits(__builtin_nan("0xfffffffffffffffff")) != 0x7fffffffffffffffull)
        return 9;
    if (__builtin_extract_return_addr((void *)&anchor) != (void *)&anchor)
        return 10;
#if __has_builtin(__builtin_isdigit)
    enum { folded = __builtin_isdigit('7') + __builtin_isascii(0x80) * 2 + __builtin_toascii(0x1C1) * 4 };
    if (folded != 1 + 0x41 * 4)
        return 11;
    int sum = 0;
    for (volatile int c = -300; c < 300; c++)
        sum += __builtin_isdigit(c) * c + __builtin_isascii(c) + __builtin_toascii(c);
    if (sum != 38753)
        return 12;
#endif
    return 0;
}
