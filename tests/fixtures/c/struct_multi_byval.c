// C99 6.5.2.2 with the host ABIs (System V AMD64, Win64, AAPCS64):
// several aggregates passed by value in one call, interleaved with
// scalar arguments, plus aggregate returns of varying size. Field
// widths are `int` so the layout is identical on LP64 and LLP64.
//
// Per-ABI classification of the argument shapes below:
//   p1 (4B), p2 (8B):  register/value on every target.
//   p3 (12B), p4 (16B): SysV in/out registers up to 16B; Win64 by
//                       reference (size not 1/2/4/8); AAPCS64 in regs
//                       up to 16B.
//   p6 (24B):           SysV MEMORY (on the stack); Win64 by reference;
//                       AAPCS64 by reference.

struct p1 { int a; };
struct p2 { int a, b; };
struct p3 { int a, b, c; };
struct p4 { int a, b, c, d; };
struct p6 { int a, b, c, d, e, f; };

static long g_sum;

// Five aggregates of mixed size plus three scalars interleaved, so the
// register/stack split differs per ABI and the by-reference vs by-value
// vs by-stack paths all run in one call.
static void take_many(struct p2 a, int s0, struct p3 b, struct p1 c,
                      struct p4 d, int s1, struct p6 e, int s2) {
    g_sum = a.a + a.b
          + s0
          + b.a + b.b + b.c
          + c.a
          + d.a + d.b + d.c + d.d
          + s1
          + e.a + e.b + e.c + e.d + e.e + e.f
          + s2;
}

// Aggregate returns: 8B is value-in-register on Win64/SysV; 16B is
// two-register on SysV/AAPCS64 and indirect on Win64; 24B is indirect
// everywhere.
static struct p2 make2(int base) {
    struct p2 r; r.a = base; r.b = base + 1; return r;
}
static struct p4 make4(int base) {
    struct p4 r; r.a = base; r.b = base + 1; r.c = base + 2; r.d = base + 3;
    return r;
}
static struct p6 make6(int base) {
    struct p6 r;
    r.a = base; r.b = base + 1; r.c = base + 2;
    r.d = base + 3; r.e = base + 4; r.f = base + 5;
    return r;
}

int main(void) {
    struct p2 a = {10, 20};
    struct p3 b = {3, 4, 5};
    struct p1 c = {7};
    struct p4 d = {1, 2, 3, 4};
    struct p6 e = {100, 101, 102, 103, 104, 105};

    take_many(a, 1000, b, c, d, 2000, e, 3000);
    // 30 + 1000 + 12 + 7 + 10 + 2000 + 615 + 3000 = 6674
    if (g_sum != 6674) return 1;

    struct p2 r2 = make2(50);            // 50, 51
    if (r2.a != 50 || r2.b != 51) return 2;

    struct p4 r4 = make4(60);            // 60..63
    if (r4.a != 60 || r4.b != 61 || r4.c != 62 || r4.d != 63) return 3;

    struct p6 r6 = make6(70);            // 70..75
    if (r6.a != 70 || r6.b != 71 || r6.c != 72
        || r6.d != 73 || r6.e != 74 || r6.f != 75) return 4;

    // Pass a returned aggregate straight into a by-value parameter.
    struct p2 r2b = make2(r2.a + r2.b);  // 101, 102
    if (r2b.a != 101 || r2b.b != 102) return 5;

    return 0;
}
