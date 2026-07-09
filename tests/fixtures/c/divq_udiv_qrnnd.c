/* x86-64 unsigned 128/64 division via the `divq` inline-asm shape QEMU's
   host-utils.h `udiv_qrnnd` uses. Recognized as Intrinsic::Divq128:
   native x86-64 emits `div r/m64`; the VM computes it in 128-bit host
   arithmetic. (On non-x86-64 native targets the source gates it out.) */

static unsigned long udiv_qrnnd(unsigned long *r, unsigned long n1,
                                unsigned long n0, unsigned long d) {
    unsigned long q;
    __asm__("divq %4" : "=a"(q), "=d"(*r) : "0"(n0), "1"(n1), "rm"(d));
    return q;
}

int main(void) {
    unsigned long r;
    if (udiv_qrnnd(&r, 0, 100, 7) != 14 || r != 2) return 1;            /* 100/7 */
    if (udiv_qrnnd(&r, 0, 1000000, 1000) != 1000 || r != 0) return 2;
    if (udiv_qrnnd(&r, 1, 0, 2) != (1UL << 63) || r != 0) return 3;     /* 2^64/2 */
    if (udiv_qrnnd(&r, 1, 0, 3) != 0x5555555555555555UL || r != 1) return 4; /* 2^64/3 */
    return 0;
}
