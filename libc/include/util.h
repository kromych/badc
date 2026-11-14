// util.h -- Darwin pseudo-terminal helpers (the BSD libutil surface,
// re-exported by libSystem). macOS only; Linux exposes these through
// <pty.h>.

#pragma once

// The BSD <util.h> includes <termios.h>, as glibc's <pty.h> does.
#include <termios.h>

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::openpty,   "_openpty")
#pragma binding(libc::forkpty,   "_forkpty")
#pragma binding(libc::login_tty, "_login_tty")

// Allocate a pseudo-terminal pair; `name`, `termp` and `winp` may be null.
struct termios;
struct winsize;
int openpty(int *amaster, int *aslave, char *name, struct termios *termp,
            struct winsize *winp);
// fork() with the child on a new pseudo-terminal; returns a pid.
int forkpty(int *amaster, char *name, struct termios *termp, struct winsize *winp);
// Make `fd` the controlling terminal of the calling session.
int login_tty(int fd);
#endif
