/* In-template `.pushsection` / `.section` data directives: the blocks
 * leave the instruction stream (the code between them must still
 * execute) and accumulate into named sections of a relocatable object
 * (object-level checks live in the linker tests; an executable drops
 * the unreferenced sections). `nop` and the numeric label parse on
 * both ISAs. */

int flag;

int probe(int v) {
    __asm__("1: nop\n"
            ".pushsection .discard.probe,\"a\"\n"
            ".balign 8\n"
            ".quad 1b\n"
            ".long 1b - .\n"
            ".long %c[k]\n"
            ".popsection\n"
            "nop"
            : : [k] "i"(42) : "memory");
    return v + 1;
}

int fixup_style(int v) {
    __asm__("nop\n"
            ".section .discard.other,\"a\"\n"
            ".asciz \"probe\"\n"
            ".previous\n"
            "nop" ::: "memory");
    return v + 1;
}

int main(void) {
    if (probe(20) != 21)
        return 1;
    if (fixup_style(40) != 41)
        return 2;
    return 42;
}
