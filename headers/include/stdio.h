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

// setvbuf modes -- non-buffered, line-buffered, fully-buffered.
// macOS / Linux / Win32 all happen to use the same numeric
// values for these (2/1/0 respectively), so a single set works
// regardless of target.
#define _IONBF 2
#define _IOLBF 1
#define _IOFBF 0

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
// `&stdout` / `&stderr` won't typecheck through this path; the
// few standard-library users that need an addressable lvalue
// (none seen in sqlite3.c, shell.c, or the test fixtures) will
// have to fall back to `fdopen(...)`.
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
#pragma binding(libc::dlsym,     "_dlsym")
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
#pragma dylib(libdl_for_stdio, "libdl.so.2")
#pragma binding(libdl_for_stdio::dlsym, "dlsym")
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
#endif

int printf(char *fmt, ...);
int fprintf(FILE *stream, char *fmt, ...);
int sprintf(char *buf, char *fmt, ...);
int snprintf(char *buf, int size, char *fmt, ...);
int sscanf(char *src, char *fmt, ...);
FILE *fopen(char *path, char *mode);
int fclose(FILE *stream);
int fread(char *buf, int size, int n, FILE *stream);
int fwrite(char *buf, int size, int n, FILE *stream);
int fputs(char *s, FILE *stream);
char *fgets(char *buf, int n, FILE *stream);
int fputc(int c, FILE *stream);
int fgetc(FILE *stream);
int putchar(int c);
int getchar();
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
int   _stat(char *path, struct _stat *buf);
int   _stat64(char *path, struct _stat64 *buf);
int   _fstat64(int fd, struct _stat64 *buf);
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
// below; the few standard-library users that need an
// addressable lvalue (none seen in sqlite3.c, shell.c, or the
// test fixtures) will have to fall back to `fdopen(...)`.
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
// `vfprintf(stream, fmt, ap)` etc.; the macros below redirect the
// call to the c5-side implementation. The upstream sqlite shell
// `#define sqlite3_vfprintf vfprintf` transitively follows.
#include <c5io.h>

int c5_vfprintf_FILE(FILE *out, char *fmt, va_list ap) {
    char buf[8192];
    int n;
    n = c5_vsnprintf(buf, 8192, fmt, ap);
    fputs(buf, out);
    return n;
}

int c5_vprintf_stdout(char *fmt, va_list ap) {
    return c5_vfprintf_FILE(stdout, fmt, ap);
}

// Unbounded buffer formatter -- mirrors libc's vsprintf, where
// the caller is responsible for sizing the buffer. Implemented
// as a thin wrapper around c5_vsnprintf with INT_MAX as the
// cap.
int c5_vsprintf_unbounded(char *buf, char *fmt, va_list ap) {
    return c5_vsnprintf(buf, 0x7FFFFFFF, fmt, ap);
}

// Object-like aliases (rather than function-like) so the
// substitution chain works even through an intermediate
// object-like alias like sqlite's
// `#define sqlite3_vfprintf vfprintf`. c5's preprocessor
// rescans only the expansion text for further macro names, not
// the surrounding tokens (C99 6.10.3.4 strictly requires both),
// so a function-like `#define vfprintf(s,f,a) ...` would only
// expand at direct `vfprintf(...)` call sites and leave
// `sqlite3_vfprintf(...)`-derived `vfprintf` tokens unresolved.
// Object-like aliases sidestep the rescan-window issue: the
// substitution doesn't depend on a `(` check.
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
