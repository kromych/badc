/* C99 6.2.1p4: the parameter names of a function declarator that is not
 * part of a function definition have no scope. Such names appear in an
 * abstract function-pointer type used in a cast (`int (*)(int nr)`) and
 * in a function-type typedef (`typedef int T(int nr)`). Binding one that
 * matches a local of the enclosing function corrupted the single-slot
 * shadow the enclosing scope restores at exit, so a later function
 * declaring the same name as its first local was wrongly rejected with
 * "duplicate local definition". */

static int inc(int n) {
    return n + 1;
}

/* Cast path: `nr` is this function's parameter; the cast re-spells `nr`
 * inside the abstract function-pointer type. */
static int dispatch(void *fp, int nr) {
    return ((int (*)(int nr))(fp))(nr);
}

/* Typedef path: a block-scope function-type typedef spelling `nr`. The
 * type stays usable for an indirect call. */
static int via_typedef(int nr) {
    typedef int fn_t(int nr);
    fn_t *p = inc;
    return p(nr);
}

/* The enclosing-parameter name reused as a plain first local in a later
 * function -- the construct the leak turned into a spurious duplicate. */
static int consume(void) {
    int nr = 41;
    return nr;
}

int main(void) {
    int a = dispatch((void *)inc, 10);
    int b = via_typedef(20);
    int c = consume();
    return (a == 11 && b == 21 && c == 41) ? 0 : 1;
}
