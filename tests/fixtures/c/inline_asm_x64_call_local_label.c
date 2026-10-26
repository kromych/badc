// A `call` to a numeric local label of the same x86_64 asm block, as an
// auxiliary routine the block calls: backward (`call 1b`) and forward
// (`call 3f`), the rel32 near call GNU as encodes for any code-address
// operand. Gated on __x86_64__ with a portable fallback. Returns 42 when
// both forms compute the expected value.

#if defined(__x86_64__)
__attribute__((noinline)) static int backward(void) {
    int r;
    __asm__ volatile("jmp 2f\n"
                     "1:\n\t"
                     "movl $7, %%eax\n\t"
                     "ret\n"
                     "2:\n\t"
                     "call 1b\n\t"
                     "movl %%eax, %0\n"
                     : "=r"(r) : : "eax", "memory");
    return r;
}

__attribute__((noinline)) static int forward(void) {
    int r;
    __asm__ volatile("call 3f\n\t"
                     "jmp 4f\n"
                     "3:\n\t"
                     "movl $35, %%eax\n\t"
                     "ret\n"
                     "4:\n\t"
                     "movl %%eax, %0\n"
                     : "=r"(r) : : "eax", "memory");
    return r;
}

int main(void) { return backward() + forward(); }
#else
int main(void) { return 42; }
#endif
