// GNU as lets a label share a statement with what follows it, so
//
//     1:  .irp num,0,1,2,3
//
// is a label and a repeat directive, not a statement whose first token is
// `.irp`. Headers write the form when a fault-table entry has to name the
// address of a block that also opens a repeat or a macro definition.
//
// Only assembler directives are used, so the fixture is
// architecture-neutral: the repeat defines four assembler constants, and
// the emitted table is read back from C.

#include <stdio.h>

extern const unsigned int seq[];
extern const unsigned int tail[];

asm(".pushsection .rodata\n"
    ".globl seq\n"
    "seq:\n"
    "1:  .irp num,0,1,2,3\n"
    "    .equ .L__seq\\num, (\\num * 3 + 1)\n"
    "    .endr\n"
    "    .long (.L__seq0), (.L__seq1), (.L__seq2), (.L__seq3)\n"
    ".globl tail\n"
    // Several labels on one statement, and one carrying the directive.
    "tail: 2: .equ .L__last, 99\n"
    "    .long (.L__last)\n"
    ".popsection\n");

int main(void) {
    if (seq[0] != 1) return 1;
    if (seq[1] != 4) return 2;
    if (seq[2] != 7) return 3;
    if (seq[3] != 10) return 4;
    if (tail[0] != 99) return 5;
    printf("ok\n");
    return 0;
}
