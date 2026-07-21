/* x86-64 r11 sits next to the emitter's reserved asm-staging scratch
   (r10) yet is bindable: a stack-switch idiom pins a scratch value to
   it. A `+r` output round-trips through the register, and a value read
   before a `call %c[fn]` survives because the indirect call stages its
   target through r10, not the bound r11. */
long g_hit, g_saved;
__attribute__((noinline)) void mark(void) { g_hit = 1; }

static long roundtrip(long x) {
    register long v asm("r11") = x;
    __asm__("addq $5, %0" : "+r"(v) : : "cc");
    return v; /* x + 5 */
}

static void read_before_call(long x) {
    register long tos asm("r11") = x;
    __asm__ volatile("movq %[t], %[s]\n\t"
                     "call %c[fn]\n\t"
                     : [s] "=m"(g_saved)
                     : [t] "r"(tos), [fn] "i"(mark)
                     : "cc", "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9",
                       "r10", "memory");
}

int main(void) {
    if (roundtrip(37) != 42) {
        return 1;
    }
    read_before_call(42);
    if (g_saved != 42) {
        return 2;
    }
    if (g_hit != 1) {
        return 3;
    }
    return 0;
}
