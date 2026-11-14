// C99 F.3 / IEC 60559: the relational operators on floating operands are
// signaling predicates, so an unordered operand raises FE_INVALID, while
// `==`, `!=` and the 7.12.14 comparison macros are quiet. Asserted by
// return code.
#include <fenv.h>
#include <math.h>

static int invalid_after(int r) {
    return !r && fetestexcept(FE_INVALID);
}

int main(void) {
    volatile double n = NAN, one = 1.0;
    volatile float f = NAN, g = 1.0f;
    feclearexcept(FE_ALL_EXCEPT);
    if (!invalid_after(n < one)) return 1;
    feclearexcept(FE_ALL_EXCEPT);
    if (!invalid_after(one >= n)) return 2;
    feclearexcept(FE_ALL_EXCEPT);
    if (!invalid_after(f > g)) return 3;
    feclearexcept(FE_ALL_EXCEPT);
    if (n <= one) return 4;
    if (!fetestexcept(FE_INVALID)) return 5;
    feclearexcept(FE_ALL_EXCEPT);
    if (n == one || !(n != one)) return 6;
    if (fetestexcept(FE_INVALID)) return 7;
    if (isless(n, one) || isgreaterequal(one, n) || islessequal(f, g) || isgreater(f, g)) return 8;
    if (fetestexcept(FE_INVALID)) return 9;
    return 0;
}
