/* AArch64 inline asm: a `dc cvac, Xt` data-cache clean by virtual address, the
 * general dc/ic/tlbi system-op path. The bare `dc cvau, %0` / `ic ivau, %0`
 * forms are pattern-matched to intrinsics earlier; `cvac` is not, so this drives
 * the general encoder with an operand-reference register. DC CVAC is permitted
 * at EL0. Native-only on AArch64; on x86_64 the statement is a no-op. */

int main(void) {
    volatile int x = 42;
#if defined(__aarch64__)
    __asm__ volatile("dc cvac, %0" : : "r"(&x) : "memory");
#endif
    return x; /* 42 -- the clean does not change the value */
}
