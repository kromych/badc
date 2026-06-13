// Taking the address of a single-precision math function that c5 lowers
// to a hardware instruction for a direct call (sqrtf, fabsf, floorf,
// ceilf, truncf). A direct call still uses the instruction; the
// function's address is a valid pointer to the library function, so
// calling through the pointer computes the same result.
//
// Exercises the `float`-return path through the address-of-import
// trampoline. The trampoline forwards control to the libc callee with a
// frameless tail jump, so the `float` result stays in s0 (C99 6.2.5p10):
// the earlier integer forwarding body widened it with `fcvt d0,s0`,
// whose double bit pattern's zero low half overwrote the s0 the caller
// reads, returning 0. Asserted by return code.
//
// `fabsf` is an MSVC compiler intrinsic that no Windows CRT DLL exports,
// so its address has no library symbol to resolve to there; its address
// checks are guarded off Windows while its direct (instruction) call is
// asserted everywhere.
//
// Run under the native and JIT paths. The SSA interpreter resolves
// library calls by name and does not call a library function through a
// pointer taken from its address (the same limitation applies to any
// imported function), so this fixture is not run there.

#include <math.h>

int main(void) {
    float (*ps)(float) = sqrtf;
    float (*pfl)(float) = floorf;
    float (*pc)(float) = ceilf;
    float (*pt)(float) = truncf;

    if (ps(16.0f) != 4.0f) return 2;
    if (pfl(2.7f) != 2.0f) return 3;
    if (pc(2.1f) != 3.0f) return 4;
    if (pt(2.9f) != 2.0f) return 5;

#ifndef _WIN32
    float (*pf)(float) = fabsf;
    if (pf(-3.5f) != 3.5f) return 1;
#endif

    // Address in a dispatch table. The argument is a `float` lvalue so
    // the call reaches the callee with a single-precision value; passing
    // a `double`-typed expression through a subscripted function pointer
    // is a separate front-end narrowing gap tracked elsewhere.
    float (*tbl[3])(float) = { sqrtf, floorf, ceilf };
    float a = 81.0f, b = 5.9f, c = 2.1f;
    if (tbl[0](a) != 9.0f) return 6;
    if (tbl[1](b) != 5.0f) return 7;
    if (tbl[2](c) != 3.0f) return 8;

    // A direct call must still fold to the instruction and produce the
    // same value (no library symbol needed, so this holds on Windows too).
    if (fabsf(-7.0f) != 7.0f) return 9;
    if (sqrtf(49.0f) != 7.0f) return 10;

    return 0;
}
