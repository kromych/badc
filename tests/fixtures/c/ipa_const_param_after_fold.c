// An argument that is a constant only once the caller's inlined helpers
// have folded still reaches the out-of-line callee. `first_shift` and
// `next_shift` return 0, so every call of the static `fill` passes 0 for
// `shift` and its `if (shift)` call is dead (C99 6.9.1p10: the arguments
// are the parameters' initial values; 6.2.2: a `static` function is
// reached only through this translation unit's call sites).
//
// `wide_mask` is declared and never defined, so linking is the assertion.
// `fill` stays out of line, so the constant has to reach it
// interprocedurally after the caller's fold. gcc 16 links this at -O2 and,
// like badc, fails to at -O0.

extern unsigned wide_mask(void *ctx);

static inline int first_shift(unsigned long shifts) {
    (void)shifts;
    return 0;
}

static inline int next_shift(unsigned long *shifts, int prev) {
    (void)shifts;
    (void)prev;
    return 0;
}

static unsigned pool[64];

static __attribute__((noinline)) long fill(unsigned mask, unsigned int shift, void *ctx) {
    unsigned long nr = 1UL << shift;
    long acc = 0;
    if (shift)
        mask = wide_mask(ctx) & mask;
    for (unsigned long i = 0; i < nr; i++)
        acc += pool[i % 64] + mask;
    return acc;
}

long fill_first(unsigned mask, unsigned long shifts, void *ctx);
long fill_first(unsigned mask, unsigned long shifts, void *ctx) {
    int shift = first_shift(shifts);
    long ret;

    if (!shifts || (1UL << shift) > 256)
        return -22;
    do {
        ret = fill(mask, shift, ctx);
        if (ret >= 0)
            break;
        if (!shift)
            break;
        shift = next_shift(&shifts, shift);
    } while (shifts);
    return ret;
}

int main(void) {
    int i;
    for (i = 0; i < 64; i++)
        pool[i] = (unsigned)i;
    if (fill_first(5, 1, 0) != 5)
        return 1;
    if (fill_first(5, 0, 0) != -22)
        return 2;
    return 0;
}
