/* Raw-byte inline asm: an instruction spelled as literal machine bytes, the
 * escape hatch for anything the mnemonic catalogue does not cover. Both the
 * `.byte` directive and the bare 2-hex-digit run are exercised, per target. The
 * bytes encode a no-op on each architecture, so the result is target-neutral
 * and the SSA interpreter (which models raw bytes as opaque) agrees with native
 * execution. */

int main(void) {
    int x = 42;
#if defined(__x86_64__)
    __asm__ volatile(".byte 0x90" ::: "memory"); /* nop */
    __asm__ volatile("90");                      /* nop, bare-hex form */
#elif defined(__aarch64__)
    /* AArch64 NOP = 0xD503201F, little-endian bytes 1f 20 03 d5. */
    __asm__ volatile(".byte 0x1f, 0x20, 0x03, 0xd5" ::: "memory");
    __asm__ volatile("1f 20 03 d5");
#endif
    return x - 42;
}
