// Case blocks that fall through into each other so shared blocks
// carry phis under -O: each fall-into block merges the dispatcher's
// table edge with the previous case's fall-through edge. The
// critical-edge splitter must retarget the table entries onto
// trampoline blocks; without the split, the dispatcher exit would
// emit every successor's phi moves and clobber live values on the
// other table edges.

static long chain(int op, long a, long b) {
    long x = a;
    long y = b;
    switch (op) {
        case 0: x = a + 1; /* fall through */
        case 1: y = x + 2; /* fall through */
        case 2: x = x + y; /* fall through */
        case 3: y = y * 3; /* fall through */
        case 4: x = x - y; /* fall through */
        case 5: y = y + x; /* fall through */
        case 6: x = x * 2; /* fall through */
        case 7: y = y - 1; /* fall through */
        case 8: x = x + 7; /* fall through */
        case 9: y = y + x; break;
        case 10: x = -a; break;
        case 11: y = -b; break;
        default: x = 13; y = 17; break;
    }
    return x * 31 + y;
}

int main(void) {
    long h = 0;
    for (int op = -2; op < 14; op++) {
        for (long a = -1; a < 3; a++) {
            for (long b = 0; b < 3; b++) {
                h = h * 33 + chain(op, a, b);
            }
        }
    }
    // Golden value cross-checked against clang -O2 and -O0.
    return h == -3365603682695239840L ? 0 : 1;
}
