// stdlib.h -- general-purpose libc surface: allocator, conversions,
// process control.
//
// `exit` on Windows binds to `msvcrt!exit`, which runs the CRT's
// atexit chain + flushes stdout / stderr before terminating per
// C99 7.20.4.3p2. The earlier binding (`kernel32!ExitProcess`)
// terminates without draining buffered stdio streams, so a
// program writing through fully-buffered stdout to a pipe loses
// every row that sat unflushed at exit. msvcrt's `exit` is
// already loaded for everything else we link, so the CRT-init
// concern from the original comment doesn't apply to programs
// that touch stdio at all.

#pragma once

// C99 7.20: `<stdlib.h>` exposes `size_t` (and the canonical
// `NULL`). Pull `<stddef.h>` so any code that reaches for
// `size_t` after `#include <stdlib.h>` sees it without having
// to know `<stddef.h>` is the underlying source. Re-include is
// guarded by `<stddef.h>`'s own `#pragma once`.
#include <stddef.h>

#ifndef NULL
#define NULL 0
#endif

#define EXIT_SUCCESS 0
#define EXIT_FAILURE 1
#define RAND_MAX 0x7FFFFFFF

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::malloc,  "_malloc")
#pragma binding(libc::calloc,  "_calloc")
#pragma binding(libc::realloc, "_realloc")
#pragma binding(libc::free,    "_free")
#pragma binding(libc::atoi,    "_atoi")
#pragma binding(libc::atol,    "_atol")
#pragma binding(libc::atoll,   "_atoll")
#pragma binding(libc::atof,    "_atof")
#pragma binding(libc::strtol,  "_strtol")
#pragma binding(libc::strtoll, "_strtoll")
#pragma binding(libc::strtod,  "_strtod")
// C99 7.20.1.3: `strtof` returns a `float`. The c5 dialect aliases
// `float` to `double` for ABI; binding routes to `_strtod` so the
// 64-bit FP return slot is filled correctly. The supplied string
// is the same; precision loss from float -> double is harmless.
#pragma binding(libc::strtof,  "_strtod")
#pragma binding(libc::strtold, "_strtold")
#pragma binding(libc::abs,     "_abs")
#pragma binding(libc::abort,   "_abort")
#pragma binding(libc::exit,    "_exit")
#pragma binding(libc::system,  "_system")
#pragma binding(libc::getenv,  "_getenv")
#pragma binding(libc::setenv,  "_setenv")
#pragma binding(libc::putenv,  "_putenv")
#pragma binding(libc::mbstowcs, "_mbstowcs")
#pragma binding(libc::wcstombs, "_wcstombs")
#pragma binding(libc::qsort,   "_qsort")
#pragma binding(libc::bsearch, "_bsearch")
#pragma binding(libc::rand,    "_rand")
#pragma binding(libc::srand,   "_srand")
#pragma binding(libc::atexit,  "_atexit")
#pragma binding(libc::strtoul, "_strtoul")
#pragma binding(libc::strtoull, "_strtoull")
#pragma binding(libc::mkstemp, "_mkstemp")
#pragma binding(libc::mkstemps, "_mkstemps")
#pragma binding(libc::mkdtemp, "_mkdtemp")
#pragma binding(libc::mktemp,  "_mktemp")
#pragma binding(libc::random,  "_random")
#pragma binding(libc::srandom, "_srandom")
#pragma binding(libc::grantpt,   "_grantpt")
#pragma binding(libc::unlockpt,  "_unlockpt")
#pragma binding(libc::posix_openpt,"_posix_openpt")
#pragma binding(libc::ptsname,   "_ptsname")
#pragma binding(libc::ptsname_r, "_ptsname_r")
#pragma binding(libc::getloadavg,"_getloadavg")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::malloc,  "malloc")
#pragma binding(libc::calloc,  "calloc")
#pragma binding(libc::realloc, "realloc")
#pragma binding(libc::free,    "free")
#pragma binding(libc::atoi,    "atoi")
#pragma binding(libc::atol,    "atol")
#pragma binding(libc::atoll,   "atoll")
#pragma binding(libc::atof,    "atof")
#pragma binding(libc::strtol,  "strtol")
#pragma binding(libc::strtoll, "strtoll")
#pragma binding(libc::strtod,  "strtod")
#pragma binding(libc::strtof,  "strtof")
#pragma binding(libc::strtold, "strtold")
#pragma binding(libc::abs,     "abs")
#pragma binding(libc::abort,   "abort")
#pragma binding(libc::exit,    "exit")
#pragma binding(libc::system,  "system")
#pragma binding(libc::getenv,  "getenv")
#pragma binding(libc::setenv,  "setenv")
#pragma binding(libc::putenv,  "putenv")
#pragma binding(libc::mbstowcs, "mbstowcs")
#pragma binding(libc::wcstombs, "wcstombs")
#pragma binding(libc::qsort,   "qsort")
#pragma binding(libc::bsearch, "bsearch")
#pragma binding(libc::rand,    "rand")
#pragma binding(libc::srand,   "srand")
// The Linux C library doesn't export `atexit` as a regular dynamic symbol --
// it's an inline that calls per-DSO `__cxa_atexit(handler, NULL,
// dso_handle)`, so `dlsym(libc.so.6, "atexit")` returns NULL and
// any c5 binary that calls atexit fails at exec with
// "undefined symbol: atexit". Bind the underlying entrypoint
// directly and route atexit() through a header-side macro
// (declared further down), filling in NULL for both the closure
// arg and the dso handle. NULL as dso_handle is the Linux C library's spelling
// for "register on the main program's exit chain."
#pragma binding(libc::__cxa_atexit, "__cxa_atexit")
#pragma binding(libc::strtoul, "strtoul")
#pragma binding(libc::strtoull, "strtoull")
#pragma binding(libc::mkstemp, "mkstemp")
#pragma binding(libc::mkstemps, "mkstemps")
#pragma binding(libc::mkdtemp, "mkdtemp")
#pragma binding(libc::mktemp,  "mktemp")
#pragma binding(libc::random,  "random")
#pragma binding(libc::srandom, "srandom")
#pragma binding(libc::grantpt,   "grantpt")
#pragma binding(libc::unlockpt,  "unlockpt")
#pragma binding(libc::posix_openpt,"posix_openpt")
#pragma binding(libc::ptsname,   "ptsname")
#pragma binding(libc::ptsname_r, "ptsname_r")
#pragma binding(libc::getloadavg,"getloadavg")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt,   "msvcrt.dll")
#pragma dylib(kernel32, "kernel32.dll")
#pragma binding(msvcrt::malloc,  "malloc")
#pragma binding(msvcrt::calloc,  "calloc")
#pragma binding(msvcrt::realloc, "realloc")
#pragma binding(msvcrt::free,    "free")
#pragma binding(msvcrt::atoi,    "atoi")
#pragma binding(msvcrt::atol,    "atol")
// MSVC spells the long-long parse `_atoi64`.
#pragma binding(msvcrt::atoll,   "_atoi64")
#pragma binding(msvcrt::atof,    "atof")
#pragma binding(msvcrt::strtol,  "strtol")
#pragma binding(msvcrt::strtoul, "strtoul")
// MSVC has _strtoi64; strtoll itself only landed in UCRT.
#pragma binding(msvcrt::strtoll, "_strtoi64")
// Underscored aliases for source compiled directly against the
// msvcrt spelling (typically through a per-platform `#define`).
#pragma binding(msvcrt::_strtoi64, "_strtoi64")
// Matching unsigned form -- `_strtoui64` is msvcrt's spelling for
// what every other libc calls `strtoull`.
#pragma binding(msvcrt::strtoull, "_strtoui64")
#pragma binding(msvcrt::_strtoui64, "_strtoui64")
#pragma binding(msvcrt::strtod,  "strtod")
#pragma binding(msvcrt::strtof,  "strtof")
// msvcrt.dll has no `strtold`; UCRT exports it but the
// universally-available CRT here does not. Programs that
// need `long double` parsing on Windows pin to UCRT.
#pragma binding(msvcrt::abs,     "abs")
#pragma binding(msvcrt::abort,   "abort")
#pragma binding(msvcrt::system,  "system")
#pragma binding(msvcrt::getenv,  "getenv")
// msvcrt's `setenv` is the underscored `_putenv_s`. Same shape:
// (name, value, overwrite) -> int.
#pragma binding(msvcrt::setenv,    "_putenv_s")
#pragma binding(msvcrt::_wputenv_s, "_wputenv_s")
#pragma binding(msvcrt::qsort,     "qsort")
#pragma binding(msvcrt::bsearch,   "bsearch")
#pragma binding(msvcrt::rand,      "rand")
#pragma binding(msvcrt::srand,     "srand")
#pragma binding(msvcrt::exit,      "exit")
// msvcrt's atexit() takes a `void (*)(void)` and registers it on
// the CRT's exit chain. On Linux the C library doesn't export atexit as
// a regular dynamic symbol so the `#ifdef __linux__` branch
// below routes through `__cxa_atexit(handler, NULL, NULL)`;
// msvcrt exports the bare `atexit` directly so we bind it as
// itself.
#pragma binding(msvcrt::atexit,    "atexit")
#pragma binding(msvcrt::_exit,     "_exit")
#pragma binding(msvcrt::mbstowcs,  "mbstowcs")
#pragma binding(msvcrt::wcstombs,  "wcstombs")
// CRT data exports: the system error table and the wide / narrow
// process environment blocks.
#pragma binding(data msvcrt::_sys_nerr,    "_sys_nerr")
#pragma binding(data msvcrt::_sys_errlist, "_sys_errlist")
#if defined(__aarch64__)
// The legacy arm64 msvcrt.dll does not export the `_wenviron` data
// symbol; UCRT exposes the wide environment only via this accessor.
#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::__p__wenviron, "__p__wenviron")
unsigned short ***__p__wenviron(void);
#define _wenviron (*__p__wenviron())
#else
#pragma binding(data msvcrt::_wenviron,    "_wenviron")
#endif
#pragma binding(data msvcrt::_environ,     "_environ")
// `_doserrno` is an SDK macro over the exported accessor `__doserrno`,
// which returns a pointer to the thread's OS error code.
#pragma binding(msvcrt::__doserrno, "__doserrno")
int *__doserrno(void);
#define _doserrno (*__doserrno())
extern int _sys_nerr;
extern char *_sys_errlist[];
// Deprecated non-underscore aliases the msvcrt headers still expose.
#define sys_nerr _sys_nerr
#define sys_errlist _sys_errlist
#if !defined(__aarch64__)
extern unsigned short **_wenviron;
#endif
extern char **_environ;
// MSVC CRT size limits (_makepath / _splitpath / environment).
#define _MAX_PATH   260
#define _MAX_DRIVE  3
#define _MAX_DIR    256
#define _MAX_FNAME  256
#define _MAX_EXT    256
#define _MAX_ENV    32767
#endif

char *malloc(int size);
char *calloc(int n, int size);
char *realloc(char *ptr, int size);
int free(char *ptr);
int atoi(char *s);
// C99 7.20.1.2: atol returns long. A libc return wider than the
// declared type is truncated to that type, so declaring it `int`
// would drop the high half on LP64.
long atol(char *s);
long long atoll(char *s);
double atof(char *s);
// C99 7.20.1.4: strtol/strtoll return long / long long; the declared
// width must match so the 64-bit return register is not narrowed.
long strtol(char *s, char **endp, int base);
long long strtoll(char *s, char **endp, int base);
long long _strtoi64(char *s, char **endp, int base);
double strtod(char *s, char **endp);
// C99 7.20.1.3. c5 stores every floating literal in `f64`, so
// the prototype declares the return as double; the binding above
// routes through strtod everywhere.
double strtof(char *s, char **endp);
#ifndef _WIN32
// `long double` falls back to f64 in c5 (16-byte storage, 8-byte
// precision) -- the return value flows through the long-double
// load/store pipeline; the libc-side conversion happens at full
// 80-bit precision and gets narrowed on the way back.
long double strtold(char *s, char **endp);
#endif
int abs(int x);
// C99 7.20.6.1: absolute value of a long / long long. Provided inline
// rather than through a libc binding because the result reduces to a
// sign test. Undefined when the value is not representable (LONG_MIN /
// LLONG_MIN), as the standard specifies.
static inline long labs(long x) {
    return x < 0 ? -x : x;
}
static inline long long llabs(long long x) {
    return x < 0 ? -x : x;
}
// C99 7.20.6.2: integer division yielding quotient and remainder
// together. The quotient is truncated toward zero (C99 6.5.5p6) and
// quot * denom + rem == numer, so these reduce to the / and %
// operators. Provided inline rather than through a libc binding
// because the result is a small aggregate returned by value, which c5
// marshals through its own struct-return path.
typedef struct {
    int quot;
    int rem;
} div_t;
typedef struct {
    long quot;
    long rem;
} ldiv_t;
typedef struct {
    long long quot;
    long long rem;
} lldiv_t;
static inline div_t div(int n, int d) {
    div_t r;
    r.quot = n / d;
    r.rem = n % d;
    return r;
}
static inline ldiv_t ldiv(long n, long d) {
    ldiv_t r;
    r.quot = n / d;
    r.rem = n % d;
    return r;
}
static inline lldiv_t lldiv(long long n, long long d) {
    lldiv_t r;
    r.quot = n / d;
    r.rem = n % d;
    return r;
}
// C99 7.20.4: abort / exit / _Exit do not return to the caller.
// `_Noreturn` lets the reachability analysis treat a call as not
// reaching its continuation.
_Noreturn int abort();
_Noreturn int exit(int status);
int system(char *cmd);
char *getenv(char *name);
int setenv(char *name, char *value, int overwrite);
int putenv(char *string);
// Multibyte / wide-character string conversion (C99 7.20.8). `wchar_t`
// and `size_t` come from <stddef.h>.
unsigned long mbstowcs(wchar_t *dest, const char *src, unsigned long n);
unsigned long wcstombs(char *dest, const wchar_t *src, unsigned long n);
int qsort(char *base, int n, int size, int *cmp);
char *bsearch(char *key, char *base, int n, int size, int *cmp);
int rand();
int srand(int seed);
#ifdef __linux__
// See the binding-block comment above. `__cxa_atexit` takes a
// 1-arg handler signature `void (*)(void *)`; c5 callees with
// 0 declared params silently ignore the host's first arg
// register.
int __cxa_atexit(int *handler, char *arg, char *dso);
#define atexit(handler) __cxa_atexit((handler), 0, 0)
#else
int atexit(int *handler);
#endif
// C99 7.20.1.4: strtoul returns unsigned long, strtoull returns
// unsigned long long. The declared width must match the libc return
// type; an `int` declaration truncates the result to its low 32 bits.
unsigned long strtoul(char *s, char **endp, int base);
unsigned long long strtoull(char *s, char **endp, int base);
unsigned long long _strtoui64(char *s, char **endp, int base);
#ifdef _WIN32
// msvcrt's `_spawn*` family takes a mode argument up front.
// `P_NOWAIT` returns the child handle immediately; the other
// modes block until the child exits.
#define P_WAIT          0
#define P_NOWAIT        1
#define P_OVERLAY       2
#define P_NOWAITO       3
#define P_DETACH        4
#pragma binding(msvcrt::_spawnvp,  "_spawnvp")
#pragma binding(msvcrt::_spawnv,   "_spawnv")
#pragma binding(msvcrt::_spawnl,   "_spawnl")
int _spawnvp(int mode, char *cmdname, char **argv);
int _spawnv(int mode, char *cmdname, char **argv);
int _spawnl(int mode, char *cmdname, char *arg0, ...);
// `_cwait` action flag: wait for the supplied child handle.
#define WAIT_CHILD       0
#define WAIT_GRANDCHILD  1
#pragma binding(msvcrt::_cwait, "_cwait")
int _cwait(int *termstat, int handle, int action);
// msvcrt path-resolution -- analogous to POSIX `realpath`.
// Resolves a relative path against the current directory and
// writes the canonical absolute form into `absPath`.
#pragma binding(msvcrt::_fullpath, "_fullpath")
char *_fullpath(char *absPath, char *relPath, int maxLength);
#endif
int mkstemp(char *templ);
int mkstemps(char *templ, int suffixlen);
char *mkdtemp(char *templ);
char *mktemp(char *templ);
int random();
int srandom(int seed);
// Pseudo-terminal master/slave setup (POSIX). ptsname returns the slave
// device path for the given master descriptor.
int posix_openpt(int flags);
int grantpt(int fd);
int unlockpt(int fd);
char *ptsname(int fd);
int ptsname_r(int fd, char *buf, unsigned long buflen);
// System load averages over 1/5/15 minutes (BSD).
int getloadavg(double *loadavg, int nelem);

/* GCC / clang `__clear_cache(begin, end)` is the runtime hint
** that makes instructions newly written into [begin, end)
** observable to the fetch path. AArch64 requires the explicit
** flush; x86_64 hardware keeps the instruction cache coherent
** so the call is effectively a no-op. Each platform exposes
** the flush through a different libc surface, so the wrappers
** below bridge the (begin, end) signature to the native
** (start, len) shape. The Linux C library exports __clear_cache
** directly. */
#ifdef __APPLE__
#pragma binding(libc::sys_icache_invalidate, "_sys_icache_invalidate")
void sys_icache_invalidate(void *start, long long len);
static inline void __clear_cache(void *begin, void *end) {
    sys_icache_invalidate(begin, (long long)((char *)end - (char *)begin));
}
#endif

#ifdef __linux__
/* The Linux C library does not export `__clear_cache`; the GCC / clang
** documented surface places the helper in libgcc_s.so.1. ARM
** ARM B2.4.4 requires explicit instruction-cache maintenance
** after a writer publishes new code -- AArch64 callers reach
** for `__clear_cache` to drive that sequence. x86_64 hardware
** keeps the instruction cache coherent with the data side, so
** the symbol stays unreferenced there. Pin the dylib explicitly
** so callers that do reach for it get a DT_NEEDED entry for
** libgcc_s.so.1 next to libc. */
#pragma dylib(libgcc_s, "libgcc_s.so.1")
#pragma binding(libgcc_s::__clear_cache, "__clear_cache")
void __clear_cache(void *begin, void *end);
/* AAPCS64 returns `long double` (IEEE binary128) in v0 as a
** single 128-bit Q register. c5 stores `long double` in an
** 8-byte FP64 slot, so callers of Linux C library functions that return
** `long double` (strtold, ldexpl, ...) need an explicit
** truncation pass after the call -- otherwise the c5 accumulator
** reads the low 64 bits of v0, which are zero for every power-
** of-two value. The libgcc helper `__trunctfdf2(long double) ->
** double` performs the IEEE-correct round-to-nearest-even
** narrowing; the aarch64 codegen emits a `bl __trunctfdf2` after
** any libc call whose binding carries `returns_long_double`. The
** declaration stays target-agnostic so that the binding is in
** scope when the codegen lowers for `LinuxAarch64`, even if the
** preprocessor ran for a different host target. On x86_64 the
** call is never emitted; the symbol stays unreferenced and
** libgcc_s.so.1 is not pulled in as a `DT_NEEDED`. */
#pragma binding(libgcc_s::__trunctfdf2, "__trunctfdf2")
double __trunctfdf2(long double a);
#endif

#ifdef _WIN32
#pragma binding(kernel32::FlushInstructionCache, "FlushInstructionCache")
#pragma binding(kernel32::GetCurrentProcess, "GetCurrentProcess")
int FlushInstructionCache(void *hProcess, void *lpBaseAddress, long long dwSize);
void *GetCurrentProcess(void);
static inline void __clear_cache(void *begin, void *end) {
    FlushInstructionCache(GetCurrentProcess(), begin,
                          (long long)((char *)end - (char *)begin));
}
// msvcrt exposes the environment vector through the `_environ`
// data symbol. Both `environ` and `_environ` live in
// `lib/runtime.c` as single canonical definitions; user code
// declares each `extern` here so every TU resolves through the
// same slot rather than contributing a tentative def of its
// own.
// TODO: bind msvcrt's `_environ` directly via `#pragma binding`'s
// data form. The form is wired for ELF (COPY relocation) and Mach-O
// (GOT import); the PE writer has no data-import path yet, so the
// local slot stays until that lands.
extern char **environ;
extern char **_environ;
#endif
