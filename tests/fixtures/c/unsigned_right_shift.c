// DEFERRED: unsigned right shift uses signed semantics.
//
// `Op::Shr` is the only right-shift op the dialect emits, and it
// lowers to ARM64 `ASR` / x86_64 `SAR` -- arithmetic
// (sign-extending) shift. For an `unsigned int x` with the high
// bit set, `x >> 1` in C should fill the high bit with 0 (logical
// shift), but the dialect fills with the sign bit.
//
// Compounded: even storing into an `unsigned int` slot doesn't
// help here, because the shift happens in a register before the
// store, and the high half already carries the sign-extended
// bits.
//
// Fix is to add `Op::Shru` (or have the compiler pre-mask the
// shifted value when the operand is unsigned).
#include <stdio.h>

int main() {
    // 0x80000000 >> 1: logical shift produces 0x40000000;
    // arithmetic shift produces 0xC0000000 (the sign bit
    // propagates into the low half from the sign-extended
    // i64).
    unsigned int x = 0x80000000;
    unsigned int y = x >> 1;
    if (y != 0x40000000) return 1;

    // Same story for u64.
    unsigned long ux = 0x8000000000000000ul;
    unsigned long uy = ux >> 1;
    if (uy != 0x4000000000000000ul) return 2;

    return 0;
}
