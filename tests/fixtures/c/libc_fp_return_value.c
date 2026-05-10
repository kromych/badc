// FP-returning libc fns (sin, cos, sqrt, fabs, ...) hand the
// result back in xmm0 (SysV x86_64 / Win64) or d0 (AAPCS64).
// The c5 native call-site handler used to copy rax / x0 into
// the c5 accumulator unconditionally, dropping the xmm0 / d0
// payload on the floor. Every FP-returning libc call thus
// returned 0.0, which silently broke every numerics-heavy
// codebase (kissfft butterflies returned NaN, sqlite's
// avg-via-Kahan worked only because it stayed inside c5).
//
// Surfaced building kissfft. Pinning a handful of widely-used
// libm fns here so a future regression on either backend
// fails loudly.
#include <stdio.h>
#include <math.h>

int main(void) {
    int ok = 1;
    double s = sqrt(4.0);   if (s != 2.0) ok = 0;
    double f = floor(2.7);  if (f != 2.0) ok = 0;
    double c = ceil(2.3);   if (c != 3.0) ok = 0;
    double a = fabs(-3.5);  if (a != 3.5) ok = 0;
    double m = fmod(7.0, 4.0); if (m != 3.0) ok = 0;
    return ok ? 11 : 0;
}
