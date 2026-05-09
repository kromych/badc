// DEFERRED: unsigned arithmetic propagation through registers.
//
// `unsigned int v = ~u;` and the like don't mask intermediate
// values to the slot's bit width. The store-and-reload through a
// typed lvalue does mask correctly (`Op::Sw` writes 4 bytes,
// `Op::Lwu` zero-extends back), but a bare register-resident
// rvalue carries the upper half from a prior signed op.
//
// What works today (round-trip through u32 storage):
//
//     unsigned int u = 0xFF00FF00;
//     unsigned int v = ~u;            // -> 0x00FF00FF after Sw/Lwu
//     if (v == 0x00FF00FF) ...        // OK
//
// What this fixture pins as broken:
//
//     unsigned int u = 0xFF00FF00;
//     if ((~u) == 0x00FF00FF) ...     // FAILS: register-resident
//                                     // ~u is 0xFFFFFFFF00FF00FF
//                                     // (i64), so the compare
//                                     // disagrees.
//
// The fixture exits 0 only when the register-resident comparison
// yields the right answer (i.e. when the bug is fixed).
#include <stdio.h>

int main() {
    unsigned int u = 0xFF00FF00;

    // Register-resident `~u` compared against a positive 32-bit
    // literal. Should be 0x00FF00FF == 0x00FF00FF -> true.
    if ((~u) != 0x00FF00FF) return 1;

    // Same pattern with shift: `u << 4` should yield 0x23456780
    // when u = 0x12345678.
    unsigned int w = 0x12345678;
    if ((w << 4) != 0x23456780) return 2;

    // Subtraction wrap: `1u - 2u` should be 0xFFFFFFFF.
    unsigned int one = 1;
    unsigned int two = 2;
    if ((one - two) != 0xFFFFFFFF) return 3;

    return 0;
}
