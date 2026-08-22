// An empty inline-asm template is a compiler barrier with no machine
// effect: the no-unroll / memory-clobber idiom that GCC/Clang code uses
// (`__asm__("" :: "r"(p))`, `__asm__ volatile("" ::: "memory")`). badc
// accepts every empty-template form, operands included, and emits
// nothing for it.

static int sink;

static void barrier_input(int *p) { __asm__("" : : "r"(p)); }
static void barrier_memory(void) { __asm__ volatile("" : : : "memory"); }
static void barrier_bare(void) { __asm__(""); }
static int barrier_rw(int v) {
    __asm__("" : "+r"(v));
    return v;
}
static void barrier_comment(int *p) { __asm__(" /* note */ ;\n\t" : : "r"(p)); }

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
    return sink - 42;
}
