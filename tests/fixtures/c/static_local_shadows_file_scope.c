// A block-scope static object has no linkage (C99 6.2.2p6): its name
// hides a file-scope declaration without denoting that entity. The
// references must bind to the block-scope storage -- not to the outer
// extern (which stays unreferenced and imports nothing) nor to the
// outer defined object -- and the outer object's storage record must
// survive the scope with its own extent, placement, and value.
extern unsigned long long cc_mask;

static unsigned long pick(unsigned int cc, unsigned long flags) {
    static const unsigned long cc_mask[6] = {0x800, 1, 0x40, 0x41, 0x80, 4};
    return flags & cc_mask[cc >> 1];
}

unsigned long long g_tab = 0x7777777777777777ULL;

static unsigned long pick2(unsigned int i) {
    static const unsigned long g_tab[4] = {1, 2, 3, 4};
    return g_tab[i];
}

int main(void) {
    volatile unsigned int idx = 2; /* an opaque index defeats folding */
    if (pick(3, 0x41) != 1)
        return 1;
    if (pick(6, 0x41) != 0x41)
        return 2;
    if (pick2(idx) != 3)
        return 3;
    if (g_tab != 0x7777777777777777ULL)
        return 4;
    return 0;
}
