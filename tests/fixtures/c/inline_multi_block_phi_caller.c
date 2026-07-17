/* A multi-block non-leaf dispatcher inlined into a caller that has a loop,
   so the caller carries loop phis. The multi-block splice shifts caller
   block ids; it must remap each surviving phi's incoming predecessor block
   id across that shift. The loop bound is a volatile read so the loop is
   not unrolled and the phis survive to the splice; the selector is the loop
   variable so the switch does not fold and the whole dispatcher body is
   spliced into the phi-carrying caller. Identical result at -O and -O0. */
static volatile unsigned bound = 12u;

static unsigned g[4];
static void acc_add(unsigned i, unsigned x) { g[i & 3u] += x; }
static void acc_xor(unsigned i, unsigned x) { g[i & 3u] ^= x; }
static void acc_def(unsigned i, unsigned x) { g[i & 3u] = x; }

static void step(unsigned sel, unsigned i, unsigned x) {
    switch (sel) {
    case 0u: acc_add(i, x); break;
    case 1u: acc_xor(i, x); break;
    default: acc_def(i, x); break;
    }
}

int main(void) {
    unsigned s = 1u;
    unsigned n = bound; /* volatile: runtime value, loop is not unrolled */
    for (unsigned i = 0u; i < n; i++) {
        step(i % 3u, i, s);
        s = s * 1103515245u + 12345u;
    }
    unsigned r = g[0] ^ g[1] ^ g[2] ^ g[3];
    return (int)(r & 0x7fu);
}
