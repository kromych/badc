// A division and a modulo over the same operands share one quotient:
// the remainder is `a - (a / b) * b` (C99 6.5.5p6). Every divisor here
// reaches the operation in a register, which is the shape that pairs;
// a lone division and a lone modulo are in for the case where nothing
// shares the quotient and the single divide has to survive.
//
// Operands arrive from tables read at run time, so no case folds at
// translation time. INT_MIN / -1 and LLONG_MIN / -1 are absent: the
// quotient is not representable and the behaviour is undefined
// (6.5.5p6), trapping on x86-64.
#include <limits.h>

struct icase {
    int a, b, q, r;
};
struct llcase {
    long long a, b, q, r;
};
struct ucase {
    unsigned int a, b, q, r;
};
struct ullcase {
    unsigned long long a, b, q, r;
};

static const struct icase INT_CASES[] = {
    {17, 5, 3, 2},
    {-17, 5, -3, -2},
    {17, -5, -3, 2},
    {-17, -5, 3, -2},
    {0, 7, 0, 0},
    {6, 7, 0, 6},
    {INT_MIN, 3, -715827882, -2},
    {INT_MIN, -3, 715827882, -2},
    {INT_MIN, 2, -1073741824, 0},
    {INT_MIN, 1, INT_MIN, 0},
    {INT_MIN, INT_MIN, 1, 0},
    {INT_MAX, -1, -INT_MAX, 0},
};

static const struct llcase LL_CASES[] = {
    {17, 5, 3, 2},
    {-17, 5, -3, -2},
    {17, -5, -3, 2},
    {-17, -5, 3, -2},
    {LLONG_MIN, 3, -3074457345618258602LL, -2},
    {LLONG_MIN, -3, 3074457345618258602LL, -2},
    {LLONG_MIN, 1, LLONG_MIN, 0},
    {LLONG_MAX, -1, -LLONG_MAX, 0},
};

static const struct ucase UINT_CASES[] = {
    {17u, 5u, 3u, 2u},
    {4294967295u, 7u, 613566756u, 3u},
    {4294967295u, 4294967294u, 1u, 1u},
    {0u, 3u, 0u, 0u},
};

static const struct ullcase ULL_CASES[] = {
    {17ull, 5ull, 3ull, 2ull},
    {18446744073709551615ull, 3ull, 6148914691236517205ull, 0ull},
    {18446744073709551615ull, 10ull, 1844674407370955161ull, 5ull},
};

// Both halves of the pair, in each source order, plus each half alone.
#define PAIR_CHECKS(a, b, q, r)                                                                    \
    do {                                                                                           \
        if ((a) / (b) != (q)) return 1;                                                            \
        if ((a) % (b) != (r)) return 2;                                                            \
        if ((a) / (b) + (a) % (b) != (q) + (r)) return 3;                                          \
        if ((a) % (b) + (a) / (b) != (q) + (r)) return 4;                                          \
        if ((a) / (b) * (b) + (a) % (b) != (a)) return 5;                                          \
    } while (0)

static int check_int(int a, int b, int q, int r) {
    PAIR_CHECKS(a, b, q, r);
    return 0;
}

static int check_ll(long long a, long long b, long long q, long long r) {
    PAIR_CHECKS(a, b, q, r);
    return 0;
}

static int check_uint(unsigned int a, unsigned int b, unsigned int q, unsigned int r) {
    PAIR_CHECKS(a, b, q, r);
    return 0;
}

static int check_ull(unsigned long long a, unsigned long long b, unsigned long long q,
                     unsigned long long r) {
    PAIR_CHECKS(a, b, q, r);
    return 0;
}

// The quotient stays live across a call, where a merge has to place it
// in a callee-saved register or decline.
static int calls;

static int bump(int x) {
    calls++;
    return x;
}

static int across_call(int a, int b) {
    int r = a % b;
    int mid = bump(r);
    return a / b + mid;
}

// The pair split over two blocks: the modulo dominates the division.
static int digit_pair(int n, int base) {
    int total = 0;
    while (n > 0) {
        int digit = n % base;
        if (digit > 100) return -1;
        total += digit;
        n = n / base;
    }
    return total;
}

int main(void) {
    unsigned int i;
    for (i = 0; i < sizeof(INT_CASES) / sizeof(INT_CASES[0]); i++) {
        int bad = check_int(INT_CASES[i].a, INT_CASES[i].b, INT_CASES[i].q, INT_CASES[i].r);
        if (bad) return 10 + bad;
    }
    for (i = 0; i < sizeof(LL_CASES) / sizeof(LL_CASES[0]); i++) {
        int bad = check_ll(LL_CASES[i].a, LL_CASES[i].b, LL_CASES[i].q, LL_CASES[i].r);
        if (bad) return 20 + bad;
    }
    for (i = 0; i < sizeof(UINT_CASES) / sizeof(UINT_CASES[0]); i++) {
        int bad = check_uint(UINT_CASES[i].a, UINT_CASES[i].b, UINT_CASES[i].q, UINT_CASES[i].r);
        if (bad) return 30 + bad;
    }
    for (i = 0; i < sizeof(ULL_CASES) / sizeof(ULL_CASES[0]); i++) {
        int bad = check_ull(ULL_CASES[i].a, ULL_CASES[i].b, ULL_CASES[i].q, ULL_CASES[i].r);
        if (bad) return 40 + bad;
    }
    if (across_call(-17, 5) != -5) return 51;
    if (calls != 1) return 52;
    if (digit_pair(9376, 10) != 25) return 53;
    if (digit_pair(-1, 10) != 0) return 54;
    return 0;
}
