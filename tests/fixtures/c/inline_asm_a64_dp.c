// AArch64 inline asm: multiply, conditional select, and a one-byte output.
// Each helper lowers a distinct form through the general inline-asm path;
// main returns 42 only when all three produce the architecturally correct
// result. Native aarch64 only.

static long mul_asm(long a, long b) {
    long r;
    __asm__("mul %0, %1, %2" : "=r"(r) : "r"(a), "r"(b));
    return r;
}

static long min_asm(long a, long b) {
    long r;
    // Set the flags, then select the smaller signed value.
    __asm__("subs xzr, %1, %2\n\tcsel %0, %1, %2, lt" : "=r"(r) : "r"(a), "r"(b));
    return r;
}

static unsigned char low_byte_asm(int v) {
    unsigned char r;
    // A one-byte output: the register holds the full value; the store-back
    // narrows to the low byte.
    __asm__("add %w0, %w1, #0" : "=r"(r) : "r"(v));
    return r;
}

static unsigned long div_asm(unsigned long a, unsigned long b) {
    unsigned long r;
    __asm__("udiv %0, %1, %2" : "=r"(r) : "r"(a), "r"(b));
    return r;
}

static long clz_asm(long v) {
    long r;
    // Count leading zeros: 1 has 63 in a 64-bit register.
    __asm__("clz %0, %1" : "=r"(r) : "r"(v));
    return r;
}

static long madd_asm(long a, long b, long c) {
    long r;
    // Multiply-accumulate: r = a * b + c.
    __asm__("madd %0, %1, %2, %3" : "=r"(r) : "r"(a), "r"(b), "r"(c));
    return r;
}

static unsigned int rev_asm(unsigned int v) {
    unsigned int r;
    // Byte-reverse a 32-bit word: 0x11223344 -> 0x44332211.
    __asm__("rev %w0, %w1" : "=r"(r) : "r"(v));
    return r;
}

int main(void) {
    long p = mul_asm(6, 7);            // 42
    long m = min_asm(10, 20);          // 10
    unsigned char b = low_byte_asm(0x142); // 0x42
    unsigned long d = div_asm(84, 2);  // 42
    long c = clz_asm(1);               // 63
    long ma = madd_asm(5, 8, 2);       // 42
    unsigned int rv = rev_asm(0x11223344); // 0x44332211
    if (p == 42 && m == 10 && b == 0x42 && d == 42 && c == 63 && ma == 42
        && rv == 0x44332211u) {
        return 42;
    }
    return 1;
}
