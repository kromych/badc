/* x86-64 scaled-index template memory operands: `disp(%%base, %%index,
 * scale)` and the scale-1 `( %%base, %%index)` form, with explicit
 * registers and `%N` operand references, across load, store, and lea. */

typedef unsigned long long u64;

static u64 cells[64];

int main(void) {
    for (int i = 0; i < 64; i++)
        cells[i] = 0x1000 + i;

    /* Loads through operand-referenced base and index, each scale. */
    u64 got;
    asm("movq (%1,%2,8), %0" : "=r"(got) : "r"(cells), "r"(5ULL));
    if (got != 0x1005)
        return 1;
    asm("movq 16(%1,%2,8), %0" : "=r"(got) : "r"(cells), "r"(5ULL));
    if (got != 0x1007)
        return 2;
    asm("movq (%1,%2), %0" : "=r"(got) : "r"(cells), "r"(24ULL));
    if (got != 0x1003)
        return 3;
    asm("movl (%1,%2,4), %k0" : "=r"(got) : "r"(cells), "r"(2ULL));
    if (got != 0x1001)
        return 4;

    /* Explicit-register store through a SIB form. */
    asm("movq %%rcx, 8(%%rax,%%rbx,2)"
        : : "a"(cells), "b"(4ULL), "c"((u64)0xF00D) : "memory");
    if (cells[2] != 0xF00D)
        return 5;

    /* lea folds the scaled address. */
    u64 addr;
    asm("lea 8(%1,%2,8), %0" : "=r"(addr) : "r"(cells), "r"(3ULL));
    if (addr != (u64)&cells[4])
        return 6;

    return 42;
}
