/* A label defined in a pushed section is a definition of the translation
 * unit whatever the section's access rights are, so a C reference binds
 * to it. The read-only, writable and executable forms are each defined
 * and referenced here: the emitted image has to place all three under
 * rights that satisfy the reference, and both the object-plus-link path
 * and the single-file image path have to agree on the result. */

#include <stdio.h>

extern const unsigned int asm_ro_word[];
extern unsigned int asm_rw_word[];
extern const unsigned int asm_x_word[];

asm(".pushsection .rodata.asmplace,\"a\"\n"
    ".balign 8\n"
    "asm_ro_word:\n"
    ".long 0x11112222\n"
    ".popsection\n"
    ".pushsection .data.asmplace,\"aw\"\n"
    ".balign 8\n"
    "asm_rw_word:\n"
    ".long 0x33334444\n"
    ".popsection\n"
    ".pushsection .text.asmplace,\"ax\"\n"
    ".balign 8\n"
    "asm_x_word:\n"
    ".long 0x55556666\n"
    ".popsection\n");

int main(void) {
    if (asm_ro_word[0] != 0x11112222u)
        return 1;
    if (asm_rw_word[0] != 0x33334444u)
        return 2;
    if (asm_x_word[0] != 0x55556666u)
        return 3;
    /* The writable section's payload must land somewhere writable. */
    asm_rw_word[0] = 0x77778888u;
    if (asm_rw_word[0] != 0x77778888u)
        return 4;
    printf("asm section placement ok\n");
    return 42;
}
