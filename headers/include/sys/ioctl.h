// sys/ioctl.h -- device control. The subset terminal-aware programs
// reach for: the window-size query.

#pragma once

// Terminal window size. ws_row / ws_col are the cell dimensions;
// the pixel fields are usually zero. Layout matches macOS and Linux.
struct winsize {
    unsigned short ws_row;
    unsigned short ws_col;
    unsigned short ws_xpixel;
    unsigned short ws_ypixel;
};

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::ioctl, "_ioctl")
// BSD encodes the request number with the argument size in the high
// bits; TIOCGWINSZ reads an 8-byte struct winsize.
#define TIOCGWINSZ 0x40087468
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::ioctl, "ioctl")
#define TIOCGWINSZ 0x5413
#endif

#ifdef _WIN32
// No POSIX ioctl on Windows; console dimensions come from
// GetConsoleScreenBufferInfo in <windows.h>.
#define TIOCGWINSZ 0x5413
#endif

// POSIX (XSH) and both target libcs declare ioctl variadic; Darwin's
// wrapper reads the argument via va_arg, so a fixed-arity prototype
// passes it where the callee does not look (Darwin arm64 takes
// variadic arguments from the stack).
int ioctl(int fd, unsigned long request, ...);

// ioctl request codes referenced by terminal/file modules. Per-target codes.
#ifndef FIOASYNC
#if defined(__APPLE__)
#define FIOASYNC 2147772029
#elif defined(__linux__)
#define FIOASYNC 0x5452
#endif
#endif
#ifndef FIOCLEX
#if defined(__APPLE__)
#define FIOCLEX 536897025
#elif defined(__linux__)
#define FIOCLEX 0x5451
#endif
#endif
#ifndef FIONBIO
#if defined(__APPLE__)
#define FIONBIO 2147772030
#elif defined(__linux__)
#define FIONBIO 0x5421
#endif
#endif
#ifndef FIONCLEX
#if defined(__APPLE__)
#define FIONCLEX 536897026
#elif defined(__linux__)
#define FIONCLEX 0x5450
#endif
#endif
#ifndef FIONREAD
#if defined(__APPLE__)
#define FIONREAD 1074030207
#elif defined(__linux__)
#define FIONREAD 0x541b
#endif
#endif
#ifdef __APPLE__
// BSD terminal size. TIOCGSIZE / TIOCSSIZE are aliases of TIOCGWINSZ /
// TIOCSWINSZ on this platform, and `struct ttysize` is layout-compatible with
// `struct winsize`; programs that prefer this spelling fill ts_cols / ts_lines.
struct ttysize {
    unsigned short ts_lines;
    unsigned short ts_cols;
    unsigned short ts_xxx;
    unsigned short ts_yyy;
};
#ifndef TIOCGSIZE
#define TIOCGSIZE 1074295912
#endif
#ifndef TIOCSSIZE
#define TIOCSSIZE 2148037735
#endif
#endif
