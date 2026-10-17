// An automatic object aligned above 16 shares its function with an asm
// statement that only reads the stack pointer and one that writes every
// callee-saved general register (C11 6.7.5): sp never moves, so the
// realigned frame needs no base register and the clobbers leave it
// none. The read reaches the second function through an inline function.
// The exit code names the failing shape.

#include <stdint.h>
#include <string.h>

#define NOINLINE __attribute__((noinline))

#if defined(__x86_64__)
#define READ_SP(v) __asm__ volatile("mov %%rsp, %0" : "=r"(v))
#define WRITE_CALLEE_SAVED()                                                                      \
    __asm__ volatile("xor %%ebx, %%ebx\n\txor %%r12d, %%r12d\n\txor %%r13d, %%r13d\n\t"           \
                     "xor %%r14d, %%r14d\n\txor %%r15d, %%r15d" ::: "rbx", "r12", "r13", "r14", \
                     "r15", "memory")
#else
#define READ_SP(v) __asm__ volatile("mov %0, sp" : "=r"(v))
#define WRITE_CALLEE_SAVED()                                                                      \
    __asm__ volatile("mov x19, xzr\n\tmov x20, xzr\n\tmov x21, xzr\n\tmov x22, xzr\n\t"           \
                     "mov x23, xzr\n\tmov x24, xzr\n\tmov x25, xzr\n\tmov x26, xzr\n\t"           \
                     "mov x27, xzr\n\tmov x28, xzr" ::: "x19", "x20", "x21", "x22", "x23", "x24", \
                     "x25", "x26", "x27", "x28", "memory")
#endif

static volatile int sink;

NOINLINE static void touch(char *p, int n)
{
    p[0] = (char)n;
    sink += n;
}

// The object sits above sp in the frame the read was taken in or in a caller's.
static int check(const char *line, uintptr_t sp)
{
    uintptr_t at = (uintptr_t)line;
    return (at % 64 != 0) | (line[63] != 3) << 1 | (at < sp || at - sp > 4096) << 2;
}

NOINLINE static int reads_sp(int n)
{
    _Alignas(64) char line[64];
    memset(line, 3, sizeof line);
    uintptr_t sp;
    READ_SP(sp);
    WRITE_CALLEE_SAVED();
    touch(line, n);
    return check(line, sp);
}

static inline uintptr_t current_sp(void)
{
    uintptr_t v;
    READ_SP(v);
    return v;
}

NOINLINE static int reads_sp_inlined(int n)
{
    _Alignas(64) char line[64];
    memset(line, 3, sizeof line);
    WRITE_CALLEE_SAVED();
    uintptr_t sp = current_sp();
    touch(line, n);
    return check(line, sp);
}

int main(void)
{
    if (reads_sp(10))
        return 1;
    if (reads_sp_inlined(10))
        return 2;
    return 0;
}
