// string.h -- POSIX string + memory routines.
//
// Per-target gating picks the right dylib + symbol name:
//   * macOS: libSystem, with the leading underscore Mach-O wants.
//   * Linux: libc.so.6.
//   * Windows: msvcrt.dll.
//
// `c4_name` (the LHS of each `#pragma binding`) is always the
// portable C name; `real_symbol` (the RHS) is whatever the target
// dylib actually exports. Source code keeps using the portable
// spelling regardless of platform.

#pragma once

#ifndef NULL
#define NULL 0
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::memset,  "_memset")
#pragma binding(libc::memcmp,  "_memcmp")
#pragma binding(libc::memcpy,  "_memcpy")
#pragma binding(libc::strlen,  "_strlen")
#pragma binding(libc::strcpy,  "_strcpy")
#pragma binding(libc::strncpy, "_strncpy")
#pragma binding(libc::strcmp,  "_strcmp")
#pragma binding(libc::strncmp, "_strncmp")
#pragma binding(libc::strchr,  "_strchr")
#pragma binding(libc::strstr,  "_strstr")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::memset,  "memset")
#pragma binding(libc::memcmp,  "memcmp")
#pragma binding(libc::memcpy,  "memcpy")
#pragma binding(libc::strlen,  "strlen")
#pragma binding(libc::strcpy,  "strcpy")
#pragma binding(libc::strncpy, "strncpy")
#pragma binding(libc::strcmp,  "strcmp")
#pragma binding(libc::strncmp, "strncmp")
#pragma binding(libc::strchr,  "strchr")
#pragma binding(libc::strstr,  "strstr")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::memset,  "memset")
#pragma binding(msvcrt::memcmp,  "memcmp")
#pragma binding(msvcrt::memcpy,  "memcpy")
#pragma binding(msvcrt::strlen,  "strlen")
#pragma binding(msvcrt::strcpy,  "strcpy")
#pragma binding(msvcrt::strncpy, "strncpy")
#pragma binding(msvcrt::strcmp,  "strcmp")
#pragma binding(msvcrt::strncmp, "strncmp")
#pragma binding(msvcrt::strchr,  "strchr")
#pragma binding(msvcrt::strstr,  "strstr")
#endif

// Portable prototypes -- `char` is one byte, `int` is the c4 machine
// word (8 bytes), so size_t and pointers all collapse to `int`.
char *memset(char *dst, int byte, int n);
int memcmp(char *a, char *b, int n);
char *memcpy(char *dst, char *src, int n);
int strlen(char *s);
char *strcpy(char *dst, char *src);
char *strncpy(char *dst, char *src, int n);
int strcmp(char *a, char *b);
int strncmp(char *a, char *b, int n);
char *strchr(char *s, int c);
char *strstr(char *haystack, char *needle);
