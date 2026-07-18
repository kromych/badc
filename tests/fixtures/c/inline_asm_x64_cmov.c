// x86-64 cmovcc inline asm: branchless conditional select reached through the
// catalogue passthrough. max_asm/min_asm exercise cmovl and cmovg on both the
// taken and not-taken paths. Returns 42. Native x86-64 only.

static long max_asm(long a, long b) {
    __asm__("cmp %1, %0\n\tcmovl %1, %0" : "+r"(a) : "r"(b) : "cc");
    return a;
}

static long min_asm(long a, long b) {
    __asm__("cmp %1, %0\n\tcmovg %1, %0" : "+r"(a) : "r"(b) : "cc");
    return a;
}

int main(void) {
    long m1 = max_asm(20, 42);  // 42, cmovl taken
    long m2 = max_asm(42, 10);  // 42, cmovl not taken
    long m3 = min_asm(100, 42); // 42, cmovg taken
    long m4 = min_asm(42, 99);  // 42, cmovg not taken
    if (m1 == 42 && m2 == 42 && m3 == 42 && m4 == 42) {
        return 42;
    }
    return 1;
}
