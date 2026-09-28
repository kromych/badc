// An object's address held in a local is tested twice after two calls:
// inlined `m ? a : b` helpers branch on it, and the second test's true arm
// is an empty edge block that carries the address to a phi. Setting the
// address again past the calls put the new definition into that edge
// block, after the branch that reads it, so the branch tested a register
// the address had not reached. The caller keeps zeros live across the
// call in callee-saved registers, which such a read picks up. Returns 0
// when every check passes.

#include <stddef.h>

struct mask {
    unsigned long bits[2];
};

static inline __attribute__((always_inline)) unsigned num(const struct mask *m)
{
    return m ? 64 : 0;
}

static inline __attribute__((always_inline)) const unsigned long *bits_of(const struct mask *m)
{
    return m ? m->bits : NULL;
}

static int calls;
static volatile long zeros[8];

__attribute__((noinline)) static int movable(const struct mask *m)
{
    calls++;
    return m->bits[0] == 0;
}

__attribute__((noinline)) static void enable(void)
{
    calls++;
}

__attribute__((noinline)) static int report(unsigned n, const unsigned long *b)
{
    return n == 64 && b != NULL && *b == 0 ? 0 : 1;
}

__attribute__((noinline)) static int check(void)
{
    static struct mask new_mems;
    const struct mask *m = &new_mems;
    if (movable(m)) {
        enable();
        return report(num(m), bits_of(m));
    }
    return 2;
}

int main(void)
{
    long z0 = zeros[0], z1 = zeros[1], z2 = zeros[2], z3 = zeros[3];
    long z4 = zeros[4], z5 = zeros[5], z6 = zeros[6], z7 = zeros[7];
    int r = check();
    return r + (int)(z0 + z1 + z2 + z3 + z4 + z5 + z6 + z7) + (calls == 2 ? 0 : 4);
}
