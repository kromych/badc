// Inline asm statements with more than one register output, each output a
// value of its own: a pair of fixed-register outputs, four fixed outputs
// from one input, outputs nothing reads, a flag output beside a read-write
// one, two `r` outputs over two inputs, early-clobber outputs of an
// exclusive-access loop, and two outputs live across a call with more
// values live than callee-saved registers. Each template reads its inputs
// before it writes a non-`&` output. Exits 0 when every value is right, a
// distinct code per failure.

#define NOINLINE __attribute__((noinline))

static volatile unsigned long long in[4] = {1, 7, 5, 9};

NOINLINE static unsigned long long pair(void) {
    unsigned int lo, hi;
#if defined(__x86_64__)
    asm volatile("movl $0x12345678, %%eax\n\tmovl $0x9abc, %%edx" : "=a"(lo), "=d"(hi));
#elif defined(__aarch64__)
    asm volatile("mov %w0, #0x5678\n\tmovk %w0, #0x1234, lsl #16\n\tmov %w1, #0x9abc"
                 : "=r"(lo), "=r"(hi));
#else
    lo = 0x12345678u;
    hi = 0x9abcu;
#endif
    return ((unsigned long long)hi << 32) | lo;
}

NOINLINE static unsigned int four(unsigned int x) {
    unsigned int a, b, c, d;
#if defined(__x86_64__)
    asm("movl %4, %%eax\n\tleal 1(%%rax), %%ebx\n\tleal 2(%%rax), %%ecx\n\tleal 3(%%rax), %%edx"
        : "=a"(a), "=b"(b), "=c"(c), "=d"(d)
        : "r"(x));
#elif defined(__aarch64__)
    asm("mov w9, %w4\n\tadd %w0, w9, #0\n\tadd %w1, w9, #1\n\tadd %w2, w9, #2\n\tadd %w3, w9, #3"
        : "=r"(a), "=r"(b), "=r"(c), "=r"(d)
        : "r"(x)
        : "x9");
#else
    a = x;
    b = x + 1;
    c = x + 2;
    d = x + 3;
#endif
    return a * 1000 + b * 100 + c * 10 + d;
}

NOINLINE static unsigned long long dead(unsigned long long x) {
    unsigned long long d0, d1, r;
#if defined(__x86_64__)
    asm("movq %3, %%rax\n\tmovq $1, %%rdi\n\tmovq $2, %%rsi\n\taddq $5, %%rax"
        : "=D"(d0), "=S"(d1), "=a"(r)
        : "r"(x));
#elif defined(__aarch64__)
    asm("add %2, %3, #5\n\tmov %0, #1\n\tmov %1, #2" : "=r"(d0), "=r"(d1), "=r"(r) : "r"(x));
#else
    d0 = 1;
    d1 = 2;
    r = x + 5;
#endif
    (void)d0;
    (void)d1;
    return r;
}

NOINLINE static unsigned long long dead_bound(unsigned long long x) {
    unsigned long long unused, r;
#if defined(__x86_64__)
    asm("leaq 3(%2), %1\n\tmovq $7, %0" : "=r"(unused), "=r"(r) : "r"(x));
#elif defined(__aarch64__)
    asm("add %1, %2, #3\n\tmov %0, #7" : "=r"(unused), "=r"(r) : "r"(x));
#else
    unused = 7;
    r = x + 3;
#endif
    (void)unused;
    return r;
}

NOINLINE static int cas(unsigned long long *p, unsigned long long *old, unsigned long long nv) {
    unsigned long long o = *old;
    int ok;
#if defined(__x86_64__)
    unsigned char z;
    asm volatile("lock cmpxchgq %[nv], %[ptr]"
                 : "=@ccz"(z), [ptr] "+m"(*p), "+a"(o)
                 : [nv] "r"(nv)
                 : "memory");
    ok = z;
    if (!ok)
        *old = o;
#elif defined(__aarch64__)
    unsigned long long prev;
    unsigned int fail;
    asm volatile("1: ldxr %0, %2\n\tcmp %0, %3\n\tb.ne 2f\n\tstxr %w1, %4, %2\n\tcbnz %w1, 1b\n2:"
                 : "=&r"(prev), "=&r"(fail), "+Q"(*p)
                 : "r"(o), "r"(nv)
                 : "cc", "memory");
    ok = prev == o;
    if (!ok)
        *old = prev;
#else
    ok = *p == o;
    if (ok)
        *p = nv;
    else
        *old = *p;
#endif
    return ok;
}

NOINLINE static unsigned long long sumdiff(unsigned long long x, unsigned long long y) {
    unsigned long long s, d;
#if defined(__x86_64__)
    asm("movq %2, %%r10\n\tmovq %3, %%r11\n\tleaq (%%r10,%%r11), %0\n\tsubq %%r11, %%r10\n\t"
        "movq %%r10, %1"
        : "=r"(s), "=r"(d)
        : "r"(x), "r"(y)
        : "r10", "r11");
#elif defined(__aarch64__)
    asm("add x9, %2, %3\n\tsub x10, %2, %3\n\tmov %0, x9\n\tmov %1, x10"
        : "=r"(s), "=r"(d)
        : "r"(x), "r"(y)
        : "x9", "x10");
#else
    s = x + y;
    d = x - y;
#endif
    return s * 100 + d;
}

NOINLINE static unsigned long long sink(unsigned long long v) {
    return v + 1;
}

/* Five call results, the two outputs and the operands of the second call
   live across calls. */
NOINLINE static unsigned long long across(unsigned long long a, unsigned long long b,
                                          unsigned long long c, unsigned long long d,
                                          unsigned long long e) {
    unsigned long long s1 = sink(a), s2 = sink(b), s3 = sink(c), s4 = sink(d), s5 = sink(e);
    unsigned long long p, q;
#if defined(__x86_64__)
    asm("movq %2, %%r10\n\tmovq %3, %%r11\n\tleaq (%%r10,%%r11), %0\n\tsubq %%r11, %%r10\n\t"
        "movq %%r10, %1"
        : "=r"(p), "=r"(q)
        : "r"(a), "r"(b)
        : "r10", "r11");
#elif defined(__aarch64__)
    asm("add x9, %2, %3\n\tsub x10, %2, %3\n\tmov %0, x9\n\tmov %1, x10"
        : "=r"(p), "=r"(q)
        : "r"(a), "r"(b)
        : "x9", "x10");
#else
    p = a + b;
    q = a - b;
#endif
    unsigned long long t = sink(p);
    return s1 + s2 + s3 + s4 + s5 + p * 3 + q + t;
}

int main(void) {
    unsigned long long one = in[0], seven = in[1], five = in[2], nine = in[3];
    if (pair() != 0x9abc12345678ull)
        return 1;
    if (four((unsigned int)one) != 1234)
        return 2;
    if (dead(seven) != 12 || dead_bound(seven) != 10)
        return 3;
    unsigned long long cell = 5, old = 5;
    if (!cas(&cell, &old, 9) || cell != 9)
        return 4;
    old = 5;
    if (cas(&cell, &old, 11) || cell != 9 || old != 9)
        return 5;
    if (sumdiff(seven, five) != 1202)
        return 6;
    /* s = 2 + 8 + 6 + 10 + 2, p = 8, q = -6, t = 9. */
    if (across(one, seven, five, nine, one) != 28 + 24 - 6 + 9)
        return 7;
    return 0;
}
