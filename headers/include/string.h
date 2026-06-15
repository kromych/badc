// string.h -- POSIX string + memory routines.
//
// Per-target gating picks the right dylib + symbol name:
//   * macOS: libSystem, with the leading underscore Mach-O wants.
//   * Linux: libc.so.6.
//   * Windows: msvcrt.dll.
//
// `local_name` (the LHS of each `#pragma binding`) is always the
// portable C name; `real_symbol` (the RHS) is whatever the target
// dylib actually exports. Source code keeps using the portable
// spelling regardless of platform.

#pragma once

// C99 7.21: `<string.h>` exposes `size_t`. Pull `<stddef.h>`
// so `size_t` reaches every TU that includes `<string.h>`,
// matching glibc / clang / MSVC.
#include <stddef.h>

#ifndef NULL
#define NULL 0
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::memset,   "_memset")
#pragma binding(libc::memcmp,   "_memcmp")
#pragma binding(libc::memcpy,   "_memcpy")
#pragma binding(libc::memmove,  "_memmove")
#pragma binding(libc::memchr,   "_memchr")
#pragma binding(libc::strlen,   "_strlen")
#pragma binding(libc::strcpy,   "_strcpy")
#pragma binding(libc::strncpy,  "_strncpy")
#pragma binding(libc::strcmp,   "_strcmp")
#pragma binding(libc::strncmp,  "_strncmp")
#pragma binding(libc::strcoll,  "_strcoll")
#pragma binding(libc::strxfrm,  "_strxfrm")
#pragma binding(libc::strchr,   "_strchr")
#pragma binding(libc::strrchr,  "_strrchr")
#pragma binding(libc::strstr,   "_strstr")
#pragma binding(libc::strcat,   "_strcat")
#pragma binding(libc::strncat,  "_strncat")
#pragma binding(libc::strerror, "_strerror")
#pragma binding(libc::strdup,   "_strdup")
#pragma binding(libc::strndup,  "_strndup")
#pragma binding(libc::strspn,   "_strspn")
#pragma binding(libc::strcspn,  "_strcspn")
#pragma binding(libc::strpbrk,  "_strpbrk")
#pragma binding(libc::strtok,   "_strtok")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::memset,   "memset")
#pragma binding(libc::memcmp,   "memcmp")
#pragma binding(libc::memcpy,   "memcpy")
#pragma binding(libc::memmove,  "memmove")
#pragma binding(libc::memchr,   "memchr")
#pragma binding(libc::strlen,   "strlen")
#pragma binding(libc::strcpy,   "strcpy")
#pragma binding(libc::strncpy,  "strncpy")
#pragma binding(libc::strcmp,   "strcmp")
#pragma binding(libc::strncmp,  "strncmp")
#pragma binding(libc::strcoll,  "strcoll")
#pragma binding(libc::strxfrm,  "strxfrm")
#pragma binding(libc::strchr,   "strchr")
#pragma binding(libc::strrchr,  "strrchr")
#pragma binding(libc::strstr,   "strstr")
#pragma binding(libc::strcat,   "strcat")
#pragma binding(libc::strncat,  "strncat")
#pragma binding(libc::strerror, "strerror")
#pragma binding(libc::strdup,   "strdup")
#pragma binding(libc::strndup,  "strndup")
#pragma binding(libc::strspn,   "strspn")
#pragma binding(libc::strcspn,  "strcspn")
#pragma binding(libc::strpbrk,  "strpbrk")
#pragma binding(libc::strtok,   "strtok")
// glibc extension: returns a pointer to the first occurrence of `c`,
// or the terminating NUL if `c` is not found. No macOS / msvcrt export.
#pragma binding(libc::strchrnul, "strchrnul")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::memset,   "memset")
#pragma binding(msvcrt::memcmp,   "memcmp")
#pragma binding(msvcrt::memcpy,   "memcpy")
#pragma binding(msvcrt::memmove,  "memmove")
#pragma binding(msvcrt::memchr,   "memchr")
#pragma binding(msvcrt::strlen,   "strlen")
#pragma binding(msvcrt::strcpy,   "strcpy")
#pragma binding(msvcrt::strncpy,  "strncpy")
#pragma binding(msvcrt::strcmp,   "strcmp")
#pragma binding(msvcrt::strncmp,  "strncmp")
#pragma binding(msvcrt::strcoll,  "strcoll")
#pragma binding(msvcrt::strxfrm,  "strxfrm")
#pragma binding(msvcrt::strchr,   "strchr")
#pragma binding(msvcrt::strrchr,  "strrchr")
#pragma binding(msvcrt::strstr,   "strstr")
#pragma binding(msvcrt::strcat,   "strcat")
#pragma binding(msvcrt::strncat,  "strncat")
#pragma binding(msvcrt::strerror, "strerror")
// MSVC marks `strdup` as deprecated and exports the underscored form;
// it's the universally available spelling on every modern msvcrt.
#pragma binding(msvcrt::strdup,   "_strdup")
// msvcrt has no `strndup` (POSIX.1-2008 7.24.1.4); programs
// that need the bounded copy on Windows emulate via
// `strnlen` + `malloc` + `memcpy`.
#pragma binding(msvcrt::strspn,   "strspn")
#pragma binding(msvcrt::strcspn,  "strcspn")
#pragma binding(msvcrt::strpbrk,  "strpbrk")
#pragma binding(msvcrt::strtok,   "strtok")
// Case-insensitive compares: msvcrt's POSIX-style names live
// behind a leading underscore. Expose both spellings so source
// reaching for the underscored direct form resolves the same
// way as source using the POSIX alias.
#pragma binding(msvcrt::stricmp,   "_stricmp")
#pragma binding(msvcrt::_stricmp,  "_stricmp")
#pragma binding(msvcrt::strnicmp,  "_strnicmp")
#pragma binding(msvcrt::_strnicmp, "_strnicmp")
// In-place case conversions; msvcrt exposes both as
// underscored entries.
#pragma binding(msvcrt::strlwr,    "_strlwr")
#pragma binding(msvcrt::_strlwr,   "_strlwr")
#pragma binding(msvcrt::strupr,    "_strupr")
#pragma binding(msvcrt::_strupr,   "_strupr")
#endif

char *memset(char *dst, int byte, int n);
int memcmp(char *a, char *b, int n);
char *memcpy(char *dst, char *src, int n);
char *memmove(char *dst, char *src, int n);
char *memchr(char *s, int c, int n);
int strlen(char *s);
char *strcpy(char *dst, char *src);
char *strncpy(char *dst, char *src, int n);
int strcmp(char *a, char *b);
int strncmp(char *a, char *b, int n);
// C99 7.21.4.3: locale-aware string compare. Returns a value
// whose sign matches the LC_COLLATE ordering of `a` vs `b`.
int strcoll(char *a, char *b);
// C99 7.21.4.5: transform `src` into a buffer suitable for
// `memcmp`-style comparison under the current LC_COLLATE.
int strxfrm(char *dst, char *src, int n);
char *strchr(char *s, int c);
char *strrchr(char *s, int c);
char *strstr(char *haystack, char *needle);
char *strcat(char *dst, char *src);
char *strncat(char *dst, char *src, int n);
char *strerror(int errnum);
char *strdup(char *s);
#ifndef _WIN32
// POSIX.1-2008 7.24.1.4 `strndup` -- C2x but not in C99
// `<string.h>`. Bound on macOS / Linux; msvcrt has no
// equivalent so the prototype is gated out on Windows.
char *strndup(char *s, int n);
#endif
int strspn(char *s, char *accept);
int strcspn(char *s, char *reject);
char *strpbrk(char *s, char *accept);
char *strtok(char *s, char *delim);
#ifdef __linux__
// glibc extension, declared only where it is bound.
char *strchrnul(const char *s, int c);
#endif
#ifdef _WIN32
// Case-insensitive compares -- msvcrt-only, no POSIX equivalent
// in the c5 surface. Names match the underscored entries
// programs reach for directly; the POSIX aliases (stricmp /
// strnicmp / strlwr / strupr) bind to the same symbols.
int stricmp(char *a, char *b);
int _stricmp(char *a, char *b);
int strnicmp(char *a, char *b, int n);
int _strnicmp(char *a, char *b, int n);
char *strlwr(char *s);
char *_strlwr(char *s);
char *strupr(char *s);
char *_strupr(char *s);
#endif
