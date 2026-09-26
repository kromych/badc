// An `L` constant has type `long double` (C99 6.4.4.2p4), and so do an
// arithmetic operation and a conditional with a `long double` operand
// (6.3.1.8p1, 6.5.15p5). `_Generic` and `sizeof` observe the type; the
// values go through temporaries, constant initializers and compound
// assignments. The exit code names the first check that fails.

#define KIND(e) _Generic((e), float: 1, double: 2, long double: 3, default: 0)
#define NOINLINE __attribute__((noinline))

static long double ld = 2.5L;
static double d = 1.5;
static float f = 0.5f;
static int i = 3;
static long double sum_static = 1.0L + 2.0L;
static long double third = 1.0L / 4;
static double narrowed = 1.0L / 8;
static float single = 2.0L * 3;
static int truncated = 2.5L;
static long double quarter = 10 / 40.0L;
static long double table[2] = {0.5L + 0.25, 3 * 0.5L};
enum { FROM_LD = (int)3.0L };
static char buf[(int)2.0L];
_Static_assert(sizeof(1.0L) == sizeof(long double), "sizeof(1.0L)");

NOINLINE static long double pick(int c, long double a, double b) { return c ? a : b; }

NOINLINE static double as_double(long double v) { return (double)v; }

int main(void)
{
    int c = i > 2;
    if (KIND(1.0L) != 3) return 1;
    if (KIND(1.0l) != 3) return 2;
    if (KIND(0x1p3L) != 3) return 3;
    if (KIND(1.0) != 2 || KIND(1.0f) != 1) return 4;
    if (KIND(ld + d) != 3 || KIND(d + ld) != 3) return 5;
    if (KIND(ld * i) != 3 || KIND(i * ld) != 3) return 6;
    if (KIND(f - ld) != 3 || KIND(ld / f) != 3) return 7;
    if (KIND(c ? ld : d) != 3 || KIND(c ? d : ld) != 3) return 8;
    if (KIND(c ? i : 1.0L) != 3) return 9;
    if (KIND(d * 2.0L) != 3) return 10;
    if (KIND(-1.0L) != 3) return 11;
    if (sizeof(1.0L) != sizeof(long double)) return 12;
    if (sizeof(ld + d) != sizeof(long double)) return 13;
    if (sizeof(c ? ld : d) != sizeof(long double)) return 14;
    if (sizeof(d + f) != sizeof(double)) return 15;
    long double t = ld * 2.0L + d;
    if (t != 6.5L) return 16;
    if (pick(1, 3.25L, 1.0) != 3.25L || pick(0, 3.25L, 1.0) != 1.0L) return 17;
    long double u = c ? ld : d;
    if (u != 2.5L) return 18;
    long double w = (c ? ld * 2 : d) + (c ? d : ld);
    if (w != 6.5L) return 19;
    if (sum_static != 3.0L || third != 0.25L) return 20;
    if (as_double(ld * 4.0L) != 10.0) return 21;
    double back = ld + 0.25L;
    if (back != 2.75) return 22;
    long double arr[3] = {1.0L, ld * 2, d / 3.0L};
    if (arr[0] != 1.0L || arr[1] != 5.0L || arr[2] != 0.5L) return 23;
    long double chain, chain2;
    chain = chain2 = ld + 1.0L;
    if (chain != 3.5L || chain2 != 3.5L) return 24;
    long double acc = 0;
    for (int k = 0; k < 4; k++) acc += k * 0.5L;
    if (acc != 3.0L) return 25;
    if (narrowed != 0.125 || single != 6.0f || truncated != 2) return 26;
    if (quarter != 0.25L || table[0] != 0.75L || table[1] != 1.5L) return 27;
    if (FROM_LD != 3 || sizeof(buf) != 2) return 28;
    switch (i) {
    case (int)3.0L: break;
    default: return 29;
    }
    long double e = c ? 1.0L : 2;
    long double g = !c ? 1.0L : 2;
    if (e != 1.0L || g != 2.0L) return 30;
    if (KIND(d += 1.0L) != 2 || KIND(ld += 1) != 3) return 31;
    long double h = ld;
    h += 0.5L;
    h *= 2;
    if (h != 6.0L) return 32;
    double dd = 2.0;
    dd *= 1.5L;
    if (dd != 3.0) return 33;
    return 0;
}
