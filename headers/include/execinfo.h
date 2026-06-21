// <execinfo.h> -- call-stack backtrace support. A Linux / BSD / Darwin
// extension, not ISO C; provided here for sources that probe for it.

#pragma once

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::backtrace,            "_backtrace")
#pragma binding(libc::backtrace_symbols,    "_backtrace_symbols")
#pragma binding(libc::backtrace_symbols_fd, "_backtrace_symbols_fd")
#elif !defined(_WIN32)
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::backtrace,            "backtrace")
#pragma binding(libc::backtrace_symbols,    "backtrace_symbols")
#pragma binding(libc::backtrace_symbols_fd, "backtrace_symbols_fd")
#endif

int backtrace(void **buffer, int size);
char **backtrace_symbols(void *const *buffer, int size);
void backtrace_symbols_fd(void *const *buffer, int size, int fd);
