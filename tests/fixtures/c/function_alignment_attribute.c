// GNU `aligned(N)` on a function sets the minimum alignment of its code:
// the entry address is a multiple of N, from a declaration or the
// definition, the largest request across them winning. Returns 0.
typedef __UINTPTR_TYPE__ uintptr_t;

int first(void) { return 2; }
__attribute__((aligned(64))) int f64(void) { return 1; }
__attribute__((aligned(128))) static int s128(int x) { return x + 1; }
int h(void) __attribute__((aligned(32)));
__attribute__((aligned(16))) int h(void) { return 3; }

int main(void) {
    int (*volatile p)(int) = s128;
    int (*volatile q)(void) = f64;
    int (*volatile r)(void) = h;
    if ((uintptr_t)q % 64 || (uintptr_t)p % 128 || (uintptr_t)r % 32)
        return 1;
    return p(1) + q() + r() + first() == 8 ? 0 : 2;
}
