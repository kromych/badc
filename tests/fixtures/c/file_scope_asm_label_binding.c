/* A label defined only by file-scope asm is a definition of the
 * translation unit: a C reference to the name binds to it rather than
 * staying an undefined reference. One pushed executable section defines a
 * function label and two data labels; the C code calls the first, reads
 * through the second, and checks the distance between the addresses it
 * materializes against the distance the assembler computed. */

#include <stdio.h>

extern void asm_store_magic(unsigned int *out);
extern const unsigned int asm_magic_word[];
/* The section stores the distance between its two labels, so the two
 * addresses C materializes must differ by the value the assembler
 * computed. */
extern const int asm_label_delta[];

#if defined(__x86_64__)
asm(".pushsection .text.asmlbl,\"ax\",@progbits\n"
    ".balign 8\n"
    ".type asm_store_magic,@function\n"
    "asm_store_magic:\n"
    "\tmovl $0x1234, (%rdi)\n"
    "\tret\n"
    ".size asm_store_magic, .-asm_store_magic\n"
    ".balign 8\n"
    "asm_magic_word:\n"
    ".long 0x5678\n"
    ".balign 8\n"
    "asm_label_delta:\n"
    ".long asm_magic_word - asm_store_magic\n"
    ".popsection\n");
#elif defined(__aarch64__)
/* The A64 section encoder assembles data directives; the body rides in as
 * instruction words: mov w1, #0x1234 / str w1, [x0] / ret. */
asm(".pushsection .text.asmlbl,\"ax\"\n"
    ".balign 8\n"
    "asm_store_magic:\n"
    ".long 0x52824681\n"
    ".long 0xb9000001\n"
    ".long 0xd65f03c0\n"
    ".balign 8\n"
    "asm_magic_word:\n"
    ".long 0x5678\n"
    ".balign 8\n"
    "asm_label_delta:\n"
    ".long asm_magic_word - asm_store_magic\n"
    ".popsection\n");
#endif

int main(void) {
    unsigned int v = 0;
    asm_store_magic(&v);
    if (v != 0x1234)
        return 1;
    if (asm_magic_word[0] != 0x5678)
        return 2;
    if ((const char *)asm_magic_word - (const char *)asm_store_magic !=
        asm_label_delta[0])
        return 3;
    printf("asm label binding ok\n");
    return 42;
}
