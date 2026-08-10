/* x86-64 segment-relative `%c` / `%P` memory operands. AT&T marks an
 * immediate with `$`, so a bare substituted operand is a memory
 * reference: `movq %%gs:%c1, %0` loads from the segment base plus the
 * displacement, the percpu addressing shape. A constant displacement
 * takes the absolute disp32 form, an operand naming a link-time address
 * the symbol-relative form.
 *
 * The FS base is the thread control block. The GS base is zero until
 * `arch_prctl(ARCH_SET_GS)` points it at a known area, so both forms are
 * checked against their values. */

typedef unsigned long long u64;

#if defined(__x86_64__) && defined(__linux__)

static long percpu[8];
static long local_marker = 0xABCDE;
long extern_marker = 0x13579;

/* arch_prctl(ARCH_SET_GS, p) as a raw syscall: the check must not depend
 * on the C library while the GS base is redirected. */
static long set_gs(void *p) {
    long r;
    __asm__ volatile("syscall"
                     : "=a"(r)
                     : "a"(158L), "D"(0x1001L), "S"(p)
                     : "rcx", "r11", "memory");
    return r;
}

#endif

int main(void) {
#if defined(__x86_64__) && defined(__linux__)
    long v = 0;
    u64 tp = 0, field = 0;
    unsigned w = 0;

    /* `%%fs:%c` at a constant displacement: the TCB self-pointer at 0 and
     * the field next to it, both read back through a plain pointer. */
    __asm__ volatile("movq %%fs:%c1, %0" : "=r"(tp) : "i"(0));
    if (tp == 0)
        return 1;
    __asm__ volatile("movq %%fs:%c1, %0" : "=r"(field) : "i"(8));
    if (field != *(u64 *)(tp + 8))
        return 2;

    /* GS base is zero here, so a symbol address under the override reads
     * the symbol itself. `%P` and `%c` spell the same substitution. */
    __asm__ volatile("movq %%gs:%P1, %0" : "=r"(v) : "p"(&local_marker));
    if (v != 0xABCDE)
        return 3;
    v = 0;
    __asm__ volatile("movq %%gs:%c1, %0" : "=r"(v) : "i"(&extern_marker));
    if (v != 0x13579)
        return 4;

    /* With GS pointed at a known area, the constant-displacement form is
     * the percpu accessor: load, store, and a narrower access width. */
    percpu[1] = 0x1111;
    percpu[3] = 0x3333;
    if (set_gs(percpu) != 0)
        return 5;
    __asm__ volatile("movq %%gs:%c1, %0" : "=r"(v) : "i"(8));
    if (v != 0x1111)
        return 6;
    __asm__ volatile("movq %%gs:%c1, %0" : "=r"(v) : "i"(24));
    if (v != 0x3333)
        return 7;
    __asm__ volatile("movq %0, %%gs:%c1" : : "r"(0x4444L), "i"(40) : "memory");
    if (percpu[5] != 0x4444)
        return 8;
    __asm__ volatile("movl %%gs:%c1, %0" : "=r"(w) : "i"(8));
    if (w != 0x1111)
        return 9;
    if (set_gs((void *)0) != 0)
        return 10;

    /* No override: a bare `%c` operand is still a memory reference, so
     * the same load through a null segment base reads the symbol. */
    v = 0;
    __asm__ volatile("movq %c1, %0" : "=r"(v) : "i"(&local_marker));
    if (v != 0xABCDE)
        return 11;
#endif
    return 42;
}
