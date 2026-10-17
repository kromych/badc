// An automatic object aligned above 16 shares its function with `alloca` or
// a variable-length array and with asm statements that write callee-saved
// registers (C11 6.7.5, C99 6.7.6.2). sp moves, so the realigned frame is
// addressed through a callee-saved register; a statement that writes that
// register saves and restores it, and one that names it as an operand
// keeps it out of the choice. The clobbers name every candidate, by its
// own name or (x86-64) by a byte register of it, and one such statement
// stores its output into an over-aligned object. The exit code names the
// failing shape.

#include <stdint.h>
#include <string.h>

#define NOINLINE __attribute__((noinline))

#if defined(__x86_64__)
#define ZERO_ALL                                                                         \
    "xor %%ebx, %%ebx\n\txor %%r12d, %%r12d\n\txor %%r13d, %%r13d\n\txor %%r14d, %%r14d\n\t" \
    "xor %%r15d, %%r15d\n\t"
#define CANDIDATES "rbx", "r12", "r13", "r14", "r15"
#define SET_77 "mov $77, %0"
#define ZERO_REST \
    "xor %%r12d, %%r12d\n\txor %%r13d, %%r13d\n\txor %%r14d, %%r14d\n\txor %%r15d, %%r15d"
#else
// x19 is left alone: clang's base pointer, which it does not save around a
// statement that writes it.
#define ZERO_ALL                                                                         \
    "mov x20, xzr\n\tmov x21, xzr\n\tmov x22, xzr\n\tmov x23, xzr\n\tmov x24, xzr\n\t"   \
    "mov x25, xzr\n\tmov x26, xzr\n\tmov x27, xzr\n\tmov x28, xzr\n\t"
#define CANDIDATES "x20", "x21", "x22", "x23", "x24", "x25", "x26", "x27", "x28"
#define SET_77 "mov %0, #77"
#endif

static volatile int sink;

NOINLINE static void touch(void *p, int n)
{
    ((char *)p)[0] = (char)n;
    sink += n;
}

NOINLINE static int beside_vla(int n)
{
    _Alignas(64) char line[64];
    memset(line, 3, sizeof line);
    char v[n];
    memset(v, 4, n);
    touch(v, n);
    __asm__ volatile(ZERO_ALL ::: CANDIDATES, "memory");
    touch(line, 1);
    return ((uintptr_t)line % 64 != 0) | (line[63] != 3) << 1 | (v[n - 1] != 4) << 2;
}

NOINLINE static int output_after_the_writes(int n)
{
    _Alignas(64) long long word = 5;
    _Alignas(128) long long cell[4] = {1, 2, 3, 4};
    char *p = __builtin_alloca(n);
    memset(p, 6, n);
    touch(p, n);
    __asm__ volatile(ZERO_ALL SET_77 : "=r"(word)::CANDIDATES);
    __asm__ volatile(ZERO_ALL SET_77 : "=r"(cell[2])::CANDIDATES);
    int bad = ((uintptr_t)&word % 64 != 0) | ((uintptr_t)cell % 128 != 0) << 1;
    return bad | (word != 77) << 2 | (cell[2] != 77 || cell[3] != 4) << 3 | (p[n - 1] != 6) << 4;
}

#if defined(__x86_64__)
NOINLINE static int byte_register_clobber(int n)
{
    _Alignas(64) char line[64];
    memset(line, 3, sizeof line);
    char *p = __builtin_alloca(n);
    memset(p, 4, n);
    touch(p, n);
    __asm__ volatile("movb $1, %%bh" ::: "bh");
    touch(line, 3);
    return ((uintptr_t)line % 64 != 0) | (line[63] != 3) << 1 | (p[n - 1] != 4) << 2;
}

NOINLINE static int byte_register_among_all(int n)
{
    _Alignas(64) char line[64];
    memset(line, 3, sizeof line);
    char *p = __builtin_alloca(n);
    memset(p, 4, n);
    touch(p, n);
    __asm__ volatile("movb $1, %%bh\n\t" ZERO_REST ::: "bh", "r12", "r13", "r14", "r15");
    touch(line, 3);
    return ((uintptr_t)line % 64 != 0) | (line[63] != 3) << 1 | (p[n - 1] != 4) << 2;
}

NOINLINE static int operand_names_a_candidate(int n)
{
    _Alignas(64) char line[64];
    memset(line, 3, sizeof line);
    char *p = __builtin_alloca(n);
    memset(p, 4, n);
    touch(p, n);
    long long acc = n;
    __asm__ volatile("add %1, %0" : "+b"(acc) : "r"((long long)line[63]));
    __asm__ volatile(ZERO_REST ::: "r12", "r13", "r14", "r15", "memory");
    touch(line, 3);
    return ((uintptr_t)line % 64 != 0) | (line[63] != 3) << 1 | (acc != n + 3) << 2;
}
#endif

int main(void)
{
    if (beside_vla(10))
        return 1;
    if (output_after_the_writes(10))
        return 2;
#if defined(__x86_64__)
    if (byte_register_clobber(10))
        return 3;
    if (byte_register_among_all(10))
        return 4;
    if (operand_names_a_candidate(10))
        return 5;
#endif
    return 0;
}
