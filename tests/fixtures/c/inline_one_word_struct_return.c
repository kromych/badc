/* A helper returning a one-word struct by value inlines: its result-slot
   writes redirect to the caller's return slot, and a paired read helper
   inlines its field load. The accumulated sum over a loop (a phi-bearing
   caller) must match the off-line value. */
typedef union { unsigned long bits; } SR;

static SR mk(unsigned long v) { return (SR){.bits = v}; }
static unsigned long get(SR r) { return r.bits; }

int main(void) {
    unsigned long s = 0;
    for (int i = 0; i < 5; i++) {
        SR r = mk((unsigned long)(i + 1) * 10);
        s += get(r);
    }
    return s == 150 ? 0 : 1;
}
