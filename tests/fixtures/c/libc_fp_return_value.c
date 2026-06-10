// FP-returning libc fns (sin, cos, sqrt, fabs, ...) hand the
// result back in xmm0 (SysV x86_64 / Win64) or d0 (AAPCS64).
// The c5 native call-site handler used to copy rax / x0 into
// the c5 accumulator unconditionally, dropping the xmm0 / d0
// payload on the floor. Every FP-returning libc call thus
// returned 0.0, which silently broke every numerics-heavy
// codebase that depended on libm return values. Pinning a
// handful of widely-used libm fns here so a future regression
// on either backend fails loudly.
#include <stdio.h>
#include <math.h>

int main(void) {
    int ok = 1;
    double s = sqrt(4.0);   if (s != 2.0) ok = 0;
    double f = floor(2.7);  if (f != 2.0) ok = 0;
    double c = ceil(2.3);   if (c != 3.0) ok = 0;
    double a = fabs(-3.5);  if (a != 3.5) ok = 0;
    double m = fmod(7.0, 4.0); if (m != 3.0) ok = 0;

    // C99 7.12.7.5 / 7.12.7.2: sqrtf / fabsf lower to a hardware
    // instruction, so they work on every target including Windows. A
    // float result widened to double exercises the FP-return path.
    float sf = sqrtf(4.0f);   if (sf != 2.0f) ok = 0;
    float af = fabsf(-3.5f);  if (af != 3.5f) ok = 0;
    double wf = sqrtf(16.0f); if (wf != 4.0) ok = 0;

    // The remaining `f`-suffixed functions bind to a host library, which
    // on Windows does not export them as DLL symbols.
#ifndef _WIN32
    float ff = floorf(2.7f);  if (ff != 2.0f) ok = 0;
    float cf = ceilf(2.3f);   if (cf != 3.0f) ok = 0;
    float mf = fmodf(7.0f, 4.0f); if (mf != 3.0f) ok = 0;
#endif
    return ok ? 11 : 0;
}
