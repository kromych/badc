// C99 6.3.1.8 + 6.5.16.1: when one operand of a binary op is
// floating and the other is integral, the integer is promoted
// to floating before the operation. The parser's
// `require_both_float` helper emits the conversion bytecode --
// `Op::StLocI` / `Op::Imm` / `Op::Or` / `Op::Fcvtif` /
// `Op::Psh` / `Op::Lea` / `Op::Li` -- each routed through
// `ast_track_emit_op`, which pops the AST vstack to build a
// scalar binop node. The lhs we wanted to promote was already
// in the vstack; the inner pops consumed the outer
// expression's operand and the resulting assignment node went
// missing on the AST.
//
// The walker then emitted no code for the assignment, leaving
// the destination local uninitialised. A
// `double phase = -2 * pi * idx;` line with a non-FP outer
// expression around the multiply triggered the bug.

#include <stdio.h>

double compute(int nfft, int idx) {
    const double pi = 3.141592653589793;
    double phase = -2 * pi * idx;
    return phase;
}

int main(void) {
    if (compute(8, 0) != 0.0) return 1;
    if (compute(8, 1) != -2.0 * 3.141592653589793) return 2;
    if (compute(8, 2) != -4.0 * 3.141592653589793) return 3;
    return 0;
}
