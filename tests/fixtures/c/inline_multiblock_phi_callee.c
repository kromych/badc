// A static multi-block callee whose result is a phi merging the arms of an
// if/else-if/else chain, plus a second phi from a following conditional. At -O
// the inliner splices the callee (phi included) into each caller; a constant
// selector then folds the chain to one arm (a degenerate single-incoming phi),
// while a variable selector keeps the full phi live. Locks the callee-phi
// multi-block splice and its predecessor-move lowering.

static int pick(int a, int b, int sel) {
    int t;
    if (sel == 0) { t = a + b; }
    else if (sel == 1) { t = a - b; }
    else if (sel == 2) { t = a * b; }
    else { t = a ^ b; }
    if (t < 0) { t = -t; }
    return t * 2 + (t & 1);
}

static int use_const0(int a, int b) { return pick(a, b, 0); }
static int use_const2(int a, int b) { return pick(a, b, 2); }
static int use_var(int a, int b, int s) { return pick(a, b, s); }

int main(void) {
    if (use_const0(3, 4) != 15) return 1;         // |3+4|=7 -> 14 + (7&1)
    if (use_const2(-3, 4) != 24) return 2;        // |-12|=12 -> 24 + (12&1)
    if (use_var(5, 6, 1) != 3) return 3;          // |5-6|=1 -> 2 + (1&1)
    if (use_var(5, 6, 3) != 7) return 4;          // |5^6|=3 -> 6 + (3&1)
    if (use_var(-7, -8, 0) != 31) return 5;       // |-15|=15 -> 30 + (15&1)
    long acc = 0;
    for (int a = -4; a <= 4; a++)
        for (int b = -3; b <= 3; b++)
            for (int s = 0; s < 4; s++)
                acc += use_var(a, b, s);
    if (acc != 1568) return 6;
    return 0;
}
