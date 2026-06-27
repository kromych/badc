/* A one-word-struct-returning helper inlines and the result is delivered
   in a register: the caller's return slot is forwarded out of memory, so a
   store-into-an-array-slot becomes a direct indexed store and a field read
   becomes a direct use. Exercises both consumer shapes plus an address
   escape (which keeps the destination local in memory but still forwards
   the return slot). The accumulated value must match the off-line result. */
typedef union {
    unsigned long bits;
} SR;

static inline SR steal(void *p) {
    SR r;
    r.bits = (unsigned long)p;
    return r;
}

static unsigned long read_bits(SR r) {
    return r.bits;
}

int main(void) {
    SR st[4];
    unsigned long bases[4] = {0x1000, 0x2000, 0x3000, 0x4000};
    /* store-into-array-slot consumer (a whole-slot copy out of the return slot) */
    for (int i = 0; i < 4; i++) {
        st[i] = steal((void *)bases[i]);
    }
    unsigned long acc = 0;
    /* field-read consumer */
    for (int i = 0; i < 4; i++) {
        acc += read_bits(st[i]);
    }
    /* local-variable round-trip consumer */
    SR r = steal((void *)0x55);
    acc += r.bits;
    /* 0x1000+0x2000+0x3000+0x4000+0x55 = 0xA055 */
    return acc == 0xA055UL ? 0 : 1;
}
