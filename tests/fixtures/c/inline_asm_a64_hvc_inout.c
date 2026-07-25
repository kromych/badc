/* AArch64 call-style trapping instructions (`hvc` / `smc`) with the
 * argument registers as register-asm operand pairs: x0..x3 carry the
 * arguments in as inputs and the results out as outputs, x4..x7 are
 * further pinned inputs, all spelled with the `rN` alias. Compile-only:
 * both instructions trap at the exception level a user process runs at.
 */

#if defined(__aarch64__)

struct quad {
    unsigned long a0, a1, a2, a3;
};

static void hvc_call(unsigned long fid, unsigned long a1, unsigned long a2,
                     unsigned long a3, unsigned long a4, unsigned long a5,
                     unsigned long a6, unsigned long a7, struct quad *res) {
    register unsigned long arg0 asm("r0") = fid;
    register unsigned long arg1 asm("r1") = a1;
    register unsigned long arg2 asm("r2") = a2;
    register unsigned long arg3 asm("r3") = a3;
    register unsigned long arg4 asm("r4") = a4;
    register unsigned long arg5 asm("r5") = a5;
    register unsigned long arg6 asm("r6") = a6;
    register unsigned long arg7 asm("r7") = a7;
    register unsigned long r0 asm("r0");
    register unsigned long r1 asm("r1");
    register unsigned long r2 asm("r2");
    register unsigned long r3 asm("r3");
    __asm__ volatile("hvc #0"
                     : "=r"(r0), "=r"(r1), "=r"(r2), "=r"(r3)
                     : "r"(arg0), "r"(arg1), "r"(arg2), "r"(arg3), "r"(arg4),
                       "r"(arg5), "r"(arg6), "r"(arg7)
                     : "memory");
    res->a0 = r0;
    res->a1 = r1;
    res->a2 = r2;
    res->a3 = r3;
}

static void smc_call(unsigned long fid, unsigned long a1, struct quad *res) {
    register unsigned long arg0 asm("r0") = fid;
    register unsigned long arg1 asm("r1") = a1;
    register unsigned long r0 asm("r0");
    register unsigned long r1 asm("r1");
    register unsigned long r2 asm("r2");
    register unsigned long r3 asm("r3");
    __asm__ volatile("smc #0"
                     : "=r"(r0), "=r"(r1), "=r"(r2), "=r"(r3)
                     : "r"(arg0), "r"(arg1)
                     : "memory");
    res->a0 = r0;
    res->a1 = r1;
    res->a2 = r2;
    res->a3 = r3;
}

int main(int argc, char **argv) {
    struct quad q;
    (void)argv;
    /* Never taken at run time; the calls must still compile and link. */
    if (argc < 0) {
        hvc_call(0x84000000UL, 1, 2, 3, 4, 5, 6, 7, &q);
        smc_call(0x84000000UL, 1, &q);
        return (int)q.a0;
    }
    return 0;
}

#else

int main(void) { return 0; }

#endif
