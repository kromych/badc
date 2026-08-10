// AArch64 inline asm: the `Q` memory constraint, whose address is a single
// base register with no offset and whose `%N` substitutes as `[xN]` -- the
// addressing mode ldar / stlr require. main returns 42 only when the
// acquire load observes each release store. Native aarch64 only.

static long load_acquire(long *p) {
    long v;
    __asm__ volatile("ldar %0, %1" : "=r"(v) : "Q"(*p) : "memory");
    return v;
}

static void store_release(long *p, long v) {
    __asm__ volatile("stlr %1, %0" : "=Q"(*p) : "r"(v) : "memory");
}

int main(void) {
    long cell = 7;
    store_release(&cell, 40);
    long a = load_acquire(&cell); // 40
    if (a != 40 || cell != 40) {
        return 1;
    }
    store_release(&cell, a + 2);
    if (cell != 42) {
        return 2;
    }
    return (int)load_acquire(&cell); // 42
}
