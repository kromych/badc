// An `asm goto` whose operands are all immediates needs no operand
// frame: an immediate is substituted into the template text and has no
// runtime storage. The distinction is not only the saved bytes -- the
// operand frame is released on each path leaving the template, and a
// label whose address is published to a data section can be branched to
// by code planted after the fact, which reaches none of those paths.
// That is the shape a patched branch target takes: the `%l` reference
// sits in a table, not in an instruction of the template.
//
// The paired aarch64 snapshot carries the property: the emitted body
// holds no stack-pointer adjustment around the template.

extern void unused_sink(long);

static long table_probe(long sel) {
    __asm__ goto(".pushsection .test_branch_table, \"a\"\n\t"
                 ".align 3\n\t"
                 ".quad 1f - ., %l[taken] - ., %[sel] \n\t"
                 ".popsection\n"
                 "1:\n\t"
                 "nop\n"
                 :
                 : [sel] "i"(7)
                 :
                 : taken);
    return sel;
taken:
    return -1;
}

// Two immediates and a template that uses both as operands.
static long two_immediates(void) {
    long out = 0;
    __asm__("mov %0, %1\n\t"
            "add %0, %0, %2\n"
            : "=r"(out)
            : "i"(11), "i"(20));
    return out;
}

int main(void) {
    if (table_probe(3) != 3)
        return 1;
    if (table_probe(-9) != -9)
        return 2;
    if (two_immediates() != 31)
        return 3;
    return 0;
}
