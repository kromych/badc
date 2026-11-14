#pragma once

// pty.h -- Linux pseudo-terminal helpers (libutil). macOS exposes the
// same set through <util.h>.

// glibc's <pty.h> includes <termios.h>, so a program that reaches the
// pty helpers through this header alone still sees `struct termios`.
#include <termios.h>

#ifdef __linux__
#pragma dylib(libutil, "libutil.so.1")
#pragma binding(libutil::openpty,   "openpty")
#pragma binding(libutil::forkpty,   "forkpty")
#pragma binding(libutil::login_tty, "login_tty")

// Allocate a pseudo-terminal pair; `name`, `termp` and `winp` may be null.
struct termios;
struct winsize;
int openpty(int *amaster, int *aslave, char *name, const struct termios *termp,
            const struct winsize *winp);
// fork() with the child on a new pseudo-terminal; returns a pid.
int forkpty(int *amaster, char *name, const struct termios *termp,
            const struct winsize *winp);
// Make `fd` the controlling terminal of the calling session.
int login_tty(int fd);
#endif
