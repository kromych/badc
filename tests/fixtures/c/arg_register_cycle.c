// A call that re-passes its caller's argument-register values in
// permuted order forms a parallel-copy cycle the marshaller must break:
// the values sit in the argument registers and the call needs them
// swapped, so an unscheduled per-argument `mov` would clobber a source
// before it is read. On x86_64 the cycle resolves to a single `xchg`; on
// AArch64 (no register swap) it routes one source through the reserved
// scratch.
//
// `rec` is self-recursive, so it is not inlined and the call boundary
// that produces the cycle survives: `a` and `b` arrive in the first two
// argument registers and `rec(b, a, n - 1)` needs them exchanged.
static int rec(int a, int b, int n) {
    if (n == 0) {
        return a - b;
    }
    return rec(b, a, n - 1);
}

int main(void) {
    // One swap: rec(3,10,1) -> rec(10,3,0) -> 10 - 3 = 7.
    if (rec(3, 10, 1) != 7) {
        return 1;
    }
    // Two swaps cancel: rec(3,10,2) -> rec(10,3,1) -> rec(3,10,0) = -7.
    if (rec(3, 10, 2) != -7) {
        return 2;
    }
    // Three swaps: rec(100,1,3) -> ... -> rec(1,100,0) = 1 - 100 = -99.
    if (rec(100, 1, 3) != -99) {
        return 3;
    }
    return 0;
}
