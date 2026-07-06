/* store_forward on frame slots. mem2reg skips a function containing a
   computed goto, so its scalar locals stay as StoreLocal / LoadLocal;
   a store immediately reloaded in the same block forwards to the stored
   value. Negative controls: a volatile slot performs every access (C99
   6.7.3p6), an address-taken slot observes a store through its pointer,
   and a pair split across a block boundary reloads. */

/* acc's store and reloads sit in one block; the reloads forward. */
static int forwards(int n) {
    void *lab = &&out;
    int acc;
    acc = n * 3;
    int r = acc + acc;
    goto *lab;
out:
    return r;
}

/* Each access of v is performed: the reload is kept. */
static int volatile_kept(int n) {
    void *lab = &&out;
    volatile int v;
    v = n;
    int r = v;
    goto *lab;
out:
    return r;
}

/* x's address is taken; the store through p between x's store and the
   reload must be observed, so the reload is kept. */
static int aliased_kept(int n) {
    void *lab = &&out;
    int x;
    int *p = &x;
    x = n;
    *p = n + 1;
    int r = x;
    goto *lab;
out:
    return r;
}

/* The store and the reload sit in different blocks: the reload is kept
   (the pass is intra-block). */
static int cross_block(int n) {
    void *lab = &&join;
    int acc;
    acc = n * 2;
    goto *lab;
join:
    return acc;
}

int main(void) {
    if (forwards(5) != 30) return 1;
    if (volatile_kept(7) != 7) return 2;
    if (aliased_kept(9) != 10) return 3;
    if (cross_block(6) != 12) return 4;
    return 0;
}
