// An empty inline-asm template is a compiler barrier with no machine
// effect: the no-unroll / memory-clobber idiom that GCC/Clang code uses
// (`__asm__("" :: "r"(p))`, `__asm__ volatile("" ::: "memory")`). badc
// accepts every empty-template form, operands included, and emits
// nothing for it.

static int sink;

static void barrier_input(int *p) { __asm__("" : : "r"(p)); }
static void barrier_memory(void) { __asm__ volatile("" : : : "memory"); }
static void barrier_bare(void) { __asm__(""); }

int main(void) {
    int x = 41;
    barrier_input(&x);
    barrier_memory();
    barrier_bare();
    x++;
    sink = x;
    return sink - 42;
}
