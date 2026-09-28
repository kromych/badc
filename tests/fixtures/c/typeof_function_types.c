// C23 6.7.2.5: typeof names the operand's type, a type name's through all
// its derivations (C99 6.7.6) and an expression's whatever its form -- a
// call, `&x`, a member, an element, a conditional. A function type in it
// keeps its parameters, so a call through an object declared with the
// specifier converts its arguments to them (C99 6.5.2.2p7). Each check
// exits with its own code; success returns 0.

static int twice(int x) { return 2 * x; }
static double half(double x) { return x / 2; }
static double (*getfp(void))(double) { return half; }
static int (*arr[3])(int) = {twice, twice, twice};
static int (*fp)(int) = twice;

struct S {
    int (*m)(int);
    double (*t[2])(double);
} s = {twice, {half, half}};

int main(void) {
    __typeof__(int (*)(int)) a = twice;
    __typeof__(getfp()) b = half;
    __typeof__(arr) c = {twice, twice, twice};
    __typeof__(&fp) d = &fp;
    __typeof__(double (*)(double)) e = half;
    __typeof__(s.t) f = {half, half};
    __typeof__(1 ? s.m : 0) g = twice;
    __typeof__(double (*[2])(double)) h = {half, half};
    __typeof__(int (*(*)(void))(int)) k = 0;
    if (a(3) != 6) return 1;
    if (b(4) != 2) return 2;
    if (c[2](5) != 10 || sizeof(c) != 3 * sizeof(void *)) return 3;
    if ((*d)(7) != 14) return 4;
    if (e(4) != 2) return 5;
    if (f[1](8) != 4 || sizeof(f) != 2 * sizeof(void *)) return 6;
    if (g(9) != 18) return 7;
    if (h[0](6) != 3) return 8;
    if (k != 0) return 9;
    return 0;
}
