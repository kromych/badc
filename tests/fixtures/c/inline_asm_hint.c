// GCC inline-asm statement, operand-free forms. c5 supports an empty
// template (a compiler barrier, no instruction emitted) and a single
// known operand-free hint instruction (`pause` on x86-64, `yield` on
// AArch64), lowered to the target spin-loop hint. The hint has no
// architectural effect, so the surrounding computation must be
// unaffected; the result is asserted by return code.

#if defined(__aarch64__)
#define CPU_PAUSE() asm volatile("yield" ::: "memory")
#elif defined(__x86_64__) || defined(__i386__)
#define CPU_PAUSE() asm volatile("pause" ::: "memory")
#else
#define CPU_PAUSE() do {} while (0)
#endif

static int spin_sum(int n) {
    int sum = 0;
    for (int i = 0; i < n; i++) {
        CPU_PAUSE();
        sum += i;
        // Empty template: a compiler barrier with no emitted
        // instruction.
        asm volatile("" ::: "memory");
    }
    return sum;
}

int main(void) {
    if (spin_sum(5) != 10) return 1;   // 0+1+2+3+4
    if (spin_sum(10) != 45) return 2;
    // A bare barrier outside a loop must also compile.
    asm volatile("");
    return 0;
}
