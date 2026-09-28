// x86-64 inline asm whose register operands are their values' registers:
// inputs in the argument registers, a read-write output whose old value is
// read after the statement, three inputs with r10 and r11 clobbered, `r`
// given a constant and a static address, inputs live across a call with one
// of them spilled, and `x` vector operands, one pair reloaded after a call.
// Each template reads its inputs before it writes a `=` output. Returns 42.
// Native x86-64 only.

#define NOINLINE __attribute__((noinline))

NOINLINE static unsigned long add2(unsigned long x, unsigned long y) {
    __asm__("add %1, %0" : "+r"(x) : "r"(y));
    return x;
}

NOINLINE static unsigned long sum3(unsigned long a, unsigned long b, unsigned long c) {
    unsigned long r;
    __asm__("lea (%1,%2), %%r11\n\tlea (%%r11,%3), %0" : "=r"(r) : "r"(a), "r"(b), "r"(c) : "r11");
    return r;
}

NOINLINE static unsigned long keep_old(unsigned long x, unsigned long y) {
    unsigned long t = x;
    __asm__("add %1, %0" : "+r"(x) : "r"(y));
    return x * 3 + t;
}

/* The scratch is r9, r8 and rdx, the last of which c arrives in. */
NOINLINE static unsigned long scratch_clobbered(unsigned long a, unsigned long b, unsigned long c) {
    __asm__("add %1, %0\n\tadd %2, %0\n\txor %%r10, %%r10\n\txor %%r11, %%r11"
            : "+r"(a)
            : "r"(b), "r"(c)
            : "r10", "r11");
    return a;
}

static unsigned long scratch_constants(void) {
    unsigned long r = 1;
    __asm__("add %1, %0\n\tadd %2, %0\n\txor %%r10, %%r10\n\txor %%r11, %%r11"
            : "+r"(r)
            : "r"(2UL), "r"(3UL)
            : "r10", "r11");
    return r;
}

static unsigned long table[4] = {3, 5, 7, 11};

static unsigned long statics(void) {
    unsigned long r = 100;
    __asm__("add 8(%1), %0\n\tadd %2, %0" : "+r"(r) : "r"(table), "r"(5UL));
    return r;
}

NOINLINE static unsigned long sink(unsigned long v) {
    return v + 1;
}

/* Six inputs live across the call and five callee-saved registers: one
   reaches its statement from a spill slot. */
NOINLINE static unsigned long across_call(unsigned long a, unsigned long b, unsigned long c,
                                          unsigned long d, unsigned long e, unsigned long f) {
    unsigned long s = sink(a);
    unsigned long r1, r2;
    __asm__("lea (%1,%2), %%r11\n\tlea (%%r11,%3), %0" : "=r"(r1) : "r"(a), "r"(b), "r"(c) : "r11");
    __asm__("lea (%1,%2), %%r11\n\tlea (%%r11,%3), %0" : "=r"(r2) : "r"(d), "r"(e), "r"(f) : "r11");
    return r1 * 100 + r2 + s;
}

typedef int v4si __attribute__((vector_size(16)));

static v4si vin[2] = {{1, 2, 3, 4}, {10, 20, 30, 40}};
static v4si vout[2];

NOINLINE static void vec_add(void) {
    v4si a = vin[0], b = vin[1], r;
    __asm__("vpaddd %2, %1, %0" : "=x"(r) : "x"(a), "x"(b));
    vout[0] = r;
}

/* No xmm register is callee-saved: a and b reach the statement from memory. */
NOINLINE static unsigned long vec_across_call(void) {
    v4si a = vin[0], b = vin[1];
    unsigned long s = sink(0);
    __asm__("paddd %1, %0" : "+x"(a) : "x"(b));
    vout[1] = a;
    return s;
}

static int lanes(const v4si *v) {
    const int *p = (const int *)v;
    return p[0] + p[1] + p[2] + p[3];
}

/* Read through a volatile, so no callee sees a constant argument. */
static volatile unsigned long in[7] = {20, 22, 1, 2, 3, 4, 5};

int main(void) {
    unsigned long one = in[2], two = in[3], three = in[4], four = in[5], five = in[6];
    if (add2(in[0], in[1]) != 42)
        return 1;
    if (sum3(three, four, five) != 12)
        return 2;
    if (keep_old(five, five + 1) != 38)
        return 3;
    if (scratch_clobbered(one, two, three) != 6 || scratch_constants() != 6)
        return 4;
    if (statics() != 110)
        return 5;
    if (across_call(one, two, three, four, five, five + 1) != 617)
        return 6;
    vec_add();
    if (lanes(&vout[0]) != 110 || vec_across_call() != 1 || lanes(&vout[1]) != 110)
        return 7;
    return 42;
}
