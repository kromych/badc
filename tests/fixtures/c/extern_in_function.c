// Locks C99 6.7.1 paragraph 3 -- `extern` declarations are
// permitted at any scope, including inside a function body. The
// declaration refers to the prior file-scope or external
// declaration of the same identifier. c5 has no separate
// translation units; the function-body extern declaration is
// consumed as a no-op so the resolver finds the symbol via its
// own table.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

// File-scope declaration of `negate` -- the function body below
// is the binding the block-scope extern must resolve to.
int negate(int x);

static int wrap(int x) {
    // `extern` re-declaration at function-body scope with a
    // pointer-qualified return type -- stresses the parser's
    // function-prototype detection, which must walk the `*`
    // chain before deciding the declaration is a prototype.
    extern char *strchr(char *, int);
    // Plain block-scope extern of the file-scope function.
    extern int negate(int);
    return negate(x);
}

int negate(int x) {
    return -x;
}

int main(void) {
    if (wrap(-5) != 5) return 11;
    if (wrap(7)  != -7) return 12;
    if (negate(3) != -3) return 13;
    // Both call sites must resolve through the same binding.
    if (wrap(-1) != negate(-1)) return 14;
    return 0;
}
