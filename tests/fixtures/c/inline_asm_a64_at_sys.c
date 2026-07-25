/* AArch64 inline asm: the `at` address-translation instruction (operand of the
 * form s1e1r/s1e0w/s12e1r/...) and the generic `sys #op1, cN, cM, #op2{, Xt}`
 * system instruction that dc/ic/tlbi/at alias. The instructions are privileged,
 * so they sit in external-linkage functions that are emitted but never executed
 * by main; x86_64 has no such instruction and is skipped. */

unsigned long translate(unsigned long addr) {
    unsigned long par;
    __asm__ volatile("at s1e1r, %0" : : "r"(addr) : "memory");
    __asm__ volatile("mrs %0, par_el1" : "=r"(par));
    __asm__ volatile("at s1e0w, %0" : : "r"(addr) : "memory");
    return par;
}

void sys_maint(unsigned long addr) {
    /* Generic SYS spelling of a data-cache clean by VA, and the CRn=cN operand
     * form the user cache-maintenance handler builds. */
    __asm__ volatile("sys #3, c7, c10, #1, %0" : : "r"(addr) : "memory");
    /* Bare (no `#`) immediates, and a form without an Xt operand. */
    __asm__ volatile("sys 3, c7, c14, 1");
}

int main(void) { return 42; }
