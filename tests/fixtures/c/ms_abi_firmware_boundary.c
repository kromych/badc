/* `__attribute__((ms_abi))` -- the Linux kernel's `__efiapi` -- only
 * shows up where this code meets code built for the Microsoft x64
 * calling convention: UEFI firmware enters the x86_64 EFI stub through
 * it, with the image handle in rcx and the system table in rdx. A
 * program compiled end to end by one compiler agrees with itself
 * whatever convention it picks, so the boundary is what has to be
 * checked. The asm below is the foreign caller: it loads the argument
 * registers the way firmware does, reserves the 32 bytes of shadow
 * space the convention requires, and reads back the registers the
 * callee owes it.
 *
 * x86_64 only; elsewhere the attribute is inert (gcc ignores it) and
 * the plain call stands in.
 */

#define MS __attribute__((ms_abi))

/* `volatile` keeps each step a runtime value, so the body really holds
 * several values at once and the register allocator has to reach past
 * the callee-saved bank. */
static long step(long v) {
    volatile long t = v;
    return t;
}

long MS probe(long a, long b, long c, long d);

long MS probe(long a, long b, long c, long d) {
    long p = step(a);
    long q = step(b);
    long r = step(c);
    long s = step(d);
    long t = step(a + d);
    long u = step(b + c);
    return p * 1000 + q * 100 + r * 10 + s + (t - u) * 0;
}

static long result;
static long rsi_after;
static long rdi_after;

static void call_like_firmware(long (MS *fn)(long, long, long, long)) {
#if defined(__x86_64__)
    /* r15 holds the entry stack pointer: it is callee-saved under both
     * conventions, so the callee gives it back and the restore is safe.
     * `and $-16` then `sub $160` leaves rsp 16-aligned at the call (the
     * convention's requirement) and skips the 128-byte System V red
     * zone on top of the 32-byte shadow space. */
    __asm__ volatile(
        "movq %%rsp, %%r15\n\t"
        "andq $-16, %%rsp\n\t"
        "subq $160, %%rsp\n\t"
        "movq $1, %%rcx\n\t"
        "movq $2, %%rdx\n\t"
        "movq $3, %%r8\n\t"
        "movq $4, %%r9\n\t"
        "movq $4369, %%rsi\n\t"
        "movq $8738, %%rdi\n\t"
        "call *%%rbx\n\t"
        "movq %%r15, %%rsp\n\t"
        "movq %%rax, %[res]\n\t"
        "movq %%rsi, %[si]\n\t"
        "movq %%rdi, %[di]\n\t"
        : [res] "=m"(result), [si] "=m"(rsi_after), [di] "=m"(rdi_after)
        : "b"(fn)
        : "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10", "r11", "r15",
          "memory", "cc");
#else
    result = fn(1, 2, 3, 4);
    rsi_after = 4369;
    rdi_after = 8738;
#endif
}

int main(void) {
    call_like_firmware(probe);
    /* The argument window: 1 in rcx, 2 in rdx, 3 in r8, 4 in r9. Read
     * through the System V window instead, the callee would see whatever
     * the asm left in rdi/rsi. */
    if (result != 1234) {
        return 1;
    }
    /* rsi and rdi are callee-saved under this convention, volatile under
     * System V. */
    if (rsi_after != 4369) {
        return 2;
    }
    if (rdi_after != 8738) {
        return 3;
    }
    return 0;
}
