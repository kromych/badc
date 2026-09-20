// The hot loops of tests/perf (fib, qsort, sieve, munchausen) reduced to
// one function each, with the operand values the -O passes reason about
// at their edges: a zero-trip loop, a negative dividend, a wrapping
// unsigned product, an index at both ends of its array. Each check
// compares against a value computed another way, and the exit code names
// the first one that fails.

#define NOINLINE __attribute__((noinline))

static int table[10] = {0, 1, 4, 27, 256, 3125, 46656, 823543, 16777216, 387420489};

NOINLINE static long count_zero(const char *p, int n) {
    long c = 0;
    for (int i = 0; i < n; i++) {
        if (!p[i]) c++;
    }
    return c;
}

NOINLINE static void partition(int *a, int i, int j, int pivot) {
    while (i <= j) {
        while (a[i] < pivot) i++;
        while (a[j] > pivot) j--;
        if (i <= j) {
            int t = a[i];
            a[i] = a[j];
            a[j] = t;
            i++;
            j--;
        }
    }
}

NOINLINE static long fib(int n) {
    if (n < 2) return (long)n;
    return fib(n - 1) + fib(n - 2);
}

static _Bool is_digit_power_sum(const int number) {
    int n = number;
    int total = 0;
    while (n > 0) {
        int digit = n % 10;
        total += table[digit];
        if (total > number) return 0;
        n = n / 10;
    }
    return total == number;
}

NOINLINE static long digit_power_sums(int limit, long *sum) {
    long found = 0;
    for (int i = 0; i < limit; ++i) {
        if (is_digit_power_sum(i)) {
            found++;
            *sum += i;
        }
    }
    return found;
}

NOINLINE static unsigned lcg(unsigned seed, int n) {
    for (int i = 0; i < n; i++) seed = seed * 1103515245u + 12345u;
    return seed;
}

NOINLINE static unsigned long long lcg_wide(unsigned long long seed, int n) {
    for (int i = 0; i < n; i++) seed = (seed * 1103515245ull + 12345ull) & 0xffffffffull;
    return seed;
}

NOINLINE static long sieve(char *composite, int n) {
    for (int i = 2; (long)i * i < n; i++) {
        if (!composite[i]) {
            for (int j = i * i; j < n; j += i) composite[j] = 1;
        }
    }
    return count_zero(composite + 2, n - 2);
}

NOINLINE static int tenth(int a) {
    a /= 10;
    return a;
}

NOINLINE static int last_digit(int a) {
    a %= 10;
    return a;
}

NOINLINE static int mid(int lo, int hi) { return (lo + hi) / 2; }

NOINLINE static int both(int a, int b) {
    if (a < 3 && b < 7) return 1;
    return 0;
}

NOINLINE static long square_at(const int *a, int i) { return (long)a[i] * a[i]; }

NOINLINE static int negi(int n) { return -n; }

NOINLINE static long negl(long n) { return -n; }

NOINLINE static unsigned negu(unsigned n) { return -n; }

NOINLINE static int negneg(int n) { return -(-n); }

NOINLINE static long sub_of_neg(long a, long b) { return a - (-b); }

NOINLINE static long add_of_neg(long a, long b) { return a + (-b); }

NOINLINE static long neg_minus_one(long n) { return -n - 1; }

NOINLINE static long zero_minus(long n) { return 0 - n; }

NOINLINE static long times_minus_one(long n) { return n * -1; }

NOINLINE static int pos(int n) { return +n; }

// A live negation between the comparison and the branch that reads it:
// the x86-64 negate writes the flags the branch would otherwise fuse.
NOINLINE static long guarded_negate(long a, long b) {
    long c = (a > 0);
    long d = -b;
    return c ? d : 0;
}

int main(void) {
    static char flags[1000];
    char zeros[8] = {0, 1, 0, 0, 2, 0, 3, 0};
    if (count_zero(zeros, 0) != 0) return 1;
    if (count_zero(zeros, 8) != 5) return 2;

    int a[9] = {7, -2, 9, 4, 4, -8, 1, 0, 3};
    partition(a, 0, 8, 4);
    int split = 0;
    while (split < 9 && a[split] <= 4) split++;
    for (int k = split; k < 9; k++)
        if (a[k] < 4) return 3;

    if (fib(15) != 610 || fib(1) != 1 || fib(0) != 0 || fib(-3) != -3) return 4;

    long sum = 0;
    if (digit_power_sums(4000, &sum) != 3 || sum != 3436) return 5;

    if (lcg(12345u, 0) != 12345u) return 6;
    if (lcg(12345u, 1000) != (unsigned)lcg_wide(12345u, 1000)) return 7;

    if (sieve(flags, 1000) != 168) return 8;

    if (tenth(-37) != -3 || tenth(99) != 9 || tenth(-2147483647 - 1) != -214748364) return 9;
    if (last_digit(-37) != -7 || last_digit(40) != 0) return 10;
    if (mid(-3, -4) != -3 || mid(3, 4) != 3 || mid(2147483647, -1) != 1073741823) return 11;
    if (both(2, 6) != 1 || both(2, 7) != 0 || both(3, 6) != 0) return 12;
    if (square_at(a, 0) != (long)a[0] * a[0] || square_at(a, 8) != (long)a[8] * a[8]) return 13;

    // Negation wraps at the type minimum, as every other signed
    // operation in this compiler does.
    if (negi(-2147483647 - 1) != -2147483647 - 1) return 14;
    if (negl(-9223372036854775807L - 1) != -9223372036854775807L - 1) return 15;
    if (negi(0) != 0 || negi(7) != -7 || negi(-7) != 7) return 16;
    if (negl(0) != 0 || negl(7) != -7 || negl(-7) != 7) return 17;
    if (negu(0u) != 0u || negu(1u) != 4294967295u || negu(2147483648u) != 2147483648u)
        return 18;
    if (negneg(-2147483647 - 1) != -2147483647 - 1 || negneg(5) != 5) return 19;
    if (sub_of_neg(3, 4) != 7 || add_of_neg(3, 4) != -1) return 20;
    if (neg_minus_one(5) != ~5L || neg_minus_one(-1) != 0) return 21;
    if (zero_minus(5) != -5 || times_minus_one(5) != -5) return 22;
    if (zero_minus(-9223372036854775807L - 1) != -9223372036854775807L - 1) return 23;
    if (times_minus_one(-9223372036854775807L - 1) != -9223372036854775807L - 1) return 24;
    if (pos(-7) != -7 || pos(0) != 0) return 25;
    if (guarded_negate(1, 1) != -1 || guarded_negate(-1, 1) != 0) return 26;
    if (guarded_negate(1, -5) != 5 || guarded_negate(0, 9) != 0) return 27;
    return 0;
}
