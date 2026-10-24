// feraiseexcept on the Windows targets, where no C runtime DLL exports it:
// each exception is raised by a division that raises it, as the SDK's is.

#ifdef _WIN32

#include <fenv.h>

int feraiseexcept(int excepts) {
    static const struct {
        int except;
        double num, den;
    } raise[] = {
        {FE_INVALID, 0.0, 0.0},       {FE_DIVBYZERO, 1.0, 0.0},
        {FE_OVERFLOW, 1e300, 1e-300}, {FE_UNDERFLOW, 1e-300, 1e300},
        {FE_INEXACT, 2.0, 3.0},
    };
    unsigned i;
    for (i = 0; i < sizeof raise / sizeof raise[0]; i++) {
        if (excepts & raise[i].except) {
            volatile double num = raise[i].num, den = raise[i].den;
            volatile double quotient = num / den;
            (void)quotient;
        }
    }
    return 0;
}

#endif
