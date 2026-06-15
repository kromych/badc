// C99 6.8.5.3 / 6.7p1: a for-loop init-clause declaration may declare
// several declarators (`for (int i = 0, l = n; ...)`), and each
// initializer must take effect. The lowering wrapped the init
// declaration by keeping only the last arena statement, which dropped
// every initializer but the last; the earlier loop counters and bounds
// were then left uninitialized and the loop misran (often zero trips).

int main(void) {
    // Two declarators: counter and bound, bound read in the condition.
    int n = 0;
    for (int i = 0, l = 3; i < l; i++) n++;
    if (n != 3) return 1;

    // Three declarators: counter, bound, and a step read in the body.
    int s = 0;
    for (int i = 0, lim = 4, step = 2; i < lim; i++) s += step;
    if (s != 8) return 2;

    // Wider type, bound and counter both from the init list.
    long prod = 1;
    for (long i = 1, hi = 5; i <= hi; i++) prod *= i;
    if (prod != 120) return 3;

    // The first declarator's initializer must not be lost even when a
    // later declarator depends on an earlier one.
    int t = 0;
    for (int a = 2, b = a + 3; a < b; a++) t++;
    if (t != 3) return 4;

    return 0;
}
