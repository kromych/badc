/* GNU explicit-register variables: `register T name asm("reg")`.
   Reading the stack / frame pointer is the pervasive use. The
   interpreter returns a per-frame proxy for both, so the assertions
   stay within what both execution models guarantee: non-zero values,
   stable within a frame, frame pointer not below the stack pointer. */
static unsigned long read_sp(void) {
#if defined(__x86_64__)
    register unsigned long sp asm("rsp");
#else
    register unsigned long sp asm("sp");
#endif
    return sp;
}

static unsigned long read_fp(void) {
#if defined(__x86_64__)
    register unsigned long fp asm("rbp");
#else
    register unsigned long fp asm("x29");
#endif
    return fp;
}

int main(void) {
    unsigned long sp1 = read_sp();
    unsigned long sp2 = read_sp();
    unsigned long fp = read_fp();
    if (sp1 == 0 || fp == 0) {
        return 1;
    }
    if (sp1 != sp2) {
        return 2;
    }
    if (fp < sp1) {
        return 3;
    }
    return 0;
}
