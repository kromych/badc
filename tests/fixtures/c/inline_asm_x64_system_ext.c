// x86-64 system / privileged, x87, and wide inline-asm encodings: PCID / VPID
// and guest-page TLB invalidation, 128-bit compare-exchange, x87 double load
// and store, MXCSR load / store, far indirect jump, and FS/GS segment stack
// ops. Each form is mode- or privilege-restricted (a far jump, a TLB flush),
// so this fixture is compile-checked for native x86-64 and not run; the exact
// byte encodings are locked in the x86-64 asm unit tests.

struct desc128 {
    unsigned long lo, hi;
};
struct farptr {
    unsigned int off;
    unsigned short seg;
};

static void invalidate_pcid(unsigned long type, struct desc128 *desc) {
    __asm__ volatile("invpcid %[d], %[t]" ::[d] "m"(*desc), [t] "r"(type) : "memory");
}

static void invalidate_vpid(unsigned long ext, struct desc128 *desc) {
    __asm__ volatile("invvpid %[d], %[e]" ::[d] "m"(*desc), [e] "r"(ext) : "memory");
}

static void invalidate_ept(unsigned long ext, struct desc128 *desc) {
    __asm__ volatile("invept %[d], %[e]" ::[d] "m"(*desc), [e] "r"(ext) : "memory");
}

static void x87_div_check(const double *p, int *out) {
    // The FDIV-bug probe sequence, plus fnclex and the extending moves.
    __asm__ volatile("fnclex\n\t"
                     "fldl %1\n\t"
                     "fdivl %1\n\t"
                     "fmull %1\n\t"
                     "fldl %1\n\t"
                     "fsubp %%st,%%st(1)\n\t"
                     "fistpl %0\n\t"
                     "fwait\n\t"
                     "fninit"
                     : "=m"(*out)
                     : "m"(*p));
}

static unsigned long extend_moves(const unsigned char *p, unsigned long i) {
    unsigned long r;
    __asm__("movzbl (%1,%2), %k0\n\t"
            "movsbq (%1), %0\n\t"
            "movzwl 2(%1), %k0\n\t"
            "movslq %k0, %0"
            : "=&r"(r)
            : "r"(p), "r"(i));
    return r;
}

static void invalidate_guest_page(unsigned long addr, unsigned int asid) {
    // rAX carries the address and ECX the ASID; the template spells those
    // implicit operands, which carry no encoding of their own.
    __asm__ volatile("invlpga %1, %0" ::"c"(asid), "a"(addr) : "memory");
}

static void cmpxchg_128(struct desc128 *p) {
    __asm__ volatile("lock cmpxchg16b %0"
                     : "+m"(*p)
                     : "a"(0UL), "d"(0UL), "b"(0UL), "c"(0UL)
                     : "memory");
}

static void load_x87_double(const double *p) {
    __asm__ volatile("fldl %0" ::"m"(*p));
}

static void store_x87_double(double *p) {
    __asm__ volatile("fstpl %0" : "=m"(*p));
}

static void load_mxcsr(const unsigned int *p) {
    __asm__ volatile("ldmxcsr %0" ::"m"(*p));
}

static void store_mxcsr(unsigned int *p) {
    __asm__ volatile("stmxcsr %0" : "=m"(*p));
}

static void far_jump(const struct farptr *p) {
    __asm__ volatile("ljmpl *%0" ::"m"(*p));
}

static void push_pop_segment(void) {
    // ES/CS/SS/DS segment push / pop have no 64-bit encoding; only FS/GS do.
    __asm__ volatile("pushw %%fs\n\tpushw %%gs\n\tpopw %%gs\n\tpopw %%fs");
}

int main(int argc, char **argv) {
    (void)argv;
    // The instructions are privilege- or mode-restricted; reference each so it
    // is compiled without executing any at run time.
    if (argc < 0) {
        struct desc128 d = {0, 0};
        struct farptr fp = {0, 0};
        double dv = 0;
        unsigned int m = 0;
        invalidate_pcid(0, &d);
        invalidate_vpid(0, &d);
        int fdiv_out = 0;
        unsigned char bytes[4] = {1, 2, 3, 4};
        invalidate_ept(0, &d);
        x87_div_check(&dv, &fdiv_out);
        (void)extend_moves(bytes, 1);
        invalidate_guest_page(0, 0);
        cmpxchg_128(&d);
        load_x87_double(&dv);
        store_x87_double(&dv);
        load_mxcsr(&m);
        store_mxcsr(&m);
        far_jump(&fp);
        push_pop_segment();
    }
    return 42;
}
