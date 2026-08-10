/* AArch64 file-scope asm: a label difference as a plain immediate and as a
 * memory offset. Both are absolute values only the section layout knows, and
 * on A64 the value picks the encoding -- `prfm` takes the scaled form only
 * for a multiple of its access size and `prfum` otherwise, `ldr` likewise
 * becomes `ldur`. This is the vector-entry shape in the kernel's
 * `arch/arm64/kernel/entry.S`, which computes the entry's own slot from
 * `1b - \vector_start`. */

__asm__(".pushsection .probe.text, \"ax\"\n"
        ".globl slot_probe\n"
        ".type slot_probe, @function\n"
        "vec_start:\n"
        "  nop\n"
        "slot_probe:\n"
        /* `1b - vec_start` is 4: past the scaled form, so an unscaled one. */
        "1:\n"
        "  prfm plil1strm, [sp, #(1b - vec_start)]\n"
        "  mov x0, #(1b - vec_start + 4)\n"
        "  add x0, x0, #(2f - 1b)\n"
        "  sub x0, x0, #(vec_start - 1b)\n"
        "  adr x1, 3f\n"
        "  ldr w2, [x1, #(4f - 3f)]\n"
        "  add x0, x0, x2\n"
        "  ret\n"
        "3:\n"
        "  .word 0\n"
        "4:\n"
        "  .word 11\n"
        "2:\n"
        ".size slot_probe, . - slot_probe\n"
        ".popsection\n");

extern unsigned long slot_probe(void);

/* A function body has no section layout, so only an expression the parse
 * folds resolves there; the encoder picks the same forms from the value. */
static unsigned long fold_in_body(unsigned long *p) {
    unsigned long v;
    __asm__("prfm plil1strm, [%1, #(2 * 4)]\n\t"
            "ldr %0, [%1, #(4 * 2)]\n\t"
            "add %0, %0, #(1 << 3)"
            : "=&r"(v)
            : "r"(p)
            : "memory");
    return v;
}

int main(void) {
    /* 8 + (2f - 1b) - (vec_start - 1b) + 11.
     * `2f - 1b` is 0x28 (ten words), `vec_start - 1b` is -4. */
    if (slot_probe() != 8 + 0x28 + 4 + 11)
        return 1;
    unsigned long a[4] = {0, 5, 0, 0};
    if (fold_in_body(a) != 5 + 8)
        return 2;
    return 42;
}
