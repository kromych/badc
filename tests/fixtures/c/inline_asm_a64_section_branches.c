/* Statement-level pushed executable sections on aarch64: a numeric forward
 * branch into the section, a branch from the section back to the main
 * stream, a `bl` out to C, and an `asm goto` branch leaving the section --
 * each a cross-section reference the linker resolves. */

unsigned long calls;

void bump(void) { calls++; }

static long via_section(long x)
{
    long r = x;
    __asm__ volatile(
        "b 1f\n"
        "2:\n\t"
        "add %0, %0, #1\n\t"
        "b 3f\n\t"
        ".pushsection .fix.text, \"ax\"\n"
        "1:\n\t"
        "str %0, [sp, #-16]!\n\t"
        "bl bump\n\t"
        "ldr %0, [sp], #16\n\t"
        "b 2b\n\t"
        ".popsection\n"
        "3:"
        : "+r"(r) : : "x30", "memory");
    return r;
}

static int goto_side(int x)
{
    __asm__ goto(
        "cbz %w0, 4f\n\t"
        "b 5f\n\t"
        ".pushsection .fix.text, \"ax\"\n"
        "4:\n\t"
        "bl bump\n\t"
        "b %l[out]\n\t"
        ".popsection\n"
        "5:"
        : : "r"(x) : "x30", "memory" : out);
    return 1;
out:
    return 0;
}

int main(void)
{
    if (via_section(5) != 6)
        return 1;
    if (goto_side(0) != 0)
        return 2;
    if (goto_side(7) != 1)
        return 3;
    if (calls != 2)
        return 4;
    return 42;
}
