// C99 6.2.1p4 / 6.2.2p4: a block-scope `extern` declaration of a name
// that shadows an enclosing local (or parameter) refers to the
// file-scope object of that name for the duration of the block and must
// not destroy the enclosing binding -- after the block the name refers
// to the enclosing object again. A prior bug converted the shadowed
// local's single symbol slot to an external `Glo` reference and never
// restored it, so the outer object was permanently clobbered (every
// later use resolved to an undefined cross-TU symbol) and an in-block
// reference that named a same-TU definition was misresolved.
//
// Each check returns a distinct nonzero code; success returns 0.

int g = 100;
int n = 77;
int fwd_seen;

// Forward reference: the function block-externs `later`, which is
// defined after this function. The in-block use must resolve to that
// same-TU definition, not a cross-TU undefined symbol.
static int forward_probe(void) {
    int later = 9; // local shadows the file-scope object declared below
    int seen;
    {
        extern int later;
        seen = later; // file-scope `later` (== 55)
    }
    return seen + later; // 55 + local 9
}

int later = 55; // defined after forward_probe references it

// Parameter shadowing: the block-extern names the file-scope `n`, the
// parameter keeps its own value outside the block.
static int param_probe(int n) {
    int r;
    {
        extern int n;
        r = n; // file-scope n (== 77)
    }
    return r + n; // 77 + parameter
}

int main(void) {
    // Repro: the block-extern is declared but not used; the outer local
    // must survive the block.
    {
        int x = 5;
        {
            extern int x;
        }
        if (x != 5) return 1;
    }

    // In-block use resolves to the same-TU file-scope global; the outer
    // local is unchanged and a write through the extern hits the global.
    {
        int g = 5; // shadows file-scope g
        int sum = 0;
        {
            extern int g;
            sum += g; // file-scope g == 100
            g = 7;    // write file-scope g
        }
        sum += g; // local g == 5  -> 105
        if (sum != 105) return 2;
        if (g != 5) return 3; // local unchanged
        {
            extern int g;
            if (g != 7) return 4; // global was written in-block
        }
    }

    if (forward_probe() != 64) return 5; // 55 + 9
    if (param_probe(3) != 80) return 6;  // 77 + 3
    return 0;
}
