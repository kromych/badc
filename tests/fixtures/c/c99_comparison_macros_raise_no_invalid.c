// C99 7.12.14: isgreater and its siblings, through <math.h> and as the
// builtins, compare quietly. With a quiet NaN operand each is false, and
// isunordered true, and FE_INVALID stays clear. Each argument is evaluated
// once, and mixed operand types meet at their common type (C99 6.3.1.8):
// an int against a float compares as float.

#include <fenv.h>
#include <math.h>

// Constant operands fold, NaN and the common type included.
_Static_assert(!__builtin_islessgreater(1.0, __builtin_nan("")), "<> with NaN");
_Static_assert(__builtin_isunordered(__builtin_nan(""), 1.0), "unordered");
_Static_assert(!__builtin_islessgreater(16777217, 16777216.0f), "compared as float");
_Static_assert(__builtin_isgreaterequal(__builtin_inf(), 1e308), "infinity");

static int calls;

static double next(double v) {
    calls++;
    return v;
}

int main(void) {
    volatile double qnan = __builtin_nan(""), one = 1.0, two = 2.0, inf = __builtin_inf();
    volatile float onef = 1.0f, f24 = 16777216.0f;
    volatile int big = 16777217;
    feclearexcept(FE_ALL_EXCEPT);
    if (isgreater(qnan, one) || isgreaterequal(qnan, one) || isless(qnan, one) ||
        islessequal(one, qnan) || islessgreater(qnan, one) || !isunordered(one, qnan))
        return 1;
    if (__builtin_isgreater(one, qnan) || __builtin_isless(qnan, qnan) ||
        __builtin_islessgreater(qnan, qnan) || !__builtin_isunordered(qnan, qnan))
        return 2;
    if (fetestexcept(FE_INVALID))
        return 3;
    if (!isgreater(two, one) || !isgreaterequal(one, one) || !isless(one, two) ||
        !islessequal(two, two) || !islessgreater(one, two) || islessgreater(one, one) ||
        isunordered(one, two))
        return 4;
    if (!isgreater(2, one) || !isless(onef, two) || islessgreater(onef, one))
        return 5;
    if (islessgreater(big, f24) || !islessequal(big, f24))
        return 6;
    calls = 0;
    if (!islessgreater(next(1.0), next(2.0)) || isunordered(next(1.0), next(2.0)) || calls != 4)
        return 7;
    if (!isgreater(inf, one) || isunordered(inf, -inf) || !islessgreater(-inf, inf))
        return 8;
    return fetestexcept(FE_INVALID) ? 9 : 0;
}
