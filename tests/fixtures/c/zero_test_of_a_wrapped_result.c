// A zero test of an arithmetic result whose 32-bit value is zero while the
// 64-bit register computing it is not. The compare reads the low word; the
// branch must not test the whole register in its place. Signed operands
// wrap here as at -O0 (badc defines signed overflow as wrapping); unsigned
// ones wrap by C99 6.2.5p9. Each callee is reached through a volatile
// pointer so its operands are unknown to the optimizer.

#include <limits.h>

#define NOINLINE __attribute__((noinline))

NOINLINE static int add_nz(int a, int b) {
    if ((a + b) != 0) return 1;
    return 0;
}
NOINLINE static int sub_z(int a, int b) {
    if ((a - b) == 0) return 1;
    return 0;
}
NOINLINE static int mul_nz(int a, int b) {
    if (a * b) return 1;
    return 0;
}
NOINLINE static int uadd_nz(unsigned a, unsigned b) {
    if ((a + b) != 0) return 1;
    return 0;
}
NOINLINE static int umul_z(unsigned a, unsigned b) {
    if (!(a * b)) return 1;
    return 0;
}
NOINLINE static int neg_nz(int a) {
    if (-a != 0) return 1;
    return 0;
}

int main(void) {
    int (*volatile add)(int, int) = add_nz;
    int (*volatile sub)(int, int) = sub_z;
    int (*volatile mul)(int, int) = mul_nz;
    int (*volatile uadd)(unsigned, unsigned) = uadd_nz;
    int (*volatile umul)(unsigned, unsigned) = umul_z;
    int (*volatile neg)(int) = neg_nz;

    if (add(INT_MIN, INT_MIN) != 0) return 1;
    if (add(INT_MAX, 1) != 1 || add(3, -3) != 0 || add(1, 2) != 1) return 2;
    if (sub(INT_MIN, INT_MIN) != 1 || sub(INT_MIN, INT_MAX) != 0) return 3;
    if (sub(0, INT_MIN) != 0) return 4;
    if (mul(65536, 65536) != 0 || mul(3, 5) != 1 || mul(0, 7) != 0) return 5;
    if (uadd(0x80000000u, 0x80000000u) != 0 || uadd(1u, 0xffffffffu) != 0) return 6;
    if (uadd(1u, 2u) != 1) return 7;
    if (umul(65536u, 65536u) != 1 || umul(3u, 5u) != 0) return 8;
    if (neg(0) != 0 || neg(INT_MIN) != 1 || neg(5) != 1) return 9;
    return 0;
}
