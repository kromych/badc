// x86-64 setcc inline asm: materialize a signed comparison into a byte via the
// condition-code setters reached through the catalogue passthrough (sete, setl,
// setg). The one-byte output holds exactly the flag. Returns 42 only when the
// true and false results are both correct. Native x86-64 only.

static int cmp_eq(long a, long b) {
    unsigned char r;
    __asm__("cmp %2, %1\n\tsete %b0" : "=r"(r) : "r"(a), "r"(b) : "cc");
    return r;
}

static int cmp_lt(long a, long b) {
    unsigned char r;
    __asm__("cmp %2, %1\n\tsetl %b0" : "=r"(r) : "r"(a), "r"(b) : "cc");
    return r;
}

static int cmp_gt(long a, long b) {
    unsigned char r;
    __asm__("cmp %2, %1\n\tsetg %b0" : "=r"(r) : "r"(a), "r"(b) : "cc");
    return r;
}

int main(void) {
    int c = 0;
    c += cmp_eq(5, 5) * 20;  // 1 * 20
    c += cmp_lt(3, 7) * 15;  // 1 * 15
    c += cmp_gt(9, 4) * 7;   // 1 * 7
    c += cmp_eq(1, 2) * 100; // 0
    c += cmp_lt(9, 3) * 100; // 0
    c += cmp_gt(4, 9) * 100; // 0
    return c;                // 20 + 15 + 7 = 42
}
