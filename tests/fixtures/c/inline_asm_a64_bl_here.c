/* AArch64 location-counter branch targets with a byte offset: `bl . + 4`
 * reaches the next instruction and only records a return address (the
 * link-stack refill idiom, repeated under `.rept`), `b . + 8` skips one
 * instruction. The bare `.` form is covered by the barrier fixtures. */

static void refill_link_stack(void) {
#if defined(__aarch64__)
    unsigned long tmp;
    __asm__ volatile("mov %0, x30      \n"
                     ".rept 16         \n"
                     "bl . + 4         \n"
                     ".endr            \n"
                     "mov x30, %0      \n"
                     : "=&r"(tmp));
#endif
}

static long skip_next(long v) {
#if defined(__aarch64__)
    long out;
    __asm__ volatile("mov %0, %1       \n"
                     "b . + 8          \n"
                     "mov %0, #99      \n"
                     "add %0, %0, #1   \n"
                     : "=&r"(out)
                     : "r"(v));
    return out;
#else
    return v + 1;
#endif
}

static long call_local_label(long v) {
#if defined(__aarch64__)
    long out, lr;
    /* `bl` to a numeric local label: the callee body adds one and
     * returns to the link address, which branches over it. */
    __asm__ volatile("mov %1, x30      \n"
                     "mov %0, %2       \n"
                     "bl 1f            \n"
                     "b 2f             \n"
                     "1: add %0, %0, #1\n"
                     "ret              \n"
                     "2: mov x30, %1   \n"
                     : "=&r"(out), "=&r"(lr)
                     : "r"(v));
    return out;
#else
    return v + 1;
#endif
}

int main(void) {
    refill_link_stack();
    if (skip_next(41) != 42)
        return 1;
    if (call_local_label(20) != 21)
        return 2;
    return 42;
}
