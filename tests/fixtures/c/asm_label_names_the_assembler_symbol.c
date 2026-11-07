// An asm label is the symbol's assembler name. On Mach-O, where a C name is
// spelled with a leading underscore, `__asm__("_asm_label_two")` names the
// symbol that file-scope asm defines as `_asm_label_two:`.
#if defined(__APPLE__)
#define LABEL "_asm_label_two"
#else
#define LABEL "asm_label_two"
#endif

int two(void) __asm__(LABEL);

#if defined(__aarch64__)
__asm__(".text\n.globl " LABEL "\n.p2align 2\n" LABEL ":\n    mov w0, #2\n    ret\n");
#else
__asm__(".text\n.globl " LABEL "\n" LABEL ":\n    movl $2, %eax\n    ret\n");
#endif

int main(void) { return two() == 2 ? 0 : 1; }
