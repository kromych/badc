/* C99 7.6 floating-point environment. Macro values and the layouts of
** fenv_t and fexcept_t must match the CRT that implements the
** functions: hardware encodings on Linux/macOS (x87/SSE control word on
** x86_64, FPCR on aarch64), the UCRT's abstract values on Windows. */
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

#ifdef _WIN32
typedef unsigned long fexcept_t;
typedef struct fenv_t {
    unsigned long _Fe_ctl, _Fe_stat;
} fenv_t;
#elif defined(__APPLE__)
typedef unsigned short fexcept_t;
typedef struct {
    unsigned long long __fpsr;
    unsigned long long __fpcr;
} fenv_t;
#elif defined(__aarch64__)
typedef unsigned int fexcept_t;
typedef struct {
    unsigned int __fpcr;
    unsigned int __fpsr;
} fenv_t;
#else
/* The x87 fnstenv block, then MXCSR. */
typedef unsigned short fexcept_t;
typedef struct {
    unsigned short __control_word, __reserved1;
    unsigned short __status_word, __reserved2;
    unsigned short __tags, __reserved3;
    unsigned int __eip;
    unsigned short __cs_selector, __opcode;
    unsigned int __data_offset;
    unsigned short __data_selector, __reserved4;
    unsigned int __mxcsr;
} fenv_t;
#endif

/* glibc takes a sentinel; libSystem and the UCRT read a default object. */
#ifdef __linux__
#define FE_DFL_ENV ((const fenv_t *)-1)
#else
#ifdef __APPLE__
static const fenv_t __c5_fe_dfl_env = {0, 0};
#elif defined(__aarch64__)
static const fenv_t __c5_fe_dfl_env = {0x3f, 0};
#else
static const fenv_t __c5_fe_dfl_env = {0x3f00003f, 0};
#endif
#define FE_DFL_ENV (&__c5_fe_dfl_env)
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::fegetround,   "_fegetround")
#pragma binding(libc::fesetround,   "_fesetround")
#pragma binding(libc::feclearexcept, "_feclearexcept")
#pragma binding(libc::fetestexcept, "_fetestexcept")
#pragma binding(libc::feraiseexcept, "_feraiseexcept")
#pragma binding(libc::fegetexceptflag, "_fegetexceptflag")
#pragma binding(libc::fesetexceptflag, "_fesetexceptflag")
#pragma binding(libc::fegetenv, "_fegetenv")
#pragma binding(libc::feholdexcept, "_feholdexcept")
#pragma binding(libc::fesetenv, "_fesetenv")
#pragma binding(libc::feupdateenv, "_feupdateenv")
#elif defined(__linux__)
#pragma dylib(libm, "libm.so.6")
#pragma binding(libm::fegetround,   "fegetround")
#pragma binding(libm::fesetround,   "fesetround")
#pragma binding(libm::feclearexcept, "feclearexcept")
#pragma binding(libm::fetestexcept, "fetestexcept")
#pragma binding(libm::feraiseexcept, "feraiseexcept")
#pragma binding(libm::fegetexceptflag, "fegetexceptflag")
#pragma binding(libm::fesetexceptflag, "fesetexceptflag")
#pragma binding(libm::fegetenv, "fegetenv")
#pragma binding(libm::feholdexcept, "feholdexcept")
#pragma binding(libm::fesetenv, "fesetenv")
#pragma binding(libm::feupdateenv, "feupdateenv")
#elif defined(_WIN32)
/* Legacy msvcrt.dll predates C99 fenv; the UCRT exports it. */
#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::fegetround,   "fegetround")
#pragma binding(ucrtbase::fesetround,   "fesetround")
#pragma binding(ucrtbase::feclearexcept, "feclearexcept")
#pragma binding(ucrtbase::fetestexcept, "fetestexcept")
#pragma binding(ucrtbase::fegetexceptflag, "fegetexceptflag")
#pragma binding(ucrtbase::fesetexceptflag, "fesetexceptflag")
#pragma binding(ucrtbase::fegetenv, "fegetenv")
#pragma binding(ucrtbase::feholdexcept, "feholdexcept")
#pragma binding(ucrtbase::fesetenv, "fesetenv")
// feraiseexcept and feupdateenv are libc/lib/fenv_ext.c's: no C runtime
// DLL exports them.
#endif

int fegetround(void);
int fesetround(int round);
int feclearexcept(int excepts);
int fetestexcept(int excepts);
int feraiseexcept(int excepts);
int fegetexceptflag(fexcept_t *flagp, int excepts);
int fesetexceptflag(const fexcept_t *flagp, int excepts);
int fegetenv(fenv_t *envp);
int feholdexcept(fenv_t *envp);
int fesetenv(const fenv_t *envp);
int feupdateenv(const fenv_t *envp);
