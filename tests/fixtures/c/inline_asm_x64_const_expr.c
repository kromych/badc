// An integer constant expression is accepted wherever an assembler takes a
// constant: a memory-operand displacement and a named section's data value.
// Both used to require a bare literal.

static unsigned long sum_quads(const unsigned long *p)
{
    unsigned long acc = 0;
    __asm__("addq 0*8(%[s]),%[r]\n\t"
            "adcq 1*8(%[s]),%[r]\n\t"
            "adcq 2*8(%[s]),%[r]\n\t"
            "adcq (1+2)*8(%[s]),%[r]\n\t"
            "adcq $0,%[r]"
            : [r] "+r"(acc)
            : [s] "r"(p), "m"(*(const unsigned long(*)[4])p));
    return acc;
}

// A named section whose values are constant expressions rather than literals.
static void emit_section(void)
{
    __asm__ volatile(".pushsection .badc_const_expr,\"a\"\n\t"
                     ".long (16*32+22)\n\t"
                     ".long (1<<3)|2\n\t"
                     ".long 7*2\n\t"
                     ".long 0xF0|0x0F\n\t"
                     ".popsection");
}

int main(void)
{
    unsigned long v[4] = {1, 2, 3, 4};
    if (sum_quads(v) != 10)
        return 1;

    v[3] = 100;
    if (sum_quads(v) != 106)
        return 2;

    // An immediate is a constant expression too.
    unsigned long n = 0;
    __asm__("addq $(3*8+1), %0" : "+r"(n));
    if (n != 25)
        return 3;

    emit_section();
    return 0;
}
