// Runtime support auto-linked into the native-link path.
//
// Embedded into the badc binary at build time via
// `src/c5/runtime.rs::EMBEDDED_RUNTIME` (mirrors the
// `embedded_headers` registry) and compiled + linked alongside the
// user's translation units.
//
// Two gates, both defined by the driver:
//
// * `__BADC_C5_CRT__` -- the image may import the user-mode C
//   library (hosted executables and shared libraries; native / EFI
//   subsystems and freestanding images leave it undefined -- a
//   kernel-mode driver cannot resolve `msvcrt!exit`).
// * `__BADC_C5_START__` -- the image writer emits an entry stub
//   (hosted executables only). Shared libraries link the CRT section
//   but not the startup section: `environ` belongs to the host
//   process, not a library that imports it.

#ifdef __BADC_C5_CRT__
#ifdef _WIN32

// C99 7.19.6.5p3 / 7.19.6.12p3: snprintf / vsnprintf return the
// length the output would have had without truncation and always
// NUL-terminate a nonempty buffer. msvcrt's `_vsnprintf` returns -1
// on truncation and omits the NUL, so the standard spellings resolve
// to these definitions (`<stdio.h>` declares them without a binding
// on Windows); `_vscprintf` supplies the untruncated length.
#pragma dylib(libc, "msvcrt.dll")
#pragma binding(libc::_vsnprintf, "_vsnprintf")
#pragma binding(libc::_vscprintf, "_vscprintf")

extern int _vsnprintf(char *buf, unsigned long long count, char *fmt, void *ap);
extern int _vscprintf(char *fmt, void *ap);

int vsnprintf(char *buf, int size, char *fmt, void *ap) {
    int len = _vscprintf(fmt, ap);
    if (len < 0) {
        return len;
    }
    if (size > 0) {
        _vsnprintf(buf, size, fmt, ap);
        if (len >= size) {
            buf[size - 1] = 0;
        }
    }
    return len;
}

// Windows `va_list` is a byte cursor over the home area / stack
// (see `<stdarg.h>`); the intrinsics take the cursor's address.
#pragma intrinsic("__builtin_va_start")
#pragma intrinsic("__builtin_va_end")
void __builtin_va_start(void **ap, void *last_addr);
void __builtin_va_end(void **ap);

int snprintf(char *buf, int size, char *fmt, ...) {
    void *ap;
    int len;
    __builtin_va_start(&ap, (void *)&fmt);
    len = vsnprintf(buf, size, fmt, ap);
    __builtin_va_end(&ap);
    return len;
}

// POSIX setenv (IEEE Std 1003.1): with overwrite == 0 an existing
// binding is left untouched and 0 is returned. msvcrt's
// `_putenv_s(name, value)` has no overwrite flag and always replaces,
// so probe `getenv` first and write only when the name is absent or a
// replacement is requested (`<stdlib.h>` leaves setenv unbound on
// Windows so this definition resolves it).
#pragma binding(libc::getenv, "getenv")
#pragma binding(libc::_putenv_s, "_putenv_s")
extern char *getenv(char *name);
extern int _putenv_s(char *name, char *value);

int setenv(char *name, char *value, int overwrite) {
    if (overwrite == 0 && getenv(name) != 0) {
        return 0;
    }
    return _putenv_s(name, value);
}

#endif
#endif

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
// (see <unistd.h>) and Windows binds `environ` / `_environ` /
// `_wenviron` to msvcrt's live vectors (see <stdlib.h>), so on both
// the symbols must stay undefined here for references to route
// through the import rather than a local cell nothing populates.
#if !defined(__APPLE__) && !defined(_WIN32)
char **environ;
#endif
#if defined(__linux__)
// POSIX `tzset` outputs. Like `environ`, the Linux bindings route these
// through a COPY relocation against the C library's symbols so a read
// after `tzset()` sees what the library wrote; the local slots here are
// the relocation targets. Windows binds them as msvcrt data imports on
// both architectures (see <time.h>), so the symbols must stay
// undefined there.
char *tzname[2];
long timezone;
int daylight;
#endif

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
// The entry shape follows the entry symbol, not the PE subsystem:
// `__BADC_WIN_WINMAIN__` selects the `WinMain` shape, `__BADC_WIN_WIDE__`
// the `wmain` shape, otherwise `main` with argc/argv. A GUI-subsystem
// program with a plain `main` therefore still receives argc/argv.
//   `nShowCmd` is `SW_SHOWNORMAL` (1), not `SW_SHOWDEFAULT` (10);
// `SW_SHOWDEFAULT` defers to `STARTUPINFOA::wShowWindow`, which is
// `SW_HIDE` when a parent left it zero without `STARTF_USESHOWWINDOW`.
#ifdef __BADC_WIN_WINMAIN__

// WinMain / wWinMain: (hInstance, hPrevInstance, lpCmdLine, nShowCmd).
// `__BADC_WIN_WIDE__` selects the wide `wWinMain` (LPWSTR command line).
#pragma dylib(kernel32, "kernel32.dll")
#pragma binding(kernel32::GetModuleHandleA, "GetModuleHandleA")

extern void *GetModuleHandleA(void *module_name);

void *__c5_getmodulehandle(void) {
    return GetModuleHandleA(0);
}

#ifdef __BADC_WIN_WIDE__
#pragma binding(kernel32::GetCommandLineW, "GetCommandLineW")
extern unsigned short *GetCommandLineW(void);
extern int __BADC_ENTRY__(void *instance, void *prev_instance,
                          unsigned short *cmd_line, int show_cmd);

unsigned short *__c5_getcommandlinew(void) {
    return GetCommandLineW();
}

void __c5_entry(void *sp, long image_off) {
    (void)sp;
    (void)image_off;
    __c5_exit(__BADC_ENTRY__(__c5_getmodulehandle(), 0, __c5_getcommandlinew(), 1));
}
#else
#pragma binding(kernel32::GetCommandLineA, "GetCommandLineA")
extern char *GetCommandLineA(void);
extern int __BADC_ENTRY__(void *instance, void *prev_instance,
                          char *cmd_line, int show_cmd);

char *__c5_getcommandline(void) {
    return GetCommandLineA();
}

void __c5_entry(void *sp, long image_off) {
    (void)sp;
    (void)image_off;
    __c5_exit(__BADC_ENTRY__(__c5_getmodulehandle(), 0, __c5_getcommandline(), 1));
}
#endif

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
