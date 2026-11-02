// Accesses to file-scope and block-scope static objects at constant
// offsets: loads of every integer width and both float widths, register and
// immediate stores (an immediate of each width, the quadword one
// sign-extended from 32 bits), zero tests that branch, members and
// constant-index elements, a volatile object. The exit code names the first
// check that fails.

#define NOINLINE __attribute__((noinline))

long long q;
int w;
short h;
signed char b;
unsigned char ub;
unsigned short uh;
unsigned uw;
double d = 1.5;
float f = 2.25f;
struct rec {
    char tag;
    short s;
    int i;
    long long l;
    double x;
} r;
int tab[8];
volatile int vw;

NOINLINE static void store_imm(void) {
    q = -1;
    w = 0x12345678;
    h = -2;
    b = -128;
    ub = 255;
    uh = 65535;
    uw = 0x80000000u;
    r.tag = 'z';
    r.s = 300;
    r.i = -7;
    r.l = 0x7fffffff;
    r.x = 0.5;
    tab[3] = 33;
    tab[7] = 77;
}

NOINLINE static long long sum(void) {
    return q + w + h + b + ub + uh + uw + r.tag + r.s + r.i + r.l + tab[3] + tab[7];
}

NOINLINE static void store_reg(long long v) {
    q = v;
    w = (int)v;
    h = (short)v;
    b = (signed char)v;
}

NOINLINE static int zero_tests(void) {
    int n = 0;
    if (b)
        n |= 1;
    if (h)
        n |= 2;
    if (w)
        n |= 4;
    if (q)
        n |= 8;
    if (ub)
        n |= 16;
    return n;
}

NOINLINE static double floats(void) {
    f = (float)d;
    d = d * 2 + r.x;
    return d + f;
}

NOINLINE static int counter(void) {
    static int c;
    return ++c;
}

NOINLINE static int vol(void) {
    vw = 5;
    vw += 1;
    return vw;
}

int main(void) {
    if (zero_tests() != 0) return 1;
    store_imm();
    if (sum() != 4600453375LL) return 2;
    if (zero_tests() != 31) return 3;
    store_reg(0x100000000LL);
    if (q != 0x100000000LL || w != 0 || h != 0 || b != 0) return 4;
    if (zero_tests() != 24) return 5;
    store_reg(-3);
    if (sum() != 4295033598LL) return 6;
    if (floats() != 5.0 || f != 1.5f) return 7;
    if (floats() != 11.0 || f != 3.5f) return 8;
    counter();
    if (counter() != 2) return 9;
    if (vol() != 6) return 10;
    return 0;
}
