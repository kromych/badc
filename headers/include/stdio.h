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

// Opaque-buffer typedef for libc's `FILE`. Different libcs use
// wildly different layouts; programs only ever pass `FILE *`
// through bound libc routines, so the buffer just needs to
// reserve enough storage.
struct __c5_FILE { char __opaque[256]; };
typedef struct __c5_FILE FILE;

// Standard streams. These are real libc globals exported by the
// platform's C runtime. c5 has no GOT-style data-symbol
// trampoline, so reading `extern FILE *stdout;` directly would
// give us an uninitialised c5-side shadow. Instead we resolve
// each stream lazily via `dlsym` on first use -- the helper
// below caches the result so repeated reads stay cheap. The
// macros wrap the lookup so user code can keep writing
// `printf` / `fprintf(stderr, ...)` / `setvbuf(stdout, ...)`
// without any extra ceremony.
//
// `&stdout` / `&stderr` won't typecheck through this path;
// callers that need an addressable `FILE *` lvalue have to
// fall back to `fdopen(...)`.
//
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
#pragma binding(libc::dlsym,     "_dlsym")
// POSIX.1-2008 `open_memstream` -- creates a FILE * backed
// by a heap buffer the libc grows as the program writes
// through it. The caller passes (char **buf, size_t *sz)
// addresses that get updated to the current buffer + length
// on every `fflush` / `fclose`. Available on macOS 10.13+
// and every modern glibc / musl; absent from msvcrt.
#pragma binding(libc::open_memstream, "_open_memstream")
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
#pragma dylib(libdl_for_stdio, "libdl.so.2")
#pragma binding(libdl_for_stdio::dlsym, "dlsym")
// POSIX `open_memstream` -- same shape as on macOS, exported
// directly by glibc / musl.
#pragma binding(libc::open_memstream, "open_memstream")
// POSIX `popen` / `pclose` -- not in C89 but universally
// available on glibc / musl. A source that opens its own
// `extern FILE *popen(const char *, const char *);` prototype
// binds through this entry instead of leaving the call as an
// unresolved Token::Fun.
#pragma binding(libc::popen,     "popen")
#pragma binding(libc::pclose,    "pclose")
// POSIX `fdopen` -- wraps an already-open file descriptor as a
// `FILE *` stream. Used by archive / pipe consumers that get a
// raw fd from a system call and need stdio-level formatting.
#pragma binding(libc::fdopen,    "fdopen")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::printf,    "printf")
#pragma binding(msvcrt::wprintf,   "wprintf")
#pragma binding(msvcrt::fprintf,   "fprintf")
#pragma binding(msvcrt::sprintf,   "sprintf")
// MSVC renamed the safe forms; the original `snprintf` only landed
// in msvcrt circa VS2015. `_snprintf` is the universally available
// spelling and behaves the same way for our usage (no NUL guarantee
// on overflow, but neither does our other targets' `snprintf` once
// the buffer fills). Note that msvcrt's printf family prints
// infinity / NaN as `1.#INF` / `1.#IND` / `1.#QNAN` rather than
// C99 `inf` / `nan`; programs that classify formatted output
// by a digit-prefix regex misclassify the msvcrt output as
// numeric.
// Routing through `ucrtbase._snprintf` would emit the C99
// spelling but that entry point fails with
// STATUS_ENTRYPOINT_NOT_FOUND at PE load time on the GitHub
// Windows runners -- the documented UCRT import path is via the
// `api-ms-win-crt-stdio-l1-1-0.dll` proxy set, not ucrtbase
// directly. Tracked under the TODO marker until c5 grows
// support for the UCRT proxy DLLs.
#pragma binding(msvcrt::snprintf,  "_snprintf")
#pragma binding(msvcrt::_snprintf, "_snprintf")
#pragma binding(msvcrt::vfprintf,  "vfprintf")
#pragma binding(msvcrt::vsprintf,  "vsprintf")
#pragma binding(msvcrt::vsnprintf, "_vsnprintf")
#pragma binding(msvcrt::_vsnprintf,"_vsnprintf")
#pragma binding(msvcrt::sscanf,    "sscanf")
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
#pragma binding(msvcrt::rewind,    "rewind")
#pragma binding(msvcrt::fflush,    "fflush")
#pragma binding(msvcrt::feof,      "feof")
#pragma binding(msvcrt::ferror,    "ferror")
#pragma binding(msvcrt::clearerr,  "clearerr")
#pragma binding(msvcrt::setvbuf,   "setvbuf")
#pragma binding(msvcrt::remove,    "remove")
#pragma binding(msvcrt::rename,    "rename")
// Wide-string companion shell.c reaches for to open paths that
// contain non-ASCII characters: it converts the UTF-8 input to
// UTF-16 via MultiByteToWideChar and then calls _wfopen. The
// Windows CRT spells the entry point with the leading underscore.
#pragma binding(msvcrt::_wfopen,   "_wfopen")
// shell.c also reaches for `_wpopen` / `_pclose` to drive the
// `.system` and pager pipes when the path needs UTF-16. The Windows
// CRT spells the popen entry point with a leading underscore on
// both the byte-string and wide-string flavours.
#pragma binding(msvcrt::_wpopen,   "_wpopen")
#pragma binding(msvcrt::_popen,    "_popen")
#pragma binding(msvcrt::_pclose,   "_pclose")
// shell.c reaches for the wide-string fs APIs to walk archives /
// snapshots whose paths contain non-ASCII characters, plus a few
// Win32-spelled fileno / setmode / isatty / access helpers that
// every Windows console interaction routes through.
#pragma binding(msvcrt::_fileno,        "_fileno")
#pragma binding(msvcrt::_isatty,        "_isatty")
#pragma binding(msvcrt::_setmode,       "_setmode")
#pragma binding(msvcrt::_access,        "_access")
#pragma binding(msvcrt::_stat,          "_stat")
#pragma binding(msvcrt::_stat64,        "_stat64")
#pragma binding(msvcrt::_fstat64,       "_fstat64")
#pragma binding(msvcrt::_wstat,         "_wstat")
#pragma binding(msvcrt::_wchmod,        "_wchmod")
#pragma binding(msvcrt::_wmkdir,        "_wmkdir")
#pragma binding(msvcrt::_wunlink,       "_wunlink")
#pragma binding(msvcrt::_wfullpath,     "_wfullpath")
#pragma binding(msvcrt::_wfindfirst,    "_wfindfirst")
#pragma binding(msvcrt::_wfindnext,     "_wfindnext")
#pragma binding(msvcrt::_findclose,     "_findclose")
// Wide-string IO companions to fgets / fputs / putc, plus the
// process-environment helpers shell.c uses for `.system` / `--`
// argv passing on Windows. Names spelled with the leading
// underscore where the MSVC CRT does so.
#pragma binding(msvcrt::fgetws,         "fgetws")
#pragma binding(msvcrt::fputws,         "fputws")
#pragma binding(msvcrt::_getws,         "_getws")
#pragma binding(msvcrt::_putws,         "_putws")
#pragma binding(msvcrt::_wgetenv,       "_wgetenv")
#pragma binding(msvcrt::_wputenv,       "_wputenv")
#pragma binding(msvcrt::_wsystem,       "_wsystem")
#pragma binding(msvcrt::_wgetcwd,       "_wgetcwd")
#pragma binding(msvcrt::_wchdir,        "_wchdir")
#pragma binding(msvcrt::_wrename,       "_wrename")
#pragma binding(msvcrt::_wremove,       "_wremove")
#pragma binding(msvcrt::_wtoi,          "_wtoi")
#pragma binding(msvcrt::wcslen,         "wcslen")
#pragma binding(msvcrt::wcscmp,         "wcscmp")
#pragma binding(msvcrt::wcsncmp,        "wcsncmp")
#pragma binding(msvcrt::wcschr,         "wcschr")
#pragma binding(msvcrt::wcsrchr,        "wcsrchr")
#pragma binding(msvcrt::wcsstr,         "wcsstr")
#pragma binding(msvcrt::wcscpy,         "wcscpy")
#pragma binding(msvcrt::wcsncpy,        "wcsncpy")
#pragma binding(msvcrt::wcscat,         "wcscat")
#pragma binding(msvcrt::wcsncat,        "wcsncat")
#pragma binding(msvcrt::wcsdup,         "_wcsdup")
#pragma binding(msvcrt::_wcsicmp,       "_wcsicmp")
// MSVC "safe" CRT variants (`_s` suffix). MSVC-only sources
// reach for these under `_MSC_VER`; the `_s` form is the
// bounded-buffer rewrite of the legacy entry point and behaves
// the same way for in-bounds inputs.
#pragma binding(msvcrt::localtime_s,    "localtime_s")
#pragma binding(msvcrt::gmtime_s,       "gmtime_s")
#pragma binding(msvcrt::ctime_s,        "ctime_s")
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
#pragma binding(msvcrt::_msize,         "_msize")
#pragma binding(msvcrt::_open,          "_open")
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
#pragma binding(msvcrt::_getpid,        "_getpid")
#pragma binding(msvcrt::_dup,           "_dup")
#pragma binding(msvcrt::_dup2,          "_dup2")
#pragma binding(msvcrt::_fdopen,        "_fdopen")
// POSIX-style `fdopen` -- msvcrt only exposes the underscored
// form, so the portable spelling binds to the same entry point.
#pragma binding(msvcrt::fdopen,         "_fdopen")
#pragma binding(msvcrt::_byteswap_ulong,  "_byteswap_ulong")
#pragma binding(msvcrt::_byteswap_uint64, "_byteswap_uint64")
#pragma binding(msvcrt::_byteswap_ushort, "_byteswap_ushort")
// `__acrt_iob_func(int)` is the CRT helper that returns a
// FILE * to the requested standard stream (0=stdin, 1=stdout,
// 2=stderr). Used by `__c5_lazy_stream` above to back the
// `stdin` / `stdout` / `stderr` macros on Windows -- msvcrt
// doesn't export those as data symbols.
// `__iob_func()` is the pre-UCRT spelling msvcrt.dll exports;
// `__acrt_iob_func(int)` is the UCRT replacement. Wine's bundled
// msvcrt is the legacy flavour, so bind the legacy spelling and
// teach `__c5_lazy_stream` to walk the returned FILE-array slot.
#pragma binding(msvcrt::__iob_func, "__iob_func")
#endif

int printf(char *fmt, ...);
int wprintf(const unsigned short *fmt, ...);
int fprintf(FILE *stream, char *fmt, ...);
int sprintf(char *buf, char *fmt, ...);
int snprintf(char *buf, int size, char *fmt, ...);
// Alias forms used by source that pre-rewrites the standard
// spelling through a per-platform `#define`. The msvcrt path
// binds both to the same `_snprintf` / `_vsnprintf` entry.
int _snprintf(char *buf, int size, char *fmt, ...);
int _vsnprintf(char *buf, int size, char *fmt, char *ap);
int sscanf(char *src, char *fmt, ...);
FILE *fopen(char *path, char *mode);
// C99 7.19.5.4: reopen a stream with a new file. Used by
// programs that re-route stdin / stdout / stderr to a file.
FILE *freopen(char *path, char *mode, FILE *stream);
int fclose(FILE *stream);
int fread(char *buf, int size, int n, FILE *stream);
int fwrite(char *buf, int size, int n, FILE *stream);
int fputs(char *s, FILE *stream);
char *fgets(char *buf, int n, FILE *stream);
int fputc(int c, FILE *stream);
int fgetc(FILE *stream);
// C99 7.19.7.5 / 7.19.7.8: `getc` / `putc` are functionally
// equivalent to `fgetc` / `fputc`. Spec permits multiple
// evaluations of the `stream` argument; libc implementations
// honour the same signature, so the binding is a direct alias.
int getc(FILE *stream);
int putc(int c, FILE *stream);
// C99 7.19.7.11: push one byte back onto an input stream.
int ungetc(int c, FILE *stream);
int putchar(int c);
int getchar();
// C99 7.19.4.3 / 7.19.4.4: temporary file streams.
FILE *tmpfile(void);
char *tmpnam(char *s);
// C99 7.19.5.5: convenience wrapper around setvbuf.
void setbuf(FILE *stream, char *buf);
int puts(char *s);
int perror(char *s);
int fseek(FILE *stream, int offset, int whence);
int ftell(FILE *stream);
int rewind(FILE *stream);
int fflush(FILE *stream);
int feof(FILE *stream);
int ferror(FILE *stream);
int clearerr(FILE *stream);
int setvbuf(FILE *stream, char *buf, int mode, int size);
int remove(char *path);
int rename(char *old_path, char *new_path);
#ifndef _WIN32
// POSIX open_memstream(3). Caller passes addresses of (char *,
// size_t) slots the libc updates as bytes are written; the
// `size_t` is c5's `int`-shaped machine word.
FILE *open_memstream(char **bufp, int *sizep);
#endif
#ifdef _WIN32
FILE *_wfopen(unsigned short *path, unsigned short *mode);
FILE *_wpopen(unsigned short *cmd, unsigned short *mode);
FILE *_popen(char *cmd, char *mode);
int   _pclose(FILE *stream);
int   _fileno(FILE *stream);
int   _isatty(int fd);
int   _setmode(int fd, int mode);
int   _access(char *path, int mode);
// MSVC CRT stat-result shapes. shell.c reads `st_size`, `st_mode`,
// `st_mtime`, and `st_ctime` so those fields live at the offsets
// the runtime expects. The 64-bit-time variant (`_stat64`) is the
// one shell.c reaches for to handle files past 2038.
struct _stat {
    unsigned int  st_dev;
    unsigned short st_ino;
    unsigned short st_mode;
    short         st_nlink;
    short         st_uid;
    short         st_gid;
    unsigned int  st_rdev;
    long long     st_size;
    long long     st_atime;
    long long     st_mtime;
    long long     st_ctime;
};
struct _stat64 {
    unsigned int  st_dev;
    unsigned short st_ino;
    unsigned short st_mode;
    short         st_nlink;
    short         st_uid;
    short         st_gid;
    unsigned int  st_rdev;
    long long     st_size;
    long long     st_atime;
    long long     st_mtime;
    long long     st_ctime;
};
// `__stat64` is an internal MSVC alias for `_stat64`; some
// shell.c paths reach for the double-underscore spelling. Same
// layout, same use; declared as its own struct because c5's
// struct-tag namespace doesn't track aliases.
struct __stat64 {
    unsigned int  st_dev;
    unsigned short st_ino;
    unsigned short st_mode;
    short         st_nlink;
    short         st_uid;
    short         st_gid;
    unsigned int  st_rdev;
    long long     st_size;
    long long     st_atime;
    long long     st_mtime;
    long long     st_ctime;
};
#define _S_IFMT       0xF000
#define _S_IFDIR      0x4000
#define _S_IFCHR      0x2000
#define _S_IFIFO      0x1000
#define _S_IFREG      0x8000
#define _S_IREAD      0x0100
#define _S_IWRITE     0x0080
#define _S_IEXEC      0x0040
int   _stat(char *path, struct _stat *buf);
int   _stat64(char *path, struct _stat64 *buf);
int   _fstat64(int fd, void *buf);
int   _wstat(unsigned short *path, struct _stat *buf);
int   _wchmod(unsigned short *path, int mode);
int   _wmkdir(unsigned short *path);
int   _wunlink(unsigned short *path);
unsigned short *_wfullpath(unsigned short *abs, unsigned short *rel, long long size);
long long _wfindfirst(unsigned short *pat, void *find_data);
int   _wfindnext(long long handle, void *find_data);
int   _findclose(long long handle);
unsigned short *fgetws(unsigned short *buf, int n, FILE *stream);
int   fputws(unsigned short *s, FILE *stream);
unsigned short *_getws(unsigned short *buf);
int   _putws(unsigned short *s);
unsigned short *_wgetenv(unsigned short *name);
int   _wputenv(unsigned short *name_eq_value);
int   _wsystem(unsigned short *cmd);
unsigned short *_wgetcwd(unsigned short *buf, int n);
int   _wchdir(unsigned short *path);
int   _wrename(unsigned short *old, unsigned short *new_);
int   _wremove(unsigned short *path);
int   _wtoi(unsigned short *s);
long long wcslen(unsigned short *s);
int   wcscmp(unsigned short *a, unsigned short *b);
int   wcsncmp(unsigned short *a, unsigned short *b, long long n);
unsigned short *wcschr(unsigned short *s, int c);
unsigned short *wcsrchr(unsigned short *s, int c);
unsigned short *wcsstr(unsigned short *hay, unsigned short *needle);
unsigned short *wcscpy(unsigned short *dst, unsigned short *src);
unsigned short *wcsncpy(unsigned short *dst, unsigned short *src, long long n);
unsigned short *wcscat(unsigned short *dst, unsigned short *src);
unsigned short *wcsncat(unsigned short *dst, unsigned short *src, long long n);
unsigned short *wcsdup(unsigned short *s);
int   _wcsicmp(unsigned short *a, unsigned short *b);
int   localtime_s();
int   gmtime_s();
int   ctime_s();
int   asctime_s();
int   strerror_s();
char *_strdup();
int   _strnicmp();
int   _stricmp();
int   _get_errno();
int   _set_errno();
int  *_errno();
int   __argc();
char **__argv();
unsigned short **__wargv();
int   __getmainargs();
int   _getch();
int   _kbhit();
long long _msize(void *p);
int   _open(char *path, int flags, int mode);
int   _close(int fd);
long long _read(int fd, void *buf, long long n);
long long _write(int fd, void *buf, long long n);
long long _lseek(int fd, long long off, int whence);
long long _lseeki64(int fd, long long off, int whence);
int   _chsize(int fd, long long size);
int   _chsize_s(int fd, long long size);
int   _chmod(char *path, int mode);
int   _unlink(char *path);
char *_getcwd(char *buf, int n);
int   _chdir(char *path);
int   _getpid();
int   _dup(int fd);
int   _dup2(int fd, int newfd);
FILE *_fdopen(int fd, char *mode);
// Portable POSIX-style spelling for the same operation -- routed
// through `_fdopen` on Windows because msvcrt does not export the
// non-underscored name.
FILE *fdopen(int fd, char *mode);
unsigned int       _byteswap_ulong(unsigned int v);
unsigned long long _byteswap_uint64(unsigned long long v);
unsigned short     _byteswap_ushort(unsigned short v);
FILE *__iob_func();

// MSVC's `_findfirst`/`_findnext` companion structs. Layout
// pinned to the Win64 SDK so the kernel-emitted records match
// what shell.c reads. Per MSVC: `time_t` is 64-bit on the 64-bit
// CRT; `_fsize_t` is `unsigned long` (32-bit on LLP64). Wide
// names are 260 wchars; ANSI variant is 260 chars.
struct _finddata_t {
    unsigned int  attrib;
    long long     time_create;
    long long     time_access;
    long long     time_write;
    unsigned int  size;
    char          name[260];
};
struct _wfinddata_t {
    unsigned int   attrib;
    long long      time_create;
    long long      time_access;
    long long      time_write;
    unsigned int   size;
    unsigned short name[260];
};
struct _finddata64_t {
    unsigned int  attrib;
    long long     time_create;
    long long     time_access;
    long long     time_write;
    long long     size;
    char          name[260];
};
struct _wfinddata64_t {
    unsigned int   attrib;
    long long      time_create;
    long long      time_access;
    long long      time_write;
    long long      size;
    unsigned short name[260];
};
#define _A_NORMAL     0x00
#define _A_RDONLY     0x01
#define _A_HIDDEN     0x02
#define _A_SYSTEM     0x04
#define _A_SUBDIR     0x10
#define _A_ARCH       0x20

// `_setmode` flag values from <fcntl.h> on the MSVC CRT. Modes
// shell.c uses are O_BINARY (raw bytes through stdin/stdout for
// the shell pipeline) and O_TEXT / O_WTEXT (auto CRLF + locale-
// aware translation). Values pinned by the platform.
#define _O_TEXT       0x4000
#define _O_BINARY     0x8000
#define _O_WTEXT      0x10000
#define _O_U16TEXT    0x20000
#define _O_U8TEXT     0x40000
#define O_TEXT        _O_TEXT
#define O_BINARY      _O_BINARY
#endif
char *dlsym(char *handle, char *name);

// Lazy resolver for `stdin` / `stdout` / `stderr`. Index
// 0 = stdin, 1 = stdout, 2 = stderr.
//
// macOS exports `___stdinp` / `___stdoutp` / `___stderrp` --
// each is a `FILE *` (one indirection through the libc data
// section). dlsym hands back the address of those slots, so we
// dereference once to get the FILE* the caller actually wants.
// Note: dlsym strips one leading underscore, so pass the
// standard C name with two underscores -- not three even
// though `nm /usr/lib/libSystem.B.dylib` shows `___stdoutp`.
// macOS's RTLD_DEFAULT is `(void*)-2`, not `NULL` -- pass that
// in as the handle so dyld uses its fast cross-image search
// instead of the NULL-handle slow path that misses libc.
//
// Linux's symbols are spelled `stdin` / `stdout` / `stderr`
// without underscores; same shape otherwise.  RTLD_DEFAULT is
// the conventional NULL there.
//
// Windows msvcrt has `__iob_func()` returning an array of FILE
// structs -- left as a TODO for the Windows port.
//
// `&stdout` / `&stderr` won't typecheck through the macros
// below; callers that need an addressable `FILE *` lvalue
// have to fall back to `fdopen(...)`.
// Lazy resolver. char* return (rather than FILE*) keeps c5's
// type system from tangling on a struct-pointer return value
// inside a header. The macros below cast to `FILE *` at the
// call site; users' code reads `stdout` as `FILE *` exactly
// as on every other platform.
static char *__c5_lazy_stream(int idx) {
    static char *__c5_stream_cache[3];
    if (__c5_stream_cache[idx]) return __c5_stream_cache[idx];
#ifdef __APPLE__
    char *names[3];
    names[0] = "__stdinp";
    names[1] = "__stdoutp";
    names[2] = "__stderrp";
    char **slot = (char **)dlsym((char *)-2, names[idx]);
    if (slot) __c5_stream_cache[idx] = *slot;
#endif
#ifdef __linux__
    char *names[3];
    names[0] = "stdin";
    names[1] = "stdout";
    names[2] = "stderr";
    char **slot = (char **)dlsym((char *)0, names[idx]);
    if (slot) __c5_stream_cache[idx] = *slot;
#endif
#ifdef _WIN32
    // Windows msvcrt doesn't expose `stdin` / `stdout` / `stderr`
    // as exported data symbols. Programs reach the underlying
    // FILE * through the helper `__acrt_iob_func(int)`, which
    // returns a pointer into the CRT's per-process `_iob` array.
    // Older msvcrt (pre-UCRT) called the same helper `__iob_func`
    // -- bind both spellings and let the CRT pick whichever it
    // exports.
    // msvcrt's `__iob_func()` returns a pointer to its 3-entry
    // `_iob` array (stdin / stdout / stderr). On the legacy
    // (pre-UCRT) wine / Windows msvcrt, `sizeof(_iobuf)` is 48
    // bytes -- 8B _ptr + 4B _cnt (+4B padding) + 8B _base + 4B
    // _flag + 4B _file + 4B _charbuf + 4B _bufsiz + 8B _tmpfname.
    // We need the address of the requested entry, so cast the
    // base to a byte pointer and step by 48 bytes per slot.
    char *iob = (char *)__iob_func();
    if (iob) __c5_stream_cache[idx] = iob + idx * 48;
#endif
    return __c5_stream_cache[idx];
}

#define stdin   ((FILE *)__c5_lazy_stream(0))
#define stdout  ((FILE *)__c5_lazy_stream(1))
#define stderr  ((FILE *)__c5_lazy_stream(2))

// libc's vfprintf / vprintf / vsprintf / vsnprintf take a
// platform-native va_list -- a register-save struct on aarch64 /
// x86_64, not the flat `long long *` cursor c5's <stdarg.h>
// produces. Calling libc directly with c5's va_list returns
// garbage; we route every v* call through a c5-side formatter
// (`c5_vsnprintf` in <c5io.h>) that walks the cursor the way c5
// emits it.
//
// Plain printf / fprintf / sprintf / snprintf still bind to libc
// because their `...` varargs go through the host ABI's register
// packing -- the platform's variadic call shape is exactly what
// the c5 codegen emits for `func(a, b, c)`, so no bridge is
// needed there. Only the v* variants need the c5 detour.
//
// User-side syntax doesn't change: source still calls
// `vfprintf(stream, fmt, ap)` etc.; the macros below redirect
// the call to the c5-side implementation. A downstream
// `#define foo_vfprintf vfprintf` style alias transitively
// follows the redirect because the v* macros are object-like
// (see the note below).
#include <c5io.h>

static int c5_vfprintf_FILE(FILE *out, char *fmt, va_list ap) {
    char buf[8192];
    int n;
    n = c5_vsnprintf(buf, 8192, fmt, ap);
    fputs(buf, out);
    return n;
}

static int c5_vprintf_stdout(char *fmt, va_list ap) {
    return c5_vfprintf_FILE(stdout, fmt, ap);
}

// Unbounded buffer formatter -- mirrors libc's vsprintf, where
// the caller is responsible for sizing the buffer. Implemented
// as a thin wrapper around c5_vsnprintf with INT_MAX as the
// cap.
static int c5_vsprintf_unbounded(char *buf, char *fmt, va_list ap) {
    return c5_vsnprintf(buf, 0x7FFFFFFF, fmt, ap);
}

// Object-like aliases (rather than function-like) so the
// substitution chain works even through an intermediate
// object-like alias like `#define foo_vfprintf vfprintf`. c5's
// preprocessor rescans only the expansion text for further
// macro names, not the surrounding tokens (C99 6.10.3.4
// strictly requires both), so a function-like
// `#define vfprintf(s,f,a) ...` would only expand at direct
// `vfprintf(...)` call sites and leave the alias-derived
// `vfprintf` tokens unresolved. Object-like aliases sidestep
// the rescan-window issue: the substitution doesn't depend on
// a `(` check.
//
// vsprintf passes 0x7FFFFFFF as the size cap (= effectively
// unlimited) so the unbounded shape matches libc semantics; in
// practice the c5 caller has to supply a buffer large enough
// for the output -- vsnprintf (the bounded form) is the safer
// choice and where most code lands.
#define vfprintf  c5_vfprintf_FILE
#define vprintf   c5_vprintf_stdout
#define vsnprintf c5_vsnprintf
#define vsprintf  c5_vsprintf_unbounded

// Windows-flavoured sources pre-rewrite the v* names with leading
// underscores (`#define vsnprintf _vsnprintf` is a common idiom in
// MSVC-compatibility blocks). The macro substitution lands on
// `_vsnprintf` *before* the redirection above gets a chance to
// fire, so the call resolves against the msvcrt `#pragma binding`
// for `_vsnprintf` -- a real CRT entry point whose va_list ABI is
// the platform-native register-save struct, not the long-long
// cursor c5's <stdarg.h> produces. Alias the underscored spellings
// to the same c5-side shims so the cursor-format va_list reaches a
// walker that understands it. Without this, callers see the wrong
// slot stride and every argument past the first reads garbage.
#define _vfprintf  c5_vfprintf_FILE
#define _vprintf   c5_vprintf_stdout
#define _vsnprintf c5_vsnprintf
#define _vsprintf  c5_vsprintf_unbounded
