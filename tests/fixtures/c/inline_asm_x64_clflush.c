// x86-64 sizeless-memory cache ops (prefetcht0, clflush) via inline asm,
// reached through the catalogue passthrough. Both act on the cache line of a
// memory operand without changing its value, so the stored 42 survives.
// Native x86-64 only.

int main(void) {
    volatile int x = 42;
    __asm__ volatile("prefetcht0 %0\n\tclflush %0" : : "m"(x) : "memory");
    return x;
}
