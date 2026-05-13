/* Minimal NT-native usermode program.
 *
 * EXE-form PE with Subsystem = `IMAGE_SUBSYSTEM_NATIVE (1)`;
 * loader path is `ntdll!LdrpInitializeProcess`. No kernel32,
 * no msvcrt, no console.
 *
 * Opens the cross-process event `nt_loader` creates
 * (`\BaseNamedObjects\BadcLoaderSync`), signals it, and exits.
 * Stand-alone: `NtOpenEvent` returns
 * `STATUS_OBJECT_NAME_NOT_FOUND` and the process exits cleanly. */

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

/* The NT loader calls `NtProcessStartup` with `PPEB` in `rcx`
 * (Win64) / `x0` (AAPCS64). */
void NtProcessStartup(void *Peb) {
    (void)Peb;

    /* OBJECT_ATTRIBUTES + UNICODE_STRING are built inline to
     * avoid an `RtlInitUnicodeString` import. */
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
