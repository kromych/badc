// Unsigned arithmetic propagation through registers.
//
// C99 6.5 says unsigned integer ops produce a result at the type's
// storage width with wrap modulo 2^N. c5 keeps every value in a
// 64-bit accumulator, so for unsigned narrow types it has to mask
// after `~`, `<<`, `+`/`-`/`*` (when the C99 common type is
// unsigned narrow) to discard bits beyond the type's width --
// otherwise an immediate register-resident comparison observes the
// sign-extended / shifted-out high half.
//
// Closed by the post-op mask added to:
//   * `~` and `<<` for unsigned size-4 operands.
//   * `+` / `-` / `*` (`maybe_mask_to_unsigned_width`) when the
//     usual-arithmetic-conversions common type is unsigned and
//     narrower than 8 bytes.
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
