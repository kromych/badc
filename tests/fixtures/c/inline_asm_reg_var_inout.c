/* GCC register-asm variables: an input and an output pinned to the
 * same register form a tied pair -- the register carries the input
 * value into the template and the output value out, the contract a
 * "0" matching constraint spells for pool operands. Covers a single
 * pair and the call-shaped form of four pairs with extra pinned
 * inputs. */

static long tied_pair(long v) {
#if defined(__x86_64__)
    register long in asm("rax") = v;
    register long out asm("rax");
    __asm__ volatile("addq $1, %%rax" : "=r"(out) : "r"(in));
    return out;
#elif defined(__aarch64__)
    register long in asm("x0") = v;
    register long out asm("x0");
    __asm__ volatile("add x0, x0, #1" : "=r"(out) : "r"(in));
    return out;
#else
    return v + 1;
#endif
}

static long quad_pairs(long a0, long a1, long a2, long a3, long a4, long a5) {
#if defined(__x86_64__)
    register long r0 asm("rax") = a0;
    register long r1 asm("rcx") = a1;
    register long r2 asm("rdx") = a2;
    register long r3 asm("rsi") = a3;
    register long r4 asm("r8") = a4;
    register long r5 asm("r9") = a5;
    register long o0 asm("rax");
    register long o1 asm("rcx");
    register long o2 asm("rdx");
    register long o3 asm("rsi");
    __asm__ volatile("addq %%r8, %%rax\n\t"
                     "addq %%r9, %%rcx\n\t"
                     "addq $2, %%rdx\n\t"
                     "addq $3, %%rsi"
                     : "=r"(o0), "=r"(o1), "=r"(o2), "=r"(o3)
                     : "r"(r0), "r"(r1), "r"(r2), "r"(r3), "r"(r4), "r"(r5)
                     : "memory");
    return o0 + o1 + o2 + o3;
#elif defined(__aarch64__)
    register long r0 asm("x0") = a0;
    register long r1 asm("x1") = a1;
    register long r2 asm("x2") = a2;
    register long r3 asm("x3") = a3;
    register long r4 asm("x4") = a4;
    register long r5 asm("x5") = a5;
    register long o0 asm("x0");
    register long o1 asm("x1");
    register long o2 asm("x2");
    register long o3 asm("x3");
    __asm__ volatile("add x0, x0, x4\n\t"
                     "add x1, x1, x5\n\t"
                     "add x2, x2, #2\n\t"
                     "add x3, x3, #3"
                     : "=r"(o0), "=r"(o1), "=r"(o2), "=r"(o3)
                     : "r"(r0), "r"(r1), "r"(r2), "r"(r3), "r"(r4), "r"(r5)
                     : "memory");
    return o0 + o1 + o2 + o3;
#else
    return (a0 + a4) + (a1 + a5) + (a2 + 2) + (a3 + 3);
#endif
}

int main(void) {
    if (tied_pair(4) != 5)
        return 1;
    /* (1+5) + (2+6) + (3+2) + (4+3) = 26 */
    if (quad_pairs(1, 2, 3, 4, 5, 6) != 26)
        return 2;
    return 42;
}
