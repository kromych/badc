// A constant `?:` over arithmetic arms has the type the usual arithmetic
// conversions give the two arms (C99 6.5.15p5), whichever arm it selects:
// (1 ? -1 : 0u) is the unsigned int 0xFFFFFFFF, so it widens to 4294967295
// and compares above 0, in every constant context. A floating constant has
// the type of its literal or conversion, `float` arithmetic rounds to
// `float` (6.3.1.8), and an initializer converts as if by assignment
// (6.7.8p11). The exit status is the number of the first check that fails.
_Static_assert((1 ? -1 : 0u) > 0, "the result is unsigned int");

static unsigned long long s1 = (1 ? -1 : 0u);
static long long s2 = (0 ? 1u : -1);
static double s3 = (1 ? 1 : 2.5);
static unsigned long long s4 = (1 ? -1 : 0ull);
static long long s5 = (1 ? -1ll : 0u);
static int s6 = (1 ? (short)-1 : (unsigned short)0);
static unsigned long long s7 = (-1 ?: 0u);
static unsigned long long s8 = (1 ? (0 ? 2 : -1) : 0u);
enum { E = (1 ? -1 : 0u) > 0 };
static char arr[(1 ? -1 : 0u) > 0 ? 3 : 5];

static unsigned long long b1[] = { 5, 1 ? -1 : 0u };
static struct { char c; unsigned long long m; } b2 = { 1, (0 ? 1u : -1) };
static struct { int p; long long m; } b3 = { .m = 1 ? -1 : 0u };
static long long b4[] = { (1 ? 1ll << 40 : 0) >> 20 };
static double f1 = 1 ? 16777217 : 1.0f;
static double f2[] = { 16777217 + 1.0f };
static double f3 = (float)16777217;
static double f4 = { 0.1f * 3 };
static _Bool z1 = (_Bool)0.5;
static double *p1 = (double *)0 + 1;
static double d5 = (double)(float)0.1;

static int case_of(unsigned long long v) {
    switch (v) {
    case (1 ? -1 : 0u):
        return 1;
    default:
        return 0;
    }
}

int main(void) {
    unsigned long long a1[] = { 1 ? -1 : 0u };
    if (s1 != 4294967295ull)
        return 1;
    if (s2 != 4294967295ll)
        return 2;
    if (s3 != 1.0)
        return 3;
    if (s4 != 0xFFFFFFFFFFFFFFFFull)
        return 4;
    if (s5 != -1)
        return 5;
    if (s6 != -1)
        return 6;
    if (s7 != 4294967295ull)
        return 7;
    if (s8 != 4294967295ull)
        return 8;
    if (E != 1)
        return 9;
    if (sizeof arr != 3)
        return 10;
    if (!case_of(4294967295ull))
        return 11;
    if (b1[1] != 4294967295ull)
        return 12;
    if (b2.m != 4294967295ull)
        return 13;
    if (b3.m != 4294967295ll)
        return 14;
    if (b4[0] != 1ll << 20)
        return 15;
    if (f1 != 16777216.0)
        return 16;
    if (f2[0] != 16777216.0)
        return 17;
    if (f3 != 16777216.0)
        return 18;
    if (f4 != 0x1.333334p-2)
        return 19;
    if (a1[0] != 4294967295ull)
        return 20;
    if (z1 != 1)
        return 21;
    if ((unsigned long)p1 != sizeof(double))
        return 22;
    if (d5 != (double)0.1f)
        return 23;
    return 0;
}
