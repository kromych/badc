// An empty inline-asm template is a compiler barrier with no machine
// effect: the no-unroll / memory-clobber idiom that GCC/Clang code uses
// (`__asm__("" :: "r"(p))`, `__asm__ volatile("" ::: "memory")`). badc
// accepts every empty-template form, operands included, and emits
// nothing for the template itself.
//
// Operand placement is the statement's own effect, not the template's,
// so an output still receives its value: an input tied to it by a
// matching constraint, or by naming the same fixed register, has to
// reach the output object. That is the `RELOC_HIDE` idiom the Linux
// per-CPU accessors are built on.

static int sink;

static void barrier_input(int *p) { __asm__("" : : "r"(p)); }
static void barrier_memory(void) { __asm__ volatile("" : : : "memory"); }
static void barrier_bare(void) { __asm__(""); }
static int barrier_rw(int v) {
    __asm__("" : "+r"(v));
    return v;
}
static void barrier_comment(int *p) { __asm__(" /* note */ ;\n\t" : : "r"(p)); }

// `RELOC_HIDE`: the output is tied to a separate input operand, so the
// empty template still hands the input's value back.
static unsigned long hide(unsigned long v) {
    unsigned long out;
    __asm__("" : "=r"(out) : "0"(v));
    return out;
}

// The same tie spelled with a fixed register class on both sides.
static unsigned long hide_fixed(unsigned long v) {
    unsigned long out;
#if defined(__x86_64__)
    __asm__("" : "=a"(out) : "a"(v));
#else
    __asm__("" : "=r"(out) : "0"(v));
#endif
    return out;
}

int main(void) {
    int x = 41;
    barrier_input(&x);
    barrier_memory();
    barrier_bare();
    barrier_comment(&x);
    x++;
    sink = x;
    if (barrier_rw(sink) != 42)
        return 1;
    if (hide(0x1234) != 0x1234)
        return 2;
    if (hide((unsigned long)&sink) != (unsigned long)&sink)
        return 3;
    if (hide_fixed(0x5678) != 0x5678)
        return 4;
    return sink - 42;
}
