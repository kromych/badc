// tgmath.h -- C99 (7.22) type-generic math. Each macro names the
// <math.h> function of the type its generic arguments determine
// (7.22p3): `long double` if any of them has that type, else `double`
// if any is `double` or an integer type, else `float`. The complex
// selections are absent while __STDC_NO_COMPLEX__ is defined.
//
// `+(x)` drops qualifiers and promotes an integer argument, which then
// takes the `double` association; the sum of the promoted arguments has
// the type 7.22p3 determines.

#pragma once

#include <math.h>

#define __tg_real(x) _Generic(+(x), float: 0.0f, long double: 0.0L, default: 0.0)
#define __tg_select(t, fn) _Generic((t), float: fn##f, long double: fn##l, default: fn)
#define __tg1(fn, x) __tg_select(__tg_real(x), fn)(x)
#define __tg1x(fn, x, y) __tg_select(__tg_real(x), fn)(x, y)
#define __tg2(fn, x, y) __tg_select(__tg_real(x) + __tg_real(y), fn)(x, y)
#define __tg2x(fn, x, y, z) __tg_select(__tg_real(x) + __tg_real(y), fn)(x, y, z)
#define __tg3(fn, x, y, z) \
    __tg_select(__tg_real(x) + __tg_real(y) + __tg_real(z), fn)(x, y, z)

#define acos(x) __tg1(acos, x)
#define asin(x) __tg1(asin, x)
#define atan(x) __tg1(atan, x)
#define acosh(x) __tg1(acosh, x)
#define asinh(x) __tg1(asinh, x)
#define atanh(x) __tg1(atanh, x)
#define cos(x) __tg1(cos, x)
#define sin(x) __tg1(sin, x)
#define tan(x) __tg1(tan, x)
#define cosh(x) __tg1(cosh, x)
#define sinh(x) __tg1(sinh, x)
#define tanh(x) __tg1(tanh, x)
#define exp(x) __tg1(exp, x)
#define log(x) __tg1(log, x)
#define pow(x, y) __tg2(pow, x, y)
#define sqrt(x) __tg1(sqrt, x)
#define fabs(x) __tg1(fabs, x)

#define atan2(y, x) __tg2(atan2, y, x)
#define cbrt(x) __tg1(cbrt, x)
#define ceil(x) __tg1(ceil, x)
#define copysign(x, y) __tg2(copysign, x, y)
#define erf(x) __tg1(erf, x)
#define erfc(x) __tg1(erfc, x)
#define exp2(x) __tg1(exp2, x)
#define expm1(x) __tg1(expm1, x)
#define fdim(x, y) __tg2(fdim, x, y)
#define floor(x) __tg1(floor, x)
#define fma(x, y, z) __tg3(fma, x, y, z)
#define fmax(x, y) __tg2(fmax, x, y)
#define fmin(x, y) __tg2(fmin, x, y)
#define fmod(x, y) __tg2(fmod, x, y)
#define frexp(x, e) __tg1x(frexp, x, e)
#define hypot(x, y) __tg2(hypot, x, y)
#define ilogb(x) __tg1(ilogb, x)
#define ldexp(x, e) __tg1x(ldexp, x, e)
#define lgamma(x) __tg1(lgamma, x)
#define llrint(x) __tg1(llrint, x)
#define llround(x) __tg1(llround, x)
#define log10(x) __tg1(log10, x)
#define log1p(x) __tg1(log1p, x)
#define log2(x) __tg1(log2, x)
#define logb(x) __tg1(logb, x)
#define lrint(x) __tg1(lrint, x)
#define lround(x) __tg1(lround, x)
#define nearbyint(x) __tg1(nearbyint, x)
#define nextafter(x, y) __tg2(nextafter, x, y)
#define nexttoward(x, y) __tg1x(nexttoward, x, y)
#define remainder(x, y) __tg2(remainder, x, y)
#define remquo(x, y, q) __tg2x(remquo, x, y, q)
#define rint(x) __tg1(rint, x)
#define round(x) __tg1(round, x)
#define scalbn(x, n) __tg1x(scalbn, x, n)
#define scalbln(x, n) __tg1x(scalbln, x, n)
#define tgamma(x) __tg1(tgamma, x)
#define trunc(x) __tg1(trunc, x)
