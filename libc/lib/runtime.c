// Runtime support auto-linked into the native-link path.
//
// Embedded into the badc binary at build time via
// `src/c5/runtime.rs::EMBEDDED_RUNTIME` (mirrors the
// `embedded_headers` registry) and compiled + linked alongside the
// user's translation units.
//
// The driver defines `__BADC_C5_START__` when the image writer emits an
// entry stub (hosted executables only; native / EFI subsystems,
// freestanding images and shared libraries leave it undefined:
// `environ` belongs to the host process, not a library that imports it).

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

// `__c5_exit` runs libc's `exit` so the atexit chain (including the
// stdio flush) executes before the kernel reaps the process. The
// per-OS dylib name mirrors `<stdlib.h>`'s convention.
#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::exit, "_exit")
#elif defined(__linux__)
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::exit, "exit")
#elif defined(_WIN32) && !defined(__BADC_WIN_UCRT__)
#pragma dylib(libc, "msvcrt.dll")
#pragma binding(libc::exit, "exit")
#endif

// `__BADC_WIN_UCRT__`: the link's own libraries supply the UCRT, whose
// startup interface the names below resolve through, as the VC startup
// code calls it; msvcrt.dll is not loaded beside it.
extern void exit(int);

void __c5_exit(int rc) {
    exit(rc);
}

// Constructors / destructors (`__attribute__((constructor))` /
// `((destructor))`). badc's linker lays out two arrays of function
// pointers in the image and defines the boundary symbols below; the
// entry (`__c5_entry`) walks `__init_array` forward before the program
// entry. Destructors run in reverse on exit through the platform atexit
// chain, so they fire on both a return from the entry and a direct
// `exit()`. An object linked by a system toolchain instead carries a
// real `.init_array` the platform C library runs, so both link paths
// execute the same functions.
typedef void (*__c5_init_fn)(void);
extern __c5_init_fn __init_array_start[];
extern __c5_init_fn __init_array_end[];
extern __c5_init_fn __fini_array_start[];
extern __c5_init_fn __fini_array_end[];

// Run destructors in reverse registration order.
static void __c5_run_fini_array(void) {
    __c5_init_fn *fn = __fini_array_end;
    while (fn != __fini_array_start) {
        fn--;
        (*fn)();
    }
}

#if defined(__linux__)
// The Linux C library exposes the exit chain as `__cxa_atexit`, whose
// handler takes a closure argument (see <stdlib.h>); the trampoline
// discards it. A NULL DSO handle registers on the main program's chain.
#pragma binding(libc::__cxa_atexit, "__cxa_atexit")
extern int __cxa_atexit(void (*)(void *), void *, void *);
static void __c5_fini_trampoline(void *arg) {
    (void)arg;
    __c5_run_fini_array();
}
static void __c5_register_fini(void) {
    __cxa_atexit(__c5_fini_trampoline, 0, 0);
}
#elif defined(_WIN32) && defined(__BADC_WIN_UCRT__)
// The UCRT keeps the program's table behind `_crt_atexit`; its `exit` runs
// it. The UCRT exports no `atexit`: the VC startup library defines it over
// `_crt_atexit` for a program, as here, unless another input does.
extern int _crt_atexit(void (*)(void));
static void __c5_register_fini(void) {
    _crt_atexit(__c5_run_fini_array);
}

__attribute__((weak)) int atexit(void (*fn)(void)) {
    return _crt_atexit(fn);
}
#elif defined(_WIN32)
// msvcrt exports `atexit` directly, taking a `void (*)(void)` handler.
#pragma binding(libc::atexit, "atexit")
extern int atexit(void (*)(void));
static void __c5_register_fini(void) {
    atexit(__c5_run_fini_array);
}
#elif defined(__APPLE__)
// libSystem spells the exit chain `_atexit`, taking a `void (*)(void)`.
#pragma binding(libc::atexit, "_atexit")
extern int atexit(void (*)(void));
static void __c5_register_fini(void) {
    atexit(__c5_run_fini_array);
}
#endif

void __c5_run_init_array(void) {
    // Register destructors before running constructors so a handler a
    // constructor installs with atexit() runs before the static
    // destructors -- the ordering a C library gives.
    if (__fini_array_end != __fini_array_start) {
        __c5_register_fini();
    }
    __c5_init_fn *fn;
    for (fn = __init_array_start; fn != __init_array_end; fn++) {
        (*fn)();
    }
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
    __c5_run_init_array();
    __c5_exit(__BADC_ENTRY__(argc, argv));
}
#endif

#ifdef __APPLE__
// macOS process entry. dyld enters through `LC_MAIN`, calling this like
// the program main -- `int (int argc, char **argv, char **envp, char
// **apple)` -- and passes the return value to `exit()`, so the atexit
// chain (destructors + stdio flush) runs without an explicit `__c5_exit`.
// The Mach-O writer points `LC_MAIN` at `__c5_entry` when it is linked
// (see mach_o::write); a bare single-TU image with no runtime keeps
// `LC_MAIN` on `main`. `environ` is a libSystem GOT import here, so it
// needs no startup assignment.
extern int __BADC_ENTRY__(int argc, char **argv);

int __c5_entry(int argc, char **argv) {
    __c5_run_init_array();
    return __BADC_ENTRY__(argc, argv);
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
#ifdef __BADC_WIN_UCRT__
// The application type (`_crt_gui_app` for the WinMain shape, else
// `_crt_console_app`), then the unexpanded argument vector and the
// environment in the entry's character width.
extern void _set_app_type(int);
extern int _configure_narrow_argv(int);

// The module's printf and scanf options, which the UCRT headers' inline
// functions read from the same storage: one definition of each survives
// the link. The VC startup code sets the legacy wide specifiers (`%s` of a
// wide format is a wide string) and, for printf, standard rounding, as
// measured with VC 14.44 and 14.52.
__declspec(noinline) __inline unsigned long long *__local_stdio_printf_options(void) {
    static unsigned long long __options;
    return &__options;
}

__declspec(noinline) __inline unsigned long long *__local_stdio_scanf_options(void) {
    static unsigned long long __options;
    return &__options;
}
extern int _configure_wide_argv(int);
extern int _initialize_narrow_environment(void);
extern int _initialize_wide_environment(void);

static void __c5_crt_startup(void) {
    *__local_stdio_printf_options() |= 4 | 32;
    *__local_stdio_scanf_options() |= 2;
#ifdef __BADC_WIN_WINMAIN__
    _set_app_type(2);
#else
    _set_app_type(1);
#endif
#ifdef __BADC_WIN_WIDE__
    _configure_wide_argv(1);
    _initialize_wide_environment();
#else
    _configure_narrow_argv(1);
    _initialize_narrow_environment();
#endif
}
#else
static void __c5_crt_startup(void) {}
#endif

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

// `lpCmdLine` is the command line past the program name, as cl's CRT
// passes it: the first token, quoted spans included, then its blanks.
unsigned short *__c5_getcommandlinew(void) {
    unsigned short *p = GetCommandLineW();
    int quoted = 0;
    while (*p > ' ' || (*p && quoted)) {
        if (*p == '"')
            quoted = !quoted;
        ++p;
    }
    while (*p && *p <= ' ')
        ++p;
    return p;
}

void __c5_entry(void *sp, long image_off) {
    (void)sp;
    (void)image_off;
    __c5_crt_startup();
    __c5_run_init_array();
    __c5_exit(__BADC_ENTRY__(__c5_getmodulehandle(), 0, __c5_getcommandlinew(), 1));
}
#else
#pragma binding(kernel32::GetCommandLineA, "GetCommandLineA")
extern char *GetCommandLineA(void);
extern int __BADC_ENTRY__(void *instance, void *prev_instance,
                          char *cmd_line, int show_cmd);

// `lpCmdLine` is the command line past the program name, as cl's CRT
// passes it: the first token, quoted spans included, then its blanks.
char *__c5_getcommandline(void) {
    unsigned char *p = (unsigned char *)GetCommandLineA();
    int quoted = 0;
    while (*p > ' ' || (*p && quoted)) {
        if (*p == '"')
            quoted = !quoted;
        ++p;
    }
    while (*p && *p <= ' ')
        ++p;
    return (char *)p;
}

void __c5_entry(void *sp, long image_off) {
    (void)sp;
    (void)image_off;
    __c5_crt_startup();
    __c5_run_init_array();
    __c5_exit(__BADC_ENTRY__(__c5_getmodulehandle(), 0, __c5_getcommandline(), 1));
}
#endif

#else

#ifdef __BADC_WIN_UCRT__
// The UCRT holds the vectors `__c5_crt_startup` configured.
extern int *__p___argc(void);
extern char ***__p___argv(void);
extern unsigned short ***__p___wargv(void);

void __c5_getmainargs(int *argc, char ***argv) {
    *argc = *__p___argc();
    *argv = *__p___argv();
}

void __c5_wgetmainargs(int *argc, unsigned short ***argv) {
    *argc = *__p___argc();
    *argv = *__p___wargv();
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
#endif

#ifdef __BADC_WIN_WIDE__
extern int __BADC_ENTRY__(int argc, unsigned short **argv);

void __c5_entry(void *sp, long image_off) {
    (void)sp;
    (void)image_off;
    int argc;
    unsigned short **argv;
    __c5_crt_startup();
    __c5_wgetmainargs(&argc, &argv);
    __c5_run_init_array();
    __c5_exit(__BADC_ENTRY__(argc, argv));
}
#else
extern int __BADC_ENTRY__(int argc, char **argv);

void __c5_entry(void *sp, long image_off) {
    (void)sp;
    (void)image_off;
    int argc;
    char **argv;
    __c5_crt_startup();
    __c5_getmainargs(&argc, &argv);
    __c5_run_init_array();
    __c5_exit(__BADC_ENTRY__(argc, argv));
}
#endif

#endif
#endif

#endif
