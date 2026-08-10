// Unsuffixed `pushf` / `popf` take the 64-bit operand size in 64-bit mode,
// and the AT&T word suffix on push / pop of a register selects the 16-bit
// form. Reading the flags back through `pushf; pop` observes the comparison
// the template just performed.

#define ZF 0x40u

static unsigned long flags_after_compare(long a, long b)
{
    unsigned long f;
    __asm__ volatile("cmpq %2, %1\n\t"
                     "pushf\n\t"
                     "pop %0"
                     : "=r"(f)
                     : "r"(a), "r"(b)
                     : "cc");
    return f;
}

// A 16-bit push / pop round-trip leaves the value unchanged and, because the
// operand size is 16-bit, moves the stack pointer by two rather than eight.
static unsigned short word_push_pop(unsigned short v)
{
    unsigned short out;
    __asm__ volatile("pushw %1\n\t"
                     "popw %0"
                     : "=r"(out)
                     : "r"(v));
    return out;
}

int main(void)
{
    // Equal operands set ZF; unequal clear it.
    if (!(flags_after_compare(7, 7) & ZF))
        return 1;
    if (flags_after_compare(7, 9) & ZF)
        return 2;

    if (word_push_pop(0x1234) != 0x1234)
        return 3;
    if (word_push_pop(0xBEEF) != 0xBEEF)
        return 4;

    // `popf` restores what `pushf` saved: the flags survive the round trip.
    unsigned long f = flags_after_compare(3, 3);
    unsigned long g;
    __asm__ volatile("push %1\n\t"
                     "popf\n\t"
                     "pushf\n\t"
                     "pop %0"
                     : "=r"(g)
                     : "r"(f)
                     : "cc");
    if (!(g & ZF))
        return 5;

    return 0;
}
