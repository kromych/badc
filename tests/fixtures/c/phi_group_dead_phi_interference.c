// All phi results of a block are written by the same predecessor-edge
// parallel copy, so no two of them may share a register. A dead phi --
// one no instruction reads -- still takes part in that copy, so an
// interference model that sequences phi definitions within the block
// loses the edge between a dead phi and a live one and lets the
// colourer place both in one register. Here the dead phi lands on the
// loop counter's register and its copy resets the counter on every
// back edge, so the loop never exits.
//
// The struct must exceed two eightbytes: the parameter is then passed
// indirectly and the prologue copies it into the frame slot that the
// pre-loop whole-object assignment overwrites, which is what leaves a
// phi with no reader in the loop header.

struct big {
    unsigned short f0;
    unsigned long long f1;
    unsigned long long f2;
};

static struct big mix(struct big p) {
    int i;
    unsigned long long acc = 0x78420c978878fff7ull;
    struct big zero = {0};
    p = zero;
    for (i = 0; i < 5; i++) {
        p = zero;
    }
    acc = (acc * 0x100000001b3ull) ^ ((unsigned long long)p.f0 ^ p.f1);
    zero.f1 = acc;
    return zero;
}

int main(void) {
    struct big a = {0};
    struct big t = mix(a);
    return (int)(t.f1 & 0x7f) == 53 ? 0 : 1;
}
