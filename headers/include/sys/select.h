// sys/select.h -- select(2) multiplexer.
//
// Per-target binding for select(). On Windows the symbol lives in
// ws2_32.dll (alongside the rest of the socket surface); on POSIX
// it's plain libc.
//
// fd_set is just a bitmap and the c4 dialect doesn't have macros
// for FD_ZERO / FD_SET / FD_ISSET. The portable cookie-cutter is
// to malloc FD_SETSIZE/8 bytes (128 on Linux, larger on Windows
// since Windows fd_set wraps an array of socket handles rather
// than a bitmap -- but 128 is fine for small servers) and use
// raw byte ops to flip bits.

#pragma once

#define FD_SETSIZE   1024
#define FD_SET_BYTES 128             // FD_SETSIZE / 8

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::select, "_select")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::select, "select")
#endif

#ifdef _WIN32
#pragma dylib(ws2_32, "ws2_32.dll")
#pragma binding(ws2_32::select, "select")
#endif

int select(int nfds, char *rfds, char *wfds, char *efds, char *timeout);
