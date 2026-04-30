// stdio.h -- formatted I/O, file streams.
//
// Variadic functions (`printf` / `fprintf` / `sprintf` / `snprintf` /
// `sscanf`) carry a real ABI catch on AArch64 macOS: the platform
// AAPCS64 spills variadic arguments to the native stack, while
// Linux AArch64 and SysV x86_64 keep them in registers. The current
// codegen lowers all calls register-only, which means more than a
// couple of variadic args land in the wrong place on macOS. Worth
// knowing if a `printf("%d %d %d %d %d %d\n", ...)` returns garbage.

#pragma once

#ifndef NULL
#define NULL 0
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::printf,   "_printf")
#pragma binding(libc::fprintf,  "_fprintf")
#pragma binding(libc::sprintf,  "_sprintf")
#pragma binding(libc::snprintf, "_snprintf")
#pragma binding(libc::sscanf,   "_sscanf")
#pragma binding(libc::fopen,    "_fopen")
#pragma binding(libc::fclose,   "_fclose")
#pragma binding(libc::fread,    "_fread")
#pragma binding(libc::fwrite,   "_fwrite")
#pragma binding(libc::fputs,    "_fputs")
#pragma binding(libc::fgets,    "_fgets")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::printf,   "printf")
#pragma binding(libc::fprintf,  "fprintf")
#pragma binding(libc::sprintf,  "sprintf")
#pragma binding(libc::snprintf, "snprintf")
#pragma binding(libc::sscanf,   "sscanf")
#pragma binding(libc::fopen,    "fopen")
#pragma binding(libc::fclose,   "fclose")
#pragma binding(libc::fread,    "fread")
#pragma binding(libc::fwrite,   "fwrite")
#pragma binding(libc::fputs,    "fputs")
#pragma binding(libc::fgets,    "fgets")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::printf,   "printf")
#pragma binding(msvcrt::fprintf,  "fprintf")
#pragma binding(msvcrt::sprintf,  "sprintf")
// MSVC renamed the safe forms; the original `snprintf` only landed
// in msvcrt circa VS2015. `_snprintf` is the universally available
// spelling and behaves the same way for our usage (no NUL guarantee
// on overflow, but neither does our other targets' `snprintf` once
// the buffer fills).
#pragma binding(msvcrt::snprintf, "_snprintf")
#pragma binding(msvcrt::sscanf,   "sscanf")
#pragma binding(msvcrt::fopen,    "fopen")
#pragma binding(msvcrt::fclose,   "fclose")
#pragma binding(msvcrt::fread,    "fread")
#pragma binding(msvcrt::fwrite,   "fwrite")
#pragma binding(msvcrt::fputs,    "fputs")
#pragma binding(msvcrt::fgets,    "fgets")
#endif

int printf(char *fmt, ...);
int fprintf(int *stream, char *fmt, ...);
int sprintf(char *buf, char *fmt, ...);
int snprintf(char *buf, int size, char *fmt, ...);
int sscanf(char *src, char *fmt, ...);
int *fopen(char *path, char *mode);
int fclose(int *stream);
int fread(char *buf, int size, int n, int *stream);
int fwrite(char *buf, int size, int n, int *stream);
int fputs(char *s, int *stream);
char *fgets(char *buf, int n, int *stream);
