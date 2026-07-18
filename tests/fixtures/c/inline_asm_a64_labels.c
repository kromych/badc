// AArch64 inline asm: local labels (`N:` definitions, `Nb` / `Nf` references)
// with the b / b.cond / cbz / cbnz branches. Each helper exercises one branch
// shape; main returns 42 only when every loop and skip lands where the
// architecture says. Native aarch64 only.

static long count_asm(long n) {
    long c;
    // Backward branch: decrement until zero, counting iterations.
    __asm__("orr %0, xzr, xzr\n"
            "1:\n\t"
            "add %0, %0, #1\n\t"
            "sub %1, %1, #1\n\t"
            "cbnz %1, 1b"
            : "=&r"(c), "+r"(n));
    return c; // n
}

static long sel_asm(long a) {
    long r;
    // Forward branches: a != 0 selects the second arm.
    __asm__("cbnz %1, 1f\n\t"
            "orr %0, xzr, #1\n\t"
            "b 2f\n"
            "1:\n\t"
            "orr %0, xzr, #2\n"
            "2:"
            : "=r"(r)
            : "r"(a));
    return r; // a ? 2 : 1
}

static long absdiff_asm(long a, long b) {
    long r;
    // Conditional forward branch over the operand-swapped recompute. The
    // output is written before the inputs' last read, hence early-clobber.
    __asm__("subs %0, %1, %2\n\t"
            "b.ge 1f\n\t"
            "sub %0, %2, %1\n"
            "1:"
            : "=&r"(r)
            : "r"(a), "r"(b));
    return r; // |a - b|
}

int main(void) {
    long s0 = sel_asm(0);           // 1
    long s1 = sel_asm(7);           // 2
    long d0 = absdiff_asm(3, 10);   // 7
    long d1 = absdiff_asm(10, 3);   // 7
    long c = count_asm(25);         // 25
    if (s0 == 1 && s1 == 2 && d0 == 7 && d1 == 7 && c == 25) {
        return 42;
    }
    return 1;
}
