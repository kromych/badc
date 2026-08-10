// x86 constraint `A`. On i386 it names the `edx:eax` pair; on x86-64 it is
// the `a` or `d` register, and both gcc and clang allocate `rax`. A template
// that reads and writes the accumulator therefore sees the operand there.

static unsigned long add_via_a(unsigned long x, unsigned long y)
{
    unsigned long r;
    __asm__("addq %[y],%[r]" : [r] "=A"(r) : "0"(x), [y] "r"(y));
    return r;
}

static unsigned long double_in_place(unsigned long v)
{
    __asm__("addq %%rax,%%rax" : "+A"(v));
    return v;
}

// The operand is the accumulator, so a template naming `%rax` explicitly
// reaches the same storage.
static unsigned long low_byte(unsigned long v)
{
    unsigned long r;
    __asm__("andq $0xFF,%%rax" : "=A"(r) : "0"(v));
    return r;
}

int main(void)
{
    if (add_via_a(20, 22) != 42)
        return 1;
    if (add_via_a(0, 0) != 0)
        return 2;

    if (double_in_place(21) != 42)
        return 3;
    if (double_in_place(0) != 0)
        return 4;

    if (low_byte(0x1234) != 0x34)
        return 5;
    if (low_byte(0xFF) != 0xFF)
        return 6;

    return 0;
}
