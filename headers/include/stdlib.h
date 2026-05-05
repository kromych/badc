// stdlib.h -- general-purpose libc surface: allocator, conversions,
// process control.
//
// `exit` on Windows binds to `kernel32!ExitProcess`, which doesn't
// run msvcrt's atexit / stream flushing. For a c5 program that's
// what you usually want -- the alternative is `msvcrt!exit` which
// pulls in CRT init the rest of our binary doesn't perform. If a
// fixture starts caring about stdout being flushed on exit on
// Windows, that's the lever to pull.

#pragma once

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
#pragma binding(libc::atexit,  "atexit")
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
#pragma binding(kernel32::exit,    "ExitProcess")
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
int atexit(int *handler);
int strtoul(char *s, char **endp, int base);
int mkstemp(char *templ);
char *mkdtemp(char *templ);
char *mktemp(char *templ);
int random();
int srandom(int seed);
