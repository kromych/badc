// A constant flows through a folded branch into a merge phi, which a
// later branch reads. At -O the first branch folds on the constant,
// prune drops its dead predecessor, and the merge phi collapses to a
// single incoming. The simplify_branches fixed point then resolves the
// constant through the degenerate phi -- directly for a branch on the
// phi, or through the value chain built on it (a comparison, arithmetic)
// -- and folds the next branch, one level per round. This verifies the
// chained folds stay value-preserving; a broken fold changes a result.

// Two levels: p folds -> q's phi degenerate -> q's branch folds.
static int two(int x) {
    int a = 2;
    int p;
    if (a == 2) p = 1; else p = 0;
    int q;
    if (p) q = x + 5; else q = x - 5;
    return q;
}

// Three levels through comparisons on the degenerate phi.
static int three(int x) {
    int a = 7;
    int p;
    if (a == 7) p = 10; else p = 20;
    int q;
    if (p == 10) q = 100; else q = 200;
    int r;
    if (q == 100) r = x * 2; else r = x * 3;
    return r;
}

// The condition reads the phi through a widening chain (int merge feeding
// a truthiness test), the shape that needs the value fold in the loop.
static int widened(int x) {
    int c = 0;
    int t;
    if (c == 0) t = 1; else t = 0;
    if (t) return x + 1;
    return x - 1;
}

int main(void) {
    if (two(3) != 8) return 1;        // p=1 -> x+5
    if (two(-3) != 2) return 2;
    if (three(4) != 8) return 3;      // p=10 -> q=100 -> x*2
    if (three(-1) != -2) return 4;
    if (widened(9) != 10) return 5;   // t=1 -> x+1
    if (widened(0) != 1) return 6;
    return 0;
}
