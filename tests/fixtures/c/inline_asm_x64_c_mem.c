/* x86-64 `%c` operand modifier in memory forms: `%cN(%%rip)` substitutes
 * an `i`-class operand as a bare displacement with no `$` prefix. A
 * link-time address becomes a RIP-relative reference to the symbol; a
 * plain constant becomes the literal disp32. Positional and named
 * spellings, load and lea. */

static int counter = 40;
static long cells[4] = {5, 6, 7, 8};

static int load_pos(void) {
    int v;
    __asm__("movl %c1(%%rip), %0" : "=r"(v) : "i"(&counter));
    return v;
}
static long load_named(void) {
    long v;
    __asm__("movq %c[cell](%%rip), %0" : "=r"(v) : [cell] "i"(&cells[2]));
    return v;
}
static long lea_addr(void) {
    long v;
    __asm__("leaq %c1(%%rip), %0" : "=r"(v) : "i"(&cells[1]));
    return v;
}
static long lea_const_disp(void) {
    long a, b;
    /* rip + 64 and rip + 64 computed from the same point: equal. */
    __asm__("leaq %c2(%%rip), %0\n\t"
            "leaq -7(%0), %1"
            : "=r"(a), "=r"(b)
            : "i"(64));
    return a - b;
}

int main(void) {
    if (load_pos() != 40)
        return 1;
    if (load_named() != 7)
        return 2;
    if (*(long *)lea_addr() != 6)
        return 3;
    if (lea_const_disp() != 7)
        return 4;
    return 42;
}
