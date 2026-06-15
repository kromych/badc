// util.h -- Darwin pseudo-terminal helpers (the BSD libutil surface,
// re-exported by libSystem). macOS only; Linux exposes these through
// <pty.h>.

#pragma once

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::openpty,   "_openpty")
#pragma binding(libc::forkpty,   "_forkpty")
#pragma binding(libc::login_tty, "_login_tty")

// Allocate a pseudo-terminal pair. `name`, `termp` (struct termios) and
// `winp` (struct winsize) are opaque to c5 and may be null.
int openpty(int *amaster, int *aslave, char *name, char *termp, char *winp);
// fork() with the child on a new pseudo-terminal; returns a pid.
int forkpty(int *amaster, char *name, char *termp, char *winp);
// Make `fd` the controlling terminal of the calling session.
int login_tty(int fd);
#endif
