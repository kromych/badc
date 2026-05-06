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
#endif

int printf(char *fmt, ...);
int fprintf(FILE *stream, char *fmt, ...);
int sprintf(char *buf, char *fmt, ...);
int snprintf(char *buf, int size, char *fmt, ...);
int vfprintf(FILE *stream, char *fmt, char *args);
int vsprintf(char *buf, char *fmt, char *args);
int vsnprintf(char *buf, int size, char *fmt, char *args);
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
