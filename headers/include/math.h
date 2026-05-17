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
#pragma binding(libc::sqrt,  "_sqrt")
#pragma binding(libc::log,   "_log")
#pragma binding(libc::log10, "_log10")
#pragma binding(libc::log2,  "_log2")
#pragma binding(libc::exp,   "_exp")
#pragma binding(libc::pow,   "_pow")
#pragma binding(libc::floor, "_floor")
#pragma binding(libc::ceil,  "_ceil")
#pragma binding(libc::round, "_round")
#pragma binding(libc::fabs,  "_fabs")
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
#pragma binding(libc::trunc, "_trunc")
#endif

#ifdef __linux__
// Linux keeps math in a separate libm.so.6.
#pragma dylib(libm, "libm.so.6")
#pragma binding(libm::sqrt,  "sqrt")
#pragma binding(libm::log,   "log")
#pragma binding(libm::log10, "log10")
#pragma binding(libm::log2,  "log2")
#pragma binding(libm::exp,   "exp")
#pragma binding(libm::pow,   "pow")
#pragma binding(libm::floor, "floor")
#pragma binding(libm::ceil,  "ceil")
#pragma binding(libm::round, "round")
#pragma binding(libm::fabs,  "fabs")
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
#pragma binding(libm::trunc, "trunc")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::sqrt,  "sqrt")
#pragma binding(msvcrt::log,   "log")
#pragma binding(msvcrt::log10, "log10")
#pragma binding(msvcrt::log2,  "log2")
#pragma binding(msvcrt::exp,   "exp")
#pragma binding(msvcrt::pow,   "pow")
#pragma binding(msvcrt::floor, "floor")
#pragma binding(msvcrt::ceil,  "ceil")
#pragma binding(msvcrt::round, "round")
#pragma binding(msvcrt::fabs,  "fabs")
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
#pragma binding(msvcrt::trunc, "trunc")

// C99 7.12.6.4 paragraph 2: `frexp(x, *exp)` returns x and
// stores an unspecified value in `*exp` when x is infinite.
// msvcrt.dll returns NaN instead, which breaks ldexp/frexp
// round-trip programs (e.g. Lua's math.lua line 692). The
// Universal CRT (`ucrtbase.dll`, shipped with Windows 10 and
// later, redistributed back to Windows 7 SP1) implements the
// C99-conformant behaviour. Pin `frexp` to ucrtbase so the
// round-trip works regardless of which legacy CRT happens to
// be on the import table.
#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::frexp, "frexp")
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
