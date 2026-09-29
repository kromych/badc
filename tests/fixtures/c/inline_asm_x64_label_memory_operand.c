// A local label as the RIP-relative memory operand of any x86_64
// instruction: a numeric and a named label in the code stream, a numeric
// label in a pushed section before and after the reference, a displacement
// followed by an immediate, and a numeric label in each copy of a repeated
// body. With them, the label bindings they rely on: a number defined twice in
// a repeated body, and branches forward and back into pushed blocks. Each
// form is gated on __x86_64__ with a portable fallback. Returns 42 when every
// form computes the expected value.

#if defined(__x86_64__)
__attribute__((noinline)) static int code_numeric(void) {
    int r;
    __asm__("jmp 2f\n"
            "1: .long 42\n"
            "2: movl 1b(%%rip), %0"
            : "=r"(r));
    return r;
}
__attribute__((noinline)) static int code_named(void) {
    int r;
    __asm__("jmp 2f\n"
            ".Lval%=: .long 42\n"
            "2: movl .Lval%=(%%rip), %0"
            : "=r"(r));
    return r;
}
__attribute__((noinline)) static int section_before(void) {
    int r;
    __asm__(".pushsection .rodata\n"
            "1: .long 42\n"
            ".popsection\n"
            "movl 1b(%%rip), %0"
            : "=r"(r));
    return r;
}
__attribute__((noinline)) static int section_after(void) {
    int r;
    __asm__("movl 1f(%%rip), %0\n"
            ".pushsection .rodata\n"
            "1: .long 42\n"
            ".popsection"
            : "=r"(r));
    return r;
}
// The displacement is measured from the end of the instruction, past the
// immediate.
__attribute__((noinline)) static int compare(void) {
    int r;
    __asm__("jmp 2f\n"
            "1: .long 42\n"
            "2: movl $0, %0\n"
            "cmpl $42, 1b(%%rip)\n"
            "jne 3f\n"
            "movl $42, %0\n"
            "3:"
            : "=r"(r)
            :
            : "cc");
    return r;
}
__attribute__((noinline)) static int store_load(void) {
    int r;
    __asm__(".pushsection .data\n"
            "1: .long 0\n"
            ".popsection\n"
            "movl $42, 1b(%%rip)\n"
            "movl 1b(%%rip), %0"
            : "=r"(r)
            :
            : "memory");
    return r;
}
__attribute__((noinline)) static int repeated(void) {
    int r;
    __asm__("xorl %0, %0\n"
            ".rept 2\n"
            "jmp 2f\n"
            "1: .long 21\n"
            "2: addl 1b(%%rip), %0\n"
            ".endr"
            : "=&r"(r)
            :
            : "cc");
    return r;
}
// Each copy of the body binds its own two definitions.
__attribute__((noinline)) static int repeated_twice(void) {
    int r = 0;
    __asm__(".rept 3\n"
            "1: addl $14, %0\n"
            "jmp 1f\n"
            "1:\n"
            ".endr"
            : "+r"(r)
            :
            : "cc");
    return r;
}
__attribute__((noinline)) static int branch_forward(int v) {
    int r = v;
    __asm__("testl %0, %0\n"
            "jne 1f\n"
            "2: addl $40, %0\n"
            "jmp 3f\n"
            ".pushsection .text.unlikely,\"ax\"\n"
            "1: movl $2, %0\n"
            "jmp 2b\n"
            ".popsection\n"
            "3:"
            : "+r"(r)
            :
            : "cc");
    return r;
}
__attribute__((noinline)) static int branch_back(void) {
    int r = 0;
    __asm__("jmp 3f\n"
            ".pushsection .text.unlikely,\"ax\"\n"
            "1: movl $2, %0\n"
            "jmp 2f\n"
            ".popsection\n"
            "3: jmp 1b\n"
            "2: addl $40, %0"
            : "+r"(r)
            :
            : "cc");
    return r;
}
#else
static int code_numeric(void) { return 42; }
static int code_named(void) { return 42; }
static int section_before(void) { return 42; }
static int section_after(void) { return 42; }
static int compare(void) { return 42; }
static int store_load(void) { return 42; }
static int repeated(void) { return 42; }
static int repeated_twice(void) { return 42; }
static int branch_forward(int v) { return v ? 42 : 40; }
static int branch_back(void) { return 42; }
#endif

int main(void) {
    int bad = 0;
    bad += code_numeric() != 42;
    bad += code_named() != 42;
    bad += section_before() != 42;
    bad += section_after() != 42;
    bad += compare() != 42;
    bad += store_load() != 42;
    bad += repeated() != 42;
    bad += repeated_twice() != 42;
    bad += branch_forward(1) != 42;
    bad += branch_back() != 42;
    return bad ? bad : 42;
}
