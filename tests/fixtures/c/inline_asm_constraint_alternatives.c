// Multi-alternative operand constraints: a constraint naming several
// alternatives ("=qm", "=rm", "rm", "ri") is satisfied by the register
// alternative, in output position as well as input. The templates are
// per-ISA; the constraints are the same text on both, so the parse is
// target-independent. Returns 42 when every result is correct.

#if defined(__aarch64__)
#define ADD3(dst, a, b) __asm__("add %0, %1, %2" : dst(r) : "r"(a), "r"(b))
#define ADD_IMM(dst, a) __asm__("add %0, %1, #7" : dst(r) : "r"(a))
#else
#define ADD3(dst, a, b) __asm__("addq %2, %0" : dst(r) : "0"(a), "r"(b))
#define ADD_IMM(dst, a) __asm__("addq $7, %0" : dst(r) : "0"(a))
#endif

// "=qm": the q-class register alternative or memory. badc takes the register.
static long add_qm(long a, long b) {
    long r;
    ADD3("=qm", a, b);
    return r;
}

// "=rm": the general-register alternative or memory.
static long add_rm(long a, long b) {
    long r;
    ADD3("=rm", a, b);
    return r;
}

// A template immediate alongside a register output, so the multi-letter
// output constraints above are not the only shape exercised.
static long add_imm(long a) {
    long r;
    ADD_IMM("=r", a);
    return r;
}

// A read-write multi-alternative output.
static long accumulate(long a, long b) {
    long r = a;
#if defined(__aarch64__)
    __asm__("add %0, %0, %1" : "+rm"(r) : "r"(b));
#else
    __asm__("addq %1, %0" : "+rm"(r) : "r"(b));
#endif
    return r;
}

int main(void) {
    if (add_qm(20, 5) != 25) {
        return 1;
    }
    if (add_rm(3, 4) != 7) {
        return 2;
    }
    if (add_imm(1) != 8) {
        return 3;
    }
    if (accumulate(10, 32) != 42) {
        return 4;
    }
    return 42;
}
