// A block-scope pointer to a variable-length array (C99 6.7.5.2p2): the
// bound is evaluated each time the declaration is reached (6.8p3), for an
// automatic or a static pointer alike, and `sizeof *p` and the pointer's
// stride follow it. A static pointer starts out null. Returns 0 when every
// size matches the bound in effect.

static int automatic(int n) {
    char buf[4][16];
    char (*p)[n] = buf;
    int (*q)[n][3];
    char (**pp)[n] = &p;
    char (*rows[2])[n];
    rows[1] = p + 1;
    int bad = 0;
    bad |= sizeof *p != (unsigned)n;
    bad |= (char *)(p + 1) - (char *)p != n;
    bad |= sizeof *q != sizeof(int) * 3 * (unsigned)n;
    bad |= sizeof **pp != (unsigned)n;
    bad |= (char *)rows[1] - (char *)buf != n;
    return bad;
}

static int statics(int n) {
    static char (*p)[n];
    static char buf[4][16];
    int bad = 0;
    for (int i = 1; i <= 3; i++) {
        typedef char (*row_ptr)[n * i];
        row_ptr r = (row_ptr)buf;
        bad |= sizeof *r != (unsigned)(n * i);
    }
    bad |= p != 0 && (char *)(p + 1) - (char *)p != n;
    p = buf;
    bad |= sizeof *p != (unsigned)n;
    return bad;
}

int main(void) {
    int bad = 0;
    for (int n = 1; n <= 16; n *= 2) {
        bad |= automatic(n);
        bad |= statics(n);
    }
    return bad;
}
