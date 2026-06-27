// x86_64 emit_binop_divmod must save/restore RDX when the
// allocator parks a live value there. cqo / xor edx,edx /
// idiv all write RDX, and the unsigned variant zero-extends
// it; without the symmetric push/pop pair around the divmod
// (rax already has one), a value still live in RDX is
// silently corrupted. The shape below keeps several caller-
// saved-eligible SSA values live across a divmod that does
// not request the remainder; the allocator's must-be-callee
// filter only triggers on call ranges, so divmod-only
// intervals are eligible for RDX placement.
//
// AArch64 has no implicit clobber pattern here; the test still
// runs there but is a no-op for the bug.
#include <stdio.h>

int main(void) {
    int a = 100;
    int b = 50;
    int c = 25;
    int d = 12;
    // Four divmods that produce values used after the last divmod;
    // the originals a/b/c/d are also kept live so the allocator has
    // pressure to place them in caller-saved registers, including
    // RDX on x86_64. The divisor must stay non-power-of-two so the
    // pow2 strength reduction does not replace the idiv with shifts
    // and the RDX-clobber path is still exercised.
    int q1 = a / 7;
    int q2 = b / 7;
    int q3 = c / 7;
    int q4 = d / 7;
    int total = q1 + q2 + q3 + q4 + a + b + c + d;
    // expected: 14 + 7 + 3 + 1 + 100 + 50 + 25 + 12 = 212
    printf("%d\n", total);
    return total == 212 ? 0 : 1;
}
