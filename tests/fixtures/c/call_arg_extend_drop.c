// A direct internal call whose callee re-extends the parameter on
// entry (its every read is a narrow-kind ParamRef) does not need the
// caller-side re-extension of a computed argument; the callee derives
// the C99 6.5.2.2p4-converted value from the low bits itself. The
// checks pass values whose pre-truncation high bits are nonzero so a
// dropped extension that the callee failed to re-derive is caught.

static int addv(int a, int b) { return a + b; }

static int fib(int n) {
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}

// The parameter's cell address escapes: the prologue spills the raw
// incoming register, so the caller-side extension must survive here.
static long cell_escapes(int a) {
    int *p = &a;
    return (long)*p * 3;
}

static int narrow(signed char c, short s) { return c * 100 + s; }

int main(void) {
    long big = 0x7fffffff00000005L;
    int x = (int)big;
    if (addv(x - 1, x + 1) != 10) return 1;
    if (fib(x + 15) != 6765) return 2;
    if (cell_escapes(x - 12) != -21) return 3;
    if (narrow((signed char)(x + 0xEB), (short)(x - 0xFF0)) != -5675) return 4;
    return 0;
}
