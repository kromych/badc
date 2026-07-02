/* C99 7.6 floating-point environment: the rounding-mode and
** exception-flag surface. Macro values must match the CRT that
** implements the functions: hardware encodings on Linux/macOS
** (x87/SSE control word on x86_64, FPCR on aarch64), the UCRT's
** abstract values on Windows. fegetenv/feholdexcept and the
** environment object are TODO. */
#pragma once

#ifdef _WIN32
#define FE_TONEAREST  0x000
#define FE_DOWNWARD   0x100
#define FE_UPWARD     0x200
#define FE_TOWARDZERO 0x300
#define FE_INEXACT    0x01
#define FE_UNDERFLOW  0x02
#define FE_OVERFLOW   0x04
#define FE_DIVBYZERO  0x08
#define FE_INVALID    0x10
#define FE_ALL_EXCEPT 0x1f
#elif defined(__aarch64__)
#define FE_TONEAREST  0x000000
#define FE_UPWARD     0x400000
#define FE_DOWNWARD   0x800000
#define FE_TOWARDZERO 0xc00000
#define FE_INVALID    0x01
#define FE_DIVBYZERO  0x02
#define FE_OVERFLOW   0x04
#define FE_UNDERFLOW  0x08
#define FE_INEXACT    0x10
#define FE_ALL_EXCEPT 0x1f
#else
#define FE_TONEAREST  0x000
#define FE_DOWNWARD   0x400
#define FE_UPWARD     0x800
#define FE_TOWARDZERO 0xc00
#define FE_INVALID    0x01
#define FE_DIVBYZERO  0x04
#define FE_OVERFLOW   0x08
#define FE_UNDERFLOW  0x10
#define FE_INEXACT    0x20
#define FE_ALL_EXCEPT 0x3d
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::fegetround,   "_fegetround")
#pragma binding(libc::fesetround,   "_fesetround")
#pragma binding(libc::feclearexcept, "_feclearexcept")
#pragma binding(libc::fetestexcept, "_fetestexcept")
#pragma binding(libc::feraiseexcept, "_feraiseexcept")
#elif defined(__linux__)
#pragma dylib(libm, "libm.so.6")
#pragma binding(libm::fegetround,   "fegetround")
#pragma binding(libm::fesetround,   "fesetround")
#pragma binding(libm::feclearexcept, "feclearexcept")
#pragma binding(libm::fetestexcept, "fetestexcept")
#pragma binding(libm::feraiseexcept, "feraiseexcept")
#elif defined(_WIN32)
/* Legacy msvcrt.dll predates C99 fenv; the UCRT exports it. */
#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::fegetround,   "fegetround")
#pragma binding(ucrtbase::fesetround,   "fesetround")
#pragma binding(ucrtbase::feclearexcept, "feclearexcept")
#pragma binding(ucrtbase::fetestexcept, "fetestexcept")
#pragma binding(ucrtbase::feraiseexcept, "feraiseexcept")
#endif

int fegetround(void);
int fesetround(int round);
int feclearexcept(int excepts);
int fetestexcept(int excepts);
int feraiseexcept(int excepts);
