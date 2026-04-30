// unistd.h -- POSIX file descriptor I/O.
//
// On Windows, msvcrt exports the underscored forms (`_open`, `_read`,
// `_close`, `_write`) since the unprefixed versions belong to MSVC's
// "deprecated" Posix-compat layer that isn't always available. The
// portable c4-side names stay the same; only the bound symbol differs.

#pragma once

#define STDIN_FILENO  0
#define STDOUT_FILENO 1
#define STDERR_FILENO 2

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::open,  "_open")
#pragma binding(libc::read,  "_read")
#pragma binding(libc::close, "_close")
#pragma binding(libc::write, "_write")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::open,  "open")
#pragma binding(libc::read,  "read")
#pragma binding(libc::close, "close")
#pragma binding(libc::write, "write")
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::open,  "_open")
#pragma binding(msvcrt::read,  "_read")
#pragma binding(msvcrt::close, "_close")
#pragma binding(msvcrt::write, "_write")
#endif

int open(char *path, int flags);
int read(int fd, char *buf, int n);
int close(int fd);
int write(int fd, char *buf, int n);
