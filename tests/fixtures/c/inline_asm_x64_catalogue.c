// x86-64 inline asm reaching catalogue mnemonics through the generic parser
// passthrough (neg, not, xchg, rol, adc) -- instructions the table encodes but
// that have no bespoke Mnemonic arm. Returns 42 only when each produces the
// architecturally correct result. Native x86-64 only.

static long neg_asm(long x) {
    __asm__("neg %0" : "+r"(x));
    return x;
}

static long not_asm(long x) {
    __asm__("not %0" : "+r"(x));
    return x;
}

int main(void) {
    long a = neg_asm(-20);                        // 20
    long b = not_asm(-8);                         // ~(-8) = 7
    long x = 100, y = 15;
    __asm__("xchg %0, %1" : "+r"(x), "+r"(y));    // x=15, y=100
    long r = 5;
    __asm__("rol $1, %0" : "+r"(r));              // 10
    long p = 20, q = 22;
    // add $0 clears the carry; adc then adds with that carry: 20 + 22 = 42.
    __asm__("add $0, %0\n\tadc %1, %0" : "+r"(p) : "r"(q) : "cc"); // 42
    if (a == 20 && b == 7 && x == 15 && y == 100 && r == 10 && p == 42) {
        return 42;
    }
    return 1;
}
