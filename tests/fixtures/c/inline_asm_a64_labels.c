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

static long parity_asm(long long v) {
    long r;
    // Test-bit forward branch on bit 0. (Immediates stay bitmask-encodable:
    // 4 and 6 are contiguous-run patterns, 5 is not.)
    __asm__("tbnz %1, #0, 1f\n\t"
            "orr %0, xzr, #4\n\t"
            "b 2f\n"
            "1:\n\t"
            "orr %0, xzr, #6\n"
            "2:"
            : "=r"(r)
            : "r"(v));
    return r; // odd ? 6 : 4
}

static long highbit_asm(unsigned long long v) {
    long r;
    // A bit number above 31 sets the encoding's high bit-number bit.
    __asm__("orr %0, xzr, #1\n\t"
            "tbz %1, #40, 1f\n\t"
            "orr %0, xzr, #3\n"
            "1:"
            : "=&r"(r)
            : "r"(v));
    return r; // bit 40 set ? 3 : 1
}

int main(void) {
    long s0 = sel_asm(0);           // 1
    long s1 = sel_asm(7);           // 2
    long d0 = absdiff_asm(3, 10);   // 7
    long d1 = absdiff_asm(10, 3);   // 7
    long c = count_asm(25);         // 25
    long p0 = parity_asm(6);        // 4
    long p1 = parity_asm(9);        // 6
    long h0 = highbit_asm(1ULL << 40); // 3
    long h1 = highbit_asm(0);       // 1
    if (s0 == 1 && s1 == 2 && d0 == 7 && d1 == 7 && c == 25 && p0 == 4 && p1 == 6
        && h0 == 3 && h1 == 1) {
        return 42;
    }
    return 1;
}
