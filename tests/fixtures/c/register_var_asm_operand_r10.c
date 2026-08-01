/* A hypercall-style ABI names r10 for an argument: `register long v
   asm("r10")` must be bindable (r10 has no ABI role inside a function
   body), so the emitter's asm staging picks a register that avoids
   every bound operand. The templates read the architectural registers
   by name, proving the values sit in them when the asm runs. */
long g_saved;
long g_hit;
__attribute__((noinline)) void mark(void) { g_hit = 1; }

/* r10 + r8 pinned as inputs, combined from the raw register names. */
static long combine(long x, long y) {
    register long a4 asm("r10") = x;
    register long a5 asm("r8") = y;
    long out;
    __asm__("movq %%r10, %0\n\taddq %%r8, %0"
            : "=r"(out)
            : "r"(a4), "r"(a5));
    return out; /* x + y */
}

/* A `+r` operand round-trips through r10: load, template add, store
   back. */
static long roundtrip(long x) {
    register long v asm("r10") = x;
    __asm__("addq $5, %0" : "+r"(v) : : "cc");
    return v; /* x + 5 */
}

/* r10 and r11 both bound forces the staging scratch off both; the
   fallback register is allocator-visible and must be saved around the
   block (rbx here, live with `keep`). */
static long both_bound(long x, long y) {
    long keep = x * 3;
    register long p asm("r10") = x;
    register long q asm("r11") = y;
    long out;
    __asm__("movq %%r10, %0\n\taddq %%r11, %0"
            : "=r"(out)
            : "r"(p), "r"(q));
    return out + keep; /* x + y + 3x */
}

/* The template saves the r10-bound value to memory, then makes an
   indirect `call %c[fn]`: the call's target staging must not run
   through the bound r10 (r11 is clobbered too). */
static void read_before_call(long x) {
    register long tos asm("r10") = x;
    __asm__ volatile("movq %[t], %[s]\n\t"
                     "call %c[fn]\n\t"
                     : [s] "=m"(g_saved)
                     : [t] "r"(tos), [fn] "i"(mark)
                     : "cc", "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9",
                       "r11", "memory");
}

int main(void) {
    if (combine(30, 12) != 42) {
        return 1;
    }
    if (roundtrip(37) != 42) {
        return 2;
    }
    if (both_bound(10, 2) != 42) {
        return 3;
    }
    read_before_call(42);
    if (g_saved != 42) {
        return 4;
    }
    if (g_hit != 1) {
        return 5;
    }
    return 0;
}
