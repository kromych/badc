/* Main-stream template branches on x86-64: an in-reach jmp / jcc pair the
 * assembler settles on the rel8 forms, a branch a `.skip` holds on the
 * rel32 form, and a branch to a weak-declared label of the stream, which
 * keeps a relocation the link binds to the surviving definition. */

static int looped(int x, int n)
{
    __asm__ volatile(
        "jmp 1f\n\t"
        "addl $100, %0\n"
        "1:\n\t"
        "addl $20, %0\n\t"
        "subl $1, %1\n\t"
        "jne 1b\n\t"
        "jmp 2f\n\t"
        ".skip 130, 0x90\n"
        "2:"
        : "+r"(x), "+r"(n) : : "cc");
    return x;
}

static int weak_target(int x)
{
    __asm__ volatile(
        "jmp wkst\n\t"
        "addl $100, %0\n"
        ".weak wkst\n"
        "wkst:\n\t"
        "addl $1, %0"
        : "+r"(x) : : "cc");
    return x;
}

int main(void)
{
    if (weak_target(5) != 6)
        return 1;
    return looped(2, 2);
}
