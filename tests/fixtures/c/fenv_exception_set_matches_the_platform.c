// FE_ALL_EXCEPT (C17 7.6p6) is the platform's set of exception flags:
// Apple's arm64 set adds FE_FLUSHTOZERO to the five C17 names. Clearing
// the whole set leaves none raised.
#include <fenv.h>

#if defined(__APPLE__) && defined(__aarch64__)
_Static_assert(FE_FLUSHTOZERO == 0x80 && FE_ALL_EXCEPT == 0x9f, "Apple's exception set");
#endif
_Static_assert((FE_ALL_EXCEPT & (FE_INVALID | FE_DIVBYZERO | FE_OVERFLOW | FE_UNDERFLOW |
                                 FE_INEXACT)) ==
                   (FE_INVALID | FE_DIVBYZERO | FE_OVERFLOW | FE_UNDERFLOW | FE_INEXACT),
               "the C17 exceptions");

int main(void) {
    if (feraiseexcept(FE_INEXACT) != 0 || !fetestexcept(FE_INEXACT))
        return 1;
    if (feclearexcept(FE_ALL_EXCEPT) != 0)
        return 2;
    return fetestexcept(FE_ALL_EXCEPT) == 0 ? 0 : 3;
}
