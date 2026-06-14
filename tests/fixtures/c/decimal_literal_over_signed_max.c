// C99 6.4.4.1p5 lists only signed types for a decimal integer
// constant, but a decimal value that exceeds the widest signed type
// cannot be represented there. gcc and clang type such a constant as
// the unsigned type at the same rank; a constant typed signed would
// wrap to a negative value (its bit-63 pattern), so an unsigned
// comparison like `ULONG_MAX > UINT_MAX` would compare a wrapped -1
// and fail. This pins the unsigned typing of an over-large decimal.

int main(void) {
    // 2**64 - 1 as an unsuffixed decimal: must be unsigned, so the
    // comparison runs at 64-bit width.
    if (!(18446744073709551615 > 4294967295U)) {
        return 1;
    }

    // The value round-trips as the all-ones bit pattern.
    if (18446744073709551615 != 0xFFFFFFFFFFFFFFFFUL) {
        return 2;
    }

    // A decimal in (LLONG_MAX, ULLONG_MAX] is positive, not negative.
    if (!(10000000000000000000 > 0)) {
        return 3;
    }

    // A value that still fits a signed long long stays signed and
    // positive.
    if (!(9223372036854775807 > 0)) {
        return 4;
    }

    // Suffixed forms keep working.
    if (!(18446744073709551615UL > 4294967295U)) {
        return 5;
    }

    return 0;
}
