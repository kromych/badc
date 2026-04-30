// fcntl.h -- file control flags (subset) + the fcntl() syscall.
//
// `open()` itself is bound in <unistd.h>, where POSIX puts it;
// pulling fcntl in only when you need the flags keeps the binding
// sets terse. fcntl() lives here too so callers that want to flip
// O_NONBLOCK on a fd don't need to fish through dlsym.

#pragma once

#define O_RDONLY 0
#define O_WRONLY 1
#define O_RDWR   2

#define F_GETFL  3
#define F_SETFL  4

#ifdef __APPLE__
#define O_NONBLOCK 4
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::fcntl, "_fcntl")
int fcntl(int fd, int cmd, int arg);
#endif

#ifdef __linux__
#define O_NONBLOCK 04000
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::fcntl, "fcntl")
int fcntl(int fd, int cmd, int arg);
#endif
