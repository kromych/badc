// A `&&label` element (GCC labels as values) in an array initializer is a
// runtime value: the block address is not known until the function is
// emitted, so the element is filled by a runtime store rather than a
// constant. An automatic array of label addresses, indexed by a computed
// goto, is the dispatch-table form. Asserted by return code.

static int run(int n) {
    void *tbl[] = { &&L0, &&L1, &&L2 };
    int acc = 0;
    goto *tbl[n];
L0:
    acc = 10;
    goto done;
L1:
    acc = 20;
    goto done;
L2:
    acc = 30;
    goto done;
done:
    return acc;
}

int main(void) {
    if (run(0) != 10) return 1;
    if (run(1) != 20) return 2;
    if (run(2) != 30) return 3;
    return 0;
}
