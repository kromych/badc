// C99 6.5.3.3p3: unary `-` is evaluated in the integer-promoted operand
// type; 6.2.5p9 makes an unsigned result wrap modulo 2^N. The parser
// folds `-<literal>` at parse time, so the folded value has to be
// reduced to that type: `-1U` is UINT_MAX, not a 64-bit -1. An
// unreduced fold compares unequal to every `unsigned int` and widens to
// the wrong `unsigned long long`, which is how a kernel's
// `port != (unsigned)-1` collapsed to a constant. Returns 0 on success.

struct addr {
    unsigned short family;
    unsigned short pad;
    unsigned int port;
};

static int bound(const struct addr *a) { return a->port != -1U; }

int main(void) {
    struct addr a = {40, 0, -1U};
    if (bound(&a)) return 1;
    a.port = 22;
    if (!bound(&a)) return 2;

    volatile unsigned int p = 7;
    if (p != -1U != 1) return 3;
    if (p == -1U != 0) return 4;
    if (p < -1U != 1) return 5;
    if (p != -2U != 1) return 6;
    if (p != -0x80000000U != 1) return 7;

    volatile unsigned int max = -1U;
    if (max != -1U) return 8;
    if (max != 4294967295u) return 9;
    if (-2U != 4294967294u) return 10;
    if (-0x80000000U != 2147483648u) return 11;

    // The fold widens through the literal's own type, not through 64 bits.
    unsigned long long w = -1U;
    if (w != 0xffffffffULL) return 12;
    if ((unsigned long long)-1U != 0xffffffffULL) return 13;

    // Signed and 64-bit operands keep the values they had.
    volatile int s = -1;
    if (s != -1) return 14;
    if (-1UL != 0xffffffffffffffffUL) return 15;
    if (-1ULL != 0xffffffffffffffffULL) return 16;
    if ((long long)-1U != 4294967295LL) return 17;

    // A sub-int operand promotes to `int` before the negation, so the
    // result is signed even where the literal's own type is not.
    if (-(unsigned char)1 != -1) return 18;
    if (-(unsigned short)1 != -1) return 19;
    if (-u'\x0001' != -1) return 22;
    if (sizeof(-u'\x0001') != sizeof(int)) return 23;
    if (-U'\x0001' != -1) return 24;

    // Nested folds see the reduced value.
    if (- -1U != 1) return 20;
    if (-1U + 1U != 0) return 21;
    return 0;
}
