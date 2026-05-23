// C99 6.8.1 + 6.8.4.2: a `Stmt::Labeled` is reachable from
// any matching `goto`, so even when the textually preceding
// statement in a switch partition terminates the block (a
// `goto` / `return` / `break` / `continue`), the labeled
// statement must still be emitted. The partition walk
// continues past a terminator only for `Stmt::Labeled` so
// the label's body lands in its own SSA block; implicit
// fallthrough to the next partition stays suppressed when
// the trailing statement is a real terminator.
//
// Repro shape: a chain of `case X: ...; goto common;` arms
// where the `common: ...` label sits in the same compound
// block as the last case's body. Without the post-terminator
// walk the labeled block stays empty and the goto's target
// is missing from the SSA CFG.

int outer(int tok) {
    int u = 0;
    switch (tok) {
    case 1:
        u = 1;
        goto common;
    case 2:
        u = 2;
        goto common;
    case 3:
        u = 3;
        goto common;
    common:
        return u + 100;
    default:
        return -1;
    }
}

int main(void) {
    if (outer(1) != 101) return 1;
    if (outer(2) != 102) return 2;
    if (outer(3) != 103) return 3;
    if (outer(99) != -1) return 4;
    return 0;
}
