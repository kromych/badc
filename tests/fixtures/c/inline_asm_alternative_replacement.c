/* GNU-as ALTERNATIVE / callee-save inline-asm section forms on x86-64.
 *
 *  - A callee-save wrapper whose label is written with no whitespace before
 *    the first instruction (`name:push %rcx`) and is followed by a
 *    multi-instruction push/call/pop/ret body in a named executable section.
 *    GNU as terminates the label at the colon; the body is a sequence of
 *    instructions, not one, and the wrapper preserves the pushed registers
 *    across the forwarded call.
 *
 *  - A memory-constraint (`m`) operand used as the source of a `lea` inside an
 *    ALTERNATIVE replacement section: `%N` is the operand's address, lowered
 *    to the register-indirect form the code stream uses.
 *
 * The wrapper is executed; the replacement section is assembled to bytes at
 * compile time. Non-x86 targets compile the body out and return the same
 * value. */

#if defined(__x86_64__) && defined(__linux__)

int cs_inner(int x);

/* Three saved registers keep the stack 16-byte aligned at the inner call; the
 * argument stays in %rdi and is forwarded untouched. */
__asm__(".pushsection .spinlock.text, \"ax\"\n"
        ".globl cs_wrapper\n"
        ".type cs_wrapper, @function\n"
        "cs_wrapper:push %rcx;"
        "push %rdx;"
        "push %rsi;"
        "call cs_inner;"
        "pop %rsi;"
        "pop %rdx;"
        "pop %rcx;"
        "ret\n"
        ".size cs_wrapper, .-cs_wrapper\n"
        ".popsection");

int cs_inner(int x) {
    return x + 5;
}
int cs_wrapper(int x);

static int alt_selftest_data;

/* The address of an `m` operand as a `lea` source inside a replacement. */
static void alt_replacement_lea(void) {
    __asm__ __volatile__(".pushsection .altinstr_replacement, \"ax\"\n"
                         "lea %[mem], %%rdi\n"
                         ".popsection\n"
                         :
                         : [mem] "m"(alt_selftest_data)
                         : "rdi");
}

#endif

int main(void) {
#if defined(__x86_64__) && defined(__linux__)
    alt_replacement_lea();
    if (cs_wrapper(37) != 42)
        return 1;
#endif
    return 42;
}
