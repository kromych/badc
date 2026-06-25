/* Inlining a single-block helper into a computed-goto caller must
   preserve the caller's block ids: `Inst::BlockAddr` and the computed-goto
   target table reference them directly. The flat splice rebuilds the block
   array one-to-one, so dispatch stays correct. Both a one-word-struct
   by-value helper and a scalar helper are called from labelled blocks. */
typedef union {
    unsigned long bits;
} SR;

static unsigned long sr_val(SR r) {
    return r.bits & ~3UL;
}
static long dbl(long x) {
    return x + x;
}

static long interp(const int *prog, const SR *st) {
    void *tab[3];
    tab[0] = &&OP_PUSH;
    tab[1] = &&OP_DBL;
    tab[2] = &&OP_HALT;
    long acc = 0;
    int pc = 0;
    goto *tab[prog[pc++]];
OP_PUSH:
    acc += (long)sr_val(st[prog[pc++]]);
    goto *tab[prog[pc++]];
OP_DBL:
    acc = dbl(acc);
    goto *tab[prog[pc++]];
OP_HALT:
    return acc;
}

int main(void) {
    SR st[3];
    st[0].bits = 100UL | 3UL;
    st[1].bits = 200UL | 1UL;
    st[2].bits = 300UL;
    /* PUSH st0 (100), PUSH st1 (200) -> 300, DBL -> 600, PUSH st2 (300) -> 900, HALT */
    int prog[] = {0, 0, 0, 1, 1, 0, 2, 2};
    return interp(prog, st) == 900 ? 0 : 1;
}
