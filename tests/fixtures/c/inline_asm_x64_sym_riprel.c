/* x86-64 function-body RIP-relative references whose displacement is a
 * link-time symbol plus a constant, optionally parenthesized and
 * segment-prefixed. The segment-relative bodies are compiled but not
 * executed; the plain forms read real data. */

long counter[2] = {42, 7};

volatile int run_seg;

static long read_first(void) {
    long v;
    __asm__("movq counter(%%rip), %0" : "=r"(v));
    return v;
}

static long read_second(void) {
    long v;
    __asm__("movq (counter + 8)(%%rip), %0" : "=r"(v));
    return v;
}

static long seg_read(void) {
    long v;
    __asm__("movq %%gs:counter(%%rip), %0" : "=r"(v));
    __asm__ volatile("incq %%gs:(counter + 8)(%%rip)" : : : "memory", "cc");
    return v;
}

int main(void) {
    if (run_seg && seg_read() != 0)
        return 1;
    if (read_first() != 42)
        return 2;
    if (read_second() != 7)
        return 3;
    return 42;
}
