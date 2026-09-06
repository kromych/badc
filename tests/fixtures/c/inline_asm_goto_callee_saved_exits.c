/* A callee-saved register an inline-asm block writes is preserved by the
 * prologue, not by a store at the site. A save at the site is not run
 * back on the edges that leave the block without reaching its restore:
 * an `asm goto` label a branch the template did not plant reaches, the
 * shape a jump-label patch and an exception-table fixup take. The
 * prologue's save is also the only form DWARF CFI and the kernel's ORC
 * express, since it holds on every path out of the function.
 *
 * `leaves_by_patched_branch` clobbers a callee-saved register and leaves
 * through the label's own address held in a register, so no restore
 * trampoline stands on that edge. `main` seeds the same register, calls
 * it, and folds the surviving value into the result. */

long leaves_by_patched_branch(long v);

long leaves_by_patched_branch(long v) {
    void *t = &&out;
#if defined(__x86_64__)
    __asm__ goto("movq $0, %%rbx\n\t"
                 "jmp *%1"
                 : : "r"(v), "r"(t) : "rbx" : out);
#elif defined(__aarch64__)
    __asm__ goto("mov x20, xzr\n\t"
                 "br %1"
                 : : "r"(v), "r"(t) : "x20" : out);
#else
    if (t) goto out;
#endif
    return 0;
out:
    return v + 1;
}

int main(void) {
    long sum = 0;
    if (leaves_by_patched_branch(6) != 7) {
        return 1;
    }
#if defined(__x86_64__)
    __asm__ volatile("movq $101, %%rbx\n\t"
                     "movq $6, %%rdi\n\t"
                     "call leaves_by_patched_branch\n\t"
                     "addq %%rbx, %%rax\n\t"
                     "movq %%rax, %0"
                     : "=r"(sum)
                     :
                     : "rax", "rbx", "rcx", "rdx", "rsi", "rdi", "r8", "r9",
                       "r10", "r11", "cc", "memory");
#elif defined(__aarch64__)
    __asm__ volatile("mov x20, #101\n\t"
                     "mov x0, #6\n\t"
                     "bl leaves_by_patched_branch\n\t"
                     "add %0, x0, x20"
                     : "=r"(sum)
                     :
                     : "x0", "x20", "x30", "cc", "memory");
#else
    sum = leaves_by_patched_branch(6) + 101;
#endif
    if (sum != 108) {
        return 2;
    }
    return 42;
}
