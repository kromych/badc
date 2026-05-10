// Mixed signed/unsigned division & modulo through the unsigned
// common type.
//
// C99 6.3.1.8: when an integer op has one signed and one unsigned
// operand, the signed operand converts to the unsigned common type
// (per 6.3.1.3, by adding 2^N) and the operation runs at unsigned
// width. So `(int)-1 / (unsigned int)2` is
// `0xFFFFFFFFu / 2u = 0x7FFFFFFFu`, not signed `-1 / 2 = 0`.
//
// Closed by `Op::Divu` / `Op::Modu` plus a pre-divide pass that
// masks each operand to the common-unsigned width when one of them
// is signed (otherwise the sign-extended `-1` enters the udiv as
// 0xFFFFFFFFFFFFFFFF and the result is the wrong order of
// magnitude).
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
