// An `"m"` operand spelled `*(T (*)[N])p` names the whole N-element region
// at `p` rather than one element. The dereference of a pointer-to-array
// decays to the region's address (C99 6.3.2.1p3), so the operand is an
// lvalue and its value is already the address to pass.

static unsigned long sum_two_quads(const unsigned char *buf)
{
    unsigned long acc = 0;
    __asm__("addq 0(%[src]),%[res]\n\t"
            "adcq 8(%[src]),%[res]\n\t"
            "adcq $0,%[res]"
            : [res] "+r"(acc)
            : [src] "r"(buf), "m"(*(const unsigned char(*)[16])buf));
    return acc;
}

// The same shape as an output region: the template writes through the
// pointer operand and the `"m"` operand declares what it touched.
static void fill_region(unsigned char *buf)
{
    __asm__ volatile("movq $0, 0(%[dst])\n\t"
                     "movq $0, 8(%[dst])"
                     : "=m"(*(unsigned char(*)[16])buf)
                     : [dst] "r"(buf)
                     : "memory");
}

int main(void)
{
    unsigned long v[2];
    unsigned char *p = (unsigned char *)v;

    v[0] = 0x1111111111111111UL;
    v[1] = 0x2222222222222222UL;
    if (sum_two_quads(p) != 0x3333333333333333UL)
        return 1;

    v[0] = 5;
    v[1] = 9;
    if (sum_two_quads(p) != 14)
        return 2;

    fill_region(p);
    if (v[0] != 0 || v[1] != 0)
        return 3;

    // The operand names the region, not one byte: the cast's dimension
    // survives into the type.
    if (sizeof(*(unsigned char(*)[16])p) != 16)
        return 4;

    return 0;
}
