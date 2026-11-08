// An AArch64 branch relocation (R_AARCH64_JUMP26) on a word in a data
// section: the link fills the word's bits 25:0 with the distance to the
// target over 4 and keeps its opcode bits, as in code. The symbols are
// spelled through `__USER_LABEL_PREFIX__`. Exits 0 when the word branches
// to the target; elsewhere the unit checks nothing.

#if defined(__aarch64__)
#define SPELL_(prefix, name) #prefix #name
#define SPELL(prefix, name) SPELL_(prefix, name)
#define SYM(name) SPELL(__USER_LABEL_PREFIX__, name)

int target(void) { return 7; }

__asm__(".section .data.branch_word,\"aw\"\n"
        ".globl " SYM(slot) "\n"
        ".p2align 2\n" SYM(slot) ":\n"
        ".reloc 0, R_AARCH64_JUMP26, " SYM(target) "\n"
        ".word 0x14000000\n"
        ".text\n");

extern unsigned slot;

int main(void) {
    unsigned w = slot;
    long distance = (long)((int)(w << 6) >> 6) * 4;
    return w >> 26 == 5 && (char *)&slot + distance == (char *)target ? 0 : 1;
}
#else
int main(void) { return 0; }
#endif
