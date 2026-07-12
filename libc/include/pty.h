#pragma once

// pty.h -- Linux pseudo-terminal helpers (libutil). macOS exposes the
// same set through <util.h>.

#ifdef __linux__
#pragma dylib(libutil, "libutil.so.1")
#pragma binding(libutil::openpty,   "openpty")
#pragma binding(libutil::forkpty,   "forkpty")
#pragma binding(libutil::login_tty, "login_tty")

// Allocate a pseudo-terminal pair. `name`, `termp` (struct termios) and
// `winp` (struct winsize) are opaque to c5 and may be null.
int openpty(int *amaster, int *aslave, char *name, char *termp, char *winp);
// fork() with the child on a new pseudo-terminal; returns a pid.
int forkpty(int *amaster, char *name, char *termp, char *winp);
// Make `fd` the controlling terminal of the calling session.
int login_tty(int fd);
#endif
