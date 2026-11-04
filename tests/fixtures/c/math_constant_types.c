// C99 7.12p3-5: HUGE_VALF, INFINITY and NAN have type float, HUGE_VAL
// double and HUGE_VALL long double, each a constant expression; NAN is a
// quiet NaN with a clear sign bit, as __builtin_nanf("") gives it.
#include <math.h>
#include <string.h>
static const float s_nan = NAN, s_inf = INFINITY;
int main(void) {
    if (sizeof NAN != sizeof(float) || sizeof INFINITY != sizeof(float)) return 1;
    if (_Generic(NAN, float: 0, default: 1)) return 2;
    if (_Generic(INFINITY, float: 0, default: 1)) return 3;
    if (_Generic(HUGE_VALF, float: 0, default: 1)) return 4;
    if (_Generic(HUGE_VAL, double: 0, default: 1)) return 5;
    if (_Generic(HUGE_VALL, long double: 0, default: 1)) return 6;
    float n = NAN;
    unsigned bits;
    memcpy(&bits, &n, sizeof bits);
    if ((bits & 0xffc00000u) != 0x7fc00000u) return 7;
    if (s_nan == s_nan || !(s_inf > 3.0e38f) || !(HUGE_VAL > 1e308)) return 8;
    if (signbit(NAN) || signbit(-NAN) == 0) return 9;
    return 0;
}
