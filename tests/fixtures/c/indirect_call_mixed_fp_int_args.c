// Mixed integer and floating scalar arguments through a non-variadic
// function pointer: the integer and FP argument banks advance
// independently (AAPCS64 6.4.1 / SysV AMD64 3.2.3), routed at the call
// site by the argument-type mask. Interleaving the banks catches a
// mask that sends an FP argument through the integer bank or the
// reverse.

static int mixfn(int a, double x, int b, double y, float z, int c) {
    return a + (int)(x * 10.0) + b + (int)(y * 100.0) + (int)(z * 2.0f) + c;
}

typedef int (*mf)(int, double, int, double, float, int);

volatile int ione = 1;
volatile double dbase = 2.5;

int main(void) {
    mf p = mixfn;
    int a = ione;
    double x = dbase;
    int r = p(a, x, a + 2, 0.25, 1.5f, 7);
    /* 1 + 25 + 3 + 25 + 3 + 7 */
    if (r != 64) return 1;
    if (r != mixfn(a, x, a + 2, 0.25, 1.5f, 7)) return 2;
    return 0;
}
