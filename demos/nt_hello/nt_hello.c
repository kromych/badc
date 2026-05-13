/* Minimal NT-native usermode program.
 *
 * NT-native binaries are EXE-form PEs with Subsystem set to
 * `IMAGE_SUBSYSTEM_NATIVE (1)`. The loader path is
 * `ntdll!LdrpInitializeProcess`, not the kernel32-backed Win32
 * path: no kernel32, no msvcrt, no console attachment, and no
 * access to most of the Win32 API. ntdll's system-call layer is
 * the only thing reliably available before the CRT.
 *
 * The demo declares `NtTerminateProcess` from `ntdll.dll` and
 * exits with status 0. `smss.exe`, `autochk.exe`, and the
 * boot-time `chkdsk.exe` start out in roughly this shape.
 *
 * Build:
 *
 *     badc --target=windows-x64 demos/nt_hello/nt_hello.c -o nt_hello.exe
 *
 * Run (Windows host -- placing a native exe in
 * `\SystemRoot\System32` and adding it to the `BootExecute`
 * registry value is the canonical path; under WINE the loader
 * rejects native-subsystem binaries by design):
 *
 *     reg add "HKLM\System\CurrentControlSet\Control\Session Manager" \
 *         /v BootExecute /t REG_MULTI_SZ /d "autocheck autochk *\0nt_hello"
 *     -- reboot --
 *
 * The process runs before Win32 / csrss are up and has no
 * console to print to. Real native apps reach `NtDisplayString`
 * (visible on the boot console) or build their own console via
 * `NtCreateFile` against `\Device\NamedPipe\...`.
 *
 * The PE writer treats `subsystem(native)` as passthrough: no
 * CRT shim sits in front of `NtProcessStartup`, no
 * `msvcrt!__getmainargs` / `msvcrt!exit` are auto-added. The
 * IAT contains exactly what the source declares -- here, one
 * entry: `ntdll!NtTerminateProcess`. */

#pragma subsystem(native)
#pragma entrypoint(NtProcessStartup)

#pragma dylib(ntdll, "ntdll.dll")
#pragma binding(ntdll::NtTerminateProcess, "NtTerminateProcess")

typedef long NTSTATUS;
typedef void *HANDLE;

/* `(HANDLE)-1` is the calling-process pseudo-handle; the kernel
 * maps it to the real process handle on syscall entry. */
#define NtCurrentProcess ((HANDLE)(long long)-1)

NTSTATUS NtTerminateProcess(HANDLE ProcessHandle, NTSTATUS ExitStatus);

/* NT-native usermode entry: the loader hands `PPEB` in `rcx`
 * (Win64) / `x0` (AAPCS64). Declaring the parameter pins c5's
 * main-prologue spill so the body could read
 * `Peb->ProcessParameters` if the demo grew. */
void NtProcessStartup(void *Peb) {
    (void)Peb;
    /* NtTerminateProcess on the calling process does not return;
     * the kernel tears down the address space before the
     * instruction pointer can advance. The dead end-of-body
     * keeps c5's flow analysis quiet. */
    NtTerminateProcess(NtCurrentProcess, 0);
}
