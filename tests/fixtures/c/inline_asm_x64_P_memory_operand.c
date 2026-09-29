// The x86_64 `%P` operand modifier on a memory (`m`) operand prints the
// memory reference, as gcc and clang print it. Linux 6.1 and 6.6 spell
// `prefetchw %P1`, `clflush %P0` and `xchgl %0, %P1` over `m` operands
// whose address is in a register; a member at an offset and a file-scope
// object are the other two shapes. The file-scope one is RIP-relative, as
// clang prints it; gcc prints the bare address, which a PIE cannot link.
// Each form is gated on __x86_64__ with a portable fallback. Returns 42
// when every form computes the expected value.

struct rec {
    int a;
    long b[4];
};
static struct rec file_rec = {1, {10, 20, 30, 40}};

#if defined(__x86_64__)
static unsigned swap_in(unsigned *slot, unsigned v) {
    __asm__ volatile("xchgl %0, %P1" : "+r"(v), "+m"(*slot));
    return v;
}
static void touch(const void *p) {
    __asm__ volatile("prefetchw %P0" : : "m"(*(const char *)p));
}
static void flush(volatile void *p) {
    __asm__ volatile("clflush %P0" : "+m"(*(volatile char *)p));
}
static long load_member(struct rec *r) {
    long v;
    __asm__ volatile("movq %P1, %0" : "=r"(v) : "m"(r->b[2]));
    return v;
}
static long load_file(void) {
    long v;
    __asm__ volatile("movq %P1, %0" : "=r"(v) : "m"(file_rec.b[1]));
    return v;
}
#else
static unsigned swap_in(unsigned *slot, unsigned v) {
    unsigned old = *slot;
    *slot = v;
    return old;
}
static void touch(const void *p) { (void)p; }
static void flush(volatile void *p) { (void)p; }
static long load_member(struct rec *r) { return r->b[2]; }
static long load_file(void) { return file_rec.b[1]; }
#endif

int main(void) {
    unsigned slot = 5;
    if (swap_in(&slot, 7) != 5 || slot != 7)
        return 1;
    char buf[64] = {3};
    touch(buf);
    flush(buf);
    if (buf[0] != 3)
        return 2;
    struct rec r = {2, {11, 22, 33, 44}};
    if (load_member(&r) != 33)
        return 3;
    if (load_file() != 20)
        return 4;
    return 42;
}
