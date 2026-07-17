// A self-recursive caller's stack frame is paid once per recursion level,
// so the inliner must not grow it by absorbing helper bodies once it is
// already large. `rec` recurses and carries a wide local array, so its
// frame is past the recursion inline-frame budget: the `scale` call stays a
// call. The non-recursive `once` still inlines `scale`. The committed
// snapshot shows `rec` retaining its `scale` call and `once` with the call
// folded away; reverting the budget would inline `scale` into `rec` and
// churn the snapshot.

static int scale(int x) { return x * 3 + 1; }

int rec(volatile int *sink, int n) {
    int buf[64];
    for (int i = 0; i < 64; i++)
        buf[i] = scale(n + i);
    int s = 0;
    for (int i = 0; i < 64; i++)
        s += buf[i];
    *sink = s;
    if (n <= 0)
        return s;
    return s + rec(sink, n - 1);
}

int once(int x) { return scale(x) + 7; }

int main(void) {
    volatile int sink = 0;
    /* rec(&sink, 0): sum_{i=0..63} scale(i) = sum(3i+1) = 3*2016 + 64 = 6112 */
    if (rec(&sink, 0) != 6112) return 1;
    if (sink != 6112) return 2;
    if (once(5) != 23) return 3; /* scale(5)+7 = 16+7 */
    return 0;
}
