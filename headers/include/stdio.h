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

#define EOF (-1)
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

#ifndef FILENAME_MAX
#define FILENAME_MAX 4096
#endif
#ifndef FOPEN_MAX
#define FOPEN_MAX    1024
#endif
#ifndef TMP_MAX
#define TMP_MAX      308915776
#endif
#ifndef BUFSIZ
#define BUFSIZ       8192
#endif
#ifndef L_tmpnam
#define L_tmpnam     20
#endif
#ifndef PATH_MAX
#define PATH_MAX     4096
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::printf,    "_printf")
#pragma binding(libc::fprintf,   "_fprintf")
#pragma binding(libc::sprintf,   "_sprintf")
#pragma binding(libc::snprintf,  "_snprintf")
#pragma binding(libc::vfprintf,  "_vfprintf")
#pragma binding(libc::vsprintf,  "_vsprintf")
#pragma binding(libc::vsnprintf, "_vsnprintf")
#pragma binding(libc::sscanf,    "_sscanf")
#pragma binding(libc::fopen,     "_fopen")
#pragma binding(libc::fclose,    "_fclose")
#pragma binding(libc::fread,     "_fread")
#pragma binding(libc::fwrite,    "_fwrite")
#pragma binding(libc::fputs,     "_fputs")
#pragma binding(libc::fgets,     "_fgets")
#pragma binding(libc::fputc,     "_fputc")
#pragma binding(libc::fgetc,     "_fgetc")
#pragma binding(libc::putchar,   "_putchar")
#pragma binding(libc::getchar,   "_getchar")
#pragma binding(libc::puts,      "_puts")
#pragma binding(libc::perror,    "_perror")
#pragma binding(libc::fseek,     "_fseek")
#pragma binding(libc::ftell,     "_ftell")
#pragma binding(libc::rewind,    "_rewind")
#pragma binding(libc::fflush,    "_fflush")
#pragma binding(libc::feof,      "_feof")
#pragma binding(libc::ferror,    "_ferror")
#pragma binding(libc::clearerr,  "_clearerr")
#pragma binding(libc::setvbuf,   "_setvbuf")
#pragma binding(libc::remove,    "_remove")
#pragma binding(libc::rename,    "_rename")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::printf,    "printf")
#pragma binding(libc::fprintf,   "fprintf")
#pragma binding(libc::sprintf,   "sprintf")
#pragma binding(libc::snprintf,  "snprintf")
#pragma binding(libc::vfprintf,  "vfprintf")
#pragma binding(libc::vsprintf,  "vsprintf")
#pragma binding(libc::vsnprintf, "vsnprintf")
#pragma binding(libc::sscanf,    "sscanf")
#pragma binding(libc::fopen,     "fopen")
#pragma binding(libc::fclose,    "fclose")
#pragma binding(libc::fread,     "fread")
#pragma binding(libc::fwrite,    "fwrite")
#pragma binding(libc::fputs,     "fputs")
#pragma binding(libc::fgets,     "fgets")
#pragma binding(libc::fputc,     "fputc")
#pragma binding(libc::fgetc,     "fgetc")
#pragma binding(libc::putchar,   "putchar")
#pragma binding(libc::getchar,   "getchar")
#pragma binding(libc::puts,      "puts")
#pragma binding(libc::perror,    "perror")
#pragma binding(libc::fseek,     "fseek")
#pragma binding(libc::ftell,     "ftell")
#pragma binding(libc::rewind,    "rewind")
#pragma binding(libc::fflush,    "fflush")
#pragma binding(libc::feof,      "feof")
#pragma binding(libc::ferror,    "ferror")
#pragma binding(libc::clearerr,  "clearerr")
#pragma binding(libc::setvbuf,   "setvbuf")
#pragma binding(libc::remove,    "remove")
#pragma binding(libc::rename,    "rename")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::printf,    "printf")
#pragma binding(msvcrt::fprintf,   "fprintf")
#pragma binding(msvcrt::sprintf,   "sprintf")
// MSVC renamed the safe forms; the original `snprintf` only landed
// in msvcrt circa VS2015. `_snprintf` is the universally available
// spelling and behaves the same way for our usage (no NUL guarantee
// on overflow, but neither does our other targets' `snprintf` once
// the buffer fills).
#pragma binding(msvcrt::snprintf,  "_snprintf")
#pragma binding(msvcrt::vfprintf,  "vfprintf")
#pragma binding(msvcrt::vsprintf,  "vsprintf")
#pragma binding(msvcrt::vsnprintf, "_vsnprintf")
#pragma binding(msvcrt::sscanf,    "sscanf")
#pragma binding(msvcrt::fopen,     "fopen")
#pragma binding(msvcrt::fclose,    "fclose")
#pragma binding(msvcrt::fread,     "fread")
#pragma binding(msvcrt::fwrite,    "fwrite")
#pragma binding(msvcrt::fputs,     "fputs")
#pragma binding(msvcrt::fgets,     "fgets")
#pragma binding(msvcrt::fputc,     "fputc")
#pragma binding(msvcrt::fgetc,     "fgetc")
#pragma binding(msvcrt::putchar,   "putchar")
#pragma binding(msvcrt::getchar,   "getchar")
#pragma binding(msvcrt::puts,      "puts")
#pragma binding(msvcrt::perror,    "perror")
#pragma binding(msvcrt::fseek,     "fseek")
#pragma binding(msvcrt::ftell,     "ftell")
#pragma binding(msvcrt::rewind,    "rewind")
#pragma binding(msvcrt::fflush,    "fflush")
#pragma binding(msvcrt::feof,      "feof")
#pragma binding(msvcrt::ferror,    "ferror")
#pragma binding(msvcrt::clearerr,  "clearerr")
#pragma binding(msvcrt::setvbuf,   "setvbuf")
#pragma binding(msvcrt::remove,    "remove")
#pragma binding(msvcrt::rename,    "rename")
#endif

int printf(char *fmt, ...);
int fprintf(int *stream, char *fmt, ...);
int sprintf(char *buf, char *fmt, ...);
int snprintf(char *buf, int size, char *fmt, ...);
int vfprintf(int *stream, char *fmt, char *args);
int vsprintf(char *buf, char *fmt, char *args);
int vsnprintf(char *buf, int size, char *fmt, char *args);
int sscanf(char *src, char *fmt, ...);
int *fopen(char *path, char *mode);
int fclose(int *stream);
int fread(char *buf, int size, int n, int *stream);
int fwrite(char *buf, int size, int n, int *stream);
int fputs(char *s, int *stream);
char *fgets(char *buf, int n, int *stream);
int fputc(int c, int *stream);
int fgetc(int *stream);
int putchar(int c);
int getchar();
int puts(char *s);
int perror(char *s);
int fseek(int *stream, int offset, int whence);
int ftell(int *stream);
int rewind(int *stream);
int fflush(int *stream);
int feof(int *stream);
int ferror(int *stream);
int clearerr(int *stream);
int setvbuf(int *stream, char *buf, int mode, int size);
int remove(char *path);
int rename(char *old_path, char *new_path);
