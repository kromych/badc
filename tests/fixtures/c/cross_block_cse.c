// Dominator-scoped CSE. Each case recomputes a pure value at a
// dominated position and checks the result the merge produces; the
// cases the pressure gate must decline are here for their value, not
// their code shape, so the fixture locks correctness under both
// decisions.

// The digit loop of a Munchausen search: `n % 10` lowers to a quotient
// plus a multiply-subtract, and the following block divides the same
// operands again. The quotient chain is a dominated duplicate.
static int digit_sum(int n, const int *table) {
    int total = 0;
    while (n > 0) {
        int digit = n % 10;
        total += table[digit];
        if (total > 200) return -1;
        n = n / 10;
    }
    return total;
}

// A pure address computation repeated on both sides of a join. The
// dominating form in the entry block serves both arms.
static long pick(long *a, long i, int take_high) {
    long lo = a[i + 1] + a[i + 2];
    if (take_high) {
        return a[i + 1] + a[i + 2] + 1;
    }
    return a[i + 1] + a[i + 2] + lo;
}

static int calls = 0;

static int bump(int x) {
    calls++;
    return x;
}

// A recomputation separated from its leader by a call: the merged value
// would have to survive the call in a callee-saved register.
static int across_call(int x, int y) {
    int a = x * y + 3;
    int b = bump(a);
    int c = x * y + 3;
    return a + b + c;
}

// A duplicate inside a loop whose leader is the loop header: the merge
// stays inside one iteration.
static long loop_body(long *a, long n) {
    long acc = 0;
    for (long i = 0; i < n; i++) {
        long k = i * 3 + 1;
        if (a[i] > 0) {
            acc += a[i] * (i * 3 + 1);
        } else {
            acc -= k;
        }
    }
    return acc;
}

// One conversion shape over one operand, two result widths: the double
// and the float form are not the same value, and the dominating one must
// not serve the dominated one.
static int conv_widths(int n, unsigned long long u) {
    double d = n / 2.0;
    if (d != 6.0) return 1;
    float f = n / 4.0f;
    if (f != 3.0f) return 2;
    if ((double)u != 9223372036854775808.0) return 3;
    if ((float)u != 9223372036854775808.0f) return 4;
    return 0;
}

int main(void) {
    int table[10];
    for (int i = 0; i < 10; i++) table[i] = i * i;

    if (digit_sum(0, table) != 0) return 1;
    if (digit_sum(7, table) != 49) return 2;
    if (digit_sum(153, table) != 1 + 25 + 9) return 3;
    if (digit_sum(999999, table) != -1) return 4;

    long a[8];
    for (int i = 0; i < 8; i++) a[i] = i * 10 + 1;
    // a[1] + a[2] == 11 + 21 == 32
    if (pick(a, 0, 1) != 33) return 5;
    if (pick(a, 0, 0) != 64) return 6;

    // 6 * 7 + 3 == 45, three times.
    if (across_call(6, 7) != 135) return 7;
    if (calls != 1) return 8;

    if (conv_widths(12, 9223372036854775808ULL) != 0) return 10;

    long b[6] = {3, -1, 4, -1, 5, -9};
    // i=0: 3*1;  i=1: -(4);  i=2: 4*7;  i=3: -(10);  i=4: 5*13;  i=5: -(16)
    if (loop_body(b, 6) != 3 - 4 + 28 - 10 + 65 - 16) return 9;

    return 0;
}
