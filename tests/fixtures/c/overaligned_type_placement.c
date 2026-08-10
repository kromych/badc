// An object whose alignment comes from its TYPE, with no attribute on the
// declarator, must be placed on that boundary: a struct with an
// over-aligned member raises the aggregate, so `struct S g;` needs the
// wider slot. Covers file-scope, block-scope static, and initialised
// storage at 64 and 128. A layout-only check cannot see an under-placed
// object, so the checks read the runtime address. Matches GCC and clang
// on x86-64 and aarch64; returns 0, distinct non-zero per failure.

struct __attribute__((aligned(64))) S64 {
    int x;
};
struct __attribute__((aligned(128))) S128 {
    int x;
};

struct S64 g64;
struct S128 g128;
struct S64 gi64 = {1};
struct S128 gi128 = {2};

static int misaligned(const void *p, unsigned long want) {
    return ((unsigned long)p & (want - 1)) != 0;
}

int main(void) {
    static struct S64 s64;
    static struct S128 s128;
    static struct S128 si128 = {3};

    if (misaligned(&g64, 64)) return 1;
    if (misaligned(&g128, 128)) return 2;
    if (misaligned(&gi64, 64)) return 3;
    if (misaligned(&gi128, 128)) return 4;
    if (misaligned(&s64, 64)) return 5;
    if (misaligned(&s128, 128)) return 6;
    if (misaligned(&si128, 128)) return 7;

    g128.x = 11;
    gi128.x = 22;
    s128.x = 33;
    si128.x = 44;
    if (g128.x != 11 || gi128.x != 22 || s128.x != 33 || si128.x != 44) return 8;
    if (gi64.x != 1 || gi128.x != 22) return 9;
    return 0;
}
