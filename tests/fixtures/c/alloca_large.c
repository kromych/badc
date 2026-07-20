/* alloca(1 MiB): the allocation moves the stack pointer rather than
   drawing from any fixed per-frame reservation. Both ends of the block
   are written and read back, and every page is touched so demand-commit
   stacks (Windows guard pages) are exercised too. Returns 42. */
#include <alloca.h>

int main(void) {
    long n = 1L << 20;
    char *p = (char *)alloca(n);
    p[0] = 1;
    p[n - 1] = 2;
    for (long i = 4096; i < n - 1; i += 4096) {
        p[i] = 3;
    }
    return p[0] + p[n - 1] == 3 ? 42 : 1;
}
