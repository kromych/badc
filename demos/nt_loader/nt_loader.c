// nt_loader -- launches a NATIVE-subsystem NT program end-to-end.
//
// Resolves `ntdll!NtCreateUserProcess` and uses it to spawn
// `nt_hello.exe`. The kernel does the full setup the child needs
// (open the image, create an SEC_IMAGE section, build a process,
// initialize the PEB, create the initial thread, and dispatch
// through `LdrInitializeThunk` so `ntdll`'s loader sets up its
// own internal state before the PE's entry runs). The loader
// holds a named event in `\BaseNamedObjects`; `nt_hello` opens
// that NT path, signals it, and self-terminates. The loader's
// wait observes the signal.
//
// `#define USE_UNICODE` selects the wide-char (`wmain`) build;
// commenting it out selects the narrow-char (`main`) build.
//
// `NtCreateUserProcess` is the same syscall `kernel32!CreateProcessW`
// uses internally. The educational gain over `CreateProcessW` is
// that it accepts NATIVE-subsystem images (which `CreateProcessW`
// refuses with ERROR_INVALID_IMAGE_FORMAT) and that the
// PS_ATTRIBUTE_LIST + PS_CREATE_INFO calling convention is laid
// out in the open. An earlier draft tried `NtCreateProcessEx` +
// manual import patching + `NtCreateThreadEx`; that approach
// crashed in `ntdll!LdrInitializeThunk` on `PEB.Ldr == NULL`.
// Modern Windows only sets `PEB.Ldr` along the
// `NtCreateUserProcess` path.
//
// Privilege requirement: launching IMAGE_SUBSYSTEM_NATIVE images
// via `NtCreateUserProcess` requires `SeTcbPrivilege` (act as
// part of OS). The loader calls `RtlAdjustPrivilege` to enable
// it, but admin tokens normally don't carry TCB -- only services
// running as LocalSystem (SMSS, LSASS, ...) do -- so on a
// regular desktop or a hosted CI runner the enable returns
// `STATUS_PRIVILEGE_NOT_HELD` and the subsequent
// `NtCreateUserProcess` fails with `STATUS_OBJECT_PATH_SYNTAX_BAD`
// or `STATUS_INVALID_PARAMETER` (the kernel reports back at
// different validation stages, all stemming from the same gate).
// To exercise the demo end-to-end, run it from a context that
// has TCB enabled.

#define USE_UNICODE

#include <windows.h>
#include <winternl.h>
#include <stdio.h>
#include <wchar.h>
#include <string.h>

// TCHAR macros.
#ifdef USE_UNICODE
typedef WCHAR   TCHAR;
#  define _T(x)      L##x
#  define _tprintf   wprintf
#  define _tmain     wmain
#else
typedef CHAR    TCHAR;
#  define _T(x)      x
#  define _tprintf   printf
#  define _tmain     main
#endif

// ntdll function-pointer typedefs (resolved at run time).
typedef NTSTATUS (*fpNtCreateUserProcess)(
    PHANDLE ProcessHandle, PHANDLE ThreadHandle,
    ACCESS_MASK ProcessDesiredAccess, ACCESS_MASK ThreadDesiredAccess,
    POBJECT_ATTRIBUTES ProcessObjectAttributes,
    POBJECT_ATTRIBUTES ThreadObjectAttributes,
    ULONG ProcessFlags, ULONG ThreadFlags,
    PVOID ProcessParameters, PVOID CreateInfo, PVOID AttributeList);

typedef NTSTATUS (*fpNtCreateEvent)(
    PHANDLE EventHandle, ACCESS_MASK DesiredAccess,
    POBJECT_ATTRIBUTES ObjectAttributes, ULONG EventType,
    int InitialState);

typedef NTSTATUS (*fpNtWaitForSingleObject)(
    HANDLE Handle, int Alertable, PLARGE_INTEGER Timeout);

typedef NTSTATUS (*fpNtClose)(HANDLE Handle);

typedef void (*fpRtlInitUnicodeString)(
    PUNICODE_STRING DestinationString, PWSTR SourceString);

typedef NTSTATUS (*fpRtlCreateProcessParametersEx)(
    PVOID *pProcessParameters, PUNICODE_STRING ImagePathName,
    PUNICODE_STRING DllPath, PUNICODE_STRING CurrentDirectory,
    PUNICODE_STRING CommandLine, PVOID Environment,
    PUNICODE_STRING WindowTitle, PUNICODE_STRING DesktopInfo,
    PUNICODE_STRING ShellInfo, PUNICODE_STRING RuntimeData,
    ULONG Flags);

typedef NTSTATUS (*fpRtlDestroyProcessParameters)(PVOID ProcessParameters);

typedef NTSTATUS (*fpRtlAdjustPrivilege)(
    ULONG Privilege, int Enable, int CurrentThread, int *PreviousValue);

typedef int (*fpRtlDosPathNameToNtPathName_U)(
    PWSTR DosFileName, PUNICODE_STRING NtFileName,
    PWSTR *FilePart, PVOID Reserved);

typedef void (*fpRtlFreeUnicodeString)(PUNICODE_STRING UnicodeString);

#define SE_TCB_PRIVILEGE 7

// `nt_hello` opens this NT path via `NtOpenEvent`. The loader
// creates it via `NtCreateEvent`; both endpoints route through
// the same `\BaseNamedObjects` namespace.
static WCHAR *g_event_name = L"\\BaseNamedObjects\\BadcLoaderSync";

// `NtWaitForSingleObject` timeout, in 100-ns ticks. Negative
// values are relative; -2*10^7 = 2 s.
#define EVENT_WAIT_TIMEOUT_TICKS  ((long long)-20000000)

// PS_ATTRIBUTE encoding: bits 0..15 = number, 0x10000 = thread-
// flagged, 0x20000 = input, 0x40000 = additive.
// ImageName    (5, input)             = 0x00020005
// ClientId     (3, thread, output)    = 0x00010003
// TebAddress   (4, thread, output)    = 0x00010004
#define PS_ATTRIBUTE_IMAGE_NAME 0x00020005
#define PS_ATTRIBUTE_CLIENT_ID  0x00010003
#define PS_ATTRIBUTE_TEB_ADDRESS 0x00010004

typedef struct {
    HANDLE UniqueProcess;
    HANDLE UniqueThread;
} CLIENT_ID;

// PS_CREATE_INFO is a versioned, partially-tagged-union struct
// the kernel uses to report which phase of process creation
// succeeded or failed. We only fill in the input fields (Size +
// State); the kernel populates the rest as it progresses. The
// `Size` byte count is fixed at 88 in the Windows 10 / 11 ABI
// (the union's largest variant is `SuccessState`, which the
// kernel writes on a clean run).
#define PS_CREATE_INFO_SIZE 88

// Logging helpers.
#define LOG(fmt, ...)     _tprintf(_T("[*] ") fmt _T("\n"), ##__VA_ARGS__)
#define LOG_OK(fmt, ...)  _tprintf(_T("[+] ") fmt _T("\n"), ##__VA_ARGS__)
#define LOG_ERR(fmt, ...) _tprintf(_T("[-] ") fmt _T("\n"), ##__VA_ARGS__)

// Entry point.
int _tmain(int argc, TCHAR **argv)
{
    // CI smoke pipes stdout, which trips msvcrt's full-buffering for
    // wprintf. Without this, a SIGKILL from the smoke harness drops
    // every diagnostic line on the floor and the log shows nothing.
    setvbuf(stdout, NULL, _IONBF, 0);

    if (argc != 2)
    {
        LOG_ERR(_T("Usage: %s <image path>"), argv[0]);
        return 1;
    }

    NTSTATUS         status;
    HANDLE           hProcess = NULL;
    HANDLE           hThread = NULL;
    HANDLE           hEvent = NULL;
    PVOID            proc_params = NULL;
    UNICODE_STRING   image_path_us;
    int              exitCode = 1;

    image_path_us.Length = 0;
    image_path_us.MaximumLength = 0;
    image_path_us.Buffer = NULL;

    // Resolve ntdll exports.
    LOG(_T("Resolving ntdll exports"));
    HANDLE hNtdll = GetModuleHandleW(L"ntdll.dll");
    if (!hNtdll)
    {
        LOG_ERR(_T("GetModuleHandle(ntdll) failed: 0x%08lX"), GetLastError());
        return 1;
    }

    fpNtCreateUserProcess           _NtCreateUserProcess           = (fpNtCreateUserProcess)           GetProcAddress(hNtdll, "NtCreateUserProcess");
    fpNtCreateEvent                 _NtCreateEvent                 = (fpNtCreateEvent)                 GetProcAddress(hNtdll, "NtCreateEvent");
    fpNtWaitForSingleObject         _NtWaitForSingleObject         = (fpNtWaitForSingleObject)         GetProcAddress(hNtdll, "NtWaitForSingleObject");
    fpNtClose                       _NtClose                       = (fpNtClose)                       GetProcAddress(hNtdll, "NtClose");
    fpRtlInitUnicodeString          _RtlInitUnicodeString          = (fpRtlInitUnicodeString)          GetProcAddress(hNtdll, "RtlInitUnicodeString");
    fpRtlCreateProcessParametersEx  _RtlCreateProcessParametersEx  = (fpRtlCreateProcessParametersEx)  GetProcAddress(hNtdll, "RtlCreateProcessParametersEx");
    fpRtlDestroyProcessParameters   _RtlDestroyProcessParameters   = (fpRtlDestroyProcessParameters)   GetProcAddress(hNtdll, "RtlDestroyProcessParameters");
    fpRtlAdjustPrivilege            _RtlAdjustPrivilege            = (fpRtlAdjustPrivilege)            GetProcAddress(hNtdll, "RtlAdjustPrivilege");
    fpRtlDosPathNameToNtPathName_U  _RtlDosPathNameToNtPathName_U  = (fpRtlDosPathNameToNtPathName_U)  GetProcAddress(hNtdll, "RtlDosPathNameToNtPathName_U");
    fpRtlFreeUnicodeString          _RtlFreeUnicodeString          = (fpRtlFreeUnicodeString)          GetProcAddress(hNtdll, "RtlFreeUnicodeString");

    if (!_NtCreateUserProcess || !_NtCreateEvent || !_NtWaitForSingleObject
        || !_NtClose || !_RtlInitUnicodeString
        || !_RtlCreateProcessParametersEx || !_RtlDestroyProcessParameters
        || !_RtlAdjustPrivilege || !_RtlDosPathNameToNtPathName_U
        || !_RtlFreeUnicodeString)
    {
        LOG_ERR(_T("Failed to resolve one or more ntdll exports"));
        return 1;
    }
    LOG_OK(_T("ntdll exports resolved"));

    // Try to enable SeTcbPrivilege. Modern Windows requires this
    // ("act as part of OS") to launch IMAGE_SUBSYSTEM_NATIVE
    // images via NtCreateUserProcess. Admin tokens usually don't
    // carry this privilege, so the enable call typically fails
    // with STATUS_PRIVILEGE_NOT_HELD; we log and continue so
    // NtCreateUserProcess can fail loudly with a useful error
    // rather than silently.
    {
        int prev = 0;
        NTSTATUS tcb = _RtlAdjustPrivilege(SE_TCB_PRIVILEGE, TRUE, FALSE, &prev);
        if (NT_SUCCESS(tcb))
        {
            LOG_OK(_T("SeTcbPrivilege enabled (was %s)"),
                   prev ? _T("on") : _T("off"));
        }
        else
        {
            LOG_ERR(_T("RtlAdjustPrivilege(SeTcbPrivilege) failed: 0x%08lX"),
                    (ULONG)tcb);
        }
    }

    // Create the sync event under `\BaseNamedObjects`.
    UNICODE_STRING event_name_us;
    _RtlInitUnicodeString(&event_name_us, g_event_name);
    OBJECT_ATTRIBUTES event_oa;
    event_oa.Length = sizeof(OBJECT_ATTRIBUTES);
    event_oa.Attributes = OBJ_CASE_INSENSITIVE;
    event_oa.ObjectName = &event_name_us;
    event_oa.RootDirectory = NULL;
    event_oa.SecurityDescriptor = NULL;
    event_oa.SecurityQualityOfService = NULL;
    status = _NtCreateEvent(
        &hEvent, EVENT_ALL_ACCESS, &event_oa,
        NOTIFICATION_EVENT, FALSE);
    if (!NT_SUCCESS(status))
    {
        LOG_ERR(_T("NtCreateEvent failed: 0x%08lX"), (ULONG)status);
        return 1;
    }
    LOG_OK(_T("Sync event created"));

    // Build the child's image path in NT form. Use the official
    // `RtlDosPathNameToNtPathName_U` translator -- it produces
    // either `\??\<dos-form>` or `\Device\<volume>\<rest>`
    // depending on environment, handles normalization (collapses
    // `\.`, resolves `..`, etc.), and respects DOS-device
    // remapping. Hand-rolling `\\??\\` + raw concatenation tends
    // to trip `STATUS_OBJECT_PATH_SYNTAX_BAD`.
    WCHAR dos_path[600];
#ifdef USE_UNICODE
    if (wcslen(argv[1]) >= 599)
    {
        LOG_ERR(_T("Path too long"));
        goto cleanup;
    }
    wcscpy(dos_path, (unsigned short *)argv[1]);
#else
    int wlen = MultiByteToWideChar(CP_ACP, 0, argv[1], -1, dos_path, 600);
    if (wlen == 0)
    {
        LOG_ERR(_T("MultiByteToWideChar failed: 0x%08lX"), GetLastError());
        goto cleanup;
    }
#endif

    if (!_RtlDosPathNameToNtPathName_U(dos_path, &image_path_us, NULL, NULL))
    {
        LOG_ERR(_T("RtlDosPathNameToNtPathName_U failed for %s"), dos_path);
        goto cleanup;
    }
    LOG(_T("Spawning child: %s"), image_path_us.Buffer);

    // Build RTL_USER_PROCESS_PARAMETERS via the Rtl helper.
    // NtCreateUserProcess rejects NULL ProcessParameters on
    // modern Windows -- ntdll's LdrpInitializeProcess reads
    // PEB.ProcessParameters for the command line / current
    // directory / environment, and those fields need to be
    // properly populated.
    status = _RtlCreateProcessParametersEx(
        &proc_params, &image_path_us,
        NULL,            // DllPath (inherits parent's)
        NULL,            // CurrentDirectory (inherits)
        &image_path_us,  // CommandLine = image path
        NULL,            // Environment (inherits)
        NULL, NULL, NULL, NULL,
        0);              // Flags
    if (!NT_SUCCESS(status))
    {
        LOG_ERR(_T("RtlCreateProcessParametersEx failed: 0x%08lX"), (ULONG)status);
        goto cleanup;
    }

    // PS_CREATE_INFO -- input fields only. The buffer is fixed at
    // 88 bytes; the kernel rejects sizes it doesn't recognize.
    // Declared as a long-long array so c5 picks 8-byte alignment
    // -- the kernel's ProbeForRead expects 8-aligned fields and
    // returns STATUS_ACCESS_VIOLATION otherwise.
    //
    // Layout (input): [0..8) Size, [8..12) State.
    // PsCreateInitialState = 0 is the only legal input state.
    long long create_info[11];                  // 88 bytes
    memset(create_info, 0, sizeof(create_info));
    create_info[0] = PS_CREATE_INFO_SIZE;

    // PS_ATTRIBUTE_LIST with a single entry: the image name.
    // 8-byte TotalLength + one 32-byte entry = 40 bytes (5 long
    // longs).
    long long attr_list[1 + 1 * 4];
    memset(attr_list, 0, sizeof(attr_list));
    attr_list[0]  = (long long)sizeof(attr_list);            // TotalLength
    attr_list[1]  = PS_ATTRIBUTE_IMAGE_NAME;                 // Attribute
    // PsAttributeImageName's value is a pointer to a
    // UNICODE_STRING, not to the raw wide-char buffer. Pass
    // &image_path_us; the kernel reads .Length / .Buffer out of
    // it.
    attr_list[2]  = (long long)sizeof(UNICODE_STRING);
    *(void **)&attr_list[3] = &image_path_us;
    // attr_list[4] (ReturnLength) stays 0.

    status = _NtCreateUserProcess(
        &hProcess, &hThread,
        PROCESS_ALL_ACCESS, THREAD_ALL_ACCESS,
        NULL, NULL,                                          // process / thread OAs
        0, 0,                                                // process / thread flags
        proc_params,
        (PVOID)create_info,
        (PVOID)attr_list);
    if (!NT_SUCCESS(status))
    {
        // On failure the State field of create_info indicates
        // which phase the kernel got to before bailing -- useful
        // for diagnosing path / image-format issues.
        ULONG fail_state = *(ULONG *)&create_info[8];
        LOG_ERR(_T("NtCreateUserProcess failed: 0x%08lX (create_info.State = %lu)"),
                (ULONG)status, (ULONG)fail_state);
        goto cleanup;
    }
    LOG_OK(_T("Child process + initial thread created"));

    // Wait for the child to signal the event. A timeout is a hard
    // failure -- the demo's contract is the handshake.
    LOG(_T("Waiting up to 2s for sync event"));
    LARGE_INTEGER timeout;
    timeout.QuadPart = EVENT_WAIT_TIMEOUT_TICKS;
    status = _NtWaitForSingleObject(hEvent, FALSE, &timeout);
    if (status == STATUS_SUCCESS)
    {
        LOG_OK(_T("Sync event received"));
        exitCode = 0;
    }
    else if (status == STATUS_TIMEOUT)
    {
        LOG_ERR(_T("Timed out waiting for sync event"));
    }
    else
    {
        LOG_ERR(_T("NtWaitForSingleObject failed: 0x%08lX"), (ULONG)status);
    }

cleanup:
    LOG(_T("Cleaning up handles"));
    if (hThread)              _NtClose(hThread);
    if (hProcess)             _NtClose(hProcess);
    if (hEvent)               _NtClose(hEvent);
    if (proc_params)          _RtlDestroyProcessParameters(proc_params);
    if (image_path_us.Buffer) _RtlFreeUnicodeString(&image_path_us);

    LOG(_T("Done (exit code: %d)"), exitCode);
    return exitCode;
}
