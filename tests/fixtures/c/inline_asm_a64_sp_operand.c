// AArch64 inline asm: register-operand add/sub naming the stack pointer.
// Register 31 is the stack pointer only in the extended-register encodings,
// so each helper checks the value the instruction produced, not just that it
// assembled: reading 31 as the zero register yields the operand alone (or
// leaves the stack pointer unwritten) and every check below fails. Each block
// reads its own reference `sp`, so the checks do not depend on where a frame
// sits. Native aarch64 only.

// The dependent-load speculation barrier: exclusive-or a value with itself for
// a zero that carries a data dependency, add it to the stack pointer, then
// take a dependent load. The load faults if the add read 31 as zero.
static int barrier_reads_sp(unsigned long v) {
    unsigned long base, t;
    __asm__ volatile("mov %0, sp\n\t"
                     "eor %1, %2, %2\n\t"
                     "add %1, sp, %1\n\t"
                     "ldr xzr, [%1]"
                     : "=&r"(base), "=&r"(t)
                     : "r"(v));
    return base != 0 && t == base;
}

static int add_sp_reg(unsigned long v) {
    unsigned long base, t;
    __asm__ volatile("mov %0, sp\n\tadd %1, sp, %2"
                     : "=&r"(base), "=&r"(t)
                     : "r"(v));
    return t == base + v;
}

static int sub_sp_reg(unsigned long v) {
    unsigned long base, t;
    __asm__ volatile("mov %0, sp\n\tsub %1, sp, %2"
                     : "=&r"(base), "=&r"(t)
                     : "r"(v));
    return t == base - v;
}

static int subs_sp_reg(unsigned long v) {
    unsigned long base, t;
    __asm__ volatile("mov %0, sp\n\tsubs %1, sp, %2"
                     : "=&r"(base), "=&r"(t)
                     : "r"(v)
                     : "cc");
    return t == base - v;
}

static int adds_sp_reg(unsigned long v) {
    unsigned long base, t;
    __asm__ volatile("mov %0, sp\n\tadds %1, sp, %2"
                     : "=&r"(base), "=&r"(t)
                     : "r"(v)
                     : "cc");
    return t == base + v;
}

// The written extend and shift spellings of the same address computation.
static int add_sp_uxtx(unsigned long v) {
    unsigned long base, t;
    __asm__ volatile("mov %0, sp\n\tadd %1, sp, %2, uxtx #0"
                     : "=&r"(base), "=&r"(t)
                     : "r"(v));
    return t == base + v;
}

static int add_sp_lsl3(unsigned long v) {
    unsigned long base, t;
    __asm__ volatile("mov %0, sp\n\tadd %1, sp, %2, lsl #3"
                     : "=&r"(base), "=&r"(t)
                     : "r"(v));
    return t == base + (v << 3);
}

static int add_sp_uxtw(unsigned int v) {
    unsigned long base, t;
    __asm__ volatile("mov %0, sp\n\tadd %1, sp, %w2, uxtw"
                     : "=&r"(base), "=&r"(t)
                     : "r"(v));
    return t == base + v;
}

// The 32-bit form: wsp is the low half of the stack pointer.
static int add_wsp_reg(unsigned int v) {
    unsigned long base;
    unsigned int t;
    __asm__ volatile("mov %0, sp\n\tadd %w1, wsp, %w2"
                     : "=&r"(base), "=&r"(t)
                     : "r"(v));
    return t == (unsigned int)base + v;
}

// cmp is subs with a zero-register destination: comparing the stack pointer
// against its own value sets Z only if the compare really read sp.
static int cmp_sp_eq(long bias) {
    unsigned long eq;
    __asm__ volatile("add %1, sp, %2\n\tcmp sp, %1\n\tcset %0, eq"
                     : "=&r"(eq), "=&r"(bias)
                     : "r"(bias)
                     : "cc");
    return (int)eq;
}

// The stack pointer as the destination of a register-operand add/sub: move it
// down by a register amount, read it back, then restore it from the saved
// copy. A shifted-register encoding would write the zero register instead, so
// neither the move nor the restore takes effect and the readback fails.
static int sp_dest_roundtrip(unsigned long delta) {
    unsigned long saved, moved, back;
    __asm__ volatile("mov %0, sp\n\t"
                     "sub sp, sp, %3\n\t"
                     "add %1, sp, xzr\n\t"
                     "add sp, %0, xzr\n\t"
                     "add %2, sp, xzr"
                     : "=&r"(saved), "=&r"(moved), "=&r"(back)
                     : "r"(delta));
    return moved == saved - delta && back == saved;
}

int main(void) {
    unsigned long sp;
    unsigned long local;
    __asm__ volatile("mov %0, sp" : "=r"(sp));
    // The stack pointer is a real address near this frame's locals.
    if (sp == 0 || (unsigned long)&local < sp
        || (unsigned long)&local - sp > 4096) {
        return 1;
    }
    if (!barrier_reads_sp(0x1234)) {
        return 2;
    }
    if (!add_sp_reg(0) || !add_sp_reg(8)) {
        return 3;
    }
    if (!sub_sp_reg(16) || !subs_sp_reg(16) || !adds_sp_reg(16)) {
        return 4;
    }
    if (!add_sp_uxtx(24) || !add_sp_lsl3(3)) {
        return 5;
    }
    if (!add_sp_uxtw(0x10u)) {
        return 6;
    }
    if (!add_wsp_reg(4)) {
        return 7;
    }
    if (cmp_sp_eq(0) != 1 || cmp_sp_eq(8) != 0) {
        return 8;
    }
    if (!sp_dest_roundtrip(32)) {
        return 9;
    }
    return 42;
}
