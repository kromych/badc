/* `cpuid` / `xgetbv` inline-asm outputs write back at the width of the C
   operand. Both instructions define 32-bit results and clear the upper
   half of each 64-bit register they write, so a `long` output must take
   all eight bytes; storing four leaves the object's upper half holding
   what was there before, which each case plants through a volatile alias
   so a partial write-back is visible rather than accidental. The VM
   zeroes the registers the instructions define, so every check also
   holds there; other native targets reject the mnemonics. */

#define PATTERN 0xdeadbeefdeadbeefUL

static unsigned long ca, cb, cc, cd;

__attribute__((noinline)) static int cpuid_long_outputs_fill_all_bytes(void) {
    volatile unsigned long *pa = &ca, *pb = &cb, *pc = &cc, *pd = &cd;

    *pa = PATTERN;
    *pb = PATTERN;
    *pc = PATTERN;
    *pd = PATTERN;
    __asm__ volatile("cpuid"
                     : "=a"(ca), "=b"(cb), "=c"(cc), "=d"(cd)
                     : "a"(0), "c"(0));
    return (ca >> 32) == 0 && (cb >> 32) == 0 && (cc >> 32) == 0 &&
           (cd >> 32) == 0;
}

/* The same leaf with `unsigned` outputs: four-byte write-backs that agree
   with the wide run's low words (leaf 0 is stable across executions). */
__attribute__((noinline)) static int cpuid_int_outputs_agree(void) {
    unsigned a, b, c, d;

    __asm__ volatile("cpuid"
                     : "=a"(a), "=b"(b), "=c"(c), "=d"(d)
                     : "a"(0), "c"(0));
    return a == (unsigned)ca && b == (unsigned)cb && c == (unsigned)cc &&
           d == (unsigned)cd;
}

/* xgetbv runs only where cpuid reports OSXSAVE (leaf 1, ecx bit 27); XCR0
   has bit 0 (x87) set wherever the instruction executes. The VM reports
   no features, so the check passes vacuously there. */
__attribute__((noinline)) static int xgetbv_long_outputs_fill_all_bytes(void) {
    unsigned a, b, c, d;
    unsigned long lo, hi;
    volatile unsigned long *pl = &lo, *ph = &hi;

    __asm__ volatile("cpuid"
                     : "=a"(a), "=b"(b), "=c"(c), "=d"(d)
                     : "a"(1), "c"(0));
    if (!(c & (1u << 27)))
        return 1;
    *pl = PATTERN;
    *ph = PATTERN;
    __asm__ volatile("xgetbv" : "=a"(lo), "=d"(hi) : "c"(0));
    return (lo >> 32) == 0 && (hi >> 32) == 0 && (lo & 1) == 1;
}

int main(void) {
    if (!cpuid_long_outputs_fill_all_bytes())
        return 1;
    if (!cpuid_int_outputs_agree())
        return 2;
    if (!xgetbv_long_outputs_fill_all_bytes())
        return 3;
    return 0;
}
