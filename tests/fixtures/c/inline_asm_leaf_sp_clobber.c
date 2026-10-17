// Full leaves whose asm lists sp as clobbered and leaves it lower, on x86-64
// without naming it; GNU C requires an asm statement to leave sp as it found
// it, and badc gives such a leaf a frame its return restores sp from. Exits 0
// when both leaves return with the caller's values intact.

#if defined(__x86_64__)
__attribute__((noinline)) static void leaf_push(void) { __asm__ volatile("pushq $0x77" ::: "rsp"); }
__attribute__((noinline)) static long leaf_val(long a) {
    __asm__ volatile("pushq $0x77\n\tpushq $0x78" ::: "rsp");
    return a + 1;
}
#elif defined(__aarch64__)
__attribute__((noinline)) static void leaf_push(void) { __asm__ volatile("sub sp, sp, #16" ::: "sp"); }
__attribute__((noinline)) static long leaf_val(long a) {
    __asm__ volatile("sub sp, sp, #32" ::: "sp");
    return a + 1;
}
#endif

static volatile long input = 41;

int main(void) {
    long keep = input * 3;
    leaf_push();
    long r = leaf_val(input);
    if (r != 42)
        return 1;
    if (keep != 123)
        return 2;
    return 0;
}
