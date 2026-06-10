// math.h -- the libm subset c5 programs reach for.
//
// Every function takes and returns `double` -- the c5 dialect has
// no `float` / `double` distinction at the prototype level, but the
// FP-register ABI lowering does narrow on call boundaries when
// needed. Math results land in the FP return register on every
// target we ship to.

#pragma once

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
// macOS routes math through libSystem (which re-exports libm
// symbols). No separate libm needed.
#pragma binding(libc::log,   "_log")
#pragma binding(libc::log10, "_log10")
#pragma binding(libc::log2,  "_log2")
#pragma binding(libc::exp,   "_exp")
#pragma binding(libc::pow,   "_pow")
#pragma binding(libc::round, "_round")
#pragma binding(libc::fmod,  "_fmod")
#pragma binding(libc::sin,   "_sin")
#pragma binding(libc::cos,   "_cos")
#pragma binding(libc::tan,   "_tan")
#pragma binding(libc::atan,  "_atan")
#pragma binding(libc::atan2, "_atan2")
#pragma binding(libc::asin,  "_asin")
#pragma binding(libc::acos,  "_acos")
#pragma binding(libc::sinh,  "_sinh")
#pragma binding(libc::cosh,  "_cosh")
#pragma binding(libc::tanh,  "_tanh")
#pragma binding(libc::ldexp, "_ldexp")
// C99 7.12 declares `ldexpl` as the long-double form of `ldexp`.
// c5 aliases `long double` to `double` for storage, so the value
// passed to / returned from the host ABI is the same 64-bit
// double. Binding `ldexpl` to host `ldexp` keeps the
// calling-convention contract on every target without depending
// on the platform's actual `long double` width.
#pragma binding(libc::ldexpl, "_ldexp")
#pragma binding(libc::frexp, "_frexp")
#pragma binding(libc::modf,  "_modf")
// C99 7.12 single-precision variants. Each takes and returns `float`;
// the FP-register ABI narrows the argument and the call-return bridge
// recovers the single-precision result.
#pragma binding(libc::logf,   "_logf")
#pragma binding(libc::log10f, "_log10f")
#pragma binding(libc::expf,   "_expf")
#pragma binding(libc::powf,   "_powf")
#pragma binding(libc::roundf, "_roundf")
#pragma binding(libc::fmodf,  "_fmodf")
#pragma binding(libc::sinf,   "_sinf")
#pragma binding(libc::cosf,   "_cosf")
#pragma binding(libc::tanf,   "_tanf")
#pragma binding(libc::atanf,  "_atanf")
#pragma binding(libc::atan2f, "_atan2f")
#pragma binding(libc::asinf,  "_asinf")
#pragma binding(libc::acosf,  "_acosf")
#endif

#ifdef __linux__
// Linux keeps math in a separate libm.so.6.
#pragma dylib(libm, "libm.so.6")
#pragma binding(libm::log,   "log")
#pragma binding(libm::log10, "log10")
#pragma binding(libm::log2,  "log2")
#pragma binding(libm::exp,   "exp")
#pragma binding(libm::pow,   "pow")
#pragma binding(libm::round, "round")
#pragma binding(libm::fmod,  "fmod")
#pragma binding(libm::sin,   "sin")
#pragma binding(libm::cos,   "cos")
#pragma binding(libm::tan,   "tan")
#pragma binding(libm::atan,  "atan")
#pragma binding(libm::atan2, "atan2")
#pragma binding(libm::asin,  "asin")
#pragma binding(libm::acos,  "acos")
#pragma binding(libm::sinh,  "sinh")
#pragma binding(libm::cosh,  "cosh")
#pragma binding(libm::tanh,  "tanh")
#pragma binding(libm::ldexp, "ldexp")
#pragma binding(libm::ldexpl, "ldexp")
#pragma binding(libm::frexp, "frexp")
#pragma binding(libm::modf,  "modf")
// C99 7.12 single-precision variants.
#pragma binding(libm::logf,   "logf")
#pragma binding(libm::log10f, "log10f")
#pragma binding(libm::expf,   "expf")
#pragma binding(libm::powf,   "powf")
#pragma binding(libm::roundf, "roundf")
#pragma binding(libm::fmodf,  "fmodf")
#pragma binding(libm::sinf,   "sinf")
#pragma binding(libm::cosf,   "cosf")
#pragma binding(libm::tanf,   "tanf")
#pragma binding(libm::atanf,  "atanf")
#pragma binding(libm::atan2f, "atan2f")
#pragma binding(libm::asinf,  "asinf")
#pragma binding(libm::acosf,  "acosf")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::log,   "log")
#pragma binding(msvcrt::log10, "log10")
#pragma binding(msvcrt::log2,  "log2")
#pragma binding(msvcrt::exp,   "exp")
#pragma binding(msvcrt::round, "round")
#pragma binding(msvcrt::fmod,  "fmod")
#pragma binding(msvcrt::sin,   "sin")
#pragma binding(msvcrt::cos,   "cos")
#pragma binding(msvcrt::tan,   "tan")
#pragma binding(msvcrt::atan,  "atan")
#pragma binding(msvcrt::atan2, "atan2")
#pragma binding(msvcrt::asin,  "asin")
#pragma binding(msvcrt::acos,  "acos")
#pragma binding(msvcrt::sinh,  "sinh")
#pragma binding(msvcrt::cosh,  "cosh")
#pragma binding(msvcrt::tanh,  "tanh")
#pragma binding(msvcrt::ldexp, "ldexp")
#pragma binding(msvcrt::ldexpl, "ldexp")
#pragma binding(msvcrt::modf,  "modf")

// msvcrt.dll's transcendental implementations underflow
// aggressively and diverge from C99 at IEEE-754 edges:
//   - `frexp(+/-inf)` returns NaN. C99 7.12.6.4 paragraph 2
//     specifies that the argument is returned and `*exp` is
//     unspecified.
//   - `pow(2.0, -1023.0)` returns 0 instead of the largest
//     subnormal double (~1.1125e-308). msvcrt flushes to zero
//     well above the subnormal range, breaking any code that
//     walks adjacent floats via `pow(2, i) + pow(2, i - 52)`.
// The Universal CRT (`ucrtbase.dll`, shipped with Windows 10
// and redistributed back to Windows 7 SP1) handles both. Pin
// the affected entries to ucrtbase; the rest of the math
// surface stays on msvcrt for now and migrates as new
// divergences turn up under the TODO marker.
#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::frexp, "frexp")
#pragma binding(ucrtbase::pow,   "pow")
// C99 7.12 single-precision variants. The Universal CRT exports these
// `f`-suffixed entry points (the legacy msvcrt.dll does not). The forms
// with a single FP instruction (sqrtf, fabsf, floorf, ceilf, truncf)
// lower via `#pragma intrinsic` below and need no binding.
#pragma binding(ucrtbase::logf,   "logf")
#pragma binding(ucrtbase::log10f, "log10f")
#pragma binding(ucrtbase::expf,   "expf")
#pragma binding(ucrtbase::powf,   "powf")
#pragma binding(ucrtbase::roundf, "roundf")
#pragma binding(ucrtbase::fmodf,  "fmodf")
#pragma binding(ucrtbase::sinf,   "sinf")
#pragma binding(ucrtbase::cosf,   "cosf")
#pragma binding(ucrtbase::tanf,   "tanf")
#pragma binding(ucrtbase::atanf,  "atanf")
#pragma binding(ucrtbase::atan2f, "atan2f")
#pragma binding(ucrtbase::asinf,  "asinf")
#pragma binding(ucrtbase::acosf,  "acosf")
#endif

// IEEE-754 sentinel values. The c5 lexer accepts the typical
// `1e308 * 10.0` / `0.0 / 0.0` shapes so the math.h macros can
// land their bit patterns without compiler intrinsics. Worth
// noting that c5 widens both sides of the FP-overflow chain to
// `double` automatically -- the resulting bit pattern is the
// IEEE infinity and NaN that downstream code expects.
#ifndef INFINITY
#define INFINITY (1.0e+308 * 10.0)
#endif
#ifndef NAN
#define NAN (0.0 / 0.0)
#endif
#ifndef HUGE_VAL
#define HUGE_VAL INFINITY
#endif
#ifndef HUGE_VALF
#define HUGE_VALF INFINITY
#endif

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif
#ifndef M_E
#define M_E  2.71828182845904523536
#endif

int isnan(double x);
int isinf(double x);
int isfinite(double x);

double sqrt(double x);
double log(double x);
double log10(double x);
double log2(double x);
double exp(double x);
double pow(double base, double exp);
double floor(double x);
double ceil(double x);
double round(double x);
double fabs(double x);
double fmod(double x, double y);
double sin(double x);
double cos(double x);
double tan(double x);
double atan(double x);
double atan2(double y, double x);
double asin(double x);
double acos(double x);
double sinh(double x);
double cosh(double x);
double tanh(double x);
// C99 7.12.6.6: ldexp(x, exp) = x * 2^exp.
double ldexp(double x, int exp);
// C99 7.12 long-double form. c5 aliases long double to double, so
// the prototype and the binding both reduce to the `ldexp` ABI.
double ldexpl(double x, int exp);
// C99 7.12.6.4: frexp(x, *exp) splits x into a normalised
// significand in [0.5, 1.0) and an integer exponent.
double frexp(double x, int *exp);
// C99 7.12.6.12: modf(x, *iptr) splits x into integer + fractional
// parts.
double modf(double x, double *iptr);
// C99 7.12.9.8: trunc rounds toward zero.
double trunc(double x);

// C99 7.12 single-precision variants. A `float`-returning host function
// hands the result back in the low bits of the FP return register; the
// call-return bridge widens it before reading so the value survives.
float sqrtf(float x);
float logf(float x);
float log10f(float x);
float expf(float x);
float powf(float base, float exp);
float floorf(float x);
float ceilf(float x);
float roundf(float x);
float truncf(float x);
float fabsf(float x);
float fmodf(float x, float y);
float sinf(float x);
float cosf(float x);
float tanf(float x);
float atanf(float x);
float atan2f(float y, float x);
float asinf(float x);
float acosf(float x);

// C99 7.12.13.1: fma(x, y, z) = x*y + z computed with a single
// rounding of the infinitely precise result. Tagged as an intrinsic so
// the call lowers to the target's fused multiply-add instruction
// (AArch64 FMADD, x86-64 FMA3 vfmadd231) rather than a libm call;
// `fmaf` is the single-precision form. The prototypes give the
// call-site type-checker the operand precision so non-matching
// arguments take the usual conversion path.
#pragma intrinsic("fma")
#pragma intrinsic("fmaf")
double fma(double x, double y, double z);
float fmaf(float x, float y, float z);

// Math functions that map to a single FP instruction lower to it
// rather than a library call (C99 7.12.7.5 / 7.12.7.2 / 7.12.9.2 /
// 7.12.9.1 / 7.12.9.8): square root (FSQRT; SQRTSD/SQRTSS), absolute
// value (FABS; sign-mask AND), and floor / ceil / trunc (FRINTM /
// FRINTP / FRINTZ; ROUNDSD/ROUNDSS with the rounding-mode immediate,
// SSE4.1). The x86-64 backend already requires FMA (Haswell), which
// implies SSE4.1. This removes the libm / ucrtbase dependency for these
// and, on Windows, supplies the `f`-forms the CRT does not export.
// `round` is not here: x86-64 ROUNDSS has no round-half-away-from-zero
// mode, so C99 `round` keeps a library binding.
#pragma intrinsic("sqrt")
#pragma intrinsic("sqrtf")
#pragma intrinsic("fabs")
#pragma intrinsic("fabsf")
#pragma intrinsic("floor")
#pragma intrinsic("floorf")
#pragma intrinsic("ceil")
#pragma intrinsic("ceilf")
#pragma intrinsic("trunc")
#pragma intrinsic("truncf")
