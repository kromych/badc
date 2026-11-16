/* aarch64 symbol operands in function-body inline asm: `adrp`, the
 * `:lo12:` add and load/store immediates (each access size), a symbol
 * addend, and `adr` of a function -- each site resolved through a
 * per-instruction relocation. */

#if defined(__APPLE__)
#define CSYM(name) "_" name
#else
#define CSYM(name) name
#endif

static long s_qword = 0x0102030405060708;
static short s_half = 0x1234;
static char s_byte = 0x21;
static int s_arr[4] = {10, 20, 30, 40};
static int s_store;
int g_sym_reloc_word = 5;
static int probe_target = 42;

__attribute__((used)) static int helper(void) { return 7; }

/* The refused probe: an operand-reference base under `:lo12:`. */
static int probe(void) {
    int v;
    __asm__ volatile("adrp %x0, " CSYM("probe_target") "\n\t"
                     "ldr %w0, [%x0, :lo12:" CSYM("probe_target") "]"
                     : "=r"(v));
    return v;
}

static long ldr_x(void) {
    long v;
    __asm__("adrp %x0, " CSYM("s_qword") "\n\t"
            "ldr %x0, [%x0, :lo12:" CSYM("s_qword") "]"
            : "=r"(v));
    return v;
}

static int ldrh_h(void) {
    int v;
    __asm__("adrp %x0, " CSYM("s_half") "\n\t"
            "ldrh %w0, [%x0, :lo12:" CSYM("s_half") "]"
            : "=r"(v));
    return v;
}

static int ldrb_b(void) {
    int v;
    __asm__("adrp %x0, " CSYM("s_byte") "\n\t"
            "ldrb %w0, [%x0, :lo12:" CSYM("s_byte") "]"
            : "=r"(v));
    return v;
}

static int add_lo12_addend(void) {
    long p;
    __asm__("adrp %x0, " CSYM("s_arr") " + 8\n\t"
            "add %x0, %x0, :lo12:" CSYM("s_arr") " + 8"
            : "=r"(p));
    return *(int *)p;
}

static void store_word(int v) {
    __asm__("adrp x1, " CSYM("s_store") "\n\t"
            "str %w0, [x1, :lo12:" CSYM("s_store") "]"
            :
            : "r"(v)
            : "x1", "memory");
}

static int load_global(void) {
    int v;
    __asm__("adrp %x0, " CSYM("g_sym_reloc_word") "\n\t"
            "ldr %w0, [%x0, :lo12:" CSYM("g_sym_reloc_word") "]"
            : "=r"(v));
    return v;
}

static long adr_helper(void) {
    long p;
    __asm__("adr %x0, " CSYM("helper") : "=r"(p));
    return p;
}

int main(void) {
    if (probe() != 42)
        return 1;
    if (ldr_x() != 0x0102030405060708)
        return 2;
    if (ldrh_h() != 0x1234)
        return 3;
    if (ldrb_b() != 0x21)
        return 4;
    if (add_lo12_addend() != 30)
        return 5;
    store_word(0x55);
    if (s_store != 0x55)
        return 6;
    if (load_global() != 5)
        return 7;
    if (((int (*)(void))adr_helper())() != 7)
        return 8;
    return 42;
}
