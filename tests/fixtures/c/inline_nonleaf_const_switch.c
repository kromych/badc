/* A void dispatcher whose only non-purity is per-case leaf calls. At -O it
   is an inline candidate (non-leaf calls are admitted in the scalar/void
   shape) and a constant-size call folds its switch to one case, so the
   other cases -- and the standalone dispatcher, once every caller inlined
   it -- drop out. Void return keeps the dispatcher phi-free; the caller is
   phi-free so the multi-block splice applies. Links and returns 0 at both
   -O and -O0 (the default case is a defined store, not a link canary). */
static void put1(unsigned char *p, unsigned v) { *p = (unsigned char)v; }
static void put2(unsigned short *p, unsigned v) { *p = (unsigned short)v; }
static void put4(unsigned *p, unsigned v) { *p = v; }
static void put0(void *p) { *(unsigned char *)p = 0; }

static void put(void *p, int size, unsigned v) {
    switch (size) {
    case 1: put1((unsigned char *)p, v); break;
    case 2: put2((unsigned short *)p, v); break;
    case 4: put4((unsigned *)p, v); break;
    default: put0(p); break;
    }
}

int main(void) {
    unsigned a = 0, b = 0, c = 0;
    put(&a, 4, 0x11223344u);
    put(&b, 2, 0x11223344u);
    put(&c, 1, 0x11223344u);
    /* a=0x11223344, b=0x3344, c=0x44; the XOR check folds to 0 when correct. */
    unsigned bad = (a ^ 0x11223344u) | (b ^ 0x3344u) | (c ^ 0x44u);
    return (int)bad;
}
