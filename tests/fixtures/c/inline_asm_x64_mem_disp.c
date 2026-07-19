/* Explicit-register memory operands in x86-64 templates: `disp(%%reg)`
   and `disp(%N)` with zero, positive, negative, and disp32-sized
   displacements, sub-quad access widths, the r12/r13 encoding corners
   (SIB byte; rbp/r13 have no mod=00 form), and the multi-alternative
   `"rax"` constraint (r|a|x: the sole operand takes the first pool
   register, rax, so a template reading %rax observes it -- the libdill
   stack-switch idiom). */

typedef unsigned long long u64;

static u64 cells[64];
static long slot;

int main(void) {
    u64 *base = &cells[8];

    /* Fixed-register base with the displacement spectrum. */
    asm("movq %%rcx, (%%rdx)\n\t"
        "movq %%rcx, 8(%%rdx)\n\t"
        "movq %%rcx, -16(%%rdx)\n\t"
        "movq %%rcx, 256(%%rdx)\n\t"
        : : "d"(base), "c"((u64)0x1122334455667788ULL) : "memory");
    if (cells[8] != 0x1122334455667788ULL) return 1;
    if (cells[9] != 0x1122334455667788ULL) return 2;
    if (cells[6] != 0x1122334455667788ULL) return 3;
    if (cells[40] != 0x1122334455667788ULL) return 4;

    /* Loads back through an operand-referenced base, disp(%N). */
    u64 got;
    asm("movq 8(%1), %0" : "=r"(got) : "r"(base));
    if (got != 0x1122334455667788ULL) return 5;

    /* Sub-quad widths narrow the store to 4 / 2 / 1 bytes. */
    asm("movl %%ecx, (%%rdx)\n\t"
        "movw %%cx, 8(%%rdx)\n\t"
        "movb %%cl, 16(%%rdx)\n\t"
        : : "d"(&cells[16]), "c"((u64)0xAABBCCDDEE99CAFEULL) : "memory");
    if (cells[16] != 0x00000000EE99CAFEULL) return 6;
    if (cells[17] != 0x000000000000CAFEULL) return 7;
    if (cells[18] != 0x00000000000000FEULL) return 8;

    /* r12 (SIB base) and r13 (disp8=0 form) as explicit bases. */
    asm("mov %0, %%r12\n\t"
        "mov %0, %%r13\n\t"
        "movq %1, (%%r12)\n\t"
        "movq %1, 8(%%r12)\n\t"
        "movq %1, 16(%%r13)\n\t"
        "movq %1, -8(%%r13)\n\t"
        : : "r"(&cells[32]), "r"((u64)0xF00DF00DF00DF00DULL)
        : "r12", "r13", "memory");
    if (cells[32] != 0xF00DF00DF00DF00DULL) return 9;
    if (cells[33] != 0xF00DF00DF00DF00DULL) return 10;
    if (cells[34] != 0xF00DF00DF00DF00DULL) return 11;
    if (cells[31] != 0xF00DF00DF00DF00DULL) return 12;

    /* Read-modify through an explicit base. */
    asm("addq $5, (%%rdx)" : : "d"(&cells[8]) : "memory");
    if (cells[8] != 0x112233445566778DULL) return 13;

    /* The sole "rax" operand lands in rax. */
    asm volatile("mov %%rax, (%%rax)" : : "rax"(&slot) : "memory");
    if (slot != (long)&slot) return 14;

    return 42;
}
