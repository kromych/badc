// An argument that is a constant only once the caller's inlined helpers
// have folded still reaches the out-of-line callee. This is the shape of
// linux 7.2's swap-cache allocation without transparent hugepages:
// highest_order() and next_order() are stubs returning 0, so every call of
// the static allocator passes order 0 and its `if (order)` call to a
// hugepage-only function is dead (C99 6.9.1p10: the arguments are the
// parameters' initial values; 6.2.2: a `static` function is reached only
// through this translation unit's call sites).
//
// `huge_gfp_mask` is declared and never defined, so linking is the
// assertion. The allocator stays out of line, so the constant has to reach
// it interprocedurally after the caller's fold. gcc 16 links this at -O2
// and, like badc, fails to at -O0.

extern unsigned huge_gfp_mask(void *vma);

static inline int highest_order(unsigned long orders) {
    (void)orders;
    return 0;
}

static inline int next_order(unsigned long *orders, int prev) {
    (void)orders;
    (void)prev;
    return 0;
}

static unsigned pool[64];

static __attribute__((noinline)) long cache_alloc(unsigned gfp, unsigned int order, void *vma) {
    unsigned long nr = 1UL << order;
    long acc = 0;
    if (order)
        gfp = huge_gfp_mask(vma) & gfp;
    for (unsigned long i = 0; i < nr; i++)
        acc += pool[i % 64] + gfp;
    return acc;
}

long cache_alloc_folio(unsigned gfp, unsigned long orders, void *vma);
long cache_alloc_folio(unsigned gfp, unsigned long orders, void *vma) {
    int order = highest_order(orders);
    long ret;

    if (!orders || (1UL << order) > 256)
        return -22;
    do {
        ret = cache_alloc(gfp, order, vma);
        if (ret >= 0)
            break;
        if (!order)
            break;
        order = next_order(&orders, order);
    } while (orders);
    return ret;
}

int main(void) {
    int i;
    for (i = 0; i < 64; i++)
        pool[i] = (unsigned)i;
    if (cache_alloc_folio(5, 1, 0) != 5)
        return 1;
    if (cache_alloc_folio(5, 0, 0) != -22)
        return 2;
    return 0;
}
