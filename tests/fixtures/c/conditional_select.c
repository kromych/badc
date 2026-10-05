// A value chosen by a condition (C99 6.5.15) lowers to one
// `Inst::Select` when both arms are pure register values; the
// per-arch conditional select (csel / csinc, cmovcc) replaces the
// diamond. `__builtin_ffs` builds the select directly over the
// trailing-zero count. Asserted against hand-computed values so the
// fixture runs on the interpreter without formatted output.

static int eq(int a, int b) { return a == b; }

int tern(int a, int b, int c) { return c ? a : b; }
int min2(int a, int b) { return a < b ? a : b; }
int max2(int a, int b) { return a > b ? a : b; }
long abs2(long x) { return x < 0 ? -x : x; }
int ffs_i(int x) { return __builtin_ffs(x); }
long ffs_l(long x) { return __builtin_ffsl(x); }
/* An arm with an observable evaluation keeps its branch. */
int guarded(int *p, int c) { return c ? *p : 2; }

int main(void) {
    if (!eq(tern(5, 7, 0), 7)) return 1;
    if (!eq(tern(5, 7, 1), 5)) return 2;
    if (!eq(min2(-3, 8), -3)) return 3;
    if (!eq(max2(-3, 8), 8)) return 4;
    if (!eq((int)abs2(-42), 42)) return 5;
    if (!eq(ffs_i(0), 0)) return 6;
    if (!eq(ffs_i(12), 3)) return 7;
    if (!eq((int)ffs_l(1L << 40), 41)) return 8;
    volatile int x = 9;
    if (!eq(guarded(&x, 0), 2)) return 9;
    if (!eq(guarded(&x, 1), 9)) return 10;
    return 0;
}
