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

// C99 7.19: `<stdio.h>` exposes `size_t`. Pull `<stddef.h>`
// so callers don't have to learn that `<stddef.h>` is the
// underlying definition site.
#include <stddef.h>

#ifndef NULL
#define NULL 0
#endif

#define EOF (-1)
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

// setvbuf modes -- non-buffered, line-buffered, fully-buffered.
// macOS / Linux land on (_IONBF=2, _IOLBF=1, _IOFBF=0); MSVC
// msvcrt uses (_IONBF=4, _IOLBF=64, _IOFBF=0). Calling msvcrt's
// setvbuf with the POSIX values trips its `_invalid_parameter`
// handler -- so the values diverge per target. The macros below
// resolve the right pair at preprocess time, no runtime check.
#ifdef _WIN32
#define _IONBF 4
#define _IOLBF 64
#define _IOFBF 0
#else
#define _IONBF 2
#define _IOLBF 1
#define _IOFBF 0
#endif

// The C library's limits: tmpnam and ctermid write up to L_tmpnam and
// L_ctermid bytes into the caller's buffer.
#if defined(__APPLE__)
#define FILENAME_MAX 1024
#define FOPEN_MAX    20
#define TMP_MAX      308915776
#define BUFSIZ       1024
#define L_tmpnam     1024
#define L_ctermid    1024
#elif defined(__linux__)
#define FILENAME_MAX 4096
#define FOPEN_MAX    16
#define TMP_MAX      238328
#define BUFSIZ       8192
#define L_tmpnam     20
#define L_ctermid    9
#else
#define FILENAME_MAX 260
#define FOPEN_MAX    20
#define TMP_MAX      32767
#define BUFSIZ       512
#define L_tmpnam     14
#endif
#ifndef PATH_MAX
#if defined(__APPLE__)
#define PATH_MAX     1024
#elif defined(_WIN32)
#define PATH_MAX     260
#else
#define PATH_MAX     4096
#endif
#endif

// `FILE` and `fpos_t` (C17 7.21.1) in the C library's size and alignment:
// the SDK's 152-byte FILE and 64-bit fpos_t, glibc's 216-byte FILE and
// 16-byte fpos_t of a position and an mbstate_t, msvcrt's 48-byte FILE.
#if defined(__APPLE__)
struct __c5_FILE { union { char __opaque[152]; long __align; }; };
typedef long long fpos_t;
#elif defined(__linux__)
struct __c5_FILE { union { char __opaque[216]; long __align; }; };
struct __c5_fpos_t { union { char __opaque[16]; long long __align; } __u; };
typedef struct __c5_fpos_t fpos_t;
#else
// msvcrt's _iobuf and 64-bit position.
struct __c5_FILE {
    char *_ptr;
    int _cnt;
    char *_base;
    int _flag;
    int _file;
    int _charbuf;
    int _bufsiz;
    char *_tmpfname;
};
typedef long long fpos_t;
#endif
typedef struct __c5_FILE FILE;

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::printf,    "_printf")
#pragma binding(libc::fprintf,   "_fprintf")
#pragma binding(libc::sprintf,   "_sprintf")
#pragma binding(libc::snprintf,  "_snprintf")
#pragma binding(libc::vprintf,   "_vprintf")
#pragma binding(libc::vfprintf,  "_vfprintf")
#pragma binding(libc::vsprintf,  "_vsprintf")
#pragma binding(libc::vsnprintf, "_vsnprintf")
#pragma binding(libc::scanf,     "_scanf")
#pragma binding(libc::fscanf,    "_fscanf")
#pragma binding(libc::sscanf,    "_sscanf")
#pragma binding(libc::vsscanf,   "_vsscanf")
#pragma binding(libc::vfscanf,   "_vfscanf")
#pragma binding(libc::vscanf,    "_vscanf")
#pragma binding(libc::fopen,     "_fopen")
#pragma binding(libc::freopen,   "_freopen")
#pragma binding(libc::fclose,    "_fclose")
#pragma binding(libc::fread,     "_fread")
#pragma binding(libc::fwrite,    "_fwrite")
#pragma binding(libc::fputs,     "_fputs")
#pragma binding(libc::fgets,     "_fgets")
#pragma binding(libc::fputc,     "_fputc")
#pragma binding(libc::fgetc,     "_fgetc")
#pragma binding(libc::putc,      "_putc")
#pragma binding(libc::getc,      "_getc")
#pragma binding(libc::ungetc,    "_ungetc")
#pragma binding(libc::putchar,   "_putchar")
#pragma binding(libc::getchar,   "_getchar")
#pragma binding(libc::tmpfile,   "_tmpfile")
#pragma binding(libc::tmpnam,    "_tmpnam")
#pragma binding(libc::setbuf,    "_setbuf")
#pragma binding(libc::setbuffer, "_setbuffer")
#pragma binding(libc::puts,      "_puts")
#pragma binding(libc::perror,    "_perror")
#pragma binding(libc::fseek,     "_fseek")
#pragma binding(libc::ftell,     "_ftell")
#pragma binding(libc::fseeko,    "_fseeko")
#pragma binding(libc::ftello,    "_ftello")
#pragma binding(libc::fgetpos,   "_fgetpos")
#pragma binding(libc::fsetpos,   "_fsetpos")
#pragma binding(libc::rewind,    "_rewind")
#pragma binding(libc::fflush,    "_fflush")
#pragma binding(libc::feof,      "_feof")
#pragma binding(libc::ferror,    "_ferror")
#pragma binding(libc::clearerr,  "_clearerr")
#pragma binding(libc::setvbuf,   "_setvbuf")
#pragma binding(libc::remove,    "_remove")
#pragma binding(libc::rename,    "_rename")
#pragma binding(libc::renameat,  "_renameat")
#pragma binding(data libc::__stdinp,  "___stdinp")
#pragma binding(data libc::__stdoutp, "___stdoutp")
#pragma binding(data libc::__stderrp, "___stderrp")
// POSIX.1-2008 `open_memstream` -- creates a FILE * backed
// by a heap buffer the libc grows as the program writes
// through it. The caller passes (char **buf, size_t *sz)
// addresses that get updated to the current buffer + length
// on every `fflush` / `fclose`. Available on macOS 10.13+
// and every recent Linux C library / musl; absent from msvcrt.
#pragma binding(libc::open_memstream, "_open_memstream")
#pragma binding(libc::wprintf, "_wprintf")
// POSIX.1-2008 `fmemopen`: a stream over a caller buffer.
#pragma binding(libc::fmemopen, "_fmemopen")
// POSIX `popen` / `pclose` -- not in C89 but universally
// available on macOS / BSD. A source that opens its own
// `extern FILE *popen(const char *, const char *);` prototype
// binds through this entry instead of leaving the call as an
// unresolved Token::Fun.
#pragma binding(libc::popen,     "_popen")
#pragma binding(libc::pclose,    "_pclose")
// POSIX `fdopen` -- wraps an already-open file descriptor as a
// `FILE *` stream. Used by archive / pipe consumers that get a
// raw fd from a system call and need stdio-level formatting.
#pragma binding(libc::fdopen,    "_fdopen")
#pragma binding(libc::fileno,    "_fileno")
#pragma binding(libc::flockfile,    "_flockfile")
#pragma binding(libc::funlockfile,  "_funlockfile")
#pragma binding(libc::ftrylockfile, "_ftrylockfile")
#pragma binding(libc::getc_unlocked, "_getc_unlocked")
#pragma binding(libc::putc_unlocked, "_putc_unlocked")
#pragma binding(libc::getline,   "_getline")
#pragma binding(libc::getdelim,  "_getdelim")
#pragma binding(libc::dprintf,   "_dprintf")
#pragma binding(libc::vdprintf,  "_vdprintf")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::printf,    "printf")
#pragma binding(libc::fprintf,   "fprintf")
#pragma binding(libc::sprintf,   "sprintf")
#pragma binding(libc::snprintf,  "snprintf")
#pragma binding(libc::vprintf,   "vprintf")
#pragma binding(libc::vfprintf,  "vfprintf")
#pragma binding(libc::vsprintf,  "vsprintf")
#pragma binding(libc::vsnprintf, "vsnprintf")
// The C99 scanners glibc's <stdio.h> selects through C17, where `%as` is a
// floating conversion and a literal `s`; the plain names keep the GNU
// allocating `%as`, `%aS` and `%a[`.
#pragma binding(libc::scanf,     "__isoc99_scanf")
#pragma binding(libc::fscanf,    "__isoc99_fscanf")
#pragma binding(libc::sscanf,    "__isoc99_sscanf")
#pragma binding(libc::vsscanf,   "__isoc99_vsscanf")
#pragma binding(libc::vfscanf,   "__isoc99_vfscanf")
#pragma binding(libc::vscanf,    "__isoc99_vscanf")
// GNU allocating printf variants; their prototypes follow the bindings.
#pragma binding(libc::asprintf,  "asprintf")
#pragma binding(libc::vasprintf, "vasprintf")
#pragma binding(libc::fopen,     "fopen")
#pragma binding(libc::freopen,   "freopen")
#pragma binding(libc::fclose,    "fclose")
#pragma binding(libc::fread,     "fread")
#pragma binding(libc::fwrite,    "fwrite")
#pragma binding(libc::fputs,     "fputs")
#pragma binding(libc::fgets,     "fgets")
#pragma binding(libc::fputc,     "fputc")
#pragma binding(libc::fgetc,     "fgetc")
#pragma binding(libc::putc,      "putc")
#pragma binding(libc::getc,      "getc")
#pragma binding(libc::ungetc,    "ungetc")
#pragma binding(libc::putchar,   "putchar")
#pragma binding(libc::getchar,   "getchar")
#pragma binding(libc::tmpfile,   "tmpfile")
#pragma binding(libc::tmpnam,    "tmpnam")
#pragma binding(libc::setbuf,    "setbuf")
#pragma binding(libc::setbuffer, "setbuffer")
#pragma binding(libc::puts,      "puts")
#pragma binding(libc::perror,    "perror")
#pragma binding(libc::fseek,     "fseek")
#pragma binding(libc::ftell,     "ftell")
#pragma binding(libc::fseeko,    "fseeko")
#pragma binding(libc::ftello,    "ftello")
#pragma binding(libc::fgetpos,   "fgetpos")
#pragma binding(libc::fsetpos,   "fsetpos")
#pragma binding(libc::rewind,    "rewind")
#pragma binding(libc::fflush,    "fflush")
#pragma binding(libc::feof,      "feof")
#pragma binding(libc::ferror,    "ferror")
#pragma binding(libc::clearerr,  "clearerr")
#pragma binding(libc::setvbuf,   "setvbuf")
#pragma binding(libc::remove,    "remove")
#pragma binding(libc::rename,    "rename")
#pragma binding(libc::renameat,  "renameat")
// POSIX `open_memstream` -- same shape as on macOS, exported
// directly by the Linux C library / musl.
#pragma binding(libc::open_memstream, "open_memstream")
#pragma binding(libc::wprintf, "wprintf")
#pragma binding(libc::fmemopen, "fmemopen")
// X/Open `cuserid` -- a glibc export; absent from libSystem and msvcrt.
#pragma binding(libc::cuserid, "cuserid")
// POSIX `popen` / `pclose` -- not in C89 but universally
// available on Linux / musl. A source that opens its own
// `extern FILE *popen(const char *, const char *);` prototype
// binds through this entry instead of leaving the call as an
// unresolved Token::Fun.
#pragma binding(libc::popen,     "popen")
#pragma binding(libc::pclose,    "pclose")
// POSIX `fdopen` -- wraps an already-open file descriptor as a
// `FILE *` stream. Used by archive / pipe consumers that get a
// raw fd from a system call and need stdio-level formatting.
#pragma binding(libc::fdopen,    "fdopen")
#pragma binding(libc::fileno,    "fileno")
#pragma binding(libc::flockfile,    "flockfile")
#pragma binding(libc::funlockfile,  "funlockfile")
#pragma binding(libc::ftrylockfile, "ftrylockfile")
#pragma binding(libc::getc_unlocked, "getc_unlocked")
#pragma binding(libc::putc_unlocked, "putc_unlocked")
#pragma binding(libc::getline,   "getline")
#pragma binding(libc::getdelim,  "getdelim")
#pragma binding(libc::dprintf,   "dprintf")
#pragma binding(libc::vdprintf,  "vdprintf")
#pragma binding(data libc::stdin,  "stdin")
#pragma binding(data libc::stdout, "stdout")
#pragma binding(data libc::stderr, "stderr")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
// The C99 printf family carries no binding here: libc/lib/printf_ext.c
// defines it, msvcrt.dll's printing 1.#INF / 1.#IND / 1.#QNAN for an
// infinity or NaN, ignoring %hh and returning -1 from _vsnprintf for a
// truncated output. The underscored spellings keep the msvcrt entry points
// for source written against msvcrt semantics.
#pragma binding(msvcrt::_snprintf, "_snprintf")
#pragma binding(msvcrt::_vsnprintf,"_vsnprintf")
#pragma binding(msvcrt::fopen,     "fopen")
#pragma binding(msvcrt::freopen,   "freopen")
#pragma binding(msvcrt::fclose,    "fclose")
#pragma binding(msvcrt::fread,     "fread")
#pragma binding(msvcrt::fwrite,    "fwrite")
#pragma binding(msvcrt::fputs,     "fputs")
#pragma binding(msvcrt::fgets,     "fgets")
#pragma binding(msvcrt::fputc,     "fputc")
#pragma binding(msvcrt::fgetc,     "fgetc")
#pragma binding(msvcrt::putc,      "putc")
#pragma binding(msvcrt::getc,      "getc")
#pragma binding(msvcrt::ungetc,    "ungetc")
#pragma binding(msvcrt::putchar,   "putchar")
#pragma binding(msvcrt::getchar,   "getchar")
#pragma binding(msvcrt::tmpfile,   "tmpfile")
#pragma binding(msvcrt::tmpnam,    "tmpnam")
#pragma binding(msvcrt::setbuf,    "setbuf")
#pragma binding(msvcrt::puts,      "puts")
#pragma binding(msvcrt::perror,    "perror")
#pragma binding(msvcrt::fseek,     "fseek")
#pragma binding(msvcrt::ftell,     "ftell")
#pragma binding(msvcrt::_fseeki64, "_fseeki64")
// The legacy msvcrt.dll exports no _ftelli64 (unlike _fseeki64); UCRT does.
#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::_ftelli64, "_ftelli64")
#pragma binding(msvcrt::fgetpos,   "fgetpos")
#pragma binding(msvcrt::fsetpos,   "fsetpos")
#pragma binding(msvcrt::rewind,    "rewind")
#pragma binding(msvcrt::fflush,    "fflush")
#pragma binding(msvcrt::feof,      "feof")
#pragma binding(msvcrt::ferror,    "ferror")
#pragma binding(msvcrt::clearerr,  "clearerr")
#pragma binding(msvcrt::setvbuf,   "setvbuf")
#pragma binding(msvcrt::remove,    "remove")
#pragma binding(msvcrt::rename,    "rename")
#pragma binding(msvcrt::_fsopen,   "_fsopen")
#pragma binding(msvcrt::freopen_s, "freopen_s")
// The Windows CRT spells the popen entry point with a leading underscore.
#pragma binding(msvcrt::_popen,    "_popen")
#pragma binding(msvcrt::_pclose,   "_pclose")
// The POSIX names, which mingw-w64 declares and its oldnames library
// forwards to the CRT's underscored entry points.
#pragma binding(msvcrt::popen,     "_popen")
#pragma binding(msvcrt::pclose,    "_pclose")
// The CRT's underscored fileno, isatty, setmode and access.
#pragma binding(msvcrt::_fileno,        "_fileno")
#pragma binding(msvcrt::_isatty,        "_isatty")
#pragma binding(msvcrt::_setmode,       "_setmode")
#pragma binding(msvcrt::_access,        "_access")
#pragma binding(msvcrt::_findclose,     "_findclose")
// The wide stream functions, as the UCRT's <stdio.h> has them, and the
// wide file, directory, environment and process functions this header has
// carried.
#include <__badc_wstdio.h>
#include <__badc_ucrt_stdio.h>
#include <__badc_wio.h>
#include <__badc_wdirect.h>
#include <__badc_wstdlib.h>
#include <__badc_wprocess.h>
// MSVC "safe" CRT variants (`_s` suffix). MSVC-only sources
// reach for these under `_MSC_VER`; the `_s` form is the
// bounded-buffer rewrite of the legacy entry point and behaves
// the same way for in-bounds inputs.
// The CRT exports the 64-bit-time_t forms; the unsuffixed names are
// SDK macros. badc's time_t is 64-bit on Windows, so the ABI matches.
#pragma binding(msvcrt::localtime_s,    "_localtime64_s")
#pragma binding(msvcrt::gmtime_s,       "_gmtime64_s")
#pragma binding(msvcrt::ctime_s,        "_ctime64_s")
#pragma binding(msvcrt::asctime_s,      "asctime_s")
#pragma binding(msvcrt::strerror_s,     "strerror_s")
#pragma binding(msvcrt::_strdup,        "_strdup")
#pragma binding(msvcrt::_strnicmp,      "_strnicmp")
#pragma binding(msvcrt::_stricmp,       "_stricmp")
#pragma binding(msvcrt::_get_errno,     "_get_errno")
#pragma binding(msvcrt::_set_errno,     "_set_errno")
#pragma binding(msvcrt::_errno,         "_errno")
#pragma binding(msvcrt::__argc,         "__argc")
#pragma binding(msvcrt::__argv,         "__argv")
#pragma binding(msvcrt::__wargv,        "__wargv")
#pragma binding(msvcrt::__getmainargs,  "__getmainargs")
#pragma binding(msvcrt::_getch,         "_getch")
#pragma binding(msvcrt::_kbhit,         "_kbhit")
#pragma binding(msvcrt::_vscprintf,     "_vscprintf")
#pragma binding(msvcrt::_vscwprintf,    "_vscwprintf")
#pragma binding(msvcrt::_locking,       "_locking")
#pragma binding(msvcrt::_get_osfhandle, "_get_osfhandle")
#pragma binding(msvcrt::_open_osfhandle, "_open_osfhandle")
#pragma binding(msvcrt::_heapmin,       "_heapmin")
#pragma binding(msvcrt::_close,         "_close")
#pragma binding(msvcrt::_read,          "_read")
#pragma binding(msvcrt::_write,         "_write")
#pragma binding(msvcrt::_lseek,         "_lseek")
#pragma binding(msvcrt::_lseeki64,      "_lseeki64")
#pragma binding(msvcrt::_chsize,        "_chsize")
#pragma binding(msvcrt::_chsize_s,      "_chsize_s")
#pragma binding(msvcrt::_chmod,         "_chmod")
#pragma binding(msvcrt::_unlink,        "_unlink")
#pragma binding(msvcrt::_getcwd,        "_getcwd")
#pragma binding(msvcrt::_chdir,         "_chdir")
// The legacy arm64 msvcrt.dll does not export `_getpid`; UCRT does.
#if defined(__aarch64__)
#pragma binding(ucrtbase::_getpid,      "_getpid")
#else
#pragma binding(msvcrt::_getpid,        "_getpid")
#endif
#pragma binding(msvcrt::_dup,           "_dup")
#pragma binding(msvcrt::_dup2,          "_dup2")
#pragma binding(msvcrt::_fdopen,        "_fdopen")
// POSIX-style `fdopen` -- msvcrt only exposes the underscored
// form, so the portable spelling binds to the same entry point.
#pragma binding(msvcrt::fdopen,         "_fdopen")
#pragma binding(msvcrt::fileno,         "_fileno")
// The legacy msvcrt.dll exports no _byteswap_*; UCRT does.
#pragma binding(ucrtbase::_byteswap_ulong,  "_byteswap_ulong")
#pragma binding(ucrtbase::_byteswap_uint64, "_byteswap_uint64")
#pragma binding(ucrtbase::_byteswap_ushort, "_byteswap_ushort")
// msvcrt exports no stream objects: `__iob_func()` returns its `_iob` array,
// whose first three FILEs are the standard streams.
#pragma binding(msvcrt::__iob_func, "__iob_func")
#endif

int printf(const char *fmt, ...);
int wprintf(const wchar_t *fmt, ...);
int fprintf(FILE *stream, const char *fmt, ...);
int sprintf(char *buf, const char *fmt, ...);
int snprintf(char *buf, size_t size, const char *fmt, ...);
// C99 7.19.6.8 - 7.19.6.13: the `va_list` forms. A binding alone leaves
// a call assumed to return `int`; the prototype spells the list's type
// as the builtin `<stdarg.h>` aliases, since this header does not
// include it.
int vprintf(const char *fmt, __builtin_va_list ap);
int vfprintf(FILE *stream, const char *fmt, __builtin_va_list ap);
int vsprintf(char *buf, const char *fmt, __builtin_va_list ap);
int vsnprintf(char *buf, size_t size, const char *fmt, __builtin_va_list ap);
// Alias forms used by source that pre-rewrites the standard
// spelling through a per-platform `#define`. The msvcrt path
// binds both to the same `_snprintf` / `_vsnprintf` entry.
#ifdef _WIN32
int _snprintf(char *buf, size_t size, const char *fmt, ...);
int _vsnprintf(char *buf, size_t size, const char *fmt, char *ap);
#endif
// C99 7.19.6.4 scanf, 7.19.6.2 fscanf -- formatted input from stdin
// and from a stream. The string sibling sscanf reads from a buffer.
int scanf(const char *fmt, ...);
int fscanf(FILE *stream, const char *fmt, ...);
int sscanf(const char *src, const char *fmt, ...);
#ifdef __linux__
// GNU asprintf: allocate a buffer for the formatted result and store its
// address through `strp`, and its `va_list` form.
int asprintf(char **strp, const char *fmt, ...);
int vasprintf(char **strp, const char *fmt, __builtin_va_list ap);
#endif
// C99 7.19.6.14 vsscanf, 7.19.6.9 vfscanf and 7.19.6.11 vscanf. On Windows
// libc/lib/scanf_ext.c defines these and the three above: msvcrt.dll's
// scanners miss C99's conversions, and it exports no va_list form.
int vsscanf(const char *src, const char *fmt, __builtin_va_list ap);
int vfscanf(FILE *restrict stream, const char *restrict format, __builtin_va_list arg);
int vscanf(const char *restrict format, __builtin_va_list arg);
FILE *fopen(const char *path, const char *mode);
// C99 7.19.5.4: reopen a stream with a new file. Used by
// programs that re-route stdin / stdout / stderr to a file.
FILE *freopen(const char *path, const char *mode, FILE *stream);
int fclose(FILE *stream);
size_t fread(void *buf, size_t size, size_t n, FILE *stream);
size_t fwrite(const void *buf, size_t size, size_t n, FILE *stream);
// POSIX.1: the integer file descriptor underlying a stream.
int fileno(FILE *stream);
// POSIX stdio stream locking (not part of msvcrt's stdio surface).
#ifndef __BADC_WINDOWS__
void flockfile(FILE *stream);
void funlockfile(FILE *stream);
int ftrylockfile(FILE *stream);
int getc_unlocked(FILE *stream);
int putc_unlocked(int c, FILE *stream);
#endif
int fputs(const char *s, FILE *stream);
char *fgets(char *buf, int n, FILE *stream);
int fputc(int c, FILE *stream);
int fgetc(FILE *stream);
// C99 7.19.7.5 / 7.19.7.8: `getc` / `putc` are functionally
// equivalent to `fgetc` / `fputc`. Spec permits multiple
// evaluations of the `stream` argument; libc implementations
// honor the same signature, so the binding is a direct alias.
int getc(FILE *stream);
int putc(int c, FILE *stream);
// C99 7.19.7.11: push one byte back onto an input stream.
int ungetc(int c, FILE *stream);
int putchar(int c);
int getchar(void);
// C99 7.19.4.3 / 7.19.4.4: temporary file streams.
FILE *tmpfile(void);
char *tmpnam(char *s);
// POSIX pipe / fd streams (bound above).
FILE *popen(const char *command, const char *type);
int pclose(FILE *stream);
FILE *fdopen(int fd, const char *mode);
// C99 7.19.5.5: convenience wrapper around setvbuf.
void setbuf(FILE *stream, char *buf);
// BSD extension (glibc / macOS, not msvcrt): setvbuf with a caller-sized
// buffer, fully-buffered when `buf` is non-null.
#ifndef _WIN32
#ifdef __linux__
void setbuffer(FILE *stream, char *buf, size_t size);
#else
void setbuffer(FILE *stream, char *buf, int size);
#endif
#endif
int puts(const char *s);
void perror(const char *s);
// C99 7.19.9.2 / 7.19.9.4: fseek takes a long offset, ftell returns long.
// An `int` offset/return truncates positions past 2GB.
int fseek(FILE *stream, long offset, int whence);
long ftell(FILE *stream);
// POSIX large-file variants (off_t is 64-bit). Not provided on Windows
// msvcrt under these names (`_fseeki64` / `_ftelli64` differ).
#ifndef _WIN32
#ifndef __BADC_OFF_T
#define __BADC_OFF_T
// The file offset: the SDK's and msvcrt's 64-bit long long, glibc's long.
#if defined(__BADC_WINDOWS__) || defined(__APPLE__)
typedef long long off_t;
#else
typedef long off_t;
#endif
#endif
int fseeko(FILE *stream, off_t offset, int whence);
off_t ftello(FILE *stream);
#else
int _fseeki64(FILE *stream, long long offset, int whence);
long long _ftelli64(FILE *stream);
#endif
int fgetpos(FILE *stream, fpos_t *pos);
int fsetpos(FILE *stream, const fpos_t *pos);
void rewind(FILE *stream);
int fflush(FILE *stream);
int feof(FILE *stream);
int ferror(FILE *stream);
void clearerr(FILE *stream);
int setvbuf(FILE *stream, char *buf, int mode, size_t size);
int remove(const char *path);
int rename(const char *old_path, const char *new_path);
#ifndef _WIN32
// POSIX: rename relative to the directory descriptors `oldfd` and `newfd`.
int renameat(int oldfd, const char *old_path, int newfd, const char *new_path);
#endif
#ifndef _WIN32
// POSIX open_memstream(3). Caller passes addresses of (char *,
// size_t) slots the libc updates as bytes are written.
FILE *open_memstream(char **bufp, size_t *sizep);
FILE *fmemopen(void *restrict buf, size_t size, const char *restrict mode);
#endif
// POSIX.1-2008 delimited line input: read through the next `delim`
// (newline for `getline`) into a heap buffer `*lineptr` of capacity
// `*n`, growing it as needed, and return the byte count or -1. The
// return type is `ssize_t`, which is `long` on the targets that export
// these (`<sys/types.h>`). POSIX.1-2008 formatted output straight to a
// file descriptor follows the same rule. msvcrt exports none of the
// four; on Windows `libc/lib/stdio_ext.c` defines them and joins the
// link on demand.
#ifdef __linux__
// X/Open cuserid(3): the login name of the effective user, written to
// `s` (at least L_cuserid bytes) or returned from a static buffer when
// `s` is null.
#define L_cuserid 9
char *cuserid(char *s);
#endif
long getline(char **lineptr, size_t *n, FILE *stream);
long getdelim(char **lineptr, size_t *n, int delim, FILE *stream);
int dprintf(int fd, const char *fmt, ...);
int vdprintf(int fd, const char *fmt, __builtin_va_list ap);
#ifdef _WIN32
FILE *_fsopen(const char *path, const char *mode, int shflag);
int   freopen_s(FILE **pfile, const char *path, const char *mode, FILE *stream);
FILE *_popen(const char *cmd, const char *mode);
int   _pclose(FILE *stream);
int   _fileno(FILE *stream);
int   _isatty(int fd);
int   _setmode(int fd, int mode);
int   _access(const char *path, int mode);
int   _findclose(long long handle);
// The Windows SDK's prototypes: `errno_t` is `int`, and `time_t` the
// 64-bit `long long` the CRT's `_*64_s` entries take.
struct tm;
int   localtime_s(struct tm *tm, const long long *t);
int   gmtime_s(struct tm *tm, const long long *t);
int   ctime_s(char *buf, size_t size, const long long *t);
int   asctime_s(char *buf, size_t size, const struct tm *tm);
int   strerror_s(char *buf, size_t size, int errnum);
char *_strdup(const char *s);
int   _strnicmp(const char *a, const char *b, size_t n);
int   _stricmp(const char *a, const char *b);
int   _get_errno(int *value);
int   _set_errno(int value);
int  *_errno(void);
// msvcrt's data exports, which a reference reads through the import slot.
extern int      __argc;
extern char   **__argv;
extern wchar_t **__wargv;
int   __getmainargs(int *argc, char ***argv, char ***envp, int do_wildcard, void *startup_info);
int   _getch(void);
int   _kbhit(void);
int   _vscprintf(const char *format, __builtin_va_list ap);
int   _locking(int fd, int mode, long nbytes);
long long _get_osfhandle(int fd);
int _open_osfhandle(long long osfhandle, int flags);
int   _heapmin(void);
int   _close(int fd);
int   _read(int fd, void *buf, unsigned int n);
int   _write(int fd, const void *buf, unsigned int n);
long  _lseek(int fd, long off, int whence);
long long _lseeki64(int fd, long long off, int whence);
int   _chsize(int fd, long long size);
int   _chsize_s(int fd, long long size);
int   _chmod(const char *path, int mode);
int   _unlink(const char *path);
char *_getcwd(char *buf, int n);
int   _chdir(const char *path);
int   _getpid(void);
int   _dup(int fd);
int   _dup2(int fd, int newfd);
FILE *_fdopen(int fd, const char *mode);
// Portable POSIX-style spelling for the same operation -- routed
// through `_fdopen` on Windows because msvcrt does not export the
// non-underscored name.
FILE *fdopen(int fd, const char *mode);
unsigned long      _byteswap_ulong(unsigned long v);
unsigned long long _byteswap_uint64(unsigned long long v);
unsigned short     _byteswap_ushort(unsigned short v);
FILE *__iob_func(void);

// MSVC's `_findfirst`/`_findnext` companion structs. Layout
// pinned to the Win64 SDK so the kernel-emitted records match
// what a program reads. Per MSVC: `time_t` is 64-bit on the 64-bit
// CRT; `_fsize_t` is `unsigned long` (32-bit on LLP64). Names are 260
// chars; the wide structs are <io.h>'s.
struct _finddata_t {
    unsigned int  attrib;
    long long     time_create;
    long long     time_access;
    long long     time_write;
    unsigned int  size;
    char          name[260];
};
struct _finddata64_t {
    unsigned int  attrib;
    long long     time_create;
    long long     time_access;
    long long     time_write;
    long long     size;
    char          name[260];
};
#define _A_NORMAL     0x00
#define _A_RDONLY     0x01
#define _A_HIDDEN     0x02
#define _A_SYSTEM     0x04
#define _A_SUBDIR     0x10
#define _A_ARCH       0x20

// `_setmode` flag values from <fcntl.h> on the MSVC CRT: O_BINARY
// (raw bytes through stdin/stdout for a pipeline) and O_TEXT /
// O_WTEXT (auto CRLF + locale-aware translation). Values pinned by
// the platform.
#define _O_TEXT       0x4000
#define _O_BINARY     0x8000
#define _O_WTEXT      0x10000
#define _O_U16TEXT    0x20000
#define _O_U8TEXT     0x40000
#define O_TEXT        _O_TEXT
#define O_BINARY      _O_BINARY
#include <corecrt.h>
// The bounds-checked forms <tchar.h>'s _s mappings reach, with mingw-w64's
// prototypes (sec_api/*_s.h); msvcrt.dll exports each on both targets.
#pragma binding(msvcrt::printf_s, "printf_s")
int printf_s(const char *_Format, ...);
#pragma binding(msvcrt::fprintf_s, "fprintf_s")
int fprintf_s(FILE *_File, const char *_Format, ...);
#pragma binding(msvcrt::sprintf_s, "sprintf_s")
int sprintf_s(char *_DstBuf, size_t _DstSize, const char *_Format, ...);
#pragma binding(msvcrt::vprintf_s, "vprintf_s")
int vprintf_s(const char *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::vfprintf_s, "vfprintf_s")
int vfprintf_s(FILE *_File, const char *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::vsprintf_s, "vsprintf_s")
int vsprintf_s(char *_DstBuf, size_t _Size, const char *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_snprintf_s, "_snprintf_s")
int _snprintf_s(char *_DstBuf, size_t _DstSize, size_t _MaxCount, const char *_Format, ...);
#pragma binding(msvcrt::_vsnprintf_s, "_vsnprintf_s")
int _vsnprintf_s(char *_DstBuf, size_t _DstSize, size_t _MaxCount, const char *_Format, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_printf_s_l, "_printf_s_l")
int _printf_s_l(const char *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vprintf_s_l, "_vprintf_s_l")
int _vprintf_s_l(const char *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_fprintf_s_l, "_fprintf_s_l")
int _fprintf_s_l(FILE *_File, const char *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vfprintf_s_l, "_vfprintf_s_l")
int _vfprintf_s_l(FILE *_File, const char *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_sprintf_s_l, "_sprintf_s_l")
int _sprintf_s_l(char *_DstBuf, size_t _DstSize, const char *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vsprintf_s_l, "_vsprintf_s_l")
int _vsprintf_s_l(char *_DstBuf, size_t _DstSize, const char *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::_snprintf_s_l, "_snprintf_s_l")
int _snprintf_s_l(char *_DstBuf, size_t _DstSize, size_t _MaxCount, const char *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_vsnprintf_s_l, "_vsnprintf_s_l")
int _vsnprintf_s_l(char *_DstBuf, size_t _DstSize, size_t _MaxCount, const char *_Format, _locale_t _Locale, __builtin_va_list _ArgList);
#pragma binding(msvcrt::scanf_s, "scanf_s")
int scanf_s(const char *_Format, ...);
#pragma binding(msvcrt::fscanf_s, "fscanf_s")
int fscanf_s(FILE *_File, const char *_Format, ...);
#pragma binding(msvcrt::sscanf_s, "sscanf_s")
int sscanf_s(const char *_Src, const char *_Format, ...);
#pragma binding(msvcrt::_snscanf_s, "_snscanf_s")
int _snscanf_s(const char *_Src, size_t _MaxCount, const char *_Format, ...);
#pragma binding(msvcrt::_scanf_s_l, "_scanf_s_l")
int _scanf_s_l(const char *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_fscanf_s_l, "_fscanf_s_l")
int _fscanf_s_l(FILE *_File, const char *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_sscanf_s_l, "_sscanf_s_l")
int _sscanf_s_l(const char *_Src, const char *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::_snscanf_s_l, "_snscanf_s_l")
int _snscanf_s_l(const char *_Src, size_t _MaxCount, const char *_Format, _locale_t _Locale, ...);
#pragma binding(msvcrt::fopen_s, "fopen_s")
errno_t fopen_s(FILE **_File, const char *_Filename, const char *_Mode);
#pragma binding(msvcrt::tmpnam_s, "tmpnam_s")
errno_t tmpnam_s(char *_Buf, rsize_t _Size);
#endif
// The standard streams (C17 7.21.1): the C library's objects -- libSystem's
// `__stdinp` family, as the SDK names them, glibc's `stdin` family -- and on
// Windows the first three FILEs of msvcrt's `_iob` array, which it exports
// through `__iob_func()` alone.
#if defined(__APPLE__)
extern FILE *__stdinp;
extern FILE *__stdoutp;
extern FILE *__stderrp;
#define stdin  __stdinp
#define stdout __stdoutp
#define stderr __stderrp
#elif defined(__linux__)
extern FILE *stdin;
extern FILE *stdout;
extern FILE *stderr;
#define stdin  stdin
#define stdout stdout
#define stderr stderr
#elif defined(_WIN32)
#define stdin  (&__iob_func()[0])
#define stdout (&__iob_func()[1])
#define stderr (&__iob_func()[2])
#endif

// vfprintf / vprintf / vsprintf / vsnprintf bind directly to the
// platform C library. c5's <stdarg.h> va_list is the host's own
// representation -- the System V AMD64 / AAPCS64 register-save struct on
// Linux, the stack / home-area cursor on macOS and Windows -- so libc's
// formatters consume a forwarded c5 va_list the same way they consume
// their own. The plain printf / fprintf / sprintf / snprintf family binds
// to libc the same way: a `func(a, b, c)` call already uses the host
// variadic call shape the c5 codegen emits.
//
// Windows-flavoured sources spell the v* names with a leading underscore
// (`#define vsnprintf _vsnprintf` is a common MSVC idiom). Alias the
// underscored spellings to the canonical names so they resolve through the
// same per-target bindings. On Windows `_vsnprintf` stays a direct msvcrt
// binding with msvcrt semantics; the canonical `vsnprintf` is the C99
// definition in the auto-linked runtime.
#define _vfprintf  vfprintf
#define _vprintf   vprintf
#define _vsprintf  vsprintf
#ifndef _WIN32
#define _vsnprintf vsnprintf
#endif

#if defined(__APPLE__) || defined(__linux__)
#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::tempnam, "_tempnam")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::tempnam, "tempnam")
#endif
char *tempnam(const char *dir, const char *pfx);
#endif
