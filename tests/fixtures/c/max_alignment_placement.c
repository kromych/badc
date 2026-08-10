// The largest static alignment badc honors (64 KiB) is placed on its
// boundary for bare, initialised, and block-scope-static storage. This is
// the top of the supported range; a global at this boundary is what a
// page-and-multiple per-CPU allocation needs. Runtime addresses, matched
// against GCC and clang on x86-64 and aarch64.
//
// This fixture is not on the Mach-O list: macOS slides a position-
// independent image by whole pages, so an alignment wider than the page
// size is not guaranteed at run time there (clang rejects it likewise).
// The VM, the JIT, and the ELF writers place it exactly.

struct Member64k {
    char c;
    long __attribute__((aligned(65536))) v;
};

long __attribute__((aligned(65536))) g_bare;
long __attribute__((aligned(65536))) g_init = 3;
struct Member64k g_type;

static int mis(const void *p, unsigned long a) {
    return (int)((unsigned long)p & (a - 1));
}

int main(void) {
    static long __attribute__((aligned(65536))) s_bare;
    static long __attribute__((aligned(65536))) s_init = 4;

    if (mis(&g_bare, 65536)) return 1;
    if (mis(&g_init, 65536)) return 2;
    if (mis(&s_bare, 65536)) return 3;
    if (mis(&s_init, 65536)) return 4;
    if (mis(&g_type, 65536)) return 5;
    if (mis(&g_type.v, 65536)) return 6;

    // Negative control: an offset pointer must read as misaligned.
    if (!mis((const char *)&g_bare + 1, 65536)) return 20;
    if (!mis((const char *)&g_bare + 32768, 65536)) return 21;

    g_init = 11;
    s_init = 22;
    g_type.v = 33;
    if (g_init != 11 || s_init != 22 || g_type.v != 33) return 30;
    return 0;
}
