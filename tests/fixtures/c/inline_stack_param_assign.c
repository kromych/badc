/* C99 6.5.2.2p4: a parameter is a copy of its argument, so a body may
 * assign to it or take its address without touching the caller's
 * values. A parameter past the ABI's integer argument registers (six
 * on System V, eight on AAPCS64, four on Win64) lives in a frame cell
 * with no prologue spill; inlining such a callee must give the cell
 * caller-frame storage initialized from the call-site argument before
 * the body's assignments and re-reads run against it.
 *
 * Eleven parameters put the tail on the stack under every bank. The
 * body assigns across the register/stack boundary, modifies one
 * parameter through its taken address, reads two volatile-qualified
 * ones, and re-reads narrow types after arithmetic so the cell's width
 * conversions are exercised. The checker runs once inlined (the
 * always_inline copy collapses into main) and once out of line (the
 * noinline copy, reached through a volatile function pointer); both
 * must produce the expected value.
 *
 * Returns 42 on success; the failing check's 1-based index otherwise. */

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;

#define ALWAYS __inline__ __attribute__((always_inline))
#define NEVER __attribute__((noinline))

#define BODY                                                            \
    {                                                                   \
        e = (short)(e - b);                                             \
        f = (u8)(f + 3);                                                \
        h = (u16)(h * 2);                                               \
        i += a;                                                         \
        long long *pj = &j;                                             \
        *pj -= c;                                                       \
        j += g;                                                         \
        u32 kk = k;                                                     \
        return (long long)e + f + h + i + j + (long long)kk            \
               + (long long)d;                                          \
    }

static ALWAYS long long mash_inline(int a, int b, long long c, u32 d,
                                    short e, u8 f, volatile signed char g,
                                    u16 h, int i, long long j,
                                    volatile u32 k) BODY

static NEVER long long mash_outline(int a, int b, long long c, u32 d,
                                    short e, u8 f, volatile signed char g,
                                    u16 h, int i, long long j,
                                    volatile u32 k) BODY

static long long (*volatile via_ptr)(int, int, long long, u32, short, u8,
                                     volatile signed char, u16, int,
                                     long long, volatile u32) = mash_outline;

/* Keeps the arguments out of the constant folder so the inlined body's
 * cell traffic really runs. */
static volatile int one = 1;

int main(void) {
    int n = one;
    long long r = mash_inline(n, 2, 300, 40000u, -50, 60, -7, 800, 9,
                              100000, 3000000000u);
    if (r != 3000141314LL) return 1;
    r = via_ptr(n, 2, 300, 40000u, -50, 60, -7, 800, 9, 100000,
                3000000000u);
    if (r != 3000141314LL) return 2;
    return 42;
}
