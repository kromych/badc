/* A caller's values in the callee-saved registers must survive a call
   into a function whose inline asm takes rbx / r12..r15 as operand
   registers. clobber_heavy forces its five "+r" operands into the
   callee-saved bank by clobbering the caller-saved pool registers; the
   checker seeds rbx / r12..r15 inside one asm block, calls it, and folds
   the surviving values and the return value into one weighted sum, so a
   missed or crossed restore changes the result. The block declares every
   register the call may write; r9 stays out of the clobber list so the
   output has a pool register, and it is written only after the call.
   External linkage keeps the symbol for the asm `call` reference. */
long clobber_heavy(void) {
    long a = 10, b = 20, c = 30, d = 40, e = 50;
    __asm__ volatile("addq $1, %0\n\t"
                     "addq $2, %1\n\t"
                     "addq $3, %2\n\t"
                     "addq $4, %3\n\t"
                     "addq $5, %4"
                     : "+r"(a), "+r"(b), "+r"(c), "+r"(d), "+r"(e)
                     :
                     : "cc", "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9",
                       "memory");
    return a + b + c + d + e; /* 165 */
}

int main(void) {
    long sum;
    if (clobber_heavy() != 165) {
        return 1;
    }
    __asm__ volatile("movq $101, %%rbx\n\t"
                     "movq $103, %%r12\n\t"
                     "movq $107, %%r13\n\t"
                     "movq $109, %%r14\n\t"
                     "movq $113, %%r15\n\t"
                     "call clobber_heavy\n\t"
                     "movq %%rax, %0\n\t"
                     "addq %0, %0\n\t"
                     "addq %%rbx, %0\n\t"
                     "addq %0, %0\n\t"
                     "addq %%r12, %0\n\t"
                     "addq %0, %0\n\t"
                     "addq %%r13, %0\n\t"
                     "addq %0, %0\n\t"
                     "addq %%r14, %0\n\t"
                     "addq %0, %0\n\t"
                     "addq %%r15, %0"
                     : "=r"(sum)
                     :
                     : "rax", "rbx", "rcx", "rdx", "rsi", "rdi", "r8", "r10",
                       "r11", "r12", "r13", "r14", "r15", "cc", "memory");
    /* Weighted so a swapped or missed restore cannot cancel out. */
    if (sum != 32L * 165 + 16 * 101 + 8 * 103 + 4 * 107 + 2 * 109 + 113) {
        return 2;
    }
    return 0;
}
