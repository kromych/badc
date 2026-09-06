// C11 6.7.5: `_Alignas(N)` on a declarator places the object on an
// N-byte boundary. A GCC `vector_size(16)` type is modeled as a
// synthesized aggregate, so its objects reach the same placement paths as
// any other aggregate's -- file scope, a block-scope static, an automatic
// object and a named `_Alignas` on each. The odd-sized fillers keep the
// running data offset and the frame cursor off every 16-byte boundary.
// Returns 0, distinct non-zero per failure.

typedef int v4si __attribute__((vector_size(16)));

char pad0 = 1;
double filler0 = 1.5;
char pad1 = 2;
_Alignas(16) v4si g_vec;
char pad2 = 3;
_Alignas(32) v4si g_wide;

static long sink(const void *p) {
    return (long)p;
}

static int misaligned(const void *p, unsigned long want) {
    return ((unsigned long)p & (want - 1)) != 0;
}

static int static_local_boundaries(void) {
    static char s_pad0 = 4;
    static double s_filler = 2.5;
    static char s_pad1 = 5;
    static _Alignas(16) v4si s_vec;
    static char s_pad2 = 6;
    static _Alignas(64) v4si s_wide;

    if (misaligned(&s_vec, 16)) return 1;
    if (misaligned(&s_wide, 64)) return 2;
    sink(&s_pad0);
    sink(&s_filler);
    sink(&s_pad1);
    sink(&s_pad2);
    if (s_pad0 + s_pad1 + s_pad2 != 15 || s_filler != 2.5) return 3;
    return 0;
}

static int automatic_boundaries(void) {
    char a_pad0;
    _Alignas(16) v4si a_vec;
    char a_pad1;
    _Alignas(32) v4si a_wide;

    if (misaligned(&a_vec, 16)) return 4;
    if (misaligned(&a_wide, 32)) return 5;
    a_pad0 = 7;
    a_pad1 = 8;
    sink(&a_pad0);
    sink(&a_pad1);
    // The objects survive a call between the writes and the reads.
    a_vec[0] = 11;
    a_vec[3] = 13;
    a_wide[1] = 17;
    sink(&a_vec);
    sink(&a_wide);
    if (a_vec[0] + a_vec[3] + a_wide[1] != 41) return 6;
    if (a_pad0 + a_pad1 != 15) return 7;
    if (misaligned(&a_vec, 16) || misaligned(&a_wide, 32)) return 8;
    return 0;
}

int main(void) {
    if (misaligned(&g_vec, 16)) return 9;
    if (misaligned(&g_wide, 32)) return 10;
    g_vec[2] = 19;
    g_wide[0] = 23;
    sink(&pad0);
    sink(&filler0);
    sink(&pad1);
    sink(&pad2);
    if (g_vec[2] + g_wide[0] != 42) return 11;
    if (pad0 + pad1 + pad2 != 6 || filler0 != 1.5) return 12;

    int rc = static_local_boundaries();
    if (rc) return rc;
    return automatic_boundaries();
}
