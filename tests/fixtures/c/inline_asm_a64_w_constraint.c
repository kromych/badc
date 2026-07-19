/* AArch64 inline asm: the `w` (SIMD/FP register) operand constraint. A double is
 * reinterpreted to its integer bit pattern and back with fmov -- the common FP
 * inline-asm idiom, where the compiler allocates a d-register for the `w`
 * operand and resolves `%N` to it. Native-only on AArch64; on x86_64 the same
 * reinterpretation runs through a union. */

#if defined(__aarch64__)
static long bits_of(double d) {
    long b;
    __asm__("fmov %0, %1" : "=r"(b) : "w"(d));
    return b;
}
static double from_bits(long b) {
    double d;
    __asm__("fmov %0, %1" : "=w"(d) : "r"(b));
    return d;
}
#else
static long bits_of(double d) {
    union {
        double d;
        long b;
    } u = {.d = d};
    return u.b;
}
static double from_bits(long b) {
    union {
        long b;
        double d;
    } u = {.b = b};
    return u.d;
}
#endif

int main(void) {
    long b = 0x4045000000000000L; /* 42.0 */
    return bits_of(from_bits(b)) == b ? 42 : 0;
}
