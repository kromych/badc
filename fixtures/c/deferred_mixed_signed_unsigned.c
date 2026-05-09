// DEFERRED: mixed signed / unsigned arithmetic doesn't promote to
// a common unsigned type.
//
// C99 sec 6.3.1.8 says: when both operands are integers and one is
// unsigned (with rank >= the signed operand's), the signed
// operand is converted to the unsigned type. So
// `(int)-1 / (unsigned int)2` is computed as
// `0xFFFFFFFFu / 2u = 0x7FFFFFFFu`, not `-1 / 2 = 0` (signed).
//
// The dialect today inspects only the operator-time operand types
// for compare-op selection (`Op::Ult` etc. fire when either side
// is unsigned), but for arithmetic it picks the op based on the
// operator alone -- `+` always emits `Op::Add`, `/` always emits
// `Op::Div` (signed). The "convert signed -> unsigned in mixed
// expressions" rule isn't applied.
//
// What this fixture pins:
//   * `(int)-1 / (unsigned int)2` should equal 0x7FFFFFFFu
//     under C-correct unsigned promotion.
//   * Under today's signed-only divide it's 0 (round-toward-
//     zero of -0.5).
#include <stdio.h>

int main() {
    int s = -1;
    unsigned int u = 2;

    // Per C: s promotes to (unsigned int)-1 = 0xFFFFFFFFu. Then
    // 0xFFFFFFFFu / 2u = 0x7FFFFFFFu = 2147483647.
    unsigned int q = s / u;
    if (q != 2147483647u) return 1;

    // Same shape with modulo: 0xFFFFFFFFu % 7u = 3.
    unsigned int seven = 7;
    unsigned int r = s % seven;
    if (r != 3) return 2;

    return 0;
}
