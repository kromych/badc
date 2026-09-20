// Values whose readers after a call are only computations nobody reads,
// which no emitter lowers: such a value holds no register past its last
// lowered read, so the call, the loop's back edge or a neighbor may take
// that register. Straight-line and in a loop, with six values of which
// three are read afterwards, and a division by a constant whose pieces
// the remainder shares. The exit code names the first check that fails.

#define NOINLINE __attribute__((noinline))

static volatile long sink;

NOINLINE static long ext(long x) { return x * 3 + 1; }

// `a` and `c` are read after the call only by the unread sum.
NOINLINE static long unread_after_call(long a, long b, long c) {
    long kept = a * c;
    long t = ext(kept);
    long unused = a * b + c;
    (void)unused;
    return t + b;
}

// `b` is read only by the unread product; `a` crosses the back edge.
NOINLINE static long unread_in_loop(long a, long b, int n) {
    long acc = 0;
    for (int i = 0; i < n; i++) {
        long t = ext(a + i);
        long unused = a * b + t;
        (void)unused;
        acc += t;
    }
    return acc + a;
}

// Six values cross the first call; after the second, `b`, `d` and `e`
// are read only by unread sums.
NOINLINE static long six(long a, long b, long c, long d, long e, long f) {
    long p = ext(a + b + c + d + e + f);
    long q = ext(p);
    long u1 = b + d, u2 = d * e, u3 = b - e;
    (void)u1;
    (void)u2;
    (void)u3;
    return p * 100 + q + a + c + f;
}

// Digits of `n`: the division by 10 expands to a reciprocal multiply
// whose pieces the remainder shares, with a call per digit.
NOINLINE static long digit_calls(long n) {
    long acc = 0;
    while (n > 0) {
        long d = n % 10;
        acc = acc * 7 + ext(d);
        n = n / 10;
    }
    return acc;
}

static volatile long v[] = {3, 5, 7, 11, 13, 17, 90817, 1};

int main(void) {
    long a = v[0], b = v[1], c = v[2], d = v[3], e = v[4], f = v[5];
    if (unread_after_call(a, b, c) != 64 + 5) return 1;
    if (unread_after_call(-a, b, c) != -62 + 5) return 2;
    // ext(3 + i) for i = 0, 1, 2 is 10, 13, 16; plus a.
    if (unread_in_loop(a, b, 3) != 39 + 3 || unread_in_loop(a, b, 0) != 3) return 3;
    long p = (a + b + c + d + e + f) * 3 + 1;
    if (six(a, b, c, d, e, f) != p * 100 + (p * 3 + 1) + a + c + f) return 4;
    // Digits of 90817, least significant first: 7, 1, 8, 0, 9.
    long acc = 0;
    long digits[] = {7, 1, 8, 0, 9};
    for (int i = 0; i < 5; i++) acc = acc * 7 + (digits[i] * 3 + 1);
    if (digit_calls(v[6]) != acc) return 5;
    if (digit_calls(0) != 0 || digit_calls(v[7]) != 4) return 6;
    sink = acc;
    return 0;
}
