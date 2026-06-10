// Runtime startup helpers. Linked only into native executables
// whose writer emits a `_start` / entry CRT stub; the stub calls
// these `__c5_*` symbols instead of importing the platform CRT
// entries itself, so the libc / kernel32 dependency lives here in a
// linked translation unit rather than hardcoded in the writer.
//
// Images with no entry stub -- shared libraries and
// passthrough-entry subsystems (native / EFI), where the kernel or
// firmware calls the user entry directly -- do not link this source,
// so they carry no user-mode CRT import. A kernel-mode driver cannot
// resolve `msvcrt!exit`.

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

#ifdef _WIN32
// Windows process startup. The PE entry stub direct-calls the
// helpers below; each owns the CRT-specific call shape so the writer
// only references the `__c5_*` names. `__BADC_WIN_GUI__` is defined
// by the driver when the PE subsystem is GUI, selecting the
// kernel32-based `WinMain` argument helpers; otherwise the
// console helpers synthesize argv via the CRT.
#ifdef __BADC_WIN_GUI__

#pragma dylib(kernel32, "kernel32.dll")
#pragma binding(kernel32::GetModuleHandleA, "GetModuleHandleA")
#pragma binding(kernel32::GetCommandLineA, "GetCommandLineA")

extern void *GetModuleHandleA(void *module_name);
extern char *GetCommandLineA(void);

void *__c5_getmodulehandle(void) {
    return GetModuleHandleA(0);
}

char *__c5_getcommandline(void) {
    return GetCommandLineA();
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
#endif
