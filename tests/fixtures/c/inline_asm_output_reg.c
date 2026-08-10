/* Output-bearing inline asm in a `static __always_inline` helper: -O
 * splices each callee through the reloc path, relocating the callee's
 * own output locals into the caller frame and remapping the asm operand
 * args (an output's destination address among them). The bodies also
 * encode out of line, so the -O0 and -O runs must agree. Mirrors the
 * kernel get_current (one "=r" output), __rdmsr (two outputs combined),
 * and __wrmsr (input-only, void) helper shapes. */

/* One register output written to an own local (get_current shape). */
static inline __attribute__((always_inline)) unsigned long rd(unsigned long x) {
    unsigned long out;
#if defined(__x86_64__)
    __asm__("leaq 7(%1), %0" : "=r"(out) : "r"(x));
#elif defined(__aarch64__)
    __asm__("add %0, %1, #7" : "=r"(out) : "r"(x));
#else
    out = x + 7;
#endif
    return out;
}

/* Two register outputs to own locals, then combined (rdmsr shape). */
static inline __attribute__((always_inline)) unsigned long two(unsigned long x) {
    unsigned long a, b;
#if defined(__x86_64__)
    __asm__("movq %2, %0\n\tmovq %2, %1" : "=&r"(a), "=&r"(b) : "r"(x));
#elif defined(__aarch64__)
    __asm__("mov %0, %2\n\tmov %1, %2" : "=&r"(a), "=&r"(b) : "r"(x));
#else
    a = x;
    b = x;
#endif
    return a + b;
}

/* Input-only asm, void (wrmsr shape): store x through the pointer. */
static inline __attribute__((always_inline)) void st(unsigned long *p, unsigned long x) {
#if defined(__x86_64__)
    __asm__ volatile("movq %1, (%0)" : : "r"(p), "r"(x) : "memory");
#elif defined(__aarch64__)
    __asm__ volatile("str %1, [%0]" : : "r"(p), "r"(x) : "memory");
#else
    *p = x;
#endif
}

int main(void) {
    unsigned long m = 0;
    st(&m, 5);
    if (rd(10) != 17)
        return 1;
    if (two(6) != 12)
        return 2;
    if (m != 5)
        return 3;
    return 42;
}
