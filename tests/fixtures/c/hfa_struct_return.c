// A homogeneous floating-point aggregate returns in FP registers, not
// through an out-pointer: AAPCS64 6.9 uses v0..v(n-1) for 1..4 members;
// System V x86_64 3.2.3 returns a <=16-byte aggregate's eightbytes in
// xmm0 / xmm1 (a larger one through memory). The values must round-trip
// through a call so a caller built by the platform compiler reads them
// back intact. AArch64 also passes HFA arguments in the FP bank; System V
// FP-aggregate arguments stay by-address for now (sumf4 below).

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
typedef struct {
    float r, i;
} F2;
typedef struct {
    float a, b, c, d;
} F4;

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
static F2 mkf2(float a, float b) {
    F2 c;
    c.r = a;
    c.i = b;
    return c;
}

// Aggregate parameters: an HFA / SSE-eightbyte aggregate passes in the FP
// argument bank; the callee reads each member back.
static double sumd2(D2 c) {
    return c.r + c.i;
}
static double sumd4(D4 v) {
    return v.a + v.b + v.c + v.d;
}
static float sumf4(F4 v) {
    return v.a + v.b + v.c + v.d;
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
    F2 f2 = mkf2(1.5f, 2.5f);
    if (f2.r != 1.5f || f2.i != 2.5f) return 5;
    F4 f4 = {1.0f, 2.0f, 3.0f, 4.0f};

    if (sumd2(d2) != 0.75) return 6;
    if (sumd4(d4) != 100.0) return 7;
    if (sumf4(f4) != 10.0f) return 8;
    return 0;
}
