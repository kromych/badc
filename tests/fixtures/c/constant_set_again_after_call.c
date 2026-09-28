// An operand-free value read past a call -- a constant, an object's or
// a function's address -- is set again after the call rather than kept
// across it. The shapes are the ones that reach the allocator with such
// a range: a contracted multiply-add reading a constant its product read
// before the call, a promoted local holding a constant, a phi income
// through a split edge, a return value evaluated ahead of the call, a
// wide constant, an f32 constant, an address read after two calls, and a
// constant read past a call inside a loop, which keeps its register.
// The cases are not inlined and read their inputs through a volatile
// array, so each keeps its shape. Exits 0 when every value is right, a
// distinct code per failure.

static long log_sum;

__attribute__((noinline)) static long note(long x) {
    log_sum += x;
    return x + 1;
}

__attribute__((noinline)) static double scale(double x) {
    log_sum += (long)x;
    return x * 0.5;
}

__attribute__((noinline)) static long fma_constant(double a, double b) {
    double k0 = a * 2.0;
    double s = scale(a) + scale(b);
    return (long)(s + k0);
}

__attribute__((noinline)) static long promoted_constant(long x) {
    long k = 5;
    long a = note(x);
    return note(k) + a + k * x;
}

__attribute__((noinline)) static int phi_income(long x) {
    int ok = 1;
    if (note(x) > 3)
        ok = 0;
    return ok;
}

__attribute__((noinline)) static long returned_constant(long x) {
    long r = 7;
    note(x);
    return r;
}

__attribute__((noinline)) static long long wide_constant(long x) {
    long long k = 0x123456789abLL;
    long a = note(x);
    long b = note(a);
    return (k ^ b) + (k >> 4);
}

__attribute__((noinline)) static float f32_constant(float x) {
    float k = 2.5f;
    float s = (float)scale(x);
    return s * k + k;
}

static long tab[4] = {10, 20, 30, 40};

__attribute__((noinline)) static long address_constant(long i) {
    long *p = &tab[1];
    long a = note(i);
    long b = note(a);
    return p[0] + p[1] + a + b + (long)(p == &tab[1]);
}

typedef long (*fn)(long);

__attribute__((noinline)) static long function_address(long x) {
    fn f = note;
    long a = f(x);
    long b = f(a);
    return f(b) + (long)(f == note);
}

__attribute__((noinline)) static long in_loop(long n) {
    long s = 0;
    long k = 3;
    for (long i = 0; i < n; i++)
        s += note(i) * k + k;
    return s;
}

__attribute__((noinline)) static long two_runs(long x) {
    long k = 9;
    long a = note(x + k);
    long b = note(a + k);
    long c = note(b + k);
    return c + k;
}

static volatile long in[] = {3, 5, 4, 1, 5, 11, 1, 4, 1, 1, 4, 1};

int main(void) {
    if (fma_constant((double)in[0], (double)in[1]) != 10)
        return 1;
    if (promoted_constant(in[2]) != 5 + 1 + 5 + 20)
        return 2;
    if (phi_income(in[3]) != 1 || phi_income(in[4]) != 0)
        return 3;
    if (returned_constant(in[5]) != 7)
        return 4;
    if (wide_constant(in[6]) != ((0x123456789abLL ^ 3) + (0x123456789abLL >> 4)))
        return 5;
    if (f32_constant((float)in[7]) != 7.5f)
        return 6;
    if (address_constant(in[8]) != 20 + 30 + 2 + 3 + 1)
        return 7;
    if (function_address(in[9]) != 4 + 1)
        return 8;
    if (in_loop(in[10]) != (1 + 2 + 3 + 4) * 3 + 4 * 3)
        return 9;
    if (two_runs(in[11]) != 1 + 9 + 1 + 9 + 1 + 9 + 1 + 9)
        return 10;
    if (log_sum != 3 + 5 + 4 + 5 + 1 + 5 + 11 + 1 + 2 + 4 + 1 + 2 + 1 + 2 + 3 + 0 + 1 + 2 + 3 +
                       10 + 20 + 30)
        return 11;
    return 0;
}
