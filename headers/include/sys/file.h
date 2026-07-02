// sys/file.h -- BSD advisory whole-file locks (flock(2)).

#pragma once

#if defined(__APPLE__) || defined(__linux__)

// Operation bits; identical in Darwin <sys/fcntl.h> and glibc
// <sys/file.h>.
#define LOCK_SH 0x01
#define LOCK_EX 0x02
#define LOCK_NB 0x04
#define LOCK_UN 0x08

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::flock, "_flock")
#endif
#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::flock, "flock")
#endif

// Apply or remove an advisory lock on the open file `fd`; `operation`
// is LOCK_SH, LOCK_EX, or LOCK_UN, optionally or'ed with LOCK_NB.
int flock(int fd, int operation);
#endif
