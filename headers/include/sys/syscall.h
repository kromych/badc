#pragma once

// Linux syscall numbers. The set is architecture-specific; only the
// numbers reached for by the bundled demos are listed.

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::syscall, "syscall")

#if defined(__aarch64__)
#define SYS_gettid     178
#define SYS_getrandom  278
#else
#define SYS_gettid     186
#define SYS_getrandom  318
#endif

long syscall(long number, ...);
#endif
