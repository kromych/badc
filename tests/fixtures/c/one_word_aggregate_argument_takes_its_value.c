// An aggregate of eight bytes aligned to eight, passed by value, goes in
// the register or stack slot a scalar of its register's bank takes: in
// registers, past them on the stack, and through a function pointer.
// Returns 0 when every callee sees the values its caller passed.
// snapshot-budget: exempt

typedef struct {
    unsigned long long bits;
} Ref;

typedef struct {
    double d;
} Real;

__attribute__((noinline)) static unsigned long long regs(Ref a, Real b, Ref c) {
    return a.bits * 3 + (unsigned long long)b.d + c.bits;
}

__attribute__((noinline)) static unsigned long long
stacked(long a, long b, long c, long d, long e, long f, long g, long h, Ref r, Real t, int u,
        Ref v) {
    return (unsigned long long)(a + b + c + d + e + f + g + h + u) + r.bits * 5 +
           (unsigned long long)t.d + v.bits * 7;
}

__attribute__((noinline)) static double reals(double a, double b, double c, double d, double e,
                                              double f, double g, double h, Real t, Real w,
                                              Ref r) {
    return a + b + c + d + e + f + g + h + t.d * 10 + w.d * 100 + (double)r.bits;
}

static unsigned long long (*volatile through)(Ref, Real, Ref) = regs;

__attribute__((noinline)) static unsigned long long run(const unsigned long long *v,
                                                        const double *x) {
    Ref r = {v[0]};
    Ref s = {v[1]};
    Real t = {x[0]};
    unsigned long long n = regs(r, t, s);
    n += stacked(1, 2, 3, 4, 5, 6, 7, 8, r, t, 9, s);
    n += (unsigned long long)reals(1, 2, 3, 4, 5, 6, 7, 8, t, t, s);
    n += through(s, t, r);
    return n;
}

int main(void) {
    unsigned long long v[2] = {11, 13};
    double x[1] = {4.0};
    unsigned long long want = (11 * 3 + 4 + 13) + (45 + 11 * 5 + 4 + 13 * 7) +
                              (36 + 40 + 400 + 13) + (13 * 3 + 4 + 11);
    return run(v, x) == want ? 0 : 1;
}
