// A label whose address is taken (`&&label`) is entered through an
// indirect branch, an edge no terminator carries. When the only
// `goto *` is behind a constant-false condition the branch folds away
// and the label block is left with no terminator edge into it, yet its
// address is still recorded. Deleting it strands that reference; the
// block must survive as a target in its own right.

static int only_indirect(int x)
{
    void *target = &&resume;

    if (0)
        goto *target;
    return x + 1;
resume:
    return x + 2;
}

static int selected(int x, int go)
{
    void *target = &&resume;

    if (go)
        goto *target;
    return x + 10;
resume:
    return x + 20;
}

int main(void)
{
    volatile int runtime = 1;

    if (only_indirect(5) != 6) return 1;

    // Inlining makes the condition constant, which folds the same way.
    if (selected(5, 0) != 15) return 2;
    if (selected(5, 1) != 25) return 3;

    // The indirect branch still works where the condition survives.
    if (selected(5, runtime) != 25) return 4;

    return 0;
}
