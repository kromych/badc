// Runtime helpers auto-linked into every native executable.
//
// Embedded into the badc binary at build time via
// `src/c5/runtime.rs::EMBEDDED_RUNTIME` (mirrors the
// `embedded_headers` registry) and compiled + linked alongside
// the user's translation units in the native-link path.
//
// Today this is a single hook used by the writer's `_start`
// stub to flush stdio buffers (via libc's `exit` atexit chain)
// before the process leaves. Future entries: the `_start`
// stub itself once c5 grows inline asm or a syscall builtin,
// and the c5io / variadic plumbing currently inlined into
// each TU through `c5io.h`.

// Bind to libc's `exit` ourselves so the runtime helper
// resolves regardless of what the user TU includes. The
// per-OS dylib name mirrors `<stdlib.h>`'s convention.
#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::exit, "_exit")
#elif defined(__linux__)
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::exit, "exit")
#elif defined(_WIN32)
#pragma dylib(libc, "ucrtbase.dll")
#pragma binding(libc::exit, "exit")
#endif

extern void exit(int);

// Exit through libc rather than the raw `exit_group` syscall.
// libc's `exit` runs the atexit chain (including the stdio
// fflush) before invoking the kernel, so any buffered output
// is committed before the program leaves.
void __c5_exit(int rc) {
    exit(rc);
}

// POSIX `environ` -- defined here as the single canonical
// slot. Bundled headers (`<unistd.h>`, `<stdlib.h>`) declare
// it as `extern char **environ;` so each TU references this
// one definition rather than contributing a tentative def of
// its own. Coalescing tentative defs into a SHN_COMMON slot
// is a separate TODO; until that lands, hosting the definition
// in the runtime side-steps the multiple-definition collision.
char **environ;

// msvcrt's environment-vector alias on Windows. `<stdlib.h>`'s
// `_WIN32` section declares it `extern char **_environ;` for
// the same reason `environ` lives here -- a per-TU tentative
// def would collide once two Windows TUs land in the same link.
char **_environ;
