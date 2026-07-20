/* The x86-64 asm setjmp/longjmp context-switch idiom: a `%=`-suffixed
   template-local label, its address taken with `lea LABEL(%rip), %reg`,
   callee-saved registers parked at explicit-register memory operands
   (`8(%%rdx)`), `.cfi_*` directives (accepted, no bytes), and an indirect
   `jmp *%reg` resuming at the saved label from another function.

   The deep_touch call between the save and the jump scribbles over the
   stack below the saved rsp. Everything the resumed path needs (operand
   captures, register saves) must live in the frame, not below rsp: a
   push-based scratch area is reused by the intervening calls and the
   resumed store-back would read a trashed operand address. */

typedef unsigned long long u64;

static u64 ctxbuf[10];
static int phase;

#define ctx_save(ctx, ret)                                  \
    asm("lea     LJMPRET%=(%%rip), %%rcx\n\t"               \
        "xor     %%rax, %%rax\n\t"                          \
        "mov     %%rbx, (%%rdx)\n\t"                        \
        "mov     %%rbp, 8(%%rdx)\n\t"                       \
        "mov     %%r12, 16(%%rdx)\n\t"                      \
        "mov     %%rsp, 24(%%rdx)\n\t"                      \
        "mov     %%r13, 32(%%rdx)\n\t"                      \
        "mov     %%r14, 40(%%rdx)\n\t"                      \
        "mov     %%r15, 48(%%rdx)\n\t"                      \
        "mov     %%rcx, 56(%%rdx)\n\t"                      \
        "LJMPRET%=:\n\t"                                    \
        : "=a"(ret)                                         \
        : "d"(ctx)                                          \
        : "memory", "rcx", "r8", "r9", "r10", "r11")

static void ctx_jump(u64 *ctx) {
    asm("movq   (%%rax), %%rbx\n\t"
        "movq   8(%%rax), %%rbp\n\t"
        "movq   16(%%rax), %%r12\n\t"
        "movq   24(%%rax), %%rdx\n\t"
        "movq   32(%%rax), %%r13\n\t"
        "movq   40(%%rax), %%r14\n\t"
        "mov    %%rdx, %%rsp\n\t"
        "movq   48(%%rax), %%r15\n\t"
        "movq   56(%%rax), %%rdx\n\t"
        ".cfi_def_cfa %%rdx, 0 \n\t"
        ".cfi_offset %%rbx, 0 \n\t"
        ".cfi_offset %%rbp, 8 \n\t"
        "jmp    *%%rdx\n\t"
        : : "a"(ctx) : "rdx");
}

static void deep_touch(int depth) {
    volatile char buf[256];
    for (int i = 0; i < 256; i++)
        buf[i] = (char)(depth + i);
    if (depth > 0)
        deep_touch(depth - 1);
    (void)buf[0];
}

int main(void) {
    int ret;
    ctx_save(ctxbuf, ret);
    if (ret == 0) {
        if (phase != 0)
            return 1;
        phase = 1;
        deep_touch(4);   /* reuse the stack below the saved rsp */
        ctx_jump(ctxbuf); /* never returns */
        return 2;
    }
    if (phase != 1)
        return 3;
    return 42;
}
