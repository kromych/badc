// C99 6.7.9p21: a brace-enclosed array initializer with fewer
// elements than the declared array size zero-fills the rest
// (static-storage-duration semantics). c5's local-array lift
// emits Mcpy of the explicit prefix from a data-segment
// template but leaves the trailing bytes as whatever the
// stack frame held on entry; monocypher's mod_l miscomputes
// because of this gap.
//
// The fixture pushes a recognisable pattern onto the prior
// stack frame, then declares a partially-initialised local
// array and walks every element. A C99-conforming
// implementation returns 0; current c5 returns the sum of the
// residual bytes seeded by clobber.
//
// TODO: c5 lift must emit zero-fill of the trailing range
// for local arrays with partial brace initializers (C99
// 6.7.9p21). The c99-gaps.md "Local array partial-initializer
// zero-fill" entry tracks the divergence.

// Force a distinctive byte pattern onto the stack region the
// trailing array elements will land on. The `volatile` sink
// keeps the writes from being eliminated.
static void clobber(unsigned pattern) {
    unsigned scratch[40];
    int i;
    for (i = 0; i < 40; i++) scratch[i] = pattern;
    volatile unsigned sink = scratch[0] + scratch[39];
    (void)sink;
}

static unsigned sum_partial_init(void) {
    // 25 elements, only [0] explicitly named. C99 requires
    // [1..24] to be zero. If c5 emits only Mcpy of the
    // 4-byte prefix, the trailing 96 bytes hold stack residue.
    unsigned arr[25] = {0};
    unsigned s = 0;
    int i;
    for (i = 0; i < 25; i++) s += arr[i];
    return s;
}

int main(void) {
    clobber(0xdeadbeefu);
    unsigned a = sum_partial_init();
    clobber(0x12345678u);
    unsigned b = sum_partial_init();
    // Both sums must be zero per C99.
    if (a != 0) return 1;
    if (b != 0) return 2;
    return 0;
}
