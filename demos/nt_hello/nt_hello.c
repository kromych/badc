/* Minimal NT-native usermode program.
 *
 * NT-native binaries are EXE-form PEs with Subsystem set to
 * `IMAGE_SUBSYSTEM_NATIVE (1)`. The loader path is
 * `ntdll!LdrpInitializeProcess`, not the kernel32-backed Win32
 * path: no kernel32, no msvcrt, no console attachment, and no
 * access to most of the Win32 API. ntdll's system-call layer is
 * what's reliably available before the CRT.
 *
 * The demo opens the cross-process event the bundled `nt_loader`
 * demo creates (`\BaseNamedObjects\BadcLoaderSync`), signals it,
 * and exits with status 0. Running stand-alone (no matching
 * loader) is harmless: `NtOpenEvent` returns
 * `STATUS_OBJECT_NAME_NOT_FOUND` and the process terminates
 * cleanly. */

#pragma subsystem(native)
#pragma entrypoint(NtProcessStartup)

#include <winternl.h>

#pragma dylib(ntdll, "ntdll.dll")
#pragma binding(ntdll::NtTerminateProcess,  "NtTerminateProcess")
#pragma binding(ntdll::NtOpenEvent,         "NtOpenEvent")
#pragma binding(ntdll::NtSetEvent,          "NtSetEvent")
#pragma binding(ntdll::NtClose,             "NtClose")

NTSTATUS NtTerminateProcess(HANDLE ProcessHandle, NTSTATUS ExitStatus);
NTSTATUS NtOpenEvent(PHANDLE EventHandle, ACCESS_MASK DesiredAccess,
                     POBJECT_ATTRIBUTES ObjectAttributes);
NTSTATUS NtSetEvent(HANDLE EventHandle, ULONG *PreviousState);
NTSTATUS NtClose(HANDLE Handle);

static WCHAR *g_event_name = L"\\BaseNamedObjects\\BadcLoaderSync";

/* NT-native usermode entry: the loader hands `PPEB` in `rcx`
 * (Win64) / `x0` (AAPCS64). Declaring the parameter pins c5's
 * main-prologue spill so the body could read
 * `Peb->ProcessParameters` if the demo grew. */
void NtProcessStartup(void *Peb) {
    (void)Peb;

    /* Build the OBJECT_ATTRIBUTES + UNICODE_STRING in place. No
     * `RtlInitUnicodeString` dependency: counting the chars
     * inline keeps the import set to four ntdll exports. */
    UNICODE_STRING name;
    int n = 0;
    while (g_event_name[n] != 0) {
        n++;
    }
    name.Length        = (USHORT)(n * 2);
    name.MaximumLength = (USHORT)((n + 1) * 2);
    name.Buffer        = g_event_name;

    OBJECT_ATTRIBUTES oa;
    oa.Length                   = sizeof(OBJECT_ATTRIBUTES);
    oa.RootDirectory            = NULL;
    oa.ObjectName               = &name;
    oa.Attributes               = OBJ_CASE_INSENSITIVE;
    oa.SecurityDescriptor       = NULL;
    oa.SecurityQualityOfService = NULL;

    HANDLE hEvent = NULL;
    if (NT_SUCCESS(NtOpenEvent(&hEvent, EVENT_MODIFY_STATE, &oa))) {
        NtSetEvent(hEvent, NULL);
        NtClose(hEvent);
    }
    NtTerminateProcess(NtCurrentProcess(), 0);
}
