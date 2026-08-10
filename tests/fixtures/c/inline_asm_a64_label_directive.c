// GNU as lets any number of labels share a statement with what follows
// them, so
//
//     1:  .irp num,0,1,2,3
//
// is a label plus a repeat directive, not a statement whose first token is
// `.irp`. Headers write the form when a fault-table entry names the address
// of a block that also opens a repeat or a macro definition; reading the
// first token as the directive leaves the repeat body unexpanded and its
// `\param` references are then taken for literal symbol names.
//
// Returns 42 on success, a scenario id on the first mismatch.

// The repeat defines four assembler constants; the instruction materializes
// their sum (1 + 4 + 7 + 10).
static int irp_after_label(void) {
    int v;
    asm("1:  .irp num,0,1,2,3\n"
        "    .equ .L__ild\\num, (\\num * 3 + 1)\n"
        "    .endr\n"
        "    mov %w0, #(.L__ild0 + .L__ild1 + .L__ild2 + .L__ild3)\n"
        : "=r"(v));
    return v;
}

// Several labels on one statement, the last carrying a `.macro` definition
// whose body the macro call below expands.
static int macro_after_labels(void) {
    int v;
    asm("2: 3:  .macro ild_set, dst, val\n"
        "    mov \\dst, #\\val\n"
        "    .endm\n"
        "    ild_set %w0, 77\n"
        "    .purgem ild_set\n"
        : "=r"(v));
    return v;
}

// A label sharing the statement with a plain `.equ`, and a branch to a
// label defined the ordinary way, so label emission order is checked too.
static int equ_after_label(void) {
    int v;
    asm("4:  .equ .L__ilde, 5\n"
        "    mov %w0, #(.L__ilde * 3)\n"
        "    b 5f\n"
        "    mov %w0, #0\n"
        "5:\n"
        : "=r"(v));
    return v;
}

int main(void) {
    if (irp_after_label() != 22) return 1;
    if (macro_after_labels() != 77) return 2;
    if (equ_after_label() != 15) return 3;
    return 42;
}
