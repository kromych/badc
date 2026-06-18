// A homogeneous floating-point aggregate (AAPCS64 6.4.2 / 6.9: 1..4
// members all the same FP type) returns in consecutive FP registers
// v0..v(n-1), not through an out-pointer, and its members pass in the
// FP argument bank. The values must round-trip through a call so a
// caller built by another compiler (the platform ABI) reads them back
// intact. A four-member double HFA spans 32 bytes yet still returns in
// v0..v3, past the 16-byte integer-register threshold.
//
// Members are double: System V x86_64 keeps the out-pointer convention
// for FP-class aggregate returns, which round-trips the same members,
// so this fixture exercises the register path on AAPCS64 while staying
// correct on every target.

typedef struct {
    double x;
} D1;
typedef struct {
    double r, i;
} D2;
typedef struct {
    double a, b, c;
} D3;
typedef struct {
    double a, b, c, d;
} D4;

static D1 mkd1(double x) {
    D1 r;
    r.x = x;
    return r;
}
static D2 mkd2(double r, double i) {
    D2 c;
    c.r = r;
    c.i = i;
    return c;
}
static D3 mkd3(double a, double b, double c) {
    D3 r;
    r.a = a;
    r.b = b;
    r.c = c;
    return r;
}
static D4 mkd4(double a, double b, double c, double d) {
    D4 r;
    r.a = a;
    r.b = b;
    r.c = c;
    r.d = d;
    return r;
}

int main(void) {
    D1 d1 = mkd1(7.0);
    if (d1.x != 7.0) return 1;
    D2 d2 = mkd2(0.25, 0.5);
    if (d2.r != 0.25 || d2.i != 0.5) return 2;
    D3 d3 = mkd3(1.0, 2.0, 3.0);
    if (d3.a != 1.0 || d3.b != 2.0 || d3.c != 3.0) return 3;
    D4 d4 = mkd4(10.0, 20.0, 30.0, 40.0);
    if (d4.a != 10.0 || d4.b != 20.0 || d4.c != 30.0 || d4.d != 40.0) return 4;
    return 0;
}
