// GCC array range designator `[a ... b] = value` in an array initializer
// fills every element in the inclusive range with the value. Covers a
// constant-data range, a range that interleaves with single designators
// and positional entries, and a label-address range (the computed-goto
// dispatch-table shape, which fills the slots with runtime stores).
// Asserted by return code.

static const int ct[16] = { [0] = 1, 2, [4 ... 9] = 7, [12 ... 15] = 9 };

static int check_const(void) {
    if (ct[0] != 1) return 1;
    if (ct[1] != 2) return 2;        // positional after [0]
    if (ct[2] != 0) return 3;        // gap stays zero
    if (ct[4] != 7 || ct[9] != 7) return 4;
    if (ct[3] != 0 || ct[10] != 0) return 5; // outside the range
    if (ct[12] != 9 || ct[15] != 9) return 6;
    return 0;
}

static int dispatch(int op) {
    static const void *const tbl[8] = { &&L0, &&L1, [2 ... 7] = &&Ldef };
    goto *(void *)tbl[op];
L0:
    return 100;
L1:
    return 200;
Ldef:
    return 999;
}

int main(void) {
    int rc = check_const();
    if (rc) return rc;
    if (dispatch(0) != 100) return 10;
    if (dispatch(1) != 200) return 11;
    if (dispatch(2) != 999) return 12;
    if (dispatch(5) != 999) return 13;
    if (dispatch(7) != 999) return 14;
    return 0;
}
