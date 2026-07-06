// C99 6.2.4p3: an object with static storage duration is initialized
// exactly once, before program startup semantics apply to its lifetime.
// A static-local array whose initializer carries `&&label` elements is
// filled by runtime stores at the declaration point; those stores must
// not re-run on later calls, or they clobber user writes to the table.

static void *saved;

static int step(int n) {
    static void *tbl[] = { &&l1, &&l2 };
    if (n == 0) {
        // First call: record the original entry, then redirect slot 0.
        saved = tbl[0];
        tbl[0] = tbl[1];
        goto *tbl[1];
    }
    // Second call: the redirect must have survived the re-entry.
    if (tbl[0] != tbl[1]) return 1;
    tbl[0] = saved;
    goto *tbl[0];
l1:
    return 10;
l2:
    return 20;
}

// A logical AND inside a constant element routes to the same runtime
// path (the initializer scan keys on the `&&` token), so its once
// semantics are locked too.
static int flag_table(int n, int set) {
    static int flags[3] = { 1 && 1, 0, 1 };
    if (set) flags[1] = 7;
    return flags[n];
}

int main(void) {
    if (step(0) != 20) return 2;
    if (step(1) != 10) return 3;
    if (flag_table(1, 1) != 7) return 4;
    if (flag_table(1, 0) != 7) return 5;
    if (flag_table(0, 0) != 1) return 6;
    return 0;
}
