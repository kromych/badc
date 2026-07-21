// AArch64 inline asm: the LL/SC atomic-add loop as the kernel spells it --
// a `prfm` prefetch plus an exclusive load/store retry over one `+Q` memory
// operand, all naming that operand with a bare `%N` reference, and a
// multi-letter `"Ir"` constraint on the addend. main returns 42 when the
// updated cell reads back correctly. Native aarch64 only.

typedef struct {
    int counter;
} atomic_t;

static void atomic_add(int i, atomic_t *v) {
    unsigned long tmp;
    int result;
    __asm__ volatile("prfm pstl1strm, %2\n\t"
                     "1: ldxr %w0, %2\n\t"
                     "add %w0, %w0, %w3\n\t"
                     "stxr %w1, %w0, %2\n\t"
                     "cbnz %w1, 1b"
                     : "=&r"(result), "=&r"(tmp), "+Q"(v->counter)
                     : "Ir"(i)
                     : "memory");
}

int main(void) {
    atomic_t v = {40};
    atomic_add(2, &v); // 42
    return v.counter;
}
