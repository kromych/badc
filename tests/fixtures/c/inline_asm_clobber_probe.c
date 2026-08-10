/* Inline-asm clobber avoidance: an operand's register must not be one the
 * template clobbers. Each probe writes a known value into a plain "r" output,
 * then trashes the registers named in the clobber list; if the operand shared
 * a clobbered register the value would be destroyed. gcc and clang keep the
 * operand clear of the clobber list, and so must badc. The x86 and AArch64
 * backends allocate operands independently, so each is exercised on its own
 * target; the interpreter models the x86 path. */

static int gp_clobber_probe(void) {
    int result;
#if defined(__x86_64__)
    __asm__ volatile("movl $0x1234, %0\n\t"
                     "movl $0, %%eax\n\t"
                     "movl $0, %%ebx\n\t"
                     "movl $0, %%ecx\n\t"
                     "movl $0, %%edx\n\t"
                     : "=r"(result)
                     :
                     : "rax", "rbx", "rcx", "rdx");
#elif defined(__aarch64__)
    __asm__ volatile("mov %w0, #0x1234\n\t"
                     "mov x0, #0\n\t"
                     "mov x1, #0\n\t"
                     "mov x2, #0\n\t"
                     "mov x3, #0\n\t"
                     : "=r"(result)
                     :
                     : "x0", "x1", "x2", "x3");
#else
    result = 0x1234;
#endif
    return result;
}

int main(void) {
    return gp_clobber_probe() == 0x1234 ? 42 : 1;
}
