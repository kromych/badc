// Unsigned division / modulo.
//
// C99 6.5.5: when either operand of `/` or `%` is unsigned, both
// operands convert to the unsigned common type and the operation
// is unsigned. Closed by `Op::Divu` / `Op::Modu` (UDIV on ARM64,
// `DIV` with `xor edx, edx` on x86_64), routed when the C99
// common type is unsigned.
#include <stdio.h>

int main() {
    // 0xFFFFFFFE / 2: as unsigned 4294967294 / 2 = 2147483647.
    // As signed: -2 / 2 = -1 = 0xFFFFFFFF.
    unsigned int big = 0xFFFFFFFE;
    unsigned int two = 2;
    unsigned int q = big / two;
    if (q != 2147483647u) return 1;

    // 0xFFFFFFFF % 7: as unsigned 4294967295 % 7 = 3. As signed:
    // -1 % 7 = -1 = 0xFFFFFFFF.
    unsigned int all = 0xFFFFFFFF;
    unsigned int seven = 7;
    unsigned int r = all % seven;
    if (r != 3) return 2;

    // 64-bit unsigned: same shape, larger magnitude.
    unsigned long lbig = 0xFFFFFFFFFFFFFFFEul;
    unsigned long ltwo = 2;
    unsigned long lq = lbig / ltwo;
    if (lq != 0x7FFFFFFFFFFFFFFFul) return 3;

    return 0;
}
