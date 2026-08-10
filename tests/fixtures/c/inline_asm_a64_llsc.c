// AArch64 inline asm: a `+Q` read-write memory operand in a load/store
// exclusive retry loop. The one `%2` reference feeds both the exclusive
// load and the exclusive store, alongside `%w` width modifiers on the
// register operands. main returns 42 only when both fetch-and-add results
// and the final cell value agree. Native aarch64 only.

static unsigned fetch_add(unsigned *p, unsigned inc) {
    unsigned res, tmp;
    __asm__ volatile("1: ldxr %w0, %2\n\t"
                     "add %w0, %w0, %w3\n\t"
                     "stxr %w1, %w0, %2\n\t"
                     "cbnz %w1, 1b"
                     : "=&r"(res), "=&r"(tmp), "+Q"(*p)
                     : "r"(inc)
                     : "memory");
    return res; // the stored value
}

int main(void) {
    unsigned v = 30;
    unsigned n = fetch_add(&v, 5); // 35
    if (n != 35 || v != 35) {
        return 1;
    }
    n = fetch_add(&v, 7); // 42
    if (n != 42) {
        return 2;
    }
    return (int)v; // 42
}
