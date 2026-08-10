// C99 6.8.4.2: a dense switch lowers to an indirect dispatch through a
// jump table. When the controlling expression is a compile-time constant
// -- here after the single-call-site callee is inlined -- the dispatch
// folds to an unconditional branch and every other case block becomes
// unreachable. The table's target list outlives the terminator that
// named it, so the block deletion must clear it: an entry naming a
// deleted block is a block-id reference no later renumbering resolves.

static int pick_folded(int k)
{
    switch (k) {
    case 0: return 10;
    case 1: return 11;
    case 2: return 12;
    case 3: return 13;
    case 4: return 14;
    case 5: return 15;
    case 6: return 16;
    case 7: return 17;
    default: return -1;
    }
}

static int pick_live(int k)
{
    switch (k) {
    case 0: return 20;
    case 1: return 21;
    case 2: return 22;
    case 3: return 23;
    case 4: return 24;
    case 5: return 25;
    case 6: return 26;
    case 7: return 27;
    default: return -2;
    }
}

int main(void)
{
    volatile int runtime = 5;

    if (pick_folded(2) != 12) return 1;

    // A dispatch whose index is not constant keeps its table and must
    // still reach every arm, in range and out.
    if (pick_live(runtime) != 25) return 2;
    runtime = 0;
    if (pick_live(runtime) != 20) return 3;
    runtime = 7;
    if (pick_live(runtime) != 27) return 4;
    runtime = 9;
    if (pick_live(runtime) != -2) return 5;

    return 0;
}
