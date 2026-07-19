/* AArch64 inline asm: NEON table lookup (tbl). Each byte of the index vector
 * selects a byte from the table register; an out-of-range index yields zero.
 * Native-only on AArch64 (the interpreter's inline-asm evaluator is x86-only);
 * on x86_64 the scalar equivalent runs in plain C. */

static int tbl_select(int table_byte, int index) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v1.16b, %w1\n\t" /* table lane = table_byte */
            "dup v2.16b, %w2\n\t" /* index lane = index      */
            "tbl v0.16b, {v1.16b}, v2.16b\n\t"
            "umov %w0, v0.b[0]"
            : "=r"(r)
            : "r"(table_byte), "r"(index)
            : "d0", "d1", "d2", "memory");
#else
    r = (unsigned) index < 16 ? (unsigned char) table_byte : 0;
#endif
    return r;
}

int main(void) {
    if (tbl_select(42, 3) != 42) return 1;  /* in-range index picks the byte */
    if (tbl_select(42, 16) != 0) return 2;  /* out-of-range -> 0             */
    return 42;
}
