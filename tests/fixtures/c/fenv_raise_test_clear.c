// C99 7.6.2: feraiseexcept raises the exceptions it is given, fetestexcept
// reports which of the ones it is asked about are raised, and
// feclearexcept clears them. Raising overflow or underflow may also raise
// inexact (7.6.2.3), so each check asks only about the exceptions raised.

#include <fenv.h>

int main(void) {
    static const int each[] = {FE_INVALID, FE_DIVBYZERO, FE_OVERFLOW, FE_UNDERFLOW,
                               FE_INEXACT};
    int both = FE_DIVBYZERO | FE_INVALID;
    unsigned i;
    for (i = 0; i < sizeof each / sizeof each[0]; i++) {
        if (feclearexcept(FE_ALL_EXCEPT) || fetestexcept(FE_ALL_EXCEPT))
            return 1;
        if (feraiseexcept(each[i]))
            return 2;
        if (fetestexcept(each[i]) != each[i])
            return 10 + (int)i;
    }
    feclearexcept(FE_ALL_EXCEPT);
    if (feraiseexcept(both) || fetestexcept(FE_ALL_EXCEPT & ~FE_INEXACT) != both)
        return 3;
    if (feclearexcept(FE_ALL_EXCEPT) || fetestexcept(FE_ALL_EXCEPT))
        return 4;
    return 0;
}
