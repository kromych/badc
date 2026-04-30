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

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::malloc, "_malloc")
#pragma binding(libc::free,   "_free")
#pragma binding(libc::atoi,   "_atoi")
#pragma binding(libc::atol,   "_atol")
#pragma binding(libc::abs,    "_abs")
#pragma binding(libc::abort,  "_abort")
#pragma binding(libc::exit,   "_exit")
#pragma binding(libc::system, "_system")
#pragma binding(libc::getenv, "_getenv")
#pragma binding(libc::setenv, "_setenv")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::malloc, "malloc")
#pragma binding(libc::free,   "free")
#pragma binding(libc::atoi,   "atoi")
#pragma binding(libc::atol,   "atol")
#pragma binding(libc::abs,    "abs")
#pragma binding(libc::abort,  "abort")
#pragma binding(libc::exit,   "exit")
#pragma binding(libc::system, "system")
#pragma binding(libc::getenv, "getenv")
#pragma binding(libc::setenv, "setenv")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt,   "msvcrt.dll")
#pragma dylib(kernel32, "kernel32.dll")
#pragma binding(msvcrt::malloc, "malloc")
#pragma binding(msvcrt::free,   "free")
#pragma binding(msvcrt::atoi,   "atoi")
#pragma binding(msvcrt::atol,   "atol")
#pragma binding(msvcrt::abs,    "abs")
#pragma binding(msvcrt::abort,  "abort")
#pragma binding(msvcrt::system, "system")
#pragma binding(msvcrt::getenv, "getenv")
// msvcrt's `setenv` is the underscored `_putenv_s`. Same shape:
// (name, value, overwrite) -> int.
#pragma binding(msvcrt::setenv,   "_putenv_s")
#pragma binding(kernel32::exit,   "ExitProcess")
#endif

char *malloc(int size);
int free(char *ptr);
int atoi(char *s);
int atol(char *s);
int abs(int x);
int abort();
int exit(int status);
int system(char *cmd);
char *getenv(char *name);
int setenv(char *name, char *value, int overwrite);
