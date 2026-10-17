// The largest static alignment badc honors (64 KiB) is placed on its
// boundary for bare, initialised, and block-scope-static storage. This is
// the top of the supported range; a global at this boundary is what a
// page-and-multiple per-CPU allocation needs. Runtime addresses, matched
// against GCC and clang on x86-64 and aarch64.
// On Mach-O it is 16 KiB: macOS slides an image by whole pages.

#if defined(__APPLE__)
#define MAXA 16384
#define HALF 8192
#else
#define MAXA 65536
#define HALF 32768
#endif

struct Member64k {
    char c;
    long __attribute__((aligned(MAXA))) v;
};

long __attribute__((aligned(MAXA))) g_bare;
long __attribute__((aligned(MAXA))) g_init = 3;
struct Member64k g_type;

static int mis(const void *p, unsigned long a) {
    return (int)((unsigned long)p & (a - 1));
}

int main(void) {
    static long __attribute__((aligned(MAXA))) s_bare;
    static long __attribute__((aligned(MAXA))) s_init = 4;

    if (mis(&g_bare, MAXA)) return 1;
    if (mis(&g_init, MAXA)) return 2;
    if (mis(&s_bare, MAXA)) return 3;
    if (mis(&s_init, MAXA)) return 4;
    if (mis(&g_type, MAXA)) return 5;
    if (mis(&g_type.v, MAXA)) return 6;

    // Negative control: an offset pointer must read as misaligned.
    if (!mis((const char *)&g_bare + 1, MAXA)) return 20;
    if (!mis((const char *)&g_bare + HALF, MAXA)) return 21;

    g_init = 11;
    s_init = 22;
    g_type.v = 33;
    if (g_init != 11 || s_init != 22 || g_type.v != 33) return 30;
    return 0;
}
