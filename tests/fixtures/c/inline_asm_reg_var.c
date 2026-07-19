/* GCC register-asm variables: `register T v asm("reg")` binds `v` to
 * the named register when it is an `r`-class inline-asm operand.
 * Covers the 64- and 32-bit operand widths and an input/output pair
 * with both operands pinned. */

int add_pinned(void) {
#if defined(__x86_64__)
    register long a asm("r9") = 30;
    register long b asm("r12") = 10;
    long out;
    __asm__("movq %1, %0; addq %2, %0" : "=r"(out) : "r"(a), "r"(b));
    return (int)out;
#elif defined(__aarch64__)
    register long a asm("x9") = 30;
    register long b asm("x12") = 10;
    long out;
    __asm__("add %0, %1, %2" : "=r"(out) : "r"(a), "r"(b));
    return (int)out;
#else
    return 40;
#endif
}

int narrow_pinned(void) {
#if defined(__x86_64__)
    register int v asm("r9") = 1;
    int out;
    __asm__("movl %1, %0; addl %1, %0" : "=r"(out) : "r"(v));
    return out;
#elif defined(__aarch64__)
    register int v asm("x9") = 1;
    int out;
    __asm__("add %w0, %w1, %w1" : "=r"(out) : "r"(v));
    return out;
#else
    return 2;
#endif
}

int main(void) {
    if (add_pinned() != 40)
        return 1;
    if (narrow_pinned() != 2)
        return 2;
    return 42;
}
