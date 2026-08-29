// Zero-initialized objects carrying an explicit `aligned(N)` must be placed
// on their boundary when nothing in `.data` asks for as much: the merged
// `.bss` follows the file-backed data, whose end must be padded to the
// widest `.bss` alignment the units claim rather than to the `.data` one.
// Every object here is zero-initialized, so `.data` holds nothing wider
// than 8 bytes and the `.bss` alignment alone decides the placement. A
// layout-only check cannot see an under-placed object, so the checks read
// the runtime address. Returns 0, distinct non-zero per failure.

static unsigned char s64[64] __attribute__((aligned(64)));
unsigned char g128[128] __attribute__((aligned(128)));
static unsigned char s256[256] __attribute__((aligned(256)));
int filler;

static int misaligned(const void *p, unsigned long want) {
    return ((unsigned long)p & (want - 1)) != 0;
}

int main(void) {
    if (misaligned(s64, 64)) {
        return 1;
    }
    if (misaligned(g128, 128)) {
        return 2;
    }
    if (misaligned(s256, 256)) {
        return 3;
    }
    s64[0] = 1;
    g128[0] = 2;
    s256[0] = 3;
    filler = 4;
    return s64[0] + g128[0] + s256[0] + filler == 10 ? 0 : 4;
}
