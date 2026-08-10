// `.bss`-family named placements: a zero-initialized object whose
// section name is `.bss` or `.bss.*` is zero-fill storage with no file
// backing, and alignment requests on declarations of one object
// combine to the strictest -- including the post-definition
// `extern typeof(obj) obj;` redeclaration an export macro appends.
// A zero object in a section without the `.bss` prefix keeps its
// file-backed placement. Matches GCC on x86-64 and aarch64; returns 0,
// distinct non-zero per failure.

extern unsigned long ezp[512];
unsigned long ezp[512]
    __attribute__((__section__(".bss..page_aligned")))
    __attribute__((__aligned__(4096)));
extern typeof(ezp) ezp;

static char pad[16384] __attribute__((section(".bss..x"), aligned(4096)));
static int dat[32]
    __attribute__((section(".data..page_aligned"), aligned(4096))) = {1, 2, 3};
static long long zeronamed[8] __attribute__((section(".mydata")));

static int misaligned(const void *p, unsigned long want) {
    return ((unsigned long)p & (want - 1)) != 0;
}

int main(void) {
    if (misaligned(ezp, 4096)) return 1;
    if (misaligned(pad, 4096)) return 2;
    if (misaligned(dat, 4096)) return 3;

    for (int i = 0; i < 512; i++)
        if (ezp[i]) return 4;
    for (int i = 0; i < 16384; i++)
        if (pad[i]) return 5;
    for (int i = 0; i < 8; i++)
        if (zeronamed[i]) return 6;
    if (dat[0] + dat[1] + dat[2] + dat[3] != 6) return 7;

    // Values round-trip through the placed slots.
    ezp[0] = 9;
    ezp[511] = 1;
    pad[16383] = 7;
    zeronamed[7] = 5;
    if (ezp[0] + ezp[511] + pad[16383] + zeronamed[7] != 22) return 8;
    return 0;
}
