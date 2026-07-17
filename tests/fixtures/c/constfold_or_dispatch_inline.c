// A static dispatcher with a short-circuit `||` plus an else-if chain,
// called with a constant selector by each wrapper. At -O the callee inlines;
// folding the constant selector removes the not-taken branch edges, and the
// merge phis the `||` builds must drop the incomings those edges carried so
// they collapse to the selected arm (the dead final `else` arm folds away).
// A stale phi incoming would leave the wrong arm reachable -- verified here by
// value, and by the committed snapshot showing the dead arms gone.

static int dispatch(int op, int x) {
    int t;
    if (op == 0 || op == 2) t = x + 1;
    else if (op == 1) t = x + 2;
    else if (op == 3) t = x + 4;
    else t = x + 100; /* dead for op in {0,1,2,3} */
    return t * 2 + op;
}

int c0(int x) { return dispatch(0, x); }
int c1(int x) { return dispatch(1, x); }
int c2(int x) { return dispatch(2, x); }
int c3(int x) { return dispatch(3, x); }

int main(void) {
    if (c0(10) != 22) return 1; /* (10+1)*2 + 0 */
    if (c1(10) != 25) return 2; /* (10+2)*2 + 1 */
    if (c2(10) != 24) return 3; /* (10+1)*2 + 2 */
    if (c3(10) != 31) return 4; /* (10+4)*2 + 3 */
    long acc = 0;
    for (int x = -5; x <= 5; x++) {
        acc += c0(x);
        acc ^= c1(x);
        acc += c2(x);
        acc ^= c3(x);
    }
    if (acc != 88) return 5;
    return 0;
}
