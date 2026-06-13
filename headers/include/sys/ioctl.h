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

int ioctl(int fd, unsigned long request, void *argp);
