/* A phi's predecessor-exit moves are emitted at the end of the predecessor,
   so a block with two successors must not name a phi-carrying successor
   directly: the moves would run on both of its edges. Critical-edge
   splitting used to skip any function holding an address-taken label -- a
   shape ordinary code reaches through a label whose address is only
   recorded, never jumped to. In such a function the merge move for a
   short-circuit ran before the branch and overwrote the register holding
   the branch condition, so the second operand was evaluated whatever the
   first compared to. */

static void *reported;
static int gate;

static void report(void *ip) {
    reported = ip;
}

static int chk_a(unsigned a, unsigned b) {
    return (a & 0xf) == 5 && (b & 1);
}

static int chk_b(unsigned a, unsigned b) {
    return (a & 0xf) == 5 && (b & 2);
}

static int probe(unsigned a, unsigned b, int n) {
    if (gate) {
        __label__ here;
    here:
        report(&&here);
        return -1;
    }
    if (chk_a(a, b))
        n += 1;
    if (chk_b(a, b))
        n += 2;
    return n;
}

int main(void) {
    if (probe(5u, 3u, 10) != 13)
        return 1;
    if (probe(5u, 2u, 10) != 12)
        return 2;
    if (probe(4u, 3u, 10) != 10)
        return 3;
    if (probe(4u, 0u, 10) != 10)
        return 4;
    gate = 1;
    if (probe(5u, 3u, 10) != -1 || reported == 0)
        return 5;
    return 0;
}
