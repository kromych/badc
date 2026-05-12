/* Minimal NT-native usermode program.
 *
 * NT-native binaries are EXE-form PEs with the Subsystem byte
 * set to `IMAGE_SUBSYSTEM_NATIVE (1)` -- the loader path is
 * `ntdll!LdrpInitializeProcess` rather than the kernel32-backed
 * Win32 path, so there's no `kernel32!ExitProcess`, no
 * `msvcrt!exit`, no console attachment, and no access to most
 * of the Win32 API. The only thing reliably available before
 * the CRT is `ntdll`'s system-call layer; everything else has
 * to be reached through `NtCreateFile` / `NtQuerySystemInformation`
 * / etc.
 *
 * The demo shows the minimum: declare `NtTerminateProcess` from
 * `ntdll.dll`, exit with status 0. `smss.exe`, `autochk.exe`,
 * and the boot-time `chkdsk.exe` all start out roughly this
 * shape before grown into something bigger.
 *
 * Build:
 *
 *     badc --target=windows-x64 demos/nt_hello/nt_hello.c -o nt_hello.exe
 *
 * Run (Windows host -- placing a native exe in the
 * `\SystemRoot\System32` directory and adding it to the
 * `BootExecute` registry value is the canonical way; under WINE
 * the loader rejects native-subsystem binaries by design):
 *
 *     reg add "HKLM\System\CurrentControlSet\Control\Session Manager" \
 *         /v BootExecute /t REG_MULTI_SZ /d "autocheck autochk *\0nt_hello"
 *     -- reboot --
 *
 * The process runs before WIN32 / csrss are up, so it has no
 * console to print to. Real native apps reach `NtDisplayString`
 * (visible on the boot console) or build their own console via
 * `NtCreateFile` against `\Device\NamedPipe\...`.
 *
 * Why so few imports -- The PE writer treats `subsystem(native)`
 * as a passthrough: no CRT shim sits in front of
 * `NtProcessStartup`, no `msvcrt!__getmainargs` /
 * `msvcrt!exit` get auto-added to the import table. The image's
 * IAT contains exactly what the source `#pragma binding(...)`s --
 * one entry here, `ntdll!NtTerminateProcess`. */

#pragma subsystem(native)
#pragma entrypoint(NtProcessStartup)

#pragma dylib(ntdll, "ntdll.dll")
#pragma binding(ntdll::NtTerminateProcess, "NtTerminateProcess")

typedef long NTSTATUS;
typedef void *HANDLE;

/* `NtCurrentProcess()` is `(HANDLE)-1` -- the kernel maps this
 * pseudo-handle to the calling process's real handle when the
 * system call traps in. Cheaper than calling
 * `NtOpenProcess(... , SELF)` just to terminate ourselves. */
#define NtCurrentProcess ((HANDLE)(long long)-1)

NTSTATUS NtTerminateProcess(HANDLE ProcessHandle, NTSTATUS ExitStatus);

/* The NT-native usermode entry signature -- the loader hands us
 * a `PPEB` in `rcx` (Win64) / `x0` (AAPCS64). We don't read it
 * in this minimal demo, but typing it as a parameter
 * pins the c5 main-prologue's spill so we could read
 * `Peb->ProcessParameters` if the demo grew. */
void NtProcessStartup(void *Peb) {
    (void)Peb;
    /* `NtTerminateProcess` doesn't return when the handle is
     * the calling process -- once the kernel cleans up our
     * address space the instruction pointer never moves
     * forward. The dead `return` keeps c5's flow analysis
     * happy (functions returning `void` still need an
     * explicit end-of-body); the bytes never execute. */
    NtTerminateProcess(NtCurrentProcess, 0);
}
