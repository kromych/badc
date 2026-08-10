/* GCC named asm operands: `[name] "constraint"(expr)` in the output and
 * input lists, referenced from the template as `%[name]` and with a
 * modifier letter as `%<mod>[name]`. Named and positional references
 * may mix; the same operand is reachable both ways. */

int move_named(int a) {
    int r;
#if defined(__x86_64__)
    __asm__("mov %[src], %[dst]" : [dst] "=r"(r) : [src] "r"(a));
#elif defined(__aarch64__)
    __asm__("mov %w[dst], %w[src]" : [dst] "=r"(r) : [src] "r"(a));
#else
    r = a;
#endif
    return r;
}

long add_mixed(long a, long b) {
    long r;
#if defined(__x86_64__)
    /* Positional %2 and named %[x] address the same statement. */
    __asm__("mov %[x], %[out]; add %2, %[out]" : [out] "=r"(r) : [x] "r"(a), "r"(b));
#elif defined(__aarch64__)
    __asm__("add %[out], %[x], %2" : [out] "=r"(r) : [x] "r"(a), "r"(b));
#else
    r = a + b;
#endif
    return r;
}

int modifier_named(int a) {
    int r;
#if defined(__x86_64__)
    /* `%k[name]`: the 32-bit register view of a named operand. */
    __asm__("movl %k[v], %k[o]; addl %k[v], %k[o]" : [o] "=r"(r) : [v] "r"(a));
#elif defined(__aarch64__)
    /* `%w[name]`: the 32-bit register view of a named operand. */
    __asm__("add %w[o], %w[v], %w[v]" : [o] "=r"(r) : [v] "r"(a));
#else
    r = a + a;
#endif
    return r;
}

int rw_named(int a) {
#if defined(__x86_64__)
    __asm__("addl $5, %[v]" : [v] "+r"(a));
#elif defined(__aarch64__)
    __asm__("add %w[v], %w[v], #5" : [v] "+r"(a));
#else
    a += 5;
#endif
    return a;
}

int main(void) {
    if (move_named(7) != 7)
        return 1;
    if (add_mixed(30, 12) != 42)
        return 2;
    if (modifier_named(21) != 42)
        return 3;
    if (rw_named(37) != 42)
        return 4;
    return 42;
}
