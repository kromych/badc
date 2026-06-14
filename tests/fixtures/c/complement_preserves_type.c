// C99 6.5.3.3p4: the result of `~` has the promoted type of the
// operand. A `long` / `long long` (signed or unsigned) keeps its width
// and signedness, so `~(unsigned long)0` is `unsigned long`
// (0xFFFFFFFFFFFFFFFF) and a following `>>` is a logical shift. Forcing
// the result to a signed 32-bit `int` made `(~(unsigned long)0) >> 1`
// an arithmetic shift yielding 0xFFFFFFFFFFFFFFFF -- this broke TCL's
// bignum-to-wide narrowing bound `((~(unsigned long)0) >> 1) + sign`,
// shrinking 2**63 to INT64_MIN instead of keeping it a big integer.

int main(void) {
    // 64-bit unsigned: ~0 is all ones, logical >> 1 clears the top bit.
    unsigned long ul = (~(unsigned long)0) >> 1;
    if (ul != 0x7fffffffffffffffUL) {
        return 1;
    }

    // Through a variable, same result.
    unsigned long z = 0;
    if ((~z) >> 1 != 0x7fffffffffffffffUL) {
        return 2;
    }

    // 32-bit unsigned still masks and shifts logically.
    unsigned u = 0;
    if ((~u) >> 1 != 0x7fffffffu) {
        return 3;
    }

    // ~ alone keeps the full width.
    if (~(unsigned long)0 != 0xffffffffffffffffUL) {
        return 4;
    }

    // signed long: ~ stays signed; ~0L == -1, arithmetic >> 1 == -1.
    long sl = ~0L;
    if (sl != -1L || (sl >> 1) != -1L) {
        return 5;
    }

    // The bignum-narrowing comparison shape.
    unsigned long value = 0x8000000000000000UL; // 2**63
    if (!(value > (((~(unsigned long)0) >> 1) + 0))) {
        return 6;
    }

    return 0;
}
