/* Linux 7.3's arm64 __raw_readl chains two ALTERNATIVEs in one template, each
   defining 661..664 and placing its replacement in `.subsection 1` behind the
   function's code. The original sequence runs -- a nop, then the load --
   and neither replacement (a barrier, a load-acquire) does. Other targets
   take the plain load. */

#if defined(__aarch64__) && defined(__linux__)
#define ALT(old, new, cap)                                                    \
    ".if 1 == 1\n661:\n\t" old "\n662:\n"                                     \
    ".pushsection .altinstructions,\"a\"\n"                                   \
    " .word 661b - .\n .word 663f - .\n .hword " cap "\n"                     \
    " .byte 662b-661b\n .byte 664f-663f\n"                                    \
    ".popsection\n.subsection 1\n663:\n\t" new "\n664:\n\t"                   \
    ".org . - (664b-663b) + (662b-661b)\n\t"                                  \
    ".org . - (662b-661b) + (664b-663b)\n\t.previous\n.endif\n"

static unsigned long read_chain(const volatile unsigned long *p) {
    unsigned long v;
    __asm__ volatile(ALT("nop", "dmb osh", "0x0042") ALT("ldr %0, [%1]", "ldar %0, [%1]", "0x0043")
                     : "=r"(v)
                     : "r"(p)
                     : "memory");
    return v;
}
#else
static unsigned long read_chain(const volatile unsigned long *p) { return *p; }
#endif

int main(void) {
    volatile unsigned long x = 7, y = 11;
    if (read_chain(&x) != 7) return 1;
    if (read_chain(&y) + read_chain(&x) != 18) return 2;
    return 0;
}
