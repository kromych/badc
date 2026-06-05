// C99 6.5.15 + 6.5.2.2 + the c5 cdecl: a float-typed parameter
// arrives in the host arg register; the parser spills it into a
// 4-byte local slot so the body can read it back through the
// regular `Load { kind: F32 }` path. The walker also needs the
// spill (an `LoadLocal { off: arg_slot, kind: I64 }` + `Store {
// kind: F32 }` to the local) -- without it the local slot stays
// uninitialised and every `x` reference reads stack garbage.
//
// The conditional expression `(int_cond) ? float_expr :
// float_expr` lowers to a phi-substitute synthetic local. The
// walker has to size that slot by the result type so an
// FP-typed ternary stores / loads through `F32` instead of the
// I64 fast path; otherwise the FP value never reaches an FP
// register and the consumer reads the int-typed bit pattern.

#include <stdio.h>

float pick(int h, float x) {
    return (h & 1) ? x : -x;
}

float grad_dot(int hash, float x, float y) {
    float gx = (hash & 1) ? x : -x;
    float gy = (hash & 2) ? y : -y;
    return gx + gy;
}

int main(void) {
    if (pick(0, 5.0f) != -5.0f) return 1;
    if (pick(1, 5.0f) !=  5.0f) return 2;
    if (pick(2, 5.0f) != -5.0f) return 3;
    if (pick(3, 5.0f) !=  5.0f) return 4;
    if (grad_dot(1, 1.5f, 2.5f) != (1.5f + -2.5f)) return 5;
    if (grad_dot(2, 7.25f, 0.125f) != (-7.25f + 0.125f)) return 6;
    if (grad_dot(3, 3.0f, 4.0f) != (3.0f + 4.0f)) return 7;
    return 0;
}
