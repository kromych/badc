// C99 7.12.7.3 hypot, 7.12.12.1 fmax, 7.12.12.2 fmin (and the
// single-precision forms). fmin / fmax return the lesser / greater
// operand and treat a single NaN argument as missing data, returning
// the other operand -- the property that distinguishes them from the
// < / > operators.
#include <math.h>

int main(void) {
    if (hypot(3.0, 4.0) != 5.0) return 1;
    if (fmin(2.0, 3.0) != 2.0) return 2;
    if (fmax(2.0, 3.0) != 3.0) return 3;
    if (fmin(NAN, 4.0) != 4.0) return 4;
    if (fmax(5.0, NAN) != 5.0) return 5;
    if (hypotf(3.0f, 4.0f) != 5.0f) return 6;
    if (fminf(2.0f, 3.0f) != 2.0f) return 7;
    if (fmaxf(2.0f, 3.0f) != 3.0f) return 8;
    return 0;
}
