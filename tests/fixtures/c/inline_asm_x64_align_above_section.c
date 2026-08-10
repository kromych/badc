/* x86-64 code-stream alignment above the 16-byte section default: the
 * directive raises the text alignment carried to the writers, so the
 * section-relative NOP padding holds absolutely. The label address
 * after each directive must be a multiple of the request at run time. */

static unsigned long after_align(void) {
    void *p;
    __asm__(".p2align 6\n\t"
            "1:\n\t"
            "leaq 1b(%%rip), %0"
            : "=r"(p));
    return (unsigned long)p;
}

static unsigned long after_balign(void) {
    void *p;
    __asm__(".balign 32\n\t"
            "1:\n\t"
            "leaq 1b(%%rip), %0"
            : "=r"(p));
    return (unsigned long)p;
}

int main(void) {
    if (after_align() % 64 != 0)
        return 1;
    if (after_balign() % 32 != 0)
        return 2;
    return 42;
}
