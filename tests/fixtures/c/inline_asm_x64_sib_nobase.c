/* x86-64 no-base scaled-index memory operands `disp(,%index,scale)`:
 * ModRM mod=00 rm=100 with SIB base=101 and a disp32, no base register.
 * Loads, a store, lea address folding, and an r8+ index (REX.X). */

typedef unsigned long long u64;

static u64 cells[8];

int main(void) {
    for (int i = 0; i < 8; i++)
        cells[i] = 0x2000 + i;

    u64 base = (u64)cells;
    if (base & 7)
        return 1; /* u64 array is 8-aligned; the scale recombines it. */

    u64 got;
    __asm__("movq (,%1,8), %0" : "=r"(got) : "r"(base / 8));
    if (got != 0x2000)
        return 2;
    __asm__("movq 16(,%1,8), %0" : "=r"(got) : "r"(base / 8));
    if (got != 0x2002)
        return 3;
    __asm__("movq (,%1,4), %0" : "=r"(got) : "r"(base / 4));
    if (got != 0x2000)
        return 4;

    /* Store through the no-base form. */
    __asm__("movq %1, 24(,%0,8)" : : "r"(base / 8), "r"((u64)0xBEEF) : "memory");
    if (cells[3] != 0xBEEF)
        return 5;

    /* lea folds scale and displacement. */
    u64 addr;
    __asm__("leaq 8(,%1,8), %0" : "=r"(addr) : "r"(base / 8));
    if (addr != (u64)&cells[1])
        return 6;

    /* An r8..r15 index takes REX.X. */
    register u64 idx __asm__("r9") = base / 2;
    __asm__("movq 40(,%%r9,2), %0" : "=r"(got) : "r"(idx));
    if (got != 0x2005)
        return 7;

    return 42;
}
