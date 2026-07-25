/* An inline asm whose clobber list names the caller-saved integer
   registers -- the contract any asm that calls out must state -- forces
   its "r" operands into the callee-saved bank (rbx, r12..r15). The operand
   allocator must draw from every usable GP register, not just the
   caller-saved half, or such asm reports a spurious register exhaustion.
   heavy_clobber names seven of the caller-saved pool registers, leaving
   only the callee-saved bank for its five operands; many_operands needs
   more than half the GP file at once. Both round-trip each operand through
   its assigned register, so a wrong save/restore surfaces as a wrong sum. */
static long heavy_clobber(void) {
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
    return a + b + c + d + e; /* 11 + 22 + 33 + 44 + 55 */
}

static long many_operands(void) {
    long a = 1, b = 2, c = 3, d = 4, e = 5, f = 6, g = 7, h = 8, i = 9;
    __asm__ volatile("addq $1, %0\n\t"
                     "addq $1, %1\n\t"
                     "addq $1, %2\n\t"
                     "addq $1, %3\n\t"
                     "addq $1, %4\n\t"
                     "addq $1, %5\n\t"
                     "addq $1, %6\n\t"
                     "addq $1, %7\n\t"
                     "addq $1, %8"
                     : "+r"(a), "+r"(b), "+r"(c), "+r"(d), "+r"(e), "+r"(f),
                       "+r"(g), "+r"(h), "+r"(i)
                     :
                     : "cc");
    return a + b + c + d + e + f + g + h + i; /* each input + 1 */
}

int main(void) {
    if (heavy_clobber() != 165) {
        return 1;
    }
    if (many_operands() != 54) {
        return 2;
    }
    return 0;
}
