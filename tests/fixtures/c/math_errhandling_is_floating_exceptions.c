// C17 7.12p9: math_errhandling is MATH_ERREXCEPT on every target, and
// MATH_ERRNO and MATH_ERREXCEPT are 1 and 2. A domain error of sqrt raises
// FE_INVALID, returns a NaN and leaves errno alone. Returns 0 when every
// check holds; each failure returns its own code.
#include <errno.h>
#include <fenv.h>
#include <math.h>
#pragma STDC FENV_ACCESS ON

#if MATH_ERRNO != 1 || MATH_ERREXCEPT != 2
#error "MATH_ERRNO and MATH_ERREXCEPT are 1 and 2"
#endif

int main(void) {
    if (math_errhandling != MATH_ERREXCEPT)
        return 1;
    volatile double x = -1.0;
    errno = 0;
    feclearexcept(FE_ALL_EXCEPT);
    double r = sqrt(x);
    if (!fetestexcept(FE_INVALID))
        return 2;
    if (r == r)
        return 3;
    if (errno != 0)
        return 4;
    return 0;
}
