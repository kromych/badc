// C99 6.5.3.3p3: the unary `-` operator's result has the
// promoted operand type and follows that type's overflow rules.
// `unsigned int` does not promote down (rank 1, same as `int`),
// so `-x` on a `uint32_t` must wrap modulo 2^32. c5's IR
// lowers the negation as a 64-bit signed multiply by -1, so
// without an explicit 32-bit mask the sign-extended high half
// stays in the register; a subsequent `|`, `>>` or compare
// then operates on the wider pattern.
//
// The constant-time bit-tricks in cryptographic library
// headers (`(q | -q) >> 31` reads "1 if q != 0 else 0") show
// this clearly: with the high bits set, the logical right
// shift returns 0xFFFFFFFF instead of 1 and an enclosing NOT
// flips a boolean back to a non-zero pattern, producing
// garbage outputs from constant-time HMAC and Poly1305
// implementations.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

#include <stdint.h>

int main(void) {
    uint32_t q = 1;

    // The negated value itself must wrap to 0xFFFFFFFF.
    if ((uint32_t)(-q) != 0xFFFFFFFFu) return 1;

    // `q | -q` for non-zero q must be 0xFFFFFFFF.
    if ((q | -q) != 0xFFFFFFFFu) return 2;

    // `(q | -q) >> 31` is 1 iff q != 0.
    if (((q | -q) >> 31) != 1u) return 3;

    // q == 0 produces 0 (no sign-extension surprise either).
    uint32_t zero = 0;
    if (((zero | -zero) >> 31) != 0u) return 4;

    // The same identity routed through a temporary still works
    // (this path always did -- the regression specifically
    // targets the inline form).
    uint32_t neg = -q;
    if ((q | neg) != 0xFFFFFFFFu) return 5;
    if (((q | neg) >> 31) != 1u) return 6;

    // Match the canonical EQ helper from constant-time
    // cryptographic library headers: EQ(x, y) returns 1 iff
    // x == y, 0 otherwise.
    //   q = x ^ y;
    //   NOT((q | -q) >> 31);    // NOT(z) = z ^ 1
    uint32_t a = 1, b = 0;
    uint32_t diff = a ^ b;
    uint32_t eq = (((diff | -diff) >> 31) ^ 1u);
    if (eq != 0u) return 7;

    a = 5; b = 5;
    diff = a ^ b;
    eq = (((diff | -diff) >> 31) ^ 1u);
    if (eq != 1u) return 8;

    return 0;
}
