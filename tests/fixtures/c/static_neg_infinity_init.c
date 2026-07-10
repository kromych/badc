// A static initializer whose value is `-INFINITY` must store negative
// infinity. INFINITY expands to an overflowing product, so `-INFINITY` is
// a unary minus on a parenthesized float expression; the constant
// evaluator must fold it in f64, not coerce the infinite result to an
// integer first (which stored -(2^63)). Covers a scalar global, a struct
// member, and a union member (the shape a real-world property table with
// a negative-infinity constant uses). Asserted by return code.

#include <math.h>

static double g_neg = -INFINITY;

struct Prop {
    int flags;
    double val;
};
static struct Prop neg_inf = {0, -INFINITY};

union Num {
    double f64;
    long i64;
};
static union Num u = {.f64 = -INFINITY};

static int is_neg_infinity(double x) {
    // Negative infinity is below every finite double and equals itself
    // doubled; the prior miscompile stored -(2^63), which fails both.
    return x < -1e308 && (x + x) == x;
}

int main(void) {
    if (!is_neg_infinity(g_neg)) return 1;
    if (!is_neg_infinity(neg_inf.val)) return 2;
    if (!is_neg_infinity(u.f64)) return 3;
    // Negating it yields positive infinity, above every finite double.
    if (-g_neg <= 1e308) return 4;
    return 0;
}
