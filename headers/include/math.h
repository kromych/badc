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
#pragma binding(libc::exp2,  "_exp2")
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
#pragma binding(libc::asinh, "_asinh")
#pragma binding(libc::acosh, "_acosh")
#pragma binding(libc::atanh, "_atanh")
#pragma binding(libc::tgamma, "_tgamma")
#pragma binding(libc::erf,    "_erf")
#pragma binding(libc::erfc,   "_erfc")
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
#pragma binding(libc::nextafter, "_nextafter")
#pragma binding(libc::ilogb,     "_ilogb")
#pragma binding(libc::hypot, "_hypot")
#pragma binding(libc::fmin,  "_fmin")
#pragma binding(libc::fmax,  "_fmax")
#pragma binding(libc::nearbyint, "_nearbyint")
#pragma binding(libc::rint,      "_rint")
#pragma binding(libc::lround,    "_lround")
#pragma binding(libc::llround,   "_llround")
#pragma binding(libc::lrint,     "_lrint")
#pragma binding(libc::llrint,    "_llrint")
#pragma binding(libc::cbrt,      "_cbrt")
#pragma binding(libc::log1p,     "_log1p")
#pragma binding(libc::expm1,     "_expm1")
#pragma binding(libc::remainder, "_remainder")
// sqrt / fabs / floor / ceil / trunc lower a direct call to a single
// FP instruction through the `#pragma intrinsic` below, so a call
// needs no binding. Taking the function's address still requires a
// real callable, so bind them to the library symbol: the address
// resolves to it while direct calls keep using the instruction.
#pragma binding(libc::sqrt,  "_sqrt")
#pragma binding(libc::fabs,  "_fabs")
#pragma binding(libc::floor, "_floor")
#pragma binding(libc::ceil,  "_ceil")
#pragma binding(libc::trunc, "_trunc")
// C99 7.12 single-precision variants. Each takes and returns `float`;
// the FP-register ABI narrows the argument and the call-return bridge
// recovers the single-precision result.
// sqrtf / fabsf / floorf / ceilf / truncf lower a direct call to a
// single FP instruction below; the binding exists so taking the
// function's address resolves to a real callable symbol.
#pragma binding(libc::sqrtf,  "_sqrtf")
#pragma binding(libc::fabsf,  "_fabsf")
#pragma binding(libc::floorf, "_floorf")
#pragma binding(libc::ceilf,  "_ceilf")
#pragma binding(libc::truncf, "_truncf")
#pragma binding(libc::logf,   "_logf")
#pragma binding(libc::log10f, "_log10f")
#pragma binding(libc::expf,   "_expf")
#pragma binding(libc::powf,   "_powf")
#pragma binding(libc::roundf, "_roundf")
#pragma binding(libc::fmodf,  "_fmodf")
#pragma binding(libc::nextafterf, "_nextafterf")
#pragma binding(libc::ilogbf,     "_ilogbf")
#pragma binding(libc::sinf,   "_sinf")
#pragma binding(libc::cosf,   "_cosf")
#pragma binding(libc::tanf,   "_tanf")
#pragma binding(libc::atanf,  "_atanf")
#pragma binding(libc::atan2f, "_atan2f")
#pragma binding(libc::asinf,  "_asinf")
#pragma binding(libc::acosf,  "_acosf")
#pragma binding(libc::asinhf, "_asinhf")
#pragma binding(libc::acoshf, "_acoshf")
#pragma binding(libc::atanhf, "_atanhf")
#pragma binding(libc::tgammaf, "_tgammaf")
#pragma binding(libc::erff,    "_erff")
#pragma binding(libc::erfcf,   "_erfcf")
#pragma binding(libc::hypotf, "_hypotf")
#pragma binding(libc::fminf,  "_fminf")
#pragma binding(libc::fmaxf,  "_fmaxf")
#pragma binding(libc::nearbyintf, "_nearbyintf")
#pragma binding(libc::rintf,      "_rintf")
#pragma binding(libc::cbrtf,      "_cbrtf")
#pragma binding(libc::log1pf,     "_log1pf")
#pragma binding(libc::expm1f,     "_expm1f")
#pragma binding(libc::remainderf, "_remainderf")
#endif

#ifdef __linux__
// Linux keeps math in a separate libm.so.6.
#pragma dylib(libm, "libm.so.6")
#pragma binding(libm::log,   "log")
#pragma binding(libm::log10, "log10")
#pragma binding(libm::log2,  "log2")
#pragma binding(libm::exp2,  "exp2")
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
#pragma binding(libm::asinh, "asinh")
#pragma binding(libm::acosh, "acosh")
#pragma binding(libm::atanh, "atanh")
#pragma binding(libm::tgamma, "tgamma")
#pragma binding(libm::erf,    "erf")
#pragma binding(libm::erfc,   "erfc")
#pragma binding(libm::ldexp, "ldexp")
#pragma binding(libm::ldexpl, "ldexp")
#pragma binding(libm::frexp, "frexp")
#pragma binding(libm::modf,  "modf")
#pragma binding(libm::nextafter, "nextafter")
#pragma binding(libm::ilogb,     "ilogb")
#pragma binding(libm::hypot, "hypot")
#pragma binding(libm::fmin,  "fmin")
#pragma binding(libm::fmax,  "fmax")
#pragma binding(libm::nearbyint, "nearbyint")
#pragma binding(libm::rint,      "rint")
#pragma binding(libm::lround,    "lround")
#pragma binding(libm::llround,   "llround")
#pragma binding(libm::lrint,     "lrint")
#pragma binding(libm::llrint,    "llrint")
#pragma binding(libm::cbrt,      "cbrt")
#pragma binding(libm::log1p,     "log1p")
#pragma binding(libm::expm1,     "expm1")
#pragma binding(libm::remainder, "remainder")
#pragma binding(libm::sqrt,  "sqrt")
#pragma binding(libm::fabs,  "fabs")
#pragma binding(libm::floor, "floor")
#pragma binding(libm::ceil,  "ceil")
#pragma binding(libm::trunc, "trunc")
// C99 7.12 single-precision variants.
// sqrtf / fabsf / floorf / ceilf / truncf lower a direct call to a
// single FP instruction below; the binding exists so taking the
// function's address resolves to a real callable symbol.
#pragma binding(libm::sqrtf,  "sqrtf")
#pragma binding(libm::fabsf,  "fabsf")
#pragma binding(libm::floorf, "floorf")
#pragma binding(libm::ceilf,  "ceilf")
#pragma binding(libm::truncf, "truncf")
#pragma binding(libm::logf,   "logf")
#pragma binding(libm::log10f, "log10f")
#pragma binding(libm::expf,   "expf")
#pragma binding(libm::powf,   "powf")
#pragma binding(libm::roundf, "roundf")
#pragma binding(libm::fmodf,  "fmodf")
#pragma binding(libm::nextafterf, "nextafterf")
#pragma binding(libm::ilogbf,     "ilogbf")
#pragma binding(libm::sinf,   "sinf")
#pragma binding(libm::cosf,   "cosf")
#pragma binding(libm::tanf,   "tanf")
#pragma binding(libm::atanf,  "atanf")
#pragma binding(libm::atan2f, "atan2f")
#pragma binding(libm::asinf,  "asinf")
#pragma binding(libm::acosf,  "acosf")
#pragma binding(libm::asinhf, "asinhf")
#pragma binding(libm::acoshf, "acoshf")
#pragma binding(libm::atanhf, "atanhf")
#pragma binding(libm::tgammaf, "tgammaf")
#pragma binding(libm::erff,    "erff")
#pragma binding(libm::erfcf,   "erfcf")
#pragma binding(libm::hypotf, "hypotf")
#pragma binding(libm::fminf,  "fminf")
#pragma binding(libm::fmaxf,  "fmaxf")
#pragma binding(libm::nearbyintf, "nearbyintf")
#pragma binding(libm::rintf,      "rintf")
#pragma binding(libm::cbrtf,      "cbrtf")
#pragma binding(libm::log1pf,     "log1pf")
#pragma binding(libm::expm1f,     "expm1f")
#pragma binding(libm::remainderf, "remainderf")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::log,   "log")
#pragma binding(msvcrt::log10, "log10")
#pragma binding(msvcrt::exp,   "exp")
#pragma binding(msvcrt::fmod,  "fmod")
// sqrt / fabs / floor / ceil / trunc lower a direct call to a single
// FP instruction through the `#pragma intrinsic` below; bind them so
// taking the function's address resolves to the library symbol. sqrt /
// fabs / floor / ceil are C89 and live in msvcrt.dll; the C99 `trunc`
// only landed in the Universal CRT and is bound to ucrtbase below.
#pragma binding(msvcrt::sqrt,  "sqrt")
#pragma binding(msvcrt::fabs,  "fabs")
#pragma binding(msvcrt::floor, "floor")
#pragma binding(msvcrt::ceil,  "ceil")
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
// msvcrt.dll exports the legacy underscored `_nextafter`; ilogb and the
// single-precision forms only landed in the Universal CRT, bound below.
#pragma binding(msvcrt::nextafter, "_nextafter")
// msvcrt.dll exports the legacy underscored `_hypot`; the C99
// `fmin` / `fmax` (and the single-precision forms) only landed in the
// Universal CRT, bound below.
#pragma binding(msvcrt::hypot, "_hypot")

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
#pragma binding(ucrtbase::trunc, "trunc")
#pragma binding(ucrtbase::frexp, "frexp")
#pragma binding(ucrtbase::ilogb,      "ilogb")
#pragma binding(ucrtbase::nextafterf, "nextafterf")
#pragma binding(ucrtbase::ilogbf,     "ilogbf")
#pragma binding(ucrtbase::exp2,  "exp2")
#pragma binding(ucrtbase::exp2f, "exp2f")
// C99 log2 / round only landed in the Universal CRT.
#pragma binding(ucrtbase::log2,  "log2")
#pragma binding(ucrtbase::round, "round")
double exp2(double x);
float exp2f(float x);
#pragma binding(ucrtbase::pow,   "pow")
#pragma binding(ucrtbase::fmin,  "fmin")
#pragma binding(ucrtbase::fmax,  "fmax")
#pragma binding(ucrtbase::nearbyint, "nearbyint")
#pragma binding(ucrtbase::rint,      "rint")
#pragma binding(ucrtbase::lround,    "lround")
#pragma binding(ucrtbase::llround,   "llround")
#pragma binding(ucrtbase::lrint,     "lrint")
#pragma binding(ucrtbase::llrint,    "llrint")
#pragma binding(ucrtbase::cbrt,      "cbrt")
#pragma binding(ucrtbase::log1p,     "log1p")
#pragma binding(ucrtbase::expm1,     "expm1")
#pragma binding(ucrtbase::remainder, "remainder")
#pragma binding(ucrtbase::asinh,  "asinh")
#pragma binding(ucrtbase::acosh,  "acosh")
#pragma binding(ucrtbase::atanh,  "atanh")
#pragma binding(ucrtbase::tgamma, "tgamma")
#pragma binding(ucrtbase::erf,    "erf")
#pragma binding(ucrtbase::erfc,   "erfc")
#pragma binding(ucrtbase::asinhf, "asinhf")
#pragma binding(ucrtbase::acoshf, "acoshf")
#pragma binding(ucrtbase::atanhf, "atanhf")
#pragma binding(ucrtbase::tgammaf, "tgammaf")
#pragma binding(ucrtbase::erff,    "erff")
#pragma binding(ucrtbase::erfcf,   "erfcf")
// C99 7.12 single-precision variants. The Universal CRT exports these
// `f`-suffixed entry points (the legacy msvcrt.dll does not). The forms
// with a single FP instruction (sqrtf, fabsf, floorf, ceilf, truncf)
// lower a direct call via `#pragma intrinsic` below; the binding exists
// so taking the function's address resolves to a real callable symbol.
// `fabsf` is an MSVC compiler intrinsic that neither msvcrt.dll nor
// ucrtbase.dll exports, so its address has no library symbol to resolve
// to on Windows; only its direct (instruction) call is available here.
#pragma binding(ucrtbase::sqrtf,  "sqrtf")
#pragma binding(ucrtbase::floorf, "floorf")
#pragma binding(ucrtbase::ceilf,  "ceilf")
#pragma binding(ucrtbase::truncf, "truncf")
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
// ucrtbase.dll exports the float hypot only under the legacy underscored
// `_hypotf`; the C99 `hypotf` spelling is a header inline there, so binding
// to it yields an unresolved import at load.
#pragma binding(ucrtbase::hypotf, "_hypotf")
#pragma binding(ucrtbase::fminf,  "fminf")
#pragma binding(ucrtbase::fmaxf,  "fmaxf")
#pragma binding(ucrtbase::nearbyintf, "nearbyintf")
#pragma binding(ucrtbase::rintf,      "rintf")
#pragma binding(ucrtbase::cbrtf,      "cbrtf")
#pragma binding(ucrtbase::log1pf,     "log1pf")
#pragma binding(ucrtbase::expm1f,     "expm1f")
#pragma binding(ucrtbase::remainderf, "remainderf")
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

// C99 7.12.3.1: floating-point category codes returned by fpclassify.
// The values are an implementation choice; user code compares against
// the names.
#ifndef FP_NAN
#define FP_NAN 0
#define FP_INFINITE 1
#define FP_ZERO 2
#define FP_SUBNORMAL 3
#define FP_NORMAL 4
#endif

// C99 7.12.3.1 / 7.12.3.6 / 7.12.11.1: classify, test the sign, and
// copy the sign by inspecting the IEEE-754 binary64 fields directly,
// so they need no math-library call. copysignf reuses the double form;
// a float magnitude widens to double exactly.
static inline int fpclassify(double x) {
    union {
        double d;
        unsigned long long u;
    } a;
    a.d = x;
    unsigned long long exp = (a.u >> 52) & 0x7ff;
    unsigned long long man = a.u & 0xfffffffffffffULL;
    if (exp == 0) {
        return man == 0 ? FP_ZERO : FP_SUBNORMAL;
    }
    if (exp == 0x7ff) {
        return man == 0 ? FP_INFINITE : FP_NAN;
    }
    return FP_NORMAL;
}
// C99 7.12.3.4 / 7.12.3.3 / 7.12.3.2. Defined in terms of fpclassify so
// they need no math-library call. A float argument widens to double
// exactly, so the double form covers both.
static inline int isnan(double x) {
    return fpclassify(x) == FP_NAN;
}
static inline int isinf(double x) {
    return fpclassify(x) == FP_INFINITE;
}
static inline int isfinite(double x) {
    return fpclassify(x) >= FP_ZERO;
}
static inline int signbit(double x) {
    union {
        double d;
        unsigned long long u;
    } a;
    a.d = x;
    return (int)(a.u >> 63);
}
static inline double copysign(double x, double y) {
    union {
        double d;
        unsigned long long u;
    } ax, ay;
    ax.d = x;
    ay.d = y;
    ax.u = (ax.u & 0x7fffffffffffffffULL) | (ay.u & 0x8000000000000000ULL);
    return ax.d;
}
static inline float copysignf(float x, float y) {
    return (float) copysign((double) x, (double) y);
}

// C99 7.12.12.1: fdim(x, y) is the positive difference x - y when
// x > y, otherwise +0; a NaN argument propagates.
static inline double fdim(double x, double y) {
    return (x > y || x != x || y != y) ? x - y : 0.0;
}
static inline float fdimf(float x, float y) {
    return (float) fdim((double) x, (double) y);
}

double sqrt(double x);
double log(double x);
double log10(double x);
double log2(double x);
double exp(double x);
double pow(double base, double exp);
double floor(double x);
double ceil(double x);
double round(double x);
// C99 7.12.9.3 / 7.12.9.4: nearbyint / rint round to an integer value
// in floating-point format using the current rounding mode (rint may
// raise the inexact exception, nearbyint does not). 7.12.9.7: lround /
// llround round to the nearest integer, halfway cases away from zero,
// and return a long / long long.
double nearbyint(double x);
double rint(double x);
long lround(double x);
long long llround(double x);
// C99 7.12.9.5: lrint / llrint round to the nearest integer using the
// current rounding mode. 7.12.7.1 cbrt: cube root. 7.12.6.9 / 7.12.6.3
// log1p(x) = log(1+x), expm1(x) = exp(x)-1, accurate near zero.
// 7.12.10.2 remainder: IEEE remainder of x/y.
long lrint(double x);
long long llrint(double x);
double cbrt(double x);
double log1p(double x);
double expm1(double x);
double remainder(double x, double y);
double fabs(double x);
double fmod(double x, double y);
// C99 7.12.7.3: hypot(x, y) = sqrt(x*x + y*y) without overflow for
// representable results. C99 7.12.12.2 / 7.12.12.1: fmin / fmax return
// the lesser / greater operand, treating a single NaN as missing data.
double hypot(double x, double y);
double fmin(double x, double y);
double fmax(double x, double y);
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
// C99 7.12.5.1-3: inverse hyperbolic functions.
double asinh(double x);
double acosh(double x);
double atanh(double x);
// C99 7.12.8.3 / 7.12.8.1 / 7.12.8.2: gamma and error functions.
double tgamma(double x);
double erf(double x);
double erfc(double x);
// C99 7.12.6.6: ldexp(x, exp) = x * 2^exp.
double ldexp(double x, int exp);
// C99 7.12.6.13: scalbn / scalbln compute x * FLT_RADIX^n; with the
// binary radix here that is ldexp, so they forward to it.
static inline double scalbn(double x, int n) {
    return ldexp(x, n);
}
static inline double scalbln(double x, long n) {
    return ldexp(x, (int) n);
}
static inline float scalbnf(float x, int n) {
    return (float) ldexp((double) x, n);
}
static inline float scalblnf(float x, long n) {
    return (float) ldexp((double) x, (int) n);
}
// C99 7.12 long-double form. c5 aliases long double to double, so
// the prototype and the binding both reduce to the `ldexp` ABI.
double ldexpl(double x, int exp);
// C99 7.12.6.4: frexp(x, *exp) splits x into a normalised
// significand in [0.5, 1.0) and an integer exponent.
double frexp(double x, int *exp);
// C99 7.12.6.12: modf(x, *iptr) splits x into integer + fractional
// parts.
double modf(double x, double *iptr);
// C99 7.12.11.3: nextafter(x, y) is the next representable value after
// x toward y. 7.12.6.5: ilogb(x) is the integer exponent of x.
double nextafter(double x, double y);
int ilogb(double x);
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
float nextafterf(float x, float y);
int ilogbf(float x);
float sinf(float x);
float cosf(float x);
float tanf(float x);
float atanf(float x);
float atan2f(float y, float x);
float asinf(float x);
float acosf(float x);
float asinhf(float x);
float acoshf(float x);
float atanhf(float x);
float tgammaf(float x);
float erff(float x);
float erfcf(float x);
float hypotf(float x, float y);
float fminf(float x, float y);
float fmaxf(float x, float y);
float nearbyintf(float x);
float rintf(float x);
float cbrtf(float x);
float log1pf(float x);
float expm1f(float x);
float remainderf(float x, float y);

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
