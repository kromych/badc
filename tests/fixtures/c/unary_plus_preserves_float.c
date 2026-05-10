// C99 6.5.3.3p2: unary `+` is a no-op. Its result has the type of
// the (integer-promoted) operand. Critically, an FP operand keeps
// its FP type -- otherwise an inline `+0.5` poses as an integer
// and a subsequent `r + (+0.5)` lowers as integer addition on the
// double's bit pattern, producing garbage.
//
// Surfaced via the SQL `round()` built-in: the rounding kernel
// reads
//
//     r = (double)((long)(r + (r<0 ? -0.5 : +0.5)));
//
// where the inline `+0.5` was being tagged `int` and poisoning the
// outer add's type, so `r + (+0.5)` with r=1.5 became
// `bits_of(1.5) + bits_of(0.5)` interpreted as i64 instead of
// `1.5 + 0.5 = 2.0`.
#include <stdio.h>

int main() {
    double r = 1.5;

    // 1. Inline `+0.5` in a binary expression with a double LHS.
    if ((r + (+0.5)) != 2.0) return 1;

    // 2. Ternary whose else branch has a leading `+` -- the bug
    //    showed up here because the ternary's exit type was the
    //    else branch's type, and unary `+` had set it to int.
    double sign = (r < 0) ? -0.5 : +0.5;
    if (sign != 0.5) return 2;
    if ((r + sign) != 2.0) return 3;
    if ((r + ((r < 0) ? -0.5 : +0.5)) != 2.0) return 4;

    // 3. The full sqlite-style cast chain.
    long li = (long)(r + ((r < 0) ? -0.5 : +0.5));
    if (li != 2) return 5;
    double back = (double)((long)(r + ((r < 0) ? -0.5 : +0.5)));
    if (back != 2.0) return 6;

    // 4. Negative case: `(r-0.5)` with r=-1.5 -> -2.0 the same
    //    shape, exercising the then-branch.
    r = -1.5;
    double rounded = (double)((long)(r + ((r < 0) ? -0.5 : +0.5)));
    if (rounded != -2.0) return 7;

    // 5. Unary `+` on integers stays int (integer promotion).
    int i = 7;
    if ((+i) != 7) return 8;

    return 0;
}
