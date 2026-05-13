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

// `nt_hello` opens this NT path via `NtOpenEvent`. The loader
// creates it via `NtCreateEvent`; both endpoints route through
// the same `\BaseNamedObjects` namespace.
static WCHAR *g_event_name = L"\\BaseNamedObjects\\BadcLoaderSync";

// `NtWaitForSingleObject` timeout, in 100-ns ticks. Negative
// values are relative; -2*10^7 = 2 s.
#define EVENT_WAIT_TIMEOUT_TICKS  ((long long)-20000000)

// PS_ATTRIBUTE_IMAGE_NAME = number 5 | PS_ATTRIBUTE_INPUT (0x20000).
#define PS_ATTRIBUTE_IMAGE_NAME 0x00020005

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

    NTSTATUS  status;
    HANDLE    hProcess = NULL;
    HANDLE    hThread = NULL;
    HANDLE    hEvent = NULL;
    int       exitCode = 1;

    // Resolve ntdll exports.
    LOG(_T("Resolving ntdll exports"));
    HANDLE hNtdll = GetModuleHandleW(L"ntdll.dll");
    if (!hNtdll)
    {
        LOG_ERR(_T("GetModuleHandle(ntdll) failed: 0x%08lX"), GetLastError());
        return 1;
    }

    fpNtCreateUserProcess   _NtCreateUserProcess   = (fpNtCreateUserProcess)   GetProcAddress(hNtdll, "NtCreateUserProcess");
    fpNtCreateEvent         _NtCreateEvent         = (fpNtCreateEvent)         GetProcAddress(hNtdll, "NtCreateEvent");
    fpNtWaitForSingleObject _NtWaitForSingleObject = (fpNtWaitForSingleObject) GetProcAddress(hNtdll, "NtWaitForSingleObject");
    fpNtClose               _NtClose               = (fpNtClose)               GetProcAddress(hNtdll, "NtClose");
    fpRtlInitUnicodeString  _RtlInitUnicodeString  = (fpRtlInitUnicodeString)  GetProcAddress(hNtdll, "RtlInitUnicodeString");

    if (!_NtCreateUserProcess || !_NtCreateEvent || !_NtWaitForSingleObject
        || !_NtClose || !_RtlInitUnicodeString)
    {
        LOG_ERR(_T("Failed to resolve one or more ntdll exports"));
        return 1;
    }
    LOG_OK(_T("ntdll exports resolved"));

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

    // Build the child's image path in NT form. Win32 paths
    // (`D:\foo\bar.exe`) become `\??\D:\foo\bar.exe` when handed
    // to NT syscalls; `\??\` is the per-session Object Manager
    // symbolic-link directory that resolves DOS drive letters.
    WCHAR nt_path[600];
    nt_path[0] = L'\\';
    nt_path[1] = L'?';
    nt_path[2] = L'?';
    nt_path[3] = L'\\';

#ifdef USE_UNICODE
    if (wcslen(argv[1]) >= 590)
    {
        LOG_ERR(_T("Path too long"));
        goto cleanup;
    }
    wcscpy(&nt_path[4], (unsigned short *)argv[1]);
#else
    int wlen = MultiByteToWideChar(CP_ACP, 0, argv[1], -1, &nt_path[4], 596);
    if (wlen == 0)
    {
        LOG_ERR(_T("MultiByteToWideChar failed: 0x%08lX"), GetLastError());
        goto cleanup;
    }
#endif

    int path_chars = (int)wcslen(nt_path);
    LOG(_T("Spawning child: %s"), nt_path);

    // PS_CREATE_INFO -- input fields only. The buffer is fixed at
    // PS_CREATE_INFO_SIZE bytes; the kernel rejects sizes it
    // doesn't recognize. Layout (input): [0..8) Size, [8..12)
    // State. PsCreateInitialState = 0 is the only legal input
    // state; the kernel advances the State as it processes.
    char create_info[PS_CREATE_INFO_SIZE];
    memset(create_info, 0, sizeof(create_info));
    *(long long *)&create_info[0] = PS_CREATE_INFO_SIZE;

    // PS_ATTRIBUTE_LIST with a single PS_ATTRIBUTE entry.
    // Header layout: [0..8) TotalLength; then for each entry:
    // [+0..8) Attribute, [+8..16) Size, [+16..24) ValuePtr,
    // [+24..32) ReturnLength.
    char attr_list[40];
    memset(attr_list, 0, sizeof(attr_list));
    *(long long *)&attr_list[0]  = (long long)sizeof(attr_list);
    *(long long *)&attr_list[8]  = (long long)PS_ATTRIBUTE_IMAGE_NAME;
    *(long long *)&attr_list[16] = (long long)(path_chars * 2);
    *(void   **)&attr_list[24]  = nt_path;
    // attr_list[32..40] (ReturnLength) stays 0.

    status = _NtCreateUserProcess(
        &hProcess, &hThread,
        PROCESS_ALL_ACCESS, THREAD_ALL_ACCESS,
        NULL, NULL,            // process / thread OBJECT_ATTRIBUTES
        0, 0,                  // process / thread flags
        NULL,                  // ProcessParameters (kernel defaults)
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
    if (hThread)  _NtClose(hThread);
    if (hProcess) _NtClose(hProcess);
    if (hEvent)   _NtClose(hEvent);

    LOG(_T("Done (exit code: %d)"), exitCode);
    return exitCode;
}
