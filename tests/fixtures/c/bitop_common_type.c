// C99 6.5.10 / 6.5.11 / 6.5.12: the result type of `&` / `^` / `|`
// is the common type produced by the usual arithmetic conversions
// on the operands. Treating the result as `int` regardless of the
// operand widths trips a downstream narrowing pass: when an `int`
// LHS feeds into `+` / `-` / `*`, the codegen sign-extends from
// bit 31 and clobbers bits 32..63 of a 64-bit value.
//
// Returns 0 only when every check passes; each failure path returns
// a distinct nonzero code so a regression points directly at the
// offending pattern.

typedef unsigned long long uint64_t;

int main(void) {
    uint64_t a = 0x14006f000ULL;
    uint64_t z = 0;

    // (uint64 | uint64) + int: result must stay 64-bit.
    if (((a | z) + 1)  != 0x14006f001ULL) return 1;
    if (((a & ~z) + 1) != 0x14006f001ULL) return 2;
    if (((a ^ z) + 1)  != 0x14006f001ULL) return 3;

    // The exact tccpe.c:1272 shape: page-aligned section base
    // computed via `((addr - 1) | (16 - 1)) + 1`.
    uint64_t addr = 0x14006f001ULL;
    uint64_t aligned = ((addr - 1) | (16 - 1)) + 1;
    if (aligned != 0x14006f010ULL) return 4;

    // Mixed-arity follow-ons must preserve the width too.
    if (((a | z) - 0) != 0x14006f000ULL) return 5;
    if (((a | z) * 1) != 0x14006f000ULL) return 6;

    // Comparison after `|` still flattens to int per 6.5.8, but
    // the LHS comparison must see the full 64-bit value.
    if (((a | z) > 0x100000000ULL) == 0) return 7;

    return 0;
}
