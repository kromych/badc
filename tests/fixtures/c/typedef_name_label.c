// A label may share its spelling with a typedef name in scope: labels are a
// name space of their own (C99 6.2.3), and a typedef name followed by `:`
// begins a labeled statement, not a declaration -- at the function body's
// top level, in a nested block and after a `case` label. The typedef names
// still declare objects afterwards. Every path is checked at run time.

typedef int (*cleanup)(void *);
typedef int size;
typedef long lbl;

static int f(int x) {
    if (x > 0)
        goto cleanup;
    x = -x;
cleanup:
    x += 1;
    {
        if (x > 5)
            goto size;
        x *= 2;
    size:
        x += 10;
    }
    switch (x) {
    case 0:
    lbl:
        x = 99;
        break;
    default:
        if (x == 21)
            goto lbl;
    }
    return x;
}

int main(void) {
    cleanup c = 0;
    size s = sizeof(lbl);
    int bad = 0;
    if (f(3) != 18)
        bad |= 1;
    if (f(-2) != 16)
        bad |= 2;
    if (f(10) != 99)
        bad |= 4;
    if (c != 0 || s != sizeof(long))
        bad |= 8;
    return bad;
}
