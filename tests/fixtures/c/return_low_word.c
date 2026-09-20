// A return narrower than the return register carries its value in that
// register's low word and nothing above it, so the callee stops
// renormalizing and every reader that wants more than 32 bits widens the
// result itself. Each callee below leaves a different pattern above bit 31
// -- a wrapped product, a negative sum, a masked unsigned value -- and each
// caller reads it a different way: at 64 bits, at 32, as a zero test, as an
// array index, through a function pointer, and after a `long long` conversion.
// The expected values are the wrapped results in 64-bit arithmetic; the
// exit code names the first check that fails.

#define NOINLINE __attribute__((noinline))

#define MAX 2147483647
#define MIN (-MAX - 1)

// `n * n` overflows `int` for every n past 46341, so the result is the
// wrapped value and its high word is whatever the multiply left.
NOINLINE static int square(int n) { return n * n; }

NOINLINE static unsigned usquare(unsigned n) { return n * n; }

// A sum at the negative edge: the low word has bit 31 set, so a reader at
// 64 bits must see the sign, not the zero the 32-bit forms would leave.
NOINLINE static int sum_min(int a, int b) { return a + b; }

NOINLINE static short shalf(int n) { return (short)(n / 2); }

NOINLINE static signed char cbyte(int n) { return (signed char)n; }

NOINLINE static int zero_if(int n) { return n & 1; }

// Readers.
NOINLINE static long long as_long(int n) { return square(n); }
NOINLINE static unsigned long long as_ulong(unsigned n) { return usquare(n); }
NOINLINE static int as_int(int n) { return square(n) + 1; }
NOINLINE static int as_test(int n) { return zero_if(n) ? 3 : 5; }
NOINLINE static long long as_index(const long long *t, int n) { return t[zero_if(n)]; }
NOINLINE static long long as_short(int n) { return shalf(n); }
NOINLINE static long long as_char(int n) { return cbyte(n); }
NOINLINE static long long as_diff(int a, int b) { return (long long)sum_min(a, b) - 1; }

typedef int (*fn)(int);
NOINLINE static long long through_ptr(fn f, int n) { return f(n); }

int main(void) {
    // 65536 * 65536 wraps to 0; 46341 * 46341 wraps to -2147479015.
    if (as_long(65536) != 0LL) return 1;
    if (as_long(46341) != -2147479015LL) return 2;
    if (as_long(-46341) != -2147479015LL) return 3;
    if (as_int(46341) != -2147479014) return 4;
    if (as_ulong(65536u) != 0ULL) return 5;
    if (as_ulong(4294967295u) != 1ULL) return 6;

    if (as_test(4) != 5 || as_test(5) != 3) return 7;
    static const long long t[2] = {11, 22};
    if (as_index(t, 4) != 11 || as_index(t, 5) != 22) return 8;

    if (as_short(-70000) != 30536LL) return 9;
    if (as_short(200000) != -31072LL) return 10;
    if (as_char(-1) != -1LL) return 11;
    if (as_char(255) != -1LL) return 12;

    if (as_diff(MIN, MIN) != -1LL) return 13;
    if (as_diff(MAX, 1) != MIN - 1LL) return 14;
    if (as_diff(MIN, -1) != MAX - 1LL) return 15;

    if (through_ptr(square, 65536) != 0LL) return 16;
    if (through_ptr(square, 46341) != -2147479015LL) return 17;
    return 0;
}
