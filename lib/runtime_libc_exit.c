// Runtime libc-`exit` wrapper. Linked only into native
// executables whose writer emits a `_start` CRT stub; the stub
// calls `__c5_exit` instead of the raw `exit_group` syscall so
// libc's `exit` runs the atexit chain (including the stdio
// fflush) before the kernel reaps the process.
//
// Images with no `_start` stub -- shared libraries and
// passthrough-entry subsystems (native / EFI), where the
// kernel or firmware calls the user entry directly -- do not
// link this source, so they carry no user-mode libc `exit`
// import. A kernel-mode driver cannot resolve `msvcrt!exit`.

// Bind to libc's `exit` ourselves so the helper resolves
// regardless of what the user TU includes. The per-OS dylib
// name mirrors `<stdlib.h>`'s convention.
#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::exit, "_exit")
#elif defined(__linux__)
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::exit, "exit")
#elif defined(_WIN32)
#pragma dylib(libc, "msvcrt.dll")
#pragma binding(libc::exit, "exit")
#endif

extern void exit(int);

void __c5_exit(int rc) {
    exit(rc);
}
