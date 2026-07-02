/* CAS/RMW operands allocated in the borrowed working registers
   (x9..x12 on aarch64) must be read from the save area, not from the
   registers an earlier operand move already overwrote. */
#include <stdatomic.h>

long f(long a0, long a1, long a2, long a3, long a4, long a5, long a6, long a7) {
    static _Atomic long l = 9;
    long want = 100;
    int c = atomic_compare_exchange_strong(&l, &want, 5);
    long r = atomic_fetch_add(&l, a0 + a1);
    /* c must be 0, want must be 9 (observed), l must be 9+3=12, r old=9 */
    if (c != 0) return 1;
    if (want != 9) return 2;
    if (r != 9) return 3;
    if (atomic_load(&l) != 9 + a0 + a1) return 4;
    return a0 + a1 + a2 + a3 + a4 + a5 + a6 + a7; /* keep 8 values live */
}

int main(void) {
    long r = f(1, 2, 3, 4, 5, 6, 7, 8);
    return r == 36 ? 0 : (int)r;
}
