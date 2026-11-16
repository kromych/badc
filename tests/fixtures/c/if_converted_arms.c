/* Short branches that only choose values, which -O turns into selects: an
 * arm's 32-bit comparison of a zero-extended load keeps its width, an arm
 * reading values the branch's block defines after the condition sees
 * them, two values chosen by one comparison, both arms of a diamond, a
 * conditional increment in a loop and out of one, floating constants
 * chosen by a comparison, integers chosen by floating comparisons, a NaN
 * operand among them, and by the zero test of a loaded value or a
 * parameter, either way round. Every check is against values computed here;
 * each failure returns a distinct code. */

#define NOINLINE __attribute__((noinline))

struct Q { int a, b; };

NOINLINE struct Q makeq(int x) {
    struct Q r = {x, -x};
    return r;
}

/* `q.b == -7` compares the low words of a zero-extended load. */
NOINLINE int narrow_compare_in_arm(long long s) {
    struct Q q = makeq(7);
    return s == 18 && q.a == 7 && q.b == -7;
}

static int pick(int c, int x, int y) {
    if (c) return x * 3;
    return y - 1;
}

/* Inlined, the arms read stack parameters the caller loads after `c > 0`. */
NOINLINE long late_operands(long a0, long a1, long a2, long a3, long a4, long a5, long a6,
                            long a7, signed char c, short s, int i) {
    return a6 + pick(c > 0, s, i) * 5 + c + a0 + a1 + a2 + a3 + a4 + a5 + a7;
}

NOINLINE long swap_if(long a, long b, int c) {
    if (c & 1) {
        long t = a;
        a = b;
        b = t;
    }
    return a * 10 + b;
}

NOINLINE long diamond(long x, long y) {
    long r;
    if (x < y) r = y - x;
    else r = x - y;
    return r;
}

NOINLINE long count_below(const int *p, int n, int k) {
    long c = 0;
    for (int i = 0; i < n; i++) {
        if (p[i] < k) c++;
    }
    return c;
}

NOINLINE long inc_unless(long x, int c) {
    long r = x + 1;
    if (c) r = x;
    return r;
}

NOINLINE double scale(int c, double y) {
    double r = c ? 1.5 : 0.001;
    return r * y;
}

NOINLINE unsigned umax(unsigned a, unsigned b) { return a > b ? a : b; }

NOINLINE long pick_ne(double x, double y, long a, long b) {
    long r = b;
    if (x != y) r = a;
    return r;
}

NOINLINE long pick_eq(double x, double y, long a, long b) {
    long r = b;
    if (x == y) r = a;
    return r;
}

NOINLINE long pick_lt(double x, double y, long a, long b) { return x < y ? a : b; }

NOINLINE long on_byte(const signed char *p, long a, long b) { return *p ? a : b; }
NOINLINE long on_int_zero(const int *p, long a, long b) { return *p == 0 ? a : b; }
NOINLINE long on_long(const long long *p, long a, long b) { return !*p ? a : b; }
NOINLINE long on_param(int c, long a, long b) { return c == 0 ? a : b; }

/* The tested value is read before the store that clears it. */
NOINLINE long load_then_store(signed char *p, long a, long b) {
    signed char v = *p;
    *p = 0;
    return v != 0 ? a : b;
}

int main(void) {
    if (!narrow_compare_in_arm(18)) return 1;
    if (narrow_compare_in_arm(17)) return 2;
    if (late_operands(0, 0, 0, 0, 0, 0, 16, 0, 'x', -300, 70000) != 16 + -900 * 5 + 'x')
        return 3;
    if (late_operands(0, 0, 0, 0, 0, 0, 16, 0, -2, -300, 70000) != 16 + 69999 * 5 - 2) return 4;
    if (swap_if(1, 2, 0) != 12) return 5;
    if (swap_if(1, 2, 3) != 21) return 6;
    if (diamond(3, 10) != 7 || diamond(10, 3) != 7 || diamond(-5, -5) != 0) return 7;
    int v[8] = {5, -1, 9, 3, 3, 12, -7, 0};
    if (count_below(v, 8, 3) != 3) return 8;
    if (count_below(v, 8, 4) != 5) return 9;
    if (inc_unless(5, 0) != 6 || inc_unless(5, 1) != 5 || inc_unless(-1, 0) != 0) return 15;
    if (scale(1, 2.0) != 3.0 || scale(0, 1000.0) != 1.0) return 10;
    if (umax(0x80000000u, 5) != 0x80000000u || umax(5, 0xFFFFFFFFu) != 0xFFFFFFFFu) return 11;
    volatile double zero = 0.0;
    double nan = zero / zero;
    if (pick_ne(1, 2, 5, 7) != 5 || pick_ne(1, 1, 5, 7) != 7 || pick_ne(nan, 1, 5, 7) != 5)
        return 12;
    if (pick_eq(1, 1, 5, 7) != 5 || pick_eq(1, 2, 5, 7) != 7 || pick_eq(nan, nan, 5, 7) != 7)
        return 13;
    if (pick_lt(1, 2, 5, 7) != 5 || pick_lt(2, 1, 5, 7) != 7 || pick_lt(nan, 1, 5, 7) != 7 ||
        pick_lt(1, nan, 5, 7) != 7)
        return 14;
    signed char bytes[2] = {0, -128};
    int ints[2] = {0, 1 << 31};
    long long longs[2] = {0, 1LL << 40};
    for (int i = 0; i < 2; i++) {
        if (on_byte(&bytes[i], 5, 7) != (i ? 5 : 7)) return 16;
        if (on_int_zero(&ints[i], 5, 7) != (i ? 7 : 5)) return 17;
        if (on_long(&longs[i], 5, 7) != (i ? 7 : 5)) return 18;
        if (on_param(i, 5, 7) != (i ? 7 : 5)) return 19;
    }
    signed char flag = 3;
    if (load_then_store(&flag, 5, 7) != 5 || flag != 0) return 20;
    return 0;
}
