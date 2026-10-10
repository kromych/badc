/* Frameless leaves whose inline asm names sp convert binary128 long
 * doubles (AAPCS64 Linux). Such a leaf reserves no outgoing area, so
 * each conversion moves sp down for the registers it borrows rather than
 * storing them at [sp, #0] -- the caller's frame. The caller fills the
 * borrowed registers with marker values before each call and checks its
 * own locals after it. Returns 42 when they are intact. Where long double
 * is binary64, and on x86_64, the same computation runs without a
 * conversion sequence. */

long double gld = 1.5L;
long double gout;
volatile double got;

#if defined(__aarch64__)
#define SP_ASM() __asm__ volatile("add sp, sp, #0")
#define FILL()                                                               \
    __asm__ volatile("mov x9, #91\n\tmov x10, #92\n\tmov x11, #93\n\t"       \
                     "mov x12, #94\n\tmov x13, #95\n\tmov x14, #96\n\t"      \
                     "mov x15, #97" ::: "x9", "x10", "x11", "x12", "x13", \
                     "x14", "x15")
#else
#define SP_ASM()
#define FILL()
#endif

__attribute__((noinline)) double narrow(void) {
    SP_ASM();
    return (double)gld;
}

__attribute__((noinline)) void widen(double d) {
    SP_ASM();
    gout = d;
}

static long sum(volatile long *p, int n) {
    long s = 0;
    for (int i = 0; i < n; i++) s += p[i];
    return s;
}

__attribute__((noinline)) static long narrows(void) {
    volatile long keep[16];
    for (int i = 0; i < 16; i++) keep[i] = i + 11;
    FILL();
    got = narrow();
    return sum(keep, 16);
}

__attribute__((noinline)) static long widens(double d) {
    volatile long keep[16];
    for (int i = 0; i < 16; i++) keep[i] = i + 11;
    FILL();
    widen(d);
    return sum(keep, 16);
}

int main(void) {
    /* 11 + 12 + ... + 26 = 296 */
    if (narrows() != 296 || got != 1.5) return 1;
    if (widens(2.5) != 296 || gout != 2.5L) return 2;
    return 42;
}
