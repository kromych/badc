/* x86-64 segment-prefixed memory operands: `%%fs:disp` (absolute under
 * the segment base) and `%%fs:disp(%%reg)`. On Linux the FS base holds
 * the thread control block, whose first quadword is the block's own
 * address (the TCB self-pointer), so `%%fs:0` read back through the
 * un-prefixed pointer must yield the same value. The %%gs forms encode
 * identically (0x65 vs 0x64) and are byte-verified in the unit tests;
 * userspace has no GS base to read at runtime. */

typedef unsigned long long u64;

int main(void) {
#if defined(__x86_64__) && defined(__linux__)
    u64 tp, self, self2;
    /* The TCB self-pointer: fs-relative 0 is the block's address. */
    asm("movq %%fs:0, %0" : "=r"(tp));
    if (tp == 0)
        return 1;
    /* Reading the block's first field through the plain pointer must
     * observe the same self-pointer. */
    asm("movq (%1), %0" : "=r"(self) : "r"(tp));
    if (self != tp)
        return 2;
    /* The based form under the prefix: fs:0(%reg) with a zero base
     * register value addresses the same field. */
    asm("movq %%fs:0(%1), %0" : "=r"(self2) : "r"(0ULL));
    if (self2 != tp)
        return 3;
#endif
    return 42;
}
