// An integer multiply feeding an add or a subtract contracts into one
// multiply-accumulate (AArch64 `madd` / `msub`; on x86-64 the same
// `imul` plus `add` / `sub` pair it already emitted). The fused form
// computes the operands' arithmetic exactly: two's-complement multiply
// and add agree modulo 2^N whether or not the product lands in a
// register of its own (C99 6.2.5p9 for the unsigned wrap; the signed
// products here stay inside their type).
//
// Operands arrive from tables read at run time, so no case folds at
// translation time. Covered: both operand orders of the add, `c - a*b`
// against the `a*b - c` that has no fused form, a product a second
// expression also reads, the remainder shape a shared quotient leaves
// behind (`n - (n/d)*d`), 32- and 64-bit widths signed and unsigned,
// and a body with enough live values to spill the operands.
#include <limits.h>

struct icase {
    int a, b, c, add, sub, psub;
};
struct llcase {
    long long a, b, c, add, sub;
};
struct ucase {
    unsigned int a, b, c, add, sub;
};
struct ullcase {
    unsigned long long a, b, c, add, sub;
};
struct dmcase {
    int n, d, sum;
};
struct dmllcase {
    long long n, d, sum;
};
struct spillcase {
    long long a, b, c, want;
};

static const struct icase INT_CASES[] = {
    {3, 5, 7, 22, -8, 8},
    {-3, 5, 7, -8, 22, -22},
    {-3, -5, 7, 22, -8, 8},
    {0, 7, 9, 9, 9, -9},
    {1, INT_MAX, 0, INT_MAX, -INT_MAX, INT_MAX},
    {-1, -INT_MAX, 0, INT_MAX, -INT_MAX, INT_MAX},
    {12345, 6789, -100, 83810105, -83810305, 83810305},
};

static const struct llcase LL_CASES[] = {
    {1000000007LL, 3000000019LL, -5LL, 3000000040000000128LL, -3000000040000000138LL},
    {-1LL, LLONG_MAX, 0LL, -LLONG_MAX, LLONG_MAX},
    {123456789LL, 987654321LL, 42LL, 121932631112635311LL, -121932631112635227LL},
    {-1000000LL, 1000000LL, -7LL, -1000000000007LL, 999999999993LL},
};

static const struct ucase UINT_CASES[] = {
    {65536u, 65536u, 5u, 5u, 5u},
    {3u, 5u, 1u, 16u, 4294967282u},
    {3000000000u, 3u, 1u, 410065409u, 3884901889u},
    {4294967295u, 4294967295u, 0u, 1u, 4294967295u},
};

static const struct ullcase ULL_CASES[] = {
    {18446744073709551615ull, 3ull, 10ull, 7ull, 13ull},
    {123456789123ull, 987654321ull, 5ull, 11252166791859440792ull, 7194577281850110834ull},
    {1099511627776ull, 1099511627776ull, 7ull, 7ull, 7ull},
};

// INT_MIN / -1 and LLONG_MIN / -1 are absent: the quotient is not
// representable and the behaviour is undefined (C99 6.5.5p6).
static const struct dmcase DM_CASES[] = {
    {17, 5, 5}, {-17, 5, -5}, {INT_MIN, 3, -715827884},
    {INT_MAX, 7, 306783379}, {-99, -10, 0}, {100, 7, 16},
};

static const struct dmllcase DM_LL_CASES[] = {
    {-1000000007LL, 7LL, -142857149LL},
    {LLONG_MAX, 3LL, 3074457345618258603LL},
    {-LLONG_MAX, 1000000007LL, -9514543975LL},
};

static const struct spillcase SPILL_CASES[] = {
    {11LL, 13LL, 17LL, -510LL},
    {-5LL, 7LL, 3LL, 8LL},
    {1000003LL, 999983LL, -7LL, 20999912LL},
};

static int add_product(int a, int b, int c) {
    return c + a * b;
}

static int product_add(int a, int b, int c) {
    return a * b + c;
}

static int sub_product(int a, int b, int c) {
    return c - a * b;
}

// No fused form subtracts the addend from the product; the pair stays.
static int product_sub(int a, int b, int c) {
    return a * b - c;
}

static long long add_product_ll(long long a, long long b, long long c) {
    return c + a * b;
}

static long long sub_product_ll(long long a, long long b, long long c) {
    return c - a * b;
}

static unsigned int add_product_u(unsigned int a, unsigned int b, unsigned int c) {
    return c + a * b;
}

static unsigned int sub_product_u(unsigned int a, unsigned int b, unsigned int c) {
    return c - a * b;
}

static unsigned long long add_product_ull(unsigned long long a, unsigned long long b,
                                          unsigned long long c) {
    return c + a * b;
}

static unsigned long long sub_product_ull(unsigned long long a, unsigned long long b,
                                          unsigned long long c) {
    return c - a * b;
}

// The product reaches two readers, so it is materialised on its own;
// both readers must still see it.
static int product_read_twice(int a, int b, int c) {
    int p = a * b;
    return (c - p) ^ p;
}

// `n % d` derived from the quotient the division above shares.
static int divmod_sum(int n, int d) {
    return n / d + n % d;
}

static long long divmod_sum_ll(long long n, long long d) {
    return n / d + n % d;
}

// Every intermediate stays live to the last statement, so the three
// inputs of each accumulate compete with eight other values.
static long long spilled_accumulate(long long a, long long b, long long c) {
    long long v0 = a + 1, v1 = b + 2, v2 = c + 3, v3 = a ^ b;
    long long v4 = b ^ c, v5 = a + b, v6 = b + c, v7 = a + c;
    long long acc = v0 * v1 - v2;
    acc = acc + v3 * v4;
    acc = v5 - v6 * v7;
    return acc + v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7 + a * b;
}

// A product computed in one block and read in another: contracting
// moves the multiply to its reader.
static int across_blocks(int a, int b, int c, int take) {
    int p = a * b;
    if (take) {
        return c - p;
    }
    return c;
}

static int loop_accumulate(const int *xs, int n, int scale) {
    int acc = 0;
    int i;
    for (i = 0; i < n; i++) {
        acc = acc + xs[i] * scale;
    }
    return acc;
}

int main(void) {
    static const int XS[5] = {3, -4, 7, 0, 11};
    unsigned int i;

    for (i = 0; i < sizeof(INT_CASES) / sizeof(INT_CASES[0]); i++) {
        int a = INT_CASES[i].a, b = INT_CASES[i].b, c = INT_CASES[i].c;
        if (add_product(a, b, c) != INT_CASES[i].add) return 10;
        if (product_add(a, b, c) != INT_CASES[i].add) return 11;
        if (sub_product(a, b, c) != INT_CASES[i].sub) return 12;
        if (product_sub(a, b, c) != INT_CASES[i].psub) return 13;
        if (product_read_twice(a, b, c) != (INT_CASES[i].sub ^ (a * b))) return 14;
        if (across_blocks(a, b, c, 1) != INT_CASES[i].sub) return 15;
        if (across_blocks(a, b, c, 0) != c) return 16;
    }
    for (i = 0; i < sizeof(LL_CASES) / sizeof(LL_CASES[0]); i++) {
        long long a = LL_CASES[i].a, b = LL_CASES[i].b, c = LL_CASES[i].c;
        if (add_product_ll(a, b, c) != LL_CASES[i].add) return 20;
        if (sub_product_ll(a, b, c) != LL_CASES[i].sub) return 21;
    }
    for (i = 0; i < sizeof(UINT_CASES) / sizeof(UINT_CASES[0]); i++) {
        unsigned int a = UINT_CASES[i].a, b = UINT_CASES[i].b, c = UINT_CASES[i].c;
        if (add_product_u(a, b, c) != UINT_CASES[i].add) return 30;
        if (sub_product_u(a, b, c) != UINT_CASES[i].sub) return 31;
    }
    for (i = 0; i < sizeof(ULL_CASES) / sizeof(ULL_CASES[0]); i++) {
        unsigned long long a = ULL_CASES[i].a, b = ULL_CASES[i].b, c = ULL_CASES[i].c;
        if (add_product_ull(a, b, c) != ULL_CASES[i].add) return 40;
        if (sub_product_ull(a, b, c) != ULL_CASES[i].sub) return 41;
    }
    for (i = 0; i < sizeof(DM_CASES) / sizeof(DM_CASES[0]); i++) {
        if (divmod_sum(DM_CASES[i].n, DM_CASES[i].d) != DM_CASES[i].sum) return 50;
    }
    for (i = 0; i < sizeof(DM_LL_CASES) / sizeof(DM_LL_CASES[0]); i++) {
        if (divmod_sum_ll(DM_LL_CASES[i].n, DM_LL_CASES[i].d) != DM_LL_CASES[i].sum) return 51;
    }
    for (i = 0; i < sizeof(SPILL_CASES) / sizeof(SPILL_CASES[0]); i++) {
        if (spilled_accumulate(SPILL_CASES[i].a, SPILL_CASES[i].b, SPILL_CASES[i].c)
            != SPILL_CASES[i].want)
            return 60;
    }
    if (loop_accumulate(XS, 5, XS[0]) != 51) return 70;
    if (loop_accumulate(XS, 0, XS[0]) != 0) return 71;
    if (loop_accumulate(XS, 5, -XS[4] / 11) != -17) return 72;
    if (loop_accumulate(XS, 3, XS[4] - 4) != 42) return 73;
    return 0;
}
