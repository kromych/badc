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
 * and exits with status 0. Running it stand-alone (with no
 * matching loader) is harmless: `NtOpenEvent` returns
 * `STATUS_OBJECT_NAME_NOT_FOUND` and the process still
 * terminates cleanly.
 *
 * Build:
 *
 *     badc -O demos/nt_hello/nt_hello.c -o nt_hello.exe
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
 * The PE writer treats `subsystem(native)` as passthrough: no
 * CRT shim sits in front of `NtProcessStartup`, no
 * `msvcrt!__getmainargs` / `msvcrt!exit` are auto-added. The
 * IAT contains exactly the ntdll exports the source declares. */

#pragma subsystem(native)
#pragma entrypoint(NtProcessStartup)

#pragma dylib(ntdll, "ntdll.dll")
#pragma binding(ntdll::NtTerminateProcess,  "NtTerminateProcess")
#pragma binding(ntdll::NtOpenEvent,         "NtOpenEvent")
#pragma binding(ntdll::NtSetEvent,          "NtSetEvent")
#pragma binding(ntdll::NtClose,             "NtClose")

typedef long           NTSTATUS;
typedef void          *PVOID;
typedef PVOID          HANDLE;
typedef HANDLE        *PHANDLE;
typedef unsigned long  ULONG;
typedef unsigned short USHORT;
typedef unsigned short WCHAR;
typedef WCHAR         *PWSTR;
typedef ULONG          ACCESS_MASK;

#define NULL                  ((PVOID)0)
#define NtCurrentProcess      ((HANDLE)(long long)-1)
#define OBJ_CASE_INSENSITIVE  0x00000040UL
#define EVENT_MODIFY_STATE    0x00000002UL
#define NT_SUCCESS(s)         ((NTSTATUS)(s) >= 0)

typedef struct _UNICODE_STRING {
    USHORT Length;
    USHORT MaximumLength;
    PWSTR  Buffer;
} UNICODE_STRING, *PUNICODE_STRING;

typedef struct _OBJECT_ATTRIBUTES {
    ULONG           Length;
    HANDLE          RootDirectory;
    PUNICODE_STRING ObjectName;
    ULONG           Attributes;
    PVOID           SecurityDescriptor;
    PVOID           SecurityQualityOfService;
} OBJECT_ATTRIBUTES, *POBJECT_ATTRIBUTES;

NTSTATUS NtTerminateProcess(HANDLE ProcessHandle, NTSTATUS ExitStatus);
NTSTATUS NtOpenEvent(PHANDLE EventHandle, ACCESS_MASK DesiredAccess,
                     POBJECT_ATTRIBUTES ObjectAttributes);
NTSTATUS NtSetEvent(HANDLE EventHandle, ULONG *PreviousState);
NTSTATUS NtClose(HANDLE Handle);

/* `\BaseNamedObjects\BadcLoaderSync` -- the same name the loader
 * uses for the cross-process event. Spelled as a literal CHAR16
 * array so the demo stays free of the `L"..."` wide-string
 * literal surface. */
static WCHAR g_event_name[] = {
    '\\', 'B', 'a', 's', 'e', 'N', 'a', 'm', 'e', 'd', 'O', 'b', 'j',
    'e', 'c', 't', 's', '\\',
    'B', 'a', 'd', 'c', 'L', 'o', 'a', 'd', 'e', 'r', 'S', 'y', 'n', 'c',
    0
};

/* NT-native usermode entry: the loader hands `PPEB` in `rcx`
 * (Win64) / `x0` (AAPCS64). Declaring the parameter pins c5's
 * main-prologue spill so the body could read
 * `Peb->ProcessParameters` if the demo grew. */
void NtProcessStartup(void *Peb) {
    (void)Peb;

    /* Build the OBJECT_ATTRIBUTES + UNICODE_STRING in place; no
     * `RtlInitUnicodeString` import needed. `Length` and
     * `MaximumLength` are in bytes and exclude the trailing nul. */
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
    /* Falling through to NtTerminateProcess covers both the
     * "loader present, event signalled" and "no loader" paths. */
    NtTerminateProcess(NtCurrentProcess, 0);
}
