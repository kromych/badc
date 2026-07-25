/* x86-64 `.align` / `.p2align` / `.balign` inside the inline-asm code
 * stream: NOP padding to a section-relative boundary, executed through
 * when control flows across it. A fill byte and a max skip are honored
 * (the max form drops padding that would exceed it). */

static int spaced(void) {
    int r;
    __asm__("movl $1, %0\n\t"
            ".align 8\n\t"
            "addl $2, %0"
            : "=r"(r));
    return r;
}
static int pow2(void) {
    int r;
    __asm__("movl $5, %0\n\t"
            ".p2align 4\n\t"
            "addl $6, %0"
            : "=r"(r));
    return r;
}
static int byte_bound(void) {
    int r;
    __asm__("movl $7, %0\n\t"
            ".balign 16\n\t"
            "addl $8, %0"
            : "=r"(r));
    return r;
}
static int capped(void) {
    int r;
    /* One-byte max skip: the pad is dropped unless already adjacent. */
    __asm__("movl $9, %0\n\t"
            ".p2align 4,,1\n\t"
            "addl $4, %0"
            : "=r"(r));
    return r;
}

int main(void) {
    if (spaced() != 3)
        return 1;
    if (pow2() != 11)
        return 2;
    if (byte_bound() != 15)
        return 3;
    if (capped() != 13)
        return 4;
    return 42;
}
