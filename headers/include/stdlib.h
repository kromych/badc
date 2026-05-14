// stdlib.h -- general-purpose libc surface: allocator, conversions,
// process control.
//
// `exit` on Windows binds to `msvcrt!exit`, which runs the CRT's
// atexit chain + flushes stdout / stderr before terminating. The
// previous binding (`kernel32!ExitProcess`) was chosen back when
// no fixture depended on stdio flushing -- a fast, no-init exit
// for the small fixtures that just `return 0`. sqlite's shell
// changed that: a piped `printf "select 1;" | sqlite3 :memory:`
// run produced empty output with `ExitProcess` because every
// SELECT row sat in stdout's fully-buffered pipe and got
// discarded on the unflushed exit. msvcrt's `exit` is already
// loaded for everything else we link, so the CRT-init concern
// from the original comment doesn't apply to programs that
// touch stdio at all.

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
#pragma binding(libc::atof,    "_atof")
#pragma binding(libc::strtol,  "_strtol")
#pragma binding(libc::strtoll, "_strtoll")
#pragma binding(libc::strtod,  "_strtod")
#pragma binding(libc::strtold, "_strtold")
#pragma binding(libc::abs,     "_abs")
#pragma binding(libc::abort,   "_abort")
#pragma binding(libc::exit,    "_exit")
#pragma binding(libc::system,  "_system")
#pragma binding(libc::getenv,  "_getenv")
#pragma binding(libc::setenv,  "_setenv")
#pragma binding(libc::qsort,   "_qsort")
#pragma binding(libc::bsearch, "_bsearch")
#pragma binding(libc::rand,    "_rand")
#pragma binding(libc::srand,   "_srand")
#pragma binding(libc::atexit,  "_atexit")
#pragma binding(libc::strtoul, "_strtoul")
#pragma binding(libc::mkstemp, "_mkstemp")
#pragma binding(libc::mkdtemp, "_mkdtemp")
#pragma binding(libc::mktemp,  "_mktemp")
#pragma binding(libc::div,     "_div")
#pragma binding(libc::ldiv,    "_ldiv")
#pragma binding(libc::random,  "_random")
#pragma binding(libc::srandom, "_srandom")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::malloc,  "malloc")
#pragma binding(libc::calloc,  "calloc")
#pragma binding(libc::realloc, "realloc")
#pragma binding(libc::free,    "free")
#pragma binding(libc::atoi,    "atoi")
#pragma binding(libc::atol,    "atol")
#pragma binding(libc::atof,    "atof")
#pragma binding(libc::strtol,  "strtol")
#pragma binding(libc::strtoll, "strtoll")
#pragma binding(libc::strtod,  "strtod")
#pragma binding(libc::strtold, "strtold")
#pragma binding(libc::abs,     "abs")
#pragma binding(libc::abort,   "abort")
#pragma binding(libc::exit,    "exit")
#pragma binding(libc::system,  "system")
#pragma binding(libc::getenv,  "getenv")
#pragma binding(libc::setenv,  "setenv")
#pragma binding(libc::qsort,   "qsort")
#pragma binding(libc::bsearch, "bsearch")
#pragma binding(libc::rand,    "rand")
#pragma binding(libc::srand,   "srand")
// glibc doesn't export `atexit` as a regular dynamic symbol --
// it's an inline that calls per-DSO `__cxa_atexit(handler, NULL,
// dso_handle)`, so `dlsym(libc.so.6, "atexit")` returns NULL and
// any c5 binary that calls atexit fails at exec with
// "undefined symbol: atexit". Bind the underlying entrypoint
// directly and route atexit() through a header-side macro
// (declared further down), filling in NULL for both the closure
// arg and the dso handle. NULL as dso_handle is glibc's spelling
// for "register on the main program's exit chain."
#pragma binding(libc::__cxa_atexit, "__cxa_atexit")
#pragma binding(libc::strtoul, "strtoul")
#pragma binding(libc::mkstemp, "mkstemp")
#pragma binding(libc::mkdtemp, "mkdtemp")
#pragma binding(libc::mktemp,  "mktemp")
#pragma binding(libc::div,     "div")
#pragma binding(libc::ldiv,    "ldiv")
#pragma binding(libc::random,  "random")
#pragma binding(libc::srandom, "srandom")
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
#pragma binding(msvcrt::atof,    "atof")
#pragma binding(msvcrt::strtol,  "strtol")
// MSVC has _strtoi64; strtoll itself only landed in UCRT.
#pragma binding(msvcrt::strtoll, "_strtoi64")
#pragma binding(msvcrt::strtod,  "strtod")
// msvcrt has no `strtold`; UCRT has it but msvcrt.dll itself
// only ships strtod. The chibicc bringup currently targets
// macOS / Linux; Windows resolution lands when the rest of
// the bringup catches up.
#pragma binding(msvcrt::abs,     "abs")
#pragma binding(msvcrt::abort,   "abort")
#pragma binding(msvcrt::system,  "system")
#pragma binding(msvcrt::getenv,  "getenv")
// msvcrt's `setenv` is the underscored `_putenv_s`. Same shape:
// (name, value, overwrite) -> int.
#pragma binding(msvcrt::setenv,    "_putenv_s")
#pragma binding(msvcrt::qsort,     "qsort")
#pragma binding(msvcrt::bsearch,   "bsearch")
#pragma binding(msvcrt::rand,      "rand")
#pragma binding(msvcrt::srand,     "srand")
#pragma binding(msvcrt::exit,      "exit")
// msvcrt's atexit() takes a `void (*)(void)` and registers it on
// the CRT's exit chain. On Linux glibc doesn't export atexit as
// a regular dynamic symbol so the `#ifdef __linux__` branch
// below routes through `__cxa_atexit(handler, NULL, NULL)`;
// msvcrt exports the bare `atexit` directly so we bind it as
// itself.
#pragma binding(msvcrt::atexit,    "atexit")
#endif

char *malloc(int size);
char *calloc(int n, int size);
char *realloc(char *ptr, int size);
int free(char *ptr);
int atoi(char *s);
int atol(char *s);
double atof(char *s);
int strtol(char *s, char **endp, int base);
int strtoll(char *s, char **endp, int base);
double strtod(char *s, char **endp);
#ifndef _WIN32
// `long double` falls back to f64 in c5 (16-byte storage, 8-byte
// precision) -- the return value flows through the long-double
// load/store pipeline; the libc-side conversion happens at full
// 80-bit precision and gets narrowed on the way back.
long double strtold(char *s, char **endp);
#endif
int abs(int x);
int abort();
int exit(int status);
int system(char *cmd);
char *getenv(char *name);
int setenv(char *name, char *value, int overwrite);
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
int strtoul(char *s, char **endp, int base);
int mkstemp(char *templ);
char *mkdtemp(char *templ);
char *mktemp(char *templ);
int random();
int srandom(int seed);
