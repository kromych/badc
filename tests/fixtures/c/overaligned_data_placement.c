// Objects carrying an explicit `aligned(N)` above 16 must be placed on
// their boundary in the emitted image. The static data-DCE pass rebases
// each surviving object; it must keep the object's full alignment residue,
// not just a fixed 16, or a cache-line-aligned object ends up 16-aligned.
// Every request here is an explicit declarator attribute, which badc has
// always accepted. A layout-only check cannot see an under-placed object,
// so the checks read the runtime address. Matches GCC and clang on x86-64
// and aarch64; returns 0, distinct non-zero per failure.

int __attribute__((aligned(64))) g64;
int __attribute__((aligned(128))) g128;
int __attribute__((aligned(256))) g256;
int __attribute__((aligned(64))) gi64 = 1;
int __attribute__((aligned(128))) gi128 = 2;
int __attribute__((aligned(256))) gi256 = 3;

// A live nonzero object between the aligned ones exercises the mixed
// file-backed / bss carve the DCE pass performs.
int filler = 7;

static int misaligned(const void *p, unsigned long want) {
    return ((unsigned long)p & (want - 1)) != 0;
}

int main(void) {
    static int __attribute__((aligned(64))) s64;
    static int __attribute__((aligned(128))) s128;
    static int __attribute__((aligned(256))) si256 = 9;

    if (misaligned(&g64, 64)) return 1;
    if (misaligned(&g128, 128)) return 2;
    if (misaligned(&g256, 256)) return 3;
    if (misaligned(&gi64, 64)) return 4;
    if (misaligned(&gi128, 128)) return 5;
    if (misaligned(&gi256, 256)) return 6;
    if (misaligned(&s64, 64)) return 7;
    if (misaligned(&s128, 128)) return 8;
    if (misaligned(&si256, 256)) return 9;

    // Values round-trip through the placed slots.
    g128 = 11;
    gi256 = 22;
    s128 = 33;
    si256 = 44;
    if (g128 != 11 || gi256 != 22 || s128 != 33 || si256 != 44) return 10;
    if (gi64 != 1 || gi128 != 2 || filler != 7) return 11;
    return 0;
}
