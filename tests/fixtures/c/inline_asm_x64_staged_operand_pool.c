/* A staged x86-64 asm statement -- an early-clobber output may not share
   an input's register, so the operands cannot bind directly -- assigns
   its `r` operands from the staged pool: the caller-saved registers
   first, so a two-operand statement costs no callee-saved save /
   restore and no frame. two_r round-trips both operands through their
   assigned registers; three_r keeps drawing caller-saved registers past
   the second operand. */
__attribute__((noinline)) static long two_r(long x) {
    long out;
    __asm__("leaq 1(%1), %0" : "=&r"(out) : "r"(x) : "cc");
    return out;
}

static long three_r(long x, long y, long z) {
    long out;
    __asm__("leaq (%1,%2), %0\n\t"
            "addq %3, %0"
            : "=&r"(out)
            : "r"(x), "r"(y), "r"(z)
            : "cc");
    return out;
}

int main(void) {
    if (two_r(41) != 42)
        return 1;
    if (three_r(1, 2, 39) != 42)
        return 2;
    return 0;
}
