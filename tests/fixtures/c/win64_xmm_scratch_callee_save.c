// Win64 marks xmm6..xmm15 non-volatile. The x86_64 emit pass uses
// xmm13/14/15 as fixed FP scratch, so a function performing FP work must
// save and restore them around its body. The save offsets in the
// prologue and every epilogue path (scalar return, register-aggregate
// return, intra-unit tail call) must agree: a mismatch restores
// callee-saved GPRs from the wrong slot and leaves the caller's
// non-volatile xmm clobbered. This fixture exercises an FP function that
// returns a small struct by value (the register-aggregate return path)
// and one that does FP work across a call, then checks the results so a
// stack-corrupting epilogue mismatch fails the run on the Win64 target.
// It is a correctness check on every target; the saves are inert where
// the scratch registers are volatile (System V / AAPCS64).

struct pair {
    int lo;
    int hi;
};

static double mix(double a, double b, double c, double d, double e, double f) {
    return a * b + c * d + e * f;
}

static struct pair make(double a, double b, double c, double d, double e, double f) {
    struct pair p;
    double s = mix(a, b, c, d, e, f);
    p.lo = (int)s;
    p.hi = (int)(s * 2.0 + a);
    return p;
}

int main(void) {
    struct pair p = make(1.0, 2.0, 3.0, 4.0, 5.0, 6.0); // 2 + 12 + 30 = 44
    if (p.lo != 44) {
        return 1;
    }
    if (p.hi != 89) { // 44*2 + 1
        return 2;
    }
    // A second call with different arguments to exercise the path again.
    struct pair q = make(10.0, 1.0, 0.0, 0.0, 0.0, 0.0); // 10
    if (q.lo != 10) {
        return 3;
    }
    if (q.hi != 30) { // 10*2 + 10
        return 4;
    }
    return 0;
}
