/* An inline-asm output tied to a fixed register (`"=a"`, `"=d"`) is written
   back at the width of its C object, not at the width the instruction
   happens to define. A 32-bit instruction feeding a `long` operand must
   still store all eight bytes: the operand names %rax, whose upper half the
   instruction cleared. Storing four bytes leaves the object's upper half
   holding what was there before, which each case below plants through a
   volatile alias so a partial write-back is visible rather than accidental. */

typedef unsigned long long u64;

#define PATTERN 0xdeadbeefdeadbeefUL

/* Bare-mnemonic template, the shape an x86-64 timestamp read uses. */
__attribute__((noinline)) static int tick_halves_are_clean(u64 *out) {
    unsigned long low, high;
    volatile unsigned long *pl = &low, *ph = &high;

    *pl = PATTERN;
    *ph = PATTERN;
    __asm__ volatile("rdtsc" : "=a"(low), "=d"(high));
    *out = low | (high << 32);
    /* The counter leaves the upper 32 bits of rax and rdx clear. */
    return (low >> 32) == 0 && (high >> 32) == 0;
}

/* The same read with `unsigned` halves: two four-byte write-backs. */
__attribute__((noinline)) static u64 tick_int_halves(void) {
    unsigned low, high;

    __asm__ volatile("rdtsc" : "=a"(low), "=d"(high));
    return ((u64)high << 32) | low;
}

/* An operand-referencing template, for the same width rule. */
__attribute__((noinline)) static int long_output_fills_all_bytes(void) {
    unsigned long v;
    volatile unsigned long *pv = &v;

    *pv = PATTERN;
    __asm__ volatile("movl $0x99, %%eax" : "=a"(v));
    return v == 0x99;
}

/* Store too wide: a 16-bit operand must leave its neighbours intact. */
__attribute__((noinline)) static int short_output_keeps_neighbours(void) {
    struct { unsigned short before, val, after; } s;

    s.before = 0xbeef;
    s.val = 0;
    s.after = 0xfeed;
    __asm__ volatile("movl $0x11223344, %%eax" : "=a"(s.val));
    return s.before == 0xbeef && s.val == 0x3344 && s.after == 0xfeed;
}

int main(void) {
    u64 a = 0, b;

    if (!tick_halves_are_clean(&a))
        return 1;
    b = tick_int_halves();
    /* Both readings come from the same counter microseconds apart, so they
       agree in every bit above its live range and advance monotonically. */
    if ((a >> 48) != (b >> 48) || b < a)
        return 2;
    if (!long_output_fills_all_bytes())
        return 3;
    if (!short_output_keeps_neighbours())
        return 4;
    return 0;
}
