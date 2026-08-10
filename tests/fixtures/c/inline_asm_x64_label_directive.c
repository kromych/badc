// GNU as lets any number of labels share a statement with what follows
// them, so
//
//     1:  .irp num,0,1,2,3
//
// is a label plus a repeat directive, not a statement whose first token is
// `.irp`. Reading the first token as the directive leaves the repeat body
// unexpanded and its `\param` references are then taken for literal symbol
// names.
//
// The x86-64 twin of the aarch64 fixture; the pre-pass that peels the
// labels is shared, the instructions are not.
//
// Returns 42 on success, a scenario id on the first mismatch.

static int irp_after_label(void) {
    int v;
    asm("1:  .irp num,0,1,2,3\n"
        "    .equ .L__xld\\num, (\\num * 3 + 1)\n"
        "    .endr\n"
        "    movl $(.L__xld0 + .L__xld1 + .L__xld2 + .L__xld3), %0\n"
        : "=r"(v));
    return v;
}

static int macro_after_labels(void) {
    int v;
    asm("2: 3:  .macro xld_set dst, val\n"
        "    movl $\\val, \\dst\n"
        "    .endm\n"
        "    xld_set %0, 77\n"
        "    .purgem xld_set\n"
        : "=r"(v));
    return v;
}

static int equ_after_label(void) {
    int v;
    asm("4:  .equ .L__xlde, 5\n"
        "    movl $(.L__xlde * 3), %0\n"
        "    jmp 5f\n"
        "    movl $0, %0\n"
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
