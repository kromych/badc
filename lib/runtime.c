// Runtime support auto-linked into the native-link path.
//
// Embedded into the badc binary at build time via
// `src/c5/runtime.rs::EMBEDDED_RUNTIME` (mirrors the
// `embedded_headers` registry) and compiled + linked alongside the
// user's translation units.
//
// Everything here is gated on `__BADC_C5_START__`, which the driver
// defines only when the image writer emits an entry stub -- i.e. for
// a hosted executable. Shared libraries and passthrough-entry
// subsystems (native / EFI) leave it undefined and link none of it:
// they carry no user-mode CRT import (a kernel-mode driver cannot
// resolve `msvcrt!exit`), and `environ` belongs to the host process,
// not a library that imports it.

#ifdef __BADC_C5_START__

// The entry symbol `__c5_entry` calls. Defaults to `main`;
// `#pragma entrypoint(<name>)` / `--entry=<name>` retarget it, and the
// driver redefines `__BADC_ENTRY__` for the runtime TU to match. The
// signature is selected by the GUI / wide gating below.
#ifndef __BADC_ENTRY__
#define __BADC_ENTRY__ main
#endif

// POSIX `environ` -- the single canonical slot for a hosted image.
// Bundled headers (`<unistd.h>`, `<stdlib.h>`) declare it as
// `extern char **environ;` so each TU references this one definition
// rather than contributing a tentative def of its own. Coalescing
// tentative defs into a SHN_COMMON slot is a separate TODO; until
// that lands, hosting the definition here side-steps the
// multiple-definition collision.
//
// macOS binds `environ` as a GOT data import to libSystem's `_environ`
// (see <unistd.h>), so the symbol must stay undefined here for the
// reference to route through the import slot rather than a local cell.
#ifndef __APPLE__
char **environ;
#endif

// msvcrt's environment-vector alias on Windows. `<stdlib.h>`'s
// `_WIN32` section declares it `extern char **_environ;` for the same
// reason `environ` lives here.
char **_environ;

// `__c5_exit` runs libc's `exit` so the atexit chain (including the
// stdio flush) executes before the kernel reaps the process. The
// per-OS dylib name mirrors `<stdlib.h>`'s convention.
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

#ifdef __linux__
// Linux process entry. The image writer's entry adapter hands control
// here with the initial stack pointer in the first argument and the
// entry's offset from the image base in the second; the kernel
// process-startup layout puts argc at sp[0] and argv at sp+1. main's
// result goes through __c5_exit so libc's atexit chain + stdio flush
// run before the kernel reaps the process.
extern int __BADC_ENTRY__(int argc, char **argv);

void __c5_entry(void *sp, long image_off) {
    (void)image_off;
    long *frame = (long *)sp;
    int argc = (int)frame[0];
    char **argv = (char **)(frame + 1);
    // The kernel lays the environment vector right after argv's NULL
    // terminator, so envp is `&argv[argc + 1]`. crt startup publishes it
    // through `environ` (POSIX 8.3); without this the global stays NULL
    // and an `environ[i]` read faults.
    environ = argv + argc + 1;
    __c5_exit(__BADC_ENTRY__(argc, argv));
}
#endif

#ifdef _WIN32
// Windows process startup. The Windows entry ABI is not the SysV
// stack layout, so the adapter's `sp` / `image_off` are ignored; argv
// comes from the CRT instead. `__c5_*` argv helpers own the
// CRT-specific call shape so the writer only references the names.
// `__BADC_WIN_GUI__` selects the kernel32 `WinMain` path;
// `__BADC_WIN_WIDE__` the `wmain` path; otherwise `main`.
//   `nShowCmd` is `SW_SHOWNORMAL` (1), not `SW_SHOWDEFAULT` (10);
// `SW_SHOWDEFAULT` defers to `STARTUPINFOA::wShowWindow`, which is
// `SW_HIDE` when a parent left it zero without `STARTF_USESHOWWINDOW`.
#ifdef __BADC_WIN_GUI__

#pragma dylib(kernel32, "kernel32.dll")
#pragma binding(kernel32::GetModuleHandleA, "GetModuleHandleA")
#pragma binding(kernel32::GetCommandLineA, "GetCommandLineA")

extern void *GetModuleHandleA(void *module_name);
extern char *GetCommandLineA(void);
extern int __BADC_ENTRY__(void *instance, void *prev_instance,
                          char *cmd_line, int show_cmd);

void *__c5_getmodulehandle(void) {
    return GetModuleHandleA(0);
}

char *__c5_getcommandline(void) {
    return GetCommandLineA();
}

void __c5_entry(void *sp, long image_off) {
    (void)sp;
    (void)image_off;
    __c5_exit(__BADC_ENTRY__(__c5_getmodulehandle(), 0, __c5_getcommandline(), 1));
}

#else

// `__getmainargs` / `__wgetmainargs` populate argc/argv through
// out-pointers. The fifth argument is a `_startupinfo` (`int
// newmode`); zero requests the default. envp is filled but unused.
#pragma binding(libc::__getmainargs, "__getmainargs")
#pragma binding(libc::__wgetmainargs, "__wgetmainargs")

extern int __getmainargs(int *argc, char ***argv, char ***envp,
                         int do_wildcard, void *startup_info);
extern int __wgetmainargs(int *argc, unsigned short ***argv,
                          unsigned short ***envp, int do_wildcard,
                          void *startup_info);

void __c5_getmainargs(int *argc, char ***argv) {
    char **envp;
    int startup_info = 0;
    __getmainargs(argc, argv, &envp, 0, &startup_info);
}

void __c5_wgetmainargs(int *argc, unsigned short ***argv) {
    unsigned short **envp;
    int startup_info = 0;
    __wgetmainargs(argc, argv, &envp, 0, &startup_info);
}

#ifdef __BADC_WIN_WIDE__
extern int __BADC_ENTRY__(int argc, unsigned short **argv);

void __c5_entry(void *sp, long image_off) {
    (void)sp;
    (void)image_off;
    int argc;
    unsigned short **argv;
    __c5_wgetmainargs(&argc, &argv);
    __c5_exit(__BADC_ENTRY__(argc, argv));
}
#else
extern int __BADC_ENTRY__(int argc, char **argv);

void __c5_entry(void *sp, long image_off) {
    (void)sp;
    (void)image_off;
    int argc;
    char **argv;
    __c5_getmainargs(&argc, &argv);
    __c5_exit(__BADC_ENTRY__(argc, argv));
}
#endif

#endif
#endif

#endif
