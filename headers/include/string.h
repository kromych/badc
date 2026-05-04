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
#pragma binding(libc::strchr,   "_strchr")
#pragma binding(libc::strrchr,  "_strrchr")
#pragma binding(libc::strstr,   "_strstr")
#pragma binding(libc::strcat,   "_strcat")
#pragma binding(libc::strncat,  "_strncat")
#pragma binding(libc::strerror, "_strerror")
#pragma binding(libc::strdup,   "_strdup")
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
#pragma binding(libc::strchr,   "strchr")
#pragma binding(libc::strrchr,  "strrchr")
#pragma binding(libc::strstr,   "strstr")
#pragma binding(libc::strcat,   "strcat")
#pragma binding(libc::strncat,  "strncat")
#pragma binding(libc::strerror, "strerror")
#pragma binding(libc::strdup,   "strdup")
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
#pragma binding(msvcrt::strchr,   "strchr")
#pragma binding(msvcrt::strrchr,  "strrchr")
#pragma binding(msvcrt::strstr,   "strstr")
#pragma binding(msvcrt::strcat,   "strcat")
#pragma binding(msvcrt::strncat,  "strncat")
#pragma binding(msvcrt::strerror, "strerror")
// MSVC marks `strdup` as deprecated and exports the underscored form;
// it's the universally available spelling on every modern msvcrt.
#pragma binding(msvcrt::strdup,   "_strdup")
#endif

// Portable prototypes -- `char` is one byte, `int` is the c4 machine
// word (8 bytes), so size_t and pointers all collapse to `int`.
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
char *strchr(char *s, int c);
char *strrchr(char *s, int c);
char *strstr(char *haystack, char *needle);
char *strcat(char *dst, char *src);
char *strncat(char *dst, char *src, int n);
char *strerror(int errnum);
char *strdup(char *s);
