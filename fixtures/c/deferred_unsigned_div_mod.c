// DEFERRED: unsigned division / modulo use signed ops.
//
// `Op::Div` and `Op::Mod` lower to ARM64 `SDIV` / x86_64 `IDIV`
// (signed-int division). For `unsigned int / unsigned int` where
// the dividend has the high bit set, the value is interpreted as
// negative under signed division and the quotient comes out
// wrong (or signal-divides on overflow).
//
// Same as the right-shift gap: storing into an `unsigned int`
// slot doesn't help -- the division happens in a register before
// the store, and the operand interpretations are signed there.
//
// Fix is to add `Op::Divu` / `Op::Modu` (UDIV on ARM64, DIV on
// x86_64) and route to them when either operand is unsigned.
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
