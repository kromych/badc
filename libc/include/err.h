#pragma once

// err.h -- BSD-style formatted error and warning messages.

#include <stdarg.h>

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::err,    "err")
#pragma binding(libc::errx,   "errx")
#pragma binding(libc::warn,   "warn")
#pragma binding(libc::warnx,  "warnx")
#pragma binding(libc::verr,   "verr")
#pragma binding(libc::verrx,  "verrx")
#pragma binding(libc::vwarn,  "vwarn")
#pragma binding(libc::vwarnx, "vwarnx")
#endif

// The err/errx family prints the message and exits with eval.
_Noreturn void err(int eval, const char *fmt, ...);
_Noreturn void errx(int eval, const char *fmt, ...);
_Noreturn void verr(int eval, const char *fmt, va_list ap);
_Noreturn void verrx(int eval, const char *fmt, va_list ap);

// The warn/warnx family prints the message and returns.
void warn(const char *fmt, ...);
void warnx(const char *fmt, ...);
void vwarn(const char *fmt, va_list ap);
void vwarnx(const char *fmt, va_list ap);
